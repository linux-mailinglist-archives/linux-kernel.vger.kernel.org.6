Return-Path: <linux-kernel+bounces-255229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72073933DB9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B414283D15
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C97180A65;
	Wed, 17 Jul 2024 13:38:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304C938DD1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721223485; cv=none; b=oR+WfbpN2/uYu+lT92HgyjszrGgo+Bsj8fB0VtYZd3b8wMojTu4s6n1hKmb5WQBWfFQgJgGFWf4HsHml5ebzgwzmbBtEAszERTPvFWnteMeUPzBBmh+y/IXuqWyUS51ehquD00eqb4gtj0CnMEt4YNTSFsMf3bcxNr+lqtKKwE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721223485; c=relaxed/simple;
	bh=hbnh9WwhiU+AUxErRxm0uAz/l5ipQK8I+n812/iOUig=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UmtKbkp9NEwXyV31X9Stmkua88OvmmynKagtV6cUfkZ8q4ShFlc6n5xYto7MjbfJ4DwteQi1eDqTCb82hdKvdCa8HreLr87ufBWp+LDa4pTCcTk5hxrmALy4BrS8Qewt06WOaxDHkp8W+Fn5GXNOgN6dTtL1Te/C+wJHFE8LgRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-804b8301480so135921239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721223482; x=1721828282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ot+Td4MDi7yyXEeSkZsT2uLn4/KwdZrRGQ9VnSuIUQU=;
        b=jEubbmvGbctz5hnWEFnzFpTn8lI/6DXIc4gRawWhn39AnrT7zOfEsMdxkTgJP91wja
         foO06Sfobvb+kp8hDoe7q/CT70op+NMjsvPNl6sLxxiHzZ8enBUq8MaF2mXK1G07gBDa
         HOw+YZsDmeRAX6hJ5T38j3i23Bh3lXIsaokjpETF6joPlqNdQLsTxQDxSFcGLzTnPgHg
         Rg9oB3WexJ7NHIxDEbWTnVgw6I09WFpCGknEYT+SDOTX9HoGsz2JlgaaVWXtxansakVn
         QloC9cKDXb6UctKx4Lpq1LZ7Y/JiRyt+ElcEA8DkT15l49Hy7IT5kkxZvZUxxYvi9Uxp
         uHRw==
X-Forwarded-Encrypted: i=1; AJvYcCURXK7fKCe3gqTOpOVoVOgEZ1PPJRma1AWQWvA6t7JZs8peJ7rHsGr0TP47MYaeRXqR2sGEbpvj4x+rNcc9uqf5NZPL2v8vm7xaCA8Y
X-Gm-Message-State: AOJu0YyiiOW0APuvc4Mw4cg8Z/eTCo6b8tyMowY65E588ToR3hBsFjvr
	Y2jKU8cFzMO3383loiGay+SHVk9GYUuKUeij1YME4AR2S76vfZAT0P4ju5NuBxYWPGzj67JaRz7
	7jIm5NzulsgLgNOjMc9i0Ayk4RX8St60/sdeBwveGsuJJ1wyb3G7m5mg=
X-Google-Smtp-Source: AGHT+IFM/ICsSM+0akOPItVSFyKyDh2HjU6wwmxq3f9SNw03IoMCmMuGIyNb6fVd7sJX78+3wDgyxMKB8U/qPbP3FRn1VsTw2nhK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6298:b0:4b9:6c10:36a9 with SMTP id
 8926c6da1cb9f-4c21588974fmr45628173.1.1721223482392; Wed, 17 Jul 2024
 06:38:02 -0700 (PDT)
Date: Wed, 17 Jul 2024 06:38:02 -0700
In-Reply-To: <tencent_B8E916EE96CCEC783A6F182C756C2094800A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f5550061d719244@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in lockref_get
From: syzbot <syzbot+d5dc2801166df6d34774@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in lockref_get

wlan1: authentication with 08:02:11:00:00:00 timed out
==================================================================
BUG: KASAN: slab-use-after-free in __lock_acquire+0x78/0x1fd0 kernel/locking/lockdep.c:5005
Read of size 8 at addr ffff88807aa2ade8 by task kworker/u8:9/2858

