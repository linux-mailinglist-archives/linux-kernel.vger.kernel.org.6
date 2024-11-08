Return-Path: <linux-kernel+bounces-401194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF78D9C1714
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DF75B228E0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C971D1308;
	Fri,  8 Nov 2024 07:38:26 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31ED1D0F7D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051506; cv=none; b=l15dok+5VECjxwjW7Ahs8XtmQTz398PHqkxXlBix5kxKU979CvAjG8yuNtlkcy5gKAunwyxS0ndaXqhPpfI4+QbgHTHz6OJTNSLfi8XP54Xbx1DlQ2d6nDyMHYDIz3ZtP9R6/E1WgkMP2Cob6reO7u2rzj7BH/bOh6fwbclcp80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051506; c=relaxed/simple;
	bh=Z0yka/gHUbECjGhS+svH4I5Us0ZsfeQLgT6NcGozaGA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=X556SgK+QlJOatq8drzN/QorEcGyw3hu4Aqe6BreRTJoYuuLpAr26SaHvto9h2+fW2qdoj/XYHQiRQ0JcfcFMd61WocwiwdVJ39N9Izul0Le54i3BGNusoUqS+oWChRa+Cah1YZsTLspdScyO1wOFEyPnXdrIUygdoJnNALn6DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a4f32b0007so19139065ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 23:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731051504; x=1731656304;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uxnhchQHLyTtfm+Tl89zgYMRYi0IbFQ09kWUz8Vx7hM=;
        b=bAHbBa/N2Iu9floy3d4IfKmUw3XsahUhP5Xf0F/Du1mT/nWcMIXSoxeHmTanZur33N
         Ydw9n7L1okweMdyL8RvwIy0mXSd/MLTAW8EwU+qe4tUhYaPVFdI7tOnashkfoSli091b
         Wbx7huCqz45MyD5I9CvmItdTlPHieNo0a3YD7nnQL0BdQxn+9f/0hrcpkpTDigwCHd0u
         ajjpag4QLu9Qvi2lNpHg+UJBDQoPNNzrrbpU6rZanSxFcLOx2fm49dBaIhq14FovBZqE
         t2eNDcFB6Z7yHIucx1XY8s+Jol8z/LDEQbD78QnlSjUgMx5mXhZniw+0P4cYPEG/RuNP
         VnCA==
X-Forwarded-Encrypted: i=1; AJvYcCUQn9nTX5Qss9bVm2LSBqgsKEbpO0TmtOxPrbYeAibzyG+Toq9Kn1EIVKpfKeAdpuGyUpCLom9nl7Oo9NY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfKKRMUZBIS5ny39m4Cmc11/yTuVy2Q9bBWJrZPZ6b43rCZU5o
	hJp4vXF270vIxaRex1R1nrwvaUnnIWunfJRAf3nXIVL9Y4MPxH6AFVX0HhrFZeMw7NbyJoqL1Sa
	Q9r2/T4FXDjIOP20nxCWxXxkcu/xIz4+7NgQOGZ70+i3cCaB0PeEGeh0=
X-Google-Smtp-Source: AGHT+IGSSpUIyw605MrYqKlGF3UN1XZ4Mz+Z/N5DPuh96HEVMEpEXREXdb/GSVw7HeBoSvnnWBgzfZRRdFKb7hV636TFLWsUGwvV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170c:b0:3a6:cac0:1299 with SMTP id
 e9e14a558f8ab-3a6f19d1253mr24621845ab.14.1731051503874; Thu, 07 Nov 2024
 23:38:23 -0800 (PST)
Date: Thu, 07 Nov 2024 23:38:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672dbfef.050a0220.69327.0001.GAE@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in ntfs_look_for_free_space
From: syzbot <syzbot+d27edf9f96ae85939222@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    74741a050b79 Add linux-next specific files for 20241107
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13f15d87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3ef0574c9dc8b00
dashboard link: https://syzkaller.appspot.com/bug?extid=d27edf9f96ae85939222
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8993ea1d09da/disk-74741a05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dab7bc3c6e88/vmlinux-74741a05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fda543ad532f/bzImage-74741a05.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d27edf9f96ae85939222@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc6-next-20241107-syzkaller #0 Not tainted
------------------------------------------------------
syz.1.532/8903 is trying to acquire lock:
ffff888060c52270 (&wnd->rw_lock){++++}-{4:4}, at: ntfs_look_for_free_space+0x100/0x690 fs/ntfs3/fsntfs.c:362

