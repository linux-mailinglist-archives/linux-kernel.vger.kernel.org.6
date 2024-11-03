Return-Path: <linux-kernel+bounces-393638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EB59BA37C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 02:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810E91F229A7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 01:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EF854727;
	Sun,  3 Nov 2024 01:49:09 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8750F7494
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 01:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730598547; cv=none; b=EM4yVqijaWuXTidnQk3uGbcfL+9OvW1OBKQ6eW750x1V4yOej0tgy8DyvXetldopbAAZUjECeUd5gBPiRT7JdLEoVb1DgNioBQEU4vXH46ErH1lCBoP4XdqpPuI8cNDcfGWA+QvoPJowCrOk9EIgSRxrwIzeJjiJM4hhDEz6GT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730598547; c=relaxed/simple;
	bh=AnivrVov3MrUoPiP/GzTZYN671r0GYglECUWcAoSo9Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jSmn+NhILzeT0O+OtLj1am5uDQYZ1yfL9cDAbpH4n+7XJR5hhn5XvVENvUcmRCtv/0I9xsvNxzVYC0ZlsB5KHDKozsY2xuFQ3QCu2hUfAVSAzey18dizoCqlI+0IfVGMgYP7YooLUM3BO7d21wpgP3Il8qvxGD88ZBYhWv0l2Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83ae0af926dso313423539f.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 18:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730598543; x=1731203343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckp5v/Pu1RByDVA8SH4Z+tBNgWOIJkSUxMPBZ0ZTOYM=;
        b=Rs+O06esyfqFxGoSSp++mAlzsG2q8bZ7r5UhqPhp6Zug4yYNQkuW91tygihoNyZ1VS
         50zKK/GI08OT1OfNE6ltcstYGEi50u23TwTD92W+IC1weszOdd1nNEhaVcexEIYFm2wM
         7zz853Vyssiu9XgW3fuYZ3/mJqmECyw4Zq2ACg4WR44oq2FtJyWqZAHnMhHO5iteUBlO
         MxM9l1HM0jJsWICxsun9Kmpzuc/axXFITRhvtSulseIk1ipnXuP2aZiTnFoXKAICecdx
         3RP7DJKtQGPeZ9BCFW8yLVLZO8GmfUrux16k7IhftZtf2UhzTo97fDJQvSoMfSRb/SHe
         Nemw==
X-Forwarded-Encrypted: i=1; AJvYcCViXpgBctexSOc3gGKURODuida6qKkDlp5KbTfBEKQ05Qdv3VLla8RcHm+PK7FkqigjXR64EikHdbjT+YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Cr91Fxuw6PhSfRZWxfNJz7sFzy5Fw2eOiH5C+yBSoiW0cZzz
	nLdt1im4c8v4Mplr6Ouy87HlaHy5XKYbYrQuQdEPnhNLPw0x5prvr7U/xtuLJUh0y9pTXRsz1lT
	VYTds0MLhal6Eo1zX86Yk7ZyqjJy5Pkci3/7p2p5ow04K/WISCotdpuU=
X-Google-Smtp-Source: AGHT+IHOiPWX/VYDTWE8pbQqSVJhjcfmtj2bUX31ILM6kl3ujQLHzkfIz7+0tUw7ts/Vs/pVX/6h17H7jlC6Ec0x7qj73Zajym1L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4f:b0:3a0:8c5f:90b4 with SMTP id
 e9e14a558f8ab-3a6b022a5d6mr96524785ab.4.1730598543618; Sat, 02 Nov 2024
 18:49:03 -0700 (PDT)
Date: Sat, 02 Nov 2024 18:49:03 -0700
In-Reply-To: <20241103012845.3066-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6726d68f.050a0220.35b515.018d.GAE@google.com>
Subject: Re: [syzbot] [sound?] INFO: task hung in snd_card_free
From: syzbot <syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in snd_card_free

