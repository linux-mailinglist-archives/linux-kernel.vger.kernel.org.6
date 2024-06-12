Return-Path: <linux-kernel+bounces-210896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 925259049D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1472D1F22175
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3585021360;
	Wed, 12 Jun 2024 03:58:23 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9D51F602
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718164702; cv=none; b=RJ2ObmgoMU4e0jQV9GRXNAKlwQXb+//gMmIGDxRX9B87JYDWQLM12efBxAygLKSJZI6jVM5Ttm299Z3qZ3exiDQrR05WaKQql+YdDP+ESBoxO9NWejrMjWQDqMPU+AG3Ki0eCr2NI0eSLZQsaebrA1FOl36QAqM+v1DRnaJSCTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718164702; c=relaxed/simple;
	bh=p5asosSazmrpu9azCDUZZ3UQaRdGUAIgeUXqhMl8NOI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cNay1JXlQ30FWn+vfLK2H2HDIW++ucQOelNAvxMQk4KHybfGHxlkP5Ix0mdxUCUEOFtdEkzIN9oj1CvO+8o1Jy8Pdk3QmKDwF6PAh8o/8Rt+95krxQqMBrUksELB7nwBOH1KTZEr3Lu4a9E0/+PTUzMOqlP1rs2TFjoR+VFasIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e91ad684e4so753919439f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718164700; x=1718769500;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQYH2TrsZ7NiWNhWZFT6JrJyWqlVIePoFA0pYyW0Cx4=;
        b=AgFLHeQHJ6sZXZX0tR1CIeeUY0R630UlPhGZwX3i4LOjZrbzO5E2liPRF+2MarjZMs
         nzrF+vU8kvm1bO1FLOCPJRWyYZwO9Sz72IaDo0WMkNcK/uFrCqE8okmDSN/ixXWah4Vf
         Pk9BxrI4rQaGzrxcN4fPRoW2PMwj6Rf3//lmcnEQfZ1j1Cxs1Km14jnL7Sk76aA6pJss
         AHgtB76D3iRM233aHuSXyUlYdWcM9ZZGuaBofRRiAi7X9Ah/xUQ0rsPt2vcKwdiLQ6Bj
         rchUPiVZSMSQON3Tas75fxkfVbgmLlXWqkq5HvWuIWGTH+weRXH3NC5SHVVrdKNi4BMe
         E5Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUJd0oRVuJarudXV5dQeV+5aeBTTCmndPch8IN0qM/u7lUmtZ3FeKdoOZmWJM7Xv8K1ChO0jzYhac5KKnZ5Ma3D0g60wAmi3C78V+fz
X-Gm-Message-State: AOJu0YwvfQP5ZCNDNUMuOeoHq0CoP9Tp3HWxIyXCz5KRivP4b4cIKu2f
	UYd+bm1nBF91Gi1CTQjFxeGfg+EXbwiDDA/rNtsMaC0vilcIPBuANSET29jrgsbvPtea9dy6+oV
	sYFszD0JCi9KtJttgqFIIIwU/ecNaNJ2mvIvpaeKj0OoFJtiOKEHUmLs=
X-Google-Smtp-Source: AGHT+IFASV8Vk3JgLpJ72mZl5rw1jV7jwFDVFaAzb6S696/uQM71nQ2XvbaoAdpj6txWhskk4dEcRTQEXK/6NEjy2WzOgDohGyix
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22d3:b0:4b9:2c27:3586 with SMTP id
 8926c6da1cb9f-4b93eb97394mr47880173.1.1718164700097; Tue, 11 Jun 2024
 20:58:20 -0700 (PDT)
Date: Tue, 11 Jun 2024 20:58:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d7f32061aa964a3@google.com>
Subject: [syzbot] [overlayfs?] possible deadlock in ovl_copy_up_start (4)
From: syzbot <syzbot+6d34d0b636fea8b593eb@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    771ed66105de Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d2d41c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a6ac4277fffe3ea
dashboard link: https://syzkaller.appspot.com/bug?extid=6d34d0b636fea8b593eb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/424f71634ac4/disk-771ed661.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b5e8a406642/vmlinux-771ed661.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ad23424a0851/bzImage-771ed661.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6d34d0b636fea8b593eb@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc2-syzkaller-00366-g771ed66105de #0 Not tainted
------------------------------------------------------
syz-executor.2/5264 is trying to acquire lock:
ffff888055db1698 (&ovl_i_lock_key[depth]){+.+.}-{3:3}, at: ovl_inode_lock_interruptible fs/overlayfs/overlayfs.h:657 [inline]
ffff888055db1698 (&ovl_i_lock_key[depth]){+.+.}-{3:3}, at: ovl_copy_up_start+0x53/0x310 fs/overlayfs/util.c:719

