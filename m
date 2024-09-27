Return-Path: <linux-kernel+bounces-341899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD329887F9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE64C283FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D3C1C172E;
	Fri, 27 Sep 2024 15:10:30 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26B51465A9
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449829; cv=none; b=mZwTLNq/pRXBys7OU0ycyXlBdTKs7nOUF4YsPszes/C7GXUO8sgfZBsZkzN9x6tfM14fDYLdC0r1NZ2CQ6scI/MuxHiefr1UfGIQZGUdgvUSyKbaYqJ4DBfgsqqLtho+bAtayN4OG+ntalQONUEYkA18oXJTyPzOV11srte9wPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449829; c=relaxed/simple;
	bh=tbQlpSYDQbJIWs+I6PoKHmXEbRrMwnswxHoSLa5T9+k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oLKm2Q4fo2ast3qpBagRP0/v39p16wO33BUM7w3+ISXu06DIRZNq4MldlCREpMmvzE5p1vuv6h+K7b0sVEyRCiphxyAdLea5EXuDH9/F3I2g9Js678CUXixtlPd8zuS0xpktin8l44FcvMJ33cg96VFESQ/YxwjJg1GC/R+pCwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a19534ac2fso27607975ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727449827; x=1728054627;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ERlCl2uGX1D9UD9O6/6oh/wf/ZOom1paAo5/+bUQn0E=;
        b=PY0zQxVb5GFzoqxLob4bgtEhlf3eA2qkQ1A89CXjB2/xFvCMlUfcBj2vdh24/Nb0Z3
         bJOWHumUlyDR/NJI7LOcaHbZeTibzEMDsVV5S5DzwEesGyb9GtO1H6bB48VFjGsLLOg9
         r/rRTIPXvGlSB2Vrr+cQpTRWIH+MbE8GIRKR+O6u5ebbO+yvv1CBD1yeKSPo+0bMuaEe
         rS3BtnL4JRBfgegYYkdMJhdu5UgXSIXv5I5SVikb7qlN/FcxQuCMri0cYkGilJVAlPT2
         C3iGs6YDNb3mitAk1wF8GlRBOh1U0SXCKYhtMXs7k29b+l7Jj3sWw4kuP0WyoSkhwq6H
         MK7A==
X-Forwarded-Encrypted: i=1; AJvYcCWSLFpHWiEGyq31AjgirNfweEfUGSeC1IFjx1nyD77HlwgJG1HABRLTyCbA12oN5JhmAfVHDjZwGFabTPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpOmHVvHbEJnokTCwWvF4WxGWhPHiKBKECbw7AgNDcVXp5fSNs
	q7dJxJL9fmds2I0IoWEVBl+R++N1SQDGjXDoEARIE7qkRAWRWcK5LK03KbzCcm1v8N+E5CQFPcV
	3B1UGhioZZ1cC7F3omTNomFFAEsLNRK3LgilfOApZSz8Ap4f1gZUYLvM=
X-Google-Smtp-Source: AGHT+IGg4soPYa/5ZkMZNlCRvLjGd6EtJf5hLBmIDpVQVQzb3/BpiWuaUeifRwlgY8sDSQg1N1+gk4NkTRRKDbUlo9LnzfSOtWku
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216e:b0:39f:60d7:813b with SMTP id
 e9e14a558f8ab-3a3452bf4damr29639725ab.22.1727449827013; Fri, 27 Sep 2024
 08:10:27 -0700 (PDT)
Date: Fri, 27 Sep 2024 08:10:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6cae2.050a0220.46d20.0020.GAE@google.com>
Subject: [syzbot] [kernfs?] KASAN: slab-use-after-free Read in kernfs_add_one
From: syzbot <syzbot+81380e5b57bacce8a9f6@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d1f2d51b711a Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15bf0e00580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58a85aa6925a8b78
dashboard link: https://syzkaller.appspot.com/bug?extid=81380e5b57bacce8a9f6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1517895ef9e6/disk-d1f2d51b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a5831fb8e0a7/vmlinux-d1f2d51b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3291515529ce/bzImage-d1f2d51b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+81380e5b57bacce8a9f6@syzkaller.appspotmail.com

usb 1-1: Direct firmware load for ueagle-atm/eagleII.fw failed with error -2
usb 1-1: Falling back to sysfs fallback for: ueagle-atm/eagleII.fw
==================================================================
BUG: KASAN: slab-use-after-free in kernfs_root fs/kernfs/kernfs-internal.h:70 [inline]
BUG: KASAN: slab-use-after-free in kernfs_add_one+0x447/0x8b0 fs/kernfs/dir.c:818
Read of size 8 at addr ffff88803434d990 by task kworker/0:5/5284

