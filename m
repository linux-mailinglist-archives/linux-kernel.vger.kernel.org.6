Return-Path: <linux-kernel+bounces-531475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDE9A440EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518F43A9FED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139552690F8;
	Tue, 25 Feb 2025 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PyzfEqx3"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6333A1DB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490480; cv=none; b=EVkYs8YHVbkVuUhBbr6X+xwiGKNXGzIG2WyNIMktYSna4+QiHdoOnPF83jFOEPu+qdsB2hnWDdSV/wJ969F1tOmwFJ6k3Iu1C+uOJ2E6IGKFk7pYDnEcr7Xv9FZAVCg5mzQtn3bPhUkbaIHqFPhbaWapjt9yuwXr4YeGQTckdW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490480; c=relaxed/simple;
	bh=+K+g144L+ZN9DMzdDL2EkahPOa8eXTahQuhHm51dSms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcgr+2PYQP/Icn6SFB5UhVqHhX+AzjSmsGZRICftubhcOC0k7++3NNDxOGmaxYAAAcZdw3PCWXbG0pRpfjlxOXJYE1FtRNQwd1gylArcHSUXTrrwzYbs+amyl9OcV4OJdSYPL5bWTNelGggxkh9K1vt29UhFLUCDxDBgvU9+T08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PyzfEqx3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4393ee912e1so40685e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740490477; x=1741095277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1XPlcI28gI5oChrIiNVecq25q0LkKn4pW0JK0o6KpS0=;
        b=PyzfEqx3tMbWIrtkbEqpgLBL1Z2+XGaL0w3S8dONSB2CKXRdirW4JD2Ae3z+XzPtm5
         RD7/ipt+OD3iOV1YIKMXkGegkaw/mhrkanYUiF4IqMd0CP3rORxl0IDsJa3Weu/VFj64
         mIZp8W4OBsv3l9IzqpJLyO0i94OFDoBFQzGiUSmV6yJRpIyZjS6qGx+AR2pc5oBuZV93
         oh9jXzwH7EF3rsvo2i8v/1mkbpHQH06MdiqfRzyJTxO5R0vcsds2CLKwShfzANxYHQ9P
         Fr/oCHlodzG6vRllP9R7zjjmuHsAMMYj4qPaixlN+d74z2RwTSlkkaD3/9yIRJbjttUe
         3H8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740490477; x=1741095277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XPlcI28gI5oChrIiNVecq25q0LkKn4pW0JK0o6KpS0=;
        b=RC7noK07Hs8VqiYS8CVYeGhkNdOpiSs0N+7cV/wGE+L5KOP74rK9HXrCTRxJU84ldt
         Z7n7jHt5LA68+kFg+Jh0C/M1sDMK+uzHmNL6nGY8bGLbA4xL+lhquFNqiQ6WS4/YjJ3a
         KPvVKqBV/G063YTKjDX8ylxuxLruzMSyC5dHoipeWCO6v85WupWDhHoDiby2MpqFcCpN
         fBRCIZcY74J4pbtEyZ0qywUSDzOZi2tuFBinsW71zbV/2Lu5sT5sn0HU1gpOsonOyk8r
         ZKBHH7cRXWZIxyQpnsp4jIxAsIxIw35Yr55GhZHeWd4mbc4k5pzVGTXaZv83Ck3sM5pZ
         ndjw==
X-Forwarded-Encrypted: i=1; AJvYcCWmxMsCHKnR2e+JSpCHuayuz0MoI/1YiONkpwwUjwWslfTa/hWoRkayZ7vD8DLSa8NEVjBL/p4vuC7StLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu7OU9Ir2wmSoMDMp+cs/R5YKg7gy/R008XyutSToFG+1FZwh9
	iE6HPd5/l1FPxW+R7zWJRpKOFfRI9LDblRPvQn8R7s2k40SyPnp28cOQ78W/uA==
X-Gm-Gg: ASbGnctEDhAdA5GfJfxsftWDzaB48/Y7Tafn0/rGy80krJVOefgYY/vYv8pGHwa3Nib
	Q5Y9eauStwTwyooj/Fckv9DXgeEY8T/r2EcWGlju6IVAFUZzs4wYDQrXJzkE9t5K4T0bwjJupGo
	+UkQgHa0/ssRVU1tPS1ShLaNrQBBbumBnpFgjAFRpeanSRbne9eRqUnpxbMlMffdEX/qc8k5wpA
	bhqv+lCH04Sh8pSssaSSLXHwHY7CrS7rJRs8GpLoJ49NK624wLMTMn16skxy5WuhEOah6l14z2l
	o8JxXI98y3Ey9FbEmbpxyqDbBTUGnJFvNnRfhOr0MMgZdC9YQk0CqshZ/EcOeg==
X-Google-Smtp-Source: AGHT+IFgarIShp/PegXB9yEBD9d5JJwHidwtjyIFC7IcNoRQMLs6o2EYyQwp8nXRryIOXgFHEMrOsA==
X-Received: by 2002:a05:600c:56d1:b0:439:961d:fc7d with SMTP id 5b1f17b1804b1-43ab10378dcmr1431035e9.6.1740490476743;
        Tue, 25 Feb 2025 05:34:36 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1546f77sm26215295e9.20.2025.02.25.05.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:34:36 -0800 (PST)
Date: Tue, 25 Feb 2025 13:34:32 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: page_alloc: don't steal single pages from
 biggest buddy
Message-ID: <Z73G6A6asz_KrGTo@google.com>
References: <20250225001023.1494422-1-hannes@cmpxchg.org>
 <20250225001023.1494422-2-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225001023.1494422-2-hannes@cmpxchg.org>

On Mon, Feb 23, 2025 at 07:08:24PM -0500, Johannes Weiner wrote:
> The fallback code searches for the biggest buddy first in an attempt
> to steal the whole block and encourage type grouping down the line.
> 
> The approach used to be this:
> 
> - Non-movable requests will split the largest buddy and steal the
>   remainder. This splits up contiguity, but it allows subsequent
>   requests of this type to fall back into adjacent space.
> 
> - Movable requests go and look for the smallest buddy instead. The
>   thinking is that movable requests can be compacted, so grouping is
>   less important than retaining contiguity.
> 
> c0cd6f557b90 ("mm: page_alloc: fix freelist movement during block
> conversion") enforces freelist type hygiene, which restricts stealing
> to either claiming the whole block or just taking the requested chunk;
> no additional pages or buddy remainders can be stolen any more.
> 
> The patch mishandled when to switch to finding the smallest buddy in
> that new reality. As a result, it may steal the exact request size,
> but from the biggest buddy. This causes fracturing for no good reason.
> 
> Fix this by committing to the new behavior: either steal the whole
> block, or fall back to the smallest buddy.
> 
> Remove single-page stealing from steal_suitable_fallback(). Rename it
> to try_to_steal_block() to make the intentions clear. If this fails,
> always fall back to the smallest buddy.

Nit - I think the try_to_steal_block() changes could be a separate
patch, the history might be easier to understand if it went:

[1/N] mm: page_alloc: don't steal single pages from biggest buddy
[2/N] mm: page_alloc: drop unused logic in steal_suitable_fallback()

(But not a big deal, it's not that hard to follow as-is).

>  static __always_inline struct page *
>  __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
> @@ -2291,45 +2289,35 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
>  		if (fallback_mt == -1)
>  			continue;
>  
> -		/*
> -		 * We cannot steal all free pages from the pageblock and the
> -		 * requested migratetype is movable. In that case it's better to
> -		 * steal and split the smallest available page instead of the
> -		 * largest available page, because even if the next movable
> -		 * allocation falls back into a different pageblock than this
> -		 * one, it won't cause permanent fragmentation.
> -		 */
> -		if (!can_steal && start_migratetype == MIGRATE_MOVABLE
> -					&& current_order > order)
> -			goto find_smallest;
> +		if (!can_steal)
> +			break;
>  
> -		goto do_steal;
> +		page = get_page_from_free_area(area, fallback_mt);
> +		page = try_to_steal_block(zone, page, current_order, order,
> +					  start_migratetype, alloc_flags);
> +		if (page)
> +			goto got_one;
>  	}
>  
> -	return NULL;
> +	if (alloc_flags & ALLOC_NOFRAGMENT)
> +		return NULL;

Is this a separate change? Is it a bug that we currently allow
stealing a from a fallback type when ALLOC_NOFRAGMENT? (I wonder if
the second loop was supposed to start from min_order).

>  
> -find_smallest:
> +	/* No luck stealing blocks. Find the smallest fallback page */
>  	for (current_order = order; current_order < NR_PAGE_ORDERS; current_order++) {
>  		area = &(zone->free_area[current_order]);
>  		fallback_mt = find_suitable_fallback(area, current_order,
>  				start_migratetype, false, &can_steal);
> -		if (fallback_mt != -1)
> -			break;
> -	}
> -
> -	/*
> -	 * This should not happen - we already found a suitable fallback
> -	 * when looking for the largest page.
> -	 */
> -	VM_BUG_ON(current_order > MAX_PAGE_ORDER);
> +		if (fallback_mt == -1)
> +			continue;
>  
> -do_steal:
> -	page = get_page_from_free_area(area, fallback_mt);
> +		page = get_page_from_free_area(area, fallback_mt);
> +		page_del_and_expand(zone, page, order, current_order, fallback_mt);
> +		goto got_one;
> +	}
>  
> -	/* take off list, maybe claim block, expand remainder */
> -	page = steal_suitable_fallback(zone, page, current_order, order,
> -				       start_migratetype, alloc_flags, can_steal);
> +	return NULL;
>  
> +got_one:
>  	trace_mm_page_alloc_extfrag(page, order, current_order,
>  		start_migratetype, fallback_mt);

