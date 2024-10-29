Return-Path: <linux-kernel+bounces-386911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E04649B498C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE9C1F23651
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C38205E24;
	Tue, 29 Oct 2024 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CovoGUxj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5088BEA
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730204466; cv=none; b=oDd5V+QZRniSMqr0EWrEbw1pbrWSWBvJq6PbvL/gxvOf8qmTl/6KYSeqgew83zVr8+WDarUuX78DHU0Rw0H8ChX3QZJg1s1cK9SmmWbImBaqtVoiszv8RFkYokzvAVlxjmY9GUT058KobUfTmW/5q+XOQAfQBRZ8TpOjjVC+Wc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730204466; c=relaxed/simple;
	bh=4phbkHWXMdsk5mbRLkM1PILpFb76hqilv3pu2vFatSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCsHArvs8UIvz1fpX9XF40h1QhZb+Pg/zhSqmM8WdI0Lk6vOGMmr9q/4UJhXZd7GLdbQ+oM05Z6l7T74+yay63+eLB5nG0YC4aoFcyH/QGqYus6S5zoFCgY/cDaF/o5quI6mmevbBgjE61UjbLq3LeTyVaX1ZnjeammHiTYrVoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CovoGUxj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730204462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gPPs0+CUPj5G4mr0G9qtS6gLC/HhMtUnQLQJptozAAA=;
	b=CovoGUxjaKqaIluGQMAgYoiRu3ofcMXmq9Tojo96oa0055q6haVOhKAhzuHeytj1EyO2cQ
	G194yGMO7pefaprp3Y1S2TOMenNAriRWHvSJdKx0MKzYMtru0LxlktkzXISnPvOemyHko0
	QB5PFCqS++UKVSL3eRyBy1Dz1UuK/zI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-F-Dvs9SSOzSVCxqFvXS7rA-1; Tue, 29 Oct 2024 08:21:00 -0400
X-MC-Unique: F-Dvs9SSOzSVCxqFvXS7rA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d563a1af4so2621795f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 05:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730204458; x=1730809258;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gPPs0+CUPj5G4mr0G9qtS6gLC/HhMtUnQLQJptozAAA=;
        b=QW0bSs/KfzQT1NiAfSlPKfKsjzM1r8hISgnzFske4SAPpavyFi0JaGGbWALzpJPoqH
         gChTocy/BgGxmJAq6+dYyyV1nSyiJ0SecnC9RJMcZ/NRDBYfwlHbICcS8WyAO77+gqa4
         GmTy6ImXByUHITBUs2pMhv9YVnW8b6cyL3sC18crWC9s+cnYK+BvRgN96XZ7O0X0jL56
         +JNuiRLLVEIET7UiOTLFJQoExGKDuCGVPB78peMVI3/NDaF4A0pwZR93DUiLjEKE06VA
         lBUvHr/6fQKuV9QTeG/AGzTSIBeU7qJqfZyV8SkpLV4TgPDHW+GxNzg3uz7W5o0KkQPo
         B2yg==
X-Forwarded-Encrypted: i=1; AJvYcCXq12oWlW6iU9Ix1JoDnl9OB1AmObDtOR7+mNiX+OxK8DeEQh0asoBCaVStJ7GKJ5CJ9k0EuFX2FXhFYgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6LM8/iqmFnUI8jZHqndUZUUtC4bICXpXe3O7NI7U9/YZ8tT4D
	dd90GjWETE0I0LiminA9//XjgvPV+pP4mwArJ2XlGmTGTjk+JziIcmn3i6YGCOgoWM/dkzZB90V
	UNzrCtELYBIFIPMX2rpmpWUchVCRrZFlE5vOUdOzY5IjpuearkDie4V/VaccfijinAeX8tA==
X-Received: by 2002:adf:e58f:0:b0:37c:babe:2c49 with SMTP id ffacd0b85a97d-38061128ef1mr7604530f8f.19.1730204457934;
        Tue, 29 Oct 2024 05:20:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJbMMeDjIu1DI5jNTZEhmaFaxxbUnwOb2nMscklDaVJq5aebRKgtU65pH7ernvrB290cCtgg==
