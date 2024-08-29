Return-Path: <linux-kernel+bounces-306369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC9A963E17
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683231F257EA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E83718A6BF;
	Thu, 29 Aug 2024 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JkCWo6T4"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E268118A6BA
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919039; cv=none; b=UKVXCp9kvGuYn37s//eFS9VwLQKNiz3DJUb/Fz0kL8SUc+iJHbmq31j9Gwoz/PfkIP23OK4PrQx2T8OZ4rHnw3czl75U50BWFFsg4ruFHkhEYcKjT2u6vbDZF1uLVK8VIKaTUHfiwvU5aOrbgumM7zVr7ImDynYxPg7/AgnGLYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919039; c=relaxed/simple;
	bh=PQaTHLwVG2fLnPCo6P7mMXSwRpVK0l4kDMJQY+leysA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+kktEQSwn0bQ+Gq5TENKJ/WubysrNC26JiOh+FF9M6Bpe0GIQcxynWRnJgeCnOistJrhsfMnSXa9PGl0UD4NvusLjKWXRpoTYY5CA3KiC1li2zjQ38oOB5tvO0U3+KS58k1VM4DdYypu6KGtgENZ1nF3Z6jqcV/ficJEMB44eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JkCWo6T4; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <24be821f-a95f-47f1-879a-c392a79072cc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724919034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVz/wFUOYpNbyYNUc2eYBCHKhOCPnySMmezJns0Oe5E=;
	b=JkCWo6T4DGdgbCAXphgbiqn76m/Hac2NMrto05Yqg228sV/hYwhh5QOjkkT+QTr9iK+es3
	yl+P+qiEt9/MYTwMaSb44oBxw8VTe8/XNgUfCPzt0xGIsf1QGsxN2NaKK+INRn1DpE166Q
	U+w6BKUd0BaNIni7PN6uCd8i6zXapyE=
Date: Thu, 29 Aug 2024 16:10:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 07/14] mm: khugepaged: collapse_pte_mapped_thp() use
 pte_offset_map_rw_nolock()
To: Qi Zheng <zhengqi.arch@bytedance.com>, david@redhat.com,
 hughd@google.com, willy@infradead.org, vbabka@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vishal.moola@gmail.com,
 peterx@redhat.com, ryan.roberts@arm.com, christophe.leroy2@cs-soprasteria.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
 <c377dab2bf55950e6155ea051aba3887ed5a2773.1724310149.git.zhengqi.arch@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <c377dab2bf55950e6155ea051aba3887ed5a2773.1724310149.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/8/22 15:13, Qi Zheng wrote:
> In collapse_pte_mapped_thp(), we may modify the pte and pmd entry after
> acquring the ptl, so convert it to using pte_offset_map_rw_nolock(). At
> this time, the write lock of mmap_lock is not held, and the pte_same()
> check is not performed after the PTL held. So we should get pgt_pmd and do
> pmd_same() check after the ptl held.
>
> For the case where the ptl is released first and then the pml is acquired,
> the PTE page may have been freed, so we must do pmd_same() check before
> reacquiring the ptl.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   mm/khugepaged.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 53bfa7f4b7f82..15d3f7f3c65f2 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1604,7 +1604,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>   	if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
>   		pml = pmd_lock(mm, pmd);
>   
> -	start_pte = pte_offset_map_nolock(mm, pmd, haddr, &ptl);
> +	start_pte = pte_offset_map_rw_nolock(mm, pmd, haddr, &pgt_pmd, &ptl);
>   	if (!start_pte)		/* mmap_lock + page lock should prevent this */
>   		goto abort;
>   	if (!pml)
> @@ -1612,6 +1612,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>   	else if (ptl != pml)
>   		spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>   
> +	if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd))))
> +		goto abort;
> +
>   	/* step 2: clear page table and adjust rmap */
>   	for (i = 0, addr = haddr, pte = start_pte;
>   	     i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE, pte++) {
> @@ -1657,6 +1660,16 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>   	/* step 4: remove empty page table */
>   	if (!pml) {
>   		pml = pmd_lock(mm, pmd);
> +		/*
> +		 * We called pte_unmap() and release the ptl before acquiring
> +		 * the pml, which means we left the RCU critical section, so the
> +		 * PTE page may have been freed, so we must do pmd_same() check
> +		 * before reacquiring the ptl.
> +		 */
> +		if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
> +			spin_unlock(pml);
> +			goto pmd_change;

Seems we forget to flush TLB since we've cleared some pte entry?

> +		}
>   		if (ptl != pml)
>   			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>   	}
> @@ -1688,6 +1701,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>   		pte_unmap_unlock(start_pte, ptl);
>   	if (pml && pml != ptl)
>   		spin_unlock(pml);
> +pmd_change:
>   	if (notified)
>   		mmu_notifier_invalidate_range_end(&range);
>   drop_folio:


