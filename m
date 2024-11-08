Return-Path: <linux-kernel+bounces-401778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF99C9C1F09
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28B86B22FC5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864791EB9F7;
	Fri,  8 Nov 2024 14:19:21 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C63C1DEFC2;
	Fri,  8 Nov 2024 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731075560; cv=none; b=PbQmNNaQzuXoNc6gGJ/JQeSMuGdf1auoPCb7qUO7ZPvM2oQEG+TuQqvMI019ehHJ5IqOLjALjwuH+b1e6lylVHjaTSetTsJxD11fLTwrQ0rFXy5SFa9BkaNO+EFFBeItAv7wVxOnoMS44aoG9SUcyH5h/gk+wdl5n5TdpfnJEYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731075560; c=relaxed/simple;
	bh=5M1fp1zETuKtZNvmJBiQWx1YKtpxHEQQHL300eSnzEE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHktISpmIbLo7jp5Jk1Aqa6j2GnFTjrTn6oXwWar5AZ4Ie79nJK0UV0e3NohLqTusjIZtWHh5LcjM2S2jfTb+2Skbgb0g6FD18lBErKr4JtChVILPP2VB8+CYgHbm2ktMlqsCltK+LQnnnlvQgCzeDjR/2SEMKEDgYQXfMhabMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XlLb80r2wz6J7BR;
	Fri,  8 Nov 2024 22:16:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E85A41401F4;
	Fri,  8 Nov 2024 22:19:13 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Nov
 2024 15:19:13 +0100
Date: Fri, 8 Nov 2024 14:19:11 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yoshihiro Furudera <fj5100bi@fujitsu.com>
CC: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, "Bjorn Andersson"
	<quic_bjorande@quicinc.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "
 =?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>, Thomas
 Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] perf: Fujitsu: Add the Uncore MAC PMU driver
Message-ID: <20241108141911.00003e14@huawei.com>
In-Reply-To: <20241108054006.2550856-2-fj5100bi@fujitsu.com>
References: <20241108054006.2550856-1-fj5100bi@fujitsu.com>
	<20241108054006.2550856-2-fj5100bi@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri,  8 Nov 2024 05:40:04 +0000
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
Hi.

A quick drive by review. I haven't looked at the details so this
is a little superficial at this stage.

Jonathan

> ---
>  .../admin-guide/perf/fujitsu_mac_pmu.rst      |  20 +
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/perf/Kconfig                          |   9 +
>  drivers/perf/Makefile                         |   1 +
>  drivers/perf/fujitsu_mac_pmu.c                | 633 ++++++++++++++++++
>  include/linux/cpuhotplug.h                    |   1 +
>  6 files changed, 665 insertions(+)
>  create mode 100644 Documentation/admin-guide/perf/fujitsu_mac_pmu.rst
>  create mode 100644 drivers/perf/fujitsu_mac_pmu.c
> 
> diff --git a/Documentation/admin-guide/perf/fujitsu_mac_pmu.rst b/Documentation/admin-guide/perf/fujitsu_mac_pmu.rst
> new file mode 100644
> index 000000000000..ddb3dcff3c61
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/fujitsu_mac_pmu.rst

Add this to the index file.

> @@ -0,0 +1,20 @@
> +===========================================================================
> +Fujitsu Uncore MAC Performance Monitoring Unit (PMU)
> +===========================================================================
> +
> +This driver supports the Uncore MAC PMUs found in Fujitsu chips.
> +Each MAC PMU on these chips is exposed as a uncore perf PMU with device name
> +mac_iod<iod>_mac<mac>_ch<ch>.
> +
> +The driver provides a description of its available events and configuration
> +options in sysfs, see /sys/bus/event_sources/devices/mac_iod<iod>_mac<mac>_ch<ch>/.
> +Given that these are uncore PMUs the driver also exposes a "cpumask" sysfs
> +attribute which contains a mask consisting of one CPU which will be used to
> +handle all the PMU events.
> +
> +Examples for use with perf::
> +
> +  perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
> +
> +Given that these are uncore PMUs the driver does not support sampling, therefore
> +"perf record" will not work. Per-task perf sessions are not supported.


