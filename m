Return-Path: <linux-kernel+bounces-564863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A57ECA65BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D511919A0157
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5314F1B3952;
	Mon, 17 Mar 2025 18:09:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22E719995E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234993; cv=none; b=YNQ/PS5qwwDdk+U0xiPuq+XylEoBx453m0pF++OEzrbf7V4X3a4J93t+HCtIN2jKhyhDEv006IcYmCR7zUgTN1aOXTY3KZDJEQieV/vcpcY2iEMgl+SAYjrdVgnBuN1WH7g1PyALYZZM8r1Q3X8TGmMVBZDPBaG0RaVHfzVe1hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234993; c=relaxed/simple;
	bh=Ou7Utc6DKaTABbNNqNHC8rYJyoB7vEnCz4gdfoDeUHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6un1leQaQeVdniBpTfq8thwrE+RbDjO2Z5+8m5DvfBs6JBOHymyHwM1c1EBZIZujHV4/QmxOC09vyiApcebIlZRb0W7AorKTrSX+EStLQHfmMRK0sHEdFLAoCQYAIJ0862wui/Mk7fNtwi9oRLNXuBgLW2TlJbo02T1h8gdnxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9974313D5;
	Mon, 17 Mar 2025 11:09:58 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60AA13F63F;
	Mon, 17 Mar 2025 11:09:49 -0700 (PDT)
Date: Mon, 17 Mar 2025 18:09:45 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: lcherian@marvell.com, coresight@lists.linaro.org,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 5/7] coresight: Clear self hosted claim tag on probe
Message-ID: <20250317180945.GK2487211@e132581.arm.com>
References: <20250211103945.967495-1-james.clark@linaro.org>
 <20250211103945.967495-6-james.clark@linaro.org>
 <20250313160409.GS9682@e132581.arm.com>
 <6be400e2-a464-4714-acf4-328dade883a9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6be400e2-a464-4714-acf4-328dade883a9@linaro.org>

On Mon, Mar 17, 2025 at 03:05:41PM +0000, James Clark wrote:

[...]

> > >   /*
> > > - * coresight_disclaim_device_unlocked : Clear the claim tag for the device.
> > > + * Clear the claim tag for the device.
> > > + * Returns an error if the device wasn't already claimed.
> > > + */
> > > +int coresight_reset_claim(struct csdev_access *csa)
> > > +{
> > > +       int ret;
> > > +
> > > +       CS_UNLOCK(csa->base);
> > > +       ret = coresight_reset_claim_unlocked(csa);
> > > +       CS_LOCK(csa->base);
> > > +       return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(coresight_reset_claim);
> > 
> > Maybe my question is overlapping with Mike's comment.
> > 
> > Callers never check the return values from coresight_reset_claim(). I am
> 
> I can remove the return value if it's confusing. The thought process was
> probably that it could be useful somewhere in the future, and
> coresight_reset_claim_unlocked() returns something anyway so might as well
> pass it up.
> 
> > wandering if coresight_reset_claim() can directly call
> > coresight_clear_self_claim_tag() for _trying_ to clear self-host tag in
> > probe phase. Any self claim tag issues will be deferred to detect until
> > enable the component.
> > 
> 
> Maybe, the spec does a read before setting which I assumed should be done
> for clearing as well.

If you mean PSCI doc, the flow for claiming tag is a handshake between
self-host software and external debugger, this is why a read is
required.

For a cleaning up, it is not about syncing with external debugger.  And
writing bit 0 to TRCCLAIMCLR will not impact external debugger.  So I
don't think a read prior to cleaning self claim tag is needed.

> As in to not touch anything if it's in use externally.
> It doesn't specifically describe any clearing sequence, but if we assume
> it's ok to blindly clear self hosted flag even when it's in use then yes we
> can directly call coresight_clear_self_claim_tag().

As a result, directly calling coresight_clear_self_claim_tag() works
for me.

Thanks,
Leo

