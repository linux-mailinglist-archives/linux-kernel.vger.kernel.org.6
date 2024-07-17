Return-Path: <linux-kernel+bounces-254923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3E1933953
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809E31C21131
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA6B39879;
	Wed, 17 Jul 2024 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7hftj9p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B02B1CA9F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721205887; cv=none; b=VF69B7/CWuN4Ag2PJljrs6hg/Jui4IQX40adQbYWkBClnyQZBP2eMwuzFXJEDw3cl/mLUjEY+ZSHskSkUQXD+Mplni+SiQVQ2vHzOMScQutAIi/f0+wg69g34JUlj1xjwPLN+XOvfdlGnONfJ8bXVqBGxVOGFCGHdUiLKuMI5r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721205887; c=relaxed/simple;
	bh=ax5Ex0qhxEkVh2uoKRBS6DQ5++baORzSXuy+aGfTZKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qF8KxXD+6k/FVrFDqfIO7Gl9Z07M9psxPu+cJb+RkEoqAWd7HWCsEvyHCY3f75NyyrAeRD9JQNfePho1Up45Xbv1nXskydGh9rNgJf1wn0fRsJpP5+0IizPu50RdJEzUprhm8WoZxmaEjW+7njemJBpUF7UmyV8ubUT07ejrDxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q7hftj9p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721205884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nmc4is2W+25pg2tTjNRguUPajGvBZ5qCZCT6Q6HDwzE=;
	b=Q7hftj9pq1uUH68x6jY+6PeFTq8ZzkpFuviqnJkvROnP603XsLzkUDM11GBiRpEuhxukOK
	Tj9vmv98VM/DZuYOGusiBjMg4DqpC9/okgV0H/CymRxSsg2Ie57zu3nq16DbaUSVuriGvv
	q+00ZYW+1IPFcmfsygVGO8EgZpEFeKo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-Nk3Jj4UGO3ydV08k3DrFFg-1; Wed, 17 Jul 2024 04:44:42 -0400
X-MC-Unique: Nk3Jj4UGO3ydV08k3DrFFg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42666ed2d5fso43002895e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 01:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721205881; x=1721810681;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmc4is2W+25pg2tTjNRguUPajGvBZ5qCZCT6Q6HDwzE=;
        b=TKXyW93Dpmh+nZ9+baAtCwBjMqYajcb4McXH7r19llXMERsaRYvNg222hEo7P5rVlC
         4ZZJGrzXjxwq6JFVkQYsGnhvu0xANSealpLhnr+RzrFQ8sAQRXCPWsS1Pfryb4j0tNNg
         /PcWScEwekRC2UM8OTFkSuNzqnXZlSw4NaNwoKsZV6XW/OzIT70T40WbXIr7jgLMLSuE
         TwaA0PSq9/58QTvUbolqJTowgFst2tElWZ2hAS4p9YDIfSNqX7pET+UWqaZOSp9mmdTz
         veo3+KNMkHr/lwkRSgTFJCkDaa5qdIEZ1tZ4Lr3XZABDm9Njm6yl06isYTx84eBYbWBZ
         A0WA==
X-Forwarded-Encrypted: i=1; AJvYcCVEWQfRBSJr9SEL8JDv6ThT4W7YraIfE0TkyT+sHimYJ/VBR3WKUtn7peyuOxFenqgLb3V3dC1z5Xr1R71HHZU717MOpQpuENbeC399
X-Gm-Message-State: AOJu0Yyl69Ye1E5lmDcuKmnoQcuPFnxLs1QsDG4kW0Sc05P5eXF6DCsN
	XnztiSnIxJ+PLHXYC1ajgSoOX8IOtdIS6f5FRTyK7ziEWyr9EuMNNgyBdrscveYouCpQlZxKCKG
	qr0tczE79aHQ/+Sw33i86x8GMfxVxaXaj0j2BYBiKruFQGym+N9EnukHINCgM7g==
X-Received: by 2002:a05:600c:3556:b0:426:59ad:bbb3 with SMTP id 5b1f17b1804b1-427c2d42a0amr7239465e9.32.1721205881190;
        Wed, 17 Jul 2024 01:44:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyEaFNU7UEuFCPM3YS+O5oxrIdRDd+OiI3+QXVwLRYiLNKJN9n/UntO3RIAJCV2fqGo0GJGg==
