Return-Path: <linux-kernel+bounces-247564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D09DA92D13E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646631F25675
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9A3191F91;
	Wed, 10 Jul 2024 12:03:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D38F191F62
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720612985; cv=none; b=Zi39/vkt+NjvzrsXAbjJn/PThFpg+GaYciZz+gxTa02yNowKHKLq4gdYQWu4ZUpUVED4392AEyfOtZh6IzM7YOaDTf/ojydXtEb8OBJ5xZEOqiFI2Qw1XKw179X0IJcNUavHdiVuMVAHJHZZVOBOjspqeUROaeAFNjP1dBXdk9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720612985; c=relaxed/simple;
	bh=WDo5+x5cmUB3dXHJlZD94j9ct538jcW9HURkvyAORrA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S8oLzvW23eYV2moRyBodSw1RIHnez3BBbxVid/FQUfHVO8SCzfbhMI26nzmUy1ItPQcZdkmHkLMVaD0d2uUaa59nni86yOSniaOby67XJm3H72clBAGVARotijPMr1fE3TdK+M8FIL1czKGOH20OiGkCFV2yVRU7P5sfgzLj82s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f684ab3f9cso55917839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 05:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720612983; x=1721217783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzRGOhh9vr1Rqh4giu3YSxXI/iifk7bpXPeE0OlPPEw=;
        b=U0uDfz0L8Ibo/9tfQtjDzFJCfpReAyzwXmQOrwSTLhBkwvBnWsGj3ZWjX62EFxyouy
         uaojH3LoYQKWBhnuNvMqzJOxWM1rwkBrlnSgdMRWQj1fdO6w9gIKJ9lI+qsu+d5vP6Ti
         zpL6U3RB2v/9ZtPP2iIfcolcUGeqtJOu9wfEu97t6a87OiHiG5oq7VTB/AxUpR4N+pKd
         7scSLKwarWkE7XAdXKlTjoBV/jKLusCH7yug+NHf9YVeYEv43Hu76xOpHaZdyLY59mmR
         C+Z5OGKXxwyiOh0kTIYe/8ZRflc7/2vyEcOoQMcJbSTdL18+Fl2yh6cN8DIT5L5uVzuy
         Wuiw==
X-Forwarded-Encrypted: i=1; AJvYcCU0/M7rg5m6+wP6NUQoiXWFklcscJjIAl2fjc7ZwUpgy1osLRUOmc3wIm1NUIM+lcUk7vEyaWcUuwY+4fkpCtLM+kNFGhvgcjSAXtai
X-Gm-Message-State: AOJu0YxA9yu4CRZGHbXsy8OwhlAuJaGbWmrhT5vusQkvBun2WACKxZ3n
	p+LEv52XnRhXala5lFG0B/D1rO4B36M/2mZdTfqvYzDqLHr29Ua8E/XWG9XA0LZtF5mX6uqVdJG
	hSJk5Io6bj9hkmWQ0kNrmvHJ5bXnZvVDuxJkTAul673YxNGJXIPWcsJU=
X-Google-Smtp-Source: AGHT+IGoaKbktm/lianNymGBgJl9rNR1DtMwKo5aLYoD1dmVhPUOiRcvRc53M3hB3Ej6xTr48GDIkYxVyFw534sSGSyczYiWkvQL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:12d3:b0:4b9:9c0a:6f6c with SMTP id
 8926c6da1cb9f-4c0b3686024mr322115173.1.1720612983127; Wed, 10 Jul 2024
 05:03:03 -0700 (PDT)
