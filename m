Return-Path: <linux-kernel+bounces-515669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D667A3677D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16D53AE8EB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055D31D89F0;
	Fri, 14 Feb 2025 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="rC59TEBN"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200E9158870
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568416; cv=none; b=iCUq6ed0DT2nUSqblQ5/T/lLzAHPMubR432M9bxCtz6JvNAHLP8AOr6y6HeXWJuKXMKK1ltpScz0VrgYExa3GL+64IBsd8i+yPLur7veesbjFnWOAjvo/na+Zl8SLWzEnyqY1dDCapXr5+CzdTXvsO6Y7paT6CLf8iDc0+aEFrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568416; c=relaxed/simple;
	bh=Rk7nIVt1MTtXn0NS72fTOn9EXPvn5d2wl/NC81j0Mms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuJt1WB1GZHkkXM+sdUrBk6t3rpwqnUx3Nm7b5cnDvrQ+iweh9BbrRSPNDHlrpQpAT0cTlH2D2qWxe5mo3NdAhYRoTdDKmgE20NrWuPYvQ89++5S7ciQXPtD/LZ3GPvj36M0ESlpifUfPss3zBR+ofpy8oGx4G4/4N2f61VKnl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=rC59TEBN; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-471cdc14e99so14005621cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1739568412; x=1740173212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg1ey3aipCNJUc79bD6lrhDndah42SIkSCRK4mNzles=;
        b=rC59TEBNIV2NcZ7dHQUMZNJeYZ5KyEHemM1vJNlgiTm5cYOA5Oa3NQBfCZ2LZWQt1e
         Taghw5yX5XaEGEVh7byet3qE8liEmkSCvh6cDe//Om4wa7jU6g/Ok6BxAtzzSm6q+3nH
         5hK3AiRt0+Y9WQKUcfyUxNSlfmaavbdJOLpl2hqcLHAYkbtNGYAm48j+9+/tbzoJIz8+
         JA1+DYy6K9XwCpwj4gcm+sDrcwuq+5OtUjZx7YitHuvCEiwJ8LyI49WEkftHN71OrXol
         qLEUw6yAz1wOlUZdOGO27qPeQB9mPVDhMu0we1bAEv//hQnOJl9Q0cIC+75VBdYE6Jo1
         6AZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739568412; x=1740173212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cg1ey3aipCNJUc79bD6lrhDndah42SIkSCRK4mNzles=;
        b=FUmyHvmrzoJsWjg1CvVwXrmGL9UTl5qWMNcjUNHMgafQNtzJwK6CZdetoRWLZ1wKyq
         qR3UoKDSBsFkeLzN93Vy7dyT582zUvNrJngKitFyDjCY05Etp8jBxEmzyQjbJKW9dmsh
         vExEFUvgwWIvYCggNBuQNBp0t/GjcmeNMFUR15m2yB3Mnzj7RLiJDh63OK/xKrEKK6cz
         RdaWsH1sGW3aW5m3LSGi80sPzQMMlxDUcSHgRreHhMDJWyinvIzfU9VD2GB2j01uuNY9
         Jo/PCHXCXm0E4YzaZHz72NaXCulV5B75j+/aCK3zXXEY1wagR8L+c+D18c315S1V9dZ9
         eMIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/HwjI1f9oOE59oeF0U9MyDGgBWvJAr5ZbM9Yq0YTzIaiUyANBSE3u4k3bmf0hUeYpXdTBT8ysyU24g+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaSnJ9W8fE0vi10B1UyKlEfrvSD4NJPrQqc9yf6HAiUVyyqCRK
	IyaPbpmSBB/+HtbvR3DbjfG3Lt7Kg+NPXiT+KY3LRXYILUsMTzR/VSDAEM+/cD4=
