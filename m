Return-Path: <linux-kernel+bounces-275961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2002948C7D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE24D1C22349
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F54D1BDABB;
	Tue,  6 Aug 2024 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7v/oR3G"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB67B1BDAB1;
	Tue,  6 Aug 2024 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722938330; cv=none; b=S0MHPBUPEyo8hnpH/TFT6HClmIorHfCPTjmKlPs/DGSwq3H+1qfswvS5v2/3tNiEIVX7laXcgBYTidv1aIxQLHaUOOHd5yxMVPzD3izxFCCkqFm8qKYrJgC433BlgYITOVvZnUFS39oJ0/8Rya6CHi9hVn4VuqvRmMG6toJLqgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722938330; c=relaxed/simple;
	bh=WVXKPEWDjUkXu5g0wedpQut1oMyZMrn+VbJYDXgp9CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWSOU1nJtB3EALpyuyVR4/o3WrRS5LEs1rXHfHuWx2NVNCquwj3Bt2YU6ObpZ+1ppXsksnzv5jjQ0ufb6kHa3tvw4WcujT5L4WDySZb4YQaVWwnP4Jii2c77gBFDTa+B/dpx+9bisO8o9MHdDJ/qFy9koYdbRDNlFSfUPe9ZDj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7v/oR3G; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so35650666b.2;
        Tue, 06 Aug 2024 02:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722938327; x=1723543127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UWFXS3msriWso8OK2ucbircclSt70Aab+Ge8S3Vzum8=;
        b=O7v/oR3GHQDLIWwIus4rSdjqa93BRqSfQqXWJs2g5AN9F6L7IPV9/Z7JdlQgODjjRM
         xAkV0r9NEuE/xio5KiYsc+hMl1xTwS4bbK0/4UpBdUwGZRHJzYvnuHSs/9gRJoN9mWB7
         lE37BaYLHFnAugwIvziQmNF9xiYkj4fzMpHVh6QM/jluJ4wrwoNVuWKXLtwtB8K2hx45
         RpmlvN6Gm0swMKmk/Qq0Is66+dHFX92KxFvgS6g/tvVixNDr1zOV0pdrgEbo5r8afook
         RZPs6XGi4PkoVXrPws2bJWuodtJ7eNgRHwBFomv95b3LcC3Da3Y6ZMST6MOCr9LnjBtC
         dOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722938327; x=1723543127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWFXS3msriWso8OK2ucbircclSt70Aab+Ge8S3Vzum8=;
        b=pYAjrbx2/vkQ55ILBAJ+IFu6m5DYjPw5sFUJk7Qr51XlKNf8+ZIBbyjy9CS/9Va4tE
         LSj83HtkQfH8aJO6ElDNBeWabzjFnNqcGztds4QNDRycvhsRFhkMD7AIlJm9K9ZLxYKL
         gFhaJTc1mjMJZ9blUFH+x8mFqObLbh0o2Q4GdSs06ey1zFhRDlPoMUmM0ypDWKHhVHuJ
         M2uBzzYDWis4wHLYEOzYmCJjcz+6OIBv3PVm/dNGtt9DCpE/f3XcQSx1pMg7N443i2JR
         cEowjXxGGL53A99I6u6WH7lm1kgZhEu5W2iRug8icud13QdAVEV2RKdKI63y+TVTQU8E
         5jbA==
X-Forwarded-Encrypted: i=1; AJvYcCXm2ASYkiXUhPEPQDw6w2e8G6PAcaCIUV90jzUKiGsW3qGYmp7ImpN/AhGV4XIml9cHJeM8n3gKwGVk6esfO78rOe52x8Cq3BBv86FDe3M5meanSFfD3lmL2yPs1I0NJiI9rLoMbC+E
X-Gm-Message-State: AOJu0YwfRCD10BogcKaNs+bxTHTlJKa14fGg3jUwoLDa6eu0CYFLcZbE
	otycn8X5jpobLIJJzZRXcz+3tGI2cUhp4YeGoGu0h1fgfE3xUZV5
X-Google-Smtp-Source: AGHT+IEar3jTUi864HpTSM4h75a+MT2FqFimqumdw4yMkpqbOP3dpy9RmMkU5joiiUHcMlsKONIbQA==
X-Received: by 2002:a17:907:3f1d:b0:a7a:952b:95b1 with SMTP id a640c23a62f3a-a7dc4e287demr1050845166b.24.1722938326530;
        Tue, 06 Aug 2024 02:58:46 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:c24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d437bbsm529533566b.121.2024.08.06.02.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 02:58:46 -0700 (PDT)
