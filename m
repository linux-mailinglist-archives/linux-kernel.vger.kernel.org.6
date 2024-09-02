Return-Path: <linux-kernel+bounces-311541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A3E968A3B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E28B21482
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEBC19C55D;
	Mon,  2 Sep 2024 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwjrXm89"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087C41DA5E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725288440; cv=none; b=HBEcNlgu2PJ0ZEVI6cwH/I2X3AB6BM/3HXAHJlCQNb9PEwg330Q32ymtkqwT7D0muYxBOnbBy5HOJ3ltKHf4hIeoySNvfnWQTI/i4aOQ1rKCPDG4wKKznIgBiVbqiTEUZX84sSMTG2xtPs5qbjS2eP8vLCL5twjdKCyf9pZN0fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725288440; c=relaxed/simple;
	bh=X45jWrJCTaBMiYV5408CS0aYMQPVZIj6Q9txx4dbO+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLsLh1Ba+Ywkg/EyNSpjJ+wVNPuD1Kihn1FX3OUJfT1NydTdUVLhcSWk66SPaHC4QD/0pM8HI7eTLcOtdqQpRMpmFSqebqXJopM3x5HfNWeevzc/kf5apFVhZYj8VDc3Gn7tf+5HoSrCLodoO7wf+re1N7BPUcHSgQA0aWc1v54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwjrXm89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DBCC4CEC2;
	Mon,  2 Sep 2024 14:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725288439;
	bh=X45jWrJCTaBMiYV5408CS0aYMQPVZIj6Q9txx4dbO+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZwjrXm89et9gPbeEmry7VYwgv1sa69m/R0JFIUjqkxST8BgocZYVOED9qEhmrzDd9
	 jMOEqRiSnIJpk0RnlGTBJ6W7AGaOD+xKAGVZ3Rm6f3X/vZyOQRglwm1eqHk7mQMhtu
	 JKLj5gRFVYKUnmKthNWL34ySPrxnXZTPjq8QQ5ng6DcarXQLdwUKqYTteUf3rWXasp
	 976bgykl8UEn0cU6BDS8WWgqWtHtpR+s9E57DRVaBuHqbvMhLjKc15scwzFHg9J0pv
	 e3Gl/RrmW4/mbAlUs+EpeKsHvg2A3H2LG7tY2vFCKAlOn+Lui6F1yPerYA6OBZ9vG/
	 /aeWPuVccwT7A==
Date: Mon, 2 Sep 2024 15:47:15 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, jialong.yang@shingroup.cn
Subject: Re: [PATCH v3 2/3] perf: Add driver for Arm NI-700 interconnect PMU
Message-ID: <20240902144714.GA11443@willie-the-truck>
References: <cover.1725037424.git.robin.murphy@arm.com>
 <275e8ef450eeaf837468ce34e2c6930d59091fbc.1725037424.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <275e8ef450eeaf837468ce34e2c6930d59091fbc.1725037424.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Robin,

On Fri, Aug 30, 2024 at 06:19:34PM +0100, Robin Murphy wrote:
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
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> v2:
>  - Add basic usage documentation
>  - Use __counted_by attribute
>  - Make group validation logic clearer (and drop PMU type check
>    which perf_event_open() already takes care of)
>  - Add retry limit to arm_ni_read_ccnt()
> v3:
>  - Update .remove to return void
>  - Fix group leader validation and make the naming clearer
>  - Drop NUMA_NO_NODE check for CPU online (the only way that could
>    actually pass both other migration conditions is if the NUMA info
>    is so messed up that it's not worth worrying about anyway)

Thanks, this is looking pretty good now. I just have a few random comments
based on another read-through of the code.

> diff --git a/Documentation/admin-guide/perf/arm-ni.rst b/Documentation/admin-guide/perf/arm-ni.rst
> new file mode 100644
> index 000000000000..3cd7d0f75f0f
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/arm-ni.rst
> @@ -0,0 +1,17 @@
> +====================================
> +Arm Network-on Chip Interconnect PMU
> +====================================
> +
> +NI-700 and friends implement a distinct PMU for each clock domain within the
> +interconnect. Correspondingly, the driver exposes multiple PMU devices named
> +arm_ni_<x>_cd_<y>, where <x> is an (abritrary) instance identifier and <y> is

typo: abritrary

> +the clock domain ID within that particular instance. If multiple NI instances
> +exist within a system, the PMU devices can be correlated with the underlying
> +hardware instance via sysfs parentage.
> +
> +Each PMU exposes base event aliases for the interface types present in its clock
> +domain. These require qualifying with the "eventid" and "nodeid" parameters
> +to specify the event code to count and the interface at which to count it
> +(per the configured hardware ID as reflected in the xxNI_NODE_INFO register).
> +The exception is the "cycles" alias for the PMU cycle counter, which is encoded
> +with the PMU node type and needs no further qualification.

[...]

> +static ssize_t arm_ni_format_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct arm_ni_format_attr *fmt = container_of(attr, typeof(*fmt), attr);
> +	int lo = __ffs(fmt->field), hi = __fls(fmt->field);
> +
> +	return sysfs_emit(buf, "config:%d-%d\n", lo, hi);
> +}

Nit: if you end up adding single-bit config fields in the future, this
will quietly do the wrong thing. Maybe safe-guard the 'lo==hi' case (even
if you just warn once and return without doing anything).


[...]

