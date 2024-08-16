Return-Path: <linux-kernel+bounces-290287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD439551CE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D4D1C233B8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49F81C578A;
	Fri, 16 Aug 2024 20:25:25 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53628137747
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723839925; cv=none; b=mo6pbf/tOgsKkhZGum4qW7UNS+0a8osqmGQrff2tU/girqBdp3Us/OLtk87sQP8JguR2PHKiaiygwc13jTlzHZdK3/OHiFj+/ayl/qzzyMVcWM1J+r5wKuEwzwx5MA3ME839vSLviZ+20f8M9wkyqfv+38mE2nXJ7HeMgGQXd1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723839925; c=relaxed/simple;
	bh=b7wyPfteuw2nvav8OfA6M5PqComXgLkYR8Z8D4Oe4io=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Rg7t5foohzZKjWGlfVuZm9jGjpOeJBwu+fuMiyVn/VexskafWjfKqFmLEiI1/smyZM4Y5Q0LRaZv1RSRkLdbVTL445hesCH2jB2O+yj2vFFlKf7uvrwNZRRkrL7RUsKaLdeOxvR94BZ7Hcw6x+Yh31cH8YYJQWga+qzjJ1JsRR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f8293cdb1so231747839f.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 13:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723839922; x=1724444722;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Es3o3HeOcrLPALCGkIr+5PklVIsN8jdhH+ELP4w9stE=;
        b=ZZ9QgAUrdDojjk5nRsdsVmD8I1xRe6ehLooeZkRQm1ejcEiZeebUXMxYKVSnvuTEJ9
         xzgZtUVrzIItQCjcfaf3VbMSgkigvUbzp7FSgtCq9usaZjbeWVC4AJm0oDh1VkK83Cpg
         5vrI0itmR9evu+NNlJXaF6rjIml/jzFH5Ib0+n1NZau+nwGVz4BycWBY5rr3QZ1Lafst
         cLyeN93JdOlp1dua54OgqqbwCvrpxSKacEEsb3Sh4CLXjMP8yKwrq3/mc1gQUkqUE5j6
         BIkvZJ9upLgM425eTztyQrqlJiAth2uZYeyGtu4TzJInRroLBohBJeVIsWsfSpxxzRr1
         awmA==
X-Forwarded-Encrypted: i=1; AJvYcCXs+Pazy3eH9EyUB3ngtXjVwA4TyggHhwpZl04Pq9SDyELv+TWu9WqcwpyLTGHrSfwfc12Ioo7YmznX7FKJyoC6dvC2YXBhpelZJVh8
X-Gm-Message-State: AOJu0YzxYNHmpKW+OGCALoulLI6Sfl2NkWVCNyzMfv3yUO5TM7QHbFkT
	hwbS65K3rj4OWHODED+E1vVWjE0usLivcqF0AmdHK75DTpAfdfaXojvoeS6BsB076eBmGb/vFVZ
	wjHTF2WUnAQn1GMnIjIad+vFDRtSTtrKYpUt/uWL8mpoo60/X4gfTvUQ=
X-Google-Smtp-Source: AGHT+IF10KUqQM9RVhB4p32isZ3rC79FX8I7cGStxax1CusW1sLgJ+pD86aJa7cWDW+dVym3GcoQfnn8O4TJCFjvGYqliN1a6ZfQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:860b:b0:4b7:c9b5:6765 with SMTP id
 8926c6da1cb9f-4cce16eb89dmr204807173.5.1723839922591; Fri, 16 Aug 2024
 13:25:22 -0700 (PDT)
Date: Fri, 16 Aug 2024 13:25:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c68f3061fd2c285@google.com>
Subject: [syzbot] [usb?] KASAN: invalid-free in dev_free
From: syzbot <syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com>
To: andreyknvl@gmail.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6b0f8db921ab Merge tag 'execve-v6.11-rc4' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=177484fd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54e9d4be0c7a0d11
dashboard link: https://syzkaller.appspot.com/bug?extid=3e563d99e70973c0755c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-6b0f8db9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5829b92d3000/vmlinux-6b0f8db9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b382f2bc118/bzImage-6b0f8db9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free in dev_free+0x446/0x700 drivers/usb/gadget/legacy/raw_gadget.c:225
Free of addr ffff888107b54de0 by task syz.1.409/6669

