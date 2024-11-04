Return-Path: <linux-kernel+bounces-394564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7469BB134
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3316B22E03
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3FF1B2183;
	Mon,  4 Nov 2024 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Mfi+W8C4"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4671AA78E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730716458; cv=none; b=q39q7G84EwP3iX+r6GtYTJdM3TFXDd6ppzmOR0AYQktFlBymHYy0+a27uHfDGdyeLWf1tlBA6O0mzj2ED33IzFl8W/ufd6R3IYYBCXqeg3HDdDLyYno93W5osyTluGgcsO5KL8Yi+pqTzKHqnjIkfzXUPzqwvJ5ATbtJ3v2IM64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730716458; c=relaxed/simple;
	bh=XsSK1pgFkq/A8OPkXk1PFtJbDDL8j8PKfqVydQMIN0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToNndl9ujsztyzj9rYhm+IuczVrWyL901wbhOkQfBFuBecDv1MXx5xwXw9/x6oTbIAmsu81pKncXcCLLYeA9rXO+cEvbVyBPrJZjATFd+cnfusW2n9he2n97DDzdFzRE8Pp8rPTUtaYlGLlVNv2LBwHDNuhu3dsguvpal1rz2Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Mfi+W8C4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AF11240E0220;
	Mon,  4 Nov 2024 10:34:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GlEbUDbfxOfC; Mon,  4 Nov 2024 10:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730716449; bh=0P18ZrrmAmT3HPBY8Q9a6NOAZGOw/hKyTseW5GSe9+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mfi+W8C4uqdDLJlkljhRMHo4L36g3Hl/GEDhEMVyjNUBTG5es4k+wXZ24jLp2Zj95
	 hYwi33pWUGmYJCZAySDUCpYVRZRCDS9+8t3Dah2DB1uwAKDXh/RDyVE6pZsGzecjjS
	 FeC4QoXR3eqQdQkbjMCAbl9UonjJ+WT/scxFhNvX5bwZKedcNBcVzR/udt3tNnGHOc
	 uL+1qMslM5idVUDFEritot6hSgot2KPLsW1wIE9D7KnIwu6ke0K/rkGsKO4dn7dv7d
	 RQt4NWJy28G0Gi7dqXwYFWJ3mAVvHX+LI2zen+55LuW8hQZdTsfjUplSrkxkDhHL9G
	 pnSodqiuu4Ujl3xH0iUXd6XJj3xn0n8+gBt+JG/E/0QPB208Mn1nl6wqIRPAfYp+5g
	 YGcYYyp7sBlakdmWchAdMMkR1zbXDyEIJ/2G/dXzeONeZE9WePX3gELhBbtzdRDYph
	 b+CUMHdU2lfTKSDaAeN0LpV7dihu8e6Viax2kbJPn3zCnEcr0ulqxioBIAM2MXAGiC
	 94bKC+7ZPLaEZuQlTv7ZDFPQJCJujqtx9LTEUkLHI+hfwnYRUO6X9bkuUgvM9c2K2w
	 K/5LsOFxl5hTa8FuRiYp1xL/WOHwSpcwl1kg6yVZY82amncWmLV6rXepXbFJxMIjxR
	 eDabSY/0rN+wIB9BfDQzMEYo=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A9E640E0163;
	Mon,  4 Nov 2024 10:33:59 +0000 (UTC)
Date: Mon, 4 Nov 2024 11:33:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH v5 6/8] x86/sev: Treat the contiguous RMP table as a
 single RMP segment
Message-ID: <20241104103353.GQZyijEalUocS_yG5r@fat_crate.local>
References: <cover.1730143962.git.thomas.lendacky@amd.com>
 <6118c46de2b2260b72dd3ed4421e5e08713fd47a.1730143962.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6118c46de2b2260b72dd3ed4421e5e08713fd47a.1730143962.git.thomas.lendacky@amd.com>

On Mon, Oct 28, 2024 at 02:32:41PM -0500, Tom Lendacky wrote:
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 5871c924c0b2..37ff4f98e8d1 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -18,6 +18,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/iommu.h>
>  #include <linux/amd-iommu.h>
> +#include <linux/nospec.h>

What's that include for?

For array_index_nospec() below?

It builds without it or did you trigger a build error with some funky .config?

