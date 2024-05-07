Return-Path: <linux-kernel+bounces-170954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA9A8BDE66
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051BC28268F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0EF14E2F6;
	Tue,  7 May 2024 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pLrka0Lu"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7312C14D2B5
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074402; cv=none; b=RjJcArhce08pMEi98haSfqvdrpOgIG7Hrq0ne0LVR2H+BeTBqTSKUGVi9Vzr5Acd/5+c1KYir4Exf6mZYBLwAzGz11TYGvPjgY0jiAhn5CVgvi5qe7fJugyhZzVcZjdCOhARPM7V3OG50RxL7I5w5RxkQOzgCz5upeWTtC7uNS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074402; c=relaxed/simple;
	bh=BYzD9DZm8ky4zklZ02OGKg8jsfq4uW90exzTQmvJGm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UhtS/rZ8mnq0XOG7nEBNsgo9Mkt4b2JpUWhYbZxSg8Xcc6zAWSrIWg2ZaAc/BOSssy389M6JpDaIBK7jrwDiOhBJPsFHvwidH0Bp4zfnjoCz7N0ILGF5XT2l7KKAgBDDbmgSrsGaRSX1/B9KPokZz+NHEDus+DUHQzKo6ZhwyL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pLrka0Lu; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715074395; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=m+W6LCQqw+fad3DX5hnYaBtalOAck6XbEGLoiU/WMjY=;
	b=pLrka0LuW+Pzno6s/zhL5bcclGXXYknmnsKznRDR/3R0yvqs5oyRTdpfgcxDqtZbVbWnMz/KL2g/IyPDpnJ9lLBEHnadyW8JkvQ+0SKXwMHV6jcjiVtaaegEL3DPyqAMd6QOzyHDfTEm+nncytUzcmbrxlhuCpZfFgCdh/Mk6Bg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0W6.oB1W_1715074391;
Received: from 30.236.4.40(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W6.oB1W_1715074391)
          by smtp.aliyun-inc.com;
          Tue, 07 May 2024 17:33:12 +0800
