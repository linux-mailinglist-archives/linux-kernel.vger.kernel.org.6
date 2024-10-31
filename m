Return-Path: <linux-kernel+bounces-389770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7309B7116
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B62A282EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C304417993;
	Thu, 31 Oct 2024 00:21:31 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9242CAB
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 00:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730334091; cv=none; b=ViaIuwZyD4elR+V727PxmRZ+CAJKUD31738qYLtcHDfH5TwFz8DhpFhMyuJevKhfI2xVpahjU2FklcWCbRHMzDA1XhSzIxx9KmJ9Sg8ijAC8e6vNOSWY0Iahg9NDINjxZCssvi0EXz96vDWG28+o/aIKBgfsXz0nhRR8x5+wRP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730334091; c=relaxed/simple;
	bh=3nRoMl0hMsNPPcXzZJ2+e0SC9n9t4R5VgKm2uwzWYvM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NluK9RYoYhU7pDPU1tg4qGV/tqdCQdEqjYPKT03eAFG3rpYBO/8w6pWzOJMxQQ947qY/+HUTjoEWjCBbNjWD3VuSF7FSKHNAZJps6w88BF2CfeTdm5UbbCapuekiJT5jKCeiANiiQFgZQvc0b9X7NEIXjNzSHyrJgvQ6gTats4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c5a6c5e1so6594805ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730334086; x=1730938886;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fE898E/To8pk3aXSTgmp6fzmkiTgdSdkSwNMV0+CEj4=;
        b=gfFxLpruc0G6ChU+myigdyIvqrPPKS1qATCya9pXfO2npEAXyrlYiKBW/ttRRMq/iA
         BdgPFWz0WA3ZBOwqrue3B66rvVzxWTuxxJQLDaNX6XK7FqfHogA6J0M8oguXU11gR66d
         R7kWDgmn/IYtJCm1OkHYzpA4UbIhSviVZkCDRtmg6nea+5bdWEjiA3wXuf6zbALb0OeT
         M74oeB9QnrEAJFim8ny60rw0ApttNuA2xF4q/SF01ZtB6suTi2G+iIXoU5ShzAu0Y04m
         RcD0DoiQ8YWF92mG2+NS1+G89tmLd5BdbxcmUZWbqP5tqYw7DOyNVX1mINSgKWRtwIKK
         0pGA==
X-Forwarded-Encrypted: i=1; AJvYcCX58JpXe+4Mhw/fbR5iFDAaveuz/9IpIgQx+7jI1EZ2EEkU6167h7fYbRsUymmfE89M5SZfRGYvn5783QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDAAd58q/k7LV0ZcZK8DdGhFHV+ale/MaMegiIsJ1mBrAMXYFa
	bTJYP7AZAioyl+QEr2aNdHD0HJY1bLakQqNe68g0gQLVOspnl+b04HpNLNIvJhDoD2Cbu7GRwpt
	Xt4yUccFwKITpBKMPLOaISl/l7EO7LQ2ed7TylvM3czh7TOhDmTuH70o=
X-Google-Smtp-Source: AGHT+IHhS8ug86wOslcoWoII+74LP2N9crnUXVfxDIPjx8rwz7JsIoDkTiXI7Z8xUfS/LQ7XsKkM1zIVN88bACm0ORY9gfMNTJfS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170b:b0:3a4:e9c1:8f75 with SMTP id
 e9e14a558f8ab-3a5e262ec8cmr52616525ab.24.1730334086592; Wed, 30 Oct 2024
 17:21:26 -0700 (PDT)
Date: Wed, 30 Oct 2024 17:21:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6722cd86.050a0220.35b515.00d2.GAE@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in move_to_new_folio (3)
From: syzbot <syzbot+0133df8780a76867f88a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f0c640580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=0133df8780a76867f88a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c35ff46634e3/disk-c2ee9f59.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/afb5a0aa9f0c/vmlinux-c2ee9f59.xz
kernel image: https://storage.googleapis.com/syzbot-assets/83d5809de2f4/bzImage-c2ee9f59.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0133df8780a76867f88a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in mapping_inaccessible include/linux/pagemap.h:335 [inline]
BUG: KASAN: slab-use-after-free in move_to_new_folio+0x231/0x1330 mm/migrate.c:1048
Read of size 8 at addr ffff888024d50b50 by task syz.1.4981/29836

