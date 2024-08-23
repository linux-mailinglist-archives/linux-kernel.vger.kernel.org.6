Return-Path: <linux-kernel+bounces-299182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4B295D13F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8601C21A83
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5227188939;
	Fri, 23 Aug 2024 15:21:24 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626AD1885BE
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724426484; cv=none; b=oyiCAVv8Hhywd9DO64T/o6jzLexZUg+HZSdugjGHWDCpzVXwPQ/T1FJifbr0Hhu2UDkZeUWDcTG0jxsbVfHLzO2NOTYgLp15ZSbqVUqhduINS3/53DeM8B7wFUP3rXNL4kG7e3PUnPs7dXeXuCTtO6bssMYINzKyI4PTuh1RK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724426484; c=relaxed/simple;
	bh=nZ9ZDobSmNTB1hDIzUysiWicZD7biWhdZG7kwMnEW1c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nW/YXlQwUtR6TxmfQuDKkr1OiUVX1/mXbV6tNYAJ3lltUINqLAlF/9uMJwK0GGdFCcsTAuAZ6zTLNHywc5WE3vwThRzE0RJCzRvmBcKyoQ3X77kr7H5FjKNOcaCudRNk0cTVljzzXbA7WjYo9TrhgI6hpR8+0dpAGa3uQLHga/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d2dbd9bebso28436155ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724426481; x=1725031281;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZehvQ8KJvOcMpn0wWBTyT/0h4IRBtT0drqZCpVwhsH4=;
        b=qmej7qKjSSmOlpMyGuxmyzpGjbDOL29u7e2u+3p5Yk3IimVTdsWSIzQFjxdYRs6E9e
         Dkvrgxjepu4swW0+uEjtNVIhpBHz4mX83GZ3sHC8HP3FxO8zG/SUyc5WWhAK/7GPYJo7
         PeqFk5FG3FaCZJnlaQ8srp4KOdAYbUemFyWYZsGgDOqEYw/Wsrl2xqEuIhcOZczRj15A
         9/LcdLiQ0zdtUKdZs37HfauuN4wdHmVV5fYNQcaLJMJjjirxTRiFTGQxd8bM2hti2+OP
         3cCI3mvapFM1UcxQig5HqxJoHfAFfqsRANBJwIe2EqA22IbZjvhLZ/rE1Pbne33yR4pL
         nIiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu+shxYbUmITxMFdVfSr2D0F5FwU+eq8F9piwKnYFNHPOnw5E1NBT8q30EpYzlft13L5qSeH+wYXxvcqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLglm2dHF2L6jsG3+J1ciPD7fRLsTPIbLKL6GpUuJsjTRC64ox
	6l9LFp7mXy8oZm8qi/CYLwnRyHqWK32dBRyWA24xA4LR9AGJGNSyGtxwTejVGowwDmNLMh7gfCg
	HYf8PqrizydJscCAkl/0Kw3KwF6p4vIuzjO2WiQUzf2CGxeRFJl+x/g8=
X-Google-Smtp-Source: AGHT+IHH+pZ2L1rERAuZehH6vOLBCf5OUmavB2hLuSzjxqsYCCISGBThJaakXOabFVLPETFS6JDRwd14ijKj6diSppvaA/wrFpzP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1485:b0:4b9:ad20:51ff with SMTP id
 8926c6da1cb9f-4ce8284ec5bmr76430173.1.1724426481453; Fri, 23 Aug 2024
 08:21:21 -0700 (PDT)
Date: Fri, 23 Aug 2024 08:21:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de603606205b538b@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in isolate_migratepages_block
From: syzbot <syzbot+fe399f27b2a7a1482ce0@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aa0743a22936 Merge tag 'net-6.11-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1071a233980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=fe399f27b2a7a1482ce0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/94b014c0070e/disk-aa0743a2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7fc82827c24d/vmlinux-aa0743a2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dab734213137/bzImage-aa0743a2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe399f27b2a7a1482ce0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in mapping_inaccessible include/linux/pagemap.h:326 [inline]
BUG: KASAN: slab-use-after-free in isolate_migratepages_block+0x2228/0x64f0 mm/compaction.c:1210
Read of size 8 at addr ffff88801fff3f90 by task syz.0.8507/23585

