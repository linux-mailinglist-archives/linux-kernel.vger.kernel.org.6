Return-Path: <linux-kernel+bounces-424607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806529DB6B4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F4D164850
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C68D19ABCB;
	Thu, 28 Nov 2024 11:45:42 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C96619AD86
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732794341; cv=none; b=Es8LRYfuGlWxEO452II9rbMkYU7N+xsN8dWq/Zrb/zV1E/vzv/Mru5H4OaEckfi4cYjEmz3HOoof4bMX8Hh27sqWR10xE7SRJUS18N5aI2r66qRTRHNwBXeCYDVco0C4QzGp8jfT+zMOOtz4ytYOZpYJ68PvMx8PQSt2kSKBivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732794341; c=relaxed/simple;
	bh=i4wkZtsQibknnttkhAaxADalLKWPvZM1PStuBsVa+ts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iVa5LHAnenHAo9orEKcNMo2qTh0I8yfKdde2wnqoWaRpdYd7nfLz8rjn/7NUlPxXt1pls+hp8km9GSs0cn+UPMGlO7kqAN0ydB5Huz3/5AWBC6Yj+cNLomZXb5YDo0EM8MMoi1GoF9rm/59mQrXkXzS07s0r36LoQ/4KsfxTsaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.49])
	by sina.com (10.185.250.23) with ESMTP
	id 67485743000025B3; Thu, 28 Nov 2024 19:43:03 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7750318913479
X-SMAIL-UIID: 03BC86C2265249C583B7D75CF6EB4741-20241128-194303-1
From: Hillf Danton <hdanton@sina.com>
To: David Hildenbrand <david@redhat.com>
Cc: syzbot <syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [syzbot] [mm?] kernel BUG in const_folio_flags (2)
Date: Thu, 28 Nov 2024 19:42:49 +0800
Message-Id: <20241128114249.1903-1-hdanton@sina.com>
In-Reply-To: <fa337639-54bd-41c0-a1b6-4cc459a32876@redhat.com>
References: <674184c9.050a0220.1cc393.0001.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 28 Nov 2024 11:52:42 +0100 David Hildenbrand <david@redhat.com>
> On 23.11.24 08:31, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    9fb2cfa4635a Merge tag 'pull-ufs' of git://git.kernel.org/..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10042930580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c4515f1b6a4e50b7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9f9a7f73fb079b2387a6
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105ff2e8580000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/7c0c61a15f60/disk-9fb2cfa4.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/3363d84eeb74/vmlinux-9fb2cfa4.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/2b1a270af550/bzImage-9fb2cfa4.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com
> > 
> 
> Staring at the console output:
> 
> [  520.222112][ T7269] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x1403 pfn:0x125be

->mapping is cleared for a order9 page

> [  520.362213][ T7269] head: order:9 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [  520.411963][ T7269] memcg:ffff88807c73c000
> [  520.492069][ T7269] flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
> [  520.499844][ T7269] raw: 00fff00000000000 ffffea0000490001 dead000000000122 dead000000000400
> [  520.551982][ T7269] raw: 00000000000014d0 0000000000000000 00000000ffffffff 0000000000000000
> [  520.560912][ T7269] head: 00fff00000000040 0000000000000000 dead000000000122 0000000000000000
> [  520.672020][ T7269] head: 0000000000001245 0000000000000000 00000001ffffffff ffff88807c73c000
> [  520.735699][ T7269] head: 00fff00000000209 ffffea0000490001 ffffffffffffffff 0000000000000000
> [  520.901989][ T7269] head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
> [  520.991952][ T7269] page dumped because: VM_BUG_ON_PAGE(PageTail(page))
> [  521.086487][ T7269] page_owner tracks the page as allocated
> [  521.132208][ T7269] page last allocated via order 0, migratetype Movable, gfp_mask 0x3d24ca(GFP_TRANSHUGE|__GFP_NORETRY|
> 
> ^order 0 looks wrong, but let;s not get distracted.
> 
> __GFP_THISNODE), pid 7321, tgid 7321 (syz.1.194), ts 520201520231, free_ts 520193076092
> [  521.272012][ T7269]  post_alloc_hook+0x2d1/0x350
> [  521.276977][ T7269]  __alloc_pages_direct_compact+0x20e/0x590
> [  521.314428][ T7269]  __alloc_pages_noprof+0x182b/0x25a0
> [  521.319975][ T7269]  alloc_pages_mpol_noprof+0x282/0x610
> [  521.420092][ T7269]  folio_alloc_mpol_noprof+0x36/0xd0
> [  521.483167][ T7269]  vma_alloc_folio_noprof+0xee/0x1b0
> [  521.539677][ T7269]  do_huge_pmd_anonymous_page+0x258/0x2ae0
> ...
> [  521.851719][ T7269] page last free pid 7323 tgid 7321 stack trace:
> [  521.972611][ T7269]  free_unref_folios+0xa87/0x14f0
> [  521.977735][ T7269]  folios_put_refs+0x587/0x7b0
> [  522.072508][ T7269]  folio_batch_move_lru+0x2c4/0x3b0
> [  522.077794][ T7269]  __folio_batch_add_and_move+0x35b/0xc60
> [  522.191992][ T7269]  reclaim_folio_list+0x205/0x3a0
> [  522.197131][ T7269]  reclaim_pages+0x481/0x650
> [  522.201760][ T7269]  madvise_cold_or_pageout_pte_range+0x163b/0x20d0
> ...
> 
> 
> So we allocated a order-9 anonymous folio, but suddenly find it via shmem in the pagecache?
> 
> Is this some crazy use-after-free / double-free, where we end up freeing a shmem folio
> that is still in the pagecache? Once freed, it gets merged in the buddy, and we then re-allocate
> it as part of a PMD THP; but shmem still finds it in the pagecache, and as the it's now suddenly

