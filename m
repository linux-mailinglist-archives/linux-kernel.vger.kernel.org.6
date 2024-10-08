Return-Path: <linux-kernel+bounces-354715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93628994196
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE36282FCE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01B51E376E;
	Tue,  8 Oct 2024 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O62G16sK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988281E0DC8
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373966; cv=none; b=kWMEFXz4ky2wiburi5NU2yfEoUk3ci7WG+XdxWfh1hPgFgkMr/5iNkYhaJmpgbleO21ijvroAq5d0Y3258LUgD5v34p+uy4/xvClRaMvHAsdeX5Fkj+z3kBhzhKwzSQerjbeHuaLAFrHA/xFc6GntiD6Q6YCopoOs1IW/Dma7R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373966; c=relaxed/simple;
	bh=B0Zd/SxC02PIQZK9wRMAHf0GJJUGb8QGgqvT+QxuqNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ItNnUdJ9As7m4B0Xjfl7XZgXgAJhvPbFIrFhLDolasdH3awypdbiJsPBBHpD5Fv8JqYi4V1l6wsKcDmEnisDgRRquLAKygPhJAh0U1UQ0pxzc6znankXt7Jm3ULf9bvKKP9ALj6+xykeM5xWlBvtAQxdBO6CAPbN0Y/gx14iNEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O62G16sK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728373962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=25lALwZwb1PU97HFjPipcsWkCDl7P4A0WPaz1iPQJQA=;
	b=O62G16sKx8rkwtRQgTjeZZkIAAFKnio2nA9pp6Ly3klLhbmO+nEbIKmnf2ODVSr/J+T3OL
	p9ssNzwbCzxa8VRCeo6h6AqT1Pfs+6xScgC3I4w+QQIDILFIoKoSfA8TAqE8ZLTmNB7bkd
	+lv9gSgUoS9wodBN3KhFW5SpVZRi/Qk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-fxcd9zEyMxGAdLYQFBg4ZA-1; Tue, 08 Oct 2024 03:52:41 -0400
X-MC-Unique: fxcd9zEyMxGAdLYQFBg4ZA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-53994f50133so5135540e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 00:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728373960; x=1728978760;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25lALwZwb1PU97HFjPipcsWkCDl7P4A0WPaz1iPQJQA=;
        b=LPtFQJQY/fj3NRwM1A5J25BwkBQgjU9xSxLqf5J6xtO+XPHcGmaboFwY0xqcJ2r5Yp
         REiDh96YqTabQj4fdQDmQYxmDxdtH74MfM0Z1xluX98qmO7VEonXl88QLc9KHH6RFCk8
         RrKAqNIR1rqrwE/OmQaHtPhG4lwXeUW7b82pgdu2aw3DDz12S2Xc/HfTucgAmbxBFgNw
         6MROpKrZACZXLF3xdtyYiM3X0/FD++E+giMLrqhHRW5ruLMuHXK3Oi/2YLjJAZHt/bcD
         F0Gji5ySQwIsp1BqyRR4VmReBQALVsa+NXt5/0Qa6WYfoS4Jv2gCdq2sX8tKhj6LT1Bg
         RlqA==
X-Forwarded-Encrypted: i=1; AJvYcCXpP7ZAAUpS3e5X/tv5PCW9mFIjeok9TBRMc06FBOBgt3WAtPf15ovn/7ib9/MEeQivZb9KkeAxIBo3apI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhS1gQTXohmIfAIk7b4vbmV2kKy/3CD8Fp3pjCgNyfrPxsVWz5
	DVXgjemhDq+X5bWh+3DLOb7cQBNeAyNgSkTOeCeu1rxsnWhkg8JHBfPp2pfwTwap7Iq9WkHvs/+
	YXgFjE351u0Es1pWKOsWVTJqnwPAdECKKhN0B0jQ1m9xLW6o/u0xDgz1pGsiVVQ==
X-Received: by 2002:a05:6512:3d93:b0:533:d3e:16fe with SMTP id 2adb3069b0e04-539ab9eae13mr7371322e87.38.1728373959644;
        Tue, 08 Oct 2024 00:52:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrLWQZap6ReWjPsbtxajYy1aDLLfJbV8H6PL5MUUysCkaPVdqC8/q5O52n67bkKlWj7ncI7w==
X-Received: by 2002:a05:6512:3d93:b0:533:d3e:16fe with SMTP id 2adb3069b0e04-539ab9eae13mr7371313e87.38.1728373959149;
        Tue, 08 Oct 2024 00:52:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:c700:a76f:473d:d5cf:25a8? (p200300cbc72fc700a76f473dd5cf25a8.dip0.t-ipconnect.de. [2003:cb:c72f:c700:a76f:473d:d5cf:25a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43017465f3bsm15971755e9.0.2024.10.08.00.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 00:52:38 -0700 (PDT)
Message-ID: <75fac79a-0ff2-4ba0-bdd7-954efe2d9f41@redhat.com>
Date: Tue, 8 Oct 2024 09:52:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mremap: Fix move_normal_pmd/retract_page_tables race
To: Qi Zheng <zhengqi.arch@bytedance.com>, Jann Horn <jannh@google.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, willy@infradead.org,
 hughd@google.com, lorenzo.stoakes@oracle.com, joel@joelfernandes.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241007-move_normal_pmd-vs-collapse-fix-2-v1-1-5ead9631f2ea@google.com>
 <1c114925-9206-42b1-b24b-bb123853a359@bytedance.com>
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
In-Reply-To: <1c114925-9206-42b1-b24b-bb123853a359@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.10.24 05:53, Qi Zheng wrote:
> Hi Jann,
> 
> On 2024/10/8 05:42, Jann Horn wrote:
> 
> [...]
> 
>>
>> diff --git a/mm/mremap.c b/mm/mremap.c
>> index 24712f8dbb6b..dda09e957a5d 100644
>> --- a/mm/mremap.c
>> +++ b/mm/mremap.c
>> @@ -238,6 +238,7 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>>    {
>>    	spinlock_t *old_ptl, *new_ptl;
>>    	struct mm_struct *mm = vma->vm_mm;
>> +	bool res = false;
>>    	pmd_t pmd;
>>    
>>    	if (!arch_supports_page_table_move())
>> @@ -277,19 +278,25 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>>    	if (new_ptl != old_ptl)
>>    		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
>>    
>> -	/* Clear the pmd */
>>    	pmd = *old_pmd;
>> +
>> +	/* Racing with collapse? */
>> +	if (unlikely(!pmd_present(pmd) || pmd_leaf(pmd)))
> 
> Since we already hold the exclusive mmap lock, after a racing
> with collapse occurs, the pmd entry cannot be refilled with
> new content by page fault. So maybe we only need to recheck
> pmd_none(pmd) here?

My thinking was that it is cheap and more future proof to check that we 
really still have a page table here. For example, what if collapse code 
is ever changed to replace the page table by the collapsed PMD?

So unless there is a good reason not to have this check here, I would 
keep it like that.

Thanks!

-- 
Cheers,

David / dhildenb


