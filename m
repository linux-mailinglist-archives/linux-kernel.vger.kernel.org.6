Return-Path: <linux-kernel+bounces-240869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC1F9273E7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD1F281941
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808A41AB907;
	Thu,  4 Jul 2024 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="LJsf2XnB"
Received: from out0-220.mail.aliyun.com (out0-220.mail.aliyun.com [140.205.0.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B14CA41
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088484; cv=none; b=eIbWiOhTL0uLLE7SE77EDY67wppxzjVu1kHSzk4IyhkyU4XLXZ4raH198EeYnlWKEsUis0xKjkgU0O7hxWkEfICZb0LDMv5WPqharkDiBD2dr6n93d5B0VqWPh8jVZ0KojWOFhQSq/CddjsDTnCDT42+D7rzCQXLvSdxxWjbDko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088484; c=relaxed/simple;
	bh=kwjJgc9kSsj3XQZhZBfULysb5rRP2Hoj9uAFGoQCeLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKubC0tQ50iZ01cEAxF6NwGC/EUgQl3FArTP3SRM49jiv5HlDWl28saUTXxcZMauFn0QWnU3aJyrFck+pYmF+cpIN+JsBHfIT1uyoMiOD3AEufVzk0kd49cqK4W1MNNskQ2oiK1WN3bxYV6Jphw94fR2FodRR70x+TwBEoijbyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=LJsf2XnB; arc=none smtp.client-ip=140.205.0.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1720088478; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xqXPNUYYyuqy38+xxKlTqoi8WFfd/x2Nf0wed4r7YUs=;
	b=LJsf2XnBZaVnv0yD029o66GErnMuzSdY0zV+BOFDx3eSVW/zngOZwGlQudarpoYwxwNzPVYsK7wWmQwqIOAPPPSOcF1j9MlwHDeO+zoZ2H2cb1XUs9y+nfI6CZkThrNgwbAB6RtiCDRQVlvWpEcteXbltOF2JCIOCvesrGY35tU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023108233;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---.YHL2Og._1720087543;
Received: from 30.230.83.123(mailfrom:libang.li@antgroup.com fp:SMTPD_---.YHL2Og._1720087543)
          by smtp.aliyun-inc.com;
          Thu, 04 Jul 2024 18:05:43 +0800
Message-ID: <941458a6-9e74-444a-9dfd-726d0a7cf158@antgroup.com>
Date: Thu, 04 Jul 2024 18:05:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: thp: support "THPeligible" semantics for mTHP with
 anonymous shmem
To: Ryan Roberts <ryan.roberts@arm.com>, ughd@google.com,
 akpm@linux-foundation.org
Cc: david@redhat.com, wangkefeng.wang@huawei.com,
 baolin.wang@linux.alibaba.com, ioworker0@gmail.com, ziy@nvidia.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240702023401.41553-1-libang.li@antgroup.com>
 <507da6d0-77c5-46ca-8351-53b405ecb131@arm.com>
 <8c018e06-74f1-46e9-bc32-b3870342cdc1@antgroup.com>
 <8d9e501a-0645-4b78-809a-7c9f49f2106d@arm.com>
 <c1e38d54-400c-4647-9ffb-1bf70f92c0c2@antgroup.com>
 <ccd5a1b8-3b01-4f5a-b9fb-6a5068b08a4a@arm.com>
Content-Language: en-US
From: "Bang Li" <libang.li@antgroup.com>
In-Reply-To: <ccd5a1b8-3b01-4f5a-b9fb-6a5068b08a4a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ryan,

On 2024/7/4 17:46, Ryan Roberts wrote:
> On 03/07/2024 17:02, Bang Li wrote:
>> On 2024/7/3 18:25, Ryan Roberts wrote:
>>> On 03/07/2024 08:33, Bang Li wrote:
>>>> Hi Ryan,
>>>>
>>>> Thanks for the review!
>>>>
>>>> On 2024/7/2 16:18, Ryan Roberts wrote:
>>>>> On 02/07/2024 03:34, Bang Li wrote:
>>>>>> After the commit 7fb1b252afb5 ("mm: shmem: add mTHP support for
>>>>>> anonymous shmem"), we can configure different policies through
>>>>>> the multi-size THP sysfs interface for anonymous shmem. But
>>>>>> currently "THPeligible" indicates only whether the mapping is
>>>>>> eligible for allocating THP-pages as well as the THP is PMD
>>>>>> mappable or not for anonymous shmem, we need to support semantics
>>>>>> for mTHP with anonymous shmem similar to those for mTHP with
>>>>>> anonymous memory.
>>>>>>
>>>>>> Signed-off-by: Bang Li <libang.li@antgroup.com>
>>>>>> ---
>>>>>> Changes since v1 [1]:
>>>>>>     - Put anonymous shmem mthp related logic into
>>>>>>       thp_vma_allowable_orders() (per David)
>>>>>>
>>>>>> [1]
>>>>>> https://lore.kernel.org/linux-mm/20240628104926.34209-1-libang.li@antgroup.com/
>>>>>> ---
>>>>>>     include/linux/huge_mm.h | 11 +++++++++++
>>>>>>     mm/huge_memory.c        | 13 +++++++++----
>>>>>>     mm/shmem.c              |  9 +--------
>>>>>>     3 files changed, 21 insertions(+), 12 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>>>> index 212cca384d7e..f87136f38aa1 100644
>>>>>> --- a/include/linux/huge_mm.h
>>>>>> +++ b/include/linux/huge_mm.h
>>>>>> @@ -267,6 +267,10 @@ unsigned long thp_vma_allowable_orders(struct
>>>>>> vm_area_struct *vma,
>>>>>>         return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
>>>>>>     }
>>>>>>     +unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>>>>> +                struct vm_area_struct *vma, pgoff_t index,
>>>>>> +                bool global_huge);
>>>>>> +
>>>>>>     struct thpsize {
>>>>>>         struct kobject kobj;
>>>>>>         struct list_head node;
>>>>>> @@ -460,6 +464,13 @@ static inline unsigned long
>>>>>> thp_vma_allowable_orders(struct vm_area_struct *vma,
>>>>>>         return 0;
>>>>>>     }
>>>>>>     +static inline unsigned long shmem_allowable_huge_orders(struct inode
>>>>>> *inode,
>>>>>> +                struct vm_area_struct *vma, pgoff_t index,
>>>>>> +                bool global_huge)
>>>>>> +{
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>>     #define transparent_hugepage_flags 0UL
>>>>>>       #define thp_get_unmapped_area    NULL
>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>>> index c7ce28f6b7f3..ea377bb4af91 100644
>>>>>> --- a/mm/huge_memory.c
>>>>>> +++ b/mm/huge_memory.c
>>>>>> @@ -151,10 +151,15 @@ unsigned long __thp_vma_allowable_orders(struct
>>>>>> vm_area_struct *vma,
>>>>>>          * Must be done before hugepage flags check since shmem has its
>>>>>>          * own flags.
>>>>>>          */
>>>>>> -    if (!in_pf && shmem_file(vma->vm_file))
>>>>>> -        return shmem_is_huge(file_inode(vma->vm_file), vma->vm_pgoff,
>>>>>> -                     !enforce_sysfs, vma->vm_mm, vm_flags)
>>>>>> -            ? orders : 0;
>>>>>> +    if (!in_pf && shmem_file(vma->vm_file)) {
>>>>>> +        bool global_huge = shmem_is_huge(file_inode(vma->vm_file),
>>>>>> vma->vm_pgoff,
>>>>>> +                            !enforce_sysfs, vma->vm_mm, vm_flags);
>>>>>> +
>>>>>> +        if (!vma_is_anon_shmem(vma))
>>>>>> +            return global_huge? orders : 0;
>>>>>
>>>>> nit: missing space before '?'
>>>>
>>>> Yes, thanks.
>>>>
>>>>>
>>>>>> +        return shmem_allowable_huge_orders(file_inode(vma->vm_file),
>>>>>> +                            vma, vma->vm_pgoff, global_huge);
>>>>>
>>>>> What's the rationale for splitting these functions into shmem_is_huge() and
>>>>> shmem_allowable_huge_orders()? Why not just have a single
>>>>> shmem_allowable_huge_orders() that tells you the answer?
>>>>>
>>>>
>>>> Currently, shmem_is_huge() is used for all shmem implementations to determine
>>>> whether the conditions for using THP are met. And shmem_allowable_huge_orders()
>>>> is currently mainly used for anonymous shmem's mTHP to obtain all orders that
>>>> meet the conditions. In my opinion, there is no problem in separating these two
>>>> functions. In the future, when mTHP of other shmem types is also implemented,
>>>> will shmem_is_huge() be unnecessary?
>>>
>>> Personally, I consider shmem_is_huge() to be superfluous; If you have one
>>> function, shmem_allowable_huge_orders(), that gives you all the information you
>>> need. If the inode only allows PMD-size, then only return that bit in the field.
>>> IMHO removing shmem_is_huge() would make things more readable.
>>
>> Thank you very much for your opinion. I think there is no big problem in keeping
>> the current interface status quo. In my opinion, when we implement mTHP for all
>> shmems, it may be better to remove shmem_is_huge() and use
>> shmem_allowable_huge_orders() uniformly. I believe that it won't be long before
>> someone proposes a non-anonymous shared mTHP patchset. Anyway, thank you for
>> your suggestion :).
> 
> See [1] for an expanded list of concerns I have about the current state of the
> interface and implementation.

OK, could you please send me the corresponding link ;)？

Thanks，
Bang

> 
> Thanks,
> Ryan
> 
>>
>> Thanks,
>> Bang
>>
>>>
>>> Thanks,
>>> Ryan
>>>
>>>>
>>>> Thanks,
>>>> Bang
>>>>
>>>>>> +    }
>>>>>>           if (!vma_is_anonymous(vma)) {
>>>>>>             /*
>>>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>>>> index d495c0701a83..aa85df9c662a 100644
>>>>>> --- a/mm/shmem.c
>>>>>> +++ b/mm/shmem.c
>>>>>> @@ -1622,7 +1622,7 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t
>>>>>> limit_gfp)
>>>>>>     }
>>>>>>       #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>>> -static unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>>>>> +unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>>>>>                     struct vm_area_struct *vma, pgoff_t index,
>>>>>>                     bool global_huge)
>>>>>>     {
>>>>>> @@ -1707,13 +1707,6 @@ static unsigned long shmem_suitable_orders(struct
>>>>>> inode *inode, struct vm_fault
>>>>>>         return orders;
>>>>>>     }
>>>>>>     #else
>>>>>> -static unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>>>>> -                struct vm_area_struct *vma, pgoff_t index,
>>>>>> -                bool global_huge)
>>>>>> -{
>>>>>> -    return 0;
>>>>>> -}
>>>>>> -
>>>>>>     static unsigned long shmem_suitable_orders(struct inode *inode, struct
>>>>>> vm_fault *vmf,
>>>>>>                            struct address_space *mapping, pgoff_t index,
>>>>>>                            unsigned long orders)

