Return-Path: <linux-kernel+bounces-326255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C60976591
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9A01C22D81
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271F5190059;
	Thu, 12 Sep 2024 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bNDX62q1"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0980918BB9E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133419; cv=none; b=foitzW0xV2SD9504DB3sENxyLh5v8rDLOI8vuNeQasSo2ZeeBWXdQjpyxQN4SAFysMCKuteFg1Ytm8XdcSYc/BlDEznweZYfzgXFtnLubbupd+9fKeJb8E1Ra2VgsQIJdHzHzFyF+tFRSD10j5aKFPn51Qo94PUx6u+UFpb8kDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133419; c=relaxed/simple;
	bh=KZxJrp/4zRno6SwdoxgSOJBiS3CoMj6Z1p4Kj1HTwHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+irlqQPZB08LwcwQ9LspNTH37IbTfQ2UIhNm/TZTKnS4h7VFJ0x3B6FEv5ayd6mp2pdaMR7Tbn+pRNyihLyxRrGEkfFwLWU3B6GczXsrAqHRA6ZJaQINcvKNvbl0DZ347QZyvEtRmD14J7awi/CyyVU10gpB0zFwthCjZ1E1cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bNDX62q1; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6bce380eb96so497919a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 02:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726133417; x=1726738217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ae1rrTLdcInpIDAaqOOlwPE8rza0PubUwEN95o/QYrw=;
        b=bNDX62q1HvNZpzWO5bvqN7FueD6UOkGpEoIOLNxZJAwwpijCSFCcVVo7ebbhj2OStO
         vhctRzcZOLVZE0Z+PxiZlWc14HIVdtdgfBiTxaeCiOR+NqbeWVuu7xVcRgo6y+4eR9eF
         1w0VK+RWlmh47LsXLgyz9/RT4eQauIoGEMLNpPg/PZaXVEuzb++gGRBS0lHDR0cbJBK9
         ZVeyOM+2MhH1Ocvh8uEtVoCwbDQq2Xj4je8ToE7OdX/sdjcNNyuZMqkZlSmRKP2qzdLU
         XaZEfqELtnTsaKm+0g6ioO996DDiKePPeOKJ/dn9mORR9wx148bfcnIUeSC+J2xAugid
         T4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726133417; x=1726738217;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ae1rrTLdcInpIDAaqOOlwPE8rza0PubUwEN95o/QYrw=;
        b=Q/ngtsj7/QLSokoYqE7DGiicBtBMClrhI8l+BFzrIsetw5e8ybcD2JavwrJX6wrH4s
         dQB41QdjGUQWXgrCXRz8nFSGzvJynPUIoPvop/5G4Gf4wUhC6oHJOq/68dOjCPhU9MO7
         /wefyoIecB6TnZl5/rzINpUoht1q3OdLlJijD6/uTOexpTZQjLkHnCzLc3VJr9TxcdHW
         jsROXnmvB2zamcpq0lphfiFWwOPSu4sTLnIziqJ4D1kyO281KWmhvfJC1b+m2ShBNqvM
         j8YCxAvN5fU6pCZKXRieOZMbU2QgD5PpR93VA9r45hHDMxP8vDF5WDIpncHlzvzV27Ed
         pD9w==
X-Gm-Message-State: AOJu0Yw2RgOkQXIj1JR4+gCjGZ7FdjglL7O2nVi4Xz5GwGzovc5OIRo8
	c+uHUxsj8/RqVq84ZzfoXbEDVPQzazqLBvAy8xei17kmZ3+OULNCQIFZwcpie/U=
X-Google-Smtp-Source: AGHT+IFJCCHYcScGtt9lkjkAEywijnfIDFZg65ZPBIHqm1dzEPdlJO7/znVrMR8ooIQDztKe568nrw==
X-Received: by 2002:a05:6a21:6b0a:b0:1cf:509c:496b with SMTP id adf61e73a8af0-1cf761e553bmr3124497637.38.1726133417121;
        Thu, 12 Sep 2024 02:30:17 -0700 (PDT)
Received: from [10.4.59.158] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db043c0672sm9995203a91.22.2024.09.12.02.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 02:30:16 -0700 (PDT)
Message-ID: <7782bc62-a09f-465a-aa43-8179542ecc02@bytedance.com>
Date: Thu, 12 Sep 2024 17:30:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/14] mm: page_vma_mapped_walk: map_pte() use
 pte_offset_map_rw_nolock()
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 david@redhat.com, hughd@google.com, willy@infradead.org, vbabka@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vishal.moola@gmail.com,
 peterx@redhat.com, ryan.roberts@arm.com, christophe.leroy2@cs-soprasteria.com