X-Received: by 2002:a05:600c:3556:b0:426:59ad:bbb3 with SMTP id 5b1f17b1804b1-427c2d42a0amr7239365e9.32.1721205880750;
        Wed, 17 Jul 2024 01:44:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:c00:b08b:a871:ce99:dfde? (p200300cbc7140c00b08ba871ce99dfde.dip0.t-ipconnect.de. [2003:cb:c714:c00:b08b:a871:ce99:dfde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5ef4793sm161483585e9.43.2024.07.17.01.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 01:44:40 -0700 (PDT)
Message-ID: <5472faf5-1fbe-4a89-a17e-83716fc00b5a@redhat.com>
Date: Wed, 17 Jul 2024 10:44:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm: mTHP stats for pagecache folio allocations
To: Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240711072929.3590000-1-ryan.roberts@arm.com>
 <20240711072929.3590000-3-ryan.roberts@arm.com>
 <9e0d84e5-2319-4425-9760-2c6bb23fc390@linux.alibaba.com>
 <CAK1f24nCDZM8aa9z_ZtgLbdj695JJri01q2HJUJb9pJt2uqy=w@mail.gmail.com>
 <756c359e-bb8f-481e-a33f-163c729afa31@redhat.com>
 <8c32a2fc-252d-406b-9fec-ce5bab0829df@arm.com>
 <a8441245-ae35-443f-9aea-325007492741@arm.com>
 <5c58d9ea-8490-4ae6-b7bf-be816dab3356@redhat.com>
 <f03deb7c-9a67-4096-9d33-32b357b52152@arm.com>
 <9052f430-2c5a-4d9d-b54c-bd093b797702@redhat.com>
 <f84bd34d-ac64-4e2f-90c0-d637c00b5055@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f84bd34d-ac64-4e2f-90c0-d637c00b5055@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>> I guess the real supported orders are:
>>>
>>>     anon:
>>>       min order: 2
>>>       max order: PMD_ORDER
>>>     anon-shmem:
>>>       min order: 1
>>>       max order: MAX_PAGECACHE_ORDER
>>>     tmpfs-shmem:
>>>       min order: PMD_ORDER <= 11 ? PMD_ORDER : NONE
>>>       max order: PMD_ORDER <= 11 ? PMD_ORDER : NONE
>>>     file:
>>>       min order: 1
>>>       max order: MAX_PAGECACHE_ORDER
>>
>> That's my understanding. But not sure about anon-shmem really supporting
>> order-1, maybe we do.
> 
> Oh, I thought we only had the restriction for anon folios now (due to deferred
> split queue), so assumed it would just work. With Gavin's
> THP_ORDERS_ALL_FILE_DEFAULT change, that certainly implies that shmem must
> support order-1. If it doesn't then we we might want to tidy that further.
> 
> Baolin, perhaps you can confirm either way?

Currently there would not have been a way to enable it, right? (maybe 
I'm wrong)

> 
>>
>>>
>>> But today, controls and stats are exposed for:
>>>
>>>     anon:
>>>       min order: 2
>>>       max order: PMD_ORDER
>>>     anon-shmem:
>>>       min order: 2
>>>       max order: PMD_ORDER
>>>     tmpfs-shmem:
>>>       min order: PMD_ORDER
>>>       max order: PMD_ORDER
>>>     file:
>>>       min order: Nothing yet (this patch proposes 1)
>>>       max order: Nothing yet (this patch proposes MAX_PAGECACHE_ORDER)
>>>
>>> So I think there is definitely a bug for shmem where the minimum order control
>>> should be order-1 but its currently order-2.
>>
>> Maybe, did not play with that yet. Likely order-1 will work. (although probably
>> of questionable use :) )
> 
> You might have to expand on why its of "questionable use". I'd assume it has the
> same amount of value as using order-1 for regular page cache pages? i.e. half
> the number of objects to manage for the same amount of memory.

order-1 was recently added for the pagecache to get some device setups 
running (IIRC, where we cannot use order-0, because device blocksize > 
PAGE_SIZE).

You might be right about "half the number of objects", but likely just 
going for order-2, order-3, order-4 ... for shmem might be even better. 
And simply falling back to order-0 when you cannot get the larger orders.

I could have sworn you mentioned something like that in your 
"configurable orders for pagecache" RFC that I only briefly skimmed so 
far :P

... only enabling "order-1" and none of the other orders for shmem 
sounds rather "interesting".

But yeah, maybe there is valid use for it, so I'm all for allowing it if 
it can be done.

> 
>>
>>>
>>> I also wonder about PUD-order for DAX? We don't currently have a stat/control.
>>> If we wanted to add it in future, if we take the "expose all stats/controls for
>>> all orders" approach, we would end up extending all the way to PUD-order and all
>>> the orders between PMD and PUD would be dummy for all memory types. That really
>>> starts to feel odd, so I still favour only populating what's really supported.
>>
>> I would go further and say that calling the fsdax thing a THP is borderline
>> wrong and we should not expose any new toggles for it that way.
>>
>> It really behaves much more like hugetlb folios that can be PTE-mapped ... we
>> cannot split these things, and they are not allocated from the buddy. So I
>> wouldn't worry about fsdax for now.
>>
>> fsdax support for compound pages (now large folios) probably never should have
>> been glued to any THP toggle.
> 
> Yeah fair enough. I wasn't really arguing for adding any dax controls; I was
> just trying to think of examples as to why adding dummy controls might be a bad
> idea.

Yes.

>>
>>>
>>> I propose to fix shmem (extend down to 1, stop at MAX_PAGECACHE_ORDER) and
>>> continue with the approach of "indicating only what really exists" for v2.
>>>
>>> Shout if you disagree.
>>
>> Makes sense.
> 
> Excellent. I posted v2, which has these changes, yesterday afternoon. :)

Yes, still digging through mails ... in-between having roughly 1000 
meetings a day :)

-- 
Cheers,

David / dhildenb


