Return-Path: <linux-kernel+bounces-242378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D037A92874E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5253E1F27517
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9018F14AD1B;
	Fri,  5 Jul 2024 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqIBinWg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B2A149C51
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176965; cv=none; b=crjv82SeDns8SZ4HpUqXQI3yYpZHaG9Ra1rEasGP5oZPhk3ZymroZHD1m6myM+DZPJdn2VKj0MIvHwPFuXPww23CWFFjM3opMiZ4oYwTg8RpWsZowMSN2F5Dm6zN6okCcO5ZIfHQ+lXHrmNHeeICIrQNmVf8AJIlNrAR94vabDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176965; c=relaxed/simple;
	bh=r+L/f9U0i8a8HMDG28yho/84ZRaPAyVHhGrGgTltqi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7VW6xTjAlxo27G3FN/BvrpWQK0pmFui05IWS4mZOL/zV4qoRi1N4RVNi70F9oTPihxQaZS1T4U2EdvkunOuvaFNVWwLhCHZ2ySOy00etqP2cPAj8DcoJfIzokVeqRq3sJVgz5f9ZUw4VLIbvbQa//WioqgAKdMW6ROD9HLa3BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZqIBinWg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720176962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CT4E93t0sj55/VAam9XLhdB5rq5TYIK0DID2v7M8x/I=;
	b=ZqIBinWg157xe08jvoPT0b7NQGicg7WKrFN968WM2XAwImGsfgvUVRrvh1jPQE6l69Uj+G
	t4vG9tbCeJZRHJLOxDwZ7h8+YEadW44GxGVINoPtJRk/KVj32kcYX2EcMpRSWLbf6/Yb+X
	37gNYOOo8bmdmRz2b0RGTubaHlM+TjU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-zFnNPzLzNlOtQweJGyYx1g-1; Fri, 05 Jul 2024 06:56:01 -0400
X-MC-Unique: zFnNPzLzNlOtQweJGyYx1g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42567dbbd20so11727535e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 03:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176960; x=1720781760;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CT4E93t0sj55/VAam9XLhdB5rq5TYIK0DID2v7M8x/I=;
        b=Fy8wrPI9Qc6JVYMz4/oenmX+h3DjivPV+qXd+Z1P3d0jSk0V1+WoEHoeglEqbvqGaW
         nWFNYr4UQ5J78TI20S7q97Jq819wta3p9TNi6cC9ch8FAq+Zxqo6K/DSVtFddVe9niSS
         +uOA2a+2+dsMSlpbM2ixTGks0FNPgRH7UprT0ly6z8pwmMfo4Cnl8MC3jWn4iqN3krHE
         8rpCbq6WtobifybcDCDgM0zYgcdQWD2a1jtkVGbz4qHOb5hZGciXwlxzq8mAz5/4NJOl
         jgTFygXofGj09wqs/UGLPuD3kSQtPrPi3wVCRtCUllxSgxEVuYXvSVuwVk9c4Tys3QGt
         qGyw==
X-Forwarded-Encrypted: i=1; AJvYcCXOY32RPMis4BxS+8X4UbQzSxsdYtcqwR+QGeVVaDio4xvEA9vS5uo5aEd71Zc2yDZZ1DkhJAiSNRp+JruYdNWezOZcGaIjjzGAmREU
X-Gm-Message-State: AOJu0YxByODvtPHtmCTM1k07EsILXqbdilPoR/TYBtZrI7UXWUgiiTRQ
	SBf9fScUmAnf8m79+RyPA67BF51yQxhEZFivUBPVDHpRKCbEamqNoczVZWSAUI1+1R1/new4CLn
	nVp/d6JKagUwuuOfZC8r8UV/BNRCWOgTbah0h1mx+XJ+L7suVQOZSgyIbnVv8E2Hg0U1m2g==
X-Received: by 2002:a05:600c:2e49:b0:426:5471:156a with SMTP id 5b1f17b1804b1-426547117a5mr7935365e9.13.1720176960161;
        Fri, 05 Jul 2024 03:56:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxzEtc1Oh6rQTMRaGAJXgmM9+q3YkvTihWJQFhwoHwrZYsOcnGz4IbjkLMq4ED/fWlfZBhhw==
X-Received: by 2002:a05:600c:2e49:b0:426:5471:156a with SMTP id 5b1f17b1804b1-426547117a5mr7935165e9.13.1720176959688;
        Fri, 05 Jul 2024 03:55:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:b500:3ed7:a1c7:447e:2279? (p200300cbc702b5003ed7a1c7447e2279.dip0.t-ipconnect.de. [2003:cb:c702:b500:3ed7:a1c7:447e:2279])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2ca4dbsm56525085e9.33.2024.07.05.03.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 03:55:59 -0700 (PDT)
Message-ID: <c9c98cbf-711c-4755-ae99-fb13aeb51381@redhat.com>
Date: Fri, 5 Jul 2024 12:55:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: add per-order mTHP split counters
To: Lance Yang <ioworker0@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 dj456119@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, libang.li@antgroup.com, baolin.wang@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Mingzhe Yang <mingzhe.yang@ly.com>
References: <20240704012905.42971-1-ioworker0@gmail.com>
 <20240704012905.42971-2-ioworker0@gmail.com>
 <677fc803-0bb9-48dc-a1ff-3ca1fb0dea15@redhat.com>
 <CAGsJ_4xX1cqKHU0eEsT=k0YDYKPs2m82bCkggdJyA1iwG4vXrg@mail.gmail.com>
 <3aef2bc6-c889-4a9a-b35d-f10ca8a5796a@redhat.com>
 <CAK1f24=M0i_Wisf9NHGcyo4wJ90a5QYefm=+rck5XAXMg1QNJQ@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
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
In-Reply-To: <CAK1f24=M0i_Wisf9NHGcyo4wJ90a5QYefm=+rck5XAXMg1QNJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.07.24 12:48, Lance Yang wrote:
> Hi David and Barry,
> 
> Thanks a lot for paying attention!
> 
> On Fri, Jul 5, 2024 at 6:14 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 05.07.24 12:12, Barry Song wrote:
>>> On Fri, Jul 5, 2024 at 9:08 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>>> @@ -3253,8 +3259,9 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>>>                 i_mmap_unlock_read(mapping);
>>>>>     out:
>>>>>         xas_destroy(&xas);
>>>>> -     if (is_thp)
>>>>> +     if (order >= HPAGE_PMD_ORDER)
>>>>
>>>> We likely should be using "== HPAGE_PMD_ORDER" here, to be safe for the
>>>> future.
>>>
>>> I feel this might need to be separate since all other places are using
>>> folio_test_pmd_mappable() ?
>>
>> Likely, but as you are moving away from this ... this counter here does
>> and will always only care about HPAGE_PMD_ORDER.
> 
> I appreciate the different opinions on whether we should use
> ">= HPAGE_PMD_ORDER" or "==" for this check.
> 
> In this context, let's leave it as is and stay consistent with
> folio_test_pmd_mappable() by using ">= HPAGE_PMD_ORDER",
> what do you think?

I don't think it's a good idea to add more wrong code that is even 
harder to grep (folio_test_pmd_mappable would give you candidates that 
might need attention). But I don't care too much. Maybe someone here can 
volunteer to clean up these instances to make sure we check PMD-size and 
not PMD-mappable for these counters that are for PMD-sized folios only, 
even in the future with larger folios?

-- 
Cheers,

David / dhildenb


