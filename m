Return-Path: <linux-kernel+bounces-178345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F57F8C4C40
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 08:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61037B20F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 06:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867671CF8A;
	Tue, 14 May 2024 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="s46wcQxN"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B653F182AE
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715668020; cv=none; b=ga9vuWTylI7/atIRF2nSSgoVcPm6ZxbZLfOGEyaSNfKv3mlmwXcJbG0ni6eVL/m05VTOG7jTtq+l+q4LISsfk3jkVeBY+h/7+nkQD412yQjGzHBgpxBYnnUmWbfw1df5PqZXCA/+f5dDT1S5P9Zh7pSmaO6UtjjOm51P+I3mZ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715668020; c=relaxed/simple;
	bh=QE6Wti0b8XigHlbkBmJfp3gGZbpOAkkYLGDlVyAoFXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ldjUMloAQ0Wt6Ao6jUDc5CnJwkAZJx4Og/pw4dYvInN8paOt9R+apdDnt8GnpWOaB1olXASoABjYCK/w+vTW8dtoY5JhJkDc0TNO74lyJVmvwJJYCtbUgI70XSjRNNmGE4U/W6lsmOUCCahtEorDnuWx/BgHs/wRCqZWciE9W1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=s46wcQxN; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715668008; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Iaw3Fzp7EZ7n49UyApJLTDj5ana4lJ0BhvUxOfLYc/o=;
	b=s46wcQxNX3hh7JnsZ/8BZpW9WOlkIncTCNcwWl16WHPulBkwICNF3MWw0NtlrlvHZFTSnraDYmxEULUxJT1S19ftOkVsztrfVhcw6DIkbSIWVopMMyG7xwtOihDETOaQ65FQEZaBsumMPuI+NFI3zejGrsji3wtBtnQo17hlCRA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0W6U.btc_1715668004;
Received: from 30.97.56.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W6U.btc_1715668004)
          by smtp.aliyun-inc.com;
          Tue, 14 May 2024 14:26:46 +0800
Message-ID: <2ec286a2-4620-4e6d-ad3d-9b4c0d9e1394@linux.alibaba.com>
Date: Tue, 14 May 2024 14:26:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 1/4] mm/rmap: remove duplicated exit code in
 pagewalk loop
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, sj@kernel.org, maskray@google.com, ziy@nvidia.com,
 ryan.roberts@arm.com, david@redhat.com, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, libang.li@antgroup.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240513074712.7608-1-ioworker0@gmail.com>
 <20240513074712.7608-2-ioworker0@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240513074712.7608-2-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/13 15:47, Lance Yang wrote:
> Introduce the labels walk_done and walk_done_err as exit points to
> eliminate duplicated exit code in the pagewalk loop.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/rmap.c | 40 +++++++++++++++-------------------------
>   1 file changed, 15 insertions(+), 25 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index e8fc5ecb59b2..ddffa30c79fb 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1679,9 +1679,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   			/* Restore the mlock which got missed */
>   			if (!folio_test_large(folio))
>   				mlock_vma_folio(folio, vma);
> -			page_vma_mapped_walk_done(&pvmw);
> -			ret = false;
> -			break;
> +			goto walk_done_err;
>   		}
>   
>   		pfn = pte_pfn(ptep_get(pvmw.pte));
> @@ -1719,11 +1717,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   			 */
>   			if (!anon) {
>   				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
> -				if (!hugetlb_vma_trylock_write(vma)) {
> -					page_vma_mapped_walk_done(&pvmw);
> -					ret = false;
> -					break;
> -				}
> +				if (!hugetlb_vma_trylock_write(vma))
> +					goto walk_done_err;
>   				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
>   					hugetlb_vma_unlock_write(vma);
>   					flush_tlb_range(vma,
> @@ -1738,8 +1733,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   					 * actual page and drop map count
>   					 * to zero.
>   					 */
> -					page_vma_mapped_walk_done(&pvmw);
> -					break;
> +					goto walk_done;
>   				}
>   				hugetlb_vma_unlock_write(vma);
>   			}
> @@ -1811,9 +1805,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   			if (unlikely(folio_test_swapbacked(folio) !=
>   					folio_test_swapcache(folio))) {
>   				WARN_ON_ONCE(1);
> -				ret = false;
> -				page_vma_mapped_walk_done(&pvmw);
> -				break;
> +				goto walk_done_err;
>   			}
>   
>   			/* MADV_FREE page check */
> @@ -1852,23 +1844,17 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   				 */
>   				set_pte_at(mm, address, pvmw.pte, pteval);
>   				folio_set_swapbacked(folio);
> -				ret = false;
> -				page_vma_mapped_walk_done(&pvmw);
> -				break;
> +				goto walk_done_err;
>   			}
>   
>   			if (swap_duplicate(entry) < 0) {
>   				set_pte_at(mm, address, pvmw.pte, pteval);
> -				ret = false;
> -				page_vma_mapped_walk_done(&pvmw);
> -				break;
> +				goto walk_done_err;
>   			}
>   			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
>   				swap_free(entry);
>   				set_pte_at(mm, address, pvmw.pte, pteval);
> -				ret = false;
> -				page_vma_mapped_walk_done(&pvmw);
> -				break;
> +				goto walk_done_err;
>   			}
>   
>   			/* See folio_try_share_anon_rmap(): clear PTE first. */
> @@ -1876,9 +1862,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   			    folio_try_share_anon_rmap_pte(folio, subpage)) {
>   				swap_free(entry);
>   				set_pte_at(mm, address, pvmw.pte, pteval);
> -				ret = false;
> -				page_vma_mapped_walk_done(&pvmw);
> -				break;
> +				goto walk_done_err;
>   			}
>   			if (list_empty(&mm->mmlist)) {
>   				spin_lock(&mmlist_lock);
> @@ -1918,6 +1902,12 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   		if (vma->vm_flags & VM_LOCKED)
>   			mlock_drain_local();
>   		folio_put(folio);
> +		continue;
> +walk_done_err:
> +		ret = false;
> +walk_done:
> +		page_vma_mapped_walk_done(&pvmw);
> +		break;
>   	}
>   
>   	mmu_notifier_invalidate_range_end(&range);

