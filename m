Return-Path: <linux-kernel+bounces-528181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C760A41499
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910B11890710
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 05:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A641A304A;
	Mon, 24 Feb 2025 05:02:23 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F935EEA8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740373342; cv=none; b=skHXku4fFwZszHEb2j/5CsUCU46UHsDRKhntC7nn69/05IUMfDiOHz8C4LV5uLR5EKQfqszyzrYMufSGxcI1zmgQPaJEZNu1ogU8ngLF5z9fAH8nDVKc0kyPTJCZ7SXDJUnXWFzSN5ldJ+yeNX81b7dp1RkvC5Vm6nvpEftf8LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740373342; c=relaxed/simple;
	bh=Afp3Tlpetqv7gdBNhh8by1evIURMXNRKljhsIhBM6Xw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sK9pfxYJgMw56dSERI5XLjEjZbtQXDSkE8a/IuiAFm0M7K2fDROQxn/4FK7ulRDwNILC0IIJ9CzhQQBSzYzcHOZMOaYHq3vT07mEbUffCzxc5Ch8N4FNFg0q69CFdbAYj4dULbRlN4Dvg1ic/xq9rzxeOfCX2gsARj8FbVW5AHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-8559d67a0daso827972039f.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 21:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740373339; x=1740978139;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d1LuiwTnhxFqGKXEvdeoIsjmOesyDtr4398x5Mxpx4c=;
        b=TN9yKlfUPosFla8K7K1BZbsHtI0uU2FvPIaKkOeORr2UJ0UbM6e7WH4e3JiVgf1jm+
         R7P3B+IK7NLuI4Py3D1Z7L9rPY+MD3tgRyCYB9dkDZRxSf0wo2koZkFa+0YVzxQ8Synz
         amlp7y12n0Pb/3kyrQuUyRWBLXbJOegBct36wwXByH4oozrsEODyd96Ip0k8cHUGi5G3
         Yuo8mxHB7u+335RXAhzh+Exllv4rKCNodK3O7bKr0kR9NrUCRZYO6zRQDf5d/JBowK4d
         qbqKckc2RkSUO2JSqbAezLE1GxVEIv0TrJ1qfSOR51Midj26cVCz/UZpv6H9YIO6ZLa6
         atMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUwuXYswg5m5Cz3UI6j7uPst8ylu8Sq9R/D3MZR/E3n08VVrZ2X59VN4XpGwCqk8WEQg6oXcjUM4oXcBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmKiaEzgQcdOZhnzNc0QOGgp/qmLfe5o5ux3WscpynIi6IWFy/
	Mnr8yG9/52jgKaLDxjwfH8QUQ0lpQvAsAQBrik8qloviQ/dTphJ8McZot1/umzQThS7Nzny8nky
	QDAQArW7u8EV/c8yVzPhe/45lRJopitCJUsNKrS5O/CEXwGFOv/+aY9M=
X-Google-Smtp-Source: AGHT+IEpL3v2O47v3i5h7Bz+0lgtzzU4Ps7/WJX/9OPRy7ZiAry+N/vyb9lsybQwruzAU37//2ygcsamUeA0RBrXoqLtp2wg61hc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0f:b0:3d2:b34d:a264 with SMTP id
 e9e14a558f8ab-3d2cb492863mr123676185ab.12.1740373339625; Sun, 23 Feb 2025
 21:02:19 -0800 (PST)
