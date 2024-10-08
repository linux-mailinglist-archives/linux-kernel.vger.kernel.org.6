Return-Path: <linux-kernel+bounces-354798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DBD9942BB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9B91F22722
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E55F1E0494;
	Tue,  8 Oct 2024 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fwilkxa4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDE11DFE31
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376009; cv=none; b=q3+6DZJZm2jt9j7fnKcUZNxAxagn/k8JLmZXAI1ByNWHUrh1BTavXz62pKHfm1dgX77JBzbJ5hpTR1SThw1X73vPuukljpoMUHpJZY0u7yYAlVaHM3OfH4C8OG5uh39Qct+9rYM+9V8vI2vibXmV4/Oe3SwrWKK9x7RGUyI+WUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376009; c=relaxed/simple;
	bh=HHfYjD1YpA3Eq5+lIEuFEsasvtIG9UN3FlMl5jj6qeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jcgxf7Jkmk3GpSlc0tHKsqA8P+zFp7AkZvQGiU7hlgLuNIORJEJ9ZkzFvxOgfGeEUMdOM8uoK363Q3204GjHqfQF+kuL1prlUjm+6gKf0sJiL2V+UtCM1Q/vyvedxSYqBzDDvLB0MBuEjNlRNhJvT56xCYbgo6m73fmeTgecDQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fwilkxa4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728376006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cOjJUPPhXg7FHSURpsWRXRS9eGsX5EzRwbqt9a/KOqs=;
	b=Fwilkxa4NhQRiyWm4g2q/x9UpXS50dkTuN3+kABFhIwHal81q0E6kmN3phd/1uKvV3VthE
	XKalkkVErheRUobrZ2Ue1UUybCpsM2eX7DLo7WggkoEUwBBv1rzUQghWwAgVXyzJrHRKDj
	zRLevhcGcjvjEfmGfHIAqV5N4YCUOFk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-qBmTi-pQMGuzeOIk29bsmw-1; Tue, 08 Oct 2024 04:26:45 -0400
X-MC-Unique: qBmTi-pQMGuzeOIk29bsmw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb08ed3a6so29167535e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 01:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728376004; x=1728980804;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOjJUPPhXg7FHSURpsWRXRS9eGsX5EzRwbqt9a/KOqs=;
        b=ZC2rjzhI2i5MvzHb1WLt0STAqSecMSnoLwTkJfNRt22KsniTuY974cWZsWy6mjww9S
         bUgcndcoVDPVlI+tRJngIXAMDLmv0u0el6CrIFz8Sgdt3BG3W20c/iAA9hmmbE6wPhet
         nHYtayXp84uJRQsFI07tldwcoQxv1rG1zYPxw+idO2SkN8p2ZZbgyezMVYZy7vpaTCtt
         jR08cayZmL4V4HLbxX9R9S9V0birZDFScKNYnNLC0GTY6tokqVBK9O11H5Q53HP1HGOF
         zwd73CRTb68usmY2nsKOtc121J3kbb1J4eyVSqqGAlf90HnxuuFSi8FvwM4ggW6r54eF
         Vz0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQuJvHa8owcosytM5rHQycFMuZoQgOCquErTlXp+ry2CM4+xvlBw8h57OUGvXYH44s4AQd8Zf9qqrPb/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg69+vbWi3tAyjrOj0kcVZTutSbb6irtXoMUk6bXbBu6D5Dusr
	bfM+6HdwihClzfEui7Jihk6xLYt3bWGPiDkkUYpYmvimT6lrS3UuaWYapCJs2IT9XF4/QF0I7co
	TtQtbSvM7XkA8/g5PIhNs6BDPtACv/LeWIa2B4P3zx58Q5qZftDvStFSJvgfZGg==
X-Received: by 2002:a05:6000:4388:b0:374:be11:22d7 with SMTP id ffacd0b85a97d-37d291e4855mr1266566f8f.13.1728376004099;
        Tue, 08 Oct 2024 01:26:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu3TPyBQ3L4hIAxIau3Zd48Xzi67YXUNgs2dOzN+sxzJaBIkGMRUy5UUj18X+Q8bjMaGLHMg==
X-Received: by 2002:a05:6000:4388:b0:374:be11:22d7 with SMTP id ffacd0b85a97d-37d291e4855mr1266542f8f.13.1728376003692;
        Tue, 08 Oct 2024 01:26:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:c700:a76f:473d:d5cf:25a8? (p200300cbc72fc700a76f473dd5cf25a8.dip0.t-ipconnect.de. [2003:cb:c72f:c700:a76f:473d:d5cf:25a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a4cdsm7442141f8f.27.2024.10.08.01.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 01:26:43 -0700 (PDT)
Message-ID: <9e4e3094-00a2-43bc-996f-af15c3168e3a@redhat.com>
Date: Tue, 8 Oct 2024 10:26:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: avoid clearing user movable page twice with
 init_on_alloc=1
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Alexander Potapenko <glider@google.com>, Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 John Hubbard <jhubbard@nvidia.com>, "Huang, Ying" <ying.huang@intel.com>,
 linux-kernel@vger.kernel.org
References: <20241007182315.401167-1-ziy@nvidia.com>
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
In-Reply-To: <20241007182315.401167-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.10.24 20:23, Zi Yan wrote:
> Commit 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and
> init_on_free=1 boot options") forces allocated page to be cleared in
> post_alloc_hook() when init_on_alloc=1.
> 
> For non PMD folios, if arch does not define
> vma_alloc_zeroed_movable_folio(), the default implementation again clears
> the page return from the buddy allocator. So the page is cleared twice.
> Fix it by passing __GFP_ZERO instead to avoid double page clearing.
> At the moment, s390,arm64,x86,alpha,m68k are not impacted since they
> define their own vma_alloc_zeroed_movable_folio().
> 
> For PMD folios, folio_zero_user() is called to clear the folio again.
> Fix it by calling folio_zero_user() only if init_on_alloc is set.
> All arch are impacted.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   include/linux/highmem.h | 14 ++------------
>   mm/huge_memory.c        |  4 +++-
>   2 files changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 930a591b9b61..4b15224842e1 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -220,18 +220,8 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
>    * Return: A folio containing one allocated and zeroed page or NULL if
>    * we are out of memory.
>    */
> -static inline
> -struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
> -				   unsigned long vaddr)
> -{
> -	struct folio *folio;
> -
> -	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr, false);
> -	if (folio)
> -		clear_user_highpage(&folio->page, vaddr);
> -
> -	return folio;
> -}
> +#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
> +	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr, false)
>   #endif
>   
>   static inline void clear_highpage(struct page *page)
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index a7b05f4c2a5e..ff746151896f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1177,7 +1177,9 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>   		goto release;
>   	}
>   
> -	folio_zero_user(folio, vmf->address);
> +	if (!static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
> +				&init_on_alloc))
> +		folio_zero_user(folio, vmf->address);
>   	/*
>   	 * The memory barrier inside __folio_mark_uptodate makes sure that
>   	 * folio_zero_user writes become visible before the set_pmd_at()

I remember we discussed that in the past and that we do *not* want to 
sprinkle these CONFIG_INIT_ON_ALLOC_DEFAULT_ON checks all over the kernel.

Ideally, we'd use GFP_ZERO and have the buddy just do that for us? There 
is the slight chance that we zero-out when we're not going to use the 
allocated folio, but ... that can happen either way even with the 
current code?


-- 
Cheers,

David / dhildenb


