Return-Path: <linux-kernel+bounces-576431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3201BA70F27
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200B43AB391
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 02:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D537129A78;
	Wed, 26 Mar 2025 02:43:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3F23D6F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 02:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742956985; cv=none; b=H4/hFcifn/0loAj9T+MgpjJiMe9FF4tu5sqBvJk3f+2kjZTcrl0uC8WcmXfA9jKBnTub5YXFr5TjHG0FnTFBx27cJWnbvSzGc4Q3E9908sROzn9rtcnegd23fge+Idc6dZFj8w0EsMeKdyZ0KaJE6EPN+15O9hCGYjvrvveBb28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742956985; c=relaxed/simple;
	bh=6APY7jnpXVbE3kVslyQY5khmIaFEUbRBCulfmoeO5gM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NNPfUZiyBSn/2vrNNi9hrTf9oagTlJmqDUve7QEK2JNZRRWTqRHS6YVQSF2mHuE6SEWMRJLDVlMILOtgs0lzfL8fxhY3JkCFljbtm1+5VfLmocu9MQj75aQ7zpvUUD8BGhzUIbjFxO2dx3O3461x3HgPgeGSU5U8a0C6YDgegD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85b3a6c37e2so665535839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742956982; x=1743561782;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sX8mpJPpI043L6+3dwCJM9mFzxl5RCqu5al8okhVkaU=;
        b=IfCudCa+JxQHXf3ViNiD5YcL1F3WnAIqdlIjx8vl7TM95sWvY4vzbzkNYzdeRHcshe
         T8Mqp7AtwN9/Ha5RactX+n4V0Azy88QNhtYOg1P1YVuwOIeH7049wavzzj5U0cgRbJzW
         dTTaOIcqYbsdRTUpF4G1V1z8gR6Tf2ITIXdaCW3D1BgFkKy7mQ/vrTX34T7XktE+y1r6
         rmN+AnAhILQySL8om61AM1VWOl5isx8xNz3Lvyya+lxsOVIHzHboRiqiecX7mTGYbw4B
         8qEi+XRX39GFeUH9+DAb9BzfBz7VPkmtWznP8SG2LckUEcET6l0zqbPFNXdAH9GcxEyu
         j+9g==
X-Gm-Message-State: AOJu0Ywmyx7Woh7+Fu/2s/ohnMDxfHgbde9FTxh3t8vdirxoxstF1l5L
	afXnsrpY03STImCc/pXr7YuhQFYZhKirq/Vn6VCX2jkpROYquJmteAr3iIGWiKPHrHVWz7vZG43
	nvReOIkTafNrITJ04nnLWJz6RC1tlv2aohTYYxrUviB/iGpl4L3Whzr4=
X-Google-Smtp-Source: AGHT+IHRZ1ZxBixGHFQf3A26Yg7li0/Z0Fvw6yx8cfbnHwBMi+Gf3tJGmRn8DjbpzZ/kwNZ3d9VfD39x/HrPcN2TwqDWwnnZ0CuO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3207:b0:3d3:dece:3dab with SMTP id
 e9e14a558f8ab-3d5960cd012mr191184065ab.1.1742956982510; Tue, 25 Mar 2025
 19:43:02 -0700 (PDT)
Date: Tue, 25 Mar 2025 19:43:02 -0700
In-Reply-To: <20250326021914.49794-1-richard120310@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e369b6.050a0220.1ec46.0005.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in _find_next_bit
From: syzbot <syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, richard120310@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

