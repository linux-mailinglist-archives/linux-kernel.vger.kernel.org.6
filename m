Return-Path: <linux-kernel+bounces-395877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D7E9BC445
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C7E7B2157B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB11218756D;
	Tue,  5 Nov 2024 04:18:09 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CBAA2D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 04:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730780287; cv=none; b=WUPzHh1kV2nQfF4dnNlfhmsOktBMjLxmr6puUZh+D/cJb2CKgUOJSVZSMlc4JNIkXWjwt6gjUKgEB1s/PxEZIeIeKTjW8eR44F4rTFs2sWWjmbHwP8sZhqRaq1t9KKY9CWUcwicja3XvJgURfhF3lu6iN1XX9aT+JnQ2TW43iSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730780287; c=relaxed/simple;
	bh=UFQcvDRotMUDvvBL/OUgZxbalzf4Tab1NPzWRKgHTy0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CYurOSg7kxLnXLqkOJMUJWOxSpBVYginTb5xCf1LXeUm/Jjapy3IZFE5kNaMpYsswCm19SZyGlvM7umbSYumve9tCOudtM678O2O9OUQCbnfGfo8yiC/jHCEtybBjf/mvNJPJ6Yj9O5BYvSEzf/y03DzoCJfs9O/58RZKS4zbwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c72d4ac4so54237405ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 20:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730780283; x=1731385083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+HodXbI7JGI3UWqn5f+mQIk1y/ERll1L5q6DOYhVVs=;
        b=j8QO+uFdweg7P2gxXU3OJDGNFXOkL3wylN/7dOdr5bvYMfMKyDgVAq9+ApR1LcL+6D
         gKIb4It0Zgu6qIUUtXV2pdEqPuug3nq1a0aD0g6HivoJsAW3SXAQRqYRRn7tUzo+W1dG
         E3B+FfDwrWkfTEkYUoL0qHGSUlHdYjONRuPXKu1CH9YUgZ06E5Vwi0WPkwMZNOvIQ3jx
         JlPCwRiBcg7x5FV74MazjAkN4UgsNtw6w6QRzBUzNJLdET1a4hNy74hMWR5KygKvIe5X
         vdelbkKoge4LhQiL49iB2fyfO1rJaDpzvRmZPefxyRZ3HYj32NidBXE3q0De9F8jTg5p
         bUkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAlR2pCw0II22u1wWcvoHwQDq1SV6OumSgda/VEdOPN6UZlV/df35SiEm2pt0AVkTtqNpMznrSy3Pan6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDSfhZNSRD0uf9a9mTjUMpNMQYk7uorm2YbcAuXzJkT6RS/zYY
	zfj3It+grg6tOGggkMpzCbZJ8ewkK2LLcUx/MXkjlPa5rJz4pGyfj69a0dLPRgUZSIG/9E16mtN
	vOgu/uMIk6/EHgQLZkMd7fnt3Sxnt1P0MFkFKdex/wSb38Km1A4GDjLQ=
X-Google-Smtp-Source: AGHT+IFwECl1BZr+ykr7blNfhh2sZ+c4NGFhrf+8UlzmofnHE6bYOxrdMwEMt4a3eXE8/5JY4K62GwocK/EwvZ8Z8bUnxBYQJkUb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c243:0:b0:3a0:9fd8:f70b with SMTP id
 e9e14a558f8ab-3a5e245844emr212065325ab.6.1730780283159; Mon, 04 Nov 2024
 20:18:03 -0800 (PST)
Date: Mon, 04 Nov 2024 20:18:03 -0800
In-Reply-To: <tencent_31F4971436464B9475FB763166423D473709@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67299c7b.050a0220.2edce.1500.GAE@google.com>
Subject: Re: [syzbot] [sound?] INFO: task hung in snd_card_free
From: syzbot <syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in snd_usx2y_probe

