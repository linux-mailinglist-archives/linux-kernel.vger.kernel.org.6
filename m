Return-Path: <linux-kernel+bounces-231040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F21091854F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81BD31C22EF1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A4E18A945;
	Wed, 26 Jun 2024 15:08:30 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356A018A933
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414509; cv=none; b=sK8CGDSYyL3bM1vAt3oo2UmmeJ0t3vOXET8EYWr85LwTZsaqv3zBUHFESOfwcgl3hAQ/Lt7WmL/5j/zYaUGAIxweytGD5ARfoky9UmS8TZJm34ZYf4qOtaK7CjYP3IQsO0f10qiSKgwMR1PUinY3fc1e/PoB64aENt9u7hTajiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414509; c=relaxed/simple;
	bh=Z28nw4Be5lF0BrjneTtWwGZHoZzVk0Fhi0aDYLMehj0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=loDWDAlQ2ibEY7mcZtOEGefQFYVFXRWGfZQOYARRyx4ao2iQdtAVq9ggQ82AO+JV4TIuEh13x2uZmFm0svv3ZpajgvIG8BqxIZn5dtwLhAg+Auv9b76ziSJuMag/c8xKL9+cxKMpP6+1qu9vuoDojKNyGg5WKHM/azDns3Fqhp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7f3caa9e180so54028039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719414507; x=1720019307;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNuJYH4t+Px7VHVw4CWIh/iouyiSsVveGQ6khPzcmic=;
        b=JGO0yMAaRlJissAAg5AUNXGUpg6xw3E/NKka9rzljxUs9pZnxhKMKyRwD+NcjfGjyy
         L+Vc29DNT7zHtx+1nF71U/C6z1yVPe2c/+ZF2tdkAW/4glkAKQsMJr/gilCowUfRRpWc
         1upT2eKZFqtqNvf0osL/RDtiI225ZxKWLzY2GpWXtnkNjHmQG4ah1Yf8TlZKdJXbOmuJ
         7mDvXpeu/QZv50c6HIOC1sSLsMxSzhDdvApCGbmBru6VG9eT+GBGiz+BxS1o6btU5wx0
         FBuIatSbEuAK3g25YO+hwwoE1R6UfsrXJcOJUGn2J4RTPH2A5SsE9QgYnlX/zpUuBWUa
         X5ww==
X-Forwarded-Encrypted: i=1; AJvYcCU0OdITkdwthzkuPdYOTU8P8pfuxit1IzzX/QrOshK4ay+6ZdT6XYz9jr5F2vufwK4itPgJwXJuMBDm4MmUzmAM4v42qsOqGKkD1Tia
X-Gm-Message-State: AOJu0YyygoVAfFSDTsMS/vDQ43tjlDUArco588/HTePnkQKV4TDe/TFX
	v3X5KLeP1yhJ8Lw7lnJLx2+/SphgWi+ZWaQD3Lhq+FnT9gB5z4Bb6Dklzh680adRdkUIn+MFwSE
	YY46TrzfjKWMxDydmaBRD0NiQauR9KK0PDlRgN1uB8hl8e8+l1DQQZd8=
X-Google-Smtp-Source: AGHT+IFwHGbofkgS2soyRDBdSpQRTNQFwFNn/ewkk1FKVMAqgIt8bybDYQQEqX5qOj6dYZ8Y2btaBrjI95c8yZl26wTDRe5+qLQ5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:aa13:0:b0:7f3:ce24:6aca with SMTP id
 ca18e2360f4ac-7f3ce246c4fmr3862239f.2.1719414507312; Wed, 26 Jun 2024
 08:08:27 -0700 (PDT)
Date: Wed, 26 Jun 2024 08:08:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee282d061bcc6245@google.com>
Subject: [syzbot] [kernel?] KASAN: stack-out-of-bounds Read in
 unwind_next_frame (2)
From: syzbot <syzbot+fc5141fdfb1e59951d38@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	jpoimboe@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f76698bd9a8c Add linux-next specific files for 20240621
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12f0a161980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca79e3c3b9118bd0
dashboard link: https://syzkaller.appspot.com/bug?extid=fc5141fdfb1e59951d38
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f204c5d02251/disk-f76698bd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/50289c7e8999/vmlinux-f76698bd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c360e133a94f/bzImage-f76698bd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fc5141fdfb1e59951d38@syzkaller.appspotmail.com

RBP: dffffc0000000000 R08: ffffffff8a2d136b R09: 1ffffffff25fc8e8
R10: dffffc0000000000 R11: fffffbfff25fc8e9 R12: ffffc900041576a0
R13: ffff8880291b0700 R14: ffff8880291b0700 R15: 1ffff110052360e0
==================================================================
BUG: KASAN: stack-out-of-bounds in user_mode arch/x86/include/asm/ptrace.h:214 [inline]
BUG: KASAN: stack-out-of-bounds in unwind_next_frame+0x2177/0x2a00 arch/x86/kernel/unwind_orc.c:482
Read of size 2 at addr ffffc900041575d0 by task syz-executor.2/7607

