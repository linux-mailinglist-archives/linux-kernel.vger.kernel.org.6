Return-Path: <linux-kernel+bounces-353183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B76C9929F6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A571F2282B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08F01D1E99;
	Mon,  7 Oct 2024 11:05:30 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146DD1D1752
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728299129; cv=none; b=AvcrsWAnQ53sFiDclupekrGKt5hXzkZCWDEUovJyxD8S9IjpR9Qg2tY9qkAx0aUyrbGZfndf0875cmVPw99zm/cKadDmyCA2cffphocYuzjNKR5v+M+KmUaX3+GZ7aOWfK00MwOQH3MSld4Rrbh9Hz7m4ag6QvfVec6mP2W3eh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728299129; c=relaxed/simple;
	bh=i3twBnT0LakwkmFDBDw9/o9Silv6Cq/XNDpzsWZ1+9I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YzWgN/dRAlUH6Dv2hIwHgL4olegb0rtaWMVbBvHwyR1pzHpSkRWpc6qOb+x2MY5MsSLGbEOjZdXK8+VQUe/mUeRpHYOQ3svjkQOHui6vBLwksTjCVQ1mmvrHGzHI/3qWCgbRHNPPvGM4KodcT2IwCOqBhoDdEbYT2mzvZELGanY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a34eef9ec9so40360485ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 04:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728299126; x=1728903926;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxiX34QWe6lEWA+FVKpzCwaYqB4GNUHucrGmPMmj81Y=;
        b=K/3GQdB3y8lc560v3yAa1qSO3PY7mR6+bW1G/A3soTiYuHP6SOsAEXdyAtHZ7ILrqI
         IyxkrxxL9rxoD6uoHhIY+wUaNFLPZ0mxsULD87HZitjExkS+AGyXnDTa20cduYSswSvf
         iJLoDwMJiZszMUxMr/ZRUxbbOGa95KcYSG2RJPUeeq+tA8dPyW2AireSEdEr73tRQD3S
         N72kTm78lVN7h+8X9p9tunfLTkpFVFd1OmHap5tYO/sVEyAxlSAyv6UJbKjxj71hZCur
         zmDYxpQysWnNuU+661ijHgszAV1hurLQ2EULOPQys1THL7PWZ5edg6EOPYA++BE4CM1T
         Oe2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJse63iiYLA0LVuX/f0gVr3g+RIiCcBHmdyHeQpMlZGCFtxOfgJ8x5yUni3WN59FVhDpkGpWseIkDO54U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPJx/hfPL62VcIKqeatS761DpVmw867hOOl0t31gxSj2ZSq/08
	WIcUxPB2P4b1GpMmWHF7JibguLV85MQkhJnVFQolHy7bTP/sli7sUcrmwbhuLPRN+ul7fadFNtb
	+TGWltKHVGxPEsaeOKTRXC/9ANzPFmiQhyDPDjU7tHwNgOqLPzPMv3TA=
X-Google-Smtp-Source: AGHT+IFSqZ/rp03NqTCS3HX1EeF+DBhuyH5w+Pdjafpq1GVC4zol4uFaSK2tOt0s73M8KK8J5Im5wW+VfAEJ5qOToaVhsei1sNlQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174f:b0:3a0:9aef:4c2 with SMTP id
 e9e14a558f8ab-3a375bafe23mr102383915ab.19.1728299126240; Mon, 07 Oct 2024
 04:05:26 -0700 (PDT)
Date: Mon, 07 Oct 2024 04:05:26 -0700
In-Reply-To: <66f6efee.050a0220.46d20.0023.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6703c076.050a0220.49194.0505.GAE@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_register_dev (2)
From: syzbot <syzbot+a194ded97ce38690073f@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c02d24a5af66 Add linux-next specific files for 20241003
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14c9179f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94f9caf16c0af42d
dashboard link: https://syzkaller.appspot.com/bug?extid=a194ded97ce38690073f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d0c327980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/641e642c9432/disk-c02d24a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/98aaf20c29e0/vmlinux-c02d24a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c23099f2d86b/bzImage-c02d24a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a194ded97ce38690073f@syzkaller.appspotmail.com

