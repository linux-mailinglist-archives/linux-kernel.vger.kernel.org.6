Return-Path: <linux-kernel+bounces-237083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8F891EADD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 00:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AB3C1F228E4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDF7171095;
	Mon,  1 Jul 2024 22:38:29 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BC312B171
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719873508; cv=none; b=TJYrEfVSMhdMb+JAwuQPKwlBieHOUMHb4j+wj4golj17jOAzUuTB9exk+ddLMj8vtdrBvmhcC10E+F+x6crXcA8l7hoIUNJVy8WBDXNZqD1pZjhj3bLda/bPUT3w6ewa/ShNp7bZucNaWjwdoI/jSBBpo3x999U6Y4zxvodfs7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719873508; c=relaxed/simple;
	bh=Ki5TJMbjcQ+bU+UNWIaJl4ifLx5eMGw3nN0OpOGVieA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rmJ9kDQR/R3pU4RT537lsm1BtAjgEpezjqCcsucyjEfCpG/ssvtgNPB4JiIcg2EjRhDfzyYp13Kj5++/bgZSbFv0EIc8kY6oGa7x1Q4NDBIjQ04BKB7cGlBqggK+a+MVBUQ9hG1jD/Km4ReJLdsV5ksN9gjqWBjje63uJnHoKoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-37642e69d7eso28213175ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 15:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719873506; x=1720478306;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/UoDGT/bMTxPnbQeBtXQha2GWRbRGeGNM7zoz3zg/8=;
        b=FvValAH+izZGa2dh5Aw9BAv1D1vhC+tpvU1ullyPdkuSJe52kEvl6qqwY+xBuy2BNC
         82MIJfmK2P59QEJuna18adQhi6T/zyjzTmPgcEydhAc8jRRViltXNZbt78Dt0hZlexak
         rv+YD4Wy8MMnY7VP2VhKbqLN+lWDfSd76sYZO4olhibG4uA1gK7VTxVx6Fe2mkqe/8rp
         0jHLd/cWoE/jAJKiQ7ffizSo0tA5JKfsJPa0sap+BmNGaWZo6lWos8EO+/nJk9QtD4xR
         ohf+FpkQEOLcoAd6MRxApTr1tY49HC5Ge9b7Vyysrm1h89x1JCspWKlqLLHY4+AL2oax
         o3Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUpme7W3Ils5/1gRhciXat35e5PUpHOd+fwuynz385vAVdc40Q2l67Q/F6GeJDE4c+g04AOGjdKQV74XmofNci2Kd4IFBsegmEG+GkG
X-Gm-Message-State: AOJu0YyFOwwIF/CwXbRWRsxYYyTyLOvshoh+q1hbVPJgVi2X8J3F3VxS
	C6OYhc7QELX5CePjKPVWXxay5EY9smm6YtvhthkogQKWisUYRdNZ+AsGvqcKLyzJvOZfcpq+i6w
	Zj/5yZFGPbu5nIPUBq7gci84/Ke0s8zrtbmq+HqjUVV9nfhfeu0FGO84=
X-Google-Smtp-Source: AGHT+IHFqE04RpEdG3IQvv2GUzgFfOAerU6wH0n/0WCdVB6ge4ssWIaxOK+gRL4IBX3CGDmj/+TVgT20ocJV6Pne9g8rNS+hnT6p
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:cd0:b0:375:a202:254d with SMTP id
 e9e14a558f8ab-37cd0633449mr2350515ab.1.1719873506043; Mon, 01 Jul 2024
 15:38:26 -0700 (PDT)
Date: Mon, 01 Jul 2024 15:38:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062fb24061c374123@google.com>
Subject: [syzbot] [kernfs?] possible deadlock in kernfs_fop_write_iter
From: syzbot <syzbot+24386307cce6239b5f68@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    66e55ff12e73 Merge tag 'for-6.10-rc5-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f114c6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7bd7d605618e43de
dashboard link: https://syzkaller.appspot.com/bug?extid=24386307cce6239b5f68
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-66e55ff1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/48d9401391cb/vmlinux-66e55ff1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8e93c493254b/bzImage-66e55ff1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+24386307cce6239b5f68@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc5-syzkaller-00155-g66e55ff12e73 #0 Not tainted
------------------------------------------------------
syz.2.1818/11922 is trying to acquire lock:
ffff88803d074c88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x281/0x500 fs/kernfs/file.c:325

