Return-Path: <linux-kernel+bounces-376679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F519AB4CD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9643285D22
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D791BD50C;
	Tue, 22 Oct 2024 17:15:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B401BD03C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617307; cv=none; b=R7koTlRTO/BAMZz/pnT79wL2UCjktUNQ3QnPqKeW8jDDJG+gp0PhzyYc1edG/+3RfTKBFQphi4GyvdUBAjrYD3AKpfW8QyuclrP99IWJASytmxmdxVjU5GxMrbgSkC5/q01m84prUQhAuGkOf+9Z7vpZR1J96wANsX1v1Vic4nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617307; c=relaxed/simple;
	bh=abhST+aBCmk1bxOYI0NQUu0dj3q0CY2E23D35RtUWgE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GmvFJTeVjkeuWs17IvIF7+o0SmM68x9gHxcvmrp6sPtQJiDBM6AYbtWNCPgYLreANAdULOy5QxtZejSHCxDqD8rz+H1l8JJCmP4qGq9RX6iVVZWVmV3L1I0k3X6VVZsHjSy/RUfl0rkmSKtGr6K7pltmRZb3Q2AvYLNRLUMBs00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3b7b13910so53217585ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729617305; x=1730222105;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jCe2ZybrB8LL8hy1P4R+w5NIWeWb89yAbDgqyOI6GM=;
        b=SPHsO2FulAvBV/FPXqO/KRy4g3fuR2jQTwMon07+ZyynNZpYQaVOnmXhvaj4eTFIUf
         fL9bqto9rIauwdKMSum+85ElyvioIsRNRIzuUEzbgkEPFMxxa1zAG2YIHYXyf5ozpa+A
         db58dnX1a1nQDCzd5ePAvuBqTStr/IYJx141cMnW3UkGDby5QdAJptxCyEsPJbO+GjAd
         Dh6kt+bL63evq3Ro4Q015CIa51/9swAI/cXJ4SOucoKDVw71TMB2c7Dyg3OYaEr5vqzT
         RI6j6d8Z/2yuzV+UNZdYLzrRZOOzW0Zt8qfyTeNlLAyQlEHqKdXkZvvu88hw6Cx5D17Q
         fS1A==
X-Forwarded-Encrypted: i=1; AJvYcCX5LjMo9a+1gazRVRcWwK+35/HbihYLBE2uGKOFjaXavW3UUeb/KolBB4UKznHVZmRKIk+3NGsqM87a8lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyGAB2jZRTno/LEIf9r5/AzOcaCngBpPlAnrQBOC/vJiEE4dUh
	wZ3MZ5LpXy5FXUN/UlRnz+eniNAd/oPBDOg7Boe95Bza3jMlkxA0GQNnPBY2M05syZ5A+yPqJPY
	iU1oOR3HVi1gg1z+BLVt4Or1C5gzs9xGArC+4LpITcTQiv85oOziiXvE=
X-Google-Smtp-Source: AGHT+IHCU5og6tKARRFk0zlqwLDNVjBFf0aZ4lzEBwN8OlH4X4ixmK9FbIarmkYc2/ZFvspS//fGE0O6lv1aLG/5vleQLR9CHw5k
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c6:b0:3a0:4e2b:9ab9 with SMTP id
 e9e14a558f8ab-3a3f404580emr164417015ab.5.1729617305092; Tue, 22 Oct 2024
 10:15:05 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:15:05 -0700
In-Reply-To: <CABBYNZLHhVmQj3R5JS13HTp7KrCrs-HBcRFLqn6AU44uLpbXjA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6717dd99.050a0220.10f4f4.0160.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_sock_timeout
From: syzbot <syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Write in sco_conn_del

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
BUG: KASAN: slab-use-after-free in __refcount_add include/linux/refcount.h:184 [inline]
BUG: KASAN: slab-use-after-free in __refcount_inc include/linux/refcount.h:241 [inline]
BUG: KASAN: slab-use-after-free in refcount_inc include/linux/refcount.h:258 [inline]
BUG: KASAN: slab-use-after-free in sock_hold include/net/sock.h:781 [inline]
BUG: KASAN: slab-use-after-free in sco_conn_del+0xa5/0x310 net/bluetooth/sco.c:220
Write of size 4 at addr ffff88807bd72080 by task syz-executor.0/5406

