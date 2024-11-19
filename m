Return-Path: <linux-kernel+bounces-414667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C129D2BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799AB1F241E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13221D1F7E;
	Tue, 19 Nov 2024 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeW4o8eB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EC71D1F54
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034960; cv=none; b=JZ2lycaP/TAHvtnxmj2ThIEkCVN3M8S7Su19QcgfiN5dsLut1NbCIYhwP/osWIxcZ3jYnqmqWMEDgqn6T0jeDsERFOeLykeLosQMmUrOy3d/ZIkchSNfXJSGu/HPMQmvIqrHTKfYNal+H2n0GXOeUfG57bGBeimI+cdBEO3V42E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034960; c=relaxed/simple;
	bh=kCjzH/YUm72Y7xwO2nKivJn0TgFQfhanDr3HXW9V92M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4/mwsHoaM4x6bdmKnBj9UKDEbsSUzC3WFZql7CJai/qt2eRl2QVlkrPtavTRXgvKbTG49TYJytgYpEehFIuIhsXbfnDq/dw02ZtFpciNQZj1luZR8Wem20BcgU31PYH5OqWu2OJaXWH3d5nb1U/pUHZgfFBKzMfUyr2QoCLUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XeW4o8eB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732034958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x2nkp3rx1Ozobq2YgJDs5rFFRfr6Hm/ku7caNa7hq6g=;
	b=XeW4o8eBbYMd0imwcAZ4hLmjMCEEmsRwQJ8KBcLQwLLtSjmRPBpGUWsrqZIBwugvGCdeUq
	Zhye31nybo007eJo2d9p2LTfCQbtI1QXQ/eql6di9Tb/wPTx7i+V83pXldcHOvz8Nruioz
	rwjmUqIQ78mCGZxSM3h0MyOQKYBh8FQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-mHonrJEZPxqkZHUWc6VV6w-1; Tue, 19 Nov 2024 11:49:16 -0500
X-MC-Unique: mHonrJEZPxqkZHUWc6VV6w-1
X-Mimecast-MFC-AGG-ID: mHonrJEZPxqkZHUWc6VV6w
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43163a40ee0so7734725e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732034955; x=1732639755;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x2nkp3rx1Ozobq2YgJDs5rFFRfr6Hm/ku7caNa7hq6g=;
        b=NVQvDIDsPcINf0vz+iX08m5VAxRvHWIWXUC4s+MVbMn/hiyGM9h14YjLg5XzFHbXIg
         qKlwUgpSKJrX9mgHulNTIOcQZBDdtTc2clDRu4lnA0oBFzgOKSvgRLsoNRvasuhN1qYh
         lFR5UbuHmSu0ns4erbxj6jv7KyG1aG1y7rmygc0CVakRRPM8q5rXOJZybmlcAGm/hGs7
         l5jZifweUu+WqBUTekCTYW0/AO9c2fTDi/mxbDQoVZjDsAqA3NH/kHfbbD4lsc9WAe+a
         +k7kWx5/Tq1x2UgbgiVtgvsJigU7C/kOkhSDu8Q3XGLE4eBpQJghaHd2KpOZLUgWO2AB
         KjWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFtsfk+dSpYlHA2I4dpnxlGVbH2XGKB5M2prEggzp6XE7nAwZvhES72voTvnIX3Hjc/4ZpSFMfReb3o5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz8J+arvtPQQMs+F6W0kacnJ+P9yT8Mi2jhj12NgzhC/OWDOV+
	k57htpThBKEBU5WN3zSMysHuKZlmJX7rpAu+KhO5wxCiVr4VSrFV+rmwyEMo2wKJxMQLgmTCHu0
	hfry8Lky2WuedFvgROOAAo/VflpylnOohoEnPp6dpI6lXqaXKqXqjmRxqu4EmNQ==
X-Received: by 2002:a05:600c:3b23:b0:42c:c28c:e477 with SMTP id 5b1f17b1804b1-432df78c48emr124615035e9.23.1732034955425;
        Tue, 19 Nov 2024 08:49:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAvmXZlpMVY7/ZmD+9GNRnuYcTcunms+8M1RgC/TVtBH0m+L7249d0hrAHtOOttrLUmYzxkg==
