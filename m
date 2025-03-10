Return-Path: <linux-kernel+bounces-554042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5284A59216
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C51F97A409C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4DB2288FB;
	Mon, 10 Mar 2025 10:57:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AF52288FE;
	Mon, 10 Mar 2025 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604250; cv=none; b=ZyViVS2FarWynOcdAte7fdhR3GubKI3MOpLmq10t7vle4eM0KdQ4Ci3JYCeNc6bedHHdfDyNDOfaXiWyZzDJIhpkpC+aV/pmoRQMDI9kcKR6SrGjYxMqFkg6S1MweU6ysLdgV2IGaBHTR/hHFsxurgMDQYBfYy9fNI7U7k6fSog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604250; c=relaxed/simple;
	bh=z8r8f3WaYefKneLFYtKcXNW7XunavUfymqJg+kkCuZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D2ULHZZYoFCVZDTbpD995AqAdaTQNBpfq0a0MWNDZhK1UhImPyBg/aojEBDkWXJXRwl20+tyQAbt67J6AtX4WUDGTxTEwoBUlmKwfhKgfynp1dF0KMMemiS4r1svW7h82FeHPMkdjAgKSTZhM/J+DWhHuiEdRx7+Fok/2x5XygE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9B7415A1;
	Mon, 10 Mar 2025 03:57:39 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0759C3F5A1;
	Mon, 10 Mar 2025 03:57:26 -0700 (PDT)
Message-ID: <bb390d95-7f2b-4327-a809-9e4cdbd1a1bc@arm.com>
Date: Mon, 10 Mar 2025 10:57:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] coresight: etm4x: Extract the trace unit
 controlling
To: Leo Yan <leo.yan@arm.com>, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250310104919.58816-1-leo.yan@arm.com>
 <20250310104919.58816-2-leo.yan@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250310104919.58816-2-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Leo

On 10/03/2025 10:49, Leo Yan wrote:
> The trace unit is controlled in the ETM hardware enabling and disabling.
> The sequential changes for support AUX pause and resume will reuse the
> same operations.
> 
> Extract the operations in the etm4_{enable|disable}_trace_unit()
> functions.  A minor improvement in etm4_enable_trace_unit() is for
> returning the timeout error to callers.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>

fyi, this area of code has changes significantly and will cause
conflicts, due to the introduction of synchronization after
each access to the TRCSTATR. Please rebase your next version on
the coresight next branch to avoid the conflict.

The changes as such look good to me.

Suzuki