Message-ID: <8c1d6e06-d84b-4be7-81c8-76e2d8fb9883@linux.alibaba.com>
Date: Tue, 7 May 2024 17:33:11 +0800
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
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAK1f24=HYM8zAw88apModHZdaLu849PH=JKPrZ3nxGqQWWzoyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/5/7 16:26, Lance Yang wrote:
> On Tue, May 7, 2024 at 2:32 PM Lance Yang <ioworker0@gmail.com> wrote:
>>
>> Hey Baolin,
>>
>> Thanks a lot for taking time to review!
>>
>> On Tue, May 7, 2024 at 12:01 PM Baolin Wang
>> <baolin.wang@linux.alibaba.com> wrote:
>>>
>>>
>>>
>>> On 2024/5/1 12:27, Lance Yang wrote:
>>>> When the user no longer requires the pages, they would use
>>>> madvise(MADV_FREE) to mark the pages as lazy free. Subsequently, they
>>>> typically would not re-write to that memory again.
>>>>
>>>> During memory reclaim, if we detect that the large folio and its PMD are
>>>> both still marked as clean and there are no unexpected references
>>>> (such as GUP), so we can just discard the memory lazily, improving the
>>>> efficiency of memory reclamation in this case.  On an Intel i5 CPU, reclaiming 1GiB of lazyfree THPs using
>>>> mem_cgroup_force_empty() results in the following runtimes in seconds
>>>> (shorter is better):
>>>>
>>>> --------------------------------------------
>>>> |     Old       |      New       |  Change  |
>>>> --------------------------------------------
>>>> |   0.683426    |    0.049197    |  -92.80% |
>>>> --------------------------------------------
>>>>
>>>> Suggested-by: Zi Yan <ziy@nvidia.com>
>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
>>>> ---
>>>>    include/linux/huge_mm.h |  9 +++++
>>>>    mm/huge_memory.c        | 73 +++++++++++++++++++++++++++++++++++++++++
>>>>    mm/rmap.c               |  3 ++
>>>>    3 files changed, 85 insertions(+)
>>>>
>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>> index 38c4b5537715..017cee864080 100644
>>>> --- a/include/linux/huge_mm.h
>>>> +++ b/include/linux/huge_mm.h
>>>> @@ -411,6 +411,8 @@ static inline bool thp_migration_supported(void)
>>>>
>>>>    void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
>>>>                           pmd_t *pmd, bool freeze, struct folio *folio);
>>>> +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
>>>> +                        pmd_t *pmdp, struct folio *folio);
>>>>
>>>>    static inline void align_huge_pmd_range(struct vm_area_struct *vma,
>>>>                                        unsigned long *start,
>>>> @@ -492,6 +494,13 @@ static inline void align_huge_pmd_range(struct vm_area_struct *vma,
>>>>                                        unsigned long *start,
>>>>                                        unsigned long *end) {}
>>>>
>>>> +static inline bool unmap_huge_pmd_locked(struct vm_area_struct *vma,
>>>> +                                      unsigned long addr, pmd_t *pmdp,
>>>> +                                      struct folio *folio)
>>>> +{
>>>> +     return false;
>>>> +}
>>>> +
>>>>    #define split_huge_pud(__vma, __pmd, __address)     \
>>>>        do { } while (0)
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 145505a1dd05..90fdef847a88 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -2690,6 +2690,79 @@ static void unmap_folio(struct folio *folio)
>>>>        try_to_unmap_flush();
>>>>    }
>>>>
>>>> +static bool __discard_trans_pmd_locked(struct vm_area_struct *vma,
>>>> +                                    unsigned long addr, pmd_t *pmdp,
>>>> +                                    struct folio *folio)
>>>> +{
>>>> +     struct mm_struct *mm = vma->vm_mm;
>>>> +     int ref_count, map_count;
>>>> +     pmd_t orig_pmd = *pmdp;
>>>> +     struct mmu_gather tlb;
>>>> +     struct page *page;
>>>> +
>>>> +     if (pmd_dirty(orig_pmd) || folio_test_dirty(folio))
>>>> +             return false;
>>>> +     if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pmd)))
>>>> +             return false;
>>>> +
>>>> +     page = pmd_page(orig_pmd);
>>>> +     if (unlikely(page_folio(page) != folio))
>>>> +             return false;
>>>> +
>>>> +     tlb_gather_mmu(&tlb, mm);
>>>> +     orig_pmd = pmdp_huge_get_and_clear(mm, addr, pmdp);
>>>> +     tlb_remove_pmd_tlb_entry(&tlb, pmdp, addr);
>>>> +
>>>> +     /*
>>>> +      * Syncing against concurrent GUP-fast:
>>>> +      * - clear PMD; barrier; read refcount
>>>> +      * - inc refcount; barrier; read PMD
>>>> +      */
>>>> +     smp_mb();
>>>> +
>>>> +     ref_count = folio_ref_count(folio);
>>>> +     map_count = folio_mapcount(folio);
>>>> +
>>>> +     /*
>>>> +      * Order reads for folio refcount and dirty flag
>>>> +      * (see comments in __remove_mapping()).
>>>> +      */
>>>> +     smp_rmb();
>>>> +
>>>> +     /*
>>>> +      * If the PMD or folio is redirtied at this point, or if there are
>>>> +      * unexpected references, we will give up to discard this folio
>>>> +      * and remap it.
>>>> +      *
>>>> +      * The only folio refs must be one from isolation plus the rmap(s).
>>>> +      */
>>>> +     if (ref_count != map_count + 1 || folio_test_dirty(folio) ||
>>>> +         pmd_dirty(orig_pmd)) {
>>>> +             set_pmd_at(mm, addr, pmdp, orig_pmd);
>>>> +             return false;
>>>> +     }
>>>> +
>>>> +     folio_remove_rmap_pmd(folio, page, vma);
>>>> +     zap_deposited_table(mm, pmdp);
>>>> +     add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
>>>> +     folio_put(folio);
>>>
>>> IIUC, you missed handling mlock vma, see mlock_drain_local() in
>>> try_to_unmap_one().
>>
>> Good spot!
>>
>> I suddenly realized that I overlooked another thing: If we detect that a
>> PMD-mapped THP is within the range of the VM_LOCKED VMA, we
>> should check whether the TTU_IGNORE_MLOCK flag is set in
>> try_to_unmap_one(). If the flag is set, we will remove the PMD mapping
>> from the folio. Otherwise, the folio should be mlocked, which avoids
>> splitting the folio and then mlocking each page again.
> 
> My previous response above is flawed - sorry :(
> 
> If we detect that a PMD-mapped THP is within the range of the
> VM_LOCKED VMA.
> 
> 1) If the TTU_IGNORE_MLOCK flag is set, we will try to remove the
> PMD mapping from the folio, as this series has done.

Right.

> 2) If the flag is not set, the large folio should be mlocked to prevent it
> from being picked during memory reclaim? Currently, we just leave it

Yes. From commit 1acbc3f93614 ("mm: handle large folio when large folio 
in VM_LOCKED VMA range"), large folios of the mlocked VMA will be 
handled during page reclaim phase.

> as is and do not to mlock it, IIUC.

Original code already handle the mlock case after the PMD-mapped THP is 
split in try_to_unmap_one():
                 /*
                  * If the folio is in an mlock()d vma, we must not swap 
it out.
                  */
                 if (!(flags & TTU_IGNORE_MLOCK) &&
                     (vma->vm_flags & VM_LOCKED)) {
                         /* Restore the mlock which got missed */
                         if (!folio_test_large(folio))
                                 mlock_vma_folio(folio, vma);
                         page_vma_mapped_walk_done(&pvmw);
                         ret = false;
                         break;
                 }

