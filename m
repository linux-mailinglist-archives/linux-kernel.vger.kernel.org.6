Return-Path: <linux-kernel+bounces-393884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FC39BA6B5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 17:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D592C1C219A0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 16:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D756187872;
	Sun,  3 Nov 2024 16:49:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1194182D98
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730652568; cv=none; b=YK3WsgjdoESh3kno2yVhgy62HfHtZdGQM1bt9xwQ0gVO5NhCVHxVSolmbuaxER+pYdtCgZBDzYhT2EIB0BULpGITDowCAA9V3y5+7q9cjqs6UiE8xkWfUaHjSmrlm4dvAUkG5Iq6bFNZ2rNBKAC7jrMiDoe+p6oZG2GUz3ZHHRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730652568; c=relaxed/simple;
	bh=MWayfOoYTk3jlKG9sOeIHQNhH68LxVtqO+7luFqh5ak=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jyJbzjm0svgM38Si/m/zAMgovDY2jspOW+zsEdOSSVWHqwEiKHCgOoC9QfolizxTrSLVAO3zvxGQWtV8uXllLolIX+2TztPb+yl4m1TuY2d6ey3fogaYdnjHtMnXZOuY3MFC3vVwpQGP38mjdslX5F/r/UEc6xw/qv9FC0jjHZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6c48f1312so10166095ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 08:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730652566; x=1731257366;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FqpQFFKDqAQo/so02YCi7q/gPAA3FA9qyNVSUpoQM2s=;
        b=GACuQuVlAcbTaFpWOfJZpCZZd7Kf+hZCZRIx1/VTmJdJjbTlps+UVdDxKekLEEKKCw
         8jCc2+clc6BfWHZ6e2pwjBJa1wt7VVfWAT9AB1tRdmBfPOsH/fk8UbBkCrOcqeYeeaIs
         FBA4DPcUca6T1m7s5F6pCbxdLSFQ90NH+8D+X0yem5RAlqI/M3LHV1YOa9Z1pLf6l04i
         z0l8CT787dQPeu08u70f1c7LyyyyJNDxwFKez/ISmFfP9diBpQu7uWZTWH71UMCH98CP
         2W6cCCR8m82As0kcH3pT47Fc3quuGmeiZtBSmSWOzHi07dieiJBfl1dxEQTb2wqHLonC
         k/Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWHR9pG/vUZzYF1Dck5iTqID46psHh9xd0phXr8oEGagavQGAy2x2DmtLfpwYcZ60tebeE1ze/Cx1pHoyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFEhRS6rnSdXhNlWti+BSRAa0itBzqHp/tcQshDZPpM83uKiek
	J3FHzMmVBslLzl6QetMDQv75NOGeLqf5SlskNTVm9r2GVHRbQEVedYwHPGmFlwF3+MLuAEwzLsX
	pwJuvBR+FMNNZjbItNml3xhnkVYKKEe94SSHtUmMSSj5olwQVFkzu92g=
X-Google-Smtp-Source: AGHT+IHAKzezrCC0XqgrCQs1wnM6U2XoK/MVl04p1R5SYnQa3RmROKbCqcjAhZSzVA/8fEiiY27AyQvui1dmCkgHIeDm7zq1sHkk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c07:b0:3a6:cac0:1299 with SMTP id
 e9e14a558f8ab-3a6cac01324mr14353105ab.14.1730652566149; Sun, 03 Nov 2024
 08:49:26 -0800 (PST)
Date: Sun, 03 Nov 2024 08:49:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6727a996.050a0220.35b515.019e.GAE@google.com>
Subject: [syzbot] [mm?] WARNING: locking bug in __set_page_owner
From: syzbot <syzbot+56dc65adbd1d2ae1f844@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f9f24ca362a4 Add linux-next specific files for 20241031
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11ac6630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
dashboard link: https://syzkaller.appspot.com/bug?extid=56dc65adbd1d2ae1f844
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171232a7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb84549dd6b3/disk-f9f24ca3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/beb29bdfa297/vmlinux-f9f24ca3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8881fe3245ad/bzImage-f9f24ca3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+56dc65adbd1d2ae1f844@syzkaller.appspotmail.com

=============================
[ BUG: Invalid wait context ]
6.12.0-rc5-next-20241031-syzkaller #0 Not tainted
-----------------------------
syz.1.44/6083 is trying to lock:
ffffffff8ea733d8 (stack_list_lock){-.-.}-{3:3}, at: add_stack_record_to_list mm/page_owner.c:182 [inline]
ffffffff8ea733d8 (stack_list_lock){-.-.}-{3:3}, at: inc_stack_record_count mm/page_owner.c:214 [inline]
ffffffff8ea733d8 (stack_list_lock){-.-.}-{3:3}, at: __set_page_owner+0x5cb/0x800 mm/page_owner.c:329
other info that might help us debug this:
context-{2:2}
1 lock held by syz.1.44/6083:
 #0: ffff8880240995e0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock include/linux/mmap_lock.h:129 [inline]
 #0: ffff8880240995e0 (&mm->mmap_lock){++++}-{4:4}, at: exit_mmap+0x2da/0xcb0 mm/mmap.c:1701
