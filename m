Return-Path: <linux-kernel+bounces-235951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1024691DBAA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BF72827E4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866FA84DE9;
	Mon,  1 Jul 2024 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="vQegFkf8"
Received: from out0-193.mail.aliyun.com (out0-193.mail.aliyun.com [140.205.0.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91984A0F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719827034; cv=none; b=CdV6cXzJeBap1Ii5OZNt99ypN8968NVN8shqmkDpPjGoVLLp43NjWwbvkkbZS4C+YOXosEoz7SDdMqIIhvqyPUONoVqGyg2bKy4kOxV9lX82VdZCBMFaL6BOpKbhZgOcQ+h1YtIs3rJuLnrMy11RWxMe9KYh7iaWikcPnZT8Yl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719827034; c=relaxed/simple;
	bh=eWNKxhroc9c4Tpm1WnD/CMbCLJ0sIYDbIpAIu0NQffs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wy6bcW1zeBIjI8yOOEN2r0TVVeLOC2E10e82qmNoPPziv6RUbETToxAf1nBpkfGs+HghauhkDL9Gv8vepHgOgraGsEXCrpUBD9X1Dw718bO8C+jxt1vz+95247ZBaxTQY+XGCapbLI65VJ5ahHHQ8oL3XjTqLfYWhbXMQj8KTzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=vQegFkf8; arc=none smtp.client-ip=140.205.0.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1719827022; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PKR6sxM7W5GGchw1blJuJyfZABT5gHN6PYWv8xcaq5E=;
	b=vQegFkf8VuHemutQ/3HI+nFLtaYR3id6R38ggVTT7vNeOL9P7ry1FqCt9ZcdRiDbLxgNXbV6UCJlDS5r7Bp4H5kGwu6xzU3L9reMaf+x0QODozRIi+ASJOzIGaEGLXcIz9FUEKcCD8GllZ+X2Po3aDAr2BNew9JiyoA81phZl5E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037088118;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---.YEDLAmw_1719827021;
Received: from 30.13.185.168(mailfrom:libang.li@antgroup.com fp:SMTPD_---.YEDLAmw_1719827021)
          by smtp.aliyun-inc.com;
          Mon, 01 Jul 2024 17:43:41 +0800
Message-ID: <ee59573f-52bd-45e4-bd2f-eac28ae97e66@antgroup.com>
Date: Mon, 01 Jul 2024 17:43:39 +0800
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
Content-Language: en-US
From: "Bang Li" <libang.li@antgroup.com>
In-Reply-To: <4d54880e-03f4-460a-94b9-e21b8ad13119@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Baolin

On 2024/7/1 16:33, Baolin Wang wrote:
> 
> 
> On 2024/7/1 15:55, Ryan Roberts wrote:
>> On 28/06/2024 11:49, Bang Li wrote:
>>> After the commit 7fb1b252afb5 ("mm: shmem: add mTHP support for
>>> anonymous shmem"), we can configure different policies through
>>> the multi-size THP sysfs interface for anonymous shmem. But
>>> currently "THPeligible" indicates only whether the mapping is
>>> eligible for allocating THP-pages as well as the THP is PMD
>>> mappable or not for anonymous shmem, we need to support semantics
>>> for mTHP with anonymous shmem similar to those for mTHP with
>>> anonymous memory.
>>>
>>> Signed-off-by: Bang Li <libang.li@antgroup.com>
>>> ---
>>>   fs/proc/task_mmu.c      | 10 +++++++---
>>>   include/linux/huge_mm.h | 11 +++++++++++
>>>   mm/shmem.c              |  9 +--------
>>>   3 files changed, 19 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>> index 93fb2c61b154..09b5db356886 100644
>>> --- a/fs/proc/task_mmu.c
>>> +++ b/fs/proc/task_mmu.c
>>> @@ -870,6 +870,7 @@ static int show_smap(struct seq_file *m, void *v)
>>>   {
>>>       struct vm_area_struct *vma = v;
>>>       struct mem_size_stats mss = {};
>>> +    bool thp_eligible;
>>>       smap_gather_stats(vma, &mss, 0);
>>> @@ -882,9 +883,12 @@ static int show_smap(struct seq_file *m, void *v)
>>>       __show_smap(m, &mss, false);
>>> -    seq_printf(m, "THPeligible:    %8u\n",
>>> -           !!thp_vma_allowable_orders(vma, vma->vm_flags,
>>> -               TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL));
>>> +    thp_eligible = !!thp_vma_allowable_orders(vma, vma->vm_flags,
>>> +                        TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL);
>>> +    if (vma_is_anon_shmem(vma))
>>> +        thp_eligible = 
>>> !!shmem_allowable_huge_orders(file_inode(vma->vm_file),
>>> +                            vma, vma->vm_pgoff, thp_eligible);
>>
>> Afraid I haven't been following the shmem mTHP support work as much as 
>> I would
>> have liked, but is there a reason why we need a separate function for 
>> shmem?
> 
> Since shmem_allowable_huge_orders() only uses shmem specific logic to 
> determine if huge orders are allowable, there is no need to complicate 
> the thp_vma_allowable_orders() function by adding more shmem related 
> logic, making it more bloated. In my view, providing a dedicated helper 
> shmem_allowable_huge_orders(), specifically for shmem, simplifies the 
> logic.
> 
> IIUC, I agree with David's suggestion that the 
> shmem_allowable_huge_orders() helper function could be used in 
> thp_vma_allowable_orders() to support shmem mTHP. Something like:
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c7ce28f6b7f3..9677fe6cf478 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -151,10 +151,13 @@ unsigned long __thp_vma_allowable_orders(struct 
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
> +
> +               return 
> shmem_allowable_huge_orders(file_inode(vma->vm_file),
> +                                       vma, vma->vm_pgoff, global_huge);
> +       }
> 
>          if (!vma_is_anonymous(vma)) {
>                  /*
> 
>> Couldn't (shouldn't) thp_vma_allowable_orders() be taught to handle 
>> shmem too?
>>
>>> +    seq_printf(m, "THPeligible:    %8u\n", thp_eligible);
>>>       if (arch_pkeys_enabled())
>>>           seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index 212cca384d7e..f87136f38aa1 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -267,6 +267,10 @@ unsigned long thp_vma_allowable_orders(struct 
>>> vm_area_struct *vma,
>>>       return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, 
>>> orders);
>>>   }
>>> +unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>> +                struct vm_area_struct *vma, pgoff_t index,
>>> +                bool global_huge);
>>> +
>>>   struct thpsize {
>>>       struct kobject kobj;
>>>       struct list_head node;
>>> @@ -460,6 +464,13 @@ static inline unsigned long 
>>> thp_vma_allowable_orders(struct vm_area_struct *vma,
>>>       return 0;
>>>   }
>>> +static inline unsigned long shmem_allowable_huge_orders(struct inode 
>>> *inode,
>>> +                struct vm_area_struct *vma, pgoff_t index,
>>> +                bool global_huge)
>>> +{
>>> +    return 0;
>>> +}
>>> +
>>>   #define transparent_hugepage_flags 0UL
>>>   #define thp_get_unmapped_area    NULL
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> index d495c0701a83..aa85df9c662a 100644
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>> @@ -1622,7 +1622,7 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, 
>>> gfp_t limit_gfp)
>>>   }
>>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> -static unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>> +unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>>                   struct vm_area_struct *vma, pgoff_t index,
>>>                   bool global_huge)
>>>   {
>>> @@ -1707,13 +1707,6 @@ static unsigned long 
>>> shmem_suitable_orders(struct inode *inode, struct vm_fault
>>>       return orders;
>>>   }
>>>   #else
>>> -static unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>> -                struct vm_area_struct *vma, pgoff_t index,
>>> -                bool global_huge)
>>> -{
>>> -    return 0;
>>> -}
>>> -
>>>   static unsigned long shmem_suitable_orders(struct inode *inode, 
>>> struct vm_fault *vmf,
>>>                          struct address_space *mapping, pgoff_t index,
>>>                          unsigned long orders)

Thanks for the reference code. Currently, we only implement the mTHP of
anonymous shmem, so we only need to handle anonymous shmem specially. As
shown in the following code:

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -151,10 +151,14 @@ unsigned long __thp_vma_allowable_orders(struct 
vm_area_struct *vma,
          * Must be done before hugepage flags check since shmem has its
          * own flags.
          */
-       if (!in_pf && shmem_file(vma->vm_file))
-               return shmem_is_huge(file_inode(vma->vm_file), 
vma->vm_pgoff,
-                                    !enforce_sysfs, vma->vm_mm, vm_flags)
-                       ? orders : 0;
+       if (!in_pf && shmem_file(vma->vm_file)) {
+               bool global_huge = 
shmem_is_huge(file_inode(vma->vm_file), vma->vm_pgoff,
+                                    !enforce_sysfs, vma->vm_mm, vm_flags);
+               if (!vma_is_anon_shmem(vma))
+                       return global_huge? orders : 0;
+               return shmem_allowable_huge_orders(file_inode(vma->vm_file),
+                                               vma, vma->vm_pgoff, 
global_huge);
+       }

         if (!vma_is_anonymous(vma)) {

Thanks,
Bang