Nice to give an idea of what the events are. EA in particularly isn't an immediately
obvious acronym.

...

> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index bab8ba64162f..4705c605e286 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -178,6 +178,15 @@ config FSL_IMX9_DDR_PMU
>  	 can give information about memory throughput and other related
>  	 events.
>  
> +config FUJITSU_MAC_PMU
> +	bool "Fujitsu Uncore MAC PMU"
> +	depends on (ARM64 && ACPI) || (COMPILE_TEST && 64BIT)
> +	help
> +		Provides support for the Uncore MAC performance monitor unit (PMU)
> +		in Fujitsu processors.
> +		Adds the Uncore MAC PMU into the perf events subsystem for
> +		monitoring Uncore MAC events.

Unusual indent. Match the rest of the file.

> +

> diff --git a/drivers/perf/fujitsu_mac_pmu.c b/drivers/perf/fujitsu_mac_pmu.c
> new file mode 100644
> index 000000000000..ee92ef5691dd
> --- /dev/null
> +++ b/drivers/perf/fujitsu_mac_pmu.c
> @@ -0,0 +1,633 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for the Uncore MAC PMUs in Fujitsu chips.
> + *
> + * See Documentation/admin-guide/perf/fujitsu_mac_pmu.rst for more details.
> + *
> + * This driver is based on drivers/perf/qcom_l3_pmu.c
> + * Copyright (c) 2015-2017, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2024 Fujitsu. All rights reserved.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/bitops.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +
> +/*
> + * General constants
> + */
> +
> +/* Number of counters on each PMU */
> +#define MAC_NUM_COUNTERS  8
> +/* Mask for the event type field within perf_event_attr.config and EVTYPE reg */
> +#define MAC_EVTYPE_MASK   0xFF
> +
> +/*
> + * Register offsets
> + */
> +
> +/* Perfmon registers */
> +#define MAC_PM_EVCNTR(__cntr) (0x000 + ((__cntr) & 0x7) * 8)
Perhaps a macro to extra the offset part from __cntr?
However there only seem to be 8 counters, so why is the masking needed?


> +#define MAC_PM_CNTCTL(__cntr) (0x100 + ((__cntr) & 0x7) * 8)
> +#define MAC_PM_EVTYPE(__cntr) (0x200 + ((__cntr) & 0x7) * 8)
> +#define MAC_PM_CR         0x400
> +#define MAC_PM_CNTENSET   0x410
> +#define MAC_PM_CNTENCLR   0x418
> +#define MAC_PM_INTENSET   0x420
> +#define MAC_PM_INTENCLR   0x428
> +#define MAC_PM_OVSR       0x440
> +
> +/*
> + * Bit field definitions
> + */
> +
> +/* MAC_PM_CNTCTLx */
> +#define PMCNT_RESET           (0)
> +
> +/* MAC_PM_EVTYPEx */
> +#define EVSEL(__val)          ((__val) & MAC_EVTYPE_MASK)
> +
> +/* MAC_PM_CR */
> +#define PM_RESET              (1UL << 1)
> +#define PM_ENABLE             (1UL << 0)
> +
> +/* MAC_PM_CNTENSET */
> +#define PMCNTENSET(__cntr)    (1UL << ((__cntr) & 0x7))
> +
> +/* MAC_PM_CNTENCLR */
> +#define PMCNTENCLR(__cntr)    (1UL << ((__cntr) & 0x7))
> +#define PM_CNTENCLR_RESET     (0xFF)
> +
> +/* MAC_PM_INTENSET */
> +#define PMINTENSET(__cntr)    (1UL << ((__cntr) & 0x7))
> +
> +/* MAC_PM_INTENCLR */
> +#define PMINTENCLR(__cntr)    (1UL << ((__cntr) & 0x7))
> +#define PM_INTENCLR_RESET     (0xFF)
> +
> +/* MAC_PM_OVSR */
> +#define PMOVSRCLR(__cntr)     (1UL << ((__cntr) & 0x7))
> +#define PMOVSRCLR_RESET       (0xFF)
No brackets for single value.

