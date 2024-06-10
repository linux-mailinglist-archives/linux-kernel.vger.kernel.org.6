Return-Path: <linux-kernel+bounces-207852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C655901D02
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0351C21064
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EEB6F079;
	Mon, 10 Jun 2024 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLi9hEU4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1FF63C7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008380; cv=none; b=iExlA0rFO2L4FRPGAAu5EG6bOS68UyKDWFJ1P+rVKx6ST3egcOs2rOGv9RR2kgfZas0J/CatS7QXqOryL8NYQmxpVDPPFZYavQic9eHtIljQTw/XoVEIxmlUscjztbW4QZhC1+orwmoS7nzUJkGfxiVLGHXG62CJwbD3+ILEQJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008380; c=relaxed/simple;
	bh=as0HTJQ8A4AJxNVHnUp1HXGaXp6uBep/Ck+KLPlL0Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bOyBnGMILAntSNZ90mJOl60p9rAyDjFCub9Cv+HGNxc7OsceNoSxvGm+s1Mo5hxI+KxQei3LrkjMzlKpHCB8uPGTJiSBUciHc3RgZ3g5rTi1q5bXnjm0y1XMecrOE5YHFsQir80vXc2+3hWPhBAr1vYTJ+7vagZfj7MNVVlYrsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLi9hEU4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718008378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kT5g/UA9Wo4TS54uBNIugmZXUwC2QiFxcvHU9R0uVXY=;
	b=VLi9hEU4uN7gYGucEReY1GV0pLs3bQaIsKdqlsJv1cuCJ7Q/u3p/mgKoCu6C9f7AL26shZ
	flE6dMJZ8VI6GvKWdxiWOYN1hjR3AJ53Q42BPxbxZkxICp30eTh9vNm5SVfQjoTOvmhKv1
	+hzEWoyBOJtyLZjcdaeO23IfvpQWTVQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-WmtXeZLwMxiBx7m2EOGXuQ-1; Mon, 10 Jun 2024 04:32:56 -0400
X-MC-Unique: WmtXeZLwMxiBx7m2EOGXuQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4217b3d2044so10367405e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 01:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718008375; x=1718613175;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kT5g/UA9Wo4TS54uBNIugmZXUwC2QiFxcvHU9R0uVXY=;
        b=rBL8OnWfyPAOKgeuJ1E66ic8ecMUxRncF37GAuyDOigliofG14XNfzItYmLFhV7pPX
         j3JdpvIMeQ8yIvww78PtKX8yi/S1dTMoJjD8p3zCuD7DgGcrDt1Y+dH4G5RixNN043HC
         fpyssUhbQxihNJpTjyjJ+Mkn4ucUOF1phJq7Maz4+Amv7XpDTFh6dJ53/Oq0UqKHfW89
         p96VIAFp4GI+OrgpZy8Z2G4a9wEWc6uP2IfqMjmTDExgwr8RwrHpwfQj2rv93qHAW5GE
         Fi2zyNhtUylG0Hi/WaWQqK+Sug1b54TqXtmjxWxYopRfRtaQ535NNietw/dXuKiPfnml
         RJDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIjuIPArIn0ySk9oAmnqF5roRu+teRCj8ML+4AT5n3E2NK5Wuxv5qrChXQtdV/7J+rhB4meaDuoGlLxGAwOiqcKlxHEJeX8UNdtcfC
X-Gm-Message-State: AOJu0YwGzEXtnaggZV2yekCq9rIihMv+J2WNdyXZj7WKOOAc0sM1tRRi
	WsT7L8ksRFozSg+lCwL/TzPP14dyXXfV8P7DDWzOdkDh+5g+k14QaCxUXliETl9wa5GiAMj/T3D
	hbUiPrWvSteld9PUBPEPUt7wa3mttQzkWZCmudZ01OTD5XKQchA0HquuTKfGPBw==
X-Received: by 2002:a05:600c:3555:b0:421:7ed9:81d3 with SMTP id 5b1f17b1804b1-4217ed98a94mr39812305e9.14.1718008375505;
        Mon, 10 Jun 2024 01:32:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJy97q55r30BWPKfbqyFTBYVglQIwOZE8jO1UNB9Gm5+3oUAmOiSWDfhwmdq6Y0FVBwOlXfQ==
X-Received: by 2002:a05:600c:3555:b0:421:7ed9:81d3 with SMTP id 5b1f17b1804b1-4217ed98a94mr39811995e9.14.1718008374880;
        Mon, 10 Jun 2024 01:32:54 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421e91c46e4sm18857285e9.9.2024.06.10.01.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 01:32:54 -0700 (PDT)
Message-ID: <bf22ef0e-0bb0-4533-838f-365b2078f03e@redhat.com>
Date: Mon, 10 Jun 2024 10:32:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm: set pte writable while pte_soft_dirty() is
 true in do_swap_page()
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: chrisl@kernel.org, kasong@tencent.com, linux-kernel@vger.kernel.org,
 minchan@kernel.org, ryan.roberts@arm.com, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org
References: <20240607211358.4660-1-21cnbao@gmail.com>
 <20240607211358.4660-3-21cnbao@gmail.com>
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
In-Reply-To: <20240607211358.4660-3-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.06.24 23:13, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> This patch leverages the new pte_needs_soft_dirty_wp() helper to optimize
> a scenario where softdirty is enabled, but the softdirty flag has already
> been set in do_swap_page(). In this situation, we can use pte_mkwrite
> instead of applying write-protection since we don't depend on write
> faults.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>   mm/memory.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index db9130488231..a063e489446d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4322,7 +4322,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>   	if (!folio_test_ksm(folio) &&
>   	    (exclusive || folio_ref_count(folio) == 1)) {
>   		if ((vma->vm_flags & VM_WRITE) && !userfaultfd_pte_wp(vma, pte) &&
> -		    !vma_soft_dirty_enabled(vma)) {
> +		    !pte_needs_soft_dirty_wp(vma, pte)) {
>   			pte = pte_mkwrite(pte, vma);
>   			if (vmf->flags & FAULT_FLAG_WRITE) {
>   				pte = pte_mkdirty(pte);

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


