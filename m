Return-Path: <linux-kernel+bounces-170611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF7C8BD9B3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33797283134
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C013FB9F;
	Tue,  7 May 2024 03:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="ZyzpYOlQ"
Received: from out0-205.mail.aliyun.com (out0-205.mail.aliyun.com [140.205.0.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694A98F59
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 03:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715052391; cv=none; b=WBYUxDzPHUmJ/+2H6/AAl5dRe/FqHQ6Z/QQX5dqrixv7rv8e96DAR2gjm0ubRwEHQUJ5cbUjWTlJSv2BvLKWe55n90KDGbo7pGE5/DErebe4/XGxtLAKdjHnrFvR66vc2E8Vb0G6vWnnMFceD3VZ7Qvf72lANJIKrRJRcRQV9zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715052391; c=relaxed/simple;
	bh=iHuRD/dtOgMuKMHeBX+HNdWTT10H1EJDGlz7gP05Kv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEBNV6rW9qzsYeqqg1baSiaM5WmjKa14FLkwDCFc/+m3R4cIv0P2tTyRgulMmKJKSnJ8DUXH2nVxrN8H8cTgNuWIIujHDjZJaf3fZ9cCf+efZ3XMVLV0Sc9KVFjljLo/O8vAo+FDu26W9b7Klge4IQd6RcW77aRbPwqwCrfvXNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=ZyzpYOlQ; arc=none smtp.client-ip=140.205.0.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1715052384; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5G08kj7fI6VhU0nVl7AlR+J897u+++S/y5nHUajrQj8=;
	b=ZyzpYOlQBVti3aUO6gWt5/JahWz5Q7gUt59jjVE9DOu+GV1bBet0zeEL3P+ZDp8FZsEjEkTcXFSQRiFL6V/4Eat2IyKSKJkJ9G9V1+C81fCMARBc13m6qplYvJODwCO3QeTI5zlJ7un9p24bml4IbNxihtFOCeTj+o98OmD3zEs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047187;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---.XU6c0Rr_1715052381;
Received: from 30.230.85.161(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XU6c0Rr_1715052381)
          by smtp.aliyun-inc.com;
          Tue, 07 May 2024 11:26:22 +0800
Message-ID: <9d251090-ed68-49a2-9e94-7347b71367b3@antgroup.com>
Date: Tue, 07 May 2024 11:26:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] mm: Add update_mmu_tlb_range()
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, chenhuacai@kernel.org,
 tsbogend@alpha.franken.de, paul.walmsley@sifive.com, palmer@dabbelt.com,
 chris@zankel.net, jcmvbkbc@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, david@redhat.com, ryan.roberts@arm.com,
 libang.linux@gmail.com
References: <20240506155120.83105-1-libang.li@antgroup.com>
 <20240506155120.83105-6-libang.li@antgroup.com>
 <CAK1f24nX6mvLXiXNJUQWSKKUQ-Avhs0_NU1k8JBhVupOr3W6Mg@mail.gmail.com>
Content-Language: en-US
From: "Bang Li" <libang.li@antgroup.com>
In-Reply-To: <CAK1f24nX6mvLXiXNJUQWSKKUQ-Avhs0_NU1k8JBhVupOr3W6Mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey Lance,

Thanks for taking time to review!

On 2024/5/7 0:07, Lance Yang wrote:
> On Mon, May 6, 2024 at 11:52 PM Bang Li <libang.li@antgroup.com> wrote:
>>
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
>>
>> +#ifndef __HAVE_ARCH_UPDATE_MMU_TLB_RANGE
> 
> IIRC, the contemporary practice is to define a macro with the same name
> as the function if it is being overridden.

The macro __HAVE_ARCH_UPDATE_MMU_TLB_RANGE defined here is aligned with
the macro __HAVE_ARCH_UPDATE_MMU_TLB corresponding to the update_mmu_tlb
function. IMO, it should be better to use my method in this case.

Thanks,
Bang

> 
> Thanks,
> Lance
> 
>> +static inline void update_mmu_tlb_range(struct vm_area_struct *vma,
>> +                               unsigned long address, pte_t *ptep, unsigned int nr)
>> +{
>> +}
>> +#define __HAVE_ARCH_UPDATE_MMU_TLB_RANGE
>> +#endif
>> +
>>   /*
>>    * Some architectures may be able to avoid expensive synchronization
>>    * primitives when modifications are made to PTE's which are already
>> diff --git a/mm/memory.c b/mm/memory.c
>> index eea6e4984eae..2d53e29cf76e 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4421,7 +4421,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>          vm_fault_t ret = 0;
>>          int nr_pages = 1;
>>          pte_t entry;
>> -       int i;
>>
>>          /* File mapping without ->vm_ops ? */
>>          if (vma->vm_flags & VM_SHARED)
>> @@ -4491,8 +4490,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>                  update_mmu_tlb(vma, addr, vmf->pte);
>>                  goto release;
>>          } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
>> -               for (i = 0; i < nr_pages; i++)
>> -                       update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
>> +               update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
>>                  goto release;
>>          }
>>
>> --
>> 2.19.1.6.gb485710b
>>