INFO: task kworker/0:1:9 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc5-syzkaller-00299-g11066801dd4b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:22400 pid:9     tgid:9     ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5730 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3e1/0x600 kernel/sched/completion.c:116
 snd_card_free+0x144/0x1b0 sound/core/init.c:663
 snd_usx2y_disconnect+0x194/0x1f0 sound/usb/usx2y/usbusx2y.c:425
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
 hub_event+0x1da5/0x4e10 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/1:1:51 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc5-syzkaller-00299-g11066801dd4b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:24480 pid:51    tgid:51    ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5730 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3e1/0x600 kernel/sched/completion.c:116
 snd_card_free+0x144/0x1b0 sound/core/init.c:663
 snd_usx2y_disconnect+0x194/0x1f0 sound/usb/usx2y/usbusx2y.c:425
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
 hub_event+0x1da5/0x4e10 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/0:3:5857 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc5-syzkaller-00299-g11066801dd4b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:3     state:D
 stack:24096 pid:5857  tgid:5857  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5730 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3e1/0x600 kernel/sched/completion.c:116
 snd_card_free+0x144/0x1b0 sound/core/init.c:663
 snd_usx2y_disconnect+0x194/0x1f0 sound/usb/usx2y/usbusx2y.c:425
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
 hub_event+0x1da5/0x4e10 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/1:7:6739 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc5-syzkaller-00299-g11066801dd4b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:7     state:D
 stack:26032 pid:6739  tgid:6739  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5730 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3e1/0x600 kernel/sched/completion.c:116
 snd_card_free+0x144/0x1b0 sound/core/init.c:663
 snd_usx2y_disconnect+0x194/0x1f0 sound/usb/usx2y/usbusx2y.c:425
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
 hub_event+0x1da5/0x4e10 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz.1.16:6744 blocked for more than 146 seconds.
      Not tainted 6.12.0-rc5-syzkaller-00299-g11066801dd4b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.16        state:D stack:28256 pid:6744  tgid:6743  ppid:6568   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5730 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1014 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2608 [inline]
 usbdev_ioctl+0x1a9/0x4010 drivers/usb/core/devio.c:2824
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18f/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0d03b7e719
RSP: 002b:00007f0d049ed038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0d03d35f80 RCX: 00007f0d03b7e719
RDX: 0000000000000000 RSI: 00000000c0105512 RDI: 0000000000000003
RBP: 00007f0d03bf132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f0d03d35f80 R15: 00007ffe05b28c68
 </TASK>
INFO: task syz.4.19:6761 blocked for more than 146 seconds.
      Not tainted 6.12.0-rc5-syzkaller-00299-g11066801dd4b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.19        state:D stack:27680 pid:6761  tgid:6760  ppid:6573   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5730 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1014 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2608 [inline]
 usbdev_ioctl+0x1a9/0x4010 drivers/usb/core/devio.c:2824
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18f/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdef957e719
RSP: 002b:00007fdefa2e4038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fdef9735f80 RCX: 00007fdef957e719
RDX: 0000000000000000 RSI: 00000000c0105512 RDI: 0000000000000003
RBP: 00007fdef95f132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fdef9735f80 R15: 00007fff0efa2c78
 </TASK>
INFO: task syz.3.18:6769 blocked for more than 147 seconds.
      Not tainted 6.12.0-rc5-syzkaller-00299-g11066801dd4b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.18        state:D stack:28384 pid:6769  tgid:6768  ppid:6562   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5730 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1014 [inline]
 usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
 chrdev_open+0x237/0x6a0 fs/char_dev.c:414
 do_dentry_open+0x6ca/0x1530 fs/open.c:958
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
RIP: 0033:0x7fecec77d0b0
RSP: 002b:00007feced522b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000d81 RCX: 00007fecec77d0b0
RDX: 0000000000000d81 RSI: 00007feced522c10 RDI: 00000000ffffff9c
RBP: 00007feced522c10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fecec935f80 R15: 00007ffc4cf1db68
 </TASK>
INFO: task syz.2.21:6788 blocked for more than 148 seconds.
      Not tainted 6.12.0-rc5-syzkaller-00299-g11066801dd4b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.21        state:D stack:27216 pid:6788  tgid:6786  ppid:6561   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5730 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1014 [inline]
 usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
 chrdev_open+0x237/0x6a0 fs/char_dev.c:414
 do_dentry_open+0x6ca/0x1530 fs/open.c:958
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
RIP: 0033:0x7fb7f857d0b0
RSP: 002b:00007fb7f92dbb70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000d81 RCX: 00007fb7f857d0b0
RDX: 0000000000000d81 RSI: 00007fb7f92dbc10 RDI: 00000000ffffff9c
RBP: 00007fb7f92dbc10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fb7f8735f80 R15: 00007fff3c60ecb8
 </TASK>
INFO: task syz.0.22:6789 blocked for more than 148 seconds.
      Not tainted 6.12.0-rc5-syzkaller-00299-g11066801dd4b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.22        state:D stack:28384 pid:6789  tgid:6787  ppid:6557   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5730 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1014 [inline]
 usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
 chrdev_open+0x237/0x6a0 fs/char_dev.c:414
 do_dentry_open+0x6ca/0x1530 fs/open.c:958
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
RIP: 0033:0x7fa27977d0b0
RSP: 002b:00007fa27a56db70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000d81 RCX: 00007fa27977d0b0
RDX: 0000000000000d81 RSI: 00007fa27a56dc10 RDI: 00000000ffffff9c
RBP: 00007fa27a56dc10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fa279935f80 R15: 00007ffee83e1168
 </TASK>