CPU: 1 UID: 0 PID: 23585 Comm: syz.0.8507 Not tainted 6.11.0-rc4-syzkaller-00135-gaa0743a22936 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 mapping_inaccessible include/linux/pagemap.h:326 [inline]
 isolate_migratepages_block+0x2228/0x64f0 mm/compaction.c:1210
 isolate_migratepages mm/compaction.c:2194 [inline]
 compact_zone+0x32e6/0x4af0 mm/compaction.c:2641
 compact_node mm/compaction.c:2935 [inline]
 compact_nodes mm/compaction.c:2957 [inline]
 sysctl_compaction_handler+0x496/0x990 mm/compaction.c:3008
 proc_sys_call_handler+0x551/0x8b0 fs/proc/proc_sysctl.c:590
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_pwrite64 fs/read_write.c:705 [inline]
 __do_sys_pwrite64 fs/read_write.c:715 [inline]
 __se_sys_pwrite64 fs/read_write.c:712 [inline]
 __x64_sys_pwrite64+0x1aa/0x230 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f54d6779e79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f54d763b038 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007f54d6915f80 RCX: 00007f54d6779e79
RDX: 0000000000000001 RSI: 0000000020000440 RDI: 0000000000000004
RBP: 00007f54d67e7916 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f54d6915f80 R15: 00007f54d6a3fa38
 </TASK>

Allocated by task 27:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 kmem_cache_alloc_lru_noprof+0x139/0x2b0 mm/slub.c:4056
 shmem_alloc_inode+0x28/0x40 mm/shmem.c:4622
 alloc_inode fs/inode.c:263 [inline]
 new_inode_pseudo fs/inode.c:1073 [inline]
 new_inode+0x6e/0x310 fs/inode.c:1092
 __shmem_get_inode mm/shmem.c:2658 [inline]
 shmem_get_inode+0x34a/0xd50 mm/shmem.c:2729
 shmem_mknod+0x5f/0x1e0 mm/shmem.c:3426
 vfs_mknod+0x36d/0x3b0 fs/namei.c:4088
 handle_create drivers/base/devtmpfs.c:219 [inline]
 handle drivers/base/devtmpfs.c:384 [inline]
 devtmpfs_work_loop+0x963/0x1040 drivers/base/devtmpfs.c:399
 devtmpfsd+0x4c/0x50 drivers/base/devtmpfs.c:441
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 24:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4548
 rcu_do_batch kernel/rcu/tree.c:2569 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2843
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:928
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3106 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3210
 destroy_inode fs/inode.c:318 [inline]
 evict+0x88b/0x950 fs/inode.c:729
 do_unlinkat+0x512/0x830 fs/namei.c:4493
 __do_sys_unlink fs/namei.c:4534 [inline]
 __se_sys_unlink fs/namei.c:4532 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:4532
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801fff3ac8
 which belongs to the cache shmem_inode_cache of size 1544
The buggy address is located 1224 bytes inside of
 freed 1544-byte region [ffff88801fff3ac8, ffff88801fff40d0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88801fff7590 pfn:0x1fff0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000240 ffff8880172e7140 ffffea0000b81810 ffffea0001dd6610
raw: ffff88801fff7590 0000000000130001 00000001fdffffff 0000000000000000
head: 00fff00000000240 ffff8880172e7140 ffffea0000b81810 ffffea0001dd6610
head: ffff88801fff7590 0000000000130001 00000001fdffffff 0000000000000000
head: 00fff00000000003 ffffea00007ffc01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 27, tgid 27 (kdevtmpfs), ts 6756474356, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3439
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4695
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2321
 allocate_slab+0x5a/0x2f0 mm/slub.c:2484
 new_slab mm/slub.c:2537 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
 __slab_alloc+0x58/0xa0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 kmem_cache_alloc_lru_noprof+0x1c5/0x2b0 mm/slub.c:4056
 shmem_alloc_inode+0x28/0x40 mm/shmem.c:4622
 alloc_inode fs/inode.c:263 [inline]
 new_inode_pseudo fs/inode.c:1073 [inline]
 new_inode+0x6e/0x310 fs/inode.c:1092
 __shmem_get_inode mm/shmem.c:2658 [inline]
 shmem_get_inode+0x34a/0xd50 mm/shmem.c:2729
 shmem_mknod+0x5f/0x1e0 mm/shmem.c:3426
 vfs_mknod+0x36d/0x3b0 fs/namei.c:4088
 handle_create drivers/base/devtmpfs.c:219 [inline]
 handle drivers/base/devtmpfs.c:384 [inline]
 devtmpfs_work_loop+0x963/0x1040 drivers/base/devtmpfs.c:399
 devtmpfsd+0x4c/0x50 drivers/base/devtmpfs.c:441
 kthread+0x2f0/0x390 kernel/kthread.c:389
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801fff3e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801fff3f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801fff3f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88801fff4000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801fff4080: fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc
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

