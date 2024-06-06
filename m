Return-Path: <linux-kernel+bounces-204032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E8E8FE32C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0B81F22352
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E118E152190;
	Thu,  6 Jun 2024 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dw3lUjKK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428F379F4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666878; cv=none; b=VptXd2+gglVKpmFnigTiSwWbsAwPztSAMqkhr7rZodPaASvtkhby0iHlfuGsc0AmTEror9IYh7dwVcvlN+NrQV9gki2/KEkmBj/fQD8JIWq3+kLJebvTQIgF2/+WGWWwQHLr8gPz2W65fm08Yd2FSlaUoHHxn52eKBZRb85CITo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666878; c=relaxed/simple;
	bh=xiQKMXhmswoJYfu87AO/u+Q3CPtVEqr0qVK9t8P54SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ryvvy47MKiPl+hW2iOWkAc9lhqHcuNTSCMdh2d/Jh4nVRgNAmAsJET1NqOdHKoHMBPgfHR3iM/0WPl2QcOkFpqkz6hp3Hoqel53fozwS6JvWVRyz5v6qLS7VJb9MgPEyfKXFXy2TLhy617FuADJr3xx6nWbyxiViUsKxlSe8+u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dw3lUjKK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717666875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sDuQFsGapZ5dAq2VQ6Agr+wNPKN/yhAr1BOmKnlpkcE=;
	b=Dw3lUjKK2OSxvwQZhdkakYlwq2LFJ/5Lm5GCbkv3bpo60GsBc6u0Swurd3I7LeRkSkecgU
	aobzQc+J3ZBEHyHMxv6+wSQrU6zf6HLe8pSd22HD7ZbknjTFRtVwOw+Sm+ESPMDHz1KjP9
	NqSfJ8J7BH3PTR3E5ysL+6Nd8OYpQWU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-aY5RZiHLPOuR_2W__7VXFQ-1; Thu, 06 Jun 2024 05:41:13 -0400
X-MC-Unique: aY5RZiHLPOuR_2W__7VXFQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52bb096e9d8so513422e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717666872; x=1718271672;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sDuQFsGapZ5dAq2VQ6Agr+wNPKN/yhAr1BOmKnlpkcE=;
        b=dvNzP3Bq96vw0HElc2H/W7C70sUUoVV3FOGqlXMA/5i0BlMIKMUf/wOaO/sKPhFLrV
         DRGiXLVlgGa3n+ZIokmx2FwoRHuVIriqo5AAoaTUIADkvetiGLxhWw0ictJ0lDaaMaOu
         ZCiGnxgQQgZKSlImu0mspfElQsJv5FcCMETanANGHsMfRnzA3SLZVBMqOPyZ6KSdxjN3
         zHXQ23horiy5ENdyfpDFfhAUDHxo6Hl66Nz53rRiBZtglLiHpA2i1rgSK5KKAvchg4Y7
         eB4Nbak+85I5sPLqDaYPe6Z/Q7NMau2B1JPNljwJWniWEZF+lRAZE5UX9bFMck0bQuvb
         2Rjw==
X-Forwarded-Encrypted: i=1; AJvYcCXskFaPLBHosIsNK+lwDzHq8hNpEnwfuFO9C1BWuD7oVDlXAWTZKHLmKNJFYm3dw/CXYOCOh23cNFO58Ic8g/dG1aL7GQm2dffQnb+Y
X-Gm-Message-State: AOJu0YzoJZ13BZhtyvS8rA0aai7nblLioLVU3vBBG3eJP83+xWCqcys5
	BZlRy/90X6aJf/y4IoeOF78omlFeG6JYAz1AWbIaPeWLT7TRyhLAeRTvjq5WKS77GWrByHQOgdZ
	dqzuA5fjwudxhsXQgyyWE+8cVhFrLrTWj4EpDNbM6y+uJr1YnZWa3HrvEH4NQhw==
X-Received: by 2002:a19:a40a:0:b0:52b:aa2f:d89b with SMTP id 2adb3069b0e04-52bab4fc5c9mr2758007e87.68.1717666872104;
        Thu, 06 Jun 2024 02:41:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhLqsJXiIpJ9ZW7HW04hpVTkrfSK7URSEN5bAqF0lpzCT8Uw/WRp+1uI1wUYbaEqt8GWmWAQ==
