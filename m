Return-Path: <linux-kernel+bounces-316720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB5F96D313
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A32284BC9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B04F198A0E;
	Thu,  5 Sep 2024 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c5FUB6sP"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84FC198838
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528379; cv=none; b=rEx+yhfnkJe7PotEIz3RRyMYwxvAk/GllpwTMRs6B9Dfv95J70Jgz6XiqzmBVI7YVH4MFwM3Yi5SZqeMjaTsxDHdwpd+BiprU1vQ+K/+yCRiR5/oh0o5IUGWwrtM/oimR+0ahhA/8bGp90z9mMxfK25+RNgsyaTCgfREKGpmE8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528379; c=relaxed/simple;
	bh=vA6Qus/Mr+jDkbsLGAd/AUyeXIyYRknGJ7FccZ+ozpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnIXfYeO0pR4kOtCevRg/3pjpTVuBk/BSPmqL/6Xfuf2j4iGIG12LKxW12tiALQ9P0erTnSt0yyLnK9523xfaxZ845mg16aHcfrXikzGjUidqYvobdsSCwZn2hjJb5LirjIYObL0lRjwKFylD9y2h3Y/rIOn68lW00cyXPYkVO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c5FUB6sP; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1b03a7de-1278-4e36-8068-885dd1c29742@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725528373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nRCI2DeauznMxWvt70Qz7zNit5+Q7VEXvujH0nECZ00=;
	b=c5FUB6sPdqxWX5L5xjOt1q9V2UQS4qiyKBlN6A7HKzXewrgQGG88vVjQ6bDaNQQo3schKq
	YNRZQuDJhFK8TX1j8wy49QWAZ03RWVSuz2vaYOxZxfj/ZHKvWeloeHACU3d7xsCnCQyqgf
	ADgGTiaDgUYLEr5AY+sqdyxdpx8HdTQ=
Date: Thu, 5 Sep 2024 17:25:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 09/14] mm: mremap: move_ptes() use
 pte_offset_map_rw_nolock()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 david@redhat.com, hughd@google.com, willy@infradead.org, vbabka@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vishal.moola@gmail.com,
 peterx@redhat.com, ryan.roberts@arm.com, christophe.leroy2@cs-soprasteria.com
References: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
 <20240904084022.32728-10-zhengqi.arch@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240904084022.32728-10-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/9/4 16:40, Qi Zheng wrote:
> In move_ptes(), we may modify the new_pte after acquiring the new_ptl, so
> convert it to using pte_offset_map_rw_nolock(). Since we may free the PTE
> page in retract_page_tables() without holding the read lock of mmap_lock,
> so we still need to do a pmd_same() check after holding the PTL.

retract_page_tables() and move_ptes() are synchronized with
i_mmap_lock, right?

Muchun,
Thanks.

>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   mm/mremap.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 24712f8dbb6b5..16e54151395ad 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -143,6 +143,7 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
>   	spinlock_t *old_ptl, *new_ptl;
>   	bool force_flush = false;
>   	unsigned long len = old_end - old_addr;
> +	pmd_t pmdval;
>   	int err = 0;
>   
>   	/*
> @@ -175,14 +176,29 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
>   		err = -EAGAIN;
>   		goto out;
>   	}
> -	new_pte = pte_offset_map_nolock(mm, new_pmd, new_addr, &new_ptl);
> +	/*
> +	 * Since we may free the PTE page in retract_page_tables() without
> +	 * holding the read lock of mmap_lock, so we still need to do a
> +	 * pmd_same() check after holding the PTL.
> +	 */
> +	new_pte = pte_offset_map_rw_nolock(mm, new_pmd, new_addr, &pmdval,
> +					   &new_ptl);
>   	if (!new_pte) {
>   		pte_unmap_unlock(old_pte, old_ptl);
>   		err = -EAGAIN;
>   		goto out;
>   	}
> -	if (new_ptl != old_ptl)
> +	if (new_ptl != old_ptl) {
>   		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> +
> +		if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(new_pmd)))) {
> +			pte_unmap_unlock(new_pte, new_ptl);
> +			pte_unmap_unlock(old_pte, old_ptl);
> +			err = -EAGAIN;
> +			goto out;
> +		}
> +	}
> +
>   	flush_tlb_batched_pending(vma->vm_mm);
>   	arch_enter_lazy_mmu_mode();
>   


