Return-Path: <linux-kernel+bounces-291390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6B8956176
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE721C211BB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2276A7E574;
	Mon, 19 Aug 2024 03:42:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F280D2F4A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724038925; cv=none; b=k/4oeo0EuSEmLtmi5ZsegoYBdxmtWZHyKfY7+rZeQmHYdkHqT42weZoTDIkDGx1IgM0E4YNbt1DoiRtCIf+U6msA77fzLwgCajCVlUae+zzwzYU0H/dYHNEz8Se78ti0JZkU4XnLIA4rGVNoN7hY78wTXBx4V9o/yojvAFsp8gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724038925; c=relaxed/simple;
	bh=VErHZD9k2N9M4Sw+jQV9YSTtXIdTH0bNEPC84MB0Dq8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jm05uSLvav3K+2vdTrD6aUA9bIMHt82UhV/7M8tzwFOx8l4fajfXtbA9JDMbL+84HV32htjutwFz1CuRvPQy0MEzXbOmFljkq8mYopjFjg+XfOwuGptaFEvKIQopktdEgZKFXtFoKMO8pFRQD2ffuQ+4Jxmj+JD3K2fgauJujJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f901cd3b5so408543339f.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 20:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724038923; x=1724643723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rRsgvhShJntFGPXBSKtw7w2QC9OLvP2LMPKqUBNg7I=;
        b=t6e47JFdoLUQMKfiQvIORg3CBC2tK+t5CvFFIaPoH257jA5gDB8erthfD3QFTqqCAp
         uCj9nAi11boFe+4BeC5ZeUjg/dktzUFCfZiQCgMI3sFVTR0bk4VzBJZ/29gd//l0inUd
         HshW4RHKBPyATJE2w0RLXJ7YO8o9oFm0N0GioCNEcDlK3u+xgUuP5qVcCiHZ2hg3T0w3
         +0Cu7vzTvu4JVBVfGsdJAxZ8PdOga4bnfuU1eTuj+U87GUtoGQLA7y0eD8dtBWxD7hx+
         tlCqpJQ6adrvEHe/dFsmgxETH761MsmY3BBNlHjrh8LMzsMbmLpz+NlZYY4kfqvMaskR
         x0gQ==
X-Gm-Message-State: AOJu0YziV8lL5OM/lV4ruEeNUid2YyvZ68jp5M+tRjouN75IImJZ9K63
	xZoz5wsk9Wp0yZG2rGxTnshSTdZ2kii+anoSlpOTJUSu5q5YV5LYOoMSfsBWJHT7kJYjRNPVOFn
	L1BLR+9mod+a5hc7ip+cwEVi+HOYN3aK954DUGHd3nyBvRUZQc6OVqc0=
X-Google-Smtp-Source: AGHT+IES/rapBqfQVF3/kazROi/9BD4LDQw4RKkfAUrhEZznq5scydsAYo5jFbCzmCTR69IXOZtNmsnV8y6V6abQdK8tmclY+ZwY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6e:b0:397:5d37:61fa with SMTP id
 e9e14a558f8ab-39d26cea212mr8708615ab.2.1724038922993; Sun, 18 Aug 2024
 20:42:02 -0700 (PDT)
Date: Sun, 18 Aug 2024 20:42:02 -0700
In-Reply-To: <20240819032658.2766427-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095953e06200117be@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Write in bch2_dev_journal_init
From: syzbot <syzbot+47ecc948aadfb2ab3efc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Write in bch2_dev_journal_init

loop0: detected capacity change from 0 to 32768
==================================================================
BUG: KASAN: slab-out-of-bounds in bch2_dev_journal_init+0x8ea/0xcf0 fs/bcachefs/journal.c:1349
Write of size 8 at addr ffff88800e56e7b0 by task syz.0.15/5578

