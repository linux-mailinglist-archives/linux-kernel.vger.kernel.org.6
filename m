Return-Path: <linux-kernel+bounces-396294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4199BCB06
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAEFB285ED5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342E01D2F4E;
	Tue,  5 Nov 2024 10:52:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42B81D2B10
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803925; cv=none; b=mY8QavJJo20580HyOKOhWK0C6GlnZV30Rmy4K19aSIPgAs4/noncNja7xsP35qxjR/Qra44aLrj4eYgjkMoJZ9oQchuHzUMcBsj/jm5TwK+XHowNHcgjJ0MWibkboSIcbHonQJ79eKYkv3wFD0cBQqeMsEr0MC7ip8qQpC7aS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803925; c=relaxed/simple;
	bh=6rOf09eteG0jW3XFQvLRSp+MANPC+67kBrO4vHpRLho=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KVmGth/PAd9U9nGRHQInXEnH2SKgXnuK7MNpxG2G5ZAEl0y5PgnWbfJhkVUl6NO8W0XNkxDspmDd7YzXvWi7wqEwFqcSQwP1he+0Omcc2RopV89tCnYWhrHL07ljp9FsZSpolH49iafguOBrKYn+KIOQ86c75ymeXiqlXvysJQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83aac7e7fd7so611688839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 02:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730803923; x=1731408723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMFdO4/9LNhl/HaJVvG/qNzQqZxHSd7Oaza0tLN11fY=;
        b=HwsGunlDszDjACiLLFNNqhBwy9ADCVxm+wH79FjWFRwBaARHC0BL3EUiVyJepTpcKe
         X4YQFqhgZyVEMe0W+7fNnrxbNiqbINImd6jbbxhdNYovHz8XarrJg3zy5iyfCtRYjqrG
         oq4gwYPzRoT3FBqLed+l/Rm8PN4Gc0GDaHrkP8Sxi7ZAbb6a4lJbSYIyYpv24LotdXHy
         bPUBDtOjIAb5adVfBUkwuGTV8X/n3jm34dG2Xv1rTwb6XHPuOiEd/7e/5uzy2RwS0Akz
         ADK7FZphJbazVpZ/WEQhM3pCtOLXR3ZUcIQpuAMdY82h8WLRsT8KBuNSVc2zfmgKuU6J
         5AOw==
X-Forwarded-Encrypted: i=1; AJvYcCXRY3UWDSwWP2Vp37PoKJHdbApN0VzmctxQZnW5f9cZGH2zNO5cPbcYjDIGp3P7l3qnVE3zNpvn0tSLazc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkbmrn/oojPsX5xh/AF5ld6qltVn0ClxhGA2BI/FUmXCGT7tDG
	ydwlOPKkCFJFLi5s5pwjuF3e/TyLJwtfSnQAvHKqjCsoiyzB7Yremw8Z14qHuCZSUsf/sns13zL
	f/qzQCokPMI9aSKO5Q+HgxHTmzFCdS6oSF0oQE00gTnk4oVhy9uFEt6Y=
X-Google-Smtp-Source: AGHT+IFoM7ZPzUILBiOr9cdeT949DoCKBaoO9uE7vPAJNXa49/BGhJv+4JqMBXfcHJ1Hwpnd9GDN27B8Vqj2TYR8nAqDVDFg7JdJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1988:b0:3a6:ca38:6862 with SMTP id
 e9e14a558f8ab-3a6ca386d1fmr86399365ab.19.1730803922837; Tue, 05 Nov 2024
 02:52:02 -0800 (PST)
Date: Tue, 05 Nov 2024 02:52:02 -0800
In-Reply-To: <tencent_BAECB2CD2C7B7E6C742CD56CA897E4E9B20A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6729f8d2.050a0220.701a.001a.GAE@google.com>
Subject: Re: [syzbot] [sound?] INFO: task hung in snd_card_free
From: syzbot <syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in put_device

card: ffff88807b9a4000, snd_card_do_free
card: ffff88807b9a4000, snd_ctl_dev_free
card: ffff88807b9a4000, snd_usx2y_card_private_free
card: ffff88807b9a4000, snd_ctl_release
==================================================================
BUG: KASAN: slab-use-after-free in kobject_put+0x4ed/0x5a0 lib/kobject.c:733
Read of size 1 at addr ffff88807b9a442c by task syz.2.17/6875

