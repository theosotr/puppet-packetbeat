class packetbeat::params {
  $ensure              = present
  $beat_name           = $::fqdn
  $bpf_filter          = undef
  $buffer_size_mb      = undef
  $config_file_mode    = "0644"
  $fields              = undef
  $fields_under_root   = false
  $flow_enable         = true
  $flow_period         = "10s"
  $flow_timeout        = "30s"
  $manage_repo         = true
  $package_ensure      = $ensure
  $queue_size          = 1000
  $tags                = []
  $service_ensure      = "enabled"
  $service_has_restart = true
  $snaplen             = 65535
  $sniff_type          = "pcap"
  $with_vlans          = undef

  case $::kernel {
    'Linux': {
      $device       = "any"
      $path_conf    = "/etc/packetbeat"
      $path_data    = "/var/lib/packetbeat"
      $path_home    = "/usr/share/packetbeat"
      $path_logs    = "/var/log/packetbeat"
    }
    default: {
      fail("$::kernel is not supported by packetbeat")
    }
  }

  $logging             = {
    "to_files" => true,
    "level"    => "info",
    "metrics"  => {
      "enabled" => true,
      "period"  => "30s",
    },
    "files"    => {
      "path"             => $path_logs,
      "name"             => "packetbeat",
      "keepfiles"        => 7,
      "rotateeverybytes" => 10485760,
    },
  }
}
