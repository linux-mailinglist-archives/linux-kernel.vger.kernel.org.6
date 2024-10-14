Return-Path: <linux-kernel+bounces-364597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4546799D6AD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045E12858FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE321CACD0;
	Mon, 14 Oct 2024 18:42:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A831CACC4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728931325; cv=none; b=hC0bv0Ap8QVJ14psf3IlKXV9lZPEnBbyLVtiYuRSyQzanEzNGXf+nrIQYM5u7NTI+MstwhGOMq40VTKq+QI3mIJ/m89UHWqJ/ksTgNPGfL/6Ja2BmE11hpdj5O3jcw4ae1KH05jkVatBQyGI2Ob9hoigMeoFGUIM6no3GzG2+q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728931325; c=relaxed/simple;
	bh=9dMpFEKVu1DTzQQf77ufMEa0WwgR7RK65edfGRypRFc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=je4pv9u5L55+FmTkYwXL2NE9fdun/fjgwSvEft8m83IYWHywf4a/xyrYJQsQDIoMB1YPG3epTTal3OZJt0HIYKYhkvvZndKV3eWlPL4FngAS8nqGlSHcC/dOFUrGqIURzhEmnVVs4Y6eKarVpTt3WQyHCs4LV8Xjxuz1hTGLeSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c4554d29so8979975ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728931322; x=1729536122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sqq7y3WVcJPzuGlLuT71Ilucf7OVcbY8DM/VQRruj0o=;
        b=cwZ4UFhhoSEmJiNu1ltrf6NRZWRR/oLOFo19vtuLVUobS/qEQ/VCcGmt0ogRHX9CAN
         jn3DnrnnjVuaInYbbze/w257elx4wrDExR3Hxeh8rmanK9r6wGP9ZgZW7VvD8rLS6Kj3
         AnvBuZ8BwQTBfAOVFVNj7uwvYl2ypW6y2Jrs2xpF/e597BE2nL9dS+PzYYjqqLiruS2M
         SEBsH/+PnegTMUzyRJ9oFlTrDZhHynEFP4GamjKufD/vL2wPtlQ5/M747f2Ywr84K+d4
         fVLgOPyNDbyCMKmsVDCP/MXizxDC/KkUzHHgzIqh3ZRm7jj5jHk7JASvUHcaU0MJnh1n
         8XIQ==
X-Gm-Message-State: AOJu0YwYbO+yeIb5teklJhv8/Pgdi3yid14DGEUaL2Lx1pzmTzOLZFrI
	IpxmMDkvX+9bs0VM4sz85lA62fOvdzD384a1ocRWmyhW+EykZrIQ/OZT0zVhXOpD5g2tRooRMhQ
	LHm9LersWF61TPviP56mfDyu27bTRh3def2xIoJI0DgHazFd2CsJDvY8=
X-Google-Smtp-Source: AGHT+IGrdh1QSML+8tGOBVOt52Y66ZvljJxAIzIGm5zjRBSgGx0cgjor9uVrkmyF6DI2Hz+8zXAB6MCADoyu/md9eiIrURUQtvMx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a08:b0:3a3:9792:e9e8 with SMTP id
 e9e14a558f8ab-3a3bcd9c979mr57755745ab.5.1728931322409; Mon, 14 Oct 2024
 11:42:02 -0700 (PDT)
Date: Mon, 14 Oct 2024 11:42:02 -0700
In-Reply-To: <6f7bdad6-d266-45c6-ad2d-2d0b1c33e4a6@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670d65fa.050a0220.3e960.00c1.GAE@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
From: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in usb_register_dev

