Return-Path: <linux-kernel+bounces-348249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A02A98E49E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18EF028432D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E19121731A;
	Wed,  2 Oct 2024 21:10:26 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74A21D1E60
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727903425; cv=none; b=ifGOC1hzuMyQw94k6TqDS5lpH9cLIroBZjyT/tMAzK6Rw7Ah65THs/d2dWKDi9n98rfpFy07R4ZI9t7OpgjN79gv6ylEHvZujRuy09o9MdqmpOxz41YZOP7c9bbxpX1mS86n1WxnJKeEoEyhc3vN+MFQcs5phtQycYVGhZXGlzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727903425; c=relaxed/simple;
	bh=BZ1g3J3vgJ4KygnQAQojhunYCfOB8xGDtY6CIzk/cDw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ikUoP0LVhg/nuBgdV8MthDYUYx1nykjmTrEt23rumLfoDbmmCTcjJP8RkdmyXI1kGZeVaeeZo09fgRhWEZB6HPMk2xoMPsF2h8845kx+j/U1ZIWL9e1FONGjamN1H9wofPy2tjAw7H2ul3OY6Ohrqfc0Bc/E4KPqZ5vB91fuZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cd9c20b2bso31126539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 14:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727903423; x=1728508223;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kiTuBXuk7cVHlNC+t9yll4mQCLb5F+N8w75BRdj4lXg=;
        b=fOaGa+/v4QZMnBtAxCvIJiLQOlRXAZJUFqk7/lxEECmC6sm/g8L/2+hh04RWAcqNm8
         ttSd9W0/dSTfZWWLo8g6j+rpzxA4CIT09XM7qF1Corx3/BeG+YFUlDWaz6MF4qZE9aGE
         wuLrsdhY9B1rlOZnfP1Y5tiwmlzOjR7MESTmJJQWVRQXDJEde7D+Lhq+dDtYOSvS+c8j
         qFnrsquO/HW2kgg7zX5tUaRYmE0Ca72k+gzPWHhpHxH5yvqmdSBYWjdG0YwhphNgdncx
         YIfOs+c5+A/q6eLdSrKUUibU1S08UJcl2Bq3upjQuMvu7SyaByJmJRfncFrvkMJb8m7I
         kt4g==
X-Forwarded-Encrypted: i=1; AJvYcCVMB8NeLYmsNtoZVX0HzWgX6sD48Z4I9YlsldrddbF09rSuq/ckTyyY4wD+CrR40jco0fI9ZhlSMocdk0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymcr0CA8RHux47GgpFKs+rk7OVEjSZZiPB+GVHWq0phqumeRds
	N8G/Bk9ZeKRdg6jEALJMuj/lKelkOR/e9WwU7MCBzo9b3ubeh2HOExJih2WMFUsEXNv505u47EV
	WvJhkfdXGgMkrv4nIpZJvth9K/QAtJJ2naBS3w9utkmIiQgJ2UAiMgTs=
X-Google-Smtp-Source: AGHT+IGiXUSSjljlIl0Okn1XXYo8/A2zSWAgy9P7wWR9/dD+eAsk8WMBQnhDX0HCbyUto7LNRd/fnIP7mny0jUp1QP6Uk/lKMs5r
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d16:b0:3a0:9a32:dedc with SMTP id
 e9e14a558f8ab-3a36591c7e0mr42030865ab.6.1727903422949; Wed, 02 Oct 2024
 14:10:22 -0700 (PDT)
Date: Wed, 02 Oct 2024 14:10:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fdb6be.050a0220.40bef.0024.GAE@google.com>
Subject: [syzbot] [kernel?] KASAN: slab-use-after-free Read in binder_release_work
From: syzbot <syzbot+9ba7a8cdae0440edd57b@syzkaller.appspotmail.com>
To: aardelean@baylibre.com, arve@android.com, brauner@kernel.org, 
	cmllamas@google.com, gregkh@linuxfoundation.org, joel@joelfernandes.org, 
	jonathan.cameron@huawei.com, linux-kernel@vger.kernel.org, maco@android.com, 
	nuno.sa@analog.com, surenb@google.com, syzkaller-bugs@googlegroups.com, 
	tkjos@android.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ad46e8f95e93 Merge tag 'pm-6.12-rc1-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16415e80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a1ec17f68be97c
