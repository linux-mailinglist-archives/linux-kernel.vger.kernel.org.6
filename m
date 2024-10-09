Return-Path: <linux-kernel+bounces-357863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB23997717
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C770282847
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7AF1E04BF;
	Wed,  9 Oct 2024 20:59:54 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D64191473
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507594; cv=none; b=rtL0Mv6eWo7wfj0qzC+ApPPArIqpMYYIEQDTpUMQMzbIGFTl26cCubwytAJ5qyU3EzPtoxl0WaHByjUluO5nXMgIdPHmQgXIP5jGKQn3moMQBB5jfohvV71zWYwjJjlUDNLhMLPRO4zM4rSuiucJc+CnYNzF9C2ZR+VrO/Yz84g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507594; c=relaxed/simple;
	bh=ZoDwH6+Bd3A1GMLgV6BxyuFokN/wTWwTcRV7wKD59AY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZLGkazNVZJjyiRSJdlKqVw1EQAr+8FRjRRovWl9uZ6Af1a8pmBNpEi0fpqKfMxuCF985uFGQxkq06A2ceSchCGTUo+DxKcVRVQI8yUqLbXV0YMRLn+Lc33fjuQJi3MJq5rgEHcOMIWkdyf6ksaeJgZIg1xxvBcQi53fby2j4eM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a34988d6b4so4332695ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 13:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728507592; x=1729112392;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tCeD9QnPZ/tII/gsMAGS/i3fFuHE7+MVF/iF9RVHZfk=;
        b=QzPOVPZ9n/35hri8zGDbr8ZKocuTwCNQ4qWlabSVNaH77J4Ig2H7bDFMk9MPZvVwIl
         c2OmhYDFZ8gM8wXnzb3D201XtA0LASK3Tl5EBw8fSxRnVCKe6xgvXY9vKRbzoD68DGPu
         FYP/A3JOQky0fowgRt0V+/1WlCFLo6D7Jco2qLCN8oMvZk5NFeHfmRRp1OYIBls2KnIt
         HPhL8reQNMTMx8l+yfNWh6ALl/LhZfqIs6pVZdFV18f0DPvLCcr96CF8Dp0tcS5mJXv3
         l8TlNRnPqOT3/dPfUx9HyJDhbA7CGfWF3VR3Yr/Oa7tjZAIvez2g5S+v5HqVXctZ63l2
         WZbg==
X-Gm-Message-State: AOJu0Yy+6yJDQLmefJA9t7VxH0pAUmNurbw2C1AEmpB0CYodGrfCE9xF
	UAp3SZNCZAzvevvBiqiuj8X1GrJSO6Z8f97dDjqQTpo26OxgK1kR+0HlEh6d6avK6WEJpMC67u7
	g30CnIk9CBwvWl+Ps4h0u9kn6IPXc8K+56hrg4jGfg03KioruABo8eVU=
X-Google-Smtp-Source: AGHT+IFY99tWqDRkdB7INmXcw7ulwng942ItCmB2iadQH1vS8WaKJZe85YzwFAPLclBVntA8KSMGWZF7cPdeBCyJcWwoI24hwUFP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54f:0:b0:3a0:9cd5:931c with SMTP id
 e9e14a558f8ab-3a397d1d413mr42026215ab.20.1728507591874; Wed, 09 Oct 2024
 13:59:51 -0700 (PDT)
Date: Wed, 09 Oct 2024 13:59:51 -0700
In-Reply-To: <0000000000002dabd805ee5b222e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6706eec7.050a0220.67064.0054.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] possible deadlock in hfsplus_file_extend
From: syzbot <syzbot+325b61d3c9a17729454b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] possible deadlock in hfsplus_file_extend
Author: sandeen@sandeen.net

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git ffcd06b6d13b72823aba0d7c871f7e4876e7916b

