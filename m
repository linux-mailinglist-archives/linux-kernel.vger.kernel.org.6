Return-Path: <linux-kernel+bounces-357665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA889973E7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A0C1F24658
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888B71E1023;
	Wed,  9 Oct 2024 18:00:30 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD44D1E008C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496829; cv=none; b=NLB2AOORtf2An8pEtYzftRy+moYHh0dTp2hkoQPSmW5oivdxDJ6g8eKliTB0nXusbToDNvZFlqoaLrunRiSbTGa+TbAILKxHtbuSpR174qCeJ4b2L/HPmiudY3CEBEJf+1AyNnt9vGZN2y/n67Cvl/YvqtUi+avpfrYj4YUGgp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496829; c=relaxed/simple;
	bh=IFoqwa1/1Gg2K7bZVpb4Vo1YKSRiIH1ZNWK+ljqf70E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m7OB2HgwCSlSmd8CRvGOLg+q0Tx56eqVoQy1cYBtxIHbuchC/nR3jDP1SfaolcLR+u6WlvsLLkFNcB82n5ILMiHaaNNzP3J4W7Tqd5+Y3OFNSf1EDHWsl4cTN5HKUDH3td/VTrnidtbt4XVzPrWG25hMUOG6fnK3aXf0lG0XlWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3a5f6cb13so1287705ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 11:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496827; x=1729101627;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jr/MdrpLpBD/eClP0lIYmtPI+VljGd5WOOh81utehfw=;
        b=ltEx6L+q4hmwptVM4/sSj95SgngfxOvgwspXx9UgmsHORN6JwbnyzSExRRkmINHPzA
         kB+nn4EgWgcBjNCi8kDQgJwLg84dIiS1dAVeN70EjrQ0M5Q9O8ZIeGiw/JqE1mB9V7p6
         i1D4rOqDVrkyqUHHA8t5/+OCu0rjndNyUpehkj26asgsYAYF6YwRL+qvq1tReRuIp8KB
         E00KBCC3tVYf+yjPK34Q2vKAT7BuvjACGdzxcp/lXrGL/CZGE+rK7+TMXDpE22QnjbBd
         jy30GOQkP1myJLFubDXnFoXC20j4Rs3Q/ilo3Y8rVKkkP3XoUmefYDaPoi/wVga/E8sT
         Xc4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOvUkFcnmcAxG4qlPJfNGbGUABLaj79DNARxdlBne5yKByRMGi3s2dr3oLsjya2FPmbvnZ3888dEYIU/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3yTa/7MMYcrhUhMcD4QnM2iOPZgdP31SRmi4dR7VROGRYxGy/
	KVlwmN9KSA5lYBZtvZ6koktHlujfReZr3fHKJHXbpEY5YLMW+4yUfzEh1ktdwLS29KOAI7juOVa
	NjvnslxZ5plpWpKk7yjKoN1rqaAtKWoMh8VR3yf2WGBxWtvtmbUUjt4I=
X-Google-Smtp-Source: AGHT+IEYAXXPxDgrt3w9fuyzgMilCUyXfa73QhT6MS2R3+fKeOFELjk7cdjRGpp/0/LWLsUQrTDG52oIYrrs3uXNovxU9LDiXCtZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219b:b0:3a0:aa6c:8a51 with SMTP id
 e9e14a558f8ab-3a397ce58d8mr32918535ab.8.1728496826750; Wed, 09 Oct 2024
 11:00:26 -0700 (PDT)
Date: Wed, 09 Oct 2024 11:00:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6706c4ba.050a0220.1139e6.0008.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: task hung in worker_attach_to_pool (2)
From: syzbot <syzbot+8b08b50984ccfdd38ce2@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    87d6aab2389e Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e41780580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
dashboard link: https://syzkaller.appspot.com/bug?extid=8b08b50984ccfdd38ce2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2a469cdf081f/disk-87d6aab2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/782fd2d1cfc7/vmlinux-87d6aab2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/450f9a610cbe/bzImage-87d6aab2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8b08b50984ccfdd38ce2@syzkaller.appspotmail.com

