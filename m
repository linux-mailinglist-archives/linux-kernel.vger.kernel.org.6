Return-Path: <linux-kernel+bounces-446292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038A59F223B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 06:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190B61663EE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01386C13D;
	Sun, 15 Dec 2024 05:03:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FD88BE5
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 05:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734238987; cv=none; b=tJ3R4GLqHa9o0Qm2gWwIBIGhdJeTAhLCrSsEBI03qZ8FQx0QQ6hq5repALTtelqXfgmQ8ICKA6gcUi5gZ8hevEf8ueN1nUAUrcHQPckKDoRnONm8CfF21ZGgGjqz/RYdEFcWlZ5L6Hh2gG+oIoSxjl0VY9pYK8ttfaTQV9j4dLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734238987; c=relaxed/simple;
	bh=uTN5rZ8Na1IddXdbfUXefvxX+qYlA+/o7/spOfqFZXY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NkvDl/nUp9vG8ejjjrNP9GXF8hzx4yqOzxVR9ARVdbQo2Xg8mq5cuQz+EZEwqE11BQQs7v9KYMx0ZrL90TInfR/u8Nje6qmLpwM/K+Igy24PXgAERRLkVX5f0VnlXr1h3jDrx+Gh7gl6QfhLr/mA2Zm2pvUCTaHdhprNzwFEwmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a814c7d58eso28913455ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 21:03:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734238984; x=1734843784;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nEjRkmg22uGEeOF5QwW3KlVseKX7nDaXqZnWlDjpW6E=;
        b=wfLtOmIp35XFMd0f44I8IXL64jnJoI1c/geuMw46Bw77nOUd2C89CKf2VAcT9UzthK
         JYNa7RVwVbdcDV/aSt9LrFqr1vawWqWLy5baikvdXotlpTeKyAcegFvfFtOlmDKjd8si
         k4i0aAIooS7qinCSBBV98vgILq2Idw7AE77Umo/pJPVoOWTNqsfIsv4J48+AvyqGQqTT
         xnsdgpjp6SC2WgTD+l1rG/9sgTjRQ4Ip1ZHTzaG1/uzFKHwgQ33ljHakiaQVwWSxjJCS
         MwZu+Fln6VrpTfqauTbFrJRquMAnsRJ0bwyI2AstmoKDI4k3ruGNHcQWkGK/pEl9kjq5
         6V8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVR1P89N7PzuWrEsm5roqsRw8FVNOfprfYOjnidXlqkcqkjJzFUw5XQ4zwmhVIOokPBt273VeoKVQ43YQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCqhlup4eEMkUL88slGkz+8sLJLQmjGBb7RKCQzf3jchlDG9tZ
	+rFMbKHT8V5Pz6a514AIr1vNZmY0OTsUwWVsu93q2ftxK31wuGvIDsfSSL6z6UMOTT2j2IK5ZnD
	LR5cGP8VPIhrreCFRS3w4lXd0qEVkgAZ8sfVvwvhbTBI7+OyjKqyDqwY=
X-Google-Smtp-Source: AGHT+IF+XyDqDC5yvZ10MPBCG76x6scYFxWU5ejwEWYgCZJ1SMKOkcykHN59p8a+KFk9NJQe/y1WCqcah1pXO8Fx19L4Tq0KoXs8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26a:0:b0:3a7:635e:d365 with SMTP id
 e9e14a558f8ab-3aff69dc06amr89615655ab.6.1734238984467; Sat, 14 Dec 2024
 21:03:04 -0800 (PST)
Date: Sat, 14 Dec 2024 21:03:04 -0800
In-Reply-To: <tencent_71F8258A8DB0123FDDAB5DE099444F878D07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675e6308.050a0220.37aaf.00ee.GAE@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in folio_evictable (3)
From: syzbot <syzbot+4c7590f1cee06597e43a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in folio_evictable

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in mapping_unevictable include/linux/pagemap.h:269 [inline]
BUG: KASAN: slab-use-after-free in folio_evictable+0xe3/0x250 mm/internal.h:435
Read of size 8 at addr ffff88804ffb13a0 by task kswapd1/81

