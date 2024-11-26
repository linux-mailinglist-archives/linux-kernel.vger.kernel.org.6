Return-Path: <linux-kernel+bounces-421810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 188159D9070
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3CBF2877BF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0171F5FA;
	Tue, 26 Nov 2024 02:41:28 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC44CA64
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 02:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732588888; cv=none; b=fPsLNACmgv/ZKJdX5/ruaAUwLvnyZwpNJaYPbKb84JgWCZ8cQbNbiUY76SgK7wZvPaO9pHqh3Wz9ePjoQ5AZ7U+m5W0uWXMcPB+YInxFxsiDP68obhc2P0L/UJ6SLH+0jOXJxPryE2f4DnKYTyr87LzknOstPlJqzH4mjwZG7r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732588888; c=relaxed/simple;
	bh=0lzAW6YcqafrierPN8mMpkyt4clnwCVz28cfIUTY0lU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bSoPnDOoS3SoQs00SJV0CtH/IKNMjw8S9prGatR8J9jcYVct7KvhQWWepyTzj0GO9N0jG5yPuetq9qEWwlMAOcrJfWBRgZQF2G4boN2rQNbYu3W5kCoJIaqODGSRvt5nZ8WzmqIJfPMknWRrHg8j4CrDC6NR6v0yOzw1Xyzl5fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7a5031e75so36491575ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 18:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732588885; x=1733193685;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fkakIRJq1QXiWpMUV2ddNwq5N0R8Aa4ZjFhHnAUtlUY=;
        b=M/K464o7LO6d8Sb/vLDLIGgtCSIGt7Eh9XQdJHJmFekz95qZhaVl3cDL7MgKZ/nrbj
         t0g67hLqXWIYWur+A/OB+zmiiRZffDz4sfEq7KMe8AUVLbB3iKRP1zs5svKpe2yV8shB
         41PAzd+1O+6kz4TS4k6n1M/PsKeKhySKCp4iXxBkY7LNpc+aZQKMC5MHcnvLGanbt4iv
         EX8WlK0lTyu+Zrx52dFi75UWrCDJCkPZIv0zasnyT/4ZEu3Bck0upe6Fr2TFxQtRodq6
         yK0pV8g2YLTItL1c+zA15tT0KJyuxHG5wrUHStmzpZl53meN/A2zQF4IpIuINgSQUuLE
         1slQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx7lA0WNhT+yVwL3jx6ZsBPgEptq+oxATG4Jgt8pD5VsHWwSkKcpSQKa+gdKS39gKzpipMGgyCfd77C0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd8jiyIaYk2zpK18X2N6FXuxrOwshnjHU7OHw8TxUw9sZwdywi
	gWc4ho81lLO1jYeKoiMY3ySiyPg74A1QrCdwQplgHk9d/ZeASSSR/DWqsZesBpm2rIIGFBBDU/K
	7zhIHhz9rgWPETEjUMnLws7bIUY0MzfAPOWdzz8FzVU4kZ5vl7ZBQCjQ=
X-Google-Smtp-Source: AGHT+IF/9UCH2hOPjPsHDnUuyrpRH4c0DXXTBgUenlxVS9GhlxAWVYuHAIiYkvq3TaaGlD5fV3zZ4JLlTqlw6ZUd4PJzJ9utm+SY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156f:b0:3a7:172f:1299 with SMTP id
 e9e14a558f8ab-3a79ae1cdbcmr144798625ab.12.1732588885568; Mon, 25 Nov 2024
 18:41:25 -0800 (PST)
Date: Mon, 25 Nov 2024 18:41:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67453555.050a0220.21d33d.0008.GAE@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in folio_evictable (3)
From: syzbot <syzbot+4c7590f1cee06597e43a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a39ac5b7d62 Merge tag 'random-6.12-rc1-for-linus' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16caa607980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd14c10ec1b6af25
dashboard link: https://syzkaller.appspot.com/bug?extid=4c7590f1cee06597e43a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3ee480a33b34/disk-4a39ac5b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/73587a04fea1/vmlinux-4a39ac5b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67e463731a48/bzImage-4a39ac5b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4c7590f1cee06597e43a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in mapping_unevictable include/linux/pagemap.h:262 [inline]
BUG: KASAN: slab-use-after-free in folio_evictable+0xe3/0x310 mm/internal.h:370
Read of size 8 at addr ffff888024afbf90 by task kswapd0/89

