Return-Path: <linux-kernel+bounces-236493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E433F91E2FC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D0C1F22315
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3633716D4D9;
	Mon,  1 Jul 2024 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="ztOEFfQt"
Received: from out0-205.mail.aliyun.com (out0-205.mail.aliyun.com [140.205.0.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CC916C857
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845812; cv=none; b=GNRCBKGwDeKxrwwUIBmea9Az0BY+u7tNxdAX/BQlXwv3P0rs1vjotSFec8fPGwZVXAVro4xjeHU8e5u2daYkgABu4qjR6M6rxF4aLVWwPI71aVo0y/CZ1GQuaigYWB59rkzj2IipJJWCMu1Dw9B5h4rirqWZqeH4kufwdvFy/3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845812; c=relaxed/simple;
	bh=pfaHEbBJd5fTzy7GDHQIzLjXL5VslSIT9fpjfkpMfls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PS11Nz88UekQHHB741JKzSXSIr+mL30k7BQRXYsoQXwIikFV/Qgj9cR82XGqodGnmjj86AE7SSCMJtq9JEPthdxjYItNwFTmctF3RVABeeaElcDtE16FGBsqGe+lhhT9FOblH2bu8IGrQH+BXmFv63HGnJ6ZwMRu89jY+ueb7ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=ztOEFfQt; arc=none smtp.client-ip=140.205.0.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1719845800; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7fXQtGE1vB/XPlQsFz75kPV4wKlykVtl82FG6M2N7A0=;
	b=ztOEFfQt9Ih78TOoEbW0SUa2cbFfRSBjjEUAooKErmaIwxC5V3cPTt7C3gPtcwq2FWF7hA5QuKxIdXiMs0iIb6n7d3vL89EIw/3ZkHQ6OJ1Fzn7mJQEu01CCS7ym79rLaimPPX8mgHOr3xDQbi5a+UxsGsO6aVBrz9PIpoTI5M4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033070043001;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---.YENyL8G_1719845482;
Received: from 30.13.185.168(mailfrom:libang.li@antgroup.com fp:SMTPD_---.YENyL8G_1719845482)
          by smtp.aliyun-inc.com;
          Mon, 01 Jul 2024 22:51:23 +0800
Message-ID: <f8a8d9de-c1e8-457e-8782-d8565f1983a2@antgroup.com>
Date: Mon, 01 Jul 2024 22:51:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] support "THPeligible" semantics for mTHP with anonymous
 shmem
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, hughd@google.com,
 akpm@linux-foundation.org
Cc: david@redhat.com, wangkefeng.wang@huawei.com, ziy@nvidia.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240628104926.34209-1-libang.li@antgroup.com>
 <4b38db15-0716-4ffb-a38b-bd6250eb93da@arm.com>
 <4d54880e-03f4-460a-94b9-e21b8ad13119@linux.alibaba.com>
 <ee59573f-52bd-45e4-bd2f-eac28ae97e66@antgroup.com>
 <2910ddc3-b05f-4394-8288-6e3c321fffee@linux.alibaba.com>
Content-Language: en-US
From: "Bang Li" <libang.li@antgroup.com>
In-Reply-To: <2910ddc3-b05f-4394-8288-6e3c321fffee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/7/1 19:12, Baolin Wang wrote:
> 
> 
> On 2024/7/1 17:43, Bang Li wrote:
>> Hi, Baolin
>>
>> On 2024/7/1 16:33, Baolin Wang wrote:
>>>
>>>
>>> On 2024/7/1 15:55, Ryan Roberts wrote:
>>>> On 28/06/2024 11:49, Bang Li wrote:
>>>>> After the commit 7fb1b252afb5 ("mm: shmem: add mTHP support for
>>>>> anonymous shmem"), we can configure different policies through
>>>>> the multi-size THP sysfs interface for anonymous shmem. But
>>>>> currently "THPeligible" indicates only whether the mapping is
>>>>> eligible for allocating THP-pages as well as the THP is PMD
>>>>> mappable or not for anonymous shmem, we need to support semantics
>>>>> for mTHP with anonymous shmem similar to those for mTHP with
>>>>> anonymous memory.
>>>>>
>>>>> Signed-off-by: Bang Li <libang.li@antgroup.com>
>>>>> ---
>>>>>   fs/proc/task_mmu.c      | 10 +++++++---
>>>>>   include/linux/huge_mm.h | 11 +++++++++++
>>>>>   mm/shmem.c              |  9 +--------
>>>>>   3 files changed, 19 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>>>> index 93fb2c61b154..09b5db356886 100644
>>>>> --- a/fs/proc/task_mmu.c
>>>>> +++ b/fs/proc/task_mmu.c
>>>>> @@ -870,6 +870,7 @@ static int show_smap(struct seq_file *m, void *v)
>>>>>   {
>>>>>       struct vm_area_struct *vma = v;
>>>>>       struct mem_size_stats mss = {};
>>>>> +    bool thp_eligible;
>>>>>       smap_gather_stats(vma, &mss, 0);
>>>>> @@ -882,9 +883,12 @@ static int show_smap(struct seq_file *m, void *v)
>>>>>       __show_smap(m, &mss, false);
>>>>> -    seq_printf(m, "THPeligible:    %8u\n",
>>>>> -           !!thp_vma_allowable_orders(vma, vma->vm_flags,
>>>>> -               TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL));
>>>>> +    thp_eligible = !!thp_vma_allowable_orders(vma, vma->vm_flags,
>>>>> +                        TVA_SMAPS | TVA_ENFORCE_SYSFS, 
>>>>> THP_ORDERS_ALL);
>>>>> +    if (vma_is_anon_shmem(vma))
>>>>> +        thp_eligible = 
>>>>> !!shmem_allowable_huge_orders(file_inode(vma->vm_file),
>>>>> +                            vma, vma->vm_pgoff, thp_eligible);
>>>>
>>>> Afraid I haven't been following the shmem mTHP support work as much 
>>>> as I would
>>>> have liked, but is there a reason why we need a separate function 
>>>> for shmem?
>>>
>>> Since shmem_allowable_huge_orders() only uses shmem specific logic to 
>>> determine if huge orders are allowable, there is no need to 
>>> complicate the thp_vma_allowable_orders() function by adding more 
>>> shmem related logic, making it more bloated. In my view, providing a 
>>> dedicated helper shmem_allowable_huge_orders(), specifically for 
>>> shmem, simplifies the logic.
>>>
>>> IIUC, I agree with David's suggestion that the 
>>> shmem_allowable_huge_orders() helper function could be used in 
>>> thp_vma_allowable_orders() to support shmem mTHP. Something like:
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index c7ce28f6b7f3..9677fe6cf478 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -151,10 +151,13 @@ unsigned long __thp_vma_allowable_orders(struct 
>>> vm_area_struct *vma,
>>>           * Must be done before hugepage flags check since shmem has its
>>>           * own flags.
>>>           */
>>> -       if (!in_pf && shmem_file(vma->vm_file))
>>> -               return shmem_is_huge(file_inode(vma->vm_file), 
>>> vma->vm_pgoff,
>>> -                                    !enforce_sysfs, vma->vm_mm, 
>>> vm_flags)
>>> -                       ? orders : 0;
>>> +       if (!in_pf && shmem_file(vma->vm_file)) {
>>> +               bool global_huge = 
>>> shmem_is_huge(file_inode(vma->vm_file), vma->vm_pgoff,
>>> +                                    !enforce_sysfs, vma->vm_mm, 
>>> vm_flags);
>>> +
>>> +               return 
>>> shmem_allowable_huge_orders(file_inode(vma->vm_file),
>>> +                                       vma, vma->vm_pgoff, 
>>> global_huge);
>>> +       }
>>>
>>>          if (!vma_is_anonymous(vma)) {
>>>                  /*
>>>
>>>> Couldn't (shouldn't) thp_vma_allowable_orders() be taught to handle 
>>>> shmem too?
>>>>
>>>>> +    seq_printf(m, "THPeligible:    %8u\n", thp_eligible);
>>>>>       if (arch_pkeys_enabled())
>>>>>           seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>>> index 212cca384d7e..f87136f38aa1 100644
>>>>> --- a/include/linux/huge_mm.h
>>>>> +++ b/include/linux/huge_mm.h
>>>>> @@ -267,6 +267,10 @@ unsigned long thp_vma_allowable_orders(struct 
>>>>> vm_area_struct *vma,
>>>>>       return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, 
>>>>> orders);
>>>>>   }
>>>>> +unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>>>> +                struct vm_area_struct *vma, pgoff_t index,
>>>>> +                bool global_huge);
>>>>> +
>>>>>   struct thpsize {
>>>>>       struct kobject kobj;
>>>>>       struct list_head node;
>>>>> @@ -460,6 +464,13 @@ static inline unsigned long 
>>>>> thp_vma_allowable_orders(struct vm_area_struct *vma,
>>>>>       return 0;
>>>>>   }
>>>>> +static inline unsigned long shmem_allowable_huge_orders(struct 
>>>>> inode *inode,
>>>>> +                struct vm_area_struct *vma, pgoff_t index,
>>>>> +                bool global_huge)
>>>>> +{
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>>   #define transparent_hugepage_flags 0UL
>>>>>   #define thp_get_unmapped_area    NULL
>>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>>> index d495c0701a83..aa85df9c662a 100644
>>>>> --- a/mm/shmem.c
>>>>> +++ b/mm/shmem.c
>>>>> @@ -1622,7 +1622,7 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, 
>>>>> gfp_t limit_gfp)
>>>>>   }
>>>>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>> -static unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>>>> +unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>>>>                   struct vm_area_struct *vma, pgoff_t index,
>>>>>                   bool global_huge)
>>>>>   {
>>>>> @@ -1707,13 +1707,6 @@ static unsigned long 
>>>>> shmem_suitable_orders(struct inode *inode, struct vm_fault
>>>>>       return orders;
>>>>>   }
>>>>>   #else
>>>>> -static unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>>>> -                struct vm_area_struct *vma, pgoff_t index,
>>>>> -                bool global_huge)
>>>>> -{
>>>>> -    return 0;
>>>>> -}
>>>>> -
>>>>>   static unsigned long shmem_suitable_orders(struct inode *inode, 
>>>>> struct vm_fault *vmf,
>>>>>                          struct address_space *mapping, pgoff_t index,
>>>>>                          unsigned long orders)
>>
>> Thanks for the reference code. Currently, we only implement the mTHP of
>> anonymous shmem, so we only need to handle anonymous shmem specially. As
>> shown in the following code:
>>
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -151,10 +151,14 @@ unsigned long __thp_vma_allowable_orders(struct 
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
> 
> Nit: add a blank line after the declaration. Otherwise looks good to me.

It doesn't matter to me whether I add spaces or not, thanks for your
suggestion anyway.

Thanks,
Bang

> 
>> +               if (!vma_is_anon_shmem(vma))
>> +                       return global_huge? orders : 0;
>> +               return 
>> shmem_allowable_huge_orders(file_inode(vma->vm_file),
>> +                                               vma, vma->vm_pgoff, 
>> global_huge);
>> +       }
>>
>>          if (!vma_is_anonymous(vma)) {
>>
>> Thanks,
>> Bang

