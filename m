Return-Path: <linux-kernel+bounces-445144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FA49F11F2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0A0188C166
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6CB1E47C7;
	Fri, 13 Dec 2024 16:21:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4A01E47C2;
	Fri, 13 Dec 2024 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734106870; cv=none; b=cZRNFNll4TM44Ax1FpUchAdy5tn0drytIpfCmre2L0nEgqfVAmePBYNIbhMH3+Cst5t+VeBipy+kGozyj5bu4c72j7XtUSlFPwqX09OBPNjr29+smxxyA1MhKJwUulPc+EGJVXir3fG9r8WJLyArWW5PMmAymXrqsJR8QQWr9wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734106870; c=relaxed/simple;
	bh=14cLsYFgVlJK0eWzZwxb+/bi0EVH4TuNos/YAcwpeEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olkfxkWrucD5PeY5TjIkxXrye+BaBz46+ZNtGpUPczQGiivOZK1RVgBy1GqUJVmubYlfyPUSlZiwFGKzXURA+FNVWRga6JnErsuO5N3D7GpcQabyaLNwv2DOSbHdPVeleSwD2wJKQbCWtCzn9NVE94yEdV7AaCnWH2BIzfybBwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AD5D1595;
	Fri, 13 Dec 2024 08:21:35 -0800 (PST)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.1.196.66])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D90B53F5A1;
	Fri, 13 Dec 2024 08:21:05 -0800 (PST)
Date: Fri, 13 Dec 2024 16:21:03 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [RFC PATCH v1 3/5] arm64: Add errata and workarounds for systems
 with broken BBML2
Message-ID: <20241213162103.GB30314@mazurka.cambridge.arm.com>
References: <20241211154611.40395-1-miko.lenczewski@arm.com>
 <20241211154611.40395-4-miko.lenczewski@arm.com>
 <86pllyrwke.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86pllyrwke.wl-maz@kernel.org>

On Wed, Dec 11, 2024 at 04:52:49PM +0000, Marc Zyngier wrote:
> On Wed, 11 Dec 2024 15:45:04 +0000,
> Mikołaj Lenczewski <miko.lenczewski@arm.com> wrote:
> > 
> > There are systems which claim support for BBML2, but whose
> > implementation of this support is broken. Add a Kconfig erratum for each
> > of these systems, and a cpufeature workaround that forces the supported
> > BBM level on these systems to 0.
> > 
> > Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> > ---
> >  Documentation/arch/arm64/silicon-errata.rst |  32 ++++
> >  arch/arm64/Kconfig                          | 164 ++++++++++++++++++++
> >  arch/arm64/kernel/cpufeature.c              |  32 +++-
> >  3 files changed, 227 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 100570a048c5..9ef8418e8410 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1127,6 +1127,170 @@ config ARM64_ERRATUM_3194386
> >  
> >  	  If unsure, say Y.
> >  
> > +config ARM64_WORKAROUND_BROKEN_BBML2_SUPPORT
> > +	bool
> > +
> > +config ARM64_ERRATUM_3696250
> > +	bool "Neoverse-N2: workaround for broken BBM level 2 support"
> > +	default y
> > +	select ARM64_WORKAROUND_BROKEN_BBML2_SUPPORT
> > +	help
> > +	  Affected Neoverse-N2 cores (r0p0, r0p1, r0p2, r0p3) declare
> 
> So you list a number of affected revisions...
> 
> [...]
> 
> > +static bool has_bbml2(const struct arm64_cpu_capabilities *entry,
> > +		      int scope)
> > +{
> > +	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_BROKEN_BBML2_SUPPORT)) {
> > +		static const struct midr_range broken_bbml2_list[] = {
> > +			MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
> > +			MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
> > +			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
> > +			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
> > +			MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
> > +			MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
> > +			MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
> > +			MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
> > +			MIDR_ALL_VERSIONS(MIDR_CORTEX_X4),
> > +			MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
> > +			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
> > +			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
> > +			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
> > +			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
> > +			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
> > +			{}
> 
> ... and yet you flag all versions as broken? So which one is it? If it
> is really the case that all versions are broken, then the text should
> be simplified. Otherwise, this should really list the broken versions.
> 
> The other thing is that I find it incredibly dangerous to rely on
> some config option to disable a feature that will absolutely eat your
> data if it is broken. I'd rather see the whole BBM-L2 being behind an
> option, and unconditionally check for b0rken CPUs.
> 
> Specially when it looks like there isn't a single CPU on the planet
> that implemented the feature correctly... :-/
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

Thanks for reviewing. Apologies for the delay in responding, and for
spam (replied instead of group-replied).

The workaround kconfig entries should be correct here. The MIDR
revisions will be fixed in the next respin.

I agree that having a BBML2 option and unconditionally guarding against
broken cpus is better, will make that change.

