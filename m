Return-Path: <linux-kernel+bounces-169501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4BF8BC992
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90781F211D7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCFC42065;
	Mon,  6 May 2024 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JU+Io/vz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483E6107A6
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714984289; cv=none; b=XqriKBVPEbZTxQelok0AeGiL8gOo0cIcqU82V2CkqzURiH/OdH2hdHXBP/EUCrcCsHJ1JXGbaS2u5jhl0M6URxY9TBNpekKnVqHQ+j2Bsz4RmXd4dInwuG+aePvxuR6hp3+DRGgwe+6XpN/R5Rq+i667PpN5QIUoduW0DX4R5N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714984289; c=relaxed/simple;
	bh=J8E7sUV/EFKV8UqH/xxDgEPusH1BssGCVqxL1eSDPcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Daqxn4WBMCH/0IhhQ29IDhaG6xsJcRp7bBGzyXgYQmdvJ2+0/u5+jHpAXf52yPQT51rxkS350wW6lOJNGcNDhGkP5jZaIMa2Wl/RBJn7Ya05uJC0mKyO5B+O2RyYcp5Nq0v1t4Gf1vfvajOP33kX1jQXeYSmW32TA4xDqEHEosI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JU+Io/vz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714984287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DXmA2b+0EarjnPnKdLd0vJ5iWqqNSQZQBKO2ERTE81c=;
	b=JU+Io/vzhN/MSbmCL7ebRDO5QVc3qkfyZKVXx3/Oj3Z6RxSWpLh16bGFTeSWsN5XDs9kDo
	ZEoh3iBbFKhqJF9cTqM3hW4CodQ3oqGPbajvolOKJ+TPyPPTV0E4lPHOoKtibPHngaEvCr
	9mnOaMwevkLXlWsmJnCits9kbs0SJB8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-f-K0Zs_3P8i_K0mXXBoI9w-1; Mon, 06 May 2024 04:31:25 -0400
X-MC-Unique: f-K0Zs_3P8i_K0mXXBoI9w-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-51f7c8c7d85so1087428e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 01:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714984284; x=1715589084;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DXmA2b+0EarjnPnKdLd0vJ5iWqqNSQZQBKO2ERTE81c=;
        b=cq9a1XXwDOaNUhyxOv5vylEk4tSEk83nPw0YaoHH+fPa+0u82PGr/0VH8Q+kzfQqba
         HOtIR8bKwGxgRYy51TnQA54jIjD6lD3MeAbWbOA6M2Hr5lLaj22z96TX8NZWDyTjuwkr
         AkWT0ow2QD1WuUB8jyylwRXVH+0UoZVyIq8RklaFH+8PcUpNph9a52wPB8/KoPB3anJ7
         nHloGbsoK4cBGDMwwSAbHpo9qn1RnJqM1cDn4elDHOCbQHwrWH6iFn5PIjWVaYw+EuPJ
         QS+Z4fnB5tYMJKsqs0UNWzNmNIA8+S2YFKsCN+zSXVfHWJnYHD9Ib9HQmwH3hSX7rS3Q
         0hag==
X-Forwarded-Encrypted: i=1; AJvYcCXB24NtuMWUCXEEM1RIeRd/Nhvyq53BRL8IvadlFwDqR2hKnbFlTf0Shd1djAKt8KAu+VXO5SJaEFDtuzHl+hAzqSlInHW604V2sQlF
X-Gm-Message-State: AOJu0YzRynX234gyh17/oG+qlPd7sm+MOn5jSz/6Ro2jLjQgtirKoMVx
	qqh4Hv4HK8ZQNwW9tnbMGzL+N52KhdK8VsAEWlw8VaYIeMnPYn2csirSJTA9zDFdPqt4NdU6U+O
	fxwP3XRawAfJw81ttp7m++cxSsjGgeZn9lO5t1s6RHzuqwlIZ1Xw+BXVvPMX5pQ==
