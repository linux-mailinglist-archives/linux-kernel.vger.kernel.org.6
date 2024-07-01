Return-Path: <linux-kernel+bounces-236112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 469D191DD9C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADF7EB225FD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BFF13D242;
	Mon,  1 Jul 2024 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LOIa7iBv"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A60C537E7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719832359; cv=none; b=FnQcXDO/2pjfeD/FDaLL5yKtpkvuRTeXfOnRf99npv2YIPR/R91X1DmqHBU/L3v7Xzk0TaXoRfntt3vUbMEpamyjFTDaCLYfEnVBWcCicM68oC0KpM4Jc86YgRWzjRDSdeondJIke6p6P6cWqYS4/RZeEB0myzOUmIOHfVuwFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719832359; c=relaxed/simple;
	bh=ppkAU5StD42sPSdL5l2TSYfljpOWYEyGK6YZrWmPipM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulGJZYsdbn9YD7G2x/uKxYQgcCRVAz54g8Gm5JOyGa/9VUF+3cwnGr/TtFfCWu7fYmmt90FoS/mE9WHI6XphBQkcFQrW55ifU4BB02RZ0K1xc2tqjvOFY0ZATuxumpQ4f64HkC9unTfpvOYynF1aFdUICM3zHvudu7km5COh3z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LOIa7iBv; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719832354; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Y+VMaG1F3anoAtn1Tdo4ZeCIuoG31jZY6NdwJKdEzqI=;
	b=LOIa7iBvOixLtyQinVwYmz8D6co+EmAoadDWVcqVF86nJL97bLPFxwfnuNK7ovaSMJGpqvCIic91nzMqzVgLD6PSbSX2xBfZsaWo6DZE0z1ofJjShA1CJ7+Qbefd5ymQCUMVG2QWEYVTrl+vQV3j2gP8ilZtFY6glrj+mhFMQdw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W9dfsZN_1719832352;
Received: from 30.97.56.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9dfsZN_1719832352)
          by smtp.aliyun-inc.com;
          Mon, 01 Jul 2024 19:12:33 +0800
Message-ID: <2910ddc3-b05f-4394-8288-6e3c321fffee@linux.alibaba.com>
Date: Mon, 1 Jul 2024 19:12:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] support "THPeligible" semantics for mTHP with anonymous
 shmem
To: Bang Li <libang.li@antgroup.com>, Ryan Roberts <ryan.roberts@arm.com>,
 hughd@google.com, akpm@linux-foundation.org
Cc: david@redhat.com, wangkefeng.wang@huawei.com, ziy@nvidia.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240628104926.34209-1-libang.li@antgroup.com>
 <4b38db15-0716-4ffb-a38b-bd6250eb93da@arm.com>
 <4d54880e-03f4-460a-94b9-e21b8ad13119@linux.alibaba.com>
 <ee59573f-52bd-45e4-bd2f-eac28ae97e66@antgroup.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ee59573f-52bd-45e4-bd2f-eac28ae97e66@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/1 17:43, Bang Li wrote:
> Hi, Baolin
> 
> On 2024/7/1 16:33, Baolin Wang wrote:
>>
>>
>> On 2024/7/1 15:55, Ryan Roberts wrote:
>>> On 28/06/2024 11:49, Bang Li wrote:
>>>> After the commit 7fb1b252afb5 ("mm: shmem: add mTHP support for
>>>> anonymous shmem"), we can configure different policies through
>>>> the multi-size THP sysfs interface for anonymous shmem. But
>>>> currently "THPeligible" indicates only whether the mapping is
>>>> eligible for allocating THP-pages as well as the THP is PMD
>>>> mappable or not for anonymous shmem, we need to support semantics
>>>> for mTHP with anonymous shmem similar to those for mTHP with
>>>> anonymous memory.
>>>>
>>>> Signed-off-by: Bang Li <libang.li@antgroup.com>
>>>> ---
>>>>   fs/proc/task_mmu.c      | 10 +++++++---
>>>>   include/linux/huge_mm.h | 11 +++++++++++
>>>>   mm/shmem.c              |  9 +--------
>>>>   3 files changed, 19 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>>> index 93fb2c61b154..09b5db356886 100644
>>>> --- a/fs/proc/task_mmu.c
>>>> +++ b/fs/proc/task_mmu.c
>>>> @@ -870,6 +870,7 @@ static int show_smap(struct seq_file *m, void *v)
>>>>   {
>>>>       struct vm_area_struct *vma = v;
>>>>       struct mem_size_stats mss = {};
>>>> +    bool thp_eligible;
>>>>       smap_gather_stats(vma, &mss, 0);
>>>> @@ -882,9 +883,12 @@ static int show_smap(struct seq_file *m, void *v)
>>>>       __show_smap(m, &mss, false);
>>>> -    seq_printf(m, "THPeligible:    %8u\n",
>>>> -           !!thp_vma_allowable_orders(vma, vma->vm_flags,
>>>> -               TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL));
>>>> +    thp_eligible = !!thp_vma_allowable_orders(vma, vma->vm_flags,
>>>> +                        TVA_SMAPS | TVA_ENFORCE_SYSFS, 
>>>> THP_ORDERS_ALL);
>>>> +    if (vma_is_anon_shmem(vma))
>>>> +        thp_eligible = 
>>>> !!shmem_allowable_huge_orders(file_inode(vma->vm_file),
>>>> +                            vma, vma->vm_pgoff, thp_eligible);
>>>
>>> Afraid I haven't been following the shmem mTHP support work as much 
>>> as I would
>>> have liked, but is there a reason why we need a separate function for 
>>> shmem?
>>
>> Since shmem_allowable_huge_orders() only uses shmem specific logic to 
>> determine if huge orders are allowable, there is no need to complicate 
>> the thp_vma_allowable_orders() function by adding more shmem related 
>> logic, making it more bloated. In my view, providing a dedicated 
>> helper shmem_allowable_huge_orders(), specifically for shmem, 
>> simplifies the logic.
>>
>> IIUC, I agree with David's suggestion that the 
>> shmem_allowable_huge_orders() helper function could be used in 
>> thp_vma_allowable_orders() to support shmem mTHP. Something like:
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index c7ce28f6b7f3..9677fe6cf478 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -151,10 +151,13 @@ unsigned long __thp_vma_allowable_orders(struct 
>> vm_area_struct *vma,
>>           * Must be done before hugepage flags check since shmem has its
>>           * own flags.
>>           */
>> -       if (!in_pf && shmem_file(vma->vm_file))
>> -               return shmem_is_huge(file_inode(vma->vm_file), 
>> vma->vm_pgoff,
>> -                                    !enforce_sysfs, vma->vm_mm, 
>> vm_flags)
>> -                       ? orders : 0;
>> +       if (!in_pf && shmem_file(vma->vm_file)) {
>> +               bool global_huge = 
>> shmem_is_huge(file_inode(vma->vm_file), vma->vm_pgoff,
>> +                                    !enforce_sysfs, vma->vm_mm, 
>> vm_flags);
>> +
>> +               return 
>> shmem_allowable_huge_orders(file_inode(vma->vm_file),
>> +                                       vma, vma->vm_pgoff, global_huge);
>> +       }
>>
>>          if (!vma_is_anonymous(vma)) {
>>                  /*
>>
>>> Couldn't (shouldn't) thp_vma_allowable_orders() be taught to handle 
>>> shmem too?
>>>
>>>> +    seq_printf(m, "THPeligible:    %8u\n", thp_eligible);
>>>>       if (arch_pkeys_enabled())
>>>>           seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>> index 212cca384d7e..f87136f38aa1 100644
>>>> --- a/include/linux/huge_mm.h
>>>> +++ b/include/linux/huge_mm.h
>>>> @@ -267,6 +267,10 @@ unsigned long thp_vma_allowable_orders(struct 
>>>> vm_area_struct *vma,
>>>>       return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, 
>>>> orders);
>>>>   }
>>>> +unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>>> +                struct vm_area_struct *vma, pgoff_t index,
>>>> +                bool global_huge);
>>>> +
>>>>   struct thpsize {
>>>>       struct kobject kobj;
>>>>       struct list_head node;
>>>> @@ -460,6 +464,13 @@ static inline unsigned long 
>>>> thp_vma_allowable_orders(struct vm_area_struct *vma,
>>>>       return 0;
>>>>   }
>>>> +static inline unsigned long shmem_allowable_huge_orders(struct 
>>>> inode *inode,
>>>> +                struct vm_area_struct *vma, pgoff_t index,
>>>> +                bool global_huge)
>>>> +{
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   #define transparent_hugepage_flags 0UL
>>>>   #define thp_get_unmapped_area    NULL
>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>> index d495c0701a83..aa85df9c662a 100644
>>>> --- a/mm/shmem.c
>>>> +++ b/mm/shmem.c
>>>> @@ -1622,7 +1622,7 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, 
>>>> gfp_t limit_gfp)
>>>>   }
>>>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>> -static unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>>> +unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>>>                   struct vm_area_struct *vma, pgoff_t index,
>>>>                   bool global_huge)
>>>>   {
>>>> @@ -1707,13 +1707,6 @@ static unsigned long 
>>>> shmem_suitable_orders(struct inode *inode, struct vm_fault
>>>>       return orders;
>>>>   }
>>>>   #else
>>>> -static unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>>> -                struct vm_area_struct *vma, pgoff_t index,
>>>> -                bool global_huge)
>>>> -{
>>>> -    return 0;
>>>> -}
>>>> -
>>>>   static unsigned long shmem_suitable_orders(struct inode *inode, 
>>>> struct vm_fault *vmf,
>>>>                          struct address_space *mapping, pgoff_t index,
>>>>                          unsigned long orders)
> 
> Thanks for the reference code. Currently, we only implement the mTHP of
> anonymous shmem, so we only need to handle anonymous shmem specially. As
> shown in the following code:
> 
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -151,10 +151,14 @@ unsigned long __thp_vma_allowable_orders(struct 
> vm_area_struct *vma,
>           * Must be done before hugepage flags check since shmem has its
>           * own flags.
>           */
> -       if (!in_pf && shmem_file(vma->vm_file))
> -               return shmem_is_huge(file_inode(vma->vm_file), 
> vma->vm_pgoff,
> -                                    !enforce_sysfs, vma->vm_mm, vm_flags)
> -                       ? orders : 0;
> +       if (!in_pf && shmem_file(vma->vm_file)) {
> +               bool global_huge = 
> shmem_is_huge(file_inode(vma->vm_file), vma->vm_pgoff,
> +                                    !enforce_sysfs, vma->vm_mm, vm_flags);

Nit: add a blank line after the declaration. Otherwise looks good to me.

> +               if (!vma_is_anon_shmem(vma))
> +                       return global_huge? orders : 0;
> +               return 
> shmem_allowable_huge_orders(file_inode(vma->vm_file),
> +                                               vma, vma->vm_pgoff, 
> global_huge);
> +       }
> 
>          if (!vma_is_anonymous(vma)) {
> 
> Thanks,
> Bang