INFO: task kworker/R-wg-cr:9362 blocked for more than 159 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00006-g87d6aab2389e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/R-wg-cr state:D stack:27704 pid:9362  tgid:9362  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 worker_attach_to_pool+0x31/0x390 kernel/workqueue.c:2669
 rescuer_thread+0x3ed/0x10a0 kernel/workqueue.c:3471
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/R-wg-cr:11253 blocked for more than 160 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00006-g87d6aab2389e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/R-wg-cr state:D stack:28720 pid:11253 tgid:11253 ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 worker_detach_from_pool kernel/workqueue.c:2727 [inline]
 rescuer_thread+0xaf5/0x10a0 kernel/workqueue.c:3526
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
6 locks held by kworker/u8:1/12:
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000117d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000117d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcc51d0 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:580
 #3: ffff88807a5d50e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88807a5d50e8 (&dev->mutex){....}-{3:3}, at: devl_dev_lock net/devlink/devl_internal.h:108 [inline]
 #3: ffff88807a5d50e8 (&dev->mutex){....}-{3:3}, at: devlink_pernet_pre_exit+0x13b/0x440 net/devlink/core.c:506
 #4: ffff88807a5d3250 (&devlink->lock_key#21){+.+.}-{3:3}, at: devl_lock net/devlink/core.c:276 [inline]
 #4: ffff88807a5d3250 (&devlink->lock_key#21){+.+.}-{3:3}, at: devl_dev_lock net/devlink/devl_internal.h:109 [inline]
 #4: ffff88807a5d3250 (&devlink->lock_key#21){+.+.}-{3:3}, at: devlink_pernet_pre_exit+0x14d/0x440 net/devlink/core.c:506
 #5: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: unregister_netdevice_notifier_net+0x89/0x3a0 net/core/dev.c:1917
1 lock held by khungtaskd/30:
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
3 locks held by kworker/u8:2/35:
 #0: ffff88814b80d148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88814b80d148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000ab7d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000ab7d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4196
6 locks held by kworker/1:3/1567:
3 locks held by kworker/u8:8/2501:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90009447d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90009447d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
2 locks held by getty/4987:
 #0: ffff88803243a0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031332f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
