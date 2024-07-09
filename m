Return-Path: <linux-kernel+bounces-245166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA95D92AF27
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598111F2253E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15A212CD89;
	Tue,  9 Jul 2024 04:51:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70D929CEA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 04:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720500664; cv=none; b=VLrramf6SebKyoAmOOd2jnEyHEz6Ic7QEXFxJiC6gq/y+xUFDp6WTU6UltFIOFfZqmxPZydslS0bWNvQCBceJ++DV9YTkv5/8q384YZl7J8VUP3cWvAtXqD7eDnzRBWbHD03BWglMOb4oY5aq3bfwaokXGj1UKAft+vbQQ019Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720500664; c=relaxed/simple;
	bh=8ACvb9qAkBRTEj7u90+Er/6ilXk6geJHwxx5MnDC8JY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hRo6tk/40h8s0I33aQl6O8AVONJhJB9Dz1+U9ooADOHJeDH12n0geFsus/pNoymPvK92P4TTII6sdubJxvnTX+5dHyZpxv+sw6lmsD1+vsTvTm6qpYAmqFeIommpPtRSJcyxzT0RuC+p5sAKMuwsR35ou+JMm51bP3MVALsU5ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7fb15d52c5cso266517539f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 21:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720500662; x=1721105462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oTC6GF+ZRWSB5wNTbXocLcnLt0XHbfCyoaqLkX+t0iw=;
        b=qORYyjz4ovHFz0uLn0fesxSBbi8hwTl7C5W1clLu0IU/+Mltv8G84taiNseOhexYw6
         lXi0XIBoVhOcKelbEnNkN1L22edJSJJzpdPWBUdKt1RVTqDR/+WzJWdOQ3iWMeKIshA8
         fF3kMMncjsryZg8XbI/q8LPx2pDjT7FHpkSpE7e0jsIot8OWIky7NGZnEZPGhI54H8i8
         11cY3+0GqfkMNL4d90q9y2AjMS+/xkrKuZuGiOzZm0RwNAXV9WRsrNALJHj+epd9MxP7
         8xErrZiC4mJ9DdFd0DYcRKf5koUDkq7qF8ItwjXbo1Vk2l1kFa7D5GICsIXL93ng97mn
         mSXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBSCb5gs4a9I00sNRpPZP0JO9iAOy9Gs782dNS2wX+7lA/NFjhIPg1R2YRW440zI7CkOS7Ng3B4k3WqpGpxQBRWisHoEjXbPbZvHg8
X-Gm-Message-State: AOJu0YypWWP1GtSn5kLSxrwKsU0Xg1Z84UTf9DKumnltzkrb6oAbBPFW
	aovq8HyM66fonjKC/smkpIcWSXyUlDLSASUDObzVCmc/xZ1L0B/DF2aijq6g5zsET/BBWCIBFLz
	7NDRnMe59S8P4zdQByV5WyYWJ9/kld6yJ8SHyh0i50nb7E5P0e8Wv9cs=
X-Google-Smtp-Source: AGHT+IEw+hujp2wbj/ZEUCREr+6rq9Ix+nU4yKiNzQRSUzHXuSitqM9DAObS7Z6hdaXnTexGzpxKoBaL9XTILpxDbeE7hotNtulf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1641:b0:7f8:bfcd:db3f with SMTP id
 ca18e2360f4ac-7ffffa48c77mr11973339f.1.1720500662031; Mon, 08 Jul 2024
 21:51:02 -0700 (PDT)
