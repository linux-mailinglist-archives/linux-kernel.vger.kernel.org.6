Return-Path: <linux-kernel+bounces-373142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27139A52F0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 08:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C8E2835D5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 06:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD3217BD6;
	Sun, 20 Oct 2024 06:49:38 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD0A28EB
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 06:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729406977; cv=none; b=XKriNT+9Lrt2gfjlLNM3fieSBBzD9JacvhbHW+kRHDpclsy1gnG+NSqRGETmL0ExbBzqj8LGE08np1TRP3AqbdHPAR4qDBRtOZF/iN8Vufxc7S+qivxwKextcPEhApG/7XoT6jUnRG6/mv2ZtNMv8AtRaXbabRVmBeesAFeoi1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729406977; c=relaxed/simple;
	bh=3iaSKeiaihREmubnN/+cWID1l2jqx2aFSbmDBFvfR7c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xx4FdOGhWiI6VPIFZ7kBIRsUqdtXjdV49lTLGSmEnpAhRFbaynyFtYo93h7VKTWWkRSNWgSI9/CaB3eh47dMUzePgCnRmcma9esW8dYLFheNRUdH5MvfeEZK1/PaIq5LHqvM5mLbYnpBi9YTbGBLQ/+v9uBjVaEsgFUsxlxy5uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c70e58bfso27750115ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 23:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729406974; x=1730011774;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVjs0MViBMIDRqKich8ty56mEwLw+hMx6tbPgDauNCc=;
        b=I7JHInj8ioCRe/4ptk441aFFWng50ZMMtjbVDgbXxxKTUgswDGrXgpgK0KFZMb+I78
         kq90rM9dxE4FRXaodVXSxTdxnGeGr/EUir72Dkvr2MnqSUUxm/o1s5VftYZywiCCKYrf
         qi+pi6reP7Gf9ufVB97wn8AZnjXhF4zODOcgZUMrYj9InSXBMxqIr3AgpZcuEehoY+mW
         uOgVSC6OJbPNZx98P9CwmuJ88AQDMEtuZukuNpKHz+8OqkEQ/HTAo2CFQy6CKhXYZqV+
         1UwMHaL8LMrKYiaWTPOgpY1FLA6aVffKysx86K9a0iE+ts3rx04o4UsfUPTtP9qLbNpC
         7kmw==
X-Gm-Message-State: AOJu0YyhiQYboIeaGs3VPLdGvdAQ+9YCM3SLZH6uNsZOKC9IfB62Ds1B
	EeD/fD3ZxKB8QPkKGW0TOzxRbvRKEA9mYT/9bH0y8RlJxKcfSxkRXBlqzlCrgEXMh1eolhJ2qXZ
	MrxiqTdysBtO9y72/Bk6tKGVMRc9z6qKLK7TH9fJDzAsJgHVDQbMVunI=
X-Google-Smtp-Source: AGHT+IGBaSA2zBP+9hnsQXOXT5+f5GaA6xPBLNXfAiny2FCIoOi1jV7xhq9eXHp8yqKjsduztgCxFjBM8YJ0Eyj0ogYSMXqnXR+H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fea:b0:3a3:ae58:2ef1 with SMTP id
 e9e14a558f8ab-3a3f40474f4mr61112475ab.2.1729406974494; Sat, 19 Oct 2024
 23:49:34 -0700 (PDT)
Date: Sat, 19 Oct 2024 23:49:34 -0700
In-Reply-To: <000000000000657ecd0614456af8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6714a7fe.050a0220.10f4f4.002c.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
Author: cmeiohas@nvidia.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next

