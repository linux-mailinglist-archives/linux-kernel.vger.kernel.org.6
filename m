Return-Path: <linux-kernel+bounces-567548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB94A6879C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086753AB616
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA712101A0;
	Wed, 19 Mar 2025 09:13:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEFE35972
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375621; cv=none; b=K5Wj34K4jWRMspBBx0z0gTVoLvvKcYV0ZlrU1+D7SME+VIRRDjb5gGU6U5/fnvfnm630oahQdnuSLLPgVtzqvD30ZS75+k4s++JdF99y2Un4njXEETTPdy/kaunQULnoZ3BrxiT89DSYS7mJ5JN/nJL3iviEIJweRVN6jEx4jKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375621; c=relaxed/simple;
	bh=uHOaPe0oCt7W2MiaGtz8hxQcN68PRHrKUne9FPEga/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPPD8EjwjnxRqhQMOYZeThOzN6D47j9Ejqcek1JStmKdnWsMN9Y0lNyHtHyO5qrG2sXvGK11CpaB0YRsy7qfuWgGlKCj77SE2U0tjsHMZcXr7G9X5etJn1P+ifDZ9F7ONqrQ89Vfi529CJ3oglzvRsYeHwjglpDF609EEdLjMus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87ED812FC;
	Wed, 19 Mar 2025 02:13:46 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E22B13F63F;
	Wed, 19 Mar 2025 02:13:37 -0700 (PDT)
Date: Wed, 19 Mar 2025 09:13:33 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 6/8] coresight: Clear self hosted claim tag on probe
Message-ID: <20250319091333.GG2860028@e132581.arm.com>
References: <20250318-james-coresight-claim-tags-v2-0-e9c8a9cde84e@linaro.org>
 <20250318-james-coresight-claim-tags-v2-6-e9c8a9cde84e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-james-coresight-claim-tags-v2-6-e9c8a9cde84e@linaro.org>

On Tue, Mar 18, 2025 at 04:22:00PM +0000, James Clark wrote:
> This can be left behind from a crashed kernel after a kexec so clear it
> when probing each device. Clearing the self hosted bit even when claimed
> externally is harmless, so do it unconditionally.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Just a note from me.

I'd expect it would be a rare case that users enable a Arm CoreSight
trace in a dump-capture kernel, as the second kernel is for dumping
CoreSight trace data but it is not necessarily to enable CoreSight
components.

This patch is not only helpful for crash kernel case, it can dismiss
quirks caused by insane hardware reset cases.

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>  drivers/hwtracing/coresight/coresight-catu.c       | 1 +
>  drivers/hwtracing/coresight/coresight-cti-core.c   | 2 ++
>  drivers/hwtracing/coresight/coresight-etb10.c      | 2 ++
>  drivers/hwtracing/coresight/coresight-etm3x-core.c | 1 +
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 ++
>  drivers/hwtracing/coresight/coresight-funnel.c     | 1 +
>  drivers/hwtracing/coresight/coresight-replicator.c | 1 +
>  drivers/hwtracing/coresight/coresight-tmc-core.c   | 1 +
>  8 files changed, 11 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index fa170c966bc3..deaacfd875af 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -558,6 +558,7 @@ static int __catu_probe(struct device *dev, struct resource *res)
>  	catu_desc.subtype.helper_subtype = CORESIGHT_DEV_SUBTYPE_HELPER_CATU;
>  	catu_desc.ops = &catu_ops;
>  
> +	coresight_clear_self_claim_tag(&catu_desc.access);
>  	drvdata->csdev = coresight_register(&catu_desc);
>  	if (IS_ERR(drvdata->csdev))
>  		ret = PTR_ERR(drvdata->csdev);
> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
> index 80f6265e3740..8fb30dd73fd2 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> @@ -931,6 +931,8 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
>  	cti_desc.ops = &cti_ops;
>  	cti_desc.groups = drvdata->ctidev.con_groups;
>  	cti_desc.dev = dev;
> +
> +	coresight_clear_self_claim_tag(&cti_desc.access);
>  	drvdata->csdev = coresight_register(&cti_desc);
>  	if (IS_ERR(drvdata->csdev)) {
>  		ret = PTR_ERR(drvdata->csdev);
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 7948597d483d..2bfcb669aa84 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -772,6 +772,8 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>  	desc.pdata = pdata;
>  	desc.dev = dev;
>  	desc.groups = coresight_etb_groups;
> +
> +	coresight_clear_self_claim_tag(&desc.access);
>  	drvdata->csdev = coresight_register(&desc);
>  	if (IS_ERR(drvdata->csdev))
>  		return PTR_ERR(drvdata->csdev);
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> index cfd463ac715c..1c6204e14422 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -764,6 +764,7 @@ static void etm_init_arch_data(void *info)
>  	drvdata->nr_ext_out = BMVAL(etmccr, 20, 22);
>  	drvdata->nr_ctxid_cmp = BMVAL(etmccr, 24, 25);
>  
> +	coresight_clear_self_claim_tag_unlocked(&drvdata->csa);
>  	etm_set_pwrdwn(drvdata);
>  	etm_clr_pwrup(drvdata);
>  	CS_LOCK(drvdata->csa.base);
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index e5972f16abff..52c9aa56e8b9 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1372,6 +1372,8 @@ static void etm4_init_arch_data(void *info)
>  	drvdata->nrseqstate = FIELD_GET(TRCIDR5_NUMSEQSTATE_MASK, etmidr5);
>  	/* NUMCNTR, bits[30:28] number of counters available for tracing */
>  	drvdata->nr_cntr = FIELD_GET(TRCIDR5_NUMCNTR_MASK, etmidr5);
> +
> +	coresight_clear_self_claim_tag_unlocked(csa);
>  	etm4_cs_lock(drvdata, csa);
>  	cpu_detect_trace_filtering(drvdata);
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 0541712b2bcb..7249cc356ccb 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -255,6 +255,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
>  		drvdata->base = base;
>  		desc.groups = coresight_funnel_groups;
>  		desc.access = CSDEV_ACCESS_IOMEM(base);
> +		coresight_clear_self_claim_tag(&desc.access);
>  	}
>  
>  	dev_set_drvdata(dev, drvdata);
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index ee7ee79f6cf7..b2acd4535c74 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -284,6 +284,7 @@ static int replicator_probe(struct device *dev, struct resource *res)
>  	desc.pdata = dev->platform_data;
>  	desc.dev = dev;
>  
> +	coresight_clear_self_claim_tag(&desc.access);
>  	drvdata->csdev = coresight_register(&desc);
>  	if (IS_ERR(drvdata->csdev)) {
>  		ret = PTR_ERR(drvdata->csdev);
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index a7814e8e657b..a09579eff3fd 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -869,6 +869,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
>  	dev->platform_data = pdata;
>  	desc.pdata = pdata;
>  
> +	coresight_clear_self_claim_tag(&desc.access);
>  	drvdata->csdev = coresight_register(&desc);
>  	if (IS_ERR(drvdata->csdev)) {
>  		ret = PTR_ERR(drvdata->csdev);
> 
> -- 
> 2.34.1
> 

