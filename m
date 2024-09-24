Return-Path: <linux-kernel+bounces-337395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A8E984979
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687C51F23D7C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F4F1AB6C8;
	Tue, 24 Sep 2024 16:23:39 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71463D531
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195018; cv=none; b=PQi0FrnPEMmyFXyznEmZ7VH/vClOUcPcOSiym0i5cuLD00ToQrJf1NSVMEZ+Oix95T4reJetjLCiC+FnwUD5fqvtIumxYlxKyuRkKyQOmL8sWvE8HaP8HBWptnojeocWhyEaNAJ8NX8X3oIXzvQxqEruNofImUiIjZOMmq9K6/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195018; c=relaxed/simple;
	bh=PU1C68dR+Svv47SRfIYvHCigCnTReyobSSJfACd15Bk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGYH6CQecpnaJ5NiZ4OrnGD4IMmPzptsYaOMaeHhdgvE/ik8tiKGJ5VmO2T4i+McdUbGSQ6aiLBquqcp6kY3EYbwhqN9cAwxN7GezhxVxFfj6nLvkX4mUPQo3ZoIDAE48kKEV81+p4HX4D6hhqbCEa6/nM7hd2UuCdAzbJUiYWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XClRR3jvsz6K5qp;
	Wed, 25 Sep 2024 00:18:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3088A1400D4;
	Wed, 25 Sep 2024 00:23:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Sep
 2024 18:23:33 +0200
Date: Tue, 24 Sep 2024 17:23:32 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<gcherian@marvell.com>, <bbhushan2@marvell.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v8 3/6] perf/marvell: Refactor to add version - no
 functional change
Message-ID: <20240924172332.00003dbf@Huawei.com>
In-Reply-To: <20240919074717.3276854-4-gthiagarajan@marvell.com>
References: <20240919074717.3276854-1-gthiagarajan@marvell.com>
	<20240919074717.3276854-4-gthiagarajan@marvell.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 19 Sep 2024 13:17:14 +0530
Gowthami Thiagarajan <gthiagarajan@marvell.com> wrote:

> This change is aimed at improving the maintainability of the code and
> laying the groundwork for versioning within the driver.
> 
> No functional changes are introduced in this commit; the driver's
> behavior and performance remain unchanged.
> 
> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>

Versioning like this tends to scale badly as more versions turn up.
Can you just use more data in your pdata instead?
A template of the struct pmu that you copy and a callback for necessary
init that is version specific.

