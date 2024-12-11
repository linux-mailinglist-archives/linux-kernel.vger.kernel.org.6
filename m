Return-Path: <linux-kernel+bounces-441227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA3F9ECB70
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2C5281333
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1140A211A06;
	Wed, 11 Dec 2024 11:39:20 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF54238E27;
	Wed, 11 Dec 2024 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733917159; cv=none; b=a890Wz6/JB2oLnwR4ZONhQaKl+tTCoc1uqXun3ZVYZqfuO9c8aTF2udHEHkCbyTqPfQuPwGbtwzk3GczEZPDD+MLHAOqMH+x6LLTjNSBBZfFg/1DYmDDlbXJNKSdpKgpmWz6R4wZhhOCCnaQR7tScPw3GU66hvYJKmPVbYSBP5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733917159; c=relaxed/simple;
	bh=GjpdDPe/vlLCgl3IY6OY0f/sBqZHbJneeNOQReCkYAk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTZ+ozxYiAqSP3/3OrPHNZXgkxK9F8r4530Afm4AMeMt5/QrUJD4/AiF4oogyPrVF8mHT+PwHF9UOz60ICRvUGJ4PwtKxVS6EkqWj3PbICseaxyIdK9v+8ImsQARA0KSyyitoiDmkBzwaBmJKHSmtXR2hwYHFo3oXuY0ZyJ2mPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y7YRJ5CxSz6GC5J;
	Wed, 11 Dec 2024 19:34:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E6E01140B73;
	Wed, 11 Dec 2024 19:39:13 +0800 (CST)
Received: from localhost (10.48.156.16) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Dec
 2024 12:39:12 +0100
Date: Wed, 11 Dec 2024 11:39:09 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yoshihiro Furudera <fj5100bi@fujitsu.com>
CC: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, "Bjorn Andersson"
	<quic_bjorande@quicinc.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "
 =?ISO-8859-1?Q?N=EDcolas?= \"F. R. A. Prado\"" <nfraprado@collabora.com>,
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] perf: Fujitsu: Add the Uncore MAC PMU driver
Message-ID: <20241211113909.000039d0@huawei.com>
In-Reply-To: <20241122061753.2598688-2-fj5100bi@fujitsu.com>
References: <20241122061753.2598688-1-fj5100bi@fujitsu.com>
	<20241122061753.2598688-2-fj5100bi@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 22 Nov 2024 06:17:52 +0000
Yoshihiro Furudera <fj5100bi@fujitsu.com> wrote:

> This adds a new dynamic PMU to the Perf Events framework to program and
> control the Uncore MAC PMUs in Fujitsu chips.
> 
> This driver was created with reference to drivers/perf/qcom_l3_pmu.c.
> 
> This driver exports formatting and event information to sysfs so it can
> be used by the perf user space tools with the syntaxes:
> 
> perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
> perf stat -e mac_iod0_mac0_ch0/event=0x80/ ls
> 
> FUJITSU-MONAKA Specification URL:
> https://github.com/fujitsu/FUJITSU-MONAKA
> 
> Signed-off-by: Yoshihiro Furudera <fj5100bi@fujitsu.com>
Hi,

A few comments inline.

Thanks,

Jonathan

> diff --git a/drivers/perf/fujitsu_mac_pmu.c b/drivers/perf/fujitsu_mac_pmu.c
> new file mode 100644
> index 000000000000..810f51f798a0
> --- /dev/null
> +++ b/drivers/perf/fujitsu_mac_pmu.c

> +/* Number of counters on each PMU */
> +#define MAC_NUM_COUNTERS  8
> +/* Mask for the event type field within perf_event_attr.config and EVTYPE reg */
> +#define MAC_EVTYPE_MASK   0xFF
> +
> +/* Perfmon registers */
> +#define MAC_PM_EVCNTR(__cntr) (0x000 + ((__cntr) & 0x7) * 8)
> +#define MAC_PM_CNTCTL(__cntr) (0x100 + ((__cntr) & 0x7) * 8)
> +#define MAC_PM_EVTYPE(__cntr) (0x200 + ((__cntr) & 0x7) * 8)

Do you need the masking?  As far as I can tell the idx that goes
into these calls is capped as below MAC_NUM_COUNTERS so
that masking operation will never do anything.  I hope the only
other value that occurs (-1) is never used with these.