INFO: task kworker/0:0:8 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc1-next-20241003-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:20416 pid:8     tgid:8     ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1d7/0x220 kernel/locking/rwsem.c:1578
 usb_register_dev+0x13a/0x5a0 drivers/usb/core/file.c:134
 wdm_create+0x11cf/0x16d0 drivers/usb/class/cdc-wdm.c:1113
 wdm_probe+0x21e/0x300 drivers/usb/class/cdc-wdm.c:1165
 usb_probe_interface+0x645/0xbb0 drivers/usb/core/driver.c:399
 really_probe+0x2b8/0xad0 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:459
 __device_attach+0x333/0x520 drivers/base/dd.c:1030
 bus_probe_device+0x189/0x260 drivers/base/bus.c:534
 device_add+0x856/0xbf0 drivers/base/core.c:3675
 usb_set_configuration+0x1976/0x1fb0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x88/0x140 drivers/usb/core/generic.c:254
 usb_probe_device+0x1b8/0x380 drivers/usb/core/driver.c:294
 really_probe+0x2b8/0xad0 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:459
 __device_attach+0x333/0x520 drivers/base/dd.c:1030
 bus_probe_device+0x189/0x260 drivers/base/bus.c:534
 device_add+0x856/0xbf0 drivers/base/core.c:3675
 usb_new_device+0x104a/0x19a0 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d6d/0x5150 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/1:0:25 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc1-next-20241003-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:0     state:D stack:20416 pid:25    tgid:25    ppid:2      flags:0x00004000
Workqueue: pm pm_runtime_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 usb_poison_urb+0x1bc/0x2e0 drivers/usb/core/urb.c:763
 poison_urbs drivers/usb/class/cdc-wdm.c:342 [inline]
 wdm_suspend+0x174/0x380 drivers/usb/class/cdc-wdm.c:1271
 usb_suspend_interface drivers/usb/core/driver.c:1328 [inline]
 usb_suspend_both+0x2a5/0x1140 drivers/usb/core/driver.c:1433
 usb_runtime_suspend+0x59/0x100 drivers/usb/core/driver.c:1968
 __rpm_callback+0x2df/0x790 drivers/base/power/runtime.c:394
 rpm_callback drivers/base/power/runtime.c:448 [inline]
 rpm_suspend+0x88c/0x1730 drivers/base/power/runtime.c:672
 __pm_runtime_suspend+0x131/0x1a0 drivers/base/power/runtime.c:1142
 pm_runtime_autosuspend include/linux/pm_runtime.h:342 [inline]
 usb_runtime_idle+0x42/0x50 drivers/usb/core/driver.c:2005
 rpm_idle+0x589/0x930 drivers/base/power/runtime.c:524
 pm_runtime_work+0x15e/0x210 drivers/base/power/runtime.c:970
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/1:4:5338 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc1-next-20241003-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:4     state:D stack:20416 pid:5338  tgid:5338  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 __pm_runtime_barrier+0x347/0x520 drivers/base/power/runtime.c:1419
 pm_runtime_barrier+0xd8/0x1d0 drivers/base/power/runtime.c:1454
 usb_disconnect+0xef/0x950 drivers/usb/core/hub.c:2293
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1ebc/0x5150 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/0:7:5409 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc1-next-20241003-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:7     state:D stack:20160 pid:5409  tgid:5409  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1d7/0x220 kernel/locking/rwsem.c:1578
 usb_register_dev+0x13a/0x5a0 drivers/usb/core/file.c:134
 wdm_create+0x11cf/0x16d0 drivers/usb/class/cdc-wdm.c:1113
 wdm_probe+0x21e/0x300 drivers/usb/class/cdc-wdm.c:1165
 usb_probe_interface+0x645/0xbb0 drivers/usb/core/driver.c:399
 really_probe+0x2b8/0xad0 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:459
 __device_attach+0x333/0x520 drivers/base/dd.c:1030
 bus_probe_device+0x189/0x260 drivers/base/bus.c:534
 device_add+0x856/0xbf0 drivers/base/core.c:3675
 usb_set_configuration+0x1976/0x1fb0 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0x88/0x140 drivers/usb/core/generic.c:254
 usb_probe_device+0x1b8/0x380 drivers/usb/core/driver.c:294
 really_probe+0x2b8/0xad0 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:459
 __device_attach+0x333/0x520 drivers/base/dd.c:1030
 bus_probe_device+0x189/0x260 drivers/base/bus.c:534
 device_add+0x856/0xbf0 drivers/base/core.c:3675
 usb_new_device+0x104a/0x19a0 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d6d/0x5150 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz.0.455:6651 blocked for more than 146 seconds.
      Not tainted 6.12.0-rc1-next-20241003-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.455       state:D stack:26032 pid:6651  tgid:6650  ppid:5324   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 rpm_resume+0x504/0x1670 drivers/base/power/runtime.c:834
 rpm_resume+0x8fe/0x1670 drivers/base/power/runtime.c:892
 __pm_runtime_resume+0x120/0x180 drivers/base/power/runtime.c:1172
 pm_runtime_resume_and_get include/linux/pm_runtime.h:430 [inline]
 usb_autopm_get_interface+0x22/0xf0 drivers/usb/core/driver.c:1833
 wdm_write+0x25b/0xd60 drivers/usb/class/cdc-wdm.c:408
 vfs_write+0x29c/0xc90 fs/read_write.c:681
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f43cc57dff9
RSP: 002b:00007f43cd3b5038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f43cc735f80 RCX: 00007f43cc57dff9
RDX: 0000000000000005 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 00007f43cc5f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f43cc735f80 R15: 00007ffe441b7e18
 </TASK>
