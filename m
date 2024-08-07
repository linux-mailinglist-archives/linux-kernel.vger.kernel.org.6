Return-Path: <linux-kernel+bounces-277831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DA794A716
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B15FB23E00
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59E51E2129;
	Wed,  7 Aug 2024 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EePmsrKU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B991E4851
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723030786; cv=none; b=Rnh/6RUFbiF7G4/jNAEf+8eYc/TDvbYfa8m5M/3Stv6kifcDDVWyR2mOzN/kdnfgf5kXGEYyuyDxmmAHG7fAFXY0RqOEajBJzxJ3wqhKMijdehgmRbKAFXhQ/1seo8FvEFxIx3oYovV5ujMS0jMuC9OpW4vx1u7BDGXn6EqbXM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723030786; c=relaxed/simple;
	bh=+JaRwfUSDKJdrnU0w4Ugmwlnc34Eg2WlRaqac8+yAB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8yqB4Y09VfA47FiNcu0Ac5eriokLCLWH2vj8ccHU33LtM0MESsaZ6PJ8w0U+Y43mwlX2joTKPeowsFhyEoRg9UR6FBPsfvv0HME77wEpnUbDpdx1/ZjuQ6q+6ZS9+NtZWcjUKRG1tz5kQIhDX/bRWYT0zewPvgE2jh4B+l0CHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EePmsrKU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723030783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RIQLd+3N+swCJsaD2XUhaZjgfvR/HcyggoFyBnsDkSk=;
	b=EePmsrKUX4yHiHM/zbkGs/kSatfdyDPjr2Sx9PlUq79S8y8xbfi2K0h7mQR72Y3Ds2XRUL
	COi9KoCTbZLcRxqqfYZI2xgRmqwYenqF/B/BxLh2BvcYv6UvnsWNFzJxnWAIxSvkuQboTL
	d22qSD2Qfd6C+yOd1VB5BX37YWf8gOg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-6A0D4oo2MhuB5R8fCdb9_A-1; Wed, 07 Aug 2024 07:39:42 -0400
X-MC-Unique: 6A0D4oo2MhuB5R8fCdb9_A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36878581685so973090f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 04:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723030781; x=1723635581;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RIQLd+3N+swCJsaD2XUhaZjgfvR/HcyggoFyBnsDkSk=;
        b=XYEDbSqMrMAVFQmFMi9GrSfj1Qw4r5uH/K4bMbhDfINbOeOiZ+yNIxuYYRrv8Fv4s/
         Lr1ECgWoKgO3aiuAYNhhKnIC3XzdD4dGONjydXBl6QRaxvT+Sn3Hbi/bbkbGxex2fHz2
         CxKpVmf0qY2oLd6na0vTLoWYMohZ2+cZ0U7yxQKYcMRCBlFUc73hzt4DZJmAPR4ixJ6m
         c5+pEBsJAxAL3RvF1orjQSIj3z+MhaLliKjr45EmqZ5PCFMlE12utogb6Dq7rkcEJ/c/
         AiHK6umM7UJvkZGg7OoJkcLK/hroAxicXWv63tK7TodBqWUtbJRDQyvmmeiFed/+1n6b
         9eog==
X-Forwarded-Encrypted: i=1; AJvYcCXlKDjwbGNcftGDkPFrSb1wQbkodj6916zg6D61yTBhkxzJwXH2S7DeboyvHiOQatqqeGwivuhCW/sT9OUIXntvloKCFg/uVexOVkj0
X-Gm-Message-State: AOJu0YygNQpRiJ7DGN1HV1P1CT5xUFQpkkk7iBSiZbLYOntS7CLg69X/
	lbZwd9yH6HAnbdU3Cu1Am+SrHFBjk40qKiyNQswZax0aa/iEjpUPclALkrxX8PZXwiporRbsHw1
	EWniz0I1e7Zv7PC02XE48g6yBWK5TJH3pKlB84jQiWOzib+vojVEn8t6IABcY3w==
