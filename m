Return-Path: <linux-kernel+bounces-362864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA63499BA4A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 18:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358391F21B93
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 16:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8083146D6E;
	Sun, 13 Oct 2024 16:08:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A9B231CB0
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728835685; cv=none; b=JX9u9jHKxXxbZs0a0wWgVjp3DOLVkQk1/TpQfRIPvppJyp9tUGotcPk+AHHx7Jjb+Z+rEfJBG2mLcvmErbQZEtRc6uigUvawyxpd6yTnteQ4otpet6kEihbrpGh9evxD1MAVh5r4yJpO8AJYLYCodXPYmA/Fo6izI8MMJ2DsfWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728835685; c=relaxed/simple;
	bh=J9ytW0yYtK0d2y28INGlpMNqMbENvamTFIUIHD+U8jA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Yyi/ILJx2y3vnWvv1VKHFx6Xi35Cm/KtiKwhgEfJcjaE6irtKkW095diV39p/0KnoqwXeCzjA1J2G8KEZXD83ySWy3R0hzmAbMsVPnvjSsBtWWicR4ezawRkzU4Co1N1VvmNv66NeV2lef+JBUe7W+bRhx+tzGVh4IIOBSxELtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3a6afd01eso27205585ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 09:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728835682; x=1729440482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ikrtxkf2WWvsBECTnbcnMW6mXXhsa0PYGQaLwwh8nyI=;
        b=arfuJIN3IGaakOPS2koizULkWTXtnQA65proXD1euDgMdPT3zxhOvnUMqQzG+9vtOy
         58pmtrOucWhJHxZpdLvtDQz1Nbfa5Q5vSLGZMMIH+eBX81VnHgLoz4jGmrknIyiNOSUs
         ceNxsbVdtDHnB46xa4AzPna9yunzD0KxRzYmBnG5GppS4P2NQKaF9rMTggofFjFHlZcM
         n0E9AkNwiCgZwMPXXj0orYtbawpvgXkXCKn0y4+zZAJK8cWwqTBn7tATSRMjdZRwoZcU
         CwQEwpAZBtMUURrvlrKp4jSlTJaA3sIKrNJ0o8LNa8suSnZUOk/PD06thsLW3L/09qoV
         5a8g==
X-Forwarded-Encrypted: i=1; AJvYcCUQV1e3FCNZl0bacAM6+PhGYEu45T40CQtR7lgbx3LLOamQK6BvgRk6ZSlkpXIaLQwX1MDRoD4SN+zii7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+UrLB41BM5i7jFtgu6u3BJZAp3RuB5ojxSYVgpVtDjHdhideR
	JYMSFxCD5l6yXOdPOFh6B/nCgnPCWpchyVdtZW+EAgWkr1flIU7WPwtWWDpzOPKgK0cqTsHsnZ9
	1fVnP8Ujw7sp0ItsRDQj/v/ZDfuWmRq7J/fzLSY+6U8l0PuMYIjO0Sj0=
X-Google-Smtp-Source: AGHT+IGzcAGKbZjorkL2XMRfzRkPghTWl7NFHwugNuq+TnOLnUSfToHh/Ku2XrWx8WLyXkDu1MTPhxNBpKJNNLVoBi0ThV5qqoV8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4a3:b0:3a3:c07e:e21b with SMTP id
 e9e14a558f8ab-3a3c07ee30amr22302595ab.1.1728835682703; Sun, 13 Oct 2024
 09:08:02 -0700 (PDT)
Date: Sun, 13 Oct 2024 09:08:02 -0700
In-Reply-To: <d21ac7f8-ab23-4b37-80f6-43836bbdbf12@nvidia.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670bf062.050a0220.4cbc0.0033.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: cmeiohas@nvidia.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: workqueue leaked atomic, lock or RCU: kworker/NUM:NUM[NUM]

BUG: workqueue leaked atomic, lock or RCU: kworker/1:5[6129]
     preempt=0x00000000 lock=0->1 RCU=0->0 workfn=smc_ib_port_event_work
1 lock held by kworker/1:5/6129:
 #0: ffffffff8fcd1d48 (rtnl_mutex){+.+.}-{3:3}, at: ib_get_eth_speed+0x13c/0x800 drivers/infiniband/core/verbs.c:1991
CPU: 1 UID: 0 PID: 6129 Comm: kworker/1:5 Not tainted 6.12.0-rc2-syzkaller-00002-g615b94746a54-dirty #0
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
6.12.0-rc2-syzkaller-00002-g615b94746a54-dirty #0 Not tainted
------------------------------------------------------
kworker/1:5/6129 is trying to acquire lock:
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

1 lock held by kworker/1:5/6129:
 #0: ffffffff8fcd1d48 (rtnl_mutex){+.+.}-{3:3}, at: ib_get_eth_speed+0x13c/0x800 drivers/infiniband/core/verbs.c:1991

stack backtrace:
CPU: 1 UID: 0 PID: 6129 Comm: kworker/1:5 Not tainted 6.12.0-rc2-syzkaller-00002-g615b94746a54-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events psi_avgs_work
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
BUG: workqueue leaked atomic, lock or RCU: kworker/1:5[6129]
     preempt=0x00000000 lock=1->0 RCU=0->0 workfn=psi_avgs_work
INFO: lockdep is turned off.
CPU: 1 UID: 0 PID: 6129 Comm: kworker/1:5 Not tainted 6.12.0-rc2-syzkaller-00002-g615b94746a54-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events psi_avgs_work
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

commit:         615b9474 RDMA/hns: Disassociate mmap pages for all uct..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=131e8727980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17f7085f980000


