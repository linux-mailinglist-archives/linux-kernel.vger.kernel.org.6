Return-Path: <linux-kernel+bounces-397153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E909BD769
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F955283C87
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4EF215C6C;
	Tue,  5 Nov 2024 21:06:11 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CA61D9A48
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730840769; cv=none; b=drMDwGpx6XbDI2eK2JzstMuLzj2GoAlldyp8jqn4C2uoCBae2VPCqQMyj3WC0HoZ96kfFpZr7uHmt7U0pB+tUThawlQds4X/R4+dml6+lUU4TjDYWL10H8v7i9zjH7QtIluO1EYQem76Fdv8iugoU+XLoukYIBfRRn8+R3Rq0Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730840769; c=relaxed/simple;
	bh=H1zkqv+8ZnZO5l7clSzoOq7z8CSTmN7c4Kxe2Cc81rs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m3hiWdknPEDMGfl8cFUFB9WF62J1pyVuCjhSQ84VJAfcSESjoRyYsRhnga8YfCY0AJUG4aFpQnyd2+ZgsoUMh2ECkhCTzaBHn9AbEZoJ7aG8q1aNHbEXAFHaxZne+P6fHupghzd5KjPLnymeEdbz0/CvTmc1pl8E4fkOat7eRTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83ac1f28d2bso620737939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 13:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730840765; x=1731445565;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1oA6cIybb2/aqUF1MmUzwoDy3AWuZs6TFUyPnhFgtsY=;
        b=oIhub8pDZqDYezMLyecOpYRY+cVpjUN+obtuK1upqZtNy8JySIB6MYMApXNbWfsKr0
         aLl/ZPT2eb6LjVAy+rwcnAu3XKfQX5skgmg4bg2CXIU1EPWpVO96UaN6htyV2U6YdaO6
         jTEkc5Kd7E4FTV+Y21opTbw3RD4tsE5cCFIY+6k5pI8rXkKZzBIOMLT9ZVJXl7Thl0qY
         vvrftDIcfcbeTVnEny28ma5sWDQ4ZXjbHUmO9f40Jn1eb6uQu9NTStL/T86KRqlEi4bi
         2vFtgxyhnKID0OksVxXKgJh9mj14cL8qDi8cUA3lF63Pgdz/W7c0XLqeYmdcjHvDgV9n
         MHIA==
X-Forwarded-Encrypted: i=1; AJvYcCWEUsROnbZJA31KzhlCIFFBeIK3bO2DT1MOVmKIKiemIb1ukkTa8sjO8Vf9APV6SFP72nECkU2McQ8UqvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU50bj5BXbDPf7cjtzedJOsYzgUEaRw4fgdfjkxM7Lz11CTyOL
	fKnpyxHygppzKFo2IiH8HiVJ4yJ0ewWpCtTwzp8o+U5nyIukpCgIFV7weBkv+Igorf6fM5HK6in
	wq5OgjmZ/J/h6puNl7Ny88YYPrSIfe/w5yktPalfxbZBhk84NvtNS3Jo=
X-Google-Smtp-Source: AGHT+IGYhgdzSY2y4/4FUhH/7b3LXf4sDtDZu2ak14ovTR0wpilK/q4gdy9F3XQakK2sTWcoMsyLzuIgOP8zLLuD6ypGvDLYdKDN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a12:b0:3a6:abdc:dfbe with SMTP id
 e9e14a558f8ab-3a6abdce332mr200204575ab.14.1730840764709; Tue, 05 Nov 2024
 13:06:04 -0800 (PST)
Date: Tue, 05 Nov 2024 13:06:04 -0800
In-Reply-To: <tencent_58E8CAEE52CF6C78226FB82CE56EDC94940A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672a88bc.050a0220.2a847.172d.GAE@google.com>
Subject: Re: [syzbot] [sound?] INFO: task hung in snd_card_free
From: syzbot <syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in snd_usx2y_probe

