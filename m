Return-Path: <linux-kernel+bounces-576958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D57BA716B0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04533AF024
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50F41E1DF5;
	Wed, 26 Mar 2025 12:28:35 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657991C5D7C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992115; cv=none; b=A7aX0aBnytKwl98VByLltLJvT1XCYkbKv71IuYXC0huJj6QAzdH0OoPxdZpLBprns385LfTFedr2BuXaEP2Z+DqL6F08ChaRMoZwEdAjw2tjqYnfMpPb/tDxKskYPSAhSJOjVYN2MmZefB0rzco/t8+yqstWY6C1AOyY0SHePj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992115; c=relaxed/simple;
	bh=1n4g/6bdveJW/rR0rc725KSzXn22VA+CQD/mrwBCn1E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lIn1UBDG7ebUwZvGsVanJ0oas1t7BRdxuL4VmLGN+ycABlVxZzflIbTF8t3G3CSLp+nGvRLCxH4HBagpftbgjy5v5WXOog3ViTGVPz49wlPIkIj6S99JSSu2oXosy+PbqHriPs2y1kKz6DxFGXcqHZkHQ4+u7DADO24VwwQKTEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so159880955ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992112; x=1743596912;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zYnXh1BdEnQUt4wBq7i6LTY5UTlxXJ/thaAO5zlxW3g=;
        b=U8VKVN3Gg2+4Almp1hRGsXdKrZSE4ujrcran24mp8TML630vSYEOLGN2t4zMJbSx7l
         SJkEzaVhRzwIf9lx5pQcVlm09euk0cmsYoyjMKVG1UK5IVRTfyvDfbKPFWPp5fRquDu+
         fItOoSHsCpn1xJIzgBUhWe3MOBtynqgLpqjDQDd7vANGpQ6GT+5sine0EauCbi9z/NtX
         nRf554su7WOAU5BOKjWC03QgFzdzGw27WRhkVvKvD7VIzwdM5U6sfN5CT6ybnwwBOa1B
         ocJkBZOoUzyxnL14Uprs58s4de1t66bPph2UA4ZCoXAL4Mk8PpRugQViGSFuAeoeNTju
         j40w==
X-Forwarded-Encrypted: i=1; AJvYcCXkpN9Oce/VBMbrNUEcKrl2qPgSv8GqP3W9ktW3U2kfRW+sbtIPQvj52QTQ9slnd42kbYnxtSQgYHL0k/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxArUxuT4euqFpLx2E1IEJnzVhwrfSmaGzRqMNjOGr3WVHd44jv
	9g7nuosttjygfyZq2NcJH6s6bZwVgiwdPbGXKPU1DtX2uQOAyO8ni4cZFshaO2/ZkdnsSatv5oJ
	kWCPg3JL4SYREgFeO3FcAafow+XJutTcbtkGqb5khbGVsZ5t8uMnoA/M=
X-Google-Smtp-Source: AGHT+IGVDZHVkoEBceZ2iUZrV27RwSUzjxrOpJ+blnO4CWSNtBcm02AI77VKCcLQ3Nr7zs9VlUmbOlReY69oRfuGXSloAC0czTtH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188d:b0:3d3:e296:1c1c with SMTP id
 e9e14a558f8ab-3d5961468famr187936185ab.9.1742992112369; Wed, 26 Mar 2025
 05:28:32 -0700 (PDT)
Date: Wed, 26 Mar 2025 05:28:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e3f2f0.050a0220.2f068f.0004.GAE@google.com>
Subject: [syzbot] [pci?] upstream test error: BUG: unable to handle kernel
 NULL pointer dereference in msix_capability_init
From: syzbot <syzbot+38d72234503f2b05981f@syzkaller.appspotmail.com>
To: bhelgaas@google.com, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1e26c5e28ca5 Merge tag 'media/v6.15-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1697cbb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae7b143bbda6d951
dashboard link: https://syzkaller.appspot.com/bug?extid=38d72234503f2b05981f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/91cf4f757ca2/disk-1e26c5e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1415c0b3bc2e/vmlinux-1e26c5e2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d363b301f320/bzImage-1e26c5e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+38d72234503f2b05981f@syzkaller.appspotmail.com