INFO: task syz.1.456:6655 blocked for more than 146 seconds.
      Not tainted 6.12.0-rc1-next-20241003-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.456       state:D stack:25472 pid:6655  tgid:6654  ppid:5326   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 rpm_resume+0x504/0x1670 drivers/base/power/runtime.c:834
 rpm_resume+0x8fe/0x1670 drivers/base/power/runtime.c:892
 __pm_runtime_resume+0x120/0x180 drivers/base/power/runtime.c:1172
 pm_runtime_resume_and_get include/linux/pm_runtime.h:430 [inline]
 usb_autopm_get_interface+0x22/0xf0 drivers/usb/core/driver.c:1833
 wdm_open+0x215/0x550 drivers/usb/class/cdc-wdm.c:730
 usb_open+0x14b/0x1d0 drivers/usb/core/file.c:47
 chrdev_open+0x521/0x600 fs/char_dev.c:414
 do_dentry_open+0x978/0x1460 fs/open.c:958
 vfs_open+0x3e/0x330 fs/open.c:1088
 do_open fs/namei.c:3774 [inline]
 path_openat+0x2c84/0x3590 fs/namei.c:3933
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4289d7c990
RSP: 002b:00007f428ac0fb70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f4289d7c990
RDX: 0000000000000002 RSI: 00007f428ac0fc10 RDI: 00000000ffffff9c
RBP: 00007f428ac0fc10 R08: 0000000000000000 R09: 00007f428ac0f987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f4289f35f80 R15: 00007ffde2a55cc8
 </TASK>
