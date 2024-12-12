Return-Path: <linux-kernel+bounces-442816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6024A9EE258
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5C5188A71B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C403A20C499;
	Thu, 12 Dec 2024 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="i7XXh1uv"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6784B20B808
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994741; cv=none; b=VaHYCSilDz7EvsXPLXod+m6mv5X5iatklshTlJcFShcfjv5Ccg4xctXP5z7Fvj9WvjS8sNDxchU+KzgC2Tr7J8mB7ne8QWozom6WRckDStS6jM19OJZYWveoTy2VLitBvDUMuXTZ95FysacfuA9UdOlRY3G26p9OI825kISdv7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994741; c=relaxed/simple;
	bh=xXdMBIhne4Zrpv5PW28hly1+J49RJvYuxKs0QvYOc2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIxWkVTSp1E4jBdW8degL43fzS4Pwnvb91yhEP+KA2emzxzUoyDiPWTGOs92+RlXjExlt/zNg7swRuabSgb6BMrZwIpNr+l3m8h6y+NOUyLTiANcgzO5HTDSqkvcYpVU22TdJaUqD02f4iRzOw9XkZiF6iK1jiWyYQVVtvI8S3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=i7XXh1uv; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BFF3140E02BC;
	Thu, 12 Dec 2024 09:12:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NMhmaTPJgG2g; Thu, 12 Dec 2024 09:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733994731; bh=2vFLkTzYNWzvXVb8Uw03lgQUYGxhzKYfDttSj1Erlbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7XXh1uvvv7TX0BbVQ2IKoVvxgdyQoYwlmmn9YlECwyAYtsGBoxnahX0/waaN4XcF
	 cp9yCDte4fsSxLOrrVaGu0KVHioZBd1szLCb5uKLfmI6jZVpZZlh5Q7q1Ca9IuGouk
	 HzerdFjUa+0rQLTWyxsamKvjyNzZs+YTXaxSkcISwgw6n9nARCr2vtsiVsRF5sDEz4
	 aa3+p52B1owLb4FSZLJmiJE5TfDzLMF71jAoKpaFdbxPpoACMP2j3lbWg/1SZdddlX
	 CFio2Ei6xfb53MHv31Npdg9WNlrX/Yav6hYXBmmXxGyJakHHSUNLtpuQWknR/V39eb
	 fY9Da+0dN5QCANJJnwf2Qh294Z9MEJUKpVKbylKegQre+0g9pnc2f4n+QcQuLOrFFK
	 fKe5MByfkyiOrF0rhSKUWzM2dkfXcLpCmkFIKb9wAHipGEWtGsOmNgOsr63wISDuLL
	 IBKlzeZ7xs8eWQfefIf4XolXv3vIQRlSgZhFpVV0ycVgVP5yEugg66bKuCfqc8lcGA
	 a4dVArRQvL8GUOnPwAgDYGTvUSdf+JUMr6UN6I4bkJSDnqIDqObgy+lW7NP7obT1kW
	 KCaxryB1lsCm/Uv0JKvRvL9eVdtF3ekFFgW5oMF16i74qWEIbke+xeMfHXFN5oG7QI
	 7Pmk9dG2lq1Mnz0SR8xn/nVs=
