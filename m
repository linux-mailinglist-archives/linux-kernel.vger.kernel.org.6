Return-Path: <linux-kernel+bounces-339563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CA99866F8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC49D1C2150C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB02143C63;
	Wed, 25 Sep 2024 19:36:36 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF79143722
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727292995; cv=none; b=I4LyFoiOGdxDX031cFtiiAcJ0G+KkbLkq+8ZOBNCo4C+4IQ9AnFmDZPNZgpkd1SeAPzUU7/VXc6jk028ABVEoreeqGieDWfnpRxjDoeNSTWFKI9XbIQLrdrqi+dXw0JFsENTffbMKfAOVoGN+W+zANfnl+s3LocJm0nWgUv37zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727292995; c=relaxed/simple;
	bh=Kwmy9nvN5vI5agERMxEXbZf386Y20KM864jpkJH7BBs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=P5qTxhbHNV1doVc/LoBubMA6nO7PA3nfJH3Fn6tj7Rax3SYIw/Xa1hSWtucOnm6k7rkd4tWofFeGihiJ2NOtQzqKsyBsoMDu+EzdJSfNByipZ40Jskhc/VeLJTQxrKCKeAiHXhNfRSBVgxelPblBxKZyC+wHvtUMG/vyi24bXWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0ce7e621aso2550765ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 12:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727292993; x=1727897793;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hNn2So2DDd405eGJwhqJxfhkbTGoMUMqnOa90L4tWFY=;
        b=dMILWBKDJFDdsmgOkINtCJspyHLj9o/m49FR2qfo40TkJT4AF4tp4rPI32YeH9gOJP
         zd5bkvK4cBRQWwZbAjlJLBJ2zx0KSsM8dhDHD3QhzGTUhkQhuh2DNVql+mT7a9D0GT+K
         ogQe9SjnOF4U0uRMVJ0ZaKt4AywLUKakAOa/7rSPkI2TQhE01D38sEdFbffftg+Ku1x8
         E8ItrzQbwURrunZCE9EWwoXIJYIehtWfAXK4hizIluwagc9RnZpBOyzDjegWb5bR1teg
         bBM478wEi+rdw3QN/HTYppolQLygFqFFaG+R5+x2ylQDQ6z94Vnyze1JsrhKTKqQVMhS
         kEog==
X-Forwarded-Encrypted: i=1; AJvYcCVJ+T1BO5ibMuBviU6TJjeaj3Ze/n85yDXd05JfGuxbfVyikUpliBZrBwM1/tU/lea4SEVazkCbYO4NB84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOZmueWK+nT4eC+O3CNbuQJ+QI+nFQL+VDCzAjiBJOEeVTMS3K
	4fNBj/8SOMn/WnI2f+JloliQMwFbg2qEosiaROEKRpWwV75y02vGsxkdlj22DvfpXepxrbI6Wtj
	bC9trlY4Kh0KfOPu1L9dkJnpqZ3FGPfGH0fDDudQyMVmPTh+2d4NkxZM=
X-Google-Smtp-Source: AGHT+IFNRaTvdnWDZusHPmIRRCPBmSd3Dr/4npGtn1opbsOpuCxKaaL/YCq7B0RHDnZeSTWXlu/i2zwG9bh/ZA5gknn+JE6jN/aG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2188:b0:3a0:be93:e8d5 with SMTP id
 e9e14a558f8ab-3a26d788145mr45313815ab.11.1727292993161; Wed, 25 Sep 2024
 12:36:33 -0700 (PDT)
