Return-Path: <linux-kernel+bounces-545955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 641DEA4F47A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9CE3AA936
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7926F152E12;
	Wed,  5 Mar 2025 02:14:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DB5130AC8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 02:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741140844; cv=none; b=dctDa8+vYFOm+b3XH7X2+i1dA7v74bB+EnBOhOJCkcyHg+vtKM81c2sikfm5kEX34FUDpWVcRguk2fHsG6l5ayPjqPQxWZN2+BVscEf0WfV23zzWJq575UxKf7rl+/u+7hGW0dDGA6VodAXImMFNkpCgINV4mu7ejCBaOrymN40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741140844; c=relaxed/simple;
	bh=ukbst+P5x1pFkpKemYAISLEdGLChLAER/qV+JgUwWuQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SNgI9QBtOSxQs5fa2M0/OzHc2jBPA3xeYqL2OrB6qiv5cThoE9b4Nfp4EA6vrlVBW+GPwIRbhrYyGBde5q7a5vn/u1QSacDKGHHIOq6h4DilvXQyULue2cB4wJHA3iU5HQu8xZHRbfgh+6C6/R6O/EPsHrGLTrdWlP8RnugivZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d054d79dacso117881985ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 18:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741140842; x=1741745642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dhC435EhtWWvtKjFFUXImE7acsikst2Ovrvizw67aeM=;
        b=MNOP9QRAKqNj50zJf74m1RnhXRwnHuKtEkIU7RfeEfgsNb5LLsqP97iBLc9+aT/lr/
         0qxs8pfc953n2NjhlOBZtyP+jY8Q6EDC9y5+LThcJM93W8byiJL9BXSiBdVyBEy+/0W6
         1RCpQBDqpsBECNa9YvY7fSud9VcC/oPnxzzmiGvovmmqPD72d2DbtTXwFOOzZXc/L+mU
         MMqkAiaCHOZ8T4OEH2/Gtq9TVOKzzqEbCEm4Lq2xTmiOt8sdd4GzxGAoN0595G8rPDSd
         pSqyjHrr2QhAkseUC9edxIoRnOL83n5x2oflVkCnYnxUb0hOhSKf9eGubjbQqAMYzNWN
         58sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfimsqD3zO5G6YwY31aVM3DopOrB0IfkO8vrDV6OTlUIz6nunWNP7QM56R0dZhSLrgqvMN9MiaW+y7fmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVwAriBwT0dunkxqlh2VzbdH/pWxtbmiOBCnYDVYRcqI3Yjm0H
	iSIhokuGjVlQUYEjBwnlE10Qn9eKH14qK+HMtKKjAjvZjZ9cB8rh4G4xNmS7AwHf1Ea/+r/txme
	DB24JNjyoJP5PCS8uqxRoM5Hw00nP2bQ+60FvGyP1zVzTLI8syUYVdEY=
X-Google-Smtp-Source: AGHT+IHEstYwFL6Mkc/RVuV5ZYs9hG0TFfFF2Oj6/rmIJN0+dizRR67DBOC7xeYK1R+D8kNhVEjByspv/jquB8coP60uNuWgfGMQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe2:b0:3d3:f7ed:c907 with SMTP id
 e9e14a558f8ab-3d42b95feaemr17402365ab.15.1741140842322; Tue, 04 Mar 2025
 18:14:02 -0800 (PST)
Date: Tue, 04 Mar 2025 18:14:02 -0800
In-Reply-To: <tencent_1695E0E90AEC5ACFE478EE6F0C2DC56CE00A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c7b36a.050a0220.15b4b9.001c.GAE@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: slab-out-of-bounds Read in xlog_cksum
From: syzbot <syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in xlog_cksum

=======================================================
XFS (loop0): Mounting V5 Filesystem bfdc47fc-10d8-4eed-a562-11a831b3f791
==================================================================
BUG: KASAN: slab-out-of-bounds in crc32c_le_arch+0xc7/0x1b0 arch/x86/lib/crc32-glue.c:81
Read of size 8 at addr ffff888032f85200 by task syz.0.16/5864

