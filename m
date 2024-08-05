Return-Path: <linux-kernel+bounces-274414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD65C9477DA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F011C214E4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044BF1547F1;
	Mon,  5 Aug 2024 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgBNu8Sv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E9914F9E6
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848421; cv=none; b=MWYsU2sueY7B330WcWemyOBA9WEh5tapZn9bReANHkJfSzc+rQhml3WmMeGN1KBtBMKeulVzMQdRqXRp72+PtZjTpkTFl+28KoLtkEQbNTm7KqH24RxX3y1LINleRikMkfiMw5M4CDETIfwx5UvVgtFRrO5zwqTI8gy4RfdpTeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848421; c=relaxed/simple;
	bh=RGxjWP36zYf705/8hcS6JggT+1VzPZ2Rgkma8Uc4dAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBPkhqx/fSOEjhZTdU5qeuCDzIRAObdRaxFzOJL8ZSEWAfrTj1S/97rhtG2vN3KrTyhjwkd7cVMQOm+1umrLvFrYD/ThI2MF0boqE5NbFNNbyGnz08D+kNY3AuYs3vlU0sZeoxUmyAvTyGF+Hb+a+aGtMJ8JIBp7ONzJE36CVxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JgBNu8Sv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722848417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8HQitpbMW2ypbNGKvmYtYs01w+MzFX+wf5SUicYWuc4=;
	b=JgBNu8Sv3XCw+vXzEicLP1PV4xapjq/th04Usz7pf6GEbywBqkNPali+MzufkmNHCCfAW9
	URuYDcbk/n6G8BHtEgWNV+qbXngJ2KLWlmKAB3kMr4dumeHmhIKTkvDfgvIXz7vT6YyuOv
	pTTArwfZ3WIaUKIgG7/lUQsXjzs1Xb8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-350jziPWOYSltfyeDqEA3Q-1; Mon, 05 Aug 2024 05:00:15 -0400
X-MC-Unique: 350jziPWOYSltfyeDqEA3Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428c2fbf95eso34217125e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 02:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722848414; x=1723453214;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8HQitpbMW2ypbNGKvmYtYs01w+MzFX+wf5SUicYWuc4=;
        b=YdVLQWObX3BM9xHQDH3JI5i2TVMAm1VBhLm224gQwBjEmLfxRLeOJWDl6crw+koPfO
         9+bV+5n5AqxP42fxQpLrc3Z55o1TGL1vTzh0BtOIQILuzhSIOPrcTNBVkfU3pynN7SqN
         tzhzVBzar39iTci4gwySEj8xxhb5Ib8dbUgwT8tZw2hSY+mixB8JArEQuvPPAArO9IF1
         kgUAYcpcswhINWxbUXyZWkPnhilyS56LSamYUjepS3kOSg3UEMNYBKKGDXo5FCwFJztX
         CdH5Ogse5mqQsz7zJf6hNixAAepOdo2M+yvFOw2fFM9T6oHEh1IdhMpw4W08OGq237ox
         /3zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAndTJ+nneFnDfjFqX3Cf0gNCNERz/UKgYc1nB4dVaZllovVBgrjNuyN+Mhu5KSSvh3B8Xc07U6CWCL6n59FNq3Xr/iuw61zZZWCej
X-Gm-Message-State: AOJu0YzZ0IvmhJaV0O8++xtqfWiyCRaMhsUYIbNdgmWwItsik4I7QXT/
	omGzZNI70Hgaqk2lQGkXGNqfaYIkX2BYClPJI9KGrJDJg4a7DBMvh4uT27HrgmwpySWlEk+qJ5a
	ZLOj0vg+/E56lmp/4bglAdciZc6pKeKVYXOhQgpHLwacBfuNUzSCkOvi/D5zAPQ==
X-Received: by 2002:a05:600c:1552:b0:426:6822:861 with SMTP id 5b1f17b1804b1-428e6b925c7mr72392245e9.36.1722848414272;
        Mon, 05 Aug 2024 02:00:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5X01e4CDCLCXfAB37fYDPKvRcTeP8WyfYVlDdNd+Qm0VWVvOc9aGo2XYJg7YFARRENnEycQ==
X-Received: by 2002:a05:600c:1552:b0:426:6822:861 with SMTP id 5b1f17b1804b1-428e6b925c7mr72391815e9.36.1722848413714;
        Mon, 05 Aug 2024 02:00:13 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6d643a4sm130515125e9.2.2024.08.05.02.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 02:00:13 -0700 (PDT)
Message-ID: <73bbee97-ff58-4518-8dcf-e1da07906b45@redhat.com>
Date: Mon, 5 Aug 2024 11:00:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] mm: free zapped tail pages when splitting isolated
 thp