but task is already holding lock:
ffff88802fbb6420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (sb_writers#4){.+.+}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1655 [inline]
       sb_start_write include/linux/fs.h:1791 [inline]
       ovl_start_write+0x11d/0x290 fs/overlayfs/util.c:31
       ovl_do_copy_up fs/overlayfs/copy_up.c:967 [inline]
       ovl_copy_up_one fs/overlayfs/copy_up.c:1168 [inline]
       ovl_copy_up_flags+0x1110/0x4470 fs/overlayfs/copy_up.c:1223
       ovl_create_object+0x113/0x370 fs/overlayfs/dir.c:638
       lookup_open fs/namei.c:3505 [inline]
       open_last_lookups fs/namei.c:3574 [inline]
       path_openat+0x1425/0x3280 fs/namei.c:3804
       do_filp_open+0x235/0x490 fs/namei.c:3834
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
       do_sys_open fs/open.c:1420 [inline]
       __do_sys_openat fs/open.c:1436 [inline]
       __se_sys_openat fs/open.c:1431 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1431
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ovl_i_lock_key[depth]){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       ovl_inode_lock_interruptible fs/overlayfs/overlayfs.h:657 [inline]
       ovl_copy_up_start+0x53/0x310 fs/overlayfs/util.c:719
       ovl_copy_up_one fs/overlayfs/copy_up.c:1161 [inline]
       ovl_copy_up_flags+0xbc1/0x4470 fs/overlayfs/copy_up.c:1223
       ovl_create_tmpfile fs/overlayfs/dir.c:1317 [inline]
       ovl_tmpfile+0x262/0x6d0 fs/overlayfs/dir.c:1373
       vfs_tmpfile+0x396/0x510 fs/namei.c:3701
       do_tmpfile+0x156/0x340 fs/namei.c:3764
       path_openat+0x2ab8/0x3280 fs/namei.c:3798
       do_filp_open+0x235/0x490 fs/namei.c:3834
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
       do_sys_open fs/open.c:1420 [inline]
       __do_sys_open fs/open.c:1428 [inline]
       __se_sys_open fs/open.c:1424 [inline]
       __x64_sys_open+0x225/0x270 fs/open.c:1424
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_writers#4);
                               lock(&ovl_i_lock_key[depth]);
                               lock(sb_writers#4);
  lock(&ovl_i_lock_key[depth]);

 *** DEADLOCK ***

2 locks held by syz-executor.2/5264:
 #0: ffff888060236420 (sb_writers#13){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409
 #1: ffff88802fbb6420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409

stack backtrace:
CPU: 0 PID: 5264 Comm: syz-executor.2 Not tainted 6.10.0-rc2-syzkaller-00366-g771ed66105de #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 ovl_inode_lock_interruptible fs/overlayfs/overlayfs.h:657 [inline]
 ovl_copy_up_start+0x53/0x310 fs/overlayfs/util.c:719
 ovl_copy_up_one fs/overlayfs/copy_up.c:1161 [inline]
 ovl_copy_up_flags+0xbc1/0x4470 fs/overlayfs/copy_up.c:1223
 ovl_create_tmpfile fs/overlayfs/dir.c:1317 [inline]
 ovl_tmpfile+0x262/0x6d0 fs/overlayfs/dir.c:1373
 vfs_tmpfile+0x396/0x510 fs/namei.c:3701
 do_tmpfile+0x156/0x340 fs/namei.c:3764
 path_openat+0x2ab8/0x3280 fs/namei.c:3798
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_open fs/open.c:1428 [inline]
 __se_sys_open fs/open.c:1424 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1424
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff91547cf69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff91627e0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007ff9155b3f80 RCX: 00007ff91547cf69
RDX: 0000000000000000 RSI: 0000000000591002 RDI: 0000000020000100
RBP: 00007ff9154da6fe R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007ff9155b3f80 R15: 00007ffe78e13ca8
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

