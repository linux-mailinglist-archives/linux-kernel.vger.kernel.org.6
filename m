Return-Path: <linux-kernel+bounces-346361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A013598C3AC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F25028478B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862DB1CB52C;
	Tue,  1 Oct 2024 16:43:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D391C6F70;
	Tue,  1 Oct 2024 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801002; cv=none; b=N7zClUEzg8T7yV61qk2nMcdY/piPhp2TgMHRujLkjXJLBzgkCe1UDlyos9UVpkhpWCyzzwyYzpAYSAdZWcD7JYLY6D18msNPcsp6s2wGUY3Z0oYl6siKpovTUkPjIU5ClDM8+emBq0HHwGVH9WYEL/+wMa0YVzU8Pig/rjQo4RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801002; c=relaxed/simple;
	bh=n5c8GRGtKEyfuuM9pdEwWmAVv+uXgk/HhE7ZTe/+vdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t18djaFYWqtWxcgJAXjE0HtHZOrhyo02LB9ZStuaFze28nY8vCey22rOt4p/Wvi0yNRU2YMZeBsoPpgIj/R5ysrVYkxZ6Q9blieYiiw1Rpw/BRMagJahMtdqKeiYbz7DnxQxLbYY+TEoDWAvuTkGNqEFzN1KfZLmKS1K2Uo7Qoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3536339;
	Tue,  1 Oct 2024 09:43:46 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59CBC3F58B;
	Tue,  1 Oct 2024 09:43:15 -0700 (PDT)
Message-ID: <6b405b22-9b1e-487b-9b9c-5944358488e2@arm.com>
Date: Tue, 1 Oct 2024 17:43:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/8] coresight: tmc: Enable panic sync handling
To: Linu Cherian <lcherian@marvell.com>, mike.leach@linaro.org,
 james.clark@arm.com
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
 devicetree@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com
References: <20240916103437.226816-1-lcherian@marvell.com>
 <20240916103437.226816-5-lcherian@marvell.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240916103437.226816-5-lcherian@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linu

On 16/09/2024 11:34, Linu Cherian wrote:
> - Get reserved region from device tree node for metadata
> - Define metadata format for TMC
> - Add TMC ETR panic sync handler that syncs register snapshot
>    to metadata region
> - Add TMC ETF panic sync handler that syncs register snapshot
>    to metadata region and internal SRAM to reserved trace buffer
>    region.

The patch looks good overall. Some minor comments below.

> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
> Changelog from v9:
> - Add common helper function of_tmc_get_reserved_resource_by_name
>    for better code reuse
> - Inorder to keep the reserved buffer validity and crashdata validity
>    independent, is_tmc_reserved_region_valid renamed to tmc_has_reserved_buffer
> - drvdata->crash_tbuf renamed to drvdata->resrv_buf
> - New fields added to crash metadata: version, ffcr, ffsr, mode
> - Defined crashdata version with Major version 1, Minor version 0
> - Set version while creating crashdata record
> - Removed Reviewed-by tag due to the above changes
>     
>   .../hwtracing/coresight/coresight-tmc-core.c  | 14 ++++
>   .../hwtracing/coresight/coresight-tmc-etf.c   | 77 ++++++++++++++++++
>   .../hwtracing/coresight/coresight-tmc-etr.c   | 78 +++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tmc.h   | 66 ++++++++++++++++
>   4 files changed, 235 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index 0764c21aba0f..54bf8ae2bff8 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -445,6 +445,20 @@ static void tmc_get_reserved_region(struct device *parent)
>   
>   	drvdata->resrv_buf.paddr = res.start;
>   	drvdata->resrv_buf.size  = resource_size(&res);
> +
> +	if (of_tmc_get_reserved_resource_by_name(parent, "metadata", &res))
> +		return;
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
> index d4f641cd9de6..d77ec9307e98 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -590,6 +590,78 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
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
> +	mdata = (struct tmc_crash_metadata *)drvdata->crash_mdata.vaddr;
> +
> +	/* Make sure we have valid reserved memory */
> +	if (!tmc_has_reserved_buffer(drvdata) ||
> +	    !tmc_has_crash_mdata_buffer(drvdata))
> +		return 0;
> +
> +	tmc_crashdata_set_invalid(drvdata);
> +
> +	CS_UNLOCK(drvdata->base);
> +
> +	/* Proceed only if ETF is enabled or configured as sink */
> +	val = readl(drvdata->base + TMC_CTL);
> +	if (!(val & TMC_CTL_CAPT_EN))
> +		goto out;
> +

minor nit : Since the check below is "covered" by the same comment
above, please drop the extra line here to make it clear that "we check
for sink" by checking the "MODE == CIRCULAR_BUFFER".