CPU: 0 UID: 0 PID: 81 Comm: kswapd1 Not tainted 6.13.0-rc2-syzkaller-00362-g2d8308bf5b67-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 mapping_unevictable include/linux/pagemap.h:269 [inline]
 folio_evictable+0xe3/0x250 mm/internal.h:435
 sort_folio mm/vmscan.c:4299 [inline]
 scan_folios mm/vmscan.c:4424 [inline]
 isolate_folios mm/vmscan.c:4550 [inline]
 evict_folios+0xff2/0x5800 mm/vmscan.c:4581
 try_to_shrink_lruvec+0x9a6/0xc70 mm/vmscan.c:4789
 shrink_one+0x3b9/0x850 mm/vmscan.c:4834
 shrink_many mm/vmscan.c:4897 [inline]
 lru_gen_shrink_node mm/vmscan.c:4975 [inline]
 shrink_node+0x37c5/0x3e50 mm/vmscan.c:5956
 kswapd_shrink_node mm/vmscan.c:6785 [inline]
 balance_pgdat mm/vmscan.c:6977 [inline]
 kswapd+0x1ca9/0x36f0 mm/vmscan.c:7246
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 6050:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4175
 gfs2_glock_get+0x309/0x1010 fs/gfs2/glock.c:1179
 gfs2_inode_lookup+0x2a3/0xc90 fs/gfs2/inode.c:135
 gfs2_dir_search+0x229/0x2f0 fs/gfs2/dir.c:1667
 gfs2_lookupi+0x461/0x5e0 fs/gfs2/inode.c:340
 gfs2_lookup_meta+0x100/0x200 fs/gfs2/inode.c:280
 init_journal+0x1bf/0x2410 fs/gfs2/ops_fstype.c:721
 init_inodes+0xdc/0x320 fs/gfs2/ops_fstype.c:864
 gfs2_fill_super+0x1bd1/0x24d0 fs/gfs2/ops_fstype.c:1249
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 16:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kmem_cache_free+0x195/0x410 mm/slub.c:4715
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:950
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
 __call_rcu_common kernel/rcu/tree.c:3086 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3190
 __gfs2_glock_free+0xda0/0xef0 fs/gfs2/glock.c:172
 gfs2_glock_free+0x3c/0xb0 fs/gfs2/glock.c:178
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Second to last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
 insert_work+0x3e/0x330 kernel/workqueue.c:2183
 __queue_work+0xc8b/0xf50 kernel/workqueue.c:2339
 queue_delayed_work_on+0x1ca/0x390 kernel/workqueue.c:2552
 queue_delayed_work include/linux/workqueue.h:677 [inline]
 gfs2_glock_queue_work fs/gfs2/glock.c:250 [inline]
 do_xmote+0xaf8/0x1250 fs/gfs2/glock.c:833
 glock_work_func+0x343/0x5c0 fs/gfs2/glock.c:1091
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88804ffb0fd8
 which belongs to the cache gfs2_glock(aspace) of size 1224
The buggy address is located 968 bytes inside of
 freed 1224-byte region [ffff88804ffb0fd8, ffff88804ffb14a0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4ffb0
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801f8a7c80 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001f5000000 0000000000000000
head: 04fff00000000040 ffff88801f8a7c80 dead000000000122 0000000000000000
head: 0000000000000000 00000000800c000c 00000001f5000000 0000000000000000
head: 04fff00000000002 ffffea00013fec01 ffffffffffffffff 0000000000000000
head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5989, tgid 5987 (syz.0.16), ts 130709784579, free_ts 130654550879
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2269
 alloc_slab_page+0x6a/0x110 mm/slub.c:2423
 allocate_slab+0x5a/0x2b0 mm/slub.c:2589
 new_slab mm/slub.c:2642 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3830
 __slab_alloc+0x58/0xa0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 kmem_cache_alloc_noprof+0x268/0x380 mm/slub.c:4175
 gfs2_glock_get+0x309/0x1010 fs/gfs2/glock.c:1179
 gfs2_inode_lookup+0x2a3/0xc90 fs/gfs2/inode.c:135
 gfs2_lookup_root fs/gfs2/ops_fstype.c:440 [inline]
 init_sb+0xa2a/0x1270 fs/gfs2/ops_fstype.c:507
 gfs2_fill_super+0x19b3/0x24d0 fs/gfs2/ops_fstype.c:1216
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
page last free pid 52 tgid 52 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xd3f/0x1010 mm/page_alloc.c:2657
 discard_slab mm/slub.c:2688 [inline]
 __put_partials+0x160/0x1c0 mm/slub.c:3157
 put_cpu_partial+0x17c/0x250 mm/slub.c:3232
 __slab_free+0x290/0x380 mm/slub.c:4483
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 __kmalloc_cache_noprof+0x1d9/0x390 mm/slub.c:4324
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 keypair_create drivers/net/wireguard/noise.c:100 [inline]
 wg_noise_handshake_begin_session+0xc4/0xb80 drivers/net/wireguard/noise.c:827
 wg_receive_handshake_packet drivers/net/wireguard/receive.c:176 [inline]
 wg_packet_handshake_receive_worker+0x632/0xf50 drivers/net/wireguard/receive.c:213
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff88804ffb1280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804ffb1300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88804ffb1380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88804ffb1400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804ffb1480: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         2d8308bf Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1509fbe8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
dashboard link: https://syzkaller.appspot.com/bug?extid=4c7590f1cee06597e43a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13394344580000


