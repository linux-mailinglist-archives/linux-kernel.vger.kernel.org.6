Return-Path: <linux-kernel+bounces-211391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F1A905109
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D14C4B21076
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419B116EC1E;
	Wed, 12 Jun 2024 11:04:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6C612E5E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718190244; cv=none; b=lew1z0Gj+T+vVvxd/Wxvy4vwe90GKyS5GX91w9fBarDRvnagvkYrxdYK+sYNRbhwS57233Hsp3Xob94N/zDNEqo4Y8FqGAqY43dmJDR3DDljOY75eez9mpOmQuhmC4rhONcudwj/JTtLMm37sy/NyWoqyB8xGxYaggeoXjhRwBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718190244; c=relaxed/simple;
	bh=L5HDqZYicpryRSpi5+QpUDB43eaG5f7/SIQYrT6RWRU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q1FKPfkexwQ1Fbs+XRHht1EFzQ6sb3sEj1jyvLfgrQrl0P8vI35h4nXTxoMJnrIaImYkpz45wNv3sPPO/efgE13cBpCAgO2qZdiQIrdsVCfXFreeHpXJH80k9V9i84rVoPiZsbv/n5Jfll+hlLJ60z0IUXz7H9wBwMkBOpUplKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-375d074398bso2271175ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718190242; x=1718795042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUC5YR3VI9SuO2JNz8+1ii67XFr9GBYOT3U4rawTywY=;
        b=J0POBv3nvR4JCEt3dWwW9lopf2ULOYz7FjRG0+S0Jsxaw15FCywZyGQtSqraG4SrGr
         Rgem1wImL8ZorUj6EBpGChDdpoRsOrnFsujY1HqjSrR9nFvV0ZHl4ZndbLKq1W3kBKsy
         +W+EWA+QVH9U0Y/UQHmL8K9Onws3+qc50AJCsc464PL3GZ8IaZ9UUWeQzfdJBC1rPJOL
         LsOW/eRFQp2kuAsw4neDyRY012Nkcf04hHajtyP8SIwD/EFhdRs+uNfCguRDpcoBR5RN
         5jBzYu1G+wmMPBkThxvUMCfDSsZfn9oE19VCzGVLdl22x/YveJ1X9qpb+F1wzZqm53fB
         O9rQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1nG8zI+DNj/u6Eqq+LyG6bAw1FNinhBsZOOuL/jTdCq/qUZ7KCvRSrTHa6sVxUP+hlYMl4pNrot5WO4qkrb9SYrsJCBIiMOH1ARpU
X-Gm-Message-State: AOJu0YxRy0bzfpfUpqI1Na8NuPyJgt5N1iiYfveEU49DRfgyBR1GjzaC
	ipqKVkn2ItkwreVhRDs3POoqBd4Yn3z+NKzxjwGWRszwvFD//hk4R5wXpWCdwQ2ZRAsmU7cACWk
	cVkQRoguU9ZxiecwpW9jsxSUQGQzfLRVg9I5qc6gJBWpo8LfScIPpKPg=
X-Google-Smtp-Source: AGHT+IG6qs9rgARzSarWlcaMPYWZ3YJV7OX9nNFkXOeFYEXmze/cTFJ9hGj5VsiKlmY5N3o8Zj8ljAL/axoCSLhBUECpf0olI4lU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4c:b0:375:a202:2548 with SMTP id
 e9e14a558f8ab-375cd0996ecmr781655ab.1.1718190241963; Wed, 12 Jun 2024
 04:04:01 -0700 (PDT)
Date: Wed, 12 Jun 2024 04:04:01 -0700
In-Reply-To: <20240612104520.2217-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000770c3061aaf5774@google.com>
Subject: Re: [syzbot] [nilfs?] [mm?] KASAN: slab-use-after-free Read in lru_add_fn
From: syzbot <syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in lru_add_fn

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in mapping_unevictable include/linux/pagemap.h:259 [inline]
BUG: KASAN: slab-use-after-free in folio_evictable mm/internal.h:353 [inline]
BUG: KASAN: slab-use-after-free in lru_add_fn+0x192/0xd70 mm/swap.c:184
Read of size 8 at addr ffff888034b5be50 by task udevd/5343

CPU: 0 PID: 5343 Comm: udevd Not tainted 6.10.0-rc3-syzkaller-g2ef5971ff345-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 mapping_unevictable include/linux/pagemap.h:259 [inline]
 folio_evictable mm/internal.h:353 [inline]
 lru_add_fn+0x192/0xd70 mm/swap.c:184
 folio_batch_move_lru+0x243/0x400 mm/swap.c:220
 lru_add_drain_cpu+0x534/0x860 mm/swap.c:657
 lru_add_drain+0x109/0x440 mm/swap.c:757
 __folio_batch_release+0x68/0xb0 mm/swap.c:1081
 folio_batch_release include/linux/pagevec.h:101 [inline]
 shmem_undo_range+0x5a1/0x1160 mm/shmem.c:1005
 shmem_truncate_range mm/shmem.c:1114 [inline]
 shmem_evict_inode+0x3a3/0xbb0 mm/shmem.c:1242
 evict+0x2ed/0x6c0 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
 iput+0x5c/0x80 fs/inode.c:1757
 dentry_unlink_inode+0x295/0x480 fs/dcache.c:400
 __dentry_kill+0x1d0/0x600 fs/dcache.c:603
 dput.part.0+0x4b1/0x9b0 fs/dcache.c:845
 dput+0x1f/0x30 fs/dcache.c:835
 do_renameat2+0xc64/0xdc0 fs/namei.c:5046
 __do_sys_rename fs/namei.c:5091 [inline]
 __se_sys_rename fs/namei.c:5089 [inline]
 __x64_sys_rename+0x81/0xa0 fs/namei.c:5089
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6ec009a93b
Code: 48 8b 15 f0 64 15 00 83 c8 ff 64 83 3a 15 75 0e 48 8b 7c 24 08 e8 d5 d4 07 00 f7 d8 19 c0 48 83 c4 18 c3 b8 52 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 10 48 8b 15 be 64 15 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffd90985168 EFLAGS: 00000202 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6ec009a93b
RDX: 0000559846ecd125 RSI: 00007ffd90985188 RDI: 00007ffd90985588
RBP: 0000559d1f3d3820 R08: 0000000000000006 R09: 168ebfe9144866bd
R10: 00000000000001b6 R11: 0000000000000202 R12: 0000559d1f3d5c10
R13: 00007ffd90985188 R14: 00007ffd90985588 R15: 0000559d00997160
 </TASK>

