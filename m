Return-Path: <linux-kernel+bounces-318324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B276696EBD8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C00282A6D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E8814C5B5;
	Fri,  6 Sep 2024 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xNyKdDHP"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4580F14BF87
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 07:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725607272; cv=none; b=BcK8kpKqYAbv6t2PnIAmnSPphb1dcsy24n09h6LvrQMJGb1SWM7AQGmLV3j/GAQI3kVL6OmUTamN+LWuCOdYmLCJbH8jUxhB9JV7ZNombRmrgOW5LOoh50XUEhvRPYnJfr4qaS6D6nnh8qUAMcmbrSyAvgUhaCRiB14lxzkUpCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725607272; c=relaxed/simple;
	bh=yO/YqnNMOnXRqewYhKP20TS0IxM90XmpKtT+gJDL7QI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=r0ar9g3tYdPvlwTFxO2SAHOmptR2ctNAOxpIGFXp+AAHsWc8b0yEO6pGJJg+yoxPCEBv3939VVEQJaXC1gfK2T/mkNgYqR/xSxnThfruzrm1ajaK8zbn388f1RiZgTHd9Bi6tJe8QOJ9qZo+E6sjVBQH2FPNvB7gXeNP639cOps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xNyKdDHP; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d02fe02d-a6c7-4157-bb7d-3fe235f21237@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725607268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJPCh8PbP6Ph7SJVvvtMaEdy7Om9qiXdVbZwIKJbLac=;
	b=xNyKdDHP4ERpm0wvOkIn/jYqCTzwSwzDwa0+P37KJndJaFEiFop/OTDMjIXGU5EDJLKXfQ
	mM7OUatDpyRMqiet5XMBmQKn4oL7VnZRGFdfrUQz1HJqpKUQfoqZxcWhrkQcnK5SFyFKwO
	tEHqWfpnmG0P3LEQRiK/xdTIgCz4fc8=
Date: Fri, 6 Sep 2024 15:20:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v3 01/14] mm: pgtable: introduce
 pte_offset_map_{ro|rw}_nolock()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 David Hildenbrand <david@redhat.com>, hughd@google.com, willy@infradead.org,
 vbabka@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
 vishal.moola@gmail.com, peterx@redhat.com, ryan.roberts@arm.com,
 christophe.leroy2@cs-soprasteria.com
References: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
 <20240904084022.32728-2-zhengqi.arch@bytedance.com>
In-Reply-To: <20240904084022.32728-2-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/9/4 16:40, Qi Zheng wrote:
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
> pmdval when successful. It is applicable for may-write cases where any
> modification operations to the page table may happen after the
> corresponding spinlock is held afterwards. But the users should make sure
> the page table is stable like checking pte_same() or checking pmd_same()
> by using the output pmdval before performing the write operations.
>
> Note: "RO" / "RW" expresses the intended semantics, not that the *kmap*
> will be read-only/read-write protected.
>
> Subsequent commits will convert pte_offset_map_nolock() into the above
> two functions one by one, and finally completely delete it.
>
> Signed-off-by: Qi Zheng<zhengqi.arch@bytedance.com>
> ---
>   Documentation/mm/split_page_table_lock.rst |  7 +++
>   include/linux/mm.h                         |  5 +++
>   mm/pgtable-generic.c                       | 50 ++++++++++++++++++++++
>   3 files changed, 62 insertions(+)
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
> index a7c74a840249a..1fde9242231c9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3006,6 +3006,11 @@ static inline pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
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
> index a78a4adf711ac..262b7065a5a2e 100644
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
> +	VM_WARN_ON_ONCE(!pmdvalp);
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
> @@ -356,6 +383,29 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
>    * recheck *pmd once the lock is taken; in practice, no callsite needs that -
>    * either the mmap_lock for write, or pte_same() check on contents, is enough.
>    *
> + * pte_offset_map_ro_nolock(mm, pmd, addr, ptlp), above, is like pte_offset_map();
> + * but when successful, it also outputs a pointer to the spinlock in ptlp - as
> + * pte_offset_map_lock() does, but in this case without locking it.  This helps
> + * the caller to avoid a later pte_lockptr(mm, *pmd), which might by that time
> + * act on a changed *pmd: pte_offset_map_ro_nolock() provides the correct spinlock
> + * pointer for the page table that it returns. Even after grabbing the spinlock,
> + * we might be looking either at a page table that is still mapped or one that
> + * was unmapped and is about to get freed. But for R/O access this is sufficient.
> + * So it is only applicable for read-only cases where any modification operations
> + * to the page table are not allowed even if the corresponding spinlock is held
> + * afterwards.
> + *
> + * pte_offset_map_rw_nolock(mm, pmd, addr, pmdvalp, ptlp), above, is like
> + * pte_offset_map_ro_nolock(); but when successful, it also outputs the pdmval.
> + * It is applicable for may-write cases where any modification operations to the
> + * page table may happen after the corresponding spinlock is held afterwards.
> + * But the users should make sure the page table is stable like checking pte_same()
> + * or checking pmd_same() by using the output pmdval before performing the write
> + * operations.

Now, we have two options to make sure the stability of PTE for users
of pte_offset_map_rw_nolock(), in order to ease this operation, how
about proposing a new helper (or two, one for pmd_same, another for
pte_same) like pte_lock_stability (I am not good at naming, maybe
you can) which helps users 1) hold the PTL and 2) check if the PTE is
stable and 3) return true if the PTE stable, otherwise return false.

Muchun,
Thanks.

> + *
> + * Note: "RO" / "RW" expresses the intended semantics, not that the *kmap* will
> + * be read-only/read-write protected.
> + *
>    * Note that free_pgtables(), used after unmapping detached vmas, or when
>    * exiting the whole mm, does not take page table lock before freeing a page
>    * table, and may not use RCU at all: "outsiders" like khugepaged should avoid


