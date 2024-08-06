Return-Path: <linux-kernel+bounces-275821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D2C948AA7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F092C285CB0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643A01BC9F0;
	Tue,  6 Aug 2024 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJXfPHUv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CAE1BBBF5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930763; cv=none; b=WQK9be13Rd7JxS9GgCFGD+g3CyKhGW9XGs1VfxGJWMt+7Ehl52d9p/fdZVLqbIDL6towvXSn3Q/yivHU/s4pc6UbkGVAK8p5SljCjGEEvrm6LQkYtgDJhayHTm5OjblhSnThHtKGk8XH7j30K162U+W16QwdgFrMRMvrrLAlPrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930763; c=relaxed/simple;
	bh=+X08FKo9StEUMgf9vTjstF6ql0XMNbcWlbP50Nj+EWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+bGh+aGDf6W68DI4Afq5HuZ4X6wS4sTf/ptH5rE6tTdaAmvAwH2Ce7NWcytkM7cjdVttRz5vIQiHPZtXyM9FgLuAIJ7ldU6Ela9j+8cv0SnZVL3WO1ZqBVHxAZb64wmJ3/n99qchLXibk+jxf77ozD24zpZWpHJ9Bbu7mXLcto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJXfPHUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92C1C4AF09;
	Tue,  6 Aug 2024 07:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722930763;
	bh=+X08FKo9StEUMgf9vTjstF6ql0XMNbcWlbP50Nj+EWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJXfPHUvIU0q82x/WwqcmxN6Low65cgiC9meVwuKP/9OQsiwLqwa9x5O7ikonDeAt
	 jMmkKvdUqbPdgmlqETNXWiyfmGmvHfmzM+FtkXpJgNEepFeREoqW6cVm0Un50RKNVs
	 p73GFTrT3UoSGEAd3IbyFtSYk0DlHWDHzfR+E3xCUJesOml7j1Kq5BMpWRPTDGov75
	 SYDUoB8bGqZdgiCpxuLToOkez+xLmd5Za6Om+lkalGuqLorW4fQmerlFO52w7Gu/QV
	 jftAj3GXQqWwREbsKXJukGuYhLlF3g0hkKsmx27dcZ5zsepH3qqoOmBDos5Ca32457
	 44NHm/JRLDzkg==
Date: Tue, 6 Aug 2024 10:52:35 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] mm: Accept memory in __alloc_pages_bulk().
Message-ID: <ZrHWQ/+EC5CApJ3M@kernel.org>
References: <20240805145940.2911011-1-kirill.shutemov@linux.intel.com>
 <20240805145940.2911011-3-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805145940.2911011-3-kirill.shutemov@linux.intel.com>

On Mon, Aug 05, 2024 at 05:59:34PM +0300, Kirill A. Shutemov wrote:
> Currently, the kernel only accepts memory in get_page_from_freelist(),
> but there is another path that directly takes pages from free lists -
> __alloc_page_bulk(). This function can consume all accepted memory and
> will resort to __alloc_pages_noprof() if necessary.
> 
> Conditionally accepted in __alloc_pages_bulk().
> 
> The same issue may arise due to deferred page initialization. Kick the
> deferred initialization machinery before abandoning the zone, as the
> kernel does in get_page_from_freelist().
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/page_alloc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index aa9b1eaa638c..90a1f01d5996 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4576,12 +4576,25 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
>  			goto failed;
>  		}
>  
> +		cond_accept_memory(zone, 0);
> +retry_this_zone:
>  		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK) + nr_pages;
>  		if (zone_watermark_fast(zone, 0,  mark,
>  				zonelist_zone_idx(ac.preferred_zoneref),
>  				alloc_flags, gfp)) {
>  			break;
>  		}
> +
> +		if (cond_accept_memory(zone, 0))
> +			goto retry_this_zone;
> +
> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> +		/* Try again if zone has deferred pages */
> +		if (deferred_pages_enabled()) {
> +			if (_deferred_grow_zone(zone, 0))
> +				goto retry_this_zone;
> +		}
> +#endif
>  	}
>  
>  	/*
> -- 
> 2.43.0
> 

