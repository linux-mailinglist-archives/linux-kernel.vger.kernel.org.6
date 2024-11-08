Return-Path: <linux-kernel+bounces-401193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F849C1713
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32FC5284A58
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3091D12E9;
	Fri,  8 Nov 2024 07:38:26 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B551197A82
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051506; cv=none; b=dBtj+AKQD6LLd3P2Zk/L/fgifW5FOwT+AOo6t+bWo7rfaqq8veWvK25eQ16BHczzrjp9cPx3539WnOSQ1vQArqnaKRo0Lv+S+7jQ9BPfB8q+Lk/mi58KTI9xHBW0q964Wvlvvuija8A8XsgnKxXlhXn60gmsKVDOitvz5F1lFnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051506; c=relaxed/simple;
	bh=H5ABauqiYTmvzxyIAD10hLSydjyvPRfjyyUJ6Donh8I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EkQhqHwCcajHYJU6NEwi+SG6FZmFKQbuSa0r8x3EpZP4IRMWbbFvjXCiZIlvASRbiTiIRqlHg4XyqHRxRBNnHGoZsK3C5o6l/cD3m5aqP70yx/okL0bZpRU/60PqMUMW7rQEisOWogLW+0hnl3P3aE6EvDQJHpvA9vSpJ6+KPzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83ac354a75fso232564439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 23:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731051503; x=1731656303;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fc0iMFWrkiC8YV7w1Kkt4UDxXgkTuj/su720ky0s4K4=;
        b=nwQZic2w46M6D/aRGDEFjbFK30I1OgLt7lvrVKhsjsVUDYnvkCLIeAWB8/J+Nz68+3
         FRtKqW830QKSDZ3jZMfUY8nTMngm61i8p6KYLSQPboE83CRzm4viZ7849Ii9WH9yl+j7
         G0mTDh1J7fjiwyc/VhsgW2bhcOuXbTbsczX44NW64a9DmqiIWqlKUb60rGcY55uNlY9r
         yj3oQ6HFa0wwVetLLGtmlFkdMhCcDW7khKNPrS+FnWAzWxr4KUU4XypOWtE1XECOboyC
         Ae+U1GB9tLGXbgzGOHakxG3hXMxyW/iTXSEEKE3rRoqpJSZ+xOZSyQokeaHOpEwm6I3O
         QPkg==
X-Forwarded-Encrypted: i=1; AJvYcCUQB9iaugLlMvp7TERkp+XgMN/mDhO1HdW4wNvgT9rCwZ5cH4miZuG4CTBUfQpdT6aMbAvk1r4t/T1yrtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzQIbsefpWneJ5yiKAeV3GZlMb/iNp3IKTko2gXShRdaJrKhkC
	j6IJYlqWoQs0mS0HNexoEVzWvJsZY2U9b2eGfMi1xX0VcF6wJItuLNj+O8KjSpuAaRZYkRJUf0U
	c0ip7+BZxKaxj3RfxUnjBafToOIVHplJfteKv/keYLrYjwEpd7YTLuAE=
X-Google-Smtp-Source: AGHT+IHuzE+2BxWiHs72LyQWE1vRReJHd77VczImVbihM/tYARVv3apYugNhgDqp9OB6e7xdO+IaGRQNvQEHfW+VfcnWrcxpoWtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2b:b0:3a0:ae35:f2eb with SMTP id
 e9e14a558f8ab-3a6f1a6438cmr26728905ab.19.1731051503605; Thu, 07 Nov 2024
 23:38:23 -0800 (PST)
Date: Thu, 07 Nov 2024 23:38:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672dbfef.050a0220.69327.0000.GAE@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in run_unpack_ex
From: syzbot <syzbot+731b27ee9413ba859499@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    74741a050b79 Add linux-next specific files for 20241107
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14b4dd87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3ef0574c9dc8b00
dashboard link: https://syzkaller.appspot.com/bug?extid=731b27ee9413ba859499
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8993ea1d09da/disk-74741a05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dab7bc3c6e88/vmlinux-74741a05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fda543ad532f/bzImage-74741a05.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+731b27ee9413ba859499@syzkaller.appspotmail.com

