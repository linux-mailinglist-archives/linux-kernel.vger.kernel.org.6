Return-Path: <linux-kernel+bounces-269639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942D994352F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D81E7B22825
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800723C482;
	Wed, 31 Jul 2024 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFSEB7Mp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA383381A4
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722448283; cv=none; b=riCg+tMpXqUMuQTG566N8/DaupuvD6E5IbaRMNABWs2ZUgXhs1V+vfS3gZjR2G0YmdUPG2pr8VIq3aT8B2tRGPIOzmsTnS7qaMnix+6Ych1Rm/zhTTe4CpZmP2DZhgGGfpqBYn8iTNHjZwWfcVnA1OkJxsLLlMDb0gX8NsPHsA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722448283; c=relaxed/simple;
	bh=5+IMmDkvsOi4I1aSB72S7wEwZg5ODilucpMDJSlv7iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F3C31C1sVmPMitQxAUxeVbLkK9y3dYwmBEaa8paX8RtCR0UGMydOK32nUktQB1dizh2b+b5EgcxG5I+W0XIs71yMWsdVVQLVWr26///IgYPRLbfwbloi9ksxLXmvnt+I/uOeFwXCnB+HYW/TSGvj+C6yRyeBNWnFhiDoL9aND/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IFSEB7Mp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722448278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HkKQW92TBob03xYQLPasswxFJNWKudmGt3Ls39IwsLw=;
	b=IFSEB7MpFQTXapD9wD+WCD3T/J3Nqx64iHpemEhstAcZ7Axqlsg2drjCtMOtqU8di5rQCK
	V/+7nRWtlYzYwhHwuk4tzpjoOU4K/FaMQM+heGayJhDiEXEppXIcbp/HPUPLpyJiXGZo+B
	DByJaT3TJg+FmH268Fs5Gjy+1suV+bg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-UUlOCHwmNuGJwc8IwRzlxQ-1; Wed, 31 Jul 2024 13:51:17 -0400
X-MC-Unique: UUlOCHwmNuGJwc8IwRzlxQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5a7661b251aso6039511a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722448276; x=1723053076;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HkKQW92TBob03xYQLPasswxFJNWKudmGt3Ls39IwsLw=;
        b=AapAaWbp2c+XVjgsIKumsusjygkhQCBSWXLraU69QxqGfDRaFgCv8+LOHFR3MVSRwD
         lGuovyamiEgXKtjZrUn30BoZ9CuTfHKIodDALjaZUgCyO7XGUQ4UpV35GTp+0Ey/HiUA
         fu/vhSp1Q0qf6mHoRHQiwxPWMFQn6xrYBY1acniaGx6IKCYIq1wydlvRiS52SK4DefBM
         UaxTtfEc4mSLss8DjOBpzIBpLRpprt5uZyhBm09bkyGKPeaJZU1SNAH1eOGdcE3L8FBm
         YnoE5G3rUs6wiRJ9QYX9hR/XAnnWkdI14G3jzmGijJW816Mz8Bpgfry3rNepFN9oZ9S4
         JfCg==
X-Forwarded-Encrypted: i=1; AJvYcCVU+XXmhDEqa46Y3roI2DQyctq3ZOHb09EKF2bdIqap6+MXkHS9BTtGZv5EFHT1pwAEiewcFXAQz+ntZMBjECZnVpQI0+HjZWHzpKyN
X-Gm-Message-State: AOJu0YyoCAQrDeEdiAMMz9TcSpk+xLcfktkLzNN7qYMFKk9PzCt7lqep
	fC3ACIOzhecipkhIbibHvDgvtP0SKOzSPEMxb8Tyn1e5RkYRaBkoUtN+0B/vvr4A+Cqa70h8Z4N
	J6ogqvIc63tqpTnY3mQsz6nOUcmiR3dgLmJUSMjMJSXolU/Xi5UhMEkqPWe+CuA==
X-Received: by 2002:a50:c354:0:b0:5a1:c40a:3a81 with SMTP id 4fb4d7f45d1cf-5b022a96946mr9687534a12.35.1722448275842;
        Wed, 31 Jul 2024 10:51:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW5j5gLNyiWJpAEbuAQxK8i+uOvNMEfI0aTiFcQ+xUVuYYhUcHL91F+cUyVEICVSx22OUtag==
