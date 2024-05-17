Return-Path: <linux-kernel+bounces-181755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 594D98C80C4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 08:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3D11F2212F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 06:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44455125AE;
	Fri, 17 May 2024 06:02:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3231119B
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 06:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715925771; cv=none; b=Au5Fjn5kJqk10j9deGVneUjWxsI5NXIIdjhEn2pErXZTuEMd9ZCwemoECIio6WLmGw7NR4A1XLhdg3/mSNcEJxXVikuGLp595f/nKZZ/kHswwY5MQq2meAfTgdUDK/i9DtVynxMnQxi2Ry5jWUXiC9WD0uKxOPrmubfyPY6u+DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715925771; c=relaxed/simple;
	bh=pkX+Pnt4ltKFyu8YyzgBROHZsxF/xcflOw+kJZgsD7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpPxxmmFPa1ePNm6V1hPyfsCx8s9vHJhtVZF7Em7bQM+Kk2/V097Xf3X0GT34bi0JCVkbjvOrD11zt/cbR36PSOdLGE4srBI/AokhuWBRzpSA8ej2IMLOVOm/2T3mPA0pl5kt0oXe34WnDE4p5u3/VB2CbeOpNKDU0+MV3rGbTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D3101424;
	Thu, 16 May 2024 23:03:08 -0700 (PDT)
Received: from [10.163.37.42] (unknown [10.163.37.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 603833F762;
	Thu, 16 May 2024 23:02:42 -0700 (PDT)
Message-ID: <71b08fe0-277b-451e-868f-1d81e1b3e810@arm.com>
Date: Fri, 17 May 2024 11:32:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: Drop node_alloc_noretry from
 alloc_fresh_hugetlb_folio
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>
References: <20240516081035.5651-1-osalvador@suse.de>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240516081035.5651-1-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/16/24 13:40, Oscar Salvador wrote:
> Since commit d67e32f26713 ("hugetlb: restructure pool allocations"),
> the parameter node_alloc_noretry from alloc_fresh_hugetlb_folio()
> is not used, so drop it.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/hugetlb.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6be78e7d4f6e..fedce00ff839 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2289,13 +2289,11 @@ static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
>   * pages is zero.
>   */
>  static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
> -		gfp_t gfp_mask, int nid, nodemask_t *nmask,
> -		nodemask_t *node_alloc_noretry)
> +		gfp_t gfp_mask, int nid, nodemask_t *nmask)
>  {
>  	struct folio *folio;
>  
> -	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,
> -						node_alloc_noretry);
> +	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
>  	if (!folio)
>  		return NULL;
>  
> @@ -2513,7 +2511,7 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
>  		goto out_unlock;
>  	spin_unlock_irq(&hugetlb_lock);
>  
> -	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
> +	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask);
>  	if (!folio)
>  		return NULL;
>  
> @@ -2549,7 +2547,7 @@ static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, gfp_t gfp_mas
>  	if (hstate_is_gigantic(h))
>  		return NULL;
>  
> -	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
> +	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask);
>  	if (!folio)
>  		return NULL;
>  
> @@ -3474,7 +3472,7 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
>  			gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
>  
>  			folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid,
> -					&node_states[N_MEMORY], NULL);
> +					&node_states[N_MEMORY]);
>  			if (!folio)
>  				break;
>  			free_huge_folio(folio); /* free it into the hugepage allocator */

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

