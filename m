Return-Path: <linux-kernel+bounces-563265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 386B9A63BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362B1188F157
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 02:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9390F13B7B3;
	Mon, 17 Mar 2025 02:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A84Kgl5w"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7478F5C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 02:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742178855; cv=none; b=BhuJ+LbwfMhlp77Z8JzGZBPp2gAdzK4C1S5I6USb0iMOsIBwQtuiPj6XWBMurTdQeL92T+dxc8TpQQP77zS+/FTa69QkyA0YOBcMzXURNtf5dYiDAXYRsGF+80AkHGu1HHy+JkwJTmf4k3+ci3UCWI5DUhljSUCVWvxp/q6QocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742178855; c=relaxed/simple;
	bh=nEDwUSXy+yO3w/PN/BTjRQ7rFvaGZZ4o5mazFLNR5iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUoEEgnQSvwXKIo1ZYBxnK8a3nUKE4KOF3lTD2MFhPAV4jp0bOO+I86imavbYAw5uMjO7z9cwS6sOx0/A1xPdhli1Vt4eH9lpdcEbzg2WMTe3CjbI4nz7ZouIORq+phdhbOGB5cNZxUdAyVtMcZSHqp/JImxHKm72VvGXg4yxmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A84Kgl5w; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e6039be4-c7dc-4f2b-9ea3-5b16181d5a1a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742178849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B1BtYu1DSI8lISxQbWnsSvvbQXjtPK+aRa7qKTFZoxc=;
	b=A84Kgl5w9n3BzV9edm/ttONFdXH+h8EK/6OFwSjEOl4Q4LpN9xT/h7UMbUxTK6CqmZLo1G
	2vY3BQ7I35qinp65gFQN6OW7EySsZ60Xx3oY1IP9BJ0q5YrqxAYGvV68PnAnOiodhWarYi
	K0gaBjkb8iXGe2qPBX9AgHtwU+inmAM=
Date: Mon, 17 Mar 2025 10:33:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Linux6.14-rc5: KASAN: use-after-free Read in zswap_store
To: ffhgfv <xnxc22xnxc22@qq.com>, hannes <hannes@cmpxchg.org>,
 "yosry.ahmed" <yosry.ahmed@linux.dev>, nphamcs <nphamcs@gmail.com>,
 akpm <akpm@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <tencent_49DA3E780998A9B96ADC9FF658CC84641808@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <tencent_49DA3E780998A9B96ADC9FF658CC84641808@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/3/17 08:13, ffhgfv wrote:
> Hello, I found a bug titled " KASAN: use-after-free Read in zswap_store " with modified syzkaller in the Linux6.14-rc5.
> If you fix this issue, please add the following tag to the commit:  Reported-by: Jianzhou Zhao <xnxc22xnxc22@qq.com>,    xingwei lee <xrivendell7@gmail.com>, Zhizhuo Tang <strforexctzzchange@foxmail.com>
> 
> I use the same kernel as syzbot instance upstream: 7eb172143d5508b4da468ed59ee857c6e5e01da6
> kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&amp;x=da4b04ae798b7ef6
> compiler: gcc version 11.4.0
> ------------[ cut here ]-----------------------------------------
>   TITLE:   KASAN: use-after-free Read in zswap_store
> ==================================================================
> ==================================================================
> BUG: KASAN: use-after-free in debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
> BUG: KASAN: use-after-free in do_raw_spin_lock+0x285/0x2e0 kernel/locking/spinlock_debug.c:115
> Read of size 4 at addr ffff88804e78e014 by task kswapd0/98
> 
> CPU: 0 UID: 0 PID: 98 Comm: kswapd0 Not tainted 6.14.0-rc5-dirty #11
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>   <task>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:408 [inline]
>   print_report+0xc1/0x630 mm/kasan/report.c:521
>   kasan_report+0x93/0xc0 mm/kasan/report.c:634
>   debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
>   do_raw_spin_lock+0x285/0x2e0 kernel/locking/spinlock_debug.c:115
>   spin_lock include/linux/spinlock.h:351 [inline]
>   z3fold_page_lock mm/z3fold.c:223 [inline]
>   z3fold_alloc mm/z3fold.c:1060 [inline]
>   z3fold_zpool_malloc+0x9b1/0x1410 mm/z3fold.c:1388
>   zswap_compress mm/zswap.c:971 [inline]
>   zswap_store_page mm/zswap.c:1462 [inline]
>   zswap_store+0xe46/0x41e0 mm/zswap.c:1571
>   swap_writepage+0x3a7/0x1430 mm/page_io.c:278
>   pageout+0x3bf/0xac0 mm/vmscan.c:696
>   shrink_folio_list+0x3509/0x4480 mm/vmscan.c:1402
>   evict_folios+0x849/0x2100 mm/vmscan.c:4660
>   try_to_shrink_lruvec+0x608/0x9b0 mm/vmscan.c:4821
>   shrink_one+0x412/0x7d0 mm/vmscan.c:4866
>   shrink_many mm/vmscan.c:4929 [inline]
>   lru_gen_shrink_node mm/vmscan.c:5007 [inline]
>   shrink_node+0x2355/0x3c10 mm/vmscan.c:5978
>   kswapd_shrink_node mm/vmscan.c:6807 [inline]
>   balance_pgdat+0xa85/0x1740 mm/vmscan.c:6999
>   kswapd+0x4c0/0xbe0 mm/vmscan.c:7264
>   kthread+0x427/0x880 kernel/kthread.c:464
>   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>   </task>
> 
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x564c9cd0a pfn:0x4e78e
> flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
> raw: 04fff00000000000 ffffea000139e508 ffffea000139e248 0000000000000000
> raw: 0000000564c9cd0a 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as freed
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12800(GFP_NOWAIT|__GFP_NORETRY), pid 98, tgid 98 (kswapd0), ts 431124924160, free_ts 431131252025
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook mm/page_alloc.c:1551 [inline]
>   prep_new_page+0x1b0/0x1e0 mm/page_alloc.c:1559
>   get_page_from_freelist+0x19a2/0x3250 mm/page_alloc.c:3477
>   __alloc_frozen_pages_noprof+0x324/0x6b0 mm/page_alloc.c:4739
>   alloc_pages_mpol+0x20a/0x550 mm/mempolicy.c:2270
>   alloc_pages_noprof+0x1c/0x250 mm/mempolicy.c:2361
>   z3fold_alloc mm/z3fold.c:1036 [inline]
>   z3fold_zpool_malloc+0x7aa/0x1410 mm/z3fold.c:1388
>   zswap_compress mm/zswap.c:971 [inline]
>   zswap_store_page mm/zswap.c:1462 [inline]
>   zswap_store+0xe46/0x41e0 mm/zswap.c:1571
>   swap_writepage+0x3a7/0x1430 mm/page_io.c:278
>   pageout+0x3bf/0xac0 mm/vmscan.c:696
>   shrink_folio_list+0x3509/0x4480 mm/vmscan.c:1402
>   evict_folios+0x849/0x2100 mm/vmscan.c:4660
>   try_to_shrink_lruvec+0x608/0x9b0 mm/vmscan.c:4821
>   shrink_one+0x412/0x7d0 mm/vmscan.c:4866
>   shrink_many mm/vmscan.c:4929 [inline]
>   lru_gen_shrink_node mm/vmscan.c:5007 [inline]
>   shrink_node+0x2355/0x3c10 mm/vmscan.c:5978
>   kswapd_shrink_node mm/vmscan.c:6807 [inline]
>   balance_pgdat+0xa85/0x1740 mm/vmscan.c:6999
>   kswapd+0x4c0/0xbe0 mm/vmscan.c:7264
> page last free pid 38 tgid 38 stack trace:

It looks like the z3fold doesn't handle the migration correctly?
But it's suggested that we should use zsmalloc as zswap allocator,
and the z3fold/zbud will be deleted.

Thanks.

>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1127 [inline]
>   free_frozen_pages+0x7aa/0x1290 mm/page_alloc.c:2660
>   __folio_put+0x304/0x3d0 mm/swap.c:112
>   folio_put include/linux/mm.h:1489 [inline]
>   migrate_folio_done+0x29b/0x340 mm/migrate.c:1180
>   migrate_folio_move mm/migrate.c:1402 [inline]
>   migrate_folios_move mm/migrate.c:1712 [inline]
>   migrate_pages_batch+0x1c0b/0x2f30 mm/migrate.c:1959
>   migrate_pages_sync+0x110/0x8d0 mm/migrate.c:1989
>   migrate_pages+0x1b19/0x22d0 mm/migrate.c:2098
>   compact_zone+0x1b40/0x3ed0 mm/compaction.c:2663
>   compact_node+0x19c/0x2d0 mm/compaction.c:2932
>   kcompactd+0x328/0x940 mm/compaction.c:3226
>   kthread+0x427/0x880 kernel/kthread.c:464
>   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> Memory state around the buggy address:
>   ffff88804e78df00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   ffff88804e78df80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> &gt;ffff88804e78e000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                           ^
>   ffff88804e78e080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>   ffff88804e78e100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ==================================================================
> 
> 
> I hope it helps.
> Best regards
> Jianzhou Zhao</strforexctzzchange@foxmail.com></xrivendell7@gmail.com></xnxc22xnxc22@qq.com>

