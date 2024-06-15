Return-Path: <linux-kernel+bounces-215736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F57909674
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 09:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AEE91C219C9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 07:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619CA16415;
	Sat, 15 Jun 2024 07:06:26 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AF54A1E
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718435185; cv=none; b=sWcRldr//0gw83UBSVA2ZZXIwJDfN8L6R8ISZxtnY38UFRVKUzE/3ekpXYHg2k0HaTWRqU2zfkbwN8SNphMX6u00jEcoMwodvQtLYzt3f1BLqL0Ngm5hqeJYfMw82cyt2dzaQP8YMAd9Tq/fwwXkH2WZVmcaGl4LumICyvRCMVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718435185; c=relaxed/simple;
	bh=6p56Scgh5m4MgP/mLouncxoH2WBqwQkUU5ZLfeV72QA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lv6TPJinwdkSmDTwpvSyfLCdWrs9vpn+cUg5dq4Y6yb5091Rl+O28mev2k1QML9HiYBEbtVmk04OT/uOj1meetVMQ7g8MUDsSoJIfbPSxRM6OTSmdMTBHIJpsMVvn2gxqQG6GQj42+NSHIJ/6XSZ4ux2MpOd0rDQomrvJxgPDTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-37492fe22cdso22532245ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 00:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718435183; x=1719039983;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UY/K+nYcIQSGVpg7Qc+7eYsrYu/lg9DOplLudRc2L/w=;
        b=J2nBX+rJtHrgJ7kqe6SFvpXYlqv+jQKLDhYMytXx2rV/4Z1zMeBIn/jmLEIikB1Rba
         vfbrVl3Fat7wlh+imajc9Yonj/j0y5fM/hZ0rzslhqPkuLkJFYwS81VklsLt29KfHGz/
         B31Dtqi5gV1Cc/FvRQ4r9S3jO/UCnNy1TQYGAPSZCYR1xSMuPLJfXei710eHyGifyBlv
         aFs++SXRfTz2eOx4JrEjhiQpx8M5u4jCOGRRsAwMnLbUXYpq+YzEQzn9ZKXZWm+DzHYi
         MRayFZrrAqyNhyPq7Lk4NO5DVnrJFwozpealKJPLQmpCV5uXaP2y0JbKCVZymlyn4rnm
         kLaA==
X-Forwarded-Encrypted: i=1; AJvYcCWTN0i1AfuRcxcbrZXTgUZ5lCmMgJgFe56H4Jzn4/zgMjXFVad8KeUxsigtFNZ3/8MvP7AVGbGI/I9EHIFBmIEOBEmLtsfbKRc2bX4M
X-Gm-Message-State: AOJu0Yy5YOnQH0fZZjTOafGbasvqfUU5AgsWXyHO6I1VLLLq4ZmfcgyL
	XVz86y3e1InQYtvOiUsQC1rqED6ocPvoD+bH9isxX6R6M4AfW3CMmWzwhyVysz1b5QjUY7TvT/s
	tPL3Lhpgf8ZmrRP/xF8QRjGmSVOGjPMc3xcVN6dW6/Ts/bjPqWv71xaU=
X-Google-Smtp-Source: AGHT+IEInppKTlIdy0IkWdbieMPtI0jJzHBWmkgnZox/l36V/gNqRM2DmME936hMPDHQKg5TH7Izfx1EnNKlui5sYRyFKnCtJcuj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a48:b0:373:8d04:28b2 with SMTP id
 e9e14a558f8ab-375e00059bemr2597325ab.0.1718435183111; Sat, 15 Jun 2024
 00:06:23 -0700 (PDT)
Date: Sat, 15 Jun 2024 00:06:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8c856061ae85e20@google.com>
Subject: [syzbot] [kernel?] KASAN: stack-out-of-bounds Read in __show_regs (2)
From: syzbot <syzbot+e9be5674af5e3a0b9ecc@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a957267fa7e9 Add linux-next specific files for 20240611
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=171e6e56980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a880e96898e79f8
dashboard link: https://syzkaller.appspot.com/bug?extid=e9be5674af5e3a0b9ecc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6451759a606b/disk-a957267f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7f635dbe5b8a/vmlinux-a957267f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/33eafd1b8aec/bzImage-a957267f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e9be5674af5e3a0b9ecc@syzkaller.appspotmail.com

 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:synchronize_rcu+0x0/0x360 kernel/rcu/tree.c:4005
Code: Unable to access opcode bytes at 0x1ffff920012daeae.
RSP: 76c0:0000000000000203 EFLAGS: 1ffff920012daed4
==================================================================
BUG: KASAN: stack-out-of-bounds in __show_regs+0xa6/0x610 arch/x86/kernel/process_64.c:83
Read of size 8 at addr ffffc900096d7618 by task syz-executor.0/9934