CPU: 0 UID: 0 PID: 6669 Comm: syz.1.409 Not tainted 6.11.0-rc3-syzkaller-00013-g6b0f8db921ab #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report_invalid_free+0xaa/0xd0 mm/kasan/report.c:563
 poison_slab_object+0x135/0x160 mm/kasan/common.c:232
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4594
 dev_free+0x446/0x700 drivers/usb/gadget/legacy/raw_gadget.c:225
 kref_put include/linux/kref.h:65 [inline]
 raw_release+0x188/0x2f0 drivers/usb/gadget/legacy/raw_gadget.c:473
 __fput+0x408/0xbb0 fs/file_table.c:422
 __fput_sync+0x47/0x50 fs/file_table.c:507
 __do_sys_close fs/open.c:1566 [inline]
 __se_sys_close fs/open.c:1551 [inline]
 __x64_sys_close+0x86/0x100 fs/open.c:1551
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0af717868a
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 13 8b 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 73 8b 02 00 8b 44 24
RSP: 002b:00007f0af7f85ff0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 00007f0af7315f80 RCX: 00007f0af717868a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f0af71e78ee R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f0af7315f80 R15: 00007ffd55eaee78
 </TASK>

Allocated by task 6671:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4158 [inline]
 __kmalloc_node_track_caller_noprof+0x20f/0x430 mm/slub.c:4177
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

Freed by task 6669:
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
 raw_release+0x188/0x2f0 drivers/usb/gadget/legacy/raw_gadget.c:473
 __fput+0x408/0xbb0 fs/file_table.c:422
 __fput_sync+0x47/0x50 fs/file_table.c:507
 __do_sys_close fs/open.c:1566 [inline]
 __se_sys_close fs/open.c:1551 [inline]
 __x64_sys_close+0x86/0x100 fs/open.c:1551
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888107b54de0
 which belongs to the cache kmalloc-16 of size 16
The buggy address is located 0 bytes inside of
 16-byte region [ffff888107b54de0, ffff888107b54df0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x107b54
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 057ff00000000000 ffff888015842640 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000800080 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x352800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_THISNODE), pid 5917, tgid 5917 (syz-executor), ts 274370933809, free_ts 273397742220
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x1351/0x2e50 mm/page_alloc.c:3442
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4700
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
 __kmalloc_node_noprof+0x357/0x430 mm/slub.c:4164
 __kvmalloc_node_noprof+0x9d/0x1a0 mm/util.c:650
 xt_jumpstack_alloc net/netfilter/x_tables.c:1355 [inline]
 xt_replace_table+0x1c7/0x910 net/netfilter/x_tables.c:1394
 __do_replace+0x1d9/0x9c0 net/ipv4/netfilter/arp_tables.c:912
 do_replace net/ipv6/netfilter/ip6_tables.c:1158 [inline]
 do_ip6t_set_ctl+0x94b/0xc40 net/ipv6/netfilter/ip6_tables.c:1644
 nf_setsockopt+0x8a/0xf0 net/netfilter/nf_sockopt.c:101
 ipv6_setsockopt+0x133/0x1a0 net/ipv6/ipv6_sockglue.c:998
 tcp_setsockopt+0xa4/0x100 net/ipv4/tcp.c:3768
 do_sock_setsockopt+0x222/0x480 net/socket.c:2324
page last free pid 6016 tgid 6016 stack trace:
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
 kmem_cache_alloc_noprof+0x121/0x2f0 mm/slub.c:4044
 vm_area_dup+0x21/0x2f0 kernel/fork.c:486
 __split_vma+0x181/0x11c0 mm/mmap.c:2465
 split_vma mm/mmap.c:2537 [inline]
 vma_modify+0x1ec/0x360 mm/mmap.c:2571
 vma_modify_flags include/linux/mm.h:3298 [inline]
 mprotect_fixup+0x220/0xc40 mm/mprotect.c:639
 do_mprotect_pkey+0x9d7/0xd70 mm/mprotect.c:822
 __do_sys_mprotect mm/mprotect.c:843 [inline]
 __se_sys_mprotect mm/mprotect.c:840 [inline]
 __x64_sys_mprotect+0x78/0xc0 mm/mprotect.c:840
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888107b54c80: fa fb fc fc fa fb fc fc fa fb fc fc 00 00 fc fc
 ffff888107b54d00: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
>ffff888107b54d80: fa fb fc fc 00 00 fc fc fa fb fc fc fa fb fc fc
                                                       ^
 ffff888107b54e00: 00 00 fc fc fa fb fc fc fa fb fc fc fa fb fc fc
 ffff888107b54e80: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
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