X-Received: by 2002:a19:2d48:0:b0:51d:682d:c2ab with SMTP id t8-20020a192d48000000b0051d682dc2abmr5675319lft.32.1714984284266;
        Mon, 06 May 2024 01:31:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRtWmuCrMd8AAAcj4bnvXdNFeWP6pfUpHAXDYA7Eh4bV0WI0D7uGbcnZBa7a8tZ5D90pXD0A==
X-Received: by 2002:a19:2d48:0:b0:51d:682d:c2ab with SMTP id t8-20020a192d48000000b0051d682dc2abmr5675288lft.32.1714984283685;
        Mon, 06 May 2024 01:31:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:bf00:182c:d606:87cf:6fea? (p200300cbc74bbf00182cd60687cf6fea.dip0.t-ipconnect.de. [2003:cb:c74b:bf00:182c:d606:87cf:6fea])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0041bb11ff5a7sm19042298wmq.8.2024.05.06.01.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 01:31:22 -0700 (PDT)
Message-ID: <ab283f1f-93bd-4f5e-8172-02109e02e8c4@redhat.com>
Date: Mon, 6 May 2024 10:31:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] mm: introduce pte_move_swp_offset() helper which
 can move offset bidirectionally
To: Barry Song <21cnbao@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, baolin.wang@linux.alibaba.com, chrisl@kernel.org,
 hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com,
 ziy@nvidia.com
References: <20240503005023.174597-1-21cnbao@gmail.com>
 <20240503005023.174597-4-21cnbao@gmail.com>
 <7548e30c-d56a-4a57-ab87-86c9c8e523b1@arm.com>
 <CAGsJ_4wx60GoB1erTQ7v3GTXLb_140bOJ_+z=kqY39eOd3P23g@mail.gmail.com>
 <0d20d8af-e480-4eb8-8606-1e486b13fd7e@redhat.com>
 <CAGsJ_4wP75tFWDcKJZfw7Pk9AdigVCv0niGUeTY6RTZwk1UnjQ@mail.gmail.com>
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
In-Reply-To: <CAGsJ_4wP75tFWDcKJZfw7Pk9AdigVCv0niGUeTY6RTZwk1UnjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.05.24 10:20, Barry Song wrote:
> On Mon, May 6, 2024 at 8:06 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 04.05.24 01:40, Barry Song wrote:
>>> On Fri, May 3, 2024 at 5:41 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> On 03/05/2024 01:50, Barry Song wrote:
>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>
>>>>> There could arise a necessity to obtain the first pte_t from a swap
>>>>> pte_t located in the middle. For instance, this may occur within the
>>>>> context of do_swap_page(), where a page fault can potentially occur in
>>>>> any PTE of a large folio. To address this, the following patch introduces
>>>>> pte_move_swp_offset(), a function capable of bidirectional movement by
>>>>> a specified delta argument. Consequently, pte_increment_swp_offset()
>>>>
>>>> You mean pte_next_swp_offset()?
>>>
>>> yes.
>>>
>>>>
>>>>> will directly invoke it with delta = 1.
>>>>>
>>>>> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>>> ---
>>>>>    mm/internal.h | 25 +++++++++++++++++++++----
>>>>>    1 file changed, 21 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/mm/internal.h b/mm/internal.h
>>>>> index c5552d35d995..cfe4aed66a5c 100644
>>>>> --- a/mm/internal.h
>>>>> +++ b/mm/internal.h
>>>>> @@ -211,18 +211,21 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>>>>>    }
>>>>>
>>>>>    /**
>>>>> - * pte_next_swp_offset - Increment the swap entry offset field of a swap pte.
>>>>> + * pte_move_swp_offset - Move the swap entry offset field of a swap pte
>>>>> + *    forward or backward by delta
>>>>>     * @pte: The initial pte state; is_swap_pte(pte) must be true and
>>>>>     *    non_swap_entry() must be false.
>>>>> + * @delta: The direction and the offset we are moving; forward if delta
>>>>> + *    is positive; backward if delta is negative
>>>>>     *
>>>>> - * Increments the swap offset, while maintaining all other fields, including
>>>>> + * Moves the swap offset, while maintaining all other fields, including
>>>>>     * swap type, and any swp pte bits. The resulting pte is returned.
>>>>>     */
>>>>> -static inline pte_t pte_next_swp_offset(pte_t pte)
>>>>> +static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
>>>>
>>>> We have equivalent functions for pfn:
>>>>
>>>>     pte_next_pfn()
>>>>     pte_advance_pfn()
>>>>
>>>> Although the latter takes an unsigned long and only moves forward currently. I
>>>> wonder if it makes sense to have their naming and semantics match? i.e. change
>>>> pte_advance_pfn() to pte_move_pfn() and let it move backwards too.
>>>>
>>>> I guess we don't have a need for that and it adds more churn.
>>>
>>> we might have a need in the below case.
>>> A forks B, then A and B share large folios. B unmap/exit, then large
>>> folios of process
>>> A become single-mapped.
>>> Right now, while writing A's folios, we are CoWing A's large folios
>>> into many small
>>> folios. I believe we can reuse the entire large folios instead of doing nr_pages
>>> CoW and page faults.
>>> In this case, we might want to get the first PTE from vmf->pte.
>>
>> Once we have COW reuse for large folios in place (I think you know that
>> I am working on that), it might make sense to "COW-reuse around",
> 
> TBH, I don't know if you are working on that. please Cc me next time :-)

