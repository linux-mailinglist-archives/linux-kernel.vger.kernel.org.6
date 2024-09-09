Return-Path: <linux-kernel+bounces-322134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2646C972491
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 23:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700CB1F24A29
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100F018C917;
	Mon,  9 Sep 2024 21:32:30 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657F418951A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725917548; cv=none; b=FEFGMBEh0X2TOR1PKNpt9G0IuZC9PNmfS7HcXv4GVu60V7yIiCd5f9q40mnPHkW6Padh+Q9KqLoJt9xv32OaJ280TvGMPG1m11XFCxWR6PB6PM1+K90bBSPhy9650K+vvKucl4G+91i7zSM9fy82pz0KjIeziXiU+iOyLzz6Cfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725917548; c=relaxed/simple;
	bh=Wc3ZX1LN45mhINUPUcSbo0me/f+8CE1E9NaZ9UrJvyE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e7+Fj6dhr9Y9QSK6kRJhV0xSCPF3tuASKXX7gmShOaeABfbgv7GRKCnOY1inQzaqzYYDknWm+dYXSP3GwC+QjeKcunlc1Y009yxrK7znr372/iGNN/STOYzFDAgXF/M6//MX4UGmcJ8s9Nq9Kv5lbPpmZhiqW72f6+5qmVGPxug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a32368e13so1182983939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 14:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725917545; x=1726522345;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RJUfpnP/sB65P3ciGY81GDE/B+QHiN+Y3SdqEMGJtTw=;
        b=NTZZmQofgrrxI6iAd0UFglk9Rl4AMlEKHK6T60clMz3VnYT4e1LZkSj7fl1Qp4GcnG
         NsnyxyIc80tkm1jihspnWyAqFWquq8PsIhuf+Q7WJHImOQJOoWeiG/cxSyjCjA24Nuou
         IMQGeS8njumYY3wvqxwYT4Mvdy3Wh8Akndo69O2mwkObOMs3F1CbGY1y0/oRu5xoqH5/
         AP5S+59E4TmkZaWcn5iMirPNu2GvOBJk+k+ib8pofUhZd4lQbEEOdzrkHoFAtYhkLBeJ
         QNm4tI10r7hSTZBp02V3vzt2k5ZEBlmVPzFYM0VEaFo+gm9e/lByUvuMoUJg77P2zd5d
         1piQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpHROOlomcWYES8VycJjaYKn2WNg6DpUUTE/LIsXY8ZCoxRaSeHZlj0NcU9b9RhhNdAscSfCVE+almOtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwitLvB6kaVMyMhBaThSutBOKxCXlA4R2J8//tpP2Dxs96AqhX
	aD+lMgtmRtP7X5eU14giGLQJBgzhYtwtXLlRHXEsZzY+iEVxEenlnMfGdRlJO9DkL0l4/6Ip0dp
	kva1BLuAdTODyzZ1SPqtJ83JaSB2cXvFGAkiJczuN8pc6XIgbRY7HQeg=
X-Google-Smtp-Source: AGHT+IHQAOaHfFbRR0kn0b9oeJIcKTqVMbqaX2n8/qVP6P7BLfpBsH/Za9E3SdTyyde1uXjLbV6uwL2T2X0HIdqFLgh6A89+0enL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c81:b0:82c:f1f6:55b1 with SMTP id
 ca18e2360f4ac-82cf1f65a59mr406256039f.0.1725917545516; Mon, 09 Sep 2024
 14:32:25 -0700 (PDT)
Date: Mon, 09 Sep 2024 14:32:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000366cb70621b67e68@google.com>
Subject: [syzbot] [usb?] INFO: task hung in usb_deregister_dev (2)
From: syzbot <syzbot+54d572cc6fd8922d1242@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9c0c11bb87b0 xhci: support setting interrupt moderation IM..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=17397d09980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a1ccb5ad00c3ba6
dashboard link: https://syzkaller.appspot.com/bug?extid=54d572cc6fd8922d1242
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137e5f33980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d41cb6c3e427/disk-9c0c11bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1beec7548c8b/vmlinux-9c0c11bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66b2bb190ac1/bzImage-9c0c11bb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+54d572cc6fd8922d1242@syzkaller.appspotmail.com