UDP-Lite hash table entries: 4096 (order: 6, 262144 bytes, linear)
NET: Registered PF_UNIX/PF_LOCAL protocol family
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp-with-tls transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NET: Registered PF_XDP protocol family
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfefff window]
pci 0000:00:00.0: Limiting direct PCI/PCI transfers
PCI: CLS 0 bytes, default 64
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
software IO TLB: mapped [mem 0x00000000bbffd000-0x00000000bfffd000] (64MB)
ACPI: bus type thunderbolt registered
RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fb63109b96, max_idle_ns: 440795265316 ns
clocksource: Switched to clocksource tsc
Initialise system trusted keyrings
workingset: timestamp_bits=40 max_order=21 bucket_order=0
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
9p: Installing v9fs 9p2000 file system support
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
io scheduler mq-deadline registered
io scheduler kyber registered
usbcore: registered new interface driver udlfb
usbcore: registered new interface driver smscufx
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: button: Power Button [PWRF]
input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
ACPI: button: Sleep Button [SLPF]
ACPI: \_SB_.LNKC: Enabled at IRQ 11
virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
ACPI: \_SB_.LNKD: Enabled at IRQ 10
virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
ACPI: \_SB_.LNKB: Enabled at IRQ 10
virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
Non-volatile memory driver v1.3
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: Oops: 0000 [#1] SMP PTI
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-syzkaller-02665-g1e26c5e28ca5 #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:msix_prepare_msi_desc drivers/pci/msi/msi.c:615 [inline]
RIP: 0010:msix_setup_msi_descs drivers/pci/msi/msi.c:639 [inline]
RIP: 0010:__msix_setup_interrupts drivers/pci/msi/msi.c:672 [inline]
RIP: 0010:msix_setup_interrupts drivers/pci/msi/msi.c:701 [inline]
RIP: 0010:msix_capability_init+0x3f7/0x8c0 drivers/pci/msi/msi.c:743
Code: e8 fe 3d 77 ff 41 8b 06 89 84 24 e0 00 00 00 4c 89 ff e8 bc 42 77 ff 4d 8b 3f 4c 89 bc 24 e8 00 00 00 48 89 df e8 d9 3d 77 ff <8b> 1b be 00 00 40 00 21 de 31 ff e8 29 9a 5d ff b8 00 00 40 00 21
RSP: 0000:ffffc900000174a8 EFLAGS: 00010246
RAX: ffff8881001b8a98 RBX: 0000000000000000 RCX: ffffffff81f5f7e7
RDX: 000000000000004c RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000101 R08: 0000000000000003 R09: 0000000000000000
R10: 0001ffffffffffff R11: 0001c90000017476 R12: 0000000000000000
R13: 0000000000000000 R14: ffff8881013d239c R15: ffffc90000029008
FS:  0000000000000000(0000) GS:ffff8882aee5d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000006836000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __pci_enable_msix_range+0x435/0x4d0 drivers/pci/msi/msi.c:851
 pci_alloc_irq_vectors_affinity+0xae/0x1f0 drivers/pci/msi/api.c:268
 vp_request_msix_vectors drivers/virtio/virtio_pci_common.c:160 [inline]
 vp_find_vqs_msix+0x412/0x8b0 drivers/virtio/virtio_pci_common.c:417
 vp_find_vqs+0x50/0x510 drivers/virtio/virtio_pci_common.c:525
 virtio_find_vqs include/linux/virtio_config.h:226 [inline]
 virtio_find_single_vq include/linux/virtio_config.h:237 [inline]
 probe_common+0x1f0/0x3d0 drivers/char/hw_random/virtio-rng.c:155
 virtrng_probe+0x15/0x20 drivers/char/hw_random/virtio-rng.c:193
 virtio_dev_probe+0x632/0x7b0 drivers/virtio/virtio.c:341
 really_probe+0x1cf/0x5d0 drivers/base/dd.c:658
 __driver_probe_device+0x12d/0x200 drivers/base/dd.c:800
 driver_probe_device+0x38/0x2f0 drivers/base/dd.c:830
 __driver_attach+0x311/0x400 drivers/base/dd.c:1216
 bus_for_each_dev+0x1af/0x210 drivers/base/bus.c:370
 driver_attach+0x2b/0x40 drivers/base/dd.c:1234
 bus_add_driver+0x272/0x470 drivers/base/bus.c:678
 driver_register+0x163/0x220 drivers/base/driver.c:249
 __register_virtio_driver+0x7a/0x90 drivers/virtio/virtio.c:415
 virtio_rng_driver_init+0x17/0x20 drivers/char/hw_random/virtio-rng.c:256
 do_one_initcall+0x10d/0x580 init/main.c:1257
 do_initcall_level+0x91/0x190 init/main.c:1319
 do_initcalls+0x89/0xf0 init/main.c:1335
 do_basic_setup+0x5b/0x70 init/main.c:1354
 kernel_init_freeable+0x1d5/0x280 init/main.c:1567
 kernel_init+0x1b/0x300 init/main.c:1457
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:msix_prepare_msi_desc drivers/pci/msi/msi.c:615 [inline]
RIP: 0010:msix_setup_msi_descs drivers/pci/msi/msi.c:639 [inline]
RIP: 0010:__msix_setup_interrupts drivers/pci/msi/msi.c:672 [inline]
RIP: 0010:msix_setup_interrupts drivers/pci/msi/msi.c:701 [inline]
RIP: 0010:msix_capability_init+0x3f7/0x8c0 drivers/pci/msi/msi.c:743
Code: e8 fe 3d 77 ff 41 8b 06 89 84 24 e0 00 00 00 4c 89 ff e8 bc 42 77 ff 4d 8b 3f 4c 89 bc 24 e8 00 00 00 48 89 df e8 d9 3d 77 ff <8b> 1b be 00 00 40 00 21 de 31 ff e8 29 9a 5d ff b8 00 00 40 00 21
RSP: 0000:ffffc900000174a8 EFLAGS: 00010246
RAX: ffff8881001b8a98 RBX: 0000000000000000 RCX: ffffffff81f5f7e7
RDX: 000000000000004c RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000101 R08: 0000000000000003 R09: 0000000000000000
R10: 0001ffffffffffff R11: 0001c90000017476 R12: 0000000000000000
R13: 0000000000000000 R14: ffff8881013d239c R15: ffffc90000029008
FS:  0000000000000000(0000) GS:ffff8882aee5d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000006836000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 fe 3d 77 ff       	call   0xff773e03
   5:	41 8b 06             	mov    (%r14),%eax
   8:	89 84 24 e0 00 00 00 	mov    %eax,0xe0(%rsp)
   f:	4c 89 ff             	mov    %r15,%rdi
  12:	e8 bc 42 77 ff       	call   0xff7742d3
  17:	4d 8b 3f             	mov    (%r15),%r15
  1a:	4c 89 bc 24 e8 00 00 	mov    %r15,0xe8(%rsp)
  21:	00
  22:	48 89 df             	mov    %rbx,%rdi
  25:	e8 d9 3d 77 ff       	call   0xff773e03
* 2a:	8b 1b                	mov    (%rbx),%ebx <-- trapping instruction
  2c:	be 00 00 40 00       	mov    $0x400000,%esi
  31:	21 de                	and    %ebx,%esi
  33:	31 ff                	xor    %edi,%edi
  35:	e8 29 9a 5d ff       	call   0xff5d9a63
  3a:	b8 00 00 40 00       	mov    $0x400000,%eax
  3f:	21                   	.byte 0x21


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

