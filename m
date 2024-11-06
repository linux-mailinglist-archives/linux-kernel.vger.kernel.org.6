Return-Path: <linux-kernel+bounces-397530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F95D9BDD11
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB421F235F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E27118FDBA;
	Wed,  6 Nov 2024 02:29:27 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D5F18FDC8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730860166; cv=none; b=pRv9PVO4sd7SwhRL+taSIoHKz/mPtyR7yjRWahW87EDtXyeJWVF5PTom4zXpw9H8Pv1IwNzSx+iYT1RSJwJCTT5XrwzWnagEqyeg/HWsLqGtPYAMOhaPTGGf1+JlPGuCfi4e/g+mESNCGfat42IrUIF6B9jcHvbILrXPZyh6LSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730860166; c=relaxed/simple;
	bh=D7GuYcCW0wVRruzah/RDjanL70lUsedzG0NODoso8pU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Qr2+dU6tQrRhzmBEuh5GphNXnx9EE7W7JJVAeusfNwxYIto1/no0NaOapDo3PkRAymCpuFq60Tat2+4WF/l6se3c9H16O1bKEeGomZSyJuLqRFWWuz9PK6SI19DgJUwsrISe169PW6W2nignslP9NMn87MSpTIxqG+H3F9/rcPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3e1ef9102so71957165ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 18:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730860163; x=1731464963;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0uCnQH/wyq66C1J73f7eo/Y07fQx1E+OuXgQA8CSD/s=;
        b=BnglzN7aphkPY/tEO/ilZ/tvDiGvbJJGElfrZ+urUnOCmRx8v6Euxu8Vty6GwwIuDC
         1yHcFFwvuZyTyJge57HdJvJxChioFUZGY/6IQ6HRoGv8BoA12ClIftGXgFSIe7vrouHC
         6n0unXdetno+pZ3nW+BWqUhyNtdLXeEInXIfB011fO2lx+nC6PvzD68LCOEj/YJ6Lzve
         YPEWGkhatdBTlkjd7lGXuxuiVdKgUErei0lMJS4+md9xumJ5vAPbFG2XgaiLcBGpyiwD
         hApXT5sQd/ZMip3YO1OLAYJgPyyYn0eMYWQpJ4xfKeQkdkZCBqDK6zozdnB5t7WTbr+a
         qYyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT/GyqlwnMcOCHEsUDhTC9kDJR3WJmqU4RnmTtyAkYU++B38HYvIkXQMkb6/heS8mwxMgavUQ8MGDlTV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUyXstna2jT+k8YTgtp85qlpWQxkYvTF3YUgbiK6g3IEyKCaOj
	Tt9z5HT88VuIrFgfvWI2a413zpUUJqIC4QLG3qdD1Iar5uNCY6HF59D3MQgWQMjBNg97VIKoqSB
	r53M/XlKd+7+0OZ3s8kEZMJlXE9uTsrM1/i0rR6HB9gxvJImFuLtJh38=
X-Google-Smtp-Source: AGHT+IF8A76nzgdlmkzukA56MD8+HEoaO/dzKYE48fauTUYkB0WSzIfc7ySxGHTCFnsXPMj8nacr2RWC64B8bxjCtlNJhy7G2bgX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c01:b0:3a6:aee2:1696 with SMTP id
 e9e14a558f8ab-3a6aee218b9mr154427165ab.21.1730860163448; Tue, 05 Nov 2024
 18:29:23 -0800 (PST)
Date: Tue, 05 Nov 2024 18:29:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672ad483.050a0220.2edce.1519.GAE@google.com>
Subject: [syzbot] [scsi?] possible deadlock in sd_remove
From: syzbot <syzbot+566d48f3784973a22771@syzkaller.appspotmail.com>
To: James.Bottomley@HansenPartnership.com, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org, martin.petersen@oracle.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c88416ba074a Add linux-next specific files for 20241101
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=165f0740580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=704b6be2ac2f205f
dashboard link: https://syzkaller.appspot.com/bug?extid=566d48f3784973a22771
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/760a8c88d0c3/disk-c88416ba.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46e4b0a851a2/vmlinux-c88416ba.xz
kernel image: https://storage.googleapis.com/syzbot-assets/428e2c784b75/bzImage-c88416ba.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+566d48f3784973a22771@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc5-next-20241101-syzkaller #0 Not tainted
------------------------------------------------------
kworker/1:5/15509 is trying to acquire lock:
ffff8880315343e0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
ffff8880315343e0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
ffff8880315343e0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: start_flush_work kernel/workqueue.c:4123 [inline]
ffff8880315343e0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: __flush_work+0xe7/0xc50 kernel/workqueue.c:4181