INFO: task kworker/0:0:8 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:25104 pid:8     tgid:8     ppid:2      flags:0x00004000
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
 snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:441
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
INFO: task kworker/0:3:5904 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:3     state:D stack:26080 pid:5904  tgid:5904  ppid:2      flags:0x00004000
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
 snd_usx2y_disconnect+0x22/0x230 sound/usb/usx2y/usbusx2y.c:412
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
INFO: task kworker/0:4:5912 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:4     state:D stack:25984 pid:5912  tgid:5912  ppid:2      flags:0x00004000
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
 snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:441
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
INFO: task kworker/0:5:5913 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D stack:26368 pid:5913  tgid:5913  ppid:2      flags:0x00004000
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
 snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:441
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
INFO: task udevd:6245 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:27232 pid:6245  tgid:6245  ppid:5201   flags:0x00000002
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
RIP: 0033:0x7fb774516b6a
RSP: 002b:00007ffe9a6a5ff8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055673771abd0 RCX: 00007fb774516b6a
RDX: 0000000000001000 RSI: 0000556737713800 RDI: 0000000000000008
RBP: 000055673771abd0 R08: 0000000000000008 R09: 0000000000000008
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffe9a6a64d8 R15: 000000000000000a
 </TASK>
INFO: task udevd:6273 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:27152 pid:6273  tgid:6273  ppid:5201   flags:0x00000002
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
RIP: 0033:0x7fb774516b6a
RSP: 002b:00007ffe9a6a4e28 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055673771abd0 RCX: 00007fb774516b6a
RDX: 0000000000001000 RSI: 000055673771cde0 RDI: 0000000000000008
RBP: 000055673771abd0 R08: 0000000000000008 R09: 0000000000040000
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffe9a6a5308 R15: 000000000000000a
 </TASK>
INFO: task udevd:6279 blocked for more than 146 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:27136 pid:6279  tgid:6279  ppid:5201   flags:0x00000002
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
RIP: 0033:0x7fb774516b6a
RSP: 002b:00007ffe9a6a5ff8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055673771abd0 RCX: 00007fb774516b6a
RDX: 0000000000001000 RSI: 000055673771d530 RDI: 0000000000000008
RBP: 000055673771abd0 R08: 0000000000000008 R09: 0000000000000008
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffe9a6a64d8 R15: 000000000000000a
 </TASK>
INFO: task udevd:6385 blocked for more than 146 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:27280 pid:6385  tgid:6385  ppid:5201   flags:0x00004002
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
RIP: 0033:0x7fb774516b6a
RSP: 002b:00007ffe9a6a5ff8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055673771abd0 RCX: 00007fb774516b6a
RDX: 0000000000001000 RSI: 000055673771dd90 RDI: 0000000000000008
RBP: 000055673771abd0 R08: 0000000000000008 R09: 0000000000000008
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffe9a6a64d8 R15: 000000000000000a
 </TASK>
INFO: task kworker/0:6:6485 blocked for more than 146 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:6     state:D stack:24560 pid:6485  tgid:6485  ppid:2      flags:0x00004000
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
 snd_card_free+0x1cc/0x250 sound/core/init.c:658
 snd_usx2y_disconnect+0x1aa/0x230 sound/usb/usx2y/usbusx2y.c:430
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
INFO: task syz.1.16:6491 blocked for more than 147 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.16        state:D stack:26096 pid:6491  tgid:6490  ppid:6337   flags:0x00000004
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
RIP: 0033:0x7fa9e657e719
RSP: 002b:00007fa9e57fe038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa9e6735f80 RCX: 00007fa9e657e719
RDX: 0000000000000000 RSI: 00000000c0105512 RDI: 0000000000000003
RBP: 00007fa9e65f132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa9e6735f80 R15: 00007ffc228d1e28
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
INFO: task syz.4.19:6495 blocked for more than 147 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.19        state:D stack:27680 pid:6495  tgid:6494  ppid:6349   flags:0x00000004
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
RIP: 0033:0x7f7c92d7e719
RSP: 002b:00007f7c93bd0038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7c92f35f80 RCX: 00007f7c92d7e719
RDX: 0000000000000000 RSI: 00000000c0105512 RDI: 0000000000000003
RBP: 00007f7c92df132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f7c92f35f80 R15: 00007ffef375c0d8
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
INFO: task syz.3.18:6507 blocked for more than 148 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.18        state:D stack:27632 pid:6507  tgid:6505  ppid:6339   flags:0x00000004
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
RIP: 0033:0x7fe68a37e719
RSP: 002b:00007fe68b094038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe68a535f80 RCX: 00007fe68a37e719
RDX: 0000000000000000 RSI: 00000000c0105512 RDI: 0000000000000003
RBP: 00007fe68a3f132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe68a535f80 R15: 00007ffc418b42b8
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
INFO: task syz.0.15:6517 blocked for more than 148 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.15        state:D stack:28384 pid:6517  tgid:6516  ppid:6332   flags:0x00000004
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
RIP: 0033:0x7fe1beb7d0b0
RSP: 002b:00007fe1bfa37b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000d81 RCX: 00007fe1beb7d0b0
RDX: 0000000000000d81 RSI: 00007fe1bfa37c10 RDI: 00000000ffffff9c
RBP: 00007fe1bfa37c10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fe1bed35f80 R15: 00007ffdbac6c328
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
INFO: task syz.2.17:6538 blocked for more than 149 seconds.
      Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.17        state:D stack:27216 pid:6538  tgid:6537  ppid:6338   flags:0x00000004
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
RIP: 0033:0x7fb4f517d0b0
RSP: 002b:00007fb4f5f78b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000d81 RCX: 00007fb4f517d0b0
RDX: 0000000000000d81 RSI: 00007fb4f5f78c10 RDI: 00000000ffffff9c
RBP: 00007fb4f5f78c10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fb4f5335f80 R15: 00007fff57a0f898
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings

Showing all locks held in the system:
6 locks held by kworker/0:0/8:
 #0: ffff888144eed148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900000d7d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff88802957c190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff88802957c190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff888012973190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888012973190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff88802569a160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88802569a160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8fe67f48 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:441
6 locks held by kworker/u8:1/12:
1 lock held by khungtaskd/30:
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
6 locks held by kworker/1:1/51:
 #0: ffff888144eed148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000bc7d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff8880296a6190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff8880296a6190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff8880510eb190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff8880510eb190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff888021757160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888021757160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8fe67f48 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:441
4 locks held by kworker/u9:0/54:
 #0: ffff888049a9d948 ((wq_completion)hci42#2){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000bf7d80 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888040814078 (&hdev->lock){+.+.}-{3:3}, at: hci_remote_features_evt+0x99/0x980 net/bluetooth/hci_event.c:3687
 #3: ffffffff9014c2a8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #3: ffffffff9014c2a8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_remote_features_evt+0x486/0x980 net/bluetooth/hci_event.c:3721
2 locks held by kworker/u8:5/742:
6 locks held by kworker/1:2/968:
 #0: ffff888144eed148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90003927d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff8880296a4190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff8880296a4190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff8880650e3190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff8880650e3190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff888024128160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888024128160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8fe67f48 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:441
3 locks held by kworker/u8:7/3645:
 #0: ffff888031af1948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000be0fd80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffffffff8fee3ae8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xcf/0x14d0 net/ipv6/addrconf.c:4196
5 locks held by kworker/u9:1/5139:
 #0: ffff888035753148 ((wq_completion)hci14){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900100e7d80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888020b6cd80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:331
 #3: ffff888020b6c078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5577
 #4: ffffffff9014c2a8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #4: ffffffff9014c2a8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x340 net/bluetooth/hci_conn.c:1265
2 locks held by getty/5578:
 #0: ffff88814dff20a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
6 locks held by kworker/0:3/5904:
 #0: ffff888144eed148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90005f2fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888029684190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888029684190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff88803268b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88803268b190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff88807c450160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88807c450160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88807c450160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
 #5: ffffffff8fe67f48 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_disconnect+0x22/0x230 sound/usb/usx2y/usbusx2y.c:412
6 locks held by kworker/0:4/5912:
 #0: ffff888144eed148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000433fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888029604190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888029604190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff8880794ef190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff8880794ef190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff88807c74a160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88807c74a160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8fe67f48 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:441
6 locks held by kworker/0:5/5913:
 #0: ffff888144eed148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90004ab7d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff8881447c9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff8881447c9190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff88801c77b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88801c77b190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff88806670d160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88806670d160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8fe67f48 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:441
4 locks held by udevd/6245:
 #0: ffff8880524a5790 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff8880565a3888 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff8880349a6d28 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff88801c77b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88801c77b190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
4 locks held by udevd/6273:
 #0: ffff88802b07ce80 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff88801c7d6088 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff88802035bf08 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff8880776a9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff8880776a9190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
4 locks held by udevd/6279:
 #0: ffff888069665b08 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff8880347dd088 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff8880656a9968 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff888012973190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888012973190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
5 locks held by kworker/u9:4/6345:
 #0: ffff8880532e2948 ((wq_completion)hci11){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000485fd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888028adcd80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:331
 #3: ffff888028adc078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5577
 #4: ffffffff9014c2a8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #4: ffffffff9014c2a8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x340 net/bluetooth/hci_conn.c:1265
