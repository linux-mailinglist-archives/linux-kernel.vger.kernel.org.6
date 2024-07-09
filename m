Return-Path: <linux-kernel+bounces-245432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DA292B274
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA7D281052
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC21915358A;
	Tue,  9 Jul 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FizDL4ms"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED41D152E04
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514706; cv=none; b=dlQzOouVCgPlt9qlHDJBjUYVedtuNWV/Vx3KQTDNPvXzQt6L+Dh1+It3UVsmOP1z2Sn1d7VH8w7rZFb6L1I0A4XLXc1SchAszGrDjFCYxnPUDLyA8EvGGhIEhqqcpO9lnujGIuVA1k4CHk8/P2E2LVl3p3BhYVDUlfwZgervp0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514706; c=relaxed/simple;
	bh=qXLhekIIlxj3jNGmdtcQpx1h4FQhxbC3rEZKQl/dwJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NL4Tp3tHLZEMdBSTdDu+N6EnwMe1WavbniSselg1+gCfoISvq9r5+VRLmIB//l7BA68EfP2UHp838fysPwN8EDZlB6AFnYg+wtamY9uflOYQmSjd5Lw42kaULcaVoGBYD2K4K5HY4kJNtnoL+vXcgZS4LLvo+oh7QpMxRxQixsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FizDL4ms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41096C3277B;
	Tue,  9 Jul 2024 08:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720514705;
	bh=qXLhekIIlxj3jNGmdtcQpx1h4FQhxbC3rEZKQl/dwJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FizDL4msF5tdF1c1h/MXNDlCvvdnN+5sk5lqksan2OqVLq/gNqCO7YNN9uo1F86Si
	 V2ygNccvJtykvL6N/RTJkeO8sI/UXcKUcIu/D/BIWgtLfaQ+R204c0Na2ZAQaZSm0i
	 MKCZCNdY+8lwjXYcZcO7tge62dL1ZH/lOPunYjwsN1QUb0JF7OsfOJXs9r4bdbcz/O
	 tjO66q2fU7MFHRgvZ8PFu3o1MBnHn1KGRvkwbdizCjcvRRKR5NpU9CQ3Mf5k7NXZLZ
	 m3X0Fv5659wEjqvr7k6K1CulVC1npPcugwqOe6j6d5gmj4Sd15FEb/d0G6lue+C+1d
	 jivMx2TuJG9HQ==
Date: Tue, 9 Jul 2024 11:42:20 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, oleg@redhat.com,
	tandersen@netflix.com, mjguzik@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v5 1/3] mm/memblock: introduce a new helper
 memblock_estimated_nr_free_pages()
Message-ID: <Zoz37AoDvFtEWz-S@kernel.org>
References: <20240709023609.21332-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709023609.21332-1-richard.weiyang@gmail.com>

On Tue, Jul 09, 2024 at 02:36:07AM +0000, Wei Yang wrote:
> During bootup, system may need the number of free pages in the whole system
> to do some calculation before all pages are freed to buddy system. Usually
> this number is get from totalram_pages(). Since we plan to move the free
> pages accounting in __free_pages_core(), this value may not represent
> total free pages at the early stage, especially when
> CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
> 
> Instead of using raw memblock api, let's introduce a new helper for user
> to get the estimated number of free pages from memblock point of view.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: David Hildenbrand <david@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport <rppt@kernel.org>

> 
> ---
> v5: cleanup the stale name
> v4: adjust comment per david's suggestion
> ---
>  include/linux/memblock.h |  1 +
>  mm/memblock.c            | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 40c62aca36ec..aba7ed9f2531 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -486,6 +486,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
>  
>  phys_addr_t memblock_phys_mem_size(void);
>  phys_addr_t memblock_reserved_size(void);
> +unsigned long memblock_estimated_nr_free_pages(void);
>  phys_addr_t memblock_start_of_DRAM(void);
>  phys_addr_t memblock_end_of_DRAM(void);
>  void memblock_enforce_memory_limit(phys_addr_t memory_limit);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index e81fb68f7f88..ae8e58fc4e7f 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1729,6 +1729,23 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
>  	return memblock.reserved.total_size;
>  }
>  
> +/**
> + * memblock_estimated_nr_free_pages - return estimated number of free pages
> + * from memblock point of view
> + *
> + * During bootup, subsystems might need a rough estimate of the number of free
> + * pages in the whole system, before precise numbers are available from the
> + * buddy. Especially with CONFIG_DEFERRED_STRUCT_PAGE_INIT, the numbers
> + * obtained from the buddy might be very imprecise during bootup.
> + *
> + * Return:
> + * An estimated number of free pages from memblock point of view.
> + */
> +unsigned long __init memblock_estimated_nr_free_pages(void)
> +{
> +	return PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
> +}
> +
>  /* lowest address */
>  phys_addr_t __init_memblock memblock_start_of_DRAM(void)
>  {
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.