Date: Sun, 23 Feb 2025 21:02:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bbfd5b.050a0220.bbfd1.0043.GAE@google.com>
Subject: [syzbot] [jfs?] BUG: sleeping function called from invalid context in jfs_fsync
From: syzbot <syzbot+c266ffd7d9f1769517ec@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e6747d19291c Merge branch 'for-next/el2-enable-feat-pmuv3p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12435ae4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6b108de97771157
dashboard link: https://syzkaller.appspot.com/bug?extid=c266ffd7d9f1769517ec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157c6fdf980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137bddb8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/874063395a28/disk-e6747d19.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f707e2e6b743/vmlinux-e6747d19.xz
kernel image: https://storage.googleapis.com/syzbot-assets/57c934b7f0e8/Image-e6747d19.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fdad6db15ae6/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=106fdba4580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c266ffd7d9f1769517ec@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1576
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 16, name: ksoftirqd/0
preempt_count: 100, expected: 0
RCU nest depth: 0, expected: 0
no locks held by ksoftirqd/0/16.
Preemption disabled at:
[<ffff8000803110e4>] softirq_handle_begin kernel/softirq.c:402 [inline]
[<ffff8000803110e4>] handle_softirqs+0xe0/0xd34 kernel/softirq.c:537
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.14.0-rc3-syzkaller-ge6747d19291c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 __might_resched+0x374/0x4d0 kernel/sched/core.c:8767
 __might_sleep+0x90/0xe4 kernel/sched/core.c:8696
 down_write+0x28/0xc0 kernel/locking/rwsem.c:1576
 inode_lock include/linux/fs.h:877 [inline]
 jfs_fsync+0xa0/0x1d4 fs/jfs/file.c:28
 vfs_fsync_range+0x160/0x19c fs/sync.c:187
 generic_write_sync include/linux/fs.h:2970 [inline]
 dio_complete+0x510/0x6b8 fs/direct-io.c:313
 dio_bio_end_aio+0x488/0x550 fs/direct-io.c:368
 bio_endio+0x840/0x87c block/bio.c:1548
 blk_update_request+0x4ac/0xda0 block/blk-mq.c:983
 blk_mq_end_request+0x54/0x88 block/blk-mq.c:1145
 lo_complete_rq+0x188/0x2f4 drivers/block/loop.c:395
 blk_complete_reqs block/blk-mq.c:1220 [inline]
 blk_done_softirq+0x11c/0x168 block/blk-mq.c:1225
 handle_softirqs+0x320/0xd34 kernel/softirq.c:561
 run_ksoftirqd+0x70/0xc0 kernel/softirq.c:950
 smpboot_thread_fn+0x4b0/0x90c kernel/smpboot.c:164
 kthread+0x65c/0x7b0 kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862

