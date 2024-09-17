Return-Path: <linux-kernel+bounces-331675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1996497AFE4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42231F244D9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ABF171E68;
	Tue, 17 Sep 2024 11:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esvqRVWg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9308E1EB35
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726574393; cv=none; b=A/ngD9YWELqPhJnSomBAFqajiwd3rxbrDCHH2c3QCwyxOg1Mpda1lAfHmJ3vlDLs4yB9D9tNo+8SAKK7hLe9oo5wxIWRBBYDidzd+EeA7xD/fPElQVR0H08XNOd/9F3enzGPerc+zWuqWZJRH240lMIG4PgZag4u2XIGL4H1b7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726574393; c=relaxed/simple;
	bh=Ik0qrV/mr31A5upMb1SUXUGcH6/CprQL5YfZil+Xkg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZToX/qc8pabeV+AxzMBTZQAUsEZVyUsAFS/VPZ8CRunZp6S+q4Hee6IHhLLnCL/CcvqyKo+fnDNVqRxrNLDJCE68ci0zdmHL0bBM95UzLZLfee1jE2ezm4+3I6ttgENygh6UxTLdXbAqEmVDoGzjljZT+PHeLFxSb/tE0j37+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=esvqRVWg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726574390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5tuyWy+viPkv83wz0PbFEOt4BIBRr5UCA+QlQy8fgpA=;
	b=esvqRVWgy8uWnIqQLnjgk8bSoDNhRyJ2LWxZn82oPDfOXJmCgu9RIT214b2Y9uxRcwpwi1
	ZlHXtVXT1R7e+rFly216Qw8dVqu5C/fbDL9KPsFuITYAbebJCMJ7Nm6ndrT6m95cW3Qf1A
	CB3TqIHMMZFv+Cl1gJJBiNWCkeofHz4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-8v_mbUs5OeaC85bb4u5T4g-1; Tue, 17 Sep 2024 07:59:49 -0400
X-MC-Unique: 8v_mbUs5OeaC85bb4u5T4g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8d13a9cc7aso316202166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 04:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726574388; x=1727179188;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5tuyWy+viPkv83wz0PbFEOt4BIBRr5UCA+QlQy8fgpA=;
        b=G1O7xA0knBL9oCIZoBCF6i76naqJpB92GsED5SfB3Fo0OLEUmgVdEzmFdHPiofUCJv
         yJZ57KxV+ffkGUXAVxs2wiPdAgp1fkwLDdq1OSCoCQfgsCEhfLW1qLhKK20tVCX60BsN
         GPgiVBGMTyM0FMT/Rg5HdwOYHvSgZ8Bb7AUrJrag1Gkm4094pz04UTnGXtyXMz4A+ppQ
         QdAwN1LK77rjANcbUUX/IjYWcQWS+TwvMtGDAe6jOuGLs2ZYIgJ6ksedeBntYd6KAqJY
         a6jlJ136k45qwkV7VsFuhO0+qGvUPOXvDjU23Z8YB4c5rRFmOtGrxkqOp6FUr699kur7
         0Blg==
X-Forwarded-Encrypted: i=1; AJvYcCUbuEn05+pkYQqZAX1V0WBmHNT70edD2YIziLuJ4wFJQMRlsD5C7b3x86raRL+ITZ3CXHhxU/XeIsUcC3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrUac4EujsktaS9GrN47aORTUGAXsPzhUPD0+6NHywxUnq/c42
	F4M2Y0rLki+CKEePixNSi7sA+H+Z4OvHmaBwkfe8AvvTLaK9WYOZnTjAZRSk4B9dFR454eHSmWM
	0LqnCVgS1KboGpam7ijwdSSilG6U7Mk1vTwQ7Tli5xa0FkyS+TKX+Q+Y41IjMoBPrjjwUQw==
X-Received: by 2002:a17:907:d2a:b0:a8d:51d6:b3ef with SMTP id a640c23a62f3a-a9029668104mr2064965266b.56.1726574388147;
        Tue, 17 Sep 2024 04:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF97R38V4HWZTO7dwSDSPSvsE7YIPAL+RK1R5oC7wdwLlieHBu7z/9cKMMKIAq/N3RaIp00SA==
X-Received: by 2002:a17:907:d2a:b0:a8d:51d6:b3ef with SMTP id a640c23a62f3a-a9029668104mr2064963066b.56.1726574387618;
        Tue, 17 Sep 2024 04:59:47 -0700 (PDT)
Received: from [192.168.55.136] (tmo-113-196.customers.d1-online.com. [80.187.113.196])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b3a04sm437357366b.125.2024.09.17.04.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 04:59:47 -0700 (PDT)
Message-ID: <2875de57-6e11-4cfe-a0a6-36879ca96091@redhat.com>
Date: Tue, 17 Sep 2024 13:59:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: ensure huge_zero_folio won't have
 large_rmappable flag set
To: Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
 willy@infradead.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240914015306.3656791-1-linmiaohe@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240914015306.3656791-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.09.24 03:53, Miaohe Lin wrote:
> Ensure huge_zero_folio won't have large_rmappable flag set. So it can be
> reported as thp,zero correctly through stable_page_flags().
> 
> Fixes: 5691753d73a2 ("mm: convert huge_zero_page to huge_zero_folio")
 > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>> ---
>   mm/huge_memory.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2a73efea02d7..4e34b7f89daf 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -218,6 +218,8 @@ static bool get_huge_zero_page(void)
>   		count_vm_event(THP_ZERO_PAGE_ALLOC_FAILED);
>   		return false;
>   	}
> +	/* Ensure zero folio won't have large_rmappable flag set. */
> +	folio_clear_large_rmappable(zero_folio);
>   	preempt_disable();
>   	if (cmpxchg(&huge_zero_folio, NULL, zero_folio)) {
>   		preempt_enable();

Doesn't that rather fix

commit 4c8763e84aae4d04d94b35aca9f7db6a8930ad77
Author: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Date:   Fri Jul 5 10:43:43 2024 +0000

     kpageflags: detect isolated KPF_THP folios


?

We could fix it simply by changing the order of checks in there.

It makes sense, though. The huge zeropage is not tracked via the rmap 
... ever. Mapcounts etc are unused. But clearing that flag is just ugly.

I wonder if the real problem lies in using folio_alloc() here, and that 
we should be never setting the flag in the first place .... Yes, we want 
a folio, but not really an rmappable one.

... Willy, what would be your take?

-- 
Cheers,

David / dhildenb


