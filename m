Return-Path: <linux-kernel+bounces-349070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECB698F05F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A191C21348
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F7319C548;
	Thu,  3 Oct 2024 13:29:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542BE19B3EC;
	Thu,  3 Oct 2024 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962176; cv=none; b=uSsgzElk/IolQ37bzSqo9jLUJjkZc2QRQs0e6PkLUuhWZNETToaIlFjP4kbLbB8a3gAVwZ3IxLVjtTJPwVHK77Ogp3vKb5qQDAFdEaYtODpRxkJ3kctxbYOuhaK1o1sJA86MOkANqup1F6HmWeqOsnztksQKAFOM2u3Cw4rotYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962176; c=relaxed/simple;
	bh=jOKnamp+zOvLkzBChUlJlOFhlPvWRGzHLEzkOEuY1Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0mGKmE33OiUWiCIJw5hvUshdVy82eSi4TDW1y6Aiz4MNUKsFOxuOV8FZGCsXV2sWiLIV4y+GxqY1NFrDqPqFZZYPfCPyozDTHhwZEON0VYcNpxNpWstbX4APhvyL+I4n/2lAdlAS188thenttx1ajhAqrlawjeqVpzsXJDQdnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 446F3339;
	Thu,  3 Oct 2024 06:30:03 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C504B3F640;
	Thu,  3 Oct 2024 06:29:31 -0700 (PDT)
Message-ID: <53b80d4d-31f2-4abf-a0ef-f194c63280dc@arm.com>
Date: Thu, 3 Oct 2024 14:29:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 7/8] coresight: config: Add preloaded configuration
To: Linu Cherian <lcherian@marvell.com>, mike.leach@linaro.org,
 james.clark@arm.com
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
 devicetree@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com
References: <20240916103437.226816-1-lcherian@marvell.com>
 <20240916103437.226816-8-lcherian@marvell.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240916103437.226816-8-lcherian@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/09/2024 11:34, Linu Cherian wrote:
> Add a preloaded configuration for generating
> external trigger on address match. This can be
> used by CTI and ETR blocks to stop trace capture
> on kernel panic.
> 
> Kernel address for "panic" function is used as the
> default trigger address.
> 
> This new configuration is available as,
> /sys/kernel/config/cs-syscfg/configurations/panicstop
> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> Reviewed-by: James Clark <james.clark@arm.com>
> ---
> Changelog from v9:
> No changes
> 
>   drivers/hwtracing/coresight/Makefile          |  2 +-
>   .../coresight/coresight-cfg-preload.c         |  2 +
>   .../coresight/coresight-cfg-preload.h         |  2 +
>   .../hwtracing/coresight/coresight-cfg-pstop.c | 83 +++++++++++++++++++
>   4 files changed, 88 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/hwtracing/coresight/coresight-cfg-pstop.c
> 
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 4ba478211b31..46ce7f39d05f 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -25,7 +25,7 @@ subdir-ccflags-y += $(condflags)
>   obj-$(CONFIG_CORESIGHT) += coresight.o
>   coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
>   		coresight-sysfs.o coresight-syscfg.o coresight-config.o \
> -		coresight-cfg-preload.o coresight-cfg-afdo.o \
> +		coresight-cfg-preload.o coresight-cfg-afdo.o coresight-cfg-pstop.o \

Please could you only build it when ETM4X is selected ? That way you
could drop the "CONFIG" check in the code ?

