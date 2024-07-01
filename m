Return-Path: <linux-kernel+bounces-236349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 296AF91E0D7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE731C215A4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5065143864;
	Mon,  1 Jul 2024 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obfwfaXZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EBE15ECC5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840920; cv=none; b=NqQMv6EnUPNbchfp/66KjRDEaP6creoHnDj5+tJIoaMKc+CnuUD4/4mkDUVU8agdPYO4caxspzFAYHK45hBBLbm/lRvRXO49lPsuk5bafuLrisxBD3yi6RCsrGGfr7Geobmicg97wRNlGc5iNSQYywwmvvB8SfrCgkrLy4e5XAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840920; c=relaxed/simple;
	bh=452Q4FhZJ0mADWWLmyzoJKxOQya9ASi8Mich7VuTw24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7t8j+iC0yMctcQQtCBdmcdnwve9aaoMOIknf944KG5VMOoGSfT+gLipxpPWNWPds3dowQ8iMsn34+TMQTMTRsrT9NE4yUZRu7eNW1neHDjeQU2ekiQeQS/DM8wtJ51ImuAsxPnnVCWm4LoK54noZ7U/bo3wuVTthPYEu/ke/Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obfwfaXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3E1C116B1;
	Mon,  1 Jul 2024 13:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719840919;
	bh=452Q4FhZJ0mADWWLmyzoJKxOQya9ASi8Mich7VuTw24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=obfwfaXZJuo7CKWqimApdmuV6R+GIeO9qj255mFWzzCb/bf29xrbGB0kNUz8ziT7r
	 xLQ4ZK3JLomhHJTwIM0LIndI2ftjImn5aTlEzNj8NawFcqSVDlZrGkTHXjnRkA1Sf8
	 TDLXP23gqmKaBatLMfyuzTxdSLo9y3n9imHVSmzBSgeKO25JZ1MeWa7C23V2n8I1H0
	 6CfzYRDFefZORpoLqkh1DDLtGYjiDxoD0QnGSJl3PGQ2qVMmDzad6kMxIAYV8a6Xpf
	 kEsAOr07kgfEnroGDkS+kKej+ye0fzWjW3Axp57ZfMZV8YchAgVfXFlu+qW4ClPTnT
	 fA2wv5x4hOclg==
Date: Mon, 1 Jul 2024 14:35:14 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, jialong.yang@shingroup.cn
Subject: Re: [PATCH 2/3] perf: Add driver for Arm NI-700 interconnect PMU
Message-ID: <20240701133514.GB2250@willie-the-truck>
References: <cover.1713972897.git.robin.murphy@arm.com>
 <eb471ea519d358880eda01c95fd1f11a63663907.1713972897.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb471ea519d358880eda01c95fd1f11a63663907.1713972897.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Apr 25, 2024 at 01:29:53PM +0100, Robin Murphy wrote:
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
> ---
>  drivers/perf/Kconfig  |   7 +
>  drivers/perf/Makefile |   1 +
>  drivers/perf/arm-ni.c | 767 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 775 insertions(+)
>  create mode 100644 drivers/perf/arm-ni.c

Please can you add some documentation?

> +struct arm_ni {
> +	struct device *dev;
> +	void __iomem *base;
> +	enum ni_part part;
> +	int id;
> +	int num_cds;
> +	struct arm_ni_cd cds[];
> +};

Can you use that fancy new __counted_by thing here?

> +
> +#define cd_to_ni(cd) container_of((cd), struct arm_ni, cds[(cd)->id])
> +#define pmu_to_cd(p) container_of((p), struct arm_ni_cd, pmu)
> +
> +#define cd_for_each_unit(cd, u) \
> +	for (struct arm_ni_unit *u = cd->units; u < cd->units + cd->num_units; u++)
> +
> +static int arm_ni_hp_state;
> +
> +struct arm_ni_event_attr {
> +	struct device_attribute attr;
> +	enum ni_node_type type;
> +};
> +
> +#define NI_EVENT_ATTR(_name, _type)					\
> +	(&((struct arm_ni_event_attr[]) {{				\
> +		.attr = __ATTR(_name, 0444, arm_ni_event_show, NULL),	\
> +		.type = _type,						\
> +	}})[0].attr.attr)
> +
> +static ssize_t arm_ni_event_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct arm_ni_event_attr *eattr = container_of(attr, typeof(*eattr), attr);
> +
> +	if (eattr->type == NI_PMU)
> +		return sysfs_emit(buf, "type=0x%x\n", eattr->type);
> +
> +	return sysfs_emit(buf, "type=0x%x,eventid=?,nodeid=?\n", eattr->type);

