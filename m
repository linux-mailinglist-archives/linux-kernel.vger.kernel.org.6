Return-Path: <linux-kernel+bounces-576520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDC5A71057
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2B41899CB3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 06:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F7617A300;
	Wed, 26 Mar 2025 06:07:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB8EA937
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742969225; cv=none; b=bUx2uC0XojA4gBI0lzSFYG5uN8/O2teRf/sReBX66l+/QwA9Bi4pi/BSCmXsECwMq/PNyguKQGMhyn0nKivp74J3kpMxqk+evw/73D/pTTDhj3UVYwlNZ+X1YSbFPYCZJosDqohA2pssB4n7JS+AJDCZxIp5tijiFvkwzU0bckc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742969225; c=relaxed/simple;
	bh=JCIXskc/UgmSo/0ghi/DrOByQZYVO5o6XVG/EsOx9cM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qMzdW+cTJQV1W5ER7oCEpipoAXpeIRyX908aq+nzM68mTv8Z0H2NlW9ZinM/vyWJMZ9UXNynXXCkeBU/23q5CqF5fbtU9PZwneGAC//hZceZ/Pw5ZLkJXJ9YKXkwL7vWuPD8I6IEHSwxK3k+Y5pSdcz94Ivx8FoxaHFNece/JEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85b48bd978cso666624639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 23:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742969223; x=1743574023;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBg0FZ0+CQr4KVb8bxwv7LZxesYgU6hMCnWeiuTM4Lg=;
        b=YZghuW00huLmQ7bDWfqI9H79PBMDPGOkt2gxlF6Dc8/C2SzQwT9SKCr1AFTeo3EaHy
         9hMZAKUHyRcwWPcI8NP24InxaQFNYhn2Uj/qsNixrxWsIi90yuonbqY3lUxHA9O5Lsrb
         9y2sTypGZDRnq02WRzCeynB9wMUuNtM4ZNEgGEfARJQ71xzmCy+I99V+T4ucTjy1+2i7
         jyYv5HyPq8BLn5JonI27jyirv08GKY8P6mnapZWmyfpsTAThZJRJOoYp8BCrR9JQEPJb
         ulV8uiqjhrEHMhHZ0fEPJake4sKrKz/d3spko8W/Pt4elifjwqCyMaS6XBSunOeW6z33
         jsvw==
X-Gm-Message-State: AOJu0Ywl96ULkWbTzJeopFrW4/yD/g5ZNq+iUbzdBjee38rEvmdJDOfM
	oUJArRkTicUgcOK9jR4SUDruW3R3BNhzpFNqehyQB3H0OSWkgcQKgki/AVXx1XD3347jNwKCHV/
	iG+2+FKx83tUvI6jRwanN8//mmzEPqXZ1ycBPdsdbkS28t3WquJVSzLo=
X-Google-Smtp-Source: AGHT+IFeET7mmcMoczSo797b4Gy7HDlALOKC4+wIc7gfUv+dbgBHP5QWpURvYGTGGeug0S9n4v4immiQQ4LidbogRQk16hpyJpNl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c8:b0:3cf:c9b9:3eb with SMTP id
 e9e14a558f8ab-3d59604716bmr193795535ab.0.1742969222789; Tue, 25 Mar 2025
 23:07:02 -0700 (PDT)
Date: Tue, 25 Mar 2025 23:07:02 -0700
In-Reply-To: <20250326052029.88818-1-richard120310@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e39986.050a0220.1ec46.0009.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_extent_crc_append
 (2)
From: syzbot <syzbot+79e4e34c2a37d5a9c1f7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, richard120310@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

 resource 6 [mem 0x000a0000-0x000bffff window]
