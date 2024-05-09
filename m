Return-Path: <linux-kernel+bounces-174354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 905EF8C0D89
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4755928362C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E0414A623;
	Thu,  9 May 2024 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LlUd4/FE"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCADA1494D9
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715247370; cv=none; b=UQi06OSr3mMw9VheIRmMcd2/EPE8O42cjV0f2tpNOumLop3hAFYlkDJ+9qPKAEKQyj3a/JQT+Is6T+hK1wyEFVxaUT2jHw6inJ6fM9bD9UT7VWtF8HgQeMcP+TCzWVeHE6ZkCSs+XcPn5AwYC2AfFmJQd0PA/ImqNqO4TyOB6Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715247370; c=relaxed/simple;
	bh=5V0THLtjlGm7lz2Rb8dkX2TumoFDGOdEzv+qTisTZBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z3rdJou46S0ci9NSEXMBAFXEpKPyPLOEwz+ClialtcDSJe0g0F0TdCtUSs/pSEUM5Xqp6qKwxUpWAdQ6jYd5QqxGfu8BpdhdyNk0A3akafwrxheCmPqeOu6TrXmQhmuhRvCkbSha+wI6a6l6O+ElBHQUfiaNWjKhgpZwO6Q61Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LlUd4/FE; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715247365; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pvNda+d/dgY+J2GX1dZdTaOZdRlBWeQizib67djYoac=;
	b=LlUd4/FE304IT+LKS+icoj0rJeipkA26ZIcACtISj95vIOZUjjjh5oyX4Vtx7Yt7nXnN6X9UAFMVRGft5l1Wm0ZFQrnd8dCCV//DVXlxrdKGnKyOekDH0+3vMtsciSNvUJKmAPVTU48Yr4wNdxc4CMD9FB1Ol1THinTHuQCh7hI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0W66VJRi_1715247361;
Received: from 30.97.56.60(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W66VJRi_1715247361)
          by smtp.aliyun-inc.com;
          Thu, 09 May 2024 17:36:03 +0800
Message-ID: <c49e2663-a7a6-410d-b694-59cd3fb28c78@linux.alibaba.com>
Date: Thu, 9 May 2024 17:36:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] mm/vmscan: avoid split lazyfree THP during
 shrink_folio_list()
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org,
 maskray@google.com, ziy@nvidia.com, ryan.roberts@arm.com, david@redhat.com,
 21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com,
 zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com,
 libang.li@antgroup.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240501042700.83974-1-ioworker0@gmail.com>
 <20240501042700.83974-4-ioworker0@gmail.com>
 <e0b8a282-973f-41f7-a878-4a287bab81ea@linux.alibaba.com>
 <CAK1f24=gc7VojzSDyNck-03L03UWR4AFxji8Rw+xMKBg1_M7fw@mail.gmail.com>
 <CAK1f24=HYM8zAw88apModHZdaLu849PH=JKPrZ3nxGqQWWzoyQ@mail.gmail.com>
 <8c1d6e06-d84b-4be7-81c8-76e2d8fb9883@linux.alibaba.com>
 <CAK1f24=+-jtjUpyNEXQyhgtGeqKEXr1tRN89Nzg3WQONAZEMMw@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAK1f24=+-jtjUpyNEXQyhgtGeqKEXr1tRN89Nzg3WQONAZEMMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/5/7 19:37, Lance Yang wrote:
> On Tue, May 7, 2024 at 5:33 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2024/5/7 16:26, Lance Yang wrote:
>>> On Tue, May 7, 2024 at 2:32 PM Lance Yang <ioworker0@gmail.com> wrote:
>>>>
>>>> Hey Baolin,
>>>>
>>>> Thanks a lot for taking time to review!
>>>>
>>>> On Tue, May 7, 2024 at 12:01 PM Baolin Wang
>>>> <baolin.wang@linux.alibaba.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2024/5/1 12:27, Lance Yang wrote:
>>>>>> When the user no longer requires the pages, they would use
>>>>>> madvise(MADV_FREE) to mark the pages as lazy free. Subsequently, they
>>>>>> typically would not re-write to that memory again.
>>>>>>
>>>>>> During memory reclaim, if we detect that the large folio and its PMD are
>>>>>> both still marked as clean and there are no unexpected references
>>>>>> (such as GUP), so we can just discard the memory lazily, improving the
>>>>>> efficiency of memory reclamation in this case.  On an Intel i5 CPU, reclaiming 1GiB of lazyfree THPs using
>>>>>> mem_cgroup_force_empty() results in the following runtimes in seconds
>>>>>> (shorter is better):
>>>>>>
>>>>>> --------------------------------------------
>>>>>> |     Old       |      New       |  Change  |
>>>>>> --------------------------------------------
>>>>>> |   0.683426    |    0.049197    |  -92.80% |
>>>>>> --------------------------------------------
>>>>>>
>>>>>> Suggested-by: Zi Yan <ziy@nvidia.com>
>>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
>>>>>> ---
>>>>>>     include/linux/huge_mm.h |  9 +++++
>>>>>>     mm/huge_memory.c        | 73 +++++++++++++++++++++++++++++++++++++++++
>>>>>>     mm/rmap.c               |  3 ++
>>>>>>     3 files changed, 85 insertions(+)
>>>>>>
>>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>>>> index 38c4b5537715..017cee864080 100644
>>>>>> --- a/include/linux/huge_mm.h
>>>>>> +++ b/include/linux/huge_mm.h
>>>>>> @@ -411,6 +411,8 @@ static inline bool thp_migration_supported(void)
>>>>>>
>>>>>>     void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
>>>>>>                            pmd_t *pmd, bool freeze, struct folio *folio);
>>>>>> +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
>>>>>> +                        pmd_t *pmdp, struct folio *folio);
>>>>>>
>>>>>>     static inline void align_huge_pmd_range(struct vm_area_struct *vma,
>>>>>>                                         unsigned long *start,
>>>>>> @@ -492,6 +494,13 @@ static inline void align_huge_pmd_range(struct vm_area_struct *vma,
>>>>>>                                         unsigned long *start,
>>>>>>                                         unsigned long *end) {}
>>>>>>
>>>>>> +static inline bool unmap_huge_pmd_locked(struct vm_area_struct *vma,
>>>>>> +                                      unsigned long addr, pmd_t *pmdp,
>>>>>> +                                      struct folio *folio)
>>>>>> +{
>>>>>> +     return false;
>>>>>> +}
>>>>>> +
>>>>>>     #define split_huge_pud(__vma, __pmd, __address)     \
>>>>>>         do { } while (0)
>>>>>>
>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>>> index 145505a1dd05..90fdef847a88 100644
>>>>>> --- a/mm/huge_memory.c
>>>>>> +++ b/mm/huge_memory.c
>>>>>> @@ -2690,6 +2690,79 @@ static void unmap_folio(struct folio *folio)
>>>>>>         try_to_unmap_flush();
>>>>>>     }
>>>>>>
>>>>>> +static bool __discard_trans_pmd_locked(struct vm_area_struct *vma,
>>>>>> +                                    unsigned long addr, pmd_t *pmdp,
>>>>>> +                                    struct folio *folio)
>>>>>> +{
>>>>>> +     struct mm_struct *mm = vma->vm_mm;
>>>>>> +     int ref_count, map_count;
>>>>>> +     pmd_t orig_pmd = *pmdp;
>>>>>> +     struct mmu_gather tlb;
>>>>>> +     struct page *page;
>>>>>> +
>>>>>> +     if (pmd_dirty(orig_pmd) || folio_test_dirty(folio))
>>>>>> +             return false;
>>>>>> +     if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pmd)))
>>>>>> +             return false;
>>>>>> +
>>>>>> +     page = pmd_page(orig_pmd);
>>>>>> +     if (unlikely(page_folio(page) != folio))
>>>>>> +             return false;
>>>>>> +
>>>>>> +     tlb_gather_mmu(&tlb, mm);
>>>>>> +     orig_pmd = pmdp_huge_get_and_clear(mm, addr, pmdp);
>>>>>> +     tlb_remove_pmd_tlb_entry(&tlb, pmdp, addr);
>>>>>> +
>>>>>> +     /*
>>>>>> +      * Syncing against concurrent GUP-fast:
>>>>>> +      * - clear PMD; barrier; read refcount
>>>>>> +      * - inc refcount; barrier; read PMD
>>>>>> +      */
>>>>>> +     smp_mb();
>>>>>> +
>>>>>> +     ref_count = folio_ref_count(folio);
>>>>>> +     map_count = folio_mapcount(folio);
>>>>>> +
>>>>>> +     /*
>>>>>> +      * Order reads for folio refcount and dirty flag
>>>>>> +      * (see comments in __remove_mapping()).
>>>>>> +      */
>>>>>> +     smp_rmb();
>>>>>> +
>>>>>> +     /*
>>>>>> +      * If the PMD or folio is redirtied at this point, or if there are
>>>>>> +      * unexpected references, we will give up to discard this folio
>>>>>> +      * and remap it.
>>>>>> +      *
>>>>>> +      * The only folio refs must be one from isolation plus the rmap(s).
>>>>>> +      */
>>>>>> +     if (ref_count != map_count + 1 || folio_test_dirty(folio) ||
>>>>>> +         pmd_dirty(orig_pmd)) {
>>>>>> +             set_pmd_at(mm, addr, pmdp, orig_pmd);
>>>>>> +             return false;
>>>>>> +     }
>>>>>> +
>>>>>> +     folio_remove_rmap_pmd(folio, page, vma);
>>>>>> +     zap_deposited_table(mm, pmdp);
>>>>>> +     add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
>>>>>> +     folio_put(folio);
>>>>>
>>>>> IIUC, you missed handling mlock vma, see mlock_drain_local() in
>>>>> try_to_unmap_one().
>>>>
>>>> Good spot!
>>>>
>>>> I suddenly realized that I overlooked another thing: If we detect that a
>>>> PMD-mapped THP is within the range of the VM_LOCKED VMA, we
>>>> should check whether the TTU_IGNORE_MLOCK flag is set in
>>>> try_to_unmap_one(). If the flag is set, we will remove the PMD mapping
>>>> from the folio. Otherwise, the folio should be mlocked, which avoids
>>>> splitting the folio and then mlocking each page again.
>>>
>>> My previous response above is flawed - sorry :(
>>>
>>> If we detect that a PMD-mapped THP is within the range of the
>>> VM_LOCKED VMA.
>>>
>>> 1) If the TTU_IGNORE_MLOCK flag is set, we will try to remove the
>>> PMD mapping from the folio, as this series has done.
>>
>> Right.
>>
>>> 2) If the flag is not set, the large folio should be mlocked to prevent it
>>> from being picked during memory reclaim? Currently, we just leave it
>>
>> Yes. From commit 1acbc3f93614 ("mm: handle large folio when large folio
>> in VM_LOCKED VMA range"), large folios of the mlocked VMA will be
>> handled during page reclaim phase.
>>
>>> as is and do not to mlock it, IIUC.
>>
>> Original code already handle the mlock case after the PMD-mapped THP is
>> split in try_to_unmap_one():
> 
> Yep. But this series doesn't do the TTU_SPLIT_HUGE_PMD immediately.
> 
>>                   /*
>>                    * If the folio is in an mlock()d vma, we must not swap
>> it out.
>>                    */
>>                   if (!(flags & TTU_IGNORE_MLOCK) &&
>>                       (vma->vm_flags & VM_LOCKED)) {
>>                           /* Restore the mlock which got missed */
> 
> IIUC, we could detect a PMD-mapped THP here. So, I'm not sure if we
> need to mlock it to prevent it from being picked again during memory
> reclaim. The change is as follows:

For the page reclaim path, folio_check_references() should be able to 
help restore the mlock of the PMD-mapped THP. However, for other paths 
that call try_to_unmap(), I believe it is still necessary to check 
whether the mlock of the PMD-mapped THP was missed.

Below code looks reasonable to me from a quick glance.

> diff --git a/mm/rmap.c b/mm/rmap.c
> index ed7f82036986..2a9d037ab23c 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1673,7 +1673,8 @@ static bool try_to_unmap_one(struct folio
> *folio, struct vm_area_struct *vma,
>                  if (!(flags & TTU_IGNORE_MLOCK) &&
>                      (vma->vm_flags & VM_LOCKED)) {
>                          /* Restore the mlock which got missed */
> -                       if (!folio_test_large(folio))
> +                       if (!folio_test_large(folio) ||
> +                           (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)))
>                                  mlock_vma_folio(folio, vma);
>                          goto walk_done_err;
>                  }
> 


