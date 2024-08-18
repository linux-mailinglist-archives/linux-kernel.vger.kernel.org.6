Return-Path: <linux-kernel+bounces-291246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF672955FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 00:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89E31C20B68
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 22:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844BC15534D;
	Sun, 18 Aug 2024 22:16:20 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE48610D
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 22:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724019379; cv=none; b=sxmkzZ1Tosh3H9O5UPgBpihRXlFj+AJbD9MjMPNcm65tBWP9qiFcgCd7nSD2Uyk+lQOL8/RGeifukk1rTCrBFevNUZFfx1GvRfV03sVeLXm3zR6cVdXBWfK6ffZ6KqKW17I98iQZeOVuPnE+WD+qztVFEmIkiRj6HaUSX4fxzgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724019379; c=relaxed/simple;
	bh=73hjlk9L9YlrktfWSEOtv2fjlGldLHgNdTVvT9Miovg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rprKz4VxgqfVa5sKLfrvZM5nR/O0YlXKB3eQSkRFd96vnscaowfQ5yoq9lPRix42sL55yV9Ir53amYbgf4A21F2UJRKTLfcunRdQRqJRJJ7qCLzKtqYVvcBylL2hMpjYYoqu+0EVkPOSC/DnWYM8Qtv5utCyMSck7huR9BLv6sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-821dabd4625so380140039f.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 15:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724019377; x=1724624177;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PjGANY1a3lQwLNFwDI+J/7pbc+ZA8ioNAw2iBtRxXOs=;
        b=lpdu5GSicTMfjdyYQq9hGMO8dTqt0ZIKtzWd8d87DalY51hYfp2s6ryTNS1JAbGbfV
         uavA/0GdAJDSdrb0zzHEoevh7JcjVXSl1CLJ302+hEPpy3rafc3sN5Sg3YTMfXhl3dis
         SabQ6iedKFRMcWuVGVC4nU0TxbeQ0ASj4i07txiM85CW+5l7T9yd/MYlXMtNlUSs9NzK
         S+ATwwIZKvCZ0qNzdPEkdUmxdwqrRt5y+RlTfbBG7181SMQm8kjxR7LfKaodwcBQixBz
         On+labmZXHgjcQtdiNoAveSWhkAdH0DYHZORx5238ZyemtosVzDtUTq847uLHlj2NYlr
         e8fw==
X-Forwarded-Encrypted: i=1; AJvYcCVXOEJmwp4aZpa18Hg6vyUkJ5QdRe9FkDHm6fVfm3CNDOTdujKzJ+rK6ntQF9y9sAazS1hPCxD0VZJe9sn8Z/kqLeoBVOslU2noH9xZ
X-Gm-Message-State: AOJu0YzQLYK5gp/ikvsbitpl2tlvFLOKR2Hyy7nkuOJ/ib71CqWk5WCt
	60G5EBMGiymLUH8iuW2ejkOwUl7LcMdHpMZRJMrFRQ+ZLZwNrAn29fjmuTZ7koti81kHJCQ0U9G
	tS7bW+KRdc9lpPzCdxLfZ/4vOug22X9P0m6CM9IEr5e7F+LcJNP/ymQw=
X-Google-Smtp-Source: AGHT+IGS+W4Sac7cnNVlZjT0GTStjqmbNLxqi+BSF64cGQhfSOqo2EiMFsw9u/uq0udkClK37kALIub6TaPUVjReMB/N/yrN5DWO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c04:b0:39d:1a4c:b853 with SMTP id
 e9e14a558f8ab-39d26d9bbe5mr8020265ab.6.1724019377372; Sun, 18 Aug 2024
 15:16:17 -0700 (PDT)
