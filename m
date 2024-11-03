Return-Path: <linux-kernel+bounces-393619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0869BA332
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 01:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8E01F227CC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 00:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C055F29B0;
	Sun,  3 Nov 2024 00:09:29 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF74A1859
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 00:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730592568; cv=none; b=hq9zYmqzK6zuzYK5NI2RFJMcJnXb8b74iM2g39NCieAQYYCNLJOPjzBvQJev1kp2eZwn94LoBriiG0ZvD+PqLrGuyrme/sLKIkuI3uUMfFLJlUFuVH+9VXUuXV7ssuBdp2ColdOInAcexx0D8rAjm/oJg20DqJ4tgVPxJPtC/GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730592568; c=relaxed/simple;
	bh=wPguwDWI5cQrKT9CYZLW96f/OrWOnJ8HmsThpt8aNvY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kqxL0t8vUCh7pGjpA4o2WCdbsZBPoaFFlA0J0RxL59dI2UelS9IE/nLmxaRzcerXfrUgpuw8gvNcNl5lY/rHDJ6VFuaeMCof0uDn3CG9ZeDcn4AZGXALYd2PPzULVj2x0PajLxe7lLgWEQSSj++xw5nadbNLvoz24vSZlF+neuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6a9cb7efdso25503445ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 17:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730592566; x=1731197366;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QCQoYRHSrQSQGZA6pi1hyYw8Ig1Ha6Qcl3PsxU+SvBM=;
        b=cJDj4B+E2j1IP+C8ecwC7/dl3roAMsn/e2wjC3NwaA+ZbdOPjuK+MlRWBoBebJnuUL
         3u7rf2+5vcajkE3R1DRb5LZmi+u42vRYYquQMj6+2am4yl34SHEOM1mU2cmf3nEGFbG9
         5Q2J5GwZM3f3mIHBS3JfyMLnosWMdoNOz8a2zH6vNapulvdFwKNf066LitaJrdk0v2vW
         VDm0hHzsxaHV0mZyE1zn/xxB3C6iSPK8EyNWPTmct7MAhBjO1cC75aoxUPe4wyIrEp5K
         SGv/rJOzJFQUv5wfLrvmePUmutYOpjIrG3v8B47qNaBidyX+bYx2JpAu6MdhG1KvrLB6
         EjfQ==
X-Gm-Message-State: AOJu0YxlpqYxRlE0+ybO0MMM+bc+22kdJGBWrgfgZyhxiVGD/bN4TOtt
	qZU8+fqcOnMFaqGOpoJ6kZ3TnR0SVkuMLK+aebOs0oD0+GcArRQrsDHtgP/WqTjbIuW4XzQmJKu
	bUxFw2tQtFVwje6dabIuXSVurVfzUl9SQOfRjI9sJrgWP1xIvVCe/O74=
X-Google-Smtp-Source: AGHT+IELDYuq3A1QRKxPj47nnNRaGvwb4yN2GK/9E7YEOBXGYe+Rew6eLzSEpi7vW7Opp3M2HPM2YPMTXQde90EiQtCbzSBh7dhC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1528:b0:3a3:b593:83a4 with SMTP id
 e9e14a558f8ab-3a4ed295bb6mr261508265ab.14.1730592565763; Sat, 02 Nov 2024
 17:09:25 -0700 (PDT)
Date: Sat, 02 Nov 2024 17:09:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6726bf35.050a0220.35b515.018b.GAE@google.com>
Subject: [syzbot] [sound?] INFO: task hung in snd_card_free
From: syzbot <syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e42b1a9a2557 Merge tag 'spi-fix-v6.12-rc5' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=114d615f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4340261e4e9f37fc
dashboard link: https://syzkaller.appspot.com/bug?extid=73582d08864d8268b6fd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130d3687980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1274ca30580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d0782982165a/disk-e42b1a9a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f8ab91eac7df/vmlinux-e42b1a9a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/debece1170ee/bzImage-e42b1a9a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com

