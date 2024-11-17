Return-Path: <linux-kernel+bounces-412021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D169D0275
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 09:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6712BB22C75
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 08:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4787A6FB0;
	Sun, 17 Nov 2024 08:21:25 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C01BA92D
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731831684; cv=none; b=hZfj/5pknzwz19UHh8tKa/Hj4slADrGRrjenFebNwafL55rBya5mkf8FGBwHF8oq0c1IfjeDlUvowZ5uyvCI3Gl6mjsYrBB/pq3sWQNXHOcoc8H/GX34B8vO2QWO4Kj1lzn80M4qFACsaIW0oWmI6z/738S/H2jcFtkHVnmtHGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731831684; c=relaxed/simple;
	bh=LTnFmojas5soe/f0gngCsBJEBRRy63SniGL6OPiM/RU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rBp5TpkVtpSHp+ucOZGoUbvI39Sgkr9oAJLiBtOMunRWx3t77OuTf95ltCDuu6k+LqhQ3IB+FV9f6tSN712oXMR7XhKhHoPZ/0m7KBagVYRd5V8zhtIgwhfWV7CKuqV/tBQhQHbCKQaJ0nyNt8KjGT2LqvNOJ53Qn357W2FHyYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83aba93c01bso352546639f.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 00:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731831682; x=1732436482;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bnMn9SjhiOnn7Lm8M3CQKXdO/LTWlJVnoA3MmFMg2o0=;
        b=ijxX7nsputCiky+cTi9qO81PxDLBQYLl6oVCUy7MPeVkrOKJ7X0Y7UWtsrLDv0w07k
         sZgVUB6fYza+5nGfzxVyJI+IoiFoPbnXq4NG0kSMDFJKhN59SxKmk/BVZ5qbkqVNWW4x
         tq7PIc/ccWMr4CCfW7VrvaQtMTYFtW76sVBhfD4kuCSqKLy9ErAXAnbuPi5wIEtqxRWf
         E+Qe5QCaZ5DmOsz4094V5eWbEQ+QruQNqfpKo3Ne4Cybsfhn+6w7nBN5meq76rZm+PtK
         BEkCmJUbgP9U3dWKg7fJDt/U9XP+JgXgjg/wo5/nggK9Zk/rR1W/AayN3yXTRrT5cSob
         dg9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmQUKjh8xJe3rKCWElwmijIVG8WMbypuot4V4hToTDs3nWXjlaydF4UOGilhU1Qtt/6N3OqL5iz5RE7d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwefXeZnLAJXKUMQD+SNG1T0+gFAaoPEJ6r0tQLQuq0WOLGpfq2
	qX06pt9IHLO/CCj/Sot63Gh0K+AdxRo8A+e1iXN2pKc+NpUqWipxupYEVeEPUC0/dX3SDx1j+M0
	YiiIhS4I6U6f7MomqL6ipXTMtXY5pe8OK5Ru/qfn4FOjT9INk7sMKIKY=
X-Google-Smtp-Source: AGHT+IGUYtM9kki6ftQNQJmkTmDk0J1JnyVW9dmoyIURKhjsG+tLIUAdqbgcOMJlKa6W3xgq/D3E/z5+fM7QZJnLuBfNqhyePiBI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cc:b0:3a7:15aa:4169 with SMTP id
 e9e14a558f8ab-3a74808eae6mr97719005ab.23.1731831682426; Sun, 17 Nov 2024
 00:21:22 -0800 (PST)
