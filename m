Return-Path: <linux-kernel+bounces-184637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 187108CA9E5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4291F21BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DBE54675;
	Tue, 21 May 2024 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgStdCms"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4123054762
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716279961; cv=none; b=qSUUhfcUMapzGLSPfZtlSPX1fIl9oqR6hTIdxv6vjokW5bUAnat94L0lXx1WtI6Hsw5Go7WSLFjU6hjtSQfI2WkmsdjPEg1kawSrV8OThCoLjOcndZ1wmAxFiA0Vtg4NSFN+BBUUZew8/dk75TzIPoyGHi7ZLGjQibrSHHrB76M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716279961; c=relaxed/simple;
	bh=CooYznksIfhq9y9rSyIpA/vdXmFQUbjQr7VQPSD1MwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4Kz34ADoshP/EtPzJjh+aDX4V9pMYwFxRc/gLoGeI2BLt6q1aoHg5w09im713PYVkY/E6qlYFtxgWKvfcd4IdqqsS6mAkaKriEFVcnt6rZYUTWUChzCTMix4/mjJIuYfu1BGuEacO8/P283DWMm+DWpS2zNbLSIDRI+k1qd7O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TgStdCms; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716279958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=27+XXDjguxbwELklYAYivLGJcV/6bKWX/XsoeP/QUDE=;
	b=TgStdCmsqulooalds26hGtlaDDvoGz5KoV0KpwbfxbH2bhrxWCBkUVKTNKRRm1FwRxYLsx
	QSA86/OrG3xSMoz3TWgpfWxeGriUkADuwyShsu8T0bh11N54fffvdHkEZ2Jq/nUlHxLn/K
	YI6kUOyKqx5s44dGVZrdixcAuro09X0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-z4mp-uoQOiOGYwrM8AYvXQ-1; Tue, 21 May 2024 04:25:47 -0400
X-MC-Unique: z4mp-uoQOiOGYwrM8AYvXQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2e22623b573so110330041fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 01:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716279946; x=1716884746;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=27+XXDjguxbwELklYAYivLGJcV/6bKWX/XsoeP/QUDE=;
        b=qW16epvV7OgM1QUiO0uSypMXKgCs34AW0NWgYk96UzzhQSn0m9er6cpEFPiRO1gNZ1
         WG+QC5WEWdRNUygPTqPfe16N3kADVuSmkUG0yV1xdF5pFmS4k5Vae2lt3q/eGTeWZjFd
         4HZl9QdGqavuNKPRzo6oy8od+KGRsSBcffrm+rTKrSjd0ni4Z4LtJsb9yRZXoTZrI5rt
         AB3ROPeV7/X/BCSSlzuaU6SNj8cyfXkZKVJLK3e0yP3yhYtshk7hgU1BRa2LDiMzx4Sw
         c5fCRkZgAlkjFEv9ZXAUhhavRIi7v19Vv8bXS1Z2Uliuzzea+hOM2vlNn3sJmQ8/MGfG
         /ybQ==
X-Gm-Message-State: AOJu0YzFvYi8+A39099EwaZU7TNOIiBLSldMg/ABcW/hzpjwzLvPMJp0
	B0A7H8tW73VD1sXtZEd8JdnlhrBoIprvKBIvZtIEDu9w9HwRMoHPmWBSY88hwAS5bhWx8ZE3Oda
	KGy3+HqOMeR2omZnl7uctskDA8YGR5DdTpB9HBOv6045OZqw17QZRrC5Wb7ZKoKR4KjDXsw==
X-Received: by 2002:a2e:b168:0:b0:2d8:9d8c:9533 with SMTP id 38308e7fff4ca-2e5204b1c3cmr183028981fa.53.1716279946037;
        Tue, 21 May 2024 01:25:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfyam75ZPtIOYWnv7FXSVBfH5/OMq/FxbPCJqznlwD2SFbT6PkalQ3oVJpEflMKJhWF3DEPg==
X-Received: by 2002:a2e:b168:0:b0:2d8:9d8c:9533 with SMTP id 38308e7fff4ca-2e5204b1c3cmr183028611fa.53.1716279944516;
        Tue, 21 May 2024 01:25:44 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41ff7a840d2sm415707655e9.39.2024.05.21.01.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 01:25:44 -0700 (PDT)
Message-ID: <3decc6c8-9035-44d6-89c6-8d42a5e0bc40@redhat.com>
Date: Tue, 21 May 2024 10:25:43 +0200
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
In-Reply-To: <Zkdys7YKC5pe1vAu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.05.24 17:07, Vincent Donnefort wrote:
> Hi David,
> 
> [...]
> 
>> -static int validate_page_before_insert(struct page *page)
>> +static bool vm_mixed_zeropage_allowed(struct vm_area_struct *vma)
>> +{
>> +	VM_WARN_ON_ONCE(vma->vm_flags & VM_PFNMAP);
>> +	/*
>> +	 * Whoever wants to forbid the zeropage after some zeropages
>> +	 * might already have been mapped has to scan the page tables and
>> +	 * bail out on any zeropages. Zeropages in COW mappings can
>> +	 * be unshared using FAULT_FLAG_UNSHARE faults.
>> +	 */
>> +	if (mm_forbids_zeropage(vma->vm_mm))
>> +		return false;
>> +	/* zeropages in COW mappings are common and unproblematic. */
>> +	if (is_cow_mapping(vma->vm_flags))
>> +		return true;
>> +	/* Mappings that do not allow for writable PTEs are unproblematic. */
>> +	if (!(vma->vm_flags & (VM_WRITE | VM_MAYWRITE)))
>> +		return false;
> 
> Shouldn't we return true here?

Indeed, thanks! I wish we would have user in the tree already that could 
exercise that code path.

[...]

>> @@ -2043,7 +2085,7 @@ static int insert_page_in_batch_locked(struct vm_area_struct *vma, pte_t *pte,
>>   
>>   	if (!page_count(page))
>>   		return -EINVAL;
> 
> This test here prevents inserting the zero-page.

You mean the existing page_count() check? or the (wrong) vma->vm_flags 
check in vm_mixed_zeropage_allowed() ?

-- 
Cheers,

David / dhildenb


