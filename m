Return-Path: <linux-kernel+bounces-515409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A1DA3647C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE483B3A41
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC402686BA;
	Fri, 14 Feb 2025 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="l+VNROrw"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFFC26868B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553641; cv=none; b=ru/Ly13XwZgFaio8n68UGpNjkl6sqgVL9UZt8ucGnx4mtV0lQZWLinoJfhcVBSGrKaekAYTFIoee2jOaaT4GGV3jjpqMXHIz+THkBepx1AEthPIb1UGKa1KR8zutNW0+Aa85yeQa9nHLj1X7FzxSdYHnGxOBUUqDmiD3OqK8cyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553641; c=relaxed/simple;
	bh=VWbqp6K4LKAeLxmPZl8xyZnpdMT4p8X4Ma3HukStCmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4sRjFlohSbV4+Ub+EQhzBHOBk606GrU80gawGlLHxbzx15jCj6xF07fd0aviaRfVroWeUokQeIvFB8zqJciXe/q9IafKe9GtLFofLZK8LNVrJwaCuvsLRhN+1RzHF7SQ6os3xDOBapfhz7+WNvxzEjz6F803EZZ3yS1pYmnb8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=l+VNROrw; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46fa734a0b8so20611661cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1739553637; x=1740158437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+WVkzj3W35ksC2Q0LSJkzIeq5cPfQkeGpHe47IdtgQ4=;
        b=l+VNROrwHry5H2AfX3QFTQpsS65yxwexmNgr4HczZUmSsAg+U5hfttc0WI+FNuVIVV
         cNABtr/oLX3ld3+sVbBEh1ZKbBlxCB0kPXOGhNugKHYVAhtUftGoEcnjRn8k6KDl0zRw
         ar3TfjI1IYrxt6J8AUcRnDRrPMaeCTBpBDdZb31PNmmcgmyl/me9aw27JcNGNiZUOyiB
         Smz4GoocuBHozVCXsLHGltoSQmt9fn+KGUZFCwQRMOKyooj7vX7PZabjQriP3L/8197h
         cKoIpDMV+vNeuYyXbiF1ZFLO+FntEIpPDiYS+5uG9Juw/6egTZSfD1HixEHV4MXqz5RB
         a1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739553637; x=1740158437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WVkzj3W35ksC2Q0LSJkzIeq5cPfQkeGpHe47IdtgQ4=;
        b=QabkvY/IxMLgf7oaVyQlnHR2X9bTtbObh2mjcib3GMWF/VxPLvr9vdNj6Ow5/34Whf
         ha/Z86KJ/c4OjesQ0M6O/M0po5iW4uVOpyrpJWIU9PlrjPe7JRwTNqGCPbt1n9SHTkXt
         LOidZAHJ0SZDI7PNjDMF9WLiBH6sqBL2VZi/h+xHT8p8BT7MFRZJqOkX/XZbqPYNq6k8
         aq+AgcXTZz+MJCKu2iyAVijGy9gj7VUdAgmK4WHa0maN07iZrX5sP0MudISXzhBELSRL
         ZmPhTJbQQovCk4AuDFiEGmmYvKtEiAS8Xl2btj6Bz7Lxy1wfx/vndlJotVTpA1Q1CPfw
         2ZAg==
X-Forwarded-Encrypted: i=1; AJvYcCUDQKzP/pZu/QD/EwX9JQYGG61DOE77GE24j+BBNrycgNAR0PMM4osgakA3jCFqEXMfhtHB/71jWtSsCtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFsdBQwW2P93HbMOwFOTGFkxu+JsCKJJRqXaCIt+1SVhU1ZQ6x
	YrAhkbAFdsjX0OuJELDdORAEQn0ztZMlUoOmuvL1lnJhm3odFnnKlgtrNVT2pqElsIpmsJhAWRs
	s
X-Gm-Gg: ASbGncvxcOk5773aZ/qNx9g1qn3B6317mWAE6xrjuWMoC9Cj95YCCQXBcYZKT9FI31N
	UA/rLPQiO52Pw9Lf2zYvwoMErnjfhTnjKzv4nF8Mxm9jyoYEa1EvIr4fdVp5wIzIJu/3+ebAMbk
	XOq+vnfiFtlx2KGNBqAWnZWfxNpNVH3SNsgsInMZLZCtodUZvr1oNlbHiE4sgzQjQJ1lJwvBkV3
	2rUJ77dr1avpZ7cb358XU5utnzE8Ms+KeXiZwmJtgYjZtfZdP3MfQOzaxedzXRenH4hUDH4j3+e
	MHZbWbFakMOCSw==
X-Google-Smtp-Source: AGHT+IEfP2No6YtmM8ekpuXeOM+ZQKYz8NNrVM/VTB4q0JY4WMrcdrPqF3XRNKQUatLdTYn9ckBCbA==
X-Received: by 2002:a05:6214:27e2:b0:6d8:916b:1caa with SMTP id 6a1803df08f44-6e66cce6e34mr273476d6.27.1739553636676;
        Fri, 14 Feb 2025 09:20:36 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e65d78492bsm22992346d6.31.2025.02.14.09.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:20:36 -0800 (PST)
Date: Fri, 14 Feb 2025 12:20:32 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mm/page_isolation: remove migratetype from
 move_freepages_block_isolate()
Message-ID: <20250214172032.GA241035@cmpxchg.org>
References: <20250214154215.717537-1-ziy@nvidia.com>
 <20250214154215.717537-3-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214154215.717537-3-ziy@nvidia.com>

On Fri, Feb 14, 2025 at 10:42:13AM -0500, Zi Yan wrote:
> Since migratetype is no longer overwritten during pageblock isolation,
> moving pageblocks to and from MIGRATE_ISOLATE do not need migratetype.
> 
> Rename move_freepages_block_isolate() to share common code and add
> pageblock_isolate_and_move_free_pages() and
> pageblock_unisolate_and_move_free_pages() to be explicit about the page
> isolation operations.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  include/linux/page-isolation.h |  4 +--
>  mm/page_alloc.c                | 48 +++++++++++++++++++++++++++-------
>  mm/page_isolation.c            | 21 +++++++--------
>  3 files changed, 51 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
> index 51797dc39cbc..28c56f423e34 100644
> --- a/include/linux/page-isolation.h
> +++ b/include/linux/page-isolation.h
> @@ -27,8 +27,8 @@ static inline bool is_migrate_isolate(int migratetype)
>  
>  void set_pageblock_migratetype(struct page *page, int migratetype);
>  
> -bool move_freepages_block_isolate(struct zone *zone, struct page *page,
> -				  int migratetype);
> +bool pageblock_isolate_and_move_free_pages(struct zone *zone, struct page *page);
> +bool pageblock_unisolate_and_move_free_pages(struct zone *zone, struct page *page);
>  
>  int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  			     int migratetype, int flags);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f17f4acc38c6..9bba5b1c4f1d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1848,10 +1848,10 @@ static unsigned long find_large_buddy(unsigned long start_pfn)
>  }
>  
>  /**
> - * move_freepages_block_isolate - move free pages in block for page isolation
> + * __move_freepages_for_page_isolation - move free pages in block for page isolation
>   * @zone: the zone
>   * @page: the pageblock page
> - * @migratetype: migratetype to set on the pageblock
> + * @isolate_pageblock to isolate the given pageblock or unisolate it
>   *
>   * This is similar to move_freepages_block(), but handles the special
>   * case encountered in page isolation, where the block of interest
> @@ -1866,10 +1866,15 @@ static unsigned long find_large_buddy(unsigned long start_pfn)
>   *
>   * Returns %true if pages could be moved, %false otherwise.
>   */
> -bool move_freepages_block_isolate(struct zone *zone, struct page *page,
> -				  int migratetype)
> +static bool __move_freepages_for_page_isolation(struct zone *zone,
> +		struct page *page, bool isolate_pageblock)

I'm biased, but I think the old name is fine.

bool isolate?

>  {
>  	unsigned long start_pfn, pfn;
> +	int from_mt;
> +	int to_mt;
> +
> +	if (isolate_pageblock == get_pageblock_isolate(page))
> +		return false;
>  
>  	if (!prep_move_freepages_block(zone, page, &start_pfn, NULL, NULL))
>  		return false;
> @@ -1886,7 +1891,10 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
>  
>  		del_page_from_free_list(buddy, zone, order,
>  					get_pfnblock_migratetype(buddy, pfn));
> -		set_pageblock_migratetype(page, migratetype);
> +		if (isolate_pageblock)
> +			set_pageblock_isolate(page);
> +		else
> +			clear_pageblock_isolate(page);

Since this pattern repeats, maybe create a toggle function that does this?

		set_pfnblock_flags_mask(page, (isolate << PB_migrate_isolate),
					page_to_pfn(page),
					(1 << PB_migrate_isolate));

>  		split_large_buddy(zone, buddy, pfn, order, FPI_NONE);
>  		return true;
>  	}
> @@ -1897,16 +1905,38 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
>  
>  		del_page_from_free_list(page, zone, order,
>  					get_pfnblock_migratetype(page, pfn));
> -		set_pageblock_migratetype(page, migratetype);
> +		if (isolate_pageblock)
> +			set_pageblock_isolate(page);
> +		else
> +			clear_pageblock_isolate(page);
>  		split_large_buddy(zone, page, pfn, order, FPI_NONE);
>  		return true;
>  	}
>  move:
> -	__move_freepages_block(zone, start_pfn,
> -			       get_pfnblock_migratetype(page, start_pfn),
> -			       migratetype);
> +	if (isolate_pageblock) {
> +		from_mt = __get_pfnblock_flags_mask(page, page_to_pfn(page),
> +				MIGRATETYPE_MASK);
> +		to_mt = MIGRATE_ISOLATE;
> +	} else {
> +		from_mt = MIGRATE_ISOLATE;
> +		to_mt = __get_pfnblock_flags_mask(page, page_to_pfn(page),
> +				MIGRATETYPE_MASK);
> +	}
> +
> +	__move_freepages_block(zone, start_pfn, from_mt, to_mt);
>  	return true;

Keeping both MIGRATE_ISOLATE and PB_migrate_isolate encoding the same
state is fragile. At least in the pfnblock bitmask, there should only
be one bit encoding this.

Obviously, there are many places in the allocator that care about
freelist destination: they want MIGRATE_ISOLATE if the bit is set, and
the "actual" type otherwise.

I think what should work is decoupling enum migratetype from the
pageblock bits, and then have a parsing layer on top like this:

enum migratetype {
	MIGRATE_UNMOVABLE,
	...
	MIGRATE_TYPE_BITS,
	MIGRATE_ISOLATE = MIGRATE_TYPE_BITS,
	MIGRATE_TYPES
};

#define PB_migratetype_bits MIGRATE_TYPE_BITS

static enum migratetype get_pageblock_migratetype()
{
	flags = get_pfnblock_flags_mask(..., MIGRATETYPE_MASK | (1 << PB_migrate_isolate));
	if (flags & (1 << PB_migrate_isolate))
		return MIGRATE_ISOLATE;
	return flags;
}

