Return-Path: <linux-kernel+bounces-537939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C93D8A492B1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA23A3B85D0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCE11DF727;
	Fri, 28 Feb 2025 07:59:35 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09EF1DF260
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729574; cv=none; b=JoSzsbZq3aJ/gqGKPcJzzQFA7XzVFjFDk2i6zyJEWk5/hmqEf3QB6drROCp8c5oKlZGkkck9WcWTVZXSe0lSsh1iBiEmuw98lJaP0vBCMro7dwfe+oIbm+CYSrlP4jZitoBwRMmeA9IhoHuMbeTdOvarqHzcK+U4kbe6BYijlHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729574; c=relaxed/simple;
	bh=63piQ8ItITadkwFWIcbDth9Z3jrcFZkDqN/LSgCU448=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AjEFhtS9ZJown7nIL0VmaxgR1bdVRPXPOBxRE2/UoZJ31DUGOLKtsrHt8v+WvrScVuaK9Hv0PjcRsi62AqRYLdujAlR7fjwhHa67oZRkoWkj1m3jORP5CRvupRoVcG2CRzURee8K7RdntAKpKgcS3vrV71nm5VlCVTlqGvcmzqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3cf64584097so20917575ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:59:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740729571; x=1741334371;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=znt0tIz2WSnTQBMcXdT5PxAi7Th8sr34BunIklu59O0=;
        b=UfQ20RmrA6Qs5jLxuN75T0JGXYkhGlG7YszYT0b7qNQPEM8eTcv26rDXmBudUfd5Gv
         siyMA/OMsfbUEiiCK7le7DmmnYEIKwScxkxpRyjMl2w2ppTghPs/0OUD1oGOIKB688QH
         tQakeoqzbcyHM8PhyUe7Q7GC+hjn5h0biC6e+pG749Yb8LdnaIwEFkvjv0d31CWSBKDl
         n1M4TjFBjMoYXntN3Mzjk6ORxPZznEAJDy++RJCnu/g/13ftVpa+30WLY/2mSRoBbFFZ
         s3RjJ8kcJzmAasxVXqAMeLB6bishCibCJ9As+8evfyIQeBFx2Jps0WiNGxLBCnSbhh6h
         h9hw==
X-Forwarded-Encrypted: i=1; AJvYcCXJFaMeMeSCyxFZJlpQaGC2a32cctzzRyLzsi61NFOdF2DhW+FJzSRlgrE77QuLV3tZ1tIK1kMdYyc/he0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB1zqutj2lGJohcSuN3zxy624fU5quGy+zp3wg9ctHYCXQj8ye
	0P7M/pGheZGPRLpOY8Uyo1bL8V35ge8SIx4VrmH5BOjKlEqkl4ZlLHAy2DPbxXUwn3qOZzmdSve
	QZ/KwuNlPE89YG4o2mCpdCTTJPn20Z/ig3LLjEemli77lR0/qrccIda0=
X-Google-Smtp-Source: AGHT+IHBmE5QLfh5Lsm6B58SxhZO33IvQigSPu2IetXosJjOk9yLvoEe+gx89Ksc3ABGNP5NhUe3WT0E2BE+vH5CUKIdVyBbQFFw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214e:b0:3d3:e470:6d5 with SMTP id
 e9e14a558f8ab-3d3e6e70825mr20950715ab.13.1740729570816; Thu, 27 Feb 2025
 23:59:30 -0800 (PST)
Date: Thu, 27 Feb 2025 23:59:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c16ce2.050a0220.1baf.000e.GAE@google.com>
Subject: [syzbot] [bcachefs?] INFO: task hung in invalidate_inode_pages2_range (3)
From: syzbot <syzbot+de1434c5355cc909b734@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1e15510b71c9 Merge tag 'net-6.14-rc5' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=164eca97980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8de9cc84d5960254
dashboard link: https://syzkaller.appspot.com/bug?extid=de1434c5355cc909b734
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d297b8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119af064580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ac4579f25f13/disk-1e15510b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c342a1d6167e/vmlinux-1e15510b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d985a65df547/bzImage-1e15510b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4860c171e0ab/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+de1434c5355cc909b734@syzkaller.appspotmail.com