Can you rename these so that the register is obvious.
MAC_PM_OVSR_CLR(_) etc. Though you'd also want to add _REG
or similar to the register definitions so it is obvious those are
the addresses.


> +
> +static inline void fujitsu_mac__init(struct mac_pmu *macpmu)
> +{
> +	int i;
> +
> +	writeq_relaxed(PM_RESET, macpmu->regs + MAC_PM_CR);
> +
> +	writeq_relaxed(PM_CNTENCLR_RESET, macpmu->regs + MAC_PM_CNTENCLR);
> +	writeq_relaxed(PM_INTENCLR_RESET, macpmu->regs + MAC_PM_INTENCLR);
> +	writeq_relaxed(PMOVSRCLR_RESET, macpmu->regs + MAC_PM_OVSR);
> +
> +	for (i = 0; i < MAC_NUM_COUNTERS; ++i) {
> +		writeq_relaxed(PMCNT_RESET, macpmu->regs + MAC_PM_CNTCTL(i));
> +		writeq_relaxed(EVSEL(0), macpmu->regs + MAC_PM_EVTYPE(i));
> +	}
> +
> +	/*
> +	 * Use writeq here to ensure all programming commands are done
> +	 *  before proceeding
Odd indenting. Looks like an extra space before before.
> +	 */
> +	writeq(PM_ENABLE, macpmu->regs + MAC_PM_CR);
> +}

