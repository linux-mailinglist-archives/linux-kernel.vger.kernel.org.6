Return-Path: <linux-kernel+bounces-361162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1915199A476
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66BE28591F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988092185B8;
	Fri, 11 Oct 2024 13:08:34 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26585216A14
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652113; cv=none; b=b47EaDCFAy4veQNx1Hr/fywX+5UJmOmDUky+PyG2w9tV084WX+QgCDy49Mnp6orR+6JbVBUoVsWdYQtFJ4kj42R6o0QqH1g1O3fkLIvT9ill3QRQiDFiY8y179aBhz9MtXLgbvgPp5EEsSm0XzqHNXrZKhPTV9kfFlJ3QuEGbXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652113; c=relaxed/simple;
	bh=vqshVVOgZ5ipJcru97Y9en+U+e3b2QA7B3NOY6GuKuY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fIxcHXzULOLbXyfGfkUzjbWgqKPb0aGItQhOzXCXPRzgcCMW7E/CrJdum17uOIfRG6flG8On/kIoB82v+s6IEjjJTIynNpTul5UN7XyqasivkolHJIJ8c/x/U9/GXRPnC0XEysTBz1rfw/NZ3y4GueugPRYJdp4C180HjPpRX1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3a6afd01eso15990255ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728652110; x=1729256910;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kAvLKZJXK/eKP/tizfLCVlW9PMZ+4jQFhMY//1PRQ5Q=;
        b=qxS2iO1fymfQa3jJnt0AhsZ3jdfbJu3BGFqlS6yWWnKWJ/rLnQ5LUdVtoq1rvzivAF
         zYu8lUAURE1Xb1JSFYfc6VIypDf1lV6116iNqOCCfmAk+sFfuM+q0OfNFw/28Zy5AVHa
         bFXxUhDM0Q4UHYVAOQ6fJ/J7fIWZw16x0a3yKghMfw6MYrU9kUaKDuR5RmOsoWIczRo7
         Umwl0DMRBb4dTlEXd21X7wiDel2fPFrKWlSbDsmO6iQGl6uliuxs9I2M2GalZ/SnBEuN
         4HpSLgtrdx8GLrXODLo/1Zjt2yhEPVKI/MpD+c5FKQIptEaxVI1gHJzpynO50zNUQgw5
         S5ow==
X-Forwarded-Encrypted: i=1; AJvYcCX8UIdTzRWYtTb5E6RcJE30x6r5DVbGvipJt5FjVHS56QQv/ZYbQgLG0K4w4QK3PGFItgCm4Dm8YxP0ov0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQii3xMEs7yFTOEyz4BjESP8if4cmY8lW1Pai25uJMTwUrVgzs
	WTWN98/fvjazVewujgxTl5dTVxI4krQqeJH6BfU214nXMy8lQI5TrHIqKML/RH0i4mkC027OKil
	cuMw2RUlO2Gt0UsfH5xF5BCFJ+K2UdECDy3FaRPG2aLtLnv6kqYkgr4U=
X-Google-Smtp-Source: AGHT+IHzPYZJ4+vg4Z6BUimUHzhHORpMXreJ0RJ9cwoOH8OWh0gbmgs4geNU2qzzNaq4YbzpCBikFF+nkta/f6Lh+eO1A6+WLGeR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0b:b0:39d:4ef6:b36d with SMTP id
 e9e14a558f8ab-3a3b5f3f06fmr14504995ab.7.1728652110076; Fri, 11 Oct 2024
 06:08:30 -0700 (PDT)
Date: Fri, 11 Oct 2024 06:08:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6709234e.050a0220.3e960.0011.GAE@google.com>
Subject: [syzbot] [usb?] INFO: task hung in usb_port_suspend
From: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a9fe2a8ac53 dt-bindings: usb: dwc3-imx8mp: add compatible..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=17d067d0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=f342ea16c9d06d80b585
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1312c327980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/883c5319cb52/disk-4a9fe2a8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/caf4421ed2ef/vmlinux-4a9fe2a8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d8e3beb01d49/bzImage-4a9fe2a8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com

INFO: task kworker/1:0:24 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:0     state:D stack:23808 pid:24    tgid:24    ppid:2      flags:0x00004000
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
INFO: task kworker/1:1:36 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:27264 pid:36    tgid:36    ppid:2      flags:0x00004000
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
 usb_lock_port drivers/usb/core/hub.c:3206 [inline]
 hub_event+0x5c4/0x4f40 drivers/usb/core/hub.c:5902
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/0:2:815 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D stack:23808 pid:815   tgid:815   ppid:2      flags:0x00004000
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
INFO: task kworker/1:3:3229 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:3     state:D stack:23808 pid:3229  tgid:3229  ppid:2      flags:0x00004000
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
INFO: task syz.4.51:5565 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.51        state:D stack:26752 pid:5565  tgid:5563  ppid:3219   flags:0x00000004
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
RIP: 0033:0x7efd82bfc990
RSP: 002b:00007efd82678b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007efd82bfc990
RDX: 0000000000000002 RSI: 00007efd82678c10 RDI: 00000000ffffff9c
RBP: 00007efd82678c10 R08: 0000000000000000 R09: 00007efd82678987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007efd82db5f80 R15: 00007ffc5a69c008
 </TASK>
INFO: task syz.0.50:5566 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.50        state:D stack:27856 pid:5566  tgid:5566  ppid:3213   flags:0x00004004
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
RIP: 0033:0x7faa2c80dff9
RSP: 002b:00007fff9a8583e8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 000000000003d7f1 RCX: 00007faa2c80dff9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007faa2c9c7a80 R08: 0000000000000001 R09: 00007fff9a8586df
R10: 00007faa2c68a000 R11: 0000000000000246 R12: 000000000003db3e
R13: 00007fff9a8584f0 R14: 0000000000000032 R15: ffffffffffffffff
 </TASK>
