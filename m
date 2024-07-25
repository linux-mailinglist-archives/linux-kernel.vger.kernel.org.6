Return-Path: <linux-kernel+bounces-262223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD3193C2B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA53281E12
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C92F19ADB6;
	Thu, 25 Jul 2024 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eflSgiIa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B6017557C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721912985; cv=none; b=k/JDEVmLHLdDXcbRaKA5QWtK2jZ1i1+c34Djtyb/Hb3gZwEzCeG4BZU1iUrqNF4krz434+ozj20+OzCZPz4nlqrNc3I6fxq93K9nK0omDWuI0qcSKM5lzdqRBsMFKdSgdRKYskBjZxBTfptlyqces3cstwkiqfbAIkImO5j3bAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721912985; c=relaxed/simple;
	bh=6jX/3LTC9rhKPumdjIu9IGVzM34sFS4om4BlwUDFh+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGvvfCKyyD6/4QwgUctPRdl1hie+9JKOYxjQvNOPb5GYBZni6Pj0APu1qDXRBNTwp94P+bL9K64kDmkHFv1tEsi5i/H5z6Z60/i8FUnf8BvmehR1RSu0/Wy072FKKGA6iCWMxpmuhXKpq2JSQ+Ac2cemtASk8n+RGV0lR6AE9n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eflSgiIa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721912983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TtOL4ge7LeZL6vEgVOWedkEsRl+7qXAM8fQrH4fh/Bc=;
	b=eflSgiIasX9zf2XYOYrIj8+HCs/FImQORZDEhtohDKGPRjzrv3Ak1lr4z1NqqZAUH3/u0E
	pY27Ff4Pm6vD/EPvCPsln+3TdwI7p/8G0ZuUGePFgZ+Op4Tp6lBSV+5W46W4MeLQ/yQCSG
	R5D2jIs/OD1DmDiOfoH/SKM4s2XEOog=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56--Gc3Ie16MWKJI9KTJz49eg-1; Thu, 25 Jul 2024 09:09:41 -0400
X-MC-Unique: -Gc3Ie16MWKJI9KTJz49eg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42808685ef0so2574245e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 06:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721912980; x=1722517780;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TtOL4ge7LeZL6vEgVOWedkEsRl+7qXAM8fQrH4fh/Bc=;
        b=YbGsheQQYeWwImR68MzZU1Y/JY3Xk1l1q8HD15WTErW/7WPJMDE+8A6ISi5fTqFH/G
         Trgje95jP2mD6TSaNku8GzWuZJlkHlMVco4t4NnCD6Deb2WrngqrMWUlHihRK7kAC6SS
         CUIcLMuNHN6Ik+WmElw4grVhengovs14hh0sYXqp94yOOURlVNM8LSD7wxyXo38yfcrI
         7ISJdaqrD2GfE4b3Vx286xyxaq1x/gZ8MSSCQQ4Fh4W9FFuZU5xQVa5ca6BwDfdjUgtC
         7wLIz7unO6CAdzZzmO6idf29FEHEyq5iNpOTL+6ibN7v7+9ltKkmaIXCHiaIw97L6Mb0
         nNAw==
X-Forwarded-Encrypted: i=1; AJvYcCUTb8iWIRnHHcuhSl9H4V7bAXRs296Qo7RSu+gf8LKzmK1JCCqhh7FjZWsJFbWzfsxORmnG2e08bRGEx2R7rCO4d1aZJuTvjAg3Fz3l
X-Gm-Message-State: AOJu0Yw7cS4UPwbGyVEbAP1KlGkqtZElwBMhSwLqSNKVLA9x5X34os+R
	4iSAl2Ct/UIkrH7MrLqGnC1SSx5oYsPVptDmSSdl2s0j0IiiDvJa7VRaSGNmMuUFQYL5an0vpoO
	EEeKiIfcyw+TFZgnU0ULjQ8eLlO8epmar2NbUely8P09iaEGupEql+QSo0RR9aA==
X-Received: by 2002:a05:6000:1188:b0:368:38ea:7178 with SMTP id ffacd0b85a97d-36b3638c4d6mr1870772f8f.16.1721912980628;
        Thu, 25 Jul 2024 06:09:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8NDa10kpkcToYFbS1tE2a7on0sb7S8z4RiI1z2H9XjU5MrwnKVnco4DUKatDCSByAaPKQtA==
X-Received: by 2002:a05:6000:1188:b0:368:38ea:7178 with SMTP id ffacd0b85a97d-36b3638c4d6mr1870751f8f.16.1721912980170;
        Thu, 25 Jul 2024 06:09:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:2c00:5f6:3120:375a:3e4? (p200300cbc7062c0005f63120375a03e4.dip0.t-ipconnect.de. [2003:cb:c706:2c00:5f6:3120:375a:3e4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42805730d92sm35144785e9.3.2024.07.25.06.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 06:09:39 -0700 (PDT)
Message-ID: <1e635cfd-d461-4e56-95b8-c6ea512f64ca@redhat.com>
Date: Thu, 25 Jul 2024 15:09:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mm: shmem: move shmem_huge_global_enabled() into
 shmem_allowable_huge_orders()
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, 21cnbao@gmail.com, ziy@nvidia.com,
 ioworker0@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1720755677.git.baolin.wang@linux.alibaba.com>
 <16dad33282617ecb90a3f466b35273b10be68d21.1720755678.git.baolin.wang@linux.alibaba.com>
 <b670b981-bc79-4c8c-8b69-4879300066d4@arm.com>
 <f206ad30-a007-499e-941c-1c4abc0c5eb3@linux.alibaba.com>
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
In-Reply-To: <f206ad30-a007-499e-941c-1c4abc0c5eb3@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>    /*
>>> @@ -1625,27 +1632,39 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
>>>    #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>    unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>>    				struct vm_area_struct *vma, pgoff_t index,
>>> -				bool global_huge)
>>> +				bool shmem_huge_force)
>>>    {
>>>    	unsigned long mask = READ_ONCE(huge_shmem_orders_always);
>>>    	unsigned long within_size_orders = READ_ONCE(huge_shmem_orders_within_size);
>>> -	unsigned long vm_flags = vma->vm_flags;
>>> +	unsigned long vm_flags = vma ? vma->vm_flags : 0;
>>> +	struct mm_struct *fault_mm = vma ? vma->vm_mm : NULL;
>>
>> nit: rather than deriving the fault_mm here, I wonder if its cleaner to just
>> pass vma to shmem_huge_global_enabled()? shmem_huge_global_enabled() is just
>> using it as a guard to access vm_flags, which you can just as easily do by
>> testing the vma for non-NULL. And you can access mm flags with vma->vm_mm->flags
>> after testing the vma too.
> 
> Make sense to me, and will do in next version.

Feel free to add my

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


