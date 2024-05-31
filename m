Return-Path: <linux-kernel+bounces-196645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 136D68D5F40
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28B9DB249AF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ED9150981;
	Fri, 31 May 2024 10:07:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC0E1422DA;
	Fri, 31 May 2024 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717150045; cv=none; b=M5wlTzFQqqzPU0tZ0YGPvWVjkx0sULHthrg2VTwC1qrhotlN3Zml0DqjsdX8eLU/LCL7mRMW8/Rc+gDF/53XqeJogYd28DN1UyUQSmSnF7oqxNN4uC9/Eh6ZCq8xFSZqBvMhmkP0Rev8/UNpOVoveHKW/PW8t0zNDCEFbM7XRVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717150045; c=relaxed/simple;
	bh=j+/aZa6nejfS6aMNK75dfxOCC5uXpPdg4qUPfc2V9MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgQc1sqLTxxTaRIb/ln/1DvEQpDySXqIEkYB+fLfFGyDoRnevBUM2h4aeaI5EcDT3a8iOvRQyE8S0XJWrcRyGlFBY1i1VDnp8nd+GQv/a1W5S7V3DdKbFFfm5IRlCTNgeUkZhQ5F/dJAxDu3nG24YlZam6XWZR+u7lc3H7kmlJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D94F51424;
	Fri, 31 May 2024 03:07:47 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17E403F641;
	Fri, 31 May 2024 03:07:21 -0700 (PDT)
Message-ID: <069b904f-d14d-44ab-b847-f3cf4a957cd8@arm.com>
Date: Fri, 31 May 2024 11:07:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/7] coresight: core: Add provision for panic callbacks
To: Linu Cherian <lcherian@marvell.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com,
 suzuki.poulose@arm.com, mike.leach@linaro.org
References: <20240531042745.494222-1-lcherian@marvell.com>
 <20240531042745.494222-4-lcherian@marvell.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240531042745.494222-4-lcherian@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 31/05/2024 05:27, Linu Cherian wrote:
> Panic callback handlers allows coresight device drivers to sync
> relevant trace data and trace metadata to reserved memory
> regions so that they can be retrieved later in the subsequent
> boot or in the crashdump kernel.
> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---

Reviewed-by: James Clark <james.clark@arm.com>

>  drivers/hwtracing/coresight/coresight-core.c | 37 ++++++++++++++++++++
>  include/linux/coresight.h                    | 12 +++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index b83613e34289..61d75aad476b 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -19,6 +19,7 @@
>  #include <linux/property.h>
>  #include <linux/delay.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/panic_notifier.h>
>  
>  #include "coresight-etm-perf.h"
>  #include "coresight-priv.h"
> @@ -1365,6 +1366,36 @@ const struct bus_type coresight_bustype = {
>  	.name	= "coresight",
>  };
>  
> +static int coresight_panic_sync(struct device *dev, void *data)
> +{
> +	int mode;
> +	struct coresight_device *csdev;
> +
> +	/* Run through panic sync handlers for all enabled devices */
> +	csdev = container_of(dev, struct coresight_device, dev);
> +	mode = coresight_get_mode(csdev);
> +
> +	if ((mode == CS_MODE_SYSFS) || (mode == CS_MODE_PERF)) {
> +		if (panic_ops(csdev))
> +			panic_ops(csdev)->sync(csdev);
> +	}
> +
> +	return 0;
> +}
> +
> +static int coresight_panic_cb(struct notifier_block *self,
> +			       unsigned long v, void *p)
> +{
> +	bus_for_each_dev(&coresight_bustype, NULL, NULL,
> +				 coresight_panic_sync);
> +
> +	return 0;
> +}
> +
> +static struct notifier_block coresight_notifier = {
> +	.notifier_call = coresight_panic_cb,
> +};
> +
>  static int __init coresight_init(void)
>  {
>  	int ret;
> @@ -1377,6 +1408,10 @@ static int __init coresight_init(void)
>  	if (ret)
>  		goto exit_bus_unregister;
>  
> +	/* Register function to be called for panic */
> +	ret = atomic_notifier_chain_register(&panic_notifier_list,
> +					     &coresight_notifier);
> +
>  	/* initialise the coresight syscfg API */
>  	ret = cscfg_init();
>  	if (!ret)
> @@ -1391,6 +1426,8 @@ static int __init coresight_init(void)
>  static void __exit coresight_exit(void)
>  {
>  	cscfg_exit();
> +	atomic_notifier_chain_unregister(&panic_notifier_list,
> +					     &coresight_notifier);
>  	etm_perf_exit();
>  	bus_unregister(&coresight_bustype);
>  }
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 5f288d475490..b156467c9baa 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -315,6 +315,7 @@ enum cs_mode {
>  #define link_ops(csdev)		csdev->ops->link_ops
>  #define helper_ops(csdev)	csdev->ops->helper_ops
>  #define ect_ops(csdev)		csdev->ops->ect_ops
> +#define panic_ops(csdev)	csdev->ops->panic_ops
>  
>  /**
>   * struct coresight_ops_sink - basic operations for a sink
> @@ -384,11 +385,22 @@ struct coresight_ops_helper {
>  	int (*disable)(struct coresight_device *csdev, void *data);
>  };
>  
> +
> +/**
> + * struct coresight_ops_panic - Generic device ops for panic handing
> + *
> + * @sync	: Sync the device register state/trace data
> + */
> +struct coresight_ops_panic {
> +	int (*sync)(struct coresight_device *csdev);
> +};
> +
>  struct coresight_ops {
>  	const struct coresight_ops_sink *sink_ops;
>  	const struct coresight_ops_link *link_ops;
>  	const struct coresight_ops_source *source_ops;
>  	const struct coresight_ops_helper *helper_ops;
> +	const struct coresight_ops_panic *panic_ops;
>  };
>  
>  static inline u32 csdev_access_relaxed_read32(struct csdev_access *csa,

