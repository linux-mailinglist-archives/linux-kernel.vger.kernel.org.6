Return-Path: <linux-kernel+bounces-361297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9A499A669
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675C61F22DA1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3FC2E62B;
	Fri, 11 Oct 2024 14:35:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4F0624
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657304; cv=none; b=RVyXyK9QTbpzotFz0HC0cmhv71LXsH4zB19LpA4l9/VsqqeSFa6FT0EJvvVDh+WubSYBS4d3RAeDkoa+cqqalWcfnZk0TqSCRKShE/wrCt1znb8TgxPYWqaAe6U6d6ows8SwvnzE+meDDKj+2bKhERm7pKglbM3WF+QtreP980Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657304; c=relaxed/simple;
	bh=GpPaqfOPZMM3Uw3iVn3LWSeRydG3U7Z7yINjl9Bdjjg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f/sH//jHXsqDOgxwyEI5FKJnJfBoyba6bYAF20j0OFlIc8NVHYSw9A2xVi2P/jdAlfbjLPBU1T0JdACKaq4/F/ZWtucv4ZMozywGvKkBbkA9nlLy7CiYS9HeNsCX6yrhL1zY8tGFuFiX61LRleSkJejx6I9Dy1seHO3ihMRd8N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a342e7e49cso24649765ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728657302; x=1729262102;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwmqvMb4AfCz+Pu7zxZ3v3euFBRpDQu88oKicvoEfq4=;
        b=A5yZJub27RNhfmrRDdx3i+TfxNvGEmcF68JHXp/mkbtIKzfFkR28ilo0aIhAYkh0rY
         JGDaeIV35lOD0siHFBXGjAmVppxf5eD9Z2Fmlqr+PwTwj7SQtv7KLOlw3UryZfBKN0le
         FMZ8qkjLwQRw6JGDiRC1+jWoGX8L2ZNn52uTxB2+4aTgypVisMsigTWWLmnXJiMy4RE3
         5St6lC++18hmMgHEVuW26HD2wEAZC1+O8ncOVCLCyavUpCb+dJOyS8QG1jI08siL6fsQ
         N7dkerbCNbVfCn4xCWTKl1kGdN32QGT7g6N1MWx5Z4n2Y48/UGv1gnzqsh/W072CCkE9
         dyzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtok3ZGQJ1QhGynqEKiUwrUmkxS9AG6TW/9Y6lNMMrZ1deVAsm2Il8YWxINqMrSF7yM/uHyFntJU7OVdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEtrDKNA/fmQQ4++J45vD7ndElt6k1vG4/2miK3HhkdBpGf6RM
	Dh1HHVc4aR1803cbyW/udsqH7j9ibA+jejR9Ag4vu5z4MfqdsAk/iVS0npjHSUWH74T8AaBnwqB
	8NWlfr7nkSZCuclMbQ5StBDPXh6nSWcz1nG6954sdUICOjc9UqHDEErQ=
X-Google-Smtp-Source: AGHT+IEF5Hdp5F3dddqHgVS22ev0mDpli+6NfXZBzRUTRVUo00XWcsP2wW8Yxh2xmAT8XfveOWvfCHC10M3kCBcsitkLIS97CgKH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa8:b0:3a3:4391:24e9 with SMTP id
 e9e14a558f8ab-3a3b603e0dbmr16380425ab.20.1728657302041; Fri, 11 Oct 2024
 07:35:02 -0700 (PDT)
Date: Fri, 11 Oct 2024 07:35:02 -0700
In-Reply-To: <d65e2258-2901-486a-ab83-ff57e9868a91@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67093796.050a0220.3e960.0012.GAE@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
From: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, stern@rowland.harvard.edu, sylv@sylv.io, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

