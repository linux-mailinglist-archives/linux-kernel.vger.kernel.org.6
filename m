Return-Path: <linux-kernel+bounces-196437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD338D5C26
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D1728595F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 07:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD51762D0;
	Fri, 31 May 2024 07:59:29 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D13E7442F
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717142368; cv=none; b=uydp3lihsIFhNEWPBUipbcmCHqm3RFVbliu5GnEjuclkMilN6EjxgGzOCp5L4Ugq/J2vKnekfW7DHAGc0ko+IjS2t8MfFt//R+YjyZJdnpaGffDyAqYPGjzaDMdvcK2dqH2T0rMPXIk5WHxRg2ezmd8UfXgbVu+4h8tTOafPqpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717142368; c=relaxed/simple;
	bh=BG55gKdxOfm3t40y9UIHcYSk4DK+HRHGTfBqeeGfvy8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=szAKjVRpMOffZGXxe+H6YqaX+thW3WARB0INHEBL0bXHs0/MkcSwY6x3Su5uf1KwEUVoHGBPtqelJuzlMFRbNdhNatS3Nb0jiz//g1yjb9Ju9yZy7KE7KPtBIktBBZWNdJNz9fCMw+kd47axHgDu8YEi0+dhJPtLF2v95EydS6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e6ff0120a5so97802239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 00:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717142366; x=1717747166;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4pnoK/cK+PGh+SeAZOsDNZAVThFsdQT19Km+HsQZ4/E=;
        b=UdKzZUupg6bkL3KA52NVLB2FQyI7UG04s0igL8wM97DeT1ibQlto5B9uBSvfBdbETW
         NPQEmAilJnJ4BELZrrOiKK65+OxbloF3Zn1q11OMVmD3WkgipUbNRoSus83ofMuDZLhQ
         p3D2GPI5iGYNAxoObSiCFcg+tU6iTpLWBUW7vC3GzauvR916hQ9wY8+7hHsGGx0diI8O
         eqzfA9YKgjlkDrl48kvxa4aEQ3H1J1KNXuAQ7S/gtQd5p7vq5OdzhWuDECLP7JNmmrjY
         Z/9/OCCGFrB30Fve+WGsf7HxGpms60t3m7RsTqAMVzkh6G8j/avO+PC9mJIvVb2z1ZcQ
         2UpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgf7p2rPrkwM4WSw88y6N0LtfG5bOZOHvrv5mTVrYFnTRgBasYP5a8GpdpSj9r5vHc3XQSjxy7KhsKztmX7H9GofLOzlX00G92/HKS
X-Gm-Message-State: AOJu0Yzl/gJpN375s6Cprb7mQvKPAR3p+FpQqgev0q3WsZrkmmHhxy54
	88ZR5TwLrvStisG6ZA27/DM3S0NMv6mKkok7TO0Trf0TDRAAi0NSBqa90Ty0EGkFzjF9aL5jIkk
	HiajjDBSK+kRJy1Rv3sQhmHLyOY8wdFe+LukdNo4QaUKPcuKFBnTmBMk=
X-Google-Smtp-Source: AGHT+IFdIwHD3X3c+ktobHgfp+mRq2fDHkd9b85dziyG8jWvgDaGJMDoign9smrub6MK805tiEU1Gag/Z3pNZzPriNKpIvtkz51D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3406:b0:7de:e16b:4b81 with SMTP id
 ca18e2360f4ac-7eafff2ca2fmr9416539f.2.1717142366312; Fri, 31 May 2024
 00:59:26 -0700 (PDT)
Date: Fri, 31 May 2024 00:59:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5e7f60619bb5ccb@google.com>
Subject: [syzbot] [bcachefs?] INFO: task hung in journal_quiesce
From: syzbot <syzbot+1e1b380ef8d95b36f789@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6fbf71854e2d Merge tag 'perf-tools-fixes-for-v6.10-1-2024-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121a7784980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62be2ac813b33670
dashboard link: https://syzkaller.appspot.com/bug?extid=1e1b380ef8d95b36f789
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13612784980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eab66bf09e4e/disk-6fbf7185.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/232ac0545252/vmlinux-6fbf7185.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2820e679b0ee/bzImage-6fbf7185.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1b9344a81d37/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e1b380ef8d95b36f789@syzkaller.appspotmail.com

INFO: task kworker/1:5:5342 blocked for more than 143 seconds.
      Not tainted 6.9.0-syzkaller-12400-g6fbf71854e2d #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:5     state:D stack:21792 pid:5342  tgid:5342  ppid:2      flags:0x00004000
