Return-Path: <linux-kernel+bounces-448443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125FC9F4029
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A5516C038
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807406F06A;
	Tue, 17 Dec 2024 01:42:35 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431B384D3E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734399755; cv=none; b=iOk37v7GvA4mC0HEo7jVtOY9/KV6tN/zIAmgb5QY7UuuQ87qTk07oSkHiFRlu/5qmSSH+EkSHxl8cGcPMwKIoLXBqDBgZMtcSIY/8kKPCCJFtgfIte6j7G9D4ITUGqlQaLeeclGCELkdEBPME1UMzN70kLx/3TWbOtOE1/DEmmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734399755; c=relaxed/simple;
	bh=Ex+cyQq3a4nJEwGaPpVIHeJAOLuM77xmseUnFdBHamM=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tGgHwsSkElUpVjz28F+3pWz+4AdjI0yzNIJhZb3r15WlMhje//Q3Y/znDHlkOgKYcp2Xn0kQYiSymnURLCbE/YtXbAPZUl8vtseVdpgfSK/m016LyzpxferYs44xqGHks5tNJvT7DeaW36UMzKclhkS3FH1EUj+oF7pMezXc/Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YC01f2Tcjz20m8G;
	Tue, 17 Dec 2024 09:42:46 +0800 (CST)
Received: from kwepemg200013.china.huawei.com (unknown [7.202.181.64])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B3FF1A0188;
	Tue, 17 Dec 2024 09:42:28 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 kwepemg200013.china.huawei.com (7.202.181.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 17 Dec 2024 09:42:27 +0800
Subject: Re: [PATCH v2] mm: hugetlb: independent PMD page table shared count
To: <jane.chu@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Muchun
 Song <muchun.song@linux.dev>, Kenneth W Chen <kenneth.w.chen@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, Nanyong Sun <sunnanyong@huawei.com>
References: <20241216071147.3984217-1-liushixin2@huawei.com>
 <b2c4af25-3213-407e-a366-8c5a0511c30c@oracle.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
From: Liu Shixin <liushixin2@huawei.com>
Message-ID: <060c21b2-3138-15c0-66ff-42895bb956f6@huawei.com>
Date: Tue, 17 Dec 2024 09:42:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b2c4af25-3213-407e-a366-8c5a0511c30c@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200013.china.huawei.com (7.202.181.64)



On 2024/12/17 8:04, jane.chu@oracle.com wrote:
> On 12/15/2024 11:11 PM, Liu Shixin wrote:
>
>> The folio refcount may be increased unexpectly through try_get_folio() by
>> caller such as split_huge_pages. In huge_pmd_unshare(), we use refcount to
>> check whether a pmd page table is shared. The check is incorrect if the
>> refcount is increased by the above caller, and this can cause the page
>> table leaked:
>>
>>   BUG: Bad page state in process sh  pfn:109324
>>   page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x66 pfn:0x109324
>>   flags: 0x17ffff800000000(node=0|zone=2|lastcpupid=0xfffff)
>>   page_type: f2(table)
>>   raw: 017ffff800000000 0000000000000000 0000000000000000 0000000000000000
>>   raw: 0000000000000066 0000000000000000 00000000f2000000 0000000000000000
>>   page dumped because: nonzero mapcount
>>   ...
>>   CPU: 31 UID: 0 PID: 7515 Comm: sh Kdump: loaded Tainted: G    B              6.13.0-rc2master+ #7
>>   Tainted: [B]=BAD_PAGE
>>   Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>>   Call trace:
>>    show_stack+0x20/0x38 (C)
>>    dump_stack_lvl+0x80/0xf8
>>    dump_stack+0x18/0x28
>>    bad_page+0x8c/0x130
>>    free_page_is_bad_report+0xa4/0xb0
>>    free_unref_page+0x3cc/0x620
>>    __folio_put+0xf4/0x158
>>    split_huge_pages_all+0x1e0/0x3e8
>>    split_huge_pages_write+0x25c/0x2d8
>>    full_proxy_write+0x64/0xd8
>>    vfs_write+0xcc/0x280
>>    ksys_write+0x70/0x110
>>    __arm64_sys_write+0x24/0x38
>>    invoke_syscall+0x50/0x120
>>    el0_svc_common.constprop.0+0xc8/0xf0
>>    do_el0_svc+0x24/0x38
>>    el0_svc+0x34/0x128
>>    el0t_64_sync_handler+0xc8/0xd0
>>    el0t_64_sync+0x190/0x198
>>
>> The issue may be triggered by damon, offline_page, page_idle, etc, which
>> will increase the refcount of page table.
>>
>> Fix it by introducing independent PMD page table shared count.
>> As described by comment, pt_index/pt_mm/pt_frag_refcount are used for
>> s390 gmap, x86 pgds and powerpc, pt_share_count is used for x86/arm64/riscv
>> pmds, so we can reuse the field as pt_share_count.
>>
>> Fixes: 39dde65c9940 ("[PATCH] shared page table for hugetlb page")
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
>> v1->v2: Fix build error when !CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING and
>>     modify the changelog.
>
> Sorry for having missed v2 when I responded,  the same  question remains -
>
> https://lore.kernel.org/linux-mm/202412151541.SQEZStgy-lkp@intel.com/T/#m90c26215594e494f5c65c3fa71979b519f0c8481
>
> thanks,
>
> -jane
There's no overlap and the problem has nothing with THP. split_huge_pages refers
to the debugfs file.

In huge_pmd_unshare(), we use refcount to determine whether a page table is sharing,
but the split_huge_pages_all() increased the refcount. As a results, we treat an unshared
page table as shared, and eventually miss freeing the page mapped by this page table.

thanks,

>
>>
>>   include/linux/mm.h       |  1 +
>>   include/linux/mm_types.h | 30 ++++++++++++++++++++++++++++++
>>   mm/hugetlb.c             | 16 +++++++---------
>>   3 files changed, 38 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index c39c4945946c..50fbf2a1b0ad 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3115,6 +3115,7 @@ static inline bool pagetable_pmd_ctor(struct ptdesc *ptdesc)
>>       if (!pmd_ptlock_init(ptdesc))
>>           return false;
>>       __folio_set_pgtable(folio);
>> +    ptdesc_pmd_pts_init(ptdesc);
>>       lruvec_stat_add_folio(folio, NR_PAGETABLE);
>>       return true;
>>   }
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 7361a8f3ab68..332cee285662 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -445,6 +445,7 @@ FOLIO_MATCH(compound_head, _head_2a);
>>    * @pt_index:         Used for s390 gmap.
>>    * @pt_mm:            Used for x86 pgds.
>>    * @pt_frag_refcount: For fragmented page table tracking. Powerpc only.
>> + * @pt_share_count:   Used for HugeTLB PMD page table share count.
>>    * @_pt_pad_2:        Padding to ensure proper alignment.
>>    * @ptl:              Lock for the page table.
>>    * @__page_type:      Same as page->page_type. Unused for page tables.
>> @@ -471,6 +472,9 @@ struct ptdesc {
>>           pgoff_t pt_index;
>>           struct mm_struct *pt_mm;
>>           atomic_t pt_frag_refcount;
>> +#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
>> +        atomic_t pt_share_count;
>> +#endif
>>       };
>>         union {
>> @@ -516,6 +520,32 @@ static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
>>       const struct page *:        (const struct ptdesc *)(p),    \
>>       struct page *:            (struct ptdesc *)(p)))
>>   +#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
>> +static inline void ptdesc_pmd_pts_init(struct ptdesc *ptdesc)
>> +{
>> +    atomic_set(&ptdesc->pt_share_count, 0);
>> +}
>> +
>> +static inline void ptdesc_pmd_pts_inc(struct ptdesc *ptdesc)
>> +{
>> +    atomic_inc(&ptdesc->pt_share_count);
>> +}
>> +
>> +static inline void ptdesc_pmd_pts_dec(struct ptdesc *ptdesc)
>> +{
>> +    atomic_dec(&ptdesc->pt_share_count);
>> +}
>> +
>> +static inline int ptdesc_pmd_pts_count(struct ptdesc *ptdesc)
>> +{
>> +    return atomic_read(&ptdesc->pt_share_count);
>> +}
>> +#else
>> +static inline void ptdesc_pmd_pts_init(struct ptdesc *ptdesc)
>> +{
>> +}
>> +#endif
>> +
>>   /*
>>    * Used for sizing the vmemmap region on some architectures
>>    */
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index ea2ed8e301ef..60846b060b87 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -7212,7 +7212,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>>               spte = hugetlb_walk(svma, saddr,
>>                           vma_mmu_pagesize(svma));
>>               if (spte) {
>> -                get_page(virt_to_page(spte));
>> +                ptdesc_pmd_pts_inc(virt_to_ptdesc(spte));
>>                   break;
>>               }
>>           }
>> @@ -7227,7 +7227,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>>                   (pmd_t *)((unsigned long)spte & PAGE_MASK));
>>           mm_inc_nr_pmds(mm);
>>       } else {
>> -        put_page(virt_to_page(spte));
>> +        ptdesc_pmd_pts_dec(virt_to_ptdesc(spte));
>>       }
>>       spin_unlock(&mm->page_table_lock);
>>   out:
>> @@ -7239,10 +7239,6 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>>   /*
>>    * unmap huge page backed by shared pte.
>>    *
>> - * Hugetlb pte page is ref counted at the time of mapping.  If pte is shared
>> - * indicated by page_count > 1, unmap is achieved by clearing pud and
>> - * decrementing the ref count. If count == 1, the pte page is not shared.
>> - *
>>    * Called with page table lock held.
>>    *
>>    * returns: 1 successfully unmapped a shared pte page
>> @@ -7251,18 +7247,20 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>>   int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>>                       unsigned long addr, pte_t *ptep)
>>   {
>> +    unsigned long sz = huge_page_size(hstate_vma(vma));
>>       pgd_t *pgd = pgd_offset(mm, addr);
>>       p4d_t *p4d = p4d_offset(pgd, addr);
>>       pud_t *pud = pud_offset(p4d, addr);
>>         i_mmap_assert_write_locked(vma->vm_file->f_mapping);
>>       hugetlb_vma_assert_locked(vma);
>> -    BUG_ON(page_count(virt_to_page(ptep)) == 0);
>> -    if (page_count(virt_to_page(ptep)) == 1)
>> +    if (sz != PMD_SIZE)
>> +        return 0;
>> +    if (!ptdesc_pmd_pts_count(virt_to_ptdesc(ptep)))
>>           return 0;
>>         pud_clear(pud);
>> -    put_page(virt_to_page(ptep));
>> +    ptdesc_pmd_pts_dec(virt_to_ptdesc(ptep));
>>       mm_dec_nr_pmds(mm);
>>       return 1;
>>   }
>
> .
>


