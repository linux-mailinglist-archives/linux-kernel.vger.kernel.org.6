Return-Path: <linux-kernel+bounces-232376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFF691A7E3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E544D282167
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55682194096;
	Thu, 27 Jun 2024 13:30:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D68179950
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719495006; cv=none; b=t1jAPAEYXwSgbaPYlO6ysKzSWqF4rJEMeipG5gxreIXQd5hA9DWvzzh4gLDnvil8ZdCYb/SVKk7nXHqawSRnjiQcY5D2zqOj9WEv2Q/dr1nHFWGiMeNQqdCGwLNtVDernYeNNKJvroSI8lweouSYbJIrZgmVgez699w5Ga8yPM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719495006; c=relaxed/simple;
	bh=MF4CtSg754pYELazF/y0CN4JoHX6GuGxeoQzk5MSbUc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=szNRiWVsW/1zwEzSH8NSr+xsqhD7BbnJoG/i3ZRd2VF+um4Bop4azvLyEqyqKFy3UNF4Nn+xRIauZ2oTadMBKpcfDSbbmeBtm3gYhhYeE22w0cDLR/Vxs+PFaBOaaGrK6SNBr2VJ0IdrIT7LSJlPGD9Uya7eH65F5ShOZrHuDvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3762363a522so124987475ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 06:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719495004; x=1720099804;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3thB0UFoFBK3QhBbGBobLsoks2k97t6O5s8sJBccdc=;
        b=Kyj5iPiL21vOs14Cg0PSilb7j1dTGIvr8wfnNPR6mvvSAer1ZZqnCyiBKfuX5TKT8U
         GZBVflu3ILKg5WsnZp0qJ+rWOVCTSxc96uI7x013h5oPHc8a3CkMEljcwkJ1JBOq4ISk
         7H0bTbPkfLzIr9c5ZEp6FwUxebzBddC/DXKNEx6pxWiufw+piA8y5FM6bU79NdAftXrA
         +evsAEZoEPsZJns/f81dreNKl2vq75GLgW/2DYGHiXRqnoXIbyDaj1nMKGLL4xvCxEjS
         4Oaxeb29UmT+O15rRz7lu+eYhUhffD8OtpPhSscGl6vCIk2wZ6dkEYbBacza++4r71+n
         eD8w==
X-Forwarded-Encrypted: i=1; AJvYcCU9BlZrpT7UTC+flRGoviFcHrSpqcE3rKX+iV6ahmBPj5nOBdhGjePE6z9e3fpOO/G/QQP1aBE41+bmBi6AFyLo0p1waXNIoGhVjnPb
X-Gm-Message-State: AOJu0YwzNH4EpGIW2gaHZvOexWgmtAr2/CHAqC/RdJypT6alJQFfUaBU
	iV/CEgp1xQbETqZmpDiKsu5XB4k/VssM544F3CEIMLorTpuxhrfxjD1lFRA1e6zMNhI29HLJpc5
	FdMOxARvBVxPt6CjcCnTHt99/n0BhK/kbkqoxZ8nOA9kwXzZsd1zZ2IU=
X-Google-Smtp-Source: AGHT+IEIeEnQHMwucjAEmqd+aa1p11QnJrfKroy5r0+BNVN8A8UXkr1kEnis4W2dlUfMW/+CSzus2ibTnL0vXZz84GKexQ/LNkJF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c268:0:b0:375:8a85:eacd with SMTP id
 e9e14a558f8ab-3763f6c7aabmr11821585ab.3.1719495003861; Thu, 27 Jun 2024
 06:30:03 -0700 (PDT)
Date: Thu, 27 Jun 2024 06:30:03 -0700
In-Reply-To: <tencent_B71CE90EEE3ECDAC78E66E9C2FC96C1C950A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6034f061bdf2071@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
From: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Write in l2tp_session_delete

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in test_and_set_bit include/asm-generic/bitops/instrumented-atomic.h:71 [inline]
BUG: KASAN: slab-use-after-free in l2tp_session_delete+0x28/0x9e0 net/l2tp/l2tp_core.c:1639
Write of size 8 at addr ffff88806ca77808 by task kworker/u8:3/51

