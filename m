Return-Path: <linux-kernel+bounces-446307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3480F9F2264
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 07:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F6797A0868
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 06:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7B1156CF;
	Sun, 15 Dec 2024 06:14:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F5BDDD2
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734243244; cv=none; b=nPJ6gNcMPeCha3Hl3Sb0mGV+JRjuzP8CItVKvbzhbQ7INkZbthxvtCLOji+fDDGEnYn1G9nMZSrRCgfSjow0c+4bVMc+CF5nhs58+o0U5L8Daq6Vds6tvya1veIcBKcD0wVQToj29khRMuIpIb0WZdBOKwYZK/ROC2v5IKmpP3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734243244; c=relaxed/simple;
	bh=D5fXLmYQypEmvzxwo+HDFUwpEW6r02GsJFV1zJKcPjM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZJzhmhZScFXtIMGXpFXkTzJ6asg3yI/Le3w39n8Kxejz0G7/AKhtyUUfYUnDtEt/NnBQkesSE4OEWVkQ45ZGhwsXTtVJ4HVT34QyepVjpYQnUDJKp7Inqz0wle1tUkgbDdNdeaSocMVb/ruhwIe9RfKiKuOai0SlH0pzjWd4KCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-844ca360ff5so567839539f.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 22:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734243242; x=1734848042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwGyFejjOmqYpIVJuAVvjGFQ1sGVa+KA+IWvX7yjv0A=;
        b=fG7WPO44lbWJGiylxmw/lcgpYTEWa1I4a7japnWGoEMli5zWw5DhV7wfabo11csnQd
         Qeut07xUYP1nxLwK828W+rMThcSFJICvhqRTia5HeWOKw1YOtRjfmcBCSROCY1OWWUS1
         l/JrXO8DL/jWaqvWB6prYpE5W+oA+teU4uxmngMwiTkxpTLQ7X/eR6hvo7+Mpv0dH6dy
         vajVGRXzymhEL76D6Wt924Ue7QBZJKKjIaaUo9fX0ewwZ+rUzirvB8PHDsLWDNXN1ISz
         RYN9GsD+0vOXgWj73SMsVFnq8fjMrhedlIR13pby5OVqf4wlZLp0jKGc4V03tuFaBX6n
         dogA==
X-Forwarded-Encrypted: i=1; AJvYcCXlpq5cj612sNIJVQnuS/xYoDIBUaGFeyP5eWBN8L6Jm3CujebEGJ8mQtbvpG4eoF+aN1DlLOP9jZoW7Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7KgDo+oJ3BddWSmu0WH1F7qQlYUNGm/V4RqSL1tgWkv6NUeAq
	p+CIFdBUGFO0upOLXI1IZXmxBak2VMdPlGFfLb14rhsnx2l1gE/YD9DL9lSeWYcQGCvbVk6rqVx
	ywiOaDumrUM1NFgFuyxB9KIEq7kn+q42mgyD1kgogakbIpdiCt9ntk/8=
X-Google-Smtp-Source: AGHT+IGeegsAF627nE/dk+k+Pm7/eOhcUmddh41Hgh+nrLGX3zXos8OrIuQqeL2n0MsTbooflMf4qGeYRjS4rOvaxH4U7doFO5Kh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c9:b0:3ab:1b7a:5932 with SMTP id
 e9e14a558f8ab-3aff0682c2cmr86684845ab.18.1734243241945; Sat, 14 Dec 2024
 22:14:01 -0800 (PST)
Date: Sat, 14 Dec 2024 22:14:01 -0800
In-Reply-To: <tencent_85066049912EFAEED3CC8D67C146C112EA06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675e73a9.050a0220.37aaf.00f1.GAE@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in folio_evictable (3)
From: syzbot <syzbot+4c7590f1cee06597e43a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in move_to_new_folio

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in mapping_inaccessible include/linux/pagemap.h:335 [inline]
BUG: KASAN: slab-use-after-free in move_to_new_folio+0x201/0xc20 mm/migrate.c:1050
Read of size 8 at addr ffff888055fcc910 by task kcompactd1/29

