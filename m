Return-Path: <linux-kernel+bounces-316982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95E596D7DF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F75A1F2417E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8B719AA43;
	Thu,  5 Sep 2024 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JFyaLw6V"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682401991B1
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538039; cv=none; b=r/hzchajhxt1ajrj45/x/RSpn0yUNeqPJ6Sp0lOa9ABGxBUI6wEXDaBLHZLP49Bhma03YtKaeZx7eRrW91rlbftLY6Kk9FDM9MQSqTYETfiRf04zSQicajQOlS7Se6ImhskesWjUScps3wkUA281UdkAc+k6OXgnSK2RZhq3QJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538039; c=relaxed/simple;
	bh=LwXcqXwqi86LwgQpkvbJ6aG6gSxvOL+s5uKNn9S/kVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1yuulU02gnlxR1HAQjU8iQZ0Gbe3MoXNnI16X2UyHaRO62b3lP7/VRq1k9xyFiumvLn0mgxcI3R+k2ptrCVUQunT+itLhJJPMJq3tewdqjlUacG6QoSp0br6kVbjMD23h6ve+xof/KBnWYir9ePDllLSpNwrnwiV2vJeOkZRAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JFyaLw6V; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d373689b-a3f2-4c45-b291-85c58289f044@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725538034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HPUN+LftKuZr9srXj9cbq7IzfWnEz1/nVI7Ulrm9sGw=;
	b=JFyaLw6VOQxfB3bon8tNTAbaoyQOjbkkFr9E7c5BXZrhpSY87szyM6HhPhLdhveialXUBU
	DqzRCadpsUll9LREIS1K/RXRPcaIokvVnVnPDzXmSVZJ2/ObX6ocR1K2ZGP/5TkdOHxCq1
	ELIYL97JJZy+oNEpgveNV8ZUXppn1Vk=
Date: Thu, 5 Sep 2024 20:07:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 10/14] mm: page_vma_mapped_walk: map_pte() use
 pte_offset_map_rw_nolock()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 david@redhat.com, hughd@google.com, willy@infradead.org, vbabka@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vishal.moola@gmail.com,
 peterx@redhat.com, ryan.roberts@arm.com, christophe.leroy2@cs-soprasteria.com
References: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
 <20240904084022.32728-11-zhengqi.arch@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240904084022.32728-11-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/9/4 16:40, Qi Zheng wrote:
> In the caller of map_pte(), we may modify the pvmw->pte after acquiring
> the pvmw->ptl, so convert it to using pte_offset_map_rw_nolock(). At
> this time, the pte_same() check is not performed after the pvmw->ptl held,
> so we should get pmdval and do pmd_same() check to ensure the stability of
> pvmw->pmd.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   mm/page_vma_mapped.c | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index ae5cc42aa2087..f1d73fd448708 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -13,9 +13,11 @@ static inline bool not_found(struct page_vma_mapped_walk *pvmw)
>   	return false;
>   }
>   
> -static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
> +static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
> +		    spinlock_t **ptlp)
>   {
>   	pte_t ptent;
> +	pmd_t pmdval;
>   
>   	if (pvmw->flags & PVMW_SYNC) {
>   		/* Use the stricter lookup */
> @@ -25,6 +27,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
>   		return !!pvmw->pte;
>   	}
>   
> +again:
>   	/*
>   	 * It is important to return the ptl corresponding to pte,
>   	 * in case *pvmw->pmd changes underneath us; so we need to
> @@ -32,10 +35,11 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
>   	 * proceeds to loop over next ptes, and finds a match later.
>   	 * Though, in most cases, page lock already protects this.
>   	 */
> -	pvmw->pte = pte_offset_map_nolock(pvmw->vma->vm_mm, pvmw->pmd,
> -					  pvmw->address, ptlp);
> +	pvmw->pte = pte_offset_map_rw_nolock(pvmw->vma->vm_mm, pvmw->pmd,
> +					     pvmw->address, &pmdval, ptlp);
>   	if (!pvmw->pte)
>   		return false;
> +	*pmdvalp = pmdval;
>   
>   	ptent = ptep_get(pvmw->pte);
>   
> @@ -69,6 +73,12 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
>   	}
>   	pvmw->ptl = *ptlp;
>   	spin_lock(pvmw->ptl);
> +
> +	if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pvmw->pmd)))) {
> +		spin_unlock(pvmw->ptl);

Forgot to clear pvmw->ptl? Or how about moving the assignment for it
to the place where the pmd_same check is successful?

> +		goto again;
> +	}
> +

Maybe here is the right place to assign pvmw->ptl.

Muchun,
Thanks.

>   	return true;
>   }
>   
> @@ -278,7 +288,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>   			step_forward(pvmw, PMD_SIZE);
>   			continue;
>   		}
> -		if (!map_pte(pvmw, &ptl)) {
> +		if (!map_pte(pvmw, &pmde, &ptl)) {
>   			if (!pvmw->pte)
>   				goto restart;
>   			goto next_pte;
> @@ -307,6 +317,12 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>   		if (!pvmw->ptl) {
>   			pvmw->ptl = ptl;
>   			spin_lock(pvmw->ptl);
> +			if (unlikely(!pmd_same(pmde, pmdp_get_lockless(pvmw->pmd)))) {
> +				pte_unmap_unlock(pvmw->pte, pvmw->ptl);
> +				pvmw->ptl = NULL;
> +				pvmw->pte = NULL;
> +				goto restart;
> +			}
>   		}
>   		goto this_pte;
>   	} while (pvmw->address < end);


