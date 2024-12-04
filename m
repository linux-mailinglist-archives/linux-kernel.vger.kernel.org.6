Return-Path: <linux-kernel+bounces-430929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E43889E3755
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3FF82810D4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD091ADFF8;
	Wed,  4 Dec 2024 10:17:29 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265E92500D2
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733307449; cv=none; b=lRL5LkXJrBEM8epSrGmgkj4x3kyNF8tyYQ9yvLWRp3okuDbq51nHq+PlWHtnuDTCZbHlP4cLKfJd1w/w5xYQP+iae13n9pZr+luavFKbgVjfN6XknVo567QtqrcB8RT2T71clFc2Xxn/I9Y5xGmmOWlYi8i68QOUEDgPe2yRICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733307449; c=relaxed/simple;
	bh=PCwxt3pN+DdL7+ugqD3CX+jtD3kzHj7A+pO9ytXPLII=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Rv8imxZ3VdmFh+SCibUk0dJpRcf884BvSdSuif4PXt1ZJlBQmOLqk+Zr36DP+SNc1r9YkcmFYlb1RkrWTxlaNnJ0CyCL0IaPqXOQ3NAHllRzto4wTsPV6GQNlmejUYT0fgmBLGxMk2iFXd72HelD5k9cvmE2oEWePRgd3ZO9a+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a743d76ed9so6979485ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:17:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733307446; x=1733912246;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iw/VcAAZWEK1jQy36Tn6GDQ8Hn65r2cAT438ozyLJZg=;
        b=OKrYVGyzkqzCoLk7L5CmcYtmL9w9YxsydZce5TUw4T+tzE+QkI1pbQ/aT0YnunwML5
         KceNHmx/ne5oVyrZtmuLCxYWOFW2EtcIeDfbdn+eSwwC9Q8bUDG4Pk0eA3IdNCrKt4Rr
         kamO0fAT4daQ/kCkgSJNEa3uNY+Xk4QUGtBODysrtL6J88EfCeFxSEV0Fa0A1tnw0lEA
         bDC5h0fzbM6XrvkyMrh/QHK6LuswDDp1CKg8wQf9+hkGNOftwV3cOLei//nSph951Nv8
         HRId1fxHNnSW8ye+eKKc6ktWgs+Y9odFeAlyGypt40Twf9/yDzuAKelczJkIXIjqFGzv
         57Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWVCutNscc0PASEh4fY9h5C8ouV1olh7dza7mbM3BpGapvdwFO+2Jad3KVi3Atbio15zuRvNBJqx3qqaOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoj/5V/B8yCoSKNPehlRZa2reIFRQbpRKntAOqGpdgNxc+4soO
	zLTtkcLWV0MChoIFs22pui4A/fYAtYBq5Ho6VyyOBsf1glJAU9wXlDXlnokZUrxVX0xne1N8dC1
	N6aHGFFSfOMJ79KvngTZON+7dXQranCs1IJRoY7axsAB4qcoTEmrlwsU=
X-Google-Smtp-Source: AGHT+IFtk7ENyw7UvH21aYgVXn4nX9q4NjNzOY/EAWw9bMSqFp1i1DEGxnVL4cLSbhSNMqN40/G6fCPuQEPiTMz7j4On/UHxNMpr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ce:b0:3a7:cff5:16d6 with SMTP id
 e9e14a558f8ab-3a7f9c03859mr54650895ab.3.1733307446206; Wed, 04 Dec 2024
 02:17:26 -0800 (PST)
Date: Wed, 04 Dec 2024 02:17:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67502c36.050a0220.17bd51.0062.GAE@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in lru_add
From: syzbot <syzbot+2f574f2471415b81417e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ba9f676d0a2 Merge tag 'drm-next-2024-11-29' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d56d30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92c00fea95836451
dashboard link: https://syzkaller.appspot.com/bug?extid=2f574f2471415b81417e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-2ba9f676.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/67b607be891b/vmlinux-2ba9f676.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b142ef38c0ac/bzImage-2ba9f676.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f574f2471415b81417e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in mapping_unevictable include/linux/pagemap.h:269 [inline]
BUG: KASAN: slab-use-after-free in folio_evictable mm/internal.h:435 [inline]
BUG: KASAN: slab-use-after-free in lru_add+0x192/0xd70 mm/swap.c:136
Read of size 8 at addr ffff888024b24618 by task syz.7.1236/11255