CPU: 0 UID: 0 PID: 29 Comm: kcompactd1 Not tainted 6.13.0-rc2-syzkaller-00362-g2d8308bf5b67-dirty #0
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
 mapping_inaccessible include/linux/pagemap.h:335 [inline]
 move_to_new_folio+0x201/0xc20 mm/migrate.c:1050
 migrate_folio_move mm/migrate.c:1368 [inline]
 migrate_pages_batch+0x1d1b/0x2a90 mm/migrate.c:1899
 migrate_pages_sync mm/migrate.c:1965 [inline]
 migrate_pages+0x1d57/0x3380 mm/migrate.c:2074
 compact_zone+0x3404/0x4ac0 mm/compaction.c:2641
 compact_node+0x2de/0x460 mm/compaction.c:2910
 kcompactd+0x788/0x1510 mm/compaction.c:3208
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 6029:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4175
 gfs2_glock_get+0x309/0x1010 fs/gfs2/glock.c:1178
 gfs2_inode_lookup+0x2a3/0xc90 fs/gfs2/inode.c:135
 gfs2_dir_search+0x229/0x2f0 fs/gfs2/dir.c:1667
 gfs2_lookupi+0x461/0x5e0 fs/gfs2/inode.c:340
 gfs2_jindex_hold fs/gfs2/ops_fstype.c:587 [inline]
 init_journal+0x5fa/0x2470 fs/gfs2/ops_fstype.c:729
 init_inodes+0xdc/0x320 fs/gfs2/ops_fstype.c:866
 gfs2_fill_super+0x1bd1/0x24d0 fs/gfs2/ops_fstype.c:1251
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1332
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6063:
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
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

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
 do_xmote+0xaf8/0x1250 fs/gfs2/glock.c:832
 glock_work_func+0x343/0x5c0 fs/gfs2/glock.c:1090
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888055fcc548
 which belongs to the cache gfs2_glock(aspace) of size 1224
The buggy address is located 968 bytes inside of
 freed 1224-byte region [ffff888055fcc548, ffff888055fcca10)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x55fcc
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff888033766dc0 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001f5000000 0000000000000000
head: 04fff00000000040 ffff888033766dc0 dead000000000122 0000000000000000
head: 0000000000000000 00000000800c000c 00000001f5000000 0000000000000000
head: 04fff00000000002 ffffea000157f301 ffffffffffffffff 0000000000000000
head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5959, tgid 5958 (syz.0.16), ts 138900958357, free_ts 127446675079
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
 gfs2_glock_get+0x309/0x1010 fs/gfs2/glock.c:1178
 gfs2_inode_lookup+0x2a3/0xc90 fs/gfs2/inode.c:135
 gfs2_lookup_root fs/gfs2/ops_fstype.c:440 [inline]
 init_sb+0xa2a/0x1270 fs/gfs2/ops_fstype.c:507
 gfs2_fill_super+0x19b3/0x24d0 fs/gfs2/ops_fstype.c:1218
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1332
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
page last free pid 5419 tgid 5419 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xd3f/0x1010 mm/page_alloc.c:2657
 kasan_depopulate_vmalloc_pte+0x74/0x90 mm/kasan/shadow.c:408
 apply_to_pte_range mm/memory.c:2831 [inline]
 apply_to_pmd_range mm/memory.c:2875 [inline]
 apply_to_pud_range mm/memory.c:2911 [inline]
 apply_to_p4d_range mm/memory.c:2947 [inline]
 __apply_to_page_range+0x806/0xde0 mm/memory.c:2981
 kasan_release_vmalloc+0xa5/0xd0 mm/kasan/shadow.c:529
 kasan_release_vmalloc_node mm/vmalloc.c:2196 [inline]
 purge_vmap_node+0x22f/0x8d0 mm/vmalloc.c:2213
 __purge_vmap_area_lazy+0x708/0xae0 mm/vmalloc.c:2304
 drain_vmap_area_work+0x27/0x40 mm/vmalloc.c:2338
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888055fcc800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888055fcc880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888055fcc900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888055fcc980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888055fcca00: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         2d8308bf Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a094f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
dashboard link: https://syzkaller.appspot.com/bug?extid=4c7590f1cee06597e43a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15dd4344580000


