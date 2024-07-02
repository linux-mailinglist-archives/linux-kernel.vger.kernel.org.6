Return-Path: <linux-kernel+bounces-237959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A826B92413A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB0B1F25BEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EFF1BA086;
	Tue,  2 Jul 2024 14:47:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A7D1E48A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931656; cv=none; b=StvkSRYVVvUg4xov3dMiCdWYVnukBuSPHd2OxFj7pqXyCuPXol5PsxgvFcLZjT4C2SbK8cnvET53myGoejZ6eaJeeXyuv8L9HpZ8qvvSe19/JbM4kVsROI+YBFqPVgbjYWFR6DF/nx6jApESBWO5HlsI5q1770T+LrpxkZL4q5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931656; c=relaxed/simple;
	bh=pVzB79MIgOU+uxCMC0r7BiU/Pc1N4hAovjwl1Dhtt7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTWgAcDOTqEF/oHvP5jgVjsyqbBNwx6djHIoGiDXvcn9EWPx5U7JYs6ZcP4SYFXBdgRi9dFyw9yBUexyqfQXM+opufTx6pJD3dE4ojc08PEnxwyf9T4UXzfCzXO3ygVkD1wATHKYN9o4TvTXPfKoQj/BaAwOySwb4uTMkRDeC7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6781339;
	Tue,  2 Jul 2024 07:47:58 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1632C3F766;
	Tue,  2 Jul 2024 07:47:32 -0700 (PDT)
Message-ID: <71e6b849-180b-4dc4-bb9b-27753b04e62a@arm.com>
Date: Tue, 2 Jul 2024 15:47:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf: Add driver for Arm NI-700 interconnect PMU
To: Will Deacon <will@kernel.org>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, jialong.yang@shingroup.cn
References: <cover.1713972897.git.robin.murphy@arm.com>
 <eb471ea519d358880eda01c95fd1f11a63663907.1713972897.git.robin.murphy@arm.com>
 <20240701133514.GB2250@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240701133514.GB2250@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/07/2024 2:35 pm, Will Deacon wrote:
> On Thu, Apr 25, 2024 at 01:29:53PM +0100, Robin Murphy wrote:
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
>> ---
>>   drivers/perf/Kconfig  |   7 +
>>   drivers/perf/Makefile |   1 +
>>   drivers/perf/arm-ni.c | 767 ++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 775 insertions(+)
>>   create mode 100644 drivers/perf/arm-ni.c
> 
> Please can you add some documentation?

Heh, I thought I'd try my luck, but your question below helps convince 
me that some basic usage information probably is warranted.

>> +struct arm_ni {
>> +	struct device *dev;
>> +	void __iomem *base;
>> +	enum ni_part part;
>> +	int id;
>> +	int num_cds;
>> +	struct arm_ni_cd cds[];
>> +};
> 
> Can you use that fancy new __counted_by thing here?

Sure, that's new to me but I'll take a look.

>> +
>> +#define cd_to_ni(cd) container_of((cd), struct arm_ni, cds[(cd)->id])
>> +#define pmu_to_cd(p) container_of((p), struct arm_ni_cd, pmu)
>> +
>> +#define cd_for_each_unit(cd, u) \
>> +	for (struct arm_ni_unit *u = cd->units; u < cd->units + cd->num_units; u++)
>> +
>> +static int arm_ni_hp_state;
>> +
>> +struct arm_ni_event_attr {
>> +	struct device_attribute attr;
>> +	enum ni_node_type type;
>> +};
>> +
>> +#define NI_EVENT_ATTR(_name, _type)					\
>> +	(&((struct arm_ni_event_attr[]) {{				\
>> +		.attr = __ATTR(_name, 0444, arm_ni_event_show, NULL),	\
>> +		.type = _type,						\
>> +	}})[0].attr.attr)
>> +
>> +static ssize_t arm_ni_event_show(struct device *dev,
>> +				 struct device_attribute *attr, char *buf)
>> +{
>> +	struct arm_ni_event_attr *eattr = container_of(attr, typeof(*eattr), attr);
>> +
>> +	if (eattr->type == NI_PMU)
>> +		return sysfs_emit(buf, "type=0x%x\n", eattr->type);
>> +
>> +	return sysfs_emit(buf, "type=0x%x,eventid=?,nodeid=?\n", eattr->type);
> 
> I'm struggling to see what this is doing. Please can you explain it a
> bit? For example, does the perf tool parse those "=?" entries, and why
> is it useful to print out only the NI_PMU value for the other events?

Yes, "=?" means that the alias requires that parameter to be explicitly 
specified - see the "Parameterized Events" section in the perf-list docs.

The way this is working is a bit like CMN, where each node type has its 
own set of possible events, however I'm keen to avoid going down the 
same route of having to maintain an ever-growing list of hundreds of 
aliases in the driver, so the aim is to just expose these "incomplete" 
aliases to indicate which node types are present in a given PMU's 
domain, and then maybe have detailed jevents built upon those if anyone 
really wants. Unlike CMN there is no potential for aggregation in 
hardware, so for any given type, we have to know both which event to 
count and which node (of that type) to count it on. The cycles event is 
the slight exception - as for CMN, it's encoded as an event belonging to 
the PMU node type to keep things straightforward, but since there is 
only ever one PMU node and it has no notion of actual event IDs, no 
further disambiguation is needed and the ID parameters are unused.

>> +}
>> +
>> +static umode_t arm_ni_event_attr_is_visible(struct kobject *kobj,
>> +					    struct attribute *attr, int unused)
>> +{
>> +	struct device *dev = kobj_to_dev(kobj);
>> +	struct arm_ni_cd *cd = pmu_to_cd(dev_get_drvdata(dev));
>> +	struct arm_ni_event_attr *eattr;
>> +
>> +	eattr = container_of(attr, typeof(*eattr), attr.attr);
>> +
>> +	cd_for_each_unit(cd, unit) {
>> +		if (unit->type == eattr->type && unit->ns)
>> +			return attr->mode;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static struct attribute *arm_ni_event_attrs[] = {
>> +	NI_EVENT_ATTR(asni, NI_ASNI),
>> +	NI_EVENT_ATTR(amni, NI_AMNI),
>> +	NI_EVENT_ATTR(cycles, NI_PMU),
>> +	NI_EVENT_ATTR(hsni, NI_HSNI),
>> +	NI_EVENT_ATTR(hmni, NI_HMNI),
>> +	NI_EVENT_ATTR(pmni, NI_PMNI),
>> +	NULL
>> +};
> 
> [...]
> 
>> +static bool arm_ni_validate_event(struct perf_event *this,
>> +				  struct perf_event *that, int *count)
>> +{
>> +	if (is_software_event(this))
>> +		return true;
>> +	if (this->pmu != that->pmu)
>> +		return false;
>> +	return --count[NI_EVENT_TYPE(this) == NI_PMU] >= 0;
> 
> This is pretty horrible to read :/
> 
> I don't know the details of this PMU, so is the count array saying that
> you can have NI_NUM_COUNTERS events with the NI_PMU type, but only one
> event of any other type?

You found the brown M&M :)

Yes, this was largely a reaction to how horrible CMN event validation 
is, wherein I got carried away seeing how small and gratuitously clever 
I could make it here, and then decided to be cheeky and leave it like 
that. However that was already long enough ago that I too am inclined to 
start thinking that verbose and boring maybe isn't all that bad...

>> +}
>> +
>> +static int arm_ni_validate_group(struct perf_event *event)
>> +{
>> +	struct perf_event *sibling, *leader;
>> +	int count[2] = {NI_NUM_COUNTERS, 1};
>> +
>> +	arm_ni_validate_event(event, event, count);
>> +
>> +	leader = event->group_leader;
>> +	if (leader != event && !arm_ni_validate_event(leader, event, count))
>> +		return - EINVAL;
>> +
>> +	for_each_sibling_event(sibling, leader) {
>> +		if (!arm_ni_validate_event(sibling, event, count))
>> +			return - EINVAL;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int arm_ni_event_init(struct perf_event *event)
>> +{
>> +	struct arm_ni_cd *cd = pmu_to_cd(event->pmu);
>> +
>> +	if (event->attr.type != event->pmu->type)
>> +		return -ENOENT;
>> +
>> +	if (is_sampling_event(event))
>> +		return -EINVAL;
>> +
>> +	event->cpu = cd->cpu;
>> +	if (NI_EVENT_TYPE(event) == NI_PMU)
>> +		return arm_ni_validate_group(event);
>> +
>> +	cd_for_each_unit(cd, unit) {
>> +		if (unit->type == NI_EVENT_TYPE(event) &&
>> +		    unit->id == NI_EVENT_NODEID(event) && unit->ns) {
>> +			event->hw.config_base = (unsigned long)unit;
>> +			return arm_ni_validate_group(event);
>> +		}
>> +	}
>> +	return -EINVAL;
>> +}
>> +
>> +static u64 arm_ni_read_ccnt(struct arm_ni_cd *cd)
>> +{
>> +	u64 l, u_old, u_new;
>> +
>> +	u_new = readl_relaxed(cd->pmu_base + NI_PMCCNTR_U);
>> +	do {
>> +		u_old = u_new;
>> +		l = readl_relaxed(cd->pmu_base + NI_PMCCNTR_L);
>> +		u_new = readl_relaxed(cd->pmu_base + NI_PMCCNTR_U);
>> +	} while (u_new != u_old);
>> +
>> +	return (u_new << 32) | l;
>> +}
> 
> oh man, they really don't have 64-bit registers on this thing? If we
> have to loop like this, can we add a timeout just in case the hardware
> goes wonky? It's like mixing together the worst parts of iopoll.h and
> io-64-nonatomic-lo-hi.h.

Yup, it's an APB interface, so even if there is a bridge upstream that 
can split 64-bit accesses the right way, they still wouldn't be atomic. 
I can certainly bound the loop here, since this should realistically 
never need to retry more than once.

> There are a few other PMU drivers that look like they could share that
> code if you added it as a generic helper.

I'll add that to the list for my occasional side-project of trying to 
factor out a whole system PMU helper library...

Cheers,
Robin.

