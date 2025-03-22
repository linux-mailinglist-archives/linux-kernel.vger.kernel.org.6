Return-Path: <linux-kernel+bounces-572248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96069A6C835
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 09:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1DC463007
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 08:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387FC1372;
	Sat, 22 Mar 2025 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="rizr4HEi"
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C7B190052;
	Sat, 22 Mar 2025 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742630860; cv=none; b=Qq2BjBB6CCuiK9KTHo+bfxkMTWCXdniuDf3n8N8Vo+LyB6X3tnSRe31R2oCGLLsOi/XXcseTJcI5Iups5mZL+M8T3iBvyEVIvFHcnN9u2M7TQvZLJw+mdMlmCqaBqM1ouuOJNnxb7zOXZDnzt+m8DvYXmQBd97ThgLMO0T3EOgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742630860; c=relaxed/simple;
	bh=Au51vRyAT5LMw06ppkt/565mE0zxAopWlU6Sr0SecHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRibWRbulbG0mySw+iNUVdy3vlYyDEVmQiNGx4a6zghHoD+Y3ET7Yj8xuGxzafT0w/KXZSwU5HmqV0NL3Tuu304wBPSYoioJxgZRiYUq+91RVQ5gpd/3g4wMz2Atd/xYYOlwmxqxEgg2CQvqR7HhQLL7fn8AiFsctLkj2mLyLBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=rizr4HEi; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hshwU7aRjBaHNny9OPz1ETAzZnveCEQiyrumw9JRSFk=; b=rizr4HEi6P/fYzSFkAB+oJIgd8
	eUOpu+wEzW4D/xSFivPbFryn8H8xjqnFoi9LxLbyx2F3kmh0ZNYUwpITMBMtFFej6cMOR4GK1pVCR
	lEWSXVM063r8nkXZJWZtmTMYizWsOfthhXn1j7Be+5jnf4LxIULoXS/gYUZHNMEDvgRA1U0cy3WWU
	hSYhvRFHyL/gY3y4SWrVU7SCDbA0pzwI1n44hyCTZcGZDTZF8qGulqsaGysdcKpZBFNOqJEbsviTz
	zEnMPRTPlQbSrRp0O2b72dbiZ0K+cX3nptPe1auU0WOD7aJyvt8Ureu5S+aykA3Jr5fEODCQF00hj
	4kX6Kcng==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1tvthO-00151i-LD; Sat, 22 Mar 2025 07:55:18 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id ECD6CBE2DE0; Sat, 22 Mar 2025 08:55:17 +0100 (CET)
Date: Sat, 22 Mar 2025 08:55:17 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: "C.D. MacEachern" <craig.daniel.maceachern@gmail.com>,
	1100928@bugs.debian.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: [regression 6.1.y] microphone no longer records (on
 VivoBook_ASUSLaptop TP401MARB_J401MA)
Message-ID: <Z95s5T6OXFPjRnKf@eldamar.lan>
References: <174248253267.1718.4037292692790831697.reportbug@x>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174248253267.1718.4037292692790831697.reportbug@x>
X-Debian-User: carnil

Control: tags -1 + moreinfo upstream

Hi

On Thu, Mar 20, 2025 at 10:55:32AM -0400, C.D. MacEachern wrote:
> Package: src:linux
> Version: 6.1.129-1
> Severity: important
> X-Debbugs-Cc: craig.daniel.maceachern@gmail.com
> 
> Dear Maintainer,
> 
> After update to kernel image 6.1.0-32 on Debian bookworm my builtin microphone
> would no longer record
> anything - no levels detected and I checked for muted channels with tools like
> pavucontrol and alsamixer.
> 
> I found that my microphone was using the `snd_hda_intel` driver in the kernel,
> so tried rebooting and choosing
> the 6.1.0-31 kernel instead to rule out hardware issue. Previous kernel works
> as expected, mic records and playback
> is fine, so some update related to this driver, or the driver itself was
> updated and no longer works correctly with
> the builtin microphone.

Thanks for reproting the issue (leaving boot log context, hw used,
below for context).