X-Received: by 2002:a50:c354:0:b0:5a1:c40a:3a81 with SMTP id 4fb4d7f45d1cf-5b022a96946mr9687513a12.35.1722448275171;
        Wed, 31 Jul 2024 10:51:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:5f00:9b61:28a2:eea1:fa49? (p200300cbc70b5f009b6128a2eea1fa49.dip0.t-ipconnect.de. [2003:cb:c70b:5f00:9b61:28a2:eea1:fa49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b52ab8f09dsm1911559a12.26.2024.07.31.10.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 10:51:14 -0700 (PDT)
Message-ID: <fc63e14d-8269-4db8-9ed2-feb2c5b38c6c@redhat.com>
Date: Wed, 31 Jul 2024 19:51:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] mm: split underutilized THPs
To: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <dc00a32f-e4aa-4f48-b82a-176c9f615f3e@redhat.com>
 <3cd1b07d-7b02-4d37-918a-5759b23291fb@gmail.com>
 <73b97a03-3742-472f-9a36-26ba9009d715@gmail.com>
 <95ed1631-ff62-4627-8dc6-332096e673b4@redhat.com>
 <01899bc3-1920-4ff2-a470-decd1c282e38@gmail.com>
 <4b9a9546-e97b-4210-979b-262d8cf37ba0@redhat.com>
 <64c3746a-7b44-4dd6-a51b-e5b90557a30a@gmail.com>
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
In-Reply-To: <64c3746a-7b44-4dd6-a51b-e5b90557a30a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31.07.24 19:01, Usama Arif wrote:
> 
> 
> On 30/07/2024 21:25, David Hildenbrand wrote:
>> On 30.07.24 19:22, Usama Arif wrote:
>>>
>>>
>>> On 30/07/2024 17:11, David Hildenbrand wrote:
>>>> On 30.07.24 17:19, Usama Arif wrote:
>>>>>
>>>>>
>>>>> On 30/07/2024 16:14, Usama Arif wrote:
>>>>>>
>>>>>>
>>>>>> On 30/07/2024 15:35, David Hildenbrand wrote:
>>>>>>> On 30.07.24 14:45, Usama Arif wrote:
>>>>>>>> The current upstream default policy for THP is always. However, Meta
>>>>>>>> uses madvise in production as the current THP=always policy vastly
>>>>>>>> overprovisions THPs in sparsely accessed memory areas, resulting in
>>>>>>>> excessive memory pressure and premature OOM killing.
>>>>>>>> Using madvise + relying on khugepaged has certain drawbacks over
>>>>>>>> THP=always. Using madvise hints mean THPs aren't "transparent" and
>>>>>>>> require userspace changes. Waiting for khugepaged to scan memory and
>>>>>>>> collapse pages into THP can be slow and unpredictable in terms of performance
>>>>>>>> (i.e. you dont know when the collapse will happen), while production
>>>>>>>> environments require predictable performance. If there is enough memory
>>>>>>>> available, its better for both performance and predictability to have
>>>>>>>> a THP from fault time, i.e. THP=always rather than wait for khugepaged
>>>>>>>> to collapse it, and deal with sparsely populated THPs when the system is
>>>>>>>> running out of memory.
>>>>>>>>
>>>>>>>> This patch-series is an attempt to mitigate the issue of running out of
>>>>>>>> memory when THP is always enabled. During runtime whenever a THP is being
>>>>>>>> faulted in or collapsed by khugepaged, the THP is added to a list.
>>>>>>>> Whenever memory reclaim happens, the kernel runs the deferred_split
>>>>>>>> shrinker which goes through the list and checks if the THP was underutilized,
>>>>>>>> i.e. how many of the base 4K pages of the entire THP were zero-filled.
>>>>>>>> If this number goes above a certain threshold, the shrinker will attempt
>>>>>>>> to split that THP. Then at remap time, the pages that were zero-filled are
>>>>>>>> not remapped, hence saving memory. This method avoids the downside of
>>>>>>>> wasting memory in areas where THP is sparsely filled when THP is always
>>>>>>>> enabled, while still providing the upside THPs like reduced TLB misses without
>>>>>>>> having to use madvise.
>>>>>>>>
>>>>>>>> Meta production workloads that were CPU bound (>99% CPU utilzation) were
>>>>>>>> tested with THP shrinker. The results after 2 hours are as follows:
>>>>>>>>
>>>>>>>>                                 | THP=madvise |  THP=always   | THP=always
>>>>>>>>                                 |             |               | + shrinker series
>>>>>>>>                                 |             |               | + max_ptes_none=409
>>>>>>>> -----------------------------------------------------------------------------
>>>>>>>> Performance improvement     |      -      |    +1.8%      |     +1.7%
>>>>>>>> (over THP=madvise)          |             |               |
>>>>>>>> -----------------------------------------------------------------------------
>>>>>>>> Memory usage                |    54.6G    | 58.8G (+7.7%) |   55.9G (+2.4%)
>>>>>>>> -----------------------------------------------------------------------------
>>>>>>>> max_ptes_none=409 means that any THP that has more than 409 out of 512
>>>>>>>> (80%) zero filled filled pages will be split.
>>>>>>>>
>>>>>>>> To test out the patches, the below commands without the shrinker will
>>>>>>>> invoke OOM killer immediately and kill stress, but will not fail with
>>>>>>>> the shrinker:
>>>>>>>>
>>>>>>>> echo 450 > /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none
>>>>>>>> mkdir /sys/fs/cgroup/test
>>>>>>>> echo $$ > /sys/fs/cgroup/test/cgroup.procs
>>>>>>>> echo 20M > /sys/fs/cgroup/test/memory.max
>>>>>>>> echo 0 > /sys/fs/cgroup/test/memory.swap.max
>>>>>>>> # allocate twice memory.max for each stress worker and touch 40/512 of
>>>>>>>> # each THP, i.e. vm-stride 50K.
>>>>>>>> # With the shrinker, max_ptes_none of 470 and below won't invoke OOM
>>>>>>>> # killer.
>>>>>>>> # Without the shrinker, OOM killer is invoked immediately irrespective
>>>>>>>> # of max_ptes_none value and kill stress.
>>>>>>>> stress --vm 1 --vm-bytes 40M --vm-stride 50K
>>>>>>>>
>>>>>>>> Patches 1-2 add back helper functions that were previously removed
>>>>>>>> to operate on page lists (needed by patch 3).
>>>>>>>> Patch 3 is an optimization to free zapped tail pages rather than
>>>>>>>> waiting for page reclaim or migration.
>>>>>>>> Patch 4 is a prerequisite for THP shrinker to not remap zero-filled
>>>>>>>> subpages when splitting THP.
>>>>>>>> Patches 6 adds support for THP shrinker.
>>>>>>>>
>>>>>>>> (This patch-series restarts the work on having a THP shrinker in kernel
>>>>>>>> originally done in
>>>>>>>> https://lore.kernel.org/all/cover.1667454613.git.alexlzhu@fb.com/.
>>>>>>>> The THP shrinker in this series is significantly different than the
>>>>>>>> original one, hence its labelled v1 (although the prerequisite to not
>>>>>>>> remap clean subpages is the same).)
>>>>>>>
>>>>>>> As shared previously, there is one issue with uffd (even when currently not active for a VMA!), where we must not zap present page table entries.
>>>>>>>
>>>>>>> Something that is always possible (assuming no GUP pins of course, which) is replacing the zero-filled subpages by shared zeropages.
>>>>>>>
>>>>>>> Is that being done in this patch set already, or are we creating pte_none() entries?
>>>>>>>
>>>>>>
>>>>>> I think thats done in Patch 4/6. In function try_to_unmap_unused, we have below which I think does what you are suggesting? i.e. point to shared zeropage and not clear pte for uffd armed vma.
>>>>>>
>>>>>>       if (userfaultfd_armed(pvmw->vma)) {
>>>>>>           newpte = pte_mkspecial(pfn_pte(page_to_pfn(ZERO_PAGE(pvmw->address)),
>>>>>>                              pvmw->vma->vm_page_prot));
>>>>>>           ptep_clear_flush(pvmw->vma, pvmw->address, pvmw->pte);
>>>>>>           set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
>>>>>>       }
>>>>>
>>>>>
>>>>> Ah are you suggesting userfaultfd_armed(pvmw->vma) will evaluate to false even if its uffd? I think something like below would work in that case.
>>>>
>>>> I remember one ugly case in QEMU with postcopy live-migration where we must not zap zero-filled pages. I am not 100% regarding THP (if it could be enabled at that point), but imagine the following
>>>>
>>>> 1) mmap(), enable THP
>>>> 2) Migrate a bunch of pages from the source during precopy (writing to
>>>>      the memory). Might end up creating THPs (during fault/khugepaged)
>>>> 3) Register UFFD on the VMA
>>>> 4) Disable new THPs from forming via MADV_NOHUGEPAGE on the VMA
>>>> 5) Discard any pages that have been re-dirtied or not migrated yet
>>>> 6) Migrate-on-demand any holes using uffd
>>>>
>>>>
>>>> If we discard zero-filled pages between 2) and 3) we might get wrong uffd notifications in 6 for pages that have already been migrated).
>>>>
>>>> I'll have to check if that actually happens in that sequence in QEMU: if QEMU would disable THP right before 2) we would be safe. But I recall that it is not the case :/
>>>>
>>>>
>>>
>>> Thanks for the example!
>>>
>>> Just to understand the issue better, as I am not very familiar with live-migration code, the problem is only for zero-filled pages that were migrated, right? If a THP is created and a subpage of it was a zero-page that was migrated and its split before VMA is armed with uffd, userfaultfd_armed(pvmw->vma) will return false when splitting and it will become pte_none. And afterwards when the destination faults on it, uffd will see that its pte_clear and will request the zero-page back from source. Uffd will then have to get the page again from source.
>>
>> Something like that, but I recall that if it detects that it already migrated the page stuff will go wrong.
>>
>> IIRC QEMU maintains receive bitmaps about which pages it already received+placed. Staring at migrate_send_rp_req_pages(), QEMU ignores the uffd notification if it finds that the page was already received and would not ask the source again.
>>
>> So if we turn some PTEs that map zeroed-pages into pte-none we could run into trouble, because we will never try requesting/placing that page again and our VM will just be stuck forever.
>>
>> I wonder if other uffd users could similarly be affected. But maybe they don't place pages into the VMA before registering uffd.
>>
>> I'll try to double-check when QEMU would disable THP. But it could also be that that behavior changed between QEMU versions.
>>
>>>
>>> If I understand the example correctly, the below diff over patch 6 should be good? i.e. just point to the empty_zero_page instead of doing pte_clear. This should still use the same amount of memory, although ptep_clear_flush means it might be slighly more expensive.
>>
>> There are rare cases where we must not use the shared zeropage (mm_forbids_zeropage()), that must be handled.
>>
>> I assume we could optimize here if uffd is not configured in. Further, what QEMU does is sense right at the beginning by temporarily registering uffd on some other VMA if it is even supported. That could be used as an indication ("ever used uffd -> don't turn PTEs none"). But again, no idea what other uffd users might be relying on :/
>>
>> In I wonder if some applications could rely on anon memory not suddenly "vanishing" form the PTEs (for example relying on pagemap like tools/testing/selftests/mm/cow.c) would. I don't think a lot of applications would do that, though.
>>
> 
> 
> I had a deeper look at how QEMU handles migration and at how kernel handles THPs in other places with respect to uffd. I hope I understood the migration code correctly :)
> 
> QEMU:
> There are 2 types of "migrations" [1], migration_thread and bg_migration_thread
> - migration_thread supports postcopy live migration, but doesn't use uffd. So postcopy live migration doesn't use uffd as far as I can tell looking at the function [2].
> - bg_migration_thread [3]: this isn't really live migration, but background snapshot. There is no postcopy and it works similar to pre-copy. From what I understand, uffd is registered before any pages are migrated [4].
> 

