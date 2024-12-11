Return-Path: <linux-kernel+bounces-442108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB97B9ED80F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BA6168EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FB2229684;
	Wed, 11 Dec 2024 21:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgWLhRqw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41338229682
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950970; cv=none; b=CmxGzus/knu51/a7SUcj3RH5KgpZekHD+XfF7622MJL7VgsXrOX7EyY9LtzggYijttTlwAI1QG3FbxVkrm7GIQnNhil+7WfYCczjImxNw0et0C/I5YMODVD4GmXAwimkrqkeTclCNVWKQpETRUlDgehpMIFr5pwEA1AUYLkKnbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950970; c=relaxed/simple;
	bh=UuL6Tkk1/zyeCvpCEaNjww627w5GXUASRKbJM/voC/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjVRdZrqlZsC3a4yJ8tQm2qMBHiJPV/RqKvbGAi9QNSkoSwAuQE4P8cpR4Uv7omRLgAXbAD/Rpq1zKAgO1fdAWB4ms62CWyrmLDPlF7qfv0KQw2ehUcxHzJ7e2wY5xMnkwUuNjGVJbcz9bbpZDkTi7JAuXk64ExMh2Yi4B1eAp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgWLhRqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9029FC4CED2;
	Wed, 11 Dec 2024 21:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733950969;
	bh=UuL6Tkk1/zyeCvpCEaNjww627w5GXUASRKbJM/voC/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sgWLhRqwtYaMdcOGWwKKyWGeq8ACgIw3/x30NSZ/jdF7Yw3u3GL0TqGKaSLlTdVWl
	 qGZjbhDa1lnMmACXqPjcTSn/9IgUj74wxP8/meoBl8bPqpemIYuXMDfP+T8UKItV7I
	 ZZ/VETi3pYoCGZnHXXO9sMFPp990bXpRdbg7mAwRBmFvc5Q/MQ+bscn/drmbiIYojf
	 kSLEAEBNNplgxpdDp22F1Dy6UnHF6TP30sNfFVZluvqFR1uQzgNtE5cz+/2sG0CNmK
	 5Cc53VTpAXU8FziYet1gYfskQcuiFEsHUbbltSx0M671uXwbU3yLaj5hYp5yDWklqe
	 RRCkJ3rL8bcjQ==
Date: Wed, 11 Dec 2024 21:02:44 +0000
From: Will Deacon <will@kernel.org>
To: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
Cc: catalin.marinas@arm.com, corbet@lwn.net, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org,
	liunx-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvmarm@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/5] arm64: Add BBM Level 2 cpu feature
Message-ID: <20241211210243.GA17155@willie-the-truck>
References: <20241211154611.40395-1-miko.lenczewski@arm.com>
 <20241211154611.40395-3-miko.lenczewski@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211154611.40395-3-miko.lenczewski@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Dec 11, 2024 at 03:45:03PM +0000, Mikołaj Lenczewski wrote:
> The Break-Before-Make cpu feature supports multiple levels (levels 0-2),
> and this commit adds a dedicated BBML2 cpufeature to test against
> support for.
> 
> In supporting BBM level 2, we open ourselves up to potential TLB
> Conflict Abort Exceptions during expected execution, instead of only
> in exceptional circumstances. In the case of an abort, it is
> implementation defined at what stage the abort is generated, and
> the minimal set of required invalidations is also implementation
> defined. The maximal set of invalidations is to do a `tlbi vmalle1`
> or `tlbi vmalls12e1`, depending on the stage.
> 
> Such aborts should not occur on Arm hardware, and were not seen in
> benchmarked systems, so unless performance concerns arise, implementing
> the abort handlers with the worst-case invalidations seems like an
> alright hack.
> 
> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h | 14 ++++++++++++++
>  arch/arm64/kernel/cpufeature.c      |  7 +++++++
>  arch/arm64/mm/fault.c               | 27 ++++++++++++++++++++++++++-
>  arch/arm64/tools/cpucaps            |  1 +
>  4 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 8b4e5a3cd24c..a9f2ac335392 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -866,6 +866,20 @@ static __always_inline bool system_supports_mpam_hcr(void)
>  	return alternative_has_cap_unlikely(ARM64_MPAM_HCR);
>  }
>  
> +static inline bool system_supports_bbml2(void)
> +{
> +	/* currently, BBM is only relied on by code touching the userspace page
> +	 * tables, and as such we are guaranteed that caps have been finalised.
> +	 *
> +	 * if later we want to use BBM for kernel mappings, particularly early
> +	 * in the kernel, this may return 0 even if BBML2 is actually supported,
> +	 * which means unnecessary break-before-make sequences, but is still
> +	 * correct
> +	 */
> +
> +	return alternative_has_cap_unlikely(ARM64_HAS_BBML2);
> +}
> +
>  int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
>  bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
>  
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 6ce71f444ed8..7cc94bd5da24 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2917,6 +2917,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.matches = has_cpuid_feature,
>  		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
>  	},
> +	{
> +		.desc = "BBM Level 2 Support",
> +		.capability = ARM64_HAS_BBML2,
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.matches = has_cpuid_feature,
> +		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, BBM, 2)
> +	},
>  	{
>  		.desc = "52-bit Virtual Addressing for KVM (LPA2)",
>  		.capability = ARM64_HAS_LPA2,
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index ef63651099a9..dc119358cbc1 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -844,6 +844,31 @@ static int do_tag_check_fault(unsigned long far, unsigned long esr,
>  	return 0;
>  }
>  
> +static int do_conflict_abort(unsigned long far, unsigned long esr,
> +			     struct pt_regs *regs)
> +{
> +	if (!system_supports_bbml2())
> +		return do_bad(far, esr, regs);
> +
> +	/* if we receive a TLB conflict abort, we know that there are multiple
> +	 * TLB entries that translate the same address range. the minimum set
> +	 * of invalidations to clear these entries is implementation defined.
> +	 * the maximum set is defined as either tlbi(vmalls12e1) or tlbi(alle1).
> +	 *
> +	 * if el2 is enabled and stage 2 translation enabled, this may be
> +	 * raised as a stage 2 abort. if el2 is enabled but stage 2 translation
> +	 * disabled, or if el2 is disabled, it will be raised as a stage 1
> +	 * abort.
> +	 *
> +	 * local_flush_tlb_all() does a tlbi(vmalle1), which is enough to
> +	 * handle a stage 1 abort.
> +	 */
> +
> +	local_flush_tlb_all();
> +
> +	return 0;
> +}

Can we actually guarantee that we make it this far without taking another
abort? Given that I'm yet to see one of these things in the wild, I'm
fairly opposed to pretending that we can handle them. We'd be much better
off only violating BBM on CPUs that are known to handle the conflict
gracefully. Judging by your later patch, this is practically keyed off
the MIDR _anyway_...

Will

