Return-Path: <linux-kernel+bounces-444773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77779F0C52
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025BE169891
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2763E1DF73E;
	Fri, 13 Dec 2024 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8MTioJT"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61A51C3C0F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093247; cv=none; b=DmiY0nX9Oqi//5RoftoeQCDHzQlVCEZ05lhCBhglf4wqAqcYkIN366TqmJPth/ONqy1roc+XT1cBJzp/bwfdsUDlJsLqImo7+u56+Rl1lX5tPJ2GL5z2V9yYjZ7ZWM/384pst2Sk508rSw+SwnG9dPorWdw6S9DCuNeEv1blgd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093247; c=relaxed/simple;
	bh=qsvFRtzz111GaErbz/ZiH0SAUWbiNJSqdOJ+JizCsJk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=EW4IJpC+RSkss1l4gRcZiUZpv684rdOnitq6QK9Zf8ocnRoVd1jMFckgWzaIespmL5hp2zgMhYD/3QxKYC4O77inyuJ578rlRBUyEzFkkxgRIP/Yr5rscOa7JlkKhUF9Q26/PbarfjOf5mxZB8Yn5M/IzOlX1nsCZ4z7xXFmRAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8MTioJT; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d8e8cb8605so9912006d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734093244; x=1734698044; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sy1pv3KNrKA7If0E5cP9QA9FHok/xGitBn2B2dywE3k=;
        b=l8MTioJT7RrWV92SJHsb+ayaNL411MGBOHzfyjI26emGcGs4UTwSdoOL7OCf/a3TYY
         +5mibk9E3EfRxkBs0GfACGMQq1rZu3gQi9kVwdSSYNej4M6hAn/FnbvIIym203NTLF4/
         yAl0of+vdIWGt2qlOArXvUWkpL2DyTAAIMsNh2MRrW/WkqmioTqB+jZAH4JZAo5xBbtN
         mymU11LVz/DRhWmJgLRTd6R6r8ZWctNO4l/26q7/ZretsJ9yDg3JC8CFVVZ8P+dU+Urj
         2E8dr4YywPfjRYX2iVgBFT7uf+bR9Ff0g7nQsxRUT/+aQp4TCc1JL3m6corZNlRsuRQY
         EDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734093244; x=1734698044;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sy1pv3KNrKA7If0E5cP9QA9FHok/xGitBn2B2dywE3k=;
        b=kqA5n7wPEZTCxZgoPm9+ofq0s6MuVJiwimCxPIKOCBzapGWIOmtcuI93wrBpSTkBjc
         rIk5pa2YXfkmkZSgjyr3Dw0IPquc57lHcVOa/7BRHSK0ohEcc3cF0qUqIH/aPI2Sh+jd
         a2LA2kVdXL1nxkrqPhBemV6qhfTtyVKo66FMkKK4sm/KYoJ3eVBIVlvrc9DXaa4exNea
         i60XIVAY3RxsG5hIVFvxIb4wnpAQz/VIvCG9TckOdhoPo58yRkA0R8fNJYEhfIpOWYGb
         TbGPNvlEuwPefms2TJUYNBgTLlG2pKgaupQ954vbPwrgPmcw9zL6g/lgeb1z/Xev0sr8
         2kGg==
X-Gm-Message-State: AOJu0YwTdpelpPWJfI7mZ+Cjq5d1wuph2CG1sz5Hb0EQ2x5UBclLJhhS
	4BJyIt3Vvzc2LHS56ijlHbbHYgDJzt0MN2I0rIwbdpi3BnxO3y5k+hkVSQmjTKlFtWaIaneNIYk
	ZRiIh1uBDrxY6IZY3XWSOUV/yhX7uBAA9
X-Gm-Gg: ASbGncuVcyxWrFX7/pb8W1xLUdE/WDMWjVBulTZO82PmHp7D3LK3Y52IJ6wh5h0pje9
	rFTlfwTwnP8R1HRP+s40JKI6YZvPHNOoeMwAbSP4KeHv7rU5cOoy57GUMFVoCvsxLRxFalw==