X-Received: by 2002:a05:600c:3b23:b0:42c:c28c:e477 with SMTP id 5b1f17b1804b1-432df78c48emr124614805e9.23.1732034954966;
        Tue, 19 Nov 2024 08:49:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c74b:d000:3a9:de5c:9ae6:ccb3? (p200300cbc74bd00003a9de5c9ae6ccb3.dip0.t-ipconnect.de. [2003:cb:c74b:d000:3a9:de5c:9ae6:ccb3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265ca8sm202073895e9.14.2024.11.19.08.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 08:49:14 -0800 (PST)
Message-ID: <833078e4-3661-451a-bc11-3cb60a302946@redhat.com>
Date: Tue, 19 Nov 2024 17:49:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v2 1/3] mm/contig_alloc: support __GFP_COMP
To: Zi Yan <ziy@nvidia.com>
Cc: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240814035451.773331-1-yuzhao@google.com>
 <20240814035451.773331-2-yuzhao@google.com>
 <402ff3e5-4fca-4452-97ba-5b1ec4a6eeb1@redhat.com>
 <00721702-78FF-4690-8EAA-31C367FA9FC0@nvidia.com>
 <1a77f16b-d637-40b4-bf47-a8236729a0ca@redhat.com>
 <57A6BDB9-119B-4C1F-8715-2584046A5EA8@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <57A6BDB9-119B-4C1F-8715-2584046A5EA8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.11.24 17:41, Zi Yan wrote:
> On 19 Nov 2024, at 11:31, David Hildenbrand wrote:
> 
>> On 19.11.24 17:12, Zi Yan wrote:
>>> On 19 Nov 2024, at 10:29, David Hildenbrand wrote:
>>>
>>>>> +/* Split a multi-block free page into its individual pageblocks. */
>>>>> +static void split_large_buddy(struct zone *zone, struct page *page,
>>>>> +			      unsigned long pfn, int order, fpi_t fpi)
>>>>> +{
>>>>> +	unsigned long end = pfn + (1 << order);
>>>>> +
>>>>> +	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
>>>>> +	/* Caller removed page from freelist, buddy info cleared! */
>>>>> +	VM_WARN_ON_ONCE(PageBuddy(page));
>>>>> +
>>>>> +	if (order > pageblock_order)
>>>>> +		order = pageblock_order;
>>>>> +
>>>>> +	while (pfn != end) {
>>>>> +		int mt = get_pfnblock_migratetype(page, pfn);
>>>>> +
>>>>> +		__free_one_page(page, pfn, zone, order, mt, fpi);
>>>>> +		pfn += 1 << order;
>>>>> +		page = pfn_to_page(pfn);
>>>>> +	}
>>>>> +}
>>>>
>>>> Hi,
>>>>
>>>> stumbling over this while digging through the code ....
>>>>
>>>>> +
>>>>>     static void free_one_page(struct zone *zone, struct page *page,
>>>>>     			  unsigned long pfn, unsigned int order,
>>>>>     			  fpi_t fpi_flags)
>>>>>     {
>>>>>     	unsigned long flags;
>>>>> -	int migratetype;
>>>>>      	spin_lock_irqsave(&zone->lock, flags);
>>>>> -	migratetype = get_pfnblock_migratetype(page, pfn);
>>>>> -	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
>>>>
>>>> This change is rather undesired:
>>>>
>>>> via __free_pages_core()->__free_pages_ok() we can easily end up here with order=MAX_PAGE_ORDER.
>>>
>>> Do you have a concrete example? PMD THP on x86_64 is pageblock_order.
>>> We do not have PMD level mTHP yet. Any other possible source?
>>>
>>>>
>>>> What your new code will do is split this perfectly reasonable MAX_PAGE_ORDER chunk via split_large_buddy() into pageblock-sized chunks, and let the buddy merging logic undo our unnecessary splitting.
>>>>
>>>> Is there a way to avoid this and just process the whole MAX_PAGE_ORDER chunk like we used to?
>>>
>>> Probably split_large_buddy() can check the migratetypes of the to-be-freed
>>> page, if order > pageblock_order. If all migratetypes are the same, the page
>>> can be freed at MAX_PAGE_ORDER, otherwise pageblock_order.
>>
>> Thinking about this: why do we care about the migratetype?
>>
>> We only have to fallback to pageblocks if any pageblock is "MIGRATE_ISOLATE" (and maybe MIGRATE_CMA), but not all. Otherwise, we can just ignore the migratetype (or rather overwrite it)
> 
> There are VM_WARN_ONCEs around *_free_list() operations to make sure
> page migratetype matches the migratetype of the list it is on. Ignoring
> migratetype would trigger these WARNs. Overwriting it would work but
> free page migratetype accounting needs to be taken care of.
> 
> An implicit reason is that __free_one_page() does not support >MAX_PAGE_ORDER
> and gigantic hugetlb folios are freed via free_one_page(), where
> split_large_buddy() is used to work around the limitation.

Yes, I saw that change. But that can be easily identified cased by 
unlikely(order > MAX_PAGE_ORDER) to handle that rare case in a special way.

 > > For the two memory init cases you mentioned in the other email, 
maybe a new
> fpi flag to make free_one_page() use __free_one_page() for them,
> since migratetypes should be the same across MAX_PAGE_ORDER range there, right?

In the context of alloc_frozen_range()/free_frozen_range() I want to 
free MAX_PAGE_ORDER chunks when possible, and not have some odd logic in 
the freeing path undo some of that effort.

In the common case, the pageblocks will all have the same time when 
freeing a MAX_PAGE_ORDER page, so we should identify the odd case and 
only special-case that.

-- 
Cheers,

David / dhildenb


