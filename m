Return-Path: <linux-kernel+bounces-393576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC839BA28D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 22:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202B71C219FC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 21:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12D115ADAF;
	Sat,  2 Nov 2024 21:34:25 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456625223
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730583265; cv=none; b=aq0OuiBBf1DAKG8X1MXq2PufUF6s7JHfZgupoF4HV7a43s6GrUttNPQTAcJ7WTkkvj1gO5uvfz96WKRI+wHpHkO3RcP8LyyHXToCs6Rhu3T6ctqtjsqSy8HAd3baHRdxwEKjr4XeFKneuWMIfpbhPr7s+0+C/Xcs2afScqzwrVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730583265; c=relaxed/simple;
	bh=HoQwZtD+C7Sh0brPIF184uHwNE/+e+iSPnxvpdkKWVM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TudgA5IujHH9dE9h87edcuCt18sIkapkCpMuSZ0RvMTKxZJ4bOC0CKf+hiNXXbOs4r8Nx+PucfCyPBZqEZenrt3yfigWhr5bK5tqcSfsXYJzyoeWsabDTb4Y9BHhQZ7bb9WxbkfzAIsOqG8OgOwOg+uY6nzHguA2O7kXerW5mA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8353599024bso296238839f.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 14:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730583262; x=1731188062;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=trKSHvrrXW7hN0iIBvomtDU5K/wdXcGBjRTK5D/WKCM=;
        b=Xp63H2VM7+Mi27Wb/P3SpMK440KulaG1muw8yn5DUrq7qa2Znmf8gKenDbPwKxqEfF
         qwtft/jGSdlCo6TPwn3vVfvX6RzxqQFLfpYZwQQ7y21YQfcdUV9ckN0RC8RypgRZWgJq
         nmldOsPFyrxiTJC/GJ4IpzcvMB8qRJumLuCPygJ4nab6DDhWb0Th7TfkbJjbqZ6g/qkE
         sQhtEGYkl2mFPmXqnzuxura/gobqlzbbCpbs1/qdWlz5/5oa+JU8b2paCiXAsRtGEjiw
         gGP0gbjFAY5f/hXpcDqQIlUE3tJnDqOidgQ3WtL30kSqkO+E75ii4yiqp1l7Uwu7+CGi
         bV7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwdSIqjPENIXAsvXHkry0duJLtDzhFB52LU7tgt4GwDg/i7NlxUs6A8oJ0YbgyB4z5kZVJEH+MQtfjrYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh6y05ard8DQu+ArE8blvUW+RToRr3K1I2Y4LVjFLLt2hiE+BC
	90sEbO79NjDUAgF2955rvDIAF0SJfFwijURPyO5hZbuhLCoRIopQA71/U0EOBlSbTCdCr8OXIQ3
	LUjvPcPlHuF/vhtGlyUnQVM/HYcO5iNg9JzZQ/EhZ03pcsBZfLxXPIn8=
X-Google-Smtp-Source: AGHT+IGGr1wjVODrj0+5NKZHTlATIoAZ8I9JDyf9+xkPbPXJOreeCMmoycpnue8bc7e2kEKf0x30xLfrZfKCkqboZ0L7I5SGub3w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1567:b0:3a6:b445:dc9e with SMTP id
 e9e14a558f8ab-3a6b445de24mr63968985ab.4.1730583262367; Sat, 02 Nov 2024
 14:34:22 -0700 (PDT)
Date: Sat, 02 Nov 2024 14:34:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67269ade.050a0220.35b515.0188.GAE@google.com>
Subject: [syzbot] [kernel?] KASAN: invalid-free in process_one_work
From: syzbot <syzbot+902fbaf700d3d08fadf8@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e42b1a9a2557 Merge tag 'spi-fix-v6.12-rc5' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16bbeebb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4340261e4e9f37fc
dashboard link: https://syzkaller.appspot.com/bug?extid=902fbaf700d3d08fadf8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-e42b1a9a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/964caa6b772d/vmlinux-e42b1a9a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1912109c7a7f/bzImage-e42b1a9a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+902fbaf700d3d08fadf8@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free in kfree_bulk include/linux/slab.h:767 [inline]
BUG: KASAN: double-free in kvfree_rcu_bulk+0x454/0x550 kernel/rcu/tree.c:3385
Free of addr ffff88802b07f500 by task kworker/u32:8/1141

