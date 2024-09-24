Return-Path: <linux-kernel+bounces-337415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2705F9849CE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59798284DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB1C1AB6F4;
	Tue, 24 Sep 2024 16:40:54 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E151AAE0D
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727196054; cv=none; b=NyWUJhGQz4rs+P9Rt79XMgfXvT6tpdLrWCRqAWoWbIrD1hiPpxsLIFaF7+9fUCsySxldEjB4K0uqZcobT5Iff6QgWGvtHk591a4YanNGePcSLYmDLfZBN0FY9hQj18zExc76B+j8nLgBynRr7v5VGwa2ygfB2CSKzBQo2VGdMAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727196054; c=relaxed/simple;
	bh=eqmOGMQRVtWIYluqhXcdHzrBfzLr8lW9oWtQeMCeU7Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7EcI+1Ot74B2Bb79azRlDrmZufNZuVy28UMRX9lev/+/2Sgk4nzMNbHpbQGzmGZtbzZpmudFXt8t3hkL+L8w1PiXuyeSm78HpX5H1Ya5Jp673Ban5ptFeXLIJz1qFmAWyxw1ip9B4y1nqDDL+32LWyIt9EspUf5K3YITCLDh0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XClr35b8vz6L75c;
	Wed, 25 Sep 2024 00:36:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 872211400D4;
	Wed, 25 Sep 2024 00:40:48 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Sep
 2024 18:40:48 +0200
Date: Tue, 24 Sep 2024 17:40:46 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<andrew@lunn.ch>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
	<gcherian@marvell.com>
Subject: Re: [PATCH v8] perf/marvell: Marvell PEM performance monitor
 support
Message-ID: <20240924174046.0000242d@Huawei.com>
In-Reply-To: <20240924063126.460219-1-gthiagarajan@marvell.com>
References: <20240924063126.460219-1-gthiagarajan@marvell.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 24 Sep 2024 12:01:26 +0530
Gowthami Thiagarajan <gthiagarajan@marvell.com> wrote:

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

A few quick comments inline from a superficial look.

Jonathan


> diff --git a/drivers/perf/marvell_pem_pmu.c b/drivers/perf/marvell_pem_pmu.c
> new file mode 100644
> index 000000000000..d3aca94278fb
> --- /dev/null
> +++ b/drivers/perf/marvell_pem_pmu.c
> @@ -0,0 +1,427 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Marvell PEM(PCIe RC) Performance Monitor Driver
> + *
> + * Copyright (C) 2024 Marvell.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +
> +/*
> + * Each of these events maps to a free running 64 bit counter
> + * with no event control, but can be reset.
> + *

This blank line adds nothing. I'd drop it.

> + */
> +enum pem_events {
> +	IB_TLP_NPR,
> +	IB_TLP_PR,
> +	IB_TLP_CPL,
> +	IB_TLP_DWORDS_NPR,
> +	IB_TLP_DWORDS_PR,
> +	IB_TLP_DWORDS_CPL,
> +	IB_INFLIGHT,
> +	IB_READS,
> +	IB_REQ_NO_RO_NCB,
> +	IB_REQ_NO_RO_EBUS,
> +	OB_TLP_NPR,
> +	OB_TLP_PR,
> +	OB_TLP_CPL,
> +	OB_TLP_DWORDS_NPR,
> +	OB_TLP_DWORDS_PR,
> +	OB_TLP_DWORDS_CPL,
> +	OB_INFLIGHT,
> +	OB_READS,
> +	OB_MERGES_NPR,
> +	OB_MERGES_PR,
> +	OB_MERGES_CPL,
> +	ATS_TRANS,
> +	ATS_TRANS_LATENCY,
> +	ATS_PRI,
> +	ATS_PRI_LATENCY,
> +	ATS_INV,
> +	ATS_INV_LATENCY,
> +	PEM_EVENTIDS_MAX,

A comma after a MAX entry rarely makes sense. I'd drop it.

> +};



> +static int pem_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct pem_pmu *pmu = hlist_entry_safe(node, struct pem_pmu,
> +					       node);

Why wrap? It's under 80 chars anyway.

> +	unsigned int target;
> +
> +	if (cpu != pmu->cpu)
> +		return 0;
> +
> +	target = cpumask_any_but(cpu_online_mask, cpu);
> +	if (target >= nr_cpu_ids)
> +		return 0;
> +
> +	perf_pmu_migrate_context(&pmu->pmu, cpu, target);
> +	pmu->cpu = target;
> +	return 0;
> +}

> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id pem_pmu_acpi_match[] = {
> +	{"MRVL000E", 0},
> +	{},

No need for trailing comma.

> +};
> +MODULE_DEVICE_TABLE(acpi, pem_pmu_acpi_match);
> +#endif
> +
> +static struct platform_driver pem_pmu_driver = {
> +	.driver	= {
> +		.name   = "pem-pmu",
> +		.acpi_match_table = ACPI_PTR(pem_pmu_acpi_match),

Drop the ACPI_PTR() protection and the ifdefs.

They provide very little advantage and hurt readabilty.
Maybe make sense if the driver supports dt binding but this
one doesn't.

> +		.suppress_bind_attrs = true,
> +	},
> +	.probe		= pem_perf_probe,
> +	.remove		= pem_perf_remove,
> +};

> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 9316c39260e0..254491a6d09b 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -228,6 +228,7 @@ enum cpuhp_state {
>  	CPUHP_AP_PERF_ARM_APM_XGENE_ONLINE,
>  	CPUHP_AP_PERF_ARM_CAVIUM_TX2_UNCORE_ONLINE,
>  	CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE,
> +	CPUHP_AP_PERF_ARM_MRVL_PEM_ONLINE,

Silly question but which of the rules at: 
https://elixir.bootlin.com/linux/v6.11/source/include/linux/cpuhotplug.h#L45
means this can't use CPUHP_AP_ONLINE_DYN?

Quite a few recent PMU drivers have used that without issues.

>  	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
>  	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
>  	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,


