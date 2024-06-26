Return-Path: <linux-kernel+bounces-231228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C759187E5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB7B1F2426C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69A518FC6B;
	Wed, 26 Jun 2024 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6vSBTcu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B45C18F2F2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420590; cv=none; b=RdHN1ONNGDDLBxB2uyFV82k+PkuiIMcTD5uLZTucLC7bS7qBq0zqVAqrBnrmPqXoP5Ble+2dnV4sgkoGFYaBD0/hrNcjWyZG+pmRnpFdVvpd8c6CRwEEYNBvto0v3SZs6cDVYd2fouHxFI5F5NjnQ31ZGEI4YyOUHEOwD62JDsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420590; c=relaxed/simple;
	bh=hawpp2XrUuRWufGP2oDe/FmSLzU2v6HEovffB+KRtPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/B+jtuMXdiILNzsSkzQ4+aCOM9seLQHAcKoGzAf9LOXFHbBeRF67NxP6UgjMmYRjz8OwSH+s+Jq3hn9SIqdjRz6cdGMLcNpquhtiCMkCqPGGnpQJeNv7JaMKp1bXaajZvDhWVq1P6GQ0uYx6rp1zwg5pkwBjLnDcKUpllfGGk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6vSBTcu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719420588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5gzlO5jvtg7Swb8YW15zzgUHW0lyu1o46B4nngCmnBs=;
	b=i6vSBTcuvtC7XIsbsJNGz+yj4qxOE8R8m+v/sBm+E5RD0TVfsuNBV0tSztTx4tOaLMEd08
	tzSBDf8Xamj6iM4nhM0djE7k5fIx141IBA4d4MMhjByWigZ7wugwMZ9XJeiha3+FakLTPE
	+50mr3u6lYTrmdSe3dKAt6B0T9gY0Jg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-6_8scXW5PHeLeCvps_gy0Q-1; Wed, 26 Jun 2024 12:49:46 -0400
X-MC-Unique: 6_8scXW5PHeLeCvps_gy0Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36250205842so469164f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719420585; x=1720025385;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5gzlO5jvtg7Swb8YW15zzgUHW0lyu1o46B4nngCmnBs=;
        b=JJWNWLbxWpUIWwFveD5M5BqOFz0LQc0VAYKGBao/QpMtLIz6lAGDShHBA/pC3U6Xn3
         MN2r7yUlofgX49H4OKy7y/K19L4mEqAGmQ5VkdDPDjcJKPe+2b7JRRht7IeyGpQaMlFi
         vscA0QIKfHRxkPD7SxqVLS9LoWN0eiGbbece5mpGAWriRzGaHUGqNlKpOrpzSRB5TRb0
         Kp0uskEwxNKm3B44VAk/QADmxrLbxKkZ3F1CNryF/G6TRrTAAk+ZnmVlQFyWnrMjNnrf
         378iwPdSQsW8FdsOLv8Tj6ovT5OF5X0IbF6Sc9LiMHiNdZ6/Xpuf/Meudp4TA4Rn9ESj
         S8Vw==
X-Gm-Message-State: AOJu0Yw34p9SJMJSgE0MsLSW0BoVx6ikTolToc2bU+tSiUQJu+eUp+Yx
	Yt1CU6NCLX7eDRvrY8R/zAXqD/FqcYmgmmJZcgM5jMtJIEU4jWA9zNWoTMms6fFJ1AcJsh/XXUI
	EFyRuD/EyXxe9T6QpgrCgpdqe66P2a2nXMAanO1zB4+3PXxlu+O5ZNh9Hb2cD+Q==
X-Received: by 2002:a05:6000:1f88:b0:362:b906:11f2 with SMTP id ffacd0b85a97d-3673ccaf467mr158662f8f.34.1719420584695;
        Wed, 26 Jun 2024 09:49:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+nUOsBYM9+B8AAR71Fb0/ChhrkMYJkQLQ5r7EeseeRiV+aS/4CcoVMPQnICI/+iGmGT+BvA==
X-Received: by 2002:a05:6000:1f88:b0:362:b906:11f2 with SMTP id ffacd0b85a97d-3673ccaf467mr158639f8f.34.1719420584161;
        Wed, 26 Jun 2024 09:49:44 -0700 (PDT)
