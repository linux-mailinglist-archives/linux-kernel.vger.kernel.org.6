Return-Path: <linux-kernel+bounces-362843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA59999B9E3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 17:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5E0281742
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB84146D5A;
	Sun, 13 Oct 2024 15:02:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A3D1EB2E
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728831726; cv=none; b=rI0ChGxTeobZWzLtU7imgarhT47D/GH/V782ZlB89UTE+JuTEyTOjgnJIdap3Uox0XKVgvTITA3TzLuhUqn58flNN52D0vh/1XR7SQ/+NAIUGK9VIqbxyzMYa3XGjDqjBrLE0gEEcd8o4TlAAwpiRBNFAFGO+m4PJ12fFwaDAXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728831726; c=relaxed/simple;
	bh=pPNl4ATfdCLW7ZlBjBjfQH2ZZ2ZV42VWLscuHaL8LJc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dD2azkzQxfkg3YmaTpJfi/rzelBgq3zKNxXjpJohbzQuKH2j/sTwcI9pjYPtqaIKoIAmi6Iuh9xRNP4flr1vqAeYQiUmVaQDhUL+UIW4V1quVZnt5uwZgGjdcet4DdsWfwMgtpTCe7evvfMblYzSID1LROQfD+xWp+lnUQDINN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3ae775193so25319015ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 08:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728831723; x=1729436523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NokW9y4Pn7TCxKCmDe3fVs5u/gNgFAkF4CKC5TBjSlQ=;
        b=EnX5ux6E2W/MItR+Lx0cf72xi539ZhKKRGK3zAJKfXQ+tgEQE+DopqZUZLxFCriMih
         N2SEvdxqX8Z0gDtyB9fGoa0D5pAIR6xmfWvAAC8l+hJR9g6Miojc42wh824j404mRlMI
         lM1YVqrP0bwbru2XWU2Yuh/FOf8G2d+NLvQhWBTkxQ6iZcvDBJdPN+bX5g04JfhCWbAs
         99vvcToPHU5Jt3P2FJ61QppwPH7W/0Ak7F06NzstRyl6iBLReM2WyMWL41Y7d1Z4mRiq
         +ax/fKuhAx5fl0V6hHYjsTgMfFkPCsGu/qRxDZJ2Lbpo6qmfWhPse5PvJ+Uy/TxLtcWt
         0kIg==
X-Forwarded-Encrypted: i=1; AJvYcCXOxWnHUqWzI6sTN45VRcwQr6MuOjqV4v1r/s2itLZV6fueXgP5VRrXyL+x/B2amthnCs3pQRFrZ82rJYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjwiSG613FnYNB5he5XlmKdBFAuwkuCbKba1cxdJ39+W4POyjL
	fO77LKGZIctuce+/KuSnDRtJd1voL3QscvPYOf5IPsjIg574kR6n5yGycEO8yE345fHXNIw/9BG
	HH+iNmJQIFwu3wEe0zR7XG1rpTw/P+a0xAtqcD5GsvJc1sk5t7M9r/vQ=
X-Google-Smtp-Source: AGHT+IE1UIqDYpRFgX9fm+0PE4DQ0DAE7xq4oldBSrQDAR9XNWonDnyJStwWZl0x2rM9uKZKKdvojO6i+2+Q/f/txmGtAq2vnFZJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc9:b0:3a0:9f85:d74f with SMTP id
 e9e14a558f8ab-3a3bcdfc2e6mr38906615ab.16.1728831722937; Sun, 13 Oct 2024
 08:02:02 -0700 (PDT)
Date: Sun, 13 Oct 2024 08:02:02 -0700
In-Reply-To: <5d7f23a2-dd39-432c-9908-174f6fffda0b@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670be0ea.050a0220.3e960.0040.GAE@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
From: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, stern@rowland.harvard.edu, sylv@sylv.io, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in usb_register_dev

INFO: task kworker/0:2:651 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00028-gd73dc7b182be-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D stack:23728 pid:651   tgid:651   ppid:2      flags:0x00004000
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
INFO: task kworker/1:2:2510 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00028-gd73dc7b182be-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:2     state:D stack:24272 pid:2510  tgid:2510  ppid:2      flags:0x00004000
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
INFO: task kworker/1:3:3669 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00028-gd73dc7b182be-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:3     state:D stack:24064 pid:3669  tgid:3669  ppid:2      flags:0x00004000
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
INFO: task kworker/0:3:6517 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00028-gd73dc7b182be-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:3     state:D stack:24240 pid:6517  tgid:6517  ppid:2      flags:0x00004000
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
INFO: task syz.1.28:6553 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00028-gd73dc7b182be-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.28        state:D stack:27856 pid:6553  tgid:6553  ppid:4256   flags:0x00000004
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
RIP: 0033:0x7f4b61e6dff9
RSP: 002b:00007ffee4286af8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f4b62027a80 RCX: 00007f4b61e6dff9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f4b62027a80 R08: 0000000000000000 R09: 00007ffee4286def
R10: 000000000003fdc8 R11: 0000000000000246 R12: 000000000001e0b9
R13: 00007ffee4286c00 R14: 0000000000000032 R15: ffffffffffffffff
 </TASK>