I'm struggling to see what this is doing. Please can you explain it a
bit? For example, does the perf tool parse those "=?" entries, and why
is it useful to print out only the NI_PMU value for the other events?

> +}
> +
> +static umode_t arm_ni_event_attr_is_visible(struct kobject *kobj,
> +					    struct attribute *attr, int unused)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct arm_ni_cd *cd = pmu_to_cd(dev_get_drvdata(dev));
> +	struct arm_ni_event_attr *eattr;
> +
> +	eattr = container_of(attr, typeof(*eattr), attr.attr);
> +
> +	cd_for_each_unit(cd, unit) {
> +		if (unit->type == eattr->type && unit->ns)
> +			return attr->mode;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct attribute *arm_ni_event_attrs[] = {
> +	NI_EVENT_ATTR(asni, NI_ASNI),
> +	NI_EVENT_ATTR(amni, NI_AMNI),
> +	NI_EVENT_ATTR(cycles, NI_PMU),
> +	NI_EVENT_ATTR(hsni, NI_HSNI),
> +	NI_EVENT_ATTR(hmni, NI_HMNI),
> +	NI_EVENT_ATTR(pmni, NI_PMNI),
> +	NULL
> +};

[...]

> +static bool arm_ni_validate_event(struct perf_event *this,
> +				  struct perf_event *that, int *count)
> +{
> +	if (is_software_event(this))
> +		return true;
> +	if (this->pmu != that->pmu)
> +		return false;
> +	return --count[NI_EVENT_TYPE(this) == NI_PMU] >= 0;

This is pretty horrible to read :/

I don't know the details of this PMU, so is the count array saying that
you can have NI_NUM_COUNTERS events with the NI_PMU type, but only one
event of any other type?

> +}
> +
> +static int arm_ni_validate_group(struct perf_event *event)
> +{
> +	struct perf_event *sibling, *leader;
> +	int count[2] = {NI_NUM_COUNTERS, 1};
> +
> +	arm_ni_validate_event(event, event, count);
> +
> +	leader = event->group_leader;
> +	if (leader != event && !arm_ni_validate_event(leader, event, count))
> +		return - EINVAL;
> +
> +	for_each_sibling_event(sibling, leader) {
> +		if (!arm_ni_validate_event(sibling, event, count))
> +			return - EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int arm_ni_event_init(struct perf_event *event)
> +{
> +	struct arm_ni_cd *cd = pmu_to_cd(event->pmu);
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	if (is_sampling_event(event))
> +		return -EINVAL;
> +
> +	event->cpu = cd->cpu;
> +	if (NI_EVENT_TYPE(event) == NI_PMU)
> +		return arm_ni_validate_group(event);
> +
> +	cd_for_each_unit(cd, unit) {
> +		if (unit->type == NI_EVENT_TYPE(event) &&
> +		    unit->id == NI_EVENT_NODEID(event) && unit->ns) {
> +			event->hw.config_base = (unsigned long)unit;
> +			return arm_ni_validate_group(event);
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
> +static u64 arm_ni_read_ccnt(struct arm_ni_cd *cd)
> +{
> +	u64 l, u_old, u_new;
> +
> +	u_new = readl_relaxed(cd->pmu_base + NI_PMCCNTR_U);
> +	do {
> +		u_old = u_new;
> +		l = readl_relaxed(cd->pmu_base + NI_PMCCNTR_L);
> +		u_new = readl_relaxed(cd->pmu_base + NI_PMCCNTR_U);
> +	} while (u_new != u_old);
> +
> +	return (u_new << 32) | l;
> +}

oh man, they really don't have 64-bit registers on this thing? If we
have to loop like this, can we add a timeout just in case the hardware
goes wonky? It's like mixing together the worst parts of iopoll.h and
io-64-nonatomic-lo-hi.h.

There are a few other PMU drivers that look like they could share that
code if you added it as a generic helper.

Will