Received: from zn.tnic (p200300EA971f93CE329c23FFfea6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:93ce:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E0DD640E0163;
	Thu, 12 Dec 2024 09:12:00 +0000 (UTC)
Date: Thu, 12 Dec 2024 10:11:52 +0100
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
Subject: Re: [PATCH v6 7/8] x86/sev: Add full support for a segmented RMP
 table
Message-ID: <20241212091152.GEZ1qo2CJgP_V7Xvma@fat_crate.local>
References: <cover.1733172653.git.thomas.lendacky@amd.com>
 <c3c5acb445f9cdea6d5c0f16ff961aca65c05528.1733172653.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3c5acb445f9cdea6d5c0f16ff961aca65c05528.1733172653.git.thomas.lendacky@amd.com>

On Mon, Dec 02, 2024 at 02:50:52PM -0600, Tom Lendacky wrote:
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 3272a73d3594..31d653db830a 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -100,6 +100,10 @@ struct rmp_segment_desc {
>   *     a specific portion of memory. There can be up to 512 8-byte entries,
>   *     one pages worth.
>   */
> +#define RST_ENTRY_MAPPED_SIZE(x)	((x) & GENMASK_ULL(19, 0))
> +#define RST_ENTRY_SEGMENT_BASE(x)	((x) & GENMASK_ULL(51, 20))
> +
> +#define RMP_SEGMENT_TABLE_SIZE	SZ_4K

RST_SIZE as we abbreviate the segment table as RST so far...

>  static struct rmp_segment_desc **rmp_segment_table __ro_after_init;
>  static unsigned int rst_max_index __ro_after_init = 512;
>  
> @@ -109,6 +113,9 @@ static u64 rmp_segment_mask;
>  #define RST_ENTRY_INDEX(x)	((x) >> rmp_segment_shift)
>  #define RMP_ENTRY_INDEX(x)	((u64)(PHYS_PFN((x) & rmp_segment_mask)))
>  
> +static u64 rmp_cfg;
> +#define RMP_IS_SEGMENTED(x)	((x) & MSR_AMD64_SEG_RMP_ENABLED)

Please drop those macros.

	if (rmp_cfg & MSR_AMD64_SEG_RMP_ENABLED)

is good enough.

>  /* Mask to apply to a PFN to get the first PFN of a 2MB page */
>  #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
>  
> @@ -200,7 +207,49 @@ static void __init __snp_fixup_e820_tables(u64 pa)
>  void __init snp_fixup_e820_tables(void)
>  {
>  	__snp_fixup_e820_tables(probed_rmp_base);
> -	__snp_fixup_e820_tables(probed_rmp_base + probed_rmp_size);
> +
> +	if (RMP_IS_SEGMENTED(rmp_cfg)) {

That whole branch in a helper, pls, with a descriptive name what it does.

> +		u64 pa, *rst, size, mapped_size;
> +		unsigned int i;
> +
> +		pa = probed_rmp_base;
> +		pa += RMPTABLE_CPU_BOOKKEEPING_SZ;
> +		pa += RMP_SEGMENT_TABLE_SIZE;

		pa = A + B + C
		
> +		__snp_fixup_e820_tables(pa);
> +
> +		pa -= RMP_SEGMENT_TABLE_SIZE;

uff:
		pa = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;

		__snp_fixup_e820_tables(pa + RMP_SEGMENT_TABLE_SIZE);

		rst = early_memremap(pa, RMP_SEGMENT_TABLE_SIZE);

> +		rst = early_memremap(pa, RMP_SEGMENT_TABLE_SIZE);
> +		if (!rst)
> +			return;
> +
> +		for (i = 0; i < rst_max_index; i++) {
> +			pa = RST_ENTRY_SEGMENT_BASE(rst[i]);
> +			mapped_size = RST_ENTRY_MAPPED_SIZE(rst[i]);
> +			if (!mapped_size)
> +				continue;
> +
> +			__snp_fixup_e820_tables(pa);
> +
> +			/*
> +			 * Mapped size in GB. Mapped size is allowed to exceed
> +			 * the segment coverage size, but gets reduced to the
> +			 * segment coverage size.
> +			 */
> +			mapped_size <<= 30;
> +			if (mapped_size > rmp_segment_size)
> +				mapped_size = rmp_segment_size;
> +
> +			/* Calculate the RMP segment size (16 bytes/page mapped) */
> +			size = PHYS_PFN(mapped_size);
> +			size <<= 4;
> +
> +			__snp_fixup_e820_tables(pa + size);
> +		}
> +
> +		early_memunmap(rst, RMP_SEGMENT_TABLE_SIZE);
> +	} else {
> +		__snp_fixup_e820_tables(probed_rmp_base + probed_rmp_size);
> +	}
>  }
>  
>  static bool __init clear_rmptable_bookkeeping(void)
> @@ -308,29 +357,17 @@ static bool __init alloc_rmp_segment_table(void)
>  	return true;
>  }
>  
> -/*
> - * Do the necessary preparations which are verified by the firmware as
> - * described in the SNP_INIT_EX firmware command description in the SNP
> - * firmware ABI spec.
> - */
> -static int __init snp_rmptable_init(void)
> +static bool __init contiguous_rmptable_setup(void)

setup_contiguous_rmptable() and setup_segmented_rmptable() - all natural. :)

>  {
> -	u64 max_rmp_pfn, calc_rmp_sz, rmptable_segment, rmptable_size, rmp_end, val;
> -	unsigned int i;
> -
> -	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> -		return 0;
> -
> -	if (!amd_iommu_snp_en)
> -		goto nosnp;
> +	u64 max_rmp_pfn, calc_rmp_sz, rmptable_segment, rmptable_size, rmp_end;
>  
>  	if (!probed_rmp_size)
> -		goto nosnp;
> +		return false;

Lift that check into rmptable_setup(). Or should it be called setup_rmptable()
too? :)

