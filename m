Return-Path: <linux-kernel+bounces-299360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA3F95D39B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 037B4B217FC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF0A18BC06;
	Fri, 23 Aug 2024 16:36:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3040185928
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430965; cv=none; b=k+AgGkoJa0t53g5HGHbSJNgmH+emc71odyFnoHStOmtUW1hW7Awq1FMX18g0o/h7hX3NmvX12CtepJlTcfpKL1Wdr7jX0ydP2qR8ew6Y1jUO6q41F8tBKSGcUwTVF1LG09PG1OUyGUvBlZ43hL1yOrBiwmYKPjjR3DJ5iLWSZF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430965; c=relaxed/simple;
	bh=DS7MB5hGIu7rQK/F0fqgxFJ6/374Q4oPl6O28N8JY04=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uqVMkvKiODieGahSrSI0gpl0cB50eZC0+6dqNuKB1OItLQ/R/HorGnatEEF3kboU8zpCrXHNFR2yMzUDqD/qFEJp/AYHFOWIQ0U7yLUHm7OrKAYKbq6GHSFFipMK5grzOXu4uAH+Elb4rgw/o8+YzIaisYPJp/4XUg0tSsz8Plg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d4c0fc036so23206645ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724430962; x=1725035762;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmvhaKwMcEV2J1fjOHnuYTPgZnI/KIsd6nsDjLmT+vw=;
        b=feKtM0SAMf8Dl9ZxvYNrxMINAGG8V8agdunYQVsrqtPZ6B4Tp9sQtr7miI/eNGIUjW
         +931jzlK2uy81ge+bS5WKAL9bT7paC/n4NJEqdM3H4V7WAUdQVNzIUZF3qUMoIm4TvnK
         wJe3skKjA5/mya60Le35pUyA8LPn3vo4Ce1/FzXV6FRjMR22uyaE/qd1JGV12jsJK4he
         Z+hDDYEczkgkWo0h9u4jLeQIIXOyvHRZkx3gnbWL00gg0liX8la1+7Hh30Nqwa9GsYqd
         xoO1PabfSPxRlrUPqRyg2Bju7S+0Jw7dAazPgD/tPHhJkVPnirOGkad6KHDl3MiVlhWR
         wK5g==
X-Forwarded-Encrypted: i=1; AJvYcCWlK2OYNA9oMlYHVBtE/7QtreXf0yGm0sj2OHbLv4xQ33cvTXH1cUGKriuaQgZGFLgjQoJm2BnKjGZBhAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfZ8H/Al2QA+RSJSQlZNwgwD+gxBGWCv3O16E0n5ku0gXtrLAz
	e8pRr3v3HlBSdupXpLEARWpF1zPV4brLkicG/1JPxYs9j7x+na+csjtyIXWrpFdXDvkyQTP6OCK
	tvZgufX0BFOwR+Q8hzqwu35o+j8JLcgIZcWDJ3g8ZFK+kNDkZXfKH4ZU=
X-Google-Smtp-Source: AGHT+IFbF5Ld8WA5shHNBTDUDhg3eePLCbiSK1FFUFkX8/VPg36X2l0zVfrJ6MIdRvGLOP7IzMaWLPpw2e9e0VP8a33M0pf7b1Gp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c2:b0:395:fa9a:318e with SMTP id
 e9e14a558f8ab-39e3c8e3417mr1670555ab.0.1724430961733; Fri, 23 Aug 2024
 09:36:01 -0700 (PDT)
Date: Fri, 23 Aug 2024 09:36:01 -0700
In-Reply-To: <f59e3f6ca8134a6b9735b5c0477e9c7f@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea027f06205c5e1d@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in mi_read
From: syzbot <syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in mi_read

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS sector size (4096) and media sector size (512).
ntfs3: loop0: Mark volume as dirty due to NTFS errors
============================================
WARNING: possible recursive locking detected
6.11.0-rc1-syzkaller-00016-g7529036a025a #0 Not tainted
--------------------------------------------
syz.0.15/6171 is trying to acquire lock:
ffff8880746f9e60 (&ni->ni_lock/5){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1111 [inline]
ffff8880746f9e60 (&ni->ni_lock/5){+.+.}-{3:3}, at: mi_read+0x2e1/0x5a0 fs/ntfs3/record.c:148

but task is already holding lock:
ffff888074424318 (&ni->ni_lock/5){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1111 [inline]
ffff888074424318 (&ni->ni_lock/5){+.+.}-{3:3}, at: ntfs_lookup+0xf9/0x1f0 fs/ntfs3/namei.c:84

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&ni->ni_lock/5);
  lock(&ni->ni_lock/5);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by syz.0.15/6171:
 #0: ffff88802ede6420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff8880744245b0 (&type->i_mutex_dir_key#8){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:799 [inline]
 #1: ffff8880744245b0 (&type->i_mutex_dir_key#8){+.+.}-{3:3}, at: open_last_lookups fs/namei.c:3644 [inline]
 #1: ffff8880744245b0 (&type->i_mutex_dir_key#8){+.+.}-{3:3}, at: path_openat+0x7fb/0x3470 fs/namei.c:3883
 #2: ffff888074424318 (&ni->ni_lock/5){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1111 [inline]
 #2: ffff888074424318 (&ni->ni_lock/5){+.+.}-{3:3}, at: ntfs_lookup+0xf9/0x1f0 fs/ntfs3/namei.c:84

stack backtrace:
CPU: 0 UID: 0 PID: 6171 Comm: syz.0.15 Not tainted 6.11.0-rc1-syzkaller-00016-g7529036a025a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_deadlock kernel/locking/lockdep.c:3061 [inline]
 validate_chain+0x15d3/0x5900 kernel/locking/lockdep.c:3855
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 ni_lock fs/ntfs3/ntfs_fs.h:1111 [inline]
 mi_read+0x2e1/0x5a0 fs/ntfs3/record.c:148
 ntfs_read_mft fs/ntfs3/inode.c:70 [inline]
 ntfs_iget5+0x478/0x3970 fs/ntfs3/inode.c:537
 dir_search_u+0x2fe/0x3a0 fs/ntfs3/dir.c:264
 ntfs_lookup+0x106/0x1f0 fs/ntfs3/namei.c:85
 lookup_open fs/namei.c:3556 [inline]
 open_last_lookups fs/namei.c:3647 [inline]
 path_openat+0x11cc/0x3470 fs/namei.c:3883
 do_filp_open+0x235/0x490 fs/namei.c:3913
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_creat fs/open.c:1507 [inline]
 __se_sys_creat fs/open.c:1501 [inline]
 __x64_sys_creat+0x123/0x170 fs/open.c:1501
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1194977299
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f11957e1048 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f1194b05f80 RCX: 00007f1194977299
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200001c0
RBP: 00007f11949e48e6 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f1194b05f80 R15: 00007ffe08e158c8
 </TASK>


Tested on:

commit:         7529036a fs/ntfs3: Rename ntfs3_setattr into ntfs_seta..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=151c35a3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2258b49cd9b339fa
dashboard link: https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

