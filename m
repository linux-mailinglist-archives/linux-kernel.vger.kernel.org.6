Return-Path: <linux-kernel+bounces-334940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B4497DE97
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 21:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA2B282180
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 19:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07E07868B;
	Sat, 21 Sep 2024 19:43:23 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB452868D
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726947803; cv=none; b=faroKqTWRfMg1Go+nGSiQOvcG20sC0uv8qNR+JVE60fpG4biaGA4Nq8I0ZplFaekuGBkblXJHNuc2Ibo7MxljrI4p8wGlG5yRTPVx9aWVI2fwV9yFdziXHpt7KsNis3ywzquFu9ZiDfuWAmCvBDJCgVpnV1YLte/oOFCYuq2l9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726947803; c=relaxed/simple;
	bh=bf6v1VyGO8/kwORwl28Nv90TBtmEMiyiWecgQq+iOtA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BbS5dQVcowjc3/u3/8xyBXe/M0JiHu5gY5R6ghTpb0VF0m1JL5Y84zkK+cOxDrx2AaqPHI1A/h2aKrGV3vGhYDjFlowA7DqgvzSKMqJXmgFFWR8fi/TK48uPBiFA2iHUTWzNdCZM5nQSapG+iaWeZ5EV8yNOuQwPuT54U/VQCz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a04c2472f6so33821785ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 12:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726947799; x=1727552599;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bjWLuVWnB1+w6IOx8FLl3w+J9AWvt9qhKoTVCfYx2h0=;
        b=nHKYSIRIMP9ynqZ8jZKqfRksEDJAqQYU2M9v4jFl/Pjjla/rD9tDKhFT7sbivR1iMT
         7+V3ypWECCLltbpQS9B/hNVSNx5zKcN2HeaRmwt5UwUlFF7guAxWYNcheZ6AEBQwlc7i
         KaLhLSFQyz4AhXBt5WqrDlce8Qvm3S8VPd9ZBKklPwzWdtP2NrsJPHi0K+oHFZYUrhH9
         nVlgK5mmVDCjR9BeHUK7k2VTBbhUVpJLpiRrMMZ7ipYsXb5wHOgpm6uyuz3X5gxtIHjS
         9/2xJ3TTeJT+l7KsUNfGSc4UZJpDwz6LUMoAtEGFyWar/t7QMhR+li2bai5ytPNgq2Na
         geiA==
X-Forwarded-Encrypted: i=1; AJvYcCXDsdR0YfWGBqOkVXIEWdAuFzyQhnfbY7dmSDdW77mRORtBxWNuKwbiqdER4hcWun377xJ4L1CUrtOHC5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYfizmFQ23zjIC4jGeiFvz3GrS1clDwwIbg8QYlIKTVo1QKXb+
	uO9DrNQLS6mMd6dMK/k8d2ThqjnicRitFmI2mGCHwTM/njIs0e1DN9MyMsop2uls9gvdOrtgk+u
	Vf8uE9srjbqSnk0pQiNoA1GVwrlNUNLtZRab9wwQqPx6bPFhll1fvGsc=
X-Google-Smtp-Source: AGHT+IGioiFL/pUyGoyqtnDoFi0dFOMf+hnnLtJZkKhoH0scpPk6kExdbPOEjwB4GofsHFk5UsA9zuKBjs4v65EYs5svtqpGGZnq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198b:b0:39e:78d9:ebf4 with SMTP id
 e9e14a558f8ab-3a0c8d2af50mr64311485ab.22.1726947799583; Sat, 21 Sep 2024
 12:43:19 -0700 (PDT)
Date: Sat, 21 Sep 2024 12:43:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ef21d7.050a0220.3195df.0068.GAE@google.com>
Subject: [syzbot] [usb?] KASAN: slab-use-after-free Read in raw_ioctl_ep_set_clear_halt_wedge
From: syzbot <syzbot+1966d2bbc2befdc0ba2c@syzkaller.appspotmail.com>
To: andreyknvl@gmail.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    68d4209158f4 sub: cdns3: Use predefined PCI vendor ID cons..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=143d8080580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb61872d4d8c5df9
dashboard link: https://syzkaller.appspot.com/bug?extid=1966d2bbc2befdc0ba2c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c69290425359/disk-68d42091.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/caf4f26a3e85/vmlinux-68d42091.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3acdec4b62e6/bzImage-68d42091.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1966d2bbc2befdc0ba2c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in usb_endpoint_xfer_isoc include/uapi/linux/usb/ch9.h:563 [inline]
BUG: KASAN: slab-use-after-free in raw_ioctl_ep_set_clear_halt_wedge+0x4be/0x7c0 drivers/usb/gadget/legacy/raw_gadget.c:1012
Read of size 1 at addr ffff888111e55b83 by task syz.4.752/7534

