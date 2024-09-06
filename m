Return-Path: <linux-kernel+bounces-318743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E66496F26C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0B61F218A2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A8A1CB147;
	Fri,  6 Sep 2024 11:09:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66D41C870E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725620965; cv=none; b=VH8gyyuaYiHCozmkJzA5NUG6W4/zqbp3RIr4NHyZz4SyBzP7XsWpEjnPegYAG57s7wT5Vo4bB9Rf74ocI99BBoGk/1w1OVD1K4axXR4vCKtE0Y/OaJS8adLGVmdS10++M7VHf5qb3xpltYOokjofUgj8rMkJEWA+SlsMz+/tdJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725620965; c=relaxed/simple;
	bh=d3vs+RPaypFWicZQZYL9ZI9LMD15PKjB5n0Qm0H7qaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niKwF1E9bVGd/xjCJQV2ZXq7Bw7gPGdlrov477oAM4VNV/Y0bPg5aUSQKfw/KGMt6IxGY2nmiUZm3nEGJO1WCqUGVBf5O53BgBblGvwVxO5ZT2U3ZzVyHRVDn4eLpcXqSvW14Q7fBfrP3vRGkftdoIZ2uAgFiK7d6JSYDGUuyFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5132FEC;
	Fri,  6 Sep 2024 04:09:49 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A385F3F66E;
	Fri,  6 Sep 2024 04:09:21 -0700 (PDT)
Date: Fri, 6 Sep 2024 12:09:15 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "tiantao (H)" <tiantao6@hisilicon.com>
Cc: catalin.marinas@arm.com, will@kernel.org, jonathan.cameron@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com
Subject: Re: [PATCH] arm64: Add ARM64_HAS_LSE2 CPU capability
Message-ID: <Ztri2xyzjaB7k387@J2N7QTR9R3>
References: <20240906090812.249473-1-tiantao6@hisilicon.com>
 <ZtrPCVhqj5qLrQVY@J2N7QTR9R3>
 <587f7c84-cdfc-b348-4cd0-1015adad2cca@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <587f7c84-cdfc-b348-4cd0-1015adad2cca@hisilicon.com>