> ---
>  drivers/perf/marvell_cn10k_ddr_pmu.c | 63 ++++++++++++++++++----------
>  1 file changed, 42 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
> index 648ad3a740bf..65422fd5ddd2 100644
> --- a/drivers/perf/marvell_cn10k_ddr_pmu.c
> +++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
> @@ -124,10 +124,19 @@
>  #define CN10K_DDRC_PERF_CNT_VALUE_WR_OP		0x80D0
>  #define CN10K_DDRC_PERF_CNT_VALUE_RD_OP		0x80D8
>  
> +enum mrvl_ddr_pmu_version {
> +	DDR_PMU_V1 = 1,
> +};
> +
> +struct ddr_pmu_data {
> +	int id;
I don't see the point in this. Use the pdata structure
for this purpose and push anything else necessary into there.
Don't have an ID. That scales very badly as more device
types turn up over time.

> +};
> +
>  struct cn10k_ddr_pmu {
>  	struct pmu pmu;
>  	void __iomem *base;
>  	const struct ddr_pmu_platform_data *p_data;
> +	int version;
>  	unsigned int cpu;
>  	struct	device *dev;
>  	int active_events;
> @@ -738,12 +747,19 @@ static const struct ddr_pmu_platform_data cn10k_ddr_pmu_pdata = {
>  	.ops = &ddr_pmu_ops,
>  };
>  
> +#if defined(CONFIG_ACPI) || defined(CONFIG_OF)
> +static const struct ddr_pmu_data ddr_pmu_data = {
> +	.id   = DDR_PMU_V1,
> +};
> +#endif
> +
>  static int cn10k_ddr_perf_probe(struct platform_device *pdev)
>  {
>  	const struct ddr_pmu_data *dev_data;
>  	struct cn10k_ddr_pmu *ddr_pmu;
>  	struct resource *res;
>  	void __iomem *base;
> +	int version;
>  	char *name;
>  	int ret;
>  
> @@ -760,31 +776,36 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	version = dev_data->id;
> +	ddr_pmu->version = version;
> +
>  	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
>  	ddr_pmu->base = base;
>  
> -	ddr_pmu->p_data = &cn10k_ddr_pmu_pdata;
> -	/* Setup the PMU counter to work in manual mode */
> -	writeq_relaxed(OP_MODE_CTRL_VAL_MANUAL, ddr_pmu->base +
> -		       ddr_pmu->p_data->ddrc_perf_cnt_op_mode_ctrl);
> -
> -	ddr_pmu->pmu = (struct pmu) {
> -		.module	      = THIS_MODULE,
> -		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
> -		.task_ctx_nr = perf_invalid_context,
> -		.attr_groups = cn10k_attr_groups,
> -		.event_init  = cn10k_ddr_perf_event_init,
> -		.add	     = cn10k_ddr_perf_event_add,
> -		.del	     = cn10k_ddr_perf_event_del,
> -		.start	     = cn10k_ddr_perf_event_start,
> -		.stop	     = cn10k_ddr_perf_event_stop,
> -		.read	     = cn10k_ddr_perf_event_update,
> -		.pmu_enable  = cn10k_ddr_perf_pmu_enable,
> -		.pmu_disable = cn10k_ddr_perf_pmu_disable,
> -	};
> +	if (version == DDR_PMU_V1) {
> +		ddr_pmu->p_data = &cn10k_ddr_pmu_pdata;
> +		/* Setup the PMU counter to work in manual mode */
> +		writeq_relaxed(OP_MODE_CTRL_VAL_MANUAL, ddr_pmu->base +
> +			       ddr_pmu->p_data->ddrc_perf_cnt_op_mode_ctrl);
> +
> +		ddr_pmu->pmu = (struct pmu) {
> +			.module	      = THIS_MODULE,
> +			.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
> +			.task_ctx_nr = perf_invalid_context,
> +			.attr_groups = cn10k_attr_groups,
> +			.event_init  = cn10k_ddr_perf_event_init,
> +			.add	     = cn10k_ddr_perf_event_add,
> +			.del	     = cn10k_ddr_perf_event_del,
> +			.start	     = cn10k_ddr_perf_event_start,
> +			.stop	     = cn10k_ddr_perf_event_stop,
> +			.read	     = cn10k_ddr_perf_event_update,
> +			.pmu_enable  = cn10k_ddr_perf_pmu_enable,
> +			.pmu_disable = cn10k_ddr_perf_pmu_disable,
> +		};
> +	}
>  
>  	/* Choose this cpu to collect perf data */
>  	ddr_pmu->cpu = raw_smp_processor_id();
> @@ -827,7 +848,7 @@ static void cn10k_ddr_perf_remove(struct platform_device *pdev)
>  
>  #ifdef CONFIG_OF
>  static const struct of_device_id cn10k_ddr_pmu_of_match[] = {
> -	{ .compatible = "marvell,cn10k-ddr-pmu", },
> +	{ .compatible = "marvell,cn10k-ddr-pmu", .data = &ddr_pmu_data},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
> @@ -835,7 +856,7 @@ MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
>  
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id cn10k_ddr_pmu_acpi_match[] = {
> -	{"MRVL000A", 0},
> +	{"MRVL000A", (kernel_ulong_t)&ddr_pmu_data},

Use the pdata itself for this, not a structure just used to get an ID
to then look it up in code.

>  	{},
>  };
>  MODULE_DEVICE_TABLE(acpi, cn10k_ddr_pmu_acpi_match);