X-Google-Smtp-Source: AGHT+IGpj9tzr406MlLZko+8gRb9lMk9/hL3zRn9KTPzuBr19NNA+8UJWifLJIJ8yw3VIYx3OcOoZIrfpakmVU5D6cg=
X-Received: by 2002:a05:6214:2029:b0:6d8:e6be:5102 with SMTP id
 6a1803df08f44-6dc8ca9516cmr41401876d6.28.1734093242893; Fri, 13 Dec 2024
 04:34:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Rankin <rankincj@gmail.com>
Date: Fri, 13 Dec 2024 12:33:52 +0000
Message-ID: <CAK2bqVJXY2CkR4Od2bj8wnYYfzZCpFYhaiPAcwpw0Uk7zXUVkg@mail.gmail.com>
Subject: [WARNING][AMDGPU] WQ_MEM_RECLAIM with Radeon RX 6600
To: LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I've just noticed this warning in my dmesg log. This is a vanilla
6.12.4 kernel, with a Radeon RX6600 graphics card.

Cheers,
Chris

[ 4624.741148] ------------[ cut here ]------------
[ 4624.744474] workqueue: WQ_MEM_RECLAIM sdma0:drm_sched_run_job_work
[gpu_sched] is flushing !WQ_MEM_RECLAIM
events:amdgpu_device_delay_enable_gfx_off [amdgpu]
[ 4624.744942] WARNING: CPU: 2 PID: 9069 at kernel/workqueue.c:3704
check_flush_dependency+0xbe/0xd0
[ 4624.765285] Modules linked in: snd_seq_dummy rpcrdma rdma_cm iw_cm
ib_cm ib_core af_packet nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat
ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_raw
ip6table_security iptable_nat iptable_mangle iptable_raw
iptable_security nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 nf_tables libcrc32c ebtable_filter
ebtables ip6table_filter ip6_tables iptable_filter ip_tables x_tables
bnep it87 hwmon_vid binfmt_misc snd_hda_codec_realtek
snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_scodec_component
snd_hda_intel uvcvideo btusb uvc videobuf2_vmalloc btintel
videobuf2_memops videobuf2_v4l2 videodev btbcm snd_usb_audio bluetooth
snd_intel_dspcfg intel_powerclamp snd_hda_codec videobuf2_common
coretemp snd_virtuoso snd_usbmidi_lib snd_oxygen_lib snd_ctl_led
kvm_intel input_leds mc snd_hwdep led_class snd_mpu401_uart
[ 4624.765400]  snd_hda_core joydev snd_rawmidi rfkill kvm snd_seq
snd_seq_device gpio_ich snd_pcm pktcdvd iTCO_wdt snd_hrtimer r8169
snd_timer intel_cstate realtek snd mdio_devres intel_uncore libphy
i2c_i801 soundcore lpc_ich tiny_power_button mxm_wmi i7core_edac
acpi_cpufreq i2c_smbus pcspkr button nfsd auth_rpcgss nfs_acl lockd
grace dm_mod fuse sunrpc loop configfs dax nfnetlink zram zsmalloc
ext4 crc32c_generic mbcache jbd2 amdgpu video amdxcp i2c_algo_bit
mfd_core drm_ttm_helper ttm drm_exec gpu_sched hid_microsoft
drm_suballoc_helper drm_buddy drm_display_helper drm_kms_helper usbhid
sr_mod sd_mod cdrom drm pata_jmicron ahci libahci uhci_hcd xhci_pci
libata ehci_pci ehci_hcd xhci_hcd scsi_mod firewire_ohci psmouse
firewire_core usbcore crc32c_intel sha512_ssse3 sha256_ssse3 bsg
serio_raw sha1_ssse3 drm_panel_orientation_quirks scsi_common crc16
usb_common crc_itu_t wmi msr gf128mul crypto_simd cryptd
[ 4624.932496] CPU: 2 UID: 0 PID: 9069 Comm: kworker/u32:3 Tainted: G
        I        6.12.4 #1
