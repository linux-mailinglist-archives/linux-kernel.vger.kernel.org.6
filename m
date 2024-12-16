Return-Path: <linux-kernel+bounces-447078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5509F2D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C71F1881EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63193200BB9;
	Mon, 16 Dec 2024 09:33:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EDA1FF60C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734341636; cv=none; b=Fvccd2aFrXEx0b1I+NY+rCO8orZ0BXW020d9v/9v0HtzX4MHY3fIBQ+kc2EH4OldMUKJgVIAmmmmqMrUqtOIKrc74Zq+lDofK56uYrZYdA4IUsKtfWsPzRhJD0WAxcKOZGIYgslnTaW2ZB8dj46yfqhPh/+Ty1GbJ74Hz6vjzaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734341636; c=relaxed/simple;
	bh=+FqZE43mi8DGXu/yjPeU7O2ZB7l+FSol0pHD7PhX0Os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZ7fgg1cpCj0EZKvGnWbO92UwTSvYF9nrNGevYWBEmP0KBf37o14KlaHTZIg36AnXd7JoMk4pzleiW8tb3D8ZWnlFng2+OuZS17adWOvTMBSd7w0CUKWjQYNoNpbCOW3PwaL+cp9E8ybmQXcHb8VFyjTRQG3ObvVL60mhc5I/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53170113E;
	Mon, 16 Dec 2024 01:34:21 -0800 (PST)
Received: from [10.57.71.247] (unknown [10.57.71.247])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B7203F720;
	Mon, 16 Dec 2024 01:33:52 -0800 (PST)
Message-ID: <9094b068-ed3a-444d-b790-e43a652ab6e9@arm.com>
Date: Mon, 16 Dec 2024 09:33:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] coresight: tmc: Update error logging in tmc common
 functions
Content-Language: en-GB
To: Mike Leach <mike.leach@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc: james.clark@linaro.org, alexander.shishkin@linux.intel.com
References: <20241213144919.110642-1-mike.leach@linaro.org>
 <20241213144919.110642-3-mike.leach@linaro.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20241213144919.110642-3-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/12/2024 14:49, Mike Leach wrote:
> Enhance the error logging in the tmc_wait_for_tmcready() and
> tmc_flush_and_stop() to print key tmc  register values on error
> conditions to improve hardware debug information.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   .../hwtracing/coresight/coresight-tmc-core.c  | 37 +++++++++++++++----
>   drivers/hwtracing/coresight/coresight-tmc.h   |  2 +-
>   2 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index e9876252a789..1a9299adae93 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -34,25 +34,36 @@ DEFINE_CORESIGHT_DEVLIST(etb_devs, "tmc_etb");
>   DEFINE_CORESIGHT_DEVLIST(etf_devs, "tmc_etf");
>   DEFINE_CORESIGHT_DEVLIST(etr_devs, "tmc_etr");
>   
> +#define TMC_WAIT_READY_FMT_STR "timeout while waiting for TMC to be Ready [STS=0x%04x]\n"
> +
>   int tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
>   {
>   	struct coresight_device *csdev = drvdata->csdev;
>   	struct csdev_access *csa = &csdev->access;
> +	u32 tmc_sts = 0;
>   
>   	/* Ensure formatter, unformatter and hardware fifo are empty */
> -	if (coresight_timeout(csa, TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
> -		dev_err(&csdev->dev,
> -			"timeout while waiting for TMC to be Ready\n");
> +	if (coresight_timeout_retval(csa, TMC_STS, TMC_STS_TMCREADY_BIT, 1,
> +				     &tmc_sts)) {
> +		dev_err(&csdev->dev, TMC_WAIT_READY_FMT_STR, tmc_sts);
>   		return -EBUSY;
>   	}
>   	return 0;
>   }
>   
> -void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
> +int tmc_flush_and_stop(struct tmc_drvdata *drvdata)
>   {
>   	struct coresight_device *csdev = drvdata->csdev;
>   	struct csdev_access *csa = &csdev->access;
> -	u32 ffcr;
> +	u32 ffcr, ffsr, tmc_sts;
> +	int rc = 0;
> +
> +	/* note any MemErr present when stopping TMC */
> +	tmc_sts = readl_relaxed(drvdata->base + TMC_STS);
> +	if (tmc_sts & TMC_STS_MEMERR)
> +		dev_err(&csdev->dev,
> +			"MemErr detected before Manual Flush; STS[0x%02x]\n",
> +			tmc_sts);
>   
>   	ffcr = readl_relaxed(drvdata->base + TMC_FFCR);
>   	ffcr |= TMC_FFCR_STOP_ON_FLUSH;
> @@ -60,12 +71,22 @@ void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
>   	ffcr |= BIT(TMC_FFCR_FLUSHMAN_BIT);
>   	writel_relaxed(ffcr, drvdata->base + TMC_FFCR);
>   	/* Ensure flush completes */
> -	if (coresight_timeout(csa, TMC_FFCR, TMC_FFCR_FLUSHMAN_BIT, 0)) {
> +	if (coresight_timeout_retval(csa, TMC_FFCR, TMC_FFCR_FLUSHMAN_BIT, 0,
> +				     &ffcr)) {
> +		ffsr = readl_relaxed(drvdata->base + TMC_FFSR);
>   		dev_err(&csdev->dev,
> -		"timeout while waiting for completion of Manual Flush\n");
> +			"timeout while waiting for completion of Manual Flush\n");
> +		dev_err(&csdev->dev,
> +			"regs: FFCR[0x%02x] FFSR[0x%02x] STS[0x%02x]\n",
> +			ffcr, ffsr, tmc_sts);
> +		rc = -EBUSY;
>   	}
>   
> -	tmc_wait_for_tmcready(drvdata);
> +	if (tmc_wait_for_tmcready(drvdata)) {
> +		dev_err(&csdev->dev, "TMC ready error after Manual flush\n");
> +		rc = -EBUSY;
> +	}
> +	return rc;
>   }

All of this looks good to me. Do we need to move the MemErr check post 
the flush ? There is a potential chance of hitting a MemERR on flushing
and we could miss reproting those ones ?

Suzuki

>   void tmc_enable_hw(struct tmc_drvdata *drvdata)
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 2671926be62a..34513f07c3aa 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -259,7 +259,7 @@ struct tmc_sg_table {
>   
>   /* Generic functions */
>   int tmc_wait_for_tmcready(struct tmc_drvdata *drvdata);
> -void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
> +int tmc_flush_and_stop(struct tmc_drvdata *drvdata);
>   void tmc_enable_hw(struct tmc_drvdata *drvdata);
>   void tmc_disable_hw(struct tmc_drvdata *drvdata);
>   u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata);


