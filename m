Return-Path: <linux-kernel+bounces-279810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA43994C21C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501C31F291DF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3A818FC8C;
	Thu,  8 Aug 2024 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSEI7v4g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646C18CC0C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132612; cv=none; b=fB6WPKKzA7RVLvuEfTNk1lppyQwqgvF9T4aE09soOP1qzjFxFavlADPxm257HaZQ7yPFrFwrsclPgW5LeB1l93cjBddelx37Ltc7iNG6qsquWsq4ehWbPnrOrdyuV49A8h+iK2fgCUQR8MKB+Jxq57tQNz5h+GkCzbGmHL7gL4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132612; c=relaxed/simple;
	bh=9cKxumR6Rf6va4hZ9V61jAgFg9GEKzaFi4dfCc0wSEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TMrVBnAN3jlJ1fQU8ElFhyhopP/HjB1+y8xUDg0CNS/w2BmjZZIa0Vd9pPkyBIyZ2SffOBp/FIHmGjG7X0twZGaBP0QyYw7UdMYirk8Rwd0+jrtY82yIVu1aLBDtQauPL21XsQxDy/Hc56QiG/J7vEsMFWSwY1oAFcVyqkVLWvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XSEI7v4g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723132609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cpJg3TiQogO4JMicG9RkOgqxghuXdcS1unInOCVJZLk=;
	b=XSEI7v4g6JMIJPI+FcDWkb0IKTFJtWt3HyRz6JQfNxYzMeP9s6FO8lYl7as2PNMjY/8H5a
	f4nMu9+/82PS+dM+ovo4hBXssdMmgJDVdU/2LSN/JMBZT1cJRdQ9LvtAuoGzdY9bRvXd39
	KzPwxEmuLqZuP5uywxyKQ1aBX86+qHg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-OKndHDjpPLGc0lr63XK3TA-1; Thu, 08 Aug 2024 11:56:48 -0400
X-MC-Unique: OKndHDjpPLGc0lr63XK3TA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3684ea1537fso477479f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 08:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723132607; x=1723737407;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cpJg3TiQogO4JMicG9RkOgqxghuXdcS1unInOCVJZLk=;
        b=gDjPBb0NtT5Z/nNRbcIV7Vyx/W5Mu9u8bwon/gwsDM6vhGlezBmK1CAYZexh1WI1z+
         hGtfupKzkPGyFEZwUjl+ezsGo2LwU4HvzWt2B67DBI7k41zfdr0jYE3csyKT1BtL+l7r
         jO4XgJkuLPy9aruR08oFiNbvv8AO4OslFaiCMdql4xQNw+mgOPTqfoII6yrIBBnsfCIn
         nqfRB3h8+lfOtCCdp3Z1cDp5yMhSe9aUUj8zfQNcrC5UTUbzqumz3sZZ8i/eANeZ+k6o
         GW7wijN8Q9soKObLw5HpXdVNW4lwLnTTsERlgiQCGTqwXDihXynOnxIkmPDd2N9AKU3O
         DF0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbEKSkMh1sZEeDlLNdq5IAbpiLmOt+bvvYpmGg9ATvuB2w55hcfoeGo4mhkyq6omM7xp0pTNkOmA1hcKL8oitVcXbNpzLLEG6fShsa
X-Gm-Message-State: AOJu0Yxh9UTKAQQlnftfJW1VcoIQzEcmPM7HrTY+918pW9jyV1SPCCJZ
	KzTkVU2+qTlpa71r82gJjl6fjSqFZDUiCTNPMMh6xXxFHNA9LRjzo/soMW8TAu6hXVvEYT6hqwX
	I7cwnj8tmJ+BFk5Hd/p8DWItztRQwhANQXiQ2oD5BwZ0QlZdK8gWEbpFaVvzeIA==
X-Received: by 2002:adf:f54d:0:b0:367:8a2f:a6dc with SMTP id ffacd0b85a97d-36d27561449mr1351079f8f.44.1723132607424;
        Thu, 08 Aug 2024 08:56:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPqOOhcvnb7wuogS4wLNrpdjrEF6UHggHsvK/PxXwmbNGMMtWaKSi1FORuwqamSr7jyCKARg==
X-Received: by 2002:adf:f54d:0:b0:367:8a2f:a6dc with SMTP id ffacd0b85a97d-36d27561449mr1351050f8f.44.1723132606797;
        Thu, 08 Aug 2024 08:56:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:2a00:f151:50f1:7164:32e6? (p200300cbc7132a00f15150f1716432e6.dip0.t-ipconnect.de. [2003:cb:c713:2a00:f151:50f1:7164:32e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2716cab8sm2323080f8f.33.2024.08.08.08.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 08:56:46 -0700 (PDT)
Message-ID: <7eca670c-1196-4e50-be26-3fa52fa93ad2@redhat.com>
Date: Thu, 8 Aug 2024 17:56:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm: free zapped tail pages when splitting isolated
 thp
To: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com,
 Shuang Zhai <zhais@google.com>
References: <20240807134732.3292797-1-usamaarif642@gmail.com>
 <20240807134732.3292797-2-usamaarif642@gmail.com>
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
In-Reply-To: <20240807134732.3292797-2-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.24 15:46, Usama Arif wrote:
> From: Yu Zhao <yuzhao@google.com>
> 
> If a tail page has only two references left, one inherited from the
> isolation of its head and the other from lru_add_page_tail() which we
> are about to drop, it means this tail page was concurrently zapped.
> Then we can safely free it and save page reclaim or migration the
> trouble of trying it.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Tested-by: Shuang Zhai <zhais@google.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>   mm/huge_memory.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0167dc27e365..35c1089d8d61 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2923,7 +2923,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>   	unsigned int new_nr = 1 << new_order;
>   	int order = folio_order(folio);
>   	unsigned int nr = 1 << order;
> +	struct folio_batch free_folios;
>   
> +	folio_batch_init(&free_folios);
>   	/* complete memcg works before add pages to LRU */
>   	split_page_memcg(head, order, new_order);
>   
> @@ -3007,6 +3009,26 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>   		if (subpage == page)
>   			continue;
>   		folio_unlock(new_folio);
> +		/*
> +		 * If a folio has only two references left, one inherited
> +		 * from the isolation of its head and the other from
> +		 * lru_add_page_tail() which we are about to drop, it means this
> +		 * folio was concurrently zapped. Then we can safely free it
> +		 * and save page reclaim or migration the trouble of trying it.
> +		 */
> +		if (list && page_ref_freeze(subpage, 2)) {
> +			VM_WARN_ON_ONCE_FOLIO(folio_test_lru(new_folio), new_folio);
> +			VM_WARN_ON_ONCE_FOLIO(folio_test_large(new_folio), new_folio);
> +			VM_WARN_ON_ONCE_FOLIO(folio_mapped(new_folio), new_folio);
> +
> +			folio_clear_active(new_folio);
> +			folio_clear_unevictable(new_folio);
> +			if (folio_batch_add(&free_folios, folio) == 0) {

nit:  "!folio_batch_add(&free_folios, folio)"

Nothing else jumped at me.

-- 
Cheers,

David / dhildenb


