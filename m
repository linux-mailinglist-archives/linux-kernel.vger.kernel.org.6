Return-Path: <linux-kernel+bounces-289361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E8095454A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE3BAB24E40
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862E613D531;
	Fri, 16 Aug 2024 09:16:30 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF44139579
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799789; cv=none; b=IEixn8Wwm/Sp3EgS4B3NQud7aw1PVDa8TIxhnkmTQj9N1S+8SGi6Cu7kn6GyO1M+PWecXbatVaU0B++qD+dZNUAC2hyV3g32ZsfCX9E45FYCqIoq2/LIbxnPVrOfuJBd/9PxSjAHwQ3/qvQuZwUa1AVv80ZZRTw5Z2A2mNd061o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799789; c=relaxed/simple;
	bh=3povJbsWSBMrB5YtLVGQb1AIbHXA6N2jOlDNGDwkVjA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PMaLbie4bdrhUe/c3ywJfMAa6dnkwArN7SZ2nsPKA7FGxSy/Wikxa2HCjsn9l59mKZA6ksmVzR21X5Eox+xIj7YI6sYL1OW00FboQjQ6YnLqAX23acImkiOLOylMzNKItwxxhmTNCJqbn0fG8GKJd2urBozhDgncsPVJCykuwgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d2dee9722so1222625ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723799787; x=1724404587;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6swvxELE9u/ROCNrGiOGtPOS2/V8W+8x5poLYagfG/U=;
        b=r2QGbgqkTMs/b3znsG5jZE7ARDCw9/58uWGHsBJWnKXlbOnBmy2vwYUeAxBFNBj0hE
         jJUMRIky+Em10LsHV+SI7/CTAgWOdD9HtOcjbkpk3Me8hARcK2eS9gR7VbU9s9Bu5G6s
         k54Ydzf/9FvqffCfhq1KdulxwhYuSr7q6R4fSNfbiZLmvPofM+o3PIyion9c5Zcu6KX3
         hpEaaYtG7DTp7cq50GuMwVYE71ugvyUpapS6my89z1bvoI6tdTLfd9P4euoaSZ2UMUiF
         3VnL9OzN1KVgiIL9R3345hdJkmWLbVbMsbWc9Rw0cwMkLKELt4C/ymeHkI816PM4DrJx
         eAng==
X-Forwarded-Encrypted: i=1; AJvYcCVBSrneKPJCM5jCkU4MkpBMKJJFSuHTPzFACZqB9T/AmlwD5SE5XgXdGpLTq2VLdUHAlmhKmrLBjUoajC9PWHceHYm/dY+7PrUQ5qHU
X-Gm-Message-State: AOJu0YwqeYJPbgoGeSu5KJYduM5CttgsTVmVKL5Y1l6L+9f+DJnlIaym
	31KB/p1MLgbSTX/mhiG55+S1Xnt22NE/t82MivhXyMMyek8hW/RBTBzrLtEXt+8AJ0CZRFFJVmZ
	VUvuNbnib9djQGGnZQYqauHxCCi+OqrfFgZNEgUWR5dJedx+m+KgEQbo=
X-Google-Smtp-Source: AGHT+IE7nxGoospNfrrmGFS4Yo1bV3G5STW9uGeQHjxGcZVaotYpQNeztay2IhdijG+Xp0E9GsAsgUKkMOX0RKJpIqqEwCnWjXvX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c7:b0:397:35d4:3811 with SMTP id
 e9e14a558f8ab-39d26d7aa3dmr1413475ab.3.1723799787099; Fri, 16 Aug 2024
 02:16:27 -0700 (PDT)
Date: Fri, 16 Aug 2024 02:16:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f963fc061fc96998@google.com>
Subject: [syzbot] [f2fs?] possible deadlock in f2fs_release_file (2)
From: syzbot <syzbot+9aff3b6811f0a00daffa@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9e6869691724 Add linux-next specific files for 20240812
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1203caf3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
dashboard link: https://syzkaller.appspot.com/bug?extid=9aff3b6811f0a00daffa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1b086192f50/disk-9e686969.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b457920fb52e/vmlinux-9e686969.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e63ba9cce98a/bzImage-9e686969.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9aff3b6811f0a00daffa@syzkaller.appspotmail.com

