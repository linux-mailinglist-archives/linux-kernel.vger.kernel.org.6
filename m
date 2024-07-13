Return-Path: <linux-kernel+bounces-251331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBB19303A1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 06:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD9A1C21880
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 04:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B155417C6C;
	Sat, 13 Jul 2024 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFuOEj0m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765E8C152
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 04:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720844265; cv=none; b=mUqo4G+LTYw+tfvyMhNbElS9EzTp5vKSFgbUi0uBOZcsWOYYvE9b+hngXYauO16GRFspkGNW0db02WMhIeRwMHZ/VOv5sMOdVVzgHekpDMGBCbUPHpaSwtjNl73TLmecrPel9fn4OBL3Giv8PxjUN18fshLsvhR769bAomNxpKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720844265; c=relaxed/simple;
	bh=k/0k0GicTAoCSLNdqRjhhaeBAC4shB2xgl6A08iOSj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZQgpGxP3ILPWR9URX+yGhYUPqI8VfGEP6ObJVcx5ryFrhkYhfTehuO+5eFdjycgGGYSkxgIl7fUx0xqUUxGeQsFpCit4v8PefyuG9Nk09pIpzQonzZjc5ntDBb6/cSrwNgD652tQQoLhQ3DMrmdeYY6PFAJu5uSZH9TKHyjcks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFuOEj0m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720844262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ie8TlU6bf/ncTwvQuBzHORJBUX6/+XkB5Uji81N1iuk=;
	b=QFuOEj0mE5HtAKnyAaXlU7R/XC1SKmrs3IrSb5WJ4L29/b0mv5LaFkoOL+8gABafn514E5
	155XK5ScH9tcj+RBRnOlSeIpPBBl5rje8+4bFT0IS/s3ZzwhKiplek6NeLa25VN8F6gCbH
	eIK0iO3Oye8GU+2PAoCCw6bqRpzgDkw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-frOIUEiOMQ61-GZ7Gm9Mjg-1; Sat, 13 Jul 2024 00:17:40 -0400
X-MC-Unique: frOIUEiOMQ61-GZ7Gm9Mjg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70affb2ea9aso2217293b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 21:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720844259; x=1721449059;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ie8TlU6bf/ncTwvQuBzHORJBUX6/+XkB5Uji81N1iuk=;
        b=T6P0dCYfHAf9fsa0FXRWPlnqlugNsp4dvC0LBZNv2OIXZ47bXm1Uxn3VUpG6w31lK3
         SXukmUQALghbn3oywKBKP9e0hF57EMZiKQ6dNTATnASEKeRMqm2qS6iK6j6lQiqWAun0
         d9/KUfJCkmq/1EgRhWsWR0F1nNQlhfViFN9NWmIwprw62+rHgBg2LKQ96VGRFt2JJbqT
         dyJq8Zagd0hKPtQa2C2nFWnOue3t5YOORS25k1WauRncWl+O955RQePXUPoygrJcbUtx
         /toD0jaGZPBYjMAoJDgGoLBK1/3rOj9EOTDZJkU5VN3w4CIoRzt7oj3GtaM6BK+n5R3E
         ndrA==
X-Forwarded-Encrypted: i=1; AJvYcCV0NRsaXNRa4kNfGJagL+7CWijqtQFhL8g0d1CSNnpmfnYc1Nvnk68PM7Gd7IKmnWVP4bd19ZFEn1fDkp+fdF7Vzrpi8+VIgwhOXGRY
X-Gm-Message-State: AOJu0Yw0wt4CyB3HtDWbt3kbWi/eygRbIg9AY5VIBM8SI0XIVDLOApj7
	QsceoovX/uGtYTyibG8GU9igHRES6Rq7LtY1bxJek0skOeYlgdMWzO2gZmNQ0RFkJiBPJyJHKlQ
	IiOSlKXMW2ZbAFe9zCXNrbZM0hQtqk7cC4Le/1EKwcKMHloqxYQLgwZhpszmAPA==
