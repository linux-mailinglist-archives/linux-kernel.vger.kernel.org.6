Return-Path: <linux-kernel+bounces-266806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE369407F2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6469428349B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C4516A36E;
	Tue, 30 Jul 2024 05:54:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD076433B0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722318844; cv=none; b=agVPGr0u1tEzPl103vKxzYQPRn+cxTOLfQxXbLE2UkHXGTOLHrPWk1AB/G669j300dEc3fCeetCmqw+xaLKfUgpGgIQT4ySk5ocwpN/iDY063rLfzrR8CoNOHWeY4Cri/j/x7sMTIHnoMWb90C4BGho1f4XT42VVCBCYx7EleDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722318844; c=relaxed/simple;
	bh=DZSTPmydmmEe7Zx0AeUAz9G8KD4BaV8pK8SwLWexzT8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sttlXcD5nIW5kiDVCUXvA1WPbThXR0Tv+3qtvXKf8pN7oLUzCSWrI8JIbuT4t0i+SSbFidIU5N30z6O4HbOXQnzgIapw074EMJ6VcUwFOg6gxo8SKgIzkzs9+h1zp6e4eu6Wrp2Jmk3OETCUYgnIGDfaKu/OuLU2VKGzmZ/Yf+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-37492fe22cdso56943565ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 22:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722318842; x=1722923642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5CuAk+F6goRPjwMPIHzwKyOtltYVSlmctn8OOXHxAs=;
        b=pckSO0LVykGlrXA2mllLmEE71+oYGIJp51UM1zvVVIk48oG0ItlUYuSuZ/MqN3IaGG
         fI7/5+RRkQf1GWYlCk8kLtKuLQfFbM//eukm6ONkmbp4bH5B6oRPDaQQt7LWwgzTj041
         KgY2zuerzzW7Zvca0RDVFzY0edxtUVrQOAoW++spZdpw2zFhrl9DNI/qVqTNcaA900+9
         oQXQF1MOfRaXakJkMm3HZE0a6OaTC2LI9Sxcvd5JcMVq4sekwqm7jOILQIXgri1J4LJw
         vj5IeeDwJtwTqbwveJc0jicAH6Mq2tqT3IoEhfU7Cac4vrdXImumjRuHARMb4EQI8YtX
         ZnBA==
X-Forwarded-Encrypted: i=1; AJvYcCUsfjg+pult/XE2WGpg5a8hsffL8ps376OTQGm7Ibl/mKumjE4hlDKJNbqWmDcSYA217kIl7tEOFIN4m/ElNbRZr7y8vih1u15IKbsX
X-Gm-Message-State: AOJu0YwZf2f3//K7LnPFRTOssWVJ4CSTZUmWEKzsxsblYLMotZbqrEx/
	BfEQmxi9DuCS8gE7K4W0JfABoPyLshhnIIlzGTqUbQZ9lv5q/md+NYBTJZi/aftRz/Saiyz2K/E
	nQGNp/A9n/2sMpKTLsossQpdWF/hUa7UEceStwI52ELhNaqat7uhVHyo=
X-Google-Smtp-Source: AGHT+IEiJ6vc/Uv0Y33VB6j2+oEj1mvvvcpHQAcLj66bHRiSQF0W2Z3+VjuUwzXf6aZMoR1a0pRC0ih9XZVp6ZwpxzAmpHWpubYS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5c1:b0:376:3fad:bb7c with SMTP id
 e9e14a558f8ab-39b06ad8df9mr168105ab.1.1722318841802; Mon, 29 Jul 2024
 22:54:01 -0700 (PDT)
Date: Mon, 29 Jul 2024 22:54:01 -0700
In-Reply-To: <tencent_EAF7DD8919014F8F8DD6259B0DA8123DDD07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c18026061e709a93@google.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-use-after-free Read in hdm_disconnect
From: syzbot <syzbot+916742d5d24f6c254761@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in hdm_disconnect

usb 1-1: USB disconnect, device number 2
==================================================================
BUG: KASAN: slab-use-after-free in hdm_disconnect+0x1fd/0x220 drivers/most/most_usb.c:1123
Read of size 8 at addr ffff88812b88d898 by task kworker/0:1/9

CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.10.0-syzkaller-11840-g933069701c1b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 hdm_disconnect+0x1fd/0x220 drivers/most/most_usb.c:1123
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:568 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:560
 __device_release_driver drivers/base/dd.c:1270 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1293
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x396/0x9f0 drivers/base/core.c:3868
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1be4/0x4f50 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 24:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x8f/0xa0 mm/kasan/common.c:387
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 hdm_probe+0xb3/0x1880 drivers/most/most_usb.c:959
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:656
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:828
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:956
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1028
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3679
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:656
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:828
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:956
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1028
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3679
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2e66/0x4f50 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 9:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x14/0x30 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kfree+0x10b/0x380 mm/slub.c:4594
 device_release+0xa1/0x240 drivers/base/core.c:2581
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1fa/0x5b0 lib/kobject.c:737
 put_device drivers/base/core.c:3787 [inline]
 device_unregister+0x2f/0xc0 drivers/base/core.c:3910
 hdm_disconnect+0xcb/0x220 drivers/most/most_usb.c:1121
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:568 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:560
 __device_release_driver drivers/base/dd.c:1270 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1293
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x396/0x9f0 drivers/base/core.c:3868
 usb_disable_device+0x36c/0x7f0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2304
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1be4/0x4f50 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88812b88c000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 6296 bytes inside of
 freed 8192-byte region [ffff88812b88c000, ffff88812b88e000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x12b888
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x200000000000040(head|node=0|zone=2)
page_type: 0xfdffffff(slab)
raw: 0200000000000040 ffff888100042280 0000000000000000 0000000000000001
raw: 0000000000000000 0000000000020002 00000001fdffffff 0000000000000000
head: 0200000000000040 ffff888100042280 0000000000000000 0000000000000001
head: 0000000000000000 0000000000020002 00000001fdffffff 0000000000000000
head: 0200000000000003 ffffea0004ae2201 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 3760, tgid 3760 (syz-executor), ts 94461081420, free_ts 94383274108
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x1311/0x25f0 mm/page_alloc.c:3438
 __alloc_pages_noprof+0x21e/0x2290 mm/page_alloc.c:4696
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
 __kmalloc_node_track_caller_noprof+0x14e/0x3e0 mm/slub.c:4177
 kmemdup_noprof+0x29/0x60 mm/util.c:133
 kmemdup_noprof include/linux/fortify-string.h:753 [inline]
 ipv4_sysctl_init_net+0x3e/0x350 net/ipv4/sysctl_net_ipv4.c:1587
 ops_init+0xb9/0x650 net/core/net_namespace.c:139
 setup_net+0x435/0xb40 net/core/net_namespace.c:343
 copy_net_ns+0x2f0/0x670 net/core/net_namespace.c:508
 create_new_namespaces+0x3ea/0xb10 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
 ksys_unshare+0x419/0x970 kernel/fork.c:3309
page last free pid 37 tgid 37 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0x698/0xce0 mm/page_alloc.c:2608
 __put_partials+0x14c/0x170 mm/slub.c:3051
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x4e/0x70 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 kmem_cache_alloc_node_noprof+0x13e/0x2e0 mm/slub.c:4080
 __alloc_skb+0x2b1/0x380 net/core/skbuff.c:664
 alloc_skb include/linux/skbuff.h:1320 [inline]
 nlmsg_new include/net/netlink.h:1015 [inline]
 inet6_netconf_notify_devconf+0x84/0x180 net/ipv6/addrconf.c:589
 __addrconf_sysctl_unregister net/ipv6/addrconf.c:7250 [inline]
 addrconf_exit_net+0xe9/0x3f0 net/ipv6/addrconf.c:7367
 ops_exit_list+0xb0/0x180 net/core/net_namespace.c:173
 cleanup_net+0x5b7/0xbf0 net/core/net_namespace.c:640
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff88812b88d780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88812b88d800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88812b88d880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88812b88d900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88812b88d980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         93306970 Merge tag '6.11-rc-smb3-server-fixes' of git:..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=173e7345980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f828342678294017
dashboard link: https://syzkaller.appspot.com/bug?extid=916742d5d24f6c254761
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1532a965980000