but task is already holding lock:
ffff888059c0efd8 (&ni->file.run_lock#2){++++}-{4:4}, at: ntfs_set_size+0x13d/0x200 fs/ntfs3/inode.c:852

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ni->file.run_lock#2){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       run_unpack_ex+0x55e/0x9e0 fs/ntfs3/run.c:1119
       ntfs_read_mft fs/ntfs3/inode.c:401 [inline]
       ntfs_iget5+0x1f9a/0x37b0 fs/ntfs3/inode.c:537
       ntfs_dir_emit fs/ntfs3/dir.c:335 [inline]
       ntfs_read_hdr+0x700/0xb80 fs/ntfs3/dir.c:383
       ntfs_readdir+0x91f/0xf00 fs/ntfs3/dir.c:494
       iterate_dir+0x571/0x800 fs/readdir.c:108
       __do_sys_getdents64 fs/readdir.c:403 [inline]
       __se_sys_getdents64+0x1e2/0x4b0 fs/readdir.c:389
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&wnd->rw_lock){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_write_nested+0xa2/0x220 kernel/locking/rwsem.c:1693
       ntfs_look_for_free_space+0x100/0x690 fs/ntfs3/fsntfs.c:362
       attr_allocate_clusters+0x1d6/0x990 fs/ntfs3/attrib.c:159
       attr_set_size+0x2053/0x4300 fs/ntfs3/attrib.c:574
       ntfs_set_size+0x161/0x200 fs/ntfs3/inode.c:854
       ntfs_extend+0x1d1/0xad0 fs/ntfs3/file.c:409
       ntfs_setattr+0x2aa/0xb80 fs/ntfs3/file.c:826
       notify_change+0xbca/0xe90 fs/attr.c:552
       do_truncate+0x220/0x310 fs/open.c:65
       vfs_truncate+0x2e1/0x3b0 fs/open.c:111
       do_sys_truncate+0xdb/0x190 fs/open.c:134
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ni->file.run_lock#2);
                               lock(&wnd->rw_lock);
                               lock(&ni->file.run_lock#2);
  lock(&wnd->rw_lock);

 *** DEADLOCK ***

4 locks held by syz.1.532/8903:
 #0: ffff888060c54420 (sb_writers#17){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff888059c0f1c0 (&sb->s_type->i_mutex_key#29){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:817 [inline]
 #1: ffff888059c0f1c0 (&sb->s_type->i_mutex_key#29){+.+.}-{4:4}, at: do_truncate+0x20c/0x310 fs/open.c:63
 #2: ffff888059c0ef28 (&ni->ni_lock#3/5){+.+.}-{4:4}, at: ni_lock fs/ntfs3/ntfs_fs.h:1110 [inline]
 #2: ffff888059c0ef28 (&ni->ni_lock#3/5){+.+.}-{4:4}, at: ntfs_set_size+0x12e/0x200 fs/ntfs3/inode.c:851
 #3: ffff888059c0efd8 (&ni->file.run_lock#2){++++}-{4:4}, at: ntfs_set_size+0x13d/0x200 fs/ntfs3/inode.c:852

stack backtrace:
CPU: 0 UID: 0 PID: 8903 Comm: syz.1.532 Not tainted 6.12.0-rc6-next-20241107-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 down_write_nested+0xa2/0x220 kernel/locking/rwsem.c:1693
 ntfs_look_for_free_space+0x100/0x690 fs/ntfs3/fsntfs.c:362
 attr_allocate_clusters+0x1d6/0x990 fs/ntfs3/attrib.c:159
 attr_set_size+0x2053/0x4300 fs/ntfs3/attrib.c:574
 ntfs_set_size+0x161/0x200 fs/ntfs3/inode.c:854
 ntfs_extend+0x1d1/0xad0 fs/ntfs3/file.c:409
 ntfs_setattr+0x2aa/0xb80 fs/ntfs3/file.c:826
 notify_change+0xbca/0xe90 fs/attr.c:552
 do_truncate+0x220/0x310 fs/open.c:65
 vfs_truncate+0x2e1/0x3b0 fs/open.c:111
 do_sys_truncate+0xdb/0x190 fs/open.c:134
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f49bd97e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f49be6ea038 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00007f49bdb35f80 RCX: 00007f49bd97e719
RDX: 0000000000000000 RSI: 0000000000101000 RDI: 0000000020000080
RBP: 00007f49bd9f139e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f49bdb35f80 R15: 00007fffc9d8ce08
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