References: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
 <20240904084022.32728-11-zhengqi.arch@bytedance.com>
 <d373689b-a3f2-4c45-b291-85c58289f044@linux.dev>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <d373689b-a3f2-4c45-b291-85c58289f044@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/9/5 20:07, Muchun Song wrote:
> 
> 
> On 2024/9/4 16:40, Qi Zheng wrote:
>> In the caller of map_pte(), we may modify the pvmw->pte after acquiring
>> the pvmw->ptl, so convert it to using pte_offset_map_rw_nolock(). At
>> this time, the pte_same() check is not performed after the pvmw->ptl 
>> held,
>> so we should get pmdval and do pmd_same() check to ensure the 
>> stability of
>> pvmw->pmd.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/page_vma_mapped.c | 24 ++++++++++++++++++++----
>>   1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index ae5cc42aa2087..f1d73fd448708 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -13,9 +13,11 @@ static inline bool not_found(struct 
>> page_vma_mapped_walk *pvmw)
>>       return false;
>>   }
>> -static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t 
>> **ptlp)
>> +static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
>> +            spinlock_t **ptlp)
>>   {
>>       pte_t ptent;
>> +    pmd_t pmdval;
>>       if (pvmw->flags & PVMW_SYNC) {
>>           /* Use the stricter lookup */
>> @@ -25,6 +27,7 @@ static bool map_pte(struct page_vma_mapped_walk 
>> *pvmw, spinlock_t **ptlp)
>>           return !!pvmw->pte;
>>       }
>> +again:
>>       /*
>>        * It is important to return the ptl corresponding to pte,
>>        * in case *pvmw->pmd changes underneath us; so we need to
>> @@ -32,10 +35,11 @@ static bool map_pte(struct page_vma_mapped_walk 
>> *pvmw, spinlock_t **ptlp)
>>        * proceeds to loop over next ptes, and finds a match later.
>>        * Though, in most cases, page lock already protects this.
>>        */
>> -    pvmw->pte = pte_offset_map_nolock(pvmw->vma->vm_mm, pvmw->pmd,
>> -                      pvmw->address, ptlp);
>> +    pvmw->pte = pte_offset_map_rw_nolock(pvmw->vma->vm_mm, pvmw->pmd,
>> +                         pvmw->address, &pmdval, ptlp);
>>       if (!pvmw->pte)
>>           return false;
>> +    *pmdvalp = pmdval;
>>       ptent = ptep_get(pvmw->pte);
>> @@ -69,6 +73,12 @@ static bool map_pte(struct page_vma_mapped_walk 
>> *pvmw, spinlock_t **ptlp)
>>       }
>>       pvmw->ptl = *ptlp;
>>       spin_lock(pvmw->ptl);
>> +
>> +    if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pvmw->pmd)))) {
>> +        spin_unlock(pvmw->ptl);
> 
> Forgot to clear pvmw->ptl? Or how about moving the assignment for it
> to the place where the pmd_same check is successful?
> 
>> +        goto again;
>> +    }
>> +
> 
> Maybe here is the right place to assign pvmw->ptl.

Right, will do in the v4.

> 
> Muchun,
> Thanks.
> 
>>       return true;
>>   }
>> @@ -278,7 +288,7 @@ bool page_vma_mapped_walk(struct 
>> page_vma_mapped_walk *pvmw)
>>               step_forward(pvmw, PMD_SIZE);
>>               continue;
>>           }
>> -        if (!map_pte(pvmw, &ptl)) {
>> +        if (!map_pte(pvmw, &pmde, &ptl)) {
>>               if (!pvmw->pte)
>>                   goto restart;
>>               goto next_pte;
>> @@ -307,6 +317,12 @@ bool page_vma_mapped_walk(struct 
>> page_vma_mapped_walk *pvmw)
>>           if (!pvmw->ptl) {
>>               pvmw->ptl = ptl;
>>               spin_lock(pvmw->ptl);
>> +            if (unlikely(!pmd_same(pmde, 
>> pmdp_get_lockless(pvmw->pmd)))) {
>> +                pte_unmap_unlock(pvmw->pte, pvmw->ptl);
>> +                pvmw->ptl = NULL;
>> +                pvmw->pte = NULL;
>> +                goto restart;
>> +            }
>>           }
>>           goto this_pte;
>>       } while (pvmw->address < end);
> 