To: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com,
 Shuang Zhai <zhais@google.com>
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <20240730125346.1580150-4-usamaarif642@gmail.com>
 <3be3dacd-1f45-468f-a363-b9d3a10aeb89@redhat.com>
 <6622b7b4-e558-4d14-bc72-33e8008b06ec@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6622b7b4-e558-4d14-bc72-33e8008b06ec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.08.24 21:02, Usama Arif wrote:
> 
> 
> On 30/07/2024 16:14, David Hildenbrand wrote:
>> On 30.07.24 14:46, Usama Arif wrote:
>>> From: Yu Zhao <yuzhao@google.com>
>>>
>>> If a tail page has only two references left, one inherited from the
>>> isolation of its head and the other from lru_add_page_tail() which we
>>> are about to drop, it means this tail page was concurrently zapped.
>>> Then we can safely free it and save page reclaim or migration the
>>> trouble of trying it.
>>>
>>> Signed-off-by: Yu Zhao <yuzhao@google.com>
>>> Tested-by: Shuang Zhai <zhais@google.com>
>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>> ---
>>>    mm/huge_memory.c | 26 ++++++++++++++++++++++++++
>>>    1 file changed, 26 insertions(+)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 0167dc27e365..76a3b6a2b796 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -2923,6 +2923,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>>>        unsigned int new_nr = 1 << new_order;
>>>        int order = folio_order(folio);
>>>        unsigned int nr = 1 << order;
>>> +    LIST_HEAD(pages_to_free);
>>> +    int nr_pages_to_free = 0;
>>>          /* complete memcg works before add pages to LRU */
>>>        split_page_memcg(head, order, new_order);
>>> @@ -3007,6 +3009,24 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>>>            if (subpage == page)
>>>                continue;
>>>            folio_unlock(new_folio);
>>> +        /*
>>> +         * If a tail page has only two references left, one inherited
>>> +         * from the isolation of its head and the other from
>>> +         * lru_add_page_tail() which we are about to drop, it means this
>>> +         * tail page was concurrently zapped. Then we can safely free it
>>> +         * and save page reclaim or migration the trouble of trying it.
>>> +         */
>>> +        if (list && page_ref_freeze(subpage, 2)) {
>>> +            VM_BUG_ON_PAGE(PageLRU(subpage), subpage);
>>> +            VM_BUG_ON_PAGE(PageCompound(subpage), subpage);
>>> +            VM_BUG_ON_PAGE(page_mapped(subpage), subpage);
>>> +
>>
>> No VM_BUG_*, VM_WARN is good enough.
>>
>>> +            ClearPageActive(subpage);
>>> +            ClearPageUnevictable(subpage);
>>> +            list_move(&subpage->lru, &pages_to_free);
>>
>> Most checks here should operate on new_folio instead of subpage.
>>
>>
> Do you mean instead of doing the PageLRU, PageCompound and page_mapped check on the subpage, there should be checks on new_folio?
> If new_folio is a large folio, then it could be that only some of the subpages were zapped?

We do a:

struct folio *new_folio = page_folio(subpage);

Then:

PageLRU() will end up getting translated to 
folio_test_lru(page_folio(subpage))

page_mapped() will end up getting translated to
folio_mapped(page_folio(subpage))

PageCompound() is essentially a folio_test_large() check.

So what stops us from doing

VM_WARN_ON_ONCE_FOLIO(folio_test_lru(new_folio), new_folio);
VM_WARN_ON_ONCE_FOLIO(folio_test_large(new_folio), new_folio);
VM_WARN_ON_ONCE_FOLIO(folio_mapped(new_folio), new_folio);

folio_clear_active(new_folio);
folio_clear_unevictable(new_folio);
...

?

The page_ref_freeze() should make sure that we don't have a tail page of
a large folio. Tail pages would have a refcount of 0.

Or what am I missing?

> 
> Could do below if subpage makes sense
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 3305e6d0b90e..abfcd4b7cbba 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3041,9 +3041,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>                   * and save page reclaim or migration the trouble of trying it.
>                   */
>                  if (list && page_ref_freeze(subpage, 2)) {
> -                       VM_BUG_ON_PAGE(PageLRU(subpage), subpage);
> -                       VM_BUG_ON_PAGE(PageCompound(subpage), subpage);
> -                       VM_BUG_ON_PAGE(page_mapped(subpage), subpage);
> +                       VM_WARN_ON_ONCE_PAGE(PageLRU(subpage), subpage);
> +                       VM_WARN_ON_ONCE_PAGE(PageCompound(subpage), subpage);
> +                       VM_WARN_ON_ONCE_PAGE(page_mapped(subpage), subpage);
>   
>                          ClearPageActive(subpage);
>                          ClearPageUnevictable(subpage);
> 

-- 
Cheers,

David / dhildenb


