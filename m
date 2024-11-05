Return-Path: <linux-kernel+bounces-397132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC079BD725
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 739A8B22C60
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C434D1F8F1F;
	Tue,  5 Nov 2024 20:41:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEEF17BEB7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 20:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730839266; cv=none; b=bgxv9rO05A910i35TWb+ygD6tHKkqWOr/TTsn3sCQS6g6165+rIX264Vy079skztZZbOLFAfhwUn/yiQfe1rKs+53xSSjGgZMYFBqInrmsrU5wZOuA0NtsJjNVAoMUSDddr0vnRq8XgrMT5EeIW1FucfeNcgQM5GoCnxvYE4SeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730839266; c=relaxed/simple;
	bh=zAgYBW0As8PcSG4Iww/nt4C+uClRN58Y+1H5hFI4XLk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pQKIDlBrfLdMKx4iE1ZwtIAF1FY44VzQhRjrLlgIrYcP9GkJwDX+zFzwilb+ewIptLW+PwaCIfLlvoNhF0/96Gff5SrOBX7PXycy+EEd7NzA1LCOrLhmZ9w++ACTb/vZB/RPwOY+Ay3YMkT4UM8trd5x+oyrKZGMrOLeRra+7K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a4f32b0007so58421585ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 12:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730839263; x=1731444063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nluk2Nb7uHmJXeXFeWWIhk3cW7pgBwYyymXxMeyn7BQ=;
        b=FChUpb4npISYxRnghJTav2hpHM3FDrQzY14v1GW39ZCfSI+SXg32UVAknxv5uVkK0n
         XIOGNclEeK1aqGbSO71Q2DtnhoT+RIm95B9km2F8xSmiK8iOmxlF5DZZn1I9iNz+hcZs
         8lSCoqnTtXxSl4HHmw5rLnvJeC2NaVdTYkKJpLVyUBLjpNsMUbB9G9qB1YfUDarJT4+t
         ZS/9LoNWKF+RQ10YWUGtIZ0B902/uSBqMhrGdjTcf4+bJ1lzzgCrNEnr4oGuyaBrHdFo
         EKXtGhDIlDvGVKQRu7RPFGMnq3jU+paZKs3exZltTAJSubPAoaKtYLtBy4oS/z1mee6m
         SSuw==
X-Forwarded-Encrypted: i=1; AJvYcCU84SJLHGf/jN8RPQv6XmLoHm4qG6U88dJp47agFlHtvGBm6vSyCXa6PItpKEfF8dKdEUUgRT2yfN81xQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEBD9NZxFboA7Cs8Uji+HHvE0XnMqmRlMEoF7/ihTBc4vr0Jwe
	mvBDuDb85w6qHLtx587pyc+Dug9bAuO82IOhzohg/StINIdxolesiLiLb7TcpqVxDCSe08cjtSs
	ZRFO5q5V9MljGo2JKcZ1djONf1+cpJLwDEu1ZVnXhunTekMwjR4DRp2k=
X-Google-Smtp-Source: AGHT+IHNu60990jbPS4DrBO6v/1ZEzJ8FJwa8QmzzjR0qJbYomrqXQa2mllvWhGiWAD16KCYsGsLUXhBkrKQBgE43VC9bIjftpDs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214a:b0:3a6:c24d:c2f2 with SMTP id
 e9e14a558f8ab-3a6c24dc9b4mr121182875ab.17.1730839263336; Tue, 05 Nov 2024
 12:41:03 -0800 (PST)
Date: Tue, 05 Nov 2024 12:41:03 -0800
In-Reply-To: <20241105111442.864442-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672a82df.050a0220.2a847.16c2.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in taprio_dump
From: syzbot <syzbot+d4d8c0fd15a0abe39bcf@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in taprio_dump

==================================================================
BUG: KASAN: slab-use-after-free in taprio_dump_tc_entries net/sched/sch_taprio.c:2286 [inline]
BUG: KASAN: slab-use-after-free in taprio_dump+0x857/0xd50 net/sched/sch_taprio.c:2399
Read of size 4 at addr ffff8880774444c0 by task syz-executor.0/7739

CPU: 0 UID: 0 PID: 7739 Comm: syz-executor.0 Not tainted 6.12.0-rc3-syzkaller-00163-g8a7d12d674ac #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 taprio_dump_tc_entries net/sched/sch_taprio.c:2286 [inline]
 taprio_dump+0x857/0xd50 net/sched/sch_taprio.c:2399
 tc_fill_qdisc+0x6a7/0x11f0 net/sched/sch_api.c:951
 qdisc_notify+0x2ec/0x4b0 net/sched/sch_api.c:1052
 tc_modify_qdisc+0x1c58/0x1e40 net/sched/sch_api.c:1754
 rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6675
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2607
 ___sys_sendmsg net/socket.c:2661 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb320c7de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb3219990c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fb320dabf80 RCX: 00007fb320c7de69
RDX: 0000000000000000 RSI: 00000000200007c0 RDI: 0000000000000003
RBP: 00007fb320cca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fb320dabf80 R15: 00007fff29f54758
 </TASK>

Allocated by task 7731:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4295
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 taprio_change+0x1037/0x44c0 net/sched/sch_taprio.c:1859
 qdisc_change net/sched/sch_api.c:1422 [inline]
 tc_modify_qdisc+0x190d/0x1e40 net/sched/sch_api.c:1752
 rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6675
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2607
 ___sys_sendmsg net/socket.c:2661 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 1035:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4727
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1037
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3086 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3190
 taprio_change+0x265d/0x44c0 net/sched/sch_taprio.c:1970
 qdisc_change net/sched/sch_api.c:1422 [inline]
 tc_modify_qdisc+0x190d/0x1e40 net/sched/sch_api.c:1752
 rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6675
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2607
 ___sys_sendmsg net/socket.c:2661 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888077444400
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 192 bytes inside of
 freed 512-byte region [ffff888077444400, ffff888077444600)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888077447800 pfn:0x77444
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888015441c80 0000000000000000 dead000000000001
raw: ffff888077447800 000000008010000f 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff888015441c80 0000000000000000 dead000000000001
head: ffff888077447800 000000008010000f 00000001f5000000 0000000000000000
head: 00fff00000000002 ffffea0001dd1101 ffffffffffffffff 0000000000000000
head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4553, tgid 4553 (udevadm), ts 16557674621, free_ts 13771592324
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __kmalloc_cache_noprof+0x1d5/0x2c0 mm/slub.c:4290
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 kernfs_fop_open+0x3e0/0xd10 fs/kernfs/file.c:623
 do_dentry_open+0x978/0x1460 fs/open.c:958
 vfs_open+0x3e/0x330 fs/open.c:1088
 do_open fs/namei.c:3774 [inline]
 path_openat+0x2c84/0x3590 fs/namei.c:3933
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 free_contig_range+0x152/0x550 mm/page_alloc.c:6748
 destroy_args+0x8a/0x840 mm/debug_vm_pgtable.c:1017
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1397
 do_one_initcall+0x248/0x880 init/main.c:1269
 do_initcall_level+0x157/0x210 init/main.c:1331
 do_initcalls+0x3f/0x80 init/main.c:1347
 kernel_init_freeable+0x435/0x5d0 init/main.c:1580
 kernel_init+0x1d/0x2b0 init/main.c:1469
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888077444380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888077444400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888077444480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff888077444500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888077444580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         8a7d12d6 net: usb: usbnet: fix name regression
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15bf8e30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fd7a8d0218abac59
dashboard link: https://syzkaller.appspot.com/bug?extid=d4d8c0fd15a0abe39bcf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

