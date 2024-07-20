Return-Path: <linux-kernel+bounces-257878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5988938005
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 10:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BD0282215
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 08:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B5F2C1AC;
	Sat, 20 Jul 2024 08:38:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E08F10A0C
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721464687; cv=none; b=GDJ1RpZwGvajxdpnUXHFpNirxODqo0c7wyJdhiHp9F6r6W5b7riUH3cFaEpqiBaVakxjkM1Vbj2skfG8jFrzWdL1jlHNH/LXBWIx+FYuL0f8hoGxMZLodub3X4SXzNrYdT+tCWDRogxGNduTJk75CsXjQuq62Gsds1YxESg+nI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721464687; c=relaxed/simple;
	bh=PPmHwjNaNbD135zyDMwBrlY5SQVjMzjEC0VZ261wjQI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jxhWWxTyVIQ8s/V8De92HLBdozKi2+Br6+QYux3TbKcKzzquYbR3UrGznc87zokMD7b3WZBI5PuvgoWs+6OGk24QetFYwpJ6ruZ9bxq8aI2bCHFgH3OZHcpyECXxd0gY3BJBppRdGq0hiXmLXAHz7Q9Vl4h6b1PfmMW5ziuSWMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f66b3d69a8so397369739f.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 01:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721464685; x=1722069485;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/fIlFkyCDCTgXqs1kavVI5fT8kKDWlN2ouFnaHUJtE=;
        b=pG4xtOl7f6oYuP2JOU8eBZsGq97mALW0M5IeT0c9h+b5hZ+S03FHA9rKMf1q8X55aL
         Rt5SG+pSU8/Wtk1IBvTjA2RQgbQLc3oL1n3MMm1KlMG+odggmxVNKrjtG0Lnu/xWkJUY
         GkQxrRwvzfyhXZsNZdxW+djZytwDQe6N5FzSceSMa7xOyhS6vB9se1btedHBwY1C2qh5
         NCj7+QkmU6ShLeq43QX+BiyVVtRQ+m/LpRVoQC+l4S7m44qZXlmJkfvAIW6/tZHuuOWH
         6fYuVwwVSo0X8LzQtgXkQRg6l/1CrbRBHoCTnK1Uh0ooaMdDq2WX9zG2lEnfgyI6vHtw
         LgGw==
X-Forwarded-Encrypted: i=1; AJvYcCWRN6ugW+MI4ZGfJIUHMwa3E1IXXD5sDXFUk6lEE8bQ8cLXU7uj5aR8OlBahwSxePHnxDeWvQlI2wAbRlfWa4iwhgeMjEnAuZaexcX5
X-Gm-Message-State: AOJu0YyFe9IKaRX4oU3zjuz/l9sEMcncXOxeaVy5e7xzBUDlEdg/zwpu
	1XDkc7cRULN27vjyoGayDAKbXHt/aVTLGuWuUKJMPO2d5vTKolG8i4ALisaZAYx9LF2Ntx//GVe
	X56BlHJ7ZTH9wOSHd8kn+55D883dX8qISTD/EhDAa4VPKpBFV4fIk6gQ=
X-Google-Smtp-Source: AGHT+IE4gGaLkNmz/P+T+TIxzZNtzwRQS0bUYu3TjXs6wNCof2UsUDstPq9OkYp5l8s+R3zdpYj7Z1Wakz6+G7s9UNnHmegaXNNd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:25c9:b0:4bb:ae73:2783 with SMTP id
 8926c6da1cb9f-4c23fdae429mr54514173.2.1721464685509; Sat, 20 Jul 2024
 01:38:05 -0700 (PDT)
Date: Sat, 20 Jul 2024 01:38:05 -0700
In-Reply-To: <023c2035-91d2-4e0d-a2ce-7aacd763ac0d@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012c98e061da9bb98@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ni_fiemap
From: syzbot <syzbot+c300ab283ba3bc072439@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in attr_data_get_block

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc1-syzkaller-00035-gd57431c6f511 #0 Not tainted
------------------------------------------------------
syz-executor.0/5470 is trying to acquire lock:
ffff88807655e840 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1107 [inline]
ffff88807655e840 (&ni->ni_lock/4){+.+.}-{3:3}, at: attr_data_get_block+0x463/0x2ff0 fs/ntfs3/attrib.c:917

but task is already holding lock:
ffff88807e94ea18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
ffff88807e94ea18 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x17c/0x3d0 mm/util.c:571

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&mm->mmap_lock){++++}-{3:3}:
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

-> #0 (&ni->ni_lock/4){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
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

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mm->mmap_lock);
                               lock(&ni->ni_lock/4);
                               lock(&mm->mmap_lock);
  lock(&ni->ni_lock/4);

 *** DEADLOCK ***

1 lock held by syz-executor.0/5470:
 #0: ffff88807e94ea18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
 #0: ffff88807e94ea18 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x17c/0x3d0 mm/util.c:571

stack backtrace:
CPU: 0 PID: 5470 Comm: syz-executor.0 Not tainted 6.10.0-rc1-syzkaller-00035-gd57431c6f511 #0
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
RIP: 0033:0x7f2f0687dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2f075d70c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f2f069abf80 RCX: 00007f2f0687dea9
RDX: 00000000027fffff RSI: 0000000000600000 RDI: 0000000020000000
RBP: 00007f2f068ca4a4 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000004002011 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f2f069abf80 R15: 00007ffd044d5088
 </TASK>


Tested on:

commit:         d57431c6 fs/ntfs3: Do copy_to_user out of run_lock
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17849349980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

