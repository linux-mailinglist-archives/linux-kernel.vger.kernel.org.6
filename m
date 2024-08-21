Return-Path: <linux-kernel+bounces-296207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 798E995A7A3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054251F22228
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 22:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A521779BD;
	Wed, 21 Aug 2024 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhxW09iB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39DD79D1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724278266; cv=none; b=FYOyPCGUugYyHx7OMoGb/IIG3c3+6l247nImgdpgSspUUhKclkRaf9v2wT14VxU1wmaFGhI2xrXc8SqmvbsTFjfzJn7R0uVsoFDJesMuOX/dT2QIzTA3jmVBgO5gof2Jo+JOijQjoeNF50tKOVTaYM8JArW5ft+RM882UUBFpUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724278266; c=relaxed/simple;
	bh=p9qLfm6Gjg/oZvmMEhXDDkZ4Y9Mx8uU4mAqI3QYkZ9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pkfaGOoeCa7IDtem+YW1GMhB1bM42Aq0dqU7lK3qJDFNkKJ9UbXnshfYpAbXG6iruNWCurjqzTfDrXN/7NrZm4UkvZVweeMrCDQ/S+iTt7HdbhbkBi8k95ACnvEpqff7QOsiN0UAMjDS5K4cBUNfX5g1TO30IH7Gn2s8SEvKzso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhxW09iB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724278263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4C6IPY41QjQyfxamoEtFU55HAv1LSBDkPc6d1+SI6CU=;
	b=UhxW09iBTcWmcOtAEO5C38HrMMxWIaGqeutnNaAPW+C4LQ0DfNX/zacnqITcwrf1EuKSTZ
	ZiY7l90UaJOG0DpuKs2QTyhAc5WivLVPLMkcrXrl6XD71PoZ5ew9Etz1+h5mgBqIFdTDl+
	U7frytDiK+HVsdoiAJhdzWe4oLOrCbA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-C-dJJNHkOyugeWc4DdGPkQ-1; Wed, 21 Aug 2024 18:11:02 -0400
X-MC-Unique: C-dJJNHkOyugeWc4DdGPkQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428fb72245bso541365e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724278261; x=1724883061;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4C6IPY41QjQyfxamoEtFU55HAv1LSBDkPc6d1+SI6CU=;
        b=P/D8CCtS+uz1sw+WNnK+jPnB0qy1A3tJAlc1kj5qQ4rehXdCPgXWpKsEuDNcfme8he
         LQ1z6jY+dT8j0jvJJqoOQ1Tb6cE4rp1vtuXFk0MNTmtBrsVvEpKVohospAdAG+QILUQp
         hORJI0mGZxlgEFS4cFc7SlfOku0czgn8gXF9adbv/i81Wa+DH/jG6OfyqE1+Tc4lQc9z
         Xvm2OgY7U+TQ+UjlglucaNMG0vrZxvXgskSnCvyJixbUktIggRciMVQOVKpKRJFsgqAt
         HE/XFAohWo6gPZtd+8KwsXZitMfWjno839idoz7ptUfj3gC87ZLyzcb566XUt6S8Xv1t
         S9Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWmyv+XyMJ7IgzDFCJfFIoEAlRBIhXPJ57tLmO2SE7vz7Qq1zRWa5iqIEk6Wmi2sHkeH21SEMDkZrF0DC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2lIp750FlQKmN1Mf4/dB+oAQJZ/e4LgNymJVObYt/+SDVaAPQ
	V+aqn5thsR/tvayP5xUDISqMSMMMtADLPXsBx8nm0EaXKWS3iPIRYlfMwcBunqndHLmpyullE/A
	EwNoIGNACoFG24wzGDmDZToi66G+cRt6G8wuKw6Pl5V/7OgXnbk25tkVQHtlAdQ==
X-Received: by 2002:a05:600c:3b13:b0:426:526f:4a1f with SMTP id 5b1f17b1804b1-42ac38c7c13mr5129635e9.16.1724278261258;
        Wed, 21 Aug 2024 15:11:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3qs5flbuwzfZzhE697TlriPivymU4U833EaKMKvrJ+X2rrFmyp24vAau8qXdUtGIcvMprJw==