>   		coresight-syscfg-configfs.o coresight-trace-id.o
>   obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
>   coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
> diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.c b/drivers/hwtracing/coresight/coresight-cfg-preload.c
> index e237a4edfa09..4980e68483c5 100644
> --- a/drivers/hwtracing/coresight/coresight-cfg-preload.c
> +++ b/drivers/hwtracing/coresight/coresight-cfg-preload.c
> @@ -13,6 +13,7 @@
>   static struct cscfg_feature_desc *preload_feats[] = {
>   #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
>   	&strobe_etm4x,
> +	&gen_etrig_etm4x,
>   #endif
>   	NULL
>   };
> @@ -20,6 +21,7 @@ static struct cscfg_feature_desc *preload_feats[] = {
>   static struct cscfg_config_desc *preload_cfgs[] = {
>   #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
>   	&afdo_etm4x,
> +	&pstop_etm4x,
>   #endif
>   	NULL
>   };
> diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.h b/drivers/hwtracing/coresight/coresight-cfg-preload.h
> index 21299e175477..291ba530a6a5 100644
> --- a/drivers/hwtracing/coresight/coresight-cfg-preload.h
> +++ b/drivers/hwtracing/coresight/coresight-cfg-preload.h
> @@ -10,4 +10,6 @@
>   #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
>   extern struct cscfg_feature_desc strobe_etm4x;
>   extern struct cscfg_config_desc afdo_etm4x;
> +extern struct cscfg_feature_desc gen_etrig_etm4x;
> +extern struct cscfg_config_desc pstop_etm4x;
>   #endif
> diff --git a/drivers/hwtracing/coresight/coresight-cfg-pstop.c b/drivers/hwtracing/coresight/coresight-cfg-pstop.c
> new file mode 100644
> index 000000000000..c2bfbd07bfaf
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-cfg-pstop.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright(C) 2023  Marvell.
> + * Based on coresight-cfg-afdo.c
> + */
> +
> +#include "coresight-config.h"
> +
> +/* ETMv4 includes and features */
> +#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)

Could we not drop this check, if we only build it when 
CONFIG_CORESIGHT_SOURCE_ETM4X is selected. It is not useful
otherwise anyways.

Rest looks fine to me

Suzuki


> +#include "coresight-etm4x-cfg.h"
> +
> +/* preload configurations and features */
> +
> +/* preload in features for ETMv4 */
> +
> +/* panic_stop feature */
> +static struct cscfg_parameter_desc gen_etrig_params[] = {
> +	{
> +		.name = "address",
> +		.value = (u64)panic,
> +	},
> +};
> +
> +static struct cscfg_regval_desc gen_etrig_regs[] = {
> +	/* resource selector */
> +	{
> +		.type = CS_CFG_REG_TYPE_RESOURCE,
> +		.offset = TRCRSCTLRn(2),
> +		.hw_info = ETM4_CFG_RES_SEL,
> +		.val32 = 0x40001,
> +	},
> +	/* single address comparator */
> +	{
> +		.type = CS_CFG_REG_TYPE_RESOURCE | CS_CFG_REG_TYPE_VAL_64BIT |
> +			CS_CFG_REG_TYPE_VAL_PARAM,
> +		.offset =  TRCACVRn(0),
> +		.val32 = 0x0,
> +	},
> +	{
> +		.type = CS_CFG_REG_TYPE_RESOURCE,
> +		.offset = TRCACATRn(0),
> +		.val64 = 0xf00,
> +	},
> +	/* Driver external output[0] with comparator out */
> +	{
> +		.type = CS_CFG_REG_TYPE_RESOURCE,
> +		.offset = TRCEVENTCTL0R,
> +		.val32 = 0x2,
> +	},
> +	/* end of regs */
> +};
> +
> +struct cscfg_feature_desc gen_etrig_etm4x = {
> +	.name = "gen_etrig",
> +	.description = "Generate external trigger on address match\n"
> +		       "parameter \'address\': address of kernel address\n",
> +	.match_flags = CS_CFG_MATCH_CLASS_SRC_ETM4,
> +	.nr_params = ARRAY_SIZE(gen_etrig_params),
> +	.params_desc = gen_etrig_params,
> +	.nr_regs = ARRAY_SIZE(gen_etrig_regs),
> +	.regs_desc = gen_etrig_regs,
> +};
> +
> +/* create a panic stop configuration */
> +
> +/* the total number of parameters in used features */
> +#define PSTOP_NR_PARAMS	ARRAY_SIZE(gen_etrig_params)
> +
> +static const char *pstop_ref_names[] = {
> +	"gen_etrig",
> +};
> +
> +struct cscfg_config_desc pstop_etm4x = {
> +	.name = "panicstop",
> +	.description = "Stop ETM on kernel panic\n",
> +	.nr_feat_refs = ARRAY_SIZE(pstop_ref_names),
> +	.feat_ref_names = pstop_ref_names,
> +	.nr_total_params = PSTOP_NR_PARAMS,
> +};
> +
> +/* end of ETM4x configurations */
> +#endif	/* IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X) */


