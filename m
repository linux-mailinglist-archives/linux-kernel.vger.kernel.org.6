Return-Path: <linux-kernel+bounces-174532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D428C103B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2DD1F23E9C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 13:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDBD1527A2;
	Thu,  9 May 2024 13:18:32 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2D381C8
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715260711; cv=none; b=OsPVelHKykSvlVcNLqQxXr9duKzsUvW+BNTTUDg6Em+xkY7N+g9y/HXm+iFaHlv+j21HKvbxaObydm9r6+fs6JNIfCAYV/PpamTCkBKT17w5D9P4+S9y0PTSdAp0P7YJWZA3QWqSxedMeIdJRA5OoUR1M2dHV8dmdmMqZsNjQd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715260711; c=relaxed/simple;
	bh=AsgEJN1pwQZnCjXg93kzLWGJckj0gdfuHDe86lY47xk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rxz8k6lsQ12VtUe+VggfMoVqgc8IXIAFdI1eA5HSrDYLzq5o0S/vahoPUKM3Xu3LjD0FcdkOl0KTyjqRXq4y507WAMnd10lsTZTxwxCccMdcHkqpoOZDNJGyoKjHswgQ38R7QgG2UeZAZUL7hT3HWRH8Q3IZ3f8jp606MLGbT+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e19cf1f440so82057239f.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 06:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715260709; x=1715865509;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xbcOYf2jPBKcHttp1A9Wc8Pludko+s6isPUH8RhpjQQ=;
        b=T4Dbcnx3TWuzrAPUEiByEwgHNlQoYXFF0I+zi/ja7A8CmxPTpFy2pYL57CCheOs1dN
         0vez/z/aD7iBTiGrMNvHSo/yWWa73G/oLELqE6x0MCR1rgsxElRMmn3yHdd86ihXQRcY
         +Lb3VwCrvrRJ4RVoIdKJVEd6Qrb5H4hSQ44Vdxpf8X9O47Tg8LHrB0kOlmTGjR4dSQOV
         wwA3D+EIxUc4cWCPj1wETuPY9n6uS61oehOzeuYOgEZmGeIBQ2BSIo2eW7HKkIIcuUgP
         nCDBiKf07wuhlzYwk3uItb+7Fjy2plDYFa+1NHdyG+d/PI0hRPBKpmAByI+iXH1ubY/K
         5ggg==
X-Forwarded-Encrypted: i=1; AJvYcCUbzj7HoYP90TKAiwyKdF/6BceovfU/c/1dLKlOJGdtQ9EaPvgUin8ck/Va6+xRo92WuvEzepryid2X0503tpBlqzCLDfpneMrmjaXI
X-Gm-Message-State: AOJu0Yy/KkRblZlB7um4Vg7c/kx2XnP6Xjq+1bMyJEv3kloLV5nURwze
	kJtdcfY7YR+69w9Y+W1Tes5LPCCY4lcayKvN4hio3733dpLuudCUHGB7PIM8ZIinYmraUW5lnQz
	koO8LdrD1epGmMD06C7vnl6KVyRPebPy92bYVatd6lAAmReJCWDYBA0c=
X-Google-Smtp-Source: AGHT+IFlgl6Wz+199EZOSfOfidRR28Jj+TYFeqDuCcMnmGd1F25DC+LDRRg7wLmdhR2w/4IOfkQTtdJjf/WwVQZpnbDq89wFTLvl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1356:b0:488:c743:c05 with SMTP id
 8926c6da1cb9f-488fdd5feefmr251558173.5.1715260709069; Thu, 09 May 2024
 06:18:29 -0700 (PDT)
Date: Thu, 09 May 2024 06:18:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042f5d90618054116@google.com>
Subject: [syzbot] [jfs?] KASAN: slab-out-of-bounds Read in dbAllocBits
From: syzbot <syzbot+0be47376a6acbcba7f0d@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7367539ad4b0 Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16306574980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3310e643b6ef5d69
dashboard link: https://syzkaller.appspot.com/bug?extid=0be47376a6acbcba7f0d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159d897f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c3d354980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-7367539a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f814bef5f63/vmlinux-7367539a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cd1f53098470/bzImage-7367539a.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6f1d86e6c9f3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0be47376a6acbcba7f0d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in dbAllocBits+0x61e/0x630 fs/jfs/jfs_dmap.c:2255
Read of size 8 at addr ffff88802639eeb8 by task syz-executor242/5196