CPU: 0 UID: 0 PID: 5406 Comm: syz-executor.0 Not tainted 6.12.0-rc4-syzkaller-gc2ee9f594da8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
 __refcount_add include/linux/refcount.h:184 [inline]
 __refcount_inc include/linux/refcount.h:241 [inline]
 refcount_inc include/linux/refcount.h:258 [inline]
 sock_hold include/net/sock.h:781 [inline]
 sco_conn_del+0xa5/0x310 net/bluetooth/sco.c:220
 hci_disconn_cfm include/net/bluetooth/hci_core.h:1975 [inline]
 hci_conn_hash_flush+0x101/0x240 net/bluetooth/hci_conn.c:2592
 hci_dev_close_sync+0x9ef/0x11a0 net/bluetooth/hci_sync.c:5195
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_unregister_dev+0x20b/0x510 net/bluetooth/hci_core.c:2698
 vhci_release+0x80/0xd0 drivers/bluetooth/hci_vhci.c:664
 __fput+0x241/0x880 fs/file_table.c:431
 task_work_run+0x251/0x310 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f018087de69
Code: Unable to access opcode bytes at 0x7f018087de3f.
RSP: 002b:00007fffa31fb468 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f018087de69
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000043
RBP: 00007f01808ca45b R08: 00007fffa31f9207 R09: 000000000006d03d
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000006
R13: 000000000006d03d R14: 000000000006ccf5 R15: 0000000000000004
 </TASK>

Allocated by task 5400:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 getname_flags+0xb7/0x540 fs/namei.c:139
 getname fs/namei.c:225 [inline]
 __do_sys_unlink fs/namei.c:4581 [inline]
 __se_sys_unlink fs/namei.c:4579 [inline]
 __x64_sys_unlink+0x3a/0x50 fs/namei.c:4579
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5400:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kmem_cache_free+0x1a2/0x420 mm/slub.c:4681
 do_unlinkat+0x7b0/0x830 fs/namei.c:4556
 __do_sys_unlink fs/namei.c:4581 [inline]
 __se_sys_unlink fs/namei.c:4579 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:4579
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807bd71100
 which belongs to the cache names_cache of size 4096
The buggy address is located 3968 bytes inside of
 freed 4096-byte region [ffff88807bd71100, ffff88807bd72100)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7bd70
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff8880162f4780 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000070007 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff8880162f4780 dead000000000122 0000000000000000
head: 0000000000000000 0000000000070007 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea0001ef5c01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5400, tgid 5400 (udevd), ts 432009536360, free_ts 431999575653
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
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4141
 getname_flags+0xb7/0x540 fs/namei.c:139
 vfs_fstatat+0x12c/0x190 fs/stat.c:340
 __do_sys_newfstatat fs/stat.c:505 [inline]
 __se_sys_newfstatat fs/stat.c:499 [inline]
 __x64_sys_newfstatat+0x11d/0x1a0 fs/stat.c:499
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 4552 tgid 4552 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 discard_slab mm/slub.c:2677 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3145
 put_cpu_partial+0x17c/0x250 mm/slub.c:3220
 __slab_free+0x2ea/0x3d0 mm/slub.c:4449
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_noprof+0x1a6/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x2b7/0x740 security/tomoyo/file.c:822
 security_inode_getattr+0x130/0x330 security/security.c:2373
 vfs_getattr+0x45/0x430 fs/stat.c:204
 vfs_fstat fs/stat.c:229 [inline]
 vfs_fstatat+0xe4/0x190 fs/stat.c:338
 __do_sys_newfstatat fs/stat.c:505 [inline]
 __se_sys_newfstatat fs/stat.c:499 [inline]
 __x64_sys_newfstatat+0x11d/0x1a0 fs/stat.c:499
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807bd71f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807bd72000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807bd72080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88807bd72100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807bd72180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         c2ee9f59 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103ff430580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=346c6d758171538d
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13264a5f980000


