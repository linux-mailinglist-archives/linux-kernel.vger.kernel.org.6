Return-Path: <linux-kernel+bounces-342825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A38C989355
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 08:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235C21C20BCF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333E8137C35;
	Sun, 29 Sep 2024 06:58:22 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0742AEEC
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 06:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727593101; cv=none; b=XfaXAky/xcCD+6DjUKO+VgML+wLrUuaUAOX4WfqmM9GMuZb9sPsnfC84tBbIixcXaIx87dytT6xyVCJrUAqGSzpHM+7ORR48sAQesxQ8Df6bN+ebk3OQfDod8yIG03POiNVn5GIlyrRKoNROPjKAezViQ4yfhg0W4oKletat5J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727593101; c=relaxed/simple;
	bh=pRTswFexTNF31OUhgKXH7pC1L8ttyT4uSr79O9QRQDw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tha/kTNIKudAAsMZPCl1wBAi6hNF4dYRncKiIHgEMuE0wmTFRlMaTytP2jpCH36UyW0Ckq9T+6CWHPLTBAdDbrxgowfR8voBv8Sn3qnOu9zMtOG5qRD4w/iG+g3VezF/avPIYp7arGFzoebqbUwBfNCTFbrymNr10/LBUx6EteE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cda24c462so340337439f.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 23:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727593099; x=1728197899;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZwOalX9tsr3Q9s5orYX4Of7wTcGuw81q+exWjKmQ40M=;
        b=cvDLvDhvTI3odwCLedWdcjBRwgFPR63qzo9xlT5uwGAw36Bg7F+LE6SWrLtszyZ4pB
         JOgika/DctRmoHjfKKBLJHNViKmtp+hH1F6A31jf0WifOGaHEg673q0pZv2oVjlCe5B1
         4knB1j1ANKUF0MjZRedYj/AoakKzd5bcK194qcZOjUr4xZklUWErElDbtCMCPgVPDmTE
         6x7SPc3HUR7/0dCFNzVco3kE30H3jq71QoYlZJCb2nkhvuszlnOMrnWqcULl2pnzVLsa
         waDPapwPPogoY/qU2XOjDyOMe0rTL/tJ2C497Xze2Wge6MPCCSXGbLSvPDwpeCYYS3RT
         ttig==
X-Forwarded-Encrypted: i=1; AJvYcCWueMTyHneCKspoTeeYQjdOjw1NYK0guw0xI345jZH236wGfjX5Iqo/cvsbuAcKpH3hX+6kl+7SLXEM7cM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy10R64G2WaxQQDI6rWIBJTVeOXuxGjyTf+yybTeO2lsdfYdXUx
	2qMr8TVY06oKVbwsQg9Y+XALWCnltM9N13ldpXEVDRh4YKB3OGBQxmjQ2LS+a29G8UJXwIBTeDG
	TtDKUzuVGJomuNdgvfCPJ46FkOT1UnXiNZ34t+S2jyfvt8qOsTJYJ3cw=
X-Google-Smtp-Source: AGHT+IErh+5cETbUGyGKBCbOF9ralNA3s01s80VuyiX69ihYbVk8J/5hitJjjkGO+uu0Nn8djqLQwbIu2VS3yJvk9ULKm0nvw593
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0c:0:b0:3a0:a0a1:650c with SMTP id
 e9e14a558f8ab-3a3451b6ca7mr71959665ab.22.1727593098823; Sat, 28 Sep 2024
 23:58:18 -0700 (PDT)
Date: Sat, 28 Sep 2024 23:58:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f8fa8a.050a0220.aab67.000e.GAE@google.com>
Subject: [syzbot] [dri?] [virt?] INFO: task hung in drm_atomic_get_plane_state
From: syzbot <syzbot+eee643fdccb7c015b3a6@syzkaller.appspotmail.com>
To: airlied@redhat.com, dri-devel@lists.freedesktop.org, 
	gurchetansingh@chromium.org, kraxel@redhat.com, linux-kernel@vger.kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, olvaffe@gmail.com, 
	simona@ffwll.ch, syzkaller-bugs@googlegroups.com, tzimmermann@suse.de, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3efc57369a0c Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12964d9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4fcb065287cdb84
dashboard link: https://syzkaller.appspot.com/bug?extid=eee643fdccb7c015b3a6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-3efc5736.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d0988c372a39/vmlinux-3efc5736.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8547f30d7e9d/bzImage-3efc5736.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eee643fdccb7c015b3a6@syzkaller.appspotmail.com

