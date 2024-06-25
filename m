Return-Path: <linux-kernel+bounces-229243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F08916D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28903281661
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A1416F8ED;
	Tue, 25 Jun 2024 15:36:28 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EF6170827
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329788; cv=none; b=kKsubKi4uc+9pg5oLKguInvjIicjNYbsPC+afSiSbgGyNEfYHnuPF7kvRcG2QIRHTRj0OTcY8f6waxfop1V0mt8HsXeAYvfZgPTmTMCmKKMnb1CgvdBsV0jsdpfRAi16IpoM0ok3U0rMZa2wuN201bXbt/ReVqJ+XMFKei8bccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329788; c=relaxed/simple;
	bh=7Y6LMJ4LU+WvEWP/9NBUixuTA5IwyhTR8yck7WwqwAI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jwzGactiINPGuM1GAb+Pmf4fiXThGlWV7K6w9VvNuVaaepALGs77xYJu4b1ELB4SGSru2ocjXgL1N95U2xNzNZzM1gaxRX1Xl9/J2QFEOfyhdNQBvoQ8kh0yQ8n/J0UIt7k7APesxe5cw0n6OufpWGFM6KJ6peZJgo80P6LbiyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7ebe8016637so861620639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719329785; x=1719934585;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N3cj/kXcq5+EXLiAFl8myFoZZMb3DxZS0WV9x99Cjqk=;
        b=keEb3QKMkKMHx75fROt6ylZPjqG4EVazQIC0DYRIKhiT6570z+O9o+x7K8Wan4QVEo
         urjhObdS/TTftpe2nNHL+Byjf4DrnBcYD9TLCWMNln4aPg6UFkXbxO90iRk8CF5ym5Ae
         AbugZWPnuKKhE7K4GDIlau+agolVU6gEKRif1LZyftnJhHGNqojPfjNrqwd5aqCvnDjL
         RWVjg9SQiTHMacwmIn9EwxqrtvcAD0ThP/Mcy4aJhYDZW9Ye7J5Tvy0KXG6WKSpL4fcb
         mdW3p1rrijsBwRz+fNItnFAZLBcs5Z58UQ0cx3wnG8IbrKyprYMhDurltKlHS+nM9Qt2
         t/ew==
X-Forwarded-Encrypted: i=1; AJvYcCU4cvi6UfxgYL5CHClVK+Ko830TJuIJnHKu33TrEqZsjgu6a4K7ecsxhckk9o6NPDuXk+H1QfzhQOmcWiXRcPfVAR8FTR6jSKaCOe2m
X-Gm-Message-State: AOJu0Yxo/D1w2D7w/io4cUg24YHFXOjZooQW3Pj0+HfONx1UFno6XEcZ
	3xzzcctmaz3bbgRmz9+M51y0Vx15vzYZo22tJG9wd9CGEgyCv45mSo1fLQHwmK2nugyLfsoJ4L2
	tO4p0uO+KnWdecmG/Z6E5vhtbUdi3RLIbOnA0i10UhnqrSChb/IhvTUo=
X-Google-Smtp-Source: AGHT+IHUhvn/k+hlDhc0xX3PcjhePb4BPmrAs3NV+P6EFZufC8mi1YguZFpJX+dB0Ca01FDwyE5DUjZsP14mEWafjD3p1xEirJDI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13c1:b0:7eb:75e9:8f2b with SMTP id
 ca18e2360f4ac-7f3a752cb69mr22713639f.2.1719329785581; Tue, 25 Jun 2024
 08:36:25 -0700 (PDT)
Date: Tue, 25 Jun 2024 08:36:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f253b061bb8a953@google.com>
Subject: [syzbot] [jfs?] INFO: task hung in txBegin
From: syzbot <syzbot+eda89a33c5856f66f823@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50736169ecc8 Merge tag 'for-6.10-rc4-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=172777ee980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12f98862a3c0c799
dashboard link: https://syzkaller.appspot.com/bug?extid=eda89a33c5856f66f823
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17dccdda980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1644d08e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5cd6a6f1e8a6/disk-50736169.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2fb1a68197bc/vmlinux-50736169.xz
kernel image: https://storage.googleapis.com/syzbot-assets/783059c8c714/bzImage-50736169.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/95d758e45724/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13861201980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10461201980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17861201980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eda89a33c5856f66f823@syzkaller.appspotmail.com