CPU: 3 UID: 0 PID: 1141 Comm: kworker/u32:8 Not tainted 6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound kfree_rcu_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report_invalid_free+0xaa/0xd0 mm/kasan/report.c:563
 check_slab_allocation+0xfd/0x130 mm/kasan/common.c:225
 kasan_slab_pre_free include/linux/kasan.h:195 [inline]
 slab_free_hook mm/slub.c:2287 [inline]
 slab_free_freelist_hook mm/slub.c:2371 [inline]
 slab_free_bulk mm/slub.c:4603 [inline]
 kmem_cache_free_bulk.part.0+0x310/0x7c0 mm/slub.c:4847
 kfree_bulk include/linux/slab.h:767 [inline]
 kvfree_rcu_bulk+0x454/0x550 kernel/rcu/tree.c:3385
 kfree_rcu_work+0x2f2/0x5a0 kernel/rcu/tree.c:3464
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 6019:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x1e8/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 nl80211_set_cqm_rssi net/wireless/nl80211.c:13107 [inline]
 nl80211_set_cqm+0xa19/0x1790 net/wireless/nl80211.c:13174
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2551
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg net/socket.c:744 [inline]
 ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2607
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2661
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 64:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free_freelist_hook mm/slub.c:2371 [inline]
 slab_free_bulk mm/slub.c:4603 [inline]
 kmem_cache_free_bulk.part.0+0x28e/0x7c0 mm/slub.c:4847
 kfree_bulk include/linux/slab.h:767 [inline]
 kvfree_rcu_bulk+0x454/0x550 kernel/rcu/tree.c:3385
 kvfree_rcu_drain_ready kernel/rcu/tree.c:3559 [inline]
 kfree_rcu_monitor+0x462/0x8b0 kernel/rcu/tree.c:3632
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
 kvfree_call_rcu+0x74/0xbe0 kernel/rcu/tree.c:3810
 _cfg80211_unregister_wdev+0x38c/0x7f0 net/wireless/core.c:1238
 ieee80211_remove_interfaces+0x36d/0x760 net/mac80211/iface.c:2300
 ieee80211_unregister_hw+0x55/0x3a0 net/mac80211/main.c:1669
 mac80211_hwsim_del_radio drivers/net/wireless/virtual/mac80211_hwsim.c:5625 [inline]
 hwsim_exit_net+0x3ad/0x7d0 drivers/net/wireless/virtual/mac80211_hwsim.c:6505
 ops_exit_list+0xb0/0x180 net/core/net_namespace.c:173
 cleanup_net+0x5b7/0xb40 net/core/net_namespace.c:626
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
 kvfree_call_rcu+0x74/0xbe0 kernel/rcu/tree.c:3810
 _cfg80211_unregister_wdev+0x38c/0x7f0 net/wireless/core.c:1238
 cfg80211_netdev_notifier_call+0xa5c/0x1110 net/wireless/core.c:1494
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1996
 call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
 call_netdevice_notifiers net/core/dev.c:2048 [inline]
 __dev_change_net_namespace+0x46d/0x1360 net/core/dev.c:11583
 dev_change_net_namespace include/linux/netdevice.h:3944 [inline]
 cfg80211_switch_netns+0x11e/0x690 net/wireless/core.c:169
 nl80211_wiphy_netns+0x134/0x2b0 net/wireless/nl80211.c:12364
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2551
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg net/socket.c:744 [inline]
 ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2607
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2661
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802b07f500
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 0 bytes inside of
 64-byte region [ffff88802b07f500, ffff88802b07f540)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2b07f
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b0428c0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5952, tgid 5952 (syz-executor), ts 46294022202, free_ts 46272064430
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2412 [inline]
 allocate_slab mm/slub.c:2578 [inline]
 new_slab+0x2ba/0x3f0 mm/slub.c:2631
 ___slab_alloc+0xdac/0x1880 mm/slub.c:3818
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __kmalloc_cache_noprof+0x2b4/0x300 mm/slub.c:4290
 kmalloc_noprof include/linux/slab.h:878 [inline]
 call_modprobe kernel/module/kmod.c:84 [inline]
 __request_module+0x2c6/0x6c0 kernel/module/kmod.c:173
 __rtnl_newlink+0x64c/0x1920 net/core/rtnetlink.c:3748
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3772
 rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6675
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg net/socket.c:744 [inline]
 __sys_sendto+0x479/0x4d0 net/socket.c:2214
page last free pid 5952 tgid 5952 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 __kmalloc_cache_noprof+0x11e/0x300 mm/slub.c:4290
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 ref_tracker_alloc+0x17c/0x5b0 lib/ref_tracker.c:203
 __netdev_tracker_alloc include/linux/netdevice.h:4062 [inline]
 netdev_hold include/linux/netdevice.h:4091 [inline]
 netdev_hold include/linux/netdevice.h:4086 [inline]
 rx_queue_add_kobject net/core/net-sysfs.c:1106 [inline]
 net_rx_queue_update_kobjects+0x284/0x5f0 net/core/net-sysfs.c:1164
 register_queue_kobjects net/core/net-sysfs.c:1898 [inline]
 netdev_register_kobject+0x26d/0x3f0 net/core/net-sysfs.c:2143
 register_netdevice+0x1473/0x1e90 net/core/dev.c:10491
 team_newlink+0x92/0x160 drivers/net/team/team_core.c:2217
 rtnl_newlink_create net/core/rtnetlink.c:3539 [inline]
 __rtnl_newlink+0x1197/0x1920 net/core/rtnetlink.c:3759
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3772
 rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6675
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901

Memory state around the buggy address:
 ffff88802b07f400: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff88802b07f480: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff88802b07f500: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                   ^
 ffff88802b07f580: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
 ffff88802b07f600: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
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