INFO: task syz.4.29:6556 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00028-gd73dc7b182be-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.29        state:D stack:28432 pid:6556  tgid:6555  ppid:4255   flags:0x00000004
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
RIP: 0033:0x7f66f2eac990
RSP: 002b:00007f66f292eb70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f66f2eac990
RDX: 0000000000000002 RSI: 00007f66f292ec10 RDI: 00000000ffffff9c
RBP: 00007f66f292ec10 R08: 0000000000000000 R09: 00007f66f292e987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f66f3065f80 R15: 00007ffdfdf2e9a8
 </TASK>
INFO: task syz.2.30:6558 blocked for more than 146 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00028-gd73dc7b182be-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.30        state:D stack:28192 pid:6558  tgid:6557  ppid:4252   flags:0x00000004
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
RIP: 0033:0x7f38ad10c990
RSP: 002b:00007f38acb8eb70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f38ad10c990
RDX: 0000000000000002 RSI: 00007f38acb8ec10 RDI: 00000000ffffff9c
RBP: 00007f38acb8ec10 R08: 0000000000000000 R09: 00007f38acb8e987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f38ad2c5f80 R15: 00007fff6b525768
 </TASK>
INFO: task syz.3.31:6560 blocked for more than 146 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00028-gd73dc7b182be-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.31        state:D stack:28000 pid:6560  tgid:6559  ppid:4254   flags:0x00000004
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
RIP: 0033:0x7fc73276c990
RSP: 002b:00007fc7321eeb70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fc73276c990
RDX: 0000000000000002 RSI: 00007fc7321eec10 RDI: 00000000ffffff9c
RBP: 00007fc7321eec10 R08: 0000000000000000 R09: 00007fc7321ee987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fc732925f80 R15: 00007ffda361dcc8
 </TASK>
INFO: task syz.0.32:6562 blocked for more than 147 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00028-gd73dc7b182be-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.32        state:D stack:28064 pid:6562  tgid:6561  ppid:4248   flags:0x00000004
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
RIP: 0033:0x7f53a37ac990
RSP: 002b:00007f53a3228b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f53a37ac990
RDX: 0000000000000002 RSI: 00007f53a3228c10 RDI: 00000000ffffff9c
RBP: 00007f53a3228c10 R08: 0000000000000000 R09: 00007f53a3228987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f53a3965f80 R15: 00007ffcaaeb5738
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/u8:0/11:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900000bfd80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:1/28:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900001e7d80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
1 lock held by khungtaskd/30:
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
2 locks held by kworker/u8:5/266:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900016ffd80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
6 locks held by kworker/0:2/651:
 #0: ffff8881066c4148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90001b1fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff8881097b4190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff8881097b4190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff88811e7a1190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88811e7a1190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff88811e988160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88811e988160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_register_dev+0x11c/0x550 drivers/usb/core/file.c:134
2 locks held by kworker/u8:6/1332:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000298fd80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
6 locks held by kworker/1:2/2510:
 #0: ffff8881066c4148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000513fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888109b71190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888109b71190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff88811e35a190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88811e35a190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff88811e35f160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88811e35f160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_register_dev+0x11c/0x550 drivers/usb/core/file.c:134
2 locks held by getty/2605:
 #0: ffff888108ae70a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
6 locks held by kworker/1:3/3669:
 #0: ffff8881066c4148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000146fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888109b89190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888109b89190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff88811e35b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88811e35b190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff888115bd6160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888115bd6160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_register_dev+0x11c/0x550 drivers/usb/core/file.c:134
3 locks held by kworker/0:3/6517:
 #0: ffff8881022f8948 ((wq_completion)pm){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90001a4fd80 ((work_completion)(&dev->power.work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888107b7a508 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3206 [inline]
 #2: ffff888107b7a508 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_port_suspend+0x255/0xf10 drivers/usb/core/hub.c:3463
