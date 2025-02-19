Return-Path: <linux-kernel+bounces-520830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9944CA3AFD0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE113AAD32
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C13E19259F;
	Wed, 19 Feb 2025 02:51:12 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D58328628D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739933472; cv=none; b=JIIhDAcEunt8Da2cX2HSHEVVUqVJ9ZudnyA2aFZaivnPvWYLhhtwePhkjyr07uuQv8NGQUKf65yP7B6dmh9TX9fClK1RcvWkQ7KLYlEW71gONbov8JnpgqpIGOLbNt7ogMLVP9vg8JlXPqVoX9D0yx5RCFwYnvS6IC42ezvDQUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739933472; c=relaxed/simple;
	bh=QaBtTOSNec6Og6+oajGd0xWOMR5UYMIj7FGBZW7LBwU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eBCSCXQjUJ+bmqxOKqtXM7ywFCD2EL+S/kbaOIh0nt6iVTBjVCMPLmOeXGU5DYKyrE8wyY7tIdEy2zSmH0AKWIX20zCk8sUJ6ZQHCKmVFcbqWhqLjrfN3l6vsCbQp+tBQ0DBCEzFMCCYMoM0/zMDNgsQAIQjfeRTfTjNO08WPQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YyLRP05y1z22stq;
	Wed, 19 Feb 2025 10:48:01 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CC981401F0;
	Wed, 19 Feb 2025 10:51:01 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Feb 2025 10:51:00 +0800
Subject: Re: [PATCH v3 1/3] mm: memory-failure: update ttu flag inside
 unmap_poisoned_folio
To: Wupeng Ma <mawupeng1@huawei.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <osalvador@suse.de>,
	<nao.horiguchi@gmail.com>, <mhocko@suse.com>
References: <20250217014329.3610326-1-mawupeng1@huawei.com>
 <20250217014329.3610326-2-mawupeng1@huawei.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <55e4ad74-752b-65c6-5ceb-b3a7fd7959a1@huawei.com>
Date: Wed, 19 Feb 2025 10:50:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250217014329.3610326-2-mawupeng1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2025/2/17 9:43, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> Commit 6da6b1d4a7df ("mm/hwpoison: convert TTU_IGNORE_HWPOISON to
> TTU_HWPOISON") introduce TTU_HWPOISON to replace TTU_IGNORE_HWPOISON
> in order to stop send SIGBUS signal when accessing an error page after
> a memory error on a clean folio. However during page migration, anon
> folio must be set with TTU_HWPOISON during unmap_*(). For pagecache
> we need some policy just like the one in hwpoison_user_mappings to
> set this flag. So move this policy from hwpoison_user_mappings to
> unmap_poisoned_folio to handle this warning properly.
> 
> Warning will be produced during unamp poison folio with the following log:
> 
>   ------------[ cut here ]------------
>   WARNING: CPU: 1 PID: 365 at mm/rmap.c:1847 try_to_unmap_one+0x8fc/0xd3c
>   Modules linked in:
>   CPU: 1 UID: 0 PID: 365 Comm: bash Tainted: G        W          6.13.0-rc1-00018-gacdb4bbda7ab #42
>   Tainted: [W]=WARN
>   Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
>   pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : try_to_unmap_one+0x8fc/0xd3c
>   lr : try_to_unmap_one+0x3dc/0xd3c
>   Call trace:
>    try_to_unmap_one+0x8fc/0xd3c (P)
>    try_to_unmap_one+0x3dc/0xd3c (L)
>    rmap_walk_anon+0xdc/0x1f8
>    rmap_walk+0x3c/0x58
>    try_to_unmap+0x88/0x90
>    unmap_poisoned_folio+0x30/0xa8
>    do_migrate_range+0x4a0/0x568
>    offline_pages+0x5a4/0x670
>    memory_block_action+0x17c/0x374
>    memory_subsys_offline+0x3c/0x78
>    device_offline+0xa4/0xd0
>    state_store+0x8c/0xf0
>    dev_attr_store+0x18/0x2c
>    sysfs_kf_write+0x44/0x54
>    kernfs_fop_write_iter+0x118/0x1a8
>    vfs_write+0x3a8/0x4bc
>    ksys_write+0x6c/0xf8
>    __arm64_sys_write+0x1c/0x28
>    invoke_syscall+0x44/0x100
>    el0_svc_common.constprop.0+0x40/0xe0
>    do_el0_svc+0x1c/0x28
>    el0_svc+0x30/0xd0
>    el0t_64_sync_handler+0xc8/0xcc
>    el0t_64_sync+0x198/0x19c
>   ---[ end trace 0000000000000000 ]---
> 
> Fixes: 6da6b1d4a7df ("mm/hwpoison: convert TTU_IGNORE_HWPOISON to TTU_HWPOISON")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks. LGTM. One nit below.

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
>  mm/internal.h       |  5 ++--
>  mm/memory-failure.c | 61 +++++++++++++++++++++++----------------------
>  mm/memory_hotplug.c |  3 ++-
>  3 files changed, 36 insertions(+), 33 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 9826f7dce607..c9186ca8d7c2 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1102,7 +1102,7 @@ static inline int find_next_best_node(int node, nodemask_t *used_node_mask)
>   * mm/memory-failure.c
>   */
>  #ifdef CONFIG_MEMORY_FAILURE
> -void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu);
> +int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill);
>  void shake_folio(struct folio *folio);
>  extern int hwpoison_filter(struct page *p);
>  
> @@ -1125,8 +1125,9 @@ unsigned long page_mapped_in_vma(const struct page *page,
>  		struct vm_area_struct *vma);
>  
>  #else
> -static inline void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu)
> +static inline int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill)
>  {
> +	return -EBUSY;
>  }
>  #endif
>  
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a7b8ccd29b6f..b5212b6e330a 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1556,8 +1556,34 @@ static int get_hwpoison_page(struct page *p, unsigned long flags)
>  	return ret;
>  }
>  
> -void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu)
> +int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill)
>  {
> +	enum ttu_flags ttu = TTU_IGNORE_MLOCK | TTU_SYNC | TTU_HWPOISON;
> +	struct address_space *mapping;
> +
> +	if (folio_test_swapcache(folio)) {
> +		pr_err("%#lx: keeping poisoned page in swap cache\n", pfn);
> +		ttu &= ~TTU_HWPOISON;
> +	}
> +
> +	/*
> +	 * Propagate the dirty bit from PTEs to struct page first, because we
> +	 * need this to decide if we should kill or just drop the page.
> +	 * XXX: the dirty test could be racy: set_page_dirty() may not always
> +	 * be called inside page lock (it's recommended but not enforced).
> +	 */
> +	mapping = folio_mapping(folio);
> +	if (!must_kill && !folio_test_dirty(folio) && mapping &&
> +	    mapping_can_writeback(mapping)) {
> +		if (folio_mkclean(folio)) {
> +			folio_set_dirty(folio);
> +		} else {
> +			ttu &= ~TTU_HWPOISON;
> +			pr_info("%#lx: corrupted page was clean: dropped without side effects\n",
> +				pfn);
> +		}
> +	}
> +
>  	if (folio_test_hugetlb(folio) && !folio_test_anon(folio)) {
>  		struct address_space *mapping;

This mapping can be removed as we have already defined one above. But this is trivial.

Thanks.
.

