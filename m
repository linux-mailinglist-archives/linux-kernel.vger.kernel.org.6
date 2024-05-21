Return-Path: <linux-kernel+bounces-184691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A7A8CAA99
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782361C21A55
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2E656B91;
	Tue, 21 May 2024 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlV36nte"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673872EB1D
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716283128; cv=none; b=AgH5ixhWlBaUPocGD5zhAKmRW7iFoReR64mxzeeWldq7/xQyttPgPYs80NU4RVneRm8tErnCuM9NVtxnRAhIE5CiIeXh97nMz7cSeK/W3YfMZhfkdrJ/cubeEO5074s6JJqcrqCpnod1T0ho6+mYBr4JmXVKZ8CjaTi2C7Mvja8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716283128; c=relaxed/simple;
	bh=0X9YsczLkwuQQ1uVOKhEJVPPv/H07Bx6pD3Fm3d0QGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L40g5DD57uZbscAg3677FZjOU56oXwT7k7gvmkJE2Cbiy3u3u2QWCYkjQ28l3oLVXqmotJ+bZ9svrJeDKpH60TS3VVtmvsje4QTY+Ozm2S4Z2C+Fj40EOdRaexkkOY+l7puvY/iw0uYd8K/TuOnRIyVzxseareKeQIPFXM3X/Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hlV36nte; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716283126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dnj58lhRSj3HFW+3WnRIrRV99SqSMaIOOL0f1Q9rFks=;
	b=hlV36nteK5h/vsQxHWjGyYZdfRhe5Quu9jhbkCEZvFnpfHl/uD0KcUTR0CXP4YE8qFB3eY
	3gW1f17qguRwNXkR0aWYNdHf4YgPYIXgnETT1YoHyt7DjY57KRiiknZbgktttn5B5rk3kI
	1WMGgS/QScxiCGa5TcbKGKjYOd47toI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-wPz5GIhnNKmSCA8hootIYQ-1; Tue, 21 May 2024 05:18:44 -0400
X-MC-Unique: wPz5GIhnNKmSCA8hootIYQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2e1f38cb631so112309631fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716283123; x=1716887923;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnj58lhRSj3HFW+3WnRIrRV99SqSMaIOOL0f1Q9rFks=;
        b=HJZ9Rh8WDR/PFCh8Eu7j+97jDhJU92pOtK5bYBmmMEPK2wTYNwVZlmJMipZmJPGHjB
         wEvSbv3ATPET/9beT6XNhJErQkfdddQpCMbjO5GQSxXdgZ/AILiJCak2jHLm1ZZtKrDK
         BcLskFluD1ZL1bGtweZ0CfEfiOcx/9J+LxmD+zQH3UTKHN46Nrc9Y4cquWEiN14Uo3tV
         DU1g3S6hY0aQne9vrx39Iurnm4C/Pw4xV1B5gGsxLIkKEuC7kowQLoxzXHhN+0dsOwWC
         LzxuBv6Vq9rf7/ZUuW2TDyxtCXFagtsMQhygCXTIq3iUB0wn0Si8Y9q9RD8rKyMNqoIj
         5JCw==
X-Gm-Message-State: AOJu0Yz0SQOC4V4nAOmEFshOVIsEwfINsfSxCsV3dH4CSaEXAvQDcwI2
	UaKiTFDQMPhBp+hcYasYpKtJrOj1uPNK3xxAOjd9tq5AsNqpglTK2Dr+KgZi1rvusqO0+k9q0L1
	26YAUixnpCg/YQtOI8rt9vI+IiHqvBgVVLQ6bikYUe0lH4+lBGz9GIO/E+z4lnw==
X-Received: by 2002:a2e:9ac2:0:b0:2e0:298d:65ec with SMTP id 38308e7fff4ca-2e51fd45214mr271433801fa.17.1716283123243;
        Tue, 21 May 2024 02:18:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtI3Nqf10gi5+vvA+q89PR5+fFmUED7YWM/0b2KlxJbM+vtt+wifUlgzEsUFkC/F+dL/OK4A==
