Return-Path: <linux-kernel+bounces-236012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAB491DC4D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC4D1C2134C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C1412C491;
	Mon,  1 Jul 2024 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIE6JPHV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C412A177
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829336; cv=none; b=OEl0vUUrxDTqEbMnJaf9JU5eZTGyxzqbT7tN6Q9um+nnGilHwFn4c+/IwemfsRJW5pwVkGay2DO5GjkYVxbXFfalFDZzeMTox0EWLEKX40rnKi9m3t9Q3ttUQgGdV5rIYIhcONgBrPm/o+CT3C7EdlWBoWxCeEB4vX7lBpIcMUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829336; c=relaxed/simple;
	bh=0VcfbYSo5mwZ7UQQlI6OmH669XWibTEwIGSoO0s38KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJWgv/zBW4S/qHrRpEnjh8G8z1XTD6vse4d+tsSxzhsw/uAVZTHZweVjlruCH3AQExHAJzmEGlHdx3BAXyLgO0MqzWAT6/GgSUj+lppFecSsu3194Vsn21++1hRo4iIJR2xVph2whKI5IbCcw/FgXY8AIZm6rAS9spWraQh4oOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EIE6JPHV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719829333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I2G68+M4aWhYkvmTkMv5r7Ng5lUQ3NARPyIHeZbSLdg=;
	b=EIE6JPHV8vEobQx5oivxTyZNhWw0QWFE9HJ5mmoVyHO5yn1fPyk0k4+mL7o2kBDz5yxoG8
	4jONJq3EkIBVOt8WcQtV/a2OdmA9w3fALymbmR0oPClY5RLFv7QTzEcFMQxEx/9pKeqbep
	IL0cgoylwJLEsJ/mdw9UPpU+gRzANno=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-t14Gm1RvOpC9nogzB_jgFQ-1; Mon, 01 Jul 2024 06:22:12 -0400
X-MC-Unique: t14Gm1RvOpC9nogzB_jgFQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a7535875ab7so33086766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 03:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719829331; x=1720434131;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I2G68+M4aWhYkvmTkMv5r7Ng5lUQ3NARPyIHeZbSLdg=;
        b=cCOGE29r88UxAxhM4cdYJco7xd3GQxdIX2dySG0EMUBRPyKIwoP5pigjPZ9mmrVPmg
         dA5lM0ANRbIHcxlVDuCRQYLdVAcL2sE5FJgKFs40BIZi/j5trpBc96t9mmsOAXZOrvTq
         Zx6KpmMRApVJw+L043VEuTy7hgJEhiseLiiaRFdzTii6XETs2daZ5KBawTNp4rUsx0bi
         R2KCG+7k6UPBp950RkvTrUOmmvGpiD4J4Dl/MCMjchh7w4hHwyu/PcCY/IVKZcv3bgW4
         fsYtlx77MUmoDXM9B65ZGlOpz+FOqnfjXBkrMmAeFpB9FimbNLoxCCRkVwBpICTp8iP3
         4vwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHlPLf1XJuAsfW9Q00RBvY1t8pkG98s3U8ZoQ+ZVspePzBrSmt9gNuD9VfNjvDZzAaEX0rNw3v/W55uCMvtSkMlwtO4M+yPsd4t0Rr
X-Gm-Message-State: AOJu0Yyfuh6pTM38Ie2+VkHKE71N7sy8qmR1unmXcIzXNviEbpq74ugV
	YztNdaWnRJfcmrxfcCQsljkygza9beoPI1PWbOSUrE/v/UTliuRus/T2K4nbRSC3FdqkOO5JQ6e
	rRXOe6TJflP2SkL0L+jb+SCfuGYkZqEM2CsWAwgaqfCQtBuGx4Bixw0XepJI0GQ==
X-Received: by 2002:a17:906:b291:b0:a72:8ceb:4696 with SMTP id a640c23a62f3a-a72aee3e114mr575843566b.4.1719829331643;
        Mon, 01 Jul 2024 03:22:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYTYNTQNp5hnaIfn4iqMSKqsVcvmNDLnZaKGfpNNdVV8aeSYF6sQ/3OWyvCYpY+mk+z1G/Jw==
X-Received: by 2002:a17:906:b291:b0:a72:8ceb:4696 with SMTP id a640c23a62f3a-a72aee3e114mr575842366b.4.1719829331138;
        Mon, 01 Jul 2024 03:22:11 -0700 (PDT)
