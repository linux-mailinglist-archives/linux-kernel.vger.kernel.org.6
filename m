Return-Path: <linux-kernel+bounces-403996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA9E9C3DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FABE1F22BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C1418C00A;
	Mon, 11 Nov 2024 11:50:37 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5227A184542
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325837; cv=none; b=ZksHea0pjE0WhwjGlb82oBABgTj52Cz/lOXK9EeP1sn528F2iVHfKM5rSeCfLXJnBycmL23MlvYKfkJFxn4edH33M2D4SWERsJ/wv7rbidKCYDH53ffjulqRcFVraSda4BnCiYSkv5HuuNo+DBYKuABTRw+eblmEUzB2dWaY5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325837; c=relaxed/simple;
	bh=LpzcRj8XZzVYrmKd7NrNy27hwo/JIkIKdP/+5nGeoks=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YI+O8hbFoXVE0LyyWApXc5+WiuGFbWqTGLl2e2ludXp9c1i67uK+vdZjvKkIMsmubYHgqGhMtR7YLcp5t+tEJu295Q56eFPZ3lQ+AihPjpCGROpo5mKJ3zVOf1NTqE+fOZHebyj65Z/AEU/H+ZSps/cbpJliHVyFnQ5/n4jaEpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6c427e1b0so52912375ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:50:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731325833; x=1731930633;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tyNo0AyO0P+zz5Jkeap/BUIkkFwk5Q+D+7fu/KGExCY=;
        b=lqWzMstE31VaYRAWq1l50dXpeuveA2VPz/VIYnwOLLYQAsVajigVcsapZQgL6X6IaP
         ZB3p6g/QvUIEPENDtnMtC2mNio6udG9YCB3NIYzwEugmiMolsGG1duzcuFdyXGgzn3v6
         grqbnKlNmyjBDy9L4J387z52e4v2wbNz+d722EEw3J17ZwV+Jy8dPVNaIHaLFdVQUfAc
         faa+TcT2h8xOl6HrDeRLjSAD4Bq+xo9rdlYhyH545e+MeeSOrzwlr4Qy94lOJdEOuC60
         jjfNtRbEs3G5IQwc5c6+EC+aJ9z4NwNx5Slj9pELWu5CzZyH3kNjl4qAm+FVdJGOLgIj
         db5A==
X-Forwarded-Encrypted: i=1; AJvYcCW1Gb/L32qdMFfEgcUEt5rcRjkekZN/3Q6amjZjSetDtgzdK3iyO1A5J0gTI0z0cNTR2UVIL1dNJg8VI1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YynmQRjprYbfxngKuU/Xzk5bLUkn3tWnuTO9SAiN8RcWeVaj5Lv
	YIiqbnn8PmWAzyrvQoT3tvbnZl3j2uNVYkhFTfPNjgKPyW7TCMk2FdsmEw5UJTIfKfpXhEtdR3x
	6BnI7cfNX1MLQIDwz8s8PPQkmJHP7lRSQYIlbOZAyla/IfjilYfrsab8=
X-Google-Smtp-Source: AGHT+IGgwAaevhlgN+w1TuaYmvKBruIPGdiTz5br4mw5AOaR50IUDsnbZFN/e0Noddz46NNi+peMWFUbY6PiRQUqWPzhyrPqpLgY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c60f:0:b0:3a6:ac4e:4d with SMTP id e9e14a558f8ab-3a6f11bb220mr111945045ab.7.1731325833379;
 Mon, 11 Nov 2024 03:50:33 -0800 (PST)
Date: Mon, 11 Nov 2024 03:50:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6731ef89.050a0220.a83d0.0013.GAE@google.com>
Subject: [syzbot] [hfs?] possible deadlock in hfsplus_file_extend (2)
From: syzbot <syzbot+4cba2fd444e9a16ae758@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ff7afaeca1a1 Merge tag 'nfs-for-6.12-3' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d43f40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11254d3590b16717
dashboard link: https://syzkaller.appspot.com/bug?extid=4cba2fd444e9a16ae758
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135dae30580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15142d87980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-ff7afaec.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d8c6d968e5c0/vmlinux-ff7afaec.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dcee7f1927a8/bzImage-ff7afaec.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/55a0799266ca/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4cba2fd444e9a16ae758@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
hfsplus: inconsistency in B*Tree (128,1,255,1,0)
============================================
WARNING: possible recursive locking detected
6.12.0-rc6-syzkaller-00110-gff7afaeca1a1 #0 Not tainted
--------------------------------------------
syz-executor395/5309 is trying to acquire lock:
ffff8880422d0108 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_extend+0x21b/0x1b70 fs/hfsplus/extents.c:458

