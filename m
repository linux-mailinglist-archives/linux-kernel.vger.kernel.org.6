Return-Path: <linux-kernel+bounces-254808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F799337FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9111D1F21F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525342033A;
	Wed, 17 Jul 2024 07:27:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7B11D52D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721201224; cv=none; b=oGBpqNVemH7VvfRSzHOjPAltWfUlymMu8Lj06+5ht8QMTrX8umAk1/r22UsNJGDhacBQENJFJKmtaep6RdcUBUu7+nrCDLflg+gzkZGT328DV7WynyEar6uGy4gdLCFn9u2Pzzq9wY1HmT8NGRh6tpnrTqnzrcpcg+7jn6G+mJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721201224; c=relaxed/simple;
	bh=BkUTsD4wR7II6LGnWyjqHFXeFQuV9IEnceulKcjAIG4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TnXRLQW8LS/6FSGZYg/DyIDtPAR29kpJSqS7/NAt6lsH10wGRvmicXObpCkBulgimrcRDBJiKhbl5TeYLWNYSKa4YybWPrZATFF5UQ8hWVNyGIJthN4Si96oYSgQc+X86+XiTNu87gGQ3u9otW+CCZSuhKfleJ/gcMgUf0Q+ZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f92912a614so99595439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721201222; x=1721806022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DrLTyUBgfQraUmO9F0HR565t8JfHtTemWnOHrTtZ8PI=;
        b=JSIRRmaRUDwiOr9b8R9bKr049kvhNw4tgxxYqyaMh48+KLN5NSoNbIkp3h7/AwPQsS
         CqyGxVPmTgpo89jANZ1ZVDDkzGzxQgV3utXxI8zY7KW0+llvjxFlOKx3/uI56rpPuZ2F
         XrIzUZHO3C+RaF9kruUqWfbCYOxw5Hc3hdzKc14OeceyiYeHn5w7s4SxsKDc9KLWZeb7
         EuDaVgWCbLtBwjVH6gFSdZMyKnuk+Oh/rl1px3ZS1jBniqvcm6WQxa1E+6hU3huH1bMw
         G/R5Tqsl3lXWZ/PyKdExRqNZjEDNpILmbxoPDuJ0zIZZrXc96eF+LByHn81Azy96bXnv
         fMNA==
X-Forwarded-Encrypted: i=1; AJvYcCXwhCXCxJl5XFn8iqdV/xTb8KcLg4YsJuPV+l6Hq2BrCU67xe4lIYT1hmJmHwvGEdhiWToIQCFMTdi1aNwpY0IZzXTj/MPKO8SxCnUc
X-Gm-Message-State: AOJu0YwT0j59Fcd4ckGbFAIP+XFQT/1qwED7M21rwxnJN4HCYsV9f57v
	Er2vJFv3E16f2yM2ALz1c6y2YCG8Le1rDPm0+gmdLWP0XbiYpxtm2m2XlCyxIvh17FeGEU6oJxV
	mMfZIcSIi1Gc2ow19ILdn/w/nj2UWkTPEf/AsNBGLVdG2OYNJWdvg7CE=
X-Google-Smtp-Source: AGHT+IHco2ST1i0T5vxlDm4XewscMS+/kYvJZ0HDgM3DNrT4JZ5TD+JU2L4yRrjFjev84CHBVGUhVvLXHlG7RO1V20I2uZEnWYnI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3015:b0:4c0:73d0:3d77 with SMTP id
 8926c6da1cb9f-4c215d03b50mr47972173.5.1721201222515; Wed, 17 Jul 2024
 00:27:02 -0700 (PDT)
Date: Wed, 17 Jul 2024 00:27:02 -0700
In-Reply-To: <6fb088e7-3385-4c06-945f-0a58da0bf138@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000749377061d6c634f@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_set_state (2)
From: syzbot <syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in ntfs_set_state

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS sector size (4096) and media sector size (512).
ntfs3: loop0: ino=5, "/" ntfs_iget5
============================================
WARNING: possible recursive locking detected
6.10.0-rc1-syzkaller-00042-g911daf695a74 #0 Not tainted
--------------------------------------------
syz-executor.0/5460 is trying to acquire lock:
ffff88807a378100 (&ni->ni_lock#2){+.+.}-{3:3}, at: ntfs_set_state+0x1d2/0x6a0 fs/ntfs3/fsntfs.c:947

but task is already holding lock:
ffff88807a1f0100 (&ni->ni_lock#2){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1130 [inline]
ffff88807a1f0100 (&ni->ni_lock#2){+.+.}-{3:3}, at: ni_write_inode+0x24a/0x2920 fs/ntfs3/frecord.c:3333

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&ni->ni_lock#2);
  lock(&ni->ni_lock#2);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by syz-executor.0/5460:
 #0: ffff888029f26420 (sb_writers#13){.+.+}-{0:0}, at: do_sys_ftruncate fs/open.c:199 [inline]
 #0: ffff888029f26420 (sb_writers#13){.+.+}-{0:0}, at: __do_sys_ftruncate fs/open.c:207 [inline]
 #0: ffff888029f26420 (sb_writers#13){.+.+}-{0:0}, at: __se_sys_ftruncate fs/open.c:205 [inline]
 #0: ffff888029f26420 (sb_writers#13){.+.+}-{0:0}, at: __x64_sys_ftruncate+0xa9/0x110 fs/open.c:205
 #1: ffff88807a1f03a0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:791 [inline]
 #1: ffff88807a1f03a0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: do_truncate+0x14b/0x220 fs/open.c:63
 #2: ffff88807a1f0100 (&ni->ni_lock#2){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1130 [inline]
 #2: ffff88807a1f0100 (&ni->ni_lock#2){+.+.}-{3:3}, at: ni_write_inode+0x24a/0x2920 fs/ntfs3/frecord.c:3333

stack backtrace:
CPU: 1 PID: 5460 Comm: syz-executor.0 Not tainted 6.10.0-rc1-syzkaller-00042-g911daf695a74 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain kernel/locking/lockdep.c:3856 [inline]
 __lock_acquire+0x20e6/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 ntfs_set_state+0x1d2/0x6a0 fs/ntfs3/fsntfs.c:947
 ntfs_iget5+0x245/0x3880 fs/ntfs3/inode.c:540
 ni_update_parent fs/ntfs3/frecord.c:3286 [inline]
 ni_write_inode+0x1603/0x2920 fs/ntfs3/frecord.c:3392
 ntfs_truncate fs/ntfs3/file.c:473 [inline]
 ntfs3_setattr+0x739/0xc40 fs/ntfs3/file.c:775
 notify_change+0x745/0x11f0 fs/attr.c:497
 do_truncate+0x15c/0x220 fs/open.c:65
 do_ftruncate+0x5e5/0x720 fs/open.c:181
 do_sys_ftruncate fs/open.c:199 [inline]
 __do_sys_ftruncate fs/open.c:207 [inline]
 __se_sys_ftruncate fs/open.c:205 [inline]
 __x64_sys_ftruncate+0xa9/0x110 fs/open.c:205
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fda3c07dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fda3ce450c8 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007fda3c1abf80 RCX: 00007fda3c07dda9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007fda3c0ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fda3c1abf80 R15: 00007ffdbf2e6828
 </TASK>
ntfs3: loop0: Mark volume as dirty due to NTFS errors


Tested on:

commit:         911daf69 fs/ntfs3: Fix formatting, change comments, re..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=123b55e9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd757510e287aff
dashboard link: https://syzkaller.appspot.com/bug?extid=c2ada45c23d98d646118
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