Message-ID: <9162275d-12af-45d4-a004-adde8e4d63c2@gmail.com>
Date: Tue, 6 Aug 2024 10:58:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] mm: free zapped tail pages when splitting isolated
 thp
To: David Hildenbrand <david@redhat.com>
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com,
 Shuang Zhai <zhais@google.com>, akpm@linux-foundation.org, linux-mm@kvack.org
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <20240730125346.1580150-4-usamaarif642@gmail.com>
 <3be3dacd-1f45-468f-a363-b9d3a10aeb89@redhat.com>
 <6622b7b4-e558-4d14-bc72-33e8008b06ec@gmail.com>
 <73bbee97-ff58-4518-8dcf-e1da07906b45@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <73bbee97-ff58-4518-8dcf-e1da07906b45@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/08/2024 10:00, David Hildenbrand wrote:
> On 04.08.24 21:02, Usama Arif wrote:
>>
>>
>> On 30/07/2024 16:14, David Hildenbrand wrote:
>>> On 30.07.24 14:46, Usama Arif wrote:
>>>> From: Yu Zhao <yuzhao@google.com>
>>>>
>>>> If a tail page has only two references left, one inherited from the
>>>> isolation of its head and the other from lru_add_page_tail() which we
>>>> are about to drop, it means this tail page was concurrently zapped.
>>>> Then we can safely free it and save page reclaim or migration the
>>>> trouble of trying it.
>>>>
>>>> Signed-off-by: Yu Zhao <yuzhao@google.com>
>>>> Tested-by: Shuang Zhai <zhais@google.com>
>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>> ---
>>>>    mm/huge_memory.c | 26 ++++++++++++++++++++++++++
>>>>    1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 0167dc27e365..76a3b6a2b796 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -2923,6 +2923,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>>>>        unsigned int new_nr = 1 << new_order;
>>>>        int order = folio_order(folio);
>>>>        unsigned int nr = 1 << order;
>>>> +    LIST_HEAD(pages_to_free);
>>>> +    int nr_pages_to_free = 0;
>>>>          /* complete memcg works before add pages to LRU */
>>>>        split_page_memcg(head, order, new_order);
>>>> @@ -3007,6 +3009,24 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>>>>            if (subpage == page)
>>>>                continue;
>>>>            folio_unlock(new_folio);
>>>> +        /*
>>>> +         * If a tail page has only two references left, one inherited
>>>> +         * from the isolation of its head and the other from
>>>> +         * lru_add_page_tail() which we are about to drop, it means this
>>>> +         * tail page was concurrently zapped. Then we can safely free it
>>>> +         * and save page reclaim or migration the trouble of trying it.
>>>> +         */
>>>> +        if (list && page_ref_freeze(subpage, 2)) {
>>>> +            VM_BUG_ON_PAGE(PageLRU(subpage), subpage);
>>>> +            VM_BUG_ON_PAGE(PageCompound(subpage), subpage);
>>>> +            VM_BUG_ON_PAGE(page_mapped(subpage), subpage);
>>>> +
>>>
>>> No VM_BUG_*, VM_WARN is good enough.
>>>
>>>> +            ClearPageActive(subpage);
>>>> +            ClearPageUnevictable(subpage);
>>>> +            list_move(&subpage->lru, &pages_to_free);
>>>
>>> Most checks here should operate on new_folio instead of subpage.
>>>
>>>
>> Do you mean instead of doing the PageLRU, PageCompound and page_mapped check on the subpage, there should be checks on new_folio?
>> If new_folio is a large folio, then it could be that only some of the subpages were zapped?
> 
> We do a:
> 
> struct folio *new_folio = page_folio(subpage);
> 
> Then:
> 
> PageLRU() will end up getting translated to folio_test_lru(page_folio(subpage))
> 
> page_mapped() will end up getting translated to
> folio_mapped(page_folio(subpage))
> 
> PageCompound() is essentially a folio_test_large() check.
> 
> So what stops us from doing
> 
> VM_WARN_ON_ONCE_FOLIO(folio_test_lru(new_folio), new_folio);
> VM_WARN_ON_ONCE_FOLIO(folio_test_large(new_folio), new_folio);
> VM_WARN_ON_ONCE_FOLIO(folio_mapped(new_folio), new_folio);
> 
> folio_clear_active(new_folio);
> folio_clear_unevictable(new_folio);
> ...
> 
> ?
> 
> The page_ref_freeze() should make sure that we don't have a tail page of
> a large folio. Tail pages would have a refcount of 0.
> 
> Or what am I missing?
> 

Yes you are right. For some reason I was thinking tail pages would be able to reach this path.

