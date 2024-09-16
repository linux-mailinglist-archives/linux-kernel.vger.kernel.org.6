Return-Path: <linux-kernel+bounces-331112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B516597A898
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A98D1C24B49
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1CF15FD16;
	Mon, 16 Sep 2024 21:10:35 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6513698F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726521035; cv=none; b=YDvM1rH8T3eGZFlwwfTgsaRkitjmrzLXTX9AmIZmcYtAdX2GD4N3zO+XVDiSmvx71Ole8K6oEAmgUErmVYiNDPJoe7rJCQZYNk5eFf4zE4bXYkKsCyyCMo1b+UA0rYXrLxFfoW5x1oBndghJtVkTJuXAzbqCVflaWcp1EhDkGcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726521035; c=relaxed/simple;
	bh=c3U3NFwUor9/0LZ0J6DjZjOJ+TVeClyr/Uthv3c/bTw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cdbU1qLvTRenTiVp9rY6qRDo4b9cMk4RyujrbQyYdsTIKAJj5ZQALizrJ+6HpYsexhs1PKw7SkHrETmdiDJsW5P1BYZWcUKr7oZ1i3OHwahx6/njNlQy0SOprE9RqbbtJjs4FiluzXVU2gOpKiV7/LsRV9dkChUi0LMG0YIzB1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82d0daa1b09so1005262839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 14:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726521032; x=1727125832;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AOvqDoyR+lWZsZeGtf1mqP5FvSV/9YIrNzIm+Je97rg=;
        b=lVID4reBz8jxmKfMy1K3uoWuMUZ3FzLbJbs+P3qVfDzT6+yGOYVFv+ih1hwBz+4UJo
         TmQOhTLhwcrhrsZRgCJdoYwDjPE7FUdBPqveOxc+NWNq4TUzUpAxPatZoXxa/jpsFXkD
         ST32XiLqXzSSSSIq0f1Y2uwRsW4ya9ja9WLmr4n/cebz2oRwmGP8Wo8G3JOCMuVzUeAR
         4tWrKY6C8ITpfFYUAix83zk9PD7wrD9L7LwtN4n1YiTrLxWzAbSaIPyrIhjDa6E86mzJ
         nMuGdBqUY/ollJzlUUHtubszTCGcQrmvUrumezuEfHpg1DyXP/vCgRiJbsoOfDNXLRp1
         CpAw==
X-Forwarded-Encrypted: i=1; AJvYcCW/LsEwEml3Y0ZQplZea90++e+NDGfN3zZanXciBrPllEkF2+3chnZ0Qj7/NK9B9fFz4ot1oZY0TpaPKq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW4Mog3VDUOEWqZxJWPulPmU+yN2GVyGrerMpXeEpLtyuripzw
	wjwpoGrtcVk+Nf78tC/O1RBCne557gmITtMRbNnJM7zhtve5t3/xTFjuzPT/muzY7fX9D7IRZ92
	H8TwHfmuOE9OtkeOWD7rl1N5nGk74JT+Z+EHBHK965kampoHiAsldgtk=
X-Google-Smtp-Source: AGHT+IH7p4gWFCtYPAzrO14YxRyuhChZY1xErK/vs9kmTq2F+f8KsXxXAw2dq5Nckn6l68HHHFuTpmzVn6dKG1nJrNImOpmRE3n7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6281:b0:822:3d11:106b with SMTP id
 ca18e2360f4ac-82d1f8c45ccmr1573175939f.1.1726521032305; Mon, 16 Sep 2024
 14:10:32 -0700 (PDT)
Date: Mon, 16 Sep 2024 14:10:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4042506224300fd@google.com>
Subject: [syzbot] [usb?] KASAN: slab-use-after-free Read in raw_process_ep_io
From: syzbot <syzbot+1412b4c05666882f1a0d@syzkaller.appspotmail.com>
To: andreyknvl@gmail.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    20371ba12063 Merge tag 'drm-fixes-2024-08-30' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17be4453980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c33ac4f18fd4c6c7
dashboard link: https://syzkaller.appspot.com/bug?extid=1412b4c05666882f1a0d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-20371ba1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c05996bb727/vmlinux-20371ba1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/88ec4a9fc0cc/bzImage-20371ba1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1412b4c05666882f1a0d@syzkaller.appspotmail.com

usblp0: error -71 reading from printer
==================================================================
BUG: KASAN: slab-use-after-free in usb_endpoint_dir_in include/uapi/linux/usb/ch9.h:494 [inline]
BUG: KASAN: slab-use-after-free in raw_process_ep_io+0x848/0xb90 drivers/usb/gadget/legacy/raw_gadget.c:1098
Read of size 1 at addr ffff8880125e09e2 by task syz.3.365/6589