INFO: task kworker/0:2:799 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc3-syzkaller-00029-g64f3b5a6bc49-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D stack:23808 pid:799   tgid:799   ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
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
INFO: task kworker/0:4:6529 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc3-syzkaller-00029-g64f3b5a6bc49-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:4     state:D stack:23808 pid:6529  tgid:6529  ppid:2      flags:0x00004000
Workqueue: pm pm_runtime_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
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
INFO: task kworker/1:5:6611 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc3-syzkaller-00029-g64f3b5a6bc49-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:5     state:D stack:23808 pid:6611  tgid:6611  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
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
INFO: task syz.0.176:6860 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc3-syzkaller-00029-g64f3b5a6bc49-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.176       state:D stack:27856 pid:6860  tgid:6860  ppid:4248   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
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
RIP: 0033:0x7f024a0ddff9
RSP: 002b:00007ffebd42b288 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f024a297a80 RCX: 00007f024a0ddff9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f024a297a80 R08: 0000000000000000 R09: 00007ffebd42b57f
R10: 000000000003fdc8 R11: 0000000000000246 R12: 0000000000028f3e
R13: 00007ffebd42b390 R14: 0000000000000032 R15: ffffffffffffffff
 </TASK>
INFO: task syz.3.179:6864 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc3-syzkaller-00029-g64f3b5a6bc49-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.179       state:D stack:27488 pid:6864  tgid:6863  ppid:4259   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
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
RIP: 0033:0x7fddef8ac990
RSP: 002b:00007fddef328b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fddef8ac990
RDX: 0000000000000002 RSI: 00007fddef328c10 RDI: 00000000ffffff9c
RBP: 00007fddef328c10 R08: 0000000000000000 R09: 00007fddef328987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fddefa65f80 R15: 00007ffc9e273838
 </TASK>
INFO: task syz.4.180:6866 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc3-syzkaller-00029-g64f3b5a6bc49-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.180       state:D stack:27488 pid:6866  tgid:6865  ppid:4260   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
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
RIP: 0033:0x7f241606c990
RSP: 002b:00007f2415aeeb70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f241606c990
RDX: 0000000000000002 RSI: 00007f2415aeec10 RDI: 00000000ffffff9c
RBP: 00007f2415aeec10 R08: 0000000000000000 R09: 00007f2415aee987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2416225f80 R15: 00007ffd7f163508
 </TASK>
INFO: task syz.1.181:6868 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc3-syzkaller-00029-g64f3b5a6bc49-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.181       state:D stack:28192 pid:6868  tgid:6867  ppid:4252   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
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
RIP: 0033:0x7fe73bd0c990
RSP: 002b:00007fe73b788b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fe73bd0c990
RDX: 0000000000000002 RSI: 00007fe73b788c10 RDI: 00000000ffffff9c
RBP: 00007fe73b788c10 R08: 0000000000000000 R09: 00007fe73b788987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe73bec5f80 R15: 00007ffd8c74af88
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/u8:1/28:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900001e7d80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
1 lock held by khungtaskd/30:
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff88ebb100 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
2 locks held by kworker/u8:5/240:
 #0: ffff888100089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000168fd80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
6 locks held by kworker/0:2/799:
 #0: ffff888105efb148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90001b1fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888109f31190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888109f31190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff88811d54a190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88811d54a190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #4: ffff888118d8c160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888118d8c160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_register_dev+0x11c/0x550 drivers/usb/core/file.c:134
2 locks held by getty/2606:
 #0: ffff88810fb0e0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
3 locks held by kworker/0:4/6529:
 #0: ffff888100eed548 ((wq_completion)pm){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900019efd80 ((work_completion)(&dev->power.work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff8881083e5508 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3206 [inline]
 #2: ffff8881083e5508 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_port_suspend+0x255/0xf10 drivers/usb/core/hub.c:3463
6 locks held by kworker/1:5/6611:
 #0: ffff888105efb148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000194fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888109bc2190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888109bc2190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff888123a95190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888123a95190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff888105ead160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888105ead160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff888105ead160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
 #5: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_deregister_dev+0x7c/0x1e0 drivers/usb/core/file.c:186
1 lock held by syz.0.176/6860:
 #0: ffffffff89a968c8 (wdm_mutex){+.+.}-{3:3}, at: wdm_release+0x4b/0x440 drivers/usb/class/cdc-wdm.c:764
2 locks held by syz.3.179/6864:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
 #1: ffffffff89a968c8 (wdm_mutex){+.+.}-{3:3}, at: wdm_open+0x5d/0x630 drivers/usb/class/cdc-wdm.c:715
2 locks held by syz.4.180/6866:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
 #1: ffffffff89a968c8 (wdm_mutex){+.+.}-{3:3}, at: wdm_open+0x5d/0x630 drivers/usb/class/cdc-wdm.c:715