On 16/10/2024 23:57, syzbot wrote:
> External email: Use caution opening links or attachments
>
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
>
> ==================================================================
> BUG: KASAN: slab-use-after-free in __ethtool_get_link_ksettings+0x6e/0x190 net/ethtool/ioctl.c:442
> Read of size 8 at addr ffff888053712308 by task kworker/0:7/6302
>
> CPU: 0 UID: 0 PID: 6302 Comm: kworker/0:7 Not tainted 6.12.0-rc2-syzkaller-00003-g89e9ae55dc56-dirty #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: events smc_ib_port_event_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  __ethtool_get_link_ksettings+0x6e/0x190 net/ethtool/ioctl.c:442
>  ib_get_eth_speed+0x160/0x800 drivers/infiniband/core/verbs.c:1996
>  rxe_query_port+0x76/0x260 drivers/infiniband/sw/rxe/rxe_verbs.c:55
>  __ib_query_port drivers/infiniband/core/device.c:2105 [inline]
>  ib_query_port+0x208/0x870 drivers/infiniband/core/device.c:2147
>  smc_ib_remember_port_attr net/smc/smc_ib.c:364 [inline]
>  smc_ib_port_event_work+0x14e/0xa50 net/smc/smc_ib.c:388
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
>
> Allocated by task 6015:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
>  kasan_kmalloc include/linux/kasan.h:257 [inline]
>  __do_kmalloc_node mm/slub.c:4264 [inline]
>  __kmalloc_node_noprof+0x22a/0x440 mm/slub.c:4270
>  __kvmalloc_node_noprof+0x72/0x190 mm/util.c:658
>  alloc_netdev_mqs+0x9b/0x1000 net/core/dev.c:11097
>  rtnl_create_link+0x2f9/0xc20 net/core/rtnetlink.c:3374
>  rtnl_newlink_create net/core/rtnetlink.c:3500 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:3730 [inline]
>  rtnl_newlink+0x1423/0x20a0 net/core/rtnetlink.c:3743
>  rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6646
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
>  sock_sendmsg_nosec net/socket.c:729 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:744
>  __sys_sendto+0x39b/0x4f0 net/socket.c:2209
>  __do_sys_sendto net/socket.c:2221 [inline]
>  __se_sys_sendto net/socket.c:2217 [inline]
>  __x64_sys_sendto+0xde/0x100 net/socket.c:2217
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 62:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>  poison_slab_object mm/kasan/common.c:247 [inline]
>  __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
>  kasan_slab_free include/linux/kasan.h:230 [inline]
>  slab_free_hook mm/slub.c:2342 [inline]
>  slab_free mm/slub.c:4579 [inline]
>  kfree+0x1a0/0x440 mm/slub.c:4727
>  device_release+0x99/0x1c0
>  kobject_cleanup lib/kobject.c:689 [inline]
>  kobject_release lib/kobject.c:720 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x22f/0x480 lib/kobject.c:737
>  netdev_run_todo+0xe79/0x1000 net/core/dev.c:10816
>  default_device_exit_batch+0xa24/0xaa0 net/core/dev.c:11949
>  ops_exit_list net/core/net_namespace.c:178 [inline]
>  cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:626
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> The buggy address belongs to the object at ffff888053712000
>  which belongs to the cache kmalloc-cg-4k of size 4096
> The buggy address is located 776 bytes inside of
>  freed 4096-byte region [ffff888053712000, ffff888053713000)
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x53710
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> memcg:ffff888030c97b81
> flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000040 ffff88801ac4f500 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000000040004 00000001f5000000 ffff888030c97b81
> head: 00fff00000000040 ffff88801ac4f500 dead000000000122 0000000000000000
> head: 0000000000000000 0000000000040004 00000001f5000000 ffff888030c97b81
> head: 00fff00000000003 ffffea00014dc401 ffffffffffffffff 0000000000000000
> head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6015, tgid 6015 (syz-executor), ts 107991568332, free_ts 107952289946
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
>  prep_new_page mm/page_alloc.c:1545 [inline]
>  get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
>  __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
>  alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
>  alloc_slab_page+0x6a/0x120 mm/slub.c:2412
>  allocate_slab+0x5a/0x2f0 mm/slub.c:2578
>  new_slab mm/slub.c:2631 [inline]
>  ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
>  __slab_alloc+0x58/0xa0 mm/slub.c:3908
>  __slab_alloc_node mm/slub.c:3961 [inline]
>  slab_alloc_node mm/slub.c:4122 [inline]
>  __do_kmalloc_node mm/slub.c:4263 [inline]
>  __kmalloc_noprof+0x25a/0x400 mm/slub.c:4276
>  kmalloc_noprof include/linux/slab.h:882 [inline]
>  kzalloc_noprof include/linux/slab.h:1014 [inline]
>  __register_sysctl_table+0x65/0x1550 fs/proc/proc_sysctl.c:1368
>  __addrconf_sysctl_register+0x234/0x3a0 net/ipv6/addrconf.c:7224
>  addrconf_sysctl_register+0x167/0x1c0 net/ipv6/addrconf.c:7272
>  ipv6_add_dev+0xcf6/0x1220 net/ipv6/addrconf.c:456
>  addrconf_notify+0x6a7/0x1020 net/ipv6/addrconf.c:3655
>  notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
>  call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
>  call_netdevice_notifiers net/core/dev.c:2048 [inline]
>  register_netdevice+0x167f/0x1b00 net/core/dev.c:10524
> page last free pid 6166 tgid 6166 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1108 [inline]
>  free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
>  discard_slab mm/slub.c:2677 [inline]
>  __put_partials+0xeb/0x130 mm/slub.c:3145
>  put_cpu_partial+0x17c/0x250 mm/slub.c:3220
>  __slab_free+0x2ea/0x3d0 mm/slub.c:4449
>  qlink_free mm/kasan/quarantine.c:163 [inline]
>  qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
>  kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>  __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>  kasan_slab_alloc include/linux/kasan.h:247 [inline]
>  slab_post_alloc_hook mm/slub.c:4085 [inline]
>  slab_alloc_node mm/slub.c:4134 [inline]
>  kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
>  vm_area_dup+0x27/0x290 kernel/fork.c:487
>  __split_vma+0x1cb/0xc50 mm/vma.c:384
>  vms_gather_munmap_vmas+0x2ee/0x15d0 mm/vma.c:1205
>  mmap_region+0x817/0x2990 mm/mmap.c:1387
>  do_mmap+0x8f0/0x1000 mm/mmap.c:496
>  vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
>  ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:542
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>
> Memory state around the buggy address:
>  ffff888053712200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888053712280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff888053712300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                       ^
>  ffff888053712380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888053712400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
>
>
> Tested on:
>
> commit:         89e9ae55 IB/hfi1: make clear_all_interrupts static
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13a8dc40580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
> dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=11893887980000
>

