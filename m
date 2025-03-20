Return-Path: <linux-kernel+bounces-570113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF930A6AC4F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8AC3463918
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746462253E1;
	Thu, 20 Mar 2025 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JTCyBZ6m"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEEC22540B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492663; cv=none; b=N8Dczian/kgpA/FHD7A60TA8jHNRXJGcTQhLYKLB475sLFBr4QDFabc21t14Z2Gc8DaoyVwI+l4ZP4O/Z3jjZ/U0HZ3A6+5CqWcfNcChwEnYAsbDsJlVWl8HfHPFsh11naE5khF/oiflduMoG83iBMxH4j37cEU9fTFOpSvHj+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492663; c=relaxed/simple;
	bh=kp5gSLLd6PjV+marxwMgoHBh0YDqzC67ywX2X0Na7+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8NOKijIOv6jAehEKGZw12c2hHAw+lSQrphOeu0mhaQslDgQcpyjetn+dxALagPadx3TI1i2clzkJ0Evl7zTl2XNHPIXgFGhiF67af5oinby5SnOxu7VoqmkXEsfiqKfbgCBIMWUtMh+z69MMlnk+yBvqR97xDdtqk0I60VqV7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JTCyBZ6m; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Mar 2025 17:44:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742492660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+nATEGPwxa2fwpxH+oyQjnjtO3F1E78wE3wcZDa8qM=;
	b=JTCyBZ6mjiYhZGkv782PMWnYrzrKTbJ3koWgqojfxmL4ewWviXPY0IyXE8HjwsaLSf10Wc
	NlnV38ZtLi9zY89NSxiMVnXzGuD9xU4Er7f+X8odYLu78qoIK7anhWcMI6CtIv0I/jpVBR
	ltETHPFcSerr+Yyx7eDLcRRzlzAunQw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	devel@daynix.com
Subject: Re: [PATCH RFC] KVM: arm64: PMU: Use multiple host PMUs
Message-ID: <Z9xT4_fwCgp7VSgC@linux.dev>
References: <e8324d9d-3756-41cf-a102-28572e302368@daynix.com>
 <86plidmjwh.wl-maz@kernel.org>
 <bd681ec6-0b4c-47d9-8a4a-b7324c0883a6@daynix.com>
 <86o6xxmg87.wl-maz@kernel.org>
 <aabd71eb-286b-475c-a30e-d5cf5c4f2769@daynix.com>
 <86msdhmemw.wl-maz@kernel.org>
 <cd7b4528-34a3-4d87-9711-acc2c2e6f6e1@daynix.com>
 <86ldt0n9w1.wl-maz@kernel.org>
 <Z9sSMJAlf7cQ5viu@linux.dev>
 <86h63om54p.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86h63om54p.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 20, 2025 at 09:19:02AM +0000, Marc Zyngier wrote:
> On Wed, 19 Mar 2025 18:51:28 +0000, Oliver Upton <oliver.upton@linux.dev> wrote:
> > I'm at least willing to plug my nose and do the following:
> > 
> >  1) When the VMM does not specify a vPMU type:
> > 
> >    - We continue to present the 'default' PMU (including event counters)
> >      to the VM
> > 
> >    - KVM ensures that the fixed CPU cycle counter works on any PMUv3
> >      implementation in the system, even if it is different from the
> >      default
> > 
> >    - Otherwise, event counters will only count on the default
> >      implementation and will not count on different PMUs
> 
> I think this is confusing. The CC is counting, but nothing else, and
> people using the cycle counters in conjunction with other events (a
> very common use case) will not be able to correlate things correctly.
> The current behaviour is, for all its sins, at least consistent.

You of course have a good point. What Windows is doing is definitely an
outlier.

> > 
> >  2) Implement your suggestion of a UAPI where the VMM can select a PMU
> >     that only has the CPU cycle counter and works on any PMUv3
> >     implementation.
> > 
> > Either way KVM will need to have some special case handling of the fixed
> > CPU cycle counter. That'd allow users to actually run Windows *now* and
> > provide a clear mechanism for userspace to present a less-broken vPMU if
> > it cares.
> 
> Honestly, I don't care about one guest or another. My point is that if
> we are changing the behaviour of the PMU to deal with this sort of
> things, then it has to be a userspace buy-in.

I'm fine with just the user buy-in then. But I still do care about the
guest compatibility issue, especially since the end user of all this
crap is unlikely to know/care about the fine details of the
implementation.

So, Akihiko, I would *greatly* appreciate it if you propose a complete
solution to the problem, including the KVM and VMM patches to make it
all work.

Thanks,
Oliver

