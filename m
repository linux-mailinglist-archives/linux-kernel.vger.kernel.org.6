Return-Path: <linux-kernel+bounces-403289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9CA9C3394
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 16:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B087A2816A3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 15:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EBE158520;
	Sun, 10 Nov 2024 15:52:32 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D4B1586FE
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731253952; cv=none; b=de3RgwAQsIRqqbcUTmbHPbpqDhdFiwHGDfXz8e3uNRTA+Pc4bnN+1e+zUsvL7hm9hUxyx6S0/cNrs2EKyRU6RibQ3S9JoOMjfNdOtRNfNfslsJBEjegzgeLvHkSU76YhprJIgFoHj9VxWUgELH7tkVgt0blu8Ez4V4JlXAmtXJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731253952; c=relaxed/simple;
	bh=NSviJcZQFM/3mSBzpNCMkXHMx3y4Cby+XqAnbBlfbIY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ahAtbr43+6U1KpJjOa9BCqaDxh/Um0UdDFpINj/C+oZW0zrF5N/erXvo5PNjOIU8Mru4BRaWlS6T3yScFMjLamiIvMH+fvPzcmtL+gAaRTPXYrOD21RZjPAMFiOWHyJbvnpG402gmoJ18rronACF1jXcASA9ps6qf0jnjO1OLME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a4f2698c76so46209395ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 07:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731253949; x=1731858749;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KSg1gMgjGLygILFtMdTVy/REZ//qspdig6SaHa6MGU=;
        b=V/yjWUlYb9FZ+6gAfMRi+/UHGFW4tgUMRn58jwi8f12a7bYCLdHs2f0Y9Rzr1Yy80J
         d49aP5MVGJH/oiVaYfVCPztSvv4mUi96jY4exZfwtEv9coq4DA+Meji/qEtUa85pniAv
         vPh5icBOcl4LDwRBzObP+9nePLjXgK9US0SHSioFNctxpWRzDcuZCykl3jKbyqF3V7l6
         LLeyEG4sBHA7v//Em1zNG8HUBYez4bIYqE3ybAmlhWlykWZEAczhpuznvpXmPEhiIvok
         WI0V9cbuNSCYgVtaSserX8gezWFg3elsGNnryLfh3sKsp+kem1iPf2sWVQl5ixp9On9Q
         f9Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXIZ6Q1KFbHiSx9cFoIwGk9VSfuTO18EGSiHWVkAftrL6gVc3XV5IwNZJ0EXC74mxHp4h4oFXxRKDFTAQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB5z3GgIx+PIQC3o7LXJCxIilT4/NPqdKu2LXvcI6KmoViwxsg
	FrvXvaLv5MYyjVCt423j2jCJNTmd686XNygozteQV+Y7rY4qRlVNbgrwf+EgIwYMuqne3DgGmLI
	6+eKgWiv7PlGBGF6L+6BmTrvWxaDJjgKspO6xeX80xf+OyZtq8Mtk00A=
X-Google-Smtp-Source: AGHT+IGR5M2XxGaATC1M9M5nP4RnNsoXFQwLi6Bao/87y2E5J9nRVajQvFe7IEq0jTTO5ti9dlEUn4UvZe+J/cNelGqKRz3d9Mrm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198a:b0:3a6:ac17:13de with SMTP id
 e9e14a558f8ab-3a6f1a7430amr108471755ab.20.1731253949157; Sun, 10 Nov 2024
 07:52:29 -0800 (PST)