INFO: task kworker/0:1:9 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:24016 pid:9     tgid:9     ppid:2      flags:0x00004000
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
INFO: task kworker/1:1:51 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:24928 pid:51    tgid:51    ppid:2      flags:0x00004000
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
 snd_card_free+0x128/0x190 sound/core/init.c:656
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
INFO: task kworker/1:3:5905 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:3     state:D stack:22720 pid:5905  tgid:5905  ppid:2      flags:0x00004000
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
INFO: task kworker/0:4:5989 blocked for more than 147 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:4     state:D stack:26384 pid:5989  tgid:5989  ppid:2      flags:0x00004000
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
INFO: task udevd:6311 blocked for more than 147 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:27216 pid:6311  tgid:6311  ppid:5199   flags:0x00000002
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
RIP: 0033:0x7f6f46d16b6a
RSP: 002b:00007ffe20c8c6f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00005620db10aa70 RCX: 00007f6f46d16b6a
RDX: 0000000000001000 RSI: 00005620db12a1b0 RDI: 0000000000000008
RBP: 00005620db10aa70 R08: 0000000000000008 R09: 0000000000000000
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffe20c8cbd8 R15: 000000000000000a
 </TASK>
INFO: task udevd:6332 blocked for more than 147 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:27216 pid:6332  tgid:6332  ppid:5199   flags:0x00000002
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
RIP: 0033:0x7f6f46d16b6a
RSP: 002b:00007ffe20c8c6f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00005620db10aa70 RCX: 00007f6f46d16b6a
RDX: 0000000000001000 RSI: 00005620db12c910 RDI: 0000000000000008
RBP: 00005620db10aa70 R08: 0000000000000008 R09: 0000000000000000
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffe20c8cbd8 R15: 000000000000000a
 </TASK>
INFO: task syz.3.22:6550 blocked for more than 148 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.22        state:D stack:26352 pid:6550  tgid:6549  ppid:6391   flags:0x00000004
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
RIP: 0033:0x7f87b437e719
RSP: 002b:00007f87b51db038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f87b4535f80 RCX: 00007f87b437e719
RDX: 0000000000000000 RSI: 00000000c0105512 RDI: 0000000000000003
RBP: 00007f87b43f132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f87b4535f80 R15: 00007fff56f3bd58
 </TASK>
INFO: task syz.1.16:6557 blocked for more than 148 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.16        state:D stack:27632 pid:6557  tgid:6556  ppid:6384   flags:0x00000004
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
RIP: 0033:0x7ff338b7e719
RSP: 002b:00007ff3398cb038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff338d35f80 RCX: 00007ff338b7e719
RDX: 0000000000000000 RSI: 00000000c0105512 RDI: 0000000000000003
RBP: 00007ff338bf132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ff338d35f80 R15: 00007ffda8d7b3f8
 </TASK>
INFO: task kworker/1:6:6588 blocked for more than 149 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:6     state:D stack:26832 pid:6588  tgid:6588  ppid:2      flags:0x00004000
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
INFO: task syz.0.15:6617 blocked for more than 149 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.15        state:D stack:28384 pid:6617  tgid:6615  ppid:6386   flags:0x00000004
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
RIP: 0033:0x7f0db2f7d0b0
RSP: 002b:00007f0db21fdb70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000d81 RCX: 00007f0db2f7d0b0
RDX: 0000000000000d81 RSI: 00007f0db21fdc10 RDI: 00000000ffffff9c
RBP: 00007f0db21fdc10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f0db3135f80 R15: 00007ffeb5dc5cc8
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
INFO: task syz.2.17:6621 blocked for more than 150 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.17        state:D stack:27024 pid:6621  tgid:6619  ppid:6396   flags:0x00004004
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
RIP: 0033:0x7f22d457d0b0
RSP: 002b:00007f22d5366b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000d81 RCX: 00007f22d457d0b0
RDX: 0000000000000d81 RSI: 00007f22d5366c10 RDI: 00000000ffffff9c
RBP: 00007f22d5366c10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f22d4735f80 R15: 00007ffdd9d18a78
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
INFO: task syz.4.19:6627 blocked for more than 150 seconds.
      Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.19        state:D stack:27680 pid:6627  tgid:6626  ppid:6398   flags:0x00004004
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
RIP: 0033:0x7f8b8957d0b0
RSP: 002b:00007f8b8a376b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000d81 RCX: 00007f8b8957d0b0
RDX: 0000000000000d81 RSI: 00007f8b8a376c10 RDI: 00000000ffffff9c
RBP: 00007f8b8a376c10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f8b89735f80 R15: 00007ffdd1dfae68
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings

Showing all locks held in the system:
6 locks held by kworker/0:1/9:
 #0: ffff88801b14b948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900000e7d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888144fa0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888144fa0190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff88803642b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88803642b190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff88803371b160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88803371b160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8fe67c88 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:441
3 locks held by kworker/u8:0/11:
 #0: ffff88814d396148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000107d80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffffffff8fee3828 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xcf/0x14d0 net/ipv6/addrconf.c:4196
1 lock held by khungtaskd/30:
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
6 locks held by kworker/1:1/51:
 #0: ffff88801b14b948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000bc7d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888029210190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888029210190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff88805eb5c190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88805eb5c190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff8880797b6160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff8880797b6160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff8880797b6160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
 #5: ffffffff8fe67c88 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_disconnect+0x22/0x230 sound/usb/usx2y/usbusx2y.c:412
3 locks held by kworker/u8:3/52:
6 locks held by kworker/0:2/969:
 #0: ffff88801b14b948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90003e57d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888144fc0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888144fc0190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff88806880a190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88806880a190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff888031dc4160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888031dc4160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8fe67c88 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:441
1 lock held by syslogd/5181:
 #0: ffff8880b863ee98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:598
1 lock held by klogd/5188:
 #0: ffff8880b863ee98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:598
2 locks held by getty/5582:
 #0: ffff888037c0a0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
6 locks held by kworker/0:3/5861:
 #0: ffff88801b14b948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90004447d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888145330190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888145330190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff88802558c190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88802558c190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff888029550160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888029550160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8fe67c88 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:441
6 locks held by kworker/1:3/5905:
 #0: ffff88801b14b948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90003f07d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888029228190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888029228190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff8880636a9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff8880636a9190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff88802618d160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88802618d160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8fe67c88 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:441
6 locks held by kworker/0:4/5989:
 #0: ffff88801b14b948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90004dafd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff88802ad74190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88802ad74190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff88802b17f160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88802b17f160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88802b17f160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
 #5: ffffffff8fe67c88 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_disconnect+0x22/0x230 sound/usb/usx2y/usbusx2y.c:412
4 locks held by udevd/6298:
 #0: ffff888021b531c8 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff88803176e888 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff8880741142d8 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff88802558c190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88802558c190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
4 locks held by udevd/6311:
 #0: ffff8880300780a0 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff888068868488 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff8880307bdf08 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff88803642b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88803642b190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
4 locks held by udevd/6332:
 #0: ffff888033594e80 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff88807fb58888 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff8880372142d8 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff888036e8f190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888036e8f190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
4 locks held by udevd/6333:
 #0: ffff888036c06790 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff8880660a5888 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff8880325dfb48 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff88806880a190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88806880a190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
3 locks held by kworker/u9:5/6393:
 #0: ffff8880339ed148 ((wq_completion)hci14){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000381fd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888032058d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:331
4 locks held by udevd/6436:
 #0: ffff88803044e0a0 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff888030e9f088 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff88805ed165a8 (kn->active#29){.+.+}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff888030cec190 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:1019 [inline]
 #3: ffff888030cec190 (&dev->mutex){....}-{3:3}, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142
1 lock held by syz.3.22/6550:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_do_ioctl drivers/usb/core/devio.c:2608 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_ioctl+0x1a9/0x4010 drivers/usb/core/devio.c:2824
1 lock held by syz.1.16/6557:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_do_ioctl drivers/usb/core/devio.c:2608 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_ioctl+0x1a9/0x4010 drivers/usb/core/devio.c:2824
6 locks held by kworker/1:6/6588:
 #0: ffff88801b14b948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000344fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888144fb1190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888144fb1190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff888036e8f190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888036e8f190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff88802618e160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88802618e160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8fe67c88 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:441
6 locks held by kworker/1:8/6591:
 #0: ffff88801b14b948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000341fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888145318190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888145318190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff888030cec190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888030cec190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff888069111160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888069111160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8fe67c88 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:441
1 lock held by syz.0.15/6617:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.2.17/6621:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
6 locks held by kworker/0:6/6623:
 #0: ffff88801b14b948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90004747d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888029368190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888029368190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff88807eb81190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88807eb81190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff888037284160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888037284160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8fe67c88 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:441
