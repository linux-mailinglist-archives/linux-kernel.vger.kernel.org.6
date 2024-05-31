Return-Path: <linux-kernel+bounces-196656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DF38D5F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2944289AB3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852891509A8;
	Fri, 31 May 2024 10:16:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338A717554;
	Fri, 31 May 2024 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717150606; cv=none; b=OUPwDuLew9o1+uKuO2OPOW2eyDjy7auoWENHKLpRaCgXi0vzRlszFG9MuPl2qe0nuNSQvKscPfbsnXqAImEj5oVpuN+eSIlzCb2YX/fWe+z2vH8eFYjtDWBSTw4mLZ36Csp3/pKN/K13mgBbLiY4t3zqMLYOWv2LO04iKZPb45o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717150606; c=relaxed/simple;
	bh=AIObPOZx7nzq8Q3UV9pNL1Xx3nnSw2LjxaGGQvQiCk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GnfnpXEYSwqYlpgiYIbPTIO35oJVadFx2FvF1hxqxDUivTq71IAV8aqF9KJ1573JK8fozLHQEMvrYFnsokQFw9X3NJA5qgrmWT6LG++DiGxWQb0RFsfRSXgq5yIKzJXd9TROIpSvyzTTJDNnFsIJjj1l/dadeKvozZhUWSxi1dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C68DE1424;
	Fri, 31 May 2024 03:17:08 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 171BB3F641;
	Fri, 31 May 2024 03:16:42 -0700 (PDT)
Message-ID: <1a093631-ded2-4ef3-b72c-3aaffd1b0739@arm.com>
Date: Fri, 31 May 2024 11:16:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/7] coresight: tmc: Stop trace capture on FlIn
To: Linu Cherian <lcherian@marvell.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com,
 suzuki.poulose@arm.com, mike.leach@linaro.org
References: <20240531042745.494222-1-lcherian@marvell.com>
 <20240531042745.494222-7-lcherian@marvell.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240531042745.494222-7-lcherian@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 31/05/2024 05:27, Linu Cherian wrote:
> Configure TMC ETR and ETF to flush and stop trace capture
> on FlIn event based on sysfs attribute,
> /sys/bus/coresight/devices/tmc_etXn/stop_on_flush.
> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
> Changelog from v7:
> * Honour stop_on_flush sysfs attribute for perf sessions as well.
>   This allows user to start trace sessions using perf method as 
>   well to use the Coresight kernel panic support.
> 
>  .../hwtracing/coresight/coresight-tmc-core.c  | 31 +++++++++++++++++++
>  .../hwtracing/coresight/coresight-tmc-etf.c   | 18 ++++++++---
>  .../hwtracing/coresight/coresight-tmc-etr.c   | 18 ++++++++---
>  drivers/hwtracing/coresight/coresight-tmc.h   |  4 +++
>  4 files changed, 61 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index aaa9de9f4cd2..24edd9d750c3 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -452,9 +452,40 @@ static ssize_t buffer_size_store(struct device *dev,
>  
>  static DEVICE_ATTR_RW(buffer_size);
>  
> +static ssize_t stop_on_flush_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sprintf(buf, "%#x\n", drvdata->stop_on_flush);
> +}
> +
> +static ssize_t stop_on_flush_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t size)
> +{
> +	int ret;
> +	u8 val;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	ret = kstrtou8(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +	if (val)
> +		drvdata->stop_on_flush = true;
> +	else
> +		drvdata->stop_on_flush = false;
> +
> +	return size;
> +}
> +
> +static DEVICE_ATTR_RW(stop_on_flush);
> +
> +
>  static struct attribute *coresight_tmc_attrs[] = {
>  	&dev_attr_trigger_cntr.attr,
>  	&dev_attr_buffer_size.attr,
> +	&dev_attr_stop_on_flush.attr,
>  	NULL,
>  };
>  
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 655c0c0ba54b..1529b9cc210a 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -19,6 +19,7 @@ static int tmc_set_etf_buffer(struct coresight_device *csdev,
>  static int __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>  {
>  	int rc = 0;
> +	u32 ffcr;
>  
>  	CS_UNLOCK(drvdata->base);
>  
> @@ -32,10 +33,12 @@ static int __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>  	}
>  
>  	writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
> -	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
> -		       TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
> -		       TMC_FFCR_TRIGON_TRIGIN,
> -		       drvdata->base + TMC_FFCR);
> +
> +	ffcr = TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI | TMC_FFCR_FON_FLIN |
> +		TMC_FFCR_FON_TRIG_EVT | TMC_FFCR_TRIGON_TRIGIN;
> +	if (drvdata->stop_on_flush_en)
> +		ffcr |= TMC_FFCR_STOP_ON_FLUSH;
> +	writel_relaxed(ffcr, drvdata->base + TMC_FFCR);
>  
>  	writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
>  	tmc_enable_hw(drvdata);
> @@ -225,7 +228,8 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
>  		used = true;
>  		drvdata->buf = buf;
>  	}
> -
> +	if (drvdata->stop_on_flush)
> +		drvdata->stop_on_flush_en = true;

