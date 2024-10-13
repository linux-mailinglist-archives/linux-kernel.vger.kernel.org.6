Return-Path: <linux-kernel+bounces-362955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4277B99BBB1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 22:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B741C20A8E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 20:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE7214F115;
	Sun, 13 Oct 2024 20:34:09 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5565F9460
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 20:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728851648; cv=none; b=PzIrULgPGLDzF5Q8YBij0FgQIYfwEzS1VCpVWQsXIqH+xd2/M8KY8NWBc1Roa36R4Et1ADYIci8DNXQEciSB3ggZUET3WJAeTTQfMGrWU102UJVGbnCW9J52fxDgmYvhu6zotqtogd4fYWx6o5mG5kig8ojUycOlMEQs80QAM+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728851648; c=relaxed/simple;
	bh=Aednf4BiF4W8i6ZXEOYx2rJIwzdtxbE1CNfCyXJq6oE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K/w9CDwr09V126QayrwQbeGfFxkaQVDzulwoIJeXdM8uChQfb5phdzjlafmMSImVt8wbJ9i/sfm/nC1QQQwMQDAmvOrHby3baRfmrfRup6MpknqNK2njKJdklh7xHRrtO4MnCFBvxe7xSSJqpjBqNikwSoUaV2rY2mRQH9qN9zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c27c72d5so5050695ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 13:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728851645; x=1729456445;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfQojTbXXfG8ihB+/VwjAd3ukYPySP8ftxoJpgpEZqk=;
        b=YQU3pOztgXOHXvO12X355c3rXdcAVlA9UhJmOxPydJdXPSrFVArroHGGSSDs4PQ3K7
         xvhJ8PK1Kpz80KmLDCJCREpMQXpSIpEZjksupocmuvyf9pgorI5SdYscRPwLa7nAQ+Xs
         kNI6NkiR3A7nvCNmUGdZZ+0bbk8lHLbcyqbenc3zVAnG0CSeOVbNmtlCfzQP0aQCFBO/
         HlPbYgx9j1/3Ue3WZCy4OCyMyyQg7HFPogl2cmQrMyrv+WtyDFriRJSrqoC8fZLH1qTU
         E+cCu9GLG664ggXom9KUWaSRoLC02OIGUNbtqTM3EtrDg7U8EXnbXxAHK2u+a0POuHu4
         QFMg==
X-Forwarded-Encrypted: i=1; AJvYcCXdDDjII3qnSnh53X3KlsGx0WPnm4rQeDe/cPkCSwboT6jMxrhTcc4k4DZoeYxdkX2/v4rEmBX81WI4+0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ZF3Tl3s/G63TlN7P2IQp7e427Bf4lE2tAsU5/tT8toBvNIfR
	RBZmoY4qBDGNu83NGfUchl/om7DIqdKY1FKpVciFvgJndiU/STnIjxTHWUrH6C72KwA3qA4RR3Z
	EPF81j5nxhy9jRYnMJqnUyhf791rrLDLSltv6Z1dhx3Ke6Ycmh7V/MkY=
X-Google-Smtp-Source: AGHT+IGof2o0V4eEUZ/5w1MZr5jEYlG7sVROvw703GEFPVZ85fQ50/jrPzFpDP+I5Rakl+L/p/oEkNdYyY2BQTYEs4dTy7i7RDkI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1caa:b0:3a0:bc39:2d8c with SMTP id
 e9e14a558f8ab-3a3bce0fc22mr43476185ab.25.1728851645427; Sun, 13 Oct 2024
 13:34:05 -0700 (PDT)
Date: Sun, 13 Oct 2024 13:34:05 -0700
In-Reply-To: <6751f648-a622-4562-9ca4-5bdf79dd72fb@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670c2ebd.050a0220.3e960.0046.GAE@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
From: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, stern@rowland.harvard.edu, sylv@sylv.io, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in usb_port_suspend

