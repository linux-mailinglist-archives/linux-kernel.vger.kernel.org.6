Return-Path: <linux-kernel+bounces-380804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6E89AF653
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B851C21807
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424D9107A0;
	Fri, 25 Oct 2024 00:44:33 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5434C83
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729817072; cv=none; b=Vl9PE5XOq1n1YpMVJYkyBQjYTcqbnX4NKLdhPkzkaAOR/klApOff22SOs5PEuFvTnrCnQ/lq2bLJizLFW0IcLadOqsLonmsio02QMF7JxxgO1jQxrlgmfzzJt0w3z0kI853V+4cQ0Y45FiwveASVMH84ch+Vj2QNFOadJd6DCzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729817072; c=relaxed/simple;
	bh=0sayygYXLALdUV2nGI3X+d2AoM+smoVLzB000vFmUaY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XGpqlXyBvUgINa9IWDdxk4H+Dij7m2jN76tu6n+G9mmGzvv4N+mtkoBrnRrIMBO9E14MGeui3LbeDH99hfrQ8OFGM/lRyzGXVOAxxJnH+SzXuyOpFRDJ5k0xqJLFe/x11QX3wHOoXbUsGeQ/+ydKh2tgn9C3WQednnm3TraAL5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a4daf7174eso16069705ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 17:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729817069; x=1730421869;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LjXR22Qic3bXJLjdK21PpfbbxzcNVwprc2H4faFQyCo=;
        b=ATVMkEsfvWxzisnamXHbuGY4tFN1yU+lnVHupny5tak7l99ZQu+pH3gKxgJt2puCj5
         ccdSPfs3CB7WXXCoOFUVAcmNMwyW/2UsGisRwMyBb6VEAksvu6PGuB+/sykijb2bvXd5
         q3aIrMVbTFidSybs4xUQ4w/3smDb59wJDd6kXcHthsu/XMDwnyiCV1OScBOPi9nBl+bf
         q9TdqBo/SfYZ6BeQfSO34SMlE3lq2/DNgeXioyvv/8raDjK5sRfsRY+EN1YTgA8xFSUB
         Qv5QPmuf6Y3u2pH1BxsU+/J+jrglHbcdzp1nS8eIS8gcOSlBmyO65ANsLGJfPS74eWcg
         kNOA==
X-Forwarded-Encrypted: i=1; AJvYcCU853Si/kUzNe3ojDZlw/DEn1GnII6pOl3wj6DUope7f/wvj+Ni8zSkrF4hA4wjZ87ijAYBrfZIuJrYR0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMnTJaQ0Wk2y+B+JW2TZalfLo9eYz09d6oxixDtpb/8atdKZKb
	Po8FN0D4tzrU087BdikGwTwCSkmAe32KEtnuSDWei5fQfjL1598Ih7FL+plG9970o+hty3AtvIb
	QTsERgzO0HKgfvaR0+PzmCuYJ+1B5dZuhO3j8NV5RESEaSjaYAUrRhOU=
X-Google-Smtp-Source: AGHT+IER9Qwx6AdKdpojuAdGK9JBE3OeDM/TLOClIfwVFkiEpibkWlHca0hgagDyL7cKkkIbYH5cSlxH2AHq/azNzB+599uvSu3d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:581:b0:3a4:e4d0:9051 with SMTP id
 e9e14a558f8ab-3a4e4d094bcmr6753555ab.24.1729817069462; Thu, 24 Oct 2024
 17:44:29 -0700 (PDT)
Date: Thu, 24 Oct 2024 17:44:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671ae9ed.050a0220.2eb763.00cd.GAE@google.com>
Subject: [syzbot] [bcachefs?] INFO: task hung in do_rmdir (6)
From: syzbot <syzbot+4128a26fb0f85ec9e76c@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    715ca9dd687f Merge tag 'io_uring-6.12-20241019' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=163e60a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78db40d8379956d9
dashboard link: https://syzkaller.appspot.com/bug?extid=4128a26fb0f85ec9e76c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bf3787869b5a/disk-715ca9dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b938d885bc17/vmlinux-715ca9dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9c039de0dde2/bzImage-715ca9dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4128a26fb0f85ec9e76c@syzkaller.appspotmail.com