Date: Wed, 25 Sep 2024 12:36:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f46641.050a0220.2af13c.004e.GAE@google.com>
Subject: [syzbot] [iommu?] kernel BUG in trace_dma_unmap_sg
From: syzbot <syzbot+95e4ef83a3024384ec7a@syzkaller.appspotmail.com>
To: hch@lst.de, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	m.szyprowski@samsung.com, robin.murphy@arm.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1ec6d097897a Merge tag 's390-6.12-1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b69e9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6265dd30e362bb47
dashboard link: https://syzkaller.appspot.com/bug?extid=95e4ef83a3024384ec7a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11dd8080580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10769e9f980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-1ec6d097.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0b74fa2b2b4e/vmlinux-1ec6d097.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1ed852a3c5d1/bzImage-1ec6d097.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+95e4ef83a3024384ec7a@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at include/linux/scatterlist.h:171!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 4594 Comm: udevd Not tainted 6.11.0-syzkaller-08068-g1ec6d097897a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:sg_page include/linux/scatterlist.h:171 [inline]
RIP: 0010:sg_phys include/linux/scatterlist.h:389 [inline]
RIP: 0010:perf_trace_dma_unmap_sg+0x784/0x790 include/trace/events/dma.h:224
Code: 00 48 8b 54 24 08 e9 6b fe ff ff e8 06 7d 17 00 48 c7 c7 60 79 94 8e 4c 89 f6 e8 27 33 74 03 e9 5b fa ff ff e8 ed 7c 17 00 90 <0f> 0b e8 f5 ea 43 0a 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000007aa0 EFLAGS: 00010006
RAX: ffffffff817d37f3 RBX: ffff888000630288 RCX: ffff888000a98000
RDX: 0000000000010000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90000007bd0 R08: ffffffff817d34eb R09: 322e66313a30303a
R10: dffffc0000000000 R11: fffff91ffff86f4c R12: 0000000000000008
R13: ffff88801cfa9f81 R14: ffff8880006302a8 R15: dffffc0000000000
FS:  00007f54266ba280(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055fa022e3302 CR3: 0000000011df4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 trace_dma_unmap_sg+0x1c2/0x230 include/trace/events/dma.h:224
 dma_unmap_sg_attrs+0x49/0xe0 kernel/dma/mapping.c:308
 ata_sg_clean drivers/ata/libata-core.c:4627 [inline]
 __ata_qc_complete+0x1ae/0x5b0 drivers/ata/libata-core.c:4720
 ata_qc_complete_multiple+0x1a3/0x280 drivers/ata/libata-sata.c:789
 ahci_qc_complete drivers/ata/libahci.c:1881 [inline]
 ahci_handle_port_interrupt+0x422/0x650 drivers/ata/libahci.c:1948
 ahci_port_intr drivers/ata/libahci.c:1959 [inline]
 ahci_handle_port_intr+0x18e/0x2c0 drivers/ata/libahci.c:1990
 ahci_single_level_irq_intr+0xa1/0xf0 drivers/ata/libahci.c:2024
 __handle_irq_event_percpu+0x29a/0xa80 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
 handle_edge_irq+0x25f/0xc20 kernel/irq/chip.c:831
 generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
 handle_irq arch/x86/kernel/irq.c:247 [inline]
 call_irq_handler arch/x86/kernel/irq.c:259 [inline]
 __common_interrupt+0x136/0x230 arch/x86/kernel/irq.c:285
 common_interrupt+0xb4/0xd0 arch/x86/kernel/irq.c:278
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5826
Code: 2b 00 74 08 4c 89 f7 e8 ba 5a 8d 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc900021271a0 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff92000424e40 RCX: 89f1c2910a3e7200
RDX: dffffc0000000000 RSI: ffffffff8c0adbc0 RDI: ffffffff8c60d540
RBP: ffffc900021272e8 R08: ffffffff96af65d7 R09: 1ffffffff2d5ecba
R10: dffffc0000000000 R11: fffffbfff2d5ecbb R12: 1ffff92000424e3c
R13: dffffc0000000000 R14: ffffc90002127200 R15: 0000000000000246
 down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
 filemap_invalidate_lock_shared include/linux/fs.h:870 [inline]
 filemap_fault+0x6e8/0x1950 mm/filemap.c:3327
 __do_fault+0x135/0x460 mm/memory.c:4876
 do_read_fault mm/memory.c:5282 [inline]
 do_fault mm/memory.c:5416 [inline]
 do_pte_missing mm/memory.c:3965 [inline]
 handle_pte_fault+0x2d1c/0x6800 mm/memory.c:5751
 __handle_mm_fault mm/memory.c:5894 [inline]
 handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6062
 do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x2b9/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:do_strncpy_from_user lib/strncpy_from_user.c:41 [inline]
RIP: 0010:strncpy_from_user+0x110/0x2e0 lib/strncpy_from_user.c:139
Code: 00 00 00 4c 89 e6 e8 3f eb a3 fc 49 83 fc 07 0f 86 9a 00 00 00 48 89 6c 24 08 48 c7 44 24 10 f8 ff ff ff 45 31 ed 4c 89 3c 24 <4f> 8b 3c 2f 48 b8 ff fe fe fe fe fe fe fe 49 8d 1c 07 4c 89 fd 48
RSP: 0018:ffffc90002127c88 EFLAGS: 00050246
RAX: 0000000000000000 RBX: ffff888000c98000 RCX: ffff888000a98000
RDX: 0000000000000000 RSI: 0000000000000fe0 RDI: 0000000000000007
RBP: 0000000000000fe0 R08: ffffffff84f0ce81 R09: 1ffffffff2038f3d
R10: dffffc0000000000 R11: fffffbfff2038f3e R12: 0000000000000fe0
R13: 0000000000000000 R14: ffff888000c98020 R15: 000055fa022e3302
 getname_flags+0xf1/0x540 fs/namei.c:150
 vfs_fstatat+0x12c/0x190 fs/stat.c:340
 __do_sys_newfstatat fs/stat.c:505 [inline]
 __se_sys_newfstatat fs/stat.c:499 [inline]
 __x64_sys_newfstatat+0x11d/0x1a0 fs/stat.c:499
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f54263165f4
Code: 64 c7 00 09 00 00 00 83 c8 ff c3 48 89 f2 b9 00 01 00 00 48 89 fe bf 9c ff ff ff e9 00 00 00 00 41 89 ca b8 06 01 00 00 0f 05 <45> 31 c0 3d 00 f0 ff ff 76 10 48 8b 15 03 a8 0d 00 f7 d8 41 83 c8
RSP: 002b:00007ffdd2708538 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 000055fa11aa7030 RCX: 00007f54263165f4
RDX: 00007ffdd2708548 RSI: 000055fa022e3302 RDI: 00000000ffffff9c
RBP: 000055fa11a8f910 R08: 00000000ffffffff R09: 7fffffffffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 000055fa022f75e8
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:sg_page include/linux/scatterlist.h:171 [inline]
RIP: 0010:sg_phys include/linux/scatterlist.h:389 [inline]
RIP: 0010:perf_trace_dma_unmap_sg+0x784/0x790 include/trace/events/dma.h:224
Code: 00 48 8b 54 24 08 e9 6b fe ff ff e8 06 7d 17 00 48 c7 c7 60 79 94 8e 4c 89 f6 e8 27 33 74 03 e9 5b fa ff ff e8 ed 7c 17 00 90 <0f> 0b e8 f5 ea 43 0a 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000007aa0 EFLAGS: 00010006
RAX: ffffffff817d37f3 RBX: ffff888000630288 RCX: ffff888000a98000
RDX: 0000000000010000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90000007bd0 R08: ffffffff817d34eb R09: 322e66313a30303a
R10: dffffc0000000000 R11: fffff91ffff86f4c R12: 0000000000000008
R13: ffff88801cfa9f81 R14: ffff8880006302a8 R15: dffffc0000000000
FS:  00007f54266ba280(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055fa022e3302 CR3: 0000000011df4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	2b 00                	sub    (%rax),%eax
   2:	74 08                	je     0xc
   4:	4c 89 f7             	mov    %r14,%rdi
   7:	e8 ba 5a 8d 00       	call   0x8d5ac6
   c:	f6 44 24 61 02       	testb  $0x2,0x61(%rsp)
  11:	0f 85 85 01 00 00    	jne    0x19c
  17:	41 f7 c7 00 02 00 00 	test   $0x200,%r15d
  1e:	74 01                	je     0x21
  20:	fb                   	sti
  21:	48 c7 44 24 40 0e 36 	movq   $0x45e0360e,0x40(%rsp)
  28:	e0 45
* 2a:	4b c7 44 25 00 00 00 	movq   $0x0,0x0(%r13,%r12,1) <-- trapping instruction
  31:	00 00
  33:	43 c7 44 25 09 00 00 	movl   $0x0,0x9(%r13,%r12,1)
  3a:	00 00
  3c:	43                   	rex.XB
  3d:	c7                   	.byte 0xc7
  3e:	44                   	rex.R
  3f:	25                   	.byte 0x25


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