>  #include <asm/sev.h>
>  #include <asm/processor.h>
> @@ -77,12 +78,42 @@ struct rmpentry_raw {
>   */
>  #define RMPTABLE_CPU_BOOKKEEPING_SZ	0x4000
>  
> +/*
> + * For a non-segmented RMP table, use the maximum physical addressing as the
> + * segment size in order to always arrive at index 0 in the table.
> + */
> +#define RMPTABLE_NON_SEGMENTED_SHIFT	52
> +
> +struct rmp_segment_desc {
> +	struct rmpentry_raw *rmp_entry;
> +	u64 max_index;
> +	u64 size;
> +};
> +
> +/*
> + * Segmented RMP Table support.
> + *   - The segment size is used for two purposes:
> + *     - Identify the amount of memory covered by an RMP segment
> + *     - Quickly locate an RMP segment table entry for a physical address
> + *
> + *   - The RMP segment table contains pointers to an RMP table that covers
> + *     a specific portion of memory. There can be up to 512 8-byte entries,
> + *     one pages worth.
> + */
> +static struct rmp_segment_desc **rmp_segment_table __ro_after_init;
> +static unsigned int rst_max_index __ro_after_init = 512;
> +
> +static u64 rmp_segment_size_max;

This one is used in a single function. Generate it there pls.

> +static unsigned int rmp_segment_coverage_shift;
> +static u64 rmp_segment_coverage_size;
> +static u64 rmp_segment_coverage_mask;

That "_coverage_" in there looks redundant to me and could go and make those
variables shorter.

> +#define RST_ENTRY_INDEX(x)	((x) >> rmp_segment_coverage_shift)
> +#define RMP_ENTRY_INDEX(x)	((u64)(PHYS_PFN((x) & rmp_segment_coverage_mask)))
> +
>  /* Mask to apply to a PFN to get the first PFN of a 2MB page */
>  #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
>  
>  static u64 probed_rmp_base, probed_rmp_size;
> -static struct rmpentry_raw *rmptable __ro_after_init;
> -static u64 rmptable_max_pfn __ro_after_init;
>  
>  static LIST_HEAD(snp_leaked_pages_list);
>  static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
> @@ -190,6 +221,92 @@ static bool __init init_rmptable_bookkeeping(void)
>  	return true;
>  }
>  
> +static bool __init alloc_rmp_segment_desc(u64 segment_pa, u64 segment_size, u64 pa)
> +{
> +	struct rmp_segment_desc *desc;
> +	void *rmp_segment;
> +	u64 rst_index;
> +
> +	/* Validate the RMP segment size */
> +	if (segment_size > rmp_segment_size_max) {
> +		pr_err("Invalid RMP size (%#llx) for configured segment size (%#llx)\n",
> +		       segment_size, rmp_segment_size_max);
> +		return false;
> +	}
> +
> +	/* Validate the RMP segment table index */
> +	rst_index = RST_ENTRY_INDEX(pa);
> +	if (rst_index >= rst_max_index) {
> +		pr_err("Invalid RMP segment base address (%#llx) for configured segment size (%#llx)\n",
> +		       pa, rmp_segment_coverage_size);
> +		return false;
> +	}
> +	rst_index = array_index_nospec(rst_index, rst_max_index);

Why are we doing this here? Are you expecting some out-of-bounds
user-controlled values here?

AFAICT, this is all read from the hw/fw so why are speculative accesses
a problem?

> +	if (rmp_segment_table[rst_index]) {
> +		pr_err("RMP segment descriptor already exists at index %llu\n", rst_index);
> +		return false;
> +	}
> +
> +	/* Map the RMP entries */

Kinda obvious...

> +	rmp_segment = memremap(segment_pa, segment_size, MEMREMAP_WB);
> +	if (!rmp_segment) {
> +		pr_err("Failed to map RMP segment addr 0x%llx size 0x%llx\n",
> +		       segment_pa, segment_size);
> +		return false;
> +	}
> +
> +	desc = kzalloc(sizeof(*desc), GFP_KERNEL);

			sizeof(struct rmp_segment_desc)


> +	if (!desc) {
> +		memunmap(rmp_segment);
> +		return false;
> +	}
> +
> +	desc->rmp_entry = rmp_segment;
> +	desc->max_index = segment_size / sizeof(*desc->rmp_entry);
> +	desc->size = segment_size;
> +
> +	/* Add the segment descriptor to the table */
> +	rmp_segment_table[rst_index] = desc;
> +
> +	return true;
> +}

...

> @@ -248,12 +366,20 @@ static int __init snp_rmptable_init(void)
>  
>  	/* Zero out the RMP bookkeeping area */
>  	if (!init_rmptable_bookkeeping()) {
> -		memunmap(rmptable_start);
> +		free_rmp_segment_table();
>  		goto nosnp;
>  	}
>  
>  	/* Zero out the RMP entries */
> -	memset(rmptable_start, 0, rmptable_size);
> +	for (i = 0; i < rst_max_index; i++) {
> +		struct rmp_segment_desc *desc;
> +
> +		desc = rmp_segment_table[i];
> +		if (!desc)
> +			continue;
> +
> +		memset(desc->rmp_entry, 0, desc->size);
> +	}

Why isn't this zeroing out part of alloc_rmp_segment_table()?

> @@ -319,13 +458,29 @@ bool snp_probe_rmptable_info(void)
>  
>  static struct rmpentry_raw *get_raw_rmpentry(u64 pfn)
>  {
> -	if (!rmptable)
> +	struct rmp_segment_desc *desc;
> +	u64 paddr, rst_index, segment_index;

Reverse xmas tree order pls.

> +	if (!rmp_segment_table)
>  		return ERR_PTR(-ENODEV);
>  
> -	if (unlikely(pfn > rmptable_max_pfn))
> +	paddr = pfn << PAGE_SHIFT;
> +
> +	rst_index = RST_ENTRY_INDEX(paddr);
> +	if (unlikely(rst_index >= rst_max_index))
> +		return ERR_PTR(-EFAULT);
> +	rst_index = array_index_nospec(rst_index, rst_max_index);

Same question as above.

> +
> +	desc = rmp_segment_table[rst_index];
> +	if (unlikely(!desc))
>  		return ERR_PTR(-EFAULT);
>  
> -	return rmptable + pfn;
> +	segment_index = RMP_ENTRY_INDEX(paddr);
> +	if (unlikely(segment_index >= desc->max_index))
> +		return ERR_PTR(-EFAULT);
> +	segment_index = array_index_nospec(segment_index, desc->max_index);
> +
> +	return desc->rmp_entry + segment_index;
>  }

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

