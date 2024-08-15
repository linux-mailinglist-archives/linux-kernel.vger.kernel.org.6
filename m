Return-Path: <linux-kernel+bounces-288322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F729538C9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB1F282147
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796751BA890;
	Thu, 15 Aug 2024 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioPsndKY"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBBFC147;
	Thu, 15 Aug 2024 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723741816; cv=none; b=VjrnZxmZzma5Cdz/fE+LhhiG3O5XKQsJ076+iW9mZLveEXF2+Wwmqr/k9i8pkKnyFdInaKQba4gJa2SLb5fRKt0ZNzuIwNGjO3319jCYvA1/PRcJU8axi9sDMHWAq+BX4pEqjieT/zoI3+aQV6KTbAcWIL+8xOdlfRcprJId+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723741816; c=relaxed/simple;
	bh=gtm9Vi1/LsMPmQ2rb5fmIxDAZnCfeJ2OjkCux9aMWf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sztq2C/sLS/19uLAH9E1KxNowbILXcFW3WZXHSejb7xTyU0WwnRbvuLj/r2izTlPqBr2a4nnP2EhzWa81TjDyevRZPHscpHg137gOkPtGXrtVdYSS44gBTOM3UKGDgAQTYDBiLfKRRW6lM4x8eMWErTLuG+W8NJ5sFGhj0CigKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioPsndKY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428e3129851so7898625e9.3;
        Thu, 15 Aug 2024 10:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723741813; x=1724346613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wnlkNNJ+ob5CNDw8HCvYDtkEPjIKJqZQiv6kYJ2jfgs=;
        b=ioPsndKYjKAUtcM090ljHcFCAJBiAVlMCFD72KMIi1l/KdW5LwcIi41MRWIICXu9mP
         iWIQt6nJ1Jw/2k8bOKYveNQAOs1DM9NJvb/IrhBVXHUYAh+c6P0ReV+RBNcRUdLWMT44
         RZjCxaJ2Z3+DviLBILzkC44afmUELyqtWcfzuy2C0gEJCx38jsCPXjq46WO6E62eVM39
         Za2kX5mTF/53ok/z7ZF8CiimTqIbcBQTbW4lL/oxpaw9Ixddi75Pr/HYeAn5FpPBW5xI
         TcB3VfI7wkGq5duLzPRjaUrSHXqimiq/A5zBcwcJ9DZPBaG5NoIf1g5mjpSG9INT9nLf
         bvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723741813; x=1724346613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wnlkNNJ+ob5CNDw8HCvYDtkEPjIKJqZQiv6kYJ2jfgs=;
        b=sxRDEvNoWcfJZ04Kjb4KrZAySCETR/cTe40QYIMevFwbP50VrM1he0jbhw9XtDQ1Ly
         inLoKIlx1dSjagQgYVjjg69cPV/9mFHWwZbrYctBuzVX7a845L7cZlBVXgouQremNSYY
         28osUwZFDXeheEtTNH6tLY952o7F7mAD/E9Xx/J/BdURACCKUbE4GFk0krymZEtn00iW
         SVSyLo5GmnbvxsWQC2HsFtzSf7VNqRg71umQtBgcAGqQtUmOLpOHamlachiRO63jnFSn
         8ZywUpILoYZk+2g1veSZAPq67QzoU4zeCguUH/B1lSDih7YCW5pDFwpsov0EKGMINI8m
         d4gA==
X-Forwarded-Encrypted: i=1; AJvYcCW0vSVzE/dvRgU5LC/+T+ATG76Qz8Wrq4RYWnLzohnsuNWddWKI2KrCnaRu+7KCnnUU5wGD3PjRDl6rI+1LMdMiYQ6hSecSTZk9VAF454mv4zHyhFDNPtLzrVPeXyVJeRH4ONtxWyEa
X-Gm-Message-State: AOJu0YzMpdYM3wC6IZC7LS1P5NRMJb6Avm8JTDEWbvi7gup3X2W4MR0B
	h4+eoAq/HEHuTv4lwuKFk2NtfBACNIKGJ/5IRP+GOH9OfmKfGXhU
