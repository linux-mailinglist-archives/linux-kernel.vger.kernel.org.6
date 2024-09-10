Return-Path: <linux-kernel+bounces-322508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC789729E3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2151F25631
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257B517BB35;
	Tue, 10 Sep 2024 06:56:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E88217BB0C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 06:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951364; cv=none; b=Czvw6RDxNqcuDNh+4rsyHHCH9d8DTn2kRcTo2E6HirYx5wKorTo/m3ZPBoNViZJuassj2Wgm+b1aJZ4ryqzZAdNhkevp0jzpiqs3KuOb7FqXk+mLwsRzkDHVdLBuPF4T2ZGSKfXI2eBzVewVRJAAEp4TcYmxOfJpDVPl8/t48EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951364; c=relaxed/simple;
	bh=P0NEB8rOIilynb6rLJjhYpbwTEWSjzZ4XlYDZMfSWU0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IMXxfGQW1K5C5MVjpJYPRCPoJ/aWbZZt1GPo/4LU/i/j0MAtQlP1R0IRA/mzj0UlbRU5xk/ecOG4CqJxat+9TrubmyqkH5/PqDWTSsqoF0Qxeia9ISZgpav0XH0xzIIhS5wcmV8E7ySF753U5O1lRd5Ht9LVYKS2BGggA+9uaps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a047cb2e7dso4537885ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 23:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725951362; x=1726556162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5a3peqGgX7GyTANDS57MEbGTz/bno1u7b+gXJ3V1Ws=;
        b=bUjhHRgQqeAAKU1q04iTc4rfTRBGQj0izvATNC+Sii20EAExdWdjsIOVsq1ri4pAGu
         Tf1QYTjh70ACUa3xv/CcRZQM7fJhNecJMSt4p3TilGCPuwPd4+HNtv3wDjca+5NsbN+5
         VjQ+ue3N7OQd7p2GNZ/EtxT0/K47rpIEbwELqbAb3K/admIIS4RGHpxSQuG/0jyibyN0
         wU6an7FdcelxPiE7BuzjI/1O0o3udoiZW+Z1t9eWFcCcaUsxfevJVJJfyt8C6EATXPL6
         mGL6c4jLov11Y8APpIm5SDgi8b6xsADjtQ7BT4tXzvvWvz/ESR1NVx5WQEUeCYHFQ/jj
         9zOg==
X-Forwarded-Encrypted: i=1; AJvYcCXoOye3dpoKcuwKpebos2sEwYAPJX+9MSgNbqGr/wOnbkImtL2SmJAqXcRC3O6UB7FaxJOH7fZYjKWRf5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/8kPF4w0S/CwdhIR7BIxV4k8moqX5rGqSnYYtoes8+oacDk85
	paoJWEVZpfvB7gQVXizVULh1Bx3LjmxbFqAz8gLRr9kZJa4GAAutPmg8H8XxbmfWCzZ+lRA3AG4
	DmfJsfjFkIb5EMVXWiluF7+mXoAvCRbE8G3NhNSnpVYjz32LFndpCuGo=
X-Google-Smtp-Source: AGHT+IGnQLi9/krxQgZ5ANGACnVVpr80N74FUnzj8S8gBDHcTkuGDfmGmmDrajEKF2iUuYSi2iZTR39JTGNrcQyZCIf/99YJoncf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2184:b0:39d:2a84:86a3 with SMTP id
 e9e14a558f8ab-3a04f073728mr140681065ab.4.1725951361789; Mon, 09 Sep 2024
 23:56:01 -0700 (PDT)
Date: Mon, 09 Sep 2024 23:56:01 -0700
In-Reply-To: <tencent_B85DF6DDA2994D4FEB8DABA5AE0DB4122B07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1c3720621be5d3e@google.com>
Subject: Re: [syzbot] [mptcp?] KASAN: slab-use-after-free Read in __timer_delete_sync
From: syzbot <syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in __timer_delete_sync

==================================================================
BUG: KASAN: slab-use-after-free in __lock_acquire+0x77/0x2040 kernel/locking/lockdep.c:5007
Read of size 8 at addr ffff8880244d5c58 by task syz.2.17/5997

