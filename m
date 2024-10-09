Return-Path: <linux-kernel+bounces-357754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1F8997566
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E210284AB0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEC51E1A07;
	Wed,  9 Oct 2024 19:06:23 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E491A3031
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728500783; cv=none; b=CXbNXB1m2toCtUG6CkdNWZUIkgweyQGWYfYCjAEIKmFbO+gaDNpUYqPCC8tjtflh7zvoRiTQNrImW2Hngie4zqDz5urazUQVpptOuMGV1PG2cFjzWUEJskJAT16QOzgzD+Fs98pkcEwI+SGxeVpcE44CoTGEC0TOpSY1mmh3Mzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728500783; c=relaxed/simple;
	bh=S0yngzlf7/hnbdlcYPff/UkGi4KuNGvvz2eLoQOs/T4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LNGWu5F9XvF3pV7t1bTmSNs4A9jypZsHJ/yiSjNOV7y3Cuohw83mHQ/OnLm7j074npWyeoc1LN/TWyXbT9ARSyE7vKHZFMa/JsI44YxS98pcFXIK0UFB+Tbxxg6cbRQXDWkEdxgei7ky77pIho2gPVD66LKgyTHoTcFZNF2qxPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3a031168eso2055495ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 12:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728500781; x=1729105581;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HqMRnlNkwheCLMbZJR5dLRpMf+ZgytYRKTjLiVGMaTo=;
        b=KcYiA2PEtA99XhDQCpDSdOlpaRUnXSRz2sg0AFIJ10ORrTCDnwAWtPklj/Mzr2y1Fa
         fFzLKq6oIbT4ctTOt2Q5FwuIiRS3LKe4g/SVp+2IIPFGZYr03GvSmscLly7kihSTAZrP
         EXWBHitkyd3vSOJZk5+AoR2JQvP3Tx9zLzTJQx3eRUsYcmcn76tEAd9vJRN4Oui5iSiV
         w6c80gzcT+VJsUAUPF5BFyvqMTsfGmn1Aqs1yGssMZd5odfkcdDIzFx1jA9IWmTAnNQg
         cb1B4lJ9PSMGtclSYUwuQ4m6eZjvcR+Mia5dvXyYzBL4qUfJ6tj2Q92pidlqQ73FLm0g
         uyrA==
X-Forwarded-Encrypted: i=1; AJvYcCWveJM7ylnE0KeEncJcpaS7A9yDANmWeuzpleu/o0P2LrX3B87QwsEQD65bgvOmD2hNTldy6Z5ZXvqdsiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpmsrunHMAQqVex182Dib8QinKtrCGMBz8/I7Fw+Hpmx+ipBro
	PtVyFEDEVeKhiF+dMCSJeV+LSoO8fmNPuSeW6gGkaqACCi2pkFwt3eOBNJUv97JxKlTlSqHuKdH
	ABIbarcpb4KBbnbHyD3KGNoJtIFBHtt6wXW9hhjjf4VLOcv2/zLYJo0k=
X-Google-Smtp-Source: AGHT+IFXPsbLhA79mSoopHbrLby0iiKWafgJYmUW2iHWUBvz3oEEU7LATnHCjkThHhFr3aTeH7Aq0KO4AcBR/RefsuljnA95+QPr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:39f:5e18:239d with SMTP id
 e9e14a558f8ab-3a397cee009mr36409105ab.15.1728500780772; Wed, 09 Oct 2024
 12:06:20 -0700 (PDT)
Date: Wed, 09 Oct 2024 12:06:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6706d42c.050a0220.1139e6.000d.GAE@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in ntfs_set_size (3)
From: syzbot <syzbot+bc7ded2e21137a228c72@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f602276d390 Merge tag 'bcachefs-2024-10-05' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10520327980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9775e9a1af839423
dashboard link: https://syzkaller.appspot.com/bug?extid=bc7ded2e21137a228c72
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c85b02a6dfd7/disk-8f602276.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e428dbf555c6/vmlinux-8f602276.xz
kernel image: https://storage.googleapis.com/syzbot-assets/24dbed728796/bzImage-8f602276.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bc7ded2e21137a228c72@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc1-syzkaller-00349-g8f602276d390 #0 Not tainted
------------------------------------------------------
syz.0.245/7337 is trying to acquire lock:
ffff88805e861e60 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1109 [inline]
ffff88805e861e60 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_set_size+0x12e/0x200 fs/ntfs3/inode.c:846

