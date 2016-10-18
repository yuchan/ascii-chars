# coding: utf-8
require 'mechanize'
require 'cgi'
require 'pp'

agent = Mechanize.new

agent.user_agent_alias = 'Mac Safari'
page = agent.get "http://www.w3schools.com/tags/ref_urlencode.asp"

table = page.css('.w3-table-all').first
trs = table.search('tr')

chars = []
deadchars = []

trs.each do |tr|
  tds = tr.search('td')
  tds.each do |td|
    chars.push td.text
    encoded = CGI.escape(td.text)
    doubleDecoded = CGI::unescape(CGI::unescape(encoded))
    if td.text != doubleDecoded
      deadchars.push td.text
    end
    break
  end
end

pp "all chars: " + chars.to_s
pp "broken chars: " + deadchars.to_s