X-Received: by 2002:a05:600c:3b13:b0:426:526f:4a1f with SMTP id 5b1f17b1804b1-42ac38c7c13mr5129395e9.16.1724278260361;
        Wed, 21 Aug 2024 15:11:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:4300:16d5:c5b:8388:a734? (p200300cbc705430016d50c5b8388a734.dip0.t-ipconnect.de. [2003:cb:c705:4300:16d5:c5b:8388:a734])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730815c0f0sm74928f8f.51.2024.08.21.15.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 15:10:59 -0700 (PDT)
Message-ID: <2ed6c403-b7a4-4e03-92f3-7debd05d965a@redhat.com>
Date: Thu, 22 Aug 2024 00:10:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm: collect the number of anon large folios on
 split_deferred list
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com,
 ioworker0@gmail.com, kaleshsingh@google.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, ryan.roberts@arm.com, v-songbaohua@oppo.com,
 ziy@nvidia.com, yuanshuai@oppo.com, Usama Arif <usamaarif642@gmail.com>
References: <20240811224940.39876-1-21cnbao@gmail.com>
 <20240811224940.39876-3-21cnbao@gmail.com>
 <6c01b794-7c51-4d90-a215-210ac21401d2@redhat.com>
 <CAGsJ_4x4ngLS4kW-e7_DTykZSAmk3DeQ6CuZ4zGEiGBd99fbrw@mail.gmail.com>
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
In-Reply-To: <CAGsJ_4x4ngLS4kW-e7_DTykZSAmk3DeQ6CuZ4zGEiGBd99fbrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.08.24 00:01, Barry Song wrote:
> On Thu, Aug 22, 2024 at 5:39 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 12.08.24 00:49, Barry Song wrote:
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> When an mTHP is added to the deferred_list, its partial pages
>>> are unused, leading to wasted memory and potentially increasing
>>> memory reclamation pressure.
>>>
>>> Detailing the specifics of how unmapping occurs is quite difficult
>>> and not that useful, so we adopt a simple approach: each time an
>>> mTHP enters the deferred_list, we increment the count by 1; whenever
>>> it leaves for any reason, we decrement the count by 1.
>>>
>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>> ---
>>>    Documentation/admin-guide/mm/transhuge.rst | 5 +++++
>>>    include/linux/huge_mm.h                    | 1 +
>>>    mm/huge_memory.c                           | 6 ++++++
>>>    3 files changed, 12 insertions(+)
>>>
>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>>> index 9fdfb46e4560..7072469de8a8 100644
>>> --- a/Documentation/admin-guide/mm/transhuge.rst
>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>>> @@ -532,6 +532,11 @@ nr_anon
>>>           These huge pages could be entirely mapped or have partially
>>>           unmapped/unused subpages.
>>>
>>> +nr_split_deferred
>>> +       the number of anon huge pages which have been partially unmapped
>>> +       and put onto split queue. Those unmapped subpages are also unused
>>> +       and temporarily wasting memory.
>>
>> The name suggests something else ... like a counter of how many have
>> been deferred split :)
>>
>> Would "nr_anon_partially_mapped" "nr_anon_split_pending" (or something
>> less mouthful) be clearer?
>>
>> (likely "anon" really should be part of the name in any case)
>>
>> The name we chose (and the implied semantics) will likely have
>> implications on the handling of Usamas series.
>>
> 
> Hi David,
> 
> Your point is quite similar to my V1, though not exactly the same. I aimed to
> make the name more meaningful for users.
> https://lore.kernel.org/all/20240808010457.228753-3-21cnbao@gmail.com/
> 
> Ryan felt that the name should be consistent with the existing split_deferred.
> https://lore.kernel.org/all/36e8f1be-868d-4bce-8f32-e2d96b8b7af3@arm.com/#t

Right, it's an increasing counter of how often we added something to the 
deferred split queue. It's more like a low-level primitive, although 
currently only used for one reason (anon + partial mapping).

> 
> It seems that the existing split_deferred may now be less optimal with
> Usama's series, as entirely_mapped folios might also be on the list.

Yes.

> 
> Ryan is out right now, but I suppose he will be convinced that
> "nr_anon_partially_mapped" is probably a better name once
> he returns and reviews Usama's series. :-)

Maybe ;) At least it's clear from the name what we are talking about.

-- 
Cheers,

David / dhildenb