It is not in the pagecache.

> a tail page, the folio checks trigger.
> 
> 
> Maybe the MADV_COLD / MADV_PAGEOUT is a valid hint. But I'm not able to
> spot obvious refcount handling issues there.
> 
> >   madvise_pageout_page_range mm/madvise.c:609 [inline]
> >   madvise_pageout+0x326/0x820 mm/madvise.c:636
> >   madvise_vma_behavior+0x58c/0x19e0 mm/madvise.c:1045
> >   madvise_walk_vmas+0x1cf/0x2c0 mm/madvise.c:1274
> >   do_madvise+0x29d/0x700 mm/madvise.c:1461
> >   __do_sys_madvise mm/madvise.c:1477 [inline]
> >   __se_sys_madvise mm/madvise.c:1475 [inline]
> >   __x64_sys_madvise+0xa9/0x110 mm/madvise.c:1475
> >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> > ------------[ cut here ]------------
> > kernel BUG at include/linux/page-flags.h:309!
> > Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> > CPU: 0 UID: 0 PID: 7269 Comm: syz.1.183 Not tainted 6.12.0-syzkaller-00233-g9fb2cfa4635a #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
> > RIP: 0010:const_folio_flags.constprop.0+0x12e/0x150 include/linux/page-flags.h:309
> > Code: 86 cb ff e8 f4 86 cb ff 48 8d 45 ff 48 39 c3 0f 84 38 ff ff ff e8 e2 86 cb ff 48 c7 c6 00 19 58 8b 48 89 df e8 e3 4b 11 00 90 <0f> 0b e8 6b 0d 2d 00 e9 f1 fe ff ff e8 61 0d 2d 00 eb a3 48 89 df
> > RSP: 0018:ffffc9000c55ee30 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: ffffea0000496f80 RCX: ffffc9000c55ecd8
> > RDX: ffff88805f401e00 RSI: ffffffff81c1362d RDI: ffff88805f402244
> > RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff203a591
> > R10: ffffffff901d2c8f R11: 0000000000000001 R12: 00000000000014df
> > R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffff920018abdf4
> > FS:  00007f08b31bc6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000000c0025ff000 CR3: 00000000341ce000 CR4: 00000000003526f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   <TASK>
> >   folio_test_locked include/linux/page-flags.h:509 [inline]
> >   next_uptodate_folio+0xac/0x4b0 mm/filemap.c:3505
> >   filemap_map_pages+0x1c6/0x16a0 mm/filemap.c:3647
> >   do_fault_around mm/memory.c:5255 [inline]
> >   do_read_fault mm/memory.c:5288 [inline]
> >   do_fault mm/memory.c:5431 [inline]
> >   do_pte_missing+0xdae/0x3e70 mm/memory.c:3965
> >   handle_pte_fault mm/memory.c:5766 [inline]
> >   __handle_mm_fault+0x100a/0x2a10 mm/memory.c:5909
> >   handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6077
> >   faultin_page mm/gup.c:1187 [inline]
> >   __get_user_pages+0x8d9/0x3b50 mm/gup.c:1485
> >   __get_user_pages_locked mm/gup.c:1751 [inline]
> >   get_dump_page+0xfb/0x220 mm/gup.c:2269
> >   dump_user_range+0x135/0x8c0 fs/coredump.c:943
> >   elf_core_dump+0x2766/0x3840 fs/binfmt_elf.c:2121
> >   do_coredump+0x2c42/0x4160 fs/coredump.c:758
> >   get_signal+0x237c/0x26d0 kernel/signal.c:2903
> >   arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
> >   exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
> >   exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
> >   irqentry_exit_to_user_mode+0x13f/0x280 kernel/entry/common.c:231
> >   asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> > RIP: 0033:0x1000
> > Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > RSP: 002b:000000000000010c EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: 00007f08b41363b8 RCX: 00007f08b3f7e759
> > RDX: ffffffffff600000 RSI: 0000000000000104 RDI: 8000000000000000
> > RBP: 00007f08b3ff175e R08: 0000000100000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 0000000000000000 R14: 00007f08b41363b8 R15: 00007fff7656a008
> >   </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:const_folio_flags.constprop.0+0x12e/0x150 include/linux/page-flags.h:309
> > Code: 86 cb ff e8 f4 86 cb ff 48 8d 45 ff 48 39 c3 0f 84 38 ff ff ff e8 e2 86 cb ff 48 c7 c6 00 19 58 8b 48 89 df e8 e3 4b 11 00 90 <0f> 0b e8 6b 0d 2d 00 e9 f1 fe ff ff e8 61 0d 2d 00 eb a3 48 89 df
> > RSP: 0018:ffffc9000c55ee30 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: ffffea0000496f80 RCX: ffffc9000c55ecd8
> > RDX: ffff88805f401e00 RSI: ffffffff81c1362d RDI: ffff88805f402244
> > RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff203a591
> > R10: ffffffff901d2c8f R11: 0000000000000001 R12: 00000000000014df
> > R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffff920018abdf4
> > FS:  00007f08b31bc6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fff76568ff8 CR3: 00000000341ce000 CR4: 00000000003526f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > 
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> > 
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> > 
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> > 
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> > 
> > If you want to undo deduplication, reply with:
> > #syz undup
> > 
> 
> 
> -- 
> Cheers,
> 
> David / dhildenb

