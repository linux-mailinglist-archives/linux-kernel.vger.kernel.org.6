Return-Path: <linux-kernel+bounces-287827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEA4952CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81BDF1C21DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C781B4C44;
	Thu, 15 Aug 2024 10:46:28 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C623E19D886
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723718787; cv=none; b=sWx6L/rDodVy0/aDE7nJ/+gU7K2cMQhkOm8xs3o+xMzeZFSPWem4lyA6C7FVEZ9r63KvLsar2D6UOcyJb8sjStxWqVfu1XfPiJn+MLbJm/U1j/D5t+ELyvc/+KbPC/XUt9TaJyuQWlYgK8mascJWwhohKPQWxjtAhXb76l91pfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723718787; c=relaxed/simple;
	bh=LZfV56JK4JfgU4WKzXc/CY7K5t7GY565mJ0LAcNSuCk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LFVD1TlYWsSxJ9a1zoicv2ynyWgjC8SW9rIB7JzZqoRqnktps1HO4rlEzsngNebmoZADIk9ndRass5yppckuIlxKj8UHZ2RsfXCEkhfd1cfn5B4ufuA9raZLCKkAzCEDhDlxR32Uz+bSg/9aFI/gxSo0blL7H0KgD0ddikkyjn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f8c780fe7so86939239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 03:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723718785; x=1724323585;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+whW43UyTyAUQ2ijnGYIyx1IykzmSG5L5gzDL0iIXc=;
        b=FjQYktV1R2eHm/8OGCO0Wc0C4i0cwaKWqdWOnF+w8pYIxjEDqNS7zRkGvn7YPlzMD9
         3kFwBdFZF1aK3qxxGfkmLcMqdBdHqikngfeZd78xauM6yubEnbb5Yfqr1fDsXjZcxfGv
         tH8Gn0WxSpDyomM0Nivt8rsDGvp8R2DsaWpl9o8NF8a6DPH+D5rCtEkUwKj3qFii8JVU
         v1Kba2/yI0gk085KSb3dCJc3M0UrpeU7oIoYkVSQCe5uwjI8TNsLShW7zQFcBTj4h9aq
         YMw9YSpUuzPnq2IxjoqwGQk/MThzfk6A+UoG/fKCxS5RQRRzUXrfm/0+1L1mHlGdFuDB
         CW0w==
X-Forwarded-Encrypted: i=1; AJvYcCVNmEbh8GXubT+OO6fnsUmyrQ3IoShIBqSYbGlpm/J0+BLLhyJup+HnV+aWrhxnixa1DpjRQJUn6M7GzEJqTq8DRSXmCmkJvYyFhkwC
X-Gm-Message-State: AOJu0YyWFR0XID9yAkXJ8zpPgiYZqb7zr3B/Z88n86uIZYZWg3GrYMad
	VOkScrZhk5DXxz4IamwWfRklu9LJRZXsxBZz6mm3kimeFWls4NEXRs3A3L4Bi7kAHE99sKVxsPV
	l+my2zuIx8J83LJyQtiAIG5KSq1HdPVnxYkHSOcCmb/y8KuM6L1UvV/M=
X-Google-Smtp-Source: AGHT+IFRcKjVggU9E3SDGuA5G0CrYpkpiEYUnb4cyAuO6kqgguSJpsQLZ2mNOJL1BbXBBKJE93UUV7eLNTFzr6kLu8L/KIx2s9Kh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2ccf:b0:81f:8d10:6f00 with SMTP id
 ca18e2360f4ac-824dadbec3emr26322239f.2.1723718784956; Thu, 15 Aug 2024
 03:46:24 -0700 (PDT)
Date: Thu, 15 Aug 2024 03:46:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000decba0061fb68d64@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in attr_data_get_block (2)
From: syzbot <syzbot+262a71e9d2faf8747085@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9d5906799f7d Merge tag 'selinux-pr-20240814' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1673c7d3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92c0312151c4e32e
dashboard link: https://syzkaller.appspot.com/bug?extid=262a71e9d2faf8747085
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109e7cfd980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129e6c05980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/446819619a5c/disk-9d590679.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14a59529d386/vmlinux-9d590679.xz
kernel image: https://storage.googleapis.com/syzbot-assets/04e89692a4c8/bzImage-9d590679.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c9e039126cae/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+262a71e9d2faf8747085@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc3-syzkaller-00036-g9d5906799f7d #0 Not tainted
------------------------------------------------------
syz-executor969/5214 is trying to acquire lock:
ffff8880788e6f28 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1110 [inline]
ffff8880788e6f28 (&ni->ni_lock/4){+.+.}-{3:3}, at: attr_data_get_block+0x463/0x2ff0 fs/ntfs3/attrib.c:917

but task is already holding lock:
ffff888015579e18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
ffff888015579e18 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x17c/0x3d0 mm/util.c:586

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __might_fault+0xc6/0x120 mm/memory.c:6388
       _inline_copy_to_user include/linux/uaccess.h:176 [inline]
       _copy_to_user+0x2a/0xb0 lib/usercopy.c:26
       copy_to_user include/linux/uaccess.h:209 [inline]
       fiemap_fill_next_extent+0x235/0x410 fs/ioctl.c:145
       ni_fiemap+0x4f5/0x1910 fs/ntfs3/frecord.c:1993
       ntfs_fiemap+0x132/0x180 fs/ntfs3/file.c:1279
       ioctl_fiemap fs/ioctl.c:220 [inline]
       do_vfs_ioctl+0x1c07/0x2e50 fs/ioctl.c:841
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
       attr_data_get_block+0x463/0x2ff0 fs/ntfs3/attrib.c:917
       ntfs_file_mmap+0x4f5/0x850 fs/ntfs3/file.c:360
       call_mmap include/linux/fs.h:2129 [inline]
       mmap_region+0xe8f/0x2090 mm/mmap.c:2957
       do_mmap+0x8f9/0x1010 mm/mmap.c:1468
       vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
       ksys_mmap_pgoff+0x4f1/0x720 mm/mmap.c:1514
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mm->mmap_lock);
                               lock(&ni->ni_lock/4);
                               lock(&mm->mmap_lock);
  lock(&ni->ni_lock/4);

 *** DEADLOCK ***

1 lock held by syz-executor969/5214:
 #0: ffff888015579e18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
 #0: ffff888015579e18 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x17c/0x3d0 mm/util.c:586

stack backtrace:
CPU: 1 UID: 0 PID: 5214 Comm: syz-executor969 Not tainted 6.11.0-rc3-syzkaller-00036-g9d5906799f7d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
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
 attr_data_get_block+0x463/0x2ff0 fs/ntfs3/attrib.c:917
 ntfs_file_mmap+0x4f5/0x850 fs/ntfs3/file.c:360
 call_mmap include/linux/fs.h:2129 [inline]
 mmap_region+0xe8f/0x2090 mm/mmap.c:2957
 do_mmap+0x8f9/0x1010 mm/mmap.c:1468
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
 ksys_mmap_pgoff+0x4f1/0x720 mm/mmap.c:1514
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f387a5eebd9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc3dce7448 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f387a5eebd9
RDX: 00000000027fffff RSI: 0000000000600000 RDI: 0000000020000000
RBP: 00007f387a6815f0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000004002011 R11: 0000000000000246 R12: 00007ffc3dce7480
R13: 00007ffc3dce76a8 R14: 431bde82d7b634db R15: 00007f387a63703b
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

