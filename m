Return-Path: <linux-kernel+bounces-374441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2BA9A6A60
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8111E1F21754
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277601E0DD6;
	Mon, 21 Oct 2024 13:32:09 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B0111185
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517528; cv=none; b=TXhwgdVbvIdDwGtEqYRTtkF96a0Gk0yOWhSjxYR6t+BwDDxGecfOYD2vtJm1tB2xIc/t3A4uF0cy0WoyZ28iY2jN7PK8UKNnBsqqpq4AeMOq86xZtGrEDsNm7oU1GfS0NP+m79F9gXDGNmaulOr6C4cjTKrgSvssSre2BLGchrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517528; c=relaxed/simple;
	bh=wXFgTGrtzRH7a46BWMJgImCLMOrY/qJja9DeFKYPAvc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KDiVO6TlY3V3mwRaMn+uwiGB0cKKGGDBpeR4/O7sGLWoGdvQx+9iveRB5bBR4PLiMVDJwi+v/eN3iuwEafpP6jepV65nbiS7UbwqIjZfnrP1UzyV1PA3L5NoGs2qpKWZxOObh8Ohcg4T2R72bjJcBqNwuJSOZMcPoZIQh+EQR4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3cd35858aso39543955ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517526; x=1730122326;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cIsAz0+VAkPe9a8bTqn48/lsr1Xbvswkh9lhAdT+358=;
        b=q+QbJUI6pHolC9gGF4N6KcbxWQGA27N7cURMxrZodmuvTlpQTQo2IMO63ikC0MS7Eu
         8p50pBobKgtJ0Q+wCq6dZvl+YlTT1P570tyAjOXU17JgFmJks8reP8lx5aqpoFKcZVlo
         Qp54K8zBxYsjC+FUMhtQzOYmXDHiIVVhLge/Chdfl4B3At8Adv54sabVWsZK8R2htQFJ
         WyqLl8AVUXxYLCvUvJEpSIDeDRT2zlvTOi6tgE/toMRahnej5wvQbwkRl7gAalo4p9R9
         kc08b7InU4oNExIFPMWScbI7q+fGShHvVE56fOfx4U91ZG9PQrgeJBqeGfyzV/Xkdfpu
         F6rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyAdjNniyKKQU0q7I2lpqT7ojZBUWUscbJlbEYjXCBaQsaRSPVJMo1qcEGNB4JWNau41pagjbR7EK53LA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzzx4zkJ6wUypLPNJzglSHtvWu39gmGGKoz6QZNqaVx/uxUTVP
	kKu1xuyTikg22NetUnQcr+mW2PlYuBq1yGrcq2wD60x8LB3NSbK5hUvxK3yvjpcTKi7QApU1rIR
	jARmOUpibM1MlgFjFOtNm0OhslHUoeLK7ZzE/V5hLu6Jxbpf08vqCaQw=
X-Google-Smtp-Source: AGHT+IFLaCLFbPQcoigWJnOKA3wi4JjtfsF17LIVU/BIwdLB+cWbvAK1dAKGFlgtqmhHK2WHWh4FJu00XBnGfWlF/BLy9G1rud/C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc7:b0:3a0:9244:191d with SMTP id
 e9e14a558f8ab-3a3f40ab47cmr96714725ab.16.1729517525657; Mon, 21 Oct 2024
 06:32:05 -0700 (PDT)
Date: Mon, 21 Oct 2024 06:32:05 -0700
In-Reply-To: <a9414b93-0179-4d20-b619-3ef736f223f0@nvidia.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671657d5.050a0220.1e4b4d.005b.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: cmeiohas@nvidia.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: workqueue leaked atomic, lock or RCU: kworker/NUM:NUM[NUM]

BUG: workqueue leaked atomic, lock or RCU: kworker/1:1[46]
     preempt=0x00000000 lock=0->1 RCU=0->0 workfn=smc_ib_port_event_work
1 lock held by kworker/1:1/46:
 #0: ffffffff8fcd1d48 (rtnl_mutex){+.+.}-{3:3}, at: ib_get_eth_speed+0x153/0x8e0 drivers/infiniband/core/verbs.c:1995
CPU: 1 UID: 0 PID: 46 Comm: kworker/1:1 Not tainted 6.12.0-rc2-syzkaller-00003-g89e9ae55dc56-dirty #0
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
kworker/1:1/46 is trying to acquire lock:
ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310

but task is already holding lock:
ffffffff8fcd1d48 (rtnl_mutex){+.+.}-{3:3}, at: ib_get_eth_speed+0x153/0x8e0 drivers/infiniband/core/verbs.c:1995

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

1 lock held by kworker/1:1/46:
 #0: ffffffff8fcd1d48 (rtnl_mutex){+.+.}-{3:3}, at: ib_get_eth_speed+0x153/0x8e0 drivers/infiniband/core/verbs.c:1995

stack backtrace:
CPU: 1 UID: 0 PID: 46 Comm: kworker/1:1 Not tainted 6.12.0-rc2-syzkaller-00003-g89e9ae55dc56-dirty #0
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
BUG: workqueue leaked atomic, lock or RCU: kworker/1:1[46]
     preempt=0x00000000 lock=1->0 RCU=0->0 workfn=wq_barrier_func
INFO: lockdep is turned off.
CPU: 1 UID: 0 PID: 46 Comm: kworker/1:1 Not tainted 6.12.0-rc2-syzkaller-00003-g89e9ae55dc56-dirty #0
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
console output: https://syzkaller.appspot.com/x/log.txt?x=138fe430580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=115f1c87980000


