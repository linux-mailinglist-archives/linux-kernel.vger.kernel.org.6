Return-Path: <linux-kernel+bounces-330129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E26B979A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9546FB228D9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 03:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFA01BC58;
	Mon, 16 Sep 2024 03:23:27 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F9A182B3
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 03:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726457006; cv=none; b=H0qlvoySgxjw3QZV1L1sNk/ZWmX01hX4o/Vcr4rhuTHI3RqSdrJ/DegIBXdN3rfSqP4rL3dic7QGaYlvr6UL5SVNkfCAAv+2S36Joz8o2rm71G0fxOa0jhBYktYDKmn2gEpb1RjrJeFNHMcuxUBOJP1QHN611KKlAKhvYShwwyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726457006; c=relaxed/simple;
	bh=VibD6HY9je8jIuwU0sJaTGpgUL6wWtap8moAWHxGHs0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GZJHFxBSDcehut5vyp2ZKoCRW6oOlYoqw63KNU4uR7FFmUN5aJyrNRZadK2Mir0sXbMKLWv+A53byaSjG1Zmvvmb5ARD1pJBUaDhy7xz1aqwjOcvchV11tauZeYDx6FJ4tsa6btvTU0A8URgGRSbBfoC1PNy018WiUgQkw3EWJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a08d90c938so64624675ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 20:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726457004; x=1727061804;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3rLRvmOrMdpMV+QZrTlf9pWW8Zrc/5oNuA0IZL71HU=;
        b=lowrMJJ/Uxw9Yx5rYRSkbuHD8+2YaA6lN66X5VJfQeUr7XzT34VnepPx4UdM5wGflV
         WtZJBc9+/dMAloxAQAbOX/nKBu79JCarzuyhUMUHY86CbvjTWf6nnY0BzKdJn5iYFLPP
         RPG4KNn0G+h/rSQAaWoMiY6F5v86YIWjRPR8IY/H6AWzE6lv5ACUFyMkClBPCX/ClfJF
         piXY8DPk2RYhs89/Lq3O52QUoDRsWJ9vKLkycUWz3lSgk6iwkRoIU8xB0Lzia+avWr9j
         WpGqIotnBXlYewB7PQhw8oAkDCIKlIuArMoA+bgk9UgtFQ0AkYE7gbGd1brXtM06icw7
         6Pog==
X-Forwarded-Encrypted: i=1; AJvYcCVoASPv3pqqhOhoVgGGHhFZYheeviSFrVclfNcjslYvrRlmZ9/H4VEpbxMRtBSW/PIu0JeUhEuRbuZXvfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf54N5ODpktSMQeyQJ8koNJvyAX+7ZyxiYNi/ObN66A8SCIiBI
	hzLQcRewgfi4KtzOfLQGIb1bh0CIgyOfSE/GC0fgEzGzV0mDlWYpXhrk1CUHjhmFS5Li/JiMzAF
	uzxYM7uevHLiKK3Z8aBXdTAl59UMKetcH1x21v6VDPD/rtywPAxlc2y4=
X-Google-Smtp-Source: AGHT+IHinGaYL9IlnMAywuS2HK9s1WW+R+yef+POeT2gOL7kUYRbW0+gN7Uk9w3ng8+pXJUFU96W6c3YZ20TJLLdATvUpxeg2+5A
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c543:0:b0:3a0:aa6c:8a51 with SMTP id
 e9e14a558f8ab-3a0aa6c8d97mr803715ab.8.1726457004081; Sun, 15 Sep 2024
 20:23:24 -0700 (PDT)
Date: Sun, 15 Sep 2024 20:23:24 -0700
In-Reply-To: <000000000000227d2c061c54ff82@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072d8d30622341821@google.com>
Subject: Re: [syzbot] [net?] WARNING: suspicious RCU usage in dev_activate
From: syzbot <syzbot+2120b9a8f96b3fa90bad@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, hdanton@sina.com, 
	jhs@mojatatu.com, jiri@resnulli.us, johannes.berg@intel.com, 
	johannes@sipsolutions.net, jv@jvosburgh.net, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d42f7708e27c Merge tag 'for-linus-6.11' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1187229f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61d235cb8d15001c
dashboard link: https://syzkaller.appspot.com/bug?extid=2120b9a8f96b3fa90bad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c828a9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1587229f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/92f659e09436/disk-d42f7708.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1e3b5ab99922/vmlinux-d42f7708.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1c82035e4680/bzImage-d42f7708.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2120b9a8f96b3fa90bad@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.11.0-rc7-syzkaller-00151-gd42f7708e27c #0 Not tainted
-----------------------------
net/sched/sch_generic.c:1250 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by kworker/u8:14/3029:
 #0: ffff88807741a948 ((wq_completion)bond0#3){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88807741a948 ((wq_completion)bond0#3){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc9000a2c7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc9000a2c7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0x174/0x3170 drivers/net/bonding/bond_main.c:2863

stack backtrace:
CPU: 1 UID: 0 PID: 3029 Comm: kworker/u8:14 Not tainted 6.11.0-rc7-syzkaller-00151-gd42f7708e27c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: bond0 bond_mii_monitor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6724
 dev_activate+0xf8/0x1240 net/sched/sch_generic.c:1250
 linkwatch_do_dev+0xfb/0x170 net/core/link_watch.c:173
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:799
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2643 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2865
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x870/0xd30 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

