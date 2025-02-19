Return-Path: <linux-kernel+bounces-522316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BEFA3C898
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F8D3AA019
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB1C22ACD1;
	Wed, 19 Feb 2025 19:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HAo43khA"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308FA22A81A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993127; cv=none; b=T1Dhtf2tR+LiRBjW636zDNz60YiK5BF8MHydS/Et+YgBbHOozerFL2Z6o9RXHdYsFkqtknHfROwn9CMKYEOW324ItuptojoGPmmTvuh+yrG/n8uA8Th1hWNa4g0Ei+TKvW7lX/aRXeWHYBDp1ZmUIpBEsYAcx7eZD+wZ0VYm7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993127; c=relaxed/simple;
	bh=SykixatIZerodgATAwVcTB8LToqqQLkJFQdVB2OSm9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EldJIiUj7vJucYLAL65ZyhJU1WbAXNz9SOWvet456kHWEM/ktsZE2jUMcwt/Dhl8eRpqJ+6pAj7YgpqJQNgAQlaVd7Q4LwIqgj2QEUcjmB7aZXAUJd1o1PSKTvEF7mj4LZExbA/i3MkMWHFASv1axnbrYOxyCDjkz+Sg3N2SP80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HAo43khA; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 19 Feb 2025 11:25:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739993112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YWbTsmkFNVzUKGQASgjUS1od0uhjMSBLNuVdbUo2uHQ=;
	b=HAo43khA9DU1uLsdSMUg9nTVrQVQR5iWPGhSRHK2Wp8bg/ugmPa8asiQlOuuhyqh54C2El
	P0Ec3ptzNRyg2MaUQjrQu3nWUclL3MWyd0WopanhROR742V2qiKu4g9fHcKmpvzW/7fYJq
	QFG4ENuIdGD3oxElJek7m3LHNJSXlG0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mingwei Zhang <mizhang@google.com>,
	Colton Lewis <coltonlewis@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Janne Grunau <j@jannau.net>
Subject: Re: [PATCH v2 06/14] KVM: arm64: Remap PMUv3 events onto hardware
Message-ID: <Z7YwEptbRnX5s9Fw@linux.dev>
References: <20250203183111.191519-1-oliver.upton@linux.dev>
 <20250203183111.191519-7-oliver.upton@linux.dev>
 <865xl5sx20.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <865xl5sx20.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 19, 2025 at 04:45:27PM +0000, Marc Zyngier wrote:
> On Mon, 03 Feb 2025 18:31:03 +0000,
> Oliver Upton <oliver.upton@linux.dev> wrote:
> > 
> > Use the provided helper to map PMUv3 event IDs onto hardware, if the
> > driver exposes such a helper. This is expected to be quite rare, and
> > only useful for non-PMUv3 hardware.
> > 
> > Tested-by: Janne Grunau <j@jannau.net>
> > Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> > ---
> >  arch/arm64/kvm/pmu-emul.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
> > index 62349b670cf9..60cf973e2af9 100644
> > --- a/arch/arm64/kvm/pmu-emul.c
> > +++ b/arch/arm64/kvm/pmu-emul.c
> > @@ -673,6 +673,18 @@ static bool kvm_pmc_counts_at_el2(struct kvm_pmc *pmc)
> >  	return kvm_pmc_read_evtreg(pmc) & ARMV8_PMU_INCLUDE_EL2;
> >  }
> >  
> > +static u64 kvm_map_pmu_event(struct kvm *kvm, u64 eventsel)
> > +{
> > +	struct arm_pmu *pmu = kvm->arch.arm_pmu;
> > +	int hw_event;
> > +
> > +	if (!pmu->map_pmuv3_event)
> > +		return eventsel;
> > +
> > +	hw_event = pmu->map_pmuv3_event(eventsel);
> > +	return (hw_event < 0) ? eventsel : hw_event;
> 
> I find this a bit odd. If we can translate events, but failed to do
> so, we still install the originally requested event, and we have no
> idea what this maps to on the HW.
> 
> I'd rather we just don't install that event at all rather than
> counting something random.

Heh, this was a leftover party trick that I was using to try "raw"
events from inside a VM. Happy to limit things to the PMUv3 event space
though.

Thanks,
Oliver