but task is already holding lock:
ffff88802d7a3868 (&pipe->mutex){+.+.}-{3:3}, at: pipe_lock fs/pipe.c:92 [inline]
ffff88802d7a3868 (&pipe->mutex){+.+.}-{3:3}, at: pipe_lock+0x64/0x80 fs/pipe.c:89

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&pipe->mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       pipe_lock fs/pipe.c:92 [inline]
       pipe_lock+0x64/0x80 fs/pipe.c:89
       iter_file_splice_write+0x1f0/0x10b0 fs/splice.c:687
       do_splice_from fs/splice.c:941 [inline]
       do_splice+0x148c/0x1f90 fs/splice.c:1354
       __do_splice+0x327/0x360 fs/splice.c:1436
       __do_sys_splice fs/splice.c:1652 [inline]
       __se_sys_splice fs/splice.c:1634 [inline]
       __x64_sys_splice+0x1d2/0x260 fs/splice.c:1634
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (sb_writers#5){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1655 [inline]
       sb_start_write include/linux/fs.h:1791 [inline]
       mnt_want_write+0x6f/0x450 fs/namespace.c:409
       ovl_set_or_remove_acl fs/overlayfs/inode.c:517 [inline]
       ovl_set_acl+0x518/0xa00 fs/overlayfs/inode.c:566
       set_posix_acl+0x25c/0x320 fs/posix_acl.c:955
       vfs_set_acl+0x53d/0x940 fs/posix_acl.c:1134
       do_set_acl+0x15a/0x1b0 fs/posix_acl.c:1279
       do_setxattr+0xeb/0x170 fs/xattr.c:626
       setxattr+0x15d/0x180 fs/xattr.c:652
       path_setxattr+0x179/0x1e0 fs/xattr.c:671
       __do_sys_lsetxattr fs/xattr.c:694 [inline]
       __se_sys_lsetxattr fs/xattr.c:690 [inline]
       __x64_sys_lsetxattr+0xc1/0x160 fs/xattr.c:690
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&ovl_i_mutex_dir_key[depth]#2){++++}-{3:3}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
       inode_lock_shared include/linux/fs.h:801 [inline]
       lookup_slow fs/namei.c:1708 [inline]
       walk_component+0x342/0x5b0 fs/namei.c:2004
       lookup_last fs/namei.c:2469 [inline]
       path_lookupat+0x17f/0x770 fs/namei.c:2493
       filename_lookup+0x1e5/0x5b0 fs/namei.c:2522
       kern_path+0x35/0x50 fs/namei.c:2630
       lookup_bdev+0xd9/0x280 block/bdev.c:1157
       resume_store+0x1d8/0x460 kernel/power/hibernate.c:1235
       kobj_attr_store+0x55/0x80 lib/kobject.c:840
       sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:136
       kernfs_fop_write_iter+0x343/0x500 fs/kernfs/file.c:334
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0x6b6/0x1140 fs/read_write.c:590
       ksys_write+0x12f/0x260 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&of->mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       kernfs_fop_write_iter+0x281/0x500 fs/kernfs/file.c:325
       iter_file_splice_write+0x906/0x10b0 fs/splice.c:743
       do_splice_from fs/splice.c:941 [inline]
       do_splice+0x148c/0x1f90 fs/splice.c:1354
       __do_splice+0x327/0x360 fs/splice.c:1436
       __do_sys_splice fs/splice.c:1652 [inline]
       __se_sys_splice fs/splice.c:1634 [inline]
       __x64_sys_splice+0x1d2/0x260 fs/splice.c:1634
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &of->mutex --> sb_writers#5 --> &pipe->mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&pipe->mutex);
                               lock(sb_writers#5);
                               lock(&pipe->mutex);
  lock(&of->mutex);

 *** DEADLOCK ***

2 locks held by syz.2.1818/11922:
 #0: ffff888024784420 (sb_writers#9){.+.+}-{0:0}, at: __do_splice+0x327/0x360 fs/splice.c:1436
 #1: ffff88802d7a3868 (&pipe->mutex){+.+.}-{3:3}, at: pipe_lock fs/pipe.c:92 [inline]
 #1: ffff88802d7a3868 (&pipe->mutex){+.+.}-{3:3}, at: pipe_lock+0x64/0x80 fs/pipe.c:89

stack backtrace:
CPU: 2 PID: 11922 Comm: syz.2.1818 Not tainted 6.10.0-rc5-syzkaller-00155-g66e55ff12e73 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 kernfs_fop_write_iter+0x281/0x500 fs/kernfs/file.c:325
 iter_file_splice_write+0x906/0x10b0 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 do_splice+0x148c/0x1f90 fs/splice.c:1354
 __do_splice+0x327/0x360 fs/splice.c:1436
 __do_sys_splice fs/splice.c:1652 [inline]
 __se_sys_splice fs/splice.c:1634 [inline]
 __x64_sys_splice+0x1d2/0x260 fs/splice.c:1634
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5821175b29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5821e78048 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00007f5821304070 RCX: 00007f5821175b29
RDX: 0000000000000006 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f58211f6756 R08: 000000000000bfd1 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f5821304070 R15: 00007ffda6f8dbe8
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

