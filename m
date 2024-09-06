Return-Path: <linux-kernel+bounces-318574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE7096F000
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184AF2865E6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157571C9ECA;
	Fri,  6 Sep 2024 09:44:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178401C9EB8
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615887; cv=none; b=THfuSAZ2ODP4Wz8nC23BTFkuMswZsWvf5oBy6G63dDoeUc0YTkt7/LlHDh1UYshaWb2Oc6T48S59YBT4dlNaqQFrMRab4pqJZzArZyUOakzzZbdnD+JU0zOHdpiSVqdGQxCosRTjH1J55a9l8U8MnIXqKKzAKqRgINByyNciUPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615887; c=relaxed/simple;
	bh=9ODtU11g/u2BLfqy7e5eSMtZdLz4z4P+8IVG8beTBds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fg05xj8MsvlxtflvjBKg+R5J4DLV/BAMy56DztvPbx9Nzq2Jdd+MA7ridcl6q9Lf5m/oaAVV9CjxykMWRR1GXJ41yG2Q0TZI4CASVsJLoTynf9D9iX8NBt85iLqMf2XpX6SHEcIVeoXW9KClasSdNZQsxnHnpmajLA13cllR1fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 427BDFEC;
	Fri,  6 Sep 2024 02:45:12 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D281E3F73F;
	Fri,  6 Sep 2024 02:44:43 -0700 (PDT)
Date: Fri, 6 Sep 2024 10:44:41 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Tian Tao <tiantao6@hisilicon.com>
Cc: catalin.marinas@arm.com, will@kernel.org, jonathan.cameron@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com
Subject: Re: [PATCH] arm64: Add ARM64_HAS_LSE2 CPU capability
Message-ID: <ZtrPCVhqj5qLrQVY@J2N7QTR9R3>
References: <20240906090812.249473-1-tiantao6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240906090812.249473-1-tiantao6@hisilicon.com>

On Fri, Sep 06, 2024 at 05:08:12PM +0800, Tian Tao wrote:
> When FEAT_LSE2 is implemented and Bit 6 of sctlr_elx is nAA, the
> full name of the Not-aligned access. nAA bit has two values:
> 0b0 Unaligned accesses by the specified instructions generate an
> Alignment fault.
> 0b1 Unaligned accesses by the specified instructions do not generate
> an Alignment fault.
> 
> this patch sets the nAA bit to 1,The following instructions will not
> generate an Alignment fault if all bytes being accessed are not within
> a single 16-byte quantity:
> • LDAPR, LDAPRH, LDAPUR, LDAPURH, LDAPURSH, LDAPURSW, LDAR, LDARH,LDLAR,
> LDLARH.
> • STLLR, STLLRH, STLR, STLRH, STLUR, and STLURH
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

What is going to depend on this? Nothing in the kernel depends on being
able to make unaligned accesses with these instructions, and (since you
haven't added a HWCAP), userspace has no idea that these accesses won't
generate an alignment fault.

Mark.

> ---
>  arch/arm64/Kconfig              | 10 ++++++++++
>  arch/arm64/include/asm/sysreg.h |  1 +
>  arch/arm64/kernel/cpufeature.c  | 18 ++++++++++++++++++
>  arch/arm64/tools/cpucaps        |  1 +
>  4 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 77d7ef0b16c2..7afe73ebcd79 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2023,6 +2023,16 @@ config ARM64_TLB_RANGE
>  	  The feature introduces new assembly instructions, and they were
>  	  support when binutils >= 2.30.
>  
> +config ARM64_LSE2_NAA
> +	bool "Enable support for not-aligned access"
> +	depends on AS_HAS_ARMV8_4
> +	help
> +	 LSE2 is an extension to the original LSE (Large System Extensions) feature,
> +	 introduced in ARMv8.4.
> +
> +	 Enable this feature will not generate an Alignment fault if all bytes being
> +	 accessed are not within a single 16-byte quantity.
> +
>  endmenu # "ARMv8.4 architectural features"
>  
>  menu "ARMv8.5 architectural features"
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 8cced8aa75a9..42e3a1959aa8 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -854,6 +854,7 @@
>  #define SCTLR_ELx_ENDB	 (BIT(13))
>  #define SCTLR_ELx_I	 (BIT(12))
>  #define SCTLR_ELx_EOS	 (BIT(11))
> +#define SCTLR_ELx_nAA    (BIT(6))
>  #define SCTLR_ELx_SA	 (BIT(3))
>  #define SCTLR_ELx_C	 (BIT(2))
>  #define SCTLR_ELx_A	 (BIT(1))
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 646ecd3069fd..558869a7c7f0 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2299,6 +2299,14 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
>  }
>  #endif /* CONFIG_ARM64_MTE */
>  
> +#ifdef CONFIG_ARM64_LSE2_NAA
> +static void cpu_enable_lse2(const struct arm64_cpu_capabilities *__unused)
> +{
> +	sysreg_clear_set(sctlr_el2, SCTLR_ELx_nAA, SCTLR_ELx_nAA);
> +	isb();
> +}
> +#endif
> +
>  static void user_feature_fixup(void)
>  {
>  	if (cpus_have_cap(ARM64_WORKAROUND_2658417)) {
> @@ -2427,6 +2435,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		ARM64_CPUID_FIELDS(ID_AA64ISAR0_EL1, ATOMIC, IMP)
>  	},
>  #endif /* CONFIG_ARM64_LSE_ATOMICS */
> +#ifdef CONFIG_ARM64_LSE2_NAA
> +	{
> +		.desc = "Support for not-aligned access",
> +		.capability = ARM64_HAS_LSE2,
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.matches = has_cpuid_feature,
> +		.cpu_enable = cpu_enable_lse2,
> +		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, AT, IMP)
> +	},
> +#endif
>  	{
>  		.desc = "Virtualization Host Extensions",
>  		.capability = ARM64_HAS_VIRT_HOST_EXTN,
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index ac3429d892b9..0c7c0a293574 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -41,6 +41,7 @@ HAS_HCX
>  HAS_LDAPR
>  HAS_LPA2
>  HAS_LSE_ATOMICS
> +HAS_LSE2
>  HAS_MOPS
>  HAS_NESTED_VIRT
>  HAS_PAN
> -- 
> 2.33.0
> 
> 

