Return-Path: <linux-kernel+bounces-522736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D146CA3CDFB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A0316E381
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067B5260A5E;
	Wed, 19 Feb 2025 23:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SvJVt76n"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBAB261360
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009483; cv=none; b=VsskfyAhnEsAadCo6CCIqvuwOXqeMhB1ic9BjXWreIvHfGk/77yOGfo8i28BWfH5750POIEtPpRZhC/pIu2R0UuZ00PS4f8i/9UpDaMqoxWOvS3Y2Cfyoyzhfff2/OHzz9q+DZNNSh5B/Jvyk1c5BC8SlfkQpue/45nlNIOA+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009483; c=relaxed/simple;
	bh=XVvSDBWyZa+4bC7yW7xvEto1yJpcvauoHLRdOM6Zh50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrwUBzULkkfJQsddRA+F4J2RBfg3aTmZXSIXUVPSlbYCOZ3MfUc11ACKTQ48kXOFISCpSnvvn72Dk7/LUY/rA0GP1odtqzGrdFlWLzIVjuXye4SnH5vqiNiECzvGju2rKQbPsQRn3hknbCEcrH++7kG2ochC6nCxAQlxrydmseY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SvJVt76n; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 19 Feb 2025 15:57:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740009477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ifri3yR9JqPppqU+vPutRv+m7t0Xgqqx49nMkg0VTfM=;
	b=SvJVt76nU1JxnDfk5q+yWKrTlGCEQpfmftMqIRk2LNwtwF3rXPOo5KCVH/4hudZahpSCrl
	kENdQUpu190uiMYsZF1YjZvUmIm+G06HfMpDLX5KZ7ye41gi3xgyZxvd21Cte1xg1P9dGb
	gBNx8keDX59z3P8z5VTgrEI7cVXO9BI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
Cc: ryan.roberts@arm.com, yang@os.amperecomputing.com,
	catalin.marinas@arm.com, will@kernel.org, joey.gouly@arm.com,
	broonie@kernel.org, mark.rutland@arm.com, james.morse@arm.com,
	yangyicong@hisilicon.com, robin.murphy@arm.com,
	anshuman.khandual@arm.com, maz@kernel.org, liaochang1@huawei.com,
	akpm@linux-foundation.org, david@redhat.com, baohua@kernel.org,
	ioworker0@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] arm64: Add BBM Level 2 cpu feature
Message-ID: <Z7Zv90i0DyvxFUcv@linux.dev>
References: <20250219143837.44277-3-miko.lenczewski@arm.com>
 <20250219143837.44277-5-miko.lenczewski@arm.com>
 <Z7ZqbLdlbmeVX5a0@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7ZqbLdlbmeVX5a0@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 19, 2025 at 03:34:12PM -0800, Oliver Upton wrote:
> Hi Miko,
> 
> On Wed, Feb 19, 2025 at 02:38:38PM +0000, Mikołaj Lenczewski wrote:
> > +config ARM64_ENABLE_BBML2
> 
> nit: consider calling this ARM64_BBML2_NOABORT or similar, since this
> assumes behavior that exceeds the BBML2 baseline.
> 
> > +	bool "Enable support for Break-Before-Make Level 2 detection and usage"
> > +	default y
> > +	help
> > +	  FEAT_BBM provides detection of support levels for break-before-make
> > +	  sequences. If BBM level 2 is supported, some TLB maintenance requirements
> > +	  can be relaxed to improve performance. Selecting N causes the kernel to
> > +	  fallback to BBM level 0 behaviour even if the system supports BBM level 2.
> > +
> 
> [...]
> 
> > +static bool has_bbml2_noconflict(const struct arm64_cpu_capabilities *entry,
> > +				 int scope)
> > +{
> > +	if (!IS_ENABLED(CONFIG_ARM64_ENABLE_BBML2))
> > +		return false;
> > +
> > +	/* We want to allow usage of bbml2 in as wide a range of kernel contexts
> > +	 * as possible. This list is therefore an allow-list of known-good
> > +	 * implementations that both support bbml2 and additionally, fulfil the
> 
> typo: fullfill

I can't spell either ;-)

> > +	 * extra constraint of never generating TLB conflict aborts when using
> > +	 * the relaxed bbml2 semantics (such aborts make use of bbml2 in certain
> > +	 * kernel contexts difficult to prove safe against recursive aborts).
> > +	 */
> 
> We should be *very* specific of what qualifies a 'known-good'
> implementation here. Implementations shouldn't be added to this list
> based on the observed behavior, only if *the implementer* states their
> design will not generate conflict aborts for BBML2 mapping granularity
> changes.
> 
> > +	static const struct midr_range supports_bbml2_without_abort_list[] = {
> > +		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
> > +		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
> > +		{}
> > +	};
> > +
> > +	if (!is_midr_in_range_list(read_cpuid_id(), supports_bbml2_without_abort_list))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> >  #ifdef CONFIG_ARM64_PAN
> >  static void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
> >  {
> > @@ -2926,6 +2951,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
> >  		.matches = has_cpuid_feature,
> >  		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
> >  	},
> > +	{
> > +		.desc = "BBM Level 2 without conflict abort",
> > +		.capability = ARM64_HAS_BBML2_NOCONFLICT,
> > +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> > +		.matches = has_bbml2_noconflict,
> > +		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, BBM, 2)
> > +	},
> >  	{
> >  		.desc = "52-bit Virtual Addressing for KVM (LPA2)",
> >  		.capability = ARM64_HAS_LPA2,
> > diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> > index 1e65f2fb45bd..8d67bb4448c5 100644
> > --- a/arch/arm64/tools/cpucaps
> > +++ b/arch/arm64/tools/cpucaps
> > @@ -26,6 +26,7 @@ HAS_ECV
> >  HAS_ECV_CNTPOFF
> >  HAS_EPAN
> >  HAS_EVT
> > +HAS_BBML2_NOCONFLICT
> 
> Please add this cap to cpucap_is_possible() test for the config option.
> 
> Thanks,
> Oliver