X-Received: by 2002:a2e:9ac2:0:b0:2e0:298d:65ec with SMTP id 38308e7fff4ca-2e51fd45214mr271433571fa.17.1716283122764;
        Tue, 21 May 2024 02:18:42 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8fa6sm457113275e9.2.2024.05.21.02.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 02:18:42 -0700 (PDT)
Message-ID: <dde2f22d-c57f-44ac-9f2c-4a1790de084b@redhat.com>
Date: Tue, 21 May 2024 11:18:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm/memory: cleanly support zeropage in
 vm_insert_page*(), vm_map_pages*() and vmf_insert_mixed()
To: Vincent Donnefort <vdonnefort@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>, rostedt@goodmis.org
References: <20240430204044.52755-1-david@redhat.com>
 <20240430204044.52755-2-david@redhat.com> <Zkdys7YKC5pe1vAu@google.com>
 <3decc6c8-9035-44d6-89c6-8d42a5e0bc40@redhat.com>
 <ZkxkDPnPiQzPEm-0@google.com>
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
In-Reply-To: <ZkxkDPnPiQzPEm-0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.05.24 11:06, Vincent Donnefort wrote:
> On Tue, May 21, 2024 at 10:25:43AM +0200, David Hildenbrand wrote:
>> On 17.05.24 17:07, Vincent Donnefort wrote:
>>> Hi David,
>>>
>>> [...]
>>>
>>>> -static int validate_page_before_insert(struct page *page)
>>>> +static bool vm_mixed_zeropage_allowed(struct vm_area_struct *vma)
>>>> +{
>>>> +	VM_WARN_ON_ONCE(vma->vm_flags & VM_PFNMAP);
>>>> +	/*
>>>> +	 * Whoever wants to forbid the zeropage after some zeropages
>>>> +	 * might already have been mapped has to scan the page tables and
>>>> +	 * bail out on any zeropages. Zeropages in COW mappings can
>>>> +	 * be unshared using FAULT_FLAG_UNSHARE faults.
>>>> +	 */
>>>> +	if (mm_forbids_zeropage(vma->vm_mm))
>>>> +		return false;
>>>> +	/* zeropages in COW mappings are common and unproblematic. */
>>>> +	if (is_cow_mapping(vma->vm_flags))
>>>> +		return true;
>>>> +	/* Mappings that do not allow for writable PTEs are unproblematic. */
>>>> +	if (!(vma->vm_flags & (VM_WRITE | VM_MAYWRITE)))
>>>> +		return false;
>>>
>>> Shouldn't we return true here?
>>
>> Indeed, thanks! I wish we would have user in the tree already that could
>> exercise that code path.
> 
> I have a patch ready to use this path from the memory map tracing! I can either
> send it once this one is picked-up or you can add it to your series?

Whatever works for you! To debug, it would be good if you could send me 
the patch and simple instructions on how to test it (do we have a 
selftest as well?).

> 
>>
>> [...]
>>
>>>> @@ -2043,7 +2085,7 @@ static int insert_page_in_batch_locked(struct vm_area_struct *vma, pte_t *pte,
>>>>    	if (!page_count(page))
>>>>    		return -EINVAL;
>>>
>>> This test here prevents inserting the zero-page.
>>
>> You mean the existing page_count() check? or the (wrong) vma->vm_flags check
>> in vm_mixed_zeropage_allowed() ?
> 
> I meant this page_count() here. As a quick test, I removed that check (also fixed
> the vm_flags above) and the zero-page was properly mapped!

That's weird and might indicate another issue.

The refcount of the shared zeropage should be initialized to 1, just 
like for any other reserved pages 
(mm/mm_init.c:__init_single_page()->init_page_count())

Hm ...

-- 
Cheers,

David / dhildenb


