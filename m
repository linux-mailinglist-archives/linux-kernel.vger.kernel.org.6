Return-Path: <linux-kernel+bounces-216871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F131890A7C5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742981F23DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7D218FDAB;
	Mon, 17 Jun 2024 07:54:23 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D708138396
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718610863; cv=none; b=a4HYuO06bm2OTR1xpRKHBbwCbWujloA7gEzAU7GLN7SdSS2TFsLEbs9b3q4Lv+eIcK7bjbDEp69vCQGwupzzZdPEysJr9oGw/3qzAo7Ef4D+vqxrxUlsCN2USXH49DmiOIn5jye7TAQyyxyrO9y9kEyQrY0B6VEyuEXy6bx1GwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718610863; c=relaxed/simple;
	bh=BcDumrzhJHX3BFZpVrgs8bCIW5Chag3b1JiIMKiW+1w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k3XKBBp6v7SJKHwL1ufSXnSa6rtyIyL/RjcuoOvSoNo2EpJg59whA/ozBEObs9O+S00x7nUObnr/sovpeCv6gYj9xkXP6PFUVsG7DB6+Y07hjR3JRHB/4EsqCqBxXmkf9L2TAy+2abvyuCpEwABXSeOd2bAGa2uFjsrV511LtZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7eee4ffd19eso109280339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 00:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718610861; x=1719215661;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IL4TW/EgcknLwrn0dgOHn6yHg3+UpWQBoLA7pbtdQ1c=;
        b=LMp2w4LJJU0MUAfRxVZUeUIKK3woathtl+J17pSeGwo3AeNah5kdTa1JgFzlR7MwHE
         xD6mzGP/ZRq5420UGjBZbzBZy3eCbkVH8XA+RBeNsC5roAUhIkd9peQRPX2H0M6aBamI
         KJYXE6MK77oNi4s7e7H0r6oKQ9eryjMwXZ2s9TTtnIPThAo7bleemIUM8rdN3eIHW4Nv
         nbobsTcWdeSgPc6GNFhj4YN2cRzs1fzWKbA5JbABbn/4NlhJzRM36rY2GehZLl7Efdz+
         1RegVU9f/2cYOSXd+37GDejSwcZ/OKUsT+9o3ZapRlwX/L7dz4R7itHW+20wctNT5dfl
         QqZA==
X-Forwarded-Encrypted: i=1; AJvYcCW6wTRWe5vbdmkKQaw/SZautcfHX6YrTK9LE0mJHiVo5fa2u2rxL/pghXGJXg2aAfYZBW6xXitOpFgGLW3OudSnua4cC3Y2o0d7yk6I
X-Gm-Message-State: AOJu0YzIsuIVnlqpONA4VQiXwwai3Knp5tUVVG0X/zWRVZfBNWPzpMy4
	nu6oGMhtP56nczO6qwx4DXYBAFdW6pRAX6qlXfglHnCh/HXZAr87rYiXTmxhaMZ8N/Uq7xBkWB5
	v+7A0MA4PUI9kNP2h4lvs5xTBalN7U8nwJCfOw3S8ZjxkR3y1PSsqHWw=
X-Google-Smtp-Source: AGHT+IFUhkn3WFmHdHTQBc9dtTTmorC7CDJAqII+Pbbz7a8XT6qZH0Lq6ZHtGymXONx22uxp9Scpobr+6wjqwqjp+38nGO/dpUZB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8524:b0:4b7:ba50:7059 with SMTP id
 8926c6da1cb9f-4b963fa6971mr441709173.2.1718610861051; Mon, 17 Jun 2024
 00:54:21 -0700 (PDT)
Date: Mon, 17 Jun 2024 00:54:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e175c3061b1145e8@google.com>
Subject: [syzbot] [gfs2?] WARNING: held lock freed in __flush_workqueue
From: syzbot <syzbot+62f0a214565ddd1969d5@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a957267fa7e9 Add linux-next specific files for 20240611
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13d6beda980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a880e96898e79f8
dashboard link: https://syzkaller.appspot.com/bug?extid=62f0a214565ddd1969d5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6451759a606b/disk-a957267f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7f635dbe5b8a/vmlinux-a957267f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/33eafd1b8aec/bzImage-a957267f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+62f0a214565ddd1969d5@syzkaller.appspotmail.com

