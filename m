Return-Path: <linux-kernel+bounces-520848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18703A3B00C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 04:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0075B3A5DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF9019D8A9;
	Wed, 19 Feb 2025 03:34:21 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DA8136A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739936060; cv=none; b=caY+vq49p6UtNBMaDTcLuwBU37SW/sEgPd5GjP8hCpMK8vYP0cXzSs4CdRBw8OJI6U0QoVhnlELYQWhBTgVl6Qvfo7Zsp1NvAGghcACuewO6kfGGRh9l5EVYixQ6Tg/VOoyPnTVMXDiZmfkO7dwTNAoBH1Y96gMddeK0LH1oQOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739936060; c=relaxed/simple;
	bh=aXUT4dlyb+UYLtC39KF3C9ZrU2dc3dLEl1h6DlfA5kQ=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ctBW5ttIEDIEb56YohgoceiqhkjUgMEqKJ39uVH7Cm/9yCizc34IEuEv+i5UL9HWXbZ4e1/oSsKV0qxklRzRX0HROwL09b7XjCTh8x3iX8LV1/s8mtdto9uJLASXno5d6lkSnQcZP68syfh1egPg8uUaAJC8V1HFuR86Y4JyKfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YyMPF6FRSz22wRQ;
	Wed, 19 Feb 2025 11:31:13 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id E5827140120;
	Wed, 19 Feb 2025 11:34:13 +0800 (CST)
Received: from [10.174.178.114] (10.174.178.114) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Feb 2025 11:34:13 +0800
Message-ID: <783bfb90-c298-410c-893c-d497a1a2727f@huawei.com>
Date: Wed, 19 Feb 2025 11:34:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<david@redhat.com>, <osalvador@suse.de>, <nao.horiguchi@gmail.com>,
	<mhocko@suse.com>
Subject: Re: [PATCH v3 1/3] mm: memory-failure: update ttu flag inside
 unmap_poisoned_folio
To: <linmiaohe@huawei.com>
References: <20250217014329.3610326-1-mawupeng1@huawei.com>
 <20250217014329.3610326-2-mawupeng1@huawei.com>
 <55e4ad74-752b-65c6-5ceb-b3a7fd7959a1@huawei.com>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <55e4ad74-752b-65c6-5ceb-b3a7fd7959a1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg100017.china.huawei.com (7.202.181.58)



