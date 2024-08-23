Return-Path: <linux-kernel+bounces-298200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA7B95C3BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 05:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA7D1F23682
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 03:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD51438389;
	Fri, 23 Aug 2024 03:34:27 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9242928DA5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 03:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724384067; cv=none; b=NRvG5IbAcIcq6eE99U3BYYidIdCePDU+6fGoomuUf5UVOeNzmAcXlSbCExie2vq1KXcdeyoI8t0+gsmulg+JN+fT26y1ttkqlRZGlwXsqjlNxya9w26MEREPiJMduij1HACmW+EukryCI8ZYzm0wbgSXco6IHC1eJFb/BRB4668=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724384067; c=relaxed/simple;
	bh=/GZbHidTsesMILG8DmLnu6sGmj429sv6v8k01gOeguU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hinWuRJ7VHqcpHX2DV3EkUB2hS/toEUBbh1fHLN1lYhfHlJUf8braSj7S3OFpBjxKupNctBmlwXbuJ4bwjUeJO7x9YUCqRb5P0r1XEd8vp4EuL6cooVdNzJcuBHaA14RI81Ohom4MU9pmpzAUF3cuArPl+y0nrU4Z2b1iYG3yHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8223aed78e2so169003339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 20:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724384065; x=1724988865;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nGegSAKeszEJmXX/eeMZUsEF3sQMUi+1fcDu7xmVINI=;
        b=Jhxgt7MADl8AtQ/ERNo6vMigRWlaJJgeR26jheUfFLGffN9Wm11tJrst+5i4MtNva1
         2Kwwonv5LYYfVUedXxy6mw1+4Vx0+lroYyN424kNGxI+vgqHU/6eGUgm8sHuC+P0DQzQ
         0P9toZSGeXtukDkyop/9lYE+D9SGvreHfvRYoCjzpasq+Luwfv5VbtMIHc2YLCYEXxbp
         DLZAq2zfWfAleJOvkdIk/5GWwogtlc3/0vrjqnxhBc2FIcoNGIDCA935C8SSAfe+NtPI
         /51/XMqt3jBT0GJpsxhKSARKDguNQd2MCJ5vNcZvpoFMmTIfLW61P/pG4RwIbas6KPIh
         haXg==
X-Forwarded-Encrypted: i=1; AJvYcCUrWD7DH+ZUhtkZVFBnB3I1rciFKEGfp2qGTyxy/tHvCUZoWSFUKyVt1/nfqk7X5fc+s+685uXTJHDA/oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaAAVHI9Y31/mifYBtpRhZFdeGZn5J4WUDpxO4b03ui1SP6H2B
	CZ0bz7c7yifbRrIz2UKXwKOBnWQqDS0k/BzyPxL7Z3atOwNp1bAfaKDe4meWZ2f7FuSybaeHqo9
	3PsZbl9QcwN5v8/QACa7ec2+05LfvOCEUUMWVPGuCO/EylNd8DvBaLy8=
X-Google-Smtp-Source: AGHT+IHj0dxYVqyxeBA+iBO3JYAZFu981iG2Bdl7zSYxF0jyXQbKG/Cdc0x4nkdYKAzUzeIBSCLDTal0X1jMkdd4rkgkdTOPosVu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3404:b0:81f:c103:3e5f with SMTP id
 ca18e2360f4ac-8278737e91dmr5095539f.3.1724384064677; Thu, 22 Aug 2024
 20:34:24 -0700 (PDT)
Date: Thu, 22 Aug 2024 20:34:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1be890620517349@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in ntfs_unlink_inode
From: syzbot <syzbot+cccc70d683efa1c3f6a3@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    47ac09b91bef Linux 6.11-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1515fe05980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=cccc70d683efa1c3f6a3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/56a2cea5e963/disk-47ac09b9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6114ba34ec85/vmlinux-47ac09b9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1aef645f1270/bzImage-47ac09b9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cccc70d683efa1c3f6a3@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc4-syzkaller #0 Not tainted
------------------------------------------------------
syz.2.4556/17158 is trying to acquire lock:
ffff88805f0ebbc0 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1110 [inline]
ffff88805f0ebbc0 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_unlink_inode+0x32b/0x840 fs/ntfs3/inode.c:1798