INFO: task kworker/1:4:6523 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00028-gd73dc7b182be-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:4     state:D stack:23856 pid:6523  tgid:6523  ppid:2      flags:0x00004000
Workqueue: pm pm_runtime_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 usb_kill_urb.part.0+0x1ca/0x250 drivers/usb/core/urb.c:713
 usb_kill_urb+0x83/0xa0 drivers/usb/core/urb.c:702
 usb_start_wait_urb+0x255/0x4c0 drivers/usb/core/message.c:65
 usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
 usb_control_msg+0x327/0x4b0 drivers/usb/core/message.c:154
 usb_enable_remote_wakeup drivers/usb/core/hub.c:3365 [inline]
 usb_port_suspend+0x339/0xf10 drivers/usb/core/hub.c:3472
 usb_generic_driver_suspend+0xeb/0x1d0 drivers/usb/core/generic.c:302
 usb_suspend_device drivers/usb/core/driver.c:1272 [inline]
 usb_suspend_both+0x66d/0x9c0 drivers/usb/core/driver.c:1443
 usb_runtime_suspend+0x49/0x180 drivers/usb/core/driver.c:1968
 __rpm_callback+0xc5/0x4c0 drivers/base/power/runtime.c:394
 rpm_callback+0x192/0x1d0 drivers/base/power/runtime.c:448
 rpm_suspend+0x2e7/0x1200 drivers/base/power/runtime.c:672
 __pm_runtime_suspend+0xbc/0x160 drivers/base/power/runtime.c:1142
 pm_runtime_autosuspend include/linux/pm_runtime.h:342 [inline]
 usb_runtime_idle+0x4c/0x60 drivers/usb/core/driver.c:2005
 rpm_idle+0x2f7/0x740 drivers/base/power/runtime.c:524
 pm_runtime_work+0x120/0x150 drivers/base/power/runtime.c:970
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/1:5:6539 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00028-gd73dc7b182be-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:5     state:D stack:24144 pid:6539  tgid:6539  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 rwsem_down_write_slowpath+0x539/0x12a0 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1d8/0x200 kernel/locking/rwsem.c:1578
 usb_register_dev+0x11c/0x550 drivers/usb/core/file.c:134
 wdm_create+0x1269/0x1870 drivers/usb/class/cdc-wdm.c:1113
 wdm_probe+0x239/0x2e0 drivers/usb/class/cdc-wdm.c:1165
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3675
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3675
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2e58/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/0:5:6542 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00028-gd73dc7b182be-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D stack:23808 pid:6542  tgid:6542  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 wdm_disconnect+0xd1/0x440 drivers/usb/class/cdc-wdm.c:1216
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:576
 device_del+0x396/0x9f0 drivers/base/core.c:3864
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz.3.60:6614 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00028-gd73dc7b182be-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.60        state:D stack:27856 pid:6614  tgid:6614  ppid:4249   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 rpm_resume+0x5a8/0x1330 drivers/base/power/runtime.c:834
 rpm_resume+0x750/0x1330 drivers/base/power/runtime.c:892
 __pm_runtime_resume+0xb6/0x170 drivers/base/power/runtime.c:1172
 pm_runtime_resume_and_get include/linux/pm_runtime.h:430 [inline]
 usb_autopm_get_interface+0x20/0xe0 drivers/usb/core/driver.c:1833
 wdm_manage_power+0x1d/0xa0 drivers/usb/class/cdc-wdm.c:1134
 wdm_release+0x26a/0x440 drivers/usb/class/cdc-wdm.c:779
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x24e/0x260 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f34c0e8dff9
RSP: 002b:00007ffe019b50a8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f34c1047a80 RCX: 00007f34c0e8dff9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f34c1047a80 R08: 0000000000000000 R09: 00007ffe019b539f
R10: 000000000003fdc8 R11: 0000000000000246 R12: 000000000001fd9e
R13: 00007ffe019b51b0 R14: 0000000000000032 R15: ffffffffffffffff
 </TASK>
INFO: task syz.1.61:6617 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00028-gd73dc7b182be-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.61        state:D stack:28224 pid:6617  tgid:6616  ppid:4247   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 wdm_open+0x5d/0x630 drivers/usb/class/cdc-wdm.c:715
 usb_open+0x186/0x220 drivers/usb/core/file.c:47
 chrdev_open+0x237/0x6a0 fs/char_dev.c:414
 do_dentry_open+0x6cb/0x1390 fs/open.c:958
 vfs_open+0x82/0x3f0 fs/open.c:1088
 do_open fs/namei.c:3774 [inline]
 path_openat+0x1e6a/0x2d60 fs/namei.c:3933
 do_filp_open+0x1dc/0x430 fs/namei.c:3960
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcada75c990
RSP: 002b:00007fcada1d8b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fcada75c990
RDX: 0000000000000002 RSI: 00007fcada1d8c10 RDI: 00000000ffffff9c
RBP: 00007fcada1d8c10 R08: 0000000000000000 R09: 00007fcada1d8987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fcada915f80 R15: 00007ffff2a253b8
 </TASK>
