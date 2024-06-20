Return-Path: <linux-kernel+bounces-222244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5A390FEC2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725BA1C20D75
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D85198836;
	Thu, 20 Jun 2024 08:25:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0216B3CF65;
	Thu, 20 Jun 2024 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871949; cv=none; b=e/d4yWA5PmdCDySCAeCOCl7M2Gy7tNqeCofcxV0WkJ8WWNDYAFocwKdZ1PODSFii28owTLIud0R435ChxGN22vCNnbDBUP2yqZTz7Q5mfQe/cpqB6f7Yb+PO76ZCXzL4TYJYh28BqyV85DxzlK2V65aEFXqz2xzWbSD9qd7gm+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871949; c=relaxed/simple;
	bh=2h8RP9Ndy6w9QPLaBDGqwRt4sBSKvYRtqx5wKBIOJ9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9txFNAwC8MjXrrLM4XjcbNXWE7zaCyBoy8Vhq43JjzS/c1vA6mnho/P1aLNOfR42WIEZ6H99IeqUH3EU5CCc6HdR98ELQB78XfKPOgxiWFaLUusSKroDYc5Qm8QNZZ1URoK8YrI5/ZVRWuZggUwVxQ0g1vzAf3P0lSHG2ofZSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88FE4DA7;
	Thu, 20 Jun 2024 01:26:09 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CCAA3F64C;
	Thu, 20 Jun 2024 01:25:43 -0700 (PDT)
Message-ID: <ffce6b1c-1f84-4a9f-9e9a-d44201097876@arm.com>
Date: Thu, 20 Jun 2024 09:25:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/7] coresight: tmc: Enable panic sync handling
To: Linu Cherian <lcherian@marvell.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: mike.leach@linaro.org, linux-arm-kernel@lists.infradead.org,
 coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com
References: <20240605081725.622953-1-lcherian@marvell.com>
 <20240605081725.622953-5-lcherian@marvell.com>
 <f885b6df-e9c4-4c19-9587-b4e0c84d31c4@arm.com>
 <20240620041054.GC125816@hyd1403.caveonetworks.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240620041054.GC125816@hyd1403.caveonetworks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/06/2024 05:10, Linu Cherian wrote:
> On 2024-06-10 at 18:32:33, Suzuki K Poulose (suzuki.poulose@arm.com) wrote:
>> On 05/06/2024 09:17, Linu Cherian wrote:
>>> - Get reserved region from device tree node for metadata
>>> - Define metadata format for TMC
>>> - Add TMC ETR panic sync handler that syncs register snapshot
>>>    to metadata region
>>> - Add TMC ETF panic sync handler that syncs register snapshot
>>>    to metadata region and internal SRAM to reserved trace buffer
>>>    region.
>>>
>>> Signed-off-by: Linu Cherian <lcherian@marvell.com>
>>> Reviewed-by: James Clark <james.clark@arm.com>
>>> ---
>>> Changelog from v8:
>>> Added Reviewed-by tag.
>>>
>>>   .../hwtracing/coresight/coresight-tmc-core.c  | 25 +++++++
>>>   .../hwtracing/coresight/coresight-tmc-etf.c   | 72 +++++++++++++++++++
>>>   .../hwtracing/coresight/coresight-tmc-etr.c   | 70 ++++++++++++++++++
>>>   drivers/hwtracing/coresight/coresight-tmc.h   | 45 +++++++++++-
>>>   4 files changed, 211 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
>>> index 6beb69d74d0a..daad08bc693d 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
>>> @@ -443,6 +443,31 @@ static void tmc_get_reserved_region(struct device *parent)
>>>   	drvdata->crash_tbuf.paddr = res.start;
>>>   	drvdata->crash_tbuf.size  = resource_size(&res);
>>> +
>>> +	/* Metadata region */
>>> +	node = tmc_get_region_byname(parent->of_node, "metadata");
>>> +	if (IS_ERR_OR_NULL(node)) {
>>> +		dev_dbg(parent, "No metadata memory-region specified\n");
>>> +		return;
>>> +	}
>>> +
>>> +	rc = of_address_to_resource(node, 0, &res);
>>> +	of_node_put(node);
>>> +	if (rc || res.start == 0 || resource_size(&res) == 0) {
>>> +		dev_err(parent, "Metadata memory is invalid\n");
>>> +		return;
>>> +	}
>>> +
>>> +	drvdata->crash_mdata.vaddr = memremap(res.start,
>>> +					       resource_size(&res),
>>> +					       MEMREMAP_WC);
>>> +	if (IS_ERR_OR_NULL(drvdata->crash_mdata.vaddr)) {
>>> +		dev_err(parent, "Metadata memory mapping failed\n");
>>> +		return;
>>> +	}
>>> +
>>> +	drvdata->crash_mdata.paddr = res.start;
>>> +	drvdata->crash_mdata.size  = resource_size(&res);
>>>   }
>>>   /* Detect and initialise the capabilities of a TMC ETR */
>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>>> index d4f641cd9de6..f9569585e9f8 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>>> @@ -590,6 +590,73 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
>>>   	return to_read;
>>>   }
>>> +static int tmc_panic_sync_etf(struct coresight_device *csdev)
>>> +{
>>> +	u32 val;
>>> +	struct csdev_access *csa;
>>> +	struct tmc_crash_metadata *mdata;
>>> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>> +
>>> +	csa = &drvdata->csdev->access;
>>> +
>>> +	/* Make sure we have valid reserved memory */
>>> +	if (!is_tmc_reserved_region_valid(csdev->dev.parent))
>>> +		return 0;
>>> +
>>> +	mdata = (struct tmc_crash_metadata *)drvdata->crash_mdata.vaddr;
>>> +	mdata->valid = false;
>>> +
>>> +	CS_UNLOCK(drvdata->base);
>>> +
>>> +	/* Proceed only if ETF is enabled or configured as sink */
>>> +	val = readl(drvdata->base + TMC_CTL);
>>> +	if (!(val & TMC_CTL_CAPT_EN))
>>> +		goto out;
>>> +
>>> +	val = readl(drvdata->base + TMC_MODE);
>>> +	if (val != TMC_MODE_CIRCULAR_BUFFER)
>>> +		goto out;
>>> +
>>> +	val = readl(drvdata->base + TMC_FFSR);
>>> +	/* Do manual flush and stop only if its not auto-stopped */
>>> +	if (!(val & TMC_FFSR_FT_STOPPED)) {
>>> +		dev_info(&csdev->dev,
>>> +			 "%s: Triggering manual flush\n", __func__);
>>> +		tmc_flush_and_stop(drvdata);
>>> +	} else
>>> +		tmc_wait_for_tmcready(drvdata);
>>> +
>>> +	/* Sync registers from hardware to metadata region */
>>> +	mdata->sts = csdev_access_relaxed_read32(csa, TMC_STS);
>>> +	mdata->trc_paddr = drvdata->crash_tbuf.paddr;
>>> +
>>> +	/* Sync Internal SRAM to reserved trace buffer region */
>>> +	drvdata->buf = drvdata->crash_tbuf.vaddr;
>>> +	tmc_etb_dump_hw(drvdata);
>>> +	/* Store as per RSZ register convention */
>>> +	mdata->size = drvdata->len >> 2;
>>> +
>>> +	/*
>>> +	 * Make sure all previous writes are completed,
>>> +	 * before we mark valid
>>> +	 */
>>> +	dsb(sy);
>>> +	mdata->valid = true;
>>> +	/*
>>> +	 * Below order need to maintained, since crc of metadata
>>> +	 * is dependent on first
>>> +	 */
>>> +	mdata->crc32_tdata = find_crash_tracedata_crc(drvdata, mdata);
>>> +	mdata->crc32_mdata = find_crash_metadata_crc(mdata);
>>> +
>>> +	tmc_disable_hw(drvdata);
>>> +
>>> +	dev_info(&csdev->dev, "%s: success\n", __func__);
>>> +out:
>>> +	CS_UNLOCK(drvdata->base);
>>> +	return 0;
>>> +}
>>> +
>>>   static const struct coresight_ops_sink tmc_etf_sink_ops = {
>>>   	.enable		= tmc_enable_etf_sink,
>>>   	.disable	= tmc_disable_etf_sink,
>>> @@ -603,6 +670,10 @@ static const struct coresight_ops_link tmc_etf_link_ops = {
>>>   	.disable	= tmc_disable_etf_link,
>>>   };
>>> +static const struct coresight_ops_panic tmc_etf_sync_ops = {
>>> +	.sync		= tmc_panic_sync_etf,
>>> +};
>>> +
>>>   const struct coresight_ops tmc_etb_cs_ops = {
>>>   	.sink_ops	= &tmc_etf_sink_ops,
>>>   };
>>> @@ -610,6 +681,7 @@ const struct coresight_ops tmc_etb_cs_ops = {
>>>   const struct coresight_ops tmc_etf_cs_ops = {
>>>   	.sink_ops	= &tmc_etf_sink_ops,
>>>   	.link_ops	= &tmc_etf_link_ops,
>>> +	.panic_ops	= &tmc_etf_sync_ops,
>>>   };
>>>   int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> index 041c428dd7cd..be1079e8fd64 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> @@ -1813,6 +1813,71 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
>>>   	return 0;
>>>   }
>>> +static int tmc_panic_sync_etr(struct coresight_device *csdev)
>>> +{
>>> +	u32 val;
>>> +	struct csdev_access *csa;
>>> +	struct tmc_crash_metadata *mdata;
>>> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>> +
>>> +	csa = &drvdata->csdev->access;
>>> +
>>> +	if (!drvdata->etr_buf)
>>> +		return 0;
>>> +
>>> +	/* Being in RESRV mode implies valid reserved memory as well */
>>> +	if (drvdata->etr_buf->mode != ETR_MODE_RESRV)
>>> +		return 0;
>>> +
>>> +	mdata = (struct tmc_crash_metadata *)drvdata->crash_mdata.vaddr;
>>> +	mdata->valid = false;
>>> +
>>> +	CS_UNLOCK(drvdata->base);
>>> +
>>> +	/* Proceed only if ETR is enabled */
>>> +	val = readl(drvdata->base + TMC_CTL);
>>> +	if (!(val & TMC_CTL_CAPT_EN))
>>> +		goto out;
>>> +
>>> +	val = readl(drvdata->base + TMC_FFSR);
>>> +	/* Do manual flush and stop only if its not auto-stopped */
>>> +	if (!(val & TMC_FFSR_FT_STOPPED)) {
>>> +		dev_info(&csdev->dev,
>>> +			 "%s: Triggering manual flush\n", __func__);
>>> +		tmc_flush_and_stop(drvdata);
>>> +	} else
>>> +		tmc_wait_for_tmcready(drvdata);
>>> +
>>> +	/* Sync registers from hardware to metadata region */
>>> +	mdata->size = csdev_access_relaxed_read32(csa, TMC_RSZ);
>>> +	mdata->sts = csdev_access_relaxed_read32(csa, TMC_STS);
>>> +	mdata->rrp = tmc_read_rrp(drvdata);
>>> +	mdata->rwp = tmc_read_rwp(drvdata);
>>> +	mdata->dba = tmc_read_dba(drvdata);
>>> +	mdata->trc_paddr = drvdata->crash_tbuf.paddr;
>>> +
>>> +	/*
>>> +	 * Make sure all previous writes are completed,
>>> +	 * before we mark valid
>>> +	 */
>>> +	dsb(sy);
>>> +	mdata->valid = true;
>>> +	/*
>>> +	 * Below order need to maintained, since crc of metadata
>>> +	 * is dependent on first
>>> +	 */
>>> +	mdata->crc32_tdata = find_crash_tracedata_crc(drvdata, mdata);
>>> +	mdata->crc32_mdata = find_crash_metadata_crc(mdata);
>>> +
>>> +	tmc_disable_hw(drvdata);
>>> +
>>> +	dev_info(&csdev->dev, "%s: success\n", __func__);
>>> +out:
>>> +	CS_UNLOCK(drvdata->base);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>   static const struct coresight_ops_sink tmc_etr_sink_ops = {
>>>   	.enable		= tmc_enable_etr_sink,
>>>   	.disable	= tmc_disable_etr_sink,
>>> @@ -1821,8 +1886,13 @@ static const struct coresight_ops_sink tmc_etr_sink_ops = {
>>>   	.free_buffer	= tmc_free_etr_buffer,
>>>   };
>>> +static const struct coresight_ops_panic tmc_etr_sync_ops = {
>>> +	.sync		= tmc_panic_sync_etr,
>>> +};
>>> +
>>>   const struct coresight_ops tmc_etr_cs_ops = {
>>>   	.sink_ops	= &tmc_etr_sink_ops,
>>> +	.panic_ops	= &tmc_etr_sync_ops,
>>>   };
>>>   int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
>>> index c23dc9917ab9..35beee53584a 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
>>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
>>> @@ -12,6 +12,7 @@
>>>   #include <linux/miscdevice.h>
>>>   #include <linux/mutex.h>
>>>   #include <linux/refcount.h>
>>> +#include <linux/crc32.h>
>>>   #define TMC_RSZ			0x004
>>>   #define TMC_STS			0x00c
>>> @@ -76,6 +77,9 @@
>>>   #define TMC_AXICTL_AXCACHE_OS	(0xf << 2)
>>>   #define TMC_AXICTL_ARCACHE_OS	(0xf << 16)
>>> +/* TMC_FFSR - 0x300 */
>>> +#define TMC_FFSR_FT_STOPPED	BIT(1)
>>> +
>>>   /* TMC_FFCR - 0x304 */
>>>   #define TMC_FFCR_FLUSHMAN_BIT	6
>>>   #define TMC_FFCR_EN_FMT		BIT(0)
>>> @@ -131,6 +135,21 @@ enum tmc_mem_intf_width {
>>>   #define CORESIGHT_SOC_600_ETR_CAPS	\
>>>   	(TMC_ETR_SAVE_RESTORE | TMC_ETR_AXI_ARCACHE)
>>
>>
>>
>>
>>> +/* TMC metadata region for ETR and ETF configurations */
>>
>> I strongly think we should version the data layout to handle
>> the future changes better (if at all).
> 
> 
>>
>>
>>> +struct tmc_crash_metadata {
>>> +	uint32_t crc32_mdata;	/* crc of metadata */
>>> +	uint32_t crc32_tdata;	/* crc of tracedata */
>>
>> 	uint32_t version;	/* Version of the structure = 1 */
> 
> Ack.
> 
>>
>>> +	uint32_t valid;         /* Indicate if this ETF/ETR was enabled */
>>> +	uint32_t size;          /* Ram Size register */
>>
>> Please save the size in bytes and also rename it :
>>
>> 	uint32_t trace_size;	/* Trace size in Bytes */
> 
> The idea was to only take a register snapshot by kernel/firmware at the time of
> panic/watchdog reset and thought that keeping that panic handler/watchdog reset
> handler without any conversions would be better when external entities like firmware
> is involved.
> 
> Please let me know if you still prefer adding this field.
> 
>>
>>
>>> +	uint32_t sts;           /* Status register */
>>> +	uint32_t reserved32[3];
>>> +	uint64_t rrp;           /* Ram Read pointer register */
>>> +	uint64_t rwp;           /* Ram Write pointer register */
>>
>>
>>
>>> +	uint64_t dba;		/* Data buffer address register */
>>
>> Is this field useful ? And we store RRP/RWP relative to the DBA ? Could
> 
> RRP/RWP/DBA fields are just register snapshots.
> Yes we use the DBA to calculate offsets. 
> ie. etr_buf->offset = rrp - dba;
> 
> 
>> we instead :
>>
>> 1. Drop DBA
>> 2. Store RRP and RWP as offsets from DBA. Or even convert them to the
>> actual PADDRs relative to the trc_paddr.
> 
> Converting to actual PADDRs would be difficult in case of watchdog reset
> scenarios where firmware is involved.
> 
>>
>> DBA could be a "DMA" Address and not necessarily the PA Address.
>> We already have the trc_paddr below. (And for ETF, we already copy
>> the buffer to the reserved buffer). So all the user needs to know
>> is where the pointers are within the buffer. Having them relative
>> to the "actual" location of the buffer is much useful than basing
>> it on some unusable base address.
> 
> As pointed out above, the idea was to only take a register snapshot without
> any conversions. Please let me know if you still prefer dropping the DBA.
> 
>>
>>> +	uint64_t trc_paddr;	/* Phys address of trace buffer */
>>
>> s/trc/trace
>>
>> Move RRP and RWP, after the above field.
>>
>> For the sake of completeness, you are also missing :
>>
>> 1) FFCR register => That tells you whether the Formatting was enabled or not
>> (among other things) ? Though we always enable it, its good to
>> capture it, if we ever decide to turn off the formatting.
>>
>>
>> 2) MODE => Which mode was selected. Again, CIRCULAR_BUFFER for now,
>> but lets seal it for the future, so that you can infer the trace buffer
>> correctly with RRP/RWP.
>>
>> 3) And may be FFSR, just in case the flush never completed and the
>> data is not reliable ?
> 
> Sure will add the above three fields.
> 
>>
>>> +	uint64_t reserved64[3];
>>> +};
>>
>>
>>
>>
>>> +
>>>   enum etr_mode {
>>>   	ETR_MODE_FLAT,		/* Uses contiguous flat buffer */
>>>   	ETR_MODE_ETR_SG,	/* Uses in-built TMC ETR SG mechanism */
>>> @@ -204,6 +223,8 @@ struct tmc_resrv_buf {
>>>    *		retention (after crash) only when ETR_MODE_RESRV buffer
>>>    *		mode is enabled. Used by ETF for trace data retention
>>>    *		(after crash) by default.
>>> + * @crash_mdata: Reserved memory for storing tmc crash metadata.
>>> + *		 Used by ETR/ETF.
>>>    */
>>>   struct tmc_drvdata {
>>>   	struct clk		*pclk;
>>> @@ -230,6 +251,7 @@ struct tmc_drvdata {
>>>   	struct etr_buf		*sysfs_buf;
>>>   	struct etr_buf		*perf_buf;
>>>   	struct tmc_resrv_buf	crash_tbuf;
>>> +	struct tmc_resrv_buf	crash_mdata;
>>>   };
>>>   struct etr_buf_operations {
>>> @@ -352,11 +374,32 @@ static inline bool is_tmc_reserved_region_valid(struct device *dev)
>>>   	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
>>>   	if (drvdata->crash_tbuf.paddr &&
>>> -		drvdata->crash_tbuf.size)
>>> +		drvdata->crash_tbuf.size &&
>>> +		drvdata->crash_mdata.paddr &&
>>> +		drvdata->crash_mdata.size)
>>
>> Why do we need to tie the "reserved" region to metdata region availability ?
>> It is perfectly possible for another usecase
>> to dedicate a buffer for trace and use it without metadata ?
> 
> Okay that can be reworked.
> 

Wouldn't that be the same as the old sysfs mode? Without the metadata
does it do anything different functionally? I'm wondering if it's worth
the extra complexity to implement and test two modes (with and without
metadata).

James