CPU: 0 PID: 51 Comm: kworker/u8:3 Not tainted 6.10.0-rc4-syzkaller-00869-g185d72112b95-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: l2tp l2tp_tunnel_del_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 test_and_set_bit include/asm-generic/bitops/instrumented-atomic.h:71 [inline]
 l2tp_session_delete+0x28/0x9e0 net/l2tp/l2tp_core.c:1639
 l2tp_tunnel_closeall net/l2tp/l2tp_core.c:1302 [inline]
 l2tp_tunnel_del_work+0x1cb/0x330 net/l2tp/l2tp_core.c:1334
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 6223:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4122 [inline]
 __kmalloc_noprof+0x1f9/0x400 mm/slub.c:4135
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 l2tp_session_create+0x3b/0xc20 net/l2tp/l2tp_core.c:1675
 pppol2tp_connect+0xca3/0x17a0 net/l2tp/l2tp_ppp.c:783
 __sys_connect_file net/socket.c:2049 [inline]
 __sys_connect+0x2df/0x310 net/socket.c:2066
 __do_sys_connect net/socket.c:2076 [inline]
 __se_sys_connect net/socket.c:2073 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2073
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5956:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4437 [inline]
 kfree+0x149/0x360 mm/slub.c:4558
 __sk_destruct+0x58/0x5f0 net/core/sock.c:2191
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2809
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3072 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3176
 pppol2tp_release+0x357/0x450 net/l2tp/l2tp_ppp.c:458
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x406/0x8b0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88806ca77800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 8 bytes inside of
 freed 1024-byte region [ffff88806ca77800, ffff88806ca77c00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6ca70
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888015041dc0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000100010 00000001ffffefff 0000000000000000
head: 00fff00000000040 ffff888015041dc0 dead000000000122 0000000000000000
head: 0000000000000000 0000000000100010 00000001ffffefff 0000000000000000
head: 00fff00000000003 ffffea0001b29c01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x152820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 11, tgid 11 (kworker/u8:0), ts 101409670398, free_ts 101342435367
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x2e43/0x2f00 mm/page_alloc.c:3420
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4678
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2265
 allocate_slab+0x5a/0x2f0 mm/slub.c:2428
 new_slab mm/slub.c:2481 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3667
 __slab_alloc+0x58/0xa0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3989 [inline]
 __do_kmalloc_node mm/slub.c:4121 [inline]
 __kmalloc_noprof+0x257/0x400 mm/slub.c:4135
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 neigh_alloc net/core/neighbour.c:494 [inline]
 ___neigh_create+0x691/0x2470 net/core/neighbour.c:648
 ip6_finish_output2+0x1631/0x1680 net/ipv6/ip6_output.c:128
 ip6_finish_output+0x41e/0x810 net/ipv6/ip6_output.c:222
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ndisc_send_skb+0xab2/0x1380 net/ipv6/ndisc.c:509
 ndisc_send_ns+0xcc/0x160 net/ipv6/ndisc.c:667
 addrconf_dad_work+0xb45/0x16f0 net/ipv6/addrconf.c:4281
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
page last free pid 9 tgid 9 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2583
 discard_slab mm/slub.c:2527 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:2995
 put_cpu_partial+0x17c/0x250 mm/slub.c:3070
 __slab_free+0x2ea/0x3d0 mm/slub.c:4307
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3941 [inline]
 slab_alloc_node mm/slub.c:4001 [inline]
 kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4044
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:656
 alloc_skb include/linux/skbuff.h:1320 [inline]
 alloc_skb_with_frags+0xc3/0x770 net/core/skbuff.c:6509
 sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2815
 sock_alloc_send_skb include/net/sock.h:1773 [inline]
 mld_newpack+0x1c3/0xa90 net/ipv6/mcast.c:1746
 add_grhead net/ipv6/mcast.c:1849 [inline]
 add_grec+0x1492/0x19a0 net/ipv6/mcast.c:1987
 mld_send_initial_cr+0x228/0x4b0 net/ipv6/mcast.c:2233
 mld_dad_work+0x44/0x500 net/ipv6/mcast.c:2259
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312

Memory state around the buggy address:
 ffff88806ca77700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88806ca77780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88806ca77800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88806ca77880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806ca77900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         185d7211 net: xilinx: axienet: Enable multicast by def..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=135c05a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=c041b4ce3a6dfd1e63e2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13129e12980000


