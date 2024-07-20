Return-Path: <linux-kernel+bounces-257872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7817D937FFB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 10:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D296AB212D7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 08:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069622AE66;
	Sat, 20 Jul 2024 08:22:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6CF1803D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721463724; cv=none; b=tEFp8Ccz5mfZQBHyNNozde3AEcImkJlOSacc9M29mByBsxXl3tdY1gr96Lxlq0BoaqHYIYjJNFpbaOzILKBhCJuUMTCPNllS5yrH1y+vF18Qot+V79sGdymMALAPchA3710rlnvb82b1d3sVrzZLWOkKVNJHlaWFrODIR50/00E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721463724; c=relaxed/simple;
	bh=bMzdpm4YpAQTEMb0LbhbPtnyVjVZZpXykeyYfWRQ3+0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rK/HDGZIBJkyNutZMqh8ngpC+6JADpEzx7YTs6sgBOCNvg4/voxKe/x4ecBTSAhz0i+Rt/XO6n/rUXL7HQlDW4v4lC+buqFNGBrNR2LxDUdG2vhGUqxQg1TnjLhPrcWdC/B9pKBR3ThDxrgT8I7mN12X6VIZI0TeD5mL6E2Etoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-803621a51c9so431715439f.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 01:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721463722; x=1722068522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ln5JK6ngMG7eu6i28QuNjznzmBJiG29KgB9JMFBQiWU=;
        b=ATSMDqkR/THfKA00FhfAXM6zZVJCW99S9/yIRRik7eEMBhcJnJyP+mM5AAOrPtT2/q
         xmN91wmB6ZcOFx0LGZgl63PhRpme2PnunDThGz7kLqSoc3G/VhkiYD93malHzRKa6OLw
         pK08Cn0AOzXr/KwsuwErHPN7zc6F2uhrlvkNJjPCCpXj5gNMzqgiug7N0HxvoZ9lQJt2
         RRVuLvlQy6wHZi2d3KZD7W8URE+dFS9Cm013VEsLp7BD36xP1eS/8+oHDkpnAcS4akUG
         rPwL7iCrVjdHo1IGuYHr/zwKhdODILtMHMeJbEnE0huYLUVTw2JW7jfbBaS4x2yo01M7
         TeYg==
X-Forwarded-Encrypted: i=1; AJvYcCWJEKRM4umqn7njJfI5EBdLmWnuTT1p3sVSLcI9ELPLv4cZsT/0gyX5gOmiGdYkrCXY+uJ88PgLUuVQEW6tcCNRXTO/7IVuoKn2/OCX
X-Gm-Message-State: AOJu0Yy7a9hXdVraogbEgd0/n0KZVbrsLno7LZmhU7qUr5RG3MMwbNNz
	LYMYJaGIzu8i1a4hwTAigf6GQJyK5XjuX3uGXWe2N6v2BvBKdUKdXWtCsvDlGqveU3MMyiRopno
	PWSmGzIf/yfoGqdAe+EccWV+8X4vKVldoQRo6rDlpkse31o42boE+lrg=
X-Google-Smtp-Source: AGHT+IEFSY9SWnmdlrfxbjNCJt0i3m0+qSmwIKYg1SQBiDd2vGy1liGGf6WNvRAsdOPob0vKCoYHJfTYF6UqrEYmah13bUWBgzG7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8410:b0:4b9:eee6:40d with SMTP id
 8926c6da1cb9f-4c23fe04aa9mr105112173.4.1721463722078; Sat, 20 Jul 2024
 01:22:02 -0700 (PDT)
Date: Sat, 20 Jul 2024 01:22:02 -0700
In-Reply-To: <bd99516e-8702-4888-abed-fb86d5b9d84a@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6067e061da9818b@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_fiemap
From: syzbot <syzbot+96cee7d33ca3f87eee86@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in ntfs_fiemap

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS sector size (4096) and media sector size (512).
======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc1-syzkaller-00035-gd57431c6f511 #0 Not tainted
------------------------------------------------------
syz-executor.0/5466 is trying to acquire lock:
ffff88801bb51e18 (&mm->mmap_lock){++++}-{3:3}, at: __might_fault+0xaa/0x120 mm/memory.c:6233

but task is already holding lock:
ffff88807905d220 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1107 [inline]
ffff88807905d220 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_fiemap+0xff/0x180 fs/ntfs3/file.c:1211

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ni->ni_lock/4){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       ni_lock fs/ntfs3/ntfs_fs.h:1107 [inline]
       attr_data_get_block+0x463/0x2ff0 fs/ntfs3/attrib.c:917
       ntfs_file_mmap+0x50e/0x860 fs/ntfs3/file.c:294
       call_mmap include/linux/fs.h:2107 [inline]
       mmap_region+0xe8f/0x2090 mm/mmap.c:2886
       do_mmap+0x8ad/0xfa0 mm/mmap.c:1397
       vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:573
       ksys_mmap_pgoff+0x4f1/0x720 mm/mmap.c:1443
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __might_fault+0xc6/0x120 mm/memory.c:6233
       _copy_to_user+0x2a/0xb0 lib/usercopy.c:41
       copy_to_user include/linux/uaccess.h:191 [inline]
       fiemap_fill_next_extent+0x235/0x410 fs/ioctl.c:145
       ni_fiemap+0x4f5/0x1910 fs/ntfs3/frecord.c:1993
       ntfs_fiemap+0x132/0x180 fs/ntfs3/file.c:1213
       ioctl_fiemap fs/ioctl.c:220 [inline]
       do_vfs_ioctl+0x1c07/0x2e50 fs/ioctl.c:841
       __do_sys_ioctl fs/ioctl.c:905 [inline]
       __se_sys_ioctl+0x81/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ni->ni_lock/4);
                               lock(&mm->mmap_lock);
                               lock(&ni->ni_lock/4);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

1 lock held by syz-executor.0/5466:
 #0: ffff88807905d220 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1107 [inline]
 #0: ffff88807905d220 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_fiemap+0xff/0x180 fs/ntfs3/file.c:1211

stack backtrace:
CPU: 1 PID: 5466 Comm: syz-executor.0 Not tainted 6.10.0-rc1-syzkaller-00035-gd57431c6f511 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
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
 __might_fault+0xc6/0x120 mm/memory.c:6233
 _copy_to_user+0x2a/0xb0 lib/usercopy.c:41
 copy_to_user include/linux/uaccess.h:191 [inline]
 fiemap_fill_next_extent+0x235/0x410 fs/ioctl.c:145
 ni_fiemap+0x4f5/0x1910 fs/ntfs3/frecord.c:1993
 ntfs_fiemap+0x132/0x180 fs/ntfs3/file.c:1213
 ioctl_fiemap fs/ioctl.c:220 [inline]
 do_vfs_ioctl+0x1c07/0x2e50 fs/ioctl.c:841
 __do_sys_ioctl fs/ioctl.c:905 [inline]
 __se_sys_ioctl+0x81/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f26c7a7dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f26c889e0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f26c7babf80 RCX: 00007f26c7a7dea9
RDX: 0000000020000280 RSI: 00000000c020660b RDI: 0000000000000005
RBP: 00007f26c7aca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f26c7babf80 R15: 00007ffd4e86fce8
 </TASK>


Tested on:

commit:         d57431c6 fs/ntfs3: Do copy_to_user out of run_lock
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11deb321980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9016f104992d69c
dashboard link: https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

