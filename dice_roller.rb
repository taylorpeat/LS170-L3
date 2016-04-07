require 'socket'

server = TCPServer.new('localhost', 3003)
loop do
  client = server.accept

  request_line = client.gets
  puts request_line

  http_method, path, params, http = request_line.split(/[\s?]/)
  params = params.split('&').each_with_object({}) do |pair, hash|
    key, value = pair.split('=')
    hash[key] = value
  end

  client.puts request_line
  client.puts http_method
  client.puts path
  client.puts params
  params['rolls'].to_i.times do
    client.puts rand(params['sides'].to_i) + 1
  end
  client.close
end