Return-Path: <linux-kernel+bounces-564884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C65DA65C41
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E5B57A376A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57151C84C5;
	Mon, 17 Mar 2025 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hVDEO61v"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360914C5AA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235528; cv=none; b=R5F3qS+ZZtB+EZQ6qlEtZpdHPh8wrfgapJws5PUI2686nyXVDLKnJwWEny9vpGgMydOGN/JPqpWMMoGiTSVyFhSIYgFYEJaBg4wRhjXxbOxG4ewfUxrkOSY4KBqi9z0Dmoyz1V3xgSaY+0/TUXMlp28r69O907nO4mxS46nsja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235528; c=relaxed/simple;
	bh=p3n4HVJD+Jwr/egUeXjJx4oqvPezPTUR8CdjTxPi8JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J65vNqqfdt7ahY3e0jP04uGjFzZQbsdD5rvhIbH3/0zgpQtM+OKXppH41Djof3bojDQE5JXGUxi302+VFaytEIV8FEdQpGl3CPaQXrOY7XbYI9ieJiGKB32MvkXyKYoBJGjeggQaXYh16k93i41+fI5QdfeQYhwVzcPagaE8EyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hVDEO61v; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 17 Mar 2025 18:18:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742235523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LzCRo0knkfJ8o8M5oL/sL88fmyKB4M28RkEky5+ZWrI=;
	b=hVDEO61v7y2gc7S4vBCqSkkkVNYXUx3ECw9zmcBlxnd8cv1Bfna57KycbjgX5l/1m4P87l
	RlujJH2cqZWkNJVF/sVbY0P9hUwKDSd/9MaFAk4VymW9qJnZMi5LkEMaKG6gsEPuEIIO0n
	kb6uLH67aiJFdVRQy9MCuSbCQxRAMH8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: ffhgfv <xnxc22xnxc22@qq.com>, hannes <hannes@cmpxchg.org>,
	nphamcs <nphamcs@gmail.com>, akpm <akpm@linux-foundation.org>,
	linux-mm <linux-mm@kvack.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux6.14-rc5: KASAN: use-after-free Read in zswap_store
Message-ID: <Z9hnf0Zv7_1vkh3n@google.com>
References: <tencent_49DA3E780998A9B96ADC9FF658CC84641808@qq.com>
 <e6039be4-c7dc-4f2b-9ea3-5b16181d5a1a@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6039be4-c7dc-4f2b-9ea3-5b16181d5a1a@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 17, 2025 at 10:33:20AM +0800, Chengming Zhou wrote:
> On 2025/3/17 08:13, ffhgfv wrote:
> > Hello, I found a bug titled " KASAN: use-after-free Read in zswap_store " with modified syzkaller in the Linux6.14-rc5.
> > If you fix this issue, please add the following tag to the commit:  Reported-by: Jianzhou Zhao <xnxc22xnxc22@qq.com>,    xingwei lee <xrivendell7@gmail.com>, Zhizhuo Tang <strforexctzzchange@foxmail.com>
> > 
> > I use the same kernel as syzbot instance upstream: 7eb172143d5508b4da468ed59ee857c6e5e01da6
> > kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&amp;x=da4b04ae798b7ef6
> > compiler: gcc version 11.4.0
> > ------------[ cut here ]-----------------------------------------
> >   TITLE:   KASAN: use-after-free Read in zswap_store
> > ==================================================================
> > ==================================================================
> > BUG: KASAN: use-after-free in debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
> > BUG: KASAN: use-after-free in do_raw_spin_lock+0x285/0x2e0 kernel/locking/spinlock_debug.c:115
> > Read of size 4 at addr ffff88804e78e014 by task kswapd0/98
> > 
> > CPU: 0 UID: 0 PID: 98 Comm: kswapd0 Not tainted 6.14.0-rc5-dirty #11
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> > Call Trace:
> >   <task>
> >   __dump_stack lib/dump_stack.c:94 [inline]
> >   dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
> >   print_address_description mm/kasan/report.c:408 [inline]
> >   print_report+0xc1/0x630 mm/kasan/report.c:521
> >   kasan_report+0x93/0xc0 mm/kasan/report.c:634
> >   debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
> >   do_raw_spin_lock+0x285/0x2e0 kernel/locking/spinlock_debug.c:115
> >   spin_lock include/linux/spinlock.h:351 [inline]
> >   z3fold_page_lock mm/z3fold.c:223 [inline]
> >   z3fold_alloc mm/z3fold.c:1060 [inline]
> >   z3fold_zpool_malloc+0x9b1/0x1410 mm/z3fold.c:1388
> >   zswap_compress mm/zswap.c:971 [inline]
> >   zswap_store_page mm/zswap.c:1462 [inline]
> >   zswap_store+0xe46/0x41e0 mm/zswap.c:1571
> >   swap_writepage+0x3a7/0x1430 mm/page_io.c:278
> >   pageout+0x3bf/0xac0 mm/vmscan.c:696
> >   shrink_folio_list+0x3509/0x4480 mm/vmscan.c:1402
> >   evict_folios+0x849/0x2100 mm/vmscan.c:4660
> >   try_to_shrink_lruvec+0x608/0x9b0 mm/vmscan.c:4821
> >   shrink_one+0x412/0x7d0 mm/vmscan.c:4866
> >   shrink_many mm/vmscan.c:4929 [inline]
> >   lru_gen_shrink_node mm/vmscan.c:5007 [inline]
> >   shrink_node+0x2355/0x3c10 mm/vmscan.c:5978
> >   kswapd_shrink_node mm/vmscan.c:6807 [inline]
> >   balance_pgdat+0xa85/0x1740 mm/vmscan.c:6999
> >   kswapd+0x4c0/0xbe0 mm/vmscan.c:7264
> >   kthread+0x427/0x880 kernel/kthread.c:464
> >   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
> >   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >   </task>
> > 
> > The buggy address belongs to the physical page:
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x564c9cd0a pfn:0x4e78e
> > flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
> > raw: 04fff00000000000 ffffea000139e508 ffffea000139e248 0000000000000000
> > raw: 0000000564c9cd0a 0000000000000000 00000000ffffffff 0000000000000000
> > page dumped because: kasan: bad access detected
> > page_owner tracks the page as freed
> > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12800(GFP_NOWAIT|__GFP_NORETRY), pid 98, tgid 98 (kswapd0), ts 431124924160, free_ts 431131252025
> >   set_page_owner include/linux/page_owner.h:32 [inline]
> >   post_alloc_hook mm/page_alloc.c:1551 [inline]
> >   prep_new_page+0x1b0/0x1e0 mm/page_alloc.c:1559
> >   get_page_from_freelist+0x19a2/0x3250 mm/page_alloc.c:3477
> >   __alloc_frozen_pages_noprof+0x324/0x6b0 mm/page_alloc.c:4739
> >   alloc_pages_mpol+0x20a/0x550 mm/mempolicy.c:2270
> >   alloc_pages_noprof+0x1c/0x250 mm/mempolicy.c:2361
> >   z3fold_alloc mm/z3fold.c:1036 [inline]
> >   z3fold_zpool_malloc+0x7aa/0x1410 mm/z3fold.c:1388
> >   zswap_compress mm/zswap.c:971 [inline]
> >   zswap_store_page mm/zswap.c:1462 [inline]
> >   zswap_store+0xe46/0x41e0 mm/zswap.c:1571
> >   swap_writepage+0x3a7/0x1430 mm/page_io.c:278
> >   pageout+0x3bf/0xac0 mm/vmscan.c:696
> >   shrink_folio_list+0x3509/0x4480 mm/vmscan.c:1402
> >   evict_folios+0x849/0x2100 mm/vmscan.c:4660
> >   try_to_shrink_lruvec+0x608/0x9b0 mm/vmscan.c:4821
> >   shrink_one+0x412/0x7d0 mm/vmscan.c:4866
> >   shrink_many mm/vmscan.c:4929 [inline]
> >   lru_gen_shrink_node mm/vmscan.c:5007 [inline]
> >   shrink_node+0x2355/0x3c10 mm/vmscan.c:5978
> >   kswapd_shrink_node mm/vmscan.c:6807 [inline]
> >   balance_pgdat+0xa85/0x1740 mm/vmscan.c:6999
> >   kswapd+0x4c0/0xbe0 mm/vmscan.c:7264
> > page last free pid 38 tgid 38 stack trace:
> 
> It looks like the z3fold doesn't handle the migration correctly?
> But it's suggested that we should use zsmalloc as zswap allocator,
> and the z3fold/zbud will be deleted.

Yeah this code should be gone in v6.15.