CPU: 1 UID: 0 PID: 5997 Comm: syz.2.17 Not tainted 6.11.0-rc7-syzkaller-gbc83b4d1f086-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __lock_acquire+0x77/0x2040 kernel/locking/lockdep.c:5007
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __timer_delete_sync+0x148/0x310 kernel/time/timer.c:1647
 del_timer_sync include/linux/timer.h:185 [inline]
 sk_stop_timer_sync+0x1c/0x90 net/core/sock.c:3454
 mptcp_pm_del_add_timer+0x23f/0x2d0 net/mptcp/pm_netlink.c:353
 remove_anno_list_by_saddr net/mptcp/pm_netlink.c:1469 [inline]
 mptcp_pm_remove_addrs_and_subflows net/mptcp/pm_netlink.c:1686 [inline]
 mptcp_nl_remove_addrs_list net/mptcp/pm_netlink.c:1717 [inline]
 mptcp_pm_nl_flush_addrs_doit+0x670/0xdd0 net/mptcp/pm_netlink.c:1758
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f394df79eb9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f394ed91038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f394e115f80 RCX: 00007f394df79eb9
RDX: 0000000001000000 RSI: 0000000020000300 RDI: 0000000000000003
RBP: 00007f394dfe793e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f394e115f80 R15: 00007f394e23fa28
 </TASK>

Allocated by task 5997:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4193
 kmalloc_noprof include/linux/slab.h:681 [inline]
 mptcp_pm_alloc_anno_list+0x14e/0x390 net/mptcp/pm_netlink.c:378
 mptcp_pm_create_subflow_or_signal_addr+0x1920/0x22c0 net/mptcp/pm_netlink.c:594
 mptcp_nl_add_subflow_or_signal_addr net/mptcp/pm_netlink.c:1364 [inline]
 mptcp_pm_nl_add_addr_doit+0x1276/0x1b80 net/mptcp/pm_netlink.c:1436
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5997:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x149/0x360 mm/slub.c:4598
 mptcp_pm_del_add_timer+0x221/0x2d0 net/mptcp/pm_netlink.c:347
 remove_anno_list_by_saddr net/mptcp/pm_netlink.c:1469 [inline]
 mptcp_pm_remove_addrs_and_subflows net/mptcp/pm_netlink.c:1686 [inline]
 mptcp_nl_remove_addrs_list net/mptcp/pm_netlink.c:1717 [inline]
 mptcp_pm_nl_flush_addrs_doit+0x670/0xdd0 net/mptcp/pm_netlink.c:1758
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880244d5c00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 88 bytes inside of
 freed 192-byte region [ffff8880244d5c00, ffff8880244d5cc0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x244d5
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff88801ac413c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5964, tgid 5964 (syz-executor), ts 116670204712, free_ts 116664550352
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
 __kmalloc_cache_noprof+0x1d5/0x2c0 mm/slub.c:4188
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 cgroup_file_open+0x8e/0x2b0 kernel/cgroup/cgroup.c:4053
 kernfs_fop_open+0xa58/0xd10 fs/kernfs/file.c:706
 do_dentry_open+0x970/0x1440 fs/open.c:959
 vfs_open+0x3e/0x330 fs/open.c:1089
 do_open fs/namei.c:3727 [inline]
 path_openat+0x2b3e/0x3470 fs/namei.c:3886
 do_filp_open+0x235/0x490 fs/namei.c:3913
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
page last free pid 5964 tgid 5964 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2619
 discard_slab mm/slub.c:2587 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3055
 put_cpu_partial+0x17c/0x250 mm/slub.c:3130
 __slab_free+0x2ea/0x3d0 mm/slub.c:4347
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3992 [inline]
 slab_alloc_node mm/slub.c:4041 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4048
 getname_flags+0xb7/0x540 fs/namei.c:139
 user_path_at+0x24/0x60 fs/namei.c:3001
 __do_sys_pivot_root fs/namespace.c:4317 [inline]
 __se_sys_pivot_root+0x1da/0x1650 fs/namespace.c:4301
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880244d5b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880244d5b80: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
>ffff8880244d5c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff8880244d5c80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880244d5d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         bc83b4d1 Merge tag 'bcachefs-2024-09-09' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17fb449f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61d235cb8d15001c
dashboard link: https://syzkaller.appspot.com/bug?extid=f3a31fb909db9b2a5c4d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14aaa807980000


