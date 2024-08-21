Return-Path: <linux-kernel+bounces-294972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8509594F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C8B1F21F06
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 06:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D4F1D0DCE;
	Wed, 21 Aug 2024 06:45:24 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255E01CCB50
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222723; cv=none; b=JFS1TXippbFi3A4NkhSzv2t5ZBTPes+QDkn3+RNidr/WD39eCuQLJ3zJC2ElS1MRAhOCdWhlI3Ra61b/E5s2+qDKrCNihsWGs88A+hXHu/6RRBuW/hB0jAc6DoWf4ChFYmr843zP/G/80eyq3A9bF/Xm/BfDtvEO3blGoCPGzCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222723; c=relaxed/simple;
	bh=JXRydntFQL/T4hmVrV+zMmv3LnCBwUgS1RfCPSVlFJs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y/XIcBVC7YinJGla1CtRlSAexn6bFEcuOnrRHX6eL1cXo3lbkBFdzOO+r5uRZ9KbysYc+snndU9yC0YkT5WdOPZuT3P4bOvS6fTdCkjT99KK8FHb/gKRTor03mBmiOTo1mOrTrB5f5pNfrnYryF36dSYiB4RDFPDQt5kgsqkYCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f901cd3b5so652288739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724222721; x=1724827521;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3WT0nvtyOQj1JRDRUJCTKN/ZgUU0f7ZF7NeLIfQVeco=;
        b=MFSPzfHScjGH37/BYapBfzlJsgMXufQviIlWQ/Pqid6arjqIwK64pWejbJP/wWkrIY
         rKdrXEoc/zU7gt3BeRczECQRpzuL+jE6fcpODJpziAXgPPkLg9qoezzKv0tyLLVoQCfY
         DZkRtNsEuL02+8u6wRa4vOsHLe7rpYq91brsuhH9DJxr7ngVWzIAUD1w2Kir0nPTRwQI
         4FrBUJAhaoqlqLZRAQu74zOBjZh5VQW/R5xp4yVVBtxNGvrSYQbXyVmw8XVUFZkthL+N
         sH2YwxhWLnIBNHmZXczicw6fHuuo+GtrWxOlAslSC9czDtQiJdlXsPkXjv9z0FgSJ5ji
         oxrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK68avIXFVczwkZK6nqBPEGnmbMn+7YLdKOQqzfWLWwsHbeSp5jBtQdQg92+I3YhoXDlxdXEHyUqgCHhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmf6YOk7O/Xp8k23EWmRJFr7SqJaYKMfBqa8BzMgKQjp+FaW0u
	8x1u9X04fwLf4cxu4BCISjiSf9cB5SAauISDbvB+gAn3vv2boa9ODc2v1uVvx7tC43xd2o46PXl
	It3YEnWv8qgO7qTDAxcXZFqNxSm50l7cIgNnOCjAdCheaHMKjcl6O2i4=
X-Google-Smtp-Source: AGHT+IFF5pkuqCM9X+DxutP+YUIo6oh62NuZI2v3xXZRs7dnC7+P9lxpZ5aHR0a/2PEs9PpZDO8dZ8jVgpW9yBCK4w6040aRcyd7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:62a7:b0:4c0:8165:c391 with SMTP id
 8926c6da1cb9f-4ce63029bddmr43114173.4.1724222721289; Tue, 20 Aug 2024
 23:45:21 -0700 (PDT)
