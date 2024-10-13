Return-Path: <linux-kernel+bounces-362690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1013F99B817
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 05:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63AB41F2359E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 03:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D969785C47;
	Sun, 13 Oct 2024 03:05:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFED80C0A
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 03:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728788705; cv=none; b=MteWOxlf88aTthcwJBDnsFNNSmw+mGX2cgfyNrEz/xlxgay6xukFvnspbHBcAfdVXMO/GRd4YQegAqtK0sYhyCwQ3iP2pYDYdlJsVvc8bFNG5ORYrdcjCOtv/SKw83vuJBvPF/K/WueOcN/wdGjgXQ88PALT/4+8qMk3KaOPeU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728788705; c=relaxed/simple;
	bh=NGq08Nhl+tZZTbFrcM+2gF2sUToed7ZceWkAxKS83e8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jFRMRnOchs/cIFoXL+rS7iI41oT0++CP3HIYe3cbFLyQOOxWFB/ULYLjY6a5p3UF28BaT9lelqGWcBNEvBTghJ4wzq8PgbCxmyDlRhiz32+PtrwNWfwEZ4NPPUkWjoWM5h3IQWL7G8Bmm3uC7UAbdRcqhxYntnkeo3gT/G/GmN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83542e22fd7so252056639f.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 20:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728788703; x=1729393503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3L6dMbeIGYMosD58ekyPLFl7WLFvZfRSjKYR7zx8GZI=;
        b=NYtdUgMHiBmwMrJySZjmRW4dXNSkJcN3iiNXIwgqP6PgQMFspk0vox7OXk7d45G27n
         6CDBnmayd2EnVAKBvGLjMsnQ7zNsocJGjfyLjrp7jzqJMK+Ldw1yZ+3FwCZrR1uWWaoW
         zz4RzK9v0Mnwzfd9tWPSS3E68M5Bru7YRzHos3URqIr6PMr7QN7+qU+kqMrbuiLA+vSe
         if5p2c4RJ+GovIZvnaHf91LSazqAhNOsgHTw5NfUd1Xh8trpGpQy7Lq3nkigaKqiYIdh
         psk//m9IRX5h504Ysqvn53jykY7WkgCVAtWSRLTHPv98/LZmfPV2fGN96gq7gNDhMUf9
         YgsA==
X-Forwarded-Encrypted: i=1; AJvYcCWQggCUSNtqOTCw2VtPRUrJo7RCZOSIsmsAobcBTG3H1NicQt3vmkaao8BVFCmJ1CexSKlSZJoFzIFhQrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvSr5erpMM/gyE+v7G6WKaecjWItZ4Uv83/9cJfwMpskzkBWHw
	DZo1/QmMIzi+Ae+9HWVMHqRKOjXFTBJRs2C7HnhrUPyivuEqpg3/2mU4CXN4Kkr7G6dfso6HEx6
	nod/63N68XCSFVe7gBwGlnHVhjfoGyJUF1BCbtz/nEkNSZ9EYJL4/NYk=
X-Google-Smtp-Source: AGHT+IHc12w2AymHYOedglpW9JQ1cvwmOj3yUfq6oE0+2+JhgiwTEW7CJBoRk7DVDmvhAARuQ4RIZxnKdk5OK09GBpKOInU9u4ZF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cd:b0:3a0:a71b:75e5 with SMTP id
 e9e14a558f8ab-3a3bcdb421amr29369125ab.7.1728788702800; Sat, 12 Oct 2024
 20:05:02 -0700 (PDT)
Date: Sat, 12 Oct 2024 20:05:02 -0700
In-Reply-To: <d6ec3898-b225-4c92-a381-46b111b6ddcf@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670b38de.050a0220.3e960.0032.GAE@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
From: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, stern@rowland.harvard.edu, sylv@sylv.io, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in usb_register_dev

