Return-Path: <linux-kernel+bounces-524702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C80A3E60A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5BA189F5BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBFD1EB192;
	Thu, 20 Feb 2025 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQeX9o4K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED43262D39
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740084312; cv=none; b=ByW6tFGL0UdMv30gGg/WqUY2eoeQkSJkU5BWJYH8c3VZboIaCTGRO50Kv+EosaM+yscUXY8YSiYPLB/PVjRF7X75mRaH2DokXzGvsmsKHFdpxKrw315jlbByi8eVOLQ3xWC4LY+rTWDYjck2sUTEslfUHIFIw4QA3sJS/44IiMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740084312; c=relaxed/simple;
	bh=7OnWyHBt12UCQFAgo3I0LPPTNcdhh4G5zBNqO7prKUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GCYkcKGTulZ7rN6gYa2VOUBCFeM8dn88TrQLEQd21VWzX+oHx42Vz8iTr3047NYb4GSzD+EH8I+M4hsGoseAWQrQut7Y8i4705uea7LbZJg51l+R9x0J/9FWaYcruAy99tpeWzpAt16eDKsJDG95fj0DlmAKe5hUTYXPjkVA28I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQeX9o4K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740084309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1ZN8CzrRdBwaQdVv8dg4hbiNhLa0OpFqL6FW1HS29lM=;
	b=eQeX9o4KcKEqtXuPU9VRGZrEUw6OlrelLEw9OISTgjNeLacr0aDbtQmeAy7IHvB3Krc37N
	Fg0p35ToYbmeFEpl4VEwwjtFAEolGZN2SCjfXMnq/nXr8m1V1YKmPXw8jQWkTWUAUUd3mu
	86m9Yq3XuurDzc0ZPzHG3kkkbJWEN8k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-jpdacXV9M0OcURvFhLIZVQ-1; Thu, 20 Feb 2025 15:45:05 -0500
X-MC-Unique: jpdacXV9M0OcURvFhLIZVQ-1
X-Mimecast-MFC-AGG-ID: jpdacXV9M0OcURvFhLIZVQ_1740084304
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4399a5afc95so6411325e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740084304; x=1740689104;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ZN8CzrRdBwaQdVv8dg4hbiNhLa0OpFqL6FW1HS29lM=;
        b=Xwa4VNQSZiHnyZtBwHoiIamPmrKuIlSePFxg/4R2IkrEdqndrltBWDXq8yfsP18uKr
         SJHD6lsDAZlEjh6rnxzgab30zv9/zAVjpZtqkfqSUU7dnDFUov5F2Y5iR6bkao1Z3LTn
         O34juCovNcsA1nUkpOGyVKOdBT56TD5o1tq7Mfyn8NPjhmNbBrbxPCFHQmZgMO7ZA9LH
         ZOZ7pQEyVqacWFbXSQ+Q3785OMeeofYwrDbx7Gdereb5OjOEURJtwxCJTd8TSROP1ql3
         eDtQJmSBZjrqLXbZwgv21h3Zyp0R7HCgQqzpaaavV6y6Bz1oqk0PsplrKapSU1KGcCem
         6Pug==
X-Forwarded-Encrypted: i=1; AJvYcCUjjh6JTcDWzWOxLqvsGQi7EkoujLAlQfoMzQF3BWk+p7/nXRCpVWL9ITwyBQ2fqTYD+dVDEKTEvx6Sg/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVnjRmSu0VlsiiURbDBlhzsvAhNMbt2GbsaSip+VPf5mtao+xw
	UFNcCjDql9TdAO28C08MftL/NjpKhZBtCwbh1TXuKF9cKBupu8WYRNVuem6gv2LQGIGgVWQZ3Cb
	S398YeVPW2ae2n6hDqaUNrV47vFc3fh9lgx8ejZtPZwnfXdqQB0mkPNvQftWJmA==
X-Gm-Gg: ASbGncttizid3QL0+Hr+yn8BaLP/yeftyFlR1MyNEOQU+j1Pbeghvw+VFly1RneTsTV
	xb2hGMoT4f6W7Q0oLPM5knRfQK2yUR7Mrv7uWxjgnEcXWRyb4y7fVGatr3ly+PuycaSv32NbedQ
	l3QxmeIBfWFCuWntbJjZCVQH9ZNNgC3+UhjeQtDh7I7iSF1ciArZuFjgusieQV4QbGBmlXowP84
	NzguqwFTv93SZuQzEwcOeE5EMc+1nf573+3ebhdc6ZgRyqWK/CIWpE3cY2n0fhd7OQnIPUGYbxG
	qW+c4kBbHRurfaBgCNAe7Hn4nMF3o6s8KiB0dx96cDkLYCdjuOECcRDzQU6E0ovpJ0y5OqKsFM4
	nfN9cPrOuwJ0UWbZihQx45zTWdMx9YA==
X-Received: by 2002:a5d:64ec:0:b0:38f:277a:4eb3 with SMTP id ffacd0b85a97d-38f6e74f38amr510023f8f.8.1740084304338;
        Thu, 20 Feb 2025 12:45:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9zdIiVJ0nqfd6CKImdpOfXEKbdditKpEQt/zTmHhJfWbap/MvuGPAktcYg16GErv59LjpMw==