1 lock held by syz.4.19/6627:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.5.23/6891:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
4 locks held by udevd/6897:
 #0: ffff888062295b08 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff88807fbda488 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff888069384d28 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff88805ee58190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88805ee58190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
1 lock held by syz.6.24/6926:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
4 locks held by udevd/6934:
 #0: ffff8880622959e0 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xd8/0x12b0 fs/seq_file.c:182
 #1: ffff88807fbd9088 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff8880284a6c38 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff88807eb81190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88807eb81190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2736
3 locks held by kworker/u8:8/6948:
 #0: ffff88801b081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000338fd80 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffffffff8fee3828 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0x51/0xc0 net/core/link_watch.c:276
1 lock held by syz.7.25/6968:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
6 locks held by kworker/1:10/6971:
 #0: ffff88801b14b948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90002e4fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888029358190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888029358190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff88805ee58190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88805ee58190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff88803745b160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88803745b160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8fe67c88 (devices_mutex){+.+.}-{3:3}, at: snd_usx2y_probe+0xaf/0x9c0 sound/usb/usx2y/usbusx2y.c:441
1 lock held by syz.9.27/6974:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.8.26/6975:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.3.28/6999:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.1.29/7014:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.0.30/7048:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.2.31/7065:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.4.32/7068:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.5.33/7096:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.6.34/7112:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.7.35/7144:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.8.36/7175:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.9.37/7178:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.3.38/7200:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.1.39/7210:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.0.40/7226:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.2.41/7251:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.4.42/7264:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.5.43/7291:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.6.44/7315:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.7.45/7330:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.8.46/7361:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.9.47/7377:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.3.48/7390:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.1.49/7413:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.0.50/7428:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.2.51/7453:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.4.52/7475:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.5.53/7497:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.6.54/7519:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.7.55/7536:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.8.56/7562:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.9.57/7585:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.3.58/7601:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
1 lock held by syz.1.59/7620:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051
2 locks held by syz-executor/7627:
 #0: ffffffff8fee3828 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fee3828 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6672
 #1: ffffffff8e1c3c38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x282/0x3b0 kernel/rcu/tree_exp.h:297
2 locks held by syz-executor/7633:
 #0: ffffffff8fecde10 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x292/0x6b0 net/core/net_namespace.c:490
 #1: ffffffff8fee3828 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x1b/0x70 net/ipv4/nexthop.c:3885
1 lock held by syz.0.60/7639:
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144fb0190 (&dev->mutex){....}-{3:3}, at: usbdev_open+0x1b8/0x8c0 drivers/usb/core/devio.c:1051

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
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
CPU: 1 UID: 0 PID: 6948 Comm: kworker/u8:8 Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:orc_find arch/x86/kernel/unwind_orc.c:217 [inline]
RIP: 0010:unwind_next_frame+0x1c8/0x20c0 arch/x86/kernel/unwind_orc.c:494
Code: 56 ff 39 d0 0f 83 09 15 00 00 48 ba 00 00 00 00 00 fc ff df 89 c1 48 8d 3c 8d 4c b2 aa 91 49 89 f8 49 c1 e8 03 45 0f b6 04 10 <48> 89 fa 83 e2 07 83 c2 03 44 38 c2 7c 2f 45 84 c0 74 2a 48 89 4c
RSP: 0018:ffffc9000338f6f8 EFLAGS: 00000a03
RAX: 0000000000099168 RBX: 0000000000000001 RCX: 0000000000099168
RDX: dffffc0000000000 RSI: 00000000000a6001 RDI: ffffffff91d0f7ec
RBP: ffffc9000338f7b0 R08: 0000000000000000 R09: ffffffff917fb79a
R10: ffffc9000338f768 R11: 0000000000099168 R12: ffffc9000338f7b8
R13: ffffc9000338f768 R14: ffffc9000338f79d R15: ffffffff8a916806


Tested on:

commit:         2e1b3cc9 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1529a740580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2effb62852f5a821
dashboard link: https://syzkaller.appspot.com/bug?extid=73582d08864d8268b6fd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11210e30580000


