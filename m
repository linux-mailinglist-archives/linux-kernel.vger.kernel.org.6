Return-Path: <linux-kernel+bounces-407484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3D69C6E16
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051FC1F21F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEE91F80AF;
	Wed, 13 Nov 2024 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNOcwadi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DE11FF5EA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498217; cv=none; b=MBKQJRKMwW9oCqjSybCAiURatkRT52/28FQMDBWDLD+51H8cdbUjs7w3wKbD87vQJSdG9S3mtT7oYOIMVZEzRxMKA3iRxcFq3g3PjHtppZI/8cQYZMkGObz0WIndQmPi1Q/E1dzmlvK93DV1HWOl7EVtK51OWUolznH5pt5eLsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498217; c=relaxed/simple;
	bh=mA1LxL+FFtOpvHevcW+ZfVKRtnDLvZKWh4rXL0rhEEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgZ0QvoipZZXOngsAGqE+yPw3ExiCgE/M8ZN/gkLKDYhaXpzWkrcJ20igoR9zUiGsdU16Kb2tiDL73fYfe+EXtnnq6tRcrB/92bszXuifAXo/oYpQsrDH6nG8f7gYFnVIVj/s22dKoXg0TPOnCWtmK1mGt85rwFG56SY8CKYBo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNOcwadi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731498214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pcm28nj08LB3qo2IXpX60sQSkQ9cIzdPDGUCWO8Afko=;
	b=KNOcwadiVJjJNToB8icKUdcDbKpw8kOkjKes02sGbO0PoE4PpteLHQ/mzFbKCjLK9Kms59
	DG4k9VoTnSJfAxWX3KtzMLWHhHODP1xNG2mDfA5wb09LFaMqmvM7Yxw/ES0ngeOgAiEC26
	Z2URB26LSGXLtOe9yLWkKpZhsPD1mig=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-6uXYR9T8MCyTyum798644w-1; Wed, 13 Nov 2024 06:43:33 -0500
X-MC-Unique: 6uXYR9T8MCyTyum798644w-1
X-Mimecast-MFC-AGG-ID: 6uXYR9T8MCyTyum798644w
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-432d8843783so675115e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:43:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731498212; x=1732103012;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pcm28nj08LB3qo2IXpX60sQSkQ9cIzdPDGUCWO8Afko=;
        b=X1FyH0i6aXLLDOE5AU1fD3Q120GkldSDzYnzKEvpnuOSYl3lsqtbd6jEfcDa8Ow3pw
         WC7nOcphIgxtoePhbALMmrujQbwIb2KJTmbfvBRS8h+TioXN880gqZzy2ZJTFYktokLd
         Kj80NRvustaD+U8pYBHFeD0vYOGjJLNZ7wq3mYjD/3KxIo308COUHUc+gu3T4CvBg5bL
         XvoX/XfRkGH/dOXy4GjUcQ/t7BCCXGDmwEgx6sAjEX4FwUeHBuC4fv+0hpa8340dB+Ub
         X5fQSlwbNMsIs/DdVV4jLuyVtY0nNE7LMVkv58Y8Z40MzNaY2x4QNlEhMGACAbKHCpHp
         cb6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1Mu9CEX1MyQTqi1qnNw28PKSsViIHsOsaiPPJ5caYlDkRE27jKkY04ec126oUJHhnXFsxYymOov2DND8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEqKOwymNADyxGXu9HkHGazkqV9t3YFPjO7pCpHEYcfxcZ+1J4
	CkpsiAMyCvjqFpUNXGXVDgsEVab1ggrc5Tky9DOPrvA5YCeOGUqk80TU18bRA4NpfDa1Kkx9L8J
	g42AS7dp7veCNtJysrWHkhhEiCy4A0AdaileJhLRk/MiDrGJoXB49hJ3tKQSBtQ==
X-Received: by 2002:a05:600c:3b9e:b0:431:3927:d1bc with SMTP id 5b1f17b1804b1-432b74fcb02mr173864415e9.2.1731498211909;
        Wed, 13 Nov 2024 03:43:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwuW1QWxrCg2YHLeulvtRyAVVdoh46ikZDd47mIT3FGVAA1XYWtncN+eEqg/leZ0uJSYCoTw==
X-Received: by 2002:a05:600c:3b9e:b0:431:3927:d1bc with SMTP id 5b1f17b1804b1-432b74fcb02mr173864105e9.2.1731498211487;
        Wed, 13 Nov 2024 03:43:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:1500:d584:7ad8:d3f7:5539? (p200300cbc7081500d5847ad8d3f75539.dip0.t-ipconnect.de. [2003:cb:c708:1500:d584:7ad8:d3f7:5539])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d55417f3sm21648285e9.34.2024.11.13.03.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 03:43:31 -0800 (PST)
Message-ID: <6e9c649f-5fc9-4fcc-928c-c4f46a74ca66@redhat.com>
Date: Wed, 13 Nov 2024 12:43:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] mm: introduce do_zap_pte_range()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: jannh@google.com, hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, peterx@redhat.com,
 catalin.marinas@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <cover.1730360798.git.zhengqi.arch@bytedance.com>
 <1639ac32194f2b2590852f410fd3ce3595eb730b.1730360798.git.zhengqi.arch@bytedance.com>
 <db3cd6c1-03d6-48fd-9591-ab3e90d7e10f@redhat.com>
 <2fd11f54-8c0c-401d-8635-e54ebf7facc2@bytedance.com>
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
In-Reply-To: <2fd11f54-8c0c-401d-8635-e54ebf7facc2@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.11.24 03:40, Qi Zheng wrote:
> 
> 
> On 2024/11/13 01:00, David Hildenbrand wrote:
>> On 31.10.24 09:13, Qi Zheng wrote:
>>> This commit introduces do_zap_pte_range() to actually zap the PTEs, which
>>> will help improve code readability and facilitate secondary checking of
>>> the processed PTEs in the future.
>>>
>>> No functional change.
>>>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> ---
>>>    mm/memory.c | 45 ++++++++++++++++++++++++++-------------------
>>>    1 file changed, 26 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index bd9ebe0f4471f..c1150e62dd073 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -1657,6 +1657,27 @@ static inline int zap_nonpresent_ptes(struct
>>> mmu_gather *tlb,
>>>        return nr;
>>>    }
>>> +static inline int do_zap_pte_range(struct mmu_gather *tlb,
>>> +                   struct vm_area_struct *vma, pte_t *pte,
>>> +                   unsigned long addr, unsigned long end,
>>> +                   struct zap_details *details, int *rss,
>>> +                   bool *force_flush, bool *force_break)
>>> +{
>>> +    pte_t ptent = ptep_get(pte);
>>> +    int max_nr = (end - addr) / PAGE_SIZE;
>>> +
>>> +    if (pte_none(ptent))
>>> +        return 1;
>>
>> Maybe we should just skip all applicable pte_none() here directly.
> 
> Do you mean we should keep pte_none() case in zap_pte_range()? Like
> below:
> 

No rather an addon patch that will simply skip over all
consecutive pte_none, like:

if (pte_none(ptent)) {
	int nr;

	for (nr = 1; nr < max_nr; nr++) {
		ptent = ptep_get(pte + nr);
		if (pte_none(ptent))
			continue;
	}

	max_nr -= nr;
	if (!max_nr)
		return nr;
	addr += nr * PAGE_SIZE;
	pte += nr;
}

Assuming that it's likely more common to have larger pte_none() holes 
that single ones, optimizing out the 
need_resched()+force_break+incremental pte/addr increments etc.

-- 
Cheers,

David / dhildenb