[    6.495513][    T1] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfef=
ff window]
[    6.501758][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    6.504887][    T1] PCI: CLS 0 bytes, default 64
[    6.506086][    T1] PCI-DMA: Using software bounce buffering for IO (SWI=
OTLB)
[    6.507287][    T1] software IO TLB: mapped [mem 0x00000000bbffd000-0x00=
000000bfffd000] (64MB)
[    6.509037][    T1] ACPI: bus type thunderbolt registered
[    6.636982][    T1] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters=
, 10737418240 ms ovfl timer
[    6.670353][   T62] kworker/u8:3 (62) used greatest stack depth: 11960 b=
ytes left
[    6.759286][    T1] kvm_amd: CPU 1 isn't AMD or Hygon
[    6.760582][    T1] clocksource: tsc: mask: 0xffffffffffffffff max_cycle=
s: 0x1fb6d19e116, max_idle_ns: 440795289897 ns
[    6.794646][    T1] clocksource: Switched to clocksource tsc
[    6.878091][   T68] kworker/u8:3 (68) used greatest stack depth: 10984 b=
ytes left
[   27.136645][    T1] Initialise system trusted keyrings
[   27.147228][    T1] workingset: timestamp_bits=3D40 max_order=3D21 bucke=
t_order=3D0
[   27.158266][    T1] DLM installed
[   27.171851][    T1] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   27.191674][    T1] NFS: Registering the id_resolver key type
[   27.201479][    T1] Key type id_resolver registered
[   27.206638][    T1] Key type id_legacy registered
[   27.211801][    T1] nfs4filelayout_init: NFSv4 File Layout Driver Regist=
ering...
[   27.219506][    T1] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Drive=
r Registering...
[   27.255713][    T1] Key type cifs.spnego registered
[   27.261935][    T1] Key type cifs.idmap registered
[   27.275818][    T1] ntfs3: Enabled Linux POSIX ACLs support
[   27.281617][    T1] ntfs3: Read-only LZX/Xpress compression included
[   27.288687][    T1] efs: 1.0a - http://aeschi.ch.eu.org/efs/
[   27.294910][    T1] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[   27.300924][    T1] QNX4 filesystem 0.2.3 registered.
[   27.306398][    T1] qnx6: QNX6 filesystem 1.0.0 registered.
[   27.313873][    T1] fuse: init (API version 7.42)
[   27.324383][    T1] orangefs_debugfs_init: called with debug mask: :none=
: :0:
[   27.334304][    T1] orangefs_init: module version upstream loaded
[   27.342457][    T1] JFS: nTxBlock =3D 8192, nTxLock =3D 65536
[   27.385875][    T1] SGI XFS with ACLs, security attributes, realtime, qu=
ota, no debug enabled
[   27.411133][    T1] 9p: Installing v9fs 9p2000 file system support
[   27.418732][    T1] NILFS version 2 loaded
[   27.423157][    T1] befs: version: 0.9.3
[   27.428375][    T1] ocfs2: Registered cluster interface o2cb
[   27.435391][    T1] ocfs2: Registered cluster interface user
[   27.444097][    T1] OCFS2 User DLM kernel interface loaded
[   27.462448][    T1] gfs2: GFS2 installed
[   27.507842][    T1] ceph: loaded (mds proto 32)
[   31.665351][    T1] NET: Registered PF_ALG protocol family
[   31.671348][    T1] xor: automatically using best checksumming function =
  avx      =20
