Return-Path: <linux-kernel+bounces-562551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCF0A62BCE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 12:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A305A3BDC86
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 11:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE4F1F874C;
	Sat, 15 Mar 2025 11:28:31 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B891F3BBC
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742038111; cv=none; b=T47Ix7pMRmmP5Omk90txB8WfuumnUmA4r1oQ8bVpLiJeeXGdKCW402vmj6C8pjlvb8kcpashcyVh76sZvTbnepimAuoVEt269SojUUvu2mikuxQYWa5rw6kOs9tCm9Z4LmxRdlYk31csUyPFwlVl12/Zq6yApMrdeZEQ2JHub+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742038111; c=relaxed/simple;
	bh=pvfjdYSUt2n/ZwRU+Co2SQodwKeyPhv1FS9k8PUZSjA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kNADJIfeoEeL4Zm8QQirhMdYgYnE6L3EV1lx/IWv1xDadaRS/cm3Hi20LbgvdwZ5cHzaoZmeYdT65USWCp1gvdncdJNneQUPXdEXdsChYHGIc3t5ScBImcvC0BaUxI4JpH6ZVeLcn1NIXJbbBy94rlZb9KNKFRRXZzA5hzlhS30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-85d9a52717aso305341939f.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 04:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742038108; x=1742642908;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UgXQDnHoXFRYXrEu/79dfVBcLtArnNDlUuUQ8+tXDd4=;
        b=EYrLR/RxsTDpAUMeLgSOYwxvw483ED+55nzJRo0hVMg0INT88mxdC/E57siX+Lqqmb
         F2UrX9WcJnlOw5qO4tyqX+IXiLjHE98YEkh2z901F+0Bk883+yw+h1gXPnJw9yoGCDqz
         ccNw+8LFArga9PPlJAdVkGDWGuU6pMQvsuFt9OAKDz5UCvj+YS8SWmgLz3+oGzU0WwZr
         pHxzZrXPT+EZq1GXM6DX18MHSTk22JWhMt8flT/SZap98J4+pDnniVf0f7sSABRGouof
         qEBvj1Em7ZTRUQY4rubrbPIRAmASVEmck/ZcaZJtbGSNFGR8tSQcGJHlMZMrMJ7E18M0
         U6cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVcMGm+JUyYpphBfolXK6VvP6FchaYbNVcjnuEAhU8/faDL0Fc/RJzqqBLtXpssx8+MdWyrvfgdJw01T8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrnFy8wclTuf7Hv11mCl5OEEyjXzTc3ux7NN+gY0QP9vFPkpAv
	nMMDrMFpt4k6JYnuL5AUnHPfCIzZr7kSrrrFmPdXZbDe+iYDHkSqAtlF2wJUUDPBaSh1BkBdibr
	ShJNm3FgIqb//JEFtfYw5PewmeUzL0wMw+kg34zR1kfWDeDrti97LgYI=
X-Google-Smtp-Source: AGHT+IGkMp7pv0neRCLy6oDApp9bpKtRz7NxSlMZH0fDD6fJBOSmsSr+dR9CqBLjVeBdCiPlnU/c+qu6B/niejhqtp9tI0KM7YOG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fea:b0:3d1:883c:6e86 with SMTP id
 e9e14a558f8ab-3d483a09c3emr56534355ab.8.1742038108532; Sat, 15 Mar 2025
 04:28:28 -0700 (PDT)
Date: Sat, 15 Mar 2025 04:28:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d5645c.050a0220.1dc86f.0004.GAE@google.com>
Subject: [syzbot] [ocfs2?] possible deadlock in __ocfs2_flush_truncate_log
From: syzbot <syzbot+6bf948e47f9bac7aacfa@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4003c9e78778 Merge tag 'net-6.14-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=114d0fa8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb44f62cb82f8a0a
dashboard link: https://syzkaller.appspot.com/bug?extid=6bf948e47f9bac7aacfa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119f2c78580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1469304c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-4003c9e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d5eb122d2f89/vmlinux-4003c9e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/51856a1503a2/bzImage-4003c9e7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2e8806b27a27/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=100d7654580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6bf948e47f9bac7aacfa@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.14.0-rc6-syzkaller-00103-g4003c9e78778 #0 Not tainted
------------------------------------------------------
kworker/u4:1/14 is trying to acquire lock:
ffff8880447bd100 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#5){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:877 [inline]
ffff8880447bd100 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#5){+.+.}-{4:4}, at: __ocfs2_flush_truncate_log+0x388/0x1240 fs/ocfs2/alloc.c:6046