5 locks held by kworker/u9:5/6347:
 #0: ffff888028dbf148 ((wq_completion)hci13){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900047efd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888074b58d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:331
 #3: ffff888074b58078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5577
 #4: ffffffff9014c2a8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #4: ffffffff9014c2a8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x340 net/bluetooth/hci_conn.c:1265
4 locks held by kworker/u9:6/6348:
 #0: ffff8880451d2148 ((wq_completion)hci44#2){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900042cfd80 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff8880427e8078 (&hdev->lock){+.+.}-{3:3}, at: hci_remote_features_evt+0x99/0x980 net/bluetooth/hci_event.c:3687
 #3: ffffffff9014c2a8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #3: ffffffff9014c2a8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_remote_features_evt+0x486/0x980 net/bluetooth/hci_event.c:3721
4 locks held by kworker/u9:8/6352:
 #0: ffff888028db8948 ((wq_completion)hci12){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000468fd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff88802a500d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:331
 #3: ffff88802a500078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5577
4 locks held by udevd/6385:
 #0: ffff88803051f9e0 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff888021b0c488 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff88805552e698 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff8880794ef190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff8880794ef190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
6 locks held by kworker/1:6/6422:
 #0: ffff888144eed148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000432fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff8881447fc190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff8881447fc190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff888053150190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888053150190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff888067045160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888067045160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8fe67f48 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:441
6 locks held by kworker/0:6/6485:
 #0: ffff888144eed148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90003cc7d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff8880776a9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff8880776a9190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff88802acbd160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88802acbd160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88802acbd160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
 #5: ffffffff8fe67f48 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_disconnect+0x22/0x230 sound/usb/usx2y/usbusx2y.c:412
1 lock held by syz.1.16/6491:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_do_ioctl drivers/usb/core/devio.c:2608 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_ioctl+0x1a9/0x4010 drivers/usb/core/devio.c:2824
1 lock held by syz.4.19/6495:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_do_ioctl drivers/usb/core/devio.c:2608 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_ioctl+0x1a9/0x4010 drivers/usb/core/devio.c:2824
6 locks held by kworker/1:7/6501:
 #0: ffff888144eed148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90003917d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888144b16190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888144b16190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff888065ef7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888065ef7190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff888066754160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888066754160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8fe67f48 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:441
1 lock held by syz.3.18/6507:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_do_ioctl drivers/usb/core/devio.c:2608 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_ioctl+0x1a9/0x4010 drivers/usb/core/devio.c:2824
1 lock held by syz.0.15/6517:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
6 locks held by kworker/0:8/6526:
 #0: ffff888144eed148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90003e67d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888029786190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888029786190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff88805516e190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88805516e190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff8880795de160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff8880795de160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8fe67f48 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:441
1 lock held by syz.2.17/6538:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
4 locks held by udevd/6578:
 #0: ffff88802849c1c8 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff88807a6bfc88 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff8880773011e8 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff8880650e3190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff8880650e3190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
4 locks held by udevd/6579:
 #0: ffff888027cb90a0 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff8880517df488 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff888067b923c8 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff888053150190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888053150190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
1 lock held by syz.6.21/6927:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.5.20/6929:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.7.22/6934:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.8.23/6937:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
4 locks held by udevd/6939:
 #0: ffff8880294e78b8 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff888031869088 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff8880785faa58 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff888065ef7190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888065ef7190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
4 locks held by udevd/6940:
 #0: ffff8880294e7668 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff88807d1b7488 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff88802afad878 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff8880510eb190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff8880510eb190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
1 lock held by syz.9.24/6942:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
4 locks held by udevd/6945:
 #0: ffff88807d179790 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff8880346d6c88 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff88801c3c9e18 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff88805516e190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88805516e190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
1 lock held by syz.1.25/6999:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.4.26/7020:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.0.27/7027:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.2.28/7030:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.3.29/7033:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.7.30/7091:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.5.31/7104:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.9.33/7137:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.8.32/7141:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.6.34/7142:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.1.35/7159:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.4.36/7212:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.0.37/7219:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.2.38/7227:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.3.39/7230:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.7.40/7252:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.5.41/7301:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.9.42/7328:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.8.43/7337:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.6.44/7340:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.1.45/7356:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.4.46/7385:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.0.47/7423:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.2.48/7430:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.3.49/7433:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.7.50/7455:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.5.51/7477:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
5 locks held by kworker/u9:9/7479:
 #0: ffff888052482148 ((wq_completion)hci10){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000bd3fd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888061fd8d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:331
 #3: ffff888061fd8078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5577
 #4: ffffffff9014c2a8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #4: ffffffff9014c2a8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x340 net/bluetooth/hci_conn.c:1265
