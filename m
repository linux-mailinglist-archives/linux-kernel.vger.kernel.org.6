Return-Path: <linux-kernel+bounces-521916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4F1A3C3E7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21B827A93A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176201FC7EE;
	Wed, 19 Feb 2025 15:39:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD811FAC31
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979576; cv=none; b=jhpyej3t3cipjJKMhGJt+yZqOeYYcWizzYAAIwE+T8IF+QLGmWdoIYiQ/mq0MBfUAFZwUkTVLD8KzZoCxA3X+wunUW6TD753IdJbjgSFpLbSuTURtbai9ep0B+1pFVpzOlCWOJsYugcpLzPDpu38zR0q00uE83BSX3i8XJtFS1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979576; c=relaxed/simple;
	bh=Ry3S/1dW+hdKw55rvixvVMLC17KAs6jZsDOAF2LH1ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=umY5Y6h2vR7Jh9fOMRMMmV41pVJ9d4r/3glQXT8E4aJsdlC+iWIpf19xkkmQDkX7Wj5ywWw/GzSLy+aBfTyXO2U/7StBwkAdEnUcP/BnYTHHKuu+K+b5XL1idQ3GFFsyvoRJS2R+s4AOH+Qw0o1/gMb5zdAeK7UDi2i4vEV6tSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A1011688;
	Wed, 19 Feb 2025 07:39:52 -0800 (PST)
Received: from [10.57.35.204] (unknown [10.57.35.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71DC73F792;
	Wed, 19 Feb 2025 07:39:28 -0800 (PST)
Message-ID: <a6846db8-9efa-46f8-9939-7727c83d1601@arm.com>
Date: Wed, 19 Feb 2025 15:39:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] arm64: Add BBM Level 2 cpu feature
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 ryan.roberts@arm.com, yang@os.amperecomputing.com, catalin.marinas@arm.com,
 will@kernel.org, joey.gouly@arm.com, broonie@kernel.org,
 mark.rutland@arm.com, james.morse@arm.com, yangyicong@hisilicon.com,
 anshuman.khandual@arm.com, maz@kernel.org, liaochang1@huawei.com,
 akpm@linux-foundation.org, david@redhat.com, baohua@kernel.org,
 ioworker0@gmail.com, oliver.upton@linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250219143837.44277-3-miko.lenczewski@arm.com>
 <20250219143837.44277-5-miko.lenczewski@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250219143837.44277-5-miko.lenczewski@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Miko,

On 2025-02-19 2:38 pm, Mikołaj Lenczewski wrote:
> The Break-Before-Make cpu feature supports multiple levels (levels 0-2),
> and this commit adds a dedicated BBML2 cpufeature to test against
> support for.
> 
> This is a system feature as we might have a big.LITTLE architecture
> where some cores support BBML2 and some don't, but we want all cores to
> be available and BBM to default to level 0 (as opposed to having cores
> without BBML2 not coming online).
> 
> To support BBML2 in as wide a range of contexts as we can, we want not
> only the architectural guarantees that BBML2 makes, but additionally
> want BBML2 to not create TLB conflict aborts. Not causing aborts avoids
> us having to prove that no recursive faults can be induced in any path
> that uses BBML2, allowing its use for arbitrary kernel mappings.
> Support detection of such CPUs.

If this may be used for splitting/compacting userspace mappings, then 
similarly to 6e192214c6c8 ("iommu/arm-smmu-v3: Document SVA interaction 
with new pagetable features"), strictly we'll also want a check in 
arm_smmu_sva_supported() to make sure that the SMMU is OK with BBML2 
behaviour too, and disallow SVA if not. Note that the corresponding 
SMMUv3.2-BBML2 feature is already strict about TLB conflict aborts, so 
is comparatively nice and straightforward.

Thanks,
Robin.

> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> ---
>   arch/arm64/Kconfig                  |  9 ++++++++
>   arch/arm64/include/asm/cpufeature.h |  5 +++++
>   arch/arm64/kernel/cpufeature.c      | 32 +++++++++++++++++++++++++++++
>   arch/arm64/tools/cpucaps            |  1 +
>   4 files changed, 47 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 940343beb3d4..84be2c5976f0 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2057,6 +2057,15 @@ config ARM64_TLB_RANGE
>   	  The feature introduces new assembly instructions, and they were
>   	  support when binutils >= 2.30.
>   
> +config ARM64_ENABLE_BBML2
> +	bool "Enable support for Break-Before-Make Level 2 detection and usage"
> +	default y
> +	help
> +	  FEAT_BBM provides detection of support levels for break-before-make
> +	  sequences. If BBM level 2 is supported, some TLB maintenance requirements
> +	  can be relaxed to improve performance. Selecting N causes the kernel to
> +	  fallback to BBM level 0 behaviour even if the system supports BBM level 2.
> +
>   endmenu # "ARMv8.4 architectural features"
>   
>   menu "ARMv8.5 architectural features"
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index e0e4478f5fb5..2da872035f2e 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -866,6 +866,11 @@ static __always_inline bool system_supports_mpam_hcr(void)
>   	return alternative_has_cap_unlikely(ARM64_MPAM_HCR);
>   }
>   
> +static inline bool system_supports_bbml2_noconflict(void)
> +{
> +	return alternative_has_cap_unlikely(ARM64_HAS_BBML2_NOCONFLICT);
> +}
> +
>   int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
>   bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
>   
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index d561cf3b8ac7..8c337bd95ef7 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2176,6 +2176,31 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
>   	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
>   }
>   
> +static bool has_bbml2_noconflict(const struct arm64_cpu_capabilities *entry,
> +				 int scope)
> +{
> +	if (!IS_ENABLED(CONFIG_ARM64_ENABLE_BBML2))
> +		return false;
> +
> +	/* We want to allow usage of bbml2 in as wide a range of kernel contexts
> +	 * as possible. This list is therefore an allow-list of known-good
> +	 * implementations that both support bbml2 and additionally, fulfil the
> +	 * extra constraint of never generating TLB conflict aborts when using
> +	 * the relaxed bbml2 semantics (such aborts make use of bbml2 in certain
> +	 * kernel contexts difficult to prove safe against recursive aborts).
> +	 */
> +	static const struct midr_range supports_bbml2_without_abort_list[] = {
> +		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
> +		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
> +		{}
> +	};
> +
> +	if (!is_midr_in_range_list(read_cpuid_id(), supports_bbml2_without_abort_list))
> +		return false;
> +
> +	return true;
> +}
> +
>   #ifdef CONFIG_ARM64_PAN
>   static void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
>   {
> @@ -2926,6 +2951,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>   		.matches = has_cpuid_feature,
>   		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
>   	},
> +	{
> +		.desc = "BBM Level 2 without conflict abort",
> +		.capability = ARM64_HAS_BBML2_NOCONFLICT,
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.matches = has_bbml2_noconflict,
> +		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, BBM, 2)
> +	},
>   	{
>   		.desc = "52-bit Virtual Addressing for KVM (LPA2)",
>   		.capability = ARM64_HAS_LPA2,
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index 1e65f2fb45bd..8d67bb4448c5 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -26,6 +26,7 @@ HAS_ECV
>   HAS_ECV_CNTPOFF
>   HAS_EPAN
>   HAS_EVT
> +HAS_BBML2_NOCONFLICT
>   HAS_FPMR
>   HAS_FGT
>   HAS_FPSIMD