[   31.679530][    T1] async_tx: api initialized (async)
[   31.684995][    T1] Key type asymmetric registered
[   31.689997][    T1] Asymmetric key parser 'x509' registered
[   31.695886][    T1] Asymmetric key parser 'pkcs8' registered
[   31.701793][    T1] Key type pkcs7_test registered
[   31.707705][    T1] Block layer SCSI generic (bsg) driver version 0.4 lo=
aded (major 238)
[   31.717960][    T1] io scheduler mq-deadline registered
[   31.723606][    T1] io scheduler kyber registered
[   31.728949][    T1] io scheduler bfq registered
[   31.747246][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN=
:00/input/input0
[   31.764843][  T148] kworker/u8:0 (148) used greatest stack depth: 10624 =
bytes left
[   31.765789][    T1] ACPI: button: Power Button [PWRF]
[   31.785730][    T1] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN=
:00/input/input1
[   31.796004][    T1] ACPI: button: Sleep Button [SLPF]
[   31.824520][    T1] ioatdma: Intel(R) QuickData Technology Driver 5.00
[   31.910016][    T1] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[   31.917218][    T1] virtio-pci 0000:00:03.0: virtio_pci: leaving for leg=
acy driver
[   31.996381][    T1] ACPI: \_SB_.LNKD: Enabled at IRQ 10
[   32.002182][    T1] virtio-pci 0000:00:04.0: virtio_pci: leaving for leg=
acy driver
[   32.076652][    T1] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[   32.082354][    T1] virtio-pci 0000:00:06.0: virtio_pci: leaving for leg=
acy driver
[   32.138646][    T1] virtio-pci 0000:00:07.0: virtio_pci: leaving for leg=
acy driver
[   33.278040][    T1] N_HDLC line discipline registered with maxframe=3D40=
96
[   33.285257][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enab=
led
[   33.299597][    T1] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D =
115200) is a 16550A
[   33.329821][    T1] 00:04: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D =
115200) is a 16550A
[   33.362685][    T1] 00:05: ttyS2 at I/O 0x3e8 (irq =3D 6, base_baud =3D =
115200) is a 16550A
[   33.392954][    T1] 00:06: ttyS3 at I/O 0x2e8 (irq =3D 7, base_baud =3D =
115200) is a 16550A
[   33.441926][    T1] Non-volatile memory driver v1.3
[   33.452548][    T1] BUG: kernel NULL pointer dereference, address: 00000=
00000000000
[   33.457091][    T1] #PF: supervisor read access in kernel mode
[   33.463239][    T1] #PF: error_code(0x0000) - not-present page
[   33.463239][    T1] PGD 0 P4D 0=20
[   33.473453][    T1] Oops: Oops: 0000 [#1] SMP PTI
[   33.473453][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.1=
4.0-syzkaller-02665-g1e26c5e28ca5 #0 PREEMPT(undef)=20
[   33.483649][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/12/2025
[   33.493436][    T1] RIP: 0010:msix_capability_init+0x95c/0x18c0
[   33.503187][    T1] Code: ff ff ff 48 89 9d 60 fe ff ff 48 89 9d 08 ff f=
f ff 48 83 bd 30 ff ff ff 00 4c 8b 75 c8 0f 85 1d 02 00 00 48 8b bd 58 ff f=
f ff <44> 8b 27 b8 00 00 40 00 41 21 c4 e8 64 b0 ad fb 8b 18 44 8b 3a 41
[   33.523254][    T1] RSP: 0000:ffff888100642fb0 EFLAGS: 00010246
[   33.533478][    T1] RAX: ffff8880bba43080 RBX: ffffc90000b3f008 RCX: 000=
0000100243080
[   33.543208][    T1] RDX: ffff888100243080 RSI: ffff88813fffacc0 RDI: 000=
0000000000000
[   33.543208][    T1] RBP: ffff888100643178 R08: ffffea000000000f R09: 000=
0000000000000
[   33.553462][    T1] R10: ffff8880bba43020 R11: ffffffff86cfccf9 R12: 000=
0000000000000
[   33.563198][    T1] R13: 0000000000000000 R14: ffff8881408d0b58 R15: 000=
000000000000b
[   33.573526][    T1] FS:  0000000000000000(0000) GS:ffff8881ab1af000(0000=
) knlGS:0000000000000000
[   33.583232][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.583232][    T1] CR2: 0000000000000000 CR3: 0000000011a80000 CR4: 000=
00000003526f0
[   33.593463][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   33.603200][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   33.613504][    T1] Call Trace:
[   33.613504][    T1]  <TASK>
[   33.613504][    T1]  ? show_trace_log_lvl+0x268/0x3d0
[   33.623221][    T1]  ? __pci_enable_msix_range+0xad9/0xc40
[   33.623221][    T1]  ? __die_body+0xce/0x1a0
[   33.633515][    T1]  ? __die+0x20f/0x270
[   33.633515][    T1]  ? page_fault_oops+0xe58/0xfb0
[   33.643209][    T1]  ? exc_page_fault+0x56c/0x700
[   33.643209][    T1]  ? asm_exc_page_fault+0x2b/0x30
[   33.653460][    T1]  ? __pci_enable_msix_range+0xad9/0xc40
[   33.653460][    T1]  ? msix_capability_init+0x95c/0x18c0
[   33.663197][    T1]  __pci_enable_msix_range+0xad9/0xc40
[   33.673433][    T1]  ? kmsan_get_metadata+0x13e/0x1c0
[   33.673433][    T1]  ? kmsan_internal_set_shadow_origin+0x6c/0x100
[   33.683261][    T1]  pci_alloc_irq_vectors_affinity+0x111/0x3a0
[   33.683261][    T1]  vp_find_vqs_msix+0x84d/0x1560
[   33.693488][    T1]  ? kmsan_internal_unpoison_memory+0x14/0x20
[   33.703252][    T1]  vp_find_vqs+0x6c/0xa80
[   33.703252][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[   33.713473][    T1]  ? __pfx_vp_find_vqs+0x10/0x10
[   33.713473][    T1]  probe_common+0x3b4/0x970
[   33.723203][    T1]  ? __pfx_random_recv_done+0x10/0x10
[   33.723203][    T1]  ? kmsan_get_metadata+0x13e/0x1c0
[   33.733449][    T1]  virtrng_probe+0x2d/0x40
[   33.733449][    T1]  ? __pfx_virtrng_probe+0x10/0x10
[   33.743202][    T1]  virtio_dev_probe+0x1640/0x19a0
[   33.743202][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[   33.753450][    T1]  really_probe+0x4dc/0xd90
[   33.753450][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[   33.763205][    T1]  __driver_probe_device+0x2ab/0x5d0
[   33.763205][    T1]  driver_probe_device+0x72/0x890
[   33.773517][    T1]  __driver_attach+0x7ea/0xb50
[   33.773517][    T1]  bus_for_each_dev+0x350/0x540
[   33.783198][    T1]  ? __pfx___driver_attach+0x10/0x10
[   33.783198][    T1]  driver_attach+0x51/0x70
[   33.793460][    T1]  bus_add_driver+0x74c/0xdb0
[   33.793460][    T1]  driver_register+0x3fb/0x660
[   33.803198][    T1]  __register_virtio_driver+0xf1/0x120
[   33.803198][    T1]  ? __pfx_virtio_rng_driver_init+0x10/0x10
[   33.813443][    T1]  virtio_rng_driver_init+0x2e/0x40
[   33.813443][    T1]  do_one_initcall+0x228/0xbf0
[   33.823206][    T1]  ? kmsan_internal_unpoison_memory+0x14/0x20
[   33.833456][    T1]  ? __pfx_virtio_rng_driver_init+0x10/0x10
[   33.833456][    T1]  ? irqentry_enter+0x37/0x60
[   33.843203][    T1]  ? sysvec_apic_timer_interrupt+0x52/0x90
[   33.843203][    T1]  ? kmsan_get_metadata+0x13e/0x1c0
[   33.853447][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[   33.853447][    T1]  ? parse_args+0x250/0x10a0
[   33.863201][    T1]  ? kmsan_get_metadata+0x13e/0x1c0
[   33.863201][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[   33.873436][    T1]  ? kmsan_get_metadata+0x13e/0x1c0
[   33.883191][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[   33.883191][    T1]  ? parameq+0x43a/0x470
[   33.893468][    T1]  ? kmsan_get_metadata+0x13e/0x1c0
[   33.893468][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[   33.903213][    T1]  ? parse_args+0xfde/0x10a0
[   33.903213][    T1]  ? kmsan_get_metadata+0x13e/0x1c0
[   33.913423][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[   33.913423][    T1]  ? __pfx_virtio_rng_driver_init+0x10/0x10
[   33.923210][    T1]  do_initcall_level+0x140/0x350
[   33.923210][    T1]  do_initcalls+0x1a6/0x2f0
[   33.933438][    T1]  ? __pfx_native_smp_prepare_cpus+0x10/0x10
[   33.933438][    T1]  do_basic_setup+0x22/0x30
[   33.943199][    T1]  kernel_init_freeable+0x306/0x4c0
[   33.943199][    T1]  ? __pfx_kernel_init+0x10/0x10
[   33.953446][    T1]  kernel_init+0x2f/0x800
[   33.953446][    T1]  ? __pfx_kernel_init+0x10/0x10
[   33.963216][    T1]  ret_from_fork+0x6d/0x90
[   33.963216][    T1]  ? __pfx_kernel_init+0x10/0x10
[   33.973457][    T1]  ret_from_fork_asm+0x1a/0x30
[   33.973457][    T1] RIP: 1f0f:0x0
[   33.983207][    T1] Code: Unable to access opcode bytes at 0xfffffffffff=
fffd6.
[   33.983207][    T1] RSP: 0000:0000000000000000 EFLAGS: 841f0f2e66 ORIG_R=
AX: 1f0f2e6600000000
[   33.993440][    T1] RAX: 0000000000000000 RBX: 1f0f2e6600000000 RCX: 2e6=
6000000000084
[   34.003216][    T1] RDX: 0000000000841f0f RSI: 000000841f0f2e66 RDI: 008=
41f0f2e660000
[   34.013476][    T1] RBP: 00841f0f2e660000 R08: 00841f0f2e660000 R09: 000=
000841f0f2e66
[   34.023629][    T1] R10: 0000000000841f0f R11: 2e66000000000084 R12: 000=
000841f0f2e66
[   34.033521][    T1] R13: 0000000000841f0f R14: 2e66000000000084 R15: 1f0=
f2e6600000000
[   34.033521][    T1]  </TASK>
[   34.043206][    T1] Modules linked in:
[   34.043206][    T1] CR2: 0000000000000000
[   34.053458][    T1] ---[ end trace 0000000000000000 ]---
[   34.053458][    T1] RIP: 0010:msix_capability_init+0x95c/0x18c0
[   34.063202][    T1] Code: ff ff ff 48 89 9d 60 fe ff ff 48 89 9d 08 ff f=
f ff 48 83 bd 30 ff ff ff 00 4c 8b 75 c8 0f 85 1d 02 00 00 48 8b bd 58 ff f=
f ff <44> 8b 27 b8 00 00 40 00 41 21 c4 e8 64 b0 ad fb 8b 18 44 8b 3a 41
[   34.083216][    T1] RSP: 0000:ffff888100642fb0 EFLAGS: 00010246
[   34.083216][    T1] RAX: ffff8880bba43080 RBX: ffffc90000b3f008 RCX: 000=
0000100243080
[   34.093530][    T1] RDX: ffff888100243080 RSI: ffff88813fffacc0 RDI: 000=
0000000000000
[   34.103207][    T1] RBP: ffff888100643178 R08: ffffea000000000f R09: 000=
0000000000000
[   34.113459][    T1] R10: ffff8880bba43020 R11: ffffffff86cfccf9 R12: 000=
0000000000000
[   34.123215][    T1] R13: 0000000000000000 R14: ffff8881408d0b58 R15: 000=
000000000000b
[   34.123215][    T1] FS:  0000000000000000(0000) GS:ffff8881ab1af000(0000=
) knlGS:0000000000000000
[   34.133434][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.143193][    T1] CR2: 0000000000000000 CR3: 0000000011a80000 CR4: 000=
00000003526f0
[   34.153460][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   34.163201][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   34.163201][    T1] Kernel panic - not syncing: Fatal exception
[   34.173464][    T1] Kernel Offset: disabled
[   34.173464][    T1] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod/golang.org/toolchain@v0.0.=
1-go1.23.6.linux-amd64'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod/golang.org/toolchain@v0=
.0.1-go1.23.6.linux-amd64/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.23.6'
GODEBUG=3D''
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build2885475109=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at c390174278
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dc3901742785ff25afdc6f470af7b25b69d7c4f2f -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20250301-144328'" -o ./b=
in/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"c3901742785ff25afdc6f470af7b25b69d=
7c4f2f\"
/usr/bin/ld: /tmp/cc7cQtNk.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D11819804580000


Tested on:

commit:         1e26c5e2 Merge tag 'media/v6.15-1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D13e82dcb2b60127=
4
dashboard link: https://syzkaller.appspot.com/bug?extid=3D79e4e34c2a37d5a9c=
1f7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.