Allocated by task 5370:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3941 [inline]
 slab_alloc_node mm/slub.c:4001 [inline]
 kmem_cache_alloc_lru_noprof+0x121/0x2f0 mm/slub.c:4020
 nilfs_alloc_inode+0x26/0x150 fs/nilfs2/super.c:154
 alloc_inode+0x5d/0x230 fs/inode.c:261
 iget5_locked fs/inode.c:1235 [inline]
 iget5_locked+0x1c9/0x2c0 fs/inode.c:1228
 nilfs_iget_locked+0xa1/0xe0 fs/nilfs2/inode.c:606
 nilfs_ifile_read+0x2f/0x1e0 fs/nilfs2/ifile.c:192
 nilfs_attach_checkpoint+0x12d/0x1d0 fs/nilfs2/super.c:557
 nilfs_fill_super fs/nilfs2/super.c:1067 [inline]
 nilfs_get_tree+0x951/0x1000 fs/nilfs2/super.c:1211
 vfs_get_tree+0x8f/0x380 fs/super.c:1780
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 0:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4437 [inline]
 kmem_cache_free+0x12f/0x3a0 mm/slub.c:4512
 i_callback+0x43/0x70 fs/inode.c:250
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0x828/0x16b0 kernel/rcu/tree.c:2809
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
 __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:3072
 destroy_inode+0x12c/0x1b0 fs/inode.c:316
 iput_final fs/inode.c:1741 [inline]
 iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
 iput+0x5c/0x80 fs/inode.c:1757
 nilfs_put_root+0xae/0xe0 fs/nilfs2/the_nilfs.c:925
 nilfs_segctor_destroy fs/nilfs2/segment.c:2788 [inline]
 nilfs_detach_log_writer+0x5ef/0xaa0 fs/nilfs2/segment.c:2850
 nilfs_put_super+0x43/0x1b0 fs/nilfs2/super.c:498
 generic_shutdown_super+0x159/0x3d0 fs/super.c:642
 kill_block_super+0x3b/0x90 fs/super.c:1676
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
 deactivate_super+0xde/0x100 fs/super.c:506
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888034b5b9a8
 which belongs to the cache nilfs2_inode_cache of size 1512
The buggy address is located 1192 bytes inside of
 freed 1512-byte region [ffff888034b5b9a8, ffff888034b5bf90)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x34b58
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888026293801
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888016ab97c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080130013 00000001ffffefff ffff888026293801
head: 00fff00000000040 ffff888016ab97c0 dead000000000122 0000000000000000
head: 0000000000000000 0000000080130013 00000001ffffefff ffff888026293801
head: 00fff00000000003 ffffea0000d2d601 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5334, tgid 5334 (syz-executor), ts 82510212172, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x136a/0x2e50 mm/page_alloc.c:3420
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4678
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x56/0x110 mm/slub.c:2265
 allocate_slab mm/slub.c:2428 [inline]
 new_slab+0x84/0x260 mm/slub.c:2481
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3667
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3989 [inline]
 kmem_cache_alloc_lru_noprof+0x2a0/0x2f0 mm/slub.c:4020
 nilfs_alloc_inode+0x26/0x150 fs/nilfs2/super.c:154
 alloc_inode+0x5d/0x230 fs/inode.c:261
 iget5_locked fs/inode.c:1235 [inline]
 iget5_locked+0x1c9/0x2c0 fs/inode.c:1228
 nilfs_iget_locked fs/nilfs2/inode.c:606 [inline]
 nilfs_iget+0xb7/0x850 fs/nilfs2/inode.c:615
 nilfs_lookup fs/nilfs2/namei.c:63 [inline]
 nilfs_lookup+0x105/0x130 fs/nilfs2/namei.c:54
 __lookup_slow+0x24f/0x460 fs/namei.c:1692
 lookup_slow fs/namei.c:1709 [inline]
 walk_component+0x350/0x5b0 fs/namei.c:2004
 lookup_last fs/namei.c:2469 [inline]
 path_lookupat+0x17f/0x770 fs/namei.c:2493
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888034b5bd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888034b5bd80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888034b5be00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff888034b5be80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888034b5bf00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         2ef5971f Merge tag 'vfs-6.10-rc4.fixes' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12110c2e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=d79afb004be235636ee8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15cc9936980000


