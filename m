Return-Path: <linux-kernel+bounces-198754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ACE8D7CFE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0678F2813F9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AB653372;
	Mon,  3 Jun 2024 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Jrc3Naue"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DE3487BF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717401887; cv=none; b=unh1tYO9aoN1JFJNhamS9AQRjkX208lRJ11uGR8SpHT1LKJO4Eak40YGowEcIMErOLDdId+FlZRZ9ipsew/2AXO9cpF5MRqUwScEi59yTVRjSmO0lEJpKipNzGfEytlx+FoDFyNy983b3r1dRmVfccVXNyfiD5l9JbIkng5z0ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717401887; c=relaxed/simple;
	bh=JhG7fTxqtLhhNG58bB7gakwsBxU8x6j5V9O91Y38mmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPY+XinfljFJxtsQC9EpDUKFRVgsKzB5vHBiYzktzQGpif5Ocew+go3ep8hnEe1ioCvRvl/SZxuz70lzynRZSlguS2ezTcRss6ELp3cwgEPYrMNM28wLpn6RHX/+Jxf5iHlNhBG2EtrF9eWbxv/bUQBq9LIeuQE4F11b2hkX6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Jrc3Naue; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717401881; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=o+t7UAkpsXwsI9xsAwJFZS/iROqWU8NNbxxJU91Kwsk=;
	b=Jrc3Naue58w0R/XScmaiX+gVr0vPDDqX0eVN3PROprLZ6NF4NhyGtf0lsaRCkFZDET8FV79q8BVGvd6ugXEY36ZJl4MCI/qULLaThXmxalfKGo5Sg5g2wCzaYGMT6BJWiWa7/fYnJDrcl2klhgR9wEY3LHCTKimrQnWi64s5Z7Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W7kFySD_1717401878;
Received: from 30.97.56.74(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7kFySD_1717401878)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 16:04:39 +0800
Message-ID: <2ce6d815-541d-497c-8eba-3d5099e8dcd5@linux.alibaba.com>
Date: Mon, 3 Jun 2024 16:04:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] mm: memory: extend finish_fault() to support large
 folio
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, da.gomez@samsung.com, p.raghav@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Bang Li <libang.li@antgroup.com>
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
 <bf80d4a792ea82ab066f819ad7d10ed22a2f8e66.1717033868.git.baolin.wang@linux.alibaba.com>
 <CAK1f24nxQi4ER+fLioHmOpH3dgGbhdyDiSvfwidEz-oSuWyAYA@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAK1f24nxQi4ER+fLioHmOpH3dgGbhdyDiSvfwidEz-oSuWyAYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/3 12:44, Lance Yang wrote:
> On Thu, May 30, 2024 at 10:04 AM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Add large folio mapping establishment support for finish_fault() as a preparation,
>> to support multi-size THP allocation of anonymous shmem pages in the following
>> patches.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/memory.c | 58 ++++++++++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 48 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index eef4e482c0c2..435187ff7ea4 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4831,9 +4831,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>   {
>>          struct vm_area_struct *vma = vmf->vma;
>>          struct page *page;
>> +       struct folio *folio;
>>          vm_fault_t ret;
>>          bool is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
>>                        !(vma->vm_flags & VM_SHARED);
>> +       int type, nr_pages, i;
>> +       unsigned long addr = vmf->address;
>>
>>          /* Did we COW the page? */
>>          if (is_cow)
>> @@ -4864,24 +4867,59 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>                          return VM_FAULT_OOM;
>>          }
>>
>> +       folio = page_folio(page);
>> +       nr_pages = folio_nr_pages(folio);
>> +
>> +       /*
>> +        * Using per-page fault to maintain the uffd semantics, and same
>> +        * approach also applies to non-anonymous-shmem faults to avoid
>> +        * inflating the RSS of the process.
>> +        */
>> +       if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))) {
>> +               nr_pages = 1;
>> +       } else if (nr_pages > 1) {
>> +               pgoff_t idx = folio_page_idx(folio, page);
>> +               /* The page offset of vmf->address within the VMA. */
>> +               pgoff_t vma_off = vmf->pgoff - vmf->vma->vm_pgoff;
>> +
>> +               /*
>> +                * Fallback to per-page fault in case the folio size in page
>> +                * cache beyond the VMA limits.
>> +                */
>> +               if (unlikely(vma_off < idx ||
>> +                            vma_off + (nr_pages - idx) > vma_pages(vma))) {
>> +                       nr_pages = 1;
>> +               } else {
>> +                       /* Now we can set mappings for the whole large folio. */
>> +                       addr = vmf->address - idx * PAGE_SIZE;
>> +                       page = &folio->page;
>> +               }
>> +       }
>> +
>>          vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>> -                                     vmf->address, &vmf->ptl);
>> +                                      addr, &vmf->ptl);
>>          if (!vmf->pte)
>>                  return VM_FAULT_NOPAGE;
>>
>>          /* Re-check under ptl */
>> -       if (likely(!vmf_pte_changed(vmf))) {
>> -               struct folio *folio = page_folio(page);
>> -               int type = is_cow ? MM_ANONPAGES : mm_counter_file(folio);
>> -
>> -               set_pte_range(vmf, folio, page, 1, vmf->address);
>> -               add_mm_counter(vma->vm_mm, type, 1);
>> -               ret = 0;
>> -       } else {
>> -               update_mmu_tlb(vma, vmf->address, vmf->pte);
>> +       if (nr_pages == 1 && unlikely(vmf_pte_changed(vmf))) {
>> +               update_mmu_tlb(vma, addr, vmf->pte);
>>                  ret = VM_FAULT_NOPAGE;
>> +               goto unlock;
>> +       } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
>> +               for (i = 0; i < nr_pages; i++)
>> +                       update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
> 
> Just a friendly reminder: Bang has added the update_mmu_tlb_range()[1] batch
> function to update TLB in batches, so we can use it instead of the
> update_mmu_tlb()
> loop.
> 
> [1] https://lore.kernel.org/linux-mm/20240522061204.117421-1-libang.li@antgroup.com/

Good point, I will use the new helper instead.

