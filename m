Return-Path: <linux-kernel+bounces-395834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9499BC3AF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97FA1F22BCB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0730E126BEE;
	Tue,  5 Nov 2024 03:12:11 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B68A53365
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 03:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730776329; cv=none; b=nvBmEV2nKtTR/Hm0mPPFfpbutVa8/5+PZFNeXEe4q6pRkRL5q0LYHKFeDNWgxgeYEpjekQSmQTbrn9aLXV9Gyp2XJIxBwmW4hzsPPWYgt7UDQ0jtT3N/hQAZSp9ooNdBVngZ0YfBmZFqA9jWZp2IN9+Y3iBwf7gop0zUlzuCTJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730776329; c=relaxed/simple;
	bh=g/4sVIBLYmJypBWuMseyCgTiYNKkTqJX4WErUeeoRdg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p67RxeR/gq3kM2xpmKOXGLI0siZ9y0bfdFUoVmbHfdejIxD2JVF/SMV3Op4WjiaauHiW7um6BhpRrNKqDj6+OACx+Fhi8U6k5/NBBupzHleQwOJOo8a6ofeB7HLyAB4eGBd0Txfh8zrOma05+m81EnaIGT6YSVtOcm1GtGM3TGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83b567c78c3so445242639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 19:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730776325; x=1731381125;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2hkIYVP3dEP4ChhCIZ/AJGWO1dZZk4N9xfsfbyDeRo=;
        b=uI9MAkfHCcV0g30rJpVkTzbl5v3oxRFZ1ISOX4/HFXY7VggxNznHe2J3C/3StCS2xe
         louqzHzV8W/rLlDbObIWKP1B29xA7Mi/rPJoI+TP1MernaFlQVGUWA5jYr0IveoChgH9
         UBWn5QUmcvyVpBy5ah7/YmDz9/AkQyDUNRF3xshAv3cQjx4bWtbbHxpbLbvMwkv/WLkB
         c2Yg8Wvtpld5LHT4u3NClh2rSKzKcbubFBxUdlOW5ctnd5GgFdxToR6sf1RZ30HH/YmE
         ETwzZLZlfx8BYvfCtQaG5X6/zYqg5bePcLzMK2QhZ8/j5/0pOPicGFX3i0rDG5ctl0f4
         todA==
X-Forwarded-Encrypted: i=1; AJvYcCWmjGQ3GrzIK3G/vnDEDiBUaOkSuQPMLlV9CE43F/Kl0xp47A6mCCwVPRiloOb7SA1xgA8qZqZ0zcuZAC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx69FVqjTEoRLGGH3Bm3UZt6Ou9tDd0pawcU7Ro9zhSrfGeKwn3
	g+WqU9xyMZVGHV2fWnCDYrKjx/bmZvtwwbRiIAOaY2nOtt74tVzqUPxm10j9+fQYS0Bxsam8sV2
	iYMVakkAhiMO4H0UM4CLoIxJMDbb+giD3WqwlElmmEKUh+9Ftm5kZ2IE=
X-Google-Smtp-Source: AGHT+IEcMMbJyzLeXW6QhQ+gpqz7veYs2Wz4hDHFjgkv0L0CqZviKjzdY5dT7P4GdFh6qIe1i2oTKBhEgU6safCOcl5YcS66oIrJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c243:0:b0:3a6:be9a:2144 with SMTP id
 e9e14a558f8ab-3a6be9a223amr70077865ab.11.1730776325534; Mon, 04 Nov 2024
 19:12:05 -0800 (PST)
Date: Mon, 04 Nov 2024 19:12:05 -0800
In-Reply-To: <tencent_D1C2975036F44A4274C57781667C3C9B3609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67298d05.050a0220.701a.0013.GAE@google.com>
Subject: Re: [syzbot] [sound?] INFO: task hung in snd_card_free
From: syzbot <syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in snd_usx2y_probe