CPU: 0 UID: 0 PID: 5578 Comm: syz.0.15 Not tainted 6.11.0-rc3-syzkaller-00338-gc3f2d783a459-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 bch2_dev_journal_init+0x8ea/0xcf0 fs/bcachefs/journal.c:1349
 __bch2_dev_attach_bdev+0x217/0x340 fs/bcachefs/super.c:1390
 bch2_dev_attach_bdev+0x2a8/0x6f0 fs/bcachefs/super.c:1420
 bch2_fs_open+0x97c/0xdf0 fs/bcachefs/super.c:2122
 bch2_fs_get_tree+0x731/0x1700 fs/bcachefs/fs.c:1933
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fedc237b0ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 7e 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fedc31b7e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fedc31b7ef0 RCX: 00007fedc237b0ba
RDX: 00000000200058c0 RSI: 0000000020005900 RDI: 00007fedc31b7eb0
RBP: 00000000200058c0 R08: 00007fedc31b7ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020005900
R13: 00007fedc31b7eb0 R14: 00000000000058ad R15: 0000000020005940
 </TASK>

Allocated by task 5578:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4158 [inline]
 __kmalloc_noprof+0x1fc/0x400 mm/slub.c:4170
 kmalloc_noprof include/linux/slab.h:685 [inline]
 kmalloc_array_noprof include/linux/slab.h:726 [inline]
 bch2_dev_journal_init+0x77c/0xcf0 fs/bcachefs/journal.c:1339
 __bch2_dev_attach_bdev+0x217/0x340 fs/bcachefs/super.c:1390
 bch2_dev_attach_bdev+0x2a8/0x6f0 fs/bcachefs/super.c:1420
 bch2_fs_open+0x97c/0xdf0 fs/bcachefs/super.c:2122
 bch2_fs_get_tree+0x731/0x1700 fs/bcachefs/fs.c:1933
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88800e56e780
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 0 bytes to the right of
 allocated 48-byte region [ffff88800e56e780, ffff88800e56e7b0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xe56e
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff8880158418c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080200020 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5138, tgid 5138 (syz-executor), ts 83628656409, free_ts 36738612732
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
 __kmalloc_cache_node_noprof+0x20c/0x300 mm/slub.c:4197
 kmalloc_node_noprof include/linux/slab.h:704 [inline]
 __get_vm_area_node+0x113/0x270 mm/vmalloc.c:3109
 __vmalloc_node_range_noprof+0x3c6/0x1400 mm/vmalloc.c:3794
 __vmalloc_node_noprof mm/vmalloc.c:3899 [inline]
 vzalloc_noprof+0x79/0x90 mm/vmalloc.c:3972
 alloc_counters+0xd7/0x740 net/ipv4/netfilter/ip_tables.c:799
 copy_entries_to_user net/ipv4/netfilter/arp_tables.c:681 [inline]
 get_entries net/ipv4/netfilter/arp_tables.c:867 [inline]
 do_arpt_get_ctl+0xe77/0x16a0 net/ipv4/netfilter/arp_tables.c:1461
 nf_getsockopt+0x299/0x2c0 net/netfilter/nf_sockopt.c:116
 ip_getsockopt+0x222/0x2e0 net/ipv4/ip_sockglue.c:1777
 tcp_getsockopt+0x163/0x1c0 net/ipv4/tcp.c:4409
page last free pid 28 tgid 28 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2612
 __folio_put+0x2c8/0x440 mm/swap.c:128
 migrate_folio_move mm/migrate.c:1330 [inline]
 migrate_pages_batch+0x2a76/0x3560 mm/migrate.c:1818
 migrate_pages_sync mm/migrate.c:1884 [inline]
 migrate_pages+0x1f59/0x3460 mm/migrate.c:1993
 compact_zone+0x3404/0x4af0 mm/compaction.c:2671
 compact_node+0x2de/0x460 mm/compaction.c:2935
 kcompactd+0x788/0x1530 mm/compaction.c:3233
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff88800e56e680: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88800e56e700: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff88800e56e780: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
                                     ^
 ffff88800e56e800: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88800e56e880: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         c3f2d783 Merge tag 'mm-hotfixes-stable-2024-08-17-19-3..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14bc03e5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=47ecc948aadfb2ab3efc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=155d8b83980000


