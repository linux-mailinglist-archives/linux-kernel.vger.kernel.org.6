Return-Path: <linux-kernel+bounces-368371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB92D9A0F12
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675651F24177
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6F620F5BD;
	Wed, 16 Oct 2024 15:52:26 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A2620F5A2
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093946; cv=none; b=f6J8UQpn1aETKYBYAxgh8uuVOzycOCceMZ3BETl2I4tviJwp9s0JKcJwpK9uodrL1wRKLlyFl7QuUj9PfUdK2490EPVwY0SjChtPUpOGZi3TLZGG/vlr3u+twMfW8Hg5MNO39j29PFHAiBqawfmNZpryqPPcN65UESPtmdieqzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093946; c=relaxed/simple;
	bh=rfxXYmvhigK8y7uxMV9HFA6vEen5PyYzJKJ49Ophcxo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EOweRroOphZ5IhtnY87Km6LKslcFAnMScPJgJxNt59JukyxX+UmCt/uvqq7oWj76q5ZW02Rt16KHtjY+rXQna8ARrM1g+elgaSf59ZwjUjGdKmLL0HJxBKt80kf8rhYm18Tq/tPGUxh43pmUc4D6eFg+ZVAoSPcoqCh7FqrFSNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c90919a2so389475ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729093944; x=1729698744;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BKwWrraA56w+np8uIcM3moEPJ5xVl4/n7sLogifumkY=;
        b=HXqYMb5fsmiSLPkte9YW/oORHzf26o1unkKTFpvflCkVdhvs+cvFufW8HqaN1yfhGk
         Cnhr1kPH20qs1gi/hqa7LPiDPAlQWPvSchVJ8+TQ1ws9qM79WjuBAy1hVm0HkDCgTtrS
         kI3Axom5XRemEGUdP4iM1MfmmAgXoGG8QJ3Diu8mz4CfjXGrE4QOSqbluQHphhGLNBvE
         wB/8DrJv2zQX051FSM58nITtz3EUwo2vL/A/fzXSWSk1BovUT+YKlxpa1bk1FoJMoogt
         yFpQ9qSp5SA0PauUHEPHxq8/3mmEm1FSTL5/LPlqf2pH+rA1rrrtVraJXBSGTKB26bHL
         qQKw==
X-Forwarded-Encrypted: i=1; AJvYcCXg9G8VdSFEnvlAR2qTswByrC+keYu5eYIIU/iLIX1xWxZ0jFOuQTEzboeyCm6KlBEmvGH8SyG2LwyYgnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyxrrLsl+Ymy1l7LnwWGanULrwk+inCZ44TCdVl0TvBUMNY5ag
	kmeuI0akfOymVfLzmSZh3mw6MDNK4vPStDsRQyW3mdFOUEEI0IJCBk+amlH8UZTYEpM2c88WSUZ
	4Aj7aZ0RnZ8+x/rV2UuhXvZD0gXDdF1ZPq/J7pDhqY0RvQI5LWAIdklw=
X-Google-Smtp-Source: AGHT+IH6jG8zhhWhO2KFaH7kH0PTXBUmCuzrOxwrUoI/FHmkcqJnico7Xdp8Xb9QjalAuUC+mdku1eNzhNiaDSOhxxIZvH2rYzo8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0c:b0:3a1:a26e:81a with SMTP id
 e9e14a558f8ab-3a3dc4a7b7fmr44952345ab.7.1729093942640; Wed, 16 Oct 2024
 08:52:22 -0700 (PDT)
Date: Wed, 16 Oct 2024 08:52:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670fe136.050a0220.d9b66.016f.GAE@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in seq_read_iter (2)
From: syzbot <syzbot+c4cf28ed38d86d6b549d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9e4c6c1ad9a1 Merge tag 'io_uring-6.12-20241011' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121bf840580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
dashboard link: https://syzkaller.appspot.com/bug?extid=c4cf28ed38d86d6b549d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f27b27980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161bf840580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b800ca2864ac/disk-9e4c6c1a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d73e5030d835/vmlinux-9e4c6c1a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/01db64f363e3/bzImage-9e4c6c1a.xz

Bisection is inconclusive: the first bad commit could be any of:

781773e3b680 sched/fair: Implement ENQUEUE_DELAYED
a1c446611e31 sched,freezer: Mark TASK_FROZEN special
e1459a50ba31 sched: Teach dequeue_task() about special task states
f12e148892ed sched/fair: Prepare pick_next_task() for delayed dequeue
152e11f6df29 sched/fair: Implement delayed dequeue
2e0199df252a sched/fair: Prepare exit/cleanup paths for delayed_dequeue
54a58a787791 sched/fair: Implement DELAY_ZERO

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13491087980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c4cf28ed38d86d6b549d@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5242/1:b..l
rcu: 	(detected by 0, t=10503 jiffies, g=7693, q=1717126 ncpus=2)
task:udevd           state:R  running task     stack:23632 pid:5242  tgid:5242  ppid:4675   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x1843/0x4ae0 kernel/sched/core.c:6682
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7004
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:arch_stack_walk+0x139/0x150 arch/x86/kernel/stacktrace.c:30
Code: 90 84 c0 74 11 48 89 df e8 34 9e 09 00 83 bd 70 ff ff ff 00 75 d0 65 48 8b 04 25 28 00 00 00 48 3b 45 d0 75 13 48 83 c4 68 5b <41> 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 44 4e 85 0a 0f 1f 40
RSP: 0018:ffffc9000377f650 EFLAGS: 00000286
RAX: 1d18e14b92e1d000 RBX: ffffc9000377f6d0 RCX: ffffffff9179c000
RDX: ffffffff91947d00 RSI: ffffffff8c0adc40 RDI: ffffffff8c602720
RBP: ffffc9000377f670 R08: ffffffff901bc6af R09: 1ffffffff20378d5
R10: dffffc0000000000 R11: fffffbfff20378d6 R12: ffff8880741c3c00
R13: ffffffff8180a090 R14: ffffc9000377f6c0 R15: 0000000000000000
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x76/0x430 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcd0/0xf00 mm/page_alloc.c:2638
 discard_slab mm/slub.c:2677 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3145
 put_cpu_partial+0x17c/0x250 mm/slub.c:3220
 __slab_free+0x2ea/0x3d0 mm/slub.c:4449
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_kmalloc+0x23/0xb0 mm/kasan/common.c:385
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_node_noprof+0x22a/0x440 mm/slub.c:4270
 __kvmalloc_node_noprof+0x72/0x190 mm/util.c:658
 seq_buf_alloc fs/seq_file.c:38 [inline]
 seq_read_iter+0x20c/0xd70 fs/seq_file.c:210
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x9bb/0xbc0 fs/read_write.c:569
 ksys_read+0x183/0x2b0 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f550dd16b6a
RSP: 002b:00007ffcb76d24a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00005632171f20f0 RCX: 00007f550dd16b6a
RDX: 0000000000001000 RSI: 00005632172131c0 RDI: 0000000000000008
RBP: 00005632171f20f0 R08: 0000000000000008 R09: 0000000000080000
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffcb76d2988 R15: 000000000000000a
 </TASK>
rcu: rcu_preempt kthread starved for 10545 jiffies! g7693 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:25816 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x1843/0x4ae0 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6774
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2615
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 24 Comm: ksoftirqd/1 Not tainted 6.12.0-rc2-syzkaller-00260-g9e4c6c1ad9a1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__sanitizer_cov_trace_cmp4+0x0/0x90 kernel/kcov.c:287
Code: 10 48 89 74 0a 18 4c 89 44 0a 20 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 4c 8b 04 24 65 48 8b 14 25 80 d7 03 00 65 8b 05 b0 ee
RSP: 0018:ffffc900001e7638 EFLAGS: 00000202
RAX: 0000000000000000 RBX: 0000000028000045 RCX: dffffc0000000000
RDX: ffff88801da88000 RSI: 0000000028000045 RDI: 0000000028000045
RBP: ffff888202716140 R08: ffffffff84eae69c R09: 1ffff11040346984
R10: dffffc0000000000 R11: ffffed1040346985 R12: 0000000000000014
R13: 0000000000000000 R14: ffff888202716154 R15: ffff888202716144
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdaa273ff8 CR3: 000000000e734000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 do_csum lib/checksum.c:77 [inline]
 ip_fast_csum+0x14a/0x2b0 lib/checksum.c:108
 ip_rcv_core+0x415/0xd10 net/ipv4/ip_input.c:511
 ip_rcv+0x4f/0x90 net/ipv4/ip_input.c:565
 __netif_receive_skb_one_core net/core/dev.c:5666 [inline]
 __netif_receive_skb+0x2bf/0x650 net/core/dev.c:5779
 process_backlog+0x662/0x15b0 net/core/dev.c:6111
 __napi_poll+0xcb/0x490 net/core/dev.c:6775
 napi_poll net/core/dev.c:6844 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6966
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:927
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
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
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