X-Received: by 2002:a5d:4e91:0:b0:367:958e:9821 with SMTP id ffacd0b85a97d-36bbc12d79emr12162296f8f.29.1723030781206;
        Wed, 07 Aug 2024 04:39:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+5nXMf9RMndC1b+ktQv0Y0qar361a5a9rrpHRh9xPwJBnkPs6RLZcnWEDpIQrMs2BllBOuw==
X-Received: by 2002:a5d:4e91:0:b0:367:958e:9821 with SMTP id ffacd0b85a97d-36bbc12d79emr12162246f8f.29.1723030780562;
        Wed, 07 Aug 2024 04:39:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1a00:df86:93fe:6505:d096? (p200300cbc7081a00df8693fe6505d096.dip0.t-ipconnect.de. [2003:cb:c708:1a00:df86:93fe:6505:d096])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd01efe5sm15754160f8f.46.2024.08.07.04.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 04:39:40 -0700 (PDT)
Message-ID: <a8c813b5-abce-48cf-9d14-2f969d6c8180@redhat.com>
Date: Wed, 7 Aug 2024 13:39:38 +0200
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
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@techsingularity.net
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
 <418e818a-f385-459e-a84d-e3880ac08ad5@redhat.com>
 <cf8dc1c6-948a-42e7-8aef-c6183ca6cac0@arm.com>
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
In-Reply-To: <cf8dc1c6-948a-42e7-8aef-c6183ca6cac0@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.08.24 16:14, Dev Jain wrote:
> 
> On 8/5/24 16:16, David Hildenbrand wrote:
>> On 05.08.24 11:51, Dev Jain wrote:
>>>
>>> On 8/1/24 19:18, David Hildenbrand wrote:
>>>> On 01.08.24 15:43, Will Deacon wrote:
>>>>> On Thu, Aug 01, 2024 at 03:26:57PM +0200, David Hildenbrand wrote:
>>>>>> On 01.08.24 15:13, David Hildenbrand wrote:
>>>>>>>>>> To dampen the tradeoff, we could do this in shmem_fault()
>>>>>>>>>> instead? But
>>>>>>>>>> then, this would mean that we do this in all
>>>>>>>>>>
>>>>>>>>>> kinds of vma->vm_ops->fault, only when we discover another
>>>>>>>>>> reference
>>>>>>>>>> count race condition :) Doing this in do_fault()
>>>>>>>>>>
>>>>>>>>>> should solve this once and for all. In fact, do_pte_missing()
>>>>>>>>>> may call
>>>>>>>>>> do_anonymous_page() or do_fault(), and I just
>>>>>>>>>>
>>>>>>>>>> noticed that the former already checks this using
>>>>>>>>>> vmf_pte_changed().
>>>>>>>>>
>>>>>>>>> What I am still missing is why this is (a) arm64 only; and (b) if
>>>>>>>>> this
>>>>>>>>> is something we should really worry about. There are other reasons
>>>>>>>>> (e.g., speculative references) why migration could temporarily
>>>>>>>>> fail,
>>>>>>>>> does it happen that often that it is really something we have to
>>>>>>>>> worry
>>>>>>>>> about?
>>>>>>>>
>>>>>>>>
>>>>>>>> (a) See discussion at [1]; I guess it passes on x86, which is quite
>>>>>>>> strange since the race is clearly arch-independent.
>>>>>>>
>>>>>>> Yes, I think this is what we have to understand. Is the race simply
>>>>>>> less
>>>>>>> likely to trigger on x86?
>>>>>>>
>>>>>>> I would assume that it would trigger on any arch.
>>>>>>>
>>>>>>> I just ran it on a x86 VM with 2 NUMA nodes and it also seems to
>>>>>>> work here.
>>>>>>>
>>>>>>> Is this maybe related to deferred flushing? Such that the other CPU
>>>>>>> will
>>>>>>> by accident just observe the !pte_none a little less likely?
>>>>>>>
>>>>>>> But arm64 also usually defers flushes, right? At least unless
>>>>>>> ARM64_WORKAROUND_REPEAT_TLBI is around. With that we never do
>>>>>>> deferred
>>>>>>> flushes.
>>>>>>
>>>>>> Bingo!
>>>>>>
>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>>> index e51ed44f8b53..ce94b810586b 100644
>>>>>> --- a/mm/rmap.c
>>>>>> +++ b/mm/rmap.c
>>>>>> @@ -718,10 +718,7 @@ static void set_tlb_ubc_flush_pending(struct
>>>>>> mm_struct
>>>>>> *mm, pte_t pteval,
>>>>>>      */
>>>>>>     static bool should_defer_flush(struct mm_struct *mm, enum
>>>>>> ttu_flags flags)
>>>>>>     {
>>>>>> -       if (!(flags & TTU_BATCH_FLUSH))
>>>>>> -               return false;
>>>>>> -
>>>>>> -       return arch_tlbbatch_should_defer(mm);
>>>>>> +       return false;
>>>>>>     }
>>>>>>
>>>>>>
>>>>>> On x86:
>>>>>>
>>>>>> # ./migration
>>>>>> TAP version 13
>>>>>> 1..1
>>>>>> # Starting 1 tests from 1 test cases.
>>>>>> #  RUN           migration.shared_anon ...
>>>>>> Didn't migrate 1 pages
>>>>>> # migration.c:170:shared_anon:Expected migrate(ptr, self->n1,
>>>>>> self->n2) (-2)
>>>>>> == 0 (0)
>>>>>> # shared_anon: Test terminated by assertion
>>>>>> #          FAIL  migration.shared_anon
>>>>>> not ok 1 migration.shared_anon
>>>>>>
>>>>>>
>>>>>> It fails all of the time!
>>>>>
>>>>> Nice work! I suppose that makes sense as, with the eager TLB
>>>>> invalidation, the window between the other CPU faulting and the
>>>>> migration entry being written is fairly wide.
>>>>>
>>>>> Not sure about a fix though :/ It feels a bit overkill to add a new
>>>>> invalid pte encoding just for this.
>>>>
>>>> Something like that might make the test happy in most cases:
>>>>
>>>> diff --git a/tools/testing/selftests/mm/migration.c
>>>> b/tools/testing/selftests/mm/migration.c
>>>> index 6908569ef406..4c18bfc13b94 100644
>>>> --- a/tools/testing/selftests/mm/migration.c
>>>> +++ b/tools/testing/selftests/mm/migration.c
>>>> @@ -65,6 +65,7 @@ int migrate(uint64_t *ptr, int n1, int n2)
>>>>           int ret, tmp;
>>>>           int status = 0;
>>>>           struct timespec ts1, ts2;
>>>> +       int errors = 0;
>>>>
>>>>           if (clock_gettime(CLOCK_MONOTONIC, &ts1))
>>>>                   return -1;
>>>> @@ -79,12 +80,17 @@ int migrate(uint64_t *ptr, int n1, int n2)
>>>>                   ret = move_pages(0, 1, (void **) &ptr, &n2, &status,
>>>>                                   MPOL_MF_MOVE_ALL);
>>>>                   if (ret) {
>>>> -                       if (ret > 0)
>>>> +                       if (ret > 0) {
>>>> +                               if (++errors < 100)
>>>> +                                       continue;
>>>>                                   printf("Didn't migrate %d pages\n",
>>>> ret);
>>>> -                       else
>>>> +                       } else {
>>>>                                   perror("Couldn't migrate pages");
>>>> +                       }
>>>>                           return -2;
>>>>                   }
>>>> +               /* Progress! */
>>>> +               errors = 0;
>>>>
>>>>                   tmp = n2;
>>>>                   n2 = n1;
>>>>
>>>>
>>>> [root@localhost mm]# ./migration
>>>> TAP version 13
>>>> 1..1
>>>> # Starting 1 tests from 1 test cases.
>>>> #  RUN           migration.shared_anon ...
>>>> #            OK  migration.shared_anon
>>>> ok 1 migration.shared_anon
>>>> # PASSED: 1 / 1 tests passed.
>>>> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
>>>
>>>
>>> This does make the test pass, to my surprise, since what you are doing
>>> from userspace
>>>
>>> should have been done by the kernel, because it retries folio unmapping
>>> and moving
>>>
>>> NR_MAX_MIGRATE_(A)SYNC_RETRY times; I had already tested pumping up
>>> these
>>>
>>> macros and the original test was still failing. Now, I digged in more,
>>> and, if the
>>>
>>> following assertion is correct:
>>>
>>>
>>> Any thread having a reference on a folio will end up calling
>>> folio_lock()
>>>
>>
>> Good point. I suspect concurrent things like read/write would also be
>> able to trigger this (did not check, though).
>>
>>>
>>> then it seems to me that the retry for loop wrapped around
>>> migrate_folio_move(), inside
>>>
>>> migrate_pages_batch(), is useless; if migrate_folio_move() fails on the
>>> first iteration, it is
>>>
>>> going to fail for all iterations since, if I am reading the code path
>>> correctly, the only way it
>>>
>>> fails is when the actual refcount is not equal to expected refcount (in
>>> folio_migrate_mapping()),
>>>
>>> and there is no way that the extra refcount is going to get released
>>> since the migration path
>>>
>>> has the folio lock.
>>>
>>> And therefore, this begs the question: isn't it logical to assert the
>>> actual refcount against the
>>>
>>> expected refcount, just after we have changed the PTEs, so that if this
>>> assertion fails, we can
>>>
>>> go to the next iteration of the for loop for migrate_folio_unmap()
>>> inside migrate_pages_batch()
>>>
>>> by calling migrate_folio_undo_src()/dst() to restore the old state? I am
>>> trying to implement
>>>
>>> this but is not as straightforward as it seemed to me this morning.
>>
>> I agree with your assessment that migration code currently doesn't
>> handle the case well when some other thread does an unconditional
>> folio_lock(). folio_trylock() users would be handled, but that's not
>> what we want with FGP_LOCK I assume.
>>
>> So IIUC, your idea would be to unlock the folio in migration code and
>> try again their. Sounds reasonable, without looking into the details :)
> 
> 

