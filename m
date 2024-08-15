Return-Path: <linux-kernel+bounces-288316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA629538BA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5FC1C238F4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE001BA89C;
	Thu, 15 Aug 2024 17:04:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D9419E7E8
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723741490; cv=none; b=OjVd1zxHufewBJLLG3xWxc+CJkp3d3jDCY/A2dDsWPMbbB0m6X/YZCdr+wv0vepnyCs/HqvyVzVi1Ka/7Y2RMLKOryOHJzit4rt8ExNT4v5hjcMmenk/lb+tnN6xdDhrASyrzRER7BaReqBzMuNdRM7FX163knhXrOCIGotpeoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723741490; c=relaxed/simple;
	bh=NdGghsw+RyZCx8UOke9CPx0C4AbcaehGgzdV+8L2czc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtLyYAMCVKVC3VitsNFE32RscR0n8z2uICKjS0iK5Bacr0OGLbyMjyNBEivCA4TRHhcRU5WSFZWqn0KekHGbBvNnhkYGMmU6Tm0/yJyn6VqUPZRhndeRc7o0fZL3PmirrtVgF0Ar8zYuqDwadbvKBIGi8n4hx0E7syqkH4cTqeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A98A114BF;
	Thu, 15 Aug 2024 10:05:12 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC21A3F58B;
	Thu, 15 Aug 2024 10:04:45 -0700 (PDT)
Date: Thu, 15 Aug 2024 18:04:36 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, jialong.yang@shingroup.cn
Subject: Re: [PATCH v2 2/3] perf: Add driver for Arm NI-700 interconnect PMU
Message-ID: <Zr40Y_9QyRYpG_bQ@J2N7QTR9R3.cambridge.arm.com>
References: <cover.1720625639.git.robin.murphy@arm.com>
 <f38ff2078d4a65d1cadfbbeb485f3b1de91ff0df.1720625639.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f38ff2078d4a65d1cadfbbeb485f3b1de91ff0df.1720625639.git.robin.murphy@arm.com>

On Wed, Jul 10, 2024 at 05:09:34PM +0100, Robin Murphy wrote:
> The Arm NI-700 Network-on-Chip Interconnect has a relatively
> straightforward design with a hierarchy of voltage, power, and clock
> domains, where each clock domain then contains a number of interface
> units and a PMU which can monitor events thereon. As such, it begets a
> relatively straightforward driver to interface those PMUs with perf.
> 
> Even more so than with arm-cmn, users will require detailed knowledge of
> the wider system topology in order to meaningfully analyse anything,
> since the interconnect itself cannot know what lies beyond the boundary
> of each inscrutably-numbered interface. Given that, for now they are
> also expected to refer to the NI-700 documentation for the relevant
> event IDs to provide as well. An identifier is implemented so we can
> come back and add jevents if anyone really wants to.

IIUC the relevant documentation would be the NI-700 TRM:

  https://developer.arm.com/documentation/101566/0203/?lang=en

... right?

[...]

> +====================================
> +Arm Network-on Chip Interconnect PMU
> +====================================
> +
> +NI-700 and friends implement a distinct PMU for each clock domain within the
> +interconnect. Correspondingly, the driver exposes multiple PMU devices named
> +arm_ni_<x>_cd_<y>, where <x> is an (abritrary) instance identifier and <y> is
> +the clock domain ID within that particular instance. If multiple NI instances
> +exist within a system, the PMU devices can be correlated with the underlying
> +hardware instance via sysfs parentage.

I suspect that name suffixing *might* confuse userspace in some cases,
since IIUC the perf tool tries to aggregate some_pmu_<number> instances,
and here it would presumably aggregate all the clock domains as a
arm_ni_<x>_cd PMU.

We should check how that behaves and speak to the userspace folk about
this; taking a step back we probably need a better way for determining
when things can or should be aggregated.

I assume we don't have HW to test on, but we should be able to fake up
the sysfs hierarchy and see how "perf list" treats that.

[...]

> +static int arm_ni_validate_group(struct perf_event *event)
> +{
> +	struct perf_event *sibling, *leader;
> +	struct arm_ni_val val = { 0 };
> +
> +	arm_ni_validate_event(event, &val);
> +
> +	leader = event->group_leader;
> +	if (leader != event && !arm_ni_validate_event(leader, &val))
> +		return - EINVAL;
> +
> +	for_each_sibling_event(sibling, leader) {
> +		if (!arm_ni_validate_event(sibling, &val))
> +			return - EINVAL;
> +	}
> +	return 0;
> +}

As a trivial nit, something has gone wrong with spacing and you have:

	return - EINVAL;

... rather than:

	return -EINVAL;

As a more substantial thing, this will trigger splats when lockdep is
enabled and an event is opened where event == event->group_leader,
because for_each_sibling_event(..., event) checks event->ctx->mutex is
held, and event->ctx isn't initialised until pmu::event_init() returns.

That's a latent bug in many PMU drivers at the moment, and is on my TODO
list to fix elsewhere. For now, can you make the above:

| static int arm_ni_validate_group(struct perf_event *event)
| {
| 	struct perf_event *sibling, *leader = event->group_leader;
| 	struct arm_ni_val val = { 0 };
| 
| 	if (event == leader)
| 		return 0;
|
| 	arm_ni_validate_event(event, &val);
| 	
| 	if (!arm_ni_validate_event(leader, &val))
| 		return -EINVAL;
| 
| 	for_each_sibling_event(sibling, leader) {
| 		if (!arm_ni_validate_event(sibling, &val))
| 			return -EINVAL;
| 	}
| 
| 	return 0;
| }

... where the early exit for the (event == leader) case will avoid the
bad call.

[...]

> +static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_start)
> +{
> +	struct arm_ni_cd *cd = ni->cds + node->id;
> +	const char *name;
> +	int err;

> +	cd->cpu = cpumask_local_spread(0, dev_to_node(ni->dev));

Can dev_to_node(ni->dev) return NUMA_NO_NODE, and if so, do we need to
error out here? ...

> +static int arm_ni_pmu_online_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
> +{
> +	struct arm_ni_cd *cd;
> +	int node;
> +
> +	cd = hlist_entry_safe(cpuhp_node, struct arm_ni_cd, cpuhp_node);
> +	node = dev_to_node(cd_to_ni(cd)->dev);
> +	if (node != NUMA_NO_NODE && cpu_to_node(cd->cpu) != node && cpu_to_node(cpu) == node)
> +		arm_ni_pmu_migrate(cd, cpu);
> +	return 0;
> +}

... since we expect to handle similar here ...

> +
> +static int arm_ni_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
> +{
> +	struct arm_ni_cd *cd;
> +	unsigned int target;
> +	int node;
> +
> +	cd = hlist_entry_safe(cpuhp_node, struct arm_ni_cd, cpuhp_node);
> +	if (cpu != cd->cpu)
> +		return 0;
> +
> +	node = dev_to_node(cd_to_ni(cd)->dev);
> +	target = cpumask_any_and_but(cpumask_of_node(node), cpu_online_mask, cpu);
> +	if (target >= nr_cpu_ids)
> +		target = cpumask_any_but(cpu_online_mask, cpu);
> +
> +	if (target < nr_cpu_ids)
> +		arm_ni_pmu_migrate(cd, target);
> +	return 0;
> +}

... though not here, and overall that seems inconsistent.

Mark.

