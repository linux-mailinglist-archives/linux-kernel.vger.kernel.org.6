Return-Path: <linux-kernel+bounces-252600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7DE9315CE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2111B281FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCF218D4CC;
	Mon, 15 Jul 2024 13:30:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B661836D4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050242; cv=none; b=VO/qcVB8A63uJrvY58de1LbqtaFLbt9rN/4a3pIhyX2/7hANJ7gV0JawMmxmrcUA31uEgeApzTcX3sj7Gzsut+cK4/mSZwBkv8bJGR83sN61H7DR+sHGx8LXHB5P5GiuEfsaRHjQOoAbQMC0vyLkbMqPl8MPPCbMpCBrvIja5U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050242; c=relaxed/simple;
	bh=Z8efUNCzmXWAZnbILn2Fwlrih3IDRF+pWj2sK01Nknc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fs3EnULCwJAYiPABLs9Nefk4shCGDEnxa4bY1InkMYU8K8sIwB+g0J3anITMPrCxllW6rHsoWN0F4AmldW3tPF8ygWsV1XtyoMoKdLa+XBpI5LO7dBtqqHRhW5irAweFEhc1RxzxQ2jUQLXRWjfoMuB2m7+pOk3NW3emY957jmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4413FEC;
	Mon, 15 Jul 2024 06:31:04 -0700 (PDT)
Received: from [10.57.77.136] (unknown [10.57.77.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8D663F73F;
	Mon, 15 Jul 2024 06:30:37 -0700 (PDT)
Message-ID: <cf919805-9fb1-4d7a-83bc-60225151cd63@arm.com>
Date: Mon, 15 Jul 2024 14:30:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm: shmem: simplify the suitable huge orders
 validation for tmpfs
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, 21cnbao@gmail.com, ziy@nvidia.com,
 ioworker0@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1720755677.git.baolin.wang@linux.alibaba.com>
 <ee1b6ac287bb376a9da88a23e1ef16951eb94a4e.1720755678.git.baolin.wang@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ee1b6ac287bb376a9da88a23e1ef16951eb94a4e.1720755678.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/07/2024 14:24, Baolin Wang wrote:
> Move the suitable huge orders validation into shmem_suitable_orders() for
> tmpfs, which can reuse some code to simplify the logic.
> 
> In addition, we don't have special handling for the error code -E2BIG when
> checking for conflicts with PMD sized THP in the pagecache for tmpfs, instead,
> it will just fallback to order-0 allocations like this patch does, so this
> simplification will not add functional changes.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  mm/shmem.c | 39 +++++++++++++++------------------------
>  1 file changed, 15 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index f24dfbd387ba..db7e9808830f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1685,19 +1685,29 @@ static unsigned long shmem_suitable_orders(struct inode *inode, struct vm_fault
>  					   struct address_space *mapping, pgoff_t index,
>  					   unsigned long orders)
>  {
> -	struct vm_area_struct *vma = vmf->vma;
> +	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
>  	unsigned long pages;
>  	int order;
>  
> -	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
> -	if (!orders)
> -		return 0;
> +	if (vma) {
> +		orders = thp_vma_suitable_orders(vma, vmf->address, orders);
> +		if (!orders)
> +			return 0;
> +	}
>  
>  	/* Find the highest order that can add into the page cache */
>  	order = highest_order(orders);
>  	while (orders) {
>  		pages = 1UL << order;
>  		index = round_down(index, pages);
> +		/*
> +		 * Check for conflict before waiting on a huge allocation.
> +		 * Conflict might be that a huge page has just been allocated
> +		 * and added to page cache by a racing thread, or that there
> +		 * is already at least one small page in the huge extent.
> +		 * Be careful to retry when appropriate, but not forever!
> +		 * Elsewhere -EEXIST would be the right code, but not here.
> +		 */
>  		if (!xa_find(&mapping->i_pages, &index,
>  			     index + pages - 1, XA_PRESENT))
>  			break;
> @@ -1735,7 +1745,6 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>  {
>  	struct address_space *mapping = inode->i_mapping;
>  	struct shmem_inode_info *info = SHMEM_I(inode);
> -	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
>  	unsigned long suitable_orders = 0;
>  	struct folio *folio = NULL;
>  	long pages;
> @@ -1745,26 +1754,8 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>  		orders = 0;
>  
>  	if (orders > 0) {
> -		if (vma && vma_is_anon_shmem(vma)) {
> -			suitable_orders = shmem_suitable_orders(inode, vmf,
> +		suitable_orders = shmem_suitable_orders(inode, vmf,
>  							mapping, index, orders);
> -		} else if (orders & BIT(HPAGE_PMD_ORDER)) {
> -			pages = HPAGE_PMD_NR;
> -			suitable_orders = BIT(HPAGE_PMD_ORDER);
> -			index = round_down(index, HPAGE_PMD_NR);
> -
> -			/*
> -			 * Check for conflict before waiting on a huge allocation.
> -			 * Conflict might be that a huge page has just been allocated
> -			 * and added to page cache by a racing thread, or that there
> -			 * is already at least one small page in the huge extent.
> -			 * Be careful to retry when appropriate, but not forever!
> -			 * Elsewhere -EEXIST would be the right code, but not here.
> -			 */
> -			if (xa_find(&mapping->i_pages, &index,
> -				    index + HPAGE_PMD_NR - 1, XA_PRESENT))
> -				return ERR_PTR(-E2BIG);
> -		}
>  
>  		order = highest_order(suitable_orders);
>  		while (suitable_orders) {


