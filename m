Return-Path: <linux-kernel+bounces-243513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 934EC92970D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 10:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1183B1F216EF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 08:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5370CF519;
	Sun,  7 Jul 2024 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXPciYzw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D4F6AB6
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720340260; cv=none; b=dQ3S2hq6hWdFZv5jSvis6yyuWixMrZ64raDGKLHRbDc6Sq1OsOO0Bo9GMF8rtTLtINLts692BqCYNQRnXh6GwRka2xvwDoRKztWYGVnDSJpd0KD1VjpikejFIDaaGMGoj4hVhUj5f4OoAowiDukEjRJpJYjNTvXzfIfbWawc8NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720340260; c=relaxed/simple;
	bh=49xyEirYDpw2Pz8EMKQIzTu9yoraO4k7/l+XvbnrIOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbkFcxp+7qJx1Enc/X7+pTNi7r1niMiZ+WpeJPnUT6PtMvLbnfZfB2mAoQ/IhuJ9w+ac9S7VvjraCNKQ/3G3ww7F36nCvgqnIKiCgYeP+tZWs5corbEWKUfDgWcrxI0axXpU3tQUP5ms5z9vRLYpXW//oT3lWId4BKNL9NpCkZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXPciYzw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720340257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BIYC7n4oTOuRWMyTEtiJmFMqWIYwGz2xL4SRWa+Y+GQ=;
	b=ZXPciYzwQfqVhpNCWXp02w8TERwfa6eyao39gqIx6NxCdmrX4iu61fKUbWuRlevR6nz4mt
	JGasCbq0iKRVrQQgBx9+6UN/VGiN3sE6LHpWjRSPVOTxmjs/VV6N0rwVPe/ZKKxl4ACyGA
	6ai0dDMafZSvSMtDv+L1WjN1BXB284k=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-exQKTnQbNjSSiCUPqa-Hug-1; Sun, 07 Jul 2024 04:17:31 -0400
X-MC-Unique: exQKTnQbNjSSiCUPqa-Hug-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52e9d04d773so3244723e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 01:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720340250; x=1720945050;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BIYC7n4oTOuRWMyTEtiJmFMqWIYwGz2xL4SRWa+Y+GQ=;
        b=eka0S4yZCGPxC8Mtx2rI03+0qB86iXgz8gh5Iy9X6IzwnQcnId82BHVdDGaY5Sb7yt
         EATuDjvwX588ADmJ3SX2GeYSvDOV6AG4MykTszEi8ibRvaVLwaK1P5Tbm+Qei+yw39l7
         df9ueuvxckGTVISZzAC45QW7pq/5o7fOf4jcT6dXwFvtTnUHoRCmQrVkMAbImmXfhv3V
         GYlkAwjwhCpgtZ2WRRDQgPHs8MMcMtIRmIw6khbZPu+ioAXLJFpO4fxbxRManI0ER21J
         h4jXzahzv3pdf0twJd+dnF32NmEkBLOrlquFXnl4t0GchURp+Bjf6DPgP+JEZFH4V3td
         MYVg==
X-Forwarded-Encrypted: i=1; AJvYcCXrXmgr9WIX6OHVFLWPaPWb6bpvw0l5k+9CyGj7BByexVuYEzyup+XtWmO8af2/KMQGG97dMHdDq76FyeFsSNLSYeNU16NYprIgU6qA
X-Gm-Message-State: AOJu0Yzz9+CHONHrvZi4nsq3HeljT4Vm8wlxVdL0ujcFg2Gtq6DFnx+B
	tgKxOYgBa8dFnkiQt923yAuJezBx3I34bVwb9OK7e44sL3fSjjPbMZHj1h2vKeNjhzZfcsWtwxo
	5LsXy29bbj0wAL0XQs6Ds0OkF3WrYPGhKq0EGcwBKLkbhlKV3yIsurTql3IQH5A==
X-Received: by 2002:a05:6512:2249:b0:52c:c9bb:2ba4 with SMTP id 2adb3069b0e04-52ea06cc4e3mr7285495e87.46.1720340249791;
        Sun, 07 Jul 2024 01:17:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsJ5V5cThNmH7UU8pNN9TdxvjvTDpxg5t3EmmFdiMOfJn7K7gOJPmWLgLrDNJ4TKWLhbil7A==
