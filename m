Return-Path: <linux-kernel+bounces-445138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507639F11E2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0777A283855
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA351E22FC;
	Fri, 13 Dec 2024 16:17:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7CB139587
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734106653; cv=none; b=CiNeX1+SYxEGas8wLDTP2mK1lR2v6uhxbOkDfhjv0WkWitLGdTuy+L98OtNweshQVo5L120vyFgngjUiYO79RCZbYSbS16LvWdJAm+dlYx/mA/MOLGys19ZCa4yzHe8oQk+FXOyhu87hsYdLcptUo7rNwaMYfyfCjQr37fE85To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734106653; c=relaxed/simple;
	bh=6o9bgjsSLRjpX2/vlcI0zYEd0KtRqYp3VjY6EjJIfKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiBwWD+KEnmGHnzkbjjCIjFJAzPguQjiatqJkI5UzmAALXWxT6tKC3p0b+OF9luKTEYCmsAYGEFrfnx5jd+5arrNJRe/FSXw4JBcaGrAt0JmbtjBSjuyts/BSa5DUFrEw4nhxEiLgpvNtXQw0hkl/XoBSeFdk1DJcPEsBLmZLIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 288461480;
	Fri, 13 Dec 2024 08:17:58 -0800 (PST)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.1.196.66])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 969933F5A1;
	Fri, 13 Dec 2024 08:17:28 -0800 (PST)
Date: Fri, 13 Dec 2024 16:17:26 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, corbet@lwn.net, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org,
	liunx-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvmarm@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/5] arm64: Add BBM Level 2 cpu feature
Message-ID: <20241213161726.GA30314@mazurka.cambridge.arm.com>
References: <20241211154611.40395-1-miko.lenczewski@arm.com>
 <20241211154611.40395-3-miko.lenczewski@arm.com>
 <20241211210243.GA17155@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211210243.GA17155@willie-the-truck>

> > +static int do_conflict_abort(unsigned long far, unsigned long esr,
> > +			     struct pt_regs *regs)
> > +{
> > +	if (!system_supports_bbml2())
> > +		return do_bad(far, esr, regs);
> > +
> > +	/* if we receive a TLB conflict abort, we know that there are multiple
> > +	 * TLB entries that translate the same address range. the minimum set
> > +	 * of invalidations to clear these entries is implementation defined.
> > +	 * the maximum set is defined as either tlbi(vmalls12e1) or tlbi(alle1).
> > +	 *
> > +	 * if el2 is enabled and stage 2 translation enabled, this may be
> > +	 * raised as a stage 2 abort. if el2 is enabled but stage 2 translation
> > +	 * disabled, or if el2 is disabled, it will be raised as a stage 1
> > +	 * abort.
> > +	 *
> > +	 * local_flush_tlb_all() does a tlbi(vmalle1), which is enough to
> > +	 * handle a stage 1 abort.
> > +	 */
> > +
> > +	local_flush_tlb_all();
> > +
> > +	return 0;
> > +}
> 
> Can we actually guarantee that we make it this far without taking another
> abort? Given that I'm yet to see one of these things in the wild, I'm
> fairly opposed to pretending that we can handle them. We'd be much better
> off only violating BBM on CPUs that are known to handle the conflict
> gracefully. Judging by your later patch, this is practically keyed off
> the MIDR _anyway_...
> 
> Will

Thanks for reviewing. Apologies for the delay in responding, and for
spam (replied instead of group-replied).

There should not be an option to take another fault while performing the
handler, as long as the mappings covering the fault handler table or any
code in this path are not screwed with. This is discussed further in the
resent patch series [1].

The MIDR revisions will be fixed. I was confused as to which revisions
were affected on an earlier version of the series, and had missed
updating them. The kconfig workarounds should be correct in this regard.

[1]: https://lore.kernel.org/all/084c5ada-51af-4c1a-b50a-4401e62ddbd6@arm.com/

