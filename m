Return-Path: <linux-kernel+bounces-342026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0722B9889C4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455D11F21F44
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329831C1AB6;
	Fri, 27 Sep 2024 17:48:35 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A4618872F
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727459314; cv=none; b=nqXyXISRLXSMx006mNMeJeDP1i11sxMq2FgoWGme192O5GboUwbJue4Gr1vghIUsbuNPIOYslXBf3H4+lIZwEMjfMa1gSn5WsyUCSYsvfJk/0fC+1V5pz75ySPL4vBJS+rupy0WIkCQEAD4pMoriMAj/bktdPhy2RljcTF9liS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727459314; c=relaxed/simple;
	bh=ztac8O1sSzFmYHWh2zIRWsnSmbF7nwIemOlK+AhBdeY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=i6vrEREv51SDu2aN7hTueDF0PfXIp2v88mi1IcJXo4kBOkFx6i0C/V3NLvZCo79ndGLT4Wv7ncPkg5RGXfc23MewcJiNXjzjh29ZD3Da0qOP0276yOkAW/SG8swT3iWewduGyEPtexzt52T7wpM/QLTFoe59Mo4yjtwu+veIxIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aa94d4683so272817939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 10:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727459311; x=1728064111;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+UdMraZqBB22ziEIYg9bJwW47IjAaSCKOBlRA9X7Tk=;
        b=kxXjctTYydh+wHox+7RCsvF8nSsu1hBAIPPQWd31Gp8x4ClvomJ1Ui3RwBRQg8S5gN
         7/TamOHp6OBKZkbsW8fnvAKfkcNZhQT/eFI6HGmisrbFiRgj+HSWabOFqlqGDifyY+HT
         r5ggar1CJrD5YvGQaXCsBODBC0jvUqlR7Ef7dPPc1Lk7YLCxMujS0jHhb7hu86E9WJv4
         DIwJabmNDWuArnJhU6Ez3+ysHbZuup6hsTFnpJU8vWWNKMD4nbtjuLhUcp/pYG0RzuxV
         o+PnrDy9ZfS7j/vNWR7Bn/mAdCovpO/3k3dqlvPkCRFa4vMlremakzIognh082aVJgew
         688A==
X-Forwarded-Encrypted: i=1; AJvYcCXu4zf93xLvSTQzprt1Z6FyoBqsR6FLuDXoMV3X+kibxMjtehWQ9mx7BtcHn5EPNm+Q+BnOf+NZb9AaJaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7WSLZ8d+7+cxevA5UKliPWpJ0QdULIwGSvNOp14Usl6pbN+sc
	egcmwMbDWxBPlO9RZ12JpGTCedBG3TOPsAVusgds5oqz4B5fI3Q5r2hmKx5EI3+GDp8H8xp3xpJ
	+tSkFSKPkXTz8bCN5yD1uJB4onYiuP01ijau3GWdKRFv3hltxYqBKxAs=
X-Google-Smtp-Source: AGHT+IGhPZs4nozN0MTfrb1MTofdvrVDGppeFWyuEblDbErHkd+3wo5yl/+DhX6HxpoV0ikd0DiShLLX3urBz95KL0X+NWpOivX8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6c:b0:3a0:98e9:1b7a with SMTP id
 e9e14a558f8ab-3a34514af43mr34259175ab.2.1727459310999; Fri, 27 Sep 2024
 10:48:30 -0700 (PDT)
Date: Fri, 27 Sep 2024 10:48:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6efee.050a0220.46d20.0023.GAE@google.com>
Subject: [syzbot] [usb?] INFO: task hung in usb_register_dev (2)
From: syzbot <syzbot+a194ded97ce38690073f@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d42f7708e27c Merge tag 'for-linus-6.11' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12fbc8a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28869f34c32848cf
dashboard link: https://syzkaller.appspot.com/bug?extid=a194ded97ce38690073f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b480e63737cd/disk-d42f7708.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b890f2b9af0c/vmlinux-d42f7708.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dc0557124365/bzImage-d42f7708.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a194ded97ce38690073f@syzkaller.appspotmail.com

