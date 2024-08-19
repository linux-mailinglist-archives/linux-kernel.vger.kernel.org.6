Return-Path: <linux-kernel+bounces-291379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3115956166
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FEA91F2234B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5184F45014;
	Mon, 19 Aug 2024 03:18:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED101804E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724037484; cv=none; b=C586arFme/IIQEB8/4c02xH4eA0neAKPjsYwROAYkH/f9QY1VVQcA/lH2asrbWGKh4UJEeFm49DiwA0ad7xVuTZfjx4uSeRGBHKT0vO8ahK/TticElYJCXpBf26gJLSgWZp5F3G/c6xQPXc+DmojZF86Zm0sBnphjAZVKxtHQ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724037484; c=relaxed/simple;
	bh=hrWXoEnGAXOKDd59Ak3MLpJqlzkZPCcM8MPatbO/a0A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mvJWRMdSKpdzmtkzWLRSv3c4jkw4lqMX0pfx6DLdp9m9Y6g1cfGCljxWYi3lUn5tUX730YgZtBoxXJygLP2h+fVySLJevNFkGHjnLvRORIo4j9bWFmFWiHyrAxuZPuBy4u3HqlkLuM7wFo8cCDLvG8XgK4gTuCV40leb6ZQjRDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8223c3509a9so407077439f.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 20:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724037482; x=1724642282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FeJ7W0WRCTctFslxrZj+9iERec/Xi5hETqrWFRfUrSA=;
        b=My7HoNOl+q48Gq99LE3mlcz3dasyOEvPD7gvR4tW+jGhY1K8IQTm2/DWAPLyXFSP4w
         R68Ija7Aj6RhGEucCiIMUz1GfkHk9Ujt4lN8XQ25hcF3YxtSSMZCyutJT4mDYyofjY9c
         xLVaNj251RoAvTEOPCaA/9B43frXWjRPOM5nrCuCpUsHlKHWjPfT2ZcqdK34YkNnwsfd
         q9uqcCl0+xQs8qzFpulJQIYwXUONmJefGY59FmY+VNqjn8oOebiTC9FCCDTqqG+gZzoK
         NNkoNEjJ7IGR4ouFXkmhMWOMIB0/29ku+ZAQa60bfwZPMAkeD0WK0qnMFETTSIyZlsQ7
         Lc6A==
X-Gm-Message-State: AOJu0Yx0ONF5i2QX0Ki63lUwmKkbKhVS0+Iee/uGbuu77zhgYUBoVMhC
	eoyOcfe5vQKiS13B0fwLHJ5dc1GlE9Qyuh3sLj5jvX26sbxgR4zVgMrj8uQyABis1Shp1KemHhN
	N/R+09Y9JDcmn18geoJ/suO8K6v6XxgOTZqO1stvmA3dhLe4tTdntrzY=
X-Google-Smtp-Source: AGHT+IH51xyiy+1tnci+X+bdX3k7c0VzIEUkC4Y+MA8xuiRoUIpi5VdOvi3pLZJ+7Kz4JvzjU6je572lhYHJhbCSey/qP95C8V0s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:852a:b0:4c0:8165:c391 with SMTP id
 8926c6da1cb9f-4cce16d6aa9mr700595173.4.1724037482312; Sun, 18 Aug 2024
 20:18:02 -0700 (PDT)
Date: Sun, 18 Aug 2024 20:18:02 -0700
In-Reply-To: <20240819030239.2589565-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6865f062000c1e7@google.com>
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
BUG: KASAN: slab-out-of-bounds in bch2_dev_journal_init+0x764/0xa40 fs/bcachefs/journal.c:1344
Write of size 8 at addr ffff888011d03eb0 by task syz.0.15/5577

CPU: 0 UID: 0 PID: 5577 Comm: syz.0.15 Not tainted 6.11.0-rc3-syzkaller-00338-gc3f2d783a459-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 bch2_dev_journal_init+0x764/0xa40 fs/bcachefs/journal.c:1344
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
RIP: 0033:0x7fe33a17b0ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 7e 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe339bfee68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fe339bfeef0 RCX: 00007fe33a17b0ba
RDX: 00000000200058c0 RSI: 0000000020005900 RDI: 00007fe339bfeeb0
RBP: 00000000200058c0 R08: 00007fe339bfeef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020005900
R13: 00007fe339bfeeb0 R14: 00000000000058ad R15: 0000000020005940
 </TASK>

Allocated by task 5577:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4158 [inline]
 __kmalloc_noprof+0x1fc/0x400 mm/slub.c:4170
 kmalloc_noprof include/linux/slab.h:685 [inline]
 kmalloc_array_noprof include/linux/slab.h:726 [inline]
 bch2_dev_journal_init+0x603/0xa40 fs/bcachefs/journal.c:1334
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

The buggy address belongs to the object at ffff888011d03e80
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 0 bytes to the right of
 allocated 48-byte region [ffff888011d03e80, ffff888011d03eb0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11d03
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff8880158418c0 ffffea0000789500 dead000000000002
raw: 0000000000000000 0000000080200020 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 4804, tgid 4804 (dhcpcd), ts 56130662227, free_ts 56111810071
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
 __kmalloc_cache_noprof+0x1d5/0x2c0 mm/slub.c:4184
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kmalloc_array_noprof include/linux/slab.h:725 [inline]
 e1000e_setup_rx_resources+0x13b/0x4a0 drivers/net/ethernet/intel/e1000e/netdev.c:2373
 e1000e_open+0x1bd/0x9a0 drivers/net/ethernet/intel/e1000e/netdev.c:4632
 __dev_open+0x2d3/0x450 net/core/dev.c:1474
 __dev_change_flags+0x1e2/0x6f0 net/core/dev.c:8838
 dev_change_flags+0x8b/0x1a0 net/core/dev.c:8910
 devinet_ioctl+0xab8/0x1bc0 net/ipv4/devinet.c:1177
 inet_ioctl+0x3d7/0x4f0 net/ipv4/af_inet.c:1003
 sock_do_ioctl+0x158/0x460 net/socket.c:1222
page last free pid 4886 tgid 4886 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_folios+0x103a/0x1b00 mm/page_alloc.c:2660
 folios_put_refs+0x76e/0x860 mm/swap.c:1039
 free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:335
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x44f/0xc80 mm/mmap.c:3425
 __mmput+0x115/0x390 kernel/fork.c:1345
 exec_mmap+0x680/0x710 fs/exec.c:1089
 begin_new_exec+0x12c6/0x2050 fs/exec.c:1355
 load_elf_binary+0x969/0x2680 fs/binfmt_elf.c:996
 search_binary_handler fs/exec.c:1827 [inline]
 exec_binprm fs/exec.c:1869 [inline]
 bprm_execve+0xaf8/0x1770 fs/exec.c:1920
 do_execveat_common+0x55f/0x6f0 fs/exec.c:2027
 do_execve fs/exec.c:2101 [inline]
 __do_sys_execve fs/exec.c:2177 [inline]
 __se_sys_execve fs/exec.c:2172 [inline]
 __x64_sys_execve+0x92/0xb0 fs/exec.c:2172
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888011d03d80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888011d03e00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffff888011d03e80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
                                     ^
 ffff888011d03f00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888011d03f80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         c3f2d783 Merge tag 'mm-hotfixes-stable-2024-08-17-19-3..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=115c03e5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=47ecc948aadfb2ab3efc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f4c905980000