INFO: task kworker/0:0:8 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:24896 pid:8     tgid:8     ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:440
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3672
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
 device_add+0x114b/0x1a70 drivers/base/core.c:3672
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d9a/0x4e10 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/1:1:81 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:24624 pid:81    tgid:81    ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2591
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3e1/0x600 kernel/sched/completion.c:116
 snd_card_free+0x128/0x190 sound/core/init.c:653
 snd_usx2y_disconnect+0x1aa/0x230 sound/usb/usx2y/usbusx2y.c:429
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:576
 device_del+0x396/0x9f0 drivers/base/core.c:3861
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
INFO: task kworker/1:3:5860 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:3     state:D stack:23008 pid:5860  tgid:5860  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:440
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3672
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
 device_add+0x114b/0x1a70 drivers/base/core.c:3672
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d9a/0x4e10 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/1:4:5928 blocked for more than 146 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:4     state:D stack:26024 pid:5928  tgid:5928  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:440
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3672
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
 device_add+0x114b/0x1a70 drivers/base/core.c:3672
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d9a/0x4e10 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/1:6:5946 blocked for more than 146 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:6     state:D stack:25312 pid:5946  tgid:5946  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:440
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3672
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
 device_add+0x114b/0x1a70 drivers/base/core.c:3672
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d9a/0x4e10 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task udevd:6464 blocked for more than 147 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:27232 pid:6464  tgid:6464  ppid:5201   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1014 [inline]
 uevent_show+0x188/0x3b0 drivers/base/core.c:2736
 dev_attr_show+0x53/0xe0 drivers/base/core.c:2430
 sysfs_kf_seq_show+0x23e/0x410 fs/sysfs/file.c:59
 seq_read_iter+0x4f4/0x12b0 fs/seq_file.c:230
 kernfs_fop_read_iter+0x414/0x580 fs/kernfs/file.c:279
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x87f/0xbe0 fs/read_write.c:569
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0a94516b6a
RSP: 002b:00007ffde7035b28 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000056225aedec60 RCX: 00007f0a94516b6a
RDX: 0000000000001000 RSI: 000056225aecc640 RDI: 0000000000000008
RBP: 000056225aedec60 R08: 0000000000000008 R09: 0000000000000008
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffde7036008 R15: 000000000000000a
 </TASK>
INFO: task udevd:6485 blocked for more than 147 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:27120 pid:6485  tgid:6485  ppid:5201   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1014 [inline]
 uevent_show+0x188/0x3b0 drivers/base/core.c:2736
 dev_attr_show+0x53/0xe0 drivers/base/core.c:2430
 sysfs_kf_seq_show+0x23e/0x410 fs/sysfs/file.c:59
 seq_read_iter+0x4f4/0x12b0 fs/seq_file.c:230
 kernfs_fop_read_iter+0x414/0x580 fs/kernfs/file.c:279
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x87f/0xbe0 fs/read_write.c:569
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0a94516b6a
RSP: 002b:00007ffde7037108 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000056225aedec60 RCX: 00007f0a94516b6a
RDX: 0000000000001000 RSI: 000056225af02ad0 RDI: 0000000000000008
RBP: 000056225aedec60 R08: 0000000000000008 R09: 0000000000000020
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffde70375e8 R15: 000000000000000a
 </TASK>
INFO: task udevd:6516 blocked for more than 148 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:27232 pid:6516  tgid:6516  ppid:5201   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1014 [inline]
 uevent_show+0x188/0x3b0 drivers/base/core.c:2736
 dev_attr_show+0x53/0xe0 drivers/base/core.c:2430
 sysfs_kf_seq_show+0x23e/0x410 fs/sysfs/file.c:59
 seq_read_iter+0x4f4/0x12b0 fs/seq_file.c:230
 kernfs_fop_read_iter+0x414/0x580 fs/kernfs/file.c:279
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x87f/0xbe0 fs/read_write.c:569
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0a94516b6a
RSP: 002b:00007ffde7037108 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000056225aedec60 RCX: 00007f0a94516b6a
RDX: 0000000000001000 RSI: 000056225af028c0 RDI: 0000000000000008
RBP: 000056225aedec60 R08: 0000000000000008 R09: 0000000000000020
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffde70375e8 R15: 000000000000000a
 </TASK>
INFO: task syz.1.16:6717 blocked for more than 148 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.16        state:D stack:24144 pid:6717  tgid:6716  ppid:6547   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6690
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
RIP: 0033:0x7fd9aad7e719
RSP: 002b:00007fd9ababd038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fd9aaf35f80 RCX: 00007fd9aad7e719
RDX: 0000000000000000 RSI: 00000000c0105512 RDI: 0000000000000003
RBP: 00007fd9aadf132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fd9aaf35f80 R15: 00007ffc913c6398
 </TASK>