Does this do anything different than only using stop_on_flush in
__tmc_etr_enable_hw()?

Seems like stop_on_flush_en == stop_on_flush whenever stop_on_flush_en
is read, so you might as well just read stop_on_flush and get rid of the
_en copy?

>  	ret = tmc_etb_enable_hw(drvdata);
>  	if (!ret) {
>  		coresight_set_mode(csdev, CS_MODE_SYSFS);
> @@ -288,6 +292,8 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
>  			break;
>  		}
>  
> +		if (drvdata->stop_on_flush)
> +			drvdata->stop_on_flush_en = true;
>  		ret  = tmc_etb_enable_hw(drvdata);
>  		if (!ret) {
>  			/* Associate with monitored process. */
> @@ -349,6 +355,8 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
>  	tmc_etb_disable_hw(drvdata);
>  	/* Dissociate from monitored process. */
>  	drvdata->pid = -1;
> +	/* Reset stop on flush */
> +	drvdata->stop_on_flush_en = false;
>  	coresight_set_mode(csdev, CS_MODE_DISABLED);
>  
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 74f53972ce3c..bf2d0932e205 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1059,7 +1059,7 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
>  
>  static int __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>  {
> -	u32 axictl, sts;
> +	u32 axictl, sts, ffcr;
>  	struct etr_buf *etr_buf = drvdata->etr_buf;
>  	int rc = 0;
>  
> @@ -1105,10 +1105,12 @@ static int __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>  		writel_relaxed(sts, drvdata->base + TMC_STS);
>  	}
>  
> -	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
> -		       TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
> -		       TMC_FFCR_TRIGON_TRIGIN,
> -		       drvdata->base + TMC_FFCR);
> +	ffcr = TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI | TMC_FFCR_FON_FLIN |
> +		TMC_FFCR_FON_TRIG_EVT | TMC_FFCR_TRIGON_TRIGIN;
> +	if (drvdata->stop_on_flush_en)
> +		ffcr |= TMC_FFCR_STOP_ON_FLUSH;
> +	writel_relaxed(ffcr, drvdata->base + TMC_FFCR);
> +
>  	writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
>  	tmc_enable_hw(drvdata);
>  
> @@ -1313,6 +1315,8 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>  		goto out;
>  	}
>  
> +	if (drvdata->stop_on_flush)
> +		drvdata->stop_on_flush_en = true;
>  	ret = tmc_etr_enable_hw(drvdata, sysfs_buf);
>  	if (!ret) {
>  		coresight_set_mode(csdev, CS_MODE_SYSFS);
> @@ -1758,6 +1762,8 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
>  		goto unlock_out;
>  	}
>  
> +	if (drvdata->stop_on_flush)
> +		drvdata->stop_on_flush_en = true;
>  	rc = tmc_etr_enable_hw(drvdata, etr_perf->etr_buf);
>  	if (!rc) {
>  		/* Associate with monitored process. */
> @@ -1808,6 +1814,8 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
>  	tmc_etr_disable_hw(drvdata);
>  	/* Dissociate from monitored process. */
>  	drvdata->pid = -1;
> +	/* Reset stop on flush */
> +	drvdata->stop_on_flush_en = false;
>  	coresight_set_mode(csdev, CS_MODE_DISABLED);
>  	/* Reset perf specific data */
>  	drvdata->perf_buf = NULL;
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 528174283ecc..81eadb384b83 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -205,6 +205,8 @@ struct tmc_resrv_buf {
>   * @spinlock:	only one at a time pls.
>   * @pid:	Process ID of the process being monitored by the session
>   *		that is using this component.
> + * @stop_on_flush: Stop on flush trigger user configuration.
> + * @stop_on_flush_en: Stop on flush enable flag
>   * @buf:	Snapshot of the trace data for ETF/ETB.
>   * @etr_buf:	details of buffer used in TMC-ETR
>   * @len:	size of the available trace for ETF/ETB.
> @@ -238,6 +240,8 @@ struct tmc_drvdata {
>  	spinlock_t		spinlock;
>  	pid_t			pid;
>  	bool			reading;
> +	bool			stop_on_flush;
> +	bool			stop_on_flush_en;
>  	union {
>  		char		*buf;		/* TMC ETB */
>  		struct etr_buf	*etr_buf;	/* TMC ETR */

