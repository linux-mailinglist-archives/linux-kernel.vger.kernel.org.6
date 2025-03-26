Return-Path: <linux-kernel+bounces-576481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D6FA70FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 05:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8549E3B4923
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CA317A2EA;
	Wed, 26 Mar 2025 04:15:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E87175D5D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 04:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742962504; cv=none; b=daV3UbFycnOHAave5kEDauxxLCtKk2NQqJ4+X4UFrzW5LYNZOsq5G9iFNQynaKv5DcOE3TAFAD0YErAAvXhUwl/x2m8F5RdSPHsqcKUNoMA/XXd2/Nmzq94w08NsjL5tBV0R5kM1GtjehilatiGk7usaT1headikWxxJoZJckcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742962504; c=relaxed/simple;
	bh=VL9KVpKOVUmg6/BaKCLhDVj12w3kAjVyYhZz2/BF6ic=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AAuuDCDEp/DqXUR2Vfo7h52uBQaQi1VrZIu43WGyOoJWWt5f8ZT7CynLAD1Bx0/8odtJozy0atA27RUv26rQJ6ZhVck9rgJcPDU9ynakQrHTOJ6/IsNpju/h1YQ/XHrsKEaOxu1SnTdI1oQc6siM+fzBRGdOgrKK4hZ1M1k6QSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d4423d0c49so47647715ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742962502; x=1743567302;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2I3Fb6qiR7zOXdaCrazzVmtFvDz8gEW+jVCClFzM9U=;
        b=xHznkQA+sTMrozMiv8UcFCVIiJKFZb7L+IsppAHT2oh+pWXEDmvCBkHiQ5dHfsU4nk
         xPllShtvSiiT2M18Z8HcjLPnQg+5hR2BHBcJKDpk0aAQIyldrm3OIWlgUFIp0fej/pjX
         toruqv5EecSLST2oTtsHozYQ4h64DWttbupDQsVMTaMIikrRhPTS1fQmlY27WTYvvUTh
         9fe9YhsgaQWiBnjGPQafGDv8xCmjSxeuhl/wLlynjSeOfmbYC/ORMB9DBV3md/hnwHOh
         b88TAjIchhsLz3dNyhXqnyWp7xWudkNrzru3O03+GmwGaqf+wN4ijv/v3Sw4z3t/2jPr
         KSMg==
X-Gm-Message-State: AOJu0YxstiImnKrNkKBAoIJwNVGfxEhLX7zVlRY4Ta80VsZZ0iwvHWWw
	q7KgTbiXfZlejNyyuOOfSlqZ5bYoMMR8gRcmPzrHOrboJyo43d7oTWtatQ27lBQ7Yy0J7OXOTCr
	/Bl6Z1026l0MctB69ckMsX5f+aUAWm7F0YRjY5DtCMEbTczzv2ejTtT0=
X-Google-Smtp-Source: AGHT+IHQIJEGScyj+NaivoyxE+/5QtuHecMzxMi0QsDcn6pVVseHF/KrdyvYjvkIHsL9VGXe/sXlz300tkWkyrxi95FYYz53Hrqz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fed:b0:3d3:e2a1:1f23 with SMTP id
 e9e14a558f8ab-3d596185db9mr224668125ab.20.1742962501717; Tue, 25 Mar 2025
 21:15:01 -0700 (PDT)
Date: Tue, 25 Mar 2025 21:15:01 -0700
In-Reply-To: <20250326032012.83642-1-richard120310@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e37f45.050a0220.a7ebc.0059.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in _find_next_bit
From: syzbot <syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, richard120310@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

