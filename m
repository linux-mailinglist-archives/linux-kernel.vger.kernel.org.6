Return-Path: <linux-kernel+bounces-440313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B3E9EBBAE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED812840EF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBD723024D;
	Tue, 10 Dec 2024 21:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="al3wymTk"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C4B23ED4A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733865383; cv=none; b=BZHjadB+1DVHw4VdZxg+63UKTumLJzDM64LUf+Cl/VJok/J81PhkQsETjRPf0lfVieLIIWOFPdXAz+V+ueQvtskEOzygzuvW/D2my+FnZhrjRCiLj/AbQ/OW0uuHU6AcG0fb8XukI6xMsLI02aoSH9AsdyTM7KtEKnGZjBHcKKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733865383; c=relaxed/simple;
	bh=Vhk9wUtufHdBKtIffOrgwOkZRLv5EvpKs4LVfDrBxEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gE3CDV09qprEbJSUawsFAjLkBYvXQNSO7pt+40StV8Ni00DZBsc4gXax8+vBlJ15QFTxfYCL8pmZ5WEn/0uit9yokIBcYI7WOAO7v95E8UFTe7aXzuyNHhTWR7d3mZhr4Jq1xwmX7sUZFCsTftK2IydHctD1tqXAKl6G5au3/k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=al3wymTk; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b6e5ee6ac7so60152685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1733865378; x=1734470178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gyk9ndnvoGvMP7pC2cu6SDb/gT8fltkKrw46Jm17ZPc=;
        b=al3wymTkn9rwggllv/HGWzzVNRndEDEeVUsEJl5ZhCgZjUp+4kX7Of1UXyLeJosXlz
         ySV1b1qogx1kmsHVJy4cG56EarQyeeew+Aq3zbfEfifz7EgoxOLdoiPu+kWK+MU5n/mL
         wFH9BDf45N+B54OvwHBs4MwVlXLtfSbjviqifMYXSoJ7Ndi6Lis4lDwKoCgjaHxmJQOS
         5dqLVbAH7Tbu5NV4rs0vrWuKcuWK1QIPnm2frc2zEmO3ze2A+rOC0NFJ/sfpIbggYkeh
         vV3T+HwDnvl/M17TR4cYXWuNVHEs8klN4Pf6Up0KOqlwqZu7Uzv4AG01qtKCKCu8XADl
         J23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733865378; x=1734470178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyk9ndnvoGvMP7pC2cu6SDb/gT8fltkKrw46Jm17ZPc=;
        b=PzKVtIndnO+yWe65s4FAe3tyQ5G034wVDCxyKWrMKdsE3brwdj0SDLDAExl3DpzSno
         w0rU/XTU6uW0Kt6FCX4CvdGHLsXzcSO1r5K3PQzhmVIVSzaTx6dd8ZVhcx7XwKIx2tto
         xOn3auquNVeXYkIukiGfrTf+MOz3FC0z3IqiOShWrCTEtR4eyo8mZBq5Ee7PLQTEcdsD
         XK1jkV7mO9JBDBVIp7ED/hKCQQOPkOmazQptfHYey8HbuKt2NQnynNBqBoY8D3Oxt9JZ
         L3r7cWtlV/FykSh8wXV9bObOT6I3i2t1jyN7kuhCUzRXvanh7/BpKBZoZCNT/pAmaf8o
         dkzA==
X-Gm-Message-State: AOJu0YwLoRjESC2ez6RQEEL7W24G6Z/4YfZrFTgjeFLVRFdOJOAkelPi
	+DVcsuk50izT21mnMqp9QB5G2uQeAvV4rloPO7Us8+hcr6AjPSh9hctgRtq0xrg=
X-Gm-Gg: ASbGncvp/10OiAbJurcQJkpjyigrDLmaNaXD61KcVWfh5ULHHsvYTN6nRBw1uoErQ5A
	+kjoYW1y1uv3eHW9gkl0G8lydC9a1mFIO8SlVcpZp9ZEKsNnEzBfoU4di4w1MRLH/HiVtbcTQ0O
	aGhR2hZ0OeT7xT20k+o4bbc7sj9eb7ptjcFvedgIpu9S68daWQ2lGV9qbUBJ85KrZb9R+EbsfPk
	Q03VCT1pa5tVxJvw+oubPaRlNr+0k1hZnX3xHzF0TuQum6wlwe3
X-Google-Smtp-Source: AGHT+IGbonnfLU/NBu46yYYQXI1v4DRq430cXoE7IJ5mqfU9VxFIjoQbjkh3PuJphJoRzWCExYATJQ==
X-Received: by 2002:a05:6214:21a5:b0:6d8:8ca0:a7 with SMTP id 6a1803df08f44-6d934b90095mr6115126d6.30.1733865377709;
        Tue, 10 Dec 2024 13:16:17 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8eb1ce58bsm51692076d6.49.2024.12.10.13.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 13:16:17 -0800 (PST)