but task is already holding lock:
ffff8880447c3480 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#6){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:877 [inline]
ffff8880447c3480 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#6){+.+.}-{4:4}, at: ocfs2_flush_truncate_log fs/ocfs2/alloc.c:6075 [inline]
ffff8880447c3480 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#6){+.+.}-{4:4}, at: ocfs2_truncate_log_worker+0x9a/0x1b0 fs/ocfs2/alloc.c:6089

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#6){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       inode_lock include/linux/fs.h:877 [inline]
       ocfs2_move_extent fs/ocfs2/move_extents.c:640 [inline]
       __ocfs2_move_extents_range+0x1f0b/0x4440 fs/ocfs2/move_extents.c:860
       ocfs2_move_extents+0x3ee/0xac0 fs/ocfs2/move_extents.c:927
       ocfs2_ioctl_move_extents+0x61a/0x830 fs/ocfs2/move_extents.c:1053
       ocfs2_ioctl+0x196/0x7d0 fs/ocfs2/ioctl.c:946
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#5){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3163 [inline]
       check_prevs_add kernel/locking/lockdep.c:3282 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       inode_lock include/linux/fs.h:877 [inline]
       __ocfs2_flush_truncate_log+0x388/0x1240 fs/ocfs2/alloc.c:6046
       ocfs2_flush_truncate_log fs/ocfs2/alloc.c:6076 [inline]
       ocfs2_truncate_log_worker+0xa2/0x1b0 fs/ocfs2/alloc.c:6089
       process_one_work kernel/workqueue.c:3238 [inline]
       process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3319
       worker_thread+0x870/0xd30 kernel/workqueue.c:3400
       kthread+0x7a9/0x920 kernel/kthread.c:464
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#6);
                               lock(&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#5);
                               lock(&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#6);
  lock(&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#5);

 *** DEADLOCK ***

3 locks held by kworker/u4:1/14:
 #0: ffff88803f7b2948 ((wq_completion)ocfs2_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88803f7b2948 ((wq_completion)ocfs2_wq){+.+.}-{0:0}, at: process_scheduled_works+0x98b/0x18e0 kernel/workqueue.c:3319
 #1: ffffc9000040fc60 ((work_completion)(&(&osb->osb_truncate_log_wq)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000040fc60 ((work_completion)(&(&osb->osb_truncate_log_wq)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9c6/0x18e0 kernel/workqueue.c:3319
 #2: ffff8880447c3480 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#6){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:877 [inline]
 #2: ffff8880447c3480 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#6){+.+.}-{4:4}, at: ocfs2_flush_truncate_log fs/ocfs2/alloc.c:6075 [inline]
 #2: ffff8880447c3480 (&ocfs2_sysfile_lock_key[args->fi_sysfile_type]#6){+.+.}-{4:4}, at: ocfs2_truncate_log_worker+0x9a/0x1b0 fs/ocfs2/alloc.c:6089

stack backtrace:
CPU: 0 UID: 0 PID: 14 Comm: kworker/u4:1 Not tainted 6.14.0-rc6-syzkaller-00103-g4003c9e78778 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: ocfs2_wq ocfs2_truncate_log_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2076
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2208
 check_prev_add kernel/locking/lockdep.c:3163 [inline]
 check_prevs_add kernel/locking/lockdep.c:3282 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 down_write+0x99/0x220 kernel/locking/rwsem.c:1577
 inode_lock include/linux/fs.h:877 [inline]
 __ocfs2_flush_truncate_log+0x388/0x1240 fs/ocfs2/alloc.c:6046
 ocfs2_flush_truncate_log fs/ocfs2/alloc.c:6076 [inline]
 ocfs2_truncate_log_worker+0xa2/0x1b0 fs/ocfs2/alloc.c:6089
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3319
 worker_thread+0x870/0xd30 kernel/workqueue.c:3400
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
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