INFO: task syz.2.53:5570 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.53        state:D stack:28224 pid:5570  tgid:5569  ppid:3221   flags:0x00000004
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
RIP: 0033:0x7f048b01c990
RSP: 002b:00007f048aa9eb70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f048b01c990
RDX: 0000000000000002 RSI: 00007f048aa9ec10 RDI: 00000000ffffff9c
RBP: 00007f048aa9ec10 R08: 0000000000000000 R09: 00007f048aa9e987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f048b1d5f80 R15: 00007ffec6cbec08
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/1:0/24:
 #0: ffff888100eed548 ((wq_completion)pm){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000019fd80 ((work_completion)(&dev->power.work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff8881097de508 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3206 [inline]
 #2: ffff8881097de508 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_port_suspend+0x255/0xf10 drivers/usb/core/hub.c:3463
1 lock held by khungtaskd/30:
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
4 locks held by kworker/1:1/36:
 #0: ffff8881062d0148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90000267d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff8881097db190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff8881097db190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff8881097de508 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3206 [inline]
 #3: ffff8881097de508 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x5c4/0x4f40 drivers/usb/core/hub.c:5902
2 locks held by kworker/u8:4/150:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900005efd80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by kworker/u8:5/281:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000188fd80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
6 locks held by kworker/0:2/815:
 #0: ffff8881062d0148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90001cbfd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff88810972b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff88810972b190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff888116622190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888116622190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff888116623160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888116623160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_register_dev+0x11c/0x550 drivers/usb/core/file.c:134
2 locks held by kworker/u8:6/1119:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900021afd80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
2 locks held by getty/2609:
 #0: ffff888113bc10a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
6 locks held by kworker/1:3/3229:
 #0: ffff8881062d0148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90002b0fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff8881097a2190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff8881097a2190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff888130bea190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888130bea190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff88812a9c4160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88812a9c4160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88812a9c4160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
 #5: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_deregister_dev+0x7c/0x1e0 drivers/usb/core/file.c:186
2 locks held by syz.4.51/5565:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
 #1: ffffffff89a967e8 (wdm_mutex){+.+.}-{3:3}, at: wdm_open+0x5d/0x630 drivers/usb/class/cdc-wdm.c:715
1 lock held by syz.0.50/5566:
 #0: ffffffff89a967e8 (wdm_mutex){+.+.}-{3:3}, at: wdm_release+0x4b/0x440 drivers/usb/class/cdc-wdm.c:764
1 lock held by syz.2.53/5570:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.60/6912:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.62/6944:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.2.64/6974:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.83/8325:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.81/8343:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.2.85/8378:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.102/9746:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.104/9768:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.2.106/9782:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.123/11099:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.126/11133:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.2.127/11186:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.144/12415:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.146/12560:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.2.148/12590:
 #0: ffffffff899dadb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by modprobe/13635:
1 lock held by modprobe/13666:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0
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
CPU: 1 UID: 0 PID: 13672 Comm: modprobe Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:hlock_class+0x29/0x130 kernel/locking/lockdep.c:223
Code: 90 48 b8 00 00 00 00 00 fc ff df 53 48 89 fb 48 83 c7 20 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c 03 0f 8e da 00 00 00 <0f> b7 5b 20 66 81 e3 ff 1f 0f b7 db be 08 00 00 00 48 89 d8 48 c1
RSP: 0018:ffffc90005eef7a0 EFLAGS: 00000046
RAX: 0000000000000000 RBX: ffff8881115a8a98 RCX: ffffffff813313e8
RDX: 1ffff110222b5157 RSI: 0000000000000008 RDI: ffff8881115a8ab8
RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1f55db6
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8881115a8a98 R14: 00000000000000a0 R15: ffff8881115a8000
FS:  0000000000000000(0000) GS:ffff8881f5900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc62aacc270 CR3: 000000011b350000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __lock_acquire+0xbdd/0x3ce0 kernel/locking/lockdep.c:5199
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 __fs_reclaim_acquire mm/page_alloc.c:3834 [inline]
 fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3848
 might_alloc include/linux/sched/mm.h:327 [inline]
 slab_pre_alloc_hook mm/slub.c:4037 [inline]
 slab_alloc_node mm/slub.c:4115 [inline]
 kmem_cache_alloc_noprof+0x54/0x2b0 mm/slub.c:4142
 lsm_file_alloc security/security.c:734 [inline]
 security_file_alloc+0x34/0x140 security/security.c:2853
 init_file+0x93/0x230 fs/file_table.c:153
 alloc_empty_file+0x91/0x1e0 fs/file_table.c:213
 path_openat+0xe1/0x2d60 fs/namei.c:3919
 do_filp_open+0x1dc/0x430 fs/namei.c:3960
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc62ad73a46
Code: 10 00 00 00 44 8b 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 44 89 c2 4c 89 ce bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 0c f7 d8 89 05 0a 48 01 00 48 83 c8 ff c3 31
RSP: 002b:00007ffc833eead8 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007ffc833eed38 RCX: 00007fc62ad73a46
RDX: 0000000000080000 RSI: 00007ffc833eeb50 RDI: 00000000ffffff9c
RBP: 00007ffc833eeb40 R08: 0000000000080000 R09: 00007ffc833eeb50
R10: 0000000000000000 R11: 0000000000000287 R12: 00007ffc833eeb50
R13: 0000000000000007 R14: 00007ffc833eed1f R15: 00000000ffffffff
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