INFO: task kworker/0:2:965 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D stack:24576 pid:965   tgid:965   ppid:2      flags:0x00004000
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
 snd_card_free+0x128/0x190 sound/core/init.c:653
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
INFO: task kworker/1:2:2143 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:2     state:D stack:23744 pid:2143  tgid:2143  ppid:2      flags:0x00004000
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
 snd_card_free+0x128/0x190 sound/core/init.c:653
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
INFO: task syz-executor413:5880 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor413 state:D stack:26352 pid:5880  tgid:5880  ppid:5851   flags:0x00004006
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
RIP: 0033:0x7f7a45e945a9
RSP: 002b:00007ffea42b3558 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7a45e945a9
RDX: 0000000000000000 RSI: 00000000c0105512 RDI: 0000000000000003
RBP: 00000000000f4240 R08: 00312e6364755f79 R09: 00000000000000a0
R10: 000000000000001f R11: 0000000000000246 R12: 0000000000044933
R13: 00007ffea42b356c R14: 00007ffea42b3580 R15: 00007ffea42b3570
 </TASK>
INFO: task syz-executor413:5881 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor413 state:D stack:26640 pid:5881  tgid:5881  ppid:5853   flags:0x00004006
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
RIP: 0033:0x7f7a45e945a9
RSP: 002b:00007ffea42b3558 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7a45e945a9
RDX: 0000000000000000 RSI: 00000000c0105512 RDI: 0000000000000003
RBP: 00000000000f4240 R08: 00322e6364755f79 R09: 00000000000000a0
R10: 000000000000001f R11: 0000000000000246 R12: 000000000004493f
R13: 00007ffea42b356c R14: 00007ffea42b3580 R15: 00007ffea42b3570
 </TASK>
INFO: task syz-executor413:5882 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor413 state:D stack:26912 pid:5882  tgid:5882  ppid:5856   flags:0x00004006
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
RIP: 0033:0x7f7a45e945a9
RSP: 002b:00007ffea42b3558 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7a45e945a9
RDX: 0000000000000000 RSI: 00000000c0105512 RDI: 0000000000000003
RBP: 00000000000f4240 R08: 00332e6364755f79 R09: 00000000000000a0
R10: 000000000000001f R11: 0000000000000246 R12: 000000000004494f
R13: 00007ffea42b356c R14: 00007ffea42b3580 R15: 00007ffea42b3570
 </TASK>
INFO: task syz-executor413:5883 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor413 state:D stack:28176 pid:5883  tgid:5883  ppid:5850   flags:0x00004006
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
RIP: 0033:0x7f7a45e945a9
RSP: 002b:00007ffea42b3558 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7a45e945a9
RDX: 0000000000000000 RSI: 00000000c0105512 RDI: 0000000000000003
RBP: 00000000000f4240 R08: 00302e6364755f79 R09: 00000000000000a0
R10: 000000000000001f R11: 0000000000000246 R12: 0000000000044927
R13: 00007ffea42b356c R14: 00007ffea42b3580 R15: 00007ffea42b3570
 </TASK>
INFO: task syz-executor413:5884 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor413 state:D stack:27200 pid:5884  tgid:5884  ppid:5857   flags:0x00004006
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
RIP: 0033:0x7f7a45e945a9
RSP: 002b:00007ffea42b3558 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7a45e945a9
RDX: 0000000000000000 RSI: 00000000c0105512 RDI: 0000000000000003
RBP: 00000000000f4240 R08: 00342e6364755f79 R09: 00000000000000a0
R10: 000000000000001f R11: 0000000000000246 R12: 0000000000044952
R13: 00007ffea42b356c R14: 00007ffea42b3580 R15: 00007ffea42b3570
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
5 locks held by kworker/0:2/965:
 #0: ffff888022ef1d48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90004317d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888144f04190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888144f04190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff888073193190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888073193190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff888076f82160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888076f82160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff888076f82160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
5 locks held by kworker/1:2/2143:
 #0: ffff888022ef1d48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc9000540fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff888144bf4190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888144bf4190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4e10 drivers/usb/core/hub.c:5849
 #3: ffff888031f37190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff888031f37190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff88802fe31160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88802fe31160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88802fe31160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