> +	val = readl(drvdata->base + TMC_MODE);
> +	if (val != TMC_MODE_CIRCULAR_BUFFER)
> +		goto out;
> +
> +	val = readl(drvdata->base + TMC_FFSR);
> +	/* Do manual flush and stop only if its not auto-stopped */
> +	if (!(val & TMC_FFSR_FT_STOPPED)) {
> +		dev_info(&csdev->dev,
> +			 "%s: Triggering manual flush\n", __func__);

Please drop the ^^^ line. We don't want to do anything like that from a 
panic callback.

> +		tmc_flush_and_stop(drvdata);
> +	} else
> +		tmc_wait_for_tmcready(drvdata);
> +
> +	/* Sync registers from hardware to metadata region */
> +	mdata->sts = csdev_access_relaxed_read32(csa, TMC_STS);

Why are we using "csa" here and not for TMC_CTL etc ? Simply drop the 
"csa" and use the raw reads like above. TMC doesn't have anyother modes
of access.

> +	mdata->mode = csdev_access_relaxed_read32(csa, TMC_MODE);
> +	mdata->ffcr = csdev_access_relaxed_read32(csa, TMC_FFCR);
> +	mdata->ffsr = csdev_access_relaxed_read32(csa, TMC_FFSR);
> +	mdata->trace_paddr = drvdata->resrv_buf.paddr;
> +
> +	/* Sync Internal SRAM to reserved trace buffer region */
> +	drvdata->buf = drvdata->resrv_buf.vaddr;
> +	tmc_etb_dump_hw(drvdata);
> +	/* Store as per RSZ register convention */
> +	mdata->size = drvdata->len >> 2;
> +	mdata->version = CS_CRASHDATA_VERSION;
> +
> +	/*
> +	 * Make sure all previous writes are completed,
> +	 * before we mark valid
> +	 */
> +	dsb(sy);

I don't think this matters much, as this would only be read by a
secondary kernel. In the worst case, you only need `dmb(ish)` to make
sure the writes are visible before valid is set to true.

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

Please no "prints" from a panic call back, unless it absolutely CRITICAL.

