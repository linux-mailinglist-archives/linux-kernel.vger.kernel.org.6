Return-Path: <linux-kernel+bounces-241158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 021B49277A6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA280286917
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57811AEFC3;
	Thu,  4 Jul 2024 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiO12IlS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684282F37
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101722; cv=none; b=YjY5HhgAxsGf3gYEaGrWNLDJltcHgnGV0T/Yroprc99ATXfXztg57OUUWsP8FXx3+k2jNCTiAThRgHI5XL2ysjrEo8sXzXUJrjxSIUIJthmo8m91RALMqVsgBCXP+/amjOM1IDCHvO2K63uBBS8epaCNjpG6u/GWn4iYrpU08B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101722; c=relaxed/simple;
	bh=tXs40RkUPU9MgEkVuQ/+eDd2bXv7Kl4yuojJamwKrkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUD9fpa/ClrjR7nNt5ePxJ+A1fGFVDl4l7m3Hkt7LZbiWL8bQudRBq6TE1JEgyq3ck9fsCCJXIxZ8UJv/D2MA3DxnGgcMqzRGuGabSsHAS0wD5kIg0TZT0pe2n00SUpDtSNaQ7szaEcCdTNDnhfxiZBa8XdpLeokAK21/5FUrq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GiO12IlS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720101719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=88tDGw0lvfCvEqqU6cpCNtQ9t7rNAK6rugjju/WdUSc=;
	b=GiO12IlSDvKEV366LT16IMmw2gXsmwj3AjrOyp2mpxclFEl746xSKQE7MTJayr2OJcSOIi
	SAx0DQ7GaFUCfUUB0iy85oxY9xFvd8I4V2yEcpsmUvs8O09qNL9ZRtCIt5uZlIJojOFi/4
	7rEWP2wcGTH/oQhaQLeXc9Pp1kEbFy0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-nnCtgcnSO1KY2RhNPoJdcA-1; Thu, 04 Jul 2024 10:01:58 -0400
X-MC-Unique: nnCtgcnSO1KY2RhNPoJdcA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4256809ae27so4531325e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 07:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720101717; x=1720706517;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=88tDGw0lvfCvEqqU6cpCNtQ9t7rNAK6rugjju/WdUSc=;
        b=wIVy6ohLB7inbdmK6/EoRlmL2FZPxsRHVxgAPxe+q/KhlpbJY8dgwmNsYNAPabWNmE
         MZsXBdlYUa05WsPk+Y+80lJyQc81fq52THuanIkrVVdtxXMSuHULZd59lrUQOvdan5uu
         qBusv7/mQaCq1QDhZsChS6b865oigPUof3Ohv2uya/uHXA80lZ23O9og0+xF6BaqOtBF
         +xrk4twdsA6AK2Sy7xx4pSLJgPQFACUaqz/8IXM99F90mNukz2LkejfdY4dkybdWhfTz
         jkbs0YfZSsxZbCTR4GD0/hk3lpDENpda02KdIVUMrY80vli60IEqjNPVV37Jc+ok62nJ
         iDnA==
X-Forwarded-Encrypted: i=1; AJvYcCX5mrz67/6KY/lsLwIgFFyR/M8D/GtTovViKWYYZg50HDAtYflyKHYvTJWzO7am2WaTR+l1yOhWqEDuPp4Ugi+JEDgvWmJFq9qFe29M
X-Gm-Message-State: AOJu0YzeoVQnRoAE0y/UgSQng8ETtJop+uXh7EQHqCP8t5ZxRIhz9DWg
	zpWpBg18ygZ9hkwQQ6hSJEZYrCySpCJ7LBwhh6ImNksLbLVHv3KwKuvm/5/oQKWOApNGWc46iZ2
	AKYAD4s6leQU9tafkt8chN+B3pPsp09I8aphkB1s7L057kFfTymYkmBuUt/FEsw==