4 locks held by kworker/1:4/5280:
3 locks held by kworker/u8:14/7636:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc9000317fd00 ((work_completion)(&pool->idle_cull_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000317fd00 ((work_completion)(&pool->idle_cull_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8e7e23a8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: idle_cull_fn+0xd5/0x760 kernel/workqueue.c:2951
1 lock held by kworker/R-wg-cr/9362:
 #0: ffffffff8e7e23a8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_attach_to_pool+0x31/0x390 kernel/workqueue.c:2669
1 lock held by kworker/R-wg-cr/9371:
1 lock held by kworker/R-wg-cr/9910:
 #0: ffffffff8e7e23a8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_detach_from_pool kernel/workqueue.c:2727 [inline]
 #0: ffffffff8e7e23a8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_thread+0xaf5/0x10a0 kernel/workqueue.c:3526
1 lock held by kworker/R-wg-cr/10373:
 #0: ffffffff8e7e23a8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_attach_to_pool+0x31/0x390 kernel/workqueue.c:2669
1 lock held by kworker/R-wg-cr/11251:
 #0: ffffffff8e7e23a8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_detach_from_pool kernel/workqueue.c:2727 [inline]
 #0: ffffffff8e7e23a8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_thread+0xaf5/0x10a0 kernel/workqueue.c:3526
1 lock held by kworker/R-wg-cr/11253:
 #0: ffffffff8e7e23a8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_detach_from_pool kernel/workqueue.c:2727 [inline]
 #0: ffffffff8e7e23a8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: rescuer_thread+0xaf5/0x10a0 kernel/workqueue.c:3526
1 lock held by kworker/1:0/11551:
 #0: ffffffff8e7e23a8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: set_pf_worker kernel/workqueue.c:3316 [inline]
 #0: ffffffff8e7e23a8 (wq_pool_attach_mutex){+.+.}-{3:3}, at: worker_thread+0x5c/0xd30 kernel/workqueue.c:3342
2 locks held by syz-executor/11660:
 #0: ffffffff8fcc51d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: mpls_net_exit+0x7d/0x2a0 net/mpls/af_mpls.c:2706
2 locks held by syz-executor/11664:
 #0: ffffffff8fcc51d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: fib6_rules_net_exit_batch+0x20/0xc0 net/ipv6/fib6_rules.c:547
2 locks held by syz-executor/11665:
 #0: ffffffff8fcc51d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: cangw_pernet_exit_batch+0x20/0x90 net/can/gw.c:1257
3 locks held by syz-executor/11667:
 #0: ffffffff8fcc51d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: default_device_exit_batch+0xe9/0xaa0 net/core/dev.c:11934
 #2: ffffffff8e7d1dd0 (cpu_hotplug_lock){++++}-{0:0}, at: flush_all_backlogs net/core/dev.c:6025 [inline]
 #2: ffffffff8e7d1dd0 (cpu_hotplug_lock){++++}-{0:0}, at: unregister_netdevice_many_notify+0x5ea/0x1da0 net/core/dev.c:11384
2 locks held by syz-executor/11669:
 #0: ffffffff8fcc51d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: ppp_exit_net+0xe3/0x3d0 drivers/net/ppp/ppp_generic.c:1146
1 lock held by syz-executor/11675:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/11679:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/11684:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/11687:
 #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: __tun_chr_ioctl+0x48c/0x2400 drivers/net/tun.c:3121
2 locks held by syz-executor/11691:
 #0: ffffffff8fcc51d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: wg_netns_pre_exit+0x1f/0x1e0 drivers/net/wireguard/device.c:414

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc2-syzkaller-00006-g87d6aab2389e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 1567 Comm: kworker/1:3 Not tainted 6.12.0-rc2-syzkaller-00006-g87d6aab2389e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: wg-crypt-wg0 wg_packet_tx_worker
RIP: 0010:kasan_mem_to_shadow include/linux/kasan.h:61 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:130 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x4f/0x290 mm/kasan/generic.c:189
Code: 89 fd 48 c1 ed 2f 81 fd fe ff 01 00 0f 86 43 02 00 00 48 89 fb 48 c1 eb 03 49 ba 00 00 00 00 00 fc ff df 4e 8d 1c 13 49 ff c8 <4d> 89 c1 49 c1 e9 03 49 be 01 00 00 00 00 fc ff df 4f 8d 3c 31 4c
RSP: 0018:ffffc90000a18970 EFLAGS: 00000092
RAX: 0000000000000001 RBX: 1ffffffff2039da5 RCX: ffffffff81707ce0
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff901ced28
RBP: 000000000001ffff R08: ffffffff901ced2f R09: 1ffffffff2858b1d
R10: dffffc0000000000 R11: fffffbfff2039da5 R12: 1ffff92000143140
R13: ffffffff89955c8b R14: dffffc0000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f00ea51ad58 CR3: 000000000e734000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 cpumask_test_cpu include/linux/cpumask.h:570 [inline]
 cpu_online include/linux/cpumask.h:1117 [inline]
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0xb0/0xa30 kernel/locking/lockdep.c:5836
 local_lock_release include/linux/local_lock_internal.h:38 [inline]
 process_backlog+0x1014/0x15b0 net/core/dev.c:6138
 __napi_poll+0xcb/0x490 net/core/dev.c:6775
 napi_poll net/core/dev.c:6844 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6966
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 wg_socket_send_skb_to_peer+0x176/0x1d0 drivers/net/wireguard/socket.c:184
 wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
 wg_packet_tx_worker+0x1bf/0x810 drivers/net/wireguard/send.c:276
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