> +out:
> +	CS_UNLOCK(drvdata->base);
> +	return 0;
> +}
> +
>   static const struct coresight_ops_sink tmc_etf_sink_ops = {
>   	.enable		= tmc_enable_etf_sink,
>   	.disable	= tmc_disable_etf_sink,
> @@ -603,6 +675,10 @@ static const struct coresight_ops_link tmc_etf_link_ops = {
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
> @@ -610,6 +686,7 @@ const struct coresight_ops tmc_etb_cs_ops = {
>   const struct coresight_ops tmc_etf_cs_ops = {
>   	.sink_ops	= &tmc_etf_sink_ops,
>   	.link_ops	= &tmc_etf_link_ops,
> +	.panic_ops	= &tmc_etf_sync_ops,
>   };
>   
>   int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 8bca5b36334a..8228d7aaa361 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1814,6 +1814,79 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
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

As earlier, drop the csa.

> +	mdata = (struct tmc_crash_metadata *)drvdata->crash_mdata.vaddr;
> +
> +	if (!drvdata->etr_buf)
> +		return 0;
> +
> +	/* Being in RESRV mode implies valid reserved memory as well */
> +	if (drvdata->etr_buf->mode != ETR_MODE_RESRV)
> +		return 0;
> +
> +	if (!tmc_has_reserved_buffer(drvdata) ||

Do we need to check this again ? We wouldn't be in ETR_MODE_RESRV
otherwise, also indicated by the comment.

> +	    !tmc_has_crash_mdata_buffer(drvdata))
> +		return 0;
> +
> +	tmc_crashdata_set_invalid(drvdata);
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

Drop the info

> +		tmc_flush_and_stop(drvdata);
> +	} else
> +		tmc_wait_for_tmcready(drvdata);
> +
> +	/* Sync registers from hardware to metadata region */
> +	mdata->size = csdev_access_relaxed_read32(csa, TMC_RSZ);
> +	mdata->sts = csdev_access_relaxed_read32(csa, TMC_STS);
> +	mdata->mode = csdev_access_relaxed_read32(csa, TMC_MODE);
> +	mdata->ffcr = csdev_access_relaxed_read32(csa, TMC_FFCR);
> +	mdata->ffsr = csdev_access_relaxed_read32(csa, TMC_FFSR);

Please use raw reads, don't mix csa and raw reads.

> +	mdata->rrp = tmc_read_rrp(drvdata);
> +	mdata->rwp = tmc_read_rwp(drvdata);
> +	mdata->dba = tmc_read_dba(drvdata);
> +	mdata->trace_paddr = drvdata->resrv_buf.paddr;
> +	mdata->version = CS_CRASHDATA_VERSION;
> +
> +	/*
> +	 * Make sure all previous writes are completed,
> +	 * before we mark valid
> +	 */
> +	dsb(sy);

Same as earlier, doesn't buy us much

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

Drop

> +out:
> +	CS_UNLOCK(drvdata->base);
> +
> +	return 0;
> +}
> +
>   static const struct coresight_ops_sink tmc_etr_sink_ops = {
>   	.enable		= tmc_enable_etr_sink,
>   	.disable	= tmc_disable_etr_sink,
> @@ -1822,8 +1895,13 @@ static const struct coresight_ops_sink tmc_etr_sink_ops = {
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
> index d2261eddab71..75e504e51956 100644
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
> @@ -94,6 +98,9 @@
>   
>   #define TMC_AUTH_NSID_MASK	GENMASK(1, 0)
>   
> +/* Major version 1 Minor version 0 */
> +#define CS_CRASHDATA_VERSION	(1 << 16)
> +
>   enum tmc_config_type {
>   	TMC_CONFIG_TYPE_ETB,
>   	TMC_CONFIG_TYPE_ETR,
> @@ -131,6 +138,25 @@ enum tmc_mem_intf_width {
>   #define CORESIGHT_SOC_600_ETR_CAPS	\
>   	(TMC_ETR_SAVE_RESTORE | TMC_ETR_AXI_ARCACHE)
>   
> +/* TMC metadata region for ETR and ETF configurations */
> +struct tmc_crash_metadata {
> +	uint32_t crc32_mdata;	/* crc of metadata */
> +	uint32_t crc32_tdata;	/* crc of tracedata */
> +	uint32_t version;	/* 31:16 Major version, 15:0 Minor version */
> +	uint32_t valid;         /* Indicate if this ETF/ETR was enabled */
> +	uint32_t size;          /* Ram Size register */

Please could you not keep this "plain bytes" ? Or rename the field to
tmc_ram_size if we want to stick to TMC RAM SIZE register. It is very
easy to confuse it with "normal" bytes.

> +	uint32_t sts;           /* Status register */

tmc_sts

> +	uint32_t mode;		/* Mode register */

tmc_mode

This doesn't look packed. Please could you add a padding here to make 
sure the fields are 64bit aligned ?

> +	uint64_t ffcr;		/* Formatter and flush control register */

tmc_ffcr

> +	uint64_t ffsr;		/* Formatter and flush status register */

tmc_ffsr


Also, why are they both 64bit ? They are all 32bit for sure ?

> +	uint32_t reserved32[3];

Why do we have reserved bits here ? They should be near the 32bit fields.

I think, once you fix the type of ffcr and ffsr things, everything will
be in order.


> +	uint64_t rrp;           /* Ram Read pointer register */
> +	uint64_t rwp;           /* Ram Write pointer register */
> +	uint64_t dba;		/* Data buffer address register */
> +	uint64_t trace_paddr;	/* Phys address of trace buffer */
> +	uint64_t reserved64[3];
> +};


Suzuki


> +
>   enum etr_mode {
>   	ETR_MODE_FLAT,		/* Uses contiguous flat buffer */
>   	ETR_MODE_ETR_SG,	/* Uses in-built TMC ETR SG mechanism */
> @@ -205,6 +231,8 @@ struct tmc_resrv_buf {
>    *		retention (after crash) only when ETR_MODE_RESRV buffer
>    *		mode is enabled. Used by ETF for trace data retention
>    *		(after crash) by default.
> + * @crash_mdata: Reserved memory for storing tmc crash metadata.
> + *		 Used by ETR/ETF.
>    */
>   struct tmc_drvdata {
>   	struct clk		*pclk;
> @@ -231,6 +259,7 @@ struct tmc_drvdata {
>   	struct etr_buf		*sysfs_buf;
>   	struct etr_buf		*perf_buf;
>   	struct tmc_resrv_buf	resrv_buf;
> +	struct tmc_resrv_buf	crash_mdata;
>   };
>   
>   struct etr_buf_operations {
> @@ -356,6 +385,43 @@ static inline bool tmc_has_reserved_buffer(struct tmc_drvdata *drvdata)
>   	return false;
>   }
>   
> +static inline bool tmc_has_crash_mdata_buffer(struct tmc_drvdata *drvdata)
> +{
> +	if (drvdata->crash_mdata.vaddr &&
> +	    drvdata->crash_mdata.size)
> +		return true;
> +	return false;
> +}
> +
> +static inline void tmc_crashdata_set_invalid(struct tmc_drvdata *drvdata)
> +{
> +	struct tmc_crash_metadata *mdata;
> +
> +	mdata = (struct tmc_crash_metadata *)drvdata->crash_mdata.vaddr;
> +
> +	if (tmc_has_crash_mdata_buffer(drvdata))
> +		mdata->valid = false;
> +}
> +
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
> +	return crc32_le(0, (void *)drvdata->resrv_buf.vaddr, crc_size);
> +}
> +
>   struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
>   
>   void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu);