1 lock held by syz.9.52/7523:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.6.54/7544:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.8.53/7548:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.1.55/7560:
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff8881447b9190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
6 locks held by syz-executor/7563:
 #0: ffff88807ad2c420 (sb_writers#11){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:736
 #1: ffff8880461aa088 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
 #2: ffffffff8e20f448 (cgroup_mutex){+.+.}-{3:3}, at: cgroup_lock include/linux/cgroup.h:368 [inline]
 #2: ffffffff8e20f448 (cgroup_mutex){+.+.}-{3:3}, at: cgroup_kn_lock_live+0x139/0x570 kernel/cgroup/cgroup.c:1662
 #3: ffffffff8e05b950 (cpu_hotplug_lock){++++}-{0:0}, at: cgroup_attach_lock kernel/cgroup/cgroup.c:2435 [inline]
 #3: ffffffff8e05b950 (cpu_hotplug_lock){++++}-{0:0}, at: cgroup_procs_write_start+0x18f/0x660 kernel/cgroup/cgroup.c:2939
 #4: ffffffff8e20f210 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: cgroup_attach_lock kernel/cgroup/cgroup.c:2437 [inline]
 #4: ffffffff8e20f210 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: cgroup_attach_lock kernel/cgroup/cgroup.c:2433 [inline]
 #4: ffffffff8e20f210 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: cgroup_procs_write_start+0x19b/0x660 kernel/cgroup/cgroup.c:2939
 #5: ffffffff8e1c3c38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x1a4/0x3b0 kernel/rcu/tree_exp.h:329
2 locks held by syz-executor/7582:
 #0: ffffffff8fee3ae8 (
rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6672
 #1: ffffffff8e1c3c38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x1a4/0x3b0 kernel/rcu/tree_exp.h:329
1 lock held by syz-executor/7590:
 #0: ffffffff8fee3ae8 (rtnl_mutex
){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6672
1 lock held by syz-executor/7592:
 #0: ffffffff8fee3ae8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fee3ae8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6672
1 lock held by syz-executor/7595:
 #0: ffffffff8fee3ae8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fee3ae8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6672

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7-dirty #0
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
CPU: 1 UID: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:unwind_next_frame+0x4d0/0x20c0 arch/x86/kernel/unwind_orc.c:505
Code: e8 55 f1 ff ff 48 85 c0 48 89 c1 0f 84 13 fe ff ff 4c 8d 79 05 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 0f b6 04 02 <4c> 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 d8 13 00 00 0f b6 41 05
RSP: 0018:ffffc90000106dc0 EFLAGS: 00000a06
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff91996f1c
RDX: 1ffffffff2332de4 RSI: 0000000000000000 RDI: ffffffff90dfb898
RBP: ffffc90000106e78 R08: ffffffff91996f52 R09: ffffffff9197603a
R10: ffffc90000106e30 R11: 0000000000098df2 R12: ffffc90000106e80
R13: ffffc90000106e30 R14: ffffc90000106e65 R15: ffffffff91996f21
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f272f508000 CR3: 000000000df7c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 arch_stack_walk+0x95/0x100 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
 kvfree_call_rcu+0x74/0xbe0 kernel/rcu/tree.c:3810
 cfg80211_update_known_bss+0x3c0/0x11e0 net/wireless/scan.c:1891
 __cfg80211_bss_update+0x1aa/0x2440 net/wireless/scan.c:1938
 cfg80211_inform_single_bss_data+0x7af/0x1de0 net/wireless/scan.c:2329
 cfg80211_inform_bss_data+0x205/0x3ba0 net/wireless/scan.c:3188
 cfg80211_inform_bss_frame_data+0x271/0x7a0 net/wireless/scan.c:3283
 ieee80211_bss_info_update+0x311/0xab0 net/mac80211/scan.c:226
 ieee80211_rx_bss_info net/mac80211/ibss.c:1100 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1579 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1898/0x2f40 net/mac80211/ibss.c:1606
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

commit:         2e1b3cc9 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d58f40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2effb62852f5a821
dashboard link: https://syzkaller.appspot.com/bug?extid=73582d08864d8268b6fd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=149a0f40580000