> +#define MAC_PM_CR         0x400
> +#define MAC_PM_CNTENSET   0x410
> +#define MAC_PM_CNTENCLR   0x418
> +#define MAC_PM_INTENSET   0x420
> +#define MAC_PM_INTENCLR   0x428
> +#define MAC_PM_OVSR       0x440
> +
> +/* MAC_PM_CNTCTLx */
> +#define PMCNT_RESET           0
> +
> +/* MAC_PM_EVTYPEx */
> +#define EVSEL(__val)          ((__val) & MAC_EVTYPE_MASK)

FIELD_GET() and just use the mask inline.

> +
> +/* MAC_PM_CR */
> +#define PM_RESET              (1UL << 1)

BIT(1)

> +#define PM_ENABLE             (1UL << 0)

BIT(0)

> +
> +/* MAC_PM_CNTENSET */
> +#define PMCNTENSET(__cntr)    (1UL << ((__cntr) & 0x7))
> +
> +/* MAC_PM_CNTENCLR */
> +#define PMCNTENCLR(__cntr)    (1UL << ((__cntr) & 0x7))
With above note on whether the mask is needed and the small size
of that shift. BIT(__cntr) should work.

> +#define PM_CNTENCLR_RESET     0xFF
> +
> +/* MAC_PM_INTENSET */
> +#define PMINTENSET(__cntr)    (1UL << ((__cntr) & 0x7))
> +
> +/* MAC_PM_INTENCLR */
> +#define PMINTENCLR(__cntr)    (1UL << ((__cntr) & 0x7))
> +#define PM_INTENCLR_RESET     0xFF
> +
> +/* MAC_PM_OVSR */
> +#define PMOVSRCLR(__cntr)     (1UL << ((__cntr) & 0x7))
> +#define PMOVSRCLR_RESET       0xFF


> +static int fujitsu_mac__event_init(struct perf_event *event)
> +{
> +	struct mac_pmu *macpmu = to_mac_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	/* Is the event for this PMU? */
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/*
> +	 * Sampling not supported
> +	 * since these events are not core-attributable.
Strange line wrap.  
	 * Sampling not supported since these events are not
	 * core-attributable.

would be more conventional.

> +	 */
> +	if (hwc->sample_period)
> +		return -EINVAL;
> +
> +	/*
> +	 * Task mode not available, we run the counters as socket counters,
> +	 * not attributable to any CPU and therefore cannot attribute per-task.
> +	 */
> +	if (event->cpu < 0)
> +		return -EINVAL;
> +
> +	/* Validate the group */
> +	if (!fujitsu_mac__validate_event_group(event))
> +		return -EINVAL;
> +
> +	hwc->idx = -1;
> +
> +	/*
> +	 * Many perf core operations (eg. events rotation) operate on a
> +	 * single CPU context. This is obvious for CPU PMUs, where one
> +	 * expects the same sets of events being observed on all CPUs,
> +	 * but can lead to issues for off-core PMUs, like this one, where
> +	 * each event could be theoretically assigned to a different CPU.
> +	 * To mitigate this, we enforce CPU assignment to one designated
> +	 * processor (the one described in the "cpumask" attribute exported
> +	 * by the PMU device). perf user space tools honor this and avoid
> +	 * opening more than one copy of the events.
> +	 */
> +	event->cpu = cpumask_first(&macpmu->cpumask);
> +
> +	return 0;
> +}
>
> +
> +static void fujitsu_mac__event_del(struct perf_event *event, int flags)
> +{
> +	struct mac_pmu *macpmu = to_mac_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	/* Stop and clean up */
> +	fujitsu_mac__event_stop(event,  flags | PERF_EF_UPDATE);

Drop the extra space before flags.

> +	macpmu->events[hwc->idx] = NULL;
> +	bitmap_release_region(macpmu->used_mask, hwc->idx, 0);
> +
> +	/* Propagate changes to the userspace mapping. */
> +	perf_event_update_userpage(event);
> +}



...

> +static ssize_t cpumask_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct mac_pmu *macpmu = to_mac_pmu(dev_get_drvdata(dev));
If as suggested below you used an index to store the cpu rather than
a one hot mask, you'd need to create the mask here to print it.
> +
> +	return cpumap_print_to_pagebuf(true, buf, &macpmu->cpumask);
> +}

...