CPU: 0 UID: 0 PID: 11255 Comm: syz.7.1236 Not tainted 6.12.0-syzkaller-11677-g2ba9f676d0a2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 mapping_unevictable include/linux/pagemap.h:269 [inline]
 folio_evictable mm/internal.h:435 [inline]
 lru_add+0x192/0xd70 mm/swap.c:136
 folio_batch_move_lru+0x113/0x3b0 mm/swap.c:168
 lru_add_drain_cpu+0x521/0x810 mm/swap.c:616
 lru_add_drain+0x109/0x440 mm/swap.c:698
 vms_clear_ptes+0x1f8/0x780 mm/vma.c:1133
 vms_clean_up_area mm/vma.c:1155 [inline]
 __mmap_prepare mm/vma.c:2278 [inline]
 __mmap_region+0x4c9/0x2670 mm/vma.c:2443
 mmap_region+0x127/0x320 mm/mmap.c:1347
 do_mmap+0xc00/0xfc0 mm/mmap.c:496
 vm_mmap_pgoff+0x1ba/0x360 mm/util.c:580
 ksys_mmap_pgoff+0x1c8/0x5c0 mm/mmap.c:542
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f26a0980849
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f26a1845058 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f26a0b45fa0 RCX: 00007f26a0980849
RDX: 0000000000000002 RSI: 0000000000800000 RDI: 0000000020800000
RBP: 00007f26a09f3986 R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000000042032 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f26a0b45fa0 R15: 00007ffd234568e8
 </TASK>

Allocated by task 37:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_lru_noprof+0x226/0x3d0 mm/slub.c:4172
 shmem_alloc_inode+0x25/0x50 mm/shmem.c:4980
 alloc_inode+0x5d/0x230 fs/inode.c:336
 new_inode_pseudo fs/inode.c:1174 [inline]
 new_inode+0x22/0x210 fs/inode.c:1193
 __shmem_get_inode mm/shmem.c:2874 [inline]
 shmem_get_inode+0x194/0xf00 mm/shmem.c:2948
 shmem_mknod+0x1a8/0x450 mm/shmem.c:3670
 vfs_mknod+0x5d7/0x8e0 fs/namei.c:4189
 handle_create drivers/base/devtmpfs.c:219 [inline]
 handle drivers/base/devtmpfs.c:384 [inline]
 devtmpfs_work_loop+0x1a8/0x7d0 drivers/base/devtmpfs.c:399
 devtmpfsd+0x4c/0x50 drivers/base/devtmpfs.c:441
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 29:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kmem_cache_free+0x152/0x4c0 mm/slub.c:4700
 i_callback+0x43/0x70 fs/inode.c:325
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0x79d/0x14d0 kernel/rcu/tree.c:2823
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 run_ksoftirqd kernel/softirq.c:943 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:935
 smpboot_thread_fn+0x661/0xa30 kernel/smpboot.c:164
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:544
 __call_rcu_common.constprop.0+0x99/0x7a0 kernel/rcu/tree.c:3086
 destroy_inode+0x12c/0x1b0 fs/inode.c:391
 evict+0x5ed/0x960 fs/inode.c:827
 iput_final fs/inode.c:1946 [inline]
 iput fs/inode.c:1972 [inline]
 iput+0x52a/0x890 fs/inode.c:1958
 do_unlinkat+0x5c3/0x760 fs/namei.c:4594
 __do_sys_unlink fs/namei.c:4635 [inline]
 __se_sys_unlink fs/namei.c:4633 [inline]
 __x64_sys_unlink+0xc5/0x110 fs/namei.c:4633
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888024b24150
 which belongs to the cache shmem_inode_cache of size 1544
The buggy address is located 1224 bytes inside of
 freed 1544-byte region [ffff888024b24150, ffff888024b24758)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x24b20
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ca8e780 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000130013 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801ca8e780 dead000000000122 0000000000000000
head: 0000000000000000 0000000000130013 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea000092c801 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 37, tgid 37 (kdevtmpfs), ts 6023947933, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x223/0x25b0 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2408 [inline]
 allocate_slab mm/slub.c:2574 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2627
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3815
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 kmem_cache_alloc_lru_noprof+0xff/0x3d0 mm/slub.c:4172
 shmem_alloc_inode+0x25/0x50 mm/shmem.c:4980
 alloc_inode+0x5d/0x230 fs/inode.c:336
 new_inode_pseudo fs/inode.c:1174 [inline]
 new_inode+0x22/0x210 fs/inode.c:1193
 __shmem_get_inode mm/shmem.c:2874 [inline]
 shmem_get_inode+0x194/0xf00 mm/shmem.c:2948
 shmem_mknod+0x1a8/0x450 mm/shmem.c:3670
 vfs_mknod+0x5d7/0x8e0 fs/namei.c:4189
 handle_create drivers/base/devtmpfs.c:219 [inline]
 handle drivers/base/devtmpfs.c:384 [inline]
 devtmpfs_work_loop+0x1a8/0x7d0 drivers/base/devtmpfs.c:399
 devtmpfsd+0x4c/0x50 drivers/base/devtmpfs.c:441
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888024b24500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888024b24580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888024b24600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888024b24680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888024b24700: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
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