X-Received: by 2002:a05:6a20:4fa2:b0:1bd:260e:be97 with SMTP id adf61e73a8af0-1c2984ddcecmr12258049637.53.1720844259443;
        Fri, 12 Jul 2024 21:17:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwT2tRweS7HvyJoeNVv8o5zd9Nw+p2WhG7RTGb8bCIzUKGboDKM8/TI9gacwyuCm2fO7LtXA==
X-Received: by 2002:a05:6a20:4fa2:b0:1bd:260e:be97 with SMTP id adf61e73a8af0-1c2984ddcecmr12258035637.53.1720844258966;
        Fri, 12 Jul 2024 21:17:38 -0700 (PDT)
Received: from [172.31.79.51] ([216.9.110.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc38ac1sm2136255ad.217.2024.07.12.21.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 21:17:38 -0700 (PDT)
Message-ID: <11c95a82-cf13-414b-b489-1dd48255e022@redhat.com>
Date: Sat, 13 Jul 2024 06:17:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: Avoid PMD-size page cache if needed
To: Baolin Wang <baolin.wang@linux.alibaba.com>, Gavin Shan
 <gshan@redhat.com>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, william.kucharski@oracle.com,
 ryan.roberts@arm.com, shan.gavin@gmail.com
References: <20240711104840.200573-1-gshan@redhat.com>
 <ZpBEwEn3swH7IFbI@casper.infradead.org>
 <f58433ee-7217-4f9e-91ba-c29f95cd56b0@redhat.com>
 <63a0364b-a2e0-48c2-b255-e976112deeb1@redhat.com>
 <df83a218-e2e5-496e-999a-e446a7d0b383@redhat.com>
 <b11d6006-1efb-4329-baa0-75799935e019@linux.alibaba.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b11d6006-1efb-4329-baa0-75799935e019@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.07.24 06:01, Baolin Wang wrote:
> 
> 
> On 2024/7/13 09:03, David Hildenbrand wrote:
>> On 12.07.24 07:39, Gavin Shan wrote:
>>> On 7/12/24 7:03 AM, David Hildenbrand wrote:
>>>> On 11.07.24 22:46, Matthew Wilcox wrote:
>>>>> On Thu, Jul 11, 2024 at 08:48:40PM +1000, Gavin Shan wrote:
>>>>>> +++ b/mm/huge_memory.c
>>>>>> @@ -136,7 +136,8 @@ unsigned long __thp_vma_allowable_orders(struct
>>>>>> vm_area_struct *vma,
>>>>>>             while (orders) {
>>>>>>                 addr = vma->vm_end - (PAGE_SIZE << order);
>>>>>> -            if (thp_vma_suitable_order(vma, addr, order))
>>>>>> +            if (!(vma->vm_file && order > MAX_PAGECACHE_ORDER) &&
>>>>>> +                thp_vma_suitable_order(vma, addr, order))
>>>>>>                     break;
>>>>>
>>>>> Why does 'orders' even contain potential orders that are larger than
>>>>> MAX_PAGECACHE_ORDER?
>>>>>
>>>>> We do this at the top:
>>>>>
>>>>>            orders &= vma_is_anonymous(vma) ?
>>>>>                            THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE;
>>>>>
>>>>> include/linux/huge_mm.h:#define THP_ORDERS_ALL_FILE
>>>>> (BIT(PMD_ORDER) | BIT(PUD_ORDER))
>>>>>
>>>>> ... and that seems very wrong.  We support all kinds of orders for
>>>>> files, not just PMD order.  We don't support PUD order at all.
>>>>>
>>>>> What the hell is going on here?
>>>>
>>>> yes, that's just absolutely confusing. I mentioned it to Ryan lately
>>>> that we should clean that up (I wanted to look into that, but am
>>>> happy if someone else can help).
>>>>
>>>> There should likely be different defines for
>>>>
>>>> DAX (PMD|PUD)
>>>>
>>>> SHMEM (PMD) -- but soon more. Not sure if we want separate ANON_SHMEM
>>>> for the time being. Hm. But shmem is already handles separately, so
>>>> maybe we can just ignore shmem here.
>>>>
>>>> PAGECACHE (1 .. MAX_PAGECACHE_ORDER)
>>>>
>>>> ? But it's still unclear to me.
>>>>
>>>> At least DAX must stay special I think, and PAGECACHE should be
>>>> capped at MAX_PAGECACHE_ORDER.
>>>>
>>>
>>> David, I can help to clean it up. Could you please help to confirm the
>>> following
>>
>> Thanks!
>>
>>> changes are exactly what you're suggesting? Hopefully, there are
>>> nothing I've missed.
>>> The original issue can be fixed by the changes. With the changes
>>> applied, madvise(MADV_COLLAPSE)
>>> returns with errno -22 in the test program.
>>>
>>> The fix tag needs to adjusted either.
>>>
>>> Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")
>>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index 2aa986a5cd1b..45909efb0ef0 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -74,7 +74,12 @@ extern struct kobj_attribute shmem_enabled_attr;
>>>     /*
>>>      * Mask of all large folio orders supported for file THP.
>>>      */
>>> -#define THP_ORDERS_ALL_FILE    (BIT(PMD_ORDER) | BIT(PUD_ORDER))
>>
>> DAX doesn't have any MAX_PAGECACHE_ORDER restrictions (like hugetlb). So
>> this should be
>>
>> /*
>>    * FSDAX never splits folios, so the MAX_PAGECACHE_ORDER limit does not
>>    * apply here.
>>    */
>> THP_ORDERS_ALL_FILE_DAX ((BIT(PMD_ORDER) | BIT(PUD_ORDER))
>>
>> Something like that
>>
>>> +#define THP_ORDERS_ALL_FILE_DAX                \
>>> +       ((BIT(PMD_ORDER) | BIT(PUD_ORDER)) & (BIT(MAX_PAGECACHE_ORDER
>>> + 1) - 1))
>>> +#define THP_ORDERS_ALL_FILE_DEFAULT    \
>>> +       ((BIT(MAX_PAGECACHE_ORDER + 1) - 1) & ~BIT(0))
>>> +#define THP_ORDERS_ALL_FILE            \
>>> +       (THP_ORDERS_ALL_FILE_DAX | THP_ORDERS_ALL_FILE_DEFAULT)
>>
>> Maybe we can get rid of THP_ORDERS_ALL_FILE (to prevent abuse) and fixup
>> THP_ORDERS_ALL instead.
>>
>>>     /*
>>>      * Mask of all large folio orders supported for THP.
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 2120f7478e55..4690f33afaa6 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -88,9 +88,17 @@ unsigned long __thp_vma_allowable_orders(struct
>>> vm_area_struct *vma,
>>>            bool smaps = tva_flags & TVA_SMAPS;
>>>            bool in_pf = tva_flags & TVA_IN_PF;
>>>            bool enforce_sysfs = tva_flags & TVA_ENFORCE_SYSFS;
>>> +       unsigned long supported_orders;
>>> +
>>>            /* Check the intersection of requested and supported orders. */
>>> -       orders &= vma_is_anonymous(vma) ?
>>> -                       THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE;
>>> +       if (vma_is_anonymous(vma))
>>> +               supported_orders = THP_ORDERS_ALL_ANON;
>>> +       else if (vma_is_dax(vma))
>>> +               supported_orders = THP_ORDERS_ALL_FILE_DAX;
>>> +       else
>>> +               supported_orders = THP_ORDERS_ALL_FILE_DEFAULT;
>>
>> This is what I had in mind.
>>
>> But, do we have to special-case shmem as well or will that be handled
>> correctly?
> 
> For anonymous shmem, it is now same as anonymous THP, which can utilize
> THP_ORDERS_ALL_ANON.
> For tmpfs, we currently only support PMD-sized THP
> (will support more larger orders in the future). Therefore, I think we
> can reuse THP_ORDERS_ALL_ANON for shmem now:
> 
> if (vma_is_anonymous(vma) || shmem_file(vma->vm_file)))
> 	supported_orders = THP_ORDERS_ALL_ANON;
> ......
> 


It should be THP_ORDERS_ALL_FILE_DEFAULT (MAX_PAGECACHE_ORDER imitation 
applies).

-- 
Cheers,

David / dhildenb