Showing all locks held in the system:
5 locks held by kworker/0:1/9:
 #0: ffff88801b745548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900000e7d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888144341190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888144341190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff88805d738190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88805d738190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff888026a58160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888026a58160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff888026a58160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
3 locks held by kworker/u8:0/11:
 #0: ffff88814d188148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000107d80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888052b1ae58 (&p->pi_lock){-.-.}-{2:2}, at: class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
 #2: ffff888052b1ae58 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xa1/0x14f0 kernel/sched/core.c:4165
5 locks held by kworker/1:0/25:
 #0: ffff88801b745548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900001f7d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888029010190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888029010190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff88805b026190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88805b026190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff88805b24e160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88805b24e160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88805b24e160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
1 lock held by khungtaskd/30:
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
3 locks held by kworker/u8:2/35:
 #0: ffff88814d188148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000ab7d80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffffffff8fee35a8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xcf/0x14d0 net/ipv6/addrconf.c:4196
5 locks held by kworker/1:1/51:
 #0: ffff88801b745548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000bc7d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888144344190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888144344190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff888035eb1190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888035eb1190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff88802ae0a160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88802ae0a160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88802ae0a160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
5 locks held by kworker/u8:4/64:
5 locks held by kworker/1:2/965:
 #0: ffff88801b745548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900039bfd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888029000190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888029000190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff88805df78190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88805df78190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff888078cc9160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888078cc9160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff888078cc9160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
2 locks held by kworker/u8:7/2944:
2 locks held by getty/5583:
 #0: ffff888035da20a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
5 locks held by kworker/0:3/5857:
 #0: ffff88801b745548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900047afd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff88802933d190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88802933d190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff88802a961160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88802a961160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88802a961160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
5 locks held by kworker/1:4/5927:
 #0: ffff88801b745548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900049dfd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888028e78190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888028e78190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff8880213ec190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff8880213ec190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff888024a1b160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888024a1b160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff888024a1b160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
5 locks held by kworker/0:4/6092:
 #0: ffff88801b745548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900043afd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff88814474c190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff88814474c190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff88814476d190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88814476d190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff88807bcfd160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88807bcfd160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88807bcfd160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
5 locks held by kworker/u9:3/6565:
 #0: ffff88802138b148 ((wq_completion)hci12){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900047bfd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff88802adccd80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:331
 #3: ffff88802adcc078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5577
 #4: ffffffff9014bd68 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #4: ffffffff9014bd68 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x340 net/bluetooth/hci_conn.c:1265
5 locks held by kworker/u9:4/6566:
 #0: ffff88802ab31948 ((wq_completion)hci13){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000479fd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff88807e558d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:331
 #3: ffff88807e558078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5577
 #4: ffffffff9014bd68 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #4: ffffffff9014bd68 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x340 net/bluetooth/hci_conn.c:1265
5 locks held by kworker/u9:6/6571:
 #0: ffff88805fc52148 ((wq_completion)hci11){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90002e0fd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff88807b610d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:331
 #3: ffff88807b610078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5577
 #4: ffffffff9014bd68 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #4: ffffffff9014bd68 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x340 net/bluetooth/hci_conn.c:1265
5 locks held by kworker/u9:7/6572:
 #0: ffff8880618fe948 ((wq_completion)hci14){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90002f2fd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff88807e55cd80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:331
 #3: ffff88807e55c078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5577
 #4: ffffffff9014bd68 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #4: ffffffff9014bd68 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x340 net/bluetooth/hci_conn.c:1265
5 locks held by kworker/1:6/6650:
 #0: ffff88801b745548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90003b17d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff8881443f0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff8881443f0190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff88807cbd6190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88807cbd6190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff888027644160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888027644160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff888027644160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
5 locks held by kworker/1:7/6739:
 #0: ffff88801b745548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900032ffd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff88814473c190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff88814473c190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff888078fc8190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888078fc8190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff888030970160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888030970160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff888030970160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
1 lock held by syz.1.16/6744:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_do_ioctl drivers/usb/core/devio.c:2608 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_ioctl+0x1a9/0x4010 drivers/usb/core/devio.c:2824
1 lock held by syz.4.19/6761:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_do_ioctl drivers/usb/core/devio.c:2608 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_ioctl+0x1a9/0x4010 drivers/usb/core/devio.c:2824
1 lock held by syz.3.18/6769:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.2.21/6788:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.0.22/6789:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.5.23/7406:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
5 locks held by kworker/0:8/7468:
 #0: ffff88801b745548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000467fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff8880290d0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff8880290d0190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff888078594190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888078594190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff88805be4c160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88805be4c160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88805be4c160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
