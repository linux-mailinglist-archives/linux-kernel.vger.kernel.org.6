Return-Path: <linux-kernel+bounces-426557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5069DF4EF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 08:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B49162C9B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 07:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE5E54740;
	Sun,  1 Dec 2024 07:37:28 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED6B33F6
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733038647; cv=none; b=ILmOoaszkbvWClwHHHzNYV1T78VCAV/mqlIP6xs89ZHqQVBamnPvoftiY6DeVwYbGVAF4Vi1oJrXJRUM341zurjzWk9I7LgXvTcrRYjjjSpJiTRnkmlPh7nVdjupSbgXL7pMES+jXeVsI1tzmxDsEK64fEf8yOlq48I3zbTG93U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733038647; c=relaxed/simple;
	bh=JZ58AWpjRA4rzBtP7+wOf4OVfuIUU7mJN02rHLLvmy4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XFBGqO/tzHaHx83n90VlNxlO6t/ix27F4F5nU9rhMrC9McJy9D0Dx80rorgmhcT8bOprsSABNLDHitNI1MYb6ok6PmUz+k2h04NhawScuP/3IBBzctXAVhQCRM4dY3DFqnGpv/nwn2i5reIUDhqTLGUOvTf3669Ag8AIN86BCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8419aa46a87so311376339f.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 23:37:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733038645; x=1733643445;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eOdvTkw1xe00oxjEaZU2uM2/VpeN3spJBuPCHGSdB14=;
        b=L+q9609ZnGEBnOzkx6muI0Q3SBhtoPAI31yWFK3tGprmFgcVkb+JvQvG5nwyofUu+H
         JX3VdQN9Rk1DxC9bqAc3lLu9BBOl9XQvDWv+WgaaZsJ5n2tf5LmR1dI+1a7YZfdPuTC+
         qUX0XySeHl9TCaj+U6fGFWHOtYlAei2kuba0D8ycshkT9CyzlB+Bn+7bp8kXdxagSoHQ
         v/zbIvsOIR4OM4thtAyWh6KEs5iTwEDaujd7PQMcDKwyzLJcc3peAOiOmDrwW16aclfe
         G6OabOVzXa2ImMyBF4fnCAY9PB9zuE4/FQ5VGH5w5p1z3Pa1gBxJDunpazvHpeDnK7u/
         tgvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVle73zfHjstLY4/AeLSFRP59FFHxCDDEWoprHzuIrrZkEeCQqfx8EKeHUxRYk3KOy6KU5eQGxmrUBuFE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/6ePbyLwltCvvTUIS/dAeRAbIvyU3ACqXTJEd/dgR8yTmCe/Y
	T+fHfe/1BeILVv7S9HigRWuGvn7YuehQ7K7t/6sy25BVxL84OkfM2LHBf5xnYQOvRLGOX7yZ8Qj
	NivasDX+CNe0FC9012y0SQaBQGH/XBmNLEkoVrnhJ5lgj7RwGWF9GABw=
X-Google-Smtp-Source: AGHT+IGIt54bVqGCyAFye/ilOMwv1ZYyuijirqoHQsplr+mlX4XsPu2Cwpu2LXCaHVlC0t5W30PoQfLLPyDb9qA2Y/F+2UGWwtZ5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1569:b0:3a7:6636:eb48 with SMTP id
 e9e14a558f8ab-3a7c55d4c48mr199467255ab.18.1733038645191; Sat, 30 Nov 2024
 23:37:25 -0800 (PST)
Date: Sat, 30 Nov 2024 23:37:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674c1235.050a0220.ad585.0032.GAE@google.com>
Subject: [syzbot] [erofs?] KASAN: slab-use-after-free Read in z_erofs_decompress_queue
From: syzbot <syzbot+7ff87b095e7ca0c5ac39@syzkaller.appspotmail.com>
To: chao@kernel.org, dhavale@google.com, huyue2@coolpad.com, 
	jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ba9f676d0a2 Merge tag 'drm-next-2024-11-29' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a9ff5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7903df3280dd39ea