X-Gm-Gg: ASbGncvANnyz+uV2ednFDzByZFmg44QfhDZRnQIz23e1oH1C1SM/RHtiNACG7SQG7H1
	ipkCjftlVnjWMnuPXB4kGuV+X18rhBICLdLmi/ZU7JB/b/BJYHA4lgj1+TCGp/MxhIKA3n1LzVZ
	ZqSag1e9OccOyabBMBt09LbiiEOELjNtS1I6FG+o/JH5Ebo3ip/axwWp4BFg/yBUyAgjYm2XjIX
	xzXfg1/1Rvt0TYz9KCjC7SPMNfcE2SsV+iobrbAOAqkSR4XxTNaTHwJAkF2vzeRbzUW4HBbHAzd
	UihdvSxDISFk5w==
X-Google-Smtp-Source: AGHT+IGKobUtXHluY1sE6yvKOwaoaHY7us7ziVqjKoQwwTgWBzyrPdqWETaIUMUOpE8su1LCqMuAhA==
X-Received: by 2002:a05:622a:1801:b0:471:887e:fe4 with SMTP id d75a77b69052e-471dc14081amr12129771cf.5.1739568411804;
        Fri, 14 Feb 2025 13:26:51 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-471c2a12436sm21514891cf.23.2025.02.14.13.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 13:26:51 -0800 (PST)
Date: Fri, 14 Feb 2025 16:26:47 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: Re: [PATCH] mm/page_alloc: Clarify some migratetype fallback code
Message-ID: <20250214212647.GB233399@cmpxchg.org>
References: <20250214-clarify-steal-v1-1-79dc5adf1b79@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-clarify-steal-v1-1-79dc5adf1b79@google.com>

On Fri, Feb 14, 2025 at 06:14:01PM +0000, Brendan Jackman wrote:
> This code is rather confusing because:
> 
>  1. "Steal" is sometimes used to refer to the general concept of
>     allocating from a from a block of a fallback migratetype
>     (steal_suitable_fallback()) but sometimes it refers specifically to
>     converting a whole block's migratetype (can_steal_fallback()).

Yes, that's ambiguous.

>  2. can_steal_fallback() sounds as though it's answering the question "am
>     I functionally permitted to allocate from that other type" but in
>     fact it is encoding a heuristic preference.

Here I don't see that nuance tbh.

>  3. The same piece of data has different names in different places:
>     can_steal vs whole_block. This reinforces point 2 because it looks
>     like the different names reflect a shift in intent from "am I
>     allowed to steal" to "do I want to steal", but no such shift exists.
> 
> Fix 1. by avoiding the term "steal" in ambiguous contexts. This fixes
> 3. automatically since the natural name for can_steal is whole_block.

I'm not a fan of whole_block because it loses the action verb. It
makes sense in the context of steal_suitable_fallback(), but becomes
ominous in find_suitable_fallback().

Maybe @block_claimable would be better?

> Fix 2. by using "should" instead of "can", and also rename its
> parameters and add some commentary to make it more explicit what they
> mean.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  mm/compaction.c |  4 ++--
>  mm/internal.h   |  2 +-
>  mm/page_alloc.c | 42 ++++++++++++++++++++++--------------------
>  3 files changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 12ed8425fa175c5dec50bac3dddb13499abaaa11..8dccb2e388f128dd134ec6f24c924c118c9c93bb 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2332,7 +2332,7 @@ static enum compact_result __compact_finished(struct compact_control *cc)
>  	ret = COMPACT_NO_SUITABLE_PAGE;
>  	for (order = cc->order; order < NR_PAGE_ORDERS; order++) {
>  		struct free_area *area = &cc->zone->free_area[order];
> -		bool can_steal;
> +		bool whole_block;
>
>  		/* Job done if page is free of the right migratetype */
>  		if (!free_area_empty(area, migratetype))
> @@ -2349,7 +2349,7 @@ static enum compact_result __compact_finished(struct compact_control *cc)
>  		 * other migratetype buddy lists.
>  		 */
>  		if (find_suitable_fallback(area, order, migratetype,
> -						true, &can_steal) != -1)
> +						true, &whole_block) != -1)

This one e.g. would look clearer with &block_claimable.

Not that it's actually used...

> @@ -1948,7 +1948,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
>  	if (boost_watermark(zone) && (alloc_flags & ALLOC_KSWAPD))
>  		set_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
>  
> -	/* We are not allowed to try stealing from the whole block */
> +	/* No point in stealing from the whole block */