CPU: 0 UID: 0 PID: 5284 Comm: kworker/0:5 Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kernfs_root fs/kernfs/kernfs-internal.h:70 [inline]
 kernfs_add_one+0x447/0x8b0 fs/kernfs/dir.c:818
 kernfs_create_dir_ns+0xd9/0x120 fs/kernfs/dir.c:1071
 sysfs_create_dir_ns+0x189/0x3a0 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:73 [inline]
 kobject_add_internal+0x435/0x8d0 lib/kobject.c:240
 kobject_add_varg lib/kobject.c:374 [inline]
 kobject_add+0x152/0x220 lib/kobject.c:426
 class_dir_create_and_add drivers/base/core.c:3225 [inline]
 get_device_parent+0x391/0x410 drivers/base/core.c:3276
 device_add+0x325/0xbf0 drivers/base/core.c:3606
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:86 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:162 [inline]
 firmware_fallback_sysfs+0x307/0x9e0 drivers/base/firmware_loader/fallback.c:238
 _request_firmware+0xcf5/0x12b0 drivers/base/firmware_loader/main.c:914
 request_firmware_work_func+0x12a/0x280 drivers/base/firmware_loader/main.c:1165
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5284:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3992 [inline]
 slab_alloc_node mm/slub.c:4041 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4048
 __kernfs_new_node+0xd8/0x870 fs/kernfs/dir.c:624
 kernfs_new_node+0x137/0x240 fs/kernfs/dir.c:700
 kernfs_create_dir_ns+0x43/0x120 fs/kernfs/dir.c:1061
 sysfs_create_dir_ns+0x189/0x3a0 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:73 [inline]
 kobject_add_internal+0x435/0x8d0 lib/kobject.c:240
 kobject_add_varg lib/kobject.c:374 [inline]
 kobject_add+0x152/0x220 lib/kobject.c:426
 class_dir_create_and_add drivers/base/core.c:3225 [inline]
 get_device_parent+0x391/0x410 drivers/base/core.c:3276
 device_add+0x325/0xbf0 drivers/base/core.c:3606
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:86 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:162 [inline]
 firmware_fallback_sysfs+0x307/0x9e0 drivers/base/firmware_loader/fallback.c:238
 _request_firmware+0xcf5/0x12b0 drivers/base/firmware_loader/main.c:914
 request_firmware_work_func+0x12a/0x280 drivers/base/firmware_loader/main.c:1165
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 16:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4552
 rcu_do_batch kernel/rcu/tree.c:2569 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2843
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:928
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3106 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3210
 kernfs_put+0x1dc/0x370 fs/kernfs/dir.c:578
 __kernfs_remove+0x768/0x870 fs/kernfs/dir.c:1508
 kernfs_remove+0x7a/0xa0 fs/kernfs/dir.c:1528
 __kobject_del+0xe2/0x310 lib/kobject.c:604
 kobject_del+0x45/0x60 lib/kobject.c:627
 device_del+0x7ff/0x9b0 drivers/base/core.c:3891
 usb_disconnect+0x60b/0x950 drivers/usb/core/hub.c:2332
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1ebc/0x5150 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88803434d960
 which belongs to the cache kernfs_node_cache of size 176
The buggy address is located 48 bytes inside of
 freed 176-byte region [ffff88803434d960, ffff88803434da10)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3434d
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff88801bafedc0 ffffea00017d3b80 dead000000000006
raw: 0000000000000000 0000000080110011 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 13386431658, free_ts 13376370430
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4702
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2325
 allocate_slab+0x5a/0x2f0 mm/slub.c:2488
 new_slab mm/slub.c:2541 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3727
 __slab_alloc+0x58/0xa0 mm/slub.c:3817
 __slab_alloc_node mm/slub.c:3870 [inline]
 slab_alloc_node mm/slub.c:4029 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4048
 __kernfs_new_node+0xd8/0x870 fs/kernfs/dir.c:624
 kernfs_new_node+0x137/0x240 fs/kernfs/dir.c:700
 __kernfs_create_file+0x49/0x2e0 fs/kernfs/file.c:1034
 sysfs_add_file_mode_ns+0x24a/0x310 fs/sysfs/file.c:307
 create_files fs/sysfs/group.c:76 [inline]
 internal_create_group+0x7a7/0x11d0 fs/sysfs/group.c:180
 kernel_add_sysfs_param+0xec/0x130 kernel/params.c:819
 param_sysfs_builtin+0x16e/0x1f0 kernel/params.c:856
 param_sysfs_builtin_init+0x31/0x40 kernel/params.c:990
page last free pid 1173 tgid 1173 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2619
 vfree+0x186/0x2e0 mm/vmalloc.c:3367
 delayed_vfree_work+0x56/0x80 mm/vmalloc.c:3288
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff88803434d880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803434d900: fb fb fb fb fc fc fc fc fc fc fc fc fa fb fb fb
>ffff88803434d980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88803434da00: fb fb fc fc fc fc fc fc fc fc fa fb fb fb fb fb
 ffff88803434da80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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