dashboard link: https://syzkaller.appspot.com/bug?extid=7ff87b095e7ca0c5ac39
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e84f83a0add4/disk-2ba9f676.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7468420d8610/vmlinux-2ba9f676.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fd3f74d41f94/bzImage-2ba9f676.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7ff87b095e7ca0c5ac39@syzkaller.appspotmail.com

erofs (device loop7): failed to decompress -41 in[4096, 0] out[9000]
==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: slab-use-after-free in queued_spin_trylock include/asm-generic/qspinlock.h:92 [inline]
BUG: KASAN: slab-use-after-free in do_raw_spin_trylock+0x72/0x1f0 kernel/locking/spinlock_debug.c:123
Read of size 4 at addr ffff888057feb0b0 by task kworker/u9:4/5836

CPU: 0 UID: 0 PID: 5836 Comm: kworker/u9:4 Not tainted 6.12.0-syzkaller-11677-g2ba9f676d0a2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: erofs_worker z_erofs_decompressqueue_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 queued_spin_trylock include/asm-generic/qspinlock.h:92 [inline]
 do_raw_spin_trylock+0x72/0x1f0 kernel/locking/spinlock_debug.c:123
 __raw_spin_trylock include/linux/spinlock_api_smp.h:89 [inline]
 _raw_spin_trylock+0x20/0x80 kernel/locking/spinlock.c:138
 spin_trylock include/linux/spinlock.h:361 [inline]
 z_erofs_put_pcluster fs/erofs/zdata.c:959 [inline]
 z_erofs_decompress_pcluster fs/erofs/zdata.c:1403 [inline]
 z_erofs_decompress_queue+0x3798/0x3ef0 fs/erofs/zdata.c:1425
 z_erofs_decompressqueue_work+0x99/0xe0 fs/erofs/zdata.c:1437
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa68/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 9865:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4314
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 erofs_init_fs_context+0x55/0x2c0 fs/erofs/super.c:790
 alloc_fs_context+0x68c/0x800 fs/fs_context.c:318
 do_new_mount+0x160/0xb40 fs/namespace.c:3486
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 8390:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kfree+0x196/0x430 mm/slub.c:4746
 erofs_kill_sb+0x197/0x1c0 fs/erofs/super.c:824
 deactivate_locked_super+0xc6/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x251/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888057feb000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 176 bytes inside of
 freed 1024-byte region [ffff888057feb000, ffff888057feb400)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x57fe8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac41dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801ac41dc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea00015ffa01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5838, tgid 5838 (syz-executor), ts 79303051865, free_ts 23181394506
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2408
 allocate_slab+0x5a/0x2f0 mm/slub.c:2574
 new_slab mm/slub.c:2627 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3815
 __slab_alloc+0x58/0xa0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 __do_kmalloc_node mm/slub.c:4282 [inline]
 __kmalloc_node_track_caller_noprof+0x2e9/0x4c0 mm/slub.c:4302
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:609
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1323 [inline]
 nlmsg_new include/net/netlink.h:1018 [inline]
 inet6_rt_notify+0xba/0x240 net/ipv6/route.c:6195
 fib6_add_rt2node net/ipv6/ip6_fib.c:1259 [inline]
 fib6_add+0x1e33/0x4420 net/ipv6/ip6_fib.c:1488
 __ip6_ins_rt net/ipv6/route.c:1317 [inline]
 ip6_route_add+0x8b/0x160 net/ipv6/route.c:3857
 addrconf_prefix_route net/ipv6/addrconf.c:2486 [inline]
 addrconf_add_linklocal+0x61a/0xa30 net/ipv6/addrconf.c:3338
 addrconf_addr_gen+0x510/0xbb0
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xdef/0x1130 mm/page_alloc.c:2657
 free_contig_range+0x152/0x550 mm/page_alloc.c:6630
 destroy_args+0x92/0x910 mm/debug_vm_pgtable.c:1017
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1397
 do_one_initcall+0x24a/0x870 init/main.c:1266
 do_initcall_level+0x157/0x210 init/main.c:1328
 do_initcalls+0x3f/0x80 init/main.c:1344
 kernel_init_freeable+0x435/0x5d0 init/main.c:1577
 kernel_init+0x1d/0x2b0 init/main.c:1466
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888057feaf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888057feb000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888057feb080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff888057feb100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888057feb180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