X-Received: by 2002:adf:e58f:0:b0:37c:babe:2c49 with SMTP id ffacd0b85a97d-38061128ef1mr7604507f8f.19.1730204457422;
        Tue, 29 Oct 2024 05:20:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72d:8500:d87a:ed8e:1e80:5a7e? (p200300cbc72d8500d87aed8e1e805a7e.dip0.t-ipconnect.de. [2003:cb:c72d:8500:d87a:ed8e:1e80:5a7e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b47f6fsm12331687f8f.50.2024.10.29.05.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 05:20:56 -0700 (PDT)
Message-ID: <f4d0f763-f679-4885-994d-def2831d2448@redhat.com>
Date: Tue, 29 Oct 2024 13:20:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
To: Daniel Gomez <d@kruces.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Daniel Gomez <da.gomez@samsung.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
 hughd@google.com, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
 <Zw_IT136rxW_KuhU@casper.infradead.org>
 <e1b6fa05-019c-4a40-afc0-bc1efd15ad42@linux.alibaba.com>
 <6dohx7zna7x6hxzo4cwnwarep3a7rohx4qxubds3uujfb7gp3c@2xaubczl2n6d>
 <8e48cf24-83e1-486e-b89c-41edb7eeff3e@linux.alibaba.com>
 <CGME20241021085439eucas1p10a0b6e7c3b0ace3c9a0402427595875a@eucas1p1.samsung.com>
 <ppgciwd7cxmeqssryshe42lxwb4sdzr6gjhwwbotw4gx2l7vi5@7y4hedxpf4nx>
 <D51IU4N746MI.FDS6C7GYO4RP@samsung.com>
 <c59f2881-fbbb-41b1-830d-9d81f36ecc0b@linux.alibaba.com>
 <486a72c6-5877-4a95-a587-2a32faa8785d@redhat.com>
 <7eb412d1-f90e-4363-8c7b-072f1124f8a6@linux.alibaba.com>
 <1b0f9f94-06a6-48ac-a68e-848bce1008e9@redhat.com>
 <D53Z7I8D6MRB.XN14XUEFQFG7@kruces.com>
 <cbadd5fe-69d5-4c21-8eb8-3344ed36c721@redhat.com>
 <D57RWGA2IIFD.2EWIDM7HVYF5U@kruces.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <D57RWGA2IIFD.2EWIDM7HVYF5U@kruces.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.10.24 22:56, Daniel Gomez wrote:
> On Fri Oct 25, 2024 at 10:21 PM CEST, David Hildenbrand wrote:
>> Sorry for the late reply!
>>
>>>>>>> IMHO, as I discussed with Kirill, we still need maintain compatibility
>>>>>>> with the 'huge=' mount option. This means that if 'huge=never' is set
>>>>>>> for tmpfs, huge page allocation will still be prohibited (which can
>>>>>>> address Hugh's request?). However, if 'huge=' is not set, we can
>>>>>>> allocate large folios based on the write size.
>>>
>>> So, in order to make tmpfs behave like other filesystems, we need to
>>> allocate large folios by default. Not setting 'huge=' is the same as
>>> setting it to 'huge=never' as per documentation. But 'huge=' is meant to
>>> control THP, not large folios, so it should not have a conflict here, or
>>> else, what case are you thinking?
>>
>> I think we really have to move away from "huge/thp == PMD", that's a
>> historical artifact. Everything else will simply be inconsistent and
>> confusing in the future -- and I don't see any real need for that. For
>> anonymous memory and anon shmem we managed the transition. (there is a
>> longer writeup from me about this topic, so I won't go into detail).
>>
>>
>> I think I raised this in the past, but tmpfs/shmem is just like any
>> other file system .. except it sometimes really isn't and behaves much
>> more like (swappable) anonymous memory. (or mlocked files)
>>
>> There are many systems out there that run without swap enabled, or with
>> extremely minimal swap (IIRC until recently kubernetes was completely
>> incompatible with swapping). Swap can even be disabled today for shmem
>> using a mount option.
>>
>> That's a big difference to all other file systems where you are
>> guaranteed to have backend storage where you can simply evict under
>> memory pressure (might temporarily fail, of course).
>>
>> I *think* that's the reason why we have the "huge=" parameter that also
>> controls the THP allocations during page faults (IOW possible memory
>> over-allocation). Maybe also because it was a new feature, and we only
>> had a single THP size.
>>
>> There is, of course also the "fallocate() might not free up memory if
>> there is an unexpected reference on the page because splitting it will
>> fail" problem, that even exists when not over-allocating memory in the
>> first place ...
>>
>>
>> So ...I don't think tmpfs behaves like other file system in some cases.
>> And I don't think ignoring these points is a good idea.
> 
> Assuming a system without swap, what's the difference you are concern
> about between using the current tmpfs allocation method vs large folios
> implementation?

As raised above, there is the interesting interaction between 
fallocate(FALLOC_FL_PUNCH_HOLE) and raised refcounts, where we can fail 
to reclaim memory.

shmem_fallocate()->shmem_truncate_range()->truncate_inode_pages_range()->truncate_inode_partial_folio().

It's better than it was in the past -- in the past we didn't even try 
splitting, but today splitting can still fail and we'll never try 
reclaiming that memory again later. This is very different to anonymous 
memory where we have the deferred split queue+remember which pages where 
zapped implicitly using the page tables (instead of zeroing them out and 
not freeing up the memory).

It's one of the issues people ran into when using THP+shmem for backing 
guest VMs along with memory ballooning. For that reason, the 
recommendation still is to disable THP when using shmem for backing 
guest VMs and relying on memory overcommit optimizations such as memory 
balloon inflation.

> 
>>
>> Fortunately I don't maintain that code :)
>>
>>
>> If we don't want to go with the shmem_enabled toggles, we should
>> probably still extend the documentation to cover "all THP sizes", like
>> we did elsewhere.
>>
>> huge=never: no THPs of any size
>> huge=always: THPs of any size (fault/write/etc)
>> huge=fadvise: like "always" but only with fadvise/madvise
>> huge=within_size: like "fadvise" but respect i_size
>>
>> We could think about adding a "nowaste" extension and try make it the
>> default.
>>
>> For example
>>
>> "huge=always:nowaste: THPs of any size as long as we don't over-allocate
>> memory (write)"
> 
> This is the default behaviour in other fs too. I don't think is
> necessary to make it explicit.

Please keep in mind that allocating THPs of different size during *page 
faults* will have to fit into the whole picture we are creating here.

That's also what "huge=always" controls for shmem today IIRC.

>>>
>>>>>>
>>>>>> I consider allocating large folios in shmem/tmpfs on the write path less
>>>>>> controversial than allocating them on the page fault path -- especially
>>>>>> as long as we stay within the size to-be-written.
>>>>>>
>>>>>> I think in RHEL THP on shmem/tmpfs are disabled as default (e.g.,
>>>>>> shmem_enabled=never). Maybe because of some rather undesired
>>>>>> side-effects (maybe some are historical?): I recall issues with VMs with
>>>>>> THP+ memory ballooning, as we cannot reclaim pages of folios if
>>>>>> splitting fails). I assume most of these problematic use cases don't use
>>>>>> tmpfs as an ordinary file system (write()/read()), but mmap() the whole
>>>>>> thing.
>>>>>>
>>>>>> Sadly, I don't find any information about shmem/tmpfs + THP in the RHEL
>>>>>> documentation; most documentation is only concerned about anon THP.
>>>>>> Which makes me conclude that they are not suggested as of now.
>>>>>>
>>>>>> I see more issues with allocating them on the page fault path and not
>>>>>> having a way to disable it -- compared to allocating them on the write()
>>>>>> path.
>>>>>
>>>>> I may not understand your issues. IIUC, you can disable allocating huge
>>>>> pages on the page fault path by using the 'huge=never' mount option or
>>>>> setting shmem_enabled=deny. No?
>>>>
>>>> That's what I am saying: if there is some way to disable it that will
>>>> keep working, great.
>>>
>>> I agree. That aligns with what I recall Hugh requested. However, I
>>> believe if that is the way to go, we shouldn't limit it to tmpfs.
>>> Otherwise, why should tmpfs be prevented from allocating large folios if
>>> other filesystems in the system are allowed to allocate them?
>>
>> See above. On systems without/little swap you might not want them for
>> shmem/tmpfs, but would happily use them elsewhere.
>>
>> The "write() won't waste memory" case is really interesting, the
>> "fallocate cannot free the memory" still exists. A shrinker might help.
> 
> The previous implementation with large folios allocation was wrong
> and was actually wasting memory by rounding up while trying to find
> the order. Matthew already pointed it out [1]. So, with that fixed, we
> should not end up wasting memory.

Again, we should have a clear path forward how we deal with page faults 
and how this fits into the picture.

-- 
Cheers,

David / dhildenb