Date: Sun, 17 Nov 2024 00:21:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6739a782.050a0220.e1c64.0011.GAE@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in mi_read (2)
From: syzbot <syzbot+17f812893d5906837f33@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3022e9d00ebe Merge tag 'sched_ext-for-6.12-rc7-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100f41a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=17f812893d5906837f33
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d88df7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1762cce8580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-3022e9d0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4c8c676ae511/vmlinux-3022e9d0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9434a43ad72f/bzImage-3022e9d0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d977dd18110a/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+17f812893d5906837f33@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
============================================
WARNING: possible recursive locking detected
6.12.0-rc7-syzkaller-00012-g3022e9d00ebe #0 Not tainted
--------------------------------------------
syz-executor280/5308 is trying to acquire lock:
ffff88805f336a28 (&ni->ni_lock#3/5){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1109 [inline]
ffff88805f336a28 (&ni->ni_lock#3/5){+.+.}-{3:3}, at: mi_read+0x2e1/0x5a0 fs/ntfs3/record.c:148

but task is already holding lock:
ffff88804753e7d0 (&ni->ni_lock#3/5){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1109 [inline]
ffff88804753e7d0 (&ni->ni_lock#3/5){+.+.}-{3:3}, at: ntfs_link+0xf4/0x270 fs/ntfs3/namei.c:141

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&ni->ni_lock#3/5);
  lock(&ni->ni_lock#3/5);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

6 locks held by syz-executor280/5308:
 #0: ffff888032b28420 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff88804753e310 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:850 [inline]
 #1: ffff88804753e310 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: filename_create+0x260/0x540 fs/namei.c:4026
 #2: ffff88804753ea68 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
 #2: ffff88804753ea68 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: vfs_link+0x3b2/0x6e0 fs/namei.c:4730
 #3: ffff88804753e078 (&ni->ni_lock/6){+.+.}-{3:3}, at: ni_lock_dir fs/ntfs3/ntfs_fs.h:1114 [inline]
 #3: ffff88804753e078 (&ni->ni_lock/6){+.+.}-{3:3}, at: ntfs_link+0xd9/0x270 fs/ntfs3/namei.c:139
 #4: ffff88804753e7d0 (&ni->ni_lock#3/5){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1109 [inline]
 #4: ffff88804753e7d0 (&ni->ni_lock#3/5){+.+.}-{3:3}, at: ntfs_link+0xf4/0x270 fs/ntfs3/namei.c:141
 #5: ffff888032b2e128 (&wnd->rw_lock/1){+.+.}-{3:3}, at: ntfs_look_free_mft+0x1e5/0x10c0 fs/ntfs3/fsntfs.c:571

stack backtrace:
CPU: 0 UID: 0 PID: 5308 Comm: syz-executor280 Not tainted 6.12.0-rc7-syzkaller-00012-g3022e9d00ebe #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3037
 check_deadlock kernel/locking/lockdep.c:3089 [inline]
 validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3891
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 ni_lock fs/ntfs3/ntfs_fs.h:1109 [inline]
 mi_read+0x2e1/0x5a0 fs/ntfs3/record.c:148
 mi_format_new+0x1ab/0x5d0 fs/ntfs3/record.c:419
 ni_add_subrecord+0xe2/0x430 fs/ntfs3/frecord.c:374
 ntfs_look_free_mft+0x878/0x10c0 fs/ntfs3/fsntfs.c:715
 ni_create_attr_list+0x9bd/0x1480 fs/ntfs3/frecord.c:878
 ni_ins_attr_ext+0x369/0xbe0 fs/ntfs3/frecord.c:976
 ni_insert_attr fs/ntfs3/frecord.c:1143 [inline]
 ni_insert_resident fs/ntfs3/frecord.c:1527 [inline]
 ni_add_name+0x809/0xe90 fs/ntfs3/frecord.c:3112
 ntfs_link_inode+0x130/0x170 fs/ntfs3/inode.c:1735
 ntfs_link+0x116/0x270 fs/ntfs3/namei.c:146
 vfs_link+0x4f0/0x6e0 fs/namei.c:4739
 do_linkat+0x555/0x6f0 fs/namei.c:4809
 __do_sys_link fs/namei.c:4843 [inline]
 __se_sys_link fs/namei.c:4841 [inline]
 __x64_sys_link+0x82/0x90 fs/namei.c:4841
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f927e890779
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff63b3c098 EFLAGS: 00000246 ORIG_RAX: 0000000000000056
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f927e890779
RDX: 0000000000000000 RSI: 0000000020000bc0 RDI: 0000000020001240
RBP: 00007f927e923610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff63b3c268 R14: 0000000000000001 R15: 0000000000000001
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

