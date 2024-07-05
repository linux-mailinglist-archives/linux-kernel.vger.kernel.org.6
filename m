Return-Path: <linux-kernel+bounces-242198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 301649284D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B182928D859
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB46145B25;
	Fri,  5 Jul 2024 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8GIlS8c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02E113C809
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170748; cv=none; b=jcyG6Ywl8EoZhK+qZmC2AnHCaX8Hy7KLev0V28Vq/WuaWj964FrRhgDY2DoA7jiuZmPMQRfWU4o52JapeMyGHWEwtsJK6RJMXtlYZnfzSZ+xRYSpgJX7k73y8oZiZmxXx+fJmPMknPKatIhoKUQzqLOnjBbU/9HvO4rir04JcCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170748; c=relaxed/simple;
	bh=tZOrKLTxHWQw0WT54iRymsngckqcvsL1CHpv+SYW4LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHodsQGTj/sLljAG2IAiD4MQYEstqehdy78x1Bnxt26xr4+HfQeFkbSznMjJMBjF4DagN9C8Jl/7HPE4FPwuek9shssiXjfBkTBSq+PYwBCaun+jBLewlaxfi9d2LSkO6wO2VwmpCvSVYpkSjLKK35nUoqhc7ug3IIFKkkTU0Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8GIlS8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA4DC4AF0A;
	Fri,  5 Jul 2024 09:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720170748;
	bh=tZOrKLTxHWQw0WT54iRymsngckqcvsL1CHpv+SYW4LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X8GIlS8cwm9zDhg0WCkYc7zfrq2CwvZZpjWfg0AXvGNbFrcIRMZeA+Vk54rajSCcx
	 KsJuAvQpIaPQQ4bApxnBif/Di6D97P5yCZ0Jrmrr7Oizfp97MNSSai4xu/w0fSpL/S
	 hSTB7iLmciq4+gNw1seNjvQQAxRwFmZljYCaLTqQ0gj5PeRe2gKwGhPUOa10VN+AXp
	 1Nq7Jog8XpoTFOBiJn0C6kjnGsHvmvGu/eW8a+3o2vmRqvlGYxHn1DHHJzlAR+Ip+V
	 r3VZYr+iMFEIc90vh3l+q0fPSaE+kHc/quiiTht3/mrPp2Y4ZhSHPTupOJ7/dqN8Sn
	 QSP5zA41Z0G7A==
Date: Fri, 5 Jul 2024 12:09:48 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, oleg@redhat.com,
	mjguzik@gmail.com, tandersen@netflix.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, david@redhat.com
Subject: Re: [PATCH v3 1/3] mm/memblock: introduce a new helper
 memblock_estimated_nr_pages()
Message-ID: <Zoe4XN-gKJnjJtzi@kernel.org>
References: <20240703005151.28712-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703005151.28712-1-richard.weiyang@gmail.com>

On Wed, Jul 03, 2024 at 12:51:49AM +0000, Wei Yang wrote:
> Instead of using raw memblock api, we wrap a new helper for user.

The changelog should be more elaborate and explain why this function is
needed.
 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  include/linux/memblock.h |  1 +
>  mm/memblock.c            | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 40c62aca36ec..7d1c32b3dc12 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -486,6 +486,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
>  
>  phys_addr_t memblock_phys_mem_size(void);
>  phys_addr_t memblock_reserved_size(void);
> +unsigned long memblock_estimated_nr_pages(void);
>  phys_addr_t memblock_start_of_DRAM(void);
>  phys_addr_t memblock_end_of_DRAM(void);
>  void memblock_enforce_memory_limit(phys_addr_t memory_limit);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index e81fb68f7f88..c1f1aac0459f 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1729,6 +1729,25 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
>  	return memblock.reserved.total_size;
>  }
>  
> +/**
> + * memblock_estimated_nr_pages - return number of pages from memblock point of
> + * view

This function returns the estimate for free pages, not the number of pages
in RAM.

How about memblock_estimated_nr_free_pages()?

> + * some calculation before all pages are freed to buddy system, especially
> + * when CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.

I'm failing to parse this sentence. The return value here won't depend on
CONFIG_DEFERRED_STRUCT_PAGE_INIT.

> + *
> + * At this point, we can get this information from memblock. Since the system
> + * state is not settle down and address alignment, the value is an estimation.
> + *
> + * Return:
> + * An estimated number of pages from memblock point of view.

                            ^ free

> + */
> +unsigned long __init memblock_estimated_nr_pages(void)
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