F2FS-fs (loop0): Try to recover 1th superblock, ret: 0
F2FS-fs (loop0): Mounted with checkpoint version = 48b305e5
syz.0.98: attempt to access beyond end of device
loop0: rw=2049, sector=45096, nr_sectors = 8 limit=40427
======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc3-next-20240812-syzkaller #0 Not tainted
------------------------------------------------------
syz.0.98/5917 is trying to acquire lock:
ffff88807896ad30 (&sb->s_type->i_mutex_key#26){++++}-{3:3}, at: inode_lock include/linux/fs.h:799 [inline]
ffff88807896ad30 (&sb->s_type->i_mutex_key#26){++++}-{3:3}, at: f2fs_release_file+0x9b/0x100 fs/f2fs/file.c:1940

but task is already holding lock:
ffff88807896b308 (&fi->i_gc_rwsem[WRITE]){++++}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2196 [inline]
ffff88807896b308 (&fi->i_gc_rwsem[WRITE]){++++}-{3:3}, at: f2fs_commit_atomic_write+0x105/0x1510 fs/f2fs/segment.c:388

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&fi->i_gc_rwsem[WRITE]){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5762
       down_write+0x99/0x220 kernel/locking/rwsem.c:1579
       f2fs_down_write fs/f2fs/f2fs.h:2196 [inline]
       f2fs_setattr+0xb80/0x12d0 fs/f2fs/file.c:1060
       notify_change+0xb9d/0xe70 fs/attr.c:535
       do_truncate+0x220/0x310 fs/open.c:65
       handle_truncate fs/namei.c:3395 [inline]
       do_open fs/namei.c:3745 [inline]
       path_openat+0x2ced/0x3470 fs/namei.c:3900
       do_filp_open+0x235/0x490 fs/namei.c:3927
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
       do_sys_open fs/open.c:1431 [inline]
       __do_sys_creat fs/open.c:1507 [inline]
       __se_sys_creat fs/open.c:1501 [inline]
       __x64_sys_creat+0x123/0x170 fs/open.c:1501
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sb->s_type->i_mutex_key#26){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3136 [inline]
       check_prevs_add kernel/locking/lockdep.c:3255 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3871
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5145
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5762
       down_write+0x99/0x220 kernel/locking/rwsem.c:1579
       inode_lock include/linux/fs.h:799 [inline]
       f2fs_release_file+0x9b/0x100 fs/f2fs/file.c:1940
       __fput+0x24a/0x8a0 fs/file_table.c:425
       task_work_run+0x24f/0x310 kernel/task_work.c:228
       get_signal+0x16ad/0x1810 kernel/signal.c:2690
       arch_do_signal_or_restart+0x96/0x830 arch/x86/kernel/signal.c:337
       exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
       do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&fi->i_gc_rwsem[WRITE]);
                               lock(&sb->s_type->i_mutex_key#26);
                               lock(&fi->i_gc_rwsem[WRITE]);
  lock(&sb->s_type->i_mutex_key#26);

 *** DEADLOCK ***

1 lock held by syz.0.98/5917:
 #0: ffff88807896b308 (&fi->i_gc_rwsem[WRITE]){++++}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2196 [inline]
 #0: ffff88807896b308 (&fi->i_gc_rwsem[WRITE]){++++}-{3:3}, at: f2fs_commit_atomic_write+0x105/0x1510 fs/f2fs/segment.c:388

stack backtrace:
CPU: 0 UID: 0 PID: 5917 Comm: syz.0.98 Not tainted 6.11.0-rc3-next-20240812-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2189
 check_prev_add kernel/locking/lockdep.c:3136 [inline]
 check_prevs_add kernel/locking/lockdep.c:3255 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3871
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5145
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5762
 down_write+0x99/0x220 kernel/locking/rwsem.c:1579
 inode_lock include/linux/fs.h:799 [inline]
 f2fs_release_file+0x9b/0x100 fs/f2fs/file.c:1940
 __fput+0x24a/0x8a0 fs/file_table.c:425
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 get_signal+0x16ad/0x1810 kernel/signal.c:2690
 arch_do_signal_or_restart+0x96/0x830 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1c8c1779f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1c8d01f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: fffffffffffffffb RBX: 00007f1c8c305f80 RCX: 00007f1c8c1779f9
RDX: 0000000000000000 RSI: 000000000000f502 RDI: 0000000000000004
RBP: 00007f1c8c1e58ee R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f1c8c305f80 R15: 00007ffdbf6238f8
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