2 locks held by getty/5579:
 #0: ffff8880357d80a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
1 lock held by syz-executor413/5880:
 #0: ffff888144bf4190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144bf4190 (&dev->mutex){....}-{3:3}, at: usbdev_do_ioctl drivers/usb/core/devio.c:2608 [inline]
 #0: ffff888144bf4190 (&dev->mutex){....}-{3:3}, at: usbdev_ioctl+0x1a9/0x4010 drivers/usb/core/devio.c:2824
1 lock held by syz-executor413/5881:
 #0: ffff888144bf4190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144bf4190 (&dev->mutex){....}-{3:3}, at: usbdev_do_ioctl drivers/usb/core/devio.c:2608 [inline]
 #0: ffff888144bf4190 (&dev->mutex){....}-{3:3}, at: usbdev_ioctl+0x1a9/0x4010 drivers/usb/core/devio.c:2824
1 lock held by syz-executor413/5882:
 #0: ffff888144bf4190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144bf4190 (&dev->mutex){....}-{3:3}, at: usbdev_do_ioctl drivers/usb/core/devio.c:2608 [inline]
 #0: ffff888144bf4190 (&dev->mutex){....}-{3:3}, at: usbdev_ioctl+0x1a9/0x4010 drivers/usb/core/devio.c:2824
1 lock held by syz-executor413/5883:
 #0: ffff888144bf4190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144bf4190 (&dev->mutex){....}-{3:3}, at: usbdev_do_ioctl drivers/usb/core/devio.c:2608 [inline]
 #0: ffff888144bf4190 (&dev->mutex){....}-{3:3}, at: usbdev_ioctl+0x1a9/0x4010 drivers/usb/core/devio.c:2824
1 lock held by syz-executor413/5884:
 #0: ffff888144bf4190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff888144bf4190 (&dev->mutex){....}-{3:3}, at: usbdev_do_ioctl drivers/usb/core/devio.c:2608 [inline]
 #0: ffff888144bf4190 (&dev->mutex){....}-{3:3}, at: usbdev_ioctl+0x1a9/0x4010 drivers/usb/core/devio.c:2824

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
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
CPU: 1 UID: 0 PID: 63 Comm: kworker/u8:4 Not tainted 6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:call_function_single_prep_ipi+0x12e/0x1b0 kernel/sched/core.c:3806
Code: be 08 00 00 00 4c 89 ef e8 6f b4 91 00 48 8b 44 24 20 48 89 c2 48 83 ca 08 f0 48 0f b1 13 75 c3 44 89 e7 e8 14 ca fe ff 31 d2 <48> b8 00 00 00 00 00 fc ff df 48 c7 44 05 00 00 00 00 00 48 8b 44
RSP: 0018:ffffc900015d7910 EFLAGS: 00000246
RAX: 0000000000004000 RBX: ffffffff8de957c0 RCX: ffffffff8181686a
RDX: 0000000000000001 RSI: ffffffff81816945 RDI: ffff8880b863f990
RBP: 1ffff920002baf22 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc900015d7930 R14: ffff8880b8740110 R15: ffff8880b8740100
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5a4d87b580 CR3: 000000000df7c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 send_call_function_single_ipi kernel/smp.c:115 [inline]
 smp_call_function_many_cond+0xcee/0x1300 kernel/smp.c:866
 on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1051
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2085 [inline]
 text_poke_bp_batch+0x659/0x760 arch/x86/kernel/alternative.c:2295
 text_poke_flush arch/x86/kernel/alternative.c:2486 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:2483 [inline]
 text_poke_finish+0x30/0x40 arch/x86/kernel/alternative.c:2493
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x1d7/0x400 kernel/jump_label.c:920
 static_key_enable_cpuslocked+0x1b7/0x270 kernel/jump_label.c:210
 static_key_enable+0x1a/0x20 kernel/jump_label.c:223
 toggle_allocation_gate mm/kfence/core.c:849 [inline]
 toggle_allocation_gate+0xfc/0x260 mm/kfence/core.c:841
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.541 msecs


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