INFO: task syz.0.62:6619 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00028-gd73dc7b182be-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.62        state:D stack:28224 pid:6619  tgid:6618  ppid:4241   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 rwsem_down_read_slowpath+0x61e/0xb20 kernel/locking/rwsem.c:1084
 __down_read_common kernel/locking/rwsem.c:1248 [inline]
 __down_read kernel/locking/rwsem.c:1261 [inline]
 down_read+0x124/0x330 kernel/locking/rwsem.c:1526
 usb_open+0x23/0x220 drivers/usb/core/file.c:38
 chrdev_open+0x237/0x6a0 fs/char_dev.c:414
 do_dentry_open+0x6cb/0x1390 fs/open.c:958
 vfs_open+0x82/0x3f0 fs/open.c:1088
 do_open fs/namei.c:3774 [inline]
 path_openat+0x1e6a/0x2d60 fs/namei.c:3933
 do_filp_open+0x1dc/0x430 fs/namei.c:3960
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6f5d80c990
RSP: 002b:00007f6f5d28eb70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f6f5d80c990
RDX: 0000000000000002 RSI: 00007f6f5d28ec10 RDI: 00000000ffffff9c
RBP: 00007f6f5d28ec10 R08: 0000000000000000 R09: 00007f6f5d28e987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f6f5d9c5f80 R15: 00007ffd2a1ce9f8
 </TASK>
INFO: task syz.4.63:6621 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00028-gd73dc7b182be-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.63        state:D stack:28400 pid:6621  tgid:6620  ppid:4258   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 rwsem_down_read_slowpath+0x61e/0xb20 kernel/locking/rwsem.c:1084
 __down_read_common kernel/locking/rwsem.c:1248 [inline]
 __down_read kernel/locking/rwsem.c:1261 [inline]
 down_read+0x124/0x330 kernel/locking/rwsem.c:1526
 usb_open+0x23/0x220 drivers/usb/core/file.c:38
 chrdev_open+0x237/0x6a0 fs/char_dev.c:414
 do_dentry_open+0x6cb/0x1390 fs/open.c:958
 vfs_open+0x82/0x3f0 fs/open.c:1088
 do_open fs/namei.c:3774 [inline]
 path_openat+0x1e6a/0x2d60 fs/namei.c:3933
 do_filp_open+0x1dc/0x430 fs/namei.c:3960
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0fd791c990
RSP: 002b:00007f0fd7398b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f0fd791c990
RDX: 0000000000000002 RSI: 00007f0fd7398c10 RDI: 00000000ffffff9c
RBP: 00007f0fd7398c10 R08: 0000000000000000 R09: 00007f0fd7398987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f0fd7ad5f80 R15: 00007fff6fe2a278
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/u8:1/28:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900001e7d80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
1 lock held by khungtaskd/30:
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
2 locks held by kworker/u8:4/50:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000537d80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:8/1179:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000280fd80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by getty/2606:
 #0: ffff88810f72f0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
3 locks held by kworker/1:4/6523:
 #0: ffff888100eed548 ((wq_completion)pm){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900050afd80 ((work_completion)(&dev->power.work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888109b7b508 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3206 [inline]
 #2: ffff888109b7b508 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_port_suspend+0x255/0xf10 drivers/usb/core/hub.c:3463
6 locks held by kworker/1:5/6539:
 #0: ffff8881062f5948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90001d2fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888109b90190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888109b90190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff88812c090190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88812c090190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff888115874160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888115874160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_register_dev+0x11c/0x550 drivers/usb/core/file.c:134
6 locks held by kworker/0:5/6542:
 #0: ffff8881062f5948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90001d1fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888109b68190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888109b68190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff888131374190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888131374190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff888112d1e160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888112d1e160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff888112d1e160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
 #5: ffffffff89a967e8 (wdm_mutex){+.+.}-{3:3}, at: wdm_disconnect+0xd1/0x440 drivers/usb/class/cdc-wdm.c:1216
1 lock held by syz.3.60/6614:
 #0: ffffffff89a967e8 (wdm_mutex){+.+.}-{3:3}, at: wdm_release+0x4b/0x440 drivers/usb/class/cdc-wdm.c:764
