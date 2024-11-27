Return-Path: <linux-kernel+bounces-423792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 637FF9DACB9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCC1AB21787
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45A4201019;
	Wed, 27 Nov 2024 17:49:42 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CD7819
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732729782; cv=none; b=pzM8diJvu8CLeIjyh11cKMhEjOvsrnnz1wN4hEOCBbRilGX4/WmPZgRNJdeZRQI8LepZlTssprih8Vok4x2vI3D+1UgxfFQpa8Ek9966k9IlogFQgdOtmUCPlKOECt6roevCJNhKufzR6VQmfiK+/Fs54iz8eM9RIuULZkHmLrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732729782; c=relaxed/simple;
	bh=PUTVhrHgjqIZlQ+Hg0cIkwmzEY/1RmchpSVaSThdCwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVWX15DnVNZWybeA7xLkEPwuuGWmR1OqD/Y3NowsybXT//e7CDOwMAPZIXXN3cWNHEo2IBU6Mu58e91mB68v52xO3FjkupWQOAwNLe1MIODceRubdx5qCwT5FuW0N8dJM1s9nO7in+yjT5oSS0jvYKgyH8qV29DBhe6TQ/4PKPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41123C4CECC;
	Wed, 27 Nov 2024 17:49:40 +0000 (UTC)
Date: Wed, 27 Nov 2024 17:49:37 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Baruch Siach <baruch@tkos.co.il>, will@kernel.org, ptesarik@suse.com,
	hch@lst.de, jiangyutang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] arm64: mm: fix zone_dma_limit calculation
Message-ID: <Z0dbsRCsWT3hiVds@arm.com>
References: <20241125171650.77424-1-yang@os.amperecomputing.com>
 <87ttbu8q7s.fsf@tarshish>
 <98583682-a95e-440e-bd89-03828998b48e@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98583682-a95e-440e-bd89-03828998b48e@os.amperecomputing.com>

+ Robin

On Tue, Nov 26, 2024 at 09:38:22AM -0800, Yang Shi wrote:
> On 11/25/24 10:27 PM, Baruch Siach wrote:
> > On Mon, Nov 25 2024, Yang Shi wrote:
> > > The commit ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by
> > > zone_dma_limit") changed how zone_dma_limit was calculated.  Now it
> > > returns the memsize limit in IORT or device tree instead of U32_MAX if
> > > the memsize limit is greater than U32_MAX.
> > 
> > Can you give a concrete example of memory layout and dma-ranges that
> > demonstrates this issue?
> 
> Our 2 sockets system has physical memory starts at 0x0 on node 0 and
> 0x200000000000 on node 1. The memory size limit defined in IORT is 0x30 (48
> bits).
> 
> The DMA zone is:
> 
> pages free     887722
>         boost    0
>         min      229
>         low      1108
>         high     1987
>         promo    2866
>         spanned  983040
>         present  982034
>         managed  903238
>         cma      16384
>         protection: (0, 0, 124824, 0, 0)
>  start_pfn:           65536
> 
> When allocating DMA buffer, dma_direct_optimal_gfp_mask() is called to
> determine the proper zone constraints. If the phys_limit is less than
> zone_dma_limit, it will use GFP_DMA. But zone_dma_limit is 0xffffffffffff on
> v6.12 instead of 4G prior v6.12, it means all DMA buffer allocation will go
> to DMA zone even though the devices don't require it.
> 
> DMA zone is on node 0, so we saw excessive remote access on 2 sockets
> system.
[...]
> The physical addr range for DMA zone is correct, the problem is wrong
> zone_dma_limit. Before commit ba0fb44aed47 zone_dma_limit was 4G, after it
> it is the whole memory even though DMA zone just covers low 4G.

Thanks for the details. I agree that zone_dma_limit shouldn't be higher
than the ZONE_DMA upper boundary, otherwise it gets confusing for
functions like dma_direct_optimal_gfp_mask() and we may force
allocations to a specific range unnecessarily.

If IORT or DT indicate a large mask covering the whole RAM (i.e. no
restrictions), in an ideal world, we should normally extend ZONE_DMA to
the same. One problem is ZONE_DMA32 (and GFP_DMA32) and the fact that
ZONE_DMA sits below it. Until we hear otherwise, we assume a DMA offset
of 0 for such 32-bit devices and therefore define ZONE_DMA32 in the
lower 4GB if RAM starts below this limit (and an empty ZONE_DMA32 if RAM
starts above).

Another aspect to consider is that we don't always have DT or IORT
information or some devices need a smaller limit than what's advertised
in the firmware tables (typically 32-bit masks). This code went through
a couple of fixes already:

833bd284a454 ("arm64: mm: fix DMA zone when dma-ranges is missing")
122c234ef4e1 ("arm64: mm: keep low RAM dma zone")

Since our current assumption is to assume ZONE_DMA within 32-bit if RAM
below 4GB, I'm happy to make this conditional on CONFIG_ZONE_DMA32 also
being enabled. So, from your patch below:

> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index d21f67d67cf5..ccdef53872a0 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -117,15 +117,6 @@ static void __init arch_reserve_crashkernel(void)
>   static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
>   {
> -	/**
> -	 * Information we get from firmware (e.g. DT dma-ranges) describe DMA
> -	 * bus constraints. Devices using DMA might have their own limitations.
> -	 * Some of them rely on DMA zone in low 32-bit memory. Keep low RAM
> -	 * DMA zone on platforms that have RAM there.
> -	 */
> -	if (memblock_start_of_DRAM() < U32_MAX)
> -		zone_limit = min(zone_limit, U32_MAX);
> -
>   	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
>   }

This part is fine.

> @@ -141,6 +132,14 @@ static void __init zone_sizes_init(void)
>   	acpi_zone_dma_limit = acpi_iort_dma_get_max_cpu_address();
>   	dt_zone_dma_limit = of_dma_get_max_cpu_address(NULL);
>   	zone_dma_limit = min(dt_zone_dma_limit, acpi_zone_dma_limit);
> +	/*
> +	 * Information we get from firmware (e.g. DT dma-ranges) describe DMA
> +	 * bus constraints. Devices using DMA might have their own limitations.
> +	 * Some of them rely on DMA zone in low 32-bit memory. Keep low RAM
> +	 * DMA zone on platforms that have RAM there.
> +	 */
> +	if (memblock_start_of_DRAM() < U32_MAX)
> +		zone_dma_limit = min(zone_dma_limit, U32_MAX);
>   	arm64_dma_phys_limit = max_zone_phys(zone_dma_limit);
>   	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
>   #endif

But I'd move the zone_dma_limit update further down in the
CONFIG_ZONE_DMA32 block. I think we only need to limit it to
dma32_phys_limit and ignore the U32_MAX check. The former is already
capped to 32-bit. For the second hunk, something like below (untested):

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d21f67d67cf5..ffaf5bd8d0a1 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -146,8 +146,10 @@ static void __init zone_sizes_init(void)
 #endif
 #ifdef CONFIG_ZONE_DMA32
 	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(dma32_phys_limit);
-	if (!arm64_dma_phys_limit)
+	if (!arm64_dma_phys_limit || arm64_dma_phys_limit > dma32_phys_limit) {
 		arm64_dma_phys_limit = dma32_phys_limit;
+		zone_dma_limit = arm64_dma_phys_limit - 1;
+	}
 #endif
 	if (!arm64_dma_phys_limit)
 		arm64_dma_phys_limit = PHYS_MASK + 1;

With some comment on why we do this but most likely not the current
comment in max_zone_phys() (more like keep ZONE_DMA below ZONE_DMA32).

-- 
Catalin

