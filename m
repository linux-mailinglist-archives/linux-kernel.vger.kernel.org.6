Return-Path: <linux-kernel+bounces-288340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E109538FF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D962F1C21CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF331B9B4A;
	Thu, 15 Aug 2024 17:28:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC461AED29
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742911; cv=none; b=FhJnCplzl0i0HxBX1mnZ4lgB8G3/BC9JQ/eKgPQh6TKq7guwQL/O+96DVKzFJqY1chxVkh5f6O3RkEjvoyC1jWqR3uKafhHMdvfAPc7axhdbufKVMrzSwy0SPJ5sn93+gXY+Iqp0A3QZ8R2IRKeS3Qy00pLgf7MHwFrTrBkAOrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742911; c=relaxed/simple;
	bh=KXgwoNqpesCfVAoLOUz/G9HsgL43Fr6/HA7IU1L+jgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAtWmsJKrEdCuJDl7kvB3DzV7LJNebMm4+8Xca048sZbPusUXINnN/6uAaUjuRa6p7nTYGOOMykV7+YSj/HmRFOE9BKfUEoobSboZYgsqz2lb69ukbsJmOQmZI9t25Rgv6Sf6MOEIEmpHJjxvCHc986O0KdZne0cfavZmhduRN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D7CC14BF;
	Thu, 15 Aug 2024 10:28:54 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E07443F58B;
	Thu, 15 Aug 2024 10:28:26 -0700 (PDT)
Date: Thu, 15 Aug 2024 18:28:23 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	lcherian@marvell.com, gcherian@marvell.com
Subject: Re: [PATCH v6] perf/marvell: Marvell PEM performance monitor support
Message-ID: <Zr46t-JO7KPXCrn2@J2N7QTR9R3.cambridge.arm.com>
References: <20240801142917.2875300-1-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801142917.2875300-1-gthiagarajan@marvell.com>

On Thu, Aug 01, 2024 at 07:59:17PM +0530, Gowthami Thiagarajan wrote:
> PCI Express Interface PMU includes various performance counters
> to monitor the data that is transmitted over the PCIe link. The
> counters track various inbound and outbound transactions which
> includes separate counters for posted/non-posted/completion TLPs.
> Also, inbound and outbound memory read requests along with their
> latencies can also be monitored. Address Translation Services(ATS)events
> such as ATS Translation, ATS Page Request, ATS Invalidation along with
> their corresponding latencies are also supported.
> 
> The performance counters are 64 bits wide.
> 
> For instance,
> perf stat -e ib_tlp_pr <workload>
> tracks the inbound posted TLPs for the workload.
> 
> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> ---

