Return-Path: <linux-kernel+bounces-254776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E76933779
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8DA1F232CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E82117C64;
	Wed, 17 Jul 2024 06:58:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E34A17545
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721199524; cv=none; b=jOjCBr+Dcg/Hg7XAHRwsH+0oCwWcB3xazOKbPNoUYt7NIGoWCvFczdcvzdPG4oC/qtr5AEFKT1E0w+JPLB6YvH2Uxl84zZZoBuBJ520BdCWY+kWUCL62krJj9XMWIDypojBrBD7rc3hQP3RbcmiGlvKwvYucFekTQfI/Ox+drK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721199524; c=relaxed/simple;
	bh=xZ8qXwERtzwvNr0QoG/aBLvGIt0aQPh89IxV0GZ9jUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jafwf/eH01lR4Yt8hywNYIwGr+YZfkDwRyy7Ltd2YJzevjKE0JXDJGKZb/07YbPKe725X5adFv2bNpaFC1im3q/U17+59t9Uv1hf1+rBIxxEJcLCOtKX44iEO8AUM0wNFsBsFuB23bjJB8oePcSTwwGrTER19epSrfjKlitLnGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD02F1063;
	Tue, 16 Jul 2024 23:59:06 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C5383F762;
	Tue, 16 Jul 2024 23:58:38 -0700 (PDT)
Date: Wed, 17 Jul 2024 08:58:28 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
	catalin.marinas@arm.com, vincent.guittot@linaro.org,
	sumitg@nvidia.com, yang@os.amperecomputing.com,
	lihuisong@huawei.com, viresh.kumar@linaro.org, rafael@kernel.org
Subject: Re: [PATCH v6 0/4] Add support for AArch64 AMUv1-based
 arch_freq_get_on_cpu
Message-ID: <ZpdrlC-qcvweyo9q@arm.com>
References: <20240603082154.3830591-1-beata.michalska@arm.com>
 <fxtdubkbj6oucps5mc5ep3elk2ap5peufrzli5nbqnrkpluugm@ojv6ccksc5ld>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fxtdubkbj6oucps5mc5ep3elk2ap5peufrzli5nbqnrkpluugm@ojv6ccksc5ld>

On Sat, Jul 13, 2024 at 05:32:43PM -0700, Vanshidhar Konda wrote:
> On Mon, Jun 03, 2024 at 09:21:50AM +0100, Beata Michalska wrote:
> > Introducing arm64 specific version of arch_freq_get_on_cpu, cashing on
> > existing implementation for FIE and AMUv1 support: the frequency scale
> > factor, updated on each sched tick, serves as a base for retrieving
> > the frequency for a given CPU, representing an average frequency
> > reported between the ticks - thus its accuracy is limited.
> > 
> > The changes have been rather lightly (due to some limitations) tested on
> > an FVP model. Note that some small discrepancies have been observed while
> 
> I've tested these changes (v6) on AmpereOne system and the results look correct.
> The frequency reported by scaling_cur_freq is as expected for housekeeping cpus,
> idle as well as isolated cpus.
>
That's greatly appreciated - thank you for that!
This series depends on [1] so once the relevant changes are ready will send an
updated to expose the average freq through a relevant sysfs attrib.

---
[1] https://lore.kernel.org/all/ZmrB_DqtmVpvG30l@arm.com/
---
Best Regards
Beata
> Thanks,
> Vanshi
> 
> > testing (on the model) and this is currently being investigated, though it
> > should not have any significant impact on the overall results.
> > 
> > Relevant discussions:
> > [1] https://lore.kernel.org/all/20240229162520.970986-1-vanshikonda@os.amperecomputing.com/
> > [2] https://lore.kernel.org/all/7eozim2xnepacnnkzxlbx34hib4otycnbn4dqymfziqou5lw5u@5xzpv3t7sxo3/
> > [3] https://lore.kernel.org/all/20231212072617.14756-1-lihuisong@huawei.com/
> > [4] https://lore.kernel.org/lkml/ZIHpd6unkOtYVEqP@e120325.cambridge.arm.com/T/#m4e74cb5a0aaa353c60fedc6cfb95ab7a6e381e3c
> > 
> > v6:
> > - delay allocating cpumask for AMU FIE support instead of invalidating the mask
> >   upon failure to register cpufreq policy notifications
> > - drop the change to cpufreq core (for cpuinfo_cur_freq) as this one will be
> >   sent as a separate change
> > 
> > v5:
> > - Fix invalid access to cpumask
> > - Reworked finding reference cpu when getting the freq
> > 
> > v4:
> > - dropping seqcount
> > - fixing identifying active cpu within given policy
> > - skipping full dynticks cpus when retrieving the freq
> > - bringing back plugging in arch_freq_get_on_cpu into cpuinfo_cur_freq
> > 
> > v3:
> > - dropping changes to cpufreq_verify_current_freq
> > - pulling in changes from Ionela initializing capacity_freq_ref to 0
> >  (thanks for that!)  and applying suggestions made by her during last review:
> > 	- switching to arch_scale_freq_capacity and arch_scale_freq_ref when
> > 	  reversing freq scale factor computation
> > 	- swapping shift with multiplication
> > - adding time limit for considering last scale update as valid
> > - updating frequency scale factor upon entering idle
> > 
> > v2:
> > - Splitting the patches
> > - Adding comment for full dyntick mode
> > - Plugging arch_freq_get_on_cpu into cpufreq_verify_current_freq instead
> >  of in show_cpuinfo_cur_freq to allow the framework to stay more in sync
> >  with potential freq changes
> > 
> > 
> > 
> > Beata Michalska (3):
> >  arm64: amu: Delay allocating cpumask for AMU FIE support
> >  arm64: Provide an AMU-based version of arch_freq_get_on_cpu
> >  arm64: Update AMU-based frequency scale factor on entering idle
> > 
> > Ionela Voinescu (1):
> >  arch_topology: init capacity_freq_ref to 0
> > 
> > arch/arm64/kernel/topology.c | 145 +++++++++++++++++++++++++++++------
> > drivers/base/arch_topology.c |   8 +-
> > 2 files changed, 127 insertions(+), 26 deletions(-)
> > 
> > -- 
> > 2.25.1
> > 