transport module.
[    6.590030][    T1] NET: Registered PF_XDP protocol family
[    6.591410][    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 windo=
w]
[    6.592986][    T1] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff windo=
w]
[    6.594741][    T1] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bff=
ff window]
[    6.596233][    T1] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfef=
ff window]
[    6.602638][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    6.605956][    T1] PCI: CLS 0 bytes, default 64
[    6.607860][    T1] PCI-DMA: Using software bounce buffering for IO (SWI=
OTLB)
[    6.610273][    T1] software IO TLB: mapped [mem 0x00000000bbffd000-0x00=
000000bfffd000] (64MB)
[    6.613162][    T1] ACPI: bus type thunderbolt registered
[    6.737939][    T1] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters=
, 10737418240 ms ovfl timer
[    6.770832][   T62] kworker/u8:3 (62) used greatest stack depth: 11960 b=
ytes left
[    6.867316][    T1] kvm_amd: CPU 1 isn't AMD or Hygon
[    6.868703][    T1] clocksource: tsc: mask: 0xffffffffffffffff max_cycle=
s: 0x1fb6fb5cc36, max_idle_ns: 440795309794 ns
[    6.903230][    T1] clocksource: Switched to clocksource tsc
[    6.980617][   T65] kworker/u8:1 (65) used greatest stack depth: 10624 b=
ytes left
[   28.032797][    T1] Initialise system trusted keyrings
[   28.042630][    T1] workingset: timestamp_bits=3D40 max_order=3D21 bucke=
t_order=3D0
[   28.054020][    T1] DLM installed
[   28.068719][    T1] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   28.092968][    T1] NFS: Registering the id_resolver key type
[   28.099227][    T1] Key type id_resolver registered
[   28.104418][    T1] Key type id_legacy registered
[   28.109851][    T1] nfs4filelayout_init: NFSv4 File Layout Driver Regist=
ering...
[   28.118200][    T1] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Drive=
r Registering...
[   28.152197][    T1] Key type cifs.spnego registered
[   28.158513][    T1] Key type cifs.idmap registered
[   28.171052][    T1] ntfs3: Enabled Linux POSIX ACLs support
[   28.177056][    T1] ntfs3: Read-only LZX/Xpress compression included
[   28.184143][    T1] efs: 1.0a - http://aeschi.ch.eu.org/efs/
[   28.190393][    T1] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[   28.196835][    T1] QNX4 filesystem 0.2.3 registered.
[   28.202341][    T1] qnx6: QNX6 filesystem 1.0.0 registered.
[   28.209765][    T1] fuse: init (API version 7.42)
[   28.220628][    T1] orangefs_debugfs_init: called with debug mask: :none=
: :0:
[   28.229581][    T1] orangefs_init: module version upstream loaded
[   28.237636][    T1] JFS: nTxBlock =3D 8192, nTxLock =3D 65536
[   28.279418][    T1] SGI XFS with ACLs, security attributes, realtime, qu=
ota, no debug enabled
[   28.305216][    T1] 9p: Installing v9fs 9p2000 file system support
[   28.312653][    T1] NILFS version 2 loaded
[   28.317099][    T1] befs: version: 0.9.3
[   28.322254][    T1] ocfs2: Registered cluster interface o2cb
[   28.329520][    T1] ocfs2: Registered cluster interface user
[   28.336965][    T1] OCFS2 User DLM kernel interface loaded
[   28.355938][    T1] gfs2: GFS2 installed
[   28.404424][    T1] ceph: loaded (mds proto 32)
[   32.490559][    T1] NET: Registered PF_ALG protocol family
[   32.496806][    T1] xor: automatically using best checksumming function =
  avx      =20