d00-0xffff window]
[    6.656788][    T1] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bff=
ff window]
[    6.658493][    T1] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfef=
ff window]
[    6.665366][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    6.668676][    T1] PCI: CLS 0 bytes, default 64
[    6.670292][    T1] PCI-DMA: Using software bounce buffering for IO (SWI=
OTLB)
[    6.672676][    T1] software IO TLB: mapped [mem 0x00000000bbffd000-0x00=
000000bfffd000] (64MB)
[    6.675325][    T1] ACPI: bus type thunderbolt registered
[    6.803712][    T1] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters=
, 10737418240 ms ovfl timer
[    6.838838][   T62] kworker/u8:3 (62) used greatest stack depth: 11960 b=
ytes left
[    6.921338][   T61] kworker/u8:3 (61) used greatest stack depth: 10624 b=
ytes left
[    6.950433][    T1] kvm_amd: CPU 0 isn't AMD or Hygon
[    6.951845][    T1] clocksource: tsc: mask: 0xffffffffffffffff max_cycle=
s: 0x1fb6ebe4598, max_idle_ns: 440795211488 ns
[    7.032367][    T1] clocksource: Switched to clocksource tsc
[   28.149270][    T1] Initialise system trusted keyrings
[   28.159166][    T1] workingset: timestamp_bits=3D40 max_order=3D21 bucke=
t_order=3D0
[   28.170925][    T1] DLM installed
[   28.184821][    T1] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   28.206648][    T1] NFS: Registering the id_resolver key type
[   28.213155][    T1] Key type id_resolver registered
[   28.219287][    T1] Key type id_legacy registered
[   28.224463][    T1] nfs4filelayout_init: NFSv4 File Layout Driver Regist=
ering...
[   28.233124][    T1] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Drive=
r Registering...
[   28.270691][    T1] Key type cifs.spnego registered
[   28.277562][    T1] Key type cifs.idmap registered
[   28.290673][    T1] ntfs3: Enabled Linux POSIX ACLs support
[   28.296967][    T1] ntfs3: Read-only LZX/Xpress compression included
[   28.303976][    T1] efs: 1.0a - http://aeschi.ch.eu.org/efs/
[   28.310453][    T1] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[   28.317169][    T1] QNX4 filesystem 0.2.3 registered.
[   28.322689][    T1] qnx6: QNX6 filesystem 1.0.0 registered.
[   28.330316][    T1] fuse: init (API version 7.42)
[   28.341243][    T1] orangefs_debugfs_init: called with debug mask: :none=
: :0:
[   28.350107][    T1] orangefs_init: module version upstream loaded
[   28.358335][    T1] JFS: nTxBlock =3D 8192, nTxLock =3D 65536
[   28.399230][    T1] SGI XFS with ACLs, security attributes, realtime, qu=
ota, no debug enabled
[   28.425334][    T1] 9p: Installing v9fs 9p2000 file system support
[   28.433158][    T1] NILFS version 2 loaded
[   28.437605][    T1] befs: version: 0.9.3
[   28.442821][    T1] ocfs2: Registered cluster interface o2cb
[   28.450015][    T1] ocfs2: Registered cluster interface user
[   28.457650][    T1] OCFS2 User DLM kernel interface loaded
[   28.478095][    T1] gfs2: GFS2 installed
[   28.520991][    T1] ceph: loaded (mds proto 32)
[   32.625706][    T1] NET: Registered PF_ALG protocol family
[   32.631717][    T1] xor: automatically using best checksumming function =
  avx      =20