but task is already holding lock:
ffff88805f0ec318 (&ni->ni_lock/5){+.+.}-{3:3}, at: ni_lock_dir fs/ntfs3/ntfs_fs.h:1115 [inline]
ffff88805f0ec318 (&ni->ni_lock/5){+.+.}-{3:3}, at: ntfs_rmdir+0xb1/0xf0 fs/ntfs3/namei.c:222

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&ni->ni_lock/5){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       ni_lock_dir fs/ntfs3/ntfs_fs.h:1115 [inline]
       ntfs_link+0xd9/0x270 fs/ntfs3/namei.c:139
       vfs_link+0x4f7/0x690 fs/namei.c:4692
       do_linkat+0x555/0x6f0 fs/namei.c:4762
       __do_sys_link fs/namei.c:4796 [inline]
       __se_sys_link fs/namei.c:4794 [inline]
       __x64_sys_link+0x82/0x90 fs/namei.c:4794
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&sb->s_type->i_mutex_key#26){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       down_write+0x99/0x220 kernel/locking/rwsem.c:1579
       inode_lock include/linux/fs.h:799 [inline]
       ntfs_file_mmap+0x5bf/0x850 fs/ntfs3/file.c:368
       call_mmap include/linux/fs.h:2129 [inline]
       mmap_region+0xe91/0x2090 mm/mmap.c:2957
       do_mmap+0x8f9/0x1010 mm/mmap.c:1468
       vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
       ksys_mmap_pgoff+0x4f1/0x720 mm/mmap.c:1514
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __might_fault+0xc6/0x120 mm/memory.c:6387
       _inline_copy_to_user include/linux/uaccess.h:176 [inline]
       _copy_to_user+0x2a/0xb0 lib/usercopy.c:26
       copy_to_user include/linux/uaccess.h:209 [inline]
       ni_fiemap+0x5b4/0x1910 fs/ntfs3/frecord.c:2140
       ntfs_fiemap+0x132/0x180 fs/ntfs3/file.c:1279
       ioctl_fiemap fs/ioctl.c:220 [inline]
       do_vfs_ioctl+0x1c09/0x2e50 fs/ioctl.c:841
       __do_sys_ioctl fs/ioctl.c:905 [inline]
       __se_sys_ioctl+0x81/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ni->ni_lock/4){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       ni_lock fs/ntfs3/ntfs_fs.h:1110 [inline]
       ntfs_unlink_inode+0x32b/0x840 fs/ntfs3/inode.c:1798
       ntfs_rmdir+0xbc/0xf0 fs/ntfs3/namei.c:224
       vfs_rmdir+0x3a5/0x510 fs/namei.c:4293
       do_rmdir+0x3b5/0x580 fs/namei.c:4352
       __do_sys_unlinkat fs/namei.c:4528 [inline]
       __se_sys_unlinkat fs/namei.c:4522 [inline]
       __x64_sys_unlinkat+0xde/0xf0 fs/namei.c:4522
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &ni->ni_lock/4 --> &sb->s_type->i_mutex_key#26 --> &ni->ni_lock/5

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ni->ni_lock/5);
                               lock(&sb->s_type->i_mutex_key#26);
                               lock(&ni->ni_lock/5);
  lock(&ni->ni_lock/4);

 *** DEADLOCK ***

4 locks held by syz.2.4556/17158:
 #0: ffff8880696b8420 (sb_writers#14){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff88805f0ec5b0 (&type->i_mutex_dir_key#10/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:834 [inline]
 #1: ffff88805f0ec5b0 (&type->i_mutex_dir_key#10/1){+.+.}-{3:3}, at: do_rmdir+0x263/0x580 fs/namei.c:4340
 #2: ffff88805f0ebe58 (&type->i_mutex_dir_key#10){++++}-{3:3}, at: inode_lock include/linux/fs.h:799 [inline]
 #2: ffff88805f0ebe58 (&type->i_mutex_dir_key#10){++++}-{3:3}, at: vfs_rmdir+0x101/0x510 fs/namei.c:4282
 #3: ffff88805f0ec318 (&ni->ni_lock/5){+.+.}-{3:3}, at: ni_lock_dir fs/ntfs3/ntfs_fs.h:1115 [inline]
 #3: ffff88805f0ec318 (&ni->ni_lock/5){+.+.}-{3:3}, at: ntfs_rmdir+0xb1/0xf0 fs/ntfs3/namei.c:222

stack backtrace:
CPU: 0 UID: 0 PID: 17158 Comm: syz.2.4556 Not tainted 6.11.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 ni_lock fs/ntfs3/ntfs_fs.h:1110 [inline]
 ntfs_unlink_inode+0x32b/0x840 fs/ntfs3/inode.c:1798
 ntfs_rmdir+0xbc/0xf0 fs/ntfs3/namei.c:224
 vfs_rmdir+0x3a5/0x510 fs/namei.c:4293
 do_rmdir+0x3b5/0x580 fs/namei.c:4352
 __do_sys_unlinkat fs/namei.c:4528 [inline]
 __se_sys_unlinkat fs/namei.c:4522 [inline]
 __x64_sys_unlinkat+0xde/0xf0 fs/namei.c:4522
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f13b3979e79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f13b4729038 EFLAGS: 00000246 ORIG_RAX: 0000000000000107
RAX: ffffffffffffffda RBX: 00007f13b3b15f80 RCX: 00007f13b3979e79
RDX: 0000000000000200 RSI: 0000000020000000 RDI: ffffffffffffff9c
RBP: 00007f13b39e7916 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f13b3b15f80 R15: 00007ffd9e06fb08
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