ice)
[    3.002225][    T1] ACPI: Added _OSI(3.0 _SCP Extensions)
[    3.003059][    T1] ACPI: Added _OSI(Processor Aggregator Device)
[    3.085420][   T12] Callback from call_rcu_tasks() invoked.
[    3.276952][    T1] ACPI: 2 ACPI AML tables successfully acquired and lo=
aded
[    3.314462][    T1] ACPI: _OSC evaluation for CPUs failed, trying _PDC
[    3.348039][    T1] ACPI: Interpreter enabled
[    3.350335][    T1] ACPI: PM: (supports S0 S3 S4 S5)
[    3.352134][    T1] ACPI: Using IOAPIC for interrupt routing
[    3.354599][    T1] PCI: Using host bridge windows from ACPI; if necessa=
ry, use "pci=3Dnocrs" and report a bug
[    3.355296][    T1] PCI: Ignoring E820 reservations for host bridge wind=
ows
[    3.367249][    T1] ACPI: Enabled 16 GPEs in block 00 to 0F
[    3.746048][    T1] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff=
])
[    3.747443][    T1] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Seg=
ments MSI HPX-Type3]
[    3.749086][    T1] acpi PNP0A03:00: _OSC: not requesting OS control; OS=
 requires [ExtendedConfig ASPM ClockPM MSI]
[    3.753239][    T1] acpi PNP0A03:00: fail to add MMCONFIG information, c=
an't access extended configuration space under this bridge
[    3.790190][    T1] PCI host bridge to bus 0000:00
[    3.791637][    T1] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf=
7 window]
[    3.792856][    T1] pci_bus 0000:00: root bus resource [io  0x0d00-0xfff=
f window]
[    3.794311][    T1] pci_bus 0000:00: root bus resource [mem 0x000a0000-0=
x000bffff window]
[    3.795302][    T1] pci_bus 0000:00: root bus resource [mem 0xc0000000-0=
xfebfefff window]
[    3.797357][    T1] pci_bus 0000:00: root bus resource [bus 00-ff]
[    3.800192][    T1] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000=
 conventional PCI endpoint
[    3.811190][    T1] pci 0000:00:01.0: [8086:7110] type 00 class 0x060100=
 conventional PCI endpoint
[    3.851850][    T1] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000=
 conventional PCI endpoint
[    3.879292][    T1] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed=
 by PIIX4 ACPI
[    3.890132][    T1] pci 0000:00:03.0: [1af4:1004] type 00 class 0x000000=
 conventional PCI endpoint
[    3.902150][    T1] pci 0000:00:03.0: BAR 0 [io  0xc000-0xc03f]
[    3.912077][    T1] pci 0000:00:03.0: BAR 1 [mem 0xfe800000-0xfe80007f]
[    3.943377][    T1] pci 0000:00:04.0: [1af4:1000] type 00 class 0x020000=
 conventional PCI endpoint
[    3.955285][    T1] pci 0000:00:04.0: BAR 0 [io  0xc040-0xc07f]
[    3.963126][    T1] pci 0000:00:04.0: BAR 1 [mem 0xfe801000-0xfe80107f]
[    3.989371][    T1] pci 0000:00:05.0: [1ae0:a002] type 00 class 0x030000=
 conventional PCI endpoint
[    3.999276][    T1] pci 0000:00:05.0: BAR 0 [mem 0xfe000000-0xfe7fffff]
[    4.030695][    T1] pci 0000:00:05.0: Video device with shadowed ROM at =
[mem 0x000c0000-0x000dffff]
[    4.040832][    T1] pci 0000:00:06.0: [1af4:1002] type 00 class 0x00ff00=
 conventional PCI endpoint
[    4.052403][    T1] pci 0000:00:06.0: BAR 0 [io  0xc080-0xc09f]
[    4.083310][    T1] pci 0000:00:07.0: [1af4:1005] type 00 class 0x00ff00=
 conventional PCI endpoint
