Return-Path: <linux-kernel+bounces-225273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EC8912E68
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63AD11C228C1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC6216D311;
	Fri, 21 Jun 2024 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BN4njs2a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701E9156F2E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719001118; cv=none; b=XiEI07s+ie7urEb3QPhL+nRFfMOOSAIcpcVA7j8gx+elSz6GtjwcVYSAh0thi9xjXR8QfDr0BM3osCfngA05Dmqs2J6yibu//E2S9izCx7mEzKriTDh378+Qjct/sZv9Dhui4fg2jyk1nGDHmJGvyWyjayzi5aRnKNrXrTbg8Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719001118; c=relaxed/simple;
	bh=4mEPPtcTqN8ohAbKpN5PbnHUpP4Z2BKmu8299+CPJd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGAnb5aBbh6GoGJ6leEXLMZYVObzrywjJwKoggCzhjlUDuWRqFClmcjTYlBDk6AcD+z35WPTm76rRY9q1y8KP0jOKl+FfHpSi24e0VPnJPw/jhH4mV6CfVCNIkzq5lSfnFifIca2lCYMPIoy4IS99OOr/stOVPU95sRF3y78+Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BN4njs2a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719001115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xKdPnYoDnRcC5du1K7lkE2/k6eZ8tx7TTMzF6cVycUU=;
	b=BN4njs2a7BL1WvzneVgTdILX219E/aU4B47y4YWwic/Y4xVaCaPWMJLwaqlT0lIzrSet0W
	10BnTA+iRt4INfCglTouskrIQ2WOoTCBG01h77Ywr2RoqF3lCoWtN+b86mcEmyXeLQcYrS
	jOewWUySN+D3rhf1Fm8k8DzxeoCbVZo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-LbuPDClOPASI2xtL1Pd0cg-1; Fri, 21 Jun 2024 16:18:32 -0400
X-MC-Unique: LbuPDClOPASI2xtL1Pd0cg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42117a61bccso18362495e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719001111; x=1719605911;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xKdPnYoDnRcC5du1K7lkE2/k6eZ8tx7TTMzF6cVycUU=;
        b=uE1m0C10tlzm4fGAkMFLnFjTJRhVUYtrbUEVFwH4bW3hFy0XV3yEDla+r8Bkmffaiv
         rPLWJ4StHkHCWZAIMzY49/DtdAqgSFoNmLpHoUJ5kUihbmDSzcow/Su0rIq/ZGj9mmcS
         tytHdLFSxWG7Adp4GjDEXaa2ioxcEnQNhRQXv9ItKM2xHwk0gASJ/CEpc6MRVhTxXxvp
         yo0B6vfb+PO2mMpKufa0RPN7vSCEU0Fh/4PNhThsZ5rhVi0oQtOEpNSG5DdmwgQorgic
         mSbsGcVtE+HUnVnBKPRowFI6NApluqeq6f3zE5QYUEs5EZVvHk0Uea5iaHF0LAMOb2b5
         KVQg==
X-Gm-Message-State: AOJu0YwO7tAC1g5c6BedfXypt4FEetSpDXQy7QacML5uWpNt5O2xqKt1
	EY0jfG454ixAqwBTQbVhITEfoEFKOM6Qg3afcqjXThD7lL+gv/CUN69dD1G43a5JeGhio4cx/Ro
	SYYKbmp4CSfjXVSoZGLMVjR6oiKd8dfaYhf9RbRXK+z6JZqPB44PwSKWbK793Bg==
X-Received: by 2002:a05:600c:4b27:b0:421:78c3:9d11 with SMTP id 5b1f17b1804b1-4247507938bmr64105285e9.1.1719001110831;
        Fri, 21 Jun 2024 13:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcoUFnLvfF5KuGJpCNEtoSnHrYWkmGFczjaVFbyD68dnyW6nOdl942zk7PbBgsPsk8Ye29og==
X-Received: by 2002:a05:600c:4b27:b0:421:78c3:9d11 with SMTP id 5b1f17b1804b1-4247507938bmr64105095e9.1.1719001110360;
        Fri, 21 Jun 2024 13:18:30 -0700 (PDT)