Ignore the second. What QEMU ends up using is precopy + postcopy. You 
can start precopy migration and decide at some point that you want to 
switch to postcopy (this is what I trigger below, let me know if you 
want a simple way to reproduce it).

> So the way these 2 threads work in qemu is: its either postcopy without uffd, or precopy-style snapshot with uffd registered at the start, then the current patch in this series is good, i.e. only use zeropage if userfaultfd_armed(pvmw->vma), otherwise pte_clear. I can't see postcopy with uffd anywhere in qemu which doesn all the steps 1-6 that you mentioned above, but I might not be looking at the right place?

"I can't see postcopy with uffd anywhere" -- most of it lives in 
migration/postcopy-ram.c.

See postcopy_ram_incoming_setup() where most of the UFFD setup logic 
happens.

> 
> Kernel:
>  From a kernel perspective, if we look at khugepaged [5], it just takes into account if the vma is currently registered as uffd. So maybe this scenario can happen?
> 1) THP is enabled on VMA, UFFD is not yet registered.
> 2) dest accesses a 4K page (lets call it 4Kpage1), khugepaged collapses that page into 2M THP as the following 511 4K pages were pte_none [5], as VMA is not uffd armed yet.
> 3) UFFD is registered + MADV_NOHUGEPAGE is set. No further collapse will happen, but the THPs that were created in step 2 will remain. MADV_NOHUGEPAGE doesn't split existing THP created in 2.
> 4) dest tries to access 4Kpage2, the address right after 4Kpage1. As khugepaged collapsed it, there won't be a pagefault, and dest will read it as a zero-filled page, even if UFFD handler wanted to give some non-zero data filled page. I think anyone who wrote the uffd handler would want there to be a pagefault and give the non-zero data filled page and would not expect dest to see a zero-filled page.
> 
> What I am trying to say with the above example is:
> - UFFD registeration + MADV_NOHUGEPAGE should be done by all applications before any data in the region is accessed. Using THPs and accessing data before UFFD registeration + MADV_NOHUGEPAGE can lead to unexpected behaviour and is wrong?

