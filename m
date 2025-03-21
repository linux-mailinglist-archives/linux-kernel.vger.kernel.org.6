Return-Path: <linux-kernel+bounces-570743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F45A6B418
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C2E37A781F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5B41E7C1E;
	Fri, 21 Mar 2025 05:40:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DAC12E7F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742535631; cv=none; b=M56yzAjFXvr5GJ3bbSvBypTA/DrKYscMXJtgT+3l5/VqS6voqTHcYgukx0pHDR6d83o/7sKQyphJUtOe51ek0yAjNgxjRTxeL7wMJwqqyifpvpyo9agMg0MYAagHv22dK1QGBY+h1DMqVF1PAYfit3t+kmGq1+ZyydXravcpXLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742535631; c=relaxed/simple;
	bh=v9mlHIVf03ghme1Xp2oa7igvwNmTaySCr7MbctpPrwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjX+zh/Tt5By/qDiMFT0JEAY62wWhfVgbzETYO50TJQyU6qdSzEUNyzlCENQ5AfcfXu0FT1PmYELZthY9hMLLTFdB15aO6cOMMxOZbRpmUt9lDRWD1z7RtzLukTjdmZaJjERFxTlQPDDizlv7quzLg7BVbCCC38PwShptu+fZFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B28FF106F;
	Thu, 20 Mar 2025 22:40:35 -0700 (PDT)
Received: from [10.162.16.153] (a077893.blr.arm.com [10.162.16.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 905973F694;
	Thu, 20 Mar 2025 22:40:26 -0700 (PDT)
Message-ID: <b7347fad-9ea8-424b-b000-e3d01dfe0dd1@arm.com>
Date: Fri, 21 Mar 2025 11:10:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: Consolidate unlikely handling in
 page_expected_state
To: Ye Liu <ye.liu@linux.dev>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Ye Liu <liuye@kylinos.cn>
References: <20250321011304.549908-1-ye.liu@linux.dev>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250321011304.549908-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/21/25 06:43, Ye Liu wrote:
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
> ---
>  mm/page_alloc.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2842da893eea..d8d04ac1d709 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -892,6 +892,13 @@ static inline bool page_expected_state(struct page *page,
>  	if (unlikely(atomic_read(&page->_mapcount) != -1))
>  		return false;
>  
> +	if (unlikely(PageHWPoison(page))) {
> +		/* Don't complain about hwpoisoned pages */
> +		if (PageBuddy(page))
> +			__ClearPageBuddy(page);
> +		return false;

Should this be return 'true' instead ?

Let's consider a scenario where PageHWPoison(page) is true.

Previously bad_page() was not getting called as check_new_page_bad() will
return earlier before reaching bad_page().

But now with the proposed change here page_expected_state() returns false
and hence bad_page() still gets called later on in check_new_page().

There is a change in behaviour - or am I missing something here ?

> +	}
> +
>  	if (unlikely((unsigned long)page->mapping |
>  			page_ref_count(page) |
>  #ifdef CONFIG_MEMCG
> @@ -1586,29 +1593,16 @@ static __always_inline void page_del_and_expand(struct zone *zone,
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
> +	bad_page(page,
> +		 page_bad_reason(page, PAGE_FLAGS_CHECK_AT_PREP));
>  	return true;
>  }
> 

