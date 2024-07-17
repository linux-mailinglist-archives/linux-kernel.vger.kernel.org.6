Return-Path: <linux-kernel+bounces-254662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B089335FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103C61C21DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 04:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B239445;
	Wed, 17 Jul 2024 04:19:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AA5628
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 04:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721189944; cv=none; b=Nyg4bxtbqyPgZ17e8fIOo5I9pNtgP6V+6IO1F8NdcW6i+2O8tGZYsOgdZy7zyTgdFaP9A9wj8JvyILDaORvVGaXbJ/S0rP73htq315bI5X3O6pFF/CJViSVLWUvd5Cs7MG+io076X+T6RhZ+Ayxfyt9dl1rD6YjHfe+jPERwWQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721189944; c=relaxed/simple;
	bh=+JFAIEs/knQUhazHGJqkgUONBYcoI9NzeqL/agkmS0I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bSkRhJb1lE64+EY2GNnI/Wb0DcEyGm/u4vYiPZSwg2aZWakfTRX5vulspszAwjNEnqduteaWGAzz0qRAEeX82vsH5PaqfKUImPTHYwpcR3KKLcSBvmzrVBbeHcwBmX6iW0JwLhlmeot6gXOvf9QrtTXblZTNE2HvGXl/MeZisLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-375e4d55457so8279865ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 21:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721189942; x=1721794742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x4g6/oLblYCcsb9k4FDJCZCOQg/jhLvBVrexfOqfXOk=;
        b=s2cYRMgV+KbzY2I9v2q3T3Gr6VJgMMhJ0frX8xlK2y+9jQharQ85ntVOyORaQ8QjZ7
         9Dy0x1Sj/QzvnLDDNhKAuyZeX0idSaeyaxAPhMDqQahszSFOQ7vBBr7TSgliDD4V+lEC
         oCbzzeKpAUXZFHNpKV4gX/dpNgqGwERQQiKvjZaqn8zTTToEa8E6hyQYuxAiBTJ46MOW
         RMvUHDg2uovsfKmP20Wcviaj8A0+6k4DxZiyZsU4ZJmVH94rUuNwox1miER7ktEPOeuk
         AwEIEKcr916qVWldFVv1gKVyCk3NBmiJ+3swJham92xCdMZJxpKQIZCs4OdjBtPkcRff
         UchQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTkVHWK4O1824pSzm7ZlcrljTs1wFSUd1CEfXl2nQF2d+9Xkc03HzbE98wSzpzvrdEn2y2xyuW3k1ExEMhq5WL7ckxdt3B9Dtx1ODc
X-Gm-Message-State: AOJu0YyS9gbrhU74eZQhlavIcyg6i9MB21FKxEOX8pGVO0UEwnpEhxPp
	79TkGN/NdrrElS293uGIk8eU7sl7UCLb5tdXwGylyJi/kV4wamclcQGbHKIYLHW55GiVtT8Czrd
	mMAk8EqtZ13Z2NgQfj3AQ8J/0S+/6DsYpcGJVuOHUrvGmhsFBpC3tc2M=
X-Google-Smtp-Source: AGHT+IHEFFPhsNffX4AVCkuskHMSW7wsSRS8NHOitXtpXuqnn9o60VTcOMuwlEjaNo5hC6OLv2s4h86MHLmjT5Y3YWaXaAcpuo9n
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8f:b0:382:56bd:dfbc with SMTP id
 e9e14a558f8ab-39555800336mr521005ab.2.1721189942322; Tue, 16 Jul 2024
 21:19:02 -0700 (PDT)
Date: Tue, 16 Jul 2024 21:19:02 -0700
In-Reply-To: <tencent_AAEF765567CA3DCF377696B436244B387509@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a8512061d69c30b@google.com>
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
Read of size 8 at addr ffff888079a80228 by task kworker/u8:4/62

CPU: 0 PID: 62 Comm: kworker/u8:4 Not tainted 6.10.0-rc6-syzkaller-01414-g58f9416d413a-dirty #0
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
 ieee80211_sta_debugfs_remove+0x85/0xb0 net/mac80211/debugfs_sta.c:1292
 __sta_info_destroy_part2+0x35e/0x450 net/mac80211/sta_info.c:1476
 __sta_info_destroy net/mac80211/sta_info.c:1492 [inline]
 sta_info_destroy_addr+0xf4/0x140 net/mac80211/sta_info.c:1504
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

Allocated by task 9:
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

Freed by task 16:
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
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:928
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
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
 ieee80211_debugfs_remove_netdev net/mac80211/debugfs_netdev.c:1025 [inline]
 ieee80211_debugfs_recreate_netdev+0xe5/0x1400 net/mac80211/debugfs_netdev.c:1046
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

The buggy address belongs to the object at ffff888079a80178
 which belongs to the cache dentry of size 312
The buggy address is located 176 bytes inside of
 freed 312-byte region [ffff888079a80178, ffff888079a802b0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888079a818f8 pfn:0x79a80
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff8880246c0001
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000240 ffff888015ef98c0 ffffea0000908290 ffffea0000908990
raw: ffff888079a818f8 000000000015000d 00000001ffffefff ffff8880246c0001
head: 00fff00000000240 ffff888015ef98c0 ffffea0000908290 ffffea0000908990
head: ffff888079a818f8 000000000015000d 00000001ffffefff ffff8880246c0001
head: 00fff00000000001 ffffea0001e6a001 ffffffffffffffff 0000000000000000
head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Reclaimable, gfp_mask 0x1d20d0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5158, tgid 5158 (syz-executor), ts 70763984393, free_ts 17755264398
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
 d_alloc+0x4b/0x190 fs/dcache.c:1704
 lookup_one_qstr_excl+0xce/0x260 fs/namei.c:1603
 filename_create+0x297/0x540 fs/namei.c:3907
 do_symlinkat+0xf9/0x3a0 fs/namei.c:4514
 __do_sys_symlinkat fs/namei.c:4537 [inline]
 __se_sys_symlinkat fs/namei.c:4534 [inline]
 __x64_sys_symlinkat+0x99/0xb0 fs/namei.c:4534
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1093 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2588
 free_contig_range+0x9e/0x160 mm/page_alloc.c:6642
 destroy_args+0x8a/0x890 mm/debug_vm_pgtable.c:1017
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1397
 do_one_initcall+0x248/0x880 init/main.c:1267
 do_initcall_level+0x157/0x210 init/main.c:1329
 do_initcalls+0x3f/0x80 init/main.c:1345
 kernel_init_freeable+0x435/0x5d0 init/main.c:1578
 kernel_init+0x1d/0x2b0 init/main.c:1467
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888079a80100: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fa
 ffff888079a80180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888079a80200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888079a80280: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fa fb
 ffff888079a80300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         58f9416d Merge branch 'ice-support-to-dump-phy-config-..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15ce003d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db697e01efa9d1d7
dashboard link: https://syzkaller.appspot.com/bug?extid=d5dc2801166df6d34774
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=168e003d980000


