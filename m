Return-Path: <linux-kernel+bounces-434803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975E79E6B84
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591E6282EAE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871AC200B8A;
	Fri,  6 Dec 2024 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2V3FHwV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AE620013E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480004; cv=none; b=KfNILfCC/57bUzIPKe+O0X8umCmkM91vELlY60+3snx1PQo/ZO6ijiDvutqh9n5ij9Sa7U5QBg5zIY9Nf21a2Mo/Spu9a0EyiFjXbV6lwu31tx3FLtkXLsHQJ/N2Lg5LrXvNXxWA+BUk7rCyOGWiCPP/jnlFGh3nmdbAzrLHMNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480004; c=relaxed/simple;
	bh=somms22eqcnK6raUYg1L3Ujqx3OTx5AIIMXNQDS1YDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cz3UaJ06q5IaXFjUdy8+F196jgeNObDjbsYVQea04SxcRmX88LSs+gWLeVWNxW+MtbA5Y1+eJNF4HfJm/2XEo21xRybwo9YUUzw0kpGg7/qzXeAxq3bGRMZS/cxvltJ0aC/EGr9gZ9ZxRTk2i08ckVRY6FIBwWkqmkPH+ek5i4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T2V3FHwV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733480001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sE0+Jv8p1+RSxZLSoZ0bdw7B9NQgiiacOi3XQtYmxiw=;
	b=T2V3FHwVdkTzaNZ9ViWh3l/WnxE1CvDOVCg19A1oLKP2iCM6NwRvvhakPHq639JZwtI0ZB
	X8gvpxZpxIC4xoriVdlxIuGmk4vGNfLpleYgH1FUSJPg9lNZUPWCU3LiguD2fVq0dhnPZ4
	nOAcdKGGAPmBsXXZ+vhwDNrOWlXwDjQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-g1_EVkh9ONmBya-sazCRpw-1; Fri, 06 Dec 2024 05:13:20 -0500
X-MC-Unique: g1_EVkh9ONmBya-sazCRpw-1
X-Mimecast-MFC-AGG-ID: g1_EVkh9ONmBya-sazCRpw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434a876d15cso15047585e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 02:13:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733479999; x=1734084799;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sE0+Jv8p1+RSxZLSoZ0bdw7B9NQgiiacOi3XQtYmxiw=;
        b=R4Ek9CL2+s/vI1juvCoXsFlOglqBDi5tqeA1dzywwxcDSAS4yebjCKmhXuc+cv94oq
         dSKS+HZkbE550LYMdyouFcDf1u39NkjbhAImpT8mms1TaXdzyX+WCW9v7OG2RkESTQAg
         MOJxDiz8mudVkM9rGXmLZyMWV+aNJBp5TSYl8q4+nXzuX0OnD+cr6ywg1R2LH+hKPlaH
         /J4E0GDRshDIDoOsuaFxNGZSs58N9VeiyKIX0ia3oQ4jPfKYocts1Dc8o6kKnFTn9+yx
         vHR/o8m04xd0LpsDnDjnwwBEmDD+LqdYJeMWAyHOn02GJIhRw0+24M2QLM6INuISHJQo
         ctJA==
X-Forwarded-Encrypted: i=1; AJvYcCV1ySRo1EFC81nYdAmTJbl1iO0JuVG0NrT6YvZJZeqOb9BTM9iBm3+VKGxtAreE3afGLaH4WpHq60jtDHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ1JDIiAuTaMn7xV4+bseic1jBS2otOpdjQKJ3iwFstG5I7sky
	8dzgkbcroY8j7M2ko08ViN7WwAzoWi6h2rhRhx8iuK6XLRbZuWYdFVfqtAx4fxLrfcfNE8vOEOh
	aUFUGs32JkZ1sQw32hgt8h+Bd965QBsOIhf+xbx1gk6GFDhGuP2Q0NHwwIJjCGA==