INFO: task kworker/0:1:9 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:23264 pid:9     tgid:9     ppid:2      flags:0x00004000
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
INFO: task kworker/1:6:6753 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:6     state:D stack:23440 pid:6753  tgid:6753  ppid:2      flags:0x00004000
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
 usb_deregister_dev+0x7c/0x1e0 drivers/usb/core/file.c:186
 wdm_disconnect+0x25/0x440 drivers/usb/class/cdc-wdm.c:1214
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
INFO: task syz.4.420:7346 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.420       state:D stack:27856 pid:7346  tgid:7346  ppid:4266   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 wdm_release+0x4b/0x440 drivers/usb/class/cdc-wdm.c:764
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x24e/0x260 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f303702dff9
RSP: 002b:00007ffd93148178 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f30371e7a80 RCX: 00007f303702dff9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f30371e7a80 R08: 0000000000000000 R09: 00007ffd9314846f
R10: 000000000003fdc8 R11: 0000000000000246 R12: 000000000003aee8
R13: 00007ffd93148280 R14: 0000000000000032 R15: ffffffffffffffff
 </TASK>
INFO: task syz.2.421:7348 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.421       state:D stack:27856 pid:7348  tgid:7348  ppid:4257   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 wdm_release+0x4b/0x440 drivers/usb/class/cdc-wdm.c:764
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x24e/0x260 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4e8801dff9
RSP: 002b:00007ffe1f7d36a8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f4e881d7a80 RCX: 00007f4e8801dff9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f4e881d7a80 R08: 0000000000000000 R09: 00007ffe1f7d399f
R10: 000000000003fdc8 R11: 0000000000000246 R12: 000000000003af53
R13: 00007ffe1f7d37b0 R14: 0000000000000032 R15: ffffffffffffffff
 </TASK>
INFO: task syz.3.422:7351 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.422       state:D stack:28352 pid:7351  tgid:7350  ppid:4259   flags:0x00004004
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
 wdm_open+0x24a/0x630 drivers/usb/class/cdc-wdm.c:730
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
RIP: 0033:0x7fb2ca20c990
RSP: 002b:00007fb2c9c88b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fb2ca20c990
RDX: 0000000000000002 RSI: 00007fb2c9c88c10 RDI: 00000000ffffff9c
RBP: 00007fb2c9c88c10 R08: 0000000000000000 R09: 00007fb2c9c88987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb2ca3c5f80 R15: 00007fff7f2b3468
 </TASK>
INFO: task syz.1.423:7353 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.423       state:D stack:28432 pid:7353  tgid:7352  ppid:4252   flags:0x00000004
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
RIP: 0033:0x7f2d754ac990
RSP: 002b:00007f2d74f2eb70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f2d754ac990
RDX: 0000000000000002 RSI: 00007f2d74f2ec10 RDI: 00000000ffffff9c
RBP: 00007f2d74f2ec10 R08: 0000000000000000 R09: 00007f2d74f2e987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2d75665f80 R15: 00007ffc6abf00b8
 </TASK>

Showing all locks held in the system:
6 locks held by kworker/0:1/9:
 #0: ffff8881066c4148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000009fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888109b47190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888109b47190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff8881158fc190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff8881158fc190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff888105e99160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888105e99160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_register_dev+0x11c/0x550 drivers/usb/core/file.c:134
1 lock held by khungtaskd/30:
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
2 locks held by kworker/u8:3/46:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000517d80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:4/52:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000537d80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:6/1273:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000263fd80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:7/1278:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900028dfd80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:9/1292:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000291fd80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by getty/2607:
 #0: ffff88810f77c0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
3 locks held by kworker/1:3/6523:
 #0: ffff8881022f8948 ((wq_completion)pm){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000271fd80 ((work_completion)(&dev->power.work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff8881097ba508 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3206 [inline]
 #2: ffff8881097ba508 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_port_suspend+0x255/0xf10 drivers/usb/core/hub.c:3463
6 locks held by kworker/1:6/6753:
 #0: ffff8881066c4148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000219fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888107f29190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888107f29190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff88811ca06190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88811ca06190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff8881056bb160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff8881056bb160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff8881056bb160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
 #5: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_deregister_dev+0x7c/0x1e0 drivers/usb/core/file.c:186
1 lock held by syz.4.420/7346:
 #0: ffffffff89a967e8 (wdm_mutex){+.+.}-{3:3}, at: wdm_release+0x4b/0x440 drivers/usb/class/cdc-wdm.c:764