INFO: task swapper/0:1 blocked for more than 143 seconds.
      Not tainted 6.11.0-syzkaller-11993-g3efc57369a0c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:swapper/0       state:D stack:17904 pid:1     tgid:1     ppid:0      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __ww_mutex_lock+0xec5/0x2790 kernel/locking/mutex.c:759
 ww_mutex_lock+0x40/0x1f0 kernel/locking/mutex.c:876
 modeset_lock+0x2bf/0x650 drivers/gpu/drm/drm_modeset_lock.c:314
 drm_atomic_get_plane_state+0x1c1/0x500 drivers/gpu/drm/drm_atomic.c:541
 drm_client_modeset_commit_atomic+0x1a1/0x7e0 drivers/gpu/drm/drm_client_modeset.c:1020
 drm_client_modeset_commit_locked+0xe0/0x520 drivers/gpu/drm/drm_client_modeset.c:1171
 pan_display_atomic drivers/gpu/drm/drm_fb_helper.c:1371 [inline]
 drm_fb_helper_pan_display+0x379/0xc10 drivers/gpu/drm/drm_fb_helper.c:1431
 fb_pan_display+0x3a3/0x680 drivers/video/fbdev/core/fbmem.c:191
 bit_update_start+0x4d/0x1c0 drivers/video/fbdev/core/bitblit.c:381
 fbcon_switch+0x144b/0x2250 drivers/video/fbdev/core/fbcon.c:2186
 redraw_screen+0x546/0xe90 drivers/tty/vt/vt.c:957
 fbcon_prepare_logo+0x9ba/0xd20 drivers/video/fbdev/core/fbcon.c:633
 con2fb_init_display drivers/video/fbdev/core/fbcon.c:819 [inline]
 set_con2fb_map+0xc24/0x11e0 drivers/video/fbdev/core/fbcon.c:885
 do_fb_registered drivers/video/fbdev/core/fbcon.c:2992 [inline]
 fbcon_fb_registered+0x251/0x620 drivers/video/fbdev/core/fbcon.c:3008
 do_register_framebuffer drivers/video/fbdev/core/fbmem.c:449 [inline]
 register_framebuffer+0x654/0x810 drivers/video/fbdev/core/fbmem.c:515
 __drm_fb_helper_initial_config_and_unlock+0x1716/0x1df0 drivers/gpu/drm/drm_fb_helper.c:1869
 drm_fbdev_shmem_client_hotplug+0x16e/0x230 drivers/gpu/drm/drm_fbdev_shmem.c:250
 drm_client_register+0x17f/0x210 drivers/gpu/drm/drm_client.c:141
 virtio_gpu_probe+0x22e/0x3c0 drivers/gpu/drm/virtio/virtgpu_drv.c:106
 virtio_dev_probe+0x931/0xc80 drivers/virtio/virtio.c:341
 really_probe+0x2b8/0xad0 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
 bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:370
 bus_add_driver+0x346/0x670 drivers/base/bus.c:675
 driver_register+0x23a/0x320 drivers/base/driver.c:246
 do_one_initcall+0x248/0x880 init/main.c:1269
 do_initcall_level+0x157/0x210 init/main.c:1331
 do_initcalls+0x3f/0x80 init/main.c:1347
 kernel_init_freeable+0x435/0x5d0 init/main.c:1580
 kernel_init+0x1d/0x2b0 init/main.c:1469
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/0:1:9 blocked for more than 143 seconds.
      Not tainted 6.11.0-syzkaller-11993-g3efc57369a0c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:26192 pid:9     tgid:9     ppid:2      flags:0x00004000
Workqueue: events virtio_gpu_dequeue_ctrl_func
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 drm_client_dev_hotplug+0xd0/0x3c0 drivers/gpu/drm/drm_client.c:230
 virtio_gpu_dequeue_ctrl_func+0x605/0xa50 drivers/gpu/drm/virtio/virtgpu_vq.c:235
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/0:2:783 blocked for more than 143 seconds.
      Not tainted 6.11.0-syzkaller-11993-g3efc57369a0c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D stack:24368 pid:783   tgid:783   ppid:2      flags:0x00004000