[   32.505203][    T1] async_tx: api initialized (async)
[   32.510582][    T1] Key type asymmetric registered
[   32.515739][    T1] Asymmetric key parser 'x509' registered
[   32.521552][    T1] Asymmetric key parser 'pkcs8' registered
[   32.527609][    T1] Key type pkcs7_test registered
[   32.534059][    T1] Block layer SCSI generic (bsg) driver version 0.4 lo=
aded (major 238)
[   32.544358][    T1] io scheduler mq-deadline registered
[   32.550218][    T1] io scheduler kyber registered
[   32.555723][    T1] io scheduler bfq registered
[   32.573258][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN=
:00/input/input0
[   32.593674][    T1] ACPI: button: Power Button [PWRF]
[   32.601364][    T1] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN=
:00/input/input1
[   32.611866][    T1] ACPI: button: Sleep Button [SLPF]
[   32.639617][    T1] ioatdma: Intel(R) QuickData Technology Driver 5.00
[   32.729614][    T1] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[   32.737060][    T1] virtio-pci 0000:00:03.0: virtio_pci: leaving for leg=
acy driver
[   32.814037][    T1] ACPI: \_SB_.LNKD: Enabled at IRQ 10
[   32.819840][    T1] virtio-pci 0000:00:04.0: virtio_pci: leaving for leg=
acy driver
[   32.894636][    T1] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[   32.900546][    T1] virtio-pci 0000:00:06.0: virtio_pci: leaving for leg=
acy driver
[   32.957220][    T1] virtio-pci 0000:00:07.0: virtio_pci: leaving for leg=
acy driver
[   34.110401][    T1] N_HDLC line discipline registered with maxframe=3D40=
96
[   34.118652][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enab=
led
[   34.130570][    T1] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D =
115200) is a 16550A
[   34.165230][    T1] 00:04: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D =
115200) is a 16550A
[   34.192689][    T1] 00:05: ttyS2 at I/O 0x3e8 (irq =3D 6, base_baud =3D =
115200) is a 16550A
[   34.223638][    T1] 00:06: ttyS3 at I/O 0x2e8 (irq =3D 7, base_baud =3D =
115200) is a 16550A
[   34.274886][    T1] Non-volatile memory driver v1.3
[   34.286192][    T1] BUG: kernel NULL pointer dereference, address: 00000=
00000000000
[   34.294136][    T1] #PF: supervisor read access in kernel mode
[   34.294504][    T1] #PF: error_code(0x0000) - not-present page
[   34.294504][    T1] PGD 0 P4D 0=20
[   34.294504][    T1] Oops: Oops: 0000 [#1] SMP PTI
[   34.294504][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.1=
4.0-syzkaller-02121-g47618bc87540 #0 PREEMPT(undef)=20
[   34.294504][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/12/2025
[   34.334927][    T1] RIP: 0010:msix_capability_init+0x95c/0x18c0
[   34.334927][    T1] Code: ff ff ff 48 89 9d 60 fe ff ff 48 89 9d 08 ff f=
f ff 48 83 bd 30 ff ff ff 00 4c 8b 75 c8 0f 85 1d 02 00 00 48 8b bd 58 ff f=
f ff <44> 8b 27 b8 00 00 40 00 41 21 c4 e8 e4 a8 ad fb 8b 18 44 8b 3a 41
[   34.334927][    T1] RSP: 0000:ffff888100642fb0 EFLAGS: 00010246
[   34.334927][    T1] RAX: ffff8880bba43080 RBX: ffffc90000b3f008 RCX: 000=
0000100243080
[   34.334927][    T1] RDX: ffff888100243080 RSI: ffff88813fffacc0 RDI: 000=
0000000000000
[   34.384959][    T1] RBP: ffff888100643178 R08: ffffea000000000f R09: 000=
0000000000000
[   34.384959][    T1] R10: ffff8880bba43020 R11: 00000000abcd0100 R12: 000=
0000000000000
[   34.384959][    T1] R13: 0000000000000000 R14: ffff8881408d0b58 R15: 000=
000000000000b
[   34.384959][    T1] FS:  0000000000000000(0000) GS:ffff8881ab1b0000(0000=
) knlGS:0000000000000000
[   34.384959][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.384959][    T1] CR2: 0000000000000000 CR3: 0000000011a80000 CR4: 000=
00000003526f0
[   34.384959][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   34.434955][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   34.434955][    T1] Call Trace:
[   34.434955][    T1]  <TASK>
[   34.434955][    T1]  ? show_trace_log_lvl+0x268/0x3d0
[   34.434955][    T1]  ? __pci_enable_msix_range+0xad9/0xc40
[   34.434955][    T1]  ? __die_body+0xce/0x1a0
[   34.434955][    T1]  ? __die+0x20f/0x270
[   34.434955][    T1]  ? page_fault_oops+0xe58/0xfb0
[   34.434955][    T1]  ? exc_page_fault+0x56c/0x700
[   34.484952][    T1]  ? asm_exc_page_fault+0x2b/0x30
[   34.484952][    T1]  ? msix_capability_init+0x95c/0x18c0
[   34.484952][    T1]  __pci_enable_msix_range+0xad9/0xc40
[   34.484952][    T1]  ? kmsan_get_metadata+0x13e/0x1c0
[   34.484952][    T1]  ? kmsan_internal_set_shadow_origin+0x6c/0x100
[   34.484952][    T1]  pci_alloc_irq_vectors_affinity+0x111/0x3a0
[   34.484952][    T1]  vp_find_vqs_msix+0x84d/0x1560
[   34.484952][    T1]  ? kmsan_internal_unpoison_memory+0x14/0x20
[   34.484952][    T1]  vp_find_vqs+0x6c/0xa80
[   34.534964][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[   34.534964][    T1]  ? __pfx_vp_find_vqs+0x10/0x10
[   34.534964][    T1]  probe_common+0x3b4/0x970
[   34.534964][    T1]  ? __pfx_random_recv_done+0x10/0x10
[   34.534964][    T1]  ? kmsan_get_metadata+0x13e/0x1c0
[   34.534964][    T1]  virtrng_probe+0x2d/0x40
[   34.534964][    T1]  ? __pfx_virtrng_probe+0x10/0x10
[   34.534964][    T1]  virtio_dev_probe+0x1640/0x19a0
[   34.534964][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[   34.584963][    T1]  really_probe+0x4dc/0xd90
[   34.584963][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[   34.584963][    T1]  __driver_probe_device+0x2ab/0x5d0
[   34.584963][    T1]  driver_probe_device+0x72/0x890
[   34.584963][    T1]  __driver_attach+0x7ea/0xb50
[   34.584963][    T1]  bus_for_each_dev+0x350/0x540
[   34.584963][    T1]  ? __pfx___driver_attach+0x10/0x10
[   34.584963][    T1]  driver_attach+0x51/0x70
[   34.584963][    T1]  bus_add_driver+0x74c/0xdb0
[   34.584963][    T1]  driver_register+0x3fb/0x660
[   34.635200][    T1]  __register_virtio_driver+0xf1/0x120
[   34.635200][    T1]  ? __pfx_virtio_rng_driver_init+0x10/0x10
[   34.635200][    T1]  virtio_rng_driver_init+0x2e/0x40
[   34.635200][    T1]  do_one_initcall+0x228/0xbf0
[   34.635200][    T1]  ? irqentry_enter+0x37/0x60
[   34.635200][    T1]  ? __pfx_virtio_rng_driver_init+0x10/0x10
[   34.635200][    T1]  ? sysvec_call_function_single+0x30/0x90
[   34.635200][    T1]  ? kmsan_get_metadata+0x13e/0x1c0
[   34.635200][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[   34.684997][    T1]  ? kmsan_get_metadata+0x13e/0x1c0
[   34.684997][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[   34.684997][    T1]  ? kmsan_get_metadata+0x13e/0x1c0
[   34.684997][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[   34.684997][    T1]  ? parameq+0x43a/0x470
[   34.684997][    T1]  ? kmsan_get_metadata+0x13e/0x1c0
[   34.684997][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[   34.684997][    T1]  ? parse_args+0xfde/0x10a0
[   34.684997][    T1]  ? kmsan_get_metadata+0x13e/0x1c0
[   34.734934][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[   34.734934][    T1]  ? __pfx_virtio_rng_driver_init+0x10/0x10
[   34.734934][    T1]  do_initcall_level+0x140/0x350
[   34.734934][    T1]  do_initcalls+0x1a6/0x2f0
[   34.734934][    T1]  ? __pfx_native_smp_prepare_cpus+0x10/0x10
[   34.734934][    T1]  do_basic_setup+0x22/0x30
[   34.734934][    T1]  kernel_init_freeable+0x306/0x4c0
[   34.734934][    T1]  ? __pfx_kernel_init+0x10/0x10
[   34.734934][    T1]  kernel_init+0x2f/0x800
[   34.734934][    T1]  ? __pfx_kernel_init+0x10/0x10
[   34.784962][    T1]  ret_from_fork+0x6d/0x90
[   34.784962][    T1]  ? __pfx_kernel_init+0x10/0x10
[   34.784962][    T1]  ret_from_fork_asm+0x1a/0x30
[   34.784962][    T1] RIP: 1f0f:0x0
[   34.784962][    T1] Code: Unable to access opcode bytes at 0xfffffffffff=
fffd6.
[   34.784962][    T1] RSP: 0000:0000000000000000 EFLAGS: 841f0f2e66 ORIG_R=
AX: 1f0f2e6600000000
[   34.784962][    T1] RAX: 0000000000000000 RBX: 1f0f2e6600000000 RCX: 2e6=
6000000000084
[   34.784962][    T1] RDX: 0000000000841f0f RSI: 000000841f0f2e66 RDI: 008=
41f0f2e660000
[   34.834921][    T1] RBP: 00841f0f2e660000 R08: 00841f0f2e660000 R09: 000=
000841f0f2e66
[   34.834921][    T1] R10: 0000000000841f0f R11: 2e66000000000084 R12: 000=
000841f0f2e66
[   34.834921][    T1] R13: 0000000000841f0f R14: 2e66000000000084 R15: 1f0=
f2e6600000000
[   34.834921][    T1]  </TASK>
[   34.834921][    T1] Modules linked in:
[   34.834921][    T1] CR2: 0000000000000000
[   34.834921][    T1] ---[ end trace 0000000000000000 ]---
[   34.834921][    T1] RIP: 0010:msix_capability_init+0x95c/0x18c0
[   34.884997][    T1] Code: ff ff ff 48 89 9d 60 fe ff ff 48 89 9d 08 ff f=
f ff 48 83 bd 30 ff ff ff 00 4c 8b 75 c8 0f 85 1d 02 00 00 48 8b bd 58 ff f=
f ff <44> 8b 27 b8 00 00 40 00 41 21 c4 e8 e4 a8 ad fb 8b 18 44 8b 3a 41
[   34.884997][    T1] RSP: 0000:ffff888100642fb0 EFLAGS: 00010246
[   34.884997][    T1] RAX: ffff8880bba43080 RBX: ffffc90000b3f008 RCX: 000=
0000100243080
[   34.884997][    T1] RDX: ffff888100243080 RSI: ffff88813fffacc0 RDI: 000=
0000000000000
[   34.884997][    T1] RBP: ffff888100643178 R08: ffffea000000000f R09: 000=
0000000000000
[   34.934980][    T1] R10: ffff8880bba43020 R11: 00000000abcd0100 R12: 000=
0000000000000
[   34.934980][    T1] R13: 0000000000000000 R14: ffff8881408d0b58 R15: 000=
000000000000b
[   34.934980][    T1] FS:  0000000000000000(0000) GS:ffff8881ab1b0000(0000=
) knlGS:0000000000000000
[   34.934980][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.934980][    T1] CR2: 0000000000000000 CR3: 0000000011a80000 CR4: 000=
00000003526f0
[   34.934980][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   34.984958][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   34.984958][    T1] Kernel panic - not syncing: Fatal exception
[   34.984958][    T1] Kernel Offset: disabled
[   34.984958][    T1] Rebooting in 86400 seconds..


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
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/syzkaller/jobs/linux/gopath/pkg/mod/golang.org/toolchain@v0.0.1-=
go1.23.6.linux-amd64'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/syzkaller/jobs/linux/gopath/pkg/mod/golang.org/toolchain@v0.0=
.1-go1.23.6.linux-amd64/pkg/tool/linux_amd64'
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
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build622590353=3D/tmp/go-build -gno-record-gcc=
-switches'

git status (err=3D<nil>)
HEAD detached at 22a6c2b1752
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
/syzkaller/prog.GitRevision=3D22a6c2b1752ef57d8d612e233d35f6be8c3bf7df -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20250318-101307'" -o ./b=
in/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"22a6c2b1752ef57d8d612e233d35f6be8c=
3bf7df\"
/usr/bin/ld: /tmp/cc2MzyaW.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D14fe0a4c580000


Tested on:

commit:         47618bc8 Merge tag 'spi-v6.15' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6db78484161f973=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3D7ea0b96c4ddb49fd1=
a70
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.