I think this might be introduced with 3b4309546b48 ("ALSA: hda: Fix
headset detection failure due to unstable sort") wich landed as well
in 6.1.129.

If you revert that commit on top of 6.1.129, does that fixes your
issue? Would you be able to test this?

#regzbot introduced: v6.1.128..v6.1.129
#regzbot link: https://bugs.debian.org/1100928

The solution might be similar to c6557ccf8094 ("ALSA: hda/realtek: Fix
microphone regression on ASUS N705UD") from 6.14-rc5 (which got
backported to 6.13.6, 6.12.18, 6.6.81 but not yet 6.1.y).

Regards,
Salvatore
 
> Craig
> 
> 
> -- Package-specific info:
> ** Version:
> Linux version 6.1.0-32-amd64 (debian-kernel@lists.debian.org) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Debian 6.1.129-1 (2025-03-06)
> 
> ** Command line:
> BOOT_IMAGE=/boot/vmlinuz-6.1.0-32-amd64 root=UUID=ee07976a-5aea-4f61-bdcd-7017e539871d ro quiet splash
> 
> ** Not tainted
> 
> ** Kernel log:
> [    4.325950] systemd[1]: Finished systemd-sysctl.service - Apply Kernel Variables.
> [    4.348058] systemd[1]: Started systemd-journald.service - Journal Service.
> [    4.367791] systemd-journald[330]: Received client request to flush runtime journal.
> [    4.774432] input: Asus Wireless Radio Control as /devices/LNXSYSTM:00/LNXSYBUS:00/ATK4002:00/input/input20
> [    4.778434] Consider using thermal netlink events interface
> [    4.783915] input: Intel HID events as /devices/platform/INT33D5:00/input/input21
> [    4.840187] Adding 4003836k swap on /dev/mmcblk0p2.  Priority:-2 extents:1 across:4003836k SSFS
> [    4.854270] ACPI: AC: AC Adapter [AC0] (off-line)
> [    5.035666] input: PC Speaker as /devices/platform/pcspkr/input/input22
> [    5.051371] asus_wmi: ASUS WMI generic driver loaded
> [    5.058474] mc: Linux media interface: v0.10
> [    5.058737] snd_hda_intel 0000:00:0e.0: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
> [    5.059006] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> [    5.059009] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> [    5.059011] RAPL PMU: hw unit of domain package 2^-14 Joules
> [    5.059012] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [    5.059013] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> [    5.075471] asus_wmi: Initialization: 0x1
> [    5.075517] asus_wmi: BIOS WMI version: 9.0
> [    5.075547] asus_wmi: SFUN value: 0x21
> [    5.075551] asus-nb-wmi asus-nb-wmi: Detected ATK, not ASUSWMI, use DSTS
> [    5.075553] asus-nb-wmi asus-nb-wmi: Detected ATK, enable event queue
> [    5.077320] input: Asus WMI hotkeys as /devices/platform/asus-nb-wmi/input/input23
> [    5.115208] videodev: Linux video capture interface: v2.00
> [    5.189177] alg: No test for fips(ansi_cprng) (fips_ansi_cprng)
> [    5.238412] asus_wmi: fan_curve_get_factory_default (0x00110024) failed: -19
> [    5.238541] asus_wmi: fan_curve_get_factory_default (0x00110025) failed: -19
> [    5.245933] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [    5.246231] cfg80211: Loaded X.509 cert 'benh@debian.org: 577e021cb980e0e820821ba7b54b4961b8b4fadf'
> [    5.246492] cfg80211: Loaded X.509 cert 'romain.perier@gmail.com: 3abbc6ec146e09d1b6016ab9d6cf71dd233f0328'
> [    5.246752] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [    5.247013] cfg80211: Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
> [    5.267592] platform regulatory.0: firmware: direct-loading firmware regulatory.db
> [    5.268769] platform regulatory.0: firmware: direct-loading firmware regulatory.db.p7s
> [    5.279772] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC256: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
> [    5.279782] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [    5.279785] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
> [    5.279788] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
> [    5.279790] snd_hda_codec_realtek hdaudioC0D0:    inputs:
> [    5.279792] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x13
> [    5.279794] snd_hda_codec_realtek hdaudioC0D0:      Headset Mic=0x19
> [    5.279795] snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x1b
> [    5.284828] usb 1-5: Found UVC 1.00 device USB2.0 VGA UVC WebCam (13d3:5a03)
> [    5.287260] input: gpio-keys as /devices/platform/ACPI0011:00/gpio-keys.11.auto/input/input24
> [    5.300228] ACPI: battery: new extension: ASUS Battery Extension
> [    5.330959] input: USB2.0 VGA UVC WebCam: USB2.0 V as /devices/pci0000:00/0000:00:15.0/usb1/1-5/1-5:1.0/input/input25
> [    5.331254] usbcore: registered new interface driver uvcvideo
> [    5.424183] intel_rapl_common: Found RAPL domain package
> [    5.424191] intel_rapl_common: Found RAPL domain core
> [    5.424193] intel_rapl_common: Found RAPL domain uncore
> [    5.424196] intel_rapl_common: Found RAPL domain dram
> [    5.439136] mei_hdcp 0000:00:0f.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_component_ops [i915])
> [    5.535626] rtw_8821ce 0000:02:00.0: enabling device (0000 -> 0003)
> [    5.544920] Bluetooth: Core ver 2.22
> [    5.544972] NET: Registered PF_BLUETOOTH protocol family
> [    5.544974] Bluetooth: HCI device and connection manager initialized
> [    5.544980] Bluetooth: HCI socket layer initialized
> [    5.544983] Bluetooth: L2CAP socket layer initialized
> [    5.544990] Bluetooth: SCO socket layer initialized
> [    5.553534] rtw_8821ce 0000:02:00.0: firmware: direct-loading firmware rtw88/rtw8821c_fw.bin
> [    5.553550] rtw_8821ce 0000:02:00.0: Firmware version 24.11.0, H2C version 12
> [    5.628585] usbcore: registered new interface driver btusb
> [    5.676216] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:0e.0/sound/card0/input26
> [    5.676431] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:0e.0/sound/card0/input27
> [    5.676487] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:0e.0/sound/card0/input28
> [    5.696316] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:0e.0/sound/card0/input29
> [    5.757071] rtw_8821ce 0000:02:00.0 wlo1: renamed from wlan0
> [    5.771105] audit: type=1400 audit(1742481952.167:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=527 comm="apparmor_parser"
> [    5.782345] audit: type=1400 audit(1742481952.183:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/x86_64-linux-gnu/lightdm/lightdm-guest-session" pid=526 comm="apparmor_parser"
> [    5.782355] audit: type=1400 audit(1742481952.183:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/x86_64-linux-gnu/lightdm/lightdm-guest-session//chromium" pid=526 comm="apparmor_parser"
> [    5.787439] audit: type=1400 audit(1742481952.187:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=529 comm="apparmor_parser"
> [    5.787448] audit: type=1400 audit(1742481952.187:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=529 comm="apparmor_parser"
> [    5.796020] audit: type=1400 audit(1742481952.195:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=542 comm="apparmor_parser"
> [    5.796029] audit: type=1400 audit(1742481952.195:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=542 comm="apparmor_parser"
> [    5.796033] audit: type=1400 audit(1742481952.195:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=542 comm="apparmor_parser"
> [    5.814138] audit: type=1400 audit(1742481952.215:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/redshift" pid=544 comm="apparmor_parser"
> [    5.817410] audit: type=1400 audit(1742481952.219:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=538 comm="apparmor_parser"
> [    6.265695] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    6.265703] Bluetooth: BNEP filters: protocol multicast
> [    6.265713] Bluetooth: BNEP socket layer initialized
> [    6.268576] Bluetooth: MGMT ver 1.22
> [    6.280933] NET: Registered PF_ALG protocol family
> [    6.854404] NET: Registered PF_QIPCRTR protocol family
> [    9.815618] Bluetooth: RFCOMM TTY layer initialized
> [    9.815630] Bluetooth: RFCOMM socket layer initialized
> [    9.815639] Bluetooth: RFCOMM ver 1.11
> [   12.145509] wlo1: authenticate with 04:bc:9f:7d:66:73
> [   12.676740] wlo1: send auth to 04:bc:9f:7d:66:73 (try 1/3)
> [   12.708770] wlo1: authenticate with 04:bc:9f:7d:66:73
> [   12.708863] wlo1: send auth to 04:bc:9f:7d:66:73 (try 1/3)
> [   12.734459] wlo1: authenticated
> [   12.736562] wlo1: associate with 04:bc:9f:7d:66:73 (try 1/3)
> [   12.747219] wlo1: RX AssocResp from 04:bc:9f:7d:66:73 (capab=0x1511 status=0 aid=6)
> [   12.747941] wlo1: associated
> [   12.840944] wlo1: Limiting TX power to 24 (24 - 0) dBm as advertised by 04:bc:9f:7d:66:73
> [   12.840953] IPv6: ADDRCONF(NETDEV_CHANGE): wlo1: link becomes ready
> [   22.468420] [UFW BLOCK] IN=wlo1 OUT= MAC=34:6f:24:1e:d3:
> 1f:b8:9a:2a:e4:50:5c:08:00 SRC=192.168.1.176 DST=192.168.1.138 LEN=1255 TOS=0x00 PREC=0x00 TTL=128 ID=47829 PROTO=UDP SPT=3702 DPT=49923 LEN=1235 
> [   22.541642] [UFW BLOCK] IN=wlo1 OUT= MAC=34:6f:24:1e:d3:1f:b8:9a:2a:e4:50:5c:08:00 SRC=192.168.1.176 DST=192.168.1.138 LEN=1255 TOS=0x00 PREC=0x00 TTL=128 ID=47830 PROTO=UDP SPT=3702 DPT=49923 LEN=1235 
> [   22.876185] [UFW BLOCK] IN=wlo1 OUT= MAC=34:6f:24:1e:d3:1f:b8:9a:2a:e4:50:5c:08:00 SRC=192.168.1.176 DST=192.168.1.138 LEN=1255 TOS=0x00 PREC=0x00 TTL=128 ID=47831 PROTO=UDP SPT=3702 DPT=49923 LEN=1235 
> [   23.388093] [UFW BLOCK] IN=wlo1 OUT= MAC=34:6f:24:1e:d3:1f:b8:9a:2a:e4:50:5c:08:00 SRC=192.168.1.176 DST=192.168.1.138 LEN=1255 TOS=0x00 PREC=0x00 TTL=128 ID=47832 PROTO=UDP SPT=3702 DPT=49923 LEN=1235 
> ** Model information
> sys_vendor: ASUSTeK COMPUTER INC.
> product_name: VivoBook_ASUSLaptop TP401MARB_J401MA
> product_version: 1.0       
> chassis_vendor: ASUSTeK COMPUTER INC.
> chassis_version: 1.0       
> bios_vendor: American Megatrends Inc.
> bios_version: TP401MARB.305
> board_vendor: ASUSTeK COMPUTER INC.
> board_name: TP401MARB
> board_version: 1.0       
> 
> ** Loaded modules:
> ecb
> ctr
> ccm
> rfcomm
> snd_seq_dummy
> snd_hrtimer
> snd_seq
> snd_seq_device
> qrtr
> ip6t_REJECT
> nf_reject_ipv6
> xt_hl
> ip6_tables
> cmac
> ip6t_rt
> algif_hash
> algif_skcipher
> af_alg
> bnep
> ipt_REJECT
> nf_reject_ipv4
> xt_LOG
> nf_log_syslog
> nft_limit
> xt_limit
> xt_addrtype
> xt_tcpudp
> xt_conntrack
> nf_conntrack
> nf_defrag_ipv6
> nf_defrag_ipv4
> nft_compat
> nf_tables
> nfnetlink
> binfmt_misc
> snd_hda_codec_hdmi
> x86_pkg_temp_thermal
> intel_powerclamp
> coretemp
> btusb
> btrtl
> btbcm
> snd_sof_pci_intel_apl
> snd_sof_intel_hda_common
> soundwire_intel
> btintel
> kvm_intel
> soundwire_generic_allocation
> btmtk
> soundwire_cadence
> rtw88_8821ce
> bluetooth
> snd_sof_intel_hda
> rtw88_8821c
> snd_sof_pci
> rtw88_pci
> nls_ascii
> mei_hdcp
> rtw88_core
> nls_cp437
> intel_rapl_msr
> snd_sof_xtensa_dsp
> snd_sof
> mac80211
> jitterentropy_rng
> vfat
> snd_sof_utils
> soundwire_bus
> fat
> libarc4
> snd_soc_skl
> gpio_keys
> snd_soc_hdac_hda
> uvcvideo
> rtsx_usb_ms
> snd_hda_ext_core
> videobuf2_vmalloc
> snd_soc_sst_ipc
> snd_soc_sst_dsp
> videobuf2_memops
> snd_hda_codec_realtek
> drbg
> memstick
> snd_soc_acpi_intel_match
> videobuf2_v4l2
> snd_soc_acpi
> snd_hda_codec_generic
> ansi_cprng
> videobuf2_common
> kvm
> snd_soc_core
> asus_nb_wmi
> snd_compress
> irqbypass
> videodev
> wdat_wdt
> cfg80211
> rapl
> mc
> intel_cstate
> snd_hda_intel
> asus_wmi
> platform_profile
> ledtrig_audio
> wmi_bmof
> snd_intel_dspcfg
> watchdog
> pcspkr
> snd_intel_sdw_acpi
> hid_sensor_accel_3d
> hid_sensor_trigger
> ecdh_generic
> ecc
> snd_hda_codec
> hid_sensor_iio_common
> snd_hda_core
> rfkill
> industrialio_triggered_buffer
> snd_hwdep
> snd_pcm
> kfifo_buf
> industrialio
> processor_thermal_device_pci_legacy
> snd_timer
> processor_thermal_device
> snd
> mei_me
> processor_thermal_rfim
> processor_thermal_mbox
> processor_thermal_rapl
> soundcore
> mei
> intel_rapl_common
> intel_soc_dts_iosf
> ac
> intel_pmc_core
> intel_hid
> sparse_keymap
> int3400_thermal
> asus_wireless
> acpi_thermal_rel
> int3403_thermal
> int340x_thermal_zone
> soc_button_array
> joydev
> serio_raw
> evdev
> msr
> ecryptfs
> parport_pc
> ppdev
> lp
> parport
> fuse
> efi_pstore
> loop
> configfs
> efivarfs
> ip_tables
> x_tables
> autofs4
> ext4
> crc16
> mbcache
> jbd2
> crc32c_generic
> rtsx_usb_sdmmc
> rtsx_usb
> btrfs
> xor
> raid6_pq
> zstd_compress
> libcrc32c
> dm_mirror
> dm_region_hash
> dm_log
> hid_sensor_custom
> hid_sensor_hub
> dm_mod
> zsmalloc
> intel_ishtp_hid
> crct10dif_pclmul
> crct10dif_common
> crc32_pclmul
> crc32c_intel
> ghash_clmulni_intel
> sha512_ssse3
> sha512_generic
> sha256_ssse3
> sha1_ssse3
> i915
> mmc_block
> ahci
> drm_buddy
> libahci
> i2c_algo_bit
> drm_display_helper
> xhci_pci
> cec
> libata
> rc_core
> xhci_hcd
> ttm
> drm_kms_helper
> aesni_intel
> hid_multitouch
> hid_generic
> spi_pxa2xx_platform
> dw_dmac
> dw_dmac_core
> sdhci_pci
> cqhci
> i2c_i801
> sdhci
> crypto_simd
> usbcore
> scsi_mod
> cryptd
> i2c_hid_acpi
> intel_ish_ipc
> mmc_core
> i2c_smbus
> lpc_ich
> drm
> intel_ishtp
> intel_lpss_pci
> intel_lpss
> idma64
> usb_common
> scsi_common
> video
> i2c_hid
> hid
> battery
> wmi
> button
> 
> ** Network interface configuration:
> *** /etc/network/interfaces:
> source /etc/network/interfaces.d/*
> 
> ** Network status:
> *** IP interfaces and addresses:
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>     inet 127.0.0.1/8 scope host lo
>        valid_lft forever preferred_lft forever
>     inet6 ::1/128 scope host noprefixroute 
>        valid_lft forever preferred_lft forever
> 2: wlo1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>     link/ether 34:6f:24:1e:d3:1f brd ff:ff:ff:ff:ff:ff
>     altname wlp2s0
>     inet 192.168.1.138/24 brd 192.168.1.255 scope global dynamic noprefixroute wlo1
>        valid_lft 43050sec preferred_lft 43050sec
>     inet6 fe80::dc7a:c4da:70ac:75c4/64 scope link noprefixroute 
>        valid_lft forever preferred_lft forever
> 
> *** Device statistics:
> Inter-|   Receive                                                |  Transmit
>  face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
>     lo:   10373     109    0    0    0     0          0         0    10373     109    0    0    0     0       0          0
>   wlo1:  698882    1120    0   73    0     0          0         0   362256     585    0    0    0     0       0          0
> 
> *** Protocol statistics:
> Ip:
>     Forwarding: 2
>     897 total packets received
>     1 with invalid addresses
>     0 forwarded
>     0 incoming packets discarded
>     753 incoming packets delivered
>     660 requests sent out
>     20 outgoing packets dropped
> Icmp:
>     40 ICMP messages received
>     0 input ICMP message failed
>     ICMP input histogram:
>         destination unreachable: 40
>     40 ICMP messages sent
>     0 ICMP messages failed
>     ICMP output histogram:
>         destination unreachable: 40
> IcmpMsg:
>         InType3: 40
>         OutType3: 40
> Tcp:
>     20 active connection openings
>     0 passive connection openings
>     2 failed connection attempts
>     0 connection resets received
>     4 connections established
>     561 segments received
>     583 segments sent out
>     3 segments retransmitted
>     0 bad segments received
>     31 resets sent
> Udp:
>     114 packets received
>     40 packets to unknown port received
>     0 packet receive errors
>     140 packets sent
>     0 receive buffer errors
>     0 send buffer errors
> UdpLite:
> TcpExt:
>     2 TCP sockets finished time wait in fast timer
>     5 packets rejected in established connections because of timestamp
>     11 delayed acks sent
>     33 packet headers predicted
>     140 acknowledgments not containing data payload received
>     75 predicted acknowledgments
>     Detected reordering 4 times using SACK
>     TCPLossProbes: 5
>     TCPDSACKRecv: 3
>     12 connections reset due to unexpected data
>     TCPDSACKIgnoredNoUndo: 2
>     TCPSackMerged: 3
>     TCPSackShiftFallback: 3
>     TCPRcvCoalesce: 84
>     TCPOFOQueue: 2
>     TCPAutoCorking: 18
>     TCPOrigDataSent: 291
>     TCPHystartDelayDetect: 1
>     TCPHystartDelayCwnd: 29
>     TCPDelivered: 312
>     TCPDSACKRecvSegs: 3
> IpExt:
>     InMcastPkts: 66
>     OutMcastPkts: 46
>     InBcastPkts: 16
>     OutBcastPkts: 10
>     InOctets: 675541
>     OutOctets: 332155
>     InMcastOctets: 10717
>     OutMcastOctets: 6614
>     InBcastOctets: 2105
>     OutBcastOctets: 1730
>     InNoECTPkts: 1060
> MPTcpExt:
> 
> 
> ** PCI devices:
> 00:00.0 Host bridge [0600]: Intel Corporation Gemini Lake Host Bridge [8086:31f0] (rev 06)
> 	Subsystem: ASUSTeK Computer Inc. Gemini Lake Host Bridge [1043:1df2]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	IOMMU group: 1
> 
> 00:00.1 Signal processing controller [1180]: Intel Corporation Celeron/Pentium Silver Processor Dynamic Platform and Thermal Framework Processor Participant [8086:318c] (rev 06)
> 	Subsystem: ASUSTeK Computer Inc. Celeron/Pentium Silver Processor Dynamic Platform and Thermal Framework Processor Participant [1043:1df2]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx+
> 	Latency: 0
> 	Interrupt: pin B routed to IRQ 24
> 	IOMMU group: 1
> 	Region 0: Memory at 80000000 (64-bit, non-prefetchable) [size=32K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: proc_thermal
> 	Kernel modules: processor_thermal_device_pci_legacy
> 
> 00:00.3 System peripheral [0880]: Intel Corporation Celeron/Pentium Silver Processor Gaussian Mixture Model [8086:3190] (rev 06)
> 	Subsystem: ASUSTeK Computer Inc. Celeron/Pentium Silver Processor Gaussian Mixture Model [1043:1c80]
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Interrupt: pin A routed to IRQ 23
> 	IOMMU group: 1
> 	Region 0: Memory at a1229000 (64-bit, non-prefetchable) [disabled] [size=4K]
> 	Capabilities: <access denied>
> 
> 00:02.0 VGA compatible controller [0300]: Intel Corporation GeminiLake [UHD Graphics 600] [8086:3185] (rev 06) (prog-if 00 [VGA controller])
> 	DeviceName: VGA
> 	Subsystem: ASUSTeK Computer Inc. GeminiLake [UHD Graphics 600] [1043:1df2]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 127
> 	IOMMU group: 0
> 	Region 0: Memory at a0000000 (64-bit, non-prefetchable) [size=16M]
> 	Region 2: Memory at 90000000 (64-bit, prefetchable) [size=256M]
> 	Region 4: I/O ports at f000 [size=64]
> 	Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: i915
> 	Kernel modules: i915
> 
> 00:0e.0 Audio device [0403]: Intel Corporation Celeron/Pentium Silver Processor High Definition Audio [8086:3198] (rev 06)
> 	Subsystem: ASUSTeK Computer Inc. Celeron/Pentium Silver Processor High Definition Audio [1043:1c80]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 133
> 	IOMMU group: 2
> 	Region 0: Memory at a1210000 (64-bit, non-prefetchable) [size=16K]
> 	Region 4: Memory at a1000000 (64-bit, non-prefetchable) [size=1M]
> 	Capabilities: <access denied>
> 	Kernel driver in use: snd_hda_intel
> 	Kernel modules: snd_hda_intel, snd_soc_skl, snd_sof_pci_intel_apl
> 
> 00:0f.0 Communication controller [0780]: Intel Corporation Celeron/Pentium Silver Processor Trusted Execution Engine Interface [8086:319a] (rev 06)
> 	Subsystem: ASUSTeK Computer Inc. Celeron/Pentium Silver Processor Trusted Execution Engine Interface [1043:1df2]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 130
> 	IOMMU group: 3
> 	Region 0: Memory at a1228000 (64-bit, non-prefetchable) [size=4K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: mei_me
> 	Kernel modules: mei_me
> 
> 00:11.0 Unclassified device [0050]: Intel Corporation Celeron/Pentium Silver Processor Integrated Sensor Solution [8086:31a2] (rev 06) (prog-if 07)
> 	Subsystem: ASUSTeK Computer Inc. Celeron/Pentium Silver Processor Integrated Sensor Solution [1043:1df2]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 26
> 	IOMMU group: 4
> 	Region 0: Memory at a1216000 (64-bit, non-prefetchable) [size=8K]
> 	Region 2: Memory at a1227000 (64-bit, non-prefetchable) [size=4K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: intel_ish_ipc
> 	Kernel modules: intel_ish_ipc
> 
> 00:12.0 SATA controller [0106]: Intel Corporation Celeron/Pentium Silver Processor SATA Controller [8086:31e3] (rev 06) (prog-if 01 [AHCI 1.0])
> 	Subsystem: ASUSTeK Computer Inc. Celeron/Pentium Silver Processor SATA Controller [1043:1df2]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 126
> 	IOMMU group: 5
> 	Region 0: Memory at a1214000 (32-bit, non-prefetchable) [size=8K]
> 	Region 1: Memory at a1226000 (32-bit, non-prefetchable) [size=256]
> 	Region 2: I/O ports at f090 [size=8]
> 	Region 3: I/O ports at f080 [size=4]
> 	Region 4: I/O ports at f060 [size=32]
> 	Region 5: Memory at a1225000 (32-bit, non-prefetchable) [size=2K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: ahci
> 	Kernel modules: ahci
> 
> 00:13.0 PCI bridge [0604]: Intel Corporation Gemini Lake PCI Express Root Port [8086:31d8] (rev f6) (prog-if 00 [Normal decode])
> 	Subsystem: ASUSTeK Computer Inc. Gemini Lake PCI Express Root Port [1043:1df2]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 122
> 	IOMMU group: 6
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> 	I/O behind bridge: [disabled] [16-bit]
> 	Memory behind bridge: [disabled] [32-bit]
> 	Prefetchable memory behind bridge: [disabled] [64-bit]
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
> 
> 00:13.2 PCI bridge [0604]: Intel Corporation Gemini Lake PCI Express Root Port [8086:31da] (rev f6) (prog-if 00 [Normal decode])
> 	Subsystem: ASUSTeK Computer Inc. Gemini Lake PCI Express Root Port [1043:1df2]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin C routed to IRQ 123
> 	IOMMU group: 7
> 	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
> 	I/O behind bridge: e000-efff [size=4K] [16-bit]
> 	Memory behind bridge: a1100000-a11fffff [size=1M] [32-bit]
> 	Prefetchable memory behind bridge: [disabled] [64-bit]
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
> 
> 00:13.3 PCI bridge [0604]: Intel Corporation Gemini Lake PCI Express Root Port [8086:31db] (rev f6) (prog-if 00 [Normal decode])
> 	Subsystem: ASUSTeK Computer Inc. Gemini Lake PCI Express Root Port [1043:1df2]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin D routed to IRQ 124
> 	IOMMU group: 8
> 	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
> 	I/O behind bridge: [disabled] [16-bit]
> 	Memory behind bridge: [disabled] [32-bit]
> 	Prefetchable memory behind bridge: [disabled] [64-bit]
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> 	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
> 
> 00:15.0 USB controller [0c03]: Intel Corporation Celeron/Pentium Silver Processor USB 3.0 xHCI Controller [8086:31a8] (rev 06) (prog-if 30 [XHCI])
> 	Subsystem: ASUSTeK Computer Inc. Celeron/Pentium Silver Processor USB 3.0 xHCI Controller [1043:201f]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 125
> 	IOMMU group: 9
> 	Region 0: Memory at a1200000 (64-bit, non-prefetchable) [size=64K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: xhci_hcd
> 	Kernel modules: xhci_pci
> 
> 00:16.0 Signal processing controller [1180]: Intel Corporation Celeron/Pentium Silver Processor I2C 0 [8086:31ac] (rev 06)
> 	Subsystem: ASUSTeK Computer Inc. Celeron/Pentium Silver Processor I2C 0 [1043:1df2]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 27
> 	IOMMU group: 10
> 	Region 0: Memory at a1224000 (64-bit, non-prefetchable) [size=4K]
> 	Region 2: Memory at a1223000 (64-bit, non-prefetchable) [size=4K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: intel-lpss
> 	Kernel modules: intel_lpss_pci
> 
> 00:16.3 Signal processing controller [1180]: Intel Corporation Celeron/Pentium Silver Processor I2C 3 [8086:31b2] (rev 06)
> 	Subsystem: ASUSTeK Computer Inc. Celeron/Pentium Silver Processor I2C 3 [1043:1df2]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin D routed to IRQ 30
> 	IOMMU group: 10
> 	Region 0: Memory at a1222000 (64-bit, non-prefetchable) [size=4K]
> 	Region 2: Memory at a1221000 (64-bit, non-prefetchable) [size=4K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: intel-lpss
> 	Kernel modules: intel_lpss_pci
> 
> 00:17.0 Signal processing controller [1180]: Intel Corporation Celeron/Pentium Silver Processor I2C 4 [8086:31b4] (rev 06)
> 	Subsystem: ASUSTeK Computer Inc. Celeron/Pentium Silver Processor I2C 4 [1043:1df2]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 31
> 	IOMMU group: 11
> 	Region 0: Memory at a1220000 (64-bit, non-prefetchable) [size=4K]
> 	Region 2: Memory at a121f000 (64-bit, non-prefetchable) [size=4K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: intel-lpss
> 	Kernel modules: intel_lpss_pci
> 
> 00:17.1 Signal processing controller [1180]: Intel Corporation Celeron/Pentium Silver Processor I2C 5 [8086:31b6] (rev 06)
> 	Subsystem: ASUSTeK Computer Inc. Celeron/Pentium Silver Processor I2C 5 [1043:1df2]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin B routed to IRQ 32
> 	IOMMU group: 11
> 	Region 0: Memory at a121e000 (64-bit, non-prefetchable) [size=4K]
> 	Region 2: Memory at a121d000 (64-bit, non-prefetchable) [size=4K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: intel-lpss
> 	Kernel modules: intel_lpss_pci
> 
> 00:19.0 Signal processing controller [1180]: Intel Corporation Celeron/Pentium Silver Processor Serial IO SPI Host Controller [8086:31c2] (rev 06)
> 	Subsystem: ASUSTeK Computer Inc. Celeron/Pentium Silver Processor Serial IO SPI Host Controller [1043:1df2]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 35
> 	IOMMU group: 12
> 	Region 0: Memory at a121c000 (64-bit, non-prefetchable) [size=4K]
> 	Region 2: Memory at a121b000 (64-bit, non-prefetchable) [size=4K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: intel-lpss
> 	Kernel modules: intel_lpss_pci
> 
> 00:1c.0 SD Host controller [0805]: Intel Corporation Celeron/Pentium Silver Processor SDA Standard Compliant SD Host Controller [8086:31cc] (rev 06) (prog-if 01)
> 	Subsystem: ASUSTeK Computer Inc. Celeron/Pentium Silver Processor SDA Standard Compliant SD Host Controller [1043:1df2]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 39
> 	IOMMU group: 13
> 	Region 0: Memory at a121a000 (64-bit, non-prefetchable) [size=4K]
> 	Region 2: Memory at a1219000 (64-bit, non-prefetchable) [size=4K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: sdhci-pci
> 	Kernel modules: sdhci_pci
> 
> 00:1f.0 ISA bridge [0601]: Intel Corporation Celeron/Pentium Silver Processor LPC Controller [8086:31e8] (rev 06)
> 	Subsystem: ASUSTeK Computer Inc. Celeron/Pentium Silver Processor LPC Controller [1043:1df2]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	IOMMU group: 14
> 	Kernel modules: lpc_ich
> 
> 00:1f.1 SMBus [0c05]: Intel Corporation Celeron/Pentium Silver Processor Gaussian Mixture Model [8086:31d4] (rev 06)
> 	Subsystem: ASUSTeK Computer Inc. Celeron/Pentium Silver Processor Gaussian Mixture Model [1043:1df2]
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Interrupt: pin A routed to IRQ 20
> 	IOMMU group: 14
> 	Region 0: Memory at a1218000 (64-bit, non-prefetchable) [size=256]
> 	Region 4: I/O ports at f040 [size=32]
> 	Kernel driver in use: i801_smbus
> 	Kernel modules: i2c_i801
> 
> 02:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd. RTL8821CE 802.11ac PCIe Wireless Network Adapter [10ec:c821]
> 	DeviceName: WLAN
> 	Subsystem: AzureWave RTL8821CE 802.11ac PCIe Wireless Network Adapter [1a3b:3041]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 134
> 	IOMMU group: 15
> 	Region 0: I/O ports at e000 [size=256]
> 	Region 2: Memory at a1100000 (64-bit, non-prefetchable) [size=64K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: rtw_8821ce
> 	Kernel modules: rtw88_8821ce
> 
> 
> ** USB devices:
> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 001 Device 004: ID 0bda:0129 Realtek Semiconductor Corp. RTS5129 Card Reader Controller
> Bus 001 Device 003: ID 13d3:5a03 IMC Networks USB2.0 VGA UVC WebCam
> Bus 001 Device 002: ID 13d3:3530 IMC Networks Bluetooth Radio 
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> 
> 
> -- System Information:
> Debian Release: 12.1
>   APT prefers stable-updates
>   APT policy: (500, 'stable-updates'), (500, 'stable-security'), (500, 'stable')
> Architecture: amd64 (x86_64)
> Foreign Architectures: i386
> 
> Kernel: Linux 6.1.0-32-amd64 (SMP w/2 CPU threads; PREEMPT)
> Locale: LANG=en_CA.UTF-8, LC_CTYPE=en_CA.UTF-8 (charmap=UTF-8), LANGUAGE not set
> Shell: /bin/sh linked to /usr/bin/dash
> Init: systemd (via /run/systemd/system)
> LSM: AppArmor: enabled
> 
> Versions of packages linux-image-6.1.0-32-amd64 depends on:
> ii  initramfs-tools [linux-initramfs-tool]  0.142+deb12u1
> ii  kmod                                    30+20221128-1
> ii  linux-base                              4.9
> 
> Versions of packages linux-image-6.1.0-32-amd64 recommends:
> ii  apparmor             3.0.8-3
> ii  firmware-linux-free  20200122-1
> 
> Versions of packages linux-image-6.1.0-32-amd64 suggests:
> pn  debian-kernel-handbook  <none>
> ii  grub-efi-amd64          2.06-13+deb12u1
> pn  linux-doc-6.1           <none>
> 
> Versions of packages linux-image-6.1.0-32-amd64 is related to:
> ii  firmware-amd-graphics     20230210-5
> ii  firmware-atheros          20230210-5
> ii  firmware-bnx2             20230210-5
> ii  firmware-bnx2x            20230210-5
> ii  firmware-brcm80211        20230210-5
> pn  firmware-cavium           <none>
> pn  firmware-intel-sound      <none>
> pn  firmware-intelwimax       <none>
> ii  firmware-ipw2x00          20230210-5
> ii  firmware-ivtv             20230210-5
> ii  firmware-iwlwifi          20230210-5
> ii  firmware-libertas         20230210-5
> ii  firmware-linux-nonfree    20230210-5
> ii  firmware-misc-nonfree     20230210-5
> pn  firmware-myricom          <none>
> pn  firmware-netxen           <none>
> ii  firmware-qlogic           20230210-5
> ii  firmware-realtek          20230210-5
> pn  firmware-samsung          <none>
> pn  firmware-siano            <none>
> pn  firmware-ti-connectivity  <none>
> pn  xen-hypervisor            <none>
> 
> -- no debconf information

