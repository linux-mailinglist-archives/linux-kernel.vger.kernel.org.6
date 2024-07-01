Return-Path: <linux-kernel+bounces-236403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6A391E1CB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DD61F2247F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B0B15ECE4;
	Mon,  1 Jul 2024 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSh7zZPP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38303D72
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842588; cv=none; b=bMPVVtSPJFfhdIHqKV1RaSAVxS8fnzrzx66EirFphwQosJXdxNgyJcllOyDGgwtKdLeYGYWeuGExRI8ciP7da8Il0RpKI1B0410k+op3XF8zyWznTZaaBej6erPZ6e5I/gSNJkQn4llHEOphDz8fhPMM3WAeOatASm87WDFjck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842588; c=relaxed/simple;
	bh=/TgANefb4fndSMvSkJ7LU/0RsV+LcQn3Ng+3b9MaRxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=REQJFkfBjY4hQr4W2mcrEnnGczWdU2lWQlDdCT0+mB6UGd2ZH/JE6ar6bd36pBxxvNXnR9xNjbsBuMECDMfBfHLtl3miaseQKIHFgFuFMpcTcIH5kjL84+SIwx7l9ZV07dQHZ6MA5L65RqgjbaYcWB6W9fF5+ENYadcmRCQyL88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSh7zZPP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719842585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=61mGJpiLpxwzl0cKLTanEmOAKYFVvvHzMnnjtuUoHyE=;
	b=gSh7zZPP84aF9yVGPMudLtqMYYwwKXj/RXcf3yL+uwSG0eR3F89q4lcxdqUUaWi3AR1Iqj
	5QAYqcrsOaA+KcY/888giyBLiTfqdL4MUl+EisWNlAoyjIwBBe1qONzrJHG2dN2RxO3OOO
	VOjUbRLvTAsQjstAnhckDu+fpzK6EM0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-PSxv4IRYOhmmKw_H0mjGuw-1; Mon, 01 Jul 2024 10:03:04 -0400
X-MC-Unique: PSxv4IRYOhmmKw_H0mjGuw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36248c176c4so2075410f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 07:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719842583; x=1720447383;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=61mGJpiLpxwzl0cKLTanEmOAKYFVvvHzMnnjtuUoHyE=;
        b=rIZZX77y8+ji2cYKsi9oAegos9mWdRITyZZW/cJh3/v3G5BW4doBS+4JJDVX8EB6Z8
         gXJSvE7BQDPqPKFjjqfKViYinxRGlvvFFUU4PF2PkcxOpSPlkT++6wE4t+J4f3mWT2Yq
         zVwnBmETJwZOLy6guqr6VumsaN4s8VH+hm+vO0mijSMkYvxciTvvfWscTPKpgyZuFBPq
         Rj9FOqfZqHJ4E6aU3/gWe+ar4tykoKPkc3zA6CBmP0Q9wgv86N045EjHqlNnSkjeUVYv
         jJ/aVx7fVBYi5SnBe/npMkNikvllyRvNEB09HhnOziGd1w7yLXpqrDH7pY7MmFUipltm
         ohzg==
X-Gm-Message-State: AOJu0YxMROvD+Ah0gFwihTYZJX9QP8ormuJkpqNaGryeO8wQPC3K26TU
	TPmTXYLmMzdFPS6zJSyIYO8Z6qDNLMM5j2uV0W+AlwQ53cmi47A3/bP5HFuOdd6QKpHplfWzAVk
	ChrDtRQmOH7g9Okv1NgLYdizopO9Bsr8iL6FTSARyuNeB/XDXI5uhd6CvUeqj3g==
X-Received: by 2002:a5d:6a02:0:b0:35f:1d10:18f0 with SMTP id ffacd0b85a97d-367757285admr2845092f8f.64.1719842583056;
        Mon, 01 Jul 2024 07:03:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNJHVvRIHudS6QMF5kyklF0UxeLVMjv88XUXoAURf12mPcQi+jX7ThfbVuT17C3VBBTR9tng==
X-Received: by 2002:a5d:6a02:0:b0:35f:1d10:18f0 with SMTP id ffacd0b85a97d-367757285admr2845072f8f.64.1719842582552;
        Mon, 01 Jul 2024 07:03:02 -0700 (PDT)