INFO: task syz.4.77:6035 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc3-syzkaller-00420-g715ca9dd687f #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.77        state:D stack:25024 pid:6035  tgid:6021  ppid:5239   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x1843/0x4ae0 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
 rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write_nested+0x1e0/0x220 kernel/locking/rwsem.c:1694
 inode_lock_nested include/linux/fs.h:850 [inline]
 do_rmdir+0x263/0x580 fs/namei.c:4387
 __do_sys_rmdir fs/namei.c:4418 [inline]
 __se_sys_rmdir fs/namei.c:4416 [inline]
 __x64_sys_rmdir+0x47/0x50 fs/namei.c:4416
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f271637dff9
RSP: 002b:00007f27171e6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 00007f2716536058 RCX: 00007f271637dff9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 00007f27163f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2716536058 R15: 00007ffc08a709a8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937e20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937e20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937e20 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
1 lock held by khugepaged/37:
 #0: ffffffff8e9f9028 (lock#3){+.+.}-{3:3}, at: __lru_add_drain_all+0x66/0x560 mm/swap.c:843
3 locks held by kworker/u8:12/3110:
2 locks held by getty/4978:
 #0: ffff88803374a0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
6 locks held by syz.4.77/6025:
2 locks held by syz.4.77/6035:
 #0: ffff88802b2fe420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff888061fdbf68 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:850 [inline]
 #1: ffff888061fdbf68 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: do_rmdir+0x263/0x580 fs/namei.c:4387
1 lock held by syz-executor/6680:
 #0: ffffffff8e93d3b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:297 [inline]
 #0: ffffffff8e93d3b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:976
2 locks held by syz-executor/7146:
2 locks held by syz.2.238/7877:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc3-syzkaller-00420-g715ca9dd687f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 7146 Comm: syz-executor Not tainted 6.12.0-rc3-syzkaller-00420-g715ca9dd687f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:lock_acquire+0x1e8/0x550 kernel/locking/lockdep.c:5825
Code: 02 00 00 41 0f 94 c1 48 8b 7c 24 20 44 89 f6 8b 54 24 1c 48 8b 4c 24 30 4c 8b 44 24 38 6a 00 6a 00 6a 00 ff 75 10 ff 74 24 48 <e8> c3 04 00 00 48 83 c4 28 48 c7 c7 40 dc 0a 8c e8 03 bf 4d 0a b8
RSP: 0018:ffffc900038d7698 EFLAGS: 00000006
RAX: 0000000000000001 RBX: ffffc900038d7720 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888012601bd8
RBP: ffffc900038d7808 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff2037a4e R12: 1ffff9200071aee0
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000246
FS:  00005555639f4500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe89d07e48 CR3: 000000007652c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
 _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
 ext4_es_lookup_extent+0x169/0xa90 fs/ext4/extents_status.c:1015
 ext4_map_blocks+0x1f9/0x1960 fs/ext4/inode.c:623
 ext4_readdir+0xb25/0x3a60 fs/ext4/dir.c:182
 iterate_dir+0x571/0x800 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:407 [inline]
 __se_sys_getdents64+0x1d3/0x4a0 fs/readdir.c:392
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6d7fdb0193
Code: c1 66 0f 1f 44 00 00 48 83 c4 08 48 89 ef 5b 5d e9 42 43 f8 ff 66 90 b8 ff ff ff 7f 48 39 c2 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 c7 c2 a8 ff ff ff f7 d8
RSP: 002b:00007fffae72a608 EFLAGS: 00000293 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 0000555563a17640 RCX: 00007f6d7fdb0193
RDX: 0000000000008000 RSI: 0000555563a17640 RDI: 0000000000000006
RBP: 0000555563a17614 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000001000 R11: 0000000000000293 R12: ffffffffffffffa8
R13: 0000000000000016 R14: 0000555563a17610 R15: 00007fffae72d9a0
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