Date: Tue, 20 Aug 2024 23:45:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1011406202be206@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in ntfs_unlink
From: syzbot <syzbot+12f3574df80036f0f9ca@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    85652baa895b Merge tag 'block-6.11-20240824' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104377c9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92c0312151c4e32e
dashboard link: https://syzkaller.appspot.com/bug?extid=12f3574df80036f0f9ca
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f48bb8a1e215/disk-85652baa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a4eced38e143/vmlinux-85652baa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3d21ddc8de52/bzImage-85652baa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+12f3574df80036f0f9ca@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc3-syzkaller-00271-g85652baa895b #0 Not tainted
------------------------------------------------------
syz-executor/5964 is trying to acquire lock:
ffff88805d371708 (&ni->ni_lock#2/5){+.+.}-{3:3}, at: ni_lock_dir fs/ntfs3/ntfs_fs.h:1115 [inline]
ffff88805d371708 (&ni->ni_lock#2/5){+.+.}-{3:3}, at: ntfs_unlink+0xb1/0xf0 fs/ntfs3/namei.c:177

but task is already holding lock:
ffff88805d371248 (&sb->s_type->i_mutex_key#29){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:799 [inline]
ffff88805d371248 (&sb->s_type->i_mutex_key#29){+.+.}-{3:3}, at: vfs_unlink+0xe4/0x650 fs/namei.c:4411

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&sb->s_type->i_mutex_key#29){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       down_write+0x99/0x220 kernel/locking/rwsem.c:1579
       inode_lock include/linux/fs.h:799 [inline]
       ntfs_file_mmap+0x5bf/0x850 fs/ntfs3/file.c:368
       call_mmap include/linux/fs.h:2129 [inline]
       mmap_region+0xe8f/0x2090 mm/mmap.c:2957
       do_mmap+0x8f9/0x1010 mm/mmap.c:1468
       vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
       ksys_mmap_pgoff+0x4f1/0x720 mm/mmap.c:1514
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&mm->mmap_lock){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __might_fault+0xc6/0x120 mm/memory.c:6388
       _inline_copy_to_user include/linux/uaccess.h:176 [inline]
       _copy_to_user+0x2a/0xb0 lib/usercopy.c:26
       copy_to_user include/linux/uaccess.h:209 [inline]
       ni_fiemap+0x5b4/0x1910 fs/ntfs3/frecord.c:2140
       ntfs_fiemap+0x132/0x180 fs/ntfs3/file.c:1279
       ioctl_fiemap fs/ioctl.c:220 [inline]
       do_vfs_ioctl+0x1c07/0x2e50 fs/ioctl.c:841
       __do_sys_ioctl fs/ioctl.c:905 [inline]
       __se_sys_ioctl+0x81/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&ni->ni_lock/4){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       ni_lock fs/ntfs3/ntfs_fs.h:1110 [inline]
       ntfs_save_wsl_perm+0x8f/0x500 fs/ntfs3/xattr.c:959
       ntfs_create_inode+0x2314/0x3880 fs/ntfs3/inode.c:1667
       ntfs_create+0x3d/0x50 fs/ntfs3/namei.c:110
       lookup_open fs/namei.c:3578 [inline]
       open_last_lookups fs/namei.c:3647 [inline]
       path_openat+0x1a9a/0x3470 fs/namei.c:3883
       do_filp_open+0x235/0x490 fs/namei.c:3913
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
       do_sys_open fs/open.c:1431 [inline]
       __do_sys_openat fs/open.c:1447 [inline]
       __se_sys_openat fs/open.c:1442 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ni->ni_lock#2/5){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       ni_lock_dir fs/ntfs3/ntfs_fs.h:1115 [inline]
       ntfs_unlink+0xb1/0xf0 fs/ntfs3/namei.c:177
       vfs_unlink+0x365/0x650 fs/namei.c:4422
       do_unlinkat+0x4ae/0x830 fs/namei.c:4486
       __do_sys_unlink fs/namei.c:4534 [inline]
       __se_sys_unlink fs/namei.c:4532 [inline]
       __x64_sys_unlink+0x47/0x50 fs/namei.c:4532
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &ni->ni_lock#2/5 --> &mm->mmap_lock --> &sb->s_type->i_mutex_key#29

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#29);
                               lock(&mm->mmap_lock);
                               lock(&sb->s_type->i_mutex_key#29);
  lock(&ni->ni_lock#2/5);

 *** DEADLOCK ***

3 locks held by syz-executor/5964:
 #0: ffff88807f642420
 (sb_writers
#12){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff88805d3719a0 (&type->i_mutex_dir_key#8/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:834 [inline]
 #1: ffff88805d3719a0 (&type->i_mutex_dir_key#8/1){+.+.}-{3:3}, at: do_unlinkat+0x26a/0x830 fs/namei.c:4473
 #2: ffff88805d371248 (&sb->s_type->i_mutex_key#29){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:799 [inline]
 #2: ffff88805d371248 (&sb->s_type->i_mutex_key#29){+.+.}-{3:3}, at: vfs_unlink+0xe4/0x650 fs/namei.c:4411

stack backtrace:
CPU: 0 UID: 0 PID: 5964 Comm: syz-executor Not tainted 6.11.0-rc3-syzkaller-00271-g85652baa895b #0
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
 ni_lock_dir fs/ntfs3/ntfs_fs.h:1115 [inline]
 ntfs_unlink+0xb1/0xf0 fs/ntfs3/namei.c:177
 vfs_unlink+0x365/0x650 fs/namei.c:4422
 do_unlinkat+0x4ae/0x830 fs/namei.c:4486
 __do_sys_unlink fs/namei.c:4534 [inline]
 __se_sys_unlink fs/namei.c:4532 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:4532
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f30a4779427
Code: 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc62b6cfd8 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f30a4779427
RDX: 00007ffc62b6d000 RSI: 00007ffc62b6d090 RDI: 00007ffc62b6d090
RBP: 00007ffc62b6d090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000206 R12: 00007ffc62b6e180
R13: 00007f30a47e77b4 R14: 000000000002694c R15: 00007ffc62b6f240
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

