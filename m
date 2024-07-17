Return-Path: <linux-kernel+bounces-255053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83540933B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99251C21218
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF763B182;
	Wed, 17 Jul 2024 10:18:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D423BBC5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721211494; cv=none; b=UgDhzqhlqDP+TRlmT/Tdn8fcTTIUYX8OeqfxGsWWGA7cAJxXlnBXUGUv0/dfsoPV6aAjUdWp3Eov/vVnymfekn9gU8sH0suJ7Q9QAH2eyWdFifBF4YyzlKZ9B+J/hZXYamw2WXP4bn3N4M03V7dBdWG3U753WIUG256IAbGafoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721211494; c=relaxed/simple;
	bh=VHECaAouBt8HJmWECdXknPoDmIMTBlWVVMatZibwhh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbfOjR2QIcf5YFYZ1UGkVl1lS6JBbnfquECmmv42il5xE0XQ+qw5YNvb/8qYLTDZ+6uOl5BHwhCp3N0AL0wSaRiLrLWyprNysxMZ0KpNnCEXDTNPGQcqoEPsuNw01sg1h4wEr38GK/mWaNwxkR+DtjgC79xD91NKsMW618cmSgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DAE21063;
	Wed, 17 Jul 2024 03:18:37 -0700 (PDT)
Received: from [10.57.77.222] (unknown [10.57.77.222])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BAC43F73F;
	Wed, 17 Jul 2024 03:18:10 -0700 (PDT)
Message-ID: <41831175-6ea4-4e0b-8588-e51e5ee87f19@arm.com>
Date: Wed, 17 Jul 2024 11:18:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm: mTHP stats for pagecache folio allocations
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>,
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
 <5472faf5-1fbe-4a89-a17e-83716fc00b5a@redhat.com>
 <dca879ca-e430-4759-b992-4f763344319c@arm.com>
 <cdee4c58-49aa-4746-a6cc-8ef833f2322e@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <cdee4c58-49aa-4746-a6cc-8ef833f2322e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/07/2024 11:03, David Hildenbrand wrote:
>>>>>>
>>>>>> But today, controls and stats are exposed for:
>>>>>>
>>>>>>      anon:
>>>>>>        min order: 2
>>>>>>        max order: PMD_ORDER
>>>>>>      anon-shmem:
>>>>>>        min order: 2
>>>>>>        max order: PMD_ORDER
>>>>>>      tmpfs-shmem:
>>>>>>        min order: PMD_ORDER
>>>>>>        max order: PMD_ORDER
>>>>>>      file:
>>>>>>        min order: Nothing yet (this patch proposes 1)
>>>>>>        max order: Nothing yet (this patch proposes MAX_PAGECACHE_ORDER)
>>>>>>
>>>>>> So I think there is definitely a bug for shmem where the minimum order
>>>>>> control
>>>>>> should be order-1 but its currently order-2.
>>>>>
>>>>> Maybe, did not play with that yet. Likely order-1 will work. (although
>>>>> probably
>>>>> of questionable use :) )
>>>>
>>>> You might have to expand on why its of "questionable use". I'd assume it has
>>>> the
>>>> same amount of value as using order-1 for regular page cache pages? i.e. half
>>>> the number of objects to manage for the same amount of memory.
>>>
>>> order-1 was recently added for the pagecache to get some device setups running
>>> (IIRC, where we cannot use order-0, because device blocksize > PAGE_SIZE).
>>>
>>> You might be right about "half the number of objects", but likely just going for
>>> order-2, order-3, order-4 ... for shmem might be even better. And simply falling
>>> back to order-0 when you cannot get the larger orders.
>>
>> Sure, but then you're into the territory of baking in policy. Remember that
>> originally I was only interested in 64K but the concensus was to expose all the
>> sizes. Same argument applies to 8K; expose it and let others decide policy.
> 
> I don't disagree. The point I'm trying to make is that there was so far there
> was no strong evidence that it is really required. Support for the pagecache had
> a different motivation for these special devices.

Sure, but there was no clear need for anon mTHP orders other than order-2 and
order-4 (for arm64's HPA and contpte, respectively), but we still chose to
expose all the others.

> 
> But again, I agree that we should just make it consistent and allow for it. :)

Yes, we both agree, so I'll stop arguing now :)

Thanks, as always, for the discussion!