> +
> +static void fujitsu_mac__pmu_enable(struct pmu *pmu)
> +{
> +	struct mac_pmu *macpmu = to_mac_pmu(pmu);
> +
> +	/* Ensure the other programming commands are observed before enabling */
> +	wmb();
Unusual to do it this way rather than after the things you want to have finished.
I guess it's not wrong, but it does prevent use of writeq() 
> +
> +	writeq_relaxed(PM_ENABLE, macpmu->regs + MAC_PM_CR);
> +}
> +
> +static void fujitsu_mac__pmu_disable(struct pmu *pmu)
> +{
> +	struct mac_pmu *macpmu = to_mac_pmu(pmu);
> +
> +	writeq_relaxed(0, macpmu->regs + MAC_PM_CR);
> +
> +	/* Ensure the basic counter unit is stopped before proceeding */
> +	wmb();

Maybe just use writeq()?

> +}
> +
> +/*
> + * We must NOT create groups containing events from multiple hardware PMUs,
> + * although mixing different software and hardware PMUs is allowed.
> + */
> +static bool fujitsu_mac__validate_event_group(struct perf_event *event)
> +{
> +	struct perf_event *leader = event->group_leader;
> +	struct perf_event *sibling;
> +	int counters = 0;
> +
> +	if (leader->pmu != event->pmu && !is_software_event(leader))
> +		return false;
> +
> +	/* The sum of the counters used by the event and its leader event */
> +	counters = 2;
> +
> +	for_each_sibling_event(sibling, leader) {
> +		if (is_software_event(sibling))
> +			continue;
> +		if (sibling->pmu != event->pmu)
> +			return false;
> +		counters += 1;
> +	}
> +
> +	/*
> +	 * If the group requires more counters than the HW has, it
> +	 * cannot ever be scheduled.
> +	 */
> +	return counters <= MAC_NUM_COUNTERS;
> +}
> +
> +static int fujitsu_mac__event_init(struct perf_event *event)
> +{
> +	struct mac_pmu *macpmu = to_mac_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	/*
> +	 * Is the event for this PMU?
Single line comment syntax.
> +	 */
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/*
> +	 * Sampling not supported since these events are not core-attributable.
Probably also single line syntax (it's a bit long, so maybe multiline is appropriate here).
> +	 */
> +	if (hwc->sample_period)
> +		return -EINVAL;

> +
> +static int fujitsu_mac__event_add(struct perf_event *event, int flags)
> +{
> +	struct mac_pmu *macpmu = to_mac_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx;
> +
> +	/*
> +	 * Try to allocate a counter.
Single line comment syntax.

> +	 */
> +	idx = bitmap_find_free_region(macpmu->used_mask, MAC_NUM_COUNTERS, 0);
> +	if (idx < 0)
> +		/* The counters are all in use. */
> +		return -EAGAIN;
> +
> +	hwc->idx = idx;
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +	macpmu->events[idx] = event;
> +
> +	if (flags & PERF_EF_START)
> +		fujitsu_mac__event_start(event, 0);
> +
> +	/* Propagate changes to the userspace mapping. */
> +	perf_event_update_userpage(event);
> +
> +	return 0;
> +}
> +

> +
> +/*
> + * Add sysfs attributes
Code makes this obvious and it is standard PMU driver stuff. I'd drop this comment.
The details belong in the documentation, not here.

> + *
> + * We export:
> + * - formats, used by perf user space and other tools to configure events
> + * - events, used by perf user space and other tools to create events
> + *   symbolically, e.g.:
> + *     perf stat -a -e mac_iod0_mac0_ch0/event=0x21/ ls
> + * - cpumask, used by perf user space and other tools to know on which CPUs
> + *   to open the events
> + */
> +
> +/* formats */
> +
> +#define MAC_PMU_FORMAT_ATTR(_name, _config)				      \
> +	(&((struct dev_ext_attribute[]) {				      \
> +		{ .attr = __ATTR(_name, 0444, device_show_string, NULL),      \
> +		  .var = (void *) _config, }				      \
> +	})[0].attr.attr)
> +
> +static struct attribute *fujitsu_mac_pmu_formats[] = {
> +	MAC_PMU_FORMAT_ATTR(event, "config:0-7"),
> +	NULL,
> +};
> +
> +static const struct attribute_group fujitsu_mac_pmu_format_group = {
> +	.name = "format",
> +	.attrs = fujitsu_mac_pmu_formats,
> +};
> +
> +/* events */
Drop comment as adds little to my eyes. Same for all similar comments.
Your code is easy to read, so they are unnecessary noise.

> +
> +static ssize_t mac_pmu_event_show(struct device *dev,
> +				     struct device_attribute *attr, char *page)
> +{
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> +	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
> +}
> +
> +#define MAC_EVENT_ATTR(_name, _id)					     \
> +	PMU_EVENT_ATTR_ID(_name, mac_pmu_event_show, _id)
> +
> +static struct attribute *fujitsu_mac_pmu_events[] = {
> +	MAC_EVENT_ATTR(cycles, MAC_EVENT_CYCLES),
> +	MAC_EVENT_ATTR(read-count, MAC_EVENT_READ_COUNT),
> +	MAC_EVENT_ATTR(read-count-request, MAC_EVENT_READ_COUNT_REQUEST),
> +	MAC_EVENT_ATTR(read-count-return, MAC_EVENT_READ_COUNT_RETURN),
> +	MAC_EVENT_ATTR(read-count-request-pftgt, MAC_EVENT_READ_COUNT_REQUEST_PFTGT),
> +	MAC_EVENT_ATTR(read-count-request-normal, MAC_EVENT_READ_COUNT_REQUEST_NORMAL),
> +	MAC_EVENT_ATTR(read-count-return-pftgt-hit, MAC_EVENT_READ_COUNT_RETURN_PFTGT_HIT),
> +	MAC_EVENT_ATTR(read-count-return-pftgt-miss, MAC_EVENT_READ_COUNT_RETURN_PFTGT_MISS),
> +	MAC_EVENT_ATTR(read-wait, MAC_EVENT_READ_WAIT),
> +	MAC_EVENT_ATTR(write-count, MAC_EVENT_WRITE_COUNT),
> +	MAC_EVENT_ATTR(write-count-write, MAC_EVENT_WRITE_COUNT_WRITE),
> +	MAC_EVENT_ATTR(write-count-pwrite, MAC_EVENT_WRITE_COUNT_PWRITE),
> +	MAC_EVENT_ATTR(memory-read-count, MAC_EVENT_MEMORY_READ_COUNT),
> +	MAC_EVENT_ATTR(memory-write-count, MAC_EVENT_MEMORY_WRITE_COUNT),
> +	MAC_EVENT_ATTR(memory-pwrite-count, MAC_EVENT_MEMORY_PWRITE_COUNT),
> +	MAC_EVENT_ATTR(ea-mac, MAC_EVENT_EA_MAC),
> +	MAC_EVENT_ATTR(ea-memory, MAC_EVENT_EA_MEMORY),
> +	MAC_EVENT_ATTR(ea-memory-mac-read, MAC_EVENT_EA_MEMORY_MAC_READ),
> +	MAC_EVENT_ATTR(ea-memory-mac-write, MAC_EVENT_EA_MEMORY_MAC_WRITE),
> +	MAC_EVENT_ATTR(ea-memory-mac-pwrite, MAC_EVENT_EA_MEMORY_MAC_PWRITE),
> +	MAC_EVENT_ATTR(ea-ha, MAC_EVENT_EA_HA),
> +	NULL
> +};
> +
> +static const struct attribute_group fujitsu_mac_pmu_events_group = {
> +	.name = "events",
> +	.attrs = fujitsu_mac_pmu_events,
> +};
> +
> +/* cpumask */
Comment is obvious, so drop it in favor of brevity.
> +
> +static ssize_t cpumask_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct mac_pmu *macpmu = to_mac_pmu(dev_get_drvdata(dev));
> +
> +	return cpumap_print_to_pagebuf(true, buf, &macpmu->cpumask);
> +}
> +
> +static DEVICE_ATTR_RO(cpumask);
> +
> +static struct attribute *fujitsu_mac_pmu_cpumask_attrs[] = {
> +	&dev_attr_cpumask.attr,
> +	NULL,
No comma needed on null terminators as we will never add anything after them.
> +};
> +
> +static const struct attribute_group fujitsu_mac_pmu_cpumask_attr_group = {
> +	.attrs = fujitsu_mac_pmu_cpumask_attrs,
> +};
> +
> +/*
> + * Per PMU device attribute groups
> + */
> +static const struct attribute_group *fujitsu_mac_pmu_attr_grps[] = {
> +	&fujitsu_mac_pmu_format_group,
> +	&fujitsu_mac_pmu_events_group,
> +	&fujitsu_mac_pmu_cpumask_attr_group,
> +	NULL,
No comma needed on null terminators.
> +};
> +
> +/*
> + * Probing functions and data.
> + */
Structural comments like this rarely bring real value and tend to end up
wrong as code evolves. I'd drop them all now the code is written.