Date: Sun, 10 Nov 2024 07:52:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6730d6bd.050a0220.1fb99c.0139.GAE@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in sys_pipe2 (2)
From: syzbot <syzbot+693a483dd6ac06c62b09@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ff7afaeca1a1 Merge tag 'nfs-for-6.12-3' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a28ea7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=921b01cbfd887a9b
dashboard link: https://syzkaller.appspot.com/bug?extid=693a483dd6ac06c62b09
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f852e4679ae1/disk-ff7afaec.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/781fa489dc47/vmlinux-ff7afaec.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ac3c851393ff/bzImage-ff7afaec.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+693a483dd6ac06c62b09@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...!: (2 ticks this GP) idle=400c/1/0x4000000000000000 softirq=14106/14106 fqs=0
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P4167/1:b..l
rcu: 	(detected by 0, t=10502 jiffies, g=10753, q=1689 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5819 Comm: syz-executor Not tainted 6.12.0-rc6-syzkaller-00110-gff7afaeca1a1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:87 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x86/0x290 mm/kasan/generic.c:189
Code: 00 fc ff df 4f 8d 3c 31 4c 89 fd 4c 29 dd 48 83 fd 10 7f 29 48 85 ed 0f 84 3e 01 00 00 4c 89 cd 48 f7 d5 48 01 dd 41 80 3b 00 <0f> 85 c9 01 00 00 49 ff c3 48 ff c5 75 ee e9 1e 01 00 00 45 89 dc
RSP: 0018:ffffc90000a18b10 EFLAGS: 00000046
RAX: 0000000000000001 RBX: 1ffffffff34be6de RCX: ffffffff8171b4b8
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffff9a5f36f0
RBP: ffffffffffffffff R08: ffffffff9a5f36f3 R09: 1ffffffff34be6de
R10: dffffc0000000000 R11: fffffbfff34be6de R12: dffffc0000000000
R13: 1ffff92000143174 R14: dffffc0000000001 R15: fffffbfff34be6df
FS:  00005555612eb500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f003b843e1c CR3: 00000000349fe000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 queued_spin_is_locked include/asm-generic/qspinlock.h:57 [inline]
 debug_spin_unlock kernel/locking/spinlock_debug.c:101 [inline]
 do_raw_spin_unlock+0x58/0x8b0 kernel/locking/spinlock_debug.c:141
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:150 [inline]
 _raw_spin_unlock_irqrestore+0x81/0x140 kernel/locking/spinlock.c:194
 debug_object_deactivate+0x2d5/0x390 lib/debugobjects.c:778
 debug_hrtimer_deactivate kernel/time/hrtimer.c:428 [inline]
 debug_deactivate+0x1b/0x220 kernel/time/hrtimer.c:484
 __run_hrtimer kernel/time/hrtimer.c:1659 [inline]
 __hrtimer_run_queues+0x305/0xd50 kernel/time/hrtimer.c:1755
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1817
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x420 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:on_stack arch/x86/include/asm/stacktrace.h:60 [inline]
RIP: 0010:__unwind_start+0x55e/0x740 arch/x86/kernel/unwind_orc.c:758
Code: 80 3c 14 00 74 12 4c 89 ef e8 0e f9 b9 00 48 ba 00 00 00 00 00 fc ff df 48 3b 5c 24 10 77 3f 49 8b 45 00 48 3b 44 24 10 76 34 <48> 39 5c 24 08 76 2d 48 39 44 24 08 77 26 48 8b 44 24 20 80 3c 10
RSP: 0018:ffffc90003f0f7a0 EFLAGS: 00000202
RAX: ffffc90003f10000 RBX: ffffc90003f08000 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffc90003f10000 RDI: ffffc90003f0f7a0
RBP: 1ffff920007e1f01 R08: ffffc90003f0f801 R09: 0000000000000000
R10: ffffc90003f0f800 R11: fffff520007e1f0c R12: 1ffff920007e1f02
R13: ffffc90003f0f810 R14: ffffc90003f0f800 R15: ffffc90003f0f808
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0xe5/0x150 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x76/0x430 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcd0/0xf00 mm/page_alloc.c:2638
 __slab_free+0x31b/0x3d0 mm/slub.c:4490
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_noprof+0x1a6/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kmalloc_array_noprof include/linux/slab.h:923 [inline]
 alloc_pipe_info+0x1ff/0x4d0 fs/pipe.c:815
 get_pipe_inode fs/pipe.c:890 [inline]
 create_pipe_files+0x87/0x700 fs/pipe.c:922
 __do_pipe_flags+0x48/0x2d0 fs/pipe.c:973
 do_pipe2+0xd4/0x310 fs/pipe.c:1024
 __do_sys_pipe2 fs/pipe.c:1042 [inline]
 __se_sys_pipe2 fs/pipe.c:1040 [inline]
 __x64_sys_pipe2+0x5a/0x70 fs/pipe.c:1040
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f003d97d469
Code: c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 31 f6 b8 25 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 c7 c2 a8 ff ff ff
RSP: 002b:00007ffc2d92ef88 EFLAGS: 00000246 ORIG_RAX: 0000000000000125
RAX: ffffffffffffffda RBX: 00005555612ffaf0 RCX: 00007f003d97d469
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 00007ffc2d92ef98
RBP: 00007ffc2d92f560 R08: 0000000000000007 R09: 0000555561302c40
R10: ba233592f55bc4c5 R11: 0000000000000246 R12: 00007ffc2d92f3b0
R13: 0000555561302990 R14: 00007ffc2d92f0d0 R15: 0000555561305130
 </TASK>
task:kworker/u8:6    state:R  running task     stack:17432 pid:4167  tgid:4167  ppid:2      flags:0x00004000
Workqueue: bat_events batadv_nc_worker
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x17fa/0x4bd0 kernel/sched/core.c:6690
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7012
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
RIP: 0010:trace_lock_acquire include/trace/events/lock.h:24 [inline]
RIP: 0010:lock_acquire+0xdc/0x550 kernel/locking/lockdep.c:5796
Code: 08 0f 83 f4 02 00 00 89 c3 48 89 d8 48 c1 e8 06 48 8d 3c c5 68 dc 1b 90 be 08 00 00 00 e8 dc 36 8b 00 48 0f a3 1d 5c 94 ab 0e <73> 16 e8 3d 7f 0a 00 84 c0 75 0d 80 3d de 56 95 0e 00 0f 84 f9 02
RSP: 0018:ffffc9000d4579e0 EFLAGS: 00000257
RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff81704804
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff901bdc68
RBP: ffffc9000d457b40 R08: ffffffff901bdc6f R09: 1ffffffff2037b8d
R10: dffffc0000000000 R11: fffffbfff2037b8e R12: 1ffff92001a8af44
R13: dffffc0000000000 R14: 0000000000000000 R15: dffffc0000000000
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
 batadv_nc_worker+0xec/0x610 net/batman-adv/network-coding.c:719
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 10501 jiffies! g10753 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=1 timer-softirq=4600
rcu: rcu_preempt kthread starved for 10502 jiffies! g10753 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:25920 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x17fa/0x4bd0 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6782
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2615
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

