Return-Path: <linux-kernel+bounces-447950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 270049F391A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FDD1653B3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556A9206F13;
	Mon, 16 Dec 2024 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3qeXkGx"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F343AA9
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734374203; cv=none; b=nYSEQm91ZCob5JlgtQdQKhqL1ICEv6nv5cnBUT55ZiuApflUDEU4iLb0105qDFiQKewGBVpIEUW/ICO+WOBIj8iBsjyv4fQ8a9QCOmE7rS2AZI4X0IRom2Gdo4Fe5N89ZUWVvGgYpK5Ry/qirzaKqcfSD97cyz6mHqqBGJnJtxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734374203; c=relaxed/simple;
	bh=NfW7moROXhbETJ0M9vx7mqqF3Ac5PJHua6AqrfwQw2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHRzb/zVVK2ro0YhBMeeXzVYa7itS/+cAOEFGOTOQzN4IxUopqJwDXomsYpBShy0vpgrZg4s7O8cWB0AAQfETbVEUD8dTfqMlScMTnkNmtoQaSBX2K9N/l7NE5o7XQDoy6VoTpxj0Xxdld/8SxPmX0rncJu5BS/uPWrTZJIQyf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3qeXkGx; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee6d0a57acso486834a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734374201; x=1734979001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoHpaxKC0+kkzVuZNNTWmHCNqinn+c7Ii7MrNklMZsg=;
        b=S3qeXkGxkKCq809dN8EKe8kBsS1Zs8Ip8x6s7ZcSYMKfSvkaDEkoH+tcM3H3+ajwfr
         7ehQCHe9oeu9GC7wrJgYJDEtot34nPcEq7SVJ4e9Y2iaVYZ9QxDOqDOw0lj/0Fq1jFx4
         ZcIlM1ofiFzuE95+EEzgYItoXkPuVxdGrDS40ruv3afw3Lsq5TAPwNvBrPaQX1J+yGwh
         6iClpHCqEdotd7U23f97d83RoxPkmSTmLj+RJtrtTbWzyfe230KeX+WRDK9Z1KbnrXw+
         E+F2AcHGPPL+B1XBGogKrHGu6lpFDNUvyW148yfAmCFQ4qcprdoaoKn6uLLeGeNTiGnS
         2IrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734374201; x=1734979001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoHpaxKC0+kkzVuZNNTWmHCNqinn+c7Ii7MrNklMZsg=;
        b=nxf8mYz0oVT1XtDkJQEJXRwVzCu2aMOQMBZdS4BjSSfwBX4u6FdUCBOXf9X1BDKgXB
         +1qHt/d3QM6hqbikMY6yBMeB9sS7A5eIVuHEAYYJmQXqMA+te9v9OAI3JLHMb5iGWKyP
         I4WKqzusFM8moMtcxwO2nrmW0oCsXkFpzuTTeEEmu6IAcL3QW3CYLxzsaHuvI6QlI49g
         +rnURHbl+JMzJZv/B+P9UbJn+NYHA+gIzRUevCEl2Tovfojh6PLBr/vcg8k52N2fdQFg
         EYgDkYBE0pUOXEDNMoB5CnTK/TqaeSWi32T7j+3/ueFICZ2jrql10UGBXiwjixBkHtqe
         oFNQ==
X-Gm-Message-State: AOJu0YwE8RrCwQRX+6m047VI6Co6W5k+msYgC1pBejTqi8gU6jEobtzY
	v/Rtz71fWpF93oK6YG6Sd3pJWfpuKZlMhfBoD2ps6ORkdmq/zwdm2XHtwEe+k1cqRj0cwJFcRiM
	bPuaWKUm+dYPhu5JhB0GYcrij/co=
X-Gm-Gg: ASbGncujc4na2K0T+Bn/huRRuYBiOQ8+dIw3lVmtU3DJ2PIYLc4fp453qwexZsTqz9w
	nJocsNl8GksBPN2XtWdoN7F1dUzGoBFtlUR9uPQ==
X-Google-Smtp-Source: AGHT+IFPLgnnULim77ZTS270N6gKqb4/FH6nXr2RxedlEA0Rm8kILkobAryUZlvNCyspmPnYuTcIgcSTLnIq+n/hKJU=
X-Received: by 2002:a17:90b:4d08:b0:2ee:f64b:9aab with SMTP id
 98e67ed59e1d1-2f2901a8b82mr7359185a91.6.1734374201367; Mon, 16 Dec 2024
 10:36:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK2bqVJXY2CkR4Od2bj8wnYYfzZCpFYhaiPAcwpw0Uk7zXUVkg@mail.gmail.com>