On Fri, Sep 06, 2024 at 06:58:19PM +0800, tiantao (H) wrote:
> 
> 在 2024/9/6 17:44, Mark Rutland 写道:
> > On Fri, Sep 06, 2024 at 05:08:12PM +0800, Tian Tao wrote:
> > > When FEAT_LSE2 is implemented and Bit 6 of sctlr_elx is nAA, the
> > > full name of the Not-aligned access. nAA bit has two values:
> > > 0b0 Unaligned accesses by the specified instructions generate an
> > > Alignment fault.
> > > 0b1 Unaligned accesses by the specified instructions do not generate
> > > an Alignment fault.
> > > 
> > > this patch sets the nAA bit to 1,The following instructions will not
> > > generate an Alignment fault if all bytes being accessed are not within
> > > a single 16-byte quantity:
> > > • LDAPR, LDAPRH, LDAPUR, LDAPURH, LDAPURSH, LDAPURSW, LDAR, LDARH,LDLAR,
> > > LDLARH.
> > > • STLLR, STLLRH, STLR, STLRH, STLUR, and STLURH
> > > 
> > > Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> > What is going to depend on this? Nothing in the kernel depends on being
> > able to make unaligned accesses with these instructions, and (since you
> > haven't added a HWCAP), userspace has no idea that these accesses won't
> > generate an alignment fault.
> > 
> > Mark.
> 
> I've come across a situation where the simplified code is as follows:
> 
>  long  address = (long) mmap(NULL,1024*1024*2,PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS,-1,0);
> 
> long new_address = address + 9;
> 
>  long *p = (long*) new_address;
>  long v = -1;
> 
>  __atomic_store(p, &v, __ATOMIC_RELEASE);
> 
> coredump occurs after executing __atomic_store, but the user code can't be
> changed,

Where is that code and why can't it be changed? That code has never
worked and would always have generated a coredump, and even with this
patch it cannot work on hardware without LSE2.

> so I'm trying to enable NAA to solve this problem.

AFAICT that's making a kernel change to paper over a userspace bug.
As-is I don't think that's a good justification for changing nAA.

Mark.

> 
> > > ---
> > >   arch/arm64/Kconfig              | 10 ++++++++++
> > >   arch/arm64/include/asm/sysreg.h |  1 +
> > >   arch/arm64/kernel/cpufeature.c  | 18 ++++++++++++++++++
> > >   arch/arm64/tools/cpucaps        |  1 +
> > >   4 files changed, 30 insertions(+)
> > > 
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index 77d7ef0b16c2..7afe73ebcd79 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -2023,6 +2023,16 @@ config ARM64_TLB_RANGE
> > >   	  The feature introduces new assembly instructions, and they were
> > >   	  support when binutils >= 2.30.
> > > +config ARM64_LSE2_NAA
> > > +	bool "Enable support for not-aligned access"
> > > +	depends on AS_HAS_ARMV8_4
> > > +	help
> > > +	 LSE2 is an extension to the original LSE (Large System Extensions) feature,
> > > +	 introduced in ARMv8.4.
> > > +
> > > +	 Enable this feature will not generate an Alignment fault if all bytes being
> > > +	 accessed are not within a single 16-byte quantity.
> > > +
> > >   endmenu # "ARMv8.4 architectural features"
> > >   menu "ARMv8.5 architectural features"
> > > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > > index 8cced8aa75a9..42e3a1959aa8 100644
> > > --- a/arch/arm64/include/asm/sysreg.h
> > > +++ b/arch/arm64/include/asm/sysreg.h
> > > @@ -854,6 +854,7 @@
> > >   #define SCTLR_ELx_ENDB	 (BIT(13))
> > >   #define SCTLR_ELx_I	 (BIT(12))
> > >   #define SCTLR_ELx_EOS	 (BIT(11))
> > > +#define SCTLR_ELx_nAA    (BIT(6))
> > >   #define SCTLR_ELx_SA	 (BIT(3))
> > >   #define SCTLR_ELx_C	 (BIT(2))
> > >   #define SCTLR_ELx_A	 (BIT(1))
> > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > index 646ecd3069fd..558869a7c7f0 100644
> > > --- a/arch/arm64/kernel/cpufeature.c
> > > +++ b/arch/arm64/kernel/cpufeature.c
> > > @@ -2299,6 +2299,14 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
> > >   }
> > >   #endif /* CONFIG_ARM64_MTE */
> > > +#ifdef CONFIG_ARM64_LSE2_NAA
> > > +static void cpu_enable_lse2(const struct arm64_cpu_capabilities *__unused)
> > > +{
> > > +	sysreg_clear_set(sctlr_el2, SCTLR_ELx_nAA, SCTLR_ELx_nAA);
> > > +	isb();
> > > +}
> > > +#endif
> > > +
> > >   static void user_feature_fixup(void)
> > >   {
> > >   	if (cpus_have_cap(ARM64_WORKAROUND_2658417)) {
> > > @@ -2427,6 +2435,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
> > >   		ARM64_CPUID_FIELDS(ID_AA64ISAR0_EL1, ATOMIC, IMP)
> > >   	},
> > >   #endif /* CONFIG_ARM64_LSE_ATOMICS */
> > > +#ifdef CONFIG_ARM64_LSE2_NAA
> > > +	{
> > > +		.desc = "Support for not-aligned access",
> > > +		.capability = ARM64_HAS_LSE2,
> > > +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> > > +		.matches = has_cpuid_feature,
> > > +		.cpu_enable = cpu_enable_lse2,
> > > +		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, AT, IMP)
> > > +	},
> > > +#endif
> > >   	{
> > >   		.desc = "Virtualization Host Extensions",
> > >   		.capability = ARM64_HAS_VIRT_HOST_EXTN,
> > > diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> > > index ac3429d892b9..0c7c0a293574 100644
> > > --- a/arch/arm64/tools/cpucaps
> > > +++ b/arch/arm64/tools/cpucaps
> > > @@ -41,6 +41,7 @@ HAS_HCX
> > >   HAS_LDAPR
> > >   HAS_LPA2
> > >   HAS_LSE_ATOMICS
> > > +HAS_LSE2
> > >   HAS_MOPS
> > >   HAS_NESTED_VIRT
> > >   HAS_PAN
> > > -- 
> > > 2.33.0
> > > 
> > > 
> > .
> > 