1 lock held by syz.1.181/6868:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.185/8518:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.187/8714:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.1.189/8716:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.188/8718:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.199/9951:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.1.201/10532:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.203/10559:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.204/10565:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.212/11035:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.1.216/12463:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.217/12632:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.218/12641:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.222/12872:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.1.229/14235:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.232/14584:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.231/14626:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.234/14715:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.1.242/15649:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.4.245/16515:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.0.247/16617:
 #0: ffffffff899dae90 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x220 drivers/usb/core/file.c:38
1 lock held by syz.3.246/16638:
 #0: ffffffff88ec69f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x282/0x3b0 kernel/rcu/tree_exp.h:297

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc3-syzkaller-00029-g64f3b5a6bc49-dirty #0
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
CPU: 1 UID: 0 PID: 16649 Comm: modprobe Not tainted 6.12.0-rc3-syzkaller-00029-g64f3b5a6bc49-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:lookup_chain_cache kernel/locking/lockdep.c:3797 [inline]
RIP: 0010:lookup_chain_cache_add kernel/locking/lockdep.c:3817 [inline]
RIP: 0010:validate_chain kernel/locking/lockdep.c:3872 [inline]
RIP: 0010:__lock_acquire+0x167a/0x3ce0 kernel/locking/lockdep.c:5202
Code: c3 48 c1 e8 2d 49 89 c4 48 8d 04 c5 00 6d 66 8f 48 89 c2 48 89 44 24 10 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 <0f> 85 93 23 00 00 48 bd 00 00 00 00 00 fc ff df 4c 8b 74 24 08 4a
RSP: 0000:ffffc900023b7a60 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: b3a9da2ab564cfa0 RCX: ffffffff8132601e
RDX: 1ffffffff1f1fb32 RSI: 0000000000000008 RDI: ffffffff8faaeda0
RBP: ffffffff8fada078 R08: 0000000000000000 R09: fffffbfff1f55db4
R10: ffffffff8faaeda7 R11: 0000000000000000 R12: 0000000000052d92
R13: ffff88811c3da850 R14: 0000000000000003 R15: ffff88811c3d9d40
FS:  00007f9d99451380(0000) GS:ffff8881f5900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9d996873c8 CR3: 000000011fad8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 __anon_vma_prepare+0x11a/0x5e0 mm/rmap.c:212
 __vmf_anon_prepare+0x11c/0x240 mm/memory.c:3307
 vmf_anon_prepare mm/internal.h:326 [inline]
 do_anonymous_page mm/memory.c:4774 [inline]
 do_pte_missing mm/memory.c:3963 [inline]
 handle_pte_fault mm/memory.c:5751 [inline]
 __handle_mm_fault+0x15b5/0x3390 mm/memory.c:5894
 handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6062
 do_user_addr_fault+0x613/0x12c0 arch/x86/mm/fault.c:1338
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f9d99571b9d
Code: 8b 90 c8 01 00 00 48 81 e2 00 ff ff ff 7e 14 48 89 d1 48 89 15 94 e6 10 00 48 d1 f9 48 89 0d 92 e6 10 00 48 8b 90 d0 01 00 00 <48> 89 15 24 58 11 00 48 8b 90 d8 01 00 00 48 89 15 66 e6 10 00 48
RSP: 002b:00007ffe27337468 EFLAGS: 00010206
RAX: 00007f9d99788a80 RBX: 00007f9d994de000 RCX: 0000000000dc0000
RDX: 00000000014a0000 RSI: 00007f9d994fc540 RDI: 0000000000000000
RBP: 00007ffe27337570 R08: 00007ffe27330000 R09: 00007f9d99789ab0
R10: 00007f9d994e2ab8 R11: 0000000000000025 R12: 00007f9d997525c0
R13: 00007f9d9977deda R14: 00007f9d9967f8c8 R15: 00007f9d994e2ab8
 </TASK>


Tested on:

commit:         64f3b5a6 Merge 6.12-rc3 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=12192727980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9878fe11046ea2c6
dashboard link: https://syzkaller.appspot.com/bug?extid=f342ea16c9d06d80b585
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=168d6887980000


