Return-Path: <linux-kernel+bounces-318581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D51B96F01E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B231F28D47
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6E71C9DFA;
	Fri,  6 Sep 2024 09:46:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C1D1C9DF5
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615974; cv=none; b=XgguSmIHIn0X47RJCdxriCk8+0i2I0+Zn9CDyePdaMsdIohMAgzRapqkdKr1U6FuYkxszQEIedF07NXZkGyUTOUOh1DD+4KFIHsFqDhOyHYBZq3j1rp+PDqdVSSGS5b/qYUi5cTC8rkJgRMmYkRvZK7rfsIecaC3z2lneugdRII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615974; c=relaxed/simple;
	bh=MKVj5EXgmGDfSMLPglHdTuDNQr30GOdBK42OWnbUhco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6UaoV8wqZmxYFbc1VTZV6iyyficwvKEayiSvf/tiJqHunbh87UVlvta6en7fpzT9nBmdNLsDvTPSwmago9hP7cNFeSkAxoWoyYi/y1khPjrJEq3jSYdPlXWl8pcn6B4QHVRf4Njz+1AF2e+xVc9iTG6XM1tcTMYrodyDUhQvwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38671FEC;
	Fri,  6 Sep 2024 02:46:39 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBDD33F73F;
	Fri,  6 Sep 2024 02:46:08 -0700 (PDT)
Date: Fri, 6 Sep 2024 11:45:49 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, vincent.guittot@linaro.org,
	vanshikonda@os.amperecomputing.com, sumitg@nvidia.com,
	yang@os.amperecomputing.com, lihuisong@huawei.com,
	viresh.kumar@linaro.org, rafael@kernel.org
Subject: Re: [PATCH v6 0/4] Add support for AArch64 AMUv1-based
 arch_freq_get_on_cpu
Message-ID: <ZtrPTcEtynUUjBub@arm.com>
References: <20240603082154.3830591-1-beata.michalska@arm.com>
 <ZowdalL3DfkHtaCg@arm.com>
 <Zo_lN8jdgADwqvor@arm.com>
 <8500d58c-e6c5-04c7-73a0-38d3f77f2cb7@hisilicon.com>
 <ZswtkBBieOgA9p-0@arm.com>
 <8a9b4e02-a5c6-cb1b-fd32-728fc2c5e741@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a9b4e02-a5c6-cb1b-fd32-728fc2c5e741@hisilicon.com>

On Tue, Aug 27, 2024 at 08:56:28PM +0800, Jie Zhan wrote:
> On 26/08/2024 15:24, Beata Michalska wrote:
> 
> ...
> 
> > > I've recently tested this patchset on a Kunpeng system.
> > > It works as expected when reading scaling_cur_freq.
> > > The frequency samples are much stabler than what cppc_cpufreq returns.
> > Thank you for giving it a spin.
> > (and apologies for late reply)
> > > A few minor things.
> > > 
> > > 1. I observed larger errors on idle cpus than busy cpus, though it's just up
> > > to 1%.
> > > Not sure if this comes from the uncertain time interval between the last
> > > tick and entering idle.
> > > The shorter averaging interval, the larger error, I supposed.
> > All right - will look into it.
> > Just for my benefit: that diff is strictly between arch_freq_avg_get_on_cpu
> > and cpufreq_driver->get(policy->cpu) ?
> 
> I can't say whether it's "strictly" between them or not because driver->get()
> shows a fluctuating value.
> On my platform, cppc_cpufreq's driver->get() sometimes shows large errors on
> busy cpus (as reported by recent emails), but quite accurate on idle cpus (<1%).
> 
> With this patch, the "error" on idle cpus as mentioned above is typically <1%,
> hence better in general.
Ah, that's great then - I must have misunderstood your previous comment.
Apologies for that.
> 
> > > 2. In the current implementation, the resolution of frequency would be:
> > > max_freq_khz / SCHED_CAPACITY_SCALE
> > > This looks a bit unnecessary to me.
> > > 
> > > It's supposed to get a better resolution if we can do this in
> > > arch_freq_get_on_cpu():
> > > 
> > > freq = delta_cycle_cnt * max_freq_khz / delta_const_cnt
> > > 
> > > which may require caching both current and previous sets of counts in the
> > > per-cpu struct amu_cntr_sample.
> > > 
> > arch_freq_get_on_cpu relies on the frequency scale factor to derive the average
> > frequency. The scale factor is being calculated based on the deltas you have
> > mentioned and arch_max_freq_scale which uses SCHED_CAPACITY_SCALE*2 factor to
> > accommodate for rather low reference frequencies. arch_freq_get_on_cpu just does
> > somewhat reverse computation to that.
> 
> Yeah I understood this.
> 
> arch_freq_get_on_cpu() now returns:
> freq = (arch_scale_freq_capacity() * arch_scale_freq_ref()) >> SCHED_CAPACITY_SHIFT
> 
> The frequency resolution is (arch_scale_freq_ref() >> SCHED_CAPACITY_SHIFT), which
> is equivalent to max_freq_khz / SCHED_CAPACITY_SCALE.
> 
> If we can directly do
> freq = delta_cycle_cnt * ref_freq_khz / delta_const_cnt
> in arch_freq_get_on_cpu(), it's supposed to have a 1KHz resolution.
> (sorry for the wrong multiplier in the last reply)
> 
> Just similar to what's done in [1].
> 
> It could be more worthwhile to have a good resolution than utilising the
> arch_topology framework?
I guess the question would be whether the precision uplift justifies
the change ? In both cases, provided frequency value will carry over potential
error due to the nature of how it is being obtained. Furthermore, it is still
an average frequency so I am not really convinced that trading here for
a fraction of precision would bring any real value. Note that, the difference
between the two will fluctuate as well. If there is indeed a real need for
getting that extra precision* it would be good to see some actual numbers ?

---
BR
Beata

> 
> [1]https://lore.kernel.org/all/20240229162520.970986-2-vanshikonda@os.amperecomputing.com/
> 
> > 
> > ---
> > BR
> > Beata
> > > Kind regards,
> > > Jie
> > > 