INFO: task kworker/1:5:5290 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc7-syzkaller-00151-gd42f7708e27c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:5     state:D stack:22080 pid:5290  tgid:5290  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 rwsem_down_write_slowpath+0x539/0x12a0 kernel/locking/rwsem.c:1178
 __down_write_common kernel/locking/rwsem.c:1306 [inline]
 __down_write kernel/locking/rwsem.c:1315 [inline]
 down_write+0x1d8/0x200 kernel/locking/rwsem.c:1580
 usb_register_dev+0x11c/0x550 drivers/usb/core/file.c:134
 usbtmc_probe+0xdbf/0x1b10 drivers/usb/class/usbtmc.c:2461
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3682
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3682
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d9a/0x4e10 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz.1.3995:16435 blocked for more than 145 seconds.
      Not tainted 6.11.0-rc7-syzkaller-00151-gd42f7708e27c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.3995      state:D
 stack:28256 pid:16435 tgid:16434 ppid:13583  flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2557
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3de/0x5f0 kernel/sched/completion.c:116
 __synchronize_srcu+0x1bd/0x2a0 kernel/rcu/srcutree.c:1398
 mn_hlist_release mm/mmu_notifier.c:345 [inline]
 __mmu_notifier_release+0x28b/0x660 mm/mmu_notifier.c:357
 mmu_notifier_release include/linux/mmu_notifier.h:402 [inline]
 exit_mmap+0x9a0/0xb20 mm/mmap.c:3394
 __mmput+0x12a/0x480 kernel/fork.c:1345
 mmput+0x62/0x70 kernel/fork.c:1367
 exit_mm kernel/exit.c:571 [inline]
 do_exit+0x9bf/0x2bb0 kernel/exit.c:869
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 get_signal+0x25fb/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9dd017def9
RSP: 002b:00007f9dd0fd1038 EFLAGS: 00000246
 ORIG_RAX: 0000000000000010
RAX: 0000000000000004 RBX: 00007f9dd0335f80 RCX: 00007f9dd017def9
RDX: 0000000000000000 RSI: 000000000000ae01 RDI: 0000000000000003
RBP: 00007f9dd01f0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9dd0335f80 R15: 00007fff88615a28
 </TASK>

Showing all locks held in the system:
7 locks held by kworker/0:1/9:
6 locks held by kworker/1:0/25:
 #0: 