=============================
WARNING: suspicious RCU usage
6.11.0-rc7-syzkaller-00151-gd42f7708e27c #0 Not tainted
-----------------------------
net/sched/sch_generic.c:1228 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by kworker/u8:14/3029:
 #0: ffff88807741a948 ((wq_completion)bond0#3){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88807741a948 ((wq_completion)bond0#3){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc9000a2c7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc9000a2c7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0x174/0x3170 drivers/net/bonding/bond_main.c:2863

stack backtrace:
CPU: 0 UID: 0 PID: 3029 Comm: kworker/u8:14 Not tainted 6.11.0-rc7-syzkaller-00151-gd42f7708e27c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: bond0 bond_mii_monitor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6724
 transition_one_qdisc+0x8e/0x1c0 net/sched/sch_generic.c:1228
 netdev_for_each_tx_queue include/linux/netdevice.h:2513 [inline]
 dev_activate+0x838/0x1240 net/sched/sch_generic.c:1258
 linkwatch_do_dev+0xfb/0x170 net/core/link_watch.c:173
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:799
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2643 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2865
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x870/0xd30 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

=============================
WARNING: suspicious RCU usage
6.11.0-rc7-syzkaller-00151-gd42f7708e27c #0 Not tainted
-----------------------------
include/linux/rtnetlink.h:100 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by kworker/u8:14/3029:
 #0: ffff88807741a948 ((wq_completion)bond0#3){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88807741a948 ((wq_completion)bond0#3){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc9000a2c7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc9000a2c7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0x174/0x3170 drivers/net/bonding/bond_main.c:2863

stack backtrace:
CPU: 1 UID: 0 PID: 3029 Comm: kworker/u8:14 Not tainted 6.11.0-rc7-syzkaller-00151-gd42f7708e27c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: bond0 bond_mii_monitor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6724
 dev_ingress_queue include/linux/rtnetlink.h:100 [inline]
 dev_activate+0x925/0x1240 net/sched/sch_generic.c:1259
 linkwatch_do_dev+0xfb/0x170 net/core/link_watch.c:173
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:799
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2643 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2865
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x870/0xd30 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1525
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 3029, name: kworker/u8:14
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u8:14/3029:
 #0: ffff88807741a948 ((wq_completion)bond0#3){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88807741a948 ((wq_completion)bond0#3){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc9000a2c7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc9000a2c7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0x174/0x3170 drivers/net/bonding/bond_main.c:2863
CPU: 0 UID: 0 PID: 3029 Comm: kworker/u8:14 Not tainted 6.11.0-rc7-syzkaller-00151-gd42f7708e27c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: bond0 bond_mii_monitor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 __might_resched+0x5d4/0x780 kernel/sched/core.c:8463
 down_read+0x8e/0xa40 kernel/locking/rwsem.c:1525
 wireless_nlevent_flush net/wireless/wext-core.c:351 [inline]
 wext_netdev_notifier_call+0x1f/0x120 net/wireless/wext-core.c:371
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 netdev_state_change+0x11f/0x1a0 net/core/dev.c:1376
 linkwatch_do_dev+0x112/0x170 net/core/link_watch.c:177
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:799
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2643 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2865
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x870/0xd30 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.11.0-rc7-syzkaller-00151-gd42f7708e27c #0 Tainted: G        W         
-----------------------------
kworker/u8:14/3029 is trying to lock:
ffffffff8fc7f690 (net_rwsem){++++}-{3:3}, at: wireless_nlevent_flush net/wireless/wext-core.c:351 [inline]
ffffffff8fc7f690 (net_rwsem){++++}-{3:3}, at: wext_netdev_notifier_call+0x1f/0x120 net/wireless/wext-core.c:371
other info that might help us debug this:
context-{4:4}
3 locks held by kworker/u8:14/3029:
 #0: ffff88807741a948 ((wq_completion)bond0#3){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88807741a948 ((wq_completion)bond0#3){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc9000a2c7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc9000a2c7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #2: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0x174/0x3170 drivers/net/bonding/bond_main.c:2863
stack backtrace:
CPU: 0 UID: 0 PID: 3029 Comm: kworker/u8:14 Tainted: G        W          6.11.0-rc7-syzkaller-00151-gd42f7708e27c #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: bond0 bond_mii_monitor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4750 [inline]
 check_wait_context kernel/locking/lockdep.c:4820 [inline]
 __lock_acquire+0x153b/0x2040 kernel/locking/lockdep.c:5092
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
 wireless_nlevent_flush net/wireless/wext-core.c:351 [inline]
 wext_netdev_notifier_call+0x1f/0x120 net/wireless/wext-core.c:371
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 netdev_state_change+0x11f/0x1a0 net/core/dev.c:1376
 linkwatch_do_dev+0x112/0x170 net/core/link_watch.c:177
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:799
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2643 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2865
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x870/0xd30 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
bond0: (slave bridge0): link status definitely down, disabling slave
wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