INFO: task udevd:6718 blocked for more than 148 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:27232 pid:6718  tgid:6718  ppid:5201   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1014 [inline]
 uevent_show+0x188/0x3b0 drivers/base/core.c:2736
 dev_attr_show+0x53/0xe0 drivers/base/core.c:2430
 sysfs_kf_seq_show+0x23e/0x410 fs/sysfs/file.c:59
 seq_read_iter+0x4f4/0x12b0 fs/seq_file.c:230
 kernfs_fop_read_iter+0x414/0x580 fs/kernfs/file.c:279
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x87f/0xbe0 fs/read_write.c:569
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0a94516b6a
RSP: 002b:00007ffde7037108 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000056225aedec60 RCX: 00007f0a94516b6a
RDX: 0000000000001000 RSI: 000056225aecc640 RDI: 0000000000000008
RBP: 000056225aedec60 R08: 0000000000000008 R09: 0000000000000008
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffde70375e8 R15: 000000000000000a
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
INFO: task udevd:6749 blocked for more than 149 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:27680 pid:6749  tgid:6749  ppid:5201   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1014 [inline]
 uevent_show+0x188/0x3b0 drivers/base/core.c:2736
 dev_attr_show+0x53/0xe0 drivers/base/core.c:2430
 sysfs_kf_seq_show+0x23e/0x410 fs/sysfs/file.c:59
 seq_read_iter+0x4f4/0x12b0 fs/seq_file.c:230
 kernfs_fop_read_iter+0x414/0x580 fs/kernfs/file.c:279
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x87f/0xbe0 fs/read_write.c:569
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0a94516b6a
RSP: 002b:00007ffde7037108 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000056225aedec60 RCX: 00007f0a94516b6a
RDX: 0000000000001000 RSI: 000056225aecc640 RDI: 0000000000000008
RBP: 000056225aedec60 R08: 0000000000000008 R09: 0000000000000008
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffde70375e8 R15: 000000000000000a
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
INFO: task kworker/1:7:6765 blocked for more than 149 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:7     state:D stack:24768 pid:6765  tgid:6765  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:440
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3672
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
 device_add+0x114b/0x1a70 drivers/base/core.c:3672
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d9a/0x4e10 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
INFO: task syz.4.19:6814 blocked for more than 149 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.19        state:D stack:28384 pid:6814  tgid:6813  ppid:6560   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6690
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
RIP: 0033:0x7fe00597d0b0
RSP: 002b:00007fe0067f3b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000d81 RCX: 00007fe00597d0b0
RDX: 0000000000000d81 RSI: 00007fe0067f3c10 RDI: 00000000ffffff9c
RBP: 00007fe0067f3c10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fe005b35f80 R15: 00007fffe6ead4d8
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
INFO: task syz.0.15:6850 blocked for more than 150 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.15        state:D stack:27680 pid:6850  tgid:6848  ppid:6545   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6690
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
RIP: 0033:0x7f72b397d0b0
RSP: 002b:00007f72b4693b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000d81 RCX: 00007f72b397d0b0
RDX: 0000000000000d81 RSI: 00007f72b4693c10 RDI: 00000000ffffff9c
RBP: 00007f72b4693c10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f72b3b35f80 R15: 00007ffe3dd2b978
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
INFO: task syz.2.17:6851 blocked for more than 150 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.17        state:D stack:28384 pid:6851  tgid:6849  ppid:6554   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6690
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
RIP: 0033:0x7efc0497d0b0
RSP: 002b:00007efc0578fb70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000d81 RCX: 00007efc0497d0b0
RDX: 0000000000000d81 RSI: 00007efc0578fc10 RDI: 00000000ffffff9c
RBP: 00007efc0578fc10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00007efc04b35f80 R15: 00007ffe620c9d98
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
INFO: task syz.3.18:6860 blocked for more than 151 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.18        state:D stack:28384 pid:6860  tgid:6859  ppid:6557   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6690
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
RIP: 0033:0x7efce1f7d0b0
RSP: 002b:00007efce2da8b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000d81 RCX: 00007efce1f7d0b0
RDX: 0000000000000d81 RSI: 00007efce2da8c10 RDI: 00000000ffffff9c
RBP: 00007efce2da8c10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00007efce2135f80 R15: 00007fff025d24c8
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
INFO: task udevd:6894 blocked for more than 151 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:27232 pid:6894  tgid:6894  ppid:5201   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1014 [inline]
 uevent_show+0x188/0x3b0 drivers/base/core.c:2736
 dev_attr_show+0x53/0xe0 drivers/base/core.c:2430
 sysfs_kf_seq_show+0x23e/0x410 fs/sysfs/file.c:59
 seq_read_iter+0x4f4/0x12b0 fs/seq_file.c:230
 kernfs_fop_read_iter+0x414/0x580 fs/kernfs/file.c:279
 new_sync_read fs/read_write.c:488 [inline]
 vfs_read+0x87f/0xbe0 fs/read_write.c:569
 ksys_read+0x12f/0x260 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0a94516b6a
