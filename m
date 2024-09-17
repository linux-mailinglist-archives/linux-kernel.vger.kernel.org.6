Return-Path: <linux-kernel+bounces-331311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B04D797AB26
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5063E283B56
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF32171750;
	Tue, 17 Sep 2024 05:45:35 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7608487A5
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551935; cv=none; b=j7QokKNdGrvXmtXQdFU5h8APWSmmg42ueTI7N7O4Uw3btBtT/stnPwRQiuX3Hf4v+UHxSYqCJ4Pt4p/eN3vEHoqn+wUNs/gdOGn7LCqhgKw2CIS1qXdg1o6A5596YzXx5cea7ok6VDN9ACweqQQ3QI6pPGdUclW3SgrNmvz77B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551935; c=relaxed/simple;
	bh=csFqw64WBuOIsEUmDM31UEWn8gpgZK+XW3ny2cXL9Gg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UZ456XB4Fad/WOvuGykbXEnZJUjf1SdpmMrbg9xlhCjxf0JYYCmS0XAutpckM6QhkFdKqytbBdbnKMGJhrC6h4QqaEargF+TASd9s+oofJkgw7fN0GUbRaszFeEFAg7hRC2FIA79aHd0kTC+KIcyZOksQrVmxspvGcEMquP3/Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f56ac8d88so97007605ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726551933; x=1727156733;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSISZFPt1DMRK9FWGCFp+8EgpLRhYoSd6yiUqgNLGJk=;
        b=pxDIglFhXtg8J7sFQ8n7ygIVZehh3KEfv1wGAe40GDkWDaG2Qg24YuzOpqkDmHSPiP
         uiv4W5eWlMRGNj6zO27ju7xvZVUo3ReFZlKYAfqWy86vkmESftpj7BDjM79rLP3TlFqX
         iAV3Su4Ldu5k810CVFaWxCJPZEQyxUcp4p3HzhUHM4cY1iVxQnW1FIpNprXR0u7oEzbF
         11BdLTeEIdUxyrDtcie+zN894Czb18+5hNJkVxFGso7AZMFJBQaYmiZoTjzLCbdVH/9v
         PyL74rIzfeVOKZ2N0vX8KXG5D6YOOm2lTtocLNOZeTWSQIJ9JAbTh8BpbWiTFJVTDYRG
         XEyA==
X-Forwarded-Encrypted: i=1; AJvYcCXYLGnAKqXqgpm31X+4ENviEo3VXcZkS7tJGTRGJwEGvLo2LyJPuyzuU2vVTx617QMA8ASMYZciOKvvQH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym46NfJawYDRSsGdkK2usvCMBX6lUglPzPiInG3Inploc9Ge+O
	CAJfnkzynjtiphc0yHFI0tx9q2ZBlBgd7JDQGOZ/5WrC57y7LfLMXqiiOGHu+bV/u7Xh2s1dQaR
	k3kkcFpYyECQBUckkRqdpIW8Ekki25BIzE9dmWg4X0Ns5sXVwe3yIHEA=
X-Google-Smtp-Source: AGHT+IEDZKe47BeQM1QLFvIlrWeSC0EEriXjB+NKFGJxlCeboZBvkR2G4LussXSeSAu4lFHelfhCuuxt5g/U35FwHytd7UUSBnu1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc5:b0:3a0:9b0c:6b2c with SMTP id
 e9e14a558f8ab-3a09b0c6c78mr77571855ab.18.1726551932764; Mon, 16 Sep 2024
 22:45:32 -0700 (PDT)
Date: Mon, 16 Sep 2024 22:45:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a39cfa06224a32bd@google.com>
Subject: [syzbot] [usb?] INFO: task hung in adu_disconnect
From: syzbot <syzbot+c3664338662d943b2dc1@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    68d4209158f4 sub: cdns3: Use predefined PCI vendor ID cons..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=11bcdfc7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb61872d4d8c5df9
dashboard link: https://syzkaller.appspot.com/bug?extid=c3664338662d943b2dc1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c69290425359/disk-68d42091.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/caf4f26a3e85/vmlinux-68d42091.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3acdec4b62e6/bzImage-68d42091.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c3664338662d943b2dc1@syzkaller.appspotmail.com

INFO: task kworker/1:4:4945 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc7-syzkaller-00152-g68d4209158f4 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:4     state:D stack:21728 pid:4945  tgid:4945  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xcda/0x2f80 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 adu_disconnect+0xb2/0x1c0 drivers/usb/misc/adutux.c:770
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:568 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:560
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x396/0x9f0 drivers/base/core.c:3871
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff88ebb660 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff88ebb660 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff88ebb660 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6626
5 locks held by kworker/0:2/803:
 #0: ffff8881066c7548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc90001a4fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffff888109f54190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff888109f54190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff88812b04c190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff88812b04c190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1004
 #4: ffff888115b42160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff888115b42160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1004
2 locks held by getty/2605:
 #0: ffff8881092ad0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc8/0x1490 drivers/tty/n_tty.c:2211
4 locks held by udevd/4897:
 #0: ffff88812b7e2540 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xde/0x12c0 fs/seq_file.c:182
 #1: ffff888113ed5088 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff888112aa41e8 (kn->active#23){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff88812b04c190 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:1014 [inline]
 #3: ffff88812b04c190 (&dev->mutex){....}-{3:3}, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142
5 locks held by kworker/0:3/4910:
6 locks held by kworker/1:4/4945:
 #0: ffff8881066c7548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc9000459fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffff888109b69190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff888109b69190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff88811be2f190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff88811be2f190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff88811bf27160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff88811bf27160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1094 [inline]
 #4: ffff88811bf27160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1292
 #5: ffffffff89ad38c8 (adutux_mutex){+.+.}-{3:3}, at: adu_disconnect+0xb2/0x1c0 drivers/usb/misc/adutux.c:770
1 lock held by syz.2.2288/12545:
 #0: ffffffff89ad38c8 (adutux_mutex){+.+.}-{3:3}, at: adu_release+0xcf/0x720 drivers/usb/misc/adutux.c:323
2 locks held by syz.2.3518/18964:
 #0: ffffffff899b0110 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x27/0x2f0 drivers/usb/core/file.c:38
 #1: ffffffff89ad38c8 (adutux_mutex){+.+.}-{3:3}, at: adu_open+0x5d/0x820 drivers/usb/misc/adutux.c:236
2 locks held by syz.2.3518/18965:
 #0: ffffffff899b0110 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x27/0x2f0 drivers/usb/core/file.c:38
 #1: ffffffff89ad38c8 (adutux_mutex){+.+.}-{3:3}, at: adu_open+0x5d/0x820 drivers/usb/misc/adutux.c:236
1 lock held by syz.4.3520/18970:
 #0: ffffffff88ec6df8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x1a4/0x3b0 kernel/rcu/tree_exp.h:328
1 lock held by syz.3.3521/18971:
 #0: ffffffff88ec6df8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x282/0x3b0 kernel/rcu/tree_exp.h:296

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-rc7-syzkaller-00152-g68d4209158f4 #0
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:111


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