> +static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_start)
> +{
> +	struct arm_ni_cd *cd = ni->cds + node->id;
> +	const char *name;
> +	int err;
> +
> +	cd->id = node->id;
> +	cd->num_units = node->num_components;
> +	cd->units = devm_kcalloc(ni->dev, cd->num_units, sizeof(*(cd->units)), GFP_KERNEL);
> +	if (!cd->units)
> +		return -ENOMEM;
> +
> +	for (int i = 0; i < cd->num_units; i++) {
> +		u32 reg = readl_relaxed(node->base + NI_CHILD_PTR(i));
> +		void __iomem *unit_base = ni->base + reg;
> +		struct arm_ni_unit *unit = cd->units + i;
> +
> +		reg = readl_relaxed(unit_base + NI_NODE_TYPE);
> +		unit->type = FIELD_GET(NI_NODE_TYPE_NODE_TYPE, reg);
> +		unit->id = FIELD_GET(NI_NODE_TYPE_NODE_ID, reg);
> +
> +		switch (unit->type) {
> +		case NI_PMU:
> +			reg = readl_relaxed(unit_base + NI_PMCFGR);
> +			if (!reg) {
> +				dev_info(ni->dev, "No access to PMU %d\n", cd->id);
> +				devm_kfree(ni->dev, cd->units);
> +				return 0;
> +			}
> +			unit->ns = true;
> +			cd->pmu_base = unit_base;
> +			break;
> +		case NI_ASNI:
> +		case NI_AMNI:
> +		case NI_HSNI:
> +		case NI_HMNI:
> +		case NI_PMNI:
> +			unit->pmusela = unit_base + NI700_PMUSELA;
> +			writel_relaxed(1, unit->pmusela);
> +			if (readl_relaxed(unit->pmusela) != 1)
> +				dev_info(ni->dev, "No access to node 0x%04x%04x\n", unit->id, unit->type);
> +			else
> +				unit->ns = true;
> +			break;
> +		default:
> +			/*
> +			 * e.g. FMU - thankfully bits 3:2 of FMU_ERR_FR0 are RES0 so
> +			 * can't alias any of the leaf node types we're looking for.
> +			 */
> +			dev_dbg(ni->dev, "Mystery node 0x%04x%04x\n", unit->id, unit->type);
> +			break;
> +		}
> +	}
> +
> +	res_start += cd->pmu_base - ni->base;
> +	if (!devm_request_mem_region(ni->dev, res_start, SZ_4K, dev_name(ni->dev))) {
> +		dev_err(ni->dev, "Failed to request PMU region 0x%llx\n", res_start);
> +		return -EBUSY;
> +	}
> +
> +	writel_relaxed(NI_PMCR_RESET_CCNT | NI_PMCR_RESET_EVCNT,
> +		       cd->pmu_base + NI_PMCR);
> +	writel_relaxed(U32_MAX, cd->pmu_base + NI_PMCNTENCLR);
> +	writel_relaxed(U32_MAX, cd->pmu_base + NI_PMOVSCLR);
> +	writel_relaxed(U32_MAX, cd->pmu_base + NI_PMINTENSET);
> +
> +	cd->irq = platform_get_irq(to_platform_device(ni->dev), cd->id);
> +	if (cd->irq < 0)
> +		return cd->irq;
> +
> +	err = devm_request_irq(ni->dev, cd->irq, arm_ni_handle_irq,
> +			       IRQF_NOBALANCING | IRQF_NO_THREAD,
> +			       dev_name(ni->dev), cd);
> +	if (err)
> +		return err;
> +
> +	cd->cpu = cpumask_local_spread(0, dev_to_node(ni->dev));
> +	cd->pmu = (struct pmu) {
> +		.module = THIS_MODULE,
> +		.parent = ni->dev,
> +		.attr_groups = arm_ni_attr_groups,
> +		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
> +		.task_ctx_nr = perf_invalid_context,
> +		.pmu_enable = arm_ni_pmu_enable,
> +		.pmu_disable = arm_ni_pmu_disable,
> +		.event_init = arm_ni_event_init,
> +		.add = arm_ni_event_add,
> +		.del = arm_ni_event_del,
> +		.start = arm_ni_event_start,
> +		.stop = arm_ni_event_stop,
> +		.read = arm_ni_event_read,
> +	};
> +
> +	name = devm_kasprintf(ni->dev, GFP_KERNEL, "arm_ni_%d_cd_%d", ni->id, cd->id);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	err = cpuhp_state_add_instance(arm_ni_hp_state, &cd->cpuhp_node);
> +	if (err)
> +		return err;

What happens if there's a CPU hotplug operation here? Can we end up calling
perf_pmu_migrate_context() concurrently with perf_pmu_register()?

> +	return perf_pmu_register(&cd->pmu, name, -1);

Clean up the cpuhp instance if this fails?

> +static void arm_ni_remove(struct platform_device *pdev)
> +{
> +	struct arm_ni *ni = platform_get_drvdata(pdev);
> +
> +	for (int i = 0; i < ni->num_cds; i++) {
> +		struct arm_ni_cd *cd = ni->cds + i;
> +
> +		if (!cd->pmu_base)
> +			continue;
> +
> +		writel_relaxed(0, cd->pmu_base + NI_PMCR);
> +		writel_relaxed(U32_MAX, cd->pmu_base + NI_PMINTENCLR);
> +		perf_pmu_unregister(&cd->pmu);

Similarly here, it feels like a CPU hotplug operation could cause problems
here.

> +		cpuhp_state_remove_instance_nocalls(arm_ni_hp_state, &cd->cpuhp_node);
> +	}
> +}

Will

