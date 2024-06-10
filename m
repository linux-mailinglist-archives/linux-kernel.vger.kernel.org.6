Return-Path: <linux-kernel+bounces-208205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D21490224C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8B51C21C33
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895D081742;
	Mon, 10 Jun 2024 13:02:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9FB7E0E9;
	Mon, 10 Jun 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718024565; cv=none; b=VeRIhALriEGUr44k6GVQ6LqR0WjnluUsY9Qj5SsEM0VxfiFqIjI/D8HzMfG7C6vqSY6tAwWpy1zJSFDwRTFuwFO5zSmUwSxJ7yvtcGxA+hTmq7kmCOyEWzaiY+e613dNGT19KNXtNRAitc7H/Ps7R8VpzVYcYjP7uprNw4s6+c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718024565; c=relaxed/simple;
	bh=LA92olITgOVkeVEx4hSp+GnmhUBmo185qlfnP1yZthE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qB7Y2Ou+40ysku2RUssGrQ5bMqX+cdrX14tRKnv79hGfQDGAsM089T4Bx0/G5q7VXHQt44PlRcVuBvW1lhova4pm2/A8RnW2c9UoGy1N/IxteQkBg8xMUr5NeLWMP6u/NLrnFPy7ZlvPdqkWwebIWerw24pg3s0tjcXlTXyHNDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09E9C11FB;
	Mon, 10 Jun 2024 06:03:01 -0700 (PDT)
Received: from [10.57.71.145] (unknown [10.57.71.145])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFAED3F58B;
	Mon, 10 Jun 2024 06:02:34 -0700 (PDT)
Message-ID: <f885b6df-e9c4-4c19-9587-b4e0c84d31c4@arm.com>
Date: Mon, 10 Jun 2024 14:02:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/7] coresight: tmc: Enable panic sync handling
Content-Language: en-GB
To: Linu Cherian <lcherian@marvell.com>, mike.leach@linaro.org,
 james.clark@arm.com
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com
References: <20240605081725.622953-1-lcherian@marvell.com>
 <20240605081725.622953-5-lcherian@marvell.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240605081725.622953-5-lcherian@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/06/2024 09:17, Linu Cherian wrote:
> - Get reserved region from device tree node for metadata
> - Define metadata format for TMC
> - Add TMC ETR panic sync handler that syncs register snapshot
>    to metadata region
> - Add TMC ETF panic sync handler that syncs register snapshot
>    to metadata region and internal SRAM to reserved trace buffer
>    region.
> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> Reviewed-by: James Clark <james.clark@arm.com>
> ---
> Changelog from v8:
> Added Reviewed-by tag.
> 
>   .../hwtracing/coresight/coresight-tmc-core.c  | 25 +++++++
>   .../hwtracing/coresight/coresight-tmc-etf.c   | 72 +++++++++++++++++++
>   .../hwtracing/coresight/coresight-tmc-etr.c   | 70 ++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tmc.h   | 45 +++++++++++-
>   4 files changed, 211 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index 6beb69d74d0a..daad08bc693d 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -443,6 +443,31 @@ static void tmc_get_reserved_region(struct device *parent)
>   
>   	drvdata->crash_tbuf.paddr = res.start;
>   	drvdata->crash_tbuf.size  = resource_size(&res);
> +
> +	/* Metadata region */
> +	node = tmc_get_region_byname(parent->of_node, "metadata");
> +	if (IS_ERR_OR_NULL(node)) {
> +		dev_dbg(parent, "No metadata memory-region specified\n");
> +		return;
> +	}
> +
> +	rc = of_address_to_resource(node, 0, &res);
> +	of_node_put(node);
> +	if (rc || res.start == 0 || resource_size(&res) == 0) {
> +		dev_err(parent, "Metadata memory is invalid\n");
> +		return;
> +	}
> +
> +	drvdata->crash_mdata.vaddr = memremap(res.start,
> +					       resource_size(&res),
> +					       MEMREMAP_WC);
> +	if (IS_ERR_OR_NULL(drvdata->crash_mdata.vaddr)) {
> +		dev_err(parent, "Metadata memory mapping failed\n");
> +		return;
> +	}
> +
> +	drvdata->crash_mdata.paddr = res.start;
> +	drvdata->crash_mdata.size  = resource_size(&res);
>   }
>   
>   /* Detect and initialise the capabilities of a TMC ETR */
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index d4f641cd9de6..f9569585e9f8 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -590,6 +590,73 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
>   	return to_read;
>   }
>   
> +static int tmc_panic_sync_etf(struct coresight_device *csdev)
> +{
> +	u32 val;
> +	struct csdev_access *csa;
> +	struct tmc_crash_metadata *mdata;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	csa = &drvdata->csdev->access;
> +
> +	/* Make sure we have valid reserved memory */
> +	if (!is_tmc_reserved_region_valid(csdev->dev.parent))
> +		return 0;
> +
> +	mdata = (struct tmc_crash_metadata *)drvdata->crash_mdata.vaddr;
> +	mdata->valid = false;
> +
> +	CS_UNLOCK(drvdata->base);
> +
> +	/* Proceed only if ETF is enabled or configured as sink */
> +	val = readl(drvdata->base + TMC_CTL);
> +	if (!(val & TMC_CTL_CAPT_EN))
> +		goto out;
> +
> +	val = readl(drvdata->base + TMC_MODE);
> +	if (val != TMC_MODE_CIRCULAR_BUFFER)
> +		goto out;
> +
> +	val = readl(drvdata->base + TMC_FFSR);
> +	/* Do manual flush and stop only if its not auto-stopped */
> +	if (!(val & TMC_FFSR_FT_STOPPED)) {
> +		dev_info(&csdev->dev,
> +			 "%s: Triggering manual flush\n", __func__);
> +		tmc_flush_and_stop(drvdata);
> +	} else
> +		tmc_wait_for_tmcready(drvdata);
> +
> +	/* Sync registers from hardware to metadata region */
> +	mdata->sts = csdev_access_relaxed_read32(csa, TMC_STS);
> +	mdata->trc_paddr = drvdata->crash_tbuf.paddr;
> +
> +	/* Sync Internal SRAM to reserved trace buffer region */
> +	drvdata->buf = drvdata->crash_tbuf.vaddr;
> +	tmc_etb_dump_hw(drvdata);
> +	/* Store as per RSZ register convention */
> +	mdata->size = drvdata->len >> 2;
> +
> +	/*
> +	 * Make sure all previous writes are completed,
> +	 * before we mark valid
> +	 */
> +	dsb(sy);
> +	mdata->valid = true;
> +	/*
> +	 * Below order need to maintained, since crc of metadata
> +	 * is dependent on first
> +	 */
> +	mdata->crc32_tdata = find_crash_tracedata_crc(drvdata, mdata);
> +	mdata->crc32_mdata = find_crash_metadata_crc(mdata);
> +
> +	tmc_disable_hw(drvdata);
> +
> +	dev_info(&csdev->dev, "%s: success\n", __func__);
> +out:
> +	CS_UNLOCK(drvdata->base);
> +	return 0;
> +}
> +
>   static const struct coresight_ops_sink tmc_etf_sink_ops = {
>   	.enable		= tmc_enable_etf_sink,
>   	.disable	= tmc_disable_etf_sink,
> @@ -603,6 +670,10 @@ static const struct coresight_ops_link tmc_etf_link_ops = {
>   	.disable	= tmc_disable_etf_link,
>   };
>   
> +static const struct coresight_ops_panic tmc_etf_sync_ops = {
> +	.sync		= tmc_panic_sync_etf,
> +};
> +
>   const struct coresight_ops tmc_etb_cs_ops = {
>   	.sink_ops	= &tmc_etf_sink_ops,
>   };
> @@ -610,6 +681,7 @@ const struct coresight_ops tmc_etb_cs_ops = {
>   const struct coresight_ops tmc_etf_cs_ops = {
>   	.sink_ops	= &tmc_etf_sink_ops,
>   	.link_ops	= &tmc_etf_link_ops,
> +	.panic_ops	= &tmc_etf_sync_ops,
>   };
>   
>   int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 041c428dd7cd..be1079e8fd64 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1813,6 +1813,71 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
>   	return 0;
>   }
>   
> +static int tmc_panic_sync_etr(struct coresight_device *csdev)
> +{
> +	u32 val;
> +	struct csdev_access *csa;
> +	struct tmc_crash_metadata *mdata;
> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	csa = &drvdata->csdev->access;
> +
> +	if (!drvdata->etr_buf)
> +		return 0;
> +
> +	/* Being in RESRV mode implies valid reserved memory as well */
> +	if (drvdata->etr_buf->mode != ETR_MODE_RESRV)
> +		return 0;
> +
> +	mdata = (struct tmc_crash_metadata *)drvdata->crash_mdata.vaddr;
> +	mdata->valid = false;
> +
> +	CS_UNLOCK(drvdata->base);
> +
> +	/* Proceed only if ETR is enabled */
> +	val = readl(drvdata->base + TMC_CTL);
> +	if (!(val & TMC_CTL_CAPT_EN))
> +		goto out;
> +
> +	val = readl(drvdata->base + TMC_FFSR);
> +	/* Do manual flush and stop only if its not auto-stopped */
> +	if (!(val & TMC_FFSR_FT_STOPPED)) {
> +		dev_info(&csdev->dev,
> +			 "%s: Triggering manual flush\n", __func__);
> +		tmc_flush_and_stop(drvdata);
> +	} else
> +		tmc_wait_for_tmcready(drvdata);
> +
> +	/* Sync registers from hardware to metadata region */
> +	mdata->size = csdev_access_relaxed_read32(csa, TMC_RSZ);
> +	mdata->sts = csdev_access_relaxed_read32(csa, TMC_STS);
> +	mdata->rrp = tmc_read_rrp(drvdata);
> +	mdata->rwp = tmc_read_rwp(drvdata);
> +	mdata->dba = tmc_read_dba(drvdata);
> +	mdata->trc_paddr = drvdata->crash_tbuf.paddr;
> +
> +	/*
> +	 * Make sure all previous writes are completed,
> +	 * before we mark valid
> +	 */
> +	dsb(sy);
> +	mdata->valid = true;
> +	/*
> +	 * Below order need to maintained, since crc of metadata
> +	 * is dependent on first
> +	 */
> +	mdata->crc32_tdata = find_crash_tracedata_crc(drvdata, mdata);
> +	mdata->crc32_mdata = find_crash_metadata_crc(mdata);
> +
> +	tmc_disable_hw(drvdata);
> +
> +	dev_info(&csdev->dev, "%s: success\n", __func__);
> +out:
> +	CS_UNLOCK(drvdata->base);
> +
> +	return 0;
> +}
> +
>   static const struct coresight_ops_sink tmc_etr_sink_ops = {
>   	.enable		= tmc_enable_etr_sink,
>   	.disable	= tmc_disable_etr_sink,
> @@ -1821,8 +1886,13 @@ static const struct coresight_ops_sink tmc_etr_sink_ops = {
>   	.free_buffer	= tmc_free_etr_buffer,
>   };
>   
> +static const struct coresight_ops_panic tmc_etr_sync_ops = {
> +	.sync		= tmc_panic_sync_etr,
> +};
> +
>   const struct coresight_ops tmc_etr_cs_ops = {
>   	.sink_ops	= &tmc_etr_sink_ops,
> +	.panic_ops	= &tmc_etr_sync_ops,
>   };
>   
>   int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index c23dc9917ab9..35beee53584a 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -12,6 +12,7 @@
>   #include <linux/miscdevice.h>
>   #include <linux/mutex.h>
>   #include <linux/refcount.h>
> +#include <linux/crc32.h>
>   
>   #define TMC_RSZ			0x004
>   #define TMC_STS			0x00c
> @@ -76,6 +77,9 @@
>   #define TMC_AXICTL_AXCACHE_OS	(0xf << 2)
>   #define TMC_AXICTL_ARCACHE_OS	(0xf << 16)
>   
> +/* TMC_FFSR - 0x300 */
> +#define TMC_FFSR_FT_STOPPED	BIT(1)
> +
>   /* TMC_FFCR - 0x304 */
>   #define TMC_FFCR_FLUSHMAN_BIT	6
>   #define TMC_FFCR_EN_FMT		BIT(0)
> @@ -131,6 +135,21 @@ enum tmc_mem_intf_width {
>   #define CORESIGHT_SOC_600_ETR_CAPS	\
>   	(TMC_ETR_SAVE_RESTORE | TMC_ETR_AXI_ARCACHE)
>   




> +/* TMC metadata region for ETR and ETF configurations */

I strongly think we should version the data layout to handle
the future changes better (if at all).


> +struct tmc_crash_metadata {
> +	uint32_t crc32_mdata;	/* crc of metadata */
> +	uint32_t crc32_tdata;	/* crc of tracedata */

	uint32_t version;	/* Version of the structure = 1 */

> +	uint32_t valid;         /* Indicate if this ETF/ETR was enabled */
> +	uint32_t size;          /* Ram Size register */

Please save the size in bytes and also rename it :

	uint32_t trace_size;	/* Trace size in Bytes */


> +	uint32_t sts;           /* Status register */
> +	uint32_t reserved32[3];
> +	uint64_t rrp;           /* Ram Read pointer register */
> +	uint64_t rwp;           /* Ram Write pointer register */



> +	uint64_t dba;		/* Data buffer address register */

Is this field useful ? And we store RRP/RWP relative to the DBA ? Could
we instead :

1. Drop DBA
2. Store RRP and RWP as offsets from DBA. Or even convert them to the
actual PADDRs relative to the trc_paddr.

DBA could be a "DMA" Address and not necessarily the PA Address.
We already have the trc_paddr below. (And for ETF, we already copy
the buffer to the reserved buffer). So all the user needs to know
is where the pointers are within the buffer. Having them relative
to the "actual" location of the buffer is much useful than basing
it on some unusable base address.

> +	uint64_t trc_paddr;	/* Phys address of trace buffer */

s/trc/trace

Move RRP and RWP, after the above field.

For the sake of completeness, you are also missing :

1) FFCR register => That tells you whether the Formatting was enabled or 
not (among other things) ? Though we always enable it, its good to
capture it, if we ever decide to turn off the formatting.


2) MODE => Which mode was selected. Again, CIRCULAR_BUFFER for now,
but lets seal it for the future, so that you can infer the trace buffer
correctly with RRP/RWP.

3) And may be FFSR, just in case the flush never completed and the
data is not reliable ?

> +	uint64_t reserved64[3];
> +};