ffff888021e92948
 (
(wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc900001f7d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffff88802946f190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff88802946f190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: 
ffff8880254ed190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
ffff8880254ed190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1004
 #4: ffff888055689160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff888055689160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1004
 #5: ffffffff8f01fa10 (minor_rwsem#2){++++}-{3:3}, at: usb_register_dev+0x11c/0x550 drivers/usb/core/file.c:134
1 lock held by khungtaskd/30:
 #0: 
ffffffff8ddb9fe0
 (rcu_read_lock
){....}-{1:2}
, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6626
2 locks held by kworker/u8:3/53:
 #0: ffff88801ac89148
 (
(wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc90000be7d80 (connector_reaper_work){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
3 locks held by kworker/u8:8/2464:
 #0: 
ffff88801ac89148
 (
(wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc90008e27d80 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffffffff8fa35ca8 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0x51/0xc0 net/core/link_watch.c:276
3 locks held by kworker/u8:9/2956:
 #0: ffff88802fff3148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: 
ffffc90009837d80
 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffffffff8fa35ca8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x12/0x30 net/ipv6/addrconf.c:4734
2 locks held by kworker/u8:10/2971:
 #0: 
ffff88801ac89148
 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: 
ffffc90009997d80 ((reaper_work).work){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
2 locks held by getty/4983:
 #0: ffff888030c950a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc8/0x1490 drivers/tty/n_tty.c:2211
8 locks held by kworker/0:3/5277:
6 locks held by kworker/1:5/5290:
 #0: ffff888021e92948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc900043a7d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffff888028de5190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff888028de5190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff88806ce32190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff88806ce32190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1004
 #4: 
ffff88807d0ec160
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:1009 [inline]
, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1004
 #5: 
ffffffff8f01fa10 (minor_rwsem#2){++++}-{3:3}, at: usb_register_dev+0x11c/0x550 drivers/usb/core/file.c:134
2 locks held by kworker/0:6/5582:
3 locks held by kworker/0:7/5726:
3 locks held by kworker/1:1/8787:
 #0: 
ffff88801ac80948
 (
(wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc90004727d80 (deferred_process_work){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: 
ffffffff8fa35ca8
 (
rtnl_mutex){+.+.}-{3:3}
, at: switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
5 locks held by kworker/u8:1/9811:
2 locks held by kworker/0:5/10685:
6 locks held by kworker/u9:1/13595:
 #0: 
ffff888032008948 ((wq_completion)hci7){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: 
ffffc90004317d80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: 
ffff888021ef0d80
 (
&hdev->req_lock
){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:327
 #3: ffff888021ef0078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5564
 #4: ffffffff8fc9cc68 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #4: ffffffff8fc9cc68 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1265
 #5: ffffffff8ddc5778 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x282/0x3b0 kernel/rcu/tree_exp.h:296
4 locks held by udevd/13752:
 #0: ffff88801200cc30 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xde/0x12c0 fs/seq_file.c:182
 #1: 
ffff888032b99c88 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff888075a0ef08 (kn->active#23){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff888021a89190
 (
&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:1014 [inline]
&dev->mutex){....}-{3:3}, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142
8 locks held by syz-executor/16451:
 #0: ffff88802e8ac420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:643
 #1: ffff88807b887c88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x281/0x500 fs/kernfs/file.c:325
 #2: ffff8880244074b8 (kn->active#50){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2a4/0x500 fs/kernfs/file.c:326
 #3: 
ffffffff8efcada8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
 #4: 
ffff888030da10e8
 (
&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1094 [inline]
&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1292
 #5: ffff8880216b4250 (&devlink->lock_key#11){+.+.}-{3:3}
, at: nsim_drv_remove+0x4a/0x1d0 drivers/net/netdevsim/dev.c:1672
 #6: 
ffffffff8fa35ca8
 (
rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x6f/0x6a0 drivers/net/netdevsim/netdev.c:773
 #7: ffffffff8dc5dd90
 (cpu_hotplug_lock){++++}-{0:0}, at: flush_all_backlogs net/core/dev.c:6022 [inline]
 (cpu_hotplug_lock){++++}-{0:0}, at: unregister_netdevice_many_notify+0x53b/0x1e40 net/core/dev.c:11334
1 lock held by syz-executor/16494:
 #0: 
ffffffff8fa35ca8
 (
rtnl_mutex
){+.+.}-{3:3}
, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/16517:
 #0: ffffffff8fa35ca8
 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz.3.4037/16541:
 #0: 
ffff88807acfc868
 (&ep->mtx){+.+.}-{3:3}, at: eventpoll_release_file+0xe2/0x1d0 fs/eventpoll.c:1106
2 locks held by syz-executor/16559:
 #0: ffffffff8fa20290
 (pernet_ops_rwsem
){++++}-{3:3}, at: copy_net_ns+0x2d6/0x700 net/core/net_namespace.c:504
 #1: 
ffffffff8fa35ca8
 (
rtnl_mutex){+.+.}-{3:3}, at: ip_tunnel_init_net+0x218/0x780 net/ipv4/ip_tunnel.c:1158
2 locks held by syz-executor/16562:
 #0: ffffffff8fa20290 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x2d6/0x700 net/core/net_namespace.c:504
 #1: ffffffff8fa35ca8 (rtnl_mutex){+.+.}-{3:3}, at: ip_tunnel_init_net+0x218/0x780 net/ipv4/ip_tunnel.c:1158
1 lock held by syz-executor/16567:
 #0: ffffffff8fa35ca8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fa35ca8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/16570:
 #0: ffffffff8fa35ca8
 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/16573:
 #0: 
ffffffff8fa35ca8
 (
rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/16577:
 #0: ffffffff8fa35ca8
 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/16580:
 #0: 
ffffffff8fa35ca8
 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/16588:
 #0: 
ffffffff8fa35ca8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
ffffffff8fa35ca8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/16591:
 #0: ffffffff8fa35ca8 (rtnl_mutex
){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/16594:
 #0: 
ffffffff8fa35ca8
 (
rtnl_mutex){+.+.}-{3:3}
, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-rc7-syzkaller-00151-gd42f7708e27c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf0c/0x1240 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5277 Comm: kworker/0:3 Not tainted 6.11.0-rc7-syzkaller-00151-gd42f7708e27c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: events kfree_rcu_monitor
RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:26 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:182 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0xc/0x70 kernel/kcov.c:216
Code: c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 48 8b 15 b4 0a 78 7e <65> 8b 05 b5 0a 78 7e a9 00 01 ff 00 48 8b 34 24 74 1d f6 c4 01 74
RSP: 0018:ffffc90000006fa8 EFLAGS: 00000046
RAX: 0000000080010103 RBX: ffffffff8b4dac84 RCX: ffffffff8b085350
RDX: ffff88805ff9da00 RSI: 000000000000006c RDI: 0000000000000001
RBP: 0000000000000008 R08: 0000000000000001 R09: 000000000000006c
R10: 000000000000006c R11: 000000000021f1d8 R12: ffffc900000070b0
R13: 000000000000006c R14: 0000000000000075 R15: 0000000000000005
FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2d616ff8 CR3: 000000000db7c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 format_decode+0x980/0xba0 lib/vsprintf.c:2689
 vsnprintf+0x13d/0x1880 lib/vsprintf.c:2776
 sprintf+0xcd/0x110 lib/vsprintf.c:3028
 print_time kernel/printk/printk.c:1330 [inline]
 info_print_prefix+0x25c/0x350 kernel/printk/printk.c:1356
 record_print_text+0x141/0x400 kernel/printk/printk.c:1405
 printk_get_next_message+0x2a6/0x670 kernel/printk/printk.c:2911
 console_emit_next_record kernel/printk/printk.c:2951 [inline]
 console_flush_all+0x3b2/0xd70 kernel/printk/printk.c:3050
 console_unlock+0xae/0x290 kernel/printk/printk.c:3119
 vprintk_emit+0x409/0x600 kernel/printk/printk.c:2348
 dev_vprintk_emit drivers/base/core.c:4912 [inline]
 dev_printk_emit+0xfb/0x140 drivers/base/core.c:4923
 __dev_printk+0xf5/0x270 drivers/base/core.c:4935
 _dev_warn+0xe5/0x120 drivers/base/core.c:4979
 usb_rx_callback_intf0+0x11c/0x1a0 drivers/media/rc/imon.c:1768
 __usb_hcd_giveback_urb+0x389/0x6e0 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x396/0x450 drivers/usb/core/hcd.c:1734
 dummy_timer+0x17c3/0x38d0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x20c/0xcc0 kernel/time/hrtimer.c:1753
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1815
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x10f/0x450 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x43/0xb0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 a6 02 50 f6 48 89 df e8 be 7f 50 f6 f7 c5 00 02 00 00 75 23 9c 58 f6 c4 02 75 37 <bf> 01 00 00 00 e8 e5 f2 41 f6 65 8b 05 76 1d ea 74 85 c0 74 16 5b
RSP: 0018:ffffc90000007f18 EFLAGS: 00000246
RAX: 0000000000000016 RBX: ffff8880b882c9c0 RCX: 1ffffffff2d28485
RDX: 0000000000000000 RSI: ffffffff8b4cd740 RDI: ffffffff8bb0fc00
RBP: 0000000000000286 R08: 0000000000000001 R09: fffffbfff2d248e9
R10: ffffffff9692474f R11: 0000000000000000 R12: 0000000000000001
R13: 0000000080000101 R14: ffffffff8da0a100 R15: 0000000000000000
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:orc_ip arch/x86/kernel/unwind_orc.c:80 [inline]
RIP: 0010:__orc_find+0x52/0x130 arch/x86/kernel/unwind_orc.c:102
Code: ff 89 de 49 8d 6c 86 fc e8 eb ee 4e 00 85 db 0f 84 dd 00 00 00 e8 9e ec 4e 00 4c 39 f5 0f 82 d3 00 00 00 4c 89 f3 4c 89 34 24 <49> be 00 00 00 00 00 fc ff df eb 17 e8 7d ec 4e 00 49 8d 5f 04 4c
RSP: 0018:ffffc900042a7620 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffffff90252cec RCX: ffffffff813ce395
RDX: ffff88805ff9da00 RSI: ffffffff813ce3a2 RDI: 0000000000000005
RBP: ffffffff90252cec R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff81567c34
R13: ffffffff90a6663e R14: ffffffff90252cec R15: ffffc900042a7725
 orc_find arch/x86/kernel/unwind_orc.c:227 [inline]
 unwind_next_frame+0x335/0x23a0 arch/x86/kernel/unwind_orc.c:494
 arch_stack_walk+0x100/0x170 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free_freelist_hook mm/slub.c:2285 [inline]
 slab_free_bulk mm/slub.c:4501 [inline]
 kmem_cache_free_bulk.part.0+0x148/0x390 mm/slub.c:4718
 kfree_bulk include/linux/slab.h:570 [inline]
 kvfree_rcu_bulk+0x454/0x550 kernel/rcu/tree.c:3405
 kvfree_rcu_drain_ready kernel/rcu/tree.c:3579 [inline]
 kfree_rcu_monitor+0x47b/0x12d0 kernel/rcu/tree.c:3597
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored


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

