Return-Path: <linux-kernel+bounces-255180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC43933D29
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6888A2835C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A66217FAC6;
	Wed, 17 Jul 2024 12:53:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2A238DC3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721220785; cv=none; b=KyRRfUB3yUGikUpL5klTK0NC6oZvnni4JBzIBDnrZekQK85q5J6iy3jWiBgTnLA12/QhBds4KnO1ecxm3AsoOyDXQeYjThhoSZ/WznUt9FkeLqRVkr/XtTilXo9JTBK+Qzl6jzNz0se9tyNj50UyMqQwRgvOmGylPfSEv3qLEsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721220785; c=relaxed/simple;
	bh=9blI1e8gVv4HneTp5K9su13jWszFEQVozxNDumQ+Xqo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ccLXvaQp1xxA3dqgJ1DW5ffsywORQo3UmY+8F4VGtHasQcd9W8oRUCckKCD88tpwlWQ69K4CZHP0kCWYV7V8FVK2bkPRfLod5dhH7xklqLxbqAfC3XTmyAjsmdWbeX02klSRV6oFssAJp1ZIoKXjH1A2x8YbDPGb6x7owSt+S78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3835c6e5763so13286415ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 05:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721220783; x=1721825583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHBPjYhvuqmveSugl51jjVACZz5GxMWGW5SvqS1EYd8=;
        b=WL8b3aUBc+6nuOppUBxbt1fcA2XopAB0LypJoHyg+iTYxuc6CC6lVJB04NvAW811eA
         JzUU74SU9Smw1Rxe7cjG8diprUZA9sfHk1St5NQLkvZ1JZYptk8Zv18b2HEFupy9S+TX
         O68JJplcX/BPh0Tu+vUwdJuXyfqv0cUc582mJEZtinhjsXfznzWGgxyqvPh+JpZkKvb/
         Q53sjl81qOXsZgN54EwGBes6TT2uHrIjt38zzoVOk10A+UXkqNLTSOhQns0KmuqmisMB
         H3oAF736EVTu47ETvVjwIlf8aS3tESpYEnvcpMyiBlIW8yH44IacMQfvbjWCG/DaZmMM
         J8Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUJthf4lO/jn3iiWnylaCLb0JEGy0PRS1Cly/LQeMRhXecWCu0r511tUF69H2oNXvUfSm2dTWqj7USkzOogqzp7jkftpGQ38iqiws3t
X-Gm-Message-State: AOJu0Yy6Ov3YO8oDtcNIgmwX/m+jrG6q5NAWkjxu2FTMcw0r34OslKlq
	yxNk9WRlQ1Wxin6t2IBKo3CNoqf9fE5K5n/LIx7kgwBMgLqMCnL9Ahf/OxSei9wH7AOD0BHlhdo
	OrodpYR11kXB+t6QiJ9xJY3MzEii17Rv7GgZyGzUKFSBLD/EiSJbVp4s=
X-Google-Smtp-Source: AGHT+IFYMp5U1l97xfokkCioECGepeLIhsZIRkE/j6qAtC30/CvP6yCvb4An3bDZoGBYK2ccIEPbtSWsZt1h6dCYE283KZw2TDLc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca5:b0:380:c34a:df56 with SMTP id
 e9e14a558f8ab-39558482539mr1338025ab.6.1721220783213; Wed, 17 Jul 2024
 05:53:03 -0700 (PDT)
Date: Wed, 17 Jul 2024 05:53:03 -0700
In-Reply-To: <tencent_84396D049598E9E2ED52CCE479426DD02E0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d247d061d70f187@google.com>
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
Read of size 8 at addr ffff88806b24ede8 by task kworker/u8:1/7170

CPU: 0 PID: 7170 Comm: kworker/u8:1 Not tainted 6.10.0-rc6-syzkaller-01414-g58f9416d413a-dirty #0
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

Allocated by task 928:
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
 ieee80211_debugfs_remove_netdev net/mac80211/debugfs_netdev.c:1022 [inline]
 ieee80211_debugfs_recreate_netdev+0xc4/0x1400 net/mac80211/debugfs_netdev.c:1044
 drv_remove_interface+0x1c9/0x580 net/mac80211/driver-ops.c:117
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

The buggy address belongs to the object at ffff88806b24ed38
 which belongs to the cache dentry of size 312
The buggy address is located 176 bytes inside of
 freed 312-byte region [ffff88806b24ed38, ffff88806b24ee70)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6b24e
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88802d91c601
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888015ef98c0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000150015 00000001ffffefff ffff88802d91c601
head: 00fff00000000040 ffff888015ef98c0 0000000000000000 dead000000000001
head: 0000000000000000 0000000000150015 00000001ffffefff ffff88802d91c601
head: 00fff00000000001 ffffea0001ac9381 ffffffffffffffff 0000000000000000
head: 0000000700000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Reclaimable, gfp_mask 0x1d20d0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5271, tgid 5271 (udevd), ts 76674984449, free_ts 59074482394
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
page last free pid 5091 tgid 5091 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1093 [inline]
 free_unref_folios+0xf23/0x19e0 mm/page_alloc.c:2637
 folios_put_refs+0x93a/0xa60 mm/swap.c:1024
 free_pages_and_swap_cache+0x2ea/0x690 mm/swap_state.c:329
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 unmap_region+0x2df/0x350 mm/mmap.c:2370
 do_vmi_align_munmap+0x1122/0x18c0 mm/mmap.c:2683
 do_vmi_munmap+0x261/0x2f0 mm/mmap.c:2759
 __vm_munmap+0x1fc/0x400 mm/mmap.c:3038
 __do_sys_munmap mm/mmap.c:3055 [inline]
 __se_sys_munmap mm/mmap.c:3052 [inline]
 __x64_sys_munmap+0x68/0x80 mm/mmap.c:3052
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88806b24ec80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc
 ffff88806b24ed00: fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb
>ffff88806b24ed80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff88806b24ee00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
 ffff88806b24ee80: fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         58f9416d Merge branch 'ice-support-to-dump-phy-config-..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17736fdd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db697e01efa9d1d7
dashboard link: https://syzkaller.appspot.com/bug?extid=d5dc2801166df6d34774
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1028d8e6980000