but task is already holding lock:
ffff888028c4eb70 (&q->q_usage_counter(queue)#52){++++}-{0:0}, at: sd_remove+0x8d/0x110 drivers/scsi/sd.c:4072

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&q->q_usage_counter(queue)#52){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       blk_queue_enter+0xe1/0x600 block/blk-core.c:328
       blk_mq_alloc_request+0x26b/0xab0 block/blk-mq.c:626
       scsi_alloc_request drivers/scsi/scsi_lib.c:1222 [inline]
       scsi_execute_cmd+0x177/0x1090 drivers/scsi/scsi_lib.c:304
       read_capacity_10+0x256/0x9c0 drivers/scsi/sd.c:2766
       sd_read_capacity drivers/scsi/sd.c:2834 [inline]
       sd_revalidate_disk+0x106c/0xbcf0 drivers/scsi/sd.c:3734
       sd_probe+0x9fa/0x1100 drivers/scsi/sd.c:4010
       really_probe+0x2b8/0xad0 drivers/base/dd.c:658
       __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
       driver_probe_device+0x50/0x430 drivers/base/dd.c:830
       __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
       bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:459
       __device_attach_async_helper+0x22d/0x300 drivers/base/dd.c:987
       async_run_entry_fn+0xa8/0x420 kernel/async.c:129
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #2 (&q->limits_lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       queue_limits_start_update include/linux/blkdev.h:940 [inline]
       loop_reconfigure_limits+0x287/0xa70 drivers/block/loop.c:1004
       loop_set_block_size drivers/block/loop.c:1474 [inline]
       lo_simple_ioctl drivers/block/loop.c:1497 [inline]
       lo_ioctl+0x1351/0x1f50 drivers/block/loop.c:1560
       blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#17){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1510/0x2490 block/blk-mq.c:3069
       __submit_bio+0x2c2/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       __block_write_full_folio+0x7ed/0xf50 fs/buffer.c:1904
       write_cache_pages+0xd0/0x230 mm/page-writeback.c:2659
       blkdev_writepages+0xb1/0x110 block/fops.c:433
       do_writepages+0x35d/0x870 mm/page-writeback.c:2702
       __writeback_single_inode+0x14f/0x10d0 fs/fs-writeback.c:1656
       writeback_sb_inodes+0x80c/0x1370 fs/fs-writeback.c:1952
       __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:2023
       wb_writeback+0x42f/0xbd0 fs/fs-writeback.c:2134
       wb_check_background_flush fs/fs-writeback.c:2204 [inline]
       wb_do_writeback fs/fs-writeback.c:2292 [inline]
       wb_workfn+0xc58/0x1090 fs/fs-writeback.c:2319
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       touch_work_lockdep_map kernel/workqueue.c:3895 [inline]
       start_flush_work kernel/workqueue.c:4149 [inline]
       __flush_work+0x74e/0xc50 kernel/workqueue.c:4181
       flush_work kernel/workqueue.c:4238 [inline]
       flush_delayed_work+0x169/0x1c0 kernel/workqueue.c:4260
       wb_shutdown+0x186/0x1e0 mm/backing-dev.c:575
       bdi_unregister+0x19a/0x5d0 mm/backing-dev.c:1158
       del_gendisk+0x400/0x930 block/genhd.c:707
       sd_remove+0x8d/0x110 drivers/scsi/sd.c:4072
       device_remove drivers/base/dd.c:569 [inline]
       __device_release_driver drivers/base/dd.c:1273 [inline]
       device_release_driver_internal+0x503/0x7c0 drivers/base/dd.c:1296
       bus_remove_device+0x34f/0x420 drivers/base/bus.c:576
       device_del+0x57a/0x9b0 drivers/base/core.c:3861
       __scsi_remove_device+0x1ad/0x3c0 drivers/scsi/scsi_sysfs.c:1499
       scsi_forget_host+0xcf/0x110 drivers/scsi/scsi_scan.c:2068
       scsi_remove_host+0x1dd/0x770 drivers/scsi/hosts.c:181
       quiesce_and_remove_host drivers/usb/storage/usb.c:949 [inline]
       usb_stor_disconnect+0x14e/0x1f0 drivers/usb/storage/usb.c:1178
       usb_unbind_interface+0x25e/0x940 drivers/usb/core/driver.c:461
       device_remove drivers/base/dd.c:569 [inline]
       __device_release_driver drivers/base/dd.c:1273 [inline]
       device_release_driver_internal+0x503/0x7c0 drivers/base/dd.c:1296
       bus_remove_device+0x34f/0x420 drivers/base/bus.c:576
       device_del+0x57a/0x9b0 drivers/base/core.c:3861
       usb_disable_device+0x3bf/0x850 drivers/usb/core/message.c:1418
       usb_disconnect+0x340/0x950 drivers/usb/core/hub.c:2304
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

other info that might help us debug this:

Chain exists of:
  (work_completion)(&(&wb->dwork)->work) --> &q->limits_lock --> &q->q_usage_counter(queue)#52

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(queue)#52);
                               lock(&q->limits_lock);
                               lock(&q->q_usage_counter(queue)#52);
  lock((work_completion)(&(&wb->dwork)->work));

 *** DEADLOCK ***

9 locks held by kworker/1:5/15509:
 #0: ffff888021e8bd48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888021e8bd48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900048f7d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900048f7d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff8881443c5190 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff8881443c5190 (&dev->mutex){....}-{4:4}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
 #3: ffff88814d17f190 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1014 [inline]
 #3: ffff88814d17f190 (&dev->mutex){....}-{4:4}, at: usb_disconnect+0x103/0x950 drivers/usb/core/hub.c:2295
 #4: ffff88802484a160 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88802484a160 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88802484a160 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xce/0x7c0 drivers/base/dd.c:1293
 #5: ffff88806d2580e0 (&shost->scan_mutex){+.+.}-{4:4}, at: scsi_remove_host+0x34/0x770 drivers/scsi/hosts.c:169
 #6: ffff88805966c378 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1014 [inline]
 #6: ffff88805966c378 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #6: ffff88805966c378 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xce/0x7c0 drivers/base/dd.c:1293
 #7: ffff888028c4eb70 (&q->q_usage_counter(queue)#52){++++}-{0:0}, at: sd_remove+0x8d/0x110 drivers/scsi/sd.c:4072
 #8: ffffffff8e939ee0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #8: ffffffff8e939ee0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #8: ffffffff8e939ee0 (rcu_read_lock){....}-{1:3}, at: start_flush_work kernel/workqueue.c:4123 [inline]
 #8: ffffffff8e939ee0 (rcu_read_lock){....}-{1:3}, at: __flush_work+0xe7/0xc50 kernel/workqueue.c:4181

stack backtrace:
CPU: 1 UID: 0 PID: 15509 Comm: kworker/1:5 Not tainted 6.12.0-rc5-next-20241101-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 touch_work_lockdep_map kernel/workqueue.c:3895 [inline]
 start_flush_work kernel/workqueue.c:4149 [inline]
 __flush_work+0x74e/0xc50 kernel/workqueue.c:4181
 flush_work kernel/workqueue.c:4238 [inline]
 flush_delayed_work+0x169/0x1c0 kernel/workqueue.c:4260
 wb_shutdown+0x186/0x1e0 mm/backing-dev.c:575
 bdi_unregister+0x19a/0x5d0 mm/backing-dev.c:1158
 del_gendisk+0x400/0x930 block/genhd.c:707
 sd_remove+0x8d/0x110 drivers/scsi/sd.c:4072
 device_remove drivers/base/dd.c:569 [inline]
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x503/0x7c0 drivers/base/dd.c:1296
 bus_remove_device+0x34f/0x420 drivers/base/bus.c:576
 device_del+0x57a/0x9b0 drivers/base/core.c:3861
 __scsi_remove_device+0x1ad/0x3c0 drivers/scsi/scsi_sysfs.c:1499
 scsi_forget_host+0xcf/0x110 drivers/scsi/scsi_scan.c:2068
 scsi_remove_host+0x1dd/0x770 drivers/scsi/hosts.c:181
 quiesce_and_remove_host drivers/usb/storage/usb.c:949 [inline]
 usb_stor_disconnect+0x14e/0x1f0 drivers/usb/storage/usb.c:1178
 usb_unbind_interface+0x25e/0x940 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x503/0x7c0 drivers/base/dd.c:1296
 bus_remove_device+0x34f/0x420 drivers/base/bus.c:576
 device_del+0x57a/0x9b0 drivers/base/core.c:3861
 usb_disable_device+0x3bf/0x850 drivers/usb/core/message.c:1418
 usb_disconnect+0x340/0x950 drivers/usb/core/hub.c:2304
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


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