CPU: 0 UID: 0 PID: 5864 Comm: syz.0.16 Not tainted 6.14.0-rc5-syzkaller-g48a5eed9ad58-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0x16e/0x5b0 mm/kasan/report.c:521
 kasan_report+0x143/0x180 mm/kasan/report.c:634
 crc32c_le_arch+0xc7/0x1b0 arch/x86/lib/crc32-glue.c:81
 __crc32c_le include/linux/crc32.h:36 [inline]
 crc32c include/linux/crc32c.h:9 [inline]
 xlog_cksum+0xcf/0x130 fs/xfs/xfs_log.c:1592
 xlog_recover_process+0x78/0x1e0 fs/xfs/xfs_log_recover.c:2900
 xlog_do_recovery_pass+0xa01/0xdc0 fs/xfs/xfs_log_recover.c:3235
 xlog_verify_head+0x21f/0x5a0 fs/xfs/xfs_log_recover.c:1058
 xlog_find_tail+0xa04/0xdf0 fs/xfs/xfs_log_recover.c:1315
 xlog_recover+0xe1/0x540 fs/xfs/xfs_log_recover.c:3419
 xfs_log_mount+0x252/0x3e0 fs/xfs/xfs_log.c:666
 xfs_mountfs+0xfbb/0x2500 fs/xfs/xfs_mount.c:878
 xfs_fs_fill_super+0x1223/0x1550 fs/xfs/xfs_super.c:1817
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2098f8e90a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2099e4fe68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f2099e4fef0 RCX: 00007f2098f8e90a
RDX: 0000400000000500 RSI: 0000400000000200 RDI: 00007f2099e4feb0
RBP: 0000400000000500 R08: 00007f2099e4fef0 R09: 0000000002218a5d
R10: 0000000002218a5d R11: 0000000000000246 R12: 0000400000000200
R13: 00007f2099e4feb0 R14: 0000000000009706 R15: 0000400000000100
 </TASK>

Allocated by task 5864:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4294 [inline]
 __kmalloc_node_noprof+0x290/0x4d0 mm/slub.c:4300
 __kvmalloc_node_noprof+0x72/0x190 mm/util.c:662
 xlog_do_recovery_pass+0x143/0xdc0 fs/xfs/xfs_log_recover.c:3016
 xlog_verify_head+0x21f/0x5a0 fs/xfs/xfs_log_recover.c:1058
 xlog_find_tail+0xa04/0xdf0 fs/xfs/xfs_log_recover.c:1315
 xlog_recover+0xe1/0x540 fs/xfs/xfs_log_recover.c:3419
 xfs_log_mount+0x252/0x3e0 fs/xfs/xfs_log.c:666
 xfs_mountfs+0xfbb/0x2500 fs/xfs/xfs_mount.c:878
 xfs_fs_fill_super+0x1223/0x1550 fs/xfs/xfs_super.c:1817
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888032f85000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes to the right of
 allocated 512-byte region [ffff888032f85000, ffff888032f85200)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x32f84
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801b041c80 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
head: 04fff00000000040 ffff88801b041c80 0000000000000000 dead000000000001
head: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
head: 04fff00000000001 ffffea0000cbe101 ffffffffffffffff 0000000000000000
head: ffff888000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5658, tgid 5658 (syz-executor), ts 131552625607, free_ts 131548944772
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f4/0x240 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x292/0x710 mm/page_alloc.c:4739
 alloc_pages_mpol+0x311/0x660 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab+0x8f/0x3a0 mm/slub.c:2587
 new_slab mm/slub.c:2640 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3826
 __slab_alloc+0x58/0xa0 mm/slub.c:3916
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 __do_kmalloc_node mm/slub.c:4293 [inline]
 __kmalloc_noprof+0x2e6/0x4c0 mm/slub.c:4306
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 fib6_info_alloc+0x2e/0xf0 net/ipv6/ip6_fib.c:155
 ip6_route_info_create+0x445/0x12b0 net/ipv6/route.c:3766
 addrconf_f6i_alloc+0x3c2/0x7f0 net/ipv6/route.c:4593
 ipv6_add_addr+0x5b6/0x1090 net/ipv6/addrconf.c:1119
 inet6_addr_add+0x3ae/0xe30 net/ipv6/addrconf.c:3047
 inet6_rtm_newaddr+0xa89/0xf10 net/ipv6/addrconf.c:5054
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6912
 netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2533
page last free pid 5678 tgid 5678 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_frozen_pages+0xe0d/0x10e0 mm/page_alloc.c:2660
 mm_free_pgd kernel/fork.c:815 [inline]
 __mmdrop+0xb9/0x3d0 kernel/fork.c:931
 exec_mmap+0x7a5/0x890 fs/exec.c:1011
 begin_new_exec+0x1281/0x2100 fs/exec.c:1267
 load_elf_binary+0x973/0x2820 fs/binfmt_elf.c:1002
 search_binary_handler fs/exec.c:1775 [inline]
 exec_binprm fs/exec.c:1807 [inline]
 bprm_execve+0x979/0x1430 fs/exec.c:1859
 do_execveat_common+0x57f/0x710 fs/exec.c:1966
 do_execve fs/exec.c:2040 [inline]
 __do_sys_execve fs/exec.c:2116 [inline]
 __se_sys_execve fs/exec.c:2111 [inline]
 __x64_sys_execve+0x92/0xb0 fs/exec.c:2111
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888032f85100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888032f85180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888032f85200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff888032f85280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888032f85300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         48a5eed9 Merge tag 'devicetree-fixes-for-6.14-2' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c10254580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2040405600e83619
dashboard link: https://syzkaller.appspot.com/bug?extid=9f6d080dece587cfdd4c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10ebd8b7980000


