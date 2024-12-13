Return-Path: <linux-kernel+bounces-445140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB8D9F11E6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC0E16A05E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5984F1E3DD6;
	Fri, 13 Dec 2024 16:18:29 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3F1139587
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734106708; cv=none; b=YXX7CKEO/jqlVj3c2F0XYcqr0ml+9IULoufsO3ZBxT8V4kjttOjygZWKC4D91IQRVVE0aVsbxjALD+o6m8Zp2X4qipMG54L/tYikAFk+4ce9w/QrVZdIdQSTyS+9aSrWtwKISn8ftvVAYVzdo3wr2adNNbW8tOKk3SpFQp6Prmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734106708; c=relaxed/simple;
	bh=BJQCYb2UGYioKJY5JfP7Qo0iGBIpPO8uEcNvJSfwg38=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kCdGFOBlGwfkqy2HYmsOszjLnOjs/Bsbp3HdX9OXGcumlw6/axe5CGVCVvs1w5Nwq1t1nQ6Bw8j6BO8fXZfJmW4Ba6onWQzmGyD3ktK+pA6DqJ0/WdUrkQrCVzZlltxsdC7lVFyYQiOewZjGKNRCHbu+zuwUKORkfyB0+ck12Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-844ccafe468so291716239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:18:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734106706; x=1734711506;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7vWCczZ2BM32n5DA9hc7UZ8rhTMMhGGIqgipIip51k=;
        b=dv9JRhFj3F05gqSxZgs6KH+3IH8Q6PtefsjvXCn9XxwLsfaUsAfWUXjZ1Bf+/elIyH
         /MEePv/5j0VlNnJqBc/k9xRKNrgeL/qDsRqDC7h+2IjK5CfQLf2h4RWR4oU26nmRVEW/
         j1b9MSLWUTKUmq4NfWT5d4oMazanVUY5+kdzld9Ej6xQovYhqq2iIEWdGnjBjTC+WUk/
         C3G9Q6lJPZWQeUvdUfcsaHej2Mj7bHHfF445t+60cCe//qeE+onrCeLz1vwTxKXmsY0z
         5aGucINosu78XXQel2XnjYgSSiQ8N3tocaghfdx4vLle8goKw4a7KtB+wEl7Sv8nhXYq
         65aw==
X-Forwarded-Encrypted: i=1; AJvYcCXE3+hek3gZoA0LysIgCdGPE1hYHjhh+VV8B8CBf/x7O7y8JMKQ2F0SCbPknTQGhurlcUDpA5dm1FXYSTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXV7KUmq/fKn0q/+o4aXiwXwhqCZ5n2uFaFVKGKQQOdxnBsj51
	SFtDI0RzirSTlSE73oKEyoUvyyoOTNK5X0+hDq1ATT+Tp37vOPkfLFYG14c8ITG25VzKs3Dbhnl
	SJHF0UDc77zlJq1YhDupf3IVFZY8iD1Ftp1nVKjcqDWvli4KwCPRKHmc=
X-Google-Smtp-Source: AGHT+IFhcbCfa//QcD1vJeInxFkUdK71WUzLPVb6ilqCshdipxSwtYM02hDNJx+tDSRFnGjW2TnpI100XJcq9WvIT8eoad5uufvl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cd:b0:3a7:e047:733f with SMTP id
 e9e14a558f8ab-3aff4613b80mr45849745ab.1.1734106705774; Fri, 13 Dec 2024
 08:18:25 -0800 (PST)
Date: Fri, 13 Dec 2024 08:18:25 -0800
In-Reply-To: <67453555.050a0220.21d33d.0008.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675c5e51.050a0220.2875e5.0049.GAE@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in folio_evictable (3)
From: syzbot <syzbot+4c7590f1cee06597e43a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f932fb9b4074 Merge tag 'v6.13-rc2-ksmbd-server-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101e24f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
dashboard link: https://syzkaller.appspot.com/bug?extid=4c7590f1cee06597e43a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14654730580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-f932fb9b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1982926f01cf/vmlinux-f932fb9b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/56ef2ef1e465/bzImage-f932fb9b.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/7e9b5cd91eeb/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/87ff98e190e4/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4c7590f1cee06597e43a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in mapping_unevictable include/linux/pagemap.h:269 [inline]
BUG: KASAN: slab-use-after-free in folio_evictable+0xe3/0x250 mm/internal.h:435
Read of size 8 at addr ffff88804e4813a0 by task kswapd1/81

