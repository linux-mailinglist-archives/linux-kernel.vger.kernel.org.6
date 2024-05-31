Return-Path: <linux-kernel+bounces-196659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD5E8D5F70
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D351F24075
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E7F1509AF;
	Fri, 31 May 2024 10:19:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C728A1422DA;
	Fri, 31 May 2024 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717150758; cv=none; b=DgJn14wTeDeA5E3/qCqQqX2jVyFSI5RSW8nNN3s+sVpb7H7T/wLvuMgAVblZHAFeW8SMKIaJi8Vch8mfPWNfpQ5QzCmdzh13TEuFN6mhE97YwHQfYLWV8mL8yAVnRTFZWh0uQW97MDbt05NvYKSYh/LaaUZ+lH8zYRw1C+l+xnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717150758; c=relaxed/simple;
	bh=Gxk63K/WzefClGNX53qjRIrlcEhoJXL8wkpq+mWqYMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuOCdUr6xYKwmA8apPap8kf+I5IF/3KVQRc5kVweB+fmalNh+MsAoSqApLDOB+Vwst+46l7skUB1JB7XKGA1nsbdZ/DrpHlaOp45L4fBdCa13U6I+I43nKTe21Ls5n/qN0UHPvoxAaZTHQ5SzyKHPLeiOSQrPFG66SAwLCbW4mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83AE21424;
	Fri, 31 May 2024 03:19:40 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCAB03F641;
	Fri, 31 May 2024 03:19:14 -0700 (PDT)
Message-ID: <857fb9da-e12f-4496-964f-44d7ac0ad313@arm.com>
Date: Fri, 31 May 2024 11:19:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/7] coresight: config: Add preloaded configuration
To: Linu Cherian <lcherian@marvell.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com,
 suzuki.poulose@arm.com, mike.leach@linaro.org
References: <20240531042745.494222-1-lcherian@marvell.com>
 <20240531042745.494222-8-lcherian@marvell.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240531042745.494222-8-lcherian@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 31/05/2024 05:27, Linu Cherian wrote:
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

Reviewed-by: James Clark <james.clark@arm.com>

> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
>  drivers/hwtracing/coresight/Makefile          |  2 +-
>  .../coresight/coresight-cfg-preload.c         |  2 +
>  .../coresight/coresight-cfg-preload.h         |  2 +
>  .../hwtracing/coresight/coresight-cfg-pstop.c | 83 +++++++++++++++++++
>  4 files changed, 88 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-pstop.c
> 
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 4ba478211b31..46ce7f39d05f 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -25,7 +25,7 @@ subdir-ccflags-y += $(condflags)
>  obj-$(CONFIG_CORESIGHT) += coresight.o
>  coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
>  		coresight-sysfs.o coresight-syscfg.o coresight-config.o \
> -		coresight-cfg-preload.o coresight-cfg-afdo.o \
> +		coresight-cfg-preload.o coresight-cfg-afdo.o coresight-cfg-pstop.o \
>  		coresight-syscfg-configfs.o coresight-trace-id.o
>  obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
>  coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
> diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.c b/drivers/hwtracing/coresight/coresight-cfg-preload.c
> index e237a4edfa09..4980e68483c5 100644
> --- a/drivers/hwtracing/coresight/coresight-cfg-preload.c
> +++ b/drivers/hwtracing/coresight/coresight-cfg-preload.c
> @@ -13,6 +13,7 @@
>  static struct cscfg_feature_desc *preload_feats[] = {
>  #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
>  	&strobe_etm4x,
> +	&gen_etrig_etm4x,
>  #endif
>  	NULL
>  };
> @@ -20,6 +21,7 @@ static struct cscfg_feature_desc *preload_feats[] = {
>  static struct cscfg_config_desc *preload_cfgs[] = {
>  #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
>  	&afdo_etm4x,
> +	&pstop_etm4x,
>  #endif
>  	NULL
>  };
> diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.h b/drivers/hwtracing/coresight/coresight-cfg-preload.h
> index 21299e175477..291ba530a6a5 100644
> --- a/drivers/hwtracing/coresight/coresight-cfg-preload.h
> +++ b/drivers/hwtracing/coresight/coresight-cfg-preload.h
> @@ -10,4 +10,6 @@
>  #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
>  extern struct cscfg_feature_desc strobe_etm4x;
>  extern struct cscfg_config_desc afdo_etm4x;
> +extern struct cscfg_feature_desc gen_etrig_etm4x;
> +extern struct cscfg_config_desc pstop_etm4x;
>  #endif
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