X-Gm-Gg: ASbGncutQp7gXSzS4xDevEcjtuXknPIYgnqHCz/YBqeXntePunUSrogFwWufE3OEkaa
	M88y5frrOWdvr0GDD254JhLoK81aTgPm1Ku3C9ZGbpjDbsR5szD5CkR81N7+2ZiMIi9jadL3CqD
	dLtvINoGxMupmwDrqX7vdtRJbpoKoqnm3AB+9xOXx2QgzPUvbPx5z6ft6cLYdzcPkC9SYHykj5F
	IdkOslGZtW2xZC52wp0OGGzv1q9qfcDrk/J8etAhjX5Jl8DtwNTpr1Gy1swmPETJSYVlGqT3GR6
	gWDD0zn3EzYtWx15zPUCK8Ncs5y8Hz192uLfj1t1f2+1EwBqYx5Ly3K3Xg0S9vZdJhlKleoBzGU
	6+w==
X-Received: by 2002:a05:600c:1f95:b0:434:92f8:54a8 with SMTP id 5b1f17b1804b1-434d91fde3fmr47410305e9.0.1733479999506;
        Fri, 06 Dec 2024 02:13:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNAgJk6SspH05tND9d7SeEiASYCdP05xI5bAcUm7iX+ghPB0Puwlk/OQoFkiQYYQToswv2GA==
X-Received: by 2002:a05:600c:1f95:b0:434:92f8:54a8 with SMTP id 5b1f17b1804b1-434d91fde3fmr47410045e9.0.1733479999159;
        Fri, 06 Dec 2024 02:13:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c71b:d000:1d1f:238e:aeaf:dbf7? (p200300cbc71bd0001d1f238eaeafdbf7.dip0.t-ipconnect.de. [2003:cb:c71b:d000:1d1f:238e:aeaf:dbf7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d43a100csm80243435e9.1.2024.12.06.02.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 02:13:17 -0800 (PST)
Message-ID: <315752c5-6129-4c8b-bf8c-0cc26f0ad5c5@redhat.com>
Date: Fri, 6 Dec 2024 11:13:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/21] riscv: Introduce 64K base page
To: Zi Yan <ziy@nvidia.com>, Xu Lu <luxu.kernel@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 ardb@kernel.org, anup@brainfault.org, atishp@atishpatra.org,
 xieyongji@bytedance.com, lihangjing@bytedance.com,
 punit.agrawal@bytedance.com, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Linux MM <linux-mm@kvack.org>
References: <20241205103729.14798-1-luxu.kernel@bytedance.com>
 <F94D21C0-8189-404A-B796-BB3C6620AB89@nvidia.com>
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
In-Reply-To: <F94D21C0-8189-404A-B796-BB3C6620AB89@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.12.24 03:00, Zi Yan wrote:
> On 5 Dec 2024, at 5:37, Xu Lu wrote:
> 
>> This patch series attempts to break through the limitation of MMU and
>> supports larger base page on RISC-V, which only supports 4K page size
>> now. The key idea is to always manage and allocate memory at a
>> granularity of 64K and use SVNAPOT to accelerate address translation.
>> This is the second version and the detailed introduction can be found
>> in [1].
>>
>> Changes from v1:
>> - Rebase on v6.12.
>>
>> - Adjust the page table entry shift to reduce page table memory usage.
>>      For example, in SV39, the traditional va behaves as:
>>
>>      ----------------------------------------------
>>      | pgd index | pmd index | pte index | offset |
>>      ----------------------------------------------
>>      | 38     30 | 29     21 | 20     12 | 11   0 |
>>      ----------------------------------------------
>>
>>      When we choose 64K as basic software page, va now behaves as:
>>
>>      ----------------------------------------------
>>      | pgd index | pmd index | pte index | offset |
>>      ----------------------------------------------
>>      | 38     34 | 33     25 | 24     16 | 15   0 |
>>      ----------------------------------------------
>>
>> - Fix some bugs in v1.
>>
>> Thanks in advance for comments.
>>
>> [1] https://lwn.net/Articles/952722/
> 
> This looks very interesting. Can you cc me and linux-mm@kvack.org
> in the future? Thanks.
> 
> Have you thought about doing it for ARM64 4KB as well? ARM64’s contig PTE
> should have similar effect of RISC-V’s SVNAPOT, right?

What is the real benefit over 4k + large folios/mTHP?

64K comes with the problem of internal fragmentation: for example, a 
page table that only occupies 4k of memory suddenly consumes 64K; quite 
a downside.

-- 
Cheers,

David / dhildenb