Date: Mon, 08 Jul 2024 21:51:02 -0700
In-Reply-To: <20240709034644.8243-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbec28061cc946f8@google.com>
Subject: Re: [syzbot] [net?] [s390?] possible deadlock in smc_release
From: syzbot <syzbot+621fd56ba002faba6392@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in smc_release

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc7-syzkaller-g4376e966ecb7 #0 Not tainted
------------------------------------------------------
syz-executor386/31174 is trying to acquire lock:
ffff8880723c08f8 ((work_completion)(&new_smc->smc_listen_work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
ffff8880723c08f8 ((work_completion)(&new_smc->smc_listen_work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
ffff8880723c08f8 ((work_completion)(&new_smc->smc_listen_work)){+.+.}-{0:0}, at: start_flush_work kernel/workqueue.c:4138 [inline]
ffff8880723c08f8 ((work_completion)(&new_smc->smc_listen_work)){+.+.}-{0:0}, at: __flush_work+0xe6/0xd00 kernel/workqueue.c:4197

but task is already holding lock:
ffff8880723c7058 (sk_lock-AF_SMC/1){+.+.}-{0:0}, at: smc_release+0x231/0x530

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (sk_lock-AF_SMC/1){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       lock_sock_nested+0x48/0x100 net/core/sock.c:3534
       smc_listen_out+0x113/0x3d0 net/smc/af_smc.c:1904
       process_one_work kernel/workqueue.c:3248 [inline]
       process_scheduled_works+0xab6/0x18e0 kernel/workqueue.c:3329
       worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 ((work_completion)(&new_smc->smc_listen_work)){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       touch_work_lockdep_map kernel/workqueue.c:3910 [inline]
       start_flush_work kernel/workqueue.c:4164 [inline]
       __flush_work+0x73c/0xd00 kernel/workqueue.c:4197
       __cancel_work_sync+0xbc/0x110 kernel/workqueue.c:4347
       smc_clcsock_release+0x62/0xf0 net/smc/smc_close.c:29
       __smc_release+0x683/0x800 net/smc/af_smc.c:300
       smc_close_non_accepted+0xd8/0x1f0 net/smc/af_smc.c:1836
       smc_close_cleanup_listen net/smc/smc_close.c:45 [inline]
       smc_close_active+0xad8/0xe90 net/smc/smc_close.c:225
       __smc_release+0xa0/0x800 net/smc/af_smc.c:276
       smc_release+0x2d9/0x530 net/smc/af_smc.c:343
       __sock_release net/socket.c:659 [inline]
       sock_close+0xbc/0x240 net/socket.c:1421
       __fput+0x24a/0x8a0 fs/file_table.c:422
       task_work_run+0x24f/0x310 kernel/task_work.c:180
       exit_task_work include/linux/task_work.h:38 [inline]
       do_exit+0xa27/0x27e0 kernel/exit.c:876
       do_group_exit+0x207/0x2c0 kernel/exit.c:1025
       __do_sys_exit_group kernel/exit.c:1036 [inline]
       __se_sys_exit_group kernel/exit.c:1034 [inline]
       __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1034
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_SMC/1);
                               lock((work_completion)(&new_smc->smc_listen_work));
                               lock(sk_lock-AF_SMC/1);
  lock((work_completion)(&new_smc->smc_listen_work));

 *** DEADLOCK ***

3 locks held by syz-executor386/31174:
 #0: ffff888069ffca10 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:791 [inline]
 #0: ffff888069ffca10 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: __sock_release net/socket.c:658 [inline]
 #0: ffff888069ffca10 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: sock_close+0x90/0x240 net/socket.c:1421
 #1: ffff8880723c7058 (sk_lock-AF_SMC/1){+.+.}-{0:0}, at: smc_release+0x231/0x530
 #2: ffffffff8e334820 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #2: ffffffff8e334820 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #2: ffffffff8e334820 (rcu_read_lock){....}-{1:2}, at: start_flush_work kernel/workqueue.c:4138 [inline]
 #2: ffffffff8e334820 (rcu_read_lock){....}-{1:2}, at: __flush_work+0xe6/0xd00 kernel/workqueue.c:4197

stack backtrace:
CPU: 0 PID: 31174 Comm: syz-executor386 Not tainted 6.10.0-rc7-syzkaller-g4376e966ecb7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
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
 touch_work_lockdep_map kernel/workqueue.c:3910 [inline]
 start_flush_work kernel/workqueue.c:4164 [inline]
 __flush_work+0x73c/0xd00 kernel/workqueue.c:4197
 __cancel_work_sync+0xbc/0x110 kernel/workqueue.c:4347
 smc_clcsock_release+0x62/0xf0 net/smc/smc_close.c:29
 __smc_release+0x683/0x800 net/smc/af_smc.c:300
 smc_close_non_accepted+0xd8/0x1f0 net/smc/af_smc.c:1836
 smc_close_cleanup_listen net/smc/smc_close.c:45 [inline]
 smc_close_active+0xad8/0xe90 net/smc/smc_close.c:225
 __smc_release+0xa0/0x800 net/smc/af_smc.c:276
 smc_release+0x2d9/0x530 net/smc/af_smc.c:343
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa27/0x27e0 kernel/exit.c:876
 do_group_exit+0x207/0x2c0 kernel/exit.c:1025
 __do_sys_exit_group kernel/exit.c:1036 [inline]
 __se_sys_exit_group kernel/exit.c:1034 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0f905fac09
Code: Unable to access opcode bytes at 0x7f0f905fabdf.
RSP: 002b:00007ffcd9863848 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0f905fac09
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f0f906752d0 R08: ffffffffffffffb8 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 00007f0f906752d0
R13: 0000000000000000 R14: 00007f0f90675d20 R15: 00007f0f905cbe60
 </TASK>


Tested on:

commit:         4376e966 Merge tag 'perf-tools-fixes-for-v6.10-2024-07..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13dcf47e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=451e6d4de6561673
dashboard link: https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