Received: from [192.168.3.141] (p4ff2358f.dip0.t-ipconnect.de. [79.242.53.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b634asm78962685e9.1.2024.06.21.13.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 13:18:29 -0700 (PDT)
Message-ID: <c8f9d6fd-310d-4b13-9871-556b6b9a47e1@redhat.com>
Date: Fri, 21 Jun 2024 22:18:28 +0200
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <B726B923-E023-4E56-BED1-BFA5CEF644A1@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.06.24 15:44, Zi Yan wrote:
> On 20 Jun 2024, at 17:29, David Hildenbrand wrote:
> 
>> Currently we always take a folio reference even if migration will not
>> even be tried or isolation failed, requiring us to grab+drop an additional
>> reference.
>>
>> Further, we end up calling folio_likely_mapped_shared() while the folio
>> might have already been unmapped, because after we dropped the PTL, that
>> can easily happen. We want to stop touching mapcounts and friends from
>> such context, and only call folio_likely_mapped_shared() while the folio
>> is still mapped: mapcount information is pretty much stale and unreliable
>> otherwise.
>>
>> So let's move checks into numamigrate_isolate_folio(), rename that
>> function to migrate_misplaced_folio_prepare(), and call that function
>> from callsites where we call migrate_misplaced_folio(), but still with
>> the PTL held.
>>
>> We can now stop taking temporary folio references, and really only take
>> a reference if folio isolation succeeded. Doing the
>> folio_likely_mapped_shared() + golio isolation under PT lock is now similar
>> to how we handle MADV_PAGEOUT.
>>
>> While at it, combine the folio_is_file_lru() checks.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   include/linux/migrate.h |  7 ++++
>>   mm/huge_memory.c        |  8 ++--
>>   mm/memory.c             |  9 +++--
>>   mm/migrate.c            | 81 +++++++++++++++++++----------------------
>>   4 files changed, 55 insertions(+), 50 deletions(-)
> 
> LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>
> 
> One nit below:
> 
> <snip>
> 
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index fc27dabcd8e3..4b2817bb2c7d 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1688,11 +1688,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>>   	if (node_is_toptier(nid))
>>   		last_cpupid = folio_last_cpupid(folio);
>>   	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>> -	if (target_nid == NUMA_NO_NODE) {
>> -		folio_put(folio);
>> +	if (target_nid == NUMA_NO_NODE)
>> +		goto out_map;
>> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>> +		flags |= TNF_MIGRATE_FAIL;
>>   		goto out_map;
>>   	}
>> -
>> +	/* The folio is isolated and isolation code holds a folio reference. */
>>   	spin_unlock(vmf->ptl);
>>   	writable = false;
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 118660de5bcc..4fd1ecfced4d 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
> 
> <snip>
> 
>> @@ -5345,10 +5343,13 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>   	else
>>   		last_cpupid = folio_last_cpupid(folio);
>>   	target_nid = numa_migrate_prep(folio, vmf, vmf->address, nid, &flags);
>> -	if (target_nid == NUMA_NO_NODE) {
>> -		folio_put(folio);
>> +	if (target_nid == NUMA_NO_NODE)
>> +		goto out_map;
>> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>> +		flags |= TNF_MIGRATE_FAIL;
>>   		goto out_map;
>>   	}
> 
> These two locations are repeated code, maybe just merge the ifs into
> numa_migrate_prep(). Feel free to ignore if you are not going to send
> another version. :)

I went back and forth a couple of times and

a) Didn't want to move numa_migrate_prep() into
    migrate_misplaced_folio_prepare(), because having that code in
    mm/migrate.c felt a bit odd.

b) Didn't want to move migrate_misplaced_folio_prepare() because I enjoy
    seeing the migrate_misplaced_folio_prepare() and
    migrate_misplaced_folio() calls in the same callercontext.

I also considered renaming numa_migrate_prep(), but wasn't really able 
to come up with a good name.

But maybe a) is not too bad?

We'd have migrate_misplaced_folio_prepare() consume &flags and 
&target_nid, and perform the "flags |= TNF_MIGRATE_FAIL;" internally.

What would be your take?

> 
> --
> Best Regards,
> Yan, Zi

-- 
Cheers,

David / dhildenb