[ 4624.939803] Tainted: [I]=FIRMWARE_WORKAROUND
[ 4624.942773] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[ 4624.950340] Workqueue: sdma0 drm_sched_run_job_work [gpu_sched]
[ 4624.954967] RIP: 0010:check_flush_dependency+0xbe/0xd0
[ 4624.958806] Code: 75 2a 48 8b 55 18 48 8d 8b c8 00 00 00 4d 89 e0
48 81 c6 c8 00 00 00 48 c7 c7 1b d6 e9 81 c6 05 a3 5f 56 01 01 e8 32
30 fe ff <0f> 0b 5b 5d 41 5c c3 cc cc cc cc 0f 1f 80 00 00 00 00 90 90
90 90
[ 4624.976253] RSP: 0018:ffffc9000bec7c88 EFLAGS: 00010086
[ 4624.980177] RAX: 0000000000000000 RBX: ffff888100118000 RCX: 0000000000000027
[ 4624.986003] RDX: 0000000000000003 RSI: ffffffff81eab2b9 RDI: 00000000ffffffff
[ 4624.991835] RBP: ffff888155daa900 R08: 0000000000000000 R09: 7067646d61006600
[ 4624.997668] R10: 0000000000000091 R11: fefefefefefefeff R12: ffffffffa05ec880
[ 4625.003501] R13: 0000000000000001 R14: ffff88810011c600 R15: ffff888163600000
[ 4625.009334] FS:  0000000000000000(0000) GS:ffff888343c80000(0000)
knlGS:0000000000000000
[ 4625.016118] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4625.020555] CR2: 0000000099837000 CR3: 0000000144e4c000 CR4: 00000000000026f0
[ 4625.026381] Call Trace:
[ 4625.027525]  <TASK>
[ 4625.028323]  ? __warn+0x90/0x120
[ 4625.030255]  ? report_bug+0xe2/0x160
[ 4625.032532]  ? check_flush_dependency+0xbe/0xd0
[ 4625.035768]  ? handle_bug+0x53/0x80
[ 4625.037959]  ? exc_invalid_op+0x13/0x60
[ 4625.040499]  ? asm_exc_invalid_op+0x16/0x20
[ 4625.043384]  ? __pfx_amdgpu_device_delay_enable_gfx_off+0x10/0x10 [amdgpu]
[ 4625.049366]  ? check_flush_dependency+0xbe/0xd0
[ 4625.052598]  ? check_flush_dependency+0xbe/0xd0
[ 4625.055830]  __flush_work+0xb2/0x1f0
[ 4625.058109]  ? work_grab_pending+0x3f/0x120
[ 4625.060996]  ? set_work_pool_and_clear_pending+0x14/0x20
[ 4625.065008]  ? __cancel_work+0x89/0xc0
[ 4625.067460]  __cancel_work_sync+0x4a/0x70
[ 4625.070173]  amdgpu_gfx_off_ctrl+0xa6/0x100 [amdgpu]
[ 4625.074231]  amdgpu_ring_alloc+0x52/0x60 [amdgpu]
[ 4625.077974]  amdgpu_ib_schedule+0x155/0x640 [amdgpu]
[ 4625.081988]  amdgpu_job_run+0xda/0x140 [amdgpu]
[ 4625.085663]  drm_sched_run_job_work+0x246/0x310 [gpu_sched]
[ 4625.089935]  process_scheduled_works+0x19c/0x2c0
[ 4625.093252]  worker_thread+0x13b/0x1c0
[ 4625.095706]  ? __pfx_worker_thread+0x10/0x10
[ 4625.098678]  kthread+0xef/0x100
[ 4625.100523]  ? __pfx_kthread+0x10/0x10
[ 4625.102976]  ret_from_fork+0x24/0x40
[ 4625.105256]  ? __pfx_kthread+0x10/0x10
[ 4625.107709]  ret_from_fork_asm+0x1a/0x30
[ 4625.110338]  </TASK>
[ 4625.111228] ---[ end trace 0000000000000000 ]---

