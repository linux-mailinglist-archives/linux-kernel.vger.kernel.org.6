Return-Path: <linux-kernel+bounces-212940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D9B906878
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A888B23D63
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A361313DDD5;
	Thu, 13 Jun 2024 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OapvRCiq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE9513D891
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270614; cv=none; b=YXxa0/B4yxHWy8p9dbWSHGqO9aPOXlpizEEymKxG2PglZgZlxA4CStkWzqFYu4ryT+Gc1aro+DuWJmpqjKtqOA/9XXleEPWyg22BYgvdMeR9/XQqsTEUrfmMGZtyWaCJ0YehPswAFNQcbtK1PBqCO8vrn8xW+XT1oAUvdwoOR/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270614; c=relaxed/simple;
	bh=q8G+enZoHHNeZN/EI8OcRI7tWsDyh/8wN3VsSCGE2Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HMhmcofAsZPECTyTB6I1WaXsyUX3i5GPm4J8qPMFT75VIdKBUDbWMiN5iTfhFNTWeHfmw4HuZ44WVUwMR08Njo5elGGlSIjBiLSx+22vLUMLk7DCKjSk+i9HxLK9K+QUyeXK2BjRbA8hENybYOTGb/MAPsn2GCd+DUBJlTkpyDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OapvRCiq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718270611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HSy5Z8v5K7p6G02a7thfs6FBjOqotVJMsCZDaBh6xio=;
	b=OapvRCiqmLW9h0guOieJady4kIlkdYkWKrO57h/3l/lptFqGvlqR+Q1oBLXrk+3YjOgEsz
	OENxAKfXifzozQuzergkaid8I61Mjx8DA7mzs9EIz3u9THCPYUlodLWAPZH2vGzGmy+D0y
	W+1VGU/LZVOuaIPuRzJEQvFs2KMNcf8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-Xqfjs_D2M4yuB-BRDZf-8g-1; Thu, 13 Jun 2024 05:23:30 -0400
X-MC-Unique: Xqfjs_D2M4yuB-BRDZf-8g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35dc0949675so572026f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 02:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718270609; x=1718875409;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HSy5Z8v5K7p6G02a7thfs6FBjOqotVJMsCZDaBh6xio=;
        b=Z0Zt3FSY0t08EEWc35fpmGzXsgyGT0EXL/0GjgMfnqlZevjSvXd5PnPUTIJ8cyxgE8
         cLiyIneZJ89wHbBX2HkFIpCqNjrp0Zw9i0fsLtSuEuescu8iIH6lXmRM9ttk2Nz6cjgr
         u5R23szhX79zfyvazfE9kmjWMh5dc83+GnUk+vXwtku01qZr5xl9d4Ofkr4nnbaMN3RH
         eVt9SGX9iKmVBKc7rV5k4hzSGq03vg+zEejqu7bMKeqep8YL83jueRYgbwTRx+sNNII4
         rNoag1XDoKa9TVTh3xiTnTyaUM3g9wsujGoJmG6U/S5rIfqm7xH79e0HfRzM25P13cEG
         aiNA==
X-Forwarded-Encrypted: i=1; AJvYcCXKeFSFqxdp3De3YBJoDkhZ1ShEix15U65O4IYYvAIZjfBfFUsP3cjcCwm5OIclQ2QsZuC0i3Q0srsidpSgxQ52QoqDZD9FU5Bar+DG
X-Gm-Message-State: AOJu0YyUaoLq8Nmte2TOHQ8WHcOLHhr/LZBs0B8XuDhGeA+isWnf2RMZ
	4+9DWuPg7UzFwX2rvzhHJ+Y2yy/8Dc6Tp25p0cNt867n+T8PmN0m8kr8tD22vHyB26YCFPi19YF
	AQf5SfftC/mv5CNuLO3cy6+DpBGPp29gQPvtGXrOgJUHqrs6U0/pc0iii/L3bcA==
X-Received: by 2002:adf:e802:0:b0:360:70d2:ee0e with SMTP id ffacd0b85a97d-36070d2f405mr2317421f8f.46.1718270609272;
        Thu, 13 Jun 2024 02:23:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKqTAibPZCaF/o9kH3h0S80k6S/Jl1ZYOlz43i4qyFxe9LS6B/Sg2+ltavw0NA0GyX2gth1g==
X-Received: by 2002:adf:e802:0:b0:360:70d2:ee0e with SMTP id ffacd0b85a97d-36070d2f405mr2317406f8f.46.1718270608837;
        Thu, 13 Jun 2024 02:23:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:fe00:10fe:298:6bf1:d163? (p200300cbc703fe0010fe02986bf1d163.dip0.t-ipconnect.de. [2003:cb:c703:fe00:10fe:298:6bf1:d163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f228asm1115165f8f.73.2024.06.13.02.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 02:23:28 -0700 (PDT)
Message-ID: <77da1feb-2257-4545-9427-5729250ceb2b@redhat.com>
Date: Thu, 13 Jun 2024 11:23:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/3] mm: do_swap_page: use folio_add_new_anon_rmap()
 if folio_test_anon(folio)==false
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: chrisl@kernel.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
 ryan.roberts@arm.com, baolin.wang@linux.alibaba.com, yosryahmed@google.com,
 shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com,
 willy@infradead.org, ying.huang@intel.com, yuzhao@google.com
References: <20240613000721.23093-1-21cnbao@gmail.com>
 <20240613000721.23093-3-21cnbao@gmail.com>
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
In-Reply-To: <20240613000721.23093-3-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.06.24 02:07, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> For the !folio_test_anon(folio) case, we can now invoke folio_add_new_anon_rmap()
> with the rmap flags set to either EXCLUSIVE or non-EXCLUSIVE. This action will
> suppress the VM_WARN_ON_FOLIO check within __folio_add_anon_rmap() while initiating
> the process of bringing up mTHP swapin.
> 
>   static __always_inline void __folio_add_anon_rmap(struct folio *folio,
>                   struct page *page, int nr_pages, struct vm_area_struct *vma,
>                   unsigned long address, rmap_t flags, enum rmap_level level)
>   {
>           ...
>           if (unlikely(!folio_test_anon(folio))) {
>                   VM_WARN_ON_FOLIO(folio_test_large(folio) &&
>                                    level != RMAP_LEVEL_PMD, folio);
>           }
>           ...
>   }
> 
> It also enhances the code’s readability.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>   mm/memory.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 2f94921091fb..9c962f62f928 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4339,6 +4339,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   	if (unlikely(folio != swapcache && swapcache)) {
>   		folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
>   		folio_add_lru_vma(folio, vma);
> +	} else if (!folio_test_anon(folio)) {
> +		folio_add_new_anon_rmap(folio, vma, address, rmap_flags);

So, with large folio swapin, we would never end up here if any swp PTE 
is !exclusive, because we would make sure to allocate a large folio only 
for suitable regions, correct?

It can certainly happen during swapout + refault with large folios. But 
there, we will always have folio_test_anon() still set and wouldn't run 
into this code path.

(it will all be better with per-folio PAE bit, but that will take some 
more time until I actually get to implement it properly, handling all 
the nasty corner cases)

Better add a comment regarding why we are sure that the complete thing 
is exclusive (e.g., currently only small folios).

>   	} else {
>   		folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, address,
>   					rmap_flags);

-- 
Cheers,

David / dhildenb


