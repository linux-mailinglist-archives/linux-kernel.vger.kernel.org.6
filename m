Return-Path: <linux-kernel+bounces-330189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2C3979AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C931F21B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96BD224FD;
	Mon, 16 Sep 2024 05:20:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8192F5B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726464053; cv=none; b=MyAakWCLCR7QjYe02nY5FYaeXZis9ARRlUaGeW0eX+COgABMQit5Ob5UpO19vUvfbq3xRM0MCSFiv6gxo243wyp3qS2SIw+y0K3WLaKdDRRiritPfB3tHcLmrbJEZSDMyFjNkwg1hTnhmOz5z1SavbWaiI4GPteJ51c7q06fmq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726464053; c=relaxed/simple;
	bh=WNSkQd4GNL0HT1acuZgMy/6rKqd3G297EujVu+T7teE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahONK4hKXzRIw3inY4ebIBJbG+S+TMxih9Z1xjvm+rReNQrm9YYAPMv5yV3EZZzGvHhg0q3xnLKMM+g5OJtjJKXX7taGic1tn81zPkQcLxxzoCoBlbFcLKX5Ug6Zc56b1aThaiUnenzk9oEF37RJ46DwpOkBSjNjlasKaupmtwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8FD61476;
	Sun, 15 Sep 2024 22:21:18 -0700 (PDT)
Received: from [10.162.42.11] (e116581.arm.com [10.162.42.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70DD93F64C;
	Sun, 15 Sep 2024 22:20:45 -0700 (PDT)
Message-ID: <ba7594d4-5d3c-4950-a1bb-e50b68a74832@arm.com>
Date: Mon, 16 Sep 2024 10:50:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Compute mTHP order efficiently
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, david@redhat.com, willy@infradead.org,
 ryan.roberts@arm.com, anshuman.khandual@arm.com, hughd@google.com,
 ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 baolin.wang@linux.alibaba.com, gshan@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240913091902.1160520-1-dev.jain@arm.com>
 <CAGsJ_4yRadEPiO5H7Nd1jXQ1Gydt43VtUjfQDEp5Q+U9yddTnA@mail.gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <CAGsJ_4yRadEPiO5H7Nd1jXQ1Gydt43VtUjfQDEp5Q+U9yddTnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/16/24 10:42, Barry Song wrote:
> On Fri, Sep 13, 2024 at 5:19 PM Dev Jain <dev.jain@arm.com> wrote:
>> We use pte_range_none() to determine whether contiguous PTEs are empty
>> for an mTHP allocation. Instead of iterating the while loop for every
>> order, use some information, which is the first set PTE found, from the
>> previous iteration, to eliminate some cases. The key to understanding
>> the correctness of the patch is that the ranges we want to examine
>> form a strictly decreasing sequence of nested intervals.
>>
>> Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
> I like this patch, but could we come up with a better subject for
> pte_range_none()?
> The subject is really incorrect.

Are you asking me to change "Compute mTHP order efficiently" to
something else?

>
> Also, I'd prefer the change for alloc_anon_folio() to be separated
> into its own patch.
> So, one patchset with two patches, please.

Fine by me.

>
>> ---
>>   mm/memory.c | 30 +++++++++++++++++++++++-------
>>   1 file changed, 23 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 3c01d68065be..ffc24a48ef15 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4409,26 +4409,27 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>          return ret;
>>   }
>>
>> -static bool pte_range_none(pte_t *pte, int nr_pages)
>> +static int pte_range_none(pte_t *pte, int nr_pages)
>>   {
>>          int i;
>>
>>          for (i = 0; i < nr_pages; i++) {
>>                  if (!pte_none(ptep_get_lockless(pte + i)))
>> -                       return false;
>> +                       return i;
>>          }
>>
>> -       return true;
>> +       return nr_pages;
>>   }
>>
>>   static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>>   {
>>          struct vm_area_struct *vma = vmf->vma;
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +       pte_t *first_set_pte = NULL, *align_pte, *pte;
>>          unsigned long orders;
>>          struct folio *folio;
>>          unsigned long addr;
>> -       pte_t *pte;
>> +       int max_empty;
>>          gfp_t gfp;
>>          int order;
>>
>> @@ -4463,8 +4464,23 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>>          order = highest_order(orders);
>>          while (orders) {
>>                  addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>> -               if (pte_range_none(pte + pte_index(addr), 1 << order))
>> +               align_pte = pte + pte_index(addr);
>> +
>> +               /* Range to be scanned known to be empty */
>> +               if (align_pte + (1 << order) <= first_set_pte)
>>                          break;
>> +
>> +               /* Range to be scanned contains first_set_pte */
>> +               if (align_pte <= first_set_pte)
>> +                       goto repeat;
>> +
>> +               /* align_pte > first_set_pte, so need to check properly */
>> +               max_empty = pte_range_none(align_pte, 1 << order);
>> +               if (max_empty == 1 << order)
>> +                       break;
>> +
>> +               first_set_pte = align_pte + max_empty;
>> +repeat:
>>                  order = next_order(&orders, order);
>>          }
>>
>> @@ -4579,7 +4595,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>          if (nr_pages == 1 && vmf_pte_changed(vmf)) {
>>                  update_mmu_tlb(vma, addr, vmf->pte);
>>                  goto release;
>> -       } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
>> +       } else if (nr_pages > 1 && pte_range_none(vmf->pte, nr_pages) != nr_pages) {
>>                  update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
>>                  goto release;
>>          }
>> @@ -4915,7 +4931,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>                  update_mmu_tlb(vma, addr, vmf->pte);
>>                  ret = VM_FAULT_NOPAGE;
>>                  goto unlock;
>> -       } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
>> +       } else if (nr_pages > 1 && pte_range_none(vmf->pte, nr_pages) != nr_pages) {
>>                  update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
>>                  ret = VM_FAULT_NOPAGE;
>>                  goto unlock;
>> --
>> 2.30.2
>>
> Thanks
> Barry