1 lock held by syz.6.24/7471:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.9.27/7474:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.8.26/7476:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.7.25/7480:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.1.28/7499:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.3.31/7563:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.2.30/7570:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.4.32/7573:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.0.29/7576:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.5.33/7598:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.6.34/7625:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.9.37/7685:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.7.35/7695:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.8.36/7701:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.1.38/7708:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.3.39/7726:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.0.40/7748:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.4.42/7787:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.2.41/7790:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.5.43/7803:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.6.44/7825:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.9.45/7847:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.7.46/7898:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.8.47/7908:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.1.48/7925:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.3.49/7938:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.0.50/7948:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.2.51/7973:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.4.52/7995:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.5.53/8026:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.6.54/8044:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.9.55/8058:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.7.56/8087:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.8.57/8104:
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8880284b7190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
6 locks held by syz-executor/8105:
 #0: ffff88801206c420 (sb_writers#11){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:736
 #1: ffff888043cb7488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
 #2: ffffffff8e20f448 (cgroup_mutex){+.+.}-{3:3}, at: cgroup_lock include/linux/cgroup.h:368 [inline]
 #2: ffffffff8e20f448 (cgroup_mutex){+.+.}-{3:3}, at: cgroup_kn_lock_live+0x139/0x570 kernel/cgroup/cgroup.c:1662
 #3: ffffffff8e05b950 (cpu_hotplug_lock){++++}-{0:0}, at: cgroup_attach_lock kernel/cgroup/cgroup.c:2435 [inline]
 #3: ffffffff8e05b950 (cpu_hotplug_lock){++++}-{0:0}, at: cgroup_procs_write_start+0x18f/0x660 kernel/cgroup/cgroup.c:2939
 #4: ffffffff8e20f210 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: cgroup_attach_lock kernel/cgroup/cgroup.c:2437 [inline]
 #4: ffffffff8e20f210 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: cgroup_attach_lock kernel/cgroup/cgroup.c:2433 [inline]
 #4: ffffffff8e20f210 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: cgroup_procs_write_start+0x19b/0x660 kernel/cgroup/cgroup.c:2939
 #5: ffffffff8e1c3c38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x282/0x3b0 kernel/rcu/tree_exp.h:297
2 locks held by syz-executor/8119:
 #0: ffffffff8fee35a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fee35a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6672
 #1: ffffffff8e1c3c38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x1a4/0x3b0 kernel/rcu/tree_exp.h:329
1 lock held by syz-executor/8122:
 #0: ffffffff8fee35a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fee35a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6672

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc5-syzkaller-00299-g11066801dd4b-dirty #0
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
CPU: 0 UID: 0 PID: 64 Comm: kworker/u8:4 Not tainted 6.12.0-rc5-syzkaller-00299-g11066801dd4b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:ieee80211_sta_get_rates+0x237/0x650 net/mac80211/util.c:1556
Code: 89 7c 24 24 e8 3a 63 ef f6 89 de 44 89 ff e8 b0 64 ef f6 44 39 fb 0f 8e 6f 02 00 00 e8 22 63 ef f6 48 8b 44 24 18 48 8d 78 38 <48> 89 f8 48 c1 e8 03 42 80 3c 28 00 0f 85 82 03 00 00 48 8b 44 24
RSP: 0018:ffffc900015d7958 EFLAGS: 00000293
RAX: ffff888040429800 RBX: 0000000000000008 RCX: ffffffff8a9e1950
RDX: ffff88801d364880 RSI: ffffffff8a9e195e RDI: ffff888040429838
RBP: 000000000000000c R08: 0000000000000004 R09: 0000000000000004
R10: 0000000000000008 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: 000000000000000c R15: 0000000000000004
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555b3a6808 CR3: 000000000df7c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 ieee80211_update_sta_info net/mac80211/ibss.c:989 [inline]
 ieee80211_rx_bss_info net/mac80211/ibss.c:1098 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1579 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1039/0x2f40 net/mac80211/ibss.c:1606
 ieee80211_iface_process_skb net/mac80211/iface.c:1603 [inline]
 ieee80211_iface_work+0xc0b/0xf00 net/mac80211/iface.c:1657
 cfg80211_wiphy_work+0x3d9/0x550 net/wireless/core.c:440
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         11066801 Merge tag 'linux_kselftest-fixes-6.12-rc6' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a41aa7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4340261e4e9f37fc
dashboard link: https://syzkaller.appspot.com/bug?extid=73582d08864d8268b6fd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=157ff55f980000


