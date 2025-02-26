Return-Path: <linux-kernel+bounces-534510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9320A467CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55242424AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8545224888;
	Wed, 26 Feb 2025 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkTrZ100"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B56B224896
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590038; cv=none; b=EG91izW+Xpiw4WB9oQvuN57sEKshV4nK6BdSjGPlLMiudL/Vyk9dmn6gjwtcyBPChy3U4f1j4REEzyL74QzFj1i4UnQk0rvW2rLAawDtPL+vk6hEUeT+iavzPYWdkUSwk6GgXjCYFMjGMmNLsQuIlSBSdM8R1hwRPTHfiVTvEKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590038; c=relaxed/simple;
	bh=jKGuH3EIy718YxyGI9P04sZPm66l8raySDvRydcPVuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXQ2VQBFrw90zrxMWX2u96DE8H1MEzioTtrcf3Ikp0h2dPDPasDuFe3sUoC4Fj9eP6CbwbYFBK3cLBAirDbgES4XaSV3Ra6Gx/mnCQt8NnI78doAOhScTH9DJJDqGytuYbUR0M18BSqOTcFlt0JUNf8V1sHpiGLVUQKc1ErIGaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IkTrZ100; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740590035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2CUP2afo0J8CnMFqbpn1EyoxaUVXlazu0bjahBWSp50=;
	b=IkTrZ100pdjsa1nahzAUooLi7BcEXBf7+wyeeQasMAnRVAKJUv/bw5QvkZo1Gx643su9kI
	9ItDvKBgQXUkrYSNSCt8zenLrlACTz4MhM14WR8gI9b5Efp0oohimVifNMvw19KcxV0QiH
	wAX7kSrUX4HP9f7uBGj1/6sKJXQRp5A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-jIj4DupOO9m9pgvYUOIkhQ-1; Wed, 26 Feb 2025 12:13:53 -0500
X-MC-Unique: jIj4DupOO9m9pgvYUOIkhQ-1
X-Mimecast-MFC-AGG-ID: jIj4DupOO9m9pgvYUOIkhQ_1740590032
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43947979ce8so304015e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:13:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740590031; x=1741194831;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2CUP2afo0J8CnMFqbpn1EyoxaUVXlazu0bjahBWSp50=;
        b=m2Bb/AicciDoYIQjmN97rq6WZ/zmIk16TkGy5kQ7TYHFxqIOGXxlIOptIE0pA2Ambc
         mNRckw0Onih4C2zHvl6ZIsDJraUeQnE5IP/6/u9UROD6zd5PSV16rDJPolKHr4m1Wm8t
         Yg0gjP5fqs2D9Cjl7cfcyosF5PrkPaE02QY0wqL6fM5cGxgnmN1xYUr0kbHnCRHbLLcV
         42a1t/2Y6Kxts8MDpcerXlfkaB70cEjOb0DFQvLjua1p0b16izvMZuZjpirZzVTkpjx2
         3Am5R7h7HNbmrnJ1VEjyVosiMQ4AJtx5vRP4t7OelOmSi/+fkqEaI4hY14VsSzeYxGIj
         /5mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIDbmZ1QAQHrclUEXwHxgjVA+ehxjyacBtDMnzk6id8YCVgcQ0upIwoDHmy4QOFRANo/znhC5D+JMUmUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzokfdi0sCVYeYD5Wgf/Axp3mmL6r7YyucpW2Qp82p3/nGY+sOf
	OGamgrwov22Fi+8ttiEx7GbL254EURH3SuPvkNXeZ0cuBbR2fmmWSb5V68LlqrIh4RC3IjtVw72
	P1HQduc9DSBgWO8Q8768YY51+fOzXWK3HiIILPdOsaJz6YaqjkA0pEwxzxsfStA==
X-Gm-Gg: ASbGncuzAS5e5V2AUEDTyHmw1fp0pd5z6xLArldoGmqCbsQYwivnr5L2VxIG31vdl3r
	sJGr0LgOo0+pXpVtK3mWmAR/UewSPvs+ignLQDWyCOFECRuwiVgl1+/c76FlgkIkUNtYyABu00/
	8Br3KQFAa00Lct8+/ldc+rRy6iBGHyfFfqm/VJaCxt7MuoG2b1HQnO0aJPy2Ewb7XEFm2aQVshk
	YPZnKw/1CMzFNaZfjFhDVZt2Nzmw8BhXvjtVSOWbk2cm163vbFqh7qt6eKLTnWC/wshetMIgsYb
	Um8w1st2PZfzF7RjuGZHitz1ZQB4y3XXmWZfrBy/+EmMw5IiJQNu0p+8a53SA0V/N0u7+Zzs1CT
	+1nL82r12g23QSbryAjE49nZi/lEXc47Dxe0eTYXoNcc=
X-Received: by 2002:a05:600c:154b:b0:439:9f19:72ab with SMTP id 5b1f17b1804b1-43aa6d14bf5mr108533605e9.23.1740590031558;
        Wed, 26 Feb 2025 09:13:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0sC+EP7LuT2O8cDHJ5c4C4109uSObs54Fb8tpKj8SpndGbmz2+EBCMLHFpEQZIB3L69+v+Q==
