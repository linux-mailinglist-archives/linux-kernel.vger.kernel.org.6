Return-Path: <linux-kernel+bounces-280471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B7794CB0F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 166B7B239F2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409BA1741C9;
	Fri,  9 Aug 2024 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGa/C3vu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F3B1B964
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723187815; cv=none; b=WIrDq8BUuhGYpGBNaNUd2hwJnGAV0ODEy8ZxiAVzVKENMRT8QwTH5Y27exiTGuvyc0CzaQlw8lledfjZ8LVIAvsuKXIGnTZpolwP3Zht/CzbyQL8f9QYqT/NohOb98hHzDhbd/uOAjqyNyDDAv4NPR728eI7kY2fn/5VoKDoxLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723187815; c=relaxed/simple;
	bh=/IODmwfYieU5IO6p13ZgFbK/dzcp4i/Wgb9xnFF8XhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsRqt/sW3tbQiCCTyp0nxNswee9YNpTIic7tzUKdoaHNw2I+nkpmAAHq3FvH+6kvVxTqjliFXKPm2+Yv9GsdoXndxo4kaI3ReYWJ/+8OG3vDaCZOBBvzQrWOkiRN0l40RqOHpi/NI5i7fdu9eYXZAExKhBmKOTfZZangHpK1wVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGa/C3vu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723187810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WjJJO1LczwWOlW0BQ8SK5TpK9dJIW736kg5IdhWodDY=;
	b=OGa/C3vuO7+L7EZV/q+uU11cKdWV90NZ0YYGu7NozoquHj2nB6M4m6eSJJFXcXxaU/3fQV
	wcbCAbqAFhqghJ69PeqOuU6Tr71ShcsAIJnSVREcmImOiFPYeM40IRYzIOQbeKiaT7jzlP
	JPkXcuKIoL+2Ezc8gi0HdC6lOA0u3RA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-qAPkEmRbPZ-S7r2O7bniBA-1; Fri, 09 Aug 2024 03:16:49 -0400
X-MC-Unique: qAPkEmRbPZ-S7r2O7bniBA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280a434147so12464955e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 00:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723187808; x=1723792608;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WjJJO1LczwWOlW0BQ8SK5TpK9dJIW736kg5IdhWodDY=;
        b=f492wkdkkQYkvuAzIcYh6ZUjHg8UwpykWr6r2YGyyzGFR8Wkh/dOkuaOH2c0SSS9tH
         1Y5i88sRoy/FHvneoCFAS46SG583vdvJHLGwUl1+t914VqTzzqFP/7RnjqyVokcOvAKE
         RCw8tvZ9LOhGddbtU741PzKhcXiakbkmNJkVKBURpQI2ecLyGPqbAI6w9mHbsouwGz6m
         Nz4lXTOG950EUZoGvMzd1F6Kdii8AeUp4ySGqxHkMQBc4lkQ/K72RSqTG9w09JQMNmvA
         uptazWTlnNj4fKJFdN+0vgJmx1bhnUQJMqCAHBeGBuCHYvD3GIChzVc1kNRZUuOsn6jo
         hA+g==
X-Forwarded-Encrypted: i=1; AJvYcCUIDNlvkh6MQyuOwAeLNJTacbY0W7+4/+uKUP3rGXRZ8ofR7aTyyb7VJidi543nMgO1fMnqP4A4I/YcDd1P5QlPPSJPsGpYLesZlcxL
X-Gm-Message-State: AOJu0YyZy68JyiCxkWuMmGtlaQUmfpF+VVKPPdXgZX5moCnA9OzOpFP5
	1jg3FONNstpXvs02syxQRuiuwmzxI5eSNPtipGkhwujd82P7hgsl2P0E0iQtuHSebf1yjNmemGB
	F1C/9cMXy97m1ZrL4mteg4ILUby0h3zwvaxuHl7Wh73y3Ips4J//O5xrTFi8heQ==
X-Received: by 2002:a05:6000:e4b:b0:367:998a:87b3 with SMTP id ffacd0b85a97d-36d5eb03f01mr486160f8f.28.1723187807895;
        Fri, 09 Aug 2024 00:16:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYvY502q8JsmqHlkzADp4PV0Gc7OtZMHC9oUZX9AXJME4HJH4mLRZPYW58VetBNsRszDx9zw==
