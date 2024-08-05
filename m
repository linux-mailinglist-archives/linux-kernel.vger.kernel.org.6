Return-Path: <linux-kernel+bounces-274560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF0C947A0E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C233C1C21188
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C5D154BFC;
	Mon,  5 Aug 2024 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="If1q5DOn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDCB1311AC
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722854818; cv=none; b=dAfAzaNHHVf+3k/N/LK515pl3GgelDv5wohZm4D8DWvpF7VORPHq0IPNq3/d4L0b4Mly79gNZs0lZZ4eaOcUzdBndANrhxnLeI7ti5B4NpCsijL9Jrdr5fhWPavSQXymyJheRKVJEIxlrMEBN6ZlfeRW56DO3uLwTu9AqtYYkeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722854818; c=relaxed/simple;
	bh=t8ZYKonNXmeLKJG/HtbaEe99E0zHKq2bdb1CivF7e3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hn3P/rzHQCa+QoVSucO9dA5ezovf74Ql4pa/oMeLLSJHZzRvtotI/YbBiIvtlfBGSbamPEu1oHQ6QzRJCwhbb5qY+/VOIhdKmM9zHYULtpih+QGDRUr/zmF2chEdXZFAuqhayjqAPtS5xr2VF8TDVsvT8XBsPk7j72dNDXWulT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=If1q5DOn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722854815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RYGJ2Cl2YdNrvH50S8EXtFaCaXkcCWcHEEbaWCxwuHc=;
	b=If1q5DOnUZwfCIifhW8+r5OPsC6qjwqbKlq3ODRkddrjZjPxMAcx+YNPUc8fDcRE9Iotf0
	Re9ZpJ9WSUjw5fTEkHwkePzyoq60vXr+XHaS2YWhhoLoLUXvAiPCyF9noludUgz0oI8pBi
	sp1MmyqdDnZ6Sc8sXYR7b/KQ/7kVgZw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-yAgrWq-WNv66UTOb0S3R3g-1; Mon, 05 Aug 2024 06:46:52 -0400
X-MC-Unique: yAgrWq-WNv66UTOb0S3R3g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4281d0d1c57so25790005e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 03:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722854812; x=1723459612;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RYGJ2Cl2YdNrvH50S8EXtFaCaXkcCWcHEEbaWCxwuHc=;
        b=guSAnBXgBt5EpRxBJAol4obnfKR3LA0D72goAlZtWZp2W8VKb9QmHwFICaJlixl/RC
         8B7IJXgg9L1uejD11dIV9ylHVMjmcOAL0LczDaeAbA82cwvKMetuORbRBoZ8Pu2dgwCG
         4546307rmMiRobAc6DmxaDjWFKVJkOGF9BUPf9xS+5JpPVC6QiK14Y3C+SAgPOAc07bq
         5eixjT3TBzgnlquJC95iE3DHyrsRuqpDiKEQNLJhB7mv97KN2bhQFud0fHCpWFQ+Ew2j
         uHDA7PU9PlYT0ZNL1x8Df9MBdsAhLI9H3UrioGn1zbfyRNp3llm5Iggar7THZ6MXdll7
         4upw==
X-Forwarded-Encrypted: i=1; AJvYcCVa/m0HiYV0OU921erZlOe/YoijknO7Uva9+YNl0V5D2eHJSePV8KZBo17NTnP6g89DEsKnIUP1crkbepCVJkU7Z3JxuNfGbG5Ogujm
X-Gm-Message-State: AOJu0YyCTHLZBG3OZylP7YypANvc5kZGKDWBc4rO3Ps7sHn6T8AVCBj1
	HMVnPEJLrG3ej/cqz7rSxw9vC/iaSehDiDQA3jFSn8UnkDu2UZS3Omk84hFw3JpW2IE9R0OQ8nq
	tPAegttt+qDrJVqFy74Qz4z9UyTHZJLTe8d5j8I3eixmP32Q/84zh3M+5DQsRBA==
X-Received: by 2002:a05:600c:3b88:b0:426:62a2:34fc with SMTP id 5b1f17b1804b1-428e69e3db7mr92758925e9.11.1722854811538;
        Mon, 05 Aug 2024 03:46:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG52wWe4Kb+h/dOBYLzGYS49SAVUNgfQ7Z2G9kcHXg7wOjEXRrEo78FGdm9+pgHb7C5i1Tqpw==
X-Received: by 2002:a05:600c:3b88:b0:426:62a2:34fc with SMTP id 5b1f17b1804b1-428e69e3db7mr92758615e9.11.1722854810937;
        Mon, 05 Aug 2024 03:46:50 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42824af6e8csm126805155e9.1.2024.08.05.03.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 03:46:50 -0700 (PDT)
