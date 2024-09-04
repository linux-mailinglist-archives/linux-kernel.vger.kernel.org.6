Return-Path: <linux-kernel+bounces-315910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB6496C8B3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671EF1C25314
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4393148833;
	Wed,  4 Sep 2024 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MpduPxhc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272B9146A79
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 20:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725482465; cv=none; b=i6gKnbdve2xGCF4iTA2z2pLs7ythMIGxS8yv63dHbzCEK2nEPeNAaeysjvlHptJtOvFMpEBLt+VWABIrq5CZ1Y2OEOamXZlHyToHKcSRmkOM9rcdWWWWsS+TEspaN62An0xn1NSEPw2dtCjIRObQGjsdtuIh09dm14jq9QBXazc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725482465; c=relaxed/simple;
	bh=RtHzb2/2jf4vevAr8HjFhrLQINYyj6MKSGehMrPg02M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=O3f6FJS5AvVWEtRkNjsbQkYOvfzYYoPqldW1CNnW/VOdWVBYhO/uHXHfsIPGULxgFH76j1x0dw3+4PHRZFauwNK74gNkJUHtAFov2tAEo4/02cyde1XKrc3+HJT/GYJyacEKcXCG3ZvSxi2JlVcnR+oBrTL64CGVttiLY7a6jo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MpduPxhc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A6BC4CEC2;
	Wed,  4 Sep 2024 20:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725482464;
	bh=RtHzb2/2jf4vevAr8HjFhrLQINYyj6MKSGehMrPg02M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MpduPxhcQ3ZWy9hqnZYGup2B22fv+BFtCDYriisMpmcv5Y2F64IzAu3ZEj1B+CmOh
	 C0BCQViaeg3lbNDJ5783Sa6kA6VBWFpJIX7LOcYrgDzZMMeMxzPzG1Kp7lDeRg71DR
	 OGdRDwfAiqyJ25ulC8qckIUkHnenQpDDaCOY1Xkc=
Date: Wed, 4 Sep 2024 13:41:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Qiang Liu <liuq131@chinatelecom.cn>
Cc: rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mm_init.c: add zidcache to the init_reserved_page
 function
Message-Id: <20240904134102.a7171fb6676dd95dc3b8ede7@linux-foundation.org>
In-Reply-To: <20240904115541.6519-1-liuq131@chinatelecom.cn>
References: <20240904115541.6519-1-liuq131@chinatelecom.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Sep 2024 19:55:41 +0800 Qiang Liu <liuq131@chinatelecom.cn> wrote:

> Each call to the init_reserved_page function will look up the
> corresponding zid for the given pfn parameter. Even if subsequent
> calls have the same zid for the pfn as the current one, the lookup
> will be repeated.
> 
> During system initialization, the memmap_init_reserved_pages function
> calls init_reserved_page for each contiguous memory region in mem_region.
> Implementing a cache for zid can significantly improve performance.
> Tests have shown that adding a zid cache reduces the execution time of
> the memmap_init_reserved_pages function by over 7%.
> 

OK, but how much speedup do we see overall?  In other words, is
memmap_init_reserved_pages() a significant consumer of execution time?

I'd be surprised if it makes much difference at all - MAX_NR_ZONES is a
small number.  Maybe we call init_reserved_page() a lot.


> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -710,19 +710,25 @@ static void __meminit init_reserved_page(unsigned long pfn, int nid)
>  {
>  	pg_data_t *pgdat;
>  	int zid;
> +	struct zone *zone;
> +	static int zidcache;

What locking protects zidcache?  lock_device_hotplug() and/or
__init-time serialization?  This might be worth mentioning?

>  
>  	if (early_page_initialised(pfn, nid))
>  		return;
>  
>  	pgdat = NODE_DATA(nid);
>  
> -	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
> -		struct zone *zone = &pgdat->node_zones[zid];
> +	zone = &pgdat->node_zones[zidcache];

OK, but if init_reserved_page() was previously called against a
different node, `zidcache' will refer to a zone in a different node. 
The code will work OK, but it's worth mentioning somewhere I guess.


> +	if (unlikely(zone_spans_pfn(zone, pfn)))

Isn't this wrong?  We need to redo the search if !zone_spans_pfn(...)?

> +		for (zid = 0; zid < MAX_NR_ZONES; zid++) {
> +			zone = &pgdat->node_zones[zid];
>  
> -		if (zone_spans_pfn(zone, pfn))
> -			break;
> -	}
> -	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
> +			if (zone_spans_pfn(zone, pfn)) {
> +				zidcache = zid;
> +				break;
> +			}
> +		}
> +	__init_single_page(pfn_to_page(pfn), pfn, zidcache, nid);
>  }
>  #else
>  static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
> -- 
> 2.27.0