CPU: 0 UID: 0 PID: 6875 Comm: syz.2.17 Not tainted 6.12.0-rc6-syzkaller-g2e1b3cc9d7f7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 kobject_put+0x4ed/0x5a0 lib/kobject.c:733
 put_device+0x1f/0x30 drivers/base/core.c:3780
 snd_card_unref include/sound/core.h:314 [inline]
 snd_ctl_release+0x3b2/0x480 sound/core/control.c:142
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f017e37e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe61637728 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 0000000000019275 RCX: 00007f017e37e719
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f017e537a80 R08: 0000000000000001 R09: 00007ffe61637a1f
R10: 00007f017e200000 R11: 0000000000000246 R12: 00000000000196c6
R13: 00007ffe61637830 R14: 0000000000000032 R15: ffffffffffffffff
 </TASK>

Allocated by task 2142:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x1e8/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 snd_card_new+0x74/0x120 sound/core/init.c:184
 usx2y_create_card sound/usb/usx2y/usbusx2y.c:369 [inline]
 snd_usx2y_probe+0x387/0x9c0 sound/usb/usx2y/usbusx2y.c:450
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3672
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
 device_add+0x114b/0x1a70 drivers/base/core.c:3672
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d9a/0x4e10 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 6875:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4727
 snd_card_do_free sound/core/init.c:607 [inline]
 release_card_device+0x17f/0x1f0 sound/core/init.c:153
 device_release+0xa1/0x240 drivers/base/core.c:2574
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e4/0x5a0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3780
 snd_card_file_remove+0x3a0/0x5b0 sound/core/init.c:1132
 snd_ctl_release+0x390/0x480 sound/core/control.c:140
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807b9a4000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 1068 bytes inside of
 freed 4096-byte region [ffff88807b9a4000, ffff88807b9a5000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7b9a0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b042140 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801b042140 dead000000000122 0000000000000000
head: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea0001ee6801 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6887, tgid 6887 (kworker/u8:7), ts 103656163705, free_ts 103633261852
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0xf7d/0x2d10 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2412 [inline]
 allocate_slab mm/slub.c:2578 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2631
 ___slab_alloc+0xdac/0x1880 mm/slub.c:3818
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __kmalloc_cache_noprof+0x2b4/0x300 mm/slub.c:4290
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 tomoyo_environ security/tomoyo/domain.c:633 [inline]
 tomoyo_find_next_domain+0xba0/0x2070 security/tomoyo/domain.c:881
 tomoyo_bprm_check_security security/tomoyo/tomoyo.c:102 [inline]
 tomoyo_bprm_check_security+0x12b/0x1d0 security/tomoyo/tomoyo.c:92
 security_bprm_check+0x1b9/0x1e0 security/security.c:1297
 search_binary_handler fs/exec.c:1740 [inline]
 exec_binprm fs/exec.c:1794 [inline]
 bprm_execve fs/exec.c:1845 [inline]
 bprm_execve+0x642/0x1960 fs/exec.c:1821
 kernel_execve+0x2ef/0x3b0 fs/exec.c:2012
 call_usermodehelper_exec_async+0x255/0x4c0 kernel/umh.c:110
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
page last free pid 6618 tgid 6618 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 __put_partials+0x14c/0x170 mm/slub.c:3145
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_node_noprof+0x153/0x310 mm/slub.c:4186
 __alloc_skb+0x2b1/0x380 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1322 [inline]
 netlink_alloc_large_skb+0x69/0x130 net/netlink/af_netlink.c:1206
 netlink_sendmsg+0x689/0xd70 net/netlink/af_netlink.c:1876
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg net/socket.c:744 [inline]
 __sys_sendto+0x479/0x4d0 net/socket.c:2214
 __do_sys_sendto net/socket.c:2226 [inline]
 __se_sys_sendto net/socket.c:2222 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2222
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807b9a4300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807b9a4380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807b9a4400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88807b9a4480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807b9a4500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         2e1b3cc9 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=175596a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2effb62852f5a821
dashboard link: https://syzkaller.appspot.com/bug?extid=73582d08864d8268b6fd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=128aed5f980000