CPU: 1 UID: 0 PID: 89 Comm: kswapd0 Not tainted 6.11.0-syzkaller-05319-g4a39ac5b7d62 #0
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
 mapping_unevictable include/linux/pagemap.h:262 [inline]
 folio_evictable+0xe3/0x310 mm/internal.h:370
 sort_folio mm/vmscan.c:4275 [inline]
 scan_folios mm/vmscan.c:4392 [inline]
 isolate_folios mm/vmscan.c:4517 [inline]
 evict_folios+0x1023/0x7780 mm/vmscan.c:4548
 try_to_shrink_lruvec+0x9ab/0xbb0 mm/vmscan.c:4755
 shrink_one+0x3b9/0x850 mm/vmscan.c:4793
 shrink_many mm/vmscan.c:4856 [inline]
 lru_gen_shrink_node mm/vmscan.c:4934 [inline]
 shrink_node+0x3799/0x3de0 mm/vmscan.c:5914
 kswapd_shrink_node mm/vmscan.c:6742 [inline]
 balance_pgdat mm/vmscan.c:6934 [inline]
 kswapd+0x1cbc/0x3720 mm/vmscan.c:7203
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 22175:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4086 [inline]
 slab_alloc_node mm/slub.c:4135 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4142
 getname_flags+0xb7/0x540 fs/namei.c:139
 vfs_fstatat+0x12c/0x190 fs/stat.c:340
 __do_sys_newfstatat fs/stat.c:505 [inline]
 __se_sys_newfstatat fs/stat.c:499 [inline]
 __x64_sys_newfstatat+0x11d/0x1a0 fs/stat.c:499
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 22175:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2343 [inline]
 slab_free mm/slub.c:4580 [inline]
 kmem_cache_free+0x1a3/0x420 mm/slub.c:4682
 vfs_fstatat+0x14f/0x190 fs/stat.c:342
 __do_sys_newfstatat fs/stat.c:505 [inline]
 __se_sys_newfstatat fs/stat.c:499 [inline]
 __x64_sys_newfstatat+0x11d/0x1a0 fs/stat.c:499
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888024afb300
 which belongs to the cache names_cache of size 4096
The buggy address is located 3216 bytes inside of
 freed 4096-byte region [ffff888024afb300, ffff888024afc300)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x24af8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000040 ffff88801bafc780 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000070007 00000001fdffffff 0000000000000000
head: 00fff00000000040 ffff88801bafc780 dead000000000122 0000000000000000
head: 0000000000000000 0000000000070007 00000001fdffffff 0000000000000000
head: 00fff00000000003 ffffea000092be01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 22175, tgid 22175 (sed), ts 1028936253921, free_ts 1028792054212
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4702
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2263
 alloc_slab_page+0x6a/0x130 mm/slub.c:2413
 allocate_slab+0x5a/0x2f0 mm/slub.c:2579
 new_slab mm/slub.c:2632 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3819
 __slab_alloc+0x58/0xa0 mm/slub.c:3909
 __slab_alloc_node mm/slub.c:3962 [inline]
 slab_alloc_node mm/slub.c:4123 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4142
 getname_flags+0xb7/0x540 fs/namei.c:139
 do_sys_openat2+0xd2/0x1d0 fs/open.c:1409
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 22169 tgid 22169 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2619
 discard_slab mm/slub.c:2678 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3146
 put_cpu_partial+0x17c/0x250 mm/slub.c:3221
 __slab_free+0x2ea/0x3d0 mm/slub.c:4450
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4086 [inline]
 slab_alloc_node mm/slub.c:4135 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4142
 getname_flags+0xb7/0x540 fs/namei.c:139
 vfs_fstatat+0x12c/0x190 fs/stat.c:340
 __do_sys_newfstatat fs/stat.c:505 [inline]
 __se_sys_newfstatat fs/stat.c:499 [inline]
 __x64_sys_newfstatat+0x11d/0x1a0 fs/stat.c:499
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888024afbe80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888024afbf00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888024afbf80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888024afc000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888024afc080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

