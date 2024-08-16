Return-Path: <linux-kernel+bounces-290185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFF195507B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D5B1C21DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790111C2326;
	Fri, 16 Aug 2024 18:05:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66954817
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831551; cv=none; b=tP06jPFt/0OuROYXrjRC5OWC3k2WSJhmTWkApIrf3XWEa2lC806AsSY2qFCvX4LJnhVM4VlMPNGGUK4fdpdTEl9HFaEaibSV7WzVccotCMY06s0i4FoahcADD2Ft65hxgGZ5/crzVRxo/CF+/RPMX5uZk+IbQHUrz7oeyHj5mAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831551; c=relaxed/simple;
	bh=WCSmeOHlU59Z66WotNiWCfPVcqlHaFCXq6UK2gOICD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOcDu+xKjNJy8zMrR7sJm5UJhGWkBC+ANa46gjIBo/y+SEE+A3Uhjz56mMaFgPaDi5xvkNGVGdkP7B/ZTRxg7Pbt/zPZIizLAkoKjcQjwH8y1znw10Gp5a7M7svPjrfQVkTelNcM+GeOUhG8I+f+QFuBCR0BeKyEOH9/9MW62mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B972D13D5;
	Fri, 16 Aug 2024 11:06:13 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 233C53F6A8;
	Fri, 16 Aug 2024 11:05:47 -0700 (PDT)
Message-ID: <fb89251f-de31-428e-9821-492c31789333@arm.com>
Date: Fri, 16 Aug 2024 19:05:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] perf: Add driver for Arm NI-700 interconnect PMU
To: Mark Rutland <mark.rutland@arm.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, jialong.yang@shingroup.cn
References: <cover.1720625639.git.robin.murphy@arm.com>
 <f38ff2078d4a65d1cadfbbeb485f3b1de91ff0df.1720625639.git.robin.murphy@arm.com>
 <Zr40Y_9QyRYpG_bQ@J2N7QTR9R3.cambridge.arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Zr40Y_9QyRYpG_bQ@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/08/2024 6:04 pm, Mark Rutland wrote:
> On Wed, Jul 10, 2024 at 05:09:34PM +0100, Robin Murphy wrote:
>> The Arm NI-700 Network-on-Chip Interconnect has a relatively
>> straightforward design with a hierarchy of voltage, power, and clock
>> domains, where each clock domain then contains a number of interface
>> units and a PMU which can monitor events thereon. As such, it begets a
>> relatively straightforward driver to interface those PMUs with perf.
>>
>> Even more so than with arm-cmn, users will require detailed knowledge of
>> the wider system topology in order to meaningfully analyse anything,
>> since the interconnect itself cannot know what lies beyond the boundary
>> of each inscrutably-numbered interface. Given that, for now they are
>> also expected to refer to the NI-700 documentation for the relevant
>> event IDs to provide as well. An identifier is implemented so we can
>> come back and add jevents if anyone really wants to.
> 
> IIUC the relevant documentation would be the NI-700 TRM:
> 
>    https://developer.arm.com/documentation/101566/0203/?lang=en
> 
> ... right?

That's the one.

> [...]
> 
>> +====================================
>> +Arm Network-on Chip Interconnect PMU
>> +====================================
>> +
>> +NI-700 and friends implement a distinct PMU for each clock domain within the
>> +interconnect. Correspondingly, the driver exposes multiple PMU devices named
>> +arm_ni_<x>_cd_<y>, where <x> is an (abritrary) instance identifier and <y> is
>> +the clock domain ID within that particular instance. If multiple NI instances
>> +exist within a system, the PMU devices can be correlated with the underlying
>> +hardware instance via sysfs parentage.
> 
> I suspect that name suffixing *might* confuse userspace in some cases,
> since IIUC the perf tool tries to aggregate some_pmu_<number> instances,
> and here it would presumably aggregate all the clock domains as a
> arm_ni_<x>_cd PMU.

Indeed that is liable to be particularly funky since different domains 
may well contain different sets of interface types and thus not even 
necessarily share the same set of base events. Either way, events are 
targeted at specific interfaces so aggregation at any level would 
generally be meaningless.

> We should check how that behaves and speak to the userspace folk about
> this; taking a step back we probably need a better way for determining
> when things can or should be aggregated. >
> I assume we don't have HW to test on, but we should be able to fake up
> the sysfs hierarchy and see how "perf list" treats that.

I see there is an available FVP for the Total Compute TC2 system[1] 
which includes an NI-700 instance - it doesn't model the PMU counters, 
but the rest should work enough for discovery. I might have a go with 
that next week...