In-Reply-To: <CAK2bqVJXY2CkR4Od2bj8wnYYfzZCpFYhaiPAcwpw0Uk7zXUVkg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Dec 2024 13:36:29 -0500
Message-ID: <CADnq5_OYjnFhVnQmVLQ7ucSYLm4NZ_wmRnLSOfJQzY33VQZ+EA@mail.gmail.com>
Subject: Re: [WARNING][AMDGPU] WQ_MEM_RECLAIM with Radeon RX 6600
To: Chris Rankin <rankincj@gmail.com>, Christian Koenig <christian.koenig@amd.com>, 
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 7:53=E2=80=AFAM Chris Rankin <rankincj@gmail.com> w=
rote:
>
> Hi,
>
> I've just noticed this warning in my dmesg log. This is a vanilla
> 6.12.4 kernel, with a Radeon RX6600 graphics card.

That was caused by this commit:

commit 746ae46c11137ba21f0c0c68f082a9d8c1222c78
Author: Matthew Brost <matthew.brost@intel.com>
Date:   Wed Oct 23 16:59:17 2024 -0700

    drm/sched: Mark scheduler work queues with WQ_MEM_RECLAIM

    drm_gpu_scheduler.submit_wq is used to submit jobs, jobs are in the pat=
h
    of dma-fences, and dma-fences are in the path of reclaim. Mark schedule=
r
    work queue with WQ_MEM_RECLAIM to ensure forward progress during
    reclaim; without WQ_MEM_RECLAIM, work queues cannot make forward
    progress during reclaim.

However, after further discussion, I think the warning is actually a
false positive.  See this discussion:
https://lists.freedesktop.org/archives/amd-gfx/2024-November/117349.html

From the thread:
"Question is - does check_flush_dependency() need to skip the
!WQ_MEM_RECLAIM flushing WQ_MEM_RECLAIM warning *if* the work is already
running *and* it was called from cancel_delayed_work_sync()?"

Thanks,

Alex


