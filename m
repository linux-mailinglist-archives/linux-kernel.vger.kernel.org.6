Return-Path: <linux-kernel+bounces-410851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2DC9CE6A6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701CD1F2371C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300881CEADC;
	Fri, 15 Nov 2024 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gX1e5BF2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09411D4350
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682808; cv=none; b=UcmRU24Ss3t81aW6Ov0oQ09l/umZxvwLMcOth0kkPrzrZFzYzhbbsyhpuzk7fvbIzDUel8AqVn/1V2ft/saVHIJ6YKOwXBdG1MmCH9GOt8CY4ySYxqN/nruwJK6nJSC8uFvhgYKEFB/h+nbOID+Xl6qjT57r9FG7XKJ8sz+WQTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682808; c=relaxed/simple;
	bh=NKmwV/fHYzwQw3xV3vdCs5M375MSqqJEd8kHDF6fhSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKOO1j6bu0IWn0cNM4WD6DYeE+z5ZrE4Ip/END0UqImbmgyV1GBtjPOZb9vY9HtuwDMhTymspd8iSLzi/7zHHCTkZE9T69wZBwCBYrTonQnzNqBKS8/nOfphJ/fPQBfFBTvDxQj9XsRNnw2mzQS/srvb1+whj/2Wm9Oe2jjADiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gX1e5BF2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731682805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jBwsWUUk9oTsZzQosZBS1zd6wAmy+ijjfoz2gaRw/jI=;
	b=gX1e5BF2U/qQUgf1ROY32urzXUNs1XSoeKaC8WWkLMSVThINfWui6pjw5IcOXH8UOltHzN
	GUYriPREOADoYG9JrFqB0gwzNR76c3wRYr48Vcnm/wV5KNkUbCUSKwOrIUOXliUm6VvncJ
	Bg/JfxtnXFN40kNhNjT6l/X5wQiMO08=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-asC0_9QHPAaIwOXUDlt6lg-1; Fri, 15 Nov 2024 10:00:04 -0500
X-MC-Unique: asC0_9QHPAaIwOXUDlt6lg-1
X-Mimecast-MFC-AGG-ID: asC0_9QHPAaIwOXUDlt6lg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315eaa3189so17351835e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:00:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731682803; x=1732287603;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jBwsWUUk9oTsZzQosZBS1zd6wAmy+ijjfoz2gaRw/jI=;
        b=b0QCa+tZ6cQMdCyRdcWbjiQEYv9nGwXmp3jFhRSuTMXKSk6lYcQn+7JqUeDkeQUBBd
         k3JrIrCig0kDjCMpdGYMX9Q99VLXWoEupWleRTR8EbZSFSWST+9VMKOM1tg/8cK4HZs6
         160/N6MzoyJ+2HsybJqqGHhn/GTX/LbmsKpjmUSa0wq+C0ic3O140XVl8MA7y31HwVaD
         Z9Ag3qZ+lIboHedgRA25oFe8tYoKyxcfACdhLdfCDfucaW7aZqqBa5GxsEEoi/I0LK4t
         ZX3W/GRmTaEhNSv8n0GdXu+bo5TK9wk6CxPcJytLJAPlBF2w254wHljwweyVRVHDJgFi
         WAwA==
X-Forwarded-Encrypted: i=1; AJvYcCXfwAMq4gOdnMEFGnTRGdwEHJXyxbP6vpfvNZWru/xY76Yzqxdd8oDmK3IkSelrH4noFcvupbFNL/Oc+Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YydyXaBOnjYVnylZGh2HJ3e6nf0FfDbgI6KepHasXogtF7LE14K
	pIZQ59G0L4FjweNHLB9WJQ1ltZixY/DxZGpH/8Ki1j6xVmF3hp4C04BMARFP0/5ohQKAkY1UzdF
	ybQAyXlK+TikXmsblTS9bxXXF5RI9CnebAjjVCPVITQ9GgY13ikGZVf2ix66iqg==