CPU: 1 UID: 0 PID: 7534 Comm: syz.4.752 Not tainted 6.11.0-rc7-syzkaller-00152-g68d4209158f4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 usb_endpoint_xfer_isoc include/uapi/linux/usb/ch9.h:563 [inline]
 raw_ioctl_ep_set_clear_halt_wedge+0x4be/0x7c0 drivers/usb/gadget/legacy/raw_gadget.c:1012
 raw_ioctl+0x105/0x2b90 drivers/usb/gadget/legacy/raw_gadget.c:1350
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2f3c32def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2f3afa1038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2f3c4e5f80 RCX: 00007f2f3c32def9
RDX: 0000000000000000 RSI: 000000004004550d RDI: 0000000000000003
RBP: 00007f2f3c3a0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2f3c4e5f80 R15: 00007ffdece30528
 </TASK>

Allocated by task 7538:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x8f/0xa0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4162 [inline]
 __kmalloc_node_track_caller_noprof+0x1ff/0x3e0 mm/slub.c:4181
 memdup_user+0x2a/0xd0 mm/util.c:226
 raw_ioctl_ep_enable drivers/usb/gadget/legacy/raw_gadget.c:847 [inline]
 raw_ioctl+0xbca/0x2b90 drivers/usb/gadget/legacy/raw_gadget.c:1318
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 7534:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x14/0x30 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x10b/0x380 mm/slub.c:4598
 dev_free+0x446/0x700 drivers/usb/gadget/legacy/raw_gadget.c:225
 kref_put include/linux/kref.h:65 [inline]
 raw_release+0x16e/0x2c0 drivers/usb/gadget/legacy/raw_gadget.c:473
 __fput+0x408/0xbb0 fs/file_table.c:422
 __fput_sync+0x47/0x50 fs/file_table.c:507
 __do_sys_close fs/open.c:1566 [inline]
 __se_sys_close fs/open.c:1551 [inline]
 __x64_sys_close+0x86/0x100 fs/open.c:1551
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888111e55b80
 which belongs to the cache kmalloc-16 of size 16
The buggy address is located 3 bytes inside of
 freed 16-byte region [ffff888111e55b80, ffff888111e55b90)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x111e55
flags: 0x200000000000000(node=0|zone=2)
page_type: 0xfdffffff(slab)
raw: 0200000000000000 ffff888100041640 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000800080 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 9, tgid 9 (kworker/0:1), ts 108651586204, free_ts 108237529970
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x1311/0x25f0 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x21e/0x2290 mm/page_alloc.c:4702
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x4e/0xf0 mm/slub.c:2325
 allocate_slab mm/slub.c:2488 [inline]
 new_slab+0x84/0x260 mm/slub.c:2541
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3727
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3817
 __slab_alloc_node mm/slub.c:3870 [inline]
 slab_alloc_node mm/slub.c:4029 [inline]
 __do_kmalloc_node mm/slub.c:4161 [inline]
 __kmalloc_noprof+0x325/0x3c0 mm/slub.c:4174
 kmalloc_noprof include/linux/slab.h:685 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 rh_call_control drivers/usb/core/hcd.c:491 [inline]
 rh_urb_enqueue drivers/usb/core/hcd.c:821 [inline]
 usb_hcd_submit_urb+0x6b6/0x2090 drivers/usb/core/hcd.c:1529
 usb_submit_urb+0x87c/0x1730 drivers/usb/core/urb.c:581
 usb_start_wait_urb+0x103/0x4c0 drivers/usb/core/message.c:59
 usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
 usb_control_msg+0x327/0x4b0 drivers/usb/core/message.c:154
 usb_clear_port_feature drivers/usb/core/hub.c:453 [inline]
 hub_activate+0xb02/0x1d60 drivers/usb/core/hub.c:1230
 hub_resume+0xaa/0x3f0 drivers/usb/core/hub.c:4005
 usb_resume_interface.constprop.0.isra.0+0x2c8/0x3e0 drivers/usb/core/driver.c:1379
 usb_resume_both+0x274/0x800 drivers/usb/core/driver.c:1539
page last free pid 4937 tgid 4937 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_page+0x698/0xce0 mm/page_alloc.c:2619
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x4e/0x70 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3992 [inline]
 slab_alloc_node mm/slub.c:4041 [inline]
 kmem_cache_alloc_noprof+0x11c/0x2b0 mm/slub.c:4048
 getname_flags.part.0+0x4c/0x550 fs/namei.c:139
 getname_flags include/linux/audit.h:322 [inline]
 getname fs/namei.c:225 [inline]
 __do_sys_unlink fs/namei.c:4534 [inline]
 __se_sys_unlink fs/namei.c:4532 [inline]
 __x64_sys_unlink+0xb0/0x110 fs/namei.c:4532
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888111e55a80: 00 00 fc fc 00 01 fc fc fa fb fc fc 00 00 fc fc
 ffff888111e55b00: fa fb fc fc 00 00 fc fc fa fb fc fc fa fb fc fc
>ffff888111e55b80: fa fb fc fc 00 00 fc fc fa fb fc fc fa fb fc fc
                   ^
 ffff888111e55c00: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
 ffff888111e55c80: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
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

