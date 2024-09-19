Return-Path: <linux-kernel+bounces-333341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 294B497C726
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA3C1F2453E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006D519994B;
	Thu, 19 Sep 2024 09:32:35 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D2D19925A
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726738354; cv=none; b=CHZuA3iNPk4xFzveEZnuq+PRxnEaXGNkplMMDKk7fVk5xjgy4IiDfIh9f87t9kwEtkUiL8R7wK5wpeOpCO9h0lgqqH79rj/tghcR0F8746uvKNX3h0aUw772fYtYS6sMbfRf1pxE3CKXdmIkdFFMxSPYDYbuQHqa7FZLWGZ6BmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726738354; c=relaxed/simple;
	bh=kNR5zcZJ7VAsittlht678O2zXJum1rcG9XJRdXLFG70=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZmKFRbN76xloSZd57wRydD4Pa+JkRaG+jPMhIB100h6KFhhYPMUYhgYNWYBWIiWrKZXgn5fCbbLe/bCbq9rFPjQqfgD84hL3NkHjH3VDouaNUozf1RWmNTaPrcQCwKN9kU1jMJEB8HDXd/oxzleXnT9J8tdLj0LgfP42sWN44vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0a3f10064so7322635ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 02:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726738350; x=1727343150;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1SnQjl4GXF3+K986YiWwl9LstGzvH12H+/t0TktR+1o=;
        b=mMcIFAu3aEnJa4JZxkoHhxn0Yf+OQcq6Vr42E/Wy5DLea5n/sxmp4umkTiovEDIHtK
         2N6iUsFFCoc7/v35IYvYe6hP5oc1sUcDKs5Fzv05dj19fh0gW5KDzmxolO7hNIuoVNUu
         gKAbca2KDRJTatnp139fq6YCcEl85PBpelJfEN6mJo2Sqqmw9IrAr6e+Z7hdZ+6uMBJb
         /W5bzBzmp0hS4n7geppvmSv4Q4CiCh7+1eAt83/37G30N9G5N7ImhC1VuDFKANZfrXxd
         5zQcwJjMQYuR8kwRNU0/TkBeSS3jvPSLgygzSU56NECWg1zZNTcGQAv3piBhcM8HjOrH
         r3dg==
X-Forwarded-Encrypted: i=1; AJvYcCX+XqWadvd1Fx6tLiqGJFdoRX0xOnmYtLhsWCryCoQnRlS9a3YTA3jHnLSNoyddVVqVh3n/tK2N9NRWpaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKDcp3QPAkWi3R11kU76GmMd/RIMzRNu7mizunhXQNLpBfvFMD
	ckmgXb9qaDM/6PpeDd0Onnle/HIvj0tOLyr+Y33PKd4jXXV44fZ7kvDNYOoJx4GiSyQby4sANA0
	hudbjhZRy1AE3q1dbB5s1+QMwML5gfmeUSRIdUKcGvUYYnjYe4T7xKX4=
X-Google-Smtp-Source: AGHT+IGKiiRrVoIB5e3NoKbWyw/dEC7eY/92Mgjfy8vQgUCOoTZVl1ELnxd6VUPzI59KzUrD9kFEjcKB9eL1by3QYY1iSl7Tp9Nu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ee:b0:3a0:ac5a:2015 with SMTP id
 e9e14a558f8ab-3a0ac5a2062mr89354135ab.6.1726738349977; Thu, 19 Sep 2024
 02:32:29 -0700 (PDT)
Date: Thu, 19 Sep 2024 02:32:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ebefad.050a0220.92ef1.0019.GAE@google.com>
Subject: [syzbot] [ntfs3?] INFO: trying to register non-static key in
 ntfs3_setattr (2)
From: syzbot <syzbot+2e842ec1beb075a25865@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0babf683783d Merge tag 'pinctrl-v6.11-4' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1417bc77980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c9e296880039df9
dashboard link: https://syzkaller.appspot.com/bug?extid=2e842ec1beb075a25865
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b9b0a9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155e9900580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/aab0f0b09dd6/disk-0babf683.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b97896b7812c/vmlinux-0babf683.xz
kernel image: https://storage.googleapis.com/syzbot-assets/340ce283efd3/bzImage-0babf683.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/282ca00a7cb2/mount_0.gz

The issue was bisected to:

commit 24c5100aceedcd47af89aaa404d4c96cd2837523
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Tue Jun 4 07:41:39 2024 +0000

    fs/ntfs3: Fix getting file type

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b748a9980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11b748a9980000
console output: https://syzkaller.appspot.com/x/log.txt?x=16b748a9980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e842ec1beb075a25865@syzkaller.appspotmail.com
Fixes: 24c5100aceed ("fs/ntfs3: Fix getting file type")

ntfs3: loop0: ino=0, ntfs_iget5
ntfs3: loop0: Mark volume as dirty due to NTFS errors
ntfs3: loop0: failed to convert "046c" to maccroatian
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 5224 Comm: syz-executor352 Not tainted 6.11.0-rc7-syzkaller-00149-g0babf683783d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 assign_lock_key+0x238/0x270 kernel/locking/lockdep.c:975
 register_lock_class+0x1cf/0x980 kernel/locking/lockdep.c:1288
 __lock_acquire+0xf0/0x2040 kernel/locking/lockdep.c:5019
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 down_write+0x99/0x220 kernel/locking/rwsem.c:1579
 ntfs_truncate fs/ntfs3/file.c:458 [inline]
 ntfs3_setattr+0x6d3/0xb80 fs/ntfs3/file.c:775
 notify_change+0xbca/0xe90 fs/attr.c:503
 do_truncate+0x220/0x310 fs/open.c:65
 vfs_truncate+0x2e1/0x3b0 fs/open.c:111
 do_sys_truncate+0xdb/0x190 fs/open.c:134
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f43d7bf8779
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffda6ccac8 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00007fffda6ccc98 RCX: 00007f43d7bf8779
RDX: 00007f43d7bf8779 RSI: 0000000000000000 RDI: 0000000020000000
RBP: 00007f43d7c8b610 R08: 00007fffda6ccc98 R09: 00007fffda6ccc98
R10: 00007fffda6ccc98 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffda6ccc88 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON(sem->magic != sem): count = 0x1, magic = 0x0, owner = 0xffff88802f4f9e00, curr 0xffff88802f4f9e00, list not empty
WARNING: CPU: 0 PID: 5224 at kernel/locking/rwsem.c:1364 __up_write kernel/locking/rwsem.c:1364 [inline]
WARNING: CPU: 0 PID: 5224 at kernel/locking/rwsem.c:1364 up_write+0x412/0x590 kernel/locking/rwsem.c:1632
Modules linked in:
CPU: 0 UID: 0 PID: 5224 Comm: syz-executor352 Not tainted 6.11.0-rc7-syzkaller-00149-g0babf683783d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:__up_write kernel/locking/rwsem.c:1364 [inline]
RIP: 0010:up_write+0x412/0x590 kernel/locking/rwsem.c:1632
Code: c7 c7 a0 c8 ea 8b 48 c7 c6 80 ca ea 8b 48 89 da 48 8b 4c 24 20 4c 8b 44 24 30 4c 8b 4c 24 28 50 e8 63 9c e6 ff 48 83 c4 08 90 <0f> 0b 90 90 e9 b6 fc ff ff 90 0f 0b 90 e9 2a fd ff ff 48 89 5c 24
RSP: 0018:ffffc9000346fa00 EFLAGS: 00010296
RAX: cfd9eb2aab6fe000 RBX: 0000000000000001 RCX: ffff88802f4f9e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000346fad0 R08: ffffffff8155b292 R09: fffffbfff1cba0e0
R10: dffffc0000000000 R11: fffffbfff1cba0e0 R12: ffff88807b7288f0
R13: ffff88807b728898 R14: 1ffff9200068df48 R15: dffffc0000000000
FS:  000055556efe7380(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 0000000078130000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ntfs_truncate fs/ntfs3/file.c:461 [inline]
 ntfs3_setattr+0x7b5/0xb80 fs/ntfs3/file.c:775
 notify_change+0xbca/0xe90 fs/attr.c:503
 do_truncate+0x220/0x310 fs/open.c:65
 vfs_truncate+0x2e1/0x3b0 fs/open.c:111
 do_sys_truncate+0xdb/0x190 fs/open.c:134
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f43d7bf8779
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffda6ccac8 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00007fffda6ccc98 RCX: 00007f43d7bf8779
RDX: 00007f43d7bf8779 RSI: 0000000000000000 RDI: 0000000020000000
RBP: 00007f43d7c8b610 R08: 00007fffda6ccc98 R09: 00007fffda6ccc98
R10: 00007fffda6ccc98 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffda6ccc88 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