1 lock held by syz.1.28/6553:
 #0: ffffffff89a967e8 (wdm_mutex){+.+.}-{3:3}, at: wdm_release+0x4b/0x440 drivers/usb/class/cdc-wdm.c:764
2 locks held by syz.4.29/6556:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
 #1: ffffffff89a967e8 (wdm_mutex){+.+.}-{3:3}, at: wdm_open+0x5d/0x630 drivers/usb/class/cdc-wdm.c:715
1 lock held by syz.2.30/6558:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.31/6560:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.32/6562:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.1.33/8577:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.2.35/8827:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.34/8839:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.36/8844:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.37/8847:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.1.38/10336:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.39/11108:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.41/11117:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.2.40/11129:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.42/11140:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.1.43/11588:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.2.45/13714:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.47/13729:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.46/13737:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.44/13742:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.1.48/13873:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.49/16089:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.52/16088:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.51/16103:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.2.50/16122:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.1.53/16157:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
2 locks held by modprobe/16340:
1 lock held by modprobe/16341:
1 lock held by modprobe/16342:
5 locks held by modprobe/16343:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc1-syzkaller-00028-gd73dc7b182be-dirty #0
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 16350 Comm: modprobe Not tainted 6.12.0-rc1-syzkaller-00028-gd73dc7b182be-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:orc_ip arch/x86/kernel/unwind_orc.c:80 [inline]
RIP: 0010:__orc_find+0x83/0xf0 arch/x86/kernel/unwind_orc.c:102
Code: 02 48 01 f2 48 d1 fa 48 8d 5c 95 00 48 89 da 48 c1 ea 03 0f b6 34 0a 48 89 da 83 e2 07 83 c2 03 40 38 f2 7c 05 40 84 f6 75 4b <48> 63 13 48 01 da 49 39 d5 73 af 4c 8d 63 fc 49 39 ec 73 b2 4d 29
RSP: 0018:ffffc90004ccf358 EFLAGS: 00000246
RAX: ffffffff8b1f20be RBX: ffffffff8aa91620 RCX: dffffc0000000000
RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffffffff8aa91604
RBP: ffffffff8aa91604 R08: ffffffff8b1f2184 R09: ffffffff8b1e59d2
R10: ffffc90004ccf408 R11: 0000000000060001 R12: ffffffff8aa91640
R13: ffffffff8700012f R14: ffffffff8aa91604 R15: ffffffff8aa91604
FS:  0000000000000000(0000) GS:ffff8881f5900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0fc1ced020 CR3: 0000000119916000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 orc_find arch/x86/kernel/unwind_orc.c:227 [inline]
 unwind_next_frame+0x2be/0x20c0 arch/x86/kernel/unwind_orc.c:494
 arch_stack_walk+0x95/0x100 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x6e/0x70 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4086 [inline]
 slab_alloc_node mm/slub.c:4135 [inline]
 kmem_cache_alloc_noprof+0x11c/0x2b0 mm/slub.c:4142
 mt_alloc_one lib/maple_tree.c:162 [inline]
 mas_alloc_nodes+0x176/0x860 lib/maple_tree.c:1241
 mas_node_count_gfp+0x105/0x130 lib/maple_tree.c:1321
 mas_preallocate+0x53b/0xcd0 lib/maple_tree.c:5546
 vma_iter_prealloc mm/vma.h:432 [inline]
 mmap_region+0x14fa/0x2900 mm/mmap.c:1508
 do_mmap+0xc00/0xfc0 mm/mmap.c:496
 vm_mmap_pgoff+0x1ba/0x350 mm/util.c:588
 ksys_mmap_pgoff+0x7d/0x5c0 mm/mmap.c:542
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:79 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:79
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0fc1d0ab74
Code: 63 08 44 89 e8 5b 41 5c 41 5d c3 41 89 ca 41 f7 c1 ff 0f 00 00 74 0c c7 05 f5 46 01 00 16 00 00 00 eb 17 b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 0c f7 d8 89 05 dc 46 01 00 48 83 c8 ff c3 0f
RSP: 002b:00007ffc1b344d08 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00000000000000a0 RCX: 00007f0fc1d0ab74
RDX: 0000000000000003 RSI: 0000000000002000 RDI: 0000000000000000
RBP: 0000000000002000 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000002 R14: 0000000000000000 R15: 00007f0fc1d1f2a0
 </TASK>


Tested on:

commit:         d73dc7b1 USB: chaoskey: Fix possible deadlock chaoskey..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=12bf9087980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=f342ea16c9d06d80b585
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1089e440580000


