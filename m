Return-Path: <linux-kernel+bounces-311803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7359F968DDE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 20:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9A56B20EE9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2D81A3A93;
	Mon,  2 Sep 2024 18:47:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5B81A3A80
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302844; cv=none; b=jz/V6tJLaZ3+g9rWJWzTx3nBoRVREmgrlG6ipPfNNINzDnyIg+q9wEJaGsMiju3qhWB2wPYSdBIBo/eSJW/Hn078B7aDtjrVTtrM2FXI/GNZ7ITvf7Bwew3AvpdD0vAeEwmVjt76+LcOhsLdCeWQxAIJ3/hmqloqVHAC2LagUmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302844; c=relaxed/simple;
	bh=jGQZSu+oYhpctByQD0L/M1eplIE8J3zPzOpTkXT6Mzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qE0xTiAKIXFd/RrfSinYLCU4MrRfLEgNCA5eVv+6s8stNEJyTHD7v4n92oC1QznXDXSuYBDEQfgZzh5RXBjTWrt4Qex1EvEuTKFueqKC17Te0tSI7AHKVZRlU/0vaDarRt34S/C08tnKhDmHBuq/40TolcUwp+QdL6X2KOmTiCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 728F5FEC;
	Mon,  2 Sep 2024 11:47:47 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C8623F73B;
	Mon,  2 Sep 2024 11:47:20 -0700 (PDT)
Message-ID: <0a41657e-a52c-43c9-9b73-89fd73a376c7@arm.com>
Date: Mon, 2 Sep 2024 19:47:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] perf: Add driver for Arm NI-700 interconnect PMU
To: Will Deacon <will@kernel.org>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, jialong.yang@shingroup.cn
References: <cover.1725037424.git.robin.murphy@arm.com>
 <275e8ef450eeaf837468ce34e2c6930d59091fbc.1725037424.git.robin.murphy@arm.com>
 <20240902144714.GA11443@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240902144714.GA11443@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/09/2024 3:47 pm, Will Deacon wrote:
> Hi Robin,
> 
> On Fri, Aug 30, 2024 at 06:19:34PM +0100, Robin Murphy wrote:
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
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>
>> ---
>> v2:
>>   - Add basic usage documentation
>>   - Use __counted_by attribute
>>   - Make group validation logic clearer (and drop PMU type check
>>     which perf_event_open() already takes care of)
>>   - Add retry limit to arm_ni_read_ccnt()
>> v3:
>>   - Update .remove to return void
>>   - Fix group leader validation and make the naming clearer
>>   - Drop NUMA_NO_NODE check for CPU online (the only way that could
>>     actually pass both other migration conditions is if the NUMA info
>>     is so messed up that it's not worth worrying about anyway)
> 
> Thanks, this is looking pretty good now. I just have a few random comments
> based on another read-through of the code.
> 
>> diff --git a/Documentation/admin-guide/perf/arm-ni.rst b/Documentation/admin-guide/perf/arm-ni.rst
>> new file mode 100644
>> index 000000000000..3cd7d0f75f0f
>> --- /dev/null
>> +++ b/Documentation/admin-guide/perf/arm-ni.rst
>> @@ -0,0 +1,17 @@
>> +====================================
>> +Arm Network-on Chip Interconnect PMU
>> +====================================
>> +
>> +NI-700 and friends implement a distinct PMU for each clock domain within the
>> +interconnect. Correspondingly, the driver exposes multiple PMU devices named
>> +arm_ni_<x>_cd_<y>, where <x> is an (abritrary) instance identifier and <y> is
> 
> typo: abritrary

Oops, fixed.

>> +the clock domain ID within that particular instance. If multiple NI instances
>> +exist within a system, the PMU devices can be correlated with the underlying
>> +hardware instance via sysfs parentage.
>> +
>> +Each PMU exposes base event aliases for the interface types present in its clock
>> +domain. These require qualifying with the "eventid" and "nodeid" parameters
>> +to specify the event code to count and the interface at which to count it
>> +(per the configured hardware ID as reflected in the xxNI_NODE_INFO register).
>> +The exception is the "cycles" alias for the PMU cycle counter, which is encoded
>> +with the PMU node type and needs no further qualification.
> 
> [...]
> 
>> +static ssize_t arm_ni_format_show(struct device *dev,
>> +				  struct device_attribute *attr, char *buf)
>> +{
>> +	struct arm_ni_format_attr *fmt = container_of(attr, typeof(*fmt), attr);
>> +	int lo = __ffs(fmt->field), hi = __fls(fmt->field);
>> +
>> +	return sysfs_emit(buf, "config:%d-%d\n", lo, hi);
>> +}
> 
> Nit: if you end up adding single-bit config fields in the future, this
> will quietly do the wrong thing. Maybe safe-guard the 'lo==hi' case (even
> if you just warn once and return without doing anything).

The counter-argument is that I don't foresee having any reason to add 
single-bit config fields here in future, nor indeed config1 or config2 
fields, so I intentionally pruned the would-be dead code while 
copy-pasting this implementation from arm-cmn. Yes, if someone were to 
make an incomplete change without paying attention or testing they could 
introduce a bug, but when is that ever not true?

TBH I was originally hoping to have much of this boilerplate stuff 
factored out into a common library beforehand (I also anticipate needing 
the IRQ-sharing shenanigans here), but as ever, priorities got in the way...

> 
> 
> [...]
> 
>> +static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_start)
>> +{
>> +	struct arm_ni_cd *cd = ni->cds + node->id;
>> +	const char *name;
>> +	int err;
>> +
>> +	cd->id = node->id;
>> +	cd->num_units = node->num_components;
>> +	cd->units = devm_kcalloc(ni->dev, cd->num_units, sizeof(*(cd->units)), GFP_KERNEL);
>> +	if (!cd->units)
>> +		return -ENOMEM;
>> +
>> +	for (int i = 0; i < cd->num_units; i++) {
>> +		u32 reg = readl_relaxed(node->base + NI_CHILD_PTR(i));
>> +		void __iomem *unit_base = ni->base + reg;
>> +		struct arm_ni_unit *unit = cd->units + i;
>> +
>> +		reg = readl_relaxed(unit_base + NI_NODE_TYPE);
>> +		unit->type = FIELD_GET(NI_NODE_TYPE_NODE_TYPE, reg);
>> +		unit->id = FIELD_GET(NI_NODE_TYPE_NODE_ID, reg);
>> +
>> +		switch (unit->type) {
>> +		case NI_PMU:
>> +			reg = readl_relaxed(unit_base + NI_PMCFGR);
>> +			if (!reg) {
>> +				dev_info(ni->dev, "No access to PMU %d\n", cd->id);
>> +				devm_kfree(ni->dev, cd->units);
>> +				return 0;
>> +			}
>> +			unit->ns = true;
>> +			cd->pmu_base = unit_base;
>> +			break;
>> +		case NI_ASNI:
>> +		case NI_AMNI:
>> +		case NI_HSNI:
>> +		case NI_HMNI:
>> +		case NI_PMNI:
>> +			unit->pmusela = unit_base + NI700_PMUSELA;
>> +			writel_relaxed(1, unit->pmusela);
>> +			if (readl_relaxed(unit->pmusela) != 1)
>> +				dev_info(ni->dev, "No access to node 0x%04x%04x\n", unit->id, unit->type);
>> +			else
>> +				unit->ns = true;
>> +			break;
>> +		default:
>> +			/*
>> +			 * e.g. FMU - thankfully bits 3:2 of FMU_ERR_FR0 are RES0 so
>> +			 * can't alias any of the leaf node types we're looking for.
>> +			 */
>> +			dev_dbg(ni->dev, "Mystery node 0x%04x%04x\n", unit->id, unit->type);
>> +			break;
>> +		}
>> +	}
>> +
>> +	res_start += cd->pmu_base - ni->base;
>> +	if (!devm_request_mem_region(ni->dev, res_start, SZ_4K, dev_name(ni->dev))) {
>> +		dev_err(ni->dev, "Failed to request PMU region 0x%llx\n", res_start);
>> +		return -EBUSY;
>> +	}
>> +
>> +	writel_relaxed(NI_PMCR_RESET_CCNT | NI_PMCR_RESET_EVCNT,
>> +		       cd->pmu_base + NI_PMCR);
>> +	writel_relaxed(U32_MAX, cd->pmu_base + NI_PMCNTENCLR);
>> +	writel_relaxed(U32_MAX, cd->pmu_base + NI_PMOVSCLR);
>> +	writel_relaxed(U32_MAX, cd->pmu_base + NI_PMINTENSET);
>> +
>> +	cd->irq = platform_get_irq(to_platform_device(ni->dev), cd->id);
>> +	if (cd->irq < 0)
>> +		return cd->irq;
>> +
>> +	err = devm_request_irq(ni->dev, cd->irq, arm_ni_handle_irq,
>> +			       IRQF_NOBALANCING | IRQF_NO_THREAD,
>> +			       dev_name(ni->dev), cd);
>> +	if (err)
>> +		return err;
>> +
>> +	cd->cpu = cpumask_local_spread(0, dev_to_node(ni->dev));
>> +	cd->pmu = (struct pmu) {
>> +		.module = THIS_MODULE,
>> +		.parent = ni->dev,
>> +		.attr_groups = arm_ni_attr_groups,
>> +		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
>> +		.task_ctx_nr = perf_invalid_context,
>> +		.pmu_enable = arm_ni_pmu_enable,
>> +		.pmu_disable = arm_ni_pmu_disable,
>> +		.event_init = arm_ni_event_init,
>> +		.add = arm_ni_event_add,
>> +		.del = arm_ni_event_del,
>> +		.start = arm_ni_event_start,
>> +		.stop = arm_ni_event_stop,
>> +		.read = arm_ni_event_read,
>> +	};
>> +
>> +	name = devm_kasprintf(ni->dev, GFP_KERNEL, "arm_ni_%d_cd_%d", ni->id, cd->id);
>> +	if (!name)
>> +		return -ENOMEM;
>> +
>> +	err = cpuhp_state_add_instance(arm_ni_hp_state, &cd->cpuhp_node);
>> +	if (err)
>> +		return err;
> 
> What happens if there's a CPU hotplug operation here? Can we end up calling
> perf_pmu_migrate_context() concurrently with perf_pmu_register()?

Yes. Alternatively we could register the PMU before the hotplug handler, 
then potentially miss a hotplug event and leave a user-visible PMU 
associated with an invalid CPU. This is a known issue for all system PMU 
drivers, and the conclusion 5 years ago was that it's impractical to 
close this race from outside perf core itself[1][2].

>> +	return perf_pmu_register(&cd->pmu, name, -1);
> 
> Clean up the cpuhp instance if this fails?

Indeed, not sure how that managed to escape...

Thanks,
Robin.

[1] 
https://lore.kernel.org/linux-arm-kernel/cover.1549299188.git.robin.murphy@arm.com/
[2] 
https://lore.kernel.org/linux-arm-kernel/cover.1554310292.git.robin.murphy@arm.com/

>> +static void arm_ni_remove(struct platform_device *pdev)
>> +{
>> +	struct arm_ni *ni = platform_get_drvdata(pdev);
>> +
>> +	for (int i = 0; i < ni->num_cds; i++) {
>> +		struct arm_ni_cd *cd = ni->cds + i;
>> +
>> +		if (!cd->pmu_base)
>> +			continue;
>> +
>> +		writel_relaxed(0, cd->pmu_base + NI_PMCR);
>> +		writel_relaxed(U32_MAX, cd->pmu_base + NI_PMINTENCLR);
>> +		perf_pmu_unregister(&cd->pmu);
> 
> Similarly here, it feels like a CPU hotplug operation could cause problems
> here.
> 
>> +		cpuhp_state_remove_instance_nocalls(arm_ni_hp_state, &cd->cpuhp_node);
>> +	}
>> +}
> 
> Will

