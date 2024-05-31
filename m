Return-Path: <linux-kernel+bounces-196640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FCB8D5F2F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAEC41F239A8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48254143723;
	Fri, 31 May 2024 10:03:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A451386B4;
	Fri, 31 May 2024 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717149810; cv=none; b=QmwhyiqGavTCtwWEBENzuFFgkkmu8/l2owqJpeMKBeVaQe5Ni4TvgBo9unnDASYVFhTASPjZ0hYgQVaf3Rlyf6/4NU3e4tsWsca+8QG32F1h/tqgttd5DiRiQsdtO0cdqqovi084OT1jL1XSex7T5hkj9qZgMMhja2FocA2LqyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717149810; c=relaxed/simple;
	bh=X0ln94e4cQXmHxkpU2Ol1BQ3SCZAfewMofyqfB4pHW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/46y3Vuv6pPn+ZDgCgLvulW2B8GdS8/4aJaZUzuTqPsnDlNchEjqcNgxw7o5ZOc1yQZ0nZ5tB5amARpfjhtgfvteYny8ThhpVGJl+u++sFkIgKEiKiIatG3A5ZBNxbO1AR/sdCRgokkysA2bBYIVp2+8NPrfmwMIMu8N/e9agc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6771A1424;
	Fri, 31 May 2024 03:03:52 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 634B63F641;
	Fri, 31 May 2024 03:03:26 -0700 (PDT)
Message-ID: <5fbb37f4-031b-4b8a-be7e-676cab82b180@arm.com>
Date: Fri, 31 May 2024 11:03:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/7] coresight: tmc: Add support for reading crash data
To: Linu Cherian <lcherian@marvell.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com,
 Anil Kumar Reddy <areddy3@marvell.com>, Tanmay Jagdale <tanmay@marvell.com>,
 suzuki.poulose@arm.com, mike.leach@linaro.org
References: <20240531042745.494222-1-lcherian@marvell.com>
 <20240531042745.494222-6-lcherian@marvell.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240531042745.494222-6-lcherian@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 31/05/2024 05:27, Linu Cherian wrote:
> * Introduce a new mode CS_MODE_READ_CRASHDATA for reading trace
>   captured in previous crash/watchdog reset.
> 
> * Add special device files for reading ETR/ETF crash data.
> 
> * User can read the crash data as below
> 
>   For example, for reading crash data from tmc_etf sink
> 
>   #dd if=/dev/crash_tmc_etfXX of=~/cstrace.bin
> 
> Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
> Changelog from v7:
> * Moved crash dev registration into new function,
>   register_crash_dev_interface
> * Removed redundant variable trace_addr in
>   tmc_etr_setup_crashdata_buf
> 
>  .../coresight/coresight-etm4x-core.c          |   1 +
>  .../hwtracing/coresight/coresight-tmc-core.c  | 148 ++++++++++++++++-
>  .../hwtracing/coresight/coresight-tmc-etf.c   |  73 +++++++++
>  .../hwtracing/coresight/coresight-tmc-etr.c   | 152 +++++++++++++++++-
>  drivers/hwtracing/coresight/coresight-tmc.h   |  11 +-
>  include/linux/coresight.h                     |  13 ++
>  6 files changed, 391 insertions(+), 7 deletions(-)
> 

[...]

> +static void register_crash_dev_interface(struct tmc_drvdata * drvdata,
> +					 const char *name)
> +{
> +	drvdata->crashdev.name =
> +		devm_kasprintf(&drvdata->csdev->dev, GFP_KERNEL, "%s_%s", "crash", name);
> +	drvdata->crashdev.minor = MISC_DYNAMIC_MINOR;
> +	drvdata->crashdev.fops = &tmc_crashdata_fops;
> +	if (misc_register(&drvdata->crashdev))
> +		dev_dbg(&drvdata->csdev->dev,
> +			"Failed to setup user interface for crashdata\n");
> +}
> +
>  static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  {
>  	int ret = 0;
> @@ -619,6 +752,10 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  		coresight_unregister(drvdata->csdev);
>  	else
>  		pm_runtime_put(&adev->dev);
> +
> +	if (is_tmc_reserved_region_valid(dev))
> +		register_crash_dev_interface(drvdata, desc.name);
> +

Now that you've added an extra step to the probe you need to add a "goto
out" when the previous step fails:

  if (ret) {
	coresight_unregister(drvdata->csdev);
+	goto out;
  }

That seems to be the pattern in the rest of the function. Otherwise you
might register the interface on no device.

There's also a conflict here and in some other places. Since this has to
go through the coresight branch you should base it off of coresight-next.

>  out:
>  	return ret;
>  }
> @@ -630,7 +767,8 @@ static void tmc_shutdown(struct amba_device *adev)
>  
>  	spin_lock_irqsave(&drvdata->spinlock, flags);
>  
> -	if (coresight_get_mode(drvdata->csdev) == CS_MODE_DISABLED)
> +	if ((coresight_get_mode(drvdata->csdev) == CS_MODE_DISABLED) ||
> +	    (coresight_get_mode(drvdata->csdev) == CS_MODE_READ_CRASHDATA))
>  		goto out;
>  
>  	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index f9569585e9f8..655c0c0ba54b 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -657,6 +657,56 @@ static int tmc_panic_sync_etf(struct coresight_device *csdev)
>  	return 0;
>  }
>  

[...]

> @@ -725,6 +789,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
>  		__tmc_etb_disable_hw(drvdata);
>  	}
>  
> +mode_valid:
>  	drvdata->reading = true;
>  out:
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> @@ -744,8 +809,16 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
>  			 drvdata->config_type != TMC_CONFIG_TYPE_ETF))
>  		return -EINVAL;
>  
> +

Whitespace change. There are a couple of other minor checkpatch style
warnings.

The rest looks good to me. All the tests are passing. I still think we
should all the kself test for this mode, but that can be done later.