stack backtrace:
CPU: 1 UID: 0 PID: 6083 Comm: syz.1.44 Not tainted 6.12.0-rc5-next-20241031-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
 check_wait_context kernel/locking/lockdep.c:4898 [inline]
 __lock_acquire+0x15a8/0x2100 kernel/locking/lockdep.c:5176
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 add_stack_record_to_list mm/page_owner.c:182 [inline]
 inc_stack_record_count mm/page_owner.c:214 [inline]
 __set_page_owner+0x5cb/0x800 mm/page_owner.c:329
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1541
 prep_new_page mm/page_alloc.c:1549 [inline]
 get_page_from_freelist+0x3725/0x3870 mm/page_alloc.c:3495
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4771
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 stack_depot_save_flags+0x666/0x830 lib/stackdepot.c:627
 kasan_save_stack+0x4f/0x60 mm/kasan/common.c:48
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
 task_work_add+0xd9/0x490 kernel/task_work.c:77
 __run_posix_cpu_timers kernel/time/posix-cpu-timers.c:1219 [inline]
 run_posix_cpu_timers+0x6ac/0x810 kernel/time/posix-cpu-timers.c:1418
 tick_sched_handle kernel/time/tick-sched.c:276 [inline]
 tick_nohz_handler+0x37c/0x500 kernel/time/tick-sched.c:297
 __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
 __hrtimer_run_queues+0x551/0xd50 kernel/time/hrtimer.c:1755
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1817
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x420 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:variable_ffs arch/x86/include/asm/bitops.h:321 [inline]
RIP: 0010:handle_softirqs+0x1e3/0x980 kernel/softirq.c:542
Code: 7c 24 70 45 0f b7 e4 48 c7 c7 20 c5 09 8c e8 c4 6c 6c 0a 65 66 c7 05 32 53 ac 7e 00 00 e8 05 67 45 00 fb 49 c7 c6 c0 a0 60 8e <b8> ff ff ff ff 41 0f bc c4 41 89 c7 41 ff c7 0f 84 eb 03 00 00 44
RSP: 0018:ffffc90000a18e40 EFLAGS: 00000286
RAX: b8b036f9cad4b600 RBX: ffffc90000a18ee0 RCX: ffffffff8170c69a
RDX: dffffc0000000000 RSI: ffffffff8c0ad3a0 RDI: ffffffff8c604dc0
RBP: ffffc90000a18f50 R08: ffffffff942cd877 R09: 1ffffffff2859b0e
R10: dffffc0000000000 R11: fffffbfff2859b0f R12: 0000000000000010
R13: 0000000000000000 R14: ffffffff8e60a0c0 R15: 1ffff11004bb4780
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 common_interrupt+0xb9/0xd0 arch/x86/kernel/irq.c:278
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
RIP: 0010:lock_is_held_type+0x13b/0x190
Code: 75 44 48 c7 04 24 00 00 00 00 9c 8f 04 24 f7 04 24 00 02 00 00 75 4c 41 f7 c4 00 02 00 00 74 01 fb 65 48 8b 04 25 28 00 00 00 <48> 3b 44 24 08 75 42 89 d8 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f
RSP: 0018:ffffc9000307f618 EFLAGS: 00000206
RAX: b8b036f9cad4b600 RBX: 0000000000000001 RCX: ffff888025da3c00
RDX: ffff888025da3c00 RSI: ffffffff8c0ae580 RDI: ffffffff8c604dc0
RBP: 0000000000000000 R08: ffffffff81e2d437 R09: ffffffff8bb86877
R10: 0000000000000004 R11: ffff888025da3c00 R12: 0000000000000246
R13: ffff888025da3c00 R14: 0000000000000000 R15: ffff8880240995e0
 rwsem_assert_held_write include/linux/rwsem.h:203 [inline]
 mmap_assert_write_locked include/linux/mmap_lock.h:70 [inline]
 __is_vma_write_locked include/linux/mm.h:747 [inline]
 vma_start_write include/linux/mm.h:766 [inline]
 free_pgtables+0x433/0x840 mm/memory.c:406
 exit_mmap+0x4cd/0xcb0 mm/mmap.c:1704
 __mmput+0x115/0x390 kernel/fork.c:1344
 exit_mm+0x220/0x310 kernel/exit.c:570
 do_exit+0x9b2/0x28e0 kernel/exit.c:925
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 get_signal+0x16a3/0x1740 kernel/signal.c:2884
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3e8657e719
Code: Unable to access opcode bytes at 0x7f3e8657e6ef.
RSP: 002b:00007f3e872b30e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 00007f3e86735f88 RCX: 00007f3e8657e719
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f3e86735f8c
RBP: 00007f3e86735f80 R08: 7fffffffffffffff R09: 0000000000000000
R10: 000000000000003c R11: 0000000000000246 R12: 00007f3e86735f8c
R13: 0000000000000000 R14: 00007fff211a29e0 R15: 00007fff211a2ac8
 </TASK>
----------------
Code disassembly (best guess):
   0:	7c 24                	jl     0x26
   2:	70 45                	jo     0x49
   4:	0f b7 e4             	movzwl %sp,%esp
   7:	48 c7 c7 20 c5 09 8c 	mov    $0xffffffff8c09c520,%rdi
   e:	e8 c4 6c 6c 0a       	call   0xa6c6cd7
  13:	65 66 c7 05 32 53 ac 	movw   $0x0,%gs:0x7eac5332(%rip)        # 0x7eac534f
  1a:	7e 00 00
  1d:	e8 05 67 45 00       	call   0x456727
  22:	fb                   	sti
  23:	49 c7 c6 c0 a0 60 8e 	mov    $0xffffffff8e60a0c0,%r14
* 2a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax <-- trapping instruction
  2f:	41 0f bc c4          	bsf    %r12d,%eax
  33:	41 89 c7             	mov    %eax,%r15d
  36:	41 ff c7             	inc    %r15d
  39:	0f 84 eb 03 00 00    	je     0x42a
  3f:	44                   	rex.R


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