CPU: 0 UID: 0 PID: 81 Comm: kswapd1 Not tainted 6.13.0-rc2-syzkaller-00159-gf932fb9b4074 #0
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

Allocated by task 5580:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4160
 gfs2_glock_get+0x309/0x1010 fs/gfs2/glock.c:1178
 gfs2_inode_lookup+0x2a3/0xc90 fs/gfs2/inode.c:135
 gfs2_dir_search+0x229/0x2f0 fs/gfs2/dir.c:1667
 gfs2_lookupi+0x461/0x5e0 fs/gfs2/inode.c:340
 gfs2_jindex_hold fs/gfs2/ops_fstype.c:587 [inline]
 init_journal+0x5fa/0x2410 fs/gfs2/ops_fstype.c:729
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
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kmem_cache_free+0x195/0x410 mm/slub.c:4700
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
 gfs2_glock_put_eventually fs/gfs2/super.c:1257 [inline]
 gfs2_evict_inode+0x6e2/0x13c0 fs/gfs2/super.c:1546
 evict+0x4e8/0x9a0 fs/inode.c:796
 gfs2_jindex_free+0x3f6/0x4b0 fs/gfs2/super.c:79
 init_journal+0x9fb/0x2410 fs/gfs2/ops_fstype.c:846
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

Second to last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
 insert_work+0x3e/0x330 kernel/workqueue.c:2183
 __queue_work+0xc8b/0xf50 kernel/workqueue.c:2339
 queue_delayed_work_on+0x1ca/0x390 kernel/workqueue.c:2552
 queue_delayed_work include/linux/workqueue.h:677 [inline]
 gfs2_glock_queue_work fs/gfs2/glock.c:250 [inline]
 do_xmote+0xaf8/0x1250 fs/gfs2/glock.c:832
 glock_work_func+0x343/0x5c0 fs/gfs2/glock.c:1090
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88804e480fd8
 which belongs to the cache gfs2_glock(aspace) of size 1224
The buggy address is located 968 bytes inside of
 freed 1224-byte region [ffff88804e480fd8, ffff88804e4814a0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4e480
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801fa3d000 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001f5000000 0000000000000000
head: 04fff00000000040 ffff88801fa3d000 dead000000000122 0000000000000000
head: 0000000000000000 00000000800c000c 00000001f5000000 0000000000000000
head: 04fff00000000002 ffffea0001392001 ffffffffffffffff 0000000000000000
head: 0000000700000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5580, tgid 5580 (syz.0.16), ts 92534711834, free_ts 92373479633
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2269
 alloc_slab_page+0x6a/0x110 mm/slub.c:2408
 allocate_slab+0x5a/0x2b0 mm/slub.c:2574
 new_slab mm/slub.c:2627 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3815
 __slab_alloc+0x58/0xa0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 kmem_cache_alloc_noprof+0x268/0x380 mm/slub.c:4160
 gfs2_glock_get+0x309/0x1010 fs/gfs2/glock.c:1178
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
 discard_slab mm/slub.c:2673 [inline]
 __put_partials+0x160/0x1c0 mm/slub.c:3142
 put_cpu_partial+0x17c/0x250 mm/slub.c:3217
 __slab_free+0x290/0x380 mm/slub.c:4468
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_node_noprof+0x1d9/0x380 mm/slub.c:4205
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1323 [inline]
 alloc_skb_with_frags+0xc3/0x820 net/core/skbuff.c:6612
 sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2881
 sock_alloc_send_skb include/net/sock.h:1797 [inline]
 mld_newpack+0x1c3/0xaf0 net/ipv6/mcast.c:1747
 add_grhead net/ipv6/mcast.c:1850 [inline]
 add_grec+0x1492/0x19a0 net/ipv6/mcast.c:1988
 mld_send_cr net/ipv6/mcast.c:2114 [inline]
 mld_ifc_work+0x691/0xd90 net/ipv6/mcast.c:2651
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391

Memory state around the buggy address:
 ffff88804e481280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804e481300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88804e481380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88804e481400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804e481480: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

