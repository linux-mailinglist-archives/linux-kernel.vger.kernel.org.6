Return-Path: <linux-kernel+bounces-568613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BBCA69868
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3374811B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CFD20B812;
	Wed, 19 Mar 2025 18:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KqcKeG4k"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8767314AD29
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742410311; cv=none; b=oM4I+w22U0oiUVpq+bdAxHDAJN6UOXYrjF+R7u2mqotgfe4My8/b+F056Wc85hROrxd+QLupKuyJJOggTCF6xvyGmAMVnUU0l0b3/yp+kegJF8aXjZeVgd9Iuos+Kw21vLM+d+jLgiLA8qzvOBIp38F1TL6dYZFb5fNRBYSD3Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742410311; c=relaxed/simple;
	bh=x32Q3z6i1wVzW80/cI1dSEJFN0lmoG/8IKCRNI6L9BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0Q/4ON4JP5Z/zfnk/YNKiClW0/MtGmwmyVNGGnFb7EcSY80aVBmwvfUWIPFa+VFuK/boRa3oN1OnM5DoBbAEffmNJjpaxWzRvVxUkKI1NMXwC9DDait2bzsAFyVjkmmbOEPiQhX6Jza5DkrmTsddx9UjOLbArpnYixZsYjeYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KqcKeG4k; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 19 Mar 2025 11:51:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742410297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wNlnynwUVrUL3+4dcgZ4JkcxO+z5yinGLAIs8NF2EaQ=;
	b=KqcKeG4kg1CjIHu5E1S93MAqKvO2VkP26+wOoYoDLUbU2v4sV7cAhZuJHlSq0JPHeoRw7R
	sLICve42DoZJVxwW4dPtdM99aWKqHqvov18qhOCQTMxLUYM+clTTxPk8bY6LJ2V65knsSC
	e78n3Hs/BzWi8uBQ5HduarMD/apWMXE=
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
Message-ID: <Z9sSMJAlf7cQ5viu@linux.dev>
References: <20250319-hybrid-v1-1-4d1ada10e705@daynix.com>
 <Z9pze3J2_zrTk_yC@linux.dev>
 <e8324d9d-3756-41cf-a102-28572e302368@daynix.com>
 <86plidmjwh.wl-maz@kernel.org>
 <bd681ec6-0b4c-47d9-8a4a-b7324c0883a6@daynix.com>
 <86o6xxmg87.wl-maz@kernel.org>
 <aabd71eb-286b-475c-a30e-d5cf5c4f2769@daynix.com>
 <86msdhmemw.wl-maz@kernel.org>
 <cd7b4528-34a3-4d87-9711-acc2c2e6f6e1@daynix.com>
 <86ldt0n9w1.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ldt0n9w1.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 19, 2025 at 06:38:38PM +0000, Marc Zyngier wrote:
> On Wed, 19 Mar 2025 11:51:21 +0000, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> > What about setting the flag automatically when a user fails to pin
> > vCPUs to CPUs that are covered by one PMU? There would be no change if
> > a user correctly pins vCPUs as it is. Otherwise, they will see a
> > correct feature set advertised to the guest and the cycle counter
> > working.
> 
> How do you know that the affinity is "correct"? VCPU affinity can be
> changed at any time. I, for one, do not want my VMs to change
> behaviour because I let the vcpus bounce around as the scheduler sees
> fit.
> 
> Honestly, this is not a can of worm I want to open. We already have a
> pretty terrible userspace API for the PMU, let's not add to the
> confusion. *If* we are going down the road of presenting a dumbed-down
> PMU to the guest, it has to be an explicit buy-in from userspace.

I also have a very strong distaste for the crappy UAPI we have around a
'default' PMU. At the same time I do recognize this hurts practical
usecases since some VMMs can't be bothered to configure the vPMU / vCPU
pinning correctly.

I'm at least willing to plug my nose and do the following:

 1) When the VMM does not specify a vPMU type:

   - We continue to present the 'default' PMU (including event counters)
     to the VM

   - KVM ensures that the fixed CPU cycle counter works on any PMUv3
     implementation in the system, even if it is different from the
     default

   - Otherwise, event counters will only count on the default
     implementation and will not count on different PMUs

 2) Implement your suggestion of a UAPI where the VMM can select a PMU
    that only has the CPU cycle counter and works on any PMUv3
    implementation.

Either way KVM will need to have some special case handling of the fixed
CPU cycle counter. That'd allow users to actually run Windows *now* and
provide a clear mechanism for userspace to present a less-broken vPMU if
it cares.

Thanks,
Oliver