X-Received: by 2002:a19:a40a:0:b0:52b:aa2f:d89b with SMTP id 2adb3069b0e04-52bab4fc5c9mr2757990e87.68.1717666871651;
        Thu, 06 Jun 2024 02:41:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:8800:a73c:ec5b:c02c:5e0b? (p200300cbc7108800a73cec5bc02c5e0b.dip0.t-ipconnect.de. [2003:cb:c710:8800:a73c:ec5b:c02c:5e0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c1aa2easm15655555e9.12.2024.06.06.02.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 02:41:11 -0700 (PDT)
Message-ID: <2a6a1b50-e711-42c2-91f4-42881a6057e9@redhat.com>
Date: Thu, 6 Jun 2024 11:41:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org,
 baolin.wang@linux.alibaba.com, maskray@google.com, ziy@nvidia.com,
 ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, libang.li@antgroup.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240521040244.48760-1-ioworker0@gmail.com>
 <20240521040244.48760-3-ioworker0@gmail.com>
 <fd16b219-bc46-484a-8581-a21240440fa6@redhat.com>
 <CAK1f24kwf4gDwK=8X4z1bM9-H6_M9QKy6-ko9pTUZij-W=40wg@mail.gmail.com>
 <d319f00e-9dfb-43b1-ae81-a2e2afdf36c4@redhat.com>
 <CAK1f24kKra71RSQdFOpQecU6+yMELC748irKUt54Kg64-P=4-A@mail.gmail.com>
 <758f7be7-c17e-46d1-879f-83340ec85749@redhat.com>
 <5a728148-ed93-4d68-a86f-9be3612dedbb@redhat.com>
 <CAK1f24nMbW_UvCTq=K0aFu9=7psYZ9wmHq47J=AK7VYmpCpC4Q@mail.gmail.com>
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
In-Reply-To: <CAK1f24nMbW_UvCTq=K0aFu9=7psYZ9wmHq47J=AK7VYmpCpC4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.06.24 11:38, Lance Yang wrote:
> On Thu, Jun 6, 2024 at 4:06 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 06.06.24 10:01, David Hildenbrand wrote:
>>> On 06.06.24 05:55, Lance Yang wrote:
>>>> On Wed, Jun 5, 2024 at 10:28 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> On 05.06.24 16:20, Lance Yang wrote:
>>>>>> Hi David,
>>>>>>
>>>>>> On Wed, Jun 5, 2024 at 8:46 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>>
>>>>>>> On 21.05.24 06:02, Lance Yang wrote:
>>>>>>>> In preparation for supporting try_to_unmap_one() to unmap PMD-mapped
>>>>>>>> folios, start the pagewalk first, then call split_huge_pmd_address() to
>>>>>>>> split the folio.
>>>>>>>>
>>>>>>>> Since TTU_SPLIT_HUGE_PMD will no longer perform immediately, we might
>>>>>>>> encounter a PMD-mapped THP missing the mlock in the VM_LOCKED range during
>>>>>>>> the page walk. It’s probably necessary to mlock this THP to prevent it from
>>>>>>>> being picked up during page reclaim.
>>>>>>>>
>>>>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>>>>>> Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
>>>>>>>> ---
>>>>>>>
>>>>>>> [...] again, sorry for the late review.
>>>>>>
>>>>>> No worries at all, thanks for taking time to review!
>>>>>>
>>>>>>>
>>>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>>>>> index ddffa30c79fb..08a93347f283 100644
>>>>>>>> --- a/mm/rmap.c
>>>>>>>> +++ b/mm/rmap.c
>>>>>>>> @@ -1640,9 +1640,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>>>>>>>           if (flags & TTU_SYNC)
>>>>>>>>                   pvmw.flags = PVMW_SYNC;
>>>>>>>>
>>>>>>>> -     if (flags & TTU_SPLIT_HUGE_PMD)
>>>>>>>> -             split_huge_pmd_address(vma, address, false, folio);
>>>>>>>> -
>>>>>>>>           /*
>>>>>>>>            * For THP, we have to assume the worse case ie pmd for invalidation.
>>>>>>>>            * For hugetlb, it could be much worse if we need to do pud
>>>>>>>> @@ -1668,20 +1665,35 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>>>>>>>           mmu_notifier_invalidate_range_start(&range);
>>>>>>>>
>>>>>>>>           while (page_vma_mapped_walk(&pvmw)) {
>>>>>>>> -             /* Unexpected PMD-mapped THP? */
>>>>>>>> -             VM_BUG_ON_FOLIO(!pvmw.pte, folio);
>>>>>>>> -
>>>>>>>>                   /*
>>>>>>>>                    * If the folio is in an mlock()d vma, we must not swap it out.
>>>>>>>>                    */
>>>>>>>>                   if (!(flags & TTU_IGNORE_MLOCK) &&
>>>>>>>>                       (vma->vm_flags & VM_LOCKED)) {
>>>>>>>>                           /* Restore the mlock which got missed */
>>>>>>>> -                     if (!folio_test_large(folio))
>>>>>>>> +                     if (!folio_test_large(folio) ||
>>>>>>>> +                         (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)))
>>>>>>>>                                   mlock_vma_folio(folio, vma);
> 
> Should we still keep the '!pvmw.pte' here? Something like:
> 
> if (!folio_test_large(folio) || !pvmw.pte)
>      mlock_vma_folio(folio, vma);

I was wondering the same the whole time ...

> 
> We can mlock the THP to prevent it from being picked up during page reclaim.
> 
> David, I’d like to hear your thoughts on this ;)

but I think there is no need to for now, in the context of your patchset. :)

-- 
Cheers,

David / dhildenb