X-Received: by 2002:a05:6512:2249:b0:52c:c9bb:2ba4 with SMTP id 2adb3069b0e04-52ea06cc4e3mr7285481e87.46.1720340249304;
        Sun, 07 Jul 2024 01:17:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:c00:10f0:d1a8:c206:17ac? (p200300cbc72f0c0010f0d1a8c20617ac.dip0.t-ipconnect.de. [2003:cb:c72f:c00:10f0:d1a8:c206:17ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d0b19sm121218575e9.10.2024.07.07.01.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 01:17:28 -0700 (PDT)
Message-ID: <9f38e4f1-0ad3-4cd4-bcb7-5ec287859051@redhat.com>
Date: Sun, 7 Jul 2024 10:17:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mm/memblock: introduce a new helper
 memblock_estimated_nr_pages()
To: Wei Yang <richard.weiyang@gmail.com>, Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, oleg@redhat.com,
 mjguzik@gmail.com, tandersen@netflix.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240703005151.28712-1-richard.weiyang@gmail.com>
 <Zoe4XN-gKJnjJtzi@kernel.org> <20240706012805.uuvysz2qgapgqj6p@master>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240706012805.uuvysz2qgapgqj6p@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.07.24 03:28, Wei Yang wrote:
> On Fri, Jul 05, 2024 at 12:09:48PM +0300, Mike Rapoport wrote:
>> On Wed, Jul 03, 2024 at 12:51:49AM +0000, Wei Yang wrote:
>>> Instead of using raw memblock api, we wrap a new helper for user.
>>
>> The changelog should be more elaborate and explain why this function is
>> needed.
>>
>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>> ---
>>>   include/linux/memblock.h |  1 +
>>>   mm/memblock.c            | 19 +++++++++++++++++++
>>>   2 files changed, 20 insertions(+)
>>>
>>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>>> index 40c62aca36ec..7d1c32b3dc12 100644
>>> --- a/include/linux/memblock.h
>>> +++ b/include/linux/memblock.h
>>> @@ -486,6 +486,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
>>>   
>>>   phys_addr_t memblock_phys_mem_size(void);
>>>   phys_addr_t memblock_reserved_size(void);
>>> +unsigned long memblock_estimated_nr_pages(void);
>>>   phys_addr_t memblock_start_of_DRAM(void);
>>>   phys_addr_t memblock_end_of_DRAM(void);
>>>   void memblock_enforce_memory_limit(phys_addr_t memory_limit);
>>> diff --git a/mm/memblock.c b/mm/memblock.c
>>> index e81fb68f7f88..c1f1aac0459f 100644
>>> --- a/mm/memblock.c
>>> +++ b/mm/memblock.c
>>> @@ -1729,6 +1729,25 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
>>>   	return memblock.reserved.total_size;
>>>   }
>>>   
>>> +/**
>>> + * memblock_estimated_nr_pages - return number of pages from memblock point of
>>> + * view
>>
>> This function returns the estimate for free pages, not the number of pages
>> in RAM.
>>
>> How about memblock_estimated_nr_free_pages()?
>>
>>> + * some calculation before all pages are freed to buddy system, especially
>>> + * when CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
>>
>> I'm failing to parse this sentence. The return value here won't depend on
>> CONFIG_DEFERRED_STRUCT_PAGE_INIT.
>>
>>> + *
>>> + * At this point, we can get this information from memblock. Since the system
>>> + * state is not settle down and address alignment, the value is an estimation.
>>> + *
>>> + * Return:
>>> + * An estimated number of pages from memblock point of view.
>>
>>                             ^ free
>>
>>> + */
>>> +unsigned long __init memblock_estimated_nr_pages(void)
>>> +{
>>> +	return PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
>>> +}
>>> +
>>>   /* lowest address */
>>>   phys_addr_t __init_memblock memblock_start_of_DRAM(void)
>>>   {
>>> -- 
>>> 2.34.1
>>>
> 
> Thanks for review. Is this one looks better?
> 
> Subject: [PATCH] mm/memblock: introduce a new helper memblock_estimated_nr_free_pages()
> 
> During bootup, system may need the number of free pages in the whole system
> to do some calculation before all pages are freed to buddy system. Usually
> this number is get from totalram_pages(). Since we plan to move the free
> pages accounting in __free_pages_core(), this value may not represent
> total free pages at the early stage, especially when
> CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
> 
> Instead of using raw memblock api, let's introduce a new helper for user
> to get the estimated number of free pages from memblock point of view.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: David Hildenbrand <david@redhat.com>
> ---
>   include/linux/memblock.h |  1 +
>   mm/memblock.c            | 22 ++++++++++++++++++++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 40c62aca36ec..7d1c32b3dc12 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -486,6 +486,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
>   
>   phys_addr_t memblock_phys_mem_size(void);
>   phys_addr_t memblock_reserved_size(void);
> +unsigned long memblock_estimated_nr_pages(void);
>   phys_addr_t memblock_start_of_DRAM(void);
>   phys_addr_t memblock_end_of_DRAM(void);
>   void memblock_enforce_memory_limit(phys_addr_t memory_limit);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index e81fb68f7f88..00decc42e02b 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1729,6 +1729,28 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
>   	return memblock.reserved.total_size;
>   }
>   
> +/**
> + * memblock_estimated_nr_free_pages - return estimated number of free pages
> + * from memblock point of view
> + *
> + * During bootup, system may need the number of free pages in the whole system
> + * to do some calculation before all pages are freed to buddy system. Usually
> + * this number is get from totalram_pages(). Since we plan to move the free
> + * pages accounting in __free_pages_core(), this value may not represent total
> + * free pages at the early stage, especially when > + * CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.

These historical details should be dropped. "Since we plan ..." will 
easily get outdated soon.

* During bootup, subsystems might need a rough estimate of the number of 
* free pages in the whole system, before precise numbers are available
* from the buddy. Especially with CONFIG_DEFERRED_STRUCT_PAGE_INIT, the
* numbers obtained from the buddy might be very imprecise during bootup.

?

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