On 11/26/22 2:07 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0b1dcc2cf55a Merge tag 'mm-hotfixes-stable-2022-11-24' of ..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=138ad173880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=436ee340148d5197
> dashboard link: https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3af32b89453e/disk-0b1dcc2c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/063b631f0d64/vmlinux-0b1dcc2c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/959ae1bdec1b/bzImage-0b1dcc2c.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+325b61d3c9a17729454b@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.1.0-rc6-syzkaller-00251-g0b1dcc2cf55a #0 Not tainted
> ------------------------------------------------------
> syz-executor.2/23177 is trying to acquire lock:
> ffff88805c843dc8 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_extend+0x1bf/0xf60 fs/hfsplus/extents.c:457
> 
> but task is already holding lock:
> ffff888089d400b0 (&tree->tree_lock){+.+.}-{3:3}, at: hfsplus_find_init+0x1bb/0x230 fs/hfsplus/bfind.c:30
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (&tree->tree_lock){+.+.}-{3:3}:
>        __mutex_lock_common kernel/locking/mutex.c:603 [inline]
>        __mutex_lock+0x12f/0x1360 kernel/locking/mutex.c:747
>        hfsplus_file_truncate+0xe87/0x10d0 fs/hfsplus/extents.c:595
>        hfsplus_setattr+0x1f2/0x320 fs/hfsplus/inode.c:269
>        notify_change+0xcd4/0x1440 fs/attr.c:420
>        do_truncate+0x140/0x200 fs/open.c:65
>        handle_truncate fs/namei.c:3216 [inline]
>        do_open fs/namei.c:3561 [inline]
>        path_openat+0x2143/0x2860 fs/namei.c:3714
>        do_filp_open+0x1ba/0x410 fs/namei.c:3741
>        do_sys_openat2+0x16d/0x4c0 fs/open.c:1310
>        do_sys_open fs/open.c:1326 [inline]
>        __do_sys_creat fs/open.c:1402 [inline]
>        __se_sys_creat fs/open.c:1396 [inline]
>        __x64_sys_creat+0xcd/0x120 fs/open.c:1396
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> -> #0 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:3097 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3216 [inline]
>        validate_chain kernel/locking/lockdep.c:3831 [inline]
>        __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
>        lock_acquire kernel/locking/lockdep.c:5668 [inline]
>        lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
>        __mutex_lock_common kernel/locking/mutex.c:603 [inline]
>        __mutex_lock+0x12f/0x1360 kernel/locking/mutex.c:747
>        hfsplus_file_extend+0x1bf/0xf60 fs/hfsplus/extents.c:457
>        hfsplus_bmap_reserve+0x31c/0x410 fs/hfsplus/btree.c:358
>        hfsplus_create_cat+0x1ea/0x10d0 fs/hfsplus/catalog.c:272
>        hfsplus_fill_super+0x1544/0x1a30 fs/hfsplus/super.c:560
>        mount_bdev+0x351/0x410 fs/super.c:1401
>        legacy_get_tree+0x109/0x220 fs/fs_context.c:610
>        vfs_get_tree+0x8d/0x2f0 fs/super.c:1531
>        do_new_mount fs/namespace.c:3040 [inline]
>        path_mount+0x132a/0x1e20 fs/namespace.c:3370
>        do_mount fs/namespace.c:3383 [inline]
>        __do_sys_mount fs/namespace.c:3591 [inline]
>        __se_sys_mount fs/namespace.c:3568 [inline]
>        __x64_sys_mount+0x283/0x300 fs/namespace.c:3568
>        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>        do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&tree->tree_lock);
>                                lock(&HFSPLUS_I(inode)->extents_lock);
>                                lock(&tree->tree_lock);
>   lock(&HFSPLUS_I(inode)->extents_lock);
> 
>  *** DEADLOCK ***
> 
> 3 locks held by syz-executor.2/23177:
>  #0: ffff888077b000e0 (&type->s_umount_key#58/1){+.+.}-{3:3}, at: alloc_super+0x22e/0xb60 fs/super.c:228
>  #1: ffff888026292998 (&sbi->vh_mutex){+.+.}-{3:3}, at: hfsplus_fill_super+0x14cd/0x1a30 fs/hfsplus/super.c:553
>  #2: ffff888089d400b0 (&tree->tree_lock){+.+.}-{3:3}, at: hfsplus_find_init+0x1bb/0x230 fs/hfsplus/bfind.c:30
> 
> stack backtrace:
> CPU: 0 PID: 23177 Comm: syz-executor.2 Not tainted 6.1.0-rc6-syzkaller-00251-g0b1dcc2cf55a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
>  check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2177
>  check_prev_add kernel/locking/lockdep.c:3097 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3216 [inline]
>  validate_chain kernel/locking/lockdep.c:3831 [inline]
>  __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
>  lock_acquire kernel/locking/lockdep.c:5668 [inline]
>  lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
>  __mutex_lock_common kernel/locking/mutex.c:603 [inline]
>  __mutex_lock+0x12f/0x1360 kernel/locking/mutex.c:747
>  hfsplus_file_extend+0x1bf/0xf60 fs/hfsplus/extents.c:457
>  hfsplus_bmap_reserve+0x31c/0x410 fs/hfsplus/btree.c:358
>  hfsplus_create_cat+0x1ea/0x10d0 fs/hfsplus/catalog.c:272
>  hfsplus_fill_super+0x1544/0x1a30 fs/hfsplus/super.c:560
>  mount_bdev+0x351/0x410 fs/super.c:1401
>  legacy_get_tree+0x109/0x220 fs/fs_context.c:610
>  vfs_get_tree+0x8d/0x2f0 fs/super.c:1531
>  do_new_mount fs/namespace.c:3040 [inline]
>  path_mount+0x132a/0x1e20 fs/namespace.c:3370
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount fs/namespace.c:3568 [inline]
>  __x64_sys_mount+0x283/0x300 fs/namespace.c:3568
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f752048d60a
> Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f7521100f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00000000000005f8 RCX: 00007f752048d60a
> RDX: 0000000020000600 RSI: 0000000020000040 RDI: 00007f7521100fe0
> RBP: 00007f7521101020 R08: 00007f7521101020 R09: 0000000001a00050
> R10: 0000000001a00050 R11: 0000000000000202 R12: 0000000020000600
> R13: 0000000020000040 R14: 00007f7521100fe0 R15: 0000000020000280
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.


