Return-Path: <linux-kernel+bounces-523302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A51A3D4E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4416117BA08
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637C41F03C9;
	Thu, 20 Feb 2025 09:37:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481011EE7C4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044229; cv=none; b=la1boBAgEKzRgKFU4vlxWGwIseH4m0Q/YiumevngIqaguNFQ6JZfu7aYfx3UjAQHPSjCtph7FlOsxyMiusAp+O3Kh6DiOWyR/L5aEmJ9qhEnNrd5YBdY51yrEZSqMpsyEjYLe0OKTLNNhuS+zl1AE0wk80/qFi1Taat7qjFiq3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044229; c=relaxed/simple;
	bh=s6mHBIV9sVhHqCCbV2rtlb5EthBKknOJ105oulyFrXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8rlcoL0uLRu/EQh6U75izEx7kiVFfgi3PZih3yKTS5lvDddI1JwtXVVS6GrcV6LO89/Os1taB4LeDZjSMseAdz8ggjp02eRO+Mc49aR4H4VAb8TVTFdmu1jNRuMPRgKqhcuANwuXosyvtbj+yGHV4BPXk+Pi/PkGiMGQERnc1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F93D1BB0;
	Thu, 20 Feb 2025 01:37:24 -0800 (PST)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BA813F6A8;
	Thu, 20 Feb 2025 01:37:03 -0800 (PST)
Date: Thu, 20 Feb 2025 09:37:00 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: ryan.roberts@arm.com, yang@os.amperecomputing.com,
	catalin.marinas@arm.com, will@kernel.org, joey.gouly@arm.com,
	broonie@kernel.org, mark.rutland@arm.com, james.morse@arm.com,
	yangyicong@hisilicon.com, robin.murphy@arm.com,
	anshuman.khandual@arm.com, maz@kernel.org, liaochang1@huawei.com,
	akpm@linux-foundation.org, david@redhat.com, baohua@kernel.org,
	ioworker0@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] arm64: Add BBM Level 2 cpu feature
Message-ID: <20250220093700.GB11745@mazurka.cambridge.arm.com>
References: <20250219143837.44277-3-miko.lenczewski@arm.com>
 <20250219143837.44277-5-miko.lenczewski@arm.com>
 <Z7ZqbLdlbmeVX5a0@linux.dev>
 <Z7Zv90i0DyvxFUcv@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7Zv90i0DyvxFUcv@linux.dev>

Hi Oliver,

Thank you for taking the time to review this patch series.

On Wed, Feb 19, 2025 at 03:57:43PM -0800, Oliver Upton wrote:
> On Wed, Feb 19, 2025 at 03:34:12PM -0800, Oliver Upton wrote:
> > Hi Miko,
> > 
> > On Wed, Feb 19, 2025 at 02:38:38PM +0000, Mikołaj Lenczewski wrote:
> > > +config ARM64_ENABLE_BBML2
> > 
> > nit: consider calling this ARM64_BBML2_NOABORT or similar, since this
> > assumes behavior that exceeds the BBML2 baseline.
> > 

That is a better phrasing, will change this.

> > > +	bool "Enable support for Break-Before-Make Level 2 detection and usage"
> > > +	default y
> > > +	help
> > > +	  FEAT_BBM provides detection of support levels for break-before-make
> > > +	  sequences. If BBM level 2 is supported, some TLB maintenance requirements
> > > +	  can be relaxed to improve performance. Selecting N causes the kernel to
> > > +	  fallback to BBM level 0 behaviour even if the system supports BBM level 2.
> > > +
> > 
> > [...]
> > 

I will assume you mean to add the comment about this technically
exceeding the BBML2 baseline to the docs here as well? Or am I
misunderstanding?

> > > +static bool has_bbml2_noconflict(const struct arm64_cpu_capabilities *entry,
> > > +				 int scope)
> > > +{
> > > +	if (!IS_ENABLED(CONFIG_ARM64_ENABLE_BBML2))
> > > +		return false;
> > > +
> > > +	/* We want to allow usage of bbml2 in as wide a range of kernel contexts
> > > +	 * as possible. This list is therefore an allow-list of known-good
> > > +	 * implementations that both support bbml2 and additionally, fulfil the
> > 
> > typo: fullfill
> 
> I can't spell either ;-)

Spelling is hard, will fix :)

> > > +	 * extra constraint of never generating TLB conflict aborts when using
> > > +	 * the relaxed bbml2 semantics (such aborts make use of bbml2 in certain
> > > +	 * kernel contexts difficult to prove safe against recursive aborts).
> > > +	 */
> > 
> > We should be *very* specific of what qualifies a 'known-good'
> > implementation here. Implementations shouldn't be added to this list
> > based on the observed behavior, only if *the implementer* states their
> > design will not generate conflict aborts for BBML2 mapping granularity
> > changes.
> > 

Understood, will clarify.

> > > diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> > > index 1e65f2fb45bd..8d67bb4448c5 100644
> > > --- a/arch/arm64/tools/cpucaps
> > > +++ b/arch/arm64/tools/cpucaps
> > > @@ -26,6 +26,7 @@ HAS_ECV
> > >  HAS_ECV_CNTPOFF
> > >  HAS_EPAN
> > >  HAS_EVT
> > > +HAS_BBML2_NOCONFLICT
> > 
> > Please add this cap to cpucap_is_possible() test for the config option.
> > 

Sure, will do so.

-- 
Kind regards,
Mikołaj Lenczewski