INFO: task syz-executor337:5843 blocked for more than 143 seconds.
      Not tainted 6.14.0-rc4-syzkaller-00169-g1e15510b71c9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor337 state:D stack:11416 pid:5843  tgid:5842  ppid:5840   task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x18bc/0x4c40 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 io_schedule+0x8d/0x110 kernel/sched/core.c:7690
 folio_wait_bit_common+0x839/0xee0 mm/filemap.c:1318
 folio_lock include/linux/pagemap.h:1163 [inline]
 invalidate_inode_pages2_range+0x48f/0x960 mm/truncate.c:637
 bch2_write_invalidate_inode_pages_range+0xce/0x120 fs/bcachefs/fs-io-pagecache.c:68
 bch2_direct_write+0x2ebf/0x3190 fs/bcachefs/fs-io-direct.c:653
 bch2_write_iter+0x19d/0x2cd0 fs/bcachefs/fs-io-buffered.c:1047
 iter_file_splice_write+0xbfa/0x1510 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x11b/0x220 fs/splice.c:1164
 splice_direct_to_actor+0x586/0xc80 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x289/0x3e0 fs/splice.c:1233
 do_sendfile+0x564/0x8a0 fs/read_write.c:1363
 __do_sys_sendfile64 fs/read_write.c:1424 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1410
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f49c6338bd9
RSP: 002b:00007f49c62ef218 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f49c63c66c8 RCX: 00007f49c6338bd9
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000005
RBP: 00007f49c63c66c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000800000009 R11: 0000000000000246 R12: 00007f49c6392ae4
R13: 0031656c69662f2e R14: 0000400000000240 R15: 0000400000000040
 </TASK>
INFO: task syz-executor337:5854 blocked for more than 143 seconds.
      Not tainted 6.14.0-rc4-syzkaller-00169-g1e15510b71c9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor337 state:D stack:19160 pid:5854  tgid:5842  ppid:5840   task_flags:0x440140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x18bc/0x4c40 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 __bch2_two_state_lock+0x229/0x2c0 fs/bcachefs/two_state_shared_lock.c:7
 bch2_two_state_lock fs/bcachefs/two_state_shared_lock.h:55 [inline]
 bch2_readahead+0x9e1/0x1240 fs/bcachefs/fs-io-buffered.c:272
 read_pages+0x179/0x570 mm/readahead.c:161
 page_cache_ra_order+0xa36/0xca0 mm/readahead.c:516
 filemap_get_pages+0x59a/0x1fb0 mm/filemap.c:2580
 filemap_splice_read+0x68e/0xef0 mm/filemap.c:2971
 do_splice_read fs/splice.c:985 [inline]
 splice_direct_to_actor+0x4af/0xc80 fs/splice.c:1089
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x289/0x3e0 fs/splice.c:1233
 do_sendfile+0x564/0x8a0 fs/read_write.c:1363
 __do_sys_sendfile64 fs/read_write.c:1424 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1410
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f49c6338bd9
RSP: 002b:00007f49c62ce218 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f49c63c66d8 RCX: 00007f49c6338bd9
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000006
RBP: 00007f49c63c66d0 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000e3aa6ea R11: 0000000000000246 R12: 00007f49c6392ae4
R13: 0031656c69662f2e R14: 0000400000000240 R15: 0000400000000040
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8eb38fa0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8eb38fa0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8eb38fa0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6746
2 locks held by getty/5583:
 #0: ffff88803112f0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002fde2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x616/0x1770 drivers/tty/n_tty.c:2211
1 lock held by syz-executor337/5843:
 #0: ffff88807c384420 (sb_writers#9){.+.+}-{0:0}, at: direct_splice_actor+0x49/0x220 fs/splice.c:1163
1 lock held by syz-executor337/5854:
 #0: ffff888077d68a80 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:932 [inline]
 #0: ffff888077d68a80 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: page_cache_ra_order+0x45d/0xca0 mm/readahead.c:492

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.14.0-rc4-syzkaller-00169-g1e15510b71c9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:236 [inline]
 watchdog+0x1058/0x10a0 kernel/hung_task.c:399
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:111


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