I could have sworn I mentioned it to you already :)

See

https://lore.kernel.org/linux-mm/a9922f58-8129-4f15-b160-e0ace581bcbe@redhat.com/T/

I'll follow-up on that soonish (now that batching is upstream and the 
large mapcount is on its way upstream).

> 
>> meaning we look if some neighboring PTEs map the same large folio and
>> map them writable as well. But if it's really worth it, increasing page
>> fault latency, is to be decided separately.
> 
> On the other hand, we eliminate latency for the remaining nr_pages - 1 PTEs.
> Perhaps we can discover a more cost-effective method to signify that a large
> folio is probably singly mapped?

Yes, precisely what I am up to!

> and only call "multi-PTEs" reuse while that
> condition is true in PF and avoid increasing latency always?

I'm thinking along those lines:

If we detect that it's exclusive, we can certainly mapped the current 
PTE writable. Then, we can decide how much (and if) we want to 
fault-around writable as an optimization.

For smallish large folios, it might make sense to try faulting around 
most of the folio.

For large large folios (e.g., PTE-mapped 2MiB THP and bigger), we might 
not want to fault around the whole thing -- especially if there is 
little benefit to be had from contig-pte bits.

> 
>>
>>
>>>
>>> Another case, might be
>>> A forks B, and we write either A or B, we might CoW an entire large
>>> folios instead
>>> CoWing nr_pages small folios.
>>>
>>> case 1 seems more useful, I might have a go after some days. then we might
>>> see pte_move_pfn().
>> pte_move_pfn() does sound odd to me. It might not be required to
>> implement the optimization described above. (it's easier to simply read
>> another PTE, check if it maps the same large folio, and to batch from there)
>>
> 
> It appears that your proposal suggests potential reusability as follows: if we
> have a large folio containing 16 PTEs, you might consider reusing only 4 by
> examining PTEs "around" but not necessarily all 16 PTEs. please correct me
> if my understanding is wrong.
> 
> Initially, my idea was to obtain the first PTE using pte_move_pfn() and then
> utilize folio_pte_batch() with the first PTE as arguments to ensure consistency
> in nr_pages, thus enabling complete reuse of the whole folio.

Simply doing an vm_normal_folio(pte - X) == folio and then trying to 
batch from there might be easier and cleaner.

-- 
Cheers,

David / dhildenb


