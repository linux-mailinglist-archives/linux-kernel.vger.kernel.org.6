Return-Path: <linux-kernel+bounces-570707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5401CA6B3BF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9493A879F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 04:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC291E833F;
	Fri, 21 Mar 2025 04:39:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7754206B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742531965; cv=none; b=YY7QMQYwP1XiyfDrTxBYBP4p45Y8f+99g10uGAqnRTSFiwv4yezOEmNna/Jm5E/DDP3rgXlwLwoIThzWOaapuzgUqv2kZggY4xPkc1y4sGsSCoDbvKloGaZzstLrPUCXZk3VWiCzehRg077Jq2MbsOQlpPoMBOUaDBddJGEXl48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742531965; c=relaxed/simple;
	bh=RCpK+zXwVkMQ3+wqXY0R/x4FlYrtxzzjQ/GRlu6GxUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qaraIzd5MS6H7AwzIp4Kzt76biQEEtY3TIacWZ9SZdylFjQIKW/z9l+zFHj25k5ZpeaOnk5tOHttxXmYaWpATw5TP72HhsBLRTMe14hMTbKIvU7DU9FrYe9honei4lZqEjtOqLzLfuloAvufyv5UEQLg6opQEB9YU3m98rJppuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9508106F;
	Thu, 20 Mar 2025 21:39:29 -0700 (PDT)
Received: from [10.162.16.153] (a077893.blr.arm.com [10.162.16.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4E263F673;
	Thu, 20 Mar 2025 21:39:20 -0700 (PDT)
Message-ID: <edac5f77-529c-4705-8bd5-df7f6e9fdfab@arm.com>
Date: Fri, 21 Mar 2025 10:09:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: Simplify free_page_is_bad by removing
 free_page_is_bad_report
To: Ye Liu <ye.liu@linux.dev>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Ye Liu <liuye@kylinos.cn>
References: <20250321010710.548105-1-ye.liu@linux.dev>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250321010710.548105-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/21/25 06:37, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> This patch refactors the free_page_is_bad function by directly calling
> bad_page() instead of using the intermediary function
> free_page_is_bad_report(). The removal of free_page_is_bad_report()
> reduces unnecessary indirection, making the code cleaner and easier to
> read.
> 
> The functionality remains the same, as free_page_is_bad_report() was
> merely a wrapper for the bad_page() call. The patch also improves
> maintainability by reducing the function call depth.

Seems to be a sensible clean up indeed.

> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> ---
>  mm/page_alloc.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 61d6a3b1b286..2842da893eea 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -933,19 +933,14 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
>  	return bad_reason;
>  }
>  
> -static void free_page_is_bad_report(struct page *page)
> -{
> -	bad_page(page,
> -		 page_bad_reason(page, PAGE_FLAGS_CHECK_AT_FREE));
> -}
> -
>  static inline bool free_page_is_bad(struct page *page)
>  {
>  	if (likely(page_expected_state(page, PAGE_FLAGS_CHECK_AT_FREE)))
>  		return false;
>  
>  	/* Something has gone sideways, find it */
> -	free_page_is_bad_report(page);
> +	bad_page(page,
> +		 page_bad_reason(page, PAGE_FLAGS_CHECK_AT_FREE));

Please fold these above two lines into a single line instead.

bad_page(page, page_bad_reason(page, PAGE_FLAGS_CHECK_AT_FREE));

>  	return true;
>  }
>  

With the above suggested change in place.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