INFO: task kworker/0:1:9 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc6-syzkaller-g9c0c11bb87b0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:22960 pid:9     tgid:9     ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xcda/0x2f80 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 rwsem_down_write_slowpath+0x539/0x12a0 kernel/locking/rwsem.c:1178
 __down_write_common kernel/locking/rwsem.c:1306 [inline]
 __down_write kernel/locking/rwsem.c:1315 [inline]
 down_write+0x1d8/0x200 kernel/locking/rwsem.c:1580
 usb_deregister_dev+0x7c/0x1e0 drivers/usb/core/file.c:186
 usblp_disconnect+0x4a/0x330 drivers/usb/class/usblp.c:1396
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:568 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:560
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x396/0x9f0 drivers/base/core.c:3871
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/1:1:37 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc6-syzkaller-g9c0c11bb87b0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:24144 pid:37    tgid:37    ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xcda/0x2f80 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 usb_kill_urb.part.0+0x1ca/0x250 drivers/usb/core/urb.c:713
 usb_kill_urb+0x83/0xa0 drivers/usb/core/urb.c:702
 usb_hcd_flush_endpoint+0x1d9/0x3e0 drivers/usb/core/hcd.c:1815
 usb_disable_endpoint drivers/usb/core/message.c:1302 [inline]
 usb_disable_interface+0x1ce/0x4c0 drivers/usb/core/message.c:1348
 usb_unbind_interface+0x3c5/0x970 drivers/usb/core/driver.c:459
 device_remove drivers/base/dd.c:568 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:560
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x396/0x9f0 drivers/base/core.c:3871
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/1:3:5497 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc6-syzkaller-g9c0c11bb87b0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:3     state:D stack:24064 pid:5497  tgid:5497  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xcda/0x2f80 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 rwsem_down_write_slowpath+0x539/0x12a0 kernel/locking/rwsem.c:1178
 __down_write_common kernel/locking/rwsem.c:1306 [inline]
 __down_write kernel/locking/rwsem.c:1315 [inline]
 down_write+0x1d8/0x200 kernel/locking/rwsem.c:1580
 usb_deregister_dev+0x7c/0x1e0 drivers/usb/core/file.c:186
 usblp_disconnect+0x4a/0x330 drivers/usb/class/usblp.c:1396
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:568 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:560
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x396/0x9f0 drivers/base/core.c:3871
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/1:5:5518 blocked for more than 144 seconds.
      Not tainted 6.11.0-rc6-syzkaller-g9c0c11bb87b0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:5     state:D stack:24528 pid:5518  tgid:5518  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xcda/0x2f80 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 usblp_disconnect+0x97/0x330 drivers/usb/class/usblp.c:1403
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:568 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:560
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x396/0x9f0 drivers/base/core.c:3871
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/0:4:5556 blocked for more than 144 seconds.
      Not tainted 6.11.0-rc6-syzkaller-g9c0c11bb87b0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:4     state:D stack:24400 pid:5556  tgid:5556  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xcda/0x2f80 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 rwsem_down_write_slowpath+0x539/0x12a0 kernel/locking/rwsem.c:1178
 __down_write_common kernel/locking/rwsem.c:1306 [inline]
 __down_write kernel/locking/rwsem.c:1315 [inline]
 down_write+0x1d8/0x200 kernel/locking/rwsem.c:1580
 usb_register_dev+0x11c/0x550 drivers/usb/core/file.c:134
 usblp_probe+0xc99/0x16f0 drivers/usb/class/usblp.c:1208
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3682
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3682
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2e58/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz.2.258:6224 blocked for more than 144 seconds.
      Not tainted 6.11.0-rc6-syzkaller-g9c0c11bb87b0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.258       state:D stack:28768 pid:6224  tgid:6215  ppid:3221   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xcda/0x2f80 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 usb_kill_urb.part.0+0x1ca/0x250 drivers/usb/core/urb.c:713
 usb_kill_urb drivers/usb/core/urb.c:702 [inline]
 usb_kill_anchored_urbs+0x10d/0x370 drivers/usb/core/urb.c:822
 usblp_unlink_urbs drivers/usb/class/usblp.c:471 [inline]
 usblp_release+0x191/0x310 drivers/usb/class/usblp.c:483
 __fput+0x408/0xbb0 fs/file_table.c:422
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 get_signal+0x1ca/0x2770 kernel/signal.c:2689
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x147/0x260 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb4d0d7cef9
RSP: 002b:00007fb4d07de038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: fffffffffffffffc RBX: 00007fb4d0f36058 RCX: 00007fb4d0d7cef9
RDX: 0000000000000003 RSI: 0000000020001680 RDI: 0000000000000003
RBP: 00007fb4d0def01e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb4d0f36058 R15: 00007ffe7a3960b8
 </TASK>