=============================
[ BUG: Invalid wait context ]
6.14.0-rc3-syzkaller-ge6747d19291c #0 Tainted: G        W         
-----------------------------
ksoftirqd/0/16 is trying to lock:
ffff0000dd220578 (&sb->s_type->i_mutex_key#18){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:877 [inline]
ffff0000dd220578 (&sb->s_type->i_mutex_key#18){+.+.}-{4:4}, at: jfs_fsync+0xa0/0x1d4 fs/jfs/file.c:28
other info that might help us debug this:
context-{3:3}
no locks held by ksoftirqd/0/16.
stack backtrace:
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Tainted: G        W          6.14.0-rc3-syzkaller-ge6747d19291c #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4828 [inline]
 check_wait_context kernel/locking/lockdep.c:4900 [inline]
 __lock_acquire+0x2034/0x7904 kernel/locking/lockdep.c:5178
 lock_acquire+0x23c/0x724 kernel/locking/lockdep.c:5851
 down_write+0x50/0xc0 kernel/locking/rwsem.c:1577
 inode_lock include/linux/fs.h:877 [inline]
 jfs_fsync+0xa0/0x1d4 fs/jfs/file.c:28
 vfs_fsync_range+0x160/0x19c fs/sync.c:187
 generic_write_sync include/linux/fs.h:2970 [inline]
 dio_complete+0x510/0x6b8 fs/direct-io.c:313
 dio_bio_end_aio+0x488/0x550 fs/direct-io.c:368
 bio_endio+0x840/0x87c block/bio.c:1548
 blk_update_request+0x4ac/0xda0 block/blk-mq.c:983
 blk_mq_end_request+0x54/0x88 block/blk-mq.c:1145
 lo_complete_rq+0x188/0x2f4 drivers/block/loop.c:395
 blk_complete_reqs block/blk-mq.c:1220 [inline]
 blk_done_softirq+0x11c/0x168 block/blk-mq.c:1225
 handle_softirqs+0x320/0xd34 kernel/softirq.c:561
 run_ksoftirqd+0x70/0xc0 kernel/softirq.c:950
 smpboot_thread_fn+0x4b0/0x90c kernel/smpboot.c:164
 kthread+0x65c/0x7b0 kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1576
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 16, name: ksoftirqd/0
preempt_count: 100, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<ffff8000803110e4>] softirq_handle_begin kernel/softirq.c:402 [inline]
[<ffff8000803110e4>] handle_softirqs+0xe0/0xd34 kernel/softirq.c:537
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Tainted: G        W          6.14.0-rc3-syzkaller-ge6747d19291c #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 __might_resched+0x374/0x4d0 kernel/sched/core.c:8767
 __might_sleep+0x90/0xe4 kernel/sched/core.c:8696
 down_write+0x28/0xc0 kernel/locking/rwsem.c:1576
 inode_lock include/linux/fs.h:877 [inline]
 jfs_fsync+0xa0/0x1d4 fs/jfs/file.c:28
 vfs_fsync_range+0x160/0x19c fs/sync.c:187
 generic_write_sync include/linux/fs.h:2970 [inline]
 dio_complete+0x510/0x6b8 fs/direct-io.c:313
 dio_bio_end_aio+0x488/0x550 fs/direct-io.c:368
 bio_endio+0x840/0x87c block/bio.c:1548
 blk_update_request+0x4ac/0xda0 block/blk-mq.c:983
 blk_mq_end_request+0x54/0x88 block/blk-mq.c:1145
 lo_complete_rq+0x188/0x2f4 drivers/block/loop.c:395
 blk_complete_reqs block/blk-mq.c:1220 [inline]
 blk_done_softirq+0x11c/0x168 block/blk-mq.c:1225
 handle_softirqs+0x320/0xd34 kernel/softirq.c:561
 run_ksoftirqd+0x70/0xc0 kernel/softirq.c:950
 smpboot_thread_fn+0x4b0/0x90c kernel/smpboot.c:164
 kthread+0x65c/0x7b0 kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1576
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 16, name: ksoftirqd/0
preempt_count: 100, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<ffff8000803110e4>] softirq_handle_begin kernel/softirq.c:402 [inline]
[<ffff8000803110e4>] handle_softirqs+0xe0/0xd34 kernel/softirq.c:537
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Tainted: G        W          6.14.0-rc3-syzkaller-ge6747d19291c #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 __might_resched+0x374/0x4d0 kernel/sched/core.c:8767
 __might_sleep+0x90/0xe4 kernel/sched/core.c:8696
 down_write+0x28/0xc0 kernel/locking/rwsem.c:1576
 inode_lock include/linux/fs.h:877 [inline]
 jfs_fsync+0xa0/0x1d4 fs/jfs/file.c:28
 vfs_fsync_range+0x160/0x19c fs/sync.c:187
 generic_write_sync include/linux/fs.h:2970 [inline]
 dio_complete+0x510/0x6b8 fs/direct-io.c:313
 dio_bio_end_aio+0x488/0x550 fs/direct-io.c:368
 bio_endio+0x840/0x87c block/bio.c:1548
 blk_update_request+0x4ac/0xda0 block/blk-mq.c:983
 blk_mq_end_request+0x54/0x88 block/blk-mq.c:1145
 lo_complete_rq+0x188/0x2f4 drivers/block/loop.c:395
 blk_complete_reqs block/blk-mq.c:1220 [inline]
 blk_done_softirq+0x11c/0x168 block/blk-mq.c:1225
 handle_softirqs+0x320/0xd34 kernel/softirq.c:561
 run_ksoftirqd+0x70/0xc0 kernel/softirq.c:950
 smpboot_thread_fn+0x4b0/0x90c kernel/smpboot.c:164
 kthread+0x65c/0x7b0 kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1576
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 16, name: ksoftirqd/0
preempt_count: 100, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<ffff8000803110e4>] softirq_handle_begin kernel/softirq.c:402 [inline]
[<ffff8000803110e4>] handle_softirqs+0xe0/0xd34 kernel/softirq.c:537
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Tainted: G        W          6.14.0-rc3-syzkaller-ge6747d19291c #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 __might_resched+0x374/0x4d0 kernel/sched/core.c:8767
 __might_sleep+0x90/0xe4 kernel/sched/core.c:8696
 down_write+0x28/0xc0 kernel/locking/rwsem.c:1576
 inode_lock include/linux/fs.h:877 [inline]
 jfs_fsync+0xa0/0x1d4 fs/jfs/file.c:28
 vfs_fsync_range+0x160/0x19c fs/sync.c:187
 generic_write_sync include/linux/fs.h:2970 [inline]
 dio_complete+0x510/0x6b8 fs/direct-io.c:313
 dio_bio_end_aio+0x488/0x550 fs/direct-io.c:368
 bio_endio+0x840/0x87c block/bio.c:1548
 blk_update_request+0x4ac/0xda0 block/blk-mq.c:983
 blk_mq_end_request+0x54/0x88 block/blk-mq.c:1145
 lo_complete_rq+0x188/0x2f4 drivers/block/loop.c:395
 blk_complete_reqs block/blk-mq.c:1220 [inline]
 blk_done_softirq+0x11c/0x168 block/blk-mq.c:1225
 handle_softirqs+0x320/0xd34 kernel/softirq.c:561
 run_ksoftirqd+0x70/0xc0 kernel/softirq.c:950
 smpboot_thread_fn+0x4b0/0x90c kernel/smpboot.c:164
 kthread+0x65c/0x7b0 kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1576
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 16, name: ksoftirqd/0
preempt_count: 100, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<ffff8000803110e4>] softirq_handle_begin kernel/softirq.c:402 [inline]
[<ffff8000803110e4>] handle_softirqs+0xe0/0xd34 kernel/softirq.c:537
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Tainted: G        W          6.14.0-rc3-syzkaller-ge6747d19291c #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 __might_resched+0x374/0x4d0 kernel/sched/core.c:8767
 __might_sleep+0x90/0xe4 kernel/sched/core.c:8696
 down_write+0x28/0xc0 kernel/locking/rwsem.c:1576
 inode_lock include/linux/fs.h:877 [inline]
 jfs_fsync+0xa0/0x1d4 fs/jfs/file.c:28
 vfs_fsync_range+0x160/0x19c fs/sync.c:187
 generic_write_sync include/linux/fs.h:2970 [inline]
 dio_complete+0x510/0x6b8 fs/direct-io.c:313
 dio_bio_end_aio+0x488/0x550 fs/direct-io.c:368
 bio_endio+0x840/0x87c block/bio.c:1548
 blk_update_request+0x4ac/0xda0 block/blk-mq.c:983
 blk_mq_end_request+0x54/0x88 block/blk-mq.c:1145
 lo_complete_rq+0x188/0x2f4 drivers/block/loop.c:395
 blk_complete_reqs block/blk-mq.c:1220 [inline]
 blk_done_softirq+0x11c/0x168 block/blk-mq.c:1225
 handle_softirqs+0x320/0xd34 kernel/softirq.c:561
 run_ksoftirqd+0x70/0xc0 kernel/softirq.c:950
 smpboot_thread_fn+0x4b0/0x90c kernel/smpboot.c:164
 kthread+0x65c/0x7b0 kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862


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

