Return-Path: <linux-kernel+bounces-304717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B22449623E9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A7F1C23DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F31166F03;
	Wed, 28 Aug 2024 09:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sIA4uTt2"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10B2156F4A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838555; cv=none; b=NdQoXbk+KJBW42r3SXty+0Q/SyTSK+trcxPyfTSQR0WLegpq6W7Y4N3WMqRGk8cl+mKXbkHWcjpzcgwAJlHRw0+zp2QM1tuSJjJie8LKK9yUwjjWFaW9Uy3NT1IK9SSsnYUmuAWDENeoCqemWel0cdoUSZF13HTZzHT88uNKOqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838555; c=relaxed/simple;
	bh=/rq5TTiVzXhPGgLtskoJtNJI6nTnWASBpQ3haxxIUpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jll+KScTec8PF4GUgzhDuRqpT+XKHijcr7CP7+qeILcmRzyMAMELfcpV7JRXoiVX81mWpw2t4B97a2NGmJma9FqUwF0I4l/4zJAHf4O2r68lLycMthJYMtFMHWbicXzuZ/bCtLk+0yrldv1I7njfaCOU3eRjAbPB4Qqrx4ppqvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sIA4uTt2; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2c3f09dc-aa80-412d-ba85-3cb9aa8cc478@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724838550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9h63oGvBhtQEIewj2wn7Jmp1aE5e9TuQJjoSjWMO3Mk=;
	b=sIA4uTt2sd96Y57FvD7zS3kvg67g9xLilCsoGAk9nEYRxtB3b1iolYsHSu3I9Ql8oFQVmc
	De2qsYmLwylJzl22V/gFDZk5JVyqSrtBactAhSdnX85tb2DIYaN/E2SNYh/5awOngRV2a2
	HR/zCTUUpnWoAp1qsMncajskppAIlno=
Date: Wed, 28 Aug 2024 17:48:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 01/14] mm: pgtable: introduce
 pte_offset_map_{ro|rw}_nolock()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 david@redhat.com, hughd@google.com, willy@infradead.org, vbabka@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vishal.moola@gmail.com,
 peterx@redhat.com, ryan.roberts@arm.com, christophe.leroy2@cs-soprasteria.com
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
 <e866151ccd257ca14a9361ba59f8c3086aa76e4f.1724310149.git.zhengqi.arch@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <e866151ccd257ca14a9361ba59f8c3086aa76e4f.1724310149.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/8/22 15:13, Qi Zheng wrote:
> Currently, the usage of pte_offset_map_nolock() can be divided into the
> following two cases:
>
> 1) After acquiring PTL, only read-only operations are performed on the PTE
>     page. In this case, the RCU lock in pte_offset_map_nolock() will ensure
>     that the PTE page will not be freed, and there is no need to worry
>     about whether the pmd entry is modified.
>
> 2) After acquiring PTL, the pte or pmd entries may be modified. At this
>     time, we need to ensure that the pmd entry has not been modified
>     concurrently.
>
> To more clearing distinguish between these two cases, this commit
> introduces two new helper functions to replace pte_offset_map_nolock().
> For 1), just rename it to pte_offset_map_ro_nolock(). For 2), in addition
> to changing the name to pte_offset_map_rw_nolock(), it also outputs the
> pmdval when successful. This can help the caller recheck *pmd once the PTL
> is taken. In some cases, that is, either the mmap_lock for write, or
> pte_same() check on contents, is also enough to ensure that the pmd entry
> is stable. But in order to prevent the interface from being abused, we
> choose to pass in a dummy local variable instead of NULL.
>
> Subsequent commits will convert pte_offset_map_nolock() into the above
> two functions one by one, and finally completely delete it.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   Documentation/mm/split_page_table_lock.rst |  7 ++++
>   include/linux/mm.h                         |  5 +++
>   mm/pgtable-generic.c                       | 43 ++++++++++++++++++++++
>   3 files changed, 55 insertions(+)
>
> diff --git a/Documentation/mm/split_page_table_lock.rst b/Documentation/mm/split_page_table_lock.rst
> index e4f6972eb6c04..08d0e706a32db 100644
> --- a/Documentation/mm/split_page_table_lock.rst
> +++ b/Documentation/mm/split_page_table_lock.rst
> @@ -19,6 +19,13 @@ There are helpers to lock/unlock a table and other accessor functions:
>    - pte_offset_map_nolock()
>   	maps PTE, returns pointer to PTE with pointer to its PTE table
>   	lock (not taken), or returns NULL if no PTE table;
> + - pte_offset_map_ro_nolock()
> +	maps PTE, returns pointer to PTE with pointer to its PTE table
> +	lock (not taken), or returns NULL if no PTE table;
> + - pte_offset_map_rw_nolock()
> +	maps PTE, returns pointer to PTE with pointer to its PTE table
> +	lock (not taken) and the value of its pmd entry, or returns NULL
> +	if no PTE table;
>    - pte_offset_map()
>   	maps PTE, returns pointer to PTE, or returns NULL if no PTE table;
>    - pte_unmap()
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index da29b066495d6..a00cb35ce065f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2954,6 +2954,11 @@ static inline pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
>   
>   pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
>   			unsigned long addr, spinlock_t **ptlp);
> +pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
> +				unsigned long addr, spinlock_t **ptlp);
> +pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
> +				unsigned long addr, pmd_t *pmdvalp,
> +				spinlock_t **ptlp);
>   
>   #define pte_unmap_unlock(pte, ptl)	do {		\
>   	spin_unlock(ptl);				\
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index a78a4adf711ac..9a1666574c959 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -317,6 +317,33 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
>   	return pte;
>   }
>   
> +pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
> +				unsigned long addr, spinlock_t **ptlp)
> +{
> +	pmd_t pmdval;
> +	pte_t *pte;
> +
> +	pte = __pte_offset_map(pmd, addr, &pmdval);
> +	if (likely(pte))
> +		*ptlp = pte_lockptr(mm, &pmdval);
> +	return pte;
> +}
> +
> +pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
> +				unsigned long addr, pmd_t *pmdvalp,
> +				spinlock_t **ptlp)
> +{
> +	pmd_t pmdval;
> +	pte_t *pte;
> +
> +	BUG_ON(!pmdvalp);
> +	pte = __pte_offset_map(pmd, addr, &pmdval);
> +	if (likely(pte))
> +		*ptlp = pte_lockptr(mm, &pmdval);
> +	*pmdvalp = pmdval;
> +	return pte;
> +}
> +
>   /*
>    * pte_offset_map_lock(mm, pmd, addr, ptlp), and its internal implementation
>    * __pte_offset_map_lock() below, is usually called with the pmd pointer for
> @@ -356,6 +383,22 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
>    * recheck *pmd once the lock is taken; in practice, no callsite needs that -
>    * either the mmap_lock for write, or pte_same() check on contents, is enough.
>    *
> + * pte_offset_map_ro_nolock(mm, pmd, addr, ptlp), above, is like
> + * pte_offset_map(); but when successful, it also outputs a pointer to the
> + * spinlock in ptlp - as pte_offset_map_lock() does, but in this case without
> + * locking it.  This helps the caller to avoid a later pte_lockptr(mm, *pmd),
> + * which might by that time act on a changed *pmd: pte_offset_map_ro_nolock()
> + * provides the correct spinlock pointer for the page table that it returns.
> + * For readonly case, the caller does not need to recheck *pmd after the lock is
> + * taken, because the RCU lock will ensure that the PTE page will not be freed.

I'd like to add something like:

"
It is only applicable for read-only cases where any modification 
operations to the PTE page table are not allowed even if the 
corresponding PTL is held afterwards.
"

to explicitly specify its use cases.
> + *
> + * pte_offset_map_rw_nolock(mm, pmd, addr, pmdvalp, ptlp), above, is like
> + * pte_offset_map_ro_nolock(); but when successful, it also outputs the
> + * pdmval. For cases where pte or pmd entries may be modified, that is, maywrite
> + * case, this can help the caller recheck *pmd once the lock is taken. In some
> + * cases, that is, either the mmap_lock for write, or pte_same() check on
> + * contents, is also enough to ensure that the pmd entry is stable.
> + *

I'd like to rewrite some sentences to:

"
It is applicable for may-write cases where any modification operations 
to the PTE page table may happen after the corresponding PTL is held 
afterwards. But the users should make sure the PTE page table is stable 
like holding mmap_lock for write or checking pte_same() or checking 
pmd_same() before performing the write operations.
"

Muchun,
Thanks.

>    * Note that free_pgtables(), used after unmapping detached vmas, or when
>    * exiting the whole mm, does not take page table lock before freeing a page
>    * table, and may not use RCU at all: "outsiders" like khugepaged should avoid