CPU: 2 UID: 0 PID: 6589 Comm: syz.3.365 Not tainted 6.11.0-rc5-syzkaller-00176-g20371ba12063 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 usb_endpoint_dir_in include/uapi/linux/usb/ch9.h:494 [inline]
 raw_process_ep_io+0x848/0xb90 drivers/usb/gadget/legacy/raw_gadget.c:1098
 raw_ioctl_ep_write drivers/usb/gadget/legacy/raw_gadget.c:1152 [inline]
 raw_ioctl+0xc9c/0x2a50 drivers/usb/gadget/legacy/raw_gadget.c:1324
 __do_compat_sys_ioctl+0x2c3/0x330 fs/ioctl.c:1007
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f68579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5705514 EFLAGS: 00000292 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000040085507
RDX: 00000000f5705558 RSI: 00000000f73f0ff4 RDI: 00000000f57055e4
RBP: 00000000f5706578 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 6592:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4158 [inline]
 __kmalloc_node_track_caller_noprof+0x20f/0x440 mm/slub.c:4177
 memdup_user+0x2a/0xd0 mm/util.c:226
 raw_ioctl_ep_enable drivers/usb/gadget/legacy/raw_gadget.c:847 [inline]
 raw_ioctl+0x105d/0x2a50 drivers/usb/gadget/legacy/raw_gadget.c:1318
 __do_compat_sys_ioctl+0x2c3/0x330 fs/ioctl.c:1007
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Freed by task 6589:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4594
 dev_free+0x446/0x700 drivers/usb/gadget/legacy/raw_gadget.c:225
 kref_put include/linux/kref.h:65 [inline]
 raw_release+0x16e/0x2c0 drivers/usb/gadget/legacy/raw_gadget.c:473
 __fput+0x408/0xbb0 fs/file_table.c:422
 __fput_sync+0x47/0x50 fs/file_table.c:507
 __do_sys_close fs/open.c:1566 [inline]
 __se_sys_close fs/open.c:1551 [inline]
 __ia32_sys_close+0x86/0x100 fs/open.c:1551
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

The buggy address belongs to the object at ffff8880125e09e0
 which belongs to the cache kmalloc-16 of size 16
The buggy address is located 2 bytes inside of
 freed 16-byte region [ffff8880125e09e0, ffff8880125e09f0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880125e0ce0 pfn:0x125e0
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000200 ffff88801ac42640 ffffea00008a5b10 ffff88801ac40408
raw: ffff8880125e0ce0 0000000000800076 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 5359, tgid 5359 (syz-executor), ts 61887753741, free_ts 58155057252
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x1351/0x2e50 mm/page_alloc.c:3439
 __alloc_pages_slowpath mm/page_alloc.c:4228 [inline]
 __alloc_pages_noprof+0x6ad/0x2460 mm/page_alloc.c:4708
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x4e/0xf0 mm/slub.c:2321
 allocate_slab mm/slub.c:2484 [inline]
 new_slab+0x84/0x260 mm/slub.c:2537
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3723
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 __do_kmalloc_node mm/slub.c:4157 [inline]
 __kmalloc_node_noprof+0x367/0x440 mm/slub.c:4164
 __kvmalloc_node_noprof+0x9d/0x1a0 mm/util.c:650
 xt_jumpstack_alloc net/netfilter/x_tables.c:1355 [inline]
 xt_replace_table+0x1c7/0x910 net/netfilter/x_tables.c:1394
 __do_replace+0x1d9/0x9c0 net/ipv4/netfilter/arp_tables.c:912
 compat_do_replace+0x3ca/0x500 net/ipv4/netfilter/ip_tables.c:1529
 do_ip6t_set_ctl+0x686/0xc20 net/ipv6/netfilter/ip6_tables.c:1641
 nf_setsockopt+0x8a/0xf0 net/netfilter/nf_sockopt.c:101
 ipv6_setsockopt+0x133/0x1a0 net/ipv6/ipv6_sockglue.c:998
 tcp_setsockopt+0xa4/0x100 net/ipv4/tcp.c:3768
page last free pid 5359 tgid 5359 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2612
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 __kmalloc_cache_noprof+0x11e/0x310 mm/slub.c:4184
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 kset_create lib/kobject.c:965 [inline]
 kset_create_and_add+0x4d/0x190 lib/kobject.c:1008
 register_queue_kobjects net/core/net-sysfs.c:1887 [inline]
 netdev_register_kobject+0x1cd/0x3f0 net/core/net-sysfs.c:2140
 register_netdevice+0x1473/0x1e20 net/core/dev.c:10444
 veth_newlink+0x4fb/0x9e0 drivers/net/veth.c:1860
 rtnl_newlink_create net/core/rtnetlink.c:3510 [inline]
 __rtnl_newlink+0x119c/0x1920 net/core/rtnetlink.c:3730
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6647
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x47f/0x4e0 net/socket.c:2204

Memory state around the buggy address:
 ffff8880125e0880: 00 00 fc fc 00 00 fc fc 00 00 fc fc 00 00 fc fc
 ffff8880125e0900: 00 00 fc fc fa fb fc fc 00 00 fc fc 00 03 fc fc
>ffff8880125e0980: 00 01 fc fc 00 00 fc fc 00 03 fc fc fa fb fc fc
                                                       ^
 ffff8880125e0a00: 00 03 fc fc 00 00 fc fc 00 04 fc fc 00 00 fc fc
 ffff8880125e0a80: 00 00 fc fc 00 04 fc fc 00 00 fc fc 00 00 fc fc
==================================================================
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