CPU: 1 UID: 0 PID: 29836 Comm: syz.1.4981 Not tainted 6.12.0-rc4-syzkaller-00047-gc2ee9f594da8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 mapping_inaccessible include/linux/pagemap.h:335 [inline]
 move_to_new_folio+0x231/0x1330 mm/migrate.c:1048
 migrate_folio_move mm/migrate.c:1366 [inline]
 migrate_pages_batch+0x266b/0x36d0 mm/migrate.c:1897
 migrate_pages_sync mm/migrate.c:1963 [inline]
 migrate_pages+0x2062/0x3560 mm/migrate.c:2072
 compact_zone+0x3404/0x4af0 mm/compaction.c:2641
 compact_node mm/compaction.c:2910 [inline]
 compact_nodes mm/compaction.c:2932 [inline]
 sysctl_compaction_handler+0x496/0x990 mm/compaction.c:2983
 proc_sys_call_handler+0x550/0x8b0 fs/proc/proc_sysctl.c:595
 iter_file_splice_write+0xbfa/0x1510 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x11b/0x220 fs/splice.c:1164
 splice_direct_to_actor+0x586/0xc80 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x289/0x3e0 fs/splice.c:1233
 do_sendfile+0x561/0xe10 fs/read_write.c:1388
 __do_sys_sendfile64 fs/read_write.c:1449 [inline]
 __se_sys_sendfile64+0x100/0x1e0 fs/read_write.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fae28b7dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fae29993038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fae28d35f80 RCX: 00007fae28b7dff9
RDX: 00000000200000c0 RSI: 0000000000000004 RDI: 0000000000000006
RBP: 00007fae28bf0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fae28d35f80 R15: 00007fae28e5fa28
 </TASK>

Allocated by task 27:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_lru_noprof+0x139/0x2b0 mm/slub.c:4153
 shmem_alloc_inode+0x28/0x40 mm/shmem.c:4764
 alloc_inode+0x65/0x1a0 fs/inode.c:265
 new_inode_pseudo fs/inode.c:1104 [inline]
 new_inode+0x22/0x1d0 fs/inode.c:1123
 __shmem_get_inode mm/shmem.c:2801 [inline]
 shmem_get_inode+0x34a/0xd70 mm/shmem.c:2872
 shmem_mknod+0x5f/0x1e0 mm/shmem.c:3568
 vfs_mknod+0x36d/0x3b0 fs/namei.c:4135
 handle_create drivers/base/devtmpfs.c:219 [inline]
 handle drivers/base/devtmpfs.c:384 [inline]
 devtmpfs_work_loop+0x963/0x1040 drivers/base/devtmpfs.c:399
 devtmpfsd+0x4c/0x50 drivers/base/devtmpfs.c:441
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 28128:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kmem_cache_free+0x1a2/0x420 mm/slub.c:4681
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3086 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3190
 destroy_inode fs/inode.c:320 [inline]
 evict+0x83c/0x9b0 fs/inode.c:756
 do_unlinkat+0x512/0x830 fs/namei.c:4540
 __do_sys_unlink fs/namei.c:4581 [inline]
 __se_sys_unlink fs/namei.c:4579 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:4579
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888024d50688
 which belongs to the cache shmem_inode_cache of size 1544
The buggy address is located 1224 bytes inside of
 freed 1544-byte region [ffff888024d50688, ffff888024d50c90)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x24d50
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801c6e5140 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000130013 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801c6e5140 dead000000000122 0000000000000000
head: 0000000000000000 0000000000130013 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea0000935401 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 27, tgid 27 (kdevtmpfs), ts 8771129661, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 kmem_cache_alloc_lru_noprof+0x1c5/0x2b0 mm/slub.c:4153
 shmem_alloc_inode+0x28/0x40 mm/shmem.c:4764
 alloc_inode+0x65/0x1a0 fs/inode.c:265
 new_inode_pseudo fs/inode.c:1104 [inline]
 new_inode+0x22/0x1d0 fs/inode.c:1123
 __shmem_get_inode mm/shmem.c:2801 [inline]
 shmem_get_inode+0x34a/0xd70 mm/shmem.c:2872
 shmem_mknod+0x5f/0x1e0 mm/shmem.c:3568
 vfs_mknod+0x36d/0x3b0 fs/namei.c:4135
 handle_create drivers/base/devtmpfs.c:219 [inline]
 handle drivers/base/devtmpfs.c:384 [inline]
 devtmpfs_work_loop+0x963/0x1040 drivers/base/devtmpfs.c:399
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888024d50a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888024d50a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888024d50b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff888024d50b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888024d50c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

