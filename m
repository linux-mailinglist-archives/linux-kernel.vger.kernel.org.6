Return-Path: <linux-kernel+bounces-405360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E35A9C504C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0511F226B0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8E120ADD7;
	Tue, 12 Nov 2024 08:08:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BDB1A08CB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731398886; cv=none; b=S/mf+IgCWK7BVUz0rGmShTljqJV4So+HbyGfgyTUG4DVxNlI+vSR7+2+OL7T9WE+gl2/TsHL1HU4ybBhZgpxgZOBREb8iBfGA4SGke75PMKgtgKp8bPYSFof/d3OTPIMQ6S95VINSXppYFwRTlcDsXcCIyceFH3xobOG0K5CvaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731398886; c=relaxed/simple;
	bh=AM5L4R6NaBdcutkqIqL4gMAFj36QWXzKuQZ49JMmfu4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Uz6ydfOrTfzRg0Pm5+/eRXd8f8IFhM6IYk1+6sAiUsmcou0160hutCveWDyIsvPhyXcmrjRJeSQbYFpnSm0fIRe+1GzlX0c9kkIENwIZDMZDBoshJT6TDNPobzuJjDw+jO92Gn0EQDDjgDfKPQjDTEw2EKrZq1qVwFqE0JdKE6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c3ecaaabso70676775ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731398883; x=1732003683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eoP/5rdS8OwkJVlj1ETPwYBgUw8hzl2EFMvE7sJT7mM=;
        b=Ap8kuL+NDaV19/cuqQpU2UOHOaABWSO3LPxbp22ksdbT6ApcbLWix19DN6cxygpZbo
         +th3q4pe3pOo8h5E0zdB+NgCGKaNsbQJiOpmTirXinZvPEcnwlzLLM6sNvHzWqTLKC50
         +dNGBvg9YifOenv24tKEAfLciT5nR47t07EddNhWUjfp+ow8/FaIX/lLDgmNMrAjW4Ha
         pPFyFD/LUSDJAKNa7VQQl+Z6ejWYevftV5J4CfAv62DgBz1nHKACtWrJ3jme+LfQLp3c
         f3e3f0QwDOxh/wv4jF+JYgb/jdyUGiWVAZ0pVp+UFX0x+fyqv8gCq61QCOhqYaMQEY3j
         KxCA==
X-Forwarded-Encrypted: i=1; AJvYcCX46++huqQBecek6RAk+GmoOt3U6qN3Pg8tSgu1cWDafhjiEAvf6r7WKB9iO6zjHMYryy/E8+kFgfJe/dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZhkNoq1iy9U5gh+m6MDAWHmGYQiC1S3FvYRQRKXCNcK+aaVQA
	sLMRLd2Rise8G5kpgzs4pn96gY1Jypgisaqi+IH+zKmDXhZMRMceYLFrkulvlAlFveFE7QwCu8/
	m16Ob0whb3l/1DZNzz86MaS/9tM+nU5O0Sxi1xsE1n0ufL8AhXoBM3Sc=
X-Google-Smtp-Source: AGHT+IGXfL9slfjxLTW5zrR+H9F6Rt8PAs4HqpPjzl2yXKz237brKVs5h3TQDH8yPVLuaFNXTg6xAU7kQqlnaGPRAmXAdho6zvfF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1786:b0:3a0:5642:c78 with SMTP id
 e9e14a558f8ab-3a70c878d21mr16402335ab.15.1731398883665; Tue, 12 Nov 2024
 00:08:03 -0800 (PST)
Date: Tue, 12 Nov 2024 00:08:03 -0800
In-Reply-To: <tencent_5074A97043AAA456F764576E46C7137EC305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67330ce3.050a0220.5088e.000a.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] KASAN: use-after-free Read in nilfs_find_entry
From: syzbot <syzbot+96d5d14c47d97015c624@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in nilfs_find_entry

=======================================================
==================================================================
BUG: KASAN: use-after-free in nilfs_find_entry+0x2ad/0x670 fs/nilfs2/dir.c:321
Read of size 2 at addr ffff88805585f008 by task syz.0.15/5797

CPU: 0 UID: 0 PID: 5797 Comm: syz.0.15 Not tainted 6.12.0-rc7-syzkaller-g2d5404caa8c7-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 nilfs_find_entry+0x2ad/0x670 fs/nilfs2/dir.c:321
 nilfs_inode_by_name+0xad/0x240 fs/nilfs2/dir.c:394
 nilfs_lookup+0xed/0x210 fs/nilfs2/namei.c:63
 lookup_open fs/namei.c:3573 [inline]
 open_last_lookups fs/namei.c:3694 [inline]
 path_openat+0x11a7/0x3590 fs/namei.c:3930
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb5e537e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb5e609a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fb5e5535f80 RCX: 00007fb5e537e719
RDX: 000000000000275a RSI: 0000000020000080 RDI: ffffffffffffff9c
RBP: 00007fb5e53f139e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb5e5535f80 R15: 00007fff7a41f408
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x55be003c9 pfn:0x5585f
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea0001224c08 ffffea000110c308 0000000000000000
raw: 000000055be003c9 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 5800, tgid 5800 (dhcpcd-run-hook), ts 123081593697, free_ts 123090641935
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1541
 prep_new_page mm/page_alloc.c:1549 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3459
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4735
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 folio_alloc_mpol_noprof mm/mempolicy.c:2283 [inline]
 vma_alloc_folio_noprof+0x12e/0x230 mm/mempolicy.c:2314
 folio_prealloc+0x31/0x170
 wp_page_copy mm/memory.c:3353 [inline]
 do_wp_page+0x11c4/0x52d0 mm/memory.c:3745
 handle_pte_fault+0x10e3/0x6820 mm/memory.c:5782
 __handle_mm_fault mm/memory.c:5909 [inline]
 handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6077
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
page last free pid 5800 tgid 5800 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1112 [inline]
 free_unref_folios+0xdb3/0x1750 mm/page_alloc.c:2689
 folios_put_refs+0x76c/0x860 mm/swap.c:1007
 free_pages_and_swap_cache+0x2ea/0x690 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x496/0xc40 mm/mmap.c:1936
 __mmput+0x115/0x390 kernel/fork.c:1348
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x28e0 kernel/exit.c:926
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88805585ef00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88805585ef80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88805585f000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                      ^
 ffff88805585f080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88805585f100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ea78c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=96d5d14c47d97015c624
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1271335f980000