X-Google-Smtp-Source: AGHT+IFsB9XVZRB/XlsmdxaIb2xKgI0gDo3TvDW+JOSBryKjFBmMM2yfbb7n3rGPDerRr1UCxjYxDQ==
X-Received: by 2002:a05:600c:35c5:b0:428:1a48:d5cf with SMTP id 5b1f17b1804b1-429ed7ba070mr139315e9.9.1723741812979;
        Thu, 15 Aug 2024 10:10:12 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:7600:c5:51ce:2b5:970b? ([2a02:6b6f:e750:7600:c5:51ce:2b5:970b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed650e21sm341915e9.20.2024.08.15.10.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 10:10:12 -0700 (PDT)
Message-ID: <d7433859-6217-483c-9d48-bb6de97b09f7@gmail.com>
Date: Thu, 15 Aug 2024 18:10:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] mm: Introduce a pageflag for partially mapped
 folios
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
 <20240813120328.1275952-5-usamaarif642@gmail.com>
 <ee0bae67-17b8-4807-a9b2-9a08df00987a@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <ee0bae67-17b8-4807-a9b2-9a08df00987a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 15/08/2024 17:33, David Hildenbrand wrote:
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 6df0e9f4f56c..c024ab0f745c 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3397,6 +3397,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>                * page_deferred_list.
>>                */
>>               list_del_init(&folio->_deferred_list);
>> +            folio_clear_partially_mapped(folio);
>>           }
>>           spin_unlock(&ds_queue->split_queue_lock);
>>           if (mapping) {
>> @@ -3453,11 +3454,12 @@ void __folio_undo_large_rmappable(struct folio *folio)
>>       if (!list_empty(&folio->_deferred_list)) {
>>           ds_queue->split_queue_len--;
>>           list_del_init(&folio->_deferred_list);
>> +        folio_clear_partially_mapped(folio);
>>       }
>>       spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>>   }
>>   -void deferred_split_folio(struct folio *folio)
>> +void deferred_split_folio(struct folio *folio, bool partially_mapped)
>>   {
>     /* We lost race with folio_put() */>            list_del_init(&folio->_deferred_list);

Was there some comment here? I just see ">" remove from the start of /* We lost race with folio_put() */

>> +            folio_clear_partially_mapped(folio);
>>               ds_queue->split_queue_len--;
>>           }
>>           if (!--sc->nr_to_scan)
>> @@ -3558,7 +3564,6 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>>   next:
>>           folio_put(folio);
>>       }
>> -
>>       spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>>       list_splice_tail(&list, &ds_queue->split_queue);
>>       spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 1fdd9eab240c..2ae2d9a18e40 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1758,6 +1758,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
>>           free_gigantic_folio(folio, huge_page_order(h));
>>       } else {
>>           INIT_LIST_HEAD(&folio->_deferred_list);
>> +        folio_clear_partially_mapped(folio);
>>           folio_put(folio);
>>       }
>>   }
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 52f7fc4e8ac3..d64546b8d377 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -662,8 +662,10 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
>>       atomic_set(&folio->_entire_mapcount, -1);
>>       atomic_set(&folio->_nr_pages_mapped, 0);
>>       atomic_set(&folio->_pincount, 0);
>> -    if (order > 1)
>> +    if (order > 1) {
>>           INIT_LIST_HEAD(&folio->_deferred_list);
>> +        folio_clear_partially_mapped(folio);
> 
> Can we use the non-atomic version here?
> 

I believe we can use the non-atomic version in all places where set/clear is done as all set/clear are protected by ds_queue->split_queue_lock. So basically could replace all folio_set/clear_partially_mapped with __folio_set/clear_partially_mapped.

But I guess its likely not going to make much difference? I will do it anyways in the next revision, rather than sending a fix patch. There haven't been any reviews for patch 5 so will wait a few days for any comments on that.

Thanks