> +static int fujitsu_mac_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct mac_pmu *macpmu = hlist_entry_safe(node, struct mac_pmu, node);
> +
> +	/* If there is not a CPU/PMU association pick this CPU */
> +	if (cpumask_empty(&macpmu->cpumask))
> +		cpumask_set_cpu(cpu, &macpmu->cpumask);
As below. Seems like just storing the CPU index (and using -1 for not yet
set) would be simpler than
> +
> +	return 0;
> +}
> +
> +static int fujitsu_mac_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct mac_pmu *macpmu = hlist_entry_safe(node, struct mac_pmu, node);
> +	unsigned int target;
> +
> +	if (!cpumask_test_and_clear_cpu(cpu, &macpmu->cpumask))

If you are only ever going to set one bit in the mask, why not just
store the CPU index instead?

> +		return 0;
> +
> +	target = cpumask_any_but(cpu_online_mask, cpu);
> +	if (target >= nr_cpu_ids)
> +		return 0;
> +
> +	perf_pmu_migrate_context(&macpmu->pmu, cpu, target);
> +	cpumask_set_cpu(target, &macpmu->cpumask);
> +
> +	return 0;
> +}
> +
> +static int fujitsu_mac_pmu_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct acpi_device *acpi_dev;
> +	struct mac_pmu *macpmu;
> +	struct resource *memrc;
> +	char *name;
> +	int ret;
> +	u64 uid;
> +
> +	acpi_dev = ACPI_COMPANION(dev);
> +	if (!acpi_dev)
> +		return -ENODEV;
> +
> +	ret = acpi_dev_uid_to_integer(acpi_dev, &uid);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "unable to read ACPI uid\n");
> +
> +	macpmu = devm_kzalloc(dev, sizeof(*macpmu), GFP_KERNEL);
> +	name = devm_kasprintf(dev, GFP_KERNEL, "mac_iod%llu_mac%llu_ch%llu",
> +			  (uid >> 8) & 0xF, (uid >> 4) & 0xF, uid & 0xF);
> +	if (!macpmu)
> +		return -ENOMEM;

Why allocate two before checking either?  That's an unusual pattern.
Check if macpmu is NULL before trying to allocate name.

> +
> +	if (!name)
> +		return -ENOMEM;
> +
> +	macpmu->pmu = (struct pmu) {
> +		.parent		= dev,
> +		.task_ctx_nr	= perf_invalid_context,
> +
> +		.pmu_enable	= fujitsu_mac__pmu_enable,
> +		.pmu_disable	= fujitsu_mac__pmu_disable,
> +		.event_init	= fujitsu_mac__event_init,
> +		.add		= fujitsu_mac__event_add,
> +		.del		= fujitsu_mac__event_del,
> +		.start		= fujitsu_mac__event_start,
> +		.stop		= fujitsu_mac__event_stop,
> +		.read		= fujitsu_mac__event_read,
> +
> +		.attr_groups	= fujitsu_mac_pmu_attr_grps,
> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE
> +	};
> +
> +	macpmu->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &memrc);
> +	if (IS_ERR(macpmu->regs))
> +		return PTR_ERR(macpmu->regs);
> +
> +	fujitsu_mac__init(macpmu);
> +
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret <= 0)
> +		return ret;
> +
> +	ret = devm_request_irq(dev, ret, fujitsu_mac__handle_irq, 0,
> +			       name, macpmu);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Request for IRQ failed for slice @%pa\n",
> +						&memrc->start);
> +
> +	/* Add this instance to the list used by the offline callback */
> +	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_FUJITSU_MAC_ONLINE, &macpmu->node);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Error %d registering hotplug", ret);
> +
> +	ret = perf_pmu_register(&macpmu->pmu, name, -1);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to register MAC PMU (%d)\n", ret);

dev_err_probe() already pretty prints the return value.  No need to print the numeric
value as well. 

> +
> +	dev_dbg(dev, "Registered %s, type: %d\n", name, macpmu->pmu.type);
> +
> +	return 0;
> +}

> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index a04b73c40173..21006d1cda59 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -228,6 +228,7 @@ enum cpuhp_state {
>  	CPUHP_AP_PERF_ARM_CAVIUM_TX2_UNCORE_ONLINE,
>  	CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
>  	CPUHP_AP_PERF_ARM_MRVL_PEM_ONLINE,
> +	CPUHP_AP_PERF_ARM_FUJITSU_MAC_ONLINE,

If the DYN option works for you, I think we should go with that.
Some more recent PMU drivers are already using it without problem.

>  	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
>  	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
>  	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,


