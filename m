Return-Path: <linux-kernel+bounces-300902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA3A95EA49
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E0F285BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05FA12BF02;
	Mon, 26 Aug 2024 07:24:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9367722071
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657052; cv=none; b=MExTBSZD1npWRVpX7Z9QASwHkeCU3Z4lbDt8MsCi4KYfnZ17QD6b1jgk9Z7YaAMGQEkEDzdeOGttWIjwzXFIVqsWwbpdXY3ohj4J9FSBNdl59DJjOyJ9YhayDYjYojl36lEtZfZFxvmPLZsWEgFfX/JNvr10hVECQ5maRXkcIjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657052; c=relaxed/simple;
	bh=pXnUjiN5uHjOGQbuKJP8gzjW/Sqq7G1PNSAB282MJPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuA8+odZHdJJqWst/R6vOEAgBZqLr0GMHTyGuE0j9sVEF+KcHhxBnQhDVljIzMHAhqkQg+Rhu4uQKmHwjimrc1ldP90KGwLZKTZBYq/qMgp77R7Qc1NWnB/wBY3PCYDBwhRlaTCuJOenJC/OlOTcjdE40XnEMXCeFEV4Y86Nbhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05783339;
	Mon, 26 Aug 2024 00:24:36 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A78673F66E;
	Mon, 26 Aug 2024 00:24:06 -0700 (PDT)
Date: Mon, 26 Aug 2024 09:24:00 +0200
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
Message-ID: <ZswtkBBieOgA9p-0@arm.com>
References: <20240603082154.3830591-1-beata.michalska@arm.com>
 <ZowdalL3DfkHtaCg@arm.com>
 <Zo_lN8jdgADwqvor@arm.com>
 <8500d58c-e6c5-04c7-73a0-38d3f77f2cb7@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8500d58c-e6c5-04c7-73a0-38d3f77f2cb7@hisilicon.com>

On Wed, Aug 14, 2024 at 04:05:24PM +0800, Jie Zhan wrote:
> 
> On 11/07/2024 21:59, Beata Michalska wrote:
> > Hi Catalin,
> > 
> > On Mon, Jul 08, 2024 at 06:10:02PM +0100, Catalin Marinas wrote:
> > > Hi Beata,
> > > 
> > > On Mon, Jun 03, 2024 at 09:21:50AM +0100, Beata Michalska wrote:
> > > > Introducing arm64 specific version of arch_freq_get_on_cpu, cashing on
> > > > existing implementation for FIE and AMUv1 support: the frequency scale
> > > > factor, updated on each sched tick, serves as a base for retrieving
> > > > the frequency for a given CPU, representing an average frequency
> > > > reported between the ticks - thus its accuracy is limited.
> > > > 
> > > > The changes have been rather lightly (due to some limitations) tested on
> > > > an FVP model. Note that some small discrepancies have been observed while
> > > > testing (on the model) and this is currently being investigated, though it
> > > > should not have any significant impact on the overall results.
> > > What's the plan with this series? Are you still investigating those
> > > discrepancies or is it good to go?
> > > 
> > Overall it should be good to go with small caveat:
> > as per discussion [1] we might need to provide new sysfs attribute exposing an
> > average frequency instead of plugging new code under existing cpuinfo_cur_freq.
> > This is to avoid messing up with other archs and make a clean distinction on
> > which attribute provides what information.
> > As such, the arch_freq_get_on_cpu implementation provided within this series
> > [PATCH v6 3/4] will most probably be shifted to a new function.
> > 
> > Hopefully will be able to send those changes soon.
> > 
> > ---
> > [1] https://lore.kernel.org/all/ZmrB_DqtmVpvG30l@arm.com/
> > ---
> > BR
> > Beata
> > 
> > > -- 
> > > Catalin
> > > 
> Hi Beata,
Hi Jie,
> 
> I've recently tested this patchset on a Kunpeng system.
> It works as expected when reading scaling_cur_freq.
> The frequency samples are much stabler than what cppc_cpufreq returns.
Thank you for giving it a spin.
(and apologies for late reply)
> 
> A few minor things.
> 
> 1. I observed larger errors on idle cpus than busy cpus, though it's just up
> to 1%.
> Not sure if this comes from the uncertain time interval between the last
> tick and entering idle.
> The shorter averaging interval, the larger error, I supposed.
All right - will look into it.
Just for my benefit: that diff is strictly between arch_freq_avg_get_on_cpu
and cpufreq_driver->get(policy->cpu) ?
> 
> 2. In the current implementation, the resolution of frequency would be:
> max_freq_khz / SCHED_CAPACITY_SCALE
> This looks a bit unnecessary to me.
> 
> It's supposed to get a better resolution if we can do this in
> arch_freq_get_on_cpu():
> 
> freq = delta_cycle_cnt * max_freq_khz / delta_const_cnt
> 
> which may require caching both current and previous sets of counts in the
> per-cpu struct amu_cntr_sample.
> 
arch_freq_get_on_cpu relies on the frequency scale factor to derive the average
frequency. The scale factor is being calculated based on the deltas you have
mentioned and arch_max_freq_scale which uses SCHED_CAPACITY_SCALE*2 factor to
accommodate for rather low reference frequencies. arch_freq_get_on_cpu just does
somewhat reverse computation to that.

---
BR
Beata
> Kind regards,
> Jie
> 