Workqueue: events drm_fb_helper_damage_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 virtio_gpu_queue_ctrl_sgs drivers/gpu/drm/virtio/virtgpu_vq.c:341 [inline]
 virtio_gpu_queue_fenced_ctrl_buffer+0x720/0xff0 drivers/gpu/drm/virtio/virtgpu_vq.c:415
 virtio_gpu_resource_flush drivers/gpu/drm/virtio/virtgpu_plane.c:162 [inline]
 virtio_gpu_primary_plane_update+0xd39/0x1590 drivers/gpu/drm/virtio/virtgpu_plane.c:237
 drm_atomic_helper_commit_planes+0x5ee/0xe00 drivers/gpu/drm/drm_atomic_helper.c:2800
 drm_atomic_helper_commit_tail+0x5e/0x500 drivers/gpu/drm/drm_atomic_helper.c:1750
 commit_tail+0x2c1/0x3c0 drivers/gpu/drm/drm_atomic_helper.c:1835
 drm_atomic_helper_commit+0x953/0x9f0 drivers/gpu/drm/drm_atomic_helper.c:2073
 drm_atomic_commit+0x296/0x2f0 drivers/gpu/drm/drm_atomic.c:1516
 drm_atomic_helper_dirtyfb+0xd10/0xe70 drivers/gpu/drm/drm_damage_helper.c:181
 drm_fbdev_shmem_helper_fb_dirty+0x151/0x2c0 drivers/gpu/drm/drm_fbdev_shmem.c:197
 drm_fb_helper_fb_dirty drivers/gpu/drm/drm_fb_helper.c:376 [inline]
 drm_fb_helper_damage_work+0x275/0x880 drivers/gpu/drm/drm_fb_helper.c:399
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
9 locks held by swapper/0/1:
 #0: ffff88801fb62170 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #0: ffff88801fb62170 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #0: ffff88801fb62170 (&dev->mutex){....}-{3:3}, at: __driver_attach+0x454/0x710 drivers/base/dd.c:1215
 #1: ffff8880331942f8 (&dev->clientlist_mutex){+.+.}-{3:3}, at: drm_client_register+0x4e/0x210 drivers/gpu/drm/drm_client.c:127
 #2: ffffffff8f0eb208 (registration_lock){+.+.}-{3:3}, at: register_framebuffer+0x87/0x810 drivers/video/fbdev/core/fbmem.c:514
 #3: ffffffff8e813380 (console_lock){+.+.}-{0:0}, at: fbcon_fb_registered+0x54/0x620 drivers/video/fbdev/core/fbcon.c:3004
 #4: ffff8880004cf280 (&helper->lock){+.+.}-{3:3}, at: drm_fb_helper_pan_display+0xbc/0xc10 drivers/gpu/drm/drm_fb_helper.c:1424
 #5: ffff8880331941b0 (&dev->master_mutex){+.+.}-{3:3}, at: drm_master_internal_acquire+0x20/0x70 drivers/gpu/drm/drm_auth.c:452
 #6: ffff8880004cf098 (&client->modeset_mutex){+.+.}-{3:3}, at: drm_client_modeset_commit_locked+0x50/0x520 drivers/gpu/drm/drm_client_modeset.c:1169
 #7: ffffc90000336bf0 (crtc_ww_class_acquire){+.+.}-{0:0}, at: drm_client_modeset_commit_atomic+0xd5/0x7e0 drivers/gpu/drm/drm_client_modeset.c:1007
 #8: ffff8880004d20b0 (crtc_ww_class_mutex){+.+.}-{3:3}, at: modeset_lock+0x2bf/0x650 drivers/gpu/drm/drm_modeset_lock.c:314
3 locks held by kworker/0:1/9:
 #0: ffff88801ac74948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac74948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900003b7d00 ((work_completion)(&vgvq->dequeue_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900003b7d00 ((work_completion)(&vgvq->dequeue_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff8880331942f8 (&dev->clientlist_mutex){+.+.}-{3:3}, at: drm_client_dev_hotplug+0xd0/0x3c0 drivers/gpu/drm/drm_client.c:230
1 lock held by khungtaskd/25:
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6701
2 locks held by kworker/u4:3/46:
 #0: ffff88801ac79148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac79148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc9000060fd00 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000060fd00 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
2 locks held by kswapd0/75:
5 locks held by kworker/0:2/783:
 #0: ffff88801ac74948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac74948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc9000179fd00 ((work_completion)(&helper->damage_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000179fd00 ((work_completion)(&helper->damage_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffc9000179f970 (crtc_ww_class_acquire){+.+.}-{0:0}, at: drm_atomic_helper_dirtyfb+0xce/0xe70 drivers/gpu/drm/drm_damage_helper.c:123
 #3: ffff8880004d20b0 (crtc_ww_class_mutex){+.+.}-{3:3}, at: modeset_lock+0x2bf/0x650 drivers/gpu/drm/drm_modeset_lock.c:314
 #4: ffffffff8f1c5730 (drm_unplug_srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:151 [inline]
 #4: ffffffff8f1c5730 (drm_unplug_srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:250 [inline]
 #4: ffffffff8f1c5730 (drm_unplug_srcu){.+.+}-{0:0}, at: drm_dev_enter+0x45/0x150 drivers/gpu/drm/drm_drv.c:448

=============================================



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