[   32.639844][    T1] async_tx: api initialized (async)
[   32.645219][    T1] Key type asymmetric registered
[   32.650713][    T1] Asymmetric key parser 'x509' registered
[   32.656758][    T1] Asymmetric key parser 'pkcs8' registered
[   32.663044][    T1] Key type pkcs7_test registered
[   32.669091][    T1] Block layer SCSI generic (bsg) driver version 0.4 lo=
aded (major 238)
[   32.679411][    T1] io scheduler mq-deadline registered
[   32.685026][    T1] io scheduler kyber registered
[   32.690920][    T1] io scheduler bfq registered
[   32.709039][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN=
:00/input/input0
[   32.729404][    T1] ACPI: button: Power Button [PWRF]
[   32.737352][    T1] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN=
:00/input/input1
[   32.748217][    T1] ACPI: button: Sleep Button [SLPF]
[   32.774787][    T1] ioatdma: Intel(R) QuickData Technology Driver 5.00
[   32.863966][    T1] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[   32.871214][    T1] virtio-pci 0000:00:03.0: virtio_pci: leaving for leg=
acy driver
[   32.945814][    T1] ACPI: \_SB_.LNKD: Enabled at IRQ 10
[   32.951577][    T1] virtio-pci 0000:00:04.0: virtio_pci: leaving for leg=
acy driver
[   33.026375][    T1] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[   33.032191][    T1] virtio-pci 0000:00:06.0: virtio_pci: leaving for leg=
acy driver
[   33.089460][    T1] virtio-pci 0000:00:07.0: virtio_pci: leaving for leg=
acy driver
[   34.226900][    T1] N_HDLC line discipline registered with maxframe=3D40=
96
[   34.234889][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enab=
led
[   34.249802][    T1] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D =
115200) is a 16550A
[   34.284139][    T1] 00:04: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D =
115200) is a 16550A
[   34.313774][    T1] 00:05: ttyS2 at I/O 0x3e8 (irq =3D 6, base_baud =3D =
115200) is a 16550A
[   34.345912][    T1] 00:06: ttyS3 at I/O 0x2e8 (irq =3D 7, base_baud =3D =
115200) is a 16550A
[   34.395124][    T1] Non-volatile memory driver v1.3
[   34.407451][    T1] BUG: kernel NULL pointer dereference, address: 00000=
00000000000
[   34.415494][    T1] #PF: supervisor read access in kernel mode
[   34.416986][    T1] #PF: error_code(0x0000) - not-present page
[   34.416986][    T1] PGD 0 P4D 0=20
[   34.416986][    T1] Oops: Oops: 0000 [#1] SMP PTI
[   34.416986][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.1=
4.0-syzkaller-02023-gee6740fd34eb-dirty #0 PREEMPT(undef)=20
[   34.416986][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 02/12/2025
[   34.416986][    T1] RIP: 0010:msix_capability_init+0x95c/0x18c0
[   34.416986][    T1] Code: ff ff ff 48 89 9d 60 fe ff ff 48 89 9d 08 ff f=
f ff 48 83 bd 30 ff ff ff 00 4c 8b 75 c8 0f 85 1d 02 00 00 48 8b bd 58 ff f=
f ff <44> 8b 27 b8 00 00 40 00 41 21 c4 e8 e4 a8 ad fb 8b 18 44 8b 3a 41
[   34.416986][    T1] RSP: 0000:ffff888100642fb0 EFLAGS: 00010246
[   34.416986][    T1] RAX: ffff8880bba43080 RBX: ffffc90000b3f008 RCX: 000=
0000100243080
[   34.416986][    T1] RDX: ffff888100243080 RSI: ffff88813fffacc0 RDI: 000=
0000000000000
[   34.506029][    T1] RBP: ffff888100643178 R08: ffffea000000000f R09: 000=
0000000000000
[   34.506029][    T1] R10: ffff8880bba43020 R11: ffffffff86cfc5e9 R12: 000=
0000000000000
[   34.506029][    T1] R13: 0000000000000000 R14: ffff8881408d0b58 R15: 000=
000000000000b
[   34.506029][    T1] FS:  0000000000000000(0000) GS:ffff8881ab2b0000(0000=
) knlGS:0000000000000000
[   34.506029][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.506029][    T1] CR2: 0000000000000000 CR3: 0000000011a80000 CR4: 000=
00000003526f0
[   34.556031][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   34.556031][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   34.556031][    T1] Call Trace:
[   34.556031][    T1]  <TASK>
[   34.556031][    T1]  ? show_trace_log_lvl+0x268/0x3d0
[   34.556031][    T1]  ? __pci_enable_msix_range+0xad9/0xc40
[   34.556031][    T1]  ? __die_body+0xce/0x1a0
[   34.556031][    T1]  ? __die+0x20f/0x270
[   34.556031][    T1]  ? page_fault_oops+0xe58/0xfb0
[   34.605985][    T1]  ? exc_page_fault+0x56c/0x700
[   34.605985][    T1]  ? asm_exc_page_fault+0x2b/0x30
[   34.605985][    T1]  ? __pci_enable_msix_range+0xad9/0xc40
[   34.605985][    T1]  ? msix_capability_init+0x95c/0x18c0
[   34.605985][    T1]  __pci_enable_msix_range+0xad9/0xc40
[   34.605985][    T1]  ? kmsan_get_metadata+0x13e/0x1c0
[   34.605985][    T1]  ? kmsan_internal_set_shadow_origin+0x6c/0x100
[   34.605985][    T1]  pci_alloc_irq_vectors_affinity+0x111/0x3a0
[   34.605985][    T1]  vp_find_vqs_msix+0x84d/0x1560
[   34.656028][    T1]  ? kmsan_internal_unpoison_memory+0x14/0x20
[   34.656028][    T1]  vp_find_vqs+0x6c/0xa80
[   34.656028][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[   34.656028][    T1]  ? __pfx_vp_find_vqs+0x10/0x10
[   34.656028][    T1]  probe_common+0x3b4/0x970
[   34.656028][    T1]  ? __pfx_random_recv_done+0x10/0x10
[   34.656028][    T1]  ? kmsan_get_metadata+0x13e/0x1c0
[   34.656028][    T1]  virtrng_probe+0x2d/0x40
[   34.656028][    T1]  ? __pfx_virtrng_probe+0x10/0x10
[   34.656028][    T1]  virtio_dev_probe+0x1640/0x19a0
[   34.706032][    T1]  ? __pfx_virtio_dev_probe+0x10/0x10
[   34.706032][    T1]  really_probe+0x4dc/0xd90
[   34.706032][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[   34.706032][    T1]  __driver_probe_device+0x2ab/0x5d0
[   34.706032][    T1]  driver_probe_device+0x72/0x890
[   34.706032][    T1]  __driver_attach+0x7ea/0xb50
[   34.706032][    T1]  bus_for_each_dev+0x350/0x540
[   34.706032][    T1]  ? __pfx___driver_attach+0x10/0x10
[   34.706032][    T1]  driver_attach+0x51/0x70
[   34.755983][    T1]  bus_add_driver+0x74c/0xdb0
[   34.755983][    T1]  driver_register+0x3fb/0x660
[   34.755983][    T1]  __register_virtio_driver+0xf1/0x120
[   34.755983][    T1]  ? __pfx_virtio_rng_driver_init+0x10/0x10
[   34.755983][    T1]  virtio_rng_driver_init+0x2e/0x40
[   34.755983][    T1]  do_one_initcall+0x228/0xbf0
[   34.755983][    T1]  ? kmsan_internal_set_shadow_origin+0x6c/0x100
[   34.755983][    T1]  ? __pfx_virtio_rng_driver_init+0x10/0x10
[   34.755983][    T1]  ? advisor_target_scan_time_store+0x120/0x180
[   34.805996][    T1]  ? irqentry_enter+0x37/0x60
[   34.805996][    T1]  ? sysvec_apic_timer_interrupt+0x52/0x90
[   34.805996][    T1]  ? kmsan_get_metadata+0x13e/0x1c0
[   34.805996][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[   34.805996][    T1]  ? kmsan_get_metadata+0x13e/0x1c0
[   34.805996][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[   34.805996][    T1]  ? kmsan_get_metadata+0x13e/0x1c0
[   34.805996][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[   34.805996][    T1]  ? parameq+0x43a/0x470
[   34.856033][    T1]  ? kmsan_get_metadata+0x13e/0x1c0
[   34.856033][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[   34.856033][    T1]  ? parse_args+0xfde/0x10a0
[   34.856033][    T1]  ? kmsan_get_metadata+0x13e/0x1c0
[   34.856033][    T1]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[   34.856033][    T1]  ? __pfx_virtio_rng_driver_init+0x10/0x10
[   34.856033][    T1]  do_initcall_level+0x140/0x350
[   34.856033][    T1]  do_initcalls+0x1a6/0x2f0
[   34.856033][    T1]  ? __pfx_native_smp_prepare_cpus+0x10/0x10
[   34.906320][    T1]  do_basic_setup+0x22/0x30
[   34.906320][    T1]  kernel_init_freeable+0x306/0x4c0
[   34.906320][    T1]  ? __pfx_kernel_init+0x10/0x10
[   34.906320][    T1]  kernel_init+0x2f/0x800
[   34.906320][    T1]  ? __pfx_kernel_init+0x10/0x10
[   34.906320][    T1]  ret_from_fork+0x6d/0x90
[   34.906320][    T1]  ? __pfx_kernel_init+0x10/0x10
[   34.906320][    T1]  ret_from_fork_asm+0x1a/0x30
[   34.906320][    T1] RIP: 1f0f:0x0
[   34.906320][    T1] Code: Unable to access opcode bytes at 0xfffffffffff=
fffd6.
[   34.956009][    T1] RSP: 0000:0000000000000000 EFLAGS: 841f0f2e66 ORIG_R=
AX: 1f0f2e6600000000
[   34.956009][    T1] RAX: 0000000000000000 RBX: 1f0f2e6600000000 RCX: 2e6=
6000000000084
[   34.956009][    T1] RDX: 0000000000841f0f RSI: 000000841f0f2e66 RDI: 008=
41f0f2e660000
[   34.956009][    T1] RBP: 00841f0f2e660000 R08: 00841f0f2e660000 R09: 000=
000841f0f2e66
[   34.956009][    T1] R10: 0000000000841f0f R11: 2e66000000000084 R12: 000=
000841f0f2e66
[   34.997502][    T1] R13: 0000000000841f0f R14: 2e66000000000084 R15: 1f0=
f2e6600000000
[   35.005965][    T1]  </TASK>
[   35.005965][    T1] Modules linked in:
[   35.005965][    T1] CR2: 0000000000000000
[   35.005965][    T1] ---[ end trace 0000000000000000 ]---
[   35.005965][    T1] RIP: 0010:msix_capability_init+0x95c/0x18c0
[   35.005965][    T1] Code: ff ff ff 48 89 9d 60 fe ff ff 48 89 9d 08 ff f=
f ff 48 83 bd 30 ff ff ff 00 4c 8b 75 c8 0f 85 1d 02 00 00 48 8b bd 58 ff f=
f ff <44> 8b 27 b8 00 00 40 00 41 21 c4 e8 e4 a8 ad fb 8b 18 44 8b 3a 41
[   35.005965][    T1] RSP: 0000:ffff888100642fb0 EFLAGS: 00010246
[   35.056178][    T1] RAX: ffff8880bba43080 RBX: ffffc90000b3f008 RCX: 000=
0000100243080
[   35.056178][    T1] RDX: ffff888100243080 RSI: ffff88813fffacc0 RDI: 000=
0000000000000
[   35.056178][    T1] RBP: ffff888100643178 R08: ffffea000000000f R09: 000=
0000000000000
[   35.056178][    T1] R10: ffff8880bba43020 R11: ffffffff86cfc5e9 R12: 000=
0000000000000
[   35.056178][    T1] R13: 0000000000000000 R14: ffff8881408d0b58 R15: 000=
000000000000b
[   35.056178][    T1] FS:  0000000000000000(0000) GS:ffff8881ab2b0000(0000=
) knlGS:0000000000000000
[   35.106029][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.106029][    T1] CR2: 0000000000000000 CR3: 0000000011a80000 CR4: 000=
00000003526f0
[   35.106029][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   35.106029][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   35.106029][    T1] Kernel panic - not syncing: Fatal exception
[   35.106029][    T1] Kernel Offset: disabled
[   35.106029][    T1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build1566228150=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 22a6c2b175
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
/usr/bin/ld: /tmp/ccyWCt6N.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D1492a804580000


Tested on:

commit:         ee6740fd Merge tag 'crc-for-linus' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D28ae396b18d2fa0=
2
dashboard link: https://syzkaller.appspot.com/bug?extid=3D7ea0b96c4ddb49fd1=
a70
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1294024c5800=
00


