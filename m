Return-Path: <linux-kernel+bounces-192328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7658D1B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BC8283A40
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B24716D33F;
	Tue, 28 May 2024 12:47:25 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C04516C458
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900444; cv=none; b=EkwAfT/53Ahp9AnTaYZufGhBDGQ7F7hPGtvqj3cRke/xFesPThQ8fc+1uJrujfbCnN49Ajbkc2gHEaTlTBgDxDGrThN3iM2cKQ4PB4isipfJs6OiOmzT0rzLAN08x64sJTYbvVPCbIk9tuM6gTbeti01478HtFG6YE9DSRBIV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900444; c=relaxed/simple;
	bh=d6HdwwqiQKkBzqWVEeen/V/hv/j8NFJv4Dhj9E3X3uI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hI5i96+KGKUbB2WEyBdUALg61JQEYKmAZUXb0msnpX/WG9uIoe3NDm1QXXV2TKxgiJgNc0W2zqOjAbcgcEGBL1e5Ii3LF6fdlLviNJAZgaNMoU7TS9SGvdTs9P0YdPzyJTcL9IJPXhVMPHf3YgodcY4X88xItdgj8ce121zViT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e8dc9db8deso253541939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716900442; x=1717505242;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eKByMUSln3YpJqSGq7NAC/de7nm/SrQT/ANcO9KkAnM=;
        b=utLjTbD98IeWuszP9IIyKNcUDgRaXlxHqkgNqakewBgseVpiLAZ0uYtirfNKvq2YPP
         XDTbD+RmB9SgzIG9jyyqAH08iPhMcHl/UIGKf0xT0Y/CHLE5xR96/FGXvBnGsLo0ihGu
         NJgtEwLs7aw8OuptJkOv7FGtNSgrDBrVsAV/swbQO9t9Co/DtLKGDOtBr5NLRzElM6WZ
         ufIoNTScfRhoCGwEN0gAwfeXY0P7bvyAxUSo7JH+fW0awaI4P9kjuFSpZLma+AgTUsN3
         BqDLidkcg2EMnqzJEuvue4E3PNgCbUKZxXliwyIKal8LwQkaj3+66g+c6v6lvBIY8mlY
         9EXw==
X-Forwarded-Encrypted: i=1; AJvYcCUGxsIOzdpexeeZgyWZIduwIZRU8b0FFCUv4GhYrs3kQnK/K6Zp2vOEcdOOepA6UZExFPKW3IYbc3CKhy4YjfyPW4tpkgS8M+oNfqMw
X-Gm-Message-State: AOJu0YzOJCmQK1S9ADYM16I9JdDDyrjChHmNKREUPkExS02eY04Ud49i
	72/pIiw0QZElgLHPdRvsrUVrktq2sL9yc3AjDAjElJ2EOoIhAYfcW9VhFPxo9aoul81vW9Fr2KD
	isLtCDPGsadDZQ8QaZ6mdOZjXP2Y4WEvirWQUAKqEuR/XBYv9VvA8m+8=
X-Google-Smtp-Source: AGHT+IHlDQwhgKNAltPiOppZ7hyht/5rneTl34Nm4QQgK1LRJ8PA3hzkEuHJNHded3tZr14+s02DI6F1Q5EXX/UmVA2dJ0NQLu8p
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:874a:0:b0:373:8d04:28b2 with SMTP id
 e9e14a558f8ab-3738d0429b7mr4203945ab.0.1716900442296; Tue, 28 May 2024
 05:47:22 -0700 (PDT)