INFO: task syz.3.261:6233 blocked for more than 145 seconds.
      Not tainted 6.11.0-rc6-syzkaller-g9c0c11bb87b0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.261       state:D stack:28896 pid:6233  tgid:6226  ppid:3218   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xcda/0x2f80 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 usblp_open+0x5c/0x450 drivers/usb/class/usblp.c:417
 usb_open+0x213/0x2f0 drivers/usb/core/file.c:47
 chrdev_open+0x26d/0x6f0 fs/char_dev.c:414
 do_dentry_open+0x957/0x1490 fs/open.c:959
 vfs_open+0x82/0x3f0 fs/open.c:1089
 do_open fs/namei.c:3727 [inline]
 path_openat+0x2141/0x2d20 fs/namei.c:3886
 do_filp_open+0x1dc/0x430 fs/namei.c:3913
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa540d2b890
RSP: 002b:00007fa54078db70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fa540d2b890
RDX: 0000000000000002 RSI: 00007fa54078dc10 RDI: 00000000ffffff9c
RBP: 00007fa54078dc10 R08: 0000000000000000 R09: 00007fa54078d987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa540ee6058 R15: 00007ffe4e86f208
 </TASK>
INFO: task syz.3.261:6234 blocked for more than 145 seconds.
      Not tainted 6.11.0-rc6-syzkaller-g9c0c11bb87b0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.261       state:D stack:28896 pid:6234  tgid:6226  ppid:3218   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xcda/0x2f80 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 usblp_open+0x5c/0x450 drivers/usb/class/usblp.c:417
 usb_open+0x213/0x2f0 drivers/usb/core/file.c:47
 chrdev_open+0x26d/0x6f0 fs/char_dev.c:414
 do_dentry_open+0x957/0x1490 fs/open.c:959
 vfs_open+0x82/0x3f0 fs/open.c:1089
 do_open fs/namei.c:3727 [inline]
 path_openat+0x2141/0x2d20 fs/namei.c:3886
 do_filp_open+0x1dc/0x430 fs/namei.c:3913
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa540d2b890
RSP: 002b:00007fa54076cb70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fa540d2b890
RDX: 0000000000000002 RSI: 00007fa54076cc10 RDI: 00000000ffffff9c
RBP: 00007fa54076cc10 R08: 0000000000000000 R09: 00007fa54076c987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa540ee6130 R15: 00007ffe4e86f208
 </TASK>
INFO: task syz.4.262:6236 blocked for more than 145 seconds.
      Not tainted 6.11.0-rc6-syzkaller-g9c0c11bb87b0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.262       state:D stack:28832 pid:6236  tgid:6228  ppid:3227   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xcda/0x2f80 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 rwsem_down_read_slowpath+0x61e/0xb20 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x124/0x330 kernel/locking/rwsem.c:1528
 usb_open+0x27/0x2f0 drivers/usb/core/file.c:38
 chrdev_open+0x26d/0x6f0 fs/char_dev.c:414
 do_dentry_open+0x957/0x1490 fs/open.c:959
 vfs_open+0x82/0x3f0 fs/open.c:1089
 do_open fs/namei.c:3727 [inline]
 path_openat+0x2141/0x2d20 fs/namei.c:3886
 do_filp_open+0x1dc/0x430 fs/namei.c:3913
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb834a7b890
RSP: 002b:00007fb8344ddb70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fb834a7b890
RDX: 0000000000000002 RSI: 00007fb8344ddc10 RDI: 00000000ffffff9c
RBP: 00007fb8344ddc10 R08: 0000000000000000 R09: 00007fb8344dd987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb834c36058 R15: 00007fff85454148
 </TASK>
INFO: task syz.4.262:6239 blocked for more than 146 seconds.
      Not tainted 6.11.0-rc6-syzkaller-g9c0c11bb87b0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.262       state:D stack:28832 pid:6239  tgid:6228  ppid:3227   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xcda/0x2f80 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 rwsem_down_read_slowpath+0x61e/0xb20 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x124/0x330 kernel/locking/rwsem.c:1528
 usb_open+0x27/0x2f0 drivers/usb/core/file.c:38
 chrdev_open+0x26d/0x6f0 fs/char_dev.c:414
 do_dentry_open+0x957/0x1490 fs/open.c:959
 vfs_open+0x82/0x3f0 fs/open.c:1089
 do_open fs/namei.c:3727 [inline]
 path_openat+0x2141/0x2d20 fs/namei.c:3886
 do_filp_open+0x1dc/0x430 fs/namei.c:3913
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb834a7b890
RSP: 002b:00007fb8344bcb70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fb834a7b890
RDX: 0000000000000002 RSI: 00007fb8344bcc10 RDI: 00000000ffffff9c
RBP: 00007fb8344bcc10 R08: 0000000000000000 R09: 00007fb8344bc987
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb834c36130 R15: 00007fff85454148
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings

Showing all locks held in the system:
6 locks held by kworker/0:1/9:
 #0: ffff8881062cb548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc9000009fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffff8881093ca190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff8881093ca190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff88811e71d190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff88811e71d190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff888114bf1160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff888114bf1160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1094 [inline]
 #4: ffff888114bf1160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1292
 #5: ffffffff899affb0 (minor_rwsem){++++}-{3:3}, at: usb_deregister_dev+0x7c/0x1e0 drivers/usb/core/file.c:186
1 lock held by khungtaskd/30:
 #0: ffffffff88ebb660 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff88ebb660 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff88ebb660 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6626
5 locks held by kworker/1:1/37:
 #0: ffff8881062cb548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc90000277d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffff8881093e2190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff8881093e2190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff88810bead190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff88810bead190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff888118884160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff888118884160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1094 [inline]
 #4: ffff888118884160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1292
1 lock held by klogd/2536:
 #0: ffff8881f583d718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:560 [inline]
 #0: ffff8881f583d718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1415 [inline]
 #0: ffff8881f583d718 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1714 [inline]
 #0: ffff8881f583d718 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x28e/0x2f80 kernel/sched/core.c:6436
2 locks held by getty/2605:
 #0: ffff88810ef7c0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc8/0x1490 drivers/tty/n_tty.c:2211
4 locks held by udevd/5473:
 #0: ffff88811d26b790 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xde/0x12c0 fs/seq_file.c:182
 #1: ffff88811afa2888 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff888101710968 (kn->active#18){.+.+}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff888116181190 (&dev->mutex){....}-{3:3}, at: device_lock_interruptible include/linux/device.h:1014 [inline]
 #3: ffff888116181190 (&dev->mutex){....}-{3:3}, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142
6 locks held by kworker/1:3/5497:
 #0: ffff8881062cb548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc90001cefd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffff8881097c1190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff8881097c1190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff888104f52190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff888104f52190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff888116186160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff888116186160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1094 [inline]
 #4: ffff888116186160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1292
 #5: ffffffff899affb0 (minor_rwsem){++++}-{3:3}, at: usb_deregister_dev+0x7c/0x1e0 drivers/usb/core/file.c:186
6 locks held by kworker/1:5/5518:
 #0: ffff8881062cb548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc9000146fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffff8881097b1190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff8881097b1190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff88810bea9190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff88810bea9190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff88810beae160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff88810beae160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1094 [inline]
 #4: ffff88810beae160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1292
 #5: ffffffff89a691a8 (usblp_mutex){+.+.}-{3:3}, at: usblp_disconnect+0x97/0x330 drivers/usb/class/usblp.c:1403
6 locks held by kworker/0:4/5556:
 #0: ffff8881062cb548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc90001effd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffff888109b49190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff888109b49190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff888116181190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff888116181190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1004
 #4: ffff88811e71e160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff88811e71e160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1004
 #5: ffffffff899affb0 (minor_rwsem){++++}-{3:3}, at: usb_register_dev+0x11c/0x550 drivers/usb/core/file.c:134
1 lock held by syz.2.258/6224:
 #0: ffffffff89a691a8 (usblp_mutex){+.+.}-{3:3}, at: usblp_release+0x7f/0x310 drivers/usb/class/usblp.c:480
2 locks held by syz.3.261/6233:
 #0: ffffffff899affb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x27/0x2f0 drivers/usb/core/file.c:38
 #1: ffffffff89a691a8 (usblp_mutex){+.+.}-{3:3}, at: usblp_open+0x5c/0x450 drivers/usb/class/usblp.c:417
2 locks held by syz.3.261/6234:
 #0: ffffffff899affb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x27/0x2f0 drivers/usb/core/file.c:38
 #1: ffffffff89a691a8 (usblp_mutex){+.+.}-{3:3}, at: usblp_open+0x5c/0x450 drivers/usb/class/usblp.c:417
1 lock held by syz.4.262/6236:
 #0: ffffffff899affb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x27/0x2f0 drivers/usb/core/file.c:38
1 lock held by syz.4.262/6239:
 #0: ffffffff899affb0 (minor_rwsem){++++}-{3:3}, at: usb_open+0x27/0x2f0 drivers/usb/core/file.c:38
1 lock held by syz.4.491/8056:
 #0: ffffffff88ec6df8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x282/0x3b0 kernel/rcu/tree_exp.h:296
1 lock held by syz.3.492/8057:
 #0: ffffffff88ec6df8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock+0x1a4/0x3b0 kernel/rcu/tree_exp.h:328

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-rc6-syzkaller-g9c0c11bb87b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
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
NMI backtrace for cpu 0 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
NMI backtrace for cpu 0 skipped: idling at acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:111


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