The important point here is that you discard (MADV_DONTNEED) any pages 
you want to fault+place later lazily. That must happen after 
MADV_NOHUGEPAGE but before registering+running userfaultfd.

Then you don't care if page faults / kuhgepaged gave you THPs before 
that. In fact, you want to happily use THPs wherever possible and not
disable them unconditionally right from the start.

> - even in the current kernel code in other places like khugepaged, its only checked if uffd is enabled currently. It is not tracked if it was ever enabled on any VMA.

Right, see above, this all works if you MADV_DONTNEED the pages you want 
to get faults to after disabling THPs.


I just added a bunch of quick printfs to QEMU and ran a precopy+postcopy 
live migration. Looks like my assumption was right:

On the destination:

Writing received pages during precopy # ram_load_precopy()
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy 

Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Writing received pages during precopy
Disabling THP: MADV_NOHUGEPAGE # postcopy_ram_prepare_discard()
Discarding pages # loadvm_postcopy_ram_handle_discard()
Discarding pages
Discarding pages
Discarding pages
Discarding pages
Discarding pages
Discarding pages
Registering UFFD # postcopy_ram_incoming_setup()


Let me know if you need more information.

> Thanks for pointing to mm_forbids_zeropage. Incorporating that into the code, and if I am (hopefully :)) right about qemu and kernel above, then I believe the right code should be:

I'm afraid you are not right about the qemu code :)

> 
> 	if (userfaultfd_armed(pvmw->vma) && mm_forbids_zeropage(pvmw->vma->vm_mm))
> 		return false;
> 
> 	if (!userfaultfd_armed(pvmw->vma)) {
> 		pte_clear_not_present_full(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, false);
> 	} else {
> 		newpte = pte_mkspecial(pfn_pte(page_to_pfn(ZERO_PAGE(pvmw->address)),
> 					       pvmw->vma->vm_page_prot));
> 		ptep_clear_flush(pvmw->vma, pvmw->address, pvmw->pte);
> 		set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
> 	}
>   
> 
> 
> [1] https://github.com/qemu/qemu/blob/4e56e89d6c81589cc47cf5811f570c67889bd18a/migration/migration.c#L3817
> [2] https://github.com/qemu/qemu/blob/4e56e89d6c81589cc47cf5811f570c67889bd18a/migration/migration.c#L3455
> [3] https://github.com/qemu/qemu/blob/4e56e89d6c81589cc47cf5811f570c67889bd18a/migration/migration.c#L3591
> [4] https://github.com/qemu/qemu/blob/4e56e89d6c81589cc47cf5811f570c67889bd18a/migration/migration.c#L3675
> [5] https://github.com/torvalds/linux/blob/master/mm/khugepaged.c#L1307
> 
> 
> 

-- 
Cheers,

David / dhildenb