dashboard link: https://syzkaller.appspot.com/bug?extid=9ba7a8cdae0440edd57b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f24d9f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ff3507980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-ad46e8f9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fc370c55f9af/vmlinux-ad46e8f9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/faf0e295018c/bzImage-ad46e8f9.xz

The issue was bisected to:

commit de79583ffe794663c53b77f97be814522d4edc4f
Author: Nuno Sa <nuno.sa@analog.com>
Date:   Tue Jul 2 16:02:33 2024 +0000

    iio: core: add accessors 'masklength'

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11e42d9f980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13e42d9f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=15e42d9f980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9ba7a8cdae0440edd57b@syzkaller.appspotmail.com
Fixes: de79583ffe79 ("iio: core: add accessors 'masklength'")

BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report+0x14c/0x1c0 lib/list_debug.c:49
Read of size 8 at addr ffff8880241da108 by task kworker/2:1/69

CPU: 2 UID: 0 PID: 69 Comm: kworker/2:1 Not tainted 6.11.0-syzkaller-11728-gad46e8f95e93 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events binder_deferred_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 __list_del_entry_valid_or_report+0x14c/0x1c0 lib/list_debug.c:49
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del_init include/linux/list.h:287 [inline]
 binder_dequeue_work_head_ilocked drivers/android/binder.c:540 [inline]
 binder_release_work+0x9b/0x490 drivers/android/binder.c:5110
 binder_deferred_release drivers/android/binder.c:6261 [inline]
 binder_deferred_func+0xe6e/0x12e0 drivers/android/binder.c:6296
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5330:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 binder_request_freeze_notification drivers/android/binder.c:3855 [inline]
 binder_thread_write+0xe19/0x4c60 drivers/android/binder.c:4485
 binder_ioctl_write_read drivers/android/binder.c:5387 [inline]
 binder_ioctl+0x265b/0x6fa0 drivers/android/binder.c:5718
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18f/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 69:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2343 [inline]
 slab_free mm/slub.c:4580 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4728
 binder_free_ref drivers/android/binder.c:1355 [inline]
 binder_deferred_release drivers/android/binder.c:6256 [inline]
 binder_deferred_func+0xdd7/0x12e0 drivers/android/binder.c:6296
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff8880241da100
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 8 bytes inside of
 freed 64-byte region [ffff8880241da100, ffff8880241da140)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x241da
ksm flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b0428c0 ffffea00009e6c40 dead000000000003
raw: 0000000000000000 0000000080200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 11, tgid 11 (kworker/u32:0), ts 6002017763, free_ts 5976749714
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25c0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2413 [inline]
 allocate_slab mm/slub.c:2579 [inline]
 new_slab+0x2ba/0x3f0 mm/slub.c:2632
 ___slab_alloc+0xdac/0x1880 mm/slub.c:3819
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3909
 __slab_alloc_node mm/slub.c:3962 [inline]
 slab_alloc_node mm/slub.c:4123 [inline]
 __kmalloc_cache_node_noprof+0xf1/0x350 mm/slub.c:4304
 kmalloc_node_noprof include/linux/slab.h:901 [inline]
 __get_vm_area_node+0xe1/0x2d0 mm/vmalloc.c:3106
 __vmalloc_node_range_noprof+0x26a/0x15a0 mm/vmalloc.c:3788
 alloc_thread_stack_node kernel/fork.c:314 [inline]
 dup_task_struct kernel/fork.c:1115 [inline]
 copy_process+0x2f12/0x8dc0 kernel/fork.c:2206
 kernel_clone+0xfd/0x960 kernel/fork.c:2787
 user_mode_thread+0xb4/0xf0 kernel/fork.c:2865
 call_usermodehelper_exec_work kernel/umh.c:172 [inline]
 call_usermodehelper_exec_work+0xcb/0x170 kernel/umh.c:158
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
page last free pid 9 tgid 9 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 vfree+0x17a/0x890 mm/vmalloc.c:3361
 delayed_vfree_work+0x56/0x70 mm/vmalloc.c:3282
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff8880241da000: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880241da080: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffff8880241da100: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                      ^
 ffff8880241da180: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880241da200: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

