Return-Path: <linux-kernel+bounces-573144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25521A6D389
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 05:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5CE3B1229
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 04:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE1218A6AF;
	Mon, 24 Mar 2025 04:30:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0AF18B03
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 04:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742790600; cv=none; b=BttNjw/iO8dCqm1/ayavej+m7TtqCz+mSqUKoXLjXRLxlcRmCnV2UK/7jRMVw+GvFt9ZJko6AcCoUbuuuyOYkLREeQd6bCOAyaYTmRnwAbOeqktsnEXN27AsVMznp503uV/LLYP43/5dX9GYQ18LIRMejVMl7NsKZyZr7GcboO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742790600; c=relaxed/simple;
	bh=QmI2lau01W6wmxR1l63MAogpGgCCTvB4TWfl9pkVHZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nalp+5QSk8cBZos5+Mu9tJLkoY4NWBnoCHDwWf+3vddA7hm14XjjYmzKZ4H8S+uwiVjRzsL5TYwgfv4muvvFguciQUsQxs8kWKyn61zTgNndmSrmEJf0KTWununx3yIg7mm4zUISAQufRKtkeQtYwX67YBVN8oGtVBi5tnexxak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23CA71A2D;
	Sun, 23 Mar 2025 21:30:04 -0700 (PDT)
Received: from [10.162.16.153] (a077893.blr.arm.com [10.162.16.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DD3A3F58B;
	Sun, 23 Mar 2025 21:29:55 -0700 (PDT)
Message-ID: <33be2fbc-2572-4faf-be3e-9ec73126cc53@arm.com>
Date: Mon, 24 Mar 2025 09:59:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/page_alloc: Consolidate unlikely handling in
 page_expected_state
To: Ye Liu <ye.liu@linux.dev>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Ye Liu <liuye@kylinos.cn>
References: <20250321062053.607044-1-ye.liu@linux.dev>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250321062053.607044-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/21/25 11:50, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> This patch consolidates the handling of unlikely conditions in the
> page_expected_state function, reducing code duplication and improving
> readability.
> 
> Previously, the check_new_page_bad function contained logic to handle
> __PG_HWPOISON flags, which was called from check_new_page. This patch
> moves the handling of __PG_HWPOISON flags into the page_expected_state
> function and removes the check_new_page_bad function. The check_new_page
> function now directly calls bad_page if the page has unexpected flags.
> 
> This change simplifies the code by reducing the number of functions and
> centralizing the unlikely condition handling in one place.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> 
> ---
> V2: return true instead of false in the PageHWPoison branch.
> ---
> ---
>  mm/page_alloc.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2842da893eea..e8b95c6a96c2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -903,6 +903,12 @@ static inline bool page_expected_state(struct page *page,
>  			(page->flags & check_flags)))
>  		return false;
>  
> +	if (unlikely(PageHWPoison(page))) {
> +		/* Don't complain about hwpoisoned pages */
> +		if (PageBuddy(page))
> +			__ClearPageBuddy(page);
> +	}
> +
>  	return true;
>  }
>  
> @@ -1586,29 +1592,15 @@ static __always_inline void page_del_and_expand(struct zone *zone,
>  	account_freepages(zone, -nr_pages, migratetype);
>  }
>  
> -static void check_new_page_bad(struct page *page)
> -{
> -	if (unlikely(PageHWPoison(page))) {
> -		/* Don't complain about hwpoisoned pages */
> -		if (PageBuddy(page))
> -			__ClearPageBuddy(page);
> -		return;
> -	}
> -
> -	bad_page(page,
> -		 page_bad_reason(page, PAGE_FLAGS_CHECK_AT_PREP));
> -}
> -
>  /*
>   * This page is about to be returned from the page allocator
>   */
>  static bool check_new_page(struct page *page)
>  {
> -	if (likely(page_expected_state(page,
> -				PAGE_FLAGS_CHECK_AT_PREP|__PG_HWPOISON)))
> +	if (likely(page_expected_state(page, PAGE_FLAGS_CHECK_AT_PREP)))
>  		return false;
>  
> -	check_new_page_bad(page);
> +	bad_page(page, page_bad_reason(page, PAGE_FLAGS_CHECK_AT_PREP));
>  	return true;
>  }
>  

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