Message-ID: <418e818a-f385-459e-a84d-e3880ac08ad5@redhat.com>
Date: Mon, 5 Aug 2024 12:46:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Race condition observed between page migration and page fault
 handling on arm64 machines
To: Dev Jain <dev.jain@arm.com>, Will Deacon <will@kernel.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, ryan.roberts@arm.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
 vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com, osalvador@suse.de,
 baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
 baohua@kernel.org, ioworker0@gmail.com, gshan@redhat.com,
 mark.rutland@arm.com, kirill.shutemov@linux.intel.com, hughd@google.com,
 aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com,
 broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240801081657.1386743-1-dev.jain@arm.com>
 <3b82e195-5871-4880-9ce5-d01bb751f471@redhat.com>
 <bbe411f2-4c68-4f92-af8c-da184669dca8@arm.com>
 <a6a38ad5-c754-44ad-a64b-f9ea5b764291@redhat.com>
 <92df0ee1-d3c9-41e2-834c-284127ae2c4c@arm.com>
 <19902a48-c59b-4e3b-afc5-e792506c2fd6@redhat.com>
 <6486a2b1-45ef-44b6-bd84-d402fc121373@redhat.com>
 <20240801134358.GB4794@willie-the-truck>
 <9359caf7-81a8-45d9-9787-9009b3b2eed3@redhat.com>
 <f8d21caa-7a82-4761-8a78-d928ae8d0f24@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f8d21caa-7a82-4761-8a78-d928ae8d0f24@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.08.24 11:51, Dev Jain wrote:
> 
> On 8/1/24 19:18, David Hildenbrand wrote:
>> On 01.08.24 15:43, Will Deacon wrote:
>>> On Thu, Aug 01, 2024 at 03:26:57PM +0200, David Hildenbrand wrote:
>>>> On 01.08.24 15:13, David Hildenbrand wrote:
>>>>>>>> To dampen the tradeoff, we could do this in shmem_fault()
>>>>>>>> instead? But
>>>>>>>> then, this would mean that we do this in all
>>>>>>>>
>>>>>>>> kinds of vma->vm_ops->fault, only when we discover another
>>>>>>>> reference
>>>>>>>> count race condition :) Doing this in do_fault()
>>>>>>>>
>>>>>>>> should solve this once and for all. In fact, do_pte_missing()
>>>>>>>> may call
>>>>>>>> do_anonymous_page() or do_fault(), and I just
>>>>>>>>
>>>>>>>> noticed that the former already checks this using
>>>>>>>> vmf_pte_changed().
>>>>>>>
>>>>>>> What I am still missing is why this is (a) arm64 only; and (b) if
>>>>>>> this
>>>>>>> is something we should really worry about. There are other reasons
>>>>>>> (e.g., speculative references) why migration could temporarily fail,
>>>>>>> does it happen that often that it is really something we have to
>>>>>>> worry
>>>>>>> about?
>>>>>>
>>>>>>
>>>>>> (a) See discussion at [1]; I guess it passes on x86, which is quite
>>>>>> strange since the race is clearly arch-independent.
>>>>>
>>>>> Yes, I think this is what we have to understand. Is the race simply
>>>>> less
>>>>> likely to trigger on x86?
>>>>>
>>>>> I would assume that it would trigger on any arch.
>>>>>
>>>>> I just ran it on a x86 VM with 2 NUMA nodes and it also seems to
>>>>> work here.
>>>>>
>>>>> Is this maybe related to deferred flushing? Such that the other CPU
>>>>> will
>>>>> by accident just observe the !pte_none a little less likely?
>>>>>
>>>>> But arm64 also usually defers flushes, right? At least unless
>>>>> ARM64_WORKAROUND_REPEAT_TLBI is around. With that we never do deferred
>>>>> flushes.
>>>>
>>>> Bingo!
>>>>
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index e51ed44f8b53..ce94b810586b 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -718,10 +718,7 @@ static void set_tlb_ubc_flush_pending(struct
>>>> mm_struct
>>>> *mm, pte_t pteval,
>>>>     */
>>>>    static bool should_defer_flush(struct mm_struct *mm, enum
>>>> ttu_flags flags)
>>>>    {
>>>> -       if (!(flags & TTU_BATCH_FLUSH))
>>>> -               return false;
>>>> -
>>>> -       return arch_tlbbatch_should_defer(mm);
>>>> +       return false;
>>>>    }
>>>>
>>>>
>>>> On x86:
>>>>
>>>> # ./migration
>>>> TAP version 13
>>>> 1..1
>>>> # Starting 1 tests from 1 test cases.
>>>> #  RUN           migration.shared_anon ...
>>>> Didn't migrate 1 pages
>>>> # migration.c:170:shared_anon:Expected migrate(ptr, self->n1,
>>>> self->n2) (-2)
>>>> == 0 (0)
>>>> # shared_anon: Test terminated by assertion
>>>> #          FAIL  migration.shared_anon
>>>> not ok 1 migration.shared_anon
>>>>
>>>>
>>>> It fails all of the time!
>>>
>>> Nice work! I suppose that makes sense as, with the eager TLB
>>> invalidation, the window between the other CPU faulting and the
>>> migration entry being written is fairly wide.
>>>
>>> Not sure about a fix though :/ It feels a bit overkill to add a new
>>> invalid pte encoding just for this.
>>
>> Something like that might make the test happy in most cases:
>>
>> diff --git a/tools/testing/selftests/mm/migration.c
>> b/tools/testing/selftests/mm/migration.c
>> index 6908569ef406..4c18bfc13b94 100644
>> --- a/tools/testing/selftests/mm/migration.c
>> +++ b/tools/testing/selftests/mm/migration.c
>> @@ -65,6 +65,7 @@ int migrate(uint64_t *ptr, int n1, int n2)
>>          int ret, tmp;
>>          int status = 0;
>>          struct timespec ts1, ts2;
>> +       int errors = 0;
>>
>>          if (clock_gettime(CLOCK_MONOTONIC, &ts1))
>>                  return -1;
>> @@ -79,12 +80,17 @@ int migrate(uint64_t *ptr, int n1, int n2)
>>                  ret = move_pages(0, 1, (void **) &ptr, &n2, &status,
>>                                  MPOL_MF_MOVE_ALL);
>>                  if (ret) {
>> -                       if (ret > 0)
>> +                       if (ret > 0) {
>> +                               if (++errors < 100)
>> +                                       continue;
>>                                  printf("Didn't migrate %d pages\n", ret);
>> -                       else
>> +                       } else {
>>                                  perror("Couldn't migrate pages");
>> +                       }
>>                          return -2;
>>                  }
>> +               /* Progress! */
>> +               errors = 0;
>>
>>                  tmp = n2;
>>                  n2 = n1;
>>
>>
>> [root@localhost mm]# ./migration
>> TAP version 13
>> 1..1
>> # Starting 1 tests from 1 test cases.
>> #  RUN           migration.shared_anon ...
>> #            OK  migration.shared_anon
>> ok 1 migration.shared_anon
>> # PASSED: 1 / 1 tests passed.
>> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> 
> This does make the test pass, to my surprise, since what you are doing
> from userspace
> 
> should have been done by the kernel, because it retries folio unmapping
> and moving
> 
> NR_MAX_MIGRATE_(A)SYNC_RETRY times; I had already tested pumping up these
> 
> macros and the original test was still failing. Now, I digged in more,
> and, if the
> 
> following assertion is correct:
> 
> 
> Any thread having a reference on a folio will end up calling folio_lock()
> 

Good point. I suspect concurrent things like read/write would also be 
able to trigger this (did not check, though).

> 
> then it seems to me that the retry for loop wrapped around
> migrate_folio_move(), inside
> 
> migrate_pages_batch(), is useless; if migrate_folio_move() fails on the
> first iteration, it is
> 
> going to fail for all iterations since, if I am reading the code path
> correctly, the only way it
> 
> fails is when the actual refcount is not equal to expected refcount (in
> folio_migrate_mapping()),
> 
> and there is no way that the extra refcount is going to get released
> since the migration path
> 
> has the folio lock.
> 
> And therefore, this begs the question: isn't it logical to assert the
> actual refcount against the
> 
> expected refcount, just after we have changed the PTEs, so that if this
> assertion fails, we can
> 
> go to the next iteration of the for loop for migrate_folio_unmap()
> inside migrate_pages_batch()
> 
> by calling migrate_folio_undo_src()/dst() to restore the old state? I am
> trying to implement
> 
> this but is not as straightforward as it seemed to me this morning.

I agree with your assessment that migration code currently doesn't 
handle the case well when some other thread does an unconditional 
folio_lock(). folio_trylock() users would be handled, but that's not 
what we want with FGP_LOCK I assume.

So IIUC, your idea would be to unlock the folio in migration code and 
try again their. Sounds reasonable, without looking into the details :)

-- 
Cheers,

David / dhildenb