=========================
WARNING: held lock freed!
6.10.0-rc3-next-20240611-syzkaller #0 Not tainted
-------------------------
syz-executor.0/7578 is freeing memory ffff88823bdf8000-ffff88823bdf81ff, with a lock still held there!
ffff88823bdf8148 (&x->wait#58){+.+.}-{2:2}, at: touch_wq_lockdep_map kernel/workqueue.c:3895 [inline]
ffff88823bdf8148 (&x->wait#58){+.+.}-{2:2}, at: __flush_workqueue+0x1b0/0x1710 kernel/workqueue.c:3937
3 locks held by syz-executor.0/7578:
 #0: ffff8880221960e0 (&type->s_umount_key#107/1){+.+.}-{3:3}, at: alloc_super+0x221/0x9d0 fs/super.c:344
 #1: ffff88823bdf8148 (&x->wait#58){+.+.}-{2:2}, at: touch_wq_lockdep_map kernel/workqueue.c:3895 [inline]
 #1: ffff88823bdf8148 (&x->wait#58){+.+.}-{2:2}, at: __flush_workqueue+0x1b0/0x1710 kernel/workqueue.c:3937
 #2: ffffffff8e335560 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #2: ffffffff8e335560 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2558 [inline]
 #2: ffffffff8e335560 (rcu_callback){....}-{0:0}, at: rcu_core+0xa86/0x1830 kernel/rcu/tree.c:2838

stack backtrace:
CPU: 0 PID: 7578 Comm: syz-executor.0 Not tainted 6.10.0-rc3-next-20240611-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:91 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:117
 print_freed_lock_bug kernel/locking/lockdep.c:6607 [inline]
 debug_check_no_locks_freed+0x3ca/0x4b0 kernel/locking/lockdep.c:6642
 slab_free_hook mm/slub.c:2178 [inline]
 slab_free mm/slub.c:4455 [inline]
 kfree+0xfa/0x360 mm/slub.c:4576
 rcu_do_batch kernel/rcu/tree.c:2564 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2838
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5821
Code: 2b 00 74 08 4c 89 f7 e8 1a 18 8a 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0000:ffffc9000fdcf5c0 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff92001fb9ec4 RCX: e87e0b6d03ed4800
RDX: dffffc0000000000 RSI: ffffffff8bcad320 RDI: ffffffff8c200760
RBP: ffffc9000fdcf708 R08: ffffffff92fcb8ff R09: 1ffffffff25f971f
R10: dffffc0000000000 R11: fffffbfff25f9720 R12: 1ffff92001fb9ec0
R13: dffffc0000000000 R14: ffffc9000fdcf620 R15: 0000000000000246
 touch_wq_lockdep_map kernel/workqueue.c:3895 [inline]
 __flush_workqueue+0x1c9/0x1710 kernel/workqueue.c:3937
 drain_workqueue+0xc9/0x3a0 kernel/workqueue.c:4101
 destroy_workqueue+0xba/0xc40 kernel/workqueue.c:5812
 gfs2_fill_super+0x12a4/0x2520 fs/gfs2/ops_fstype.c:1311
 get_tree_bdev+0x3f7/0x570 fs/super.c:1615
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0x90/0x2a0 fs/super.c:1780
 do_new_mount+0x2be/0xb40 fs/namespace.c:3379
 do_mount fs/namespace.c:3719 [inline]
 __do_sys_mount fs/namespace.c:3925 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3902
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe59f07e5aa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe59fe7eef8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fe59fe7ef80 RCX: 00007fe59f07e5aa
RDX: 00000000200003c0 RSI: 0000000020037f80 RDI: 00007fe59fe7ef40
RBP: 00000000200003c0 R08: 00007fe59fe7ef80 R09: 0000000000008000
R10: 0000000000008000 R11: 0000000000000202 R12: 0000000020037f80
R13: 00007fe59fe7ef40 R14: 0000000000037f59 R15: 0000000020000400
 </TASK>
----------------
Code disassembly (best guess):
   0:	2b 00                	sub    (%rax),%eax
   2:	74 08                	je     0xc
   4:	4c 89 f7             	mov    %r14,%rdi
   7:	e8 1a 18 8a 00       	call   0x8a1826
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

