Return-Path: <linux-kernel+bounces-570763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C1AA6B447
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD211898F74
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AE11E9B18;
	Fri, 21 Mar 2025 06:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BqRHIO94"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DBD22611
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742537409; cv=none; b=a/rSnwjKpUwEDsUjIK0pjhxxbj1nyT+P0rYkhcmbDTQbgCzCpsmqo3ADcx8Wm+Rt5TdF3nyVQs9ZYWt67t/2LFkaxZWMCzOTZ4uJeM0OM26AKfinSviK/1+Phyj9fXaJ96HSTHDXTFhpjvMlJD0WvkeZ8gFl2h7FIjAibP2Im/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742537409; c=relaxed/simple;
	bh=yn0Z4H+ejFJIdrvnNBqJKZAzOw4FHBIidgjNTqstpQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEfU0hFz8Bj46cWIJFJgM63FRg8n27sKF3rWQhS9Q1cdcZMtLNtVkoaZRJr+JLZC45c+V8ZNNQ6wJVI2/BNauFAIdgkitNNjWuXjuGPTzaD2I5FOHBcDhJ6fsjlg6qgZtbhTLX+Gc0R4fHJq6Mi6DifIequoI6sePSQVoPX3WT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BqRHIO94; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5fb25a84-f047-40f1-a3a2-b4f3c65fba06@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742537403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1V/RLQ4nSCVAKsk4bPKGjohMCeFW9c4aikRB4XFSrXY=;
	b=BqRHIO94V0sRngIjmV4IKCyKmxEE4fte7+5v5NRd9mp5o8gQnzuaF5Dn6CZ8LJxxX+hfRR
	2wU26pTRUx+9jbBS6AlQlkqGqBmCqik3sOeM/GJlefkcM1FQdSCzt5rPCogCW16Vn+cC2z
	aAB2QrvIk7lcISXuaHm/fsj6MagxCcQ=
Date: Fri, 21 Mar 2025 14:09:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/page_alloc: Simplify free_page_is_bad by removing
 free_page_is_bad_report
To: Anshuman Khandual <anshuman.khandual@arm.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Ye Liu <liuye@kylinos.cn>
References: <20250321010710.548105-1-ye.liu@linux.dev>
 <edac5f77-529c-4705-8bd5-df7f6e9fdfab@arm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <edac5f77-529c-4705-8bd5-df7f6e9fdfab@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/3/21 12:39, Anshuman Khandual 写道:
>
> On 3/21/25 06:37, Ye Liu wrote:
>> From: Ye Liu <liuye@kylinos.cn>
>>
>> This patch refactors the free_page_is_bad function by directly calling
>> bad_page() instead of using the intermediary function
>> free_page_is_bad_report(). The removal of free_page_is_bad_report()
>> reduces unnecessary indirection, making the code cleaner and easier to
>> read.
>>
>> The functionality remains the same, as free_page_is_bad_report() was
>> merely a wrapper for the bad_page() call. The patch also improves
>> maintainability by reducing the function call depth.
> Seems to be a sensible clean up indeed.
>
>> Signed-off-by: Ye Liu <liuye@kylinos.cn>
>> ---
>>  mm/page_alloc.c | 9 ++-------
>>  1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 61d6a3b1b286..2842da893eea 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -933,19 +933,14 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
>>  	return bad_reason;
>>  }
>>  
>> -static void free_page_is_bad_report(struct page *page)
>> -{
>> -	bad_page(page,
>> -		 page_bad_reason(page, PAGE_FLAGS_CHECK_AT_FREE));
>> -}
>> -
>>  static inline bool free_page_is_bad(struct page *page)
>>  {
>>  	if (likely(page_expected_state(page, PAGE_FLAGS_CHECK_AT_FREE)))
>>  		return false;
>>  
>>  	/* Something has gone sideways, find it */
>> -	free_page_is_bad_report(page);
>> +	bad_page(page,
>> +		 page_bad_reason(page, PAGE_FLAGS_CHECK_AT_FREE));
> Please fold these above two lines into a single line instead.
>
> bad_page(page, page_bad_reason(page, PAGE_FLAGS_CHECK_AT_FREE));
>
>>  	return true;
>>  }
>>  
> With the above suggested change in place.
>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thank you for the suggestion. I'll make the adjustment and submit a new patch.
Appreciate your time and the review!

Thanks,
Ye Liu




