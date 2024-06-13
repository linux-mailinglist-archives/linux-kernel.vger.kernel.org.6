Return-Path: <linux-kernel+bounces-212877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 499C890679A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81DB2882A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367E3142918;
	Thu, 13 Jun 2024 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Et6t43EI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E391420C6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268550; cv=none; b=uqZ7ognciY1TdOw+kqvhpNk45bLoeDE505BQmAQcDIh6j8EBtYKx/t079T5hYlDcVwkc/NLXE/gwlbuN3esTPVdIPK/sry2wUT8Ip8ksTvjCRqhyG0MsBYaiaCSQrmx9c40E8lJemX93M4ld+51ral21s+4TJBnilGNQaTJRw88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268550; c=relaxed/simple;
	bh=HzKz4mOdi31xaOkjCx7z1KAm79ndQ9wlviA1d7c37pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0jutYSF1wQv7nHglCKwUPSxg3YZbGP8/YlBmeUDUpwQ7Qs10/mmJfVJN9W/plZ6L2vWjXHlVpb2R8frVfhQ5L6+iS3CXRjgxdKbwiVxI1vJob735sWio2dIVcAsG9CRCCnyNMpMfo/jr6miTaF5uruj/o3hyB1rcPw5fWE5fgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Et6t43EI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718268548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RS6J5KVthkxaXdiN8zOh9Jm9h30XS9QZ8/1gEQNIBB8=;
	b=Et6t43EIArvzpFXt9UYYBFmLGzVDQriES1r8thDfumqmrxJYAJ2jrifAwggGzwG+4B9uVI
	O8hSz5RVeUtegUVKcu0qq2ZudNUpOjgkHWhfhaLTUmpjNYVgVKIa+jUfuclC/l3uEKSzkP
	cToMxy4ClR3kH6eBJxNkGpspAqfZEA8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-ntRDT1tuMhm8cdW8G2Ch_g-1; Thu, 13 Jun 2024 04:49:04 -0400
X-MC-Unique: ntRDT1tuMhm8cdW8G2Ch_g-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ebeef33f21so5455421fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718268543; x=1718873343;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RS6J5KVthkxaXdiN8zOh9Jm9h30XS9QZ8/1gEQNIBB8=;
        b=gf0UyOhle5Cx+ubjKGMGrReersUtNaI0nOKPGoJ4koPFHeueteuLzLlkkFt8SvLDrh
         3Lqr4w8IbDoGIc27je9gXaalt8iGKCUeS6iz8xObIA++8qTqH5oN2TdWMTOXQo5iNXR6
         djt6lLixZvYCSwKIvqiv1Yh/4XexTsvifUzeFTlijztv4fBq7t5de6XVoiRLbZY3Jvou
         SrcTfjY4MRrS4loE1gOgtC3T4oj38TVrxmtEloILIgISXe5hs/amSEHFUu/HITVJC2N7
         4RDabMxrr0k0fr56dA0Cc2DirW3K8lu2KuoiOQPVa88HRuBjl1luKzlTRkPt3iVv6T2G
         VeDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBNPjLPBaufKPzv+beYdLPB05l5yBLHRWMlG8THtylibeN10OiVrir+YxW7rS6xxgHLMortht47xrNaCjz+WSWWbPvpzNgjf4nSQ03
X-Gm-Message-State: AOJu0YwusccoZvoIk8NMIcz1zTGmuasA24rBJjJezzgmRuoFoI1/UI6o
	DoXzXVUxcJwd6hcTll0pR02mhupHKL2sLQ1O5izYQcckHDAgGdqSgRMyjtjnGGvyMFCVHgqDrW/
	/jBlcT5IOSuf08j+OGVzOxong3NshEAdsHrkAhqELLbQ1hhSiirtrU0S/JhkDMA3BN/awQw==
X-Received: by 2002:a2e:b5ac:0:b0:2eb:e266:f9ba with SMTP id 38308e7fff4ca-2ebfc9bf1d0mr30399621fa.23.1718268543140;
        Thu, 13 Jun 2024 01:49:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQrOECpZJiDC6UibcycHJLnTZes27jrpaCziueHA/tENV8SzOy4iwATn/1UI/gv+kqf1DsMg==
X-Received: by 2002:a2e:b5ac:0:b0:2eb:e266:f9ba with SMTP id 38308e7fff4ca-2ebfc9bf1d0mr30399431fa.23.1718268542648;
        Thu, 13 Jun 2024 01:49:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:fe00:10fe:298:6bf1:d163? (p200300cbc703fe0010fe02986bf1d163.dip0.t-ipconnect.de. [2003:cb:c703:fe00:10fe:298:6bf1:d163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-423034f4129sm7677795e9.14.2024.06.13.01.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 01:49:02 -0700 (PDT)
Message-ID: <b0b4a134-1d40-4eef-94f3-5c4593b55e78@redhat.com>
Date: Thu, 13 Jun 2024 10:49:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] mm: remove folio_test_anon(folio)==false path in
 __folio_add_anon_rmap()
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: chrisl@kernel.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
 ryan.roberts@arm.com, baolin.wang@linux.alibaba.com, yosryahmed@google.com,
 shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com,
 willy@infradead.org, ying.huang@intel.com, yuzhao@google.com
References: <20240613000721.23093-1-21cnbao@gmail.com>
 <20240613000721.23093-4-21cnbao@gmail.com>
 <CAGsJ_4zx3Rp9ye=LFhzEN+JypAq1zb_gLQZgyiRvYJZTMpLCHA@mail.gmail.com>
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
In-Reply-To: <CAGsJ_4zx3Rp9ye=LFhzEN+JypAq1zb_gLQZgyiRvYJZTMpLCHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.06.24 10:46, Barry Song wrote:
> On Thu, Jun 13, 2024 at 12:08 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> From: Barry Song <v-songbaohua@oppo.com>
>>
>> The folio_test_anon(folio)==false case within do_swap_page() has been
>> relocated to folio_add_new_anon_rmap(). Additionally, two other callers
>> consistently pass anonymous folios.
>>
>> stack 1:
>> remove_migration_pmd
>>     -> folio_add_anon_rmap_pmd
>>       -> __folio_add_anon_rmap
>>
>> stack 2:
>> __split_huge_pmd_locked
>>     -> folio_add_anon_rmap_ptes
>>        -> __folio_add_anon_rmap
>>
>> __folio_add_anon_rmap() only needs to handle the cases
>> folio_test_anon(folio)==true now.
> 
> My team reported a case where swapoff() is calling
> folio_add_anon_rmap_pte *not* folio_add_anon_rmap_ptes
> with one new anon  (!folio_test_anon(folio)).
> 
> I will double check all folio_add_anon_rmap_pte() cases.

Right, swapoff() path is a bit special (e.g., we don't do any kind of 
batching on the swapoff() path).

But we should never get a new large anon folio there, or could that now 
happen?

-- 
Cheers,

David / dhildenb