1 lock held by syz.2.421/7348:
 #0: ffffffff89a967e8 (wdm_mutex){+.+.}-{3:3}, at: wdm_release+0x4b/0x440 drivers/usb/class/cdc-wdm.c:764
2 locks held by syz.3.422/7351:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
 #1: ffffffff89a967e8 (wdm_mutex){+.+.}-{3:3}, at: wdm_open+0x5d/0x630 drivers/usb/class/cdc-wdm.c:715
1 lock held by syz.1.423/7353:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.2.427/9127:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.428/9134:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.431/9194:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.1.430/9202:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.443/11017:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.444/11022:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.2.442/11035:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.1.446/11054:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.460/12868:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.459/12898:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.1.457/12900:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.2.458/12906:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.1.472/14705:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.473/14736:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.474/14738:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.2.476/14758:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by kworker/u8:4/15060:
1 lock held by modprobe/15085:
5 locks held by modprobe/15086:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53-dirty #0
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
CPU: 1 UID: 0 PID: 15093 Comm: modprobe Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:write_comp_data+0x42/0x90 kernel/kcov.c:246
Code: a9 00 01 ff 00 74 1d f6 c4 01 74 67 a9 00 00 0f 00 75 60 a9 00 00 f0 00 75 59 8b 82 54 15 00 00 85 c0 74 4f 8b 82 30 15 00 00 <83> f8 03 75 44 48 8b 82 38 15 00 00 8b 92 34 15 00 00 48 8b 38 48
RSP: 0018:ffffc9000372f608 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000004 RCX: ffffffff86e38149
RDX: ffff888101b0ba80 RSI: 0000000000000003 RDI: 0000000000000005
RBP: ffffffff88107300 R08: 0000000000000005 R09: 0000000000000003
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000005 R14: 0000000000000004 R15: 00007f6e25c01fff
FS:  00007f6e25b75380(0000) GS:ffff8881f5900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6e25c82c39 CR3: 000000010f392000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __sanitizer_cov_trace_switch+0x54/0x90 kernel/kcov.c:351
 ma_slots lib/maple_tree.c:761 [inline]
 mas_get_slot lib/maple_tree.c:7065 [inline]
 mas_validate_gaps lib/maple_tree.c:7331 [inline]
 mt_validate+0x2809/0x41b0 lib/maple_tree.c:7606
 validate_mm+0xae/0x4d0 mm/vma.c:534
 __split_vma+0xcd3/0x1130 mm/vma.c:431
 split_vma mm/vma.c:460 [inline]
 vma_modify+0x156b/0x2400 mm/vma.c:1433
 vma_modify_flags+0x1c4/0x250 mm/vma.c:1451
 mprotect_fixup+0x2c2/0xbe0 mm/mprotect.c:664
 do_mprotect_pkey+0x98e/0xd00 mm/mprotect.c:838
 __do_sys_mprotect mm/mprotect.c:859 [inline]
 __se_sys_mprotect mm/mprotect.c:856 [inline]
 __x64_sys_mprotect+0x78/0xc0 mm/mprotect.c:856
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6e25e99bb7
Code: 00 00 00 b8 0b 00 00 00 0f 05 48 3d 01 f0 ff ff 73 01 c3 48 8d 0d b9 46 01 00 f7 d8 89 01 48 83 c8 ff c3 b8 0a 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8d 0d 99 46 01 00 f7 d8 89 01 48 83
RSP: 002b:00007ffe2a205b08 EFLAGS: 00000206 ORIG_RAX: 000000000000000a
RAX: ffffffffffffffda RBX: 00007f6e25e765c0 RCX: 00007f6e25e99bb7
RDX: 0000000000000001 RSI: 0000000000004000 RDI: 00007f6e25da0000
RBP: 00007ffe2a205c20 R08: 00007ffe2a200000 R09: 00007f6e25eadab0
R10: 00007f6e25c06ab8 R11: 0000000000000206 R12: 00007f6e25e765c0
R13: 00007f6e25ea1eda R14: 00007f6e25da3bf8 R15: 00007f6e25da3b70
 </TASK>


Tested on:

commit:         4a9fe2a8 dt-bindings: usb: dwc3-imx8mp: add compatible..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=15babfd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=f342ea16c9d06d80b585
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16dc8440580000