BTW, I was trying to find the spot that would do the folio_lock(), but 
filemap_fault() does the lock_folio_maybe_drop_mmap() where we do a 
folio_trylock().

Where exactly is the folio_lock() on the fault path that would prohibit 
us from making progress?

> (Adding Mel if at all he has any comments for a compaction use-case)
> 
> What I was trying to say is this (forgive me for the hard-coded value):

The hard-coded 2 is wrong indeed :)

> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a8c6f466e33a..404af46dd661 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1262,6 +1262,8 @@ static int migrate_folio_unmap(new_folio_t
> get_new_folio,
> }
> if (!folio_mapped(src)) {
> + if (folio_ref_count(src) != 2)
> + goto out;
> __migrate_folio_record(dst, old_page_state, anon_vma);
> return MIGRATEPAGE_UNMAP;
> }
> This will give us more chances to win the race. On an average, now
> the test fails on 100 iterations of move_pages(). If you multiply
> the NR_MAX_PAGES_(A)SYNC_RETRY macros by 3, the average goes above
> to 2000.
> But if the consensus is that this is just pleasing the test without
> any real use-case (compaction?) then I guess I am alright with making
> the change in the test.

I'd be curious if other activity (besides fault, like concurrent 
read()/write()/...) can similarly make migration fail. I suspect it can.

-- 
Cheers,

David / dhildenb