> +static int pem_perf_event_init(struct perf_event *event)
> +{
> +	struct pem_pmu *pmu = to_pem_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	if (is_sampling_event(event) ||
> +	    event->attach_state & PERF_ATTACH_TASK) {
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (event->cpu < 0)
> +		return -EOPNOTSUPP;
> +
> +	/*  We must NOT create groups containing mixed PMUs */
> +	if (event->group_leader->pmu != event->pmu &&
> +	    !is_software_event(event->group_leader))
> +		return -EINVAL;
> +

This should check the entire group and should check for cross-event
conflicts or where the entire group is too large to fit into the
(maximum possible) potential set of counters.

Below in pem_perf_event_start() you reset the HW counter when starting
an event, so multiple events *must not* share the same HW counter; they
will clobber each other and events will be lost, leading to incorrect
results.

Either you need to track counter allocations, or you need to handle the
counters as free-running and *never* reset/reprogram them.

I also don't see any logic to start/stop the entire PMU, which really
means you don't support group semantics at all, and should reject groups
with more than 1 non-SW event, since the events are counting for
different times anyway.

> +	/*
> +	 * Set ownership of event to one CPU, same event can not be observed
> +	 * on multiple cpus at same time.
> +	 */
> +	event->cpu = pmu->cpu;
> +	hwc->idx = -1;
> +	return 0;
> +}
> +
> +static void pem_perf_counter_reset(struct pem_pmu *pmu,
> +				   struct perf_event *event, int eventid)
> +{
> +	writeq_relaxed(0x0, pmu->base + eventid_to_offset(eventid));
> +}
> +
> +static u64 pem_perf_read_counter(struct pem_pmu *pmu,
> +				 struct perf_event *event, int eventid)
> +{
> +	return readq_relaxed(pmu->base + eventid_to_offset(eventid));
> +}
> +
> +static void pem_perf_event_update(struct perf_event *event)
> +{
> +	struct pem_pmu *pmu = to_pem_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 prev_count, new_count;
> +
> +	do {
> +		prev_count = local64_read(&hwc->prev_count);
> +		new_count = pem_perf_read_counter(pmu, event, hwc->idx);
> +	} while (local64_xchg(&hwc->prev_count, new_count) != prev_count);
> +
> +	local64_add((new_count - prev_count), &event->count);
> +}
> +
> +static void pem_perf_event_start(struct perf_event *event, int flags)
> +{
> +	struct pem_pmu *pmu = to_pem_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int eventid = hwc->idx;
> +
> +	local64_set(&hwc->prev_count, 0);
> +
> +	pem_perf_counter_reset(pmu, event, eventid);
> +
> +	hwc->state = 0;
> +}
> +
> +static int pem_perf_event_add(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	hwc->idx = event->attr.config;

As above, this will go wrong when two events have the same
event->attr.config, regardless of whther those events are in the same
group or not.

Either

(a) Track which counters are currently allocated, and reject an event
    targetting an already-allocated counter here.

(b) Treat all HW counters as free-running and never reset/reprogam them.
    In pem_perf_event_start() you'd need to read the *current* value of
    the HW counter and set this in &hwc->prev_count.

> +	if (hwc->idx >= PEM_EVENTIDS_MAX)
> +		return -EINVAL;

This should have been rejected at event_init() time. If that's violated
here it should result in a warning.

> +	hwc->state |= PERF_HES_STOPPED;
> +
> +	if (flags & PERF_EF_START)
> +		pem_perf_event_start(event, flags);
> +
> +	return 0;
> +}

[...]

> +static int pem_perf_probe(struct platform_device *pdev)
> +{
> +	struct pem_pmu *pem_pmu;
> +	struct resource *res;
> +	void __iomem *base;
> +	char *name;
> +	int ret;
> +
> +	pem_pmu = devm_kzalloc(&pdev->dev, sizeof(*pem_pmu), GFP_KERNEL);
> +	if (!pem_pmu)
> +		return -ENOMEM;
> +
> +	pem_pmu->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, pem_pmu);
> +
> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	pem_pmu->base = base;
> +
> +	pem_pmu->pmu = (struct pmu) {
> +		.module	      = THIS_MODULE,
> +		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
> +		.task_ctx_nr = perf_invalid_context,
> +		.attr_groups = pem_perf_attr_groups,
> +		.event_init  = pem_perf_event_init,
> +		.add	     = pem_perf_event_add,
> +		.del	     = pem_perf_event_del,
> +		.start	     = pem_perf_event_start,
> +		.stop	     = pem_perf_event_stop,
> +		.read	     = pem_perf_event_update,
> +	};
> +
> +	/* Choose this cpu to collect perf data */
> +	pem_pmu->cpu = raw_smp_processor_id();
> +
> +	name = devm_kasprintf(pem_pmu->dev, GFP_KERNEL, "mrvl_pcie_rc_pmu_%llx",
> +			      res->start);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	cpuhp_state_add_instance_nocalls
> +			(CPUHP_AP_PERF_ARM_MARVELL_PEM_ONLINE,
> +			 &pem_pmu->node);

Nit: weird formatting: the opening '(' for a function call should not be
on a new line.

Mark.

