Return-Path: <linux-kernel+bounces-570754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA32FA6B436
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D021894A78
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5095B1E9B2B;
	Fri, 21 Mar 2025 05:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T90ybZgH"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8E533F6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742536794; cv=none; b=pRJodijsiu7Dd2muAoTFoT+TdmBaSUNjn1deakHQN682nl6/dYT8qTLKrlCzfBYTfQSG03YpT+7aapTFxwLoRC3SGy3D/f2Vh7ZaOFpAuZKl+5jlhximK73GIk+sOvMtFalYct9a8v3eTEMbu87xpeGcnv5dTEifvs7+GzUHbp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742536794; c=relaxed/simple;
	bh=dbY/Iub9rCgGKGsBwjfytkJln+OhpdBswIld18cotho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CESX+WgRVzbzXaKaZ/0IgkyHCJLlFlzR+5uxXuL++hyxlyJsn2fN14jhqVEAdQe3yUlCP+tQpOCsDym9yIqtx5due+Kwte9Xe1YbuqeGGfHviCq/MuNXjUZInbgvbFzl0hS529G+x/kbkQdTkfpp3GGLa7haucX70ZYzzsLynlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T90ybZgH; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e7648222-cb56-4de0-9a69-457eba87df85@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742536789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BkqHjZgI7wlamaIPE8JerqKos0bZ+qhyqzjC0Lk4oPM=;
	b=T90ybZgHo9zb7zbPOI4gDs5AnxTrSgIjrwGEBeustIyACHEB6Zg17SYxMqdOYp0VIp8gBH
	xuvgFmT+VGo5iI2F/sEctW5sszmasZ5y/BwEhBgMRH30M2tVGBkph0tqrP6Sq0BQ5VqVDS
	IyP0LR+eTESw7xB2AqIz9uOreI4A9kQ=
Date: Fri, 21 Mar 2025 13:59:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/page_alloc: Consolidate unlikely handling in
 page_expected_state
To: Anshuman Khandual <anshuman.khandual@arm.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Ye Liu <liuye@kylinos.cn>
References: <20250321011304.549908-1-ye.liu@linux.dev>
 <b7347fad-9ea8-424b-b000-e3d01dfe0dd1@arm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <b7347fad-9ea8-424b-b000-e3d01dfe0dd1@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/3/21 13:40, Anshuman Khandual 写道:
>
> On 3/21/25 06:43, Ye Liu wrote:
>> From: Ye Liu <liuye@kylinos.cn>
>>
>> This patch consolidates the handling of unlikely conditions in the
>> page_expected_state function, reducing code duplication and improving
>> readability.
>>
>> Previously, the check_new_page_bad function contained logic to handle
>> __PG_HWPOISON flags, which was called from check_new_page. This patch
>> moves the handling of __PG_HWPOISON flags into the page_expected_state
>> function and removes the check_new_page_bad function. The check_new_page
>> function now directly calls bad_page if the page has unexpected flags.
>>
>> This change simplifies the code by reducing the number of functions and
>> centralizing the unlikely condition handling in one place.
>>
>> Signed-off-by: Ye Liu <liuye@kylinos.cn>
>> ---
>>  mm/page_alloc.c | 26 ++++++++++----------------
>>  1 file changed, 10 insertions(+), 16 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 2842da893eea..d8d04ac1d709 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -892,6 +892,13 @@ static inline bool page_expected_state(struct page *page,
>>  	if (unlikely(atomic_read(&page->_mapcount) != -1))
>>  		return false;
>>  
>> +	if (unlikely(PageHWPoison(page))) {
>> +		/* Don't complain about hwpoisoned pages */
>> +		if (PageBuddy(page))
>> +			__ClearPageBuddy(page);
>> +		return false;
> Should this be return 'true' instead ?
>
> Let's consider a scenario where PageHWPoison(page) is true.
>
> Previously bad_page() was not getting called as check_new_page_bad() will
> return earlier before reaching bad_page().
>
> But now with the proposed change here page_expected_state() returns false
> and hence bad_page() still gets called later on in check_new_page().
>
> There is a change in behaviour - or am I missing something here ?

Thank you for the suggestion. You're right, it makes sense to return true in this case.
I'll update the patch accordingly. Appreciate your feedback!                           
                                                                                      
>
>> +	}
>> +
>>  	if (unlikely((unsigned long)page->mapping |
>>  			page_ref_count(page) |
>>  #ifdef CONFIG_MEMCG
>> @@ -1586,29 +1593,16 @@ static __always_inline void page_del_and_expand(struct zone *zone,
>>  	account_freepages(zone, -nr_pages, migratetype);
>>  }
>>  
>> -static void check_new_page_bad(struct page *page)
>> -{
>> -	if (unlikely(PageHWPoison(page))) {
>> -		/* Don't complain about hwpoisoned pages */
>> -		if (PageBuddy(page))
>> -			__ClearPageBuddy(page);
>> -		return;
>> -	}
>> -
>> -	bad_page(page,
>> -		 page_bad_reason(page, PAGE_FLAGS_CHECK_AT_PREP));
>> -}
>> -
>>  /*
>>   * This page is about to be returned from the page allocator
>>   */
>>  static bool check_new_page(struct page *page)
>>  {
>> -	if (likely(page_expected_state(page,
>> -				PAGE_FLAGS_CHECK_AT_PREP|__PG_HWPOISON)))
>> +	if (likely(page_expected_state(page, PAGE_FLAGS_CHECK_AT_PREP)))
>>  		return false;
>>  
>> -	check_new_page_bad(page);
>> +	bad_page(page,
>> +		 page_bad_reason(page, PAGE_FLAGS_CHECK_AT_PREP));
>>  	return true;
>>  }
>>