X-Received: by 2002:a5d:64ec:0:b0:38f:277a:4eb3 with SMTP id ffacd0b85a97d-38f6e74f38amr510006f8f.8.1740084303838;
        Thu, 20 Feb 2025 12:45:03 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:2000:e44c:bc46:d8d3:be5? (p200300cbc7062000e44cbc46d8d30be5.dip0.t-ipconnect.de. [2003:cb:c706:2000:e44c:bc46:d8d3:be5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7e8sm255279355e9.26.2025.02.20.12.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 12:45:02 -0800 (PST)
Message-ID: <70971ae0-3933-4e55-983a-24c6b65ef913@redhat.com>
Date: Thu, 20 Feb 2025 21:45:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm: page_ext: add an iteration API for page
 extensions
To: Luiz Capitulino <luizcap@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, yuzhao@google.com, pasha.tatashin@soleen.com
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev
References: <cover.1739931468.git.luizcap@redhat.com>
 <3f0e058aef3951b39cf6bb4259c247352d4fe736.1739931468.git.luizcap@redhat.com>
 <4cb93166-29fd-4aea-965b-5dfb62d4dc8c@redhat.com>
 <0a8bd481-0b97-416d-935e-84828016445d@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <0a8bd481-0b97-416d-935e-84828016445d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>> +    for (__iter.index = 0;                                 \
>>> +        __page_ext && __iter.index < __pgcount;        \
>>> +        __page_ext = page_ext_iter_next(&__iter),      \
>>> +        __iter.index++)
>>
>> Hm, if we now have an index, why not turn iter.pfn -> iter.start_pfn, and only adjust the index in page_ext_iter_next?
>>
>> Then you can set the index to 0 in page_ext_iter_begin() and have here
>>
>> for (__page_ext = page_ext_iter_begin(&__iter, __page),
>>        __page_ext && __iter.index < __pgcount,
>>        __page_ext = page_ext_iter_next(&__iter);)
> 
> I can do this if you feel strong about it, but I prefer explicitly over
> implicitly. I moved the index into the iter object just to avoid having
> to define it in the macro's body. Also, the way I did it allows for
> using page_ext_iter_begin()/page_ext_iter_next() own their if the need
> arises.

Ah, I see what you mean.

for (__page_ext = page_ext_iter_begin(&__iter, __page, __pgcount);
      __page_ext;
      __page_ext = page_ext_iter_next(&__iter))

Could do that I guess by moving the count in there as well and 
performing the check+increment in page_ext_iter_next.

That looks very clean to me, but no strong opinion. Having the index in 
there just to make a macro happy is rather weird.

> 
>> A page_ext_iter_reset() could then simply reset the index=0 and
>> lookup the page_ext(start_pfn + index) == page_ext(start_pfn)
> 
> Just note we don't have page_ext_iter_reset() today (and I guess it's
> not needed).

Right, was writing this before reviewing the other patch.

> 
>>> +
>>> +/**
>>> + * for_each_page_ext_order(): iterate through page_ext objects
>>> + *                            for a given page order
>>> + * @__page: the page we're interested in
>>> + * @__order: page order to iterate through
>>> + * @__page_ext: struct page_ext pointer where the current page_ext
>>> + *              object is returned
>>> + * @__iter: struct page_ext_iter object (defined in the stack)
>>> + *
>>> + * IMPORTANT: must be called with RCU read lock taken.
>>> + */
>>> +#define for_each_page_ext_order(__page, __order, __page_ext, __iter) \
>>> +    for_each_page_ext(__page, (1UL << __order), __page_ext, __iter)
>>> +
>>>    #else /* !CONFIG_PAGE_EXTENSION */
>>>    struct page_ext;
>>> diff --git a/mm/page_ext.c b/mm/page_ext.c
>>> index 641d93f6af4c1..508deb04d5ead 100644
>>> --- a/mm/page_ext.c
>>> +++ b/mm/page_ext.c
>>> @@ -549,3 +549,44 @@ void page_ext_put(struct page_ext *page_ext)
>>>        rcu_read_unlock();
>>>    }
>>> +
>>> +/**
>>> + * page_ext_iter_begin() - Prepare for iterating through page extensions.
>>> + * @iter: page extension iterator.
>>> + * @page: The page we're interested in.
>>> + *
>>> + * Must be called with RCU read lock taken.
>>> + *
>>> + * Return: NULL if no page_ext exists for this page.
>>> + */
>>> +struct page_ext *page_ext_iter_begin(struct page_ext_iter *iter, struct page *page)
>>> +{
>>> +    iter->pfn = page_to_pfn(page);
>>> +    iter->page_ext = lookup_page_ext(page);
>>> +
>>> +    return iter->page_ext;
>>> +}
>>> +
>>> +/**
>>> + * page_ext_iter_next() - Get next page extension
>>> + * @iter: page extension iterator.
>>> + *
>>> + * Must be called with RCU read lock taken.
>>> + *
>>> + * Return: NULL if no next page_ext exists.
>>> + */
>>> +struct page_ext *page_ext_iter_next(struct page_ext_iter *iter)
>>> +{
>>> +    if (WARN_ON_ONCE(!iter->page_ext))
>>> +        return NULL;
>>> +
>>> +    iter->pfn++;
>>   > +> +    if (page_ext_iter_next_fast_possible(iter->pfn)) {
>>> +        iter->page_ext = page_ext_next(iter->page_ext);
>>> +    } else {
>>> +        iter->page_ext = lookup_page_ext(pfn_to_page(iter->pfn));
>>> +    }
>>> +
>>> +    return iter->page_ext;
>>> +}
>>
>> We now always have a function call when calling into page_ext_iter_next(). Could we move that to the header and rather expose lookup_page_ext() ?
> 
> I personally don't like over-using inline functions, also I don't think this
> code needs optimization since the current clients make the affected code paths
> slow anyways (and this also applies to the likely/unlikely use in page_owner
> and page_table_check, I'd drop all of them if you ask me). But again, I can
> change if this would prevent you from giving your ACK :)

Well, 512^512 function calls for a 1 GiB page just to traverse the page 
ext? :)

-- 
Cheers,

David / dhildenb