loop5: detected capacity change from 0 to 4096
ntfs3(loop5): failed to convert "0080" to maccenteuro
ntfs3(loop5): Mark volume as dirty due to NTFS errors
======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc6-next-20241107-syzkaller #0 Not tainted
------------------------------------------------------
syz.5.2788/13195 is trying to acquire lock:
ffff88805e313518 (&ni->file.run_lock#2){++++}-{4:4}, at: run_unpack_ex+0x55e/0x9e0 fs/ntfs3/run.c:1119

but task is already holding lock:
ffff8880294f4270 (&wnd->rw_lock){++++}-{4:4}, at: run_unpack_ex+0x47a/0x9e0 fs/ntfs3/run.c:1100

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&wnd->rw_lock){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_write_nested+0xa2/0x220 kernel/locking/rwsem.c:1693
       ntfs_look_for_free_space+0x100/0x690 fs/ntfs3/fsntfs.c:362
       attr_allocate_clusters+0x1d6/0x990 fs/ntfs3/attrib.c:159
       attr_set_size+0x2053/0x4300 fs/ntfs3/attrib.c:574
       ntfs_extend_mft+0x188/0x4b0 fs/ntfs3/fsntfs.c:512
       ntfs_look_free_mft+0x77c/0x10c0 fs/ntfs3/fsntfs.c:709
       ntfs_create_inode+0x581/0x3760 fs/ntfs3/inode.c:1305
       ntfs_create+0x3d/0x50 fs/ntfs3/namei.c:110
       lookup_open fs/namei.c:3649 [inline]
       open_last_lookups fs/namei.c:3748 [inline]
       path_openat+0x1c03/0x3590 fs/namei.c:3984
       do_filp_open+0x27f/0x4e0 fs/namei.c:4014
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
       do_sys_open fs/open.c:1417 [inline]
       __do_sys_creat fs/open.c:1495 [inline]
       __se_sys_creat fs/open.c:1489 [inline]
       __x64_sys_creat+0x123/0x170 fs/open.c:1489
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ni->file.run_lock#2){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       run_unpack_ex+0x55e/0x9e0 fs/ntfs3/run.c:1119
       ntfs_read_mft fs/ntfs3/inode.c:401 [inline]
       ntfs_iget5+0x1f9a/0x37b0 fs/ntfs3/inode.c:537
       ntfs_dir_emit fs/ntfs3/dir.c:335 [inline]
       ntfs_read_hdr+0x700/0xb80 fs/ntfs3/dir.c:383
       ntfs_readdir+0x91f/0xf00 fs/ntfs3/dir.c:494
       iterate_dir+0x571/0x800 fs/readdir.c:108
       __do_sys_getdents fs/readdir.c:322 [inline]
       __se_sys_getdents+0x1fd/0x4e0 fs/readdir.c:308
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&wnd->rw_lock);
                               lock(&ni->file.run_lock#2);
                               lock(&wnd->rw_lock);
  rlock(&ni->file.run_lock#2);

 *** DEADLOCK ***

3 locks held by syz.5.2788/13195:
 #0: ffff88802e3249b8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x254/0x320 fs/file.c:1191
 #1: ffff88805e3319a0 (&type->i_mutex_dir_key#9){++++}-{4:4}, at: iterate_dir+0x20c/0x800 fs/readdir.c:101
 #2: ffff8880294f4270 (&wnd->rw_lock){++++}-{4:4}, at: run_unpack_ex+0x47a/0x9e0 fs/ntfs3/run.c:1100

stack backtrace:
CPU: 1 UID: 0 PID: 13195 Comm: syz.5.2788 Not tainted 6.12.0-rc6-next-20241107-syzkaller #0
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
 down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
 run_unpack_ex+0x55e/0x9e0 fs/ntfs3/run.c:1119
 ntfs_read_mft fs/ntfs3/inode.c:401 [inline]
 ntfs_iget5+0x1f9a/0x37b0 fs/ntfs3/inode.c:537
 ntfs_dir_emit fs/ntfs3/dir.c:335 [inline]
 ntfs_read_hdr+0x700/0xb80 fs/ntfs3/dir.c:383
 ntfs_readdir+0x91f/0xf00 fs/ntfs3/dir.c:494
 iterate_dir+0x571/0x800 fs/readdir.c:108
 __do_sys_getdents fs/readdir.c:322 [inline]
 __se_sys_getdents+0x1fd/0x4e0 fs/readdir.c:308
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc27c77e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc27d5b5038 EFLAGS: 00000246 ORIG_RAX: 000000000000004e
RAX: ffffffffffffffda RBX: 00007fc27c935f80 RCX: 00007fc27c77e719
RDX: 00000000000000b8 RSI: 0000000020001fc0 RDI: 0000000000000004
RBP: 00007fc27c7f139e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fc27c935f80 R15: 00007ffe153b2608
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

