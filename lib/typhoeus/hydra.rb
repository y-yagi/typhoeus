require 'typhoeus/hydra/block_connection'
require 'typhoeus/hydra/easy_factory'
require 'typhoeus/hydra/easy_pool'
require 'typhoeus/hydra/memoizable'
require 'typhoeus/hydra/queueable'
require 'typhoeus/hydra/runnable'
require 'typhoeus/hydra/stubbable'

module Typhoeus

  # Hydra manages making parallel HTTP requests. This
  # is achieved by using libcurls multi interface:
  # http://curl.haxx.se/libcurl/c/libcurl-multi.html
  # The benefits are that you don't have to worry running
  # the requests by yourself.
  class Hydra
    include Hydra::EasyPool
    include Hydra::Queueable
    include Hydra::Runnable
    include Hydra::Memoizable
    include Hydra::BlockConnection
    include Hydra::Stubbable

    attr_reader :max_concurrency, :multi

    # Create a new hydra.
    #
    # @example Create a hydra.
    #   Typhoeus::Hydra.new
    #
    # @param [ Hash ] options The options hash.
    #
    # @option options :max_concurrency [ Integer ] Number
    #  of max concurrent connections to create. Default is
    #  200.
    def initialize(options = {})
      @options = options
      @max_concurrency = @options.fetch(:max_concurrency, 200)
      @multi = Ethon::Multi.new
    end
  end
end