>
> Cheers,
> Chris
>
> [ 4624.741148] ------------[ cut here ]------------
> [ 4624.744474] workqueue: WQ_MEM_RECLAIM sdma0:drm_sched_run_job_work
> [gpu_sched] is flushing !WQ_MEM_RECLAIM
> events:amdgpu_device_delay_enable_gfx_off [amdgpu]
> [ 4624.744942] WARNING: CPU: 2 PID: 9069 at kernel/workqueue.c:3704
> check_flush_dependency+0xbe/0xd0
> [ 4624.765285] Modules linked in: snd_seq_dummy rpcrdma rdma_cm iw_cm
> ib_cm ib_core af_packet nf_conntrack_netbios_ns nf_conntrack_broadcast
> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
> nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat
> ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_raw
> ip6table_security iptable_nat iptable_mangle iptable_raw
> iptable_security nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 nf_tables libcrc32c ebtable_filter
> ebtables ip6table_filter ip6_tables iptable_filter ip_tables x_tables
> bnep it87 hwmon_vid binfmt_misc snd_hda_codec_realtek
> snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_scodec_component
> snd_hda_intel uvcvideo btusb uvc videobuf2_vmalloc btintel
> videobuf2_memops videobuf2_v4l2 videodev btbcm snd_usb_audio bluetooth
> snd_intel_dspcfg intel_powerclamp snd_hda_codec videobuf2_common
> coretemp snd_virtuoso snd_usbmidi_lib snd_oxygen_lib snd_ctl_led
> kvm_intel input_leds mc snd_hwdep led_class snd_mpu401_uart
> [ 4624.765400]  snd_hda_core joydev snd_rawmidi rfkill kvm snd_seq
> snd_seq_device gpio_ich snd_pcm pktcdvd iTCO_wdt snd_hrtimer r8169
> snd_timer intel_cstate realtek snd mdio_devres intel_uncore libphy
> i2c_i801 soundcore lpc_ich tiny_power_button mxm_wmi i7core_edac
> acpi_cpufreq i2c_smbus pcspkr button nfsd auth_rpcgss nfs_acl lockd
> grace dm_mod fuse sunrpc loop configfs dax nfnetlink zram zsmalloc
> ext4 crc32c_generic mbcache jbd2 amdgpu video amdxcp i2c_algo_bit
> mfd_core drm_ttm_helper ttm drm_exec gpu_sched hid_microsoft
> drm_suballoc_helper drm_buddy drm_display_helper drm_kms_helper usbhid
> sr_mod sd_mod cdrom drm pata_jmicron ahci libahci uhci_hcd xhci_pci
> libata ehci_pci ehci_hcd xhci_hcd scsi_mod firewire_ohci psmouse
> firewire_core usbcore crc32c_intel sha512_ssse3 sha256_ssse3 bsg
> serio_raw sha1_ssse3 drm_panel_orientation_quirks scsi_common crc16
> usb_common crc_itu_t wmi msr gf128mul crypto_simd cryptd
> [ 4624.932496] CPU: 2 UID: 0 PID: 9069 Comm: kworker/u32:3 Tainted: G
>         I        6.12.4 #1
> [ 4624.939803] Tainted: [I]=3DFIRMWARE_WORKAROUND
> [ 4624.942773] Hardware name: Gigabyte Technology Co., Ltd.
> EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
> [ 4624.950340] Workqueue: sdma0 drm_sched_run_job_work [gpu_sched]
> [ 4624.954967] RIP: 0010:check_flush_dependency+0xbe/0xd0
> [ 4624.958806] Code: 75 2a 48 8b 55 18 48 8d 8b c8 00 00 00 4d 89 e0
> 48 81 c6 c8 00 00 00 48 c7 c7 1b d6 e9 81 c6 05 a3 5f 56 01 01 e8 32
> 30 fe ff <0f> 0b 5b 5d 41 5c c3 cc cc cc cc 0f 1f 80 00 00 00 00 90 90
> 90 90
> [ 4624.976253] RSP: 0018:ffffc9000bec7c88 EFLAGS: 00010086
> [ 4624.980177] RAX: 0000000000000000 RBX: ffff888100118000 RCX: 000000000=
0000027
> [ 4624.986003] RDX: 0000000000000003 RSI: ffffffff81eab2b9 RDI: 00000000f=
fffffff
> [ 4624.991835] RBP: ffff888155daa900 R08: 0000000000000000 R09: 7067646d6=
1006600
> [ 4624.997668] R10: 0000000000000091 R11: fefefefefefefeff R12: ffffffffa=
05ec880
> [ 4625.003501] R13: 0000000000000001 R14: ffff88810011c600 R15: ffff88816=
3600000
> [ 4625.009334] FS:  0000000000000000(0000) GS:ffff888343c80000(0000)
> knlGS:0000000000000000
> [ 4625.016118] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4625.020555] CR2: 0000000099837000 CR3: 0000000144e4c000 CR4: 000000000=
00026f0
> [ 4625.026381] Call Trace:
> [ 4625.027525]  <TASK>
> [ 4625.028323]  ? __warn+0x90/0x120
> [ 4625.030255]  ? report_bug+0xe2/0x160
> [ 4625.032532]  ? check_flush_dependency+0xbe/0xd0
> [ 4625.035768]  ? handle_bug+0x53/0x80
> [ 4625.037959]  ? exc_invalid_op+0x13/0x60
> [ 4625.040499]  ? asm_exc_invalid_op+0x16/0x20
> [ 4625.043384]  ? __pfx_amdgpu_device_delay_enable_gfx_off+0x10/0x10 [amd=
gpu]
> [ 4625.049366]  ? check_flush_dependency+0xbe/0xd0
> [ 4625.052598]  ? check_flush_dependency+0xbe/0xd0
> [ 4625.055830]  __flush_work+0xb2/0x1f0
> [ 4625.058109]  ? work_grab_pending+0x3f/0x120
> [ 4625.060996]  ? set_work_pool_and_clear_pending+0x14/0x20
> [ 4625.065008]  ? __cancel_work+0x89/0xc0
> [ 4625.067460]  __cancel_work_sync+0x4a/0x70
> [ 4625.070173]  amdgpu_gfx_off_ctrl+0xa6/0x100 [amdgpu]
> [ 4625.074231]  amdgpu_ring_alloc+0x52/0x60 [amdgpu]
> [ 4625.077974]  amdgpu_ib_schedule+0x155/0x640 [amdgpu]
> [ 4625.081988]  amdgpu_job_run+0xda/0x140 [amdgpu]
> [ 4625.085663]  drm_sched_run_job_work+0x246/0x310 [gpu_sched]
> [ 4625.089935]  process_scheduled_works+0x19c/0x2c0
> [ 4625.093252]  worker_thread+0x13b/0x1c0
> [ 4625.095706]  ? __pfx_worker_thread+0x10/0x10
> [ 4625.098678]  kthread+0xef/0x100
> [ 4625.100523]  ? __pfx_kthread+0x10/0x10
> [ 4625.102976]  ret_from_fork+0x24/0x40
> [ 4625.105256]  ? __pfx_kthread+0x10/0x10
> [ 4625.107709]  ret_from_fork_asm+0x1a/0x30
> [ 4625.110338]  </TASK>
> [ 4625.111228] ---[ end trace 0000000000000000 ]---