X-Received: by 2002:a05:600c:154b:b0:439:9f19:72ab with SMTP id 5b1f17b1804b1-43aa6d14bf5mr108533305e9.23.1740590031151;
        Wed, 26 Feb 2025 09:13:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c747:ff00:9d85:4afb:a7df:6c45? (p200300cbc747ff009d854afba7df6c45.dip0.t-ipconnect.de. [2003:cb:c747:ff00:9d85:4afb:a7df:6c45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd882602sm6196411f8f.41.2025.02.26.09.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 09:13:50 -0800 (PST)
Message-ID: <00c82c92-35a0-441c-b5b5-e4a6c8a4a9b7@redhat.com>
Date: Wed, 26 Feb 2025 18:13:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] arm64: mm: Populate vmemmap at the page level if not
 section aligned
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>, anshuman.khandual@arm.com,
 catalin.marinas@arm.com
Cc: will@kernel.org, ardb@kernel.org, ryan.roberts@arm.com,
 mark.rutland@arm.com, joey.gouly@arm.com, dave.hansen@linux.intel.com,
 akpm@linux-foundation.org, chenfeiyang@loongson.cn, chenhuacai@kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com
References: <20250217092907.3474806-1-quic_zhenhuah@quicinc.com>
 <8c1578ed-cfef-4fba-a334-ebf5eac26d60@redhat.com>
 <ce2bd045-3e3a-42bf-9a48-9ad806ff3765@quicinc.com>
 <871c0dae-c419-4ac2-9472-6901aab90dcf@redhat.com>
 <a5439884-551c-4104-9175-f95b0895a489@quicinc.com>
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
In-Reply-To: <a5439884-551c-4104-9175-f95b0895a489@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Sorry, I somehow missed this mail.

>>> Hi David,
>>>
>>> I had the same doubt initially.
>>> After going through the codes, I noticed for vmemmap_populate(), the
>>> arguments "start" and "end" passed down should already be within one
>>> section.
>>> early path:
>>> for_each_present_section_nr
>>>      __populate_section_memmap
>>>          ..
>>>          vmemmap_populate()
>>>
>>> hotplug path:
>>> __add_pages
>>>      section_activate
>>>          vmemmap_populate()
>>>
>>> Therefore.. focusing only on the size seems OK to me, and fall back
>>> solution below appears unnecessary?
>>
>> Ah, in that case it is fine. Might make sense to document/enforce that
>> somehow for the time being ...
> 
> Shall I document and WARN_ON if the size exceeds? like:
> WARN_ON(end - start > PAGES_PER_SECTION * sizeof(struct page))

Probably WARN_ON_ONCE() along with a comment that we should never exceed 
a single memory section.

> 
> Since vmemmap_populate() is implemented per architecture, the change
> should apply for other architectures as well. However I have no setup to
> test it on...
> Therefore, May I implement it only for arm64 now ?

Would work for me; better than no warning.

> Additionally, from previous discussion, the change is worth
> backporting(apologies for missing to CC stable kernel in this version).
> Keeping it for arm64 should simplify for backporting. WDYT?

Jup. Of course, we could add a generic warning in a separate patch.

> 
>>
>>
>>>> +/*
>>>> + * Try to populate PMDs, but fallback to populating base pages when
>>>> ranges
>>>> + * would only partially cover a PMD.
>>>> + */
>>>>     int __meminit vmemmap_populate_hugepages(unsigned long start,
>>>> unsigned
>>>> long end,
>>>>                                             int node, struct vmem_altmap
>>>> *altmap)
>>>>     {
>>>> @@ -313,6 +317,9 @@ int __meminit vmemmap_populate_hugepages(unsigned
>>>> long start, unsigned long end,
>>>>            for (addr = start; addr < end; addr = next) {
>>>
>>> This for loop appears to be redundant for arm64 as well, as above
>>> mentioned, a single call to pmd_addr_end() should suffice.
>>
>> Right, that was what was confusing me in the first place.
>>
>>>
>>>>                    next = pmd_addr_end(addr, end);
>>>>
>>>> +               if (!IS_ALIGNED(addr, PMD_SIZE) || !IS_ALIGNED(next,
>>>> PMD_SIZE))
>>>> +                       goto fallback;
>>>> +
>>>>                    pgd = vmemmap_pgd_populate(addr, node);
>>>>                    if (!pgd)
>>>>                            return -ENOMEM;
>>>> @@ -346,6 +353,7 @@ int __meminit vmemmap_populate_hugepages(unsigned
>>>> long start, unsigned long end,
>>>>                            }
>>>>                    } else if (vmemmap_check_pmd(pmd, node, addr, next))
>>>>                            continue;
>>>> +fallback:
>>>>                    if (vmemmap_populate_basepages(addr, next, node,
>>>> altmap))
>>>>                            return -ENOMEM;
>>>
>>> It seems we have no chance to call populate_basepages here?
>>
>>
>> Can you elaborate?
> 
> It's invoked within vmemmap_populate_hugepages(), which is called by
> vmemmap_populate(). This implies that we are always performing a whole
> section hotplug?

Ah, you meant only in the context of this change, yes. I was confused, 
because there are other reasons why we run into that fallback (failing 
to allocate a PMD).

-- 
Cheers,

David / dhildenb