2 locks held by syz.1.61/6617:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
 #1: ffffffff89a967e8 (wdm_mutex){+.+.}-{3:3}, at: wdm_open+0x5d/0x630 drivers/usb/class/cdc-wdm.c:715
1 lock held by syz.0.62/6619:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.63/6621:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.68/8248:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.69/8441:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.71/8467:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.1.70/8471:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.82/9920:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.1.86/10298:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.83/10318:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.85/10320:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.95/11163:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.98/12158:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.1.99/12188:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.100/12234:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.107/12623:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.111/14041:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.114/14281:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.1.113/14308:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.117/14465:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.125/15573:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by modprobe/16087:
1 lock held by modprobe/16088:

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc1-syzkaller-00028-gd73dc7b182be-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
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
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 16093 Comm: modprobe Not tainted 6.12.0-rc1-syzkaller-00028-gd73dc7b182be-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__sanitizer_cov_trace_const_cmp8+0x8/0x20 kernel/kcov.c:320
Code: 00 00 00 e9 2a fe ff ff 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 0c 24 <48> 89 f2 48 89 fe bf 07 00 00 00 e9 f8 fd ff ff 0f 1f 84 00 00 00
RSP: 0018:ffffc9000551f768 EFLAGS: 00000282
RAX: ffffea0004559c40 RBX: ffffea0004559c40 RCX: ffffffff81895a98
RDX: ffff88811a830000 RSI: ffffea0004559c40 RDI: fffffffffffff000
RBP: ffffc9000551f930 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 000000000003c40c
R13: 0000000000000000 R14: ffffc9000551f940 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff8881f5800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055baab35c008 CR3: 0000000119afa000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 filemap_fault+0x228/0x2a10 mm/filemap.c:3323
 __do_fault+0x10a/0x490 mm/memory.c:4876
 do_cow_fault mm/memory.c:5312 [inline]
 do_fault mm/memory.c:5418 [inline]
 do_pte_missing mm/memory.c:3965 [inline]
 handle_pte_fault mm/memory.c:5751 [inline]
 __handle_mm_fault+0x7e1/0x3390 mm/memory.c:5894
 handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6062
 do_user_addr_fault+0x79f/0x12c0 arch/x86/mm/fault.c:1389
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:rep_stos_alternative+0x40/0x80 arch/x86/lib/clear_page_64.S:96
Code: ff c7 48 ff c9 75 f6 c3 cc cc cc cc 48 89 07 48 83 c7 08 83 e9 08 74 ef 83 f9 08 73 ef eb de 66 66 2e 0f 1f 84 00 00 00 00 00 <48> 89 07 48 89 47 08 48 89 47 10 48 89 47 18 48 89 47 20 48 89 47
RSP: 0018:ffffc9000551fbb8 EFLAGS: 00050206
RAX: 0000000000000000 RBX: ffff888109b42918 RCX: 0000000000000ff8
RDX: ffff88811a830000 RSI: ffffffff81cef4f5 RDI: 000055baab35c008
RBP: 000055baab35c008 R08: 0000000000000000 R09: fffffbfff14ac851
R10: ffffffff8a56428f R11: 0000000000000000 R12: 0000000000000008
R13: 000055baab35b000 R14: ffff888109b42938 R15: ffff888109b42928
 __clear_user arch/x86/include/asm/uaccess_64.h:183 [inline]
 clear_user arch/x86/include/asm/uaccess_64.h:200 [inline]
 padzero fs/binfmt_elf.c:125 [inline]
 elf_load+0x6aa/0x880 fs/binfmt_elf.c:421
 load_elf_binary+0xc19/0x4e20 fs/binfmt_elf.c:1167
 search_binary_handler fs/exec.c:1752 [inline]
 exec_binprm fs/exec.c:1794 [inline]
 bprm_execve fs/exec.c:1845 [inline]
 bprm_execve+0x703/0x1950 fs/exec.c:1821
 kernel_execve+0x2ef/0x3b0 fs/exec.c:2012
 call_usermodehelper_exec_async+0x255/0x4c0 kernel/umh.c:110
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         d73dc7b1 USB: chaoskey: Fix possible deadlock chaoskey..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=163cffd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=f342ea16c9d06d80b585
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15115087980000


