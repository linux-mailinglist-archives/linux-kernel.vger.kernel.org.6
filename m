Return-Path: <linux-kernel+bounces-170812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD048BDC5B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CC3282120
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B878613B790;
	Tue,  7 May 2024 07:24:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FB83D0BD
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715066656; cv=none; b=nW+rkpJtjIZkrFrWgA8WBqfRKexj3wjU1/KgHrUl9bV2mAcYNv0GWiWCw0US2/QO8hFZiWQ2NE9u+UO1/TFJfE6VZzkmd/dcJYQf+Eua0HKbNMKUVlU1EXmEf8+qbp+DwzC5O4nAS56GJca4U2eOypLB+wgJUsu4FE6xhAI15O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715066656; c=relaxed/simple;
	bh=vk0o87GrkY34i9rzC7biQa1F6bB1Y/3n0n+jCi1/UvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5oJ60rDYv/BfWBgtdgIE3LlGI7S7a3s4UCoxklN2yR4HTGkgpheCO9Qan+Zi2s6UfxiV+E12Wa0urMXJfLvuEkYvQeVyw3g2kBXvHhUzBLIHDEXZ88LxlUo0B04d9LmINLdBbvPtYmHfapUnCQMFqNVm4bZStSgnTWzj5AESAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 139DA106F;
	Tue,  7 May 2024 00:24:38 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BA963F762;
	Tue,  7 May 2024 00:24:11 -0700 (PDT)
Date: Tue, 7 May 2024 08:24:10 +0100
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	vanshikonda@os.amperecomputing.com, will@kernel.org,
	catalin.marinas@arm.com, vincent.guittot@linaro.org,
	sumitg@nvidia.com, yang@os.amperecomputing.com,
	lihuisong@huawei.com, viresh.kumar@linaro.org
Subject: Re: [PATCH v5 2/5] arm64: amu: Rule out potential use after free
Message-ID: <ZjnXDiHDJZQ4O5DP@arm.com>
References: <20240417093848.1555462-1-beata.michalska@arm.com>
 <20240417093848.1555462-3-beata.michalska@arm.com>
 <20240418105052.zvkomz5yeayie4ph@bogus>
 <ZiFCfwEvdJxg6Hth@arm.com>
 <20240424102527.3s4ebjnaai2md5pa@bogus>
 <ZipoWUErkebDKXYd@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZipoWUErkebDKXYd@arm.com>

Hi Beata,

On Thursday 25 Apr 2024 at 16:27:37 (+0200), Beata Michalska wrote:
> On Wed, Apr 24, 2024 at 11:25:27AM +0100, Sudeep Holla wrote:
> > On Thu, Apr 18, 2024 at 05:55:43PM +0200, Beata Michalska wrote:
> > > On Thu, Apr 18, 2024 at 11:50:52AM +0100, Sudeep Holla wrote:
> > > > On Wed, Apr 17, 2024 at 10:38:45AM +0100, Beata Michalska wrote:
> > > > > For the time being, the amu_fie_cpus cpumask is being exclusively used
> > > > > by the AMU-related internals of FIE support and is guaranteed to be
> > > > > valid on every access currently made. Still the mask is not being
> > > > > invalidated on one of the error handling code paths, which leaves
> > > > > a soft spot with potential risk of uaf for CPUMASK_OFFSTACK cases.
> > > > > To make things sound, set the cpumaks pointer explicitly to NULL upon
> > > > > failing to register the cpufreq notifier.
> > > > > Note that, due to the quirks of CPUMASK_OFFSTACK, this change needs to
> > > > > be wrapped with grim ifdefing (it would be better served by
> > > > > incorporating this into free_cpumask_var ...)
> > > > >
> > > >
> > > > Yes it doesn't look neat.
> > > >
> > > > > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > > > > ---
> > > > >  arch/arm64/kernel/topology.c | 6 +++++-
> > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > > > > index 1a2c72f3e7f8..3c814a278534 100644
> > > > > --- a/arch/arm64/kernel/topology.c
> > > > > +++ b/arch/arm64/kernel/topology.c
> > > > > @@ -244,8 +244,12 @@ static int __init init_amu_fie(void)
> > > > >
> > > > >  	ret = cpufreq_register_notifier(&init_amu_fie_notifier,
> > > > >  					CPUFREQ_POLICY_NOTIFIER);
> > > > > -	if (ret)
> > > > > +	if (ret) {
> > > > >  		free_cpumask_var(amu_fie_cpus);
> > > > > +#ifdef CONFIG_CPUMASK_OFFSTACK
> > > > > +		amu_fie_cpus = NULL;
> > > > > +#endif
> > > > > +	}
> > > >
> > > > Instead of this #ifdeffery, I was wondering if we can actually do the
> > > > allocation in init_amu_fie_callback() the first time it gets called
> > > > checking if amu_fie_cpus is NULL. init_amu_fie_callback() must get called
> > > > only if the cpufreq_register_notifier() succeeds right ?
> > > >
> > 
> > > Delayed allocation ... I guess this will do the trick.
> > 
> > I prefer that if we can't find any other alternative. Do you see any issues
> > with that ? That said I am fine if Will/Catalin is happy with this.
> >
> We could actually move it up further to amu_fie_setup and potentially save on
> memory if none of the present CPUs have valid AMU counters. This is unlikely but
> still. So it could look like:
> 
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@@ -297,7 -194,7 +297,8 @@@ static void amu_fie_setup(const struct
>         int cpu;
> 
>         /* We are already set since the last insmod of cpufreq driver */
> ++      if (cpumask_available(amu_fie_cpus) &&
> --      if (unlikely(cpumask_subset(cpus, amu_fie_cpus)))
> ++          unlikely(cpumask_subset(cpus, amu_fie_cpus)))
>                 return;
> 
>         for_each_cpu(cpu, cpus) {
> @@@ -305,6 -202,6 +306,10 @@@
>                         return;
>         }
> 
> ++      if (!cpumask_available(amu_fie_cpus) &&
> ++              !zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL))
> ++              return;
> ++
> 
> In both cases we risk not setting up AMUs for FIE for all or some CPUs
> if we fail to allocate the memory but I guess we are already there.
> @Ionela: What do you think?

It looks good to me. Many thanks for the fix.

Ionela.

> 
> > > > Also I don't see anyone calling amu_fie_setup(), so where do you think
> > > > the possible use after free could occur for amu_fie_cpus. Just thinking
> > > > out loud to check if I missed anything.
> > > >
> > > You haven't missed anything. Currently the uaf is purely theoretical as the code
> > > that relies on that mask will only be executed if we have succeeded to register
> > > the amu fie support: so far so good.
> > 
> > Yes it is better to handle it even if it is theoretical.
> > 
> > I assume you get some compiler error if you assign unconditionally and
> > if(IS_ENABLED()) also doesn't work in this case as it would still give
> > error ?
> Yes, the #if is needed to exclude it from compilation if !CPUMASK_OFFSTACK.
> 
> ---
> BR
> Beata
> > 
> > --
> > Regards,
> > Sudeep

