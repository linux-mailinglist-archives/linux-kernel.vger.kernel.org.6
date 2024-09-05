Return-Path: <linux-kernel+bounces-316673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A333A96D29B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DCA0B237AA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A921953AD;
	Thu,  5 Sep 2024 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hHL2mCMb"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB1194AE8
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526680; cv=none; b=uPcFO/jGgo9JxDR+WESzP0Ypv+XS5+6s64Fh+aEbH4LnAQPm2RrC/BHYP8iaTwwDwMOFzr2xWNL1PA7cGEWhf4fX+t51e4Y6uxsFw9wOvcg06f20OGUx2XimmnM5rs+er6CGQ1r4IaYjL+T3Mxhf49QmpJrGaHHM1XArDtHM/ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526680; c=relaxed/simple;
	bh=rDibyQrsdO6DZTBB0E6HW/nJiayDYDnD6XFMOKimOdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVJX0GhJA2kzKsru0VTZJr7jmkNcq/VlDHogepa/TxXN+zIO4oEN1x44Ep86DzqtDvmAA8HTRjztkSDSWkQo2sMTSZdvr+VLSmhqk8ZzDRdMrKU4I/L50yz/1q0h6M5zUYszqtTCO21QzJ658Zv/u6AYNnsD41ME8ue+FYI7CsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hHL2mCMb; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d8e2ef66-c345-43f0-9989-f20f16df34d3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725526676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZtqExsDOIYp5HqPgrPdq+CzPwDzSkiYY8yvT9Jxwhw=;
	b=hHL2mCMbuNK+Hs/O408hs/N7aassZHQuWT3l/9qpf3OwEqwDoq18fUNQy7T4vQkPAhr7Ip
	KhS7GNRdIL7YXvr4Kwk1nBVf05wbZgGwqSvv3B9YBaijU8YfoK9B1DhEgjDylQD3XI58dx
	j3oiLIpOO5R1TF/4CpCnFRK2Hn4WWvc=
Date: Thu, 5 Sep 2024 16:57:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 08/14] mm: copy_pte_range() use
 pte_offset_map_rw_nolock()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 david@redhat.com, hughd@google.com, willy@infradead.org, vbabka@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vishal.moola@gmail.com,
 peterx@redhat.com, ryan.roberts@arm.com, christophe.leroy2@cs-soprasteria.com
References: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
 <20240904084022.32728-9-zhengqi.arch@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240904084022.32728-9-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2024/9/4 16:40, Qi Zheng wrote:
> In copy_pte_range(), we may modify the src_pte entry after holding the
> src_ptl, so convert it to using pte_offset_map_rw_nolock(). Since we may
> free the PTE page in retract_page_tables() without holding the read lock
> of mmap_lock, so we still need to get pmdval and do pmd_same() check after
> the ptl is held.

See commit 3db82b9374ca92, copy_pte_range and retract_page_tables
are using vma->anon_vma to be exclusive.

retract_page_tables()                    copy_page_range()
     vma_interval_tree_foreach()              if (!vma_needs_copy())
         if (READ_ONCE(vma->anon_vma))            return 0;
             continue;                        copy_pte_range()

So I think mmap write lock here is also used for keeping ->anon_vma stable.
And we do not need pmd_same().

Muchun,
Thanks.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
> Hi Muchun, since the code has changed, I dropped your Reviewed-by tag here.
>
>   mm/memory.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 06674f94b7a4e..47974cc4bd7f2 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1082,6 +1082,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>   	struct mm_struct *src_mm = src_vma->vm_mm;
>   	pte_t *orig_src_pte, *orig_dst_pte;
>   	pte_t *src_pte, *dst_pte;
> +	pmd_t pmdval;
>   	pte_t ptent;
>   	spinlock_t *src_ptl, *dst_ptl;
>   	int progress, max_nr, ret = 0;
> @@ -1107,13 +1108,28 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>   		ret = -ENOMEM;
>   		goto out;
>   	}
> -	src_pte = pte_offset_map_nolock(src_mm, src_pmd, addr, &src_ptl);
> +
> +	/*
> +	 * Since we may free the PTE page in retract_page_tables() without
> +	 * holding the read lock of mmap_lock, so we still need to do a
> +	 * pmd_same() check after holding the PTL.
> +	 */
> +	src_pte = pte_offset_map_rw_nolock(src_mm, src_pmd, addr, &pmdval,
> +					   &src_ptl);
>   	if (!src_pte) {
>   		pte_unmap_unlock(dst_pte, dst_ptl);
>   		/* ret == 0 */
>   		goto out;
>   	}
>   	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> +
> +	if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(src_pmd)))) {
> +		pte_unmap_unlock(src_pte, src_ptl);
> +		pte_unmap_unlock(dst_pte, dst_ptl);
> +		/* ret == 0 */
> +		goto out;
> +	}
> +
>   	orig_src_pte = src_pte;
>   	orig_dst_pte = dst_pte;
>   	arch_enter_lazy_mmu_mode();