Date: Sun, 18 Aug 2024 15:16:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000931657061ffc8ad9@google.com>
Subject: [syzbot] [kernfs?] possible deadlock in walk_component (4)
From: syzbot <syzbot+b4567a8b2d2ad5f9dd06@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6b0f8db921ab Merge tag 'execve-v6.11-rc4' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16766c05980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54e9d4be0c7a0d11
dashboard link: https://syzkaller.appspot.com/bug?extid=b4567a8b2d2ad5f9dd06
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-6b0f8db9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5829b92d3000/vmlinux-6b0f8db9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b382f2bc118/bzImage-6b0f8db9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b4567a8b2d2ad5f9dd06@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc3-syzkaller-00013-g6b0f8db921ab #0 Not tainted
------------------------------------------------------
syz.0.2542/15091 is trying to acquire lock:
ffff888047e58cf8 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:809 [inline]
ffff888047e58cf8 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: lookup_slow fs/namei.c:1734 [inline]
ffff888047e58cf8 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: walk_component+0x342/0x5b0 fs/namei.c:2039

but task is already holding lock:
ffff8880484c6488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x281/0x500 fs/kernfs/file.c:325

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&of->mutex){+.+.}-{3:3}:
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

-> #2 (&pipe->mutex){+.+.}-{3:3}:
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

-> #1 (sb_writers#6){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1675 [inline]
       sb_start_write include/linux/fs.h:1811 [inline]
       mnt_want_write+0x6f/0x450 fs/namespace.c:515
       ovl_create_object+0x12e/0x300 fs/overlayfs/dir.c:642
       lookup_open.isra.0+0x10a1/0x13c0 fs/namei.c:3578
       open_last_lookups fs/namei.c:3647 [inline]
       path_openat+0xa3b/0x2d20 fs/namei.c:3883
       do_filp_open+0x1dc/0x430 fs/namei.c:3913
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1416
       do_sys_open fs/open.c:1431 [inline]
       __do_sys_openat fs/open.c:1447 [inline]
       __se_sys_openat fs/open.c:1442 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1442
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
       lock_acquire kernel/locking/lockdep.c:5759 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
       inode_lock_shared include/linux/fs.h:809 [inline]
       lookup_slow fs/namei.c:1734 [inline]
       walk_component+0x342/0x5b0 fs/namei.c:2039
       lookup_last fs/namei.c:2542 [inline]
       path_lookupat+0x17f/0x770 fs/namei.c:2566
       filename_lookup+0x1e5/0x5b0 fs/namei.c:2595
       kern_path+0x35/0x50 fs/namei.c:2703
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

other info that might help us debug this:

Chain exists of:
  &ovl_i_mutex_dir_key[depth] --> &pipe->mutex --> &of->mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&of->mutex);
                               lock(&pipe->mutex);
                               lock(&of->mutex);
  rlock(&ovl_i_mutex_dir_key[depth]);

 *** DEADLOCK ***

4 locks held by syz.0.2542/15091:
 #0: ffff8880298c19c8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xeb/0x180 fs/file.c:1187
 #1: ffff888024928420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:643
 #2: ffff8880484c6488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x281/0x500 fs/kernfs/file.c:325
 #3: ffff888016744698 (kn->active#77){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2a4/0x500 fs/kernfs/file.c:326

stack backtrace:
CPU: 1 UID: 0 PID: 15091 Comm: syz.0.2542 Not tainted 6.11.0-rc3-syzkaller-00013-g6b0f8db921ab #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
 lock_acquire kernel/locking/lockdep.c:5759 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
 down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
 inode_lock_shared include/linux/fs.h:809 [inline]
 lookup_slow fs/namei.c:1734 [inline]
 walk_component+0x342/0x5b0 fs/namei.c:2039
 lookup_last fs/namei.c:2542 [inline]
 path_lookupat+0x17f/0x770 fs/namei.c:2566
 filename_lookup+0x1e5/0x5b0 fs/namei.c:2595
 kern_path+0x35/0x50 fs/namei.c:2703
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
RIP: 0033:0x7efcd1f799f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efcd2d56038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007efcd2115f80 RCX: 00007efcd1f799f9
RDX: 0000000000000012 RSI: 0000000020000140 RDI: 0000000000000009
RBP: 00007efcd1fe78ee R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007efcd2115f80 R15: 00007ffdbb59c4e8
 </TASK>
PM: Image not found (code -6)


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