CPU: 0 PID: 2858 Comm: kworker/u8:9 Not tainted 6.10.0-rc6-syzkaller-01414-g58f9416d413a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: events_unbound cfg80211_wiphy_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __lock_acquire+0x78/0x1fd0 kernel/locking/lockdep.c:5005
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 lockref_get+0x15/0x60 lib/lockref.c:50
 dget include/linux/dcache.h:333 [inline]
 simple_recursive_removal+0x35/0x8e0 fs/libfs.c:601
 debugfs_remove+0x49/0x70 fs/debugfs/inode.c:823
 ieee80211_sta_debugfs_remove+0x40/0x60 net/mac80211/debugfs_sta.c:1287
 __sta_info_destroy_part2+0x3b2/0x4c0 net/mac80211/sta_info.c:1477
 __sta_info_destroy net/mac80211/sta_info.c:1493 [inline]
 sta_info_destroy_addr+0xf4/0x140 net/mac80211/sta_info.c:1505
 ieee80211_destroy_auth_data+0x139/0x270 net/mac80211/mlme.c:4163
 ieee80211_sta_work+0x1256/0x3850 net/mac80211/mlme.c:7801
 cfg80211_wiphy_work+0x2db/0x490 net/wireless/core.c:440
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5176:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4002 [inline]
 kmem_cache_alloc_lru_noprof+0x139/0x2b0 mm/slub.c:4021
 __d_alloc+0x31/0x700 fs/dcache.c:1624
 d_alloc fs/dcache.c:1704 [inline]
 d_alloc_parallel+0xdf/0x1600 fs/dcache.c:2462
 __lookup_slow+0x117/0x3f0 fs/namei.c:1677
 lookup_one_len+0x18b/0x2d0 fs/namei.c:2764
 start_creating+0x187/0x310 fs/debugfs/inode.c:378
 debugfs_create_dir+0x25/0x430 fs/debugfs/inode.c:593
 ieee80211_sta_debugfs_add+0x132/0x820 net/mac80211/debugfs_sta.c:1262
 sta_info_insert_finish net/mac80211/sta_info.c:881 [inline]
 sta_info_insert_rcu+0xecf/0x1900 net/mac80211/sta_info.c:949
 sta_info_insert+0x16/0xc0 net/mac80211/sta_info.c:954
 ieee80211_prep_connection+0xecd/0x12d0 net/mac80211/mlme.c:8319
 ieee80211_mgd_auth+0xd42/0x14c0 net/mac80211/mlme.c:8564
 rdev_auth net/wireless/rdev-ops.h:485 [inline]
 cfg80211_mlme_auth+0x59f/0x980 net/wireless/mlme.c:291
 cfg80211_conn_do_work+0x5ed/0xe60 net/wireless/sme.c:181
 cfg80211_conn_work+0x27c/0x4d0 net/wireless/sme.c:271
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 25:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4438 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4513
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2809
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:820 [inline]
 nsim_dev_trap_report_work+0x75d/0xaa0 drivers/net/netdevsim/dev.c:850
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3072 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3176
 __dentry_kill+0x497/0x630 fs/dcache.c:622
 dput+0x19f/0x2b0 fs/dcache.c:845
 find_next_child fs/libfs.c:594 [inline]
 simple_recursive_removal+0x2bd/0x8e0 fs/libfs.c:609
 debugfs_remove+0x49/0x70 fs/debugfs/inode.c:823
 ieee80211_debugfs_remove_netdev net/mac80211/debugfs_netdev.c:1022 [inline]
 ieee80211_debugfs_recreate_netdev+0xc4/0x1400 net/mac80211/debugfs_netdev.c:1044
 drv_remove_interface+0x1e1/0x590 net/mac80211/driver-ops.c:119
 _ieee80211_change_mac net/mac80211/iface.c:278 [inline]
 ieee80211_change_mac+0xaf5/0x11e0 net/mac80211/iface.c:310
 dev_set_mac_address+0x327/0x510 net/core/dev.c:9095
 dev_set_mac_address_user+0x31/0x50 net/core/dev.c:9114
 dev_ifsioc+0xbd9/0xe70 net/core/dev_ioctl.c:541
 dev_ioctl+0x719/0x1340 net/core/dev_ioctl.c:786
 sock_do_ioctl+0x240/0x460 net/socket.c:1236
 sock_ioctl+0x629/0x8e0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807aa2ad38
 which belongs to the cache dentry of size 312
The buggy address is located 176 bytes inside of
 freed 312-byte region [ffff88807aa2ad38, ffff88807aa2ae70)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7aa2a
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888022de1f01
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888015ef98c0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000150015 00000001ffffefff ffff888022de1f01
head: 00fff00000000040 ffff888015ef98c0 0000000000000000 dead000000000001
head: 0000000000000000 0000000000150015 00000001ffffefff ffff888022de1f01
head: 00fff00000000001 ffffea0001ea8a81 ffffffffffffffff 0000000000000000
head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Reclaimable, gfp_mask 0x1d20d0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5900, tgid 5900 (udevd), ts 118723483735, free_ts 96879687479
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1473
 prep_new_page mm/page_alloc.c:1481 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3425
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4683
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2265
 allocate_slab+0x5a/0x2f0 mm/slub.c:2428
 new_slab mm/slub.c:2481 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3667
 __slab_alloc+0x58/0xa0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3990 [inline]
 kmem_cache_alloc_lru_noprof+0x1c5/0x2b0 mm/slub.c:4021
 __d_alloc+0x31/0x700 fs/dcache.c:1624
 d_alloc fs/dcache.c:1704 [inline]
 d_alloc_parallel+0xdf/0x1600 fs/dcache.c:2462
 lookup_open fs/namei.c:3430 [inline]
 open_last_lookups fs/namei.c:3574 [inline]
 path_openat+0x92f/0x35f0 fs/namei.c:3810
 do_filp_open+0x235/0x490 fs/namei.c:3840
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1413
 do_sys_open fs/open.c:1428 [inline]
 __do_sys_openat fs/open.c:1444 [inline]
 __se_sys_openat fs/open.c:1439 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1439
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 4761 tgid 4761 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1093 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2588
 __slab_free+0x31b/0x3d0 mm/slub.c:4349
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4002 [inline]
 kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4045
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:664
 alloc_skb include/linux/skbuff.h:1320 [inline]
 alloc_skb_with_frags+0xc3/0x770 net/core/skbuff.c:6526
 sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2815
 unix_dgram_sendmsg+0x6d3/0x1f80 net/unix/af_unix.c:2030
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 sock_write_iter+0x2dd/0x400 net/socket.c:1160
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807aa2ac80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc
 ffff88807aa2ad00: fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb
>ffff88807aa2ad80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff88807aa2ae00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
 ffff88807aa2ae80: fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         58f9416d Merge branch 'ice-support-to-dump-phy-config-..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14034f31980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db697e01efa9d1d7
dashboard link: https://syzkaller.appspot.com/bug?extid=d5dc2801166df6d34774
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12f885a5980000