The original comment actually makes more sense to me. Why is there no
point? It could well find enough free+alike pages to steal the
block... It's just not allowed to.

I will say, the current code is pretty hard to reason about:

On one hand we check the block size statically in can_steal_fallback;
on the other hand, we do that majority scan for compatible pages in
steal_suitable_fallback(). The effective outcomes are hard to discern,
and I'm honestly not convinced they're all intentional.

For example, if we're allowed to steal the block because of this in
can_steal_fallback():

	order >= pageblock_order/2

surely, we'll always satisfy this in steal_suitable_fallback()

	free_pages + alike_pages >= (1 << (pageblock_order-1)

on free_pages alone.

And if the order is less than half a block, we're only allowed an
attempt at stealing it if this is true in can_steal_fallback():

	start_type == MIGRATE_RECLAIMABLE ||
	start_type == MIGRATE_UNMOVABLE

So why is the majority scan in steal_suitable_fallback() checking:

	if (start_type == MIGRATE_MOVABLE)
		alike_pages = movable_pages

Here is how I read the effective rules:

- We always steal the block if at least half of it is free.

- If less than half is free, but more than half is compatible (free +
  alike), we currently do movable -> non-movable conversions.

  We don't do non-movable -> movable (won't get to the majority scan).
  This seems reasonable to me, as there seems to be little value in
  making a new pre-polluted movable block.

- However, we do non-movable -> movable conversion if more than half
  is free. This is seemingly in conflict with the previous point.

Then there is compaction, which currently uses only the
find_suitable_fallback() subset of the rules. Namely, for kernel
allocations, compaction stops as soon as there is an adequately sized
fallback. Even if the allocator won't convert the block due to the
majority scan. For movable requests, we'll stop if there is half a
block to fall back to. I suppose that's reasonable - the old
utilization vs. fragmentation debate aside...

Did I miss one?

We should be able to encode all this more concisely.

> @@ -1995,12 +1995,14 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
>  
>  /*
>   * Check whether there is a suitable fallback freepage with requested order.
> - * If only_stealable is true, this function returns fallback_mt only if
> - * we can steal other freepages all together. This would help to reduce
> + * Sets *whole_block to instruct the caller whether it should convert a whole
> + * pageblock to the returned migratetype.
> + * If need_whole_block is true, this function returns fallback_mt only if
> + * we would do this whole-block stealing. This would help to reduce
>   * fragmentation due to mixed migratetype pages in one pageblock.
>   */
>  int find_suitable_fallback(struct free_area *area, unsigned int order,
> -			int migratetype, bool only_stealable, bool *can_steal)
> +			int migratetype, bool need_whole_block, bool *whole_block)
>  {
>  	int i;
>  	int fallback_mt;
> @@ -2008,19 +2010,19 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
>  	if (area->nr_free == 0)
>  		return -1;
>  
> -	*can_steal = false;
> +	*whole_block = false;
>  	for (i = 0; i < MIGRATE_PCPTYPES - 1 ; i++) {
>  		fallback_mt = fallbacks[migratetype][i];
>  		if (free_area_empty(area, fallback_mt))
>  			continue;
>  
> -		if (can_steal_fallback(order, migratetype))
> -			*can_steal = true;
> +		if (should_steal_whole_block(order, migratetype))
> +			*whole_block = true;
>  
> -		if (!only_stealable)
> +		if (!need_whole_block)
>  			return fallback_mt;
>  
> -		if (*can_steal)
> +		if (*whole_block)
>  			return fallback_mt;
>  	}

This loop is quite awkward, but I think it actually gets more awkward
with the new names.

Consider this instead:

		*block_claimable = can_claim_block(order, migratetype);
		if (*block_claimable || !need_whole_block)
			return fallback_mt;

Or better yet, inline that function completely. There are no other
callers, and consolidating the rules into fewer places would IMO go a
long way of making it easier to follow:

		if (order >= pageblock_order/2 ||
		    start_mt == MIGRATE_RECLAIMABLE ||
		    start_mt == MIGRATE_UNMOVABLE)
			*block_claimable = true;

		if (*block_claimable || !need_whole_block)
			return fallback_mt;