INFO: task syz.3.458:6660 blocked for more than 147 seconds.
      Not tainted 6.12.0-rc1-next-20241003-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.458       state:D stack:26736 pid:6660  tgid:6657  ppid:5340   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 rwsem_down_read_slowpath kernel/locking/rwsem.c:1084 [inline]
 __down_read_common kernel/locking/rwsem.c:1248 [inline]
 __down_read kernel/locking/rwsem.c:1261 [inline]
 down_read+0x705/0xa40 kernel/locking/rwsem.c:1526
 usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
 chrdev_open+0x521/0x600 fs/char_dev.c:414
 do_dentry_open+0x978/0x1460 fs/open.c:958
 vfs_open+0x3e/0x330 fs/open.c:1088
 do_open fs/namei.c:3774 [inline]
 path_openat+0x2c84/0x3590 fs/namei.c:3933
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f943537c990
RSP: 002b:00007f943609ab70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f943537c990
RDX: 0000000000000002 RSI: 00007f943609ac10 RDI: 00000000ffffff9c
RBP: 00007f943609ac10 R08: 0000000000000000 R09: 00007f943609a987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9435535f80 R15: 00007ffcb89c9bb8
 </TASK>
INFO: task syz.2.457:6659 blocked for more than 147 seconds.
      Not tainted 6.12.0-rc1-next-20241003-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.457       state:D stack:27040 pid:6659  tgid:6658  ppid:5330   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 rwsem_down_read_slowpath kernel/locking/rwsem.c:1084 [inline]
 __down_read_common kernel/locking/rwsem.c:1248 [inline]
 __down_read kernel/locking/rwsem.c:1261 [inline]
 down_read+0x705/0xa40 kernel/locking/rwsem.c:1526
 usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
 chrdev_open+0x521/0x600 fs/char_dev.c:414
 do_dentry_open+0x978/0x1460 fs/open.c:958
 vfs_open+0x3e/0x330 fs/open.c:1088
 do_open fs/namei.c:3774 [inline]
 path_openat+0x2c84/0x3590 fs/namei.c:3933
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe441f7c990
RSP: 002b:00007fe441df8b70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fe441f7c990
RDX: 0000000000000002 RSI: 00007fe441df8c10 RDI: 00000000ffffff9c
RBP: 00007fe441df8c10 R08: 0000000000000000 R09: 00007fe441df8987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe442135f80 R15: 00007fff698b7fa8
 </TASK>

Showing all locks held in the system:
6 locks held by kworker/0:0/8:
 #0: ffff888143eef948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888143eef948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900000d7d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900000d7d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff888144f90190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888144f90190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
 #3: ffff888032a8a190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888032a8a190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1005
 #4: ffff88807a5bc160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88807a5bc160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1005
 #5: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_register_dev+0x13a/0x5a0 drivers/usb/core/file.c:134
2 locks held by kworker/1:0/25:
 #0: ffff88801c29a148 ((wq_completion)pm){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801c29a148 ((wq_completion)pm){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900001f7d00 ((work_completion)(&dev->power.work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900001f7d00 ((work_completion)(&dev->power.work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
1 lock held by khungtaskd/30:
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
3 locks held by kworker/u8:4/61:
3 locks held by kworker/u8:10/3008:
 #0: ffff88802e203948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88802e203948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90009d5fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90009d5fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd52c8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4196
2 locks held by getty/4984:
 #0: ffff8880329da0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
3 locks held by kworker/1:4/5338:
 #0: ffff888143eef948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888143eef948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90003befd00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003befd00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff888144fa1190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888144fa1190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
6 locks held by kworker/0:7/5409:
 #0: ffff888143eef948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888143eef948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900032efd00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900032efd00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff888144f91190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888144f91190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
 #3: ffff888032a8d190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888032a8d190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1005
 #4: ffff888032a8e160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888032a8e160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1005
 #5: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_register_dev+0x13a/0x5a0 drivers/usb/core/file.c:134
1 lock held by syz.0.455/6651:
 #0: ffff88807c4ec928 (&desc->wlock){+.+.}-{3:3}, at: wdm_write+0x1bb/0xd60 drivers/usb/class/cdc-wdm.c:398