CPU: 2 PID: 5196 Comm: syz-executor242 Not tainted 6.9.0-rc6-syzkaller-00234-g7367539ad4b0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 dbAllocBits+0x61e/0x630 fs/jfs/jfs_dmap.c:2255
 dbAllocDmap+0x5c/0x110 fs/jfs/jfs_dmap.c:2032
 dbAllocNear fs/jfs/jfs_dmap.c:1258 [inline]
 dbAlloc+0x784/0xab0 fs/jfs/jfs_dmap.c:843
 ea_get+0xc11/0x12c0 fs/jfs/xattr.c:514
 __jfs_setxattr+0x1ed/0x1070 fs/jfs/xattr.c:718
 __jfs_set_acl+0x110/0x1a0 fs/jfs/acl.c:87
 jfs_set_acl+0x256/0x330 fs/jfs/acl.c:115
 set_posix_acl+0x25c/0x320 fs/posix_acl.c:955
 vfs_set_acl+0x53d/0x900 fs/posix_acl.c:1134
 do_set_acl+0xd9/0x1b0 fs/posix_acl.c:1279
 do_setxattr+0xeb/0x170 fs/xattr.c:626
 setxattr+0x15d/0x180 fs/xattr.c:652
 path_setxattr+0x179/0x1e0 fs/xattr.c:671
 __do_sys_lsetxattr fs/xattr.c:694 [inline]
 __se_sys_lsetxattr fs/xattr.c:690 [inline]
 __x64_sys_lsetxattr+0xc1/0x160 fs/xattr.c:690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f03a87c66b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffca6e6e748 EFLAGS: 00000246 ORIG_RAX: 00000000000000bd
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f03a87c66b9
RDX: 0000000020000180 RSI: 0000000020000040 RDI: 0000000020000000
RBP: 00007f03a883f610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000024 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffca6e6e918 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 4906:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3966 [inline]
 __kmalloc_node_track_caller+0x220/0x470 mm/slub.c:3986
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:599
 __alloc_skb+0x164/0x380 net/core/skbuff.c:668
 __netdev_alloc_skb+0x72/0x3f0 net/core/skbuff.c:732
 __netdev_alloc_skb_ip_align include/linux/skbuff.h:3321 [inline]
 e1000_alloc_rx_buffers+0x3b5/0x7b0 drivers/net/ethernet/intel/e1000e/netdev.c:668
 e1000_configure+0x199a/0x4ad0 drivers/net/ethernet/intel/e1000e/netdev.c:3761
 e1000e_open+0x403/0x1790 drivers/net/ethernet/intel/e1000e/netdev.c:4658
 __dev_open+0x2d4/0x4e0 net/core/dev.c:1430
 __dev_change_flags+0x561/0x720 net/core/dev.c:8692
 dev_change_flags+0x8f/0x160 net/core/dev.c:8764
 devinet_ioctl+0x127a/0x1f10 net/ipv4/devinet.c:1172
 inet_ioctl+0x3aa/0x3f0 net/ipv4/af_inet.c:1001
 sock_do_ioctl+0x116/0x280 net/socket.c:1222
 sock_ioctl+0x22e/0x6c0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl fs/ioctl.c:890 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802639e000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1720 bytes to the right of
 allocated 2048-byte region [ffff88802639e000, ffff88802639e800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x26398
head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888015042f00 ffffea000069fc00 dead000000000002
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
head: 00fff00000000840 ffff888015042f00 ffffea000069fc00 dead000000000002
head: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
head: 00fff00000000003 ffffea000098e601 dead000000000122 00000000ffffffff
head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4675, tgid -996255200 (klogd), ts 4675, free_ts 20473074610
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3317
 __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2391
 ___slab_alloc+0x66d/0x1790 mm/slub.c:3525
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3610
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmalloc_trace+0x2fb/0x330 mm/slub.c:3992
 kmalloc include/linux/slab.h:628 [inline]
 syslog_print+0xf9/0x5d0 kernel/printk/printk.c:1556
 do_syslog+0x3be/0x6a0 kernel/printk/printk.c:1734
 __do_sys_syslog kernel/printk/printk.c:1826 [inline]
 __se_sys_syslog kernel/printk/printk.c:1824 [inline]
 __x64_sys_syslog+0x74/0xb0 kernel/printk/printk.c:1824
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 4675 tgid 4675 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2347
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2487
 __put_partials+0x14c/0x170 mm/slub.c:2906
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_node+0x177/0x340 mm/slub.c:3888
 __alloc_skb+0x2b1/0x380 net/core/skbuff.c:658
 alloc_skb include/linux/skbuff.h:1313 [inline]
 alloc_skb_with_frags+0xe4/0x710 net/core/skbuff.c:6515
 sock_alloc_send_pskb+0x7f1/0x980 net/core/sock.c:2795
 unix_dgram_sendmsg+0x4b9/0x1b10 net/unix/af_unix.c:2019
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x47f/0x4e0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2199
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802639ed80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802639ee00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802639ee80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                        ^
 ffff88802639ef00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802639ef80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


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