X-Received: by 2002:a05:600c:6dd9:b0:425:78a9:b3cc with SMTP id 5b1f17b1804b1-4264a3e76c8mr14444215e9.17.1720101716905;
        Thu, 04 Jul 2024 07:01:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt7+R5Ll1HHYZlKdhlvsRJnkI27w9SfajWwIq0NEZ/kcpKH3Li8qi5hSS5cLEpOjwFHf5sBg==
X-Received: by 2002:a05:600c:6dd9:b0:425:78a9:b3cc with SMTP id 5b1f17b1804b1-4264a3e76c8mr14443915e9.17.1720101716389;
        Thu, 04 Jul 2024 07:01:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:8600:f05d:97b6:fb98:2bc1? (p200300cbc7158600f05d97b6fb982bc1.dip0.t-ipconnect.de. [2003:cb:c715:8600:f05d:97b6:fb98:2bc1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d510bsm26214875e9.3.2024.07.04.07.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 07:01:55 -0700 (PDT)
Message-ID: <a48becbf-ff89-4413-a0ba-b13fa006574b@redhat.com>
Date: Thu, 4 Jul 2024 16:01:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] mm: shmem: add mTHP support for anonymous shmem
To: Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com, ying.huang@intel.com,
 21cnbao@gmail.com, shy828301@gmail.com, ziy@nvidia.com, ioworker0@gmail.com,
 da.gomez@samsung.com, p.raghav@samsung.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <65796c1e72e51e15f3410195b5c2d5b6c160d411.1718090413.git.baolin.wang@linux.alibaba.com>
 <65c37315-2741-481f-b433-cec35ef1af35@arm.com>
 <475332ea-a80b-421c-855e-a663d1d5bfc7@linux.alibaba.com>
 <b33b94bb-38c7-4b54-bdd3-51dec0535438@arm.com>
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
In-Reply-To: <b33b94bb-38c7-4b54-bdd3-51dec0535438@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.07.24 15:58, Ryan Roberts wrote:
> On 04/07/2024 12:15, Baolin Wang wrote:
>>
>>
>> On 2024/7/4 01:25, Ryan Roberts wrote:
>>> On 11/06/2024 11:11, Baolin Wang wrote:
>>>> Commit 19eaf44954df adds multi-size THP (mTHP) for anonymous pages, that
>>>> can allow THP to be configured through the sysfs interface located at
>>>> '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
>>>>
>>>> However, the anonymous shmem will ignore the anonymous mTHP rule
>>>> configured through the sysfs interface, and can only use the PMD-mapped
>>>> THP, that is not reasonable. Users expect to apply the mTHP rule for
>>>> all anonymous pages, including the anonymous shmem, in order to enjoy
>>>> the benefits of mTHP. For example, lower latency than PMD-mapped THP,
>>>> smaller memory bloat than PMD-mapped THP, contiguous PTEs on ARM architecture
>>>> to reduce TLB miss etc. In addition, the mTHP interfaces can be extended
>>>> to support all shmem/tmpfs scenarios in the future, especially for the
>>>> shmem mmap() case.
>>>>
>>>> The primary strategy is similar to supporting anonymous mTHP. Introduce
>>>> a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
>>>> which can have almost the same values as the top-level
>>>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
>>>> additional "inherit" option and dropping the testing options 'force' and
>>>> 'deny'. By default all sizes will be set to "never" except PMD size,
>>>> which is set to "inherit". This ensures backward compatibility with the
>>>> anonymous shmem enabled of the top level, meanwhile also allows independent
>>>> control of anonymous shmem enabled for each mTHP.
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>
>>> [...]
>>>
>>> Hi Baolin,
>>>
>>> I'm currently trying to fix a bug where khugepaged is not started if only shmem
>>> is enabled for THP. See discussion at [1]. It's been broken like this forever.
>>>
>>> Assuming anon and shmem THP are initially both disabled:
>>>
>>> # echo never > /sys/kernel/mm/transparent_hugepage/shmem_enabled
>>> # echo never > /sys/kernel/mm/transparent_hugepage/enabled
>>> <khugepaged is stopped here>
>>>
>>> Then shemem THP is enabled:
>>>
>>> # echo always > /sys/kernel/mm/transparent_hugepage/shmem_enabled
>>> <khugepaged is not started, this is a bug>
>>
>> Thanks Ryan. Yes, this is a real problem.
>>
>>> As part of investigating the fix, I stumbled upon this patch, which I remember
>>> reviewing an early version of but I've been out for a while and missed the
>>> latter versions. See below for comments and questions; the answers to which will
>>> help me figure out how to fix the above...
>>>
>>> [1]
>>> https://lore.kernel.org/linux-mm/20240702144617.2291480-1-ryan.roberts@arm.com/
>>>
>>>
>>>>    +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>> +static unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>>> +                struct vm_area_struct *vma, pgoff_t index,
>>>> +                bool global_huge)
>>>> +{
>>>> +    unsigned long mask = READ_ONCE(huge_shmem_orders_always);
>>>> +    unsigned long within_size_orders =
>>>> READ_ONCE(huge_shmem_orders_within_size);
>>>> +    unsigned long vm_flags = vma->vm_flags;
>>>> +    /*
>>>> +     * Check all the (large) orders below HPAGE_PMD_ORDER + 1 that
>>>> +     * are enabled for this vma.
>>>> +     */
>>>> +    unsigned long orders = BIT(PMD_ORDER + 1) - 1;
>>>> +    loff_t i_size;
>>>> +    int order;
>>>> +
>>>> +    if ((vm_flags & VM_NOHUGEPAGE) ||
>>>> +        test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>>>> +        return 0;
>>>> +
>>>> +    /* If the hardware/firmware marked hugepage support disabled. */
>>>> +    if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
>>>> +        return 0;
>>>> +
>>>> +    /*
>>>> +     * Following the 'deny' semantics of the top level, force the huge
>>>> +     * option off from all mounts.
>>>> +     */
>>>> +    if (shmem_huge == SHMEM_HUGE_DENY)
>>>> +        return 0;
>>>
>>> I don't quite get this, I don't think its the desirable behaviour. This is
>>> saying that if the top-level shemem_enabled control is set to 'deny', then all
>>> mTHP sizes, regardless of their control's setting are disabled?
>>>
>>> The anon controls don't work like that; you can set the top-level control to
>>> anything you like, but its only consumed if the per-size controls are
>>> inheriting it.
>>
>> IMO, 'deny' option is not similar like 'never' option.
>>
>>>
>>> So for the deny case, wouldn't it be better to allow that as an option on all
>>> the per-size controls (and implicitly let it be inherrited from the top-level)?
>>
>>  From 'deny' option's semantics:
>> "disables huge on shm_mnt and all mounts, for emergency use;"
> 
> Right. Today, tmpfs only supports PMD-sized THP. So for all per-size controls
> except the PMD-size control, 'deny' and 'never' would be the same practically
> speaking. For the PMD-size control, 'deny' would disable THP for both anon shmem
> and all tmpfs mounts, whereas 'never' would only disable THP for anon shmem.
> When tmpfs gains mTHP support, 'deny' in the other per-size controls would also
> disable that size for the tmpfs mounts.
> 
> I disagree with the current implementation where setting it up so that a
> top-level 'deny' overrides whatever is in the per-size controls simply because
> it's different to the model implemented for anon THP. That's my 2 cents. If
> nobody else agrees then that ok - I'll fix the above bug according to the
> current model.

IIRC, Hugh said that deny+force are rather legacy artifacts that we 
don't want on sub-controls (and likely we cannot remove them). I agree 
they shouldn't overwrite other toggles. The models we used should better 
match.

-- 
Cheers,

David / dhildenb