Received: from ?IPV6:2a01:599:920:8ca1:a0b5:9e51:26ba:6a2b? ([2a01:599:920:8ca1:a0b5:9e51:26ba:6a2b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d9f9dsm10098082f8f.41.2024.07.01.07.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 07:03:01 -0700 (PDT)
Message-ID: <e2b4933f-7102-47fc-bb33-ecb46eddedcf@redhat.com>
Date: Mon, 1 Jul 2024 16:03:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/migrate: move NUMA hinting fault folio
 isolation + checks under PTL
To: Zi Yan <ziy@nvidia.com>, "Huang, Ying" <ying.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240620212935.656243-1-david@redhat.com>
 <20240620212935.656243-3-david@redhat.com>
 <B726B923-E023-4E56-BED1-BFA5CEF644A1@nvidia.com>
 <c8f9d6fd-310d-4b13-9871-556b6b9a47e1@redhat.com>
 <0F4ABC1D-7A26-4AE2-BCAA-3EA906FB13A7@nvidia.com>
 <9af34a6b-ca56-4a64-8aa6-ade65f109288@redhat.com>
 <D2A4QLLXOM9N.1YK9YRDXMWJPX@nvidia.com>
 <87ed8do6kl.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <D994321B-BF99-45F8-A4BB-F8C8E4DA77A9@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <D994321B-BF99-45F8-A4BB-F8C8E4DA77A9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.07.24 15:50, Zi Yan wrote:
> On 1 Jul 2024, at 4:32, Huang, Ying wrote:
> 
>> "Zi Yan" <ziy@nvidia.com> writes:
>>
>>> On Wed Jun 26, 2024 at 12:49 PM EDT, David Hildenbrand wrote:
>>>> On 21.06.24 22:48, Zi Yan wrote:
>>>>> On 21 Jun 2024, at 16:18, David Hildenbrand wrote:
>>>>>
>>>>>> On 21.06.24 15:44, Zi Yan wrote:
>>>>>>> On 20 Jun 2024, at 17:29, David Hildenbrand wrote:
>>>>>>>
>>>>>>>> Currently we always take a folio reference even if migration will not
>>>>>>>> even be tried or isolation failed, requiring us to grab+drop an additional
>>>>>>>> reference.
>>>>>>>>
>>>>>>>> Further, we end up calling folio_likely_mapped_shared() while the folio
>>>>>>>> might have already been unmapped, because after we dropped the PTL, that
>>>>>>>> can easily happen. We want to stop touching mapcounts and friends from
>>>>>>>> such context, and only call folio_likely_mapped_shared() while the folio
>>>>>>>> is still mapped: mapcount information is pretty much stale and unreliable
>>>>>>>> otherwise.
>>>>>>>>
>>>>>>>> So let's move checks into numamigrate_isolate_folio(), rename that
>>>>>>>> function to migrate_misplaced_folio_prepare(), and call that function
>>>>>>>> from callsites where we call migrate_misplaced_folio(), but still with
>>>>>>>> the PTL held.
>>>>>>>>
>>>>>>>> We can now stop taking temporary folio references, and really only take
>>>>>>>> a reference if folio isolation succeeded. Doing the
>>>>>>>> folio_likely_mapped_shared() + golio isolation under PT lock is now similar
>>>>>>>> to how we handle MADV_PAGEOUT.
>>>>>>>>
>>>>>>>> While at it, combine the folio_is_file_lru() checks.
>>>>>>>>
>>>>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>>>>> ---
>>>>>>>>     include/linux/migrate.h |  7 ++++
>>>>>>>>     mm/huge_memory.c        |  8 ++--
>>>>>>>>     mm/memory.c             |  9 +++--
>>>>>>>>     mm/migrate.c            | 81 +++++++++++++++++++----------------------
>>>>>>>>     4 files changed, 55 insertions(+), 50 deletions(-)
>>>>>>>
>>>>>>> LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>
>>>>>>>
>>>>>>> One nit below:
>>>>>>>
>>>>>>> <snip>
>>>>>>>
>>>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>>>>> index fc27dabcd8e3..4b2817bb2c7d 100644
>>>>>>>> --- a/mm/huge_memory.c
>>>>>>>> +++ b/mm/huge_memory.c
>>>>>>>> @@ -1688,11 +1688,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>>>>>>>     	if (node_is_toptier(nid))
>>>>>>>>     		last_cpupid = folio_last_cpupid(folio);
>>>>>>>>     	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>>>>>>>> -	if (target_nid == NUMA_NO_NODE) {
>>>>>>>> -		folio_put(folio);
>>>>>>>> +	if (target_nid == NUMA_NO_NODE)
>>>>>>>> +		goto out_map;
>>>>>>>> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>>>>>>>> +		flags |= TNF_MIGRATE_FAIL;
>>>>>>>>     		goto out_map;
>>>>>>>>     	}
>>>>>>>> -
>>>>>>>> +	/* The folio is isolated and isolation code holds a folio reference. */
>>>>>>>>     	spin_unlock(vmf->ptl);
>>>>>>>>     	writable = false;
>>>>>>>>
>>>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>>>> index 118660de5bcc..4fd1ecfced4d 100644
>>>>>>>> --- a/mm/memory.c
>>>>>>>> +++ b/mm/memory.c
>>>>>>>
>>>>>>> <snip>
>>>>>>>
>>>>>>>> @@ -5345,10 +5343,13 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>>>>>>>     	else
>>>>>>>>     		last_cpupid = folio_last_cpupid(folio);
>>>>>>>>     	target_nid = numa_migrate_prep(folio, vmf, vmf->address, nid, &flags);
>>>>>>>> -	if (target_nid == NUMA_NO_NODE) {
>>>>>>>> -		folio_put(folio);
>>>>>>>> +	if (target_nid == NUMA_NO_NODE)
>>>>>>>> +		goto out_map;
>>>>>>>> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>>>>>>>> +		flags |= TNF_MIGRATE_FAIL;
>>>>>>>>     		goto out_map;
>>>>>>>>     	}
>>>>>>>
>>>>>>> These two locations are repeated code, maybe just merge the ifs into
>>>>>>> numa_migrate_prep(). Feel free to ignore if you are not going to send
>>>>>>> another version. :)
>>>>>>
>>>>>> I went back and forth a couple of times and
>>>>>>
>>>>>> a) Didn't want to move numa_migrate_prep() into
>>>>>>      migrate_misplaced_folio_prepare(), because having that code in
>>>>>>      mm/migrate.c felt a bit odd.
>>>>>
>>>>> I agree after checking the actual code, since the code is just
>>>>> updating NUMA fault stats and checking where the folio should be.
>>>>>
>>>>>>
>>>>>> b) Didn't want to move migrate_misplaced_folio_prepare() because I enjoy
>>>>>>      seeing the migrate_misplaced_folio_prepare() and
>>>>>>      migrate_misplaced_folio() calls in the same callercontext.
>>>>>>
>>>>>> I also considered renaming numa_migrate_prep(), but wasn't really able to come up with a good name.
>>>>>
>>>>> How about numa_migrate_check()? Since it tells whether a folio should be
>>>>> migrated or not.
>>>>>
>>>>>>
>>>>>> But maybe a) is not too bad?
>>>>>>
>>>>>> We'd have migrate_misplaced_folio_prepare() consume &flags and &target_nid, and perform the "flags |= TNF_MIGRATE_FAIL;" internally.
>>>>>>
>>>>>> What would be your take?
>>>>>
>>>>> I would either rename numa_migrate_prep() or just do nothing. I have to admit
>>>>> that the "prep" and "prepare" in both function names motivated me to propose
>>>>> the merge, but now the actual code tells me they should be separate.
>>>>
>>>> Let's leave it like that for now. Renaming to numa_migrate_check() makes
>>>> sense, and likely moving more numa handling stuff in there.
>>>>
>>>> Bit I yet have to figure out why some of the memory.c vs. huge_memory.c
>>>> code differences exist, so we can unify them.
>>>>
>>>> For example, why did 33024536bafd9 introduce slightly different
>>>> last_cpupid handling in do_huge_pmd_numa_page(), whereby it seems like
>>>> some subtle difference in handling NUMA_BALANCING_MEMORY_TIERING? Maybe
>>>> I am missing something obvious. :)
>>>
>>> It seems to me that a sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING
>>> check is missing in do_huge_pmd_numa_page(). So the
>>>
>>> if (node_is_toptier(nid))
>>>
>>> should be
>>>
>>> if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
>>> node_is_toptier(nid))
>>>
>>> to be consistent with other checks. Add Ying to confirm.
>>
>> Yes.  It should be so.  Sorry for my mistake and confusing.
> 
> Thank you for the confirmation.
> 
>>
>>> I also think a function like
>>>
>>> bool folio_has_cpupid(folio)
>>> {
>>>      return !(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
>>>      || node_is_toptier(folio_nid(folio));
>>> }
>>>
>>> would be better than the existing checks.
>>
>> Yes.  This looks better.  Even better, we can add some comments to the
>> function too.
> 
> I will prepare a patch about it.

Do you have capacity to further consolidate the logic, maybe moving more 
stuff into the numa_migrate_prep (and renaming it? :)).

-- 
Cheers,

David / dhildenb