CPU: 1 PID: 9934 Comm: syz-executor.0 Not tainted 6.10.0-rc3-next-20240611-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:91 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:117
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __show_regs+0xa6/0x610 arch/x86/kernel/process_64.c:83
 show_trace_log_lvl+0x3d4/0x520 arch/x86/kernel/dumpstack.c:301
 sched_show_task+0x578/0x740 kernel/sched/core.c:7432
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
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 4e d0 63 f6 f6 44 24 21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> c3 eb cc f5 65 8b 05 74 4f 6e 74 85 c0 74 43 48 c7 04 24 0e 36
RSP: 0018:ffffc9000330f600 EFLAGS: 00000206
RAX: 4e6b703e49168e00 RBX: 1ffff92000661ec4 RCX: ffffffff816fafba
RDX: dffffc0000000000 RSI: ffffffff8bcac1a0 RDI: 0000000000000001
RBP: ffffc9000330f690 R08: ffffffff92fcb7ef R09: 1ffffffff25f96fd
R10: dffffc0000000000 R11: fffffbfff25f96fe R12: dffffc0000000000
R13: 1ffff92000661ec0 R14: ffffc9000330f620 R15: 0000000000000246
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 __wake_up_common_lock+0x18c/0x1e0 kernel/sched/wait.c:108
 __unix_dgram_recvmsg+0x5f4/0x12f0 net/unix/af_unix.c:2415
 sock_recvmsg_nosec+0x18e/0x1d0 net/socket.c:1046
 ____sys_recvmsg+0x3c0/0x470 net/socket.c:2802
 ___sys_recvmsg net/socket.c:2846 [inline]
 do_recvmmsg+0x474/0xae0 net/socket.c:2940
 __sys_recvmmsg net/socket.c:3019 [inline]
 __do_sys_recvmmsg net/socket.c:3042 [inline]
 __se_sys_recvmmsg net/socket.c:3035 [inline]
 __x64_sys_recvmmsg+0x199/0x250 net/socket.c:3035
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f53cfc7cea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f53d0a0c0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007f53cfdb4050 RCX: 00007f53cfc7cea9
RDX: 0000000000010106 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00007f53cfcebff4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f53cfdb4050 R15: 00007fffb8c061e8
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc900096d0000, ffffc900096d9000) created by:
 copy_process+0x5d1/0x3dc0 kernel/fork.c:2201

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88807c7f0000 pfn:0x7c7f0
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff88807c7f0000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102dc2(GFP_HIGHUSER|__GFP_NOWARN|__GFP_ZERO), pid 2, tgid 2 (kthreadd), ts 126928355749, free_ts 121449634751
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1470
 prep_new_page mm/page_alloc.c:1478 [inline]
 get_page_from_freelist+0x2cbd/0x2d70 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4715
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2263
 vm_area_alloc_pages mm/vmalloc.c:3567 [inline]
 __vmalloc_area_node mm/vmalloc.c:3643 [inline]
 __vmalloc_node_range_noprof+0x971/0x1460 mm/vmalloc.c:3824
 alloc_thread_stack_node kernel/fork.c:310 [inline]
 dup_task_struct+0x444/0x8c0 kernel/fork.c:1110
 copy_process+0x5d1/0x3dc0 kernel/fork.c:2201
 kernel_clone+0x226/0x8f0 kernel/fork.c:2778
 kernel_thread+0x1bc/0x240 kernel/fork.c:2840
 create_kthread kernel/kthread.c:412 [inline]
 kthreadd+0x60d/0x810 kernel/kthread.c:765
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:144
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
page last free pid 5674 tgid 5674 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1089 [inline]
 free_unref_folios+0x103a/0x1b00 mm/page_alloc.c:2669
 folios_put_refs+0x76e/0x860 mm/swap.c:1020
 free_pages_and_swap_cache+0x2ea/0x690 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x44f/0xc80 mm/mmap.c:3395
 __mmput+0x115/0x390 kernel/fork.c:1341
 exit_mm+0x220/0x310 kernel/exit.c:565
 do_exit+0x9aa/0x28e0 kernel/exit.c:861
 do_group_exit+0x207/0x2c0 kernel/exit.c:1023
 __do_sys_exit_group kernel/exit.c:1034 [inline]
 __se_sys_exit_group kernel/exit.c:1032 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffffc900096d7500: 00 00 00 00 00 f3 f3 f3 f3 f3 f3 f3 00 00 00 00
 ffffc900096d7580: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 f2 f2 f2
>ffffc900096d7600: 00 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
                            ^
 ffffc900096d7680: 00 00 00 00 f1 f1 f1 f1 00 f2 f2 f2 00 f3 f3 f3
 ffffc900096d7700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
----------------
Code disassembly (best guess):
   0:	9c                   	pushf
   1:	8f 44 24 20          	pop    0x20(%rsp)
   5:	42 80 3c 23 00       	cmpb   $0x0,(%rbx,%r12,1)
   a:	74 08                	je     0x14
   c:	4c 89 f7             	mov    %r14,%rdi
   f:	e8 4e d0 63 f6       	call   0xf663d062
  14:	f6 44 24 21 02       	testb  $0x2,0x21(%rsp)
  19:	75 52                	jne    0x6d
  1b:	41 f7 c7 00 02 00 00 	test   $0x200,%r15d
  22:	74 01                	je     0x25
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 c3 eb cc f5       	call   0xf5ccebf2 <-- trapping instruction
  2f:	65 8b 05 74 4f 6e 74 	mov    %gs:0x746e4f74(%rip),%eax        # 0x746e4faa
  36:	85 c0                	test   %eax,%eax
  38:	74 43                	je     0x7d
  3a:	48                   	rex.W
  3b:	c7                   	.byte 0xc7
  3c:	04 24                	add    $0x24,%al
  3e:	0e                   	(bad)
  3f:	36                   	ss


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