[    4.098317][    T1] pci 0000:00:07.0: BAR 0 [io  0xc0a0-0xc0bf]
[    4.107225][    T1] pci 0000:00:07.0: BAR 1 [mem 0xfe802000-0xfe80203f]
[    4.200337][    T1] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    4.213761][    T1] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    4.227312][    T1] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    4.241372][    T1] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    4.248294][    T1] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    4.283168][    T1] iommu: Default domain type: Translated
[    4.284430][    T1] iommu: DMA domain TLB invalidation policy: lazy mode
[    4.291847][    T1] SCSI subsystem initialized
[    4.298163][    T1] ACPI: bus type USB registered
[    4.300417][    T1] usbcore: registered new interface driver usbfs
[    4.302000][    T1] usbcore: registered new interface driver hub
[    4.303838][    T1] usbcore: registered new device driver usb
[    4.308961][    T1] mc: Linux media interface: v0.10
[    4.310673][    T1] videodev: Linux video capture interface: v2.00
[    4.314068][    T1] pps_core: LinuxPPS API ver. 1 registered
[    4.315288][    T1] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 =
Rodolfo Giometti <giometti@linux.it>
[    4.317429][    T1] PTP clock support registered
[    4.321082][    T1] EDAC MC: Ver: 3.0.0
[    4.331906][    T1] Advanced Linux Sound Architecture Driver Initialized=
.
[    4.345666][    T1] Bluetooth: Core ver 2.22
[    4.347724][    T1] NET: Registered PF_BLUETOOTH protocol family
[    4.349885][    T1] Bluetooth: HCI device and connection manager initial=
ized
[    4.352264][    T1] Bluetooth: HCI socket layer initialized
[    4.353522][    T1] Bluetooth: L2CAP socket layer initialized
[    4.355359][    T1] Bluetooth: SCO socket layer initialized
[    4.357435][    T1] NET: Registered PF_ATMPVC protocol family
[    4.359810][    T1] NET: Registered PF_ATMSVC protocol family
[    4.362356][    T1] NetLabel: Initializing
[    4.363887][    T1] NetLabel:  domain hash size =3D 128
[    4.365276][    T1] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    4.368668][    T1] NetLabel:  unlabeled traffic allowed by default
[    4.375910][    T1] nfc: nfc_init: NFC Core ver 0.1
[    4.378232][    T1] NET: Registered PF_NFC protocol family
[    4.380020][    T1] PCI: Using ACPI for IRQ routing
[    4.383469][    T1] pci 0000:00:05.0: vgaarb: setting as boot VGA device
[    4.385257][    T1] pci 0000:00:05.0: vgaarb: bridge control possible
[    4.385257][    T1] pci 0000:00:05.0: vgaarb: VGA device added: decodes=
=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    4.385284][    T1] vgaarb: loaded
[    4.406926][    T1] clocksource: Switched to clocksource kvm-clock
[    4.415109][    T1] VFS: Disk quotas dquot_6.6.0
[    4.415313][    T1] VFS: Dquot-cache hash table entries: 512 (order 0, 4=
096 bytes)
[    4.420224][    T1] pnp: PnP ACPI init
[    4.469015][    T1] pnp: PnP ACPI: found 7 devices
[    4.555551][    T1] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xf=
fffff, max_idle_ns: 2085701024 ns
[    4.571683][    T1] NET: Registered PF_INET protocol family
[    4.577543][    T1] IP idents hash table entries: 131072 (order: 8, 1048=
576 bytes, linear)
[    4.593539][    T1] ------------[ cut here ]------------
[    4.595293][    T1] refcount_t: decrement hit 0; leaking memory.
[    4.596951][    T1] WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount=
_warn_saturate+0x1ed/0x210
[    4.599957][    T1] Modules linked in:
[    4.601156][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc2-=
syzkaller-00078-g920e7522e3ba #0
[    4.603368][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 09/13/2024
[    4.606363][    T1] RIP: 0010:refcount_warn_saturate+0x1ed/0x210
[    4.609070][    T1] Code: 87 e8 27 0e ce fe 90 0f 0b 90 90 e9 c3 fe ff f=
f e8 d8 d6 07 ff c6 05 11 98 b3 07 01 90 48 c7 c7 40 02 26 87 e8 04 0e ce f=
e 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 42 f7 5c ff e9 44 fe ff ff
[    4.613673][    T1] RSP: 0000:ffffc9000001fba0 EFLAGS: 00010282
[    4.614899][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff811a05b9
[    4.616158][    T1] RDX: ffff8881012a8000 RSI: ffffffff811a05c6 RDI: 000=
0000000000001
[    4.618038][    T1] RBP: ffff88810a6a06cc R08: 0000000000000001 R09: 000=
0000000000000
[    4.619549][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f88810a6a06cc
[    4.620938][    T1] R13: 0000000000000000 R14: 0000000000d60059 R15: fff=
f8881068d5f28
[    4.622631][    T1] FS:  0000000000000000(0000) GS:ffff8881f5800000(0000=
) knlGS:0000000000000000
[    4.624581][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.625763][    T1] CR2: ffff88823ffff000 CR3: 000000000889e000 CR4: 000=
00000003506f0
[    4.627528][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[    4.628776][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[    4.631108][    T1] Call Trace:
[    4.631680][    T1]  <TASK>
[    4.632515][    T1]  ? show_regs+0x8c/0xa0
[    4.633661][    T1]  ? __warn+0xe5/0x3c0
[    4.635168][    T1]  ? __wake_up_klogd.part.0+0x99/0xf0
[    4.636612][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[    4.637520][    T1]  ? report_bug+0x3c0/0x580
[    4.638548][    T1]  ? handle_bug+0x3d/0x70
[    4.639596][    T1]  ? exc_invalid_op+0x17/0x50
[    4.640935][    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    4.642371][    T1]  ? __warn_printk+0x199/0x350
[    4.643107][    T1]  ? __warn_printk+0x1a6/0x350
[    4.644886][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[    4.645992][    T1]  __reset_page_owner+0x2ea/0x370
[    4.646949][    T1]  __free_pages_ok+0x5db/0xbf0
[    4.648332][    T1]  ? __split_page_owner+0xdd/0x120
[    4.649331][    T1]  make_alloc_exact+0x165/0x260
[    4.650432][    T1]  alloc_large_system_hash+0x4e0/0x640
[    4.651653][    T1]  inet_hashinfo2_init+0x4b/0xd0
[    4.653240][    T1]  tcp_init+0xba/0x9f0
[    4.654195][    T1]  inet_init+0x419/0x6f0
[    4.655067][    T1]  ? __pfx_inet_init+0x10/0x10
[    4.656148][    T1]  do_one_initcall+0x128/0x700
[    4.657254][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    4.658290][    T1]  ? trace_kmalloc+0x2d/0xe0
[    4.659168][    T1]  ? __kmalloc+0x213/0x400
[    4.659995][    T1]  kernel_init_freeable+0x69d/0xca0
[    4.661086][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.662386][    T1]  kernel_init+0x1c/0x2b0
[    4.663173][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.664120][    T1]  ret_from_fork+0x45/0x80
[    4.665027][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.665837][    T1]  ret_from_fork_asm+0x1a/0x30
[    4.666808][    T1]  </TASK>
[    4.667817][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[    4.669094][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc2-=
syzkaller-00078-g920e7522e3ba #0
[    4.670996][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 09/13/2024
[    4.672099][    T1] Call Trace:
[    4.672099][    T1]  <TASK>
[    4.672099][    T1]  dump_stack_lvl+0x3d/0x1f0
[    4.672099][    T1]  panic+0x6f5/0x7a0
[    4.672099][    T1]  ? __pfx_panic+0x10/0x10
[    4.672099][    T1]  ? show_trace_log_lvl+0x363/0x500
[    4.672099][    T1]  ? check_panic_on_warn+0x1f/0xb0
[    4.672099][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[    4.672099][    T1]  check_panic_on_warn+0xab/0xb0
[    4.672099][    T1]  __warn+0xf1/0x3c0
[    4.672099][    T1]  ? __wake_up_klogd.part.0+0x99/0xf0
[    4.672099][    T1]  ? refcount_warn_saturate+0x1ed/0x210
[    4.672099][    T1]  report_bug+0x3c0/0x580
[    4.672099][    T1]  handle_bug+0x3d/0x70
[    4.672099][    T1]  exc_invalid_op+0x17/0x50
[    4.672099][    T1]  asm_exc_invalid_op+0x1a/0x20
[    4.672099][    T1] RIP: 0010:refcount_warn_saturate+0x1ed/0x210
[    4.672099][    T1] Code: 87 e8 27 0e ce fe 90 0f 0b 90 90 e9 c3 fe ff f=
f e8 d8 d6 07 ff c6 05 11 98 b3 07 01 90 48 c7 c7 40 02 26 87 e8 04 0e ce f=
e 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 42 f7 5c ff e9 44 fe ff ff
[    4.672099][    T1] RSP: 0000:ffffc9000001fba0 EFLAGS: 00010282
[    4.672099][    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: fff=
fffff811a05b9
[    4.672099][    T1] RDX: ffff8881012a8000 RSI: ffffffff811a05c6 RDI: 000=
0000000000001
[    4.672099][    T1] RBP: ffff88810a6a06cc R08: 0000000000000001 R09: 000=
0000000000000
[    4.672099][    T1] R10: 0000000000000000 R11: 0000000000000001 R12: fff=
f88810a6a06cc
[    4.672099][    T1] R13: 0000000000000000 R14: 0000000000d60059 R15: fff=
f8881068d5f28
[    4.672099][    T1]  ? __warn_printk+0x199/0x350
[    4.672099][    T1]  ? __warn_printk+0x1a6/0x350
[    4.672099][    T1]  __reset_page_owner+0x2ea/0x370
[    4.672099][    T1]  __free_pages_ok+0x5db/0xbf0
[    4.672099][    T1]  ? __split_page_owner+0xdd/0x120
[    4.672099][    T1]  make_alloc_exact+0x165/0x260
[    4.672099][    T1]  alloc_large_system_hash+0x4e0/0x640
[    4.672099][    T1]  inet_hashinfo2_init+0x4b/0xd0
[    4.672099][    T1]  tcp_init+0xba/0x9f0
[    4.672099][    T1]  inet_init+0x419/0x6f0
[    4.672099][    T1]  ? __pfx_inet_init+0x10/0x10
[    4.672099][    T1]  do_one_initcall+0x128/0x700
[    4.672099][    T1]  ? __pfx_do_one_initcall+0x10/0x10
[    4.672099][    T1]  ? trace_kmalloc+0x2d/0xe0
[    4.721681][    T1]  ? __kmalloc+0x213/0x400
[    4.721681][    T1]  kernel_init_freeable+0x69d/0xca0
[    4.721681][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.721681][    T1]  kernel_init+0x1c/0x2b0
[    4.721681][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.721681][    T1]  ret_from_fork+0x45/0x80
[    4.721681][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.721681][    T1]  ret_from_fork_asm+0x1a/0x30
[    4.721681][    T1]  </TASK>
[    4.721681][    T1] Rebooting in 86400 seconds..


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
1-go1.22.1.linux-amd64'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod/golang.org/toolchain@v0=
.0.1-go1.22.1.linux-amd64/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.22.1'
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
 -ffile-prefix-map=3D/tmp/go-build204408742=3D/tmp/go-build -gno-record-gcc=
-switches'

git status (err=3D<nil>)
HEAD detached at d7906effc2
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
go fmt ./sys/... >/dev/null
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dd7906effc263366a8b067258cec67072b29aa5e0 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20241003-062913'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include -fpermissive -w -DGOOS_linu=
x=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"d7906effc263366a8b067258cec67072b2=
9aa5e0\"
/usr/bin/ld: /tmp/ccI6z2y7.o: in function `test_cover_filter()':
executor.cc:(.text+0x1424b): warning: the use of `tempnam' is dangerous, be=
tter use `mkstemp'
/usr/bin/ld: /tmp/ccI6z2y7.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D12ac2840580000


Tested on:

commit:         920e7522 usb: gadget: function: Remove usage of the de..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.=
git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D5508c3b3c58f53
dashboard link: https://syzkaller.appspot.com/bug?extid=3Df342ea16c9d06d80b=
585
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40

Note: no patches were applied.