but task is already holding lock:
ffff8880422d0e88 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_extend+0x21b/0x1b70 fs/hfsplus/extents.c:458

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&HFSPLUS_I(inode)->extents_lock);
  lock(&HFSPLUS_I(inode)->extents_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

6 locks held by syz-executor395/5309:
 #0: ffff88804026a420 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff8880422d24b8 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
 #1: ffff8880422d24b8 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: vfs_setxattr+0x1e1/0x430 fs/xattr.c:320
 #2: ffff8880118740b0 (&tree->tree_lock){+.+.}-{3:3}, at: hfsplus_find_init+0x14a/0x1c0 fs/hfsplus/bfind.c:28
 #3: ffff88801ebc80b0 (&tree->tree_lock/2){+.+.}-{3:3}, at: hfsplus_find_init+0x14a/0x1c0 fs/hfsplus/bfind.c:28
 #4: ffff8880422d0e88 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_extend+0x21b/0x1b70 fs/hfsplus/extents.c:458
 #5: ffff8880118720b0 (&tree->tree_lock/1){+.+.}-{3:3}, at: hfsplus_find_init+0x14a/0x1c0 fs/hfsplus/bfind.c:28

stack backtrace:
CPU: 0 UID: 0 PID: 5309 Comm: syz-executor395 Not tainted 6.12.0-rc6-syzkaller-00110-gff7afaeca1a1 #0
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
 hfsplus_file_extend+0x21b/0x1b70 fs/hfsplus/extents.c:458
 hfsplus_bmap_reserve+0x105/0x4e0 fs/hfsplus/btree.c:358
 __hfsplus_ext_write_extent+0x2a4/0x5c0 fs/hfsplus/extents.c:104
 __hfsplus_ext_cache_extent+0x84/0xe10 fs/hfsplus/extents.c:186
 hfsplus_ext_read_extent fs/hfsplus/extents.c:218 [inline]
 hfsplus_file_extend+0x48c/0x1b70 fs/hfsplus/extents.c:462
 hfsplus_bmap_reserve+0x105/0x4e0 fs/hfsplus/btree.c:358
 hfsplus_create_attr+0x1c8/0x640 fs/hfsplus/attributes.c:221
 __hfsplus_setxattr+0x6fe/0x22d0 fs/hfsplus/xattr.c:354
 hfsplus_setxattr+0xb0/0xe0 fs/hfsplus/xattr.c:432
 hfsplus_trusted_setxattr+0x40/0x60 fs/hfsplus/xattr_trusted.c:30
 __vfs_setxattr+0x468/0x4a0 fs/xattr.c:200
 __vfs_setxattr_noperm+0x12e/0x660 fs/xattr.c:234
 vfs_setxattr+0x221/0x430 fs/xattr.c:321
 do_setxattr fs/xattr.c:629 [inline]
 path_setxattr+0x37e/0x4d0 fs/xattr.c:658
 __do_sys_lsetxattr fs/xattr.c:683 [inline]
 __se_sys_lsetxattr fs/xattr.c:679 [inline]
 __x64_sys_lsetxattr+0xb8/0xd0 fs/xattr.c:679
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f704e2aca99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd231fbc58 EFLAGS: 00000246 ORIG_RAX: 00000000000000bd
RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007f704e2aca99
RDX: 0000000000000000 RSI: 0000000020000200 RDI: 0000000020000040
RBP: 00007f704e3205f0 R08: 0000000000000000 R09: 00005555908174c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd231fbc80
R13: 00007ffd231fbea8 R14: 431bde82d7b634db R15: 00007f704e2f503b
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