Workqueue: events_long bch2_fs_read_only_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 journal_quiesce+0x205/0x2e0 fs/bcachefs/journal.c:474
 bch2_fs_journal_stop+0x33b/0x520 fs/bcachefs/journal.c:1181
 __bch2_fs_read_only+0x30c/0x430 fs/bcachefs/super.c:291
 bch2_fs_read_only+0xb52/0x1210 fs/bcachefs/super.c:356
 bch2_fs_read_only_work+0x2d/0x40 fs/bcachefs/super.c:393
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz-executor.5:5431 blocked for more than 143 seconds.
      Not tainted 6.9.0-syzkaller-12400-g6fbf71854e2d #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:18512 pid:5431  tgid:5430  ppid:5255   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 rwsem_down_write_slowpath+0xeeb/0x13b0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1af/0x200 kernel/locking/rwsem.c:1306
 __bch2_fs_stop+0xfd/0x540 fs/bcachefs/super.c:612
 bch2_fs_stop fs/bcachefs/super.c:672 [inline]
 bch2_fs_open+0xb4f/0xdf0 fs/bcachefs/super.c:2139
 bch2_mount+0x71d/0x1310 fs/bcachefs/fs.c:1917
 legacy_get_tree+0xf0/0x190 fs/fs_context.c:662
 vfs_get_tree+0x92/0x2a0 fs/super.c:1780
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f532cc7e5ea
RSP: 002b:00007f532dab2ef8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f532dab2f80 RCX: 00007f532cc7e5ea
RDX: 0000000020005d80 RSI: 0000000020005dc0 RDI: 00007f532dab2f40
RBP: 0000000020005d80 R08: 00007f532dab2f80 R09: 0000000000000400
R10: 0000000000000400 R11: 0000000000000246 R12: 0000000020005dc0
R13: 00007f532dab2f40 R14: 0000000000005e05 R15: 0000000020005e00
 </TASK>

Showing all locks held in the system:
1 lock held by pool_workqueue_/3:
1 lock held by khungtaskd/30:
 #0: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by kworker/u8:6/1097:
2 locks held by getty/4846:
 #0: ffff88802abe40a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031332f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
3 locks held by kworker/1:5/5342:
 #0: ffff888015079148 ((wq_completion)events_long){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015079148 ((wq_completion)events_long){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc9000a217d00 ((work_completion)(&c->read_only_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc9000a217d00 ((work_completion)(&c->read_only_work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffff888064d80278 (&c->state_lock){+.+.}-{3:3}, at: bch2_fs_read_only_work+0x25/0x40 fs/bcachefs/super.c:392
1 lock held by syz-executor.5/5431:
 #0: ffff888064d80278 (&c->state_lock){+.+.}-{3:3}, at: __bch2_fs_stop+0xfd/0x540 fs/bcachefs/super.c:612
1 lock held by kworker/u8:7/6982:
1 lock held by syz-executor.2/7397:
2 locks held by syz-executor/7402:
1 lock held by syz-executor.3/7406:
 #0: ffffffff8e339200 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x4c/0x530 kernel/rcu/tree.c:4448
2 locks held by syz-executor.5/7440:
2 locks held by syz-executor/7444:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 30 Comm: khungtaskd Not tainted 6.9.0-syzkaller-12400-g6fbf71854e2d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfde/0x1020 kernel/hung_task.c:379
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 4532 Comm: klogd Not tainted 6.9.0-syzkaller-12400-g6fbf71854e2d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:__kasan_check_read+0xa/0x20 mm/kasan/shadow.c:31
Code: db eb d0 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 89 f6 48 8b 0c 24 <31> d2 e9 6f e6 ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
RSP: 0018:ffffc900036ff658 EFLAGS: 00000056
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff81727bc0
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffffffff8fad43a8
RBP: ffffc900036ff788 R08: ffffffff92fa8597 R09: 1ffffffff25f50b2
R10: dffffc0000000000 R11: fffffbfff25f50b3 R12: 1ffff920006dfed8
R13: ffffffff81659adb R14: 0000000000000000 R15: dffffc0000000000
FS:  00007fc3dc3d6380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb38dc96000 CR3: 000000007d38c000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 cpumask_test_cpu include/linux/cpumask.h:571 [inline]
 cpu_online include/linux/cpumask.h:1181 [inline]
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0xb0/0x9f0 kernel/locking/lockdep.c:5765
 do_write_seqcount_end include/linux/seqlock.h:515 [inline]
 psi_account_irqtime+0x382/0x5d0 kernel/sched/psi.c:1021
 update_rq_clock_task kernel/sched/core.c:726 [inline]
 update_rq_clock+0x22b/0x8a0 kernel/sched/core.c:770
 ttwu_queue kernel/sched/core.c:4056 [inline]
 try_to_wake_up+0x86b/0x1470 kernel/sched/core.c:4378
 autoremove_wake_function+0x16/0x110 kernel/sched/wait.c:384
 __wake_up_common kernel/sched/wait.c:89 [inline]
 __wake_up_common_lock+0x132/0x1e0 kernel/sched/wait.c:106
 sock_def_readable+0x20f/0x5b0 net/core/sock.c:3353
 unix_dgram_sendmsg+0x1490/0x1f80 net/unix/af_unix.c:2112
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2192
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc3dc5389b5
Code: 8b 44 24 08 48 83 c4 28 48 98 c3 48 98 c3 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 26 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 7a 48 8b 15 44 c4 0c 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffd6a24c228 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fc3dc5389b5
RDX: 000000000000005c RSI: 000055e4b1c92850 RDI: 0000000000000003
RBP: 000055e4b1c8d910 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000013
R13: 00007fc3dc6c6212 R14: 00007ffd6a24c328 R15: 0000000000000000
 </TASK>


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