but task is already holding lock:
ffff88805e8620f8 (&sb->s_type->i_mutex_key#23){+.+.}-{3:3}, at: inode_trylock include/linux/fs.h:835 [inline]
ffff88805e8620f8 (&sb->s_type->i_mutex_key#23){+.+.}-{3:3}, at: ntfs_file_write_iter+0x247/0x740 fs/ntfs3/file.c:1165

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sb->s_type->i_mutex_key#23){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       inode_lock include/linux/fs.h:815 [inline]
       ntfs_file_mmap+0x5bc/0x850 fs/ntfs3/file.c:367
       call_mmap include/linux/fs.h:2172 [inline]
       mmap_region+0x1add/0x2990 mm/mmap.c:1440
       do_mmap+0x8f0/0x1000 mm/mmap.c:496
       vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
       ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:542
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __might_fault+0xc6/0x120 mm/memory.c:6700
       _inline_copy_to_user include/linux/uaccess.h:183 [inline]
       _copy_to_user+0x2a/0xb0 lib/usercopy.c:26
       copy_to_user include/linux/uaccess.h:216 [inline]
       fiemap_fill_next_extent+0x235/0x410 fs/ioctl.c:145
       ni_fiemap+0x4f5/0x1910 fs/ntfs3/frecord.c:1993
       ntfs_fiemap+0x132/0x180 fs/ntfs3/file.c:1278
       ioctl_fiemap fs/ioctl.c:220 [inline]
       do_vfs_ioctl+0x1bf8/0x2e40 fs/ioctl.c:841
       __do_sys_ioctl fs/ioctl.c:905 [inline]
       __se_sys_ioctl+0x81/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ni->ni_lock/4){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       ni_lock fs/ntfs3/ntfs_fs.h:1109 [inline]
       ntfs_set_size+0x12e/0x200 fs/ntfs3/inode.c:846
       ntfs_extend+0x163/0x480 fs/ntfs3/file.c:397
       ntfs_file_write_iter+0x3ce/0x740 fs/ntfs3/file.c:1187
       new_sync_write fs/read_write.c:590 [inline]
       vfs_write+0xa6d/0xc90 fs/read_write.c:683
       ksys_write+0x183/0x2b0 fs/read_write.c:736
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &ni->ni_lock/4 --> &mm->mmap_lock --> &sb->s_type->i_mutex_key#23

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#23);
                               lock(&mm->mmap_lock);
                               lock(&sb->s_type->i_mutex_key#23);
  lock(&ni->ni_lock/4);

 *** DEADLOCK ***

3 locks held by syz.0.245/7337:
 #0: ffff8880260022b8 (&f->f_pos_lock){+.+.}-{3:3}, at: fdget_pos+0x24e/0x320 fs/file.c:1160
 #1: ffff8880126be420 (sb_writers#15){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2931 [inline]
 #1: ffff8880126be420 (sb_writers#15){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
 #2: ffff88805e8620f8 (&sb->s_type->i_mutex_key#23){+.+.}-{3:3}, at: inode_trylock include/linux/fs.h:835 [inline]
 #2: ffff88805e8620f8 (&sb->s_type->i_mutex_key#23){+.+.}-{3:3}, at: ntfs_file_write_iter+0x247/0x740 fs/ntfs3/file.c:1165

stack backtrace:
CPU: 1 UID: 0 PID: 7337 Comm: syz.0.245 Not tainted 6.12.0-rc1-syzkaller-00349-g8f602276d390 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 ni_lock fs/ntfs3/ntfs_fs.h:1109 [inline]
 ntfs_set_size+0x12e/0x200 fs/ntfs3/inode.c:846
 ntfs_extend+0x163/0x480 fs/ntfs3/file.c:397
 ntfs_file_write_iter+0x3ce/0x740 fs/ntfs3/file.c:1187
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xa6d/0xc90 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdd5297dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdd5381b038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fdd52b35f80 RCX: 00007fdd5297dff9
RDX: 0000000000001006 RSI: 0000000020006640 RDI: 0000000000000006
RBP: 00007fdd529f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fdd52b35f80 R15: 00007ffdd949f3f8
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