RSP: 002b:00007ffde7037108 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000056225aedec60 RCX: 00007f0a94516b6a
RDX: 0000000000001000 RSI: 000056225aecc640 RDI: 0000000000000008
RBP: 000056225aedec60 R08: 0000000000000008 R09: 0000000000000008
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffde70375e8 R15: 000000000000000a
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
INFO: task syz.5.20:7318 blocked for more than 152 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.5.20        state:D stack:28384 pid:7318  tgid:7317  ppid:7299   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0xe55/0x5740 kernel/sched/core.c:6690
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
RIP: 0033:0x7f6ef7f7d0b0
RSP: 002b:00007f6ef8e27b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000d81 RCX: 00007f6ef7f7d0b0
RDX: 0000000000000d81 RSI: 00007f6ef8e27c10 RDI: 00000000ffffff9c
RBP: 00007f6ef8e27c10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f6ef8135f80 R15: 00007ffcde8b4758
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings

Showing all locks held in the system:
6 locks held by kworker/0:0/8:
 #0: ffff888144a9f948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900000d7d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888145303190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888145303190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff88802d940190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88802d940190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff88807a842160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88807a842160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8fe67a68 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:440
1 lock held by khungtaskd/30:
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
2 locks held by kworker/u8:4/80:
6 locks held by kworker/1:1/81:
 #0: ffff888144a9f948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900015d7d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff88814539b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff88814539b190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff888060fbc190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888060fbc190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff888028f58160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888028f58160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff888028f58160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
 #5: ffffffff8fe67a68 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_disconnect+0x22/0x230 sound/usb/usx2y/usbusx2y.c:411
2 locks held by kworker/0:2/968:
 #0: ffff8880b863ee98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:598
 #1: ffff8880b8628a48 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2c1/0x8e0 kernel/sched/psi.c:987
2 locks held by getty/5586:
 #0: ffff88814e5080a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
6 locks held by kworker/1:3/5860:
 #0: ffff888144a9f948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90003ce7d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888029abb190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888029abb190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff888063ac8190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888063ac8190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff888032b4a160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888032b4a160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8fe67a68 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:440
6 locks held by kworker/1:4/5928:
 #0: ffff888144a9f948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000378fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff8881453ab190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff8881453ab190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff88806020a190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88806020a190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff88806ed10160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88806ed10160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8fe67a68 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:440
6 locks held by kworker/1:5/5931:
 #0: ffff888144a9f948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000376fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888145783190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888145783190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff8880630cf190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff8880630cf190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff88806f018160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88806f018160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8fe67a68 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:440
6 locks held by kworker/1:6/5946:
 #0: ffff888144a9f948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000377fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888145743190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888145743190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff888034111190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888034111190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff8880665a3160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff8880665a3160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8fe67a68 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:440
4 locks held by udevd/6464:
 #0: ffff88806f083418 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff888033ff7488 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff88814c61f008 (kn->active#5){.+.+}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff888060fbc190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888060fbc190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
4 locks held by udevd/6485:
 #0: ffff8880322dbc30 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff888020ad5888 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff8880289f8d28 (kn->active#5){.+.+}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff888065e20190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888065e20190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
4 locks held by udevd/6516:
 #0: ffff888079b609e0 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff8880282d2888 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff888070c530f8 (kn->active#5){.+.+}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155


Tested on:

commit:         2e1b3cc9 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b6a740580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2effb62852f5a821
dashboard link: https://syzkaller.appspot.com/bug?extid=73582d08864d8268b6fd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a5c6a7980000