CPU: 1 UID: 0 PID: 7607 Comm: syz-executor.2 Not tainted 6.10.0-rc4-next-20240621-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 user_mode arch/x86/include/asm/ptrace.h:214 [inline]
 unwind_next_frame+0x2177/0x2a00 arch/x86/kernel/unwind_orc.c:482
 show_trace_log_lvl+0x381/0x520 arch/x86/kernel/dumpstack.c:296
 sched_show_task+0x578/0x740 kernel/sched/core.c:7503
 report_rtnl_holders+0x1ba/0x2d0 net/core/rtnetlink.c:104
 call_timer_fn+0x18e/0x650 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers kernel/time/timer.c:2417 [inline]
 __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2428
 run_timer_base kernel/time/timer.c:2437 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2447
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
RIP: 0010:finish_task_switch+0x1ea/0x870 kernel/sched/core.c:5123
Code: c9 50 e8 69 b8 0b 00 48 83 c4 08 4c 89 f7 e8 dd 38 00 00 e9 de 04 00 00 4c 89 f7 e8 30 a6 34 0a e8 ab 84 37 00 fb 48 8b 5d c0 <48> 8d bb f8 15 00 00 48 89 f8 48 c1 e8 03 49 be 00 00 00 00 00 fc
RSP: 0018:ffffc90003c57288 EFLAGS: 00000282
RAX: 9195a65d1261f900 RBX: ffff888024c8da00 RCX: ffffffff816fd09a
RDX: dffffc0000000000 RSI: ffffffff8bcac8a0 RDI: ffffffff8c206c80
RBP: ffffc90003c572d0 R08: ffffffff92fe47ef R09: 1ffffffff25fc8fd
R10: dffffc0000000000 R11: fffffbfff25fc8fe R12: 1ffff110172a7ec7
R13: dffffc0000000000 R14: ffff8880b943e8c0 R15: ffff8880b953f638
 context_switch kernel/sched/core.c:5252 [inline]
 __schedule+0x17f0/0x4a20 kernel/sched/core.c:6594
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6773
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6797
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0x130/0x140 kernel/locking/spinlock.c:194
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 __wake_up_common_lock+0x18c/0x1e0 kernel/sched/wait.c:108
 __unix_dgram_recvmsg+0x5f4/0x12f0 net/unix/af_unix.c:2415
 sock_recvmsg_nosec+0x18e/0x1d0 net/socket.c:1046
 ____sys_recvmsg+0x3c0/0x470 net/socket.c:2814
 ___sys_recvmsg net/socket.c:2858 [inline]
 do_recvmmsg+0x474/0xae0 net/socket.c:2952
 __sys_recvmmsg net/socket.c:3031 [inline]
 __do_sys_recvmmsg net/socket.c:3054 [inline]
 __se_sys_recvmmsg net/socket.c:3047 [inline]
 __x64_sys_recvmmsg+0x199/0x250 net/socket.c:3047
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc27d67d0a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc27e3920c8 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007fc27d7b4050 RCX: 00007fc27d67d0a9
RDX: 0000000000010106 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00007fc27d6ec074 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fc27d7b4050 R15: 00007fff5b81d208
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc90004150000, ffffc90004159000) created by:
 copy_process+0x5d1/0x3d90 kernel/fork.c:2206

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2226b
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 2, tgid 2 (kthreadd), ts 7469715658, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x2ccb/0x2d80 mm/page_alloc.c:3487
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4745
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2263
 vm_area_alloc_pages mm/vmalloc.c:3576 [inline]
 __vmalloc_area_node mm/vmalloc.c:3652 [inline]
 __vmalloc_node_range_noprof+0x971/0x1460 mm/vmalloc.c:3833
 alloc_thread_stack_node kernel/fork.c:313 [inline]
 dup_task_struct+0x444/0x8c0 kernel/fork.c:1114
 copy_process+0x5d1/0x3d90 kernel/fork.c:2206
 kernel_clone+0x226/0x8f0 kernel/fork.c:2788
 kernel_thread+0x1bc/0x240 kernel/fork.c:2850
 create_kthread kernel/kthread.c:412 [inline]
 kthreadd+0x60d/0x810 kernel/kthread.c:765
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:144
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
page_owner free stack trace missing

Memory state around the buggy address:
 ffffc90004157480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90004157500: 00 00 00 00 f1 f1 f1 f1 00 00 00 f2 f2 f2 f2 f2
>ffffc90004157580: 04 f2 00 f2 f2 f2 00 00 f3 f3 f3 f3 00 00 00 00
                                                 ^
 ffffc90004157600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90004157680: 00 00 00 00 f1 f1 f1 f1 00 00 00 00 00 f2 f2 f2
==================================================================
----------------
Code disassembly (best guess):
   0:	c9                   	leave
   1:	50                   	push   %rax
   2:	e8 69 b8 0b 00       	call   0xbb870
   7:	48 83 c4 08          	add    $0x8,%rsp
   b:	4c 89 f7             	mov    %r14,%rdi
   e:	e8 dd 38 00 00       	call   0x38f0
  13:	e9 de 04 00 00       	jmp    0x4f6
  18:	4c 89 f7             	mov    %r14,%rdi
  1b:	e8 30 a6 34 0a       	call   0xa34a650
  20:	e8 ab 84 37 00       	call   0x3784d0
  25:	fb                   	sti
  26:	48 8b 5d c0          	mov    -0x40(%rbp),%rbx
* 2a:	48 8d bb f8 15 00 00 	lea    0x15f8(%rbx),%rdi <-- trapping instruction
  31:	48 89 f8             	mov    %rdi,%rax
  34:	48 c1 e8 03          	shr    $0x3,%rax
  38:	49                   	rex.WB
  39:	be 00 00 00 00       	mov    $0x0,%esi
  3e:	00 fc                	add    %bh,%ah


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