Received: from [192.168.1.34] (p548825e3.dip0.t-ipconnect.de. [84.136.37.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663ada128dsm16367388f8f.117.2024.06.26.09.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 09:49:43 -0700 (PDT)
Message-ID: <9af34a6b-ca56-4a64-8aa6-ade65f109288@redhat.com>
Date: Wed, 26 Jun 2024 18:49:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/migrate: move NUMA hinting fault folio
 isolation + checks under PTL
To: Zi Yan <ziy@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240620212935.656243-1-david@redhat.com>
 <20240620212935.656243-3-david@redhat.com>
 <B726B923-E023-4E56-BED1-BFA5CEF644A1@nvidia.com>
 <c8f9d6fd-310d-4b13-9871-556b6b9a47e1@redhat.com>
 <0F4ABC1D-7A26-4AE2-BCAA-3EA906FB13A7@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <0F4ABC1D-7A26-4AE2-BCAA-3EA906FB13A7@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.06.24 22:48, Zi Yan wrote:
> On 21 Jun 2024, at 16:18, David Hildenbrand wrote:
> 
>> On 21.06.24 15:44, Zi Yan wrote:
>>> On 20 Jun 2024, at 17:29, David Hildenbrand wrote:
>>>
>>>> Currently we always take a folio reference even if migration will not
>>>> even be tried or isolation failed, requiring us to grab+drop an additional
>>>> reference.
>>>>
>>>> Further, we end up calling folio_likely_mapped_shared() while the folio
>>>> might have already been unmapped, because after we dropped the PTL, that
>>>> can easily happen. We want to stop touching mapcounts and friends from
>>>> such context, and only call folio_likely_mapped_shared() while the folio
>>>> is still mapped: mapcount information is pretty much stale and unreliable
>>>> otherwise.
>>>>
>>>> So let's move checks into numamigrate_isolate_folio(), rename that
>>>> function to migrate_misplaced_folio_prepare(), and call that function
>>>> from callsites where we call migrate_misplaced_folio(), but still with
>>>> the PTL held.
>>>>
>>>> We can now stop taking temporary folio references, and really only take
>>>> a reference if folio isolation succeeded. Doing the
>>>> folio_likely_mapped_shared() + golio isolation under PT lock is now similar
>>>> to how we handle MADV_PAGEOUT.
>>>>
>>>> While at it, combine the folio_is_file_lru() checks.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>    include/linux/migrate.h |  7 ++++
>>>>    mm/huge_memory.c        |  8 ++--
>>>>    mm/memory.c             |  9 +++--
>>>>    mm/migrate.c            | 81 +++++++++++++++++++----------------------
>>>>    4 files changed, 55 insertions(+), 50 deletions(-)
>>>
>>> LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>
>>>
>>> One nit below:
>>>
>>> <snip>
>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index fc27dabcd8e3..4b2817bb2c7d 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -1688,11 +1688,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>>>    	if (node_is_toptier(nid))
>>>>    		last_cpupid = folio_last_cpupid(folio);
>>>>    	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>>>> -	if (target_nid == NUMA_NO_NODE) {
>>>> -		folio_put(folio);
>>>> +	if (target_nid == NUMA_NO_NODE)
>>>> +		goto out_map;
>>>> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>>>> +		flags |= TNF_MIGRATE_FAIL;
>>>>    		goto out_map;
>>>>    	}
>>>> -
>>>> +	/* The folio is isolated and isolation code holds a folio reference. */
>>>>    	spin_unlock(vmf->ptl);
>>>>    	writable = false;
>>>>
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 118660de5bcc..4fd1ecfced4d 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>
>>> <snip>
>>>
>>>> @@ -5345,10 +5343,13 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>>>    	else
>>>>    		last_cpupid = folio_last_cpupid(folio);
>>>>    	target_nid = numa_migrate_prep(folio, vmf, vmf->address, nid, &flags);
>>>> -	if (target_nid == NUMA_NO_NODE) {
>>>> -		folio_put(folio);
>>>> +	if (target_nid == NUMA_NO_NODE)
>>>> +		goto out_map;
>>>> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>>>> +		flags |= TNF_MIGRATE_FAIL;
>>>>    		goto out_map;
>>>>    	}
>>>
>>> These two locations are repeated code, maybe just merge the ifs into
>>> numa_migrate_prep(). Feel free to ignore if you are not going to send
>>> another version. :)
>>
>> I went back and forth a couple of times and
>>
>> a) Didn't want to move numa_migrate_prep() into
>>     migrate_misplaced_folio_prepare(), because having that code in
>>     mm/migrate.c felt a bit odd.
> 
> I agree after checking the actual code, since the code is just
> updating NUMA fault stats and checking where the folio should be.
> 
>>
>> b) Didn't want to move migrate_misplaced_folio_prepare() because I enjoy
>>     seeing the migrate_misplaced_folio_prepare() and
>>     migrate_misplaced_folio() calls in the same callercontext.
>>
>> I also considered renaming numa_migrate_prep(), but wasn't really able to come up with a good name.
> 
> How about numa_migrate_check()? Since it tells whether a folio should be
> migrated or not.
> 
>>
>> But maybe a) is not too bad?
>>
>> We'd have migrate_misplaced_folio_prepare() consume &flags and &target_nid, and perform the "flags |= TNF_MIGRATE_FAIL;" internally.
>>
>> What would be your take?
> 
> I would either rename numa_migrate_prep() or just do nothing. I have to admit
> that the "prep" and "prepare" in both function names motivated me to propose
> the merge, but now the actual code tells me they should be separate.

Let's leave it like that for now. Renaming to numa_migrate_check() makes 
sense, and likely moving more numa handling stuff in there.

Bit I yet have to figure out why some of the memory.c vs. huge_memory.c 
code differences exist, so we can unify them.

For example, why did 33024536bafd9 introduce slightly different 
last_cpupid handling in do_huge_pmd_numa_page(), whereby it seems like 
some subtle difference in handling NUMA_BALANCING_MEMORY_TIERING? Maybe 
I am missing something obvious. :)

-- 
Cheers,

David / dhildenb