Date: Tue, 28 May 2024 05:47:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa65d80619830888@google.com>
Subject: [syzbot] [arm?] BUG: unable to handle kernel paging request in task_h_load
From: syzbot <syzbot+8336c747d79a4c3a0944@syzkaller.appspotmail.com>
To: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6d69b6c12fce Merge tag 'nfs-for-6.10-1' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164ce7f0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=21de3d423116c304
dashboard link: https://syzkaller.appspot.com/bug?extid=8336c747d79a4c3a0944
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119fbe58980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a8443c980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-6d69b6c1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9fa4d7c3665d/vmlinux-6d69b6c1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/131ac291917c/Image-6d69b6c1.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8336c747d79a4c3a0944@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address 007000000621a118
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[007000000621a118] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3189 Comm: syz-executor371 Not tainted 6.9.0-syzkaller-12124-g6d69b6c12fce #0
Hardware name: linux,dummy-virt (DT)
pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : cfs_rq_of kernel/sched/sched.h:1468 [inline]
pc : update_cfs_rq_h_load kernel/sched/fair.c:9441 [inline]
pc : task_h_load+0x40/0xb8 kernel/sched/fair.c:9466
lr : detach_tasks kernel/sched/fair.c:9181 [inline]
lr : sched_balance_rq+0x80c/0xc94 kernel/sched/fair.c:11375
sp : ffff80008000bd50
x29: ffff80008000bd50 x28: f8f0000004c62538 x27: ffff8000825e3308
x26: 0000000000000001 x25: fff000007f8d6de0 x24: ffff80008000bf14
x23: fff000007f8d6340 x22: fff000007f8d6340 x21: fff000007f8d6d40
x20: ffff80008000be78 x19: f8f0000004c62480 x18: ffffffffffffffff
x17: fff07ffffd331000 x16: ffff800080008000 x15: 0000000000000001
x14: 000000000000000a x13: 0000000000000000 x12: 0000000000000011
x11: 0000000000000001 x10: 0000000000000001 x9 : 0000000000000da8
x8 : fff000007f8d6440 x7 : f4f000000621a200 x6 : 0000000000000001
x5 : 00000000ffffbd09 x4 : ffff80008000be78 x3 : f5f000000602ff40
x2 : f87000000621a080 x1 : 00000000ffffa6e9 x0 : f8f0000004c62480
Call trace:
 update_cfs_rq_h_load kernel/sched/fair.c:9440 [inline]
 task_h_load+0x40/0xb8 kernel/sched/fair.c:9466
 sched_balance_domains+0x270/0x3ac kernel/sched/fair.c:11798
 sched_balance_softirq+0x50/0x74 kernel/sched/fair.c:12503
 handle_softirqs+0x10c/0x240 kernel/softirq.c:554
 __do_softirq+0x14/0x20 kernel/softirq.c:588
 ____do_softirq+0x10/0x1c arch/arm64/kernel/irq.c:81
 call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x1c/0x28 arch/arm64/kernel/irq.c:86
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbc/0xd8 kernel/softirq.c:649
 __el1_irq arch/arm64/kernel/entry-common.c:537 [inline]
 el1_interrupt+0x38/0x64 arch/arm64/kernel/entry-common.c:551
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:556
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:594
 __pte_offset_map+0x2c/0x100 mm/pgtable-generic.c:292
 pte_offset_map_nolock+0x38/0xb0 mm/pgtable-generic.c:314
 handle_pte_fault mm/memory.c:5366 [inline]
 __handle_mm_fault+0x2e8/0xc20 mm/memory.c:5523
 handle_mm_fault+0x68/0x27c mm/memory.c:5688
 do_page_fault+0xf8/0x480 arch/arm64/mm/fault.c:578
 do_translation_fault+0xac/0xbc arch/arm64/mm/fault.c:690
 do_mem_abort+0x44/0x94 arch/arm64/mm/fault.c:826
 el0_ia+0xa4/0x118 arch/arm64/kernel/entry-common.c:598
 el0t_64_sync_handler+0xd0/0x12c arch/arm64/kernel/entry-common.c:736
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
Code: b5000082 1400001c f9404842 b4000382 (f9404c41) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	b5000082 	cbnz	x2, 0x10
   4:	1400001c 	b	0x74
   8:	f9404842 	ldr	x2, [x2, #144]
   c:	b4000382 	cbz	x2, 0x7c
* 10:	f9404c41 	ldr	x1, [x2, #152] <-- trapping instruction


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

