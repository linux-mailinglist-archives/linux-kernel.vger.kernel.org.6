Return-Path: <linux-kernel+bounces-359203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DEB9988A1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FAAF28174F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F4F1CBE98;
	Thu, 10 Oct 2024 14:02:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A631CB527
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568926; cv=none; b=Z+mtz1X0CcWaFS2rNw+oTTA2xhhxLBSFfEK9vDAnuLIYN6n1Y2dwtk/zrNKqS5Li1ZhOmsoHsck2ap+9Y6E7NAyl+i7OxVMrQ3nG0J7KT8ELmY8aDi4I55p+kvoO8fnaVTzUqxQsccei/0jm+12rZJYma7+obcO6dnMeeYZLB5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568926; c=relaxed/simple;
	bh=elzrA4hvvultaOqp4Vkr9rzM+jmfVCckk6bb4IkSpnA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QQ5DJX9mDqpLbCtpGlMFgGAC4QgigTAlEeiYOPXQpLLHkm7bYeSUf/PW3hc/sfJDCdNYJz297bOkIKf3MICpkxwawscmI+PpWlkcanR1sBkEGD2Ii0i57fzROO9ynNHGTihILaRNasPEivUyhU0oamtxJ3pTiHXxihj1uypUjPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3ae775193so6819515ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728568923; x=1729173723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3lNuvKjEhrUwXBnjWNSSNuW0HU+7/fyYdqp05pU42Lo=;
        b=hH1nYVagwgHgXUJTvsQKaynWHHSaK3zdgCEgvn9YGVEcvWTPq2WRIhhoNZkeOaGkfH
         L47AT/LZtLfZzUhEKKetpzzbZjaKuAVJkW3tyFuSWU3sIxCpGLBCxAtQ+OB7Ike+fh1p
         ix6KvXK/UIEMCiDI9IldksAc8uamaS5v0RPQnht2T56+9P6T5wJdWY9HMj8wQi/ZPNX7
         3J1R7kyVP1xtxybk1YQS6JAvWgFnLTbfC5DVzfLapwnqoDzH96ZpB/J1WPUIAXL2buWj
         ASqfkunSuTS0dcxbT9LNsf4sV3JlC4rTwHYwk6Zjjk6CjOYHzv1ONz6Nl7x6c+I4q7kB
         KfCw==
X-Forwarded-Encrypted: i=1; AJvYcCX/iPXsuJOmmBmRRRrknN0PY11exOO7NlfG+yhplqcXRRGdk+2Cn3mjLGegDNk9DGasorUKruzn8Fq8vz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRbVJSJROcS4qs1h1NxjzW8PX/Q83/VwEc2v/2dMfoHWF2Jc4N
	9qFcDam/A9fqV/A7g9tA8I+Bp2icVRIxAEDfmUF4BR/dNPbtECVJqLLJPD7r7ZXPMqQR6gXu1dw
	OlEOsiowzLt05eusmfdbM5xlrNKNOkcmUHj8Z4y+TfRBdUiKokjgeJQQ=
X-Google-Smtp-Source: AGHT+IHB9H9cAcqddnCfPlBNrFpXMzpMuvk6UbQljF9W5S7SqqOD8POzSt2JXRGzOyFVrZ7/P2XZSuWTvVbzVplMOWTpJI0qYXea
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a26:b0:3a0:8c5f:90b4 with SMTP id
 e9e14a558f8ab-3a397cd82f6mr61788695ab.4.1728568923028; Thu, 10 Oct 2024
 07:02:03 -0700 (PDT)
Date: Thu, 10 Oct 2024 07:02:02 -0700
In-Reply-To: <397b6a20-036f-404b-bdd1-82cc07d05296@nvidia.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6707de5a.050a0220.8109b.000f.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: cmeiohas@nvidia.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings

==================================================================
BUG: KASAN: slab-use-after-free in __ethtool_get_link_ksettings+0x6e/0x190 net/ethtool/ioctl.c:442
Read of size 8 at addr ffff88805ddb6308 by task kworker/0:6/6082

CPU: 0 UID: 0 PID: 6082 Comm: kworker/0:6 Not tainted 6.12.0-rc2-syzkaller-00002-g615b94746a54-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events smc_ib_port_event_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __ethtool_get_link_ksettings+0x6e/0x190 net/ethtool/ioctl.c:442
 ib_get_eth_speed+0x160/0x800 drivers/infiniband/core/verbs.c:1996
 rxe_query_port+0x76/0x260 drivers/infiniband/sw/rxe/rxe_verbs.c:55
 __ib_query_port drivers/infiniband/core/device.c:2105 [inline]
 ib_query_port+0x208/0x870 drivers/infiniband/core/device.c:2147
 smc_ib_remember_port_attr net/smc/smc_ib.c:364 [inline]
 smc_ib_port_event_work+0x14e/0xa50 net/smc/smc_ib.c:388
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5981:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_node_noprof+0x22a/0x440 mm/slub.c:4270
 __kvmalloc_node_noprof+0x72/0x190 mm/util.c:658
 alloc_netdev_mqs+0x9b/0x1000 net/core/dev.c:11097
 rtnl_create_link+0x2f9/0xc20 net/core/rtnetlink.c:3374
 rtnl_newlink_create net/core/rtnetlink.c:3500 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3730 [inline]
 rtnl_newlink+0x1423/0x20a0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6646
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 __sys_sendto+0x39b/0x4f0 net/socket.c:2209
 __do_sys_sendto net/socket.c:2221 [inline]
 __se_sys_sendto net/socket.c:2217 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2217
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 3017:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4727
 device_release+0x99/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 netdev_run_todo+0xe79/0x1000 net/core/dev.c:10816
 default_device_exit_batch+0xa24/0xaa0 net/core/dev.c:11949
 ops_exit_list net/core/net_namespace.c:178 [inline]
 cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:626
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88805ddb6000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 776 bytes inside of
 freed 4096-byte region [ffff88805ddb6000, ffff88805ddb7000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5ddb0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88802f27b201
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac4f500 ffffea00017b0600 dead000000000002
raw: 0000000000000000 0000000000040004 00000001f5000000 ffff88802f27b201
head: 00fff00000000040 ffff88801ac4f500 ffffea00017b0600 dead000000000002
head: 0000000000000000 0000000000040004 00000001f5000000 ffff88802f27b201
head: 00fff00000000003 ffffea0001776c01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5983, tgid 5983 (syz-executor), ts 116767865351, free_ts 113532383722
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
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
 snmp6_alloc_dev net/ipv6/addrconf.c:359 [inline]
 ipv6_add_dev+0x570/0x1220 net/ipv6/addrconf.c:409
 addrconf_notify+0x6a7/0x1020 net/ipv6/addrconf.c:3655
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
 call_netdevice_notifiers net/core/dev.c:2048 [inline]
 register_netdevice+0x167f/0x1b00 net/core/dev.c:10524
 macvlan_common_newlink+0x1189/0x1930 drivers/net/macvlan.c:1536
 rtnl_newlink_create net/core/rtnetlink.c:3510 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3730 [inline]
 rtnl_newlink+0x1591/0x20a0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6646
page last free pid 5909 tgid 5909 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 vfree+0x186/0x2e0 mm/vmalloc.c:3361
 kcov_put kernel/kcov.c:439 [inline]
 kcov_close+0x28/0x50 kernel/kcov.c:535
 __fput+0x23f/0x880 fs/file_table.c:431
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 get_signal+0x16a3/0x1740 kernel/signal.c:2917
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88805ddb6200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805ddb6280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88805ddb6300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88805ddb6380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805ddb6400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         615b9474 RDMA/hns: Disassociate mmap pages for all uct..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=110ecb27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10f96fd0580000