X-Received: by 2002:a05:6000:e4b:b0:367:998a:87b3 with SMTP id ffacd0b85a97d-36d5eb03f01mr486144f8f.28.1723187807309;
        Fri, 09 Aug 2024 00:16:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71c:4e00:b097:7075:f6ba:300a? (p200300cbc71c4e00b0977075f6ba300a.dip0.t-ipconnect.de. [2003:cb:c71c:4e00:b097:7075:f6ba:300a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2718030bsm4371518f8f.50.2024.08.09.00.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 00:16:46 -0700 (PDT)
Message-ID: <de60f0e4-3ec6-4e33-a4bf-bb438ff1a0e3@redhat.com>
Date: Fri, 9 Aug 2024 09:16:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/4] mm: guest_memfd: Add ability for mmap'ing pages
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Fuad Tabba <tabba@google.com>,
 Patrick Roy <roypat@amazon.co.uk>, qperret@google.com,
 Ackerley Tng <ackerleytng@google.com>, linux-coco@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kvm@vger.kernel.org
References: <20240805-guest-memfd-lib-v1-0-e5a29a4ff5d7@quicinc.com>
 <20240805-guest-memfd-lib-v1-4-e5a29a4ff5d7@quicinc.com>
 <4cdd93ba-9019-4c12-a0e6-07b430980278@redhat.com>
 <20240806093625007-0700.eberman@hu-eberman-lv.qualcomm.com>
 <a7c5bfc0-1648-4ae1-ba08-e706596e014b@redhat.com>
 <20240808101944778-0700.eberman@hu-eberman-lv.qualcomm.com>
 <6f3b5c38-fc33-43cd-8ab7-5b0f49169d5c@redhat.com>
 <20240808151910630-0700.eberman@hu-eberman-lv.qualcomm.com>
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
In-Reply-To: <20240808151910630-0700.eberman@hu-eberman-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.08.24 00:26, Elliot Berman wrote:
> On Thu, Aug 08, 2024 at 11:55:15PM +0200, David Hildenbrand wrote:
>> On 08.08.24 23:41, Elliot Berman wrote:
>>> On Wed, Aug 07, 2024 at 06:12:00PM +0200, David Hildenbrand wrote:
>>>> On 06.08.24 19:14, Elliot Berman wrote:
>>>>> On Tue, Aug 06, 2024 at 03:51:22PM +0200, David Hildenbrand wrote:
>>>>>>> -	if (gmem_flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP) {
>>>>>>> +	if (!ops->accessible && (gmem_flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP)) {
>>>>>>>      		r = guest_memfd_folio_private(folio);
>>>>>>>      		if (r)
>>>>>>>      			goto out_err;
>>>>>>> @@ -107,6 +109,82 @@ struct folio *guest_memfd_grab_folio(struct file *file, pgoff_t index, u32 flags
>>>>>>>      }
>>>>>>>      EXPORT_SYMBOL_GPL(guest_memfd_grab_folio);
>>>>>>> +int guest_memfd_make_inaccessible(struct file *file, struct folio *folio)
>>>>>>> +{
>>>>>>> +	unsigned long gmem_flags = (unsigned long)file->private_data;
>>>>>>> +	unsigned long i;
>>>>>>> +	int r;
>>>>>>> +
>>>>>>> +	unmap_mapping_folio(folio);
>>>>>>> +
>>>>>>> +	/**
>>>>>>> +	 * We can't use the refcount. It might be elevated due to
>>>>>>> +	 * guest/vcpu trying to access same folio as another vcpu
>>>>>>> +	 * or because userspace is trying to access folio for same reason
>>>>>>
>>>>>> As discussed, that's insufficient. We really have to drive the refcount to 1
>>>>>> -- the single reference we expect.
>>>>>>
>>>>>> What is the exact problem you are running into here? Who can just grab a
>>>>>> reference and maybe do nasty things with it?
>>>>>>
>>>>>
>>>>> Right, I remember we had discussed it. The problem I faced was if 2
>>>>> vcpus fault on same page, they would race to look up the folio in
>>>>> filemap, increment refcount, then try to lock the folio. One of the
>>>>> vcpus wins the lock, while the other waits. The vcpu that gets the
>>>>> lock vcpu will see the elevated refcount.
>>>>>
>>>>> I was in middle of writing an explanation why I think this is best
>>>>> approach and realized I think it should be possible to do
>>>>> shared->private conversion and actually have single reference. There
>>>>> would be some cost to walk through the allocated folios and convert them
>>>>> to private before any vcpu runs. The approach I had gone with was to
>>>>> do conversions as late as possible.
>>>>
>>>> We certainly have to support conversion while the VCPUs are running.
>>>>
>>>> The VCPUs might be able to avoid grabbing a folio reference for the
>>>> conversion and only do the folio_lock(): as long as we have a guarantee that
>>>> we will disallow freeing the folio in gmem, for example, by syncing against
>>>> FALLOC_FL_PUNCH_HOLE.
>>>>
>>>> So if we can rely on the "gmem" reference to the folio that cannot go away
>>>> while we do what we do, we should be fine.
>>>>
>>>> <random though>
>>>>
>>>> Meanwhile, I was thinking if we would want to track the references we
>>>> hand out to "safe" users differently.
>>>>
>>>> Safe references would only be references that would survive a
>>>> private<->shared conversion, like KVM MMU mappings maybe?
>>>>
>>>> KVM would then have to be thought to return these gmem references
>>>> differently.
>>>>
>>>> The idea would be to track these "safe" references differently
>>>> (page->private?) and only allow dropping *our* guest_memfd reference if all
>>>> these "safe" references are gone. That is, FALLOC_FL_PUNCH_HOLE would also
>>>> fail if there are any "safe" reference remaining.
>>>>
>>>> <\random though>
>>>>
>>>
>>> I didn't find a path in filemap where we can grab folio without
>>> increasing its refcount. I liked the idea of keeping track of a "safe"
>>> refcount, but I believe there is a small window to race comparing the
>>> main folio refcount and the "safe" refcount.
>>
>> There are various possible models. To detect unexpected references, we could
>> either use
>>
>> folio_ref_count(folio) == gmem_folio_safe_ref_count(folio) + 1
>>
>> [we increment both ref counter]
>>
>> or
>>
>> folio_ref_count(folio) == 1
>>
>> [we only increment the safe refcount and let other magic handle it as
>> described]
>>
>> A vcpu could have
>>> incremented the main folio refcount and on the way to increment the safe
>>> refcount. Before that happens, another thread does the comparison and
>>> sees a mismatch.
>>
>> Likely there won't be a way around coming up with code that is able to deal
>> with such temporary, "speculative" folio references.
>>
>> In the simplest case, these references will be obtained from our gmem code
>> only, and we'll have to detect that it happened and retry (a seqcount would
>> be a naive solution).
>>
>> In the complex case, these references are temporarily obtained from other
>> core-mm code -- using folio_try_get(). We can minimize some of them
>> (speculative references from GUP or the pagecache), and try optimizing
>> others (PFN walkers like page migration).
>>
>> But likely we'll need some retry magic, at least initially.
>>
> 
> I thought retry magic would not fly. I'll try this out.

Any details why? At least the "other gmem code is currently taking a 
speculative reference" should be handable, these speculative references 
all happen from gmem code and it should be under our control.

We can protect against some core-mm speculative references (GUP, 
page-cache): after we allocated pages for gmem, and a RCU grace period 
passed, these can no longer happen from old context that previously had 
these pages allocated before gmem allocated them.

Other folio_try_get() users like memory offlining or page migration are 
more problematic. In general, the assumption is that they will give up 
quickly, for example when realizing that a folio is not LRU or non 
"non-lru-movable" -- which is the case for gmem-allocated pages.

Yes, no retry magic would be very much preferred, but as soon as we want 
to map these folios to user space and have GUP work on them (IOW, we 
have to make the folio refcount usable), we cannot easily block all 
speculative references from core-mm, for example, by freezing the 
refcount at 0. Long term, we might find ways to just block these 
speculative references more efficiently / differently.

-- 
Cheers,

David / dhildenb


