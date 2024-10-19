Return-Path: <linux-kernel+bounces-372989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A2B9A505E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 20:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B960B25C3E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 18:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B734190074;
	Sat, 19 Oct 2024 18:55:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B78513C682
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729364106; cv=none; b=jFlYGWlbNfP9hyEsgaV4TXrebashD7vDGqXyJlJkFWuV1M0RD9hjcPLA35DGYjU6x3sTxxJHrEJm6320hoKUPOGcbGFw7H0nZbXao9MT44gvqFkp/fj+zBTXn2k1IWrBy0afohCPUdxc9r499n8+XLmrcBelf7wKmpdOOed4CMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729364106; c=relaxed/simple;
	bh=bUZdpmm4f9yyhEMqqSdQa1SVdt1x1k5ZSrrNMBXR8WY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RvynGIMufGffOZceUbUMCQE86JYIaI9tQ6TGMCtKMJeGXOiPCEQpU+0jcd9Z0U2znhd8yieqzmTJQVql2Eq/uNL0iFIawx4Da7Koq1QqV3zggTP9+96i9pIpnKs8Xt5pXbs0ofMk8iKzcPpXu8jBBNuBWByg6cHViNjUTT9oyAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83ac1f28d2bso115570839f.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 11:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729364103; x=1729968903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y/O7auIAjkjVTXqug1jjdNIJG55HYWSLIzYdVPZJLhg=;
        b=PyGxzEELSQ/VqEI0zk4Z7o/z9POAzkB1GVth4P1fyIc9Qwv6GIak3rl6EZO1Q5I17o
         zmiJsPATMJU3VHrup3a7gOQvAMX0nwLvHPQsef2ncTCUlEhhbjy97c9l/xtMaZ0n2eKY
         mfgAbqe5ybecYPcctg1CM5pvvbWuBGg/07/XqyAj7B76mOXCU0HOkpTdphNzn3Ocv6o6
         gvL08nJHmNLUCyLJnIuoTmMeW0cXumEhnRO9CJRyFoMXZyUW54I0FiuCooj13hIarkjc
         gCYkdUJC9qcvgBFT91BeBxwDjRQyLVPbuP16TF/wRySX2FoEjDArezABmph1i+HhDzUW
         TIxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5WvCbkvDkQkC3N5PRB7nb1Ud5QM0HMolryu5EWYusk94csd7vlCr9dzPimI1NVZrv1zmct26sIPu21Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVjYjsJHZAPavBCT4WQ1NLr1TngH4eoZljSNDKZpGYyPH0bD0v
	w9FDr7Dv06qzIuPFttnHwGRl0tM0bSTuxsjZDwNiOPhSnOxoLovecZUWwyTTXO1tbOJye+lrILe
	FHG7QI7O4f/Zv1ikSngr05uuAi6WzMOlZQrqxwACASZPOF2s/yGeHRlI=
X-Google-Smtp-Source: AGHT+IFDDk13PQkCAa3iltO4tsGtXBCcRwtUU2rLfLGYNtK9Su9gln4voz8oBLzY0TkKgz/cB+qUaaTbFzcYyscUUXomViwKhSOd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216b:b0:3a0:a385:911d with SMTP id
 e9e14a558f8ab-3a3f3fd3f60mr56692755ab.0.1729364103577; Sat, 19 Oct 2024
 11:55:03 -0700 (PDT)
Date: Sat, 19 Oct 2024 11:55:03 -0700
In-Reply-To: <2deb0631-ce6c-4b18-8c34-9401198c9d39@nvidia.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67140087.050a0220.1e4b4d.002c.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: cmeiohas@nvidia.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: workqueue leaked atomic, lock or RCU: kworker/NUM:NUM[NUM]

BUG: workqueue leaked atomic, lock or RCU: kworker/1:4[5339]
     preempt=0x00000000 lock=0->1 RCU=0->0 workfn=smc_ib_port_event_work
1 lock held by kworker/1:4/5339:
 #0: ffffffff8fcd1d48 (rtnl_mutex){+.+.}-{3:3}, at: ib_get_eth_speed+0x13c/0x800 drivers/infiniband/core/verbs.c:1991
CPU: 1 UID: 0 PID: 5339 Comm: kworker/1:4 Not tainted 6.12.0-rc2-syzkaller-00003-g89e9ae55dc56-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events smc_ib_port_event_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 process_one_work kernel/workqueue.c:3250 [inline]
 process_scheduled_works+0x1158/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc2-syzkaller-00003-g89e9ae55dc56-dirty #0 Not tainted
------------------------------------------------------
kworker/1:4/5339 is trying to acquire lock:
ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310

but task is already holding lock:
ffffffff8fcd1d48 (rtnl_mutex){+.+.}-{3:3}, at: ib_get_eth_speed+0x13c/0x800 drivers/infiniband/core/verbs.c:1991

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (rtnl_mutex){+.+.}-{3:3}:
       reacquire_held_locks+0x3eb/0x690 kernel/locking/lockdep.c:5350
       __lock_release kernel/locking/lockdep.c:5539 [inline]
       lock_release+0x396/0xa30 kernel/locking/lockdep.c:5846
       process_one_work kernel/workqueue.c:3236 [inline]
       process_scheduled_works+0xb70/0x1850 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 ((wq_completion)events){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       process_one_work kernel/workqueue.c:3204 [inline]
       process_scheduled_works+0x950/0x1850 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(rtnl_mutex);
                               lock((wq_completion)events);
                               lock(rtnl_mutex);
  lock((wq_completion)events);

 *** DEADLOCK ***

1 lock held by kworker/1:4/5339:
 #0: ffffffff8fcd1d48 (rtnl_mutex){+.+.}-{3:3}, at: ib_get_eth_speed+0x13c/0x800 drivers/infiniband/core/verbs.c:1991

stack backtrace:
CPU: 1 UID: 0 PID: 5339 Comm: kworker/1:4 Not tainted 6.12.0-rc2-syzkaller-00003-g89e9ae55dc56-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events wq_barrier_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 process_one_work kernel/workqueue.c:3204 [inline]
 process_scheduled_works+0x950/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
BUG: workqueue leaked atomic, lock or RCU: kworker/1:4[5339]
     preempt=0x00000000 lock=1->0 RCU=0->0 workfn=wq_barrier_func
INFO: lockdep is turned off.
CPU: 1 UID: 0 PID: 5339 Comm: kworker/1:4 Not tainted 6.12.0-rc2-syzkaller-00003-g89e9ae55dc56-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events wq_barrier_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 process_one_work kernel/workqueue.c:3250 [inline]
 process_scheduled_works+0x1158/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         89e9ae55 IB/hfi1: make clear_all_interrupts static
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1727fc5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15bcf487980000