2 locks held by syz.1.456/6655:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
 #1: ffffffff8f636b28 (wdm_mutex){+.+.}-{3:3}, at: wdm_open+0x56/0x550 drivers/usb/class/cdc-wdm.c:715
1 lock held by syz.3.458/6660:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.2.457/6659:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.1.463/6731:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.0.462/6736:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.3.466/6739:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.2.465/6741:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.1.472/6799:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.2.474/6815:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.3.475/6820:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.0.473/6823:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.1.481/6847:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.2.483/6885:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.3.484/6894:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.0.485/6897:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.1.489/6917:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.2.491/6949:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.3.493/6968:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.0.494/6972:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.1.497/6989:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.2.500/7009:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.3.502/7043:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.0.503/7056:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.1.505/7067:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.2.508/7083:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.3.511/7107:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.0.513/7133:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.1.515/7149:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.2.517/7163:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.3.519/7176:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.0.522/7205:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.1.524/7229:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.2.526/7248:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.3.528/7262:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.0.531/7281:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.1.533/7299:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.2.535/7323:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.3.537/7338:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz.0.540/7356:
 #0: ffffffff8f5aedb0 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x30/0x1d0 drivers/usb/core/file.c:38
1 lock held by syz-executor/7368:
 #0: ffffffff8fcd52c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd52c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
8 locks held by syz-executor/8086:
 #0: ffff88802e6f0420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2950 [inline]
 #0: ffff88802e6f0420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
 #1: ffff888027207888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
 #2: ffff88814471f698 (kn->active#55){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f573268 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
 #4: ffff888055b770e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888055b770e8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff888055b770e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xce/0x7c0 drivers/base/dd.c:1293
 #5: ffff888055b71250 (&devlink->lock_key#41){+.+.}-{3:3}, at: nsim_drv_remove+0x50/0x160 drivers/net/netdevsim/dev.c:1672
 #6: ffffffff8fcd52c8 (rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x71/0x5c0 drivers/net/netdevsim/netdev.c:773
 #7: ffffffff8e93d378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:297 [inline]
 #7: ffffffff8e93d378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:976
1 lock held by syz-executor/11296:
 #0: ffffffff8fcd52c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd52c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc1-next-20241003-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 7147 Comm: kworker/u8:7 Not tainted 6.12.0-rc1-next-20241003-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:stack_trace_consume_entry+0x37/0x280 kernel/stacktrace.c:86
Code: 53 48 83 ec 18 48 89 fb 48 ba 00 00 00 00 00 fc ff df 4c 8d 4f 10 4d 89 cf 49 c1 ef 03 41 0f b6 04 17 84 c0 0f 85 06 01 00 00 <44> 8b 43 10 48 8d 6b 08 49 89 ec 49 c1 ec 03 41 0f b6 04 14 84 c0
RSP: 0018:ffffc9000b8773b0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffc9000b8774e0 RCX: ffffffff917c0000
RDX: dffffc0000000000 RSI: ffffffff8b10e59b RDI: ffffc9000b8774e0
RBP: ffffc9000b877490 R08: ffffc9000b877b60 R09: ffffc9000b8774f0
R10: ffffc9000b877450 R11: ffffffff818088a0 R12: ffff888052e68000
R13: ffffffff818088a0 R14: ffffc9000b8774e0 R15: 1ffff9200170ee9e
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4ab48656c0 CR3: 00000000674ce000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 arch_stack_walk+0x10e/0x150 arch/x86/kernel/stacktrace.c:27
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2329 [inline]
 slab_free mm/slub.c:4588 [inline]
 kfree+0x196/0x420 mm/slub.c:4736
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1580 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1b1e/0x2d70 net/mac80211/ibss.c:1606
 ieee80211_iface_process_skb net/mac80211/iface.c:1603 [inline]
 ieee80211_iface_work+0x8a5/0xf20 net/mac80211/iface.c:1657
 cfg80211_wiphy_work+0x2db/0x490 net/wireless/core.c:440
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