>  
>  	rmp_end = probed_rmp_base + probed_rmp_size - 1;
>  
>  	/*
> -	 * Calculate the amount the memory that must be reserved by the BIOS to
> +	 * Calculate the amount of memory that must be reserved by the BIOS to
>  	 * address the whole RAM, including the bookkeeping area. The RMP itself
>  	 * must also be covered.
>  	 */
> @@ -342,11 +379,11 @@ static int __init snp_rmptable_init(void)
>  	if (calc_rmp_sz > probed_rmp_size) {
>  		pr_err("Memory reserved for the RMP table does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
>  		       calc_rmp_sz, probed_rmp_size);
> -		goto nosnp;
> +		return false;
>  	}
>  
>  	if (!alloc_rmp_segment_table())
> -		goto nosnp;
> +		return false;
>  
>  	/* Map only the RMP entries */
>  	rmptable_segment = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
> @@ -354,9 +391,127 @@ static int __init snp_rmptable_init(void)
>  
>  	if (!alloc_rmp_segment_desc(rmptable_segment, rmptable_size, 0)) {
>  		free_rmp_segment_table();
> -		goto nosnp;
> +		return false;
>  	}
>  
> +	return true;
> +}
> +
> +static bool __init segmented_rmptable_setup(void)
> +{
> +	u64 rst_pa, *rst, pa, ram_pa_end, ram_pa_max;
> +	unsigned int i, max_index;
> +
> +	if (!probed_rmp_base)
> +		return false;
> +
> +	if (!alloc_rmp_segment_table())
> +		return false;
> +
> +	/* Map the RMP Segment Table */

Kinda obvious, right?

I mean, a variable called "rst_pa" should already explain what it is...

> +	rst_pa = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
> +	rst = memremap(rst_pa, RMP_SEGMENT_TABLE_SIZE, MEMREMAP_WB);
> +	if (!rst) {
> +		pr_err("Failed to map RMP segment table addr %#llx\n", rst_pa);
> +		goto e_free;
> +	}
> +
> +	/* Get the address for the end of system RAM */
> +	ram_pa_max = max_pfn << PAGE_SHIFT;

Ditto.

> +
> +	/* Process each RMP segment */

Ditto.

> +	max_index = 0;
> +	ram_pa_end = 0;
> +	for (i = 0; i < rst_max_index; i++) {
> +		u64 rmp_segment, rmp_size, mapped_size;
> +
> +		mapped_size = RST_ENTRY_MAPPED_SIZE(rst[i]);
> +		if (!mapped_size)
> +			continue;
> +
> +		max_index = i;
> +
> +		/*
> +		 * Mapped size in GB. Mapped size is allowed to exceed the
> +		 * segment coverage size, but gets reduced to the segment
> +		 * coverage size.
> +		 */
> +		mapped_size <<= 30;
> +		if (mapped_size > rmp_segment_size) {
> +			pr_info("RMP segment %u mapped size (0x%llx) reduced to 0x%llx\n",
> +				i, mapped_size, rmp_segment_size);
> +			mapped_size = rmp_segment_size;
> +		}
> +
> +		rmp_segment = RST_ENTRY_SEGMENT_BASE(rst[i]);
> +
> +		/* Calculate the RMP segment size (16 bytes/page mapped) */
> +		rmp_size = PHYS_PFN(mapped_size);
> +		rmp_size <<= 4;

		rmp_size = PHYS_PFN(mapped_size) << 4;

> +
> +		pa = (u64)i << rmp_segment_shift;
> +
> +		/*
> +		 * Some segments may be for MMIO mapped above system RAM. These
> +		 * segments are used for Trusted I/O.
> +		 */
> +		if (pa < ram_pa_max)
> +			ram_pa_end = pa + mapped_size;
> +
> +		if (!alloc_rmp_segment_desc(rmp_segment, rmp_size, pa))
> +			goto e_unmap;
> +
> +		pr_info("RMP segment %u physical address [%#llx - %#llx] covering [%#llx - %#llx]\n",
> +			i, rmp_segment, rmp_segment + rmp_size - 1, pa, pa + mapped_size - 1);
> +	}
> +
> +	if (ram_pa_max > ram_pa_end) {
> +		pr_err("Segmented RMP does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
> +		       ram_pa_max, ram_pa_end);
> +		goto e_unmap;
> +	}
> +
> +	/* Adjust the maximum index based on the found segments */
> +	rst_max_index = max_index + 1;
> +
> +	memunmap(rst);
> +
> +	return true;
> +
> +e_unmap:
> +	memunmap(rst);
> +
> +e_free:
> +	free_rmp_segment_table();
> +
> +	return false;
> +}
> +
> +static bool __init rmptable_setup(void)
> +{
> +	return RMP_IS_SEGMENTED(rmp_cfg) ? segmented_rmptable_setup()
> +					 : contiguous_rmptable_setup();

How is that more readable than the most simple:

	if (rmp_cfg & MSR_AMD64_SEG_RMP_ENABLED)
		return setup_segmented_rmptable();
	else
		return setup_contiguous_rmptable();

?

> +}
> +
> +/*
> + * Do the necessary preparations which are verified by the firmware as
> + * described in the SNP_INIT_EX firmware command description in the SNP
> + * firmware ABI spec.
> + */
> +static int __init snp_rmptable_init(void)
> +{
> +	unsigned int i;
> +	u64 val;
> +
> +	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> +		return 0;
> +
> +	if (!amd_iommu_snp_en)
> +		goto nosnp;
> +
> +	if (!rmptable_setup())
> +		goto nosnp;
> +
>  	/*
>  	 * Check if SEV-SNP is already enabled, this can happen in case of
>  	 * kexec boot.
> @@ -420,7 +575,7 @@ static void set_rmp_segment_info(unsigned int segment_shift)
>  
>  #define RMP_ADDR_MASK GENMASK_ULL(51, 13)
>  
> -bool snp_probe_rmptable_info(void)
> +static bool probe_contiguous_rmptable_info(void)
>  {
>  	u64 rmp_sz, rmp_base, rmp_end;
>  
> @@ -453,6 +608,60 @@ bool snp_probe_rmptable_info(void)
>  	return true;
>  }
>  
> +static bool probe_segmented_rmptable_info(void)
> +{
> +	unsigned int eax, ebx, segment_shift, segment_shift_min, segment_shift_max;
> +	u64 rmp_base, rmp_end;
> +
> +	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
> +	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
> +
> +	if (!(rmp_base & RMP_ADDR_MASK)) {
> +		pr_err("Memory for the RMP table has not been reserved by BIOS\n");
> +		return false;
> +	}

Do them in the right order:

	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
	if (!(rmp_base & RMP_ADDR_MASK)) {
		pr_err("Memory for the RMP table has not been reserved by BIOS\n");
		return false;
	}

	rdmsrl(MSR_AMD64_RMP_END, rmp_end);


> +	WARN_ONCE(rmp_end & RMP_ADDR_MASK,
> +		  "Segmented RMP enabled but RMP_END MSR is non-zero\n");

Meaning?

Fatal error? Doesn't look like it. Sanity-check for BIOS testers?

> +
> +	/* Obtain the min and max supported RMP segment size */
> +	eax = cpuid_eax(0x80000025);
> +	segment_shift_min = eax & GENMASK(5, 0);
> +	segment_shift_max = (eax & GENMASK(11, 6)) >> 6;
> +
> +	/* Verify the segment size is within the supported limits */
> +	segment_shift = MSR_AMD64_RMP_SEGMENT_SHIFT(rmp_cfg);
> +	if (segment_shift > segment_shift_max || segment_shift < segment_shift_min) {
> +		pr_err("RMP segment size (%u) is not within advertised bounds (min=%u, max=%u)\n",
> +		       segment_shift, segment_shift_min, segment_shift_max);
> +		return false;
> +	}
> +
> +	/* Override the max supported RST index if a hardware limit exists */
> +	ebx = cpuid_ebx(0x80000025);
> +	if (ebx & BIT(10))
> +		rst_max_index = ebx & GENMASK(9, 0);
> +
> +	set_rmp_segment_info(segment_shift);
> +
> +	probed_rmp_base = rmp_base;
> +	probed_rmp_size = 0;
> +
> +	pr_info("Segmented RMP base table physical range [0x%016llx - 0x%016llx]\n",
> +		rmp_base, rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ + RMP_SEGMENT_TABLE_SIZE);
> +
> +	return true;
> +}
> +
> +bool snp_probe_rmptable_info(void)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_SEGMENTED_RMP))
> +		rdmsrl(MSR_AMD64_RMP_CFG, rmp_cfg);
> +
> +	return RMP_IS_SEGMENTED(rmp_cfg) ? probe_segmented_rmptable_info()
> +					 : probe_contiguous_rmptable_info();

As above.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