X-Received: by 2002:a05:600c:4e0f:b0:42a:a6b8:f09f with SMTP id 5b1f17b1804b1-432df78f3aamr24528245e9.23.1731682803376;
        Fri, 15 Nov 2024 07:00:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG01nOXyY9OKjk50wxG3DR8xP28DGDltQ0GFaeDZFilezFWLwkuN4I2SbMM4ajT3FsCtiLTxw==
X-Received: by 2002:a05:600c:4e0f:b0:42a:a6b8:f09f with SMTP id 5b1f17b1804b1-432df78f3aamr24527945e9.23.1731682803005;
        Fri, 15 Nov 2024 07:00:03 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:8100:177e:1983:5478:64ec? (p200300cbc7218100177e1983547864ec.dip0.t-ipconnect.de. [2003:cb:c721:8100:177e:1983:5478:64ec])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab721d7sm57786805e9.9.2024.11.15.07.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 07:00:01 -0800 (PST)
Message-ID: <4edccc1a-2761-4a5a-89a6-7869c1b6b08a@redhat.com>
Date: Fri, 15 Nov 2024 15:59:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] mm: introduce skip_none_ptes()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: jannh@google.com, hughd@google.com, willy@infradead.org,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 peterx@redhat.com, mgorman@suse.de, catalin.marinas@arm.com,
 will@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, x86@kernel.org, lorenzo.stoakes@oracle.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, zokeefe@google.com,
 rientjes@google.com
References: <cover.1731566457.git.zhengqi.arch@bytedance.com>
 <574bc9b646c87d878a5048edb63698a1f8483e10.1731566457.git.zhengqi.arch@bytedance.com>
 <c7eeac93-3619-4443-896f-ef2e02f0bef0@redhat.com>
 <617a063e-bd84-4da5-acf4-6ff516512055@bytedance.com>
 <fa3fc933-cd51-4be5-944e-250da9289eda@redhat.com>
 <b524a568-fa3b-4618-80cc-e8c31ea4eeac@bytedance.com>
 <d27a75fa-b968-43d3-bbd3-cc607feee495@redhat.com>
 <253e5fd0-7e98-43fd-b0d7-8a5b739ae4aa@bytedance.com>
 <77b1eddf-7c1b-43e9-9352-229998ce3fc7@redhat.com>
 <5a3428bd-743a-4d51-8b75-163ab560bca7@bytedance.com>
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
In-Reply-To: <5a3428bd-743a-4d51-8b75-163ab560bca7@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.11.24 15:41, Qi Zheng wrote:
> 
> 
> On 2024/11/15 18:22, David Hildenbrand wrote:
>>>>> *nr_skip = nr;
>>>>>
>>>>> and then:
>>>>>
>>>>> zap_pte_range
>>>>> --> nr = do_zap_pte_range(tlb, vma, pte, addr, end, details, &skip_nr,
>>>>>                            rss, &force_flush, &force_break);
>>>>>         if (can_reclaim_pt) {
>>>>>             none_nr += count_pte_none(pte, nr);
>>>>>             none_nr += nr_skip;
>>>>>         }
>>>>>
>>>>> Right?
>>>>
>>>> Yes. I did not look closely at the patch that adds the counting of
>>>
>>> Got it.
>>>
>>>> pte_none though (to digest why it is required :) ).
>>>
>>> Because 'none_nr == PTRS_PER_PTE' is used in patch #7 to detect
>>> empty PTE page.
>>
>> Okay, so the problem is that "nr" would be "all processed entries" but
>> there are cases where we "process an entry but not zap it".
>>
>> What you really only want to know is "was any entry not zapped", which
>> could be a simple input boolean variable passed into do_zap_pte_range?
>>
>> Because as soon as any entry was processed but  no zapped, you can
>> immediately give up on reclaiming that table.
> 
> Yes, we can set can_reclaim_pt to false when a !pte_none() entry is
> found in count_pte_none().

I'm not sure if well need cont_pte_none(), but I'll have to take a look 
at your new patch to see how this fits together with doing the pte_none 
detection+skipping in do_zap_pte_range().

I was wondering if you cannot simply avoid the additional scanning and 
simply set "can_reclaim_pt" if you skip a zap.

-- 
Cheers,

David / dhildenb