> ---
>   .../coresight/coresight-etm4x-core.c          | 126 ++++++++++--------
>   1 file changed, 74 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 2c1a60577728..71be566bd117 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -428,6 +428,78 @@ static void etm4_check_arch_features(struct etmv4_drvdata *drvdata,
>   }
>   #endif /* CONFIG_ETM4X_IMPDEF_FEATURE */
>   
> +static int etm4_enable_trace_unit(struct etmv4_drvdata *drvdata)
> +{
> +	struct coresight_device *csdev = drvdata->csdev;
> +	struct device *etm_dev = &csdev->dev;
> +	struct csdev_access *csa = &csdev->access;
> +
> +	/*
> +	 * ETE mandates that the TRCRSR is written to before
> +	 * enabling it.
> +	 */
> +	if (etm4x_is_ete(drvdata))
> +		etm4x_relaxed_write32(csa, TRCRSR_TA, TRCRSR);
> +
> +	etm4x_allow_trace(drvdata);
> +	/* Enable the trace unit */
> +	etm4x_relaxed_write32(csa, 1, TRCPRGCTLR);
> +
> +	/* Synchronize the register updates for sysreg access */
> +	if (!csa->io_mem)
> +		isb();
> +
> +	/* wait for TRCSTATR.IDLE to go back down to '0' */
> +	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 0)) {
> +		dev_err(etm_dev,
> +			"timeout while waiting for Idle Trace Status\n");
> +		return -ETIME;
> +	}
> +
> +	/*
> +	 * As recommended by section 4.3.7 ("Synchronization when using the
> +	 * memory-mapped interface") of ARM IHI 0064D
> +	 */
> +	dsb(sy);
> +	isb();
> +
> +	return 0;
> +}
> +
> +static void etm4_disable_trace_unit(struct etmv4_drvdata *drvdata)
> +{
> +	u32 control;
> +	struct coresight_device *csdev = drvdata->csdev;
> +	struct device *etm_dev = &csdev->dev;
> +	struct csdev_access *csa = &csdev->access;
> +
> +	control = etm4x_relaxed_read32(csa, TRCPRGCTLR);
> +
> +	/* EN, bit[0] Trace unit enable bit */
> +	control &= ~0x1;
> +
> +	/*
> +	 * If the CPU supports v8.4 Trace filter Control,
> +	 * set the ETM to trace prohibited region.
> +	 */
> +	etm4x_prohibit_trace(drvdata);
> +	/*
> +	 * Make sure everything completes before disabling, as recommended
> +	 * by section 7.3.77 ("TRCVICTLR, ViewInst Main Control Register,
> +	 * SSTATUS") of ARM IHI 0064D
> +	 */
> +	dsb(sy);
> +	isb();
> +	/* Trace synchronization barrier, is a nop if not supported */
> +	tsb_csync();
> +	etm4x_relaxed_write32(csa, control, TRCPRGCTLR);
> +
> +	/* wait for TRCSTATR.PMSTABLE to go to '1' */
> +	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1))
> +		dev_err(etm_dev,
> +			"timeout while waiting for PM stable Trace Status\n");
> +}
> +
>   static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>   {
>   	int i, rc;
> @@ -536,33 +608,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>   		etm4x_relaxed_write32(csa, trcpdcr | TRCPDCR_PU, TRCPDCR);
>   	}
>   
> -	/*
> -	 * ETE mandates that the TRCRSR is written to before
> -	 * enabling it.
> -	 */
> -	if (etm4x_is_ete(drvdata))
> -		etm4x_relaxed_write32(csa, TRCRSR_TA, TRCRSR);
> -
> -	etm4x_allow_trace(drvdata);
> -	/* Enable the trace unit */
> -	etm4x_relaxed_write32(csa, 1, TRCPRGCTLR);
> -
> -	/* Synchronize the register updates for sysreg access */
> -	if (!csa->io_mem)
> -		isb();
> -
> -	/* wait for TRCSTATR.IDLE to go back down to '0' */
> -	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 0))
> -		dev_err(etm_dev,
> -			"timeout while waiting for Idle Trace Status\n");
> -
> -	/*
> -	 * As recommended by section 4.3.7 ("Synchronization when using the
> -	 * memory-mapped interface") of ARM IHI 0064D
> -	 */
> -	dsb(sy);
> -	isb();
> -
> +	rc = etm4_enable_trace_unit(drvdata);
>   done:
>   	etm4_cs_lock(drvdata, csa);
>   
> @@ -906,7 +952,6 @@ static void etm4_disable_hw(void *info)
>   	struct etmv4_drvdata *drvdata = info;
>   	struct etmv4_config *config = &drvdata->config;
>   	struct coresight_device *csdev = drvdata->csdev;
> -	struct device *etm_dev = &csdev->dev;
>   	struct csdev_access *csa = &csdev->access;
>   	int i;
>   
> @@ -920,31 +965,8 @@ static void etm4_disable_hw(void *info)
>   		etm4x_relaxed_write32(csa, control, TRCPDCR);
>   	}
>   
> -	control = etm4x_relaxed_read32(csa, TRCPRGCTLR);
> +	etm4_disable_trace_unit(drvdata);
>   
> -	/* EN, bit[0] Trace unit enable bit */
> -	control &= ~0x1;
> -
> -	/*
> -	 * If the CPU supports v8.4 Trace filter Control,
> -	 * set the ETM to trace prohibited region.
> -	 */
> -	etm4x_prohibit_trace(drvdata);
> -	/*
> -	 * Make sure everything completes before disabling, as recommended
> -	 * by section 7.3.77 ("TRCVICTLR, ViewInst Main Control Register,
> -	 * SSTATUS") of ARM IHI 0064D
> -	 */
> -	dsb(sy);
> -	isb();
> -	/* Trace synchronization barrier, is a nop if not supported */
> -	tsb_csync();
> -	etm4x_relaxed_write32(csa, control, TRCPRGCTLR);
> -
> -	/* wait for TRCSTATR.PMSTABLE to go to '1' */
> -	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1))
> -		dev_err(etm_dev,
> -			"timeout while waiting for PM stable Trace Status\n");
>   	/* read the status of the single shot comparators */
>   	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
>   		config->ss_status[i] =