> +
> +static int fujitsu_mac_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct mac_pmu *macpmu = hlist_entry_safe(node, struct mac_pmu, node);
> +
> +	/* If there is not a CPU/PMU association pick this CPU */
> +	if (cpumask_empty(&macpmu->cpumask))
> +		cpumask_set_cpu(cpu, &macpmu->cpumask);
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
> +		return 0;
blank line - to help readability a little.
> +	target = cpumask_any_but(cpu_online_mask, cpu);
> +	if (target >= nr_cpu_ids)
> +		return 0;
blank line
> +	perf_pmu_migrate_context(&macpmu->pmu, cpu, target);
> +	cpumask_set_cpu(target, &macpmu->cpumask);
blank line.

> +	return 0;
> +}
> +
> +static int fujitsu_mac_pmu_probe(struct platform_device *pdev)
> +{
> +	struct mac_pmu *macpmu;
> +	struct acpi_device *acpi_dev;
> +	struct resource *memrc;
> +	int ret;
> +	char *name;
> +	u64 uid;
I'd pick an ordering and use it consistently.
Perhaps reverse xmas tree.

> +
> +	/* Initialize the PMU data structures */

This comment is a bit vague and not clearly associated with the
code I would drop it as adding insufficient value.

> +
> +	acpi_dev = ACPI_COMPANION(&pdev->dev);
> +	if (!acpi_dev)
> +		return -ENODEV;
> +
> +	ret = acpi_dev_uid_to_integer(acpi_dev, &uid);
> +	if (ret) {
> +		dev_err(&pdev->dev, "unable to read ACPI uid\n");

Probably nicer to use
		return dev_err_probe(&pdev->dev, ret, "....)
Consider a local
	struct device *dev = &pdev->dev;
as reasonable number of users in here.


> +		return ret;
> +	}
> +
> +	macpmu = devm_kzalloc(&pdev->dev, sizeof(*macpmu), GFP_KERNEL);
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "mac_iod%llu_mac%llu_ch%llu",
> +			  (uid >> 8) & 0xF, (uid >> 4) & 0xF, uid & 0xF);
> +	if (!macpmu || !name)
> +		return -ENOMEM;

Whilst valid, it is neater to just do two separate checks. Also makes
the code more resilient to future reorganizations introducing bugs.


> +
> +	macpmu->pmu = (struct pmu) {
> +		.parent		= &pdev->dev,
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
> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> +	};
> +
> +	macpmu->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &memrc);
> +	if (IS_ERR(macpmu->regs))
> +		return PTR_ERR(macpmu->regs);
> +
> +	fujitsu_mac__init(macpmu);