> [...]
> 
>> +static int arm_ni_validate_group(struct perf_event *event)
>> +{
>> +	struct perf_event *sibling, *leader;
>> +	struct arm_ni_val val = { 0 };
>> +
>> +	arm_ni_validate_event(event, &val);
>> +
>> +	leader = event->group_leader;
>> +	if (leader != event && !arm_ni_validate_event(leader, &val))
>> +		return - EINVAL;
>> +
>> +	for_each_sibling_event(sibling, leader) {
>> +		if (!arm_ni_validate_event(sibling, &val))
>> +			return - EINVAL;
>> +	}
>> +	return 0;
>> +}
> 
> As a trivial nit, something has gone wrong with spacing and you have:
> 
> 	return - EINVAL;
> 
> ... rather than:
> 
> 	return -EINVAL;
> 
> As a more substantial thing, this will trigger splats when lockdep is
> enabled and an event is opened where event == event->group_leader,
> because for_each_sibling_event(..., event) checks event->ctx->mutex is
> held, and event->ctx isn't initialised until pmu::event_init() returns.

Oof, I even remember looking at that report, so I don't really have any 
excuse!

> That's a latent bug in many PMU drivers at the moment, and is on my TODO
> list to fix elsewhere. For now, can you make the above:
> 
> | static int arm_ni_validate_group(struct perf_event *event)
> | {
> | 	struct perf_event *sibling, *leader = event->group_leader;
> | 	struct arm_ni_val val = { 0 };
> |
> | 	if (event == leader)
> | 		return 0;
> |
> | 	arm_ni_validate_event(event, &val);
> | 	
> | 	if (!arm_ni_validate_event(leader, &val))
> | 		return -EINVAL;
> |
> | 	for_each_sibling_event(sibling, leader) {
> | 		if (!arm_ni_validate_event(sibling, &val))
> | 			return -EINVAL;
> | 	}
> |
> | 	return 0;
> | }
> 
> ... where the early exit for the (event == leader) case will avoid the
> bad call.

Took me a moment to see why it's OK to skip "validating" the event as 
leader itself, but that's arguably just as much down to my naming. I'll 
polish that up a bit further.

> [...]
> 
>> +static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_start)
>> +{
>> +	struct arm_ni_cd *cd = ni->cds + node->id;
>> +	const char *name;
>> +	int err;
> 
>> +	cd->cpu = cpumask_local_spread(0, dev_to_node(ni->dev));
> 
> Can dev_to_node(ni->dev) return NUMA_NO_NODE, and if so, do we need to
> error out here? ...

It can, and cpumask_local_spread() just picks from cpu_online_mask in 
that case. It's not an error either way, the intent is just that if we 
do have NUMA, then it makes sense to try to associate with a 
physically-close CPU.

>> +static int arm_ni_pmu_online_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
>> +{
>> +	struct arm_ni_cd *cd;
>> +	int node;
>> +
>> +	cd = hlist_entry_safe(cpuhp_node, struct arm_ni_cd, cpuhp_node);
>> +	node = dev_to_node(cd_to_ni(cd)->dev);
>> +	if (node != NUMA_NO_NODE && cpu_to_node(cd->cpu) != node && cpu_to_node(cpu) == node)
>> +		arm_ni_pmu_migrate(cd, cpu);
>> +	return 0;
>> +}
> 
> ... since we expect to handle similar here ...

...and conversely, without NUMA there's no point even asking the 
question of whether a new CPU might be more local than our current one.

>> +
>> +static int arm_ni_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
>> +{
>> +	struct arm_ni_cd *cd;
>> +	unsigned int target;
>> +	int node;
>> +
>> +	cd = hlist_entry_safe(cpuhp_node, struct arm_ni_cd, cpuhp_node);
>> +	if (cpu != cd->cpu)
>> +		return 0;
>> +
>> +	node = dev_to_node(cd_to_ni(cd)->dev);
>> +	target = cpumask_any_and_but(cpumask_of_node(node), cpu_online_mask, cpu);
>> +	if (target >= nr_cpu_ids)
>> +		target = cpumask_any_but(cpu_online_mask, cpu);
>> +
>> +	if (target < nr_cpu_ids)
>> +		arm_ni_pmu_migrate(cd, target);
>> +	return 0;
>> +}
> 
> ... though not here, and overall that seems inconsistent.

I did start down that rabbit hole, but gave up in despair around the 
point of the "#ifdef CONFIG_NUMA" inside the "#ifndef CONFIG_NUMA". My 
conclusion was that the majority of cpumask_of_node() implementations do 
handle NUMA_NO_NODE, making it appear expected, and there is already 
other code assuming so, so the ones which don't were not my problem.

Thanks,
Robin.