On 2025/2/19 10:50, Miaohe Lin wrote:
> On 2025/2/17 9:43, Wupeng Ma wrote:
>> From: Ma Wupeng <mawupeng1@huawei.com>
>>
>> Commit 6da6b1d4a7df ("mm/hwpoison: convert TTU_IGNORE_HWPOISON to
>> TTU_HWPOISON") introduce TTU_HWPOISON to replace TTU_IGNORE_HWPOISON
>> in order to stop send SIGBUS signal when accessing an error page after
>> a memory error on a clean folio. However during page migration, anon
>> folio must be set with TTU_HWPOISON during unmap_*(). For pagecache
>> we need some policy just like the one in hwpoison_user_mappings to
>> set this flag. So move this policy from hwpoison_user_mappings to
>> unmap_poisoned_folio to handle this warning properly.
>>
>> Warning will be produced during unamp poison folio with the following log:
>>
>>   ------------[ cut here ]------------
>>   WARNING: CPU: 1 PID: 365 at mm/rmap.c:1847 try_to_unmap_one+0x8fc/0xd3c
>>   Modules linked in:
>>   CPU: 1 UID: 0 PID: 365 Comm: bash Tainted: G        W          6.13.0-rc1-00018-gacdb4bbda7ab #42
>>   Tainted: [W]=WARN
>>   Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
>>   pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>   pc : try_to_unmap_one+0x8fc/0xd3c
>>   lr : try_to_unmap_one+0x3dc/0xd3c
>>   Call trace:
>>    try_to_unmap_one+0x8fc/0xd3c (P)
>>    try_to_unmap_one+0x3dc/0xd3c (L)
>>    rmap_walk_anon+0xdc/0x1f8
>>    rmap_walk+0x3c/0x58
>>    try_to_unmap+0x88/0x90
>>    unmap_poisoned_folio+0x30/0xa8
>>    do_migrate_range+0x4a0/0x568
>>    offline_pages+0x5a4/0x670
>>    memory_block_action+0x17c/0x374
>>    memory_subsys_offline+0x3c/0x78
>>    device_offline+0xa4/0xd0
>>    state_store+0x8c/0xf0
>>    dev_attr_store+0x18/0x2c
>>    sysfs_kf_write+0x44/0x54
>>    kernfs_fop_write_iter+0x118/0x1a8
>>    vfs_write+0x3a8/0x4bc
>>    ksys_write+0x6c/0xf8
>>    __arm64_sys_write+0x1c/0x28
>>    invoke_syscall+0x44/0x100
>>    el0_svc_common.constprop.0+0x40/0xe0
>>    do_el0_svc+0x1c/0x28
>>    el0_svc+0x30/0xd0
>>    el0t_64_sync_handler+0xc8/0xcc
>>    el0t_64_sync+0x198/0x19c
>>   ---[ end trace 0000000000000000 ]---
>>
>> Fixes: 6da6b1d4a7df ("mm/hwpoison: convert TTU_IGNORE_HWPOISON to TTU_HWPOISON")
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> Thanks. LGTM. One nit below.
> 
> Acked-by: Miaohe Lin <linmiaohe@huawei.com>
> 
>> ---
>>  mm/internal.h       |  5 ++--
>>  mm/memory-failure.c | 61 +++++++++++++++++++++++----------------------
>>  mm/memory_hotplug.c |  3 ++-
>>  3 files changed, 36 insertions(+), 33 deletions(-)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 9826f7dce607..c9186ca8d7c2 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -1102,7 +1102,7 @@ static inline int find_next_best_node(int node, nodemask_t *used_node_mask)
>>   * mm/memory-failure.c
>>   */
>>  #ifdef CONFIG_MEMORY_FAILURE
>> -void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu);
>> +int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill);
>>  void shake_folio(struct folio *folio);
>>  extern int hwpoison_filter(struct page *p);
>>  
>> @@ -1125,8 +1125,9 @@ unsigned long page_mapped_in_vma(const struct page *page,
>>  		struct vm_area_struct *vma);
>>  
>>  #else
>> -static inline void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu)
>> +static inline int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill)
>>  {
>> +	return -EBUSY;
>>  }
>>  #endif
>>  
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index a7b8ccd29b6f..b5212b6e330a 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1556,8 +1556,34 @@ static int get_hwpoison_page(struct page *p, unsigned long flags)
>>  	return ret;
>>  }
>>  
>> -void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu)
>> +int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill)
>>  {
>> +	enum ttu_flags ttu = TTU_IGNORE_MLOCK | TTU_SYNC | TTU_HWPOISON;
>> +	struct address_space *mapping;
>> +
>> +	if (folio_test_swapcache(folio)) {
>> +		pr_err("%#lx: keeping poisoned page in swap cache\n", pfn);
>> +		ttu &= ~TTU_HWPOISON;
>> +	}
>> +
>> +	/*
>> +	 * Propagate the dirty bit from PTEs to struct page first, because we
>> +	 * need this to decide if we should kill or just drop the page.
>> +	 * XXX: the dirty test could be racy: set_page_dirty() may not always
>> +	 * be called inside page lock (it's recommended but not enforced).
>> +	 */
>> +	mapping = folio_mapping(folio);
>> +	if (!must_kill && !folio_test_dirty(folio) && mapping &&
>> +	    mapping_can_writeback(mapping)) {
>> +		if (folio_mkclean(folio)) {
>> +			folio_set_dirty(folio);
>> +		} else {
>> +			ttu &= ~TTU_HWPOISON;
>> +			pr_info("%#lx: corrupted page was clean: dropped without side effects\n",
>> +				pfn);
>> +		}
>> +	}
>> +
>>  	if (folio_test_hugetlb(folio) && !folio_test_anon(folio)) {
>>  		struct address_space *mapping;
> 
> This mapping can be removed as we have already defined one above. But this is trivial.

Thanks.

I will resend this patch with the duplicate defination removed.

> 
> Thanks.
> .