Why the double underscore?  That is fairly unusual syntax.


> +
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret <= 0)
> +		return ret;
> +
> +	ret = devm_request_irq(&pdev->dev, ret, fujitsu_mac__handle_irq, 0,
> +			       name, macpmu);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Request for IRQ failed for slice @%pa\n",
> +			&memrc->start);
> +		return ret;
reutrn dev_err_probe() 
> +	}
> +
> +	/* Add this instance to the list used by the offline callback */
> +	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_FUJITSU_MAC_ONLINE, &macpmu->node);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Error %d registering hotplug", ret);
> +		return ret;
return dev_err_probe()

> +	}
> +
> +	ret = perf_pmu_register(&macpmu->pmu, name, -1);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to register MAC PMU (%d)\n", ret);
return dev_err_probe()
> +		return ret;
> +	}
> +
> +	dev_info(&pdev->dev, "Registered %s, type: %d\n", name, macpmu->pmu.type);
Too noisy for the kernel log when this can be easily established anyway.
dev_dbg() at most.

> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id fujitsu_mac_pmu_acpi_match[] = {
> +	{ "FUJI200C", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, fujitsu_mac_pmu_acpi_match);
> +
> +static struct platform_driver fujitsu_mac_pmu_driver = {
> +	.driver = {
> +		.name = "fujitsu-mac-pmu",
> +		.acpi_match_table = ACPI_PTR(fujitsu_mac_pmu_acpi_match),

Drop the ACPI_PTR()  It saves very little space and
if you do use it you should guard the relevant data with ifdefs

> +		.suppress_bind_attrs = true,
> +	},
> +	.probe = fujitsu_mac_pmu_probe,
> +};
> +
> +static int __init register_fujitsu_mac_pmu_driver(void)
> +{
> +	int ret;
> +
> +	/* Install a hook to update the reader CPU in case it goes offline */
> +	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_FUJITSU_MAC_ONLINE,
> +				      "perf/fujitsu/mac:online",
> +				      fujitsu_mac_pmu_online_cpu,
> +				      fujitsu_mac_pmu_offline_cpu);
> +	if (ret)
> +		return ret;
> +
> +	return platform_driver_register(&fujitsu_mac_pmu_driver);
> +}
> +device_initcall(register_fujitsu_mac_pmu_driver);
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 2361ed4d2b15..e6e49e09488a 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -227,6 +227,7 @@ enum cpuhp_state {
>  	CPUHP_AP_PERF_ARM_APM_XGENE_ONLINE,
>  	CPUHP_AP_PERF_ARM_CAVIUM_TX2_UNCORE_ONLINE,
>  	CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
> +	CPUHP_AP_PERF_ARM_FUJITSU_MAC_ONLINE,

Can this use CPU_AP_ONLINE_DYN
or are there some ordering contraints?

>  	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
>  	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
>  	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,


