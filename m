Return-Path: <linux-kernel+bounces-373145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCF29A52F4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 08:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27E44B224A7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 06:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A309F286A8;
	Sun, 20 Oct 2024 06:54:28 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233BEFBF6
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 06:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729407268; cv=none; b=NdJQoXcRAoR6Je9cnD75N2ASOk8O3Yd5CzyQ4EWhgzRLL51xwMX4iTl5VU5vDP8djqgylCsjyZs+AcpQlWyLJVfhdROcahQlKpV0PYHf7BYVWBvUzSX9KhCiXrahq2/HOjKytpO2QW9Mrjx0ogQ20wfia53FOfzuSWOTzJNikSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729407268; c=relaxed/simple;
	bh=5GFzwewL/6GDKwWKnE1RznpqGM1MLWb559+xZEgufOg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JktNm3m5Z21O/yU36xBx6xMHuClWELOJL9VHHW6rDeqK2/7/5LxGBIxeXMl/x40VpBoqF7r6Ac0LZ7HvjY01FY7u+IXsMy8nDtnpiDN3m60qkdX66+7ndijMRi5j5Ewp6GL/6IVY2Sr3yLD8KSNRD1gCiKL3joIRWFf7MBe8wGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b45bfc94so33152525ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 23:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729407265; x=1730012065;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbUKYCvdMhlnRHofXfVq/vHcCYY8nGsh/snjxhoO2XE=;
        b=GrNFWa4+AcF4spc77w57h9pGPpLTTaCNs/pJDihauSWppJiQ2sjgFxcrrkUaSBQtCS
         KNZX/KbY2pphCCXpHtqmU117opR1WmXavMS80B71v+vpRXa5sOjEjdVN7R6+3GvaPxZU
         DkDORzhjaWpRYsdFY/wzCFcv09a0q/hVa2m62ytW6BouM7Ssfvjekm/8yz/MfQ3ba5aD
         khmXMZTEKUR1APzp9cnrrAJSxLlXZpP3w+ru6Uhtx9HRSU8dXF7enUM34L1q+Vw8Unqu
         eWr6eaN1K4AiIMl1/uUEoqUWEoKLDHGtoNaEY/jwh3apA33DbsknZujWNVIKwJCLeSzE
         EIlg==
X-Gm-Message-State: AOJu0YxEQ7T5BDMHVLhKO511pDMGZtivgzX9Ey5cP+j4DZJQ2sTjHEYV
	VVSiuwX7aKOYn4J4BQaxNxOoJGoUkttAyhkrx5GPyCRIP7TeQDJGuGR4ryjUyhsZM5ziS0zOpW0
	jKoVoJeWI1Cfex2+JjCOdNBf5FqnYQkhTIOAI68SevpjHSAZwVzzxQUw=
X-Google-Smtp-Source: AGHT+IF8XaoqN3UIEHsxdxYQmWYjGWUCfGKY0MT4MS0tobljYMNL3mPUd+o02SYX9FqodX68GiYK1G9tjHy8jtgxhDSGyASjGPRn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1529:b0:3a3:b3f4:af4c with SMTP id
 e9e14a558f8ab-3a3f40b74b8mr63434305ab.25.1729407265165; Sat, 19 Oct 2024
 23:54:25 -0700 (PDT)
Date: Sat, 19 Oct 2024 23:54:25 -0700
In-Reply-To: <000000000000657ecd0614456af8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6714a921.050a0220.1e4b4d.0036.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
Author: cmeiohas@nvidia.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next

On 19/10/2024 21:55, syzbot wrote:
> External email: Use caution opening links or attachments
>
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> BUG: workqueue leaked atomic, lock or RCU: kworker/NUM:NUM[NUM]
>
> BUG: workqueue leaked atomic, lock or RCU: kworker/1:4[5339]
>      preempt=0x00000000 lock=0->1 RCU=0->0 workfn=smc_ib_port_event_work
> 1 lock held by kworker/1:4/5339:
>  #0: ffffffff8fcd1d48 (rtnl_mutex){+.+.}-{3:3}, at: ib_get_eth_speed+0x13c/0x800 drivers/infiniband/core/verbs.c:1991
> CPU: 1 UID: 0 PID: 5339 Comm: kworker/1:4 Not tainted 6.12.0-rc2-syzkaller-00003-g89e9ae55dc56-dirty #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: events smc_ib_port_event_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  process_one_work kernel/workqueue.c:3250 [inline]
>  process_scheduled_works+0x1158/0x1850 kernel/workqueue.c:3310
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.12.0-rc2-syzkaller-00003-g89e9ae55dc56-dirty #0 Not tainted
> ------------------------------------------------------
> kworker/1:4/5339 is trying to acquire lock:
> ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
> ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
>
> but task is already holding lock:
> ffffffff8fcd1d48 (rtnl_mutex){+.+.}-{3:3}, at: ib_get_eth_speed+0x13c/0x800 drivers/infiniband/core/verbs.c:1991
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (rtnl_mutex){+.+.}-{3:3}:
>        reacquire_held_locks+0x3eb/0x690 kernel/locking/lockdep.c:5350
>        __lock_release kernel/locking/lockdep.c:5539 [inline]
>        lock_release+0x396/0xa30 kernel/locking/lockdep.c:5846
>        process_one_work kernel/workqueue.c:3236 [inline]
>        process_scheduled_works+0xb70/0x1850 kernel/workqueue.c:3310
>        worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>        kthread+0x2f0/0x390 kernel/kthread.c:389
>        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> -> #0 ((wq_completion)events){+.+.}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3161 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>        validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
>        __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
>        process_one_work kernel/workqueue.c:3204 [inline]
>        process_scheduled_works+0x950/0x1850 kernel/workqueue.c:3310
>        worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>        kthread+0x2f0/0x390 kernel/kthread.c:389
>        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(rtnl_mutex);
>                                lock((wq_completion)events);
>                                lock(rtnl_mutex);
>   lock((wq_completion)events);
>
>  *** DEADLOCK ***
>
> 1 lock held by kworker/1:4/5339:
>  #0: ffffffff8fcd1d48 (rtnl_mutex){+.+.}-{3:3}, at: ib_get_eth_speed+0x13c/0x800 drivers/infiniband/core/verbs.c:1991
>
> stack backtrace:
> CPU: 1 UID: 0 PID: 5339 Comm: kworker/1:4 Not tainted 6.12.0-rc2-syzkaller-00003-g89e9ae55dc56-dirty #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: events wq_barrier_func
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
>  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
>  check_prev_add kernel/locking/lockdep.c:3161 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>  validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
>  __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
>  process_one_work kernel/workqueue.c:3204 [inline]
>  process_scheduled_works+0x950/0x1850 kernel/workqueue.c:3310
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> BUG: workqueue leaked atomic, lock or RCU: kworker/1:4[5339]
>      preempt=0x00000000 lock=1->0 RCU=0->0 workfn=wq_barrier_func
> INFO: lockdep is turned off.
> CPU: 1 UID: 0 PID: 5339 Comm: kworker/1:4 Not tainted 6.12.0-rc2-syzkaller-00003-g89e9ae55dc56-dirty #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: events wq_barrier_func
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  process_one_work kernel/workqueue.c:3250 [inline]
>  process_scheduled_works+0x1158/0x1850 kernel/workqueue.c:3310
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
>
>
> Tested on:
>
> commit:         89e9ae55 IB/hfi1: make clear_all_interrupts static
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1727fc5f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
> dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=15bcf487980000
>

