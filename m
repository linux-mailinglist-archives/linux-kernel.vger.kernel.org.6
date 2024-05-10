Return-Path: <linux-kernel+bounces-176019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE588C28D0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A78E0B2393D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4B710965;
	Fri, 10 May 2024 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="nNyGn9BI"
Received: from out0-212.mail.aliyun.com (out0-212.mail.aliyun.com [140.205.0.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6BD17BA2
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715359012; cv=none; b=VJPHm73YGrkW0ZlevY00rd72x40Pcra2gfPDuntuSx6lyAzqIVZEBBUKiIL7D+DqoizVIEtrN0Sgx95e6qzQoYMB+UeKib3QA3W3FPIpzN4y5WwpnHsvPt59sN6HrcMIO41TbVYVyM3kK/n0LuhuVAGWeM/hNVuLUYa9n+9Z3lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715359012; c=relaxed/simple;
	bh=ah2f+flPhjMWjq/tYuVImg54uB8bO07DeCFS0hFQSh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNK4wcOn+hVozg/W+U5mLRLVD2gIPNg5PGlx+EJZ8NdvbqH0oqbvUJWr7T5ICaPUOH7pk4oaOwFmq91pNw5YcOuquJevUeGn7iwtZle610SkMCgKnlznPXTW/m4l6y0B9tpTShKwLgunruYnp2xcm7BZZbsKEe97H9XDQ42h9PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=nNyGn9BI; arc=none smtp.client-ip=140.205.0.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1715359000; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qtTzD4p4/mI5FQfHMAQ4AseA2ZJSqFbFGgw9hxpmGnA=;
	b=nNyGn9BIS8D5zP3Gq9ppUd+vsT4Gi844ONso3HSs1XSXLLwEhmfwYoO8YVQkeulSbzSvGzVqCCB5Gqvp4mSlJAo9IwWY6TL6QffHJ/vL098TkmO5H3hS3Pn7xb+o4yCOrqOaukyv5YpWgmQ2UiwE5zQ6+BWascjP2Rb29Zr0h18=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047212;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.XYAMMf6_1715358997;
Received: from 30.39.184.43(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XYAMMf6_1715358997)
          by smtp.aliyun-inc.com;
          Sat, 11 May 2024 00:36:38 +0800
Message-ID: <41acfd35-69b4-41bc-a45b-4426d5110077@antgroup.com>
Date: Sat, 11 May 2024 00:36:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] mm: Add update_mmu_tlb_range()
To: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 chenhuacai@kernel.org, tsbogend@alpha.franken.de, paul.walmsley@sifive.com,
 palmer@dabbelt.com, chris@zankel.net, jcmvbkbc@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 david@redhat.com, ioworker0@gmail.com, libang.linux@gmail.com,
 baolin.wang@linux.alibaba.com
References: <20240506155120.83105-1-libang.li@antgroup.com>
 <20240506155120.83105-6-libang.li@antgroup.com>
 <eb41fcb3-7207-40a8-9b49-0825a2e74e86@arm.com>
Content-Language: en-US
From: "Bang Li" <libang.li@antgroup.com>
In-Reply-To: <eb41fcb3-7207-40a8-9b49-0825a2e74e86@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ryan,

Thanks for you review!

On 2024/5/10 17:05, Ryan Roberts wrote:
> On 06/05/2024 16:51, Bang Li wrote:
>> After the commit 19eaf44954df ("mm: thp: support allocation of anonymous
>> multi-size THP"), it may need to batch update tlb of an address range
>> through the update_mmu_tlb function. We can simplify this operation by
>> adding the update_mmu_tlb_range function, which may also reduce the
>> execution of some unnecessary code in some architectures.
>>
>> Signed-off-by: Bang Li <libang.li@antgroup.com>
>> ---
>>   include/linux/pgtable.h | 8 ++++++++
>>   mm/memory.c             | 4 +---
>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index 18019f037bae..869bfe6054f1 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -737,6 +737,14 @@ static inline void update_mmu_tlb(struct vm_area_struct *vma,
>>   #define __HAVE_ARCH_UPDATE_MMU_TLB
>>   #endif
> 
> Given you are implementing update_mmu_tlb_range() in all the arches that
> currently override update_mmu_tlb() I wonder if it would be cleaner to remove
> update_mmu_tlb() from all those arches, and define generically, removing the
> ability for arches to override it:
> 
> static inline void update_mmu_tlb(struct vm_area_struct *vma,
> 				unsigned long address, pte_t *ptep)
> {
> 	update_mmu_tlb_range(vma, address, ptep, 1);
> }

Agreed! Thank you for your suggestion, I will modify it in the next version.

> 
>>   
>> +#ifndef __HAVE_ARCH_UPDATE_MMU_TLB_RANGE
>> +static inline void update_mmu_tlb_range(struct vm_area_struct *vma,
>> +				unsigned long address, pte_t *ptep, unsigned int nr)
>> +{
>> +}
>> +#define __HAVE_ARCH_UPDATE_MMU_TLB_RANGE
>> +#endif
> 
> Then you could use the modern override scheme as Lance suggested and you won't
> have any confusion with __HAVE_ARCH_UPDATE_MMU_TLB because it won't exist anymore.

Yes, use update_mmu_tlb_range to implement update_mmu_tlb, we only need 
to define the update_mmu_tlb_range macro.

> 
>> +
>>   /*
>>    * Some architectures may be able to avoid expensive synchronization
>>    * primitives when modifications are made to PTE's which are already
>> diff --git a/mm/memory.c b/mm/memory.c
>> index eea6e4984eae..2d53e29cf76e 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4421,7 +4421,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>   	vm_fault_t ret = 0;
>>   	int nr_pages = 1;
>>   	pte_t entry;
>> -	int i;
>>   
>>   	/* File mapping without ->vm_ops ? */
>>   	if (vma->vm_flags & VM_SHARED)
>> @@ -4491,8 +4490,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>   		update_mmu_tlb(vma, addr, vmf->pte);
>>   		goto release;
>>   	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
>> -		for (i = 0; i < nr_pages; i++)
>> -			update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
>> +		update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
> 
> I certainly agree that this will be a useful helper to have. I expect there will
> be more users in future.

Thank you for your affirmation. Baolin’s "add mTHP support for anonymous 
shmem" series[1] can also use this function to simplify the code.

[1] 
https://lore.kernel.org/linux-mm/cover.1714978902.git.baolin.wang@linux.alibaba.com/

Thanks,
Bang

> 
>>   		goto release;
>>   	}
>>   

