Return-Path: <linux-kernel+bounces-406507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ACF9C6049
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10553BE4609
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A32217474;
	Tue, 12 Nov 2024 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="msudGWks"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561DC216DF2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435305; cv=none; b=erYvI8zBs7dZC8iam7xI9rSyGefBRmCZLpDHvR+8tBoqN1uJsH6DO6HUgKLCdjJ3yFS8LEongAqS4/ocsc5l9fpSSKd4ViTSXdo5O1GOyhzl7PMQjJZp4e+gxEGCLYz/qi5Ou6cZ/8JGXaLJQmxsQ+HY/adUD+UOTB8wQq/wzJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435305; c=relaxed/simple;
	bh=4Hb821r6x9jOspp7k7R9OTHLtNmuXsdkmEXzZcr6GOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciKDx1tg98NdVI4ind+l4Y+KOioBT2S1lWkDOD8vDTP1siMVKyZFBrTGAaKdCFWA30mPQoeH+thqAUhDXkD67JA74al3NB71rbbyM/wlJrYZQBiCMdCL4m62Jr/bdylEqAY9tML/Pe/DCSmkiPBfMA6iCypt77hJr0FrKn0dBss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=msudGWks; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 12 Nov 2024 13:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731435299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8/ZE0KHOIIicHT1JQ4FzqCuQ19CG0YU7NmLKz0bP0A=;
	b=msudGWksSYzgnmjp5P6ize+I22JN2SJ1DWQ82pNx/LfS7g9i5BvGuPdQEvoOJmOmtYZqoL
	6yeOEqHDRQzRB+qObdacgNHQyc9NIQpUMaYRz4G9yvfkmiL1aZocDUAi0ZiaBMuT9DBLPm
	xS7ylFT72XbC+dJfVZqn+VVBCdAduyg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Hao Ge <hao.ge@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH] lib/alloc_tag: Remove the sysctl configuration to
 prevent users from disabling it at runtime
Message-ID: <tcz7mmykp7wi4h3cezhbh53wmsabzvd5shejae6vrku7haynzl@4te6hgxve3s2>
References: <20241108075004.131911-1-hao.ge@linux.dev>
 <CAJuCfpEp_3Dz32fdpUaUbPaP6KZ+0fXmXBvBV1jRt9Q+LMRQAQ@mail.gmail.com>
 <71703c20-8311-ce3f-fbed-27d2ec3a2c82@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71703c20-8311-ce3f-fbed-27d2ec3a2c82@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 12, 2024 at 11:30:39AM +0800, Hao Ge wrote:
> Hi Suren
> 
> 
> Firstly, please forgive me for my improper wording in the commit message.
> 
> After sending it, I realized that I should have used "suggestion" instead of
> "decided".
> 
> Secondly, please forgive me for taking a few days to respond. I've been
> quite busy these days.
> 
> 
> Let's continue to discuss this issue.
> 
> 
> On 11/9/24 02:16, Suren Baghdasaryan wrote:
> > On Thu, Nov 7, 2024 at 11:50 PM Hao Ge <hao.ge@linux.dev> wrote:
> > > From: Hao Ge <gehao@kylinos.cn>
> > > 
> > > After much consideration,I have decided to remove
> > > the "mem_profiling" sysctl interface to prevent
> > > users from dynamically enabling or disabling the
> > > MEMORY ALLOCATION PROFILING feature at runtime.
> > > 
> > > I have taken the following actions: I set
> > > CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=y to
> > > enable memory allocation profiling by default,
> > > and then made adjustments to mem_profiling dynamically
> > > during runtime.
> > > 
> > > When I ran the OOM test program, I obtained useful
> > > information that was indeed very helpful for debugging.
> > > 
> > > [ 1023.065402] Memory allocations:
> > > [ 1023.065407]     12.8 GiB     6546 mm/huge_memory.c:1328 func:do_huge_pmd_anonymous_page
> > > [ 1023.065412]      873 MiB   229985 arch/arm64/mm/fault.c:986 func:vma_alloc_zeroed_movable_folio
> > > [ 1023.065415]      187 MiB    29732 mm/slub.c:2412 func:alloc_slab_page
> > > [ 1023.065418]     99.8 MiB    25560 mm/memory.c:1065 func:folio_prealloc
> > > [ 1023.065421]     47.2 MiB     3189 mm/readahead.c:434 func:ra_alloc_folio
> > > [ 1023.065424]     30.0 MiB       15 mm/khugepaged.c:1072 func:alloc_charge_folio
> > > [ 1023.065428]     28.6 MiB      514 mm/compaction.c:1880 func:compaction_alloc
> > > [ 1023.065430]     25.8 MiB     6592 mm/page_ext.c:271 func:alloc_page_ext
> > > [ 1023.065433]     25.6 MiB     6546 mm/huge_memory.c:1161 func:__do_huge_pmd_anonymous_page
> > > [ 1023.065436]     23.5 MiB     6017 mm/shmem.c:1771 func:shmem_alloc_folio
> > > 
> > > After running echo 0 > /proc/sys/vm/mem_profiling
> > > and then executing the same test program,
> > > I obtained the following results
> > > 
> > > [ 1156.509699] Memory allocations:
> > > [ 1156.509703]      187 MiB    29645 mm/slub.c:2412 func:alloc_slab_page
> > > [ 1156.509707]      142 MiB     9357 mm/readahead.c:434 func:ra_alloc_folio
> > > [ 1156.509710]      136 MiB    41325 arch/arm64/mm/fault.c:986 func:vma_alloc_zeroed_movable_folio
> > > [ 1156.509713]     99.7 MiB    25531 mm/memory.c:1065 func:folio_prealloc
> > > [ 1156.509716]     56.0 MiB       28 mm/huge_memory.c:1328 func:do_huge_pmd_anonymous_page
> > > [ 1156.509719]     30.0 MiB       15 mm/khugepaged.c:1072 func:alloc_charge_folio
> > > [ 1156.509723]     28.6 MiB      514 mm/compaction.c:1880 func:compaction_alloc
> > > [ 1156.509725]     26.3 MiB     7460 mm/readahead.c:264 func:page_cache_ra_unbounded
> > > [ 1156.509728]     25.8 MiB     6592 mm/page_ext.c:271 func:alloc_page_ext
> > > [ 1156.509730]     23.5 MiB     6016 mm/shmem.c:1771 func:shmem_alloc_folio
> > > 
> > > Because mem_profiling was disabled by executing
> > > echo 0 > /proc/sys/vm/mem_profiling,we are unable to
> > > record memory allocation information after the disablement.
> > Naturally you are unable to track the allocations after disabling it.
> > You disabled it as root, so I assume you know what you are doing.
> > 
> > > These output logs can mislead users. And similarly, the same
> > > applies to alloc_info.
> > I would understand if you made /proc/allocinfo empty after disabling
> > it to avoid confusing the user, but ripping out the ability to
> > enable/disable profiling at runtime does not make sense to me. Once
> > you collect required data, disabling profiling gets you back the
> > performance that you pay for it. There are usecases when a program on
> > a remote device periodically enables profiling for some time, records
> > the difference in allocations and then disables it. Your change breaks
> > such users.
> 
> 
> Actually, my original intention was also to make /proc/allocinfo empty when
> disabling it,
> 
> but I considered the following scenario: after we disable it and clear
> /proc/allocinfo,
> 
> we then start a memory-intensive application,
> 
> such as our OOM (Out-Of-Memory) test program.
> 
> If we later enable it again, the issue described in my commit message would
> still arise.
> 
> Perhaps we need to further consider how to handle this situation.

Why would you do such a thing?

We put a lot of effort into making memory allocation profiling cheap
enough to leave on, and I haven't seen a single complaint about
performance overhead.