Received: from [100.81.188.195] ([178.24.249.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf63dfbsm317310666b.84.2024.07.01.03.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 03:22:10 -0700 (PDT)
Message-ID: <7a0bbe69-1e3d-4263-b206-da007791a5c4@redhat.com>
Date: Mon, 1 Jul 2024 12:22:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] support "THPeligible" semantics for mTHP with anonymous
 shmem
To: Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Bang Li
 <libang.li@antgroup.com>, hughd@google.com, akpm@linux-foundation.org
Cc: wangkefeng.wang@huawei.com, ziy@nvidia.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240628104926.34209-1-libang.li@antgroup.com>
 <4b38db15-0716-4ffb-a38b-bd6250eb93da@arm.com>
 <4d54880e-03f4-460a-94b9-e21b8ad13119@linux.alibaba.com>
 <516aa6b3-617c-4642-b12b-0c5f5b33d1c9@arm.com>
 <597ac51e-3f27-4606-8647-395bb4e60df4@redhat.com>
 <6f68fb9d-3039-4e38-bc08-44948a1dae4d@arm.com>
 <992cdbf9-80df-4a91-aea6-f16789c5afd7@redhat.com>
 <2e0a1554-d24f-4d0d-860b-0c2cf05eb8da@arm.com>
 <06c74db8-4d10-4a41-9a05-776f8dca7189@redhat.com>
 <429f2873-8532-4cc8-b0e1-1c3de9f224d9@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <429f2873-8532-4cc8-b0e1-1c3de9f224d9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.07.24 12:16, Ryan Roberts wrote:
> On 01/07/2024 10:17, David Hildenbrand wrote:
>> On 01.07.24 11:14, Ryan Roberts wrote:
>>> On 01/07/2024 09:57, David Hildenbrand wrote:
>>>> On 01.07.24 10:50, Ryan Roberts wrote:
>>>>> On 01/07/2024 09:48, David Hildenbrand wrote:
>>>>>> On 01.07.24 10:40, Ryan Roberts wrote:
>>>>>>> On 01/07/2024 09:33, Baolin Wang wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2024/7/1 15:55, Ryan Roberts wrote:
>>>>>>>>> On 28/06/2024 11:49, Bang Li wrote:
>>>>>>>>>> After the commit 7fb1b252afb5 ("mm: shmem: add mTHP support for
>>>>>>>>>> anonymous shmem"), we can configure different policies through
>>>>>>>>>> the multi-size THP sysfs interface for anonymous shmem. But
>>>>>>>>>> currently "THPeligible" indicates only whether the mapping is
>>>>>>>>>> eligible for allocating THP-pages as well as the THP is PMD
>>>>>>>>>> mappable or not for anonymous shmem, we need to support semantics
>>>>>>>>>> for mTHP with anonymous shmem similar to those for mTHP with
>>>>>>>>>> anonymous memory.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Bang Li <libang.li@antgroup.com>
>>>>>>>>>> ---
>>>>>>>>>>       fs/proc/task_mmu.c      | 10 +++++++---
>>>>>>>>>>       include/linux/huge_mm.h | 11 +++++++++++
>>>>>>>>>>       mm/shmem.c              |  9 +--------
>>>>>>>>>>       3 files changed, 19 insertions(+), 11 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>>>>>>>>> index 93fb2c61b154..09b5db356886 100644
>>>>>>>>>> --- a/fs/proc/task_mmu.c
>>>>>>>>>> +++ b/fs/proc/task_mmu.c
>>>>>>>>>> @@ -870,6 +870,7 @@ static int show_smap(struct seq_file *m, void *v)
>>>>>>>>>>       {
>>>>>>>>>>           struct vm_area_struct *vma = v;
>>>>>>>>>>           struct mem_size_stats mss = {};
>>>>>>>>>> +    bool thp_eligible;
>>>>>>>>>>             smap_gather_stats(vma, &mss, 0);
>>>>>>>>>>       @@ -882,9 +883,12 @@ static int show_smap(struct seq_file *m, void
>>>>>>>>>> *v)
>>>>>>>>>>             __show_smap(m, &mss, false);
>>>>>>>>>>       -    seq_printf(m, "THPeligible:    %8u\n",
>>>>>>>>>> -           !!thp_vma_allowable_orders(vma, vma->vm_flags,
>>>>>>>>>> -               TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL));
>>>>>>>>>> +    thp_eligible = !!thp_vma_allowable_orders(vma, vma->vm_flags,
>>>>>>>>>> +                        TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL);
>>>>>>>>>> +    if (vma_is_anon_shmem(vma))
>>>>>>>>>> +        thp_eligible =
>>>>>>>>>> !!shmem_allowable_huge_orders(file_inode(vma->vm_file),
>>>>>>>>>> +                            vma, vma->vm_pgoff, thp_eligible);
>>>>>>>>>
>>>>>>>>> Afraid I haven't been following the shmem mTHP support work as much as I
>>>>>>>>> would
>>>>>>>>> have liked, but is there a reason why we need a separate function for
>>>>>>>>> shmem?
>>>>>>>>
>>>>>>>> Since shmem_allowable_huge_orders() only uses shmem specific logic to
>>>>>>>> determine
>>>>>>>> if huge orders are allowable, there is no need to complicate the
>>>>>>>> thp_vma_allowable_orders() function by adding more shmem related logic,
>>>>>>>> making
>>>>>>>> it more bloated. In my view, providing a dedicated helper
>>>>>>>> shmem_allowable_huge_orders(), specifically for shmem, simplifies the logic.
>>>>>>>
>>>>>>> My point was really that a single interface (thp_vma_allowable_orders)
>>>>>>> should be
>>>>>>> used to get this information. I have no strong opinon on how the
>>>>>>> implementation
>>>>>>> of that interface looks. What you suggest below seems perfectly reasonable
>>>>>>> to me.
>>>>>>
>>>>>> Right. thp_vma_allowable_orders() might require some care as discussed in
>>>>>> other
>>>>>> context (cleanly separate dax and shmem handling/orders). But that would be
>>>>>> follow-up cleanups.
>>>>>
>>>>> Are you planning to do that, or do you want me to send a patch?
>>>>
>>>> I'm planning on looking into some details, especially the interaction with large
>>>> folios in the pagecache. I'll let you know once I have a better idea what
>>>> actually should be done :)
>>>
>>> OK great - I'll scrub it from my todo list... really getting things done today :)
>>
>> Resolved the khugepaged thiny already? :P
>>
>> [khugepaged not active when only enabling the sub-size via the 2M folder IIRC]
> 
> Hmm... baby brain?

:)

I think I only mentioned it in a private mail at some point.

> 
> Sorry about that. I've been a bit useless lately. For some reason it wasn't on
> my list, but its there now. Will prioritise it, because I agree it's not good.


IIRC, if you do

echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo always > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled

khugepaged will not get activated.

-- 
Cheers,

David / dhildenb