INFO: task kworker/u8:11:2848 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc4-syzkaller-00148-g50736169ecc8 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:11   state:D stack:23552 pid:2848  tgid:2848  ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 io_schedule+0x8d/0x110 kernel/sched/core.c:9043
 TXN_SLEEP_DROP_LOCK fs/jfs/jfs_txnmgr.c:125 [inline]
 txBegin+0x260/0xce0 fs/jfs/jfs_txnmgr.c:374
 jfs_commit_inode+0x223/0x590 fs/jfs/inode.c:101
 jfs_write_inode+0x143/0x220 fs/jfs/inode.c:132
 write_inode fs/fs-writeback.c:1497 [inline]
 __writeback_single_inode+0x6b9/0x10b0 fs/fs-writeback.c:1716
 writeback_sb_inodes+0x99c/0x1380 fs/fs-writeback.c:1947
 wb_writeback+0x481/0xd40 fs/fs-writeback.c:2127
 wb_do_writeback fs/fs-writeback.c:2274 [inline]
 wb_workfn+0x410/0x1090 fs/fs-writeback.c:2314
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz-executor117:5099 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc4-syzkaller-00148-g50736169ecc8 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor117 state:D stack:19408 pid:5099  tgid:5099  ppid:5098   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 wb_wait_for_completion+0x166/0x290 fs/fs-writeback.c:216
 __writeback_inodes_sb_nr+0x2d2/0x380 fs/fs-writeback.c:2706
 sync_filesystem+0xa4/0x230 fs/sync.c:54
 generic_shutdown_super+0x72/0x2d0 fs/super.c:621
 kill_block_super+0x44/0x90 fs/super.c:1676
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe052acc017
RSP: 002b:00007ffd7811a4d8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fe052acc017
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd7811a590
RBP: 00007ffd7811a590 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffd7811b5f0
R13: 00005555816966c0 R14: 000000000000000f R15: 431bde82d7b634db
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by kworker/u8:11/2848:
 #0: ffff88801ae86148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88801ae86148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc900098b7d00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc900098b7d00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
2 locks held by getty/4845:
 #0: ffff88802a5ab0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2211
1 lock held by syz-executor117/5099:
 #0: ffff88802c5e00e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88802c5e00e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88802c5e00e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: deactivate_super+0xb5/0xf0 fs/super.c:505

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 30 Comm: khungtaskd Not tainted 6.10.0-rc4-syzkaller-00148-g50736169ecc8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfde/0x1020 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 51 Comm: kworker/u8:3 Not tainted 6.10.0-rc4-syzkaller-00148-g50736169ecc8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:__sanitizer_cov_trace_const_cmp8+0x0/0x90 kernel/kcov.c:310
Code: 10 48 89 74 0a 18 4c 89 44 0a 20 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 4c 8b 04 24 65 48 8b 0c 25 80 d4 03 00 65 8b 05 f0 aa
RSP: 0018:ffffc90000bb7638 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 000ffffffffff000 RCX: ffff888015193c00
RDX: 000000001507c558 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000bb7730 R08: ffffffff81e6dded R09: 1ffffffff25edcb0
R10: dffffc0000000000 R11: fffffbfff25edcb1 R12: 1ffff92000176ed0
R13: 000000001507c067 R14: 0000000000000000 R15: 1ffff92000176ed8
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005617e0440680 CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 pmd_pfn_mask arch/x86/include/asm/pgtable_types.h:453 [inline]
 pmd_pfn arch/x86/include/asm/pgtable.h:234 [inline]
 pte_lockptr include/linux/mm.h:2955 [inline]
 __pte_offset_map_lock+0x17b/0x300 mm/pgtable-generic.c:374
 get_locked_pte include/linux/mm.h:2744 [inline]
 __text_poke+0x2c5/0xd30 arch/x86/kernel/alternative.c:1883
 text_poke arch/x86/kernel/alternative.c:1968 [inline]
 text_poke_bp_batch+0x8cd/0xb30 arch/x86/kernel/alternative.c:2357
 text_poke_flush arch/x86/kernel/alternative.c:2470 [inline]
 text_poke_finish+0x30/0x50 arch/x86/kernel/alternative.c:2477
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 static_key_enable_cpuslocked+0x136/0x260 kernel/jump_label.c:205
 static_key_enable+0x1a/0x20 kernel/jump_label.c:218
 toggle_allocation_gate+0xb5/0x250 mm/kfence/core.c:826
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.555 msecs


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