Date: Wed, 10 Jul 2024 05:03:03 -0700
In-Reply-To: <20240710031620.58099-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7d0da061ce36d5b@google.com>
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
6.10.0-rc7-syzkaller-g34afb82a3c67-dirty #0 Not tainted
------------------------------------------------------
syz-executor.0/20276 is trying to acquire lock:
ffff88802ba176f8 ((work_completion)(&new_smc->smc_listen_work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
ffff88802ba176f8 ((work_completion)(&new_smc->smc_listen_work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
ffff88802ba176f8 ((work_completion)(&new_smc->smc_listen_work)){+.+.}-{0:0}, at: start_flush_work kernel/workqueue.c:4138 [inline]
ffff88802ba176f8 ((work_completion)(&new_smc->smc_listen_work)){+.+.}-{0:0}, at: __flush_work+0xe6/0xd00 kernel/workqueue.c:4197

but task is already holding lock:
ffff88807c4a0258 (sk_lock-AF_SMC/1){+.+.}-{0:0}, at: smc_release+0x231/0x530

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (sk_lock-AF_SMC/1){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       lock_sock_nested+0x48/0x100 net/core/sock.c:3534
       smc_listen_out+0x113/0x3d0 net/smc/af_smc.c:1906
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
       __smc_release+0x683/0x800 net/smc/af_smc.c:302
       smc_close_non_accepted+0xd8/0x1f0 net/smc/af_smc.c:1838
       smc_close_cleanup_listen net/smc/smc_close.c:45 [inline]
       smc_close_active+0xad8/0xe90 net/smc/smc_close.c:225
       __smc_release+0xa0/0x800 net/smc/af_smc.c:276
       smc_release+0x2d9/0x530 net/smc/af_smc.c:345
       __sock_release net/socket.c:659 [inline]
       sock_close+0xbc/0x240 net/socket.c:1421
       __fput+0x24a/0x8a0 fs/file_table.c:422
       __do_sys_close fs/open.c:1563 [inline]
       __se_sys_close fs/open.c:1548 [inline]
       __x64_sys_close+0x7f/0x110 fs/open.c:1548
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

3 locks held by syz-executor.0/20276:
 #0: ffff8880699e1a10 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:791 [inline]
 #0: ffff8880699e1a10 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: __sock_release net/socket.c:658 [inline]
 #0: ffff8880699e1a10 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: sock_close+0x90/0x240 net/socket.c:1421
 #1: ffff88807c4a0258 (sk_lock-AF_SMC/1){+.+.}-{0:0}, at: smc_release+0x231/0x530
 #2: ffffffff8e334820 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #2: ffffffff8e334820 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #2: ffffffff8e334820 (rcu_read_lock){....}-{1:2}, at: start_flush_work kernel/workqueue.c:4138 [inline]
 #2: ffffffff8e334820 (rcu_read_lock){....}-{1:2}, at: __flush_work+0xe6/0xd00 kernel/workqueue.c:4197

stack backtrace:
CPU: 0 PID: 20276 Comm: syz-executor.0 Not tainted 6.10.0-rc7-syzkaller-g34afb82a3c67-dirty #0
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
 __smc_release+0x683/0x800 net/smc/af_smc.c:302
 smc_close_non_accepted+0xd8/0x1f0 net/smc/af_smc.c:1838
 smc_close_cleanup_listen net/smc/smc_close.c:45 [inline]
 smc_close_active+0xad8/0xe90 net/smc/smc_close.c:225
 __smc_release+0xa0/0x800 net/smc/af_smc.c:276
 smc_release+0x2d9/0x530 net/smc/af_smc.c:345
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x24a/0x8a0 fs/file_table.c:422
 __do_sys_close fs/open.c:1563 [inline]
 __se_sys_close fs/open.c:1548 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1548
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f952867bc9a
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007fff0f13dee0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007f952867bc9a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 0000000000000032 R08: 0000001b2cb60000 R09: 00007f95287abf8c
R10: 00007fff0f13e030 R11: 0000000000000293 R12: 00007f95282003f8
R13: ffffffffffffffff R14: 00007f9528200000 R15: 000000000003a6d4
 </TASK>


Tested on:

commit:         34afb82a Merge tag '6.10-rc6-smb3-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=115531e1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=451e6d4de6561673
dashboard link: https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13d53371980000