Date: Tue, 10 Dec 2024 16:16:13 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v2 1/2] mm/page_alloc: conditionally split >
 pageblock_order pages in free_one_page() and move_freepages_block_isolate()
Message-ID: <20241210211613.GC2508492@cmpxchg.org>
References: <20241210102953.218122-1-david@redhat.com>
 <20241210102953.218122-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210102953.218122-2-david@redhat.com>

On Tue, Dec 10, 2024 at 11:29:52AM +0100, David Hildenbrand wrote:
> @@ -1225,27 +1225,53 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  	spin_unlock_irqrestore(&zone->lock, flags);
>  }
>  
> -/* Split a multi-block free page into its individual pageblocks. */
> -static void split_large_buddy(struct zone *zone, struct page *page,
> -			      unsigned long pfn, int order, fpi_t fpi)
> +static bool pfnblock_migratetype_equal(unsigned long pfn,
> +		unsigned long end_pfn, int mt)
>  {
> -	unsigned long end = pfn + (1 << order);
> +	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | end_pfn, pageblock_nr_pages));
>  
> +	while (pfn != end_pfn) {
> +		struct page *page = pfn_to_page(pfn);
> +
> +		if (unlikely(mt != get_pfnblock_migratetype(page, pfn)))
> +			return false;
> +		pfn += pageblock_nr_pages;
> +	}
> +	return true;
> +}
> +
> +static void __free_one_page_maybe_split(struct zone *zone, struct page *page,
> +		unsigned long pfn, int order, fpi_t fpi_flags)
> +{
> +	const unsigned long end_pfn = pfn + (1 << order);
> +	int mt = get_pfnblock_migratetype(page, pfn);
> +
> +	VM_WARN_ON_ONCE(order > MAX_PAGE_ORDER);
>  	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
>  	/* Caller removed page from freelist, buddy info cleared! */
>  	VM_WARN_ON_ONCE(PageBuddy(page));
>  
> -	if (order > pageblock_order)
> -		order = pageblock_order;
> +	/*
> +	 * With CONFIG_MEMORY_ISOLATION, we might be freeing MAX_ORDER_NR_PAGES
> +	 * pages that cover pageblocks with different migratetypes; for example
> +	 * only some migratetypes might be MIGRATE_ISOLATE. In that (unlikely)
> +	 * case, fallback to freeing individual pageblocks so they get put
> +	 * onto the right lists.
> +	 */
> +	if (!IS_ENABLED(CONFIG_MEMORY_ISOLATION) ||
> +	    likely(order <= pageblock_order) ||
> +	    pfnblock_migratetype_equal(pfn + pageblock_nr_pages, end_pfn, mt)) {
> +		__free_one_page(page, pfn, zone, order, mt, fpi_flags);
> +		return;
> +	}

Ok, if memory isolation is disabled, we know the migratetypes are all
matching up, and we can skip the check. However, if memory isolation
is enabled, but this isn't move_freepages_block_isolate() calling, we
still do the check unnecessarily and slow down the boot, no?

Having a function guess the caller is a bit of an anti-pattern. The
resulting code is hard to follow, and it's very easy to
unintentionally burden some cases with unnecessary stuff. It's better
to unshare paths until you don't need conditionals like this.

In addition to the fastpath, I think you're also punishing the
move_freepages_block_isolate() case. We *know* we just changed the
type of one of the buddy's blocks, and yet you're still checking the
the range again to decide whether to split.

All of this to accomodate hugetlb, which might not even be compiled
in? Grrrr.

Like you, I was quite surprised to see that GFP_COMP patch in the
buddy hotpath splitting *everything* into blocks - on the offchance
that somebody might free a hugetlb page. Even if !CONFIG_HUGETLB. Just
- what the hell. We shouldn't merge "I only care about my niche
usecase at the expense of literally everybody else" patches like this.

My vote is NAK on this patch, and a retro-NAK on the GFP_COMP patch.

The buddy allocator operates on the assumption of MAX_PAGE_ORDER. If
we support folios of a larger size sourced from other allocators, then
it should be the folio layer discriminating. So if folio_put() detects
this is a massive alloc_contig chunk, then it should take a different
freeing path. Do the splitting in there, then pass valid chunks back
to the buddy. That would keep the layering cleaner and the cornercase
overhead out of the allocator fastpath.

It would also avoid the pointless and fragile attempt at freeing a
big, non-buddy chunk through the PCP.