> +
>   enum etr_mode {
>   	ETR_MODE_FLAT,		/* Uses contiguous flat buffer */
>   	ETR_MODE_ETR_SG,	/* Uses in-built TMC ETR SG mechanism */
> @@ -204,6 +223,8 @@ struct tmc_resrv_buf {
>    *		retention (after crash) only when ETR_MODE_RESRV buffer
>    *		mode is enabled. Used by ETF for trace data retention
>    *		(after crash) by default.
> + * @crash_mdata: Reserved memory for storing tmc crash metadata.
> + *		 Used by ETR/ETF.
>    */
>   struct tmc_drvdata {
>   	struct clk		*pclk;
> @@ -230,6 +251,7 @@ struct tmc_drvdata {
>   	struct etr_buf		*sysfs_buf;
>   	struct etr_buf		*perf_buf;
>   	struct tmc_resrv_buf	crash_tbuf;
> +	struct tmc_resrv_buf	crash_mdata;
>   };
>   
>   struct etr_buf_operations {
> @@ -352,11 +374,32 @@ static inline bool is_tmc_reserved_region_valid(struct device *dev)
>   	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
>   
>   	if (drvdata->crash_tbuf.paddr &&
> -		drvdata->crash_tbuf.size)
> +		drvdata->crash_tbuf.size &&
> +		drvdata->crash_mdata.paddr &&
> +		drvdata->crash_mdata.size)

Why do we need to tie the "reserved" region to metdata region 
availability ? It is perfectly possible for another usecase
to dedicate a buffer for trace and use it without metadata ?

Suzuki


>   		return true;
>   	return false;
>   }
>   
> +static inline uint32_t find_crash_metadata_crc(struct tmc_crash_metadata *md)
> +{
> +	unsigned long crc_size;
> +
> +	crc_size = sizeof(struct tmc_crash_metadata) -
> +		offsetof(struct tmc_crash_metadata, crc32_tdata);
> +	return crc32_le(0, (void *)&md->crc32_tdata, crc_size);
> +}
> +
> +static inline uint32_t find_crash_tracedata_crc(struct tmc_drvdata *drvdata,
> +						struct tmc_crash_metadata *md)
> +{
> +	unsigned long crc_size;
> +
> +	/* Take CRC of configured buffer size to keep it simple */
> +	crc_size = md->size << 2;
> +	return crc32_le(0, (void *)drvdata->crash_tbuf.vaddr, crc_size);
> +}
> +
>   struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
>   
>   void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu);


