Return-Path: <linux-kernel+bounces-222034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E16E190FBDB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D75C1F2365E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 04:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA1628E37;
	Thu, 20 Jun 2024 04:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hWRt9ul/"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906B11DA4E;
	Thu, 20 Jun 2024 04:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718856676; cv=none; b=FsKnEl8KOxj6hRwyKgK+1xonoGX409+iUBOX9IAw+ALqqYC9I/EZ6kZ2R+RjzERqeTtmNrvJu8/16aOGA6fGVerU6MJjjauaM/snM38oMDpDNZLVWhpkOdVwZ/2htBw1Bg42t2YAiJgQEmxyV8yBs7RuMs1bSq+B8W8Tuvl6xy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718856676; c=relaxed/simple;
	bh=zkbBbq6pZrWkU9o/iZGD2W4wFbko0wpspMAHFXB8IJk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rL+WtydtAdjCx7luHlX+IYlj21kQ98BBPQc4eOKHdQDlUPI3M1eN6jKO+hTF+x2PTz+Z3qF0fHtoyHW5h8tsJnwviy4i91CIdVL4zaKW/WakNzIGN8hfdPQvimyILIb0uBpt9zBMUw4JaCK71TymmtUJlPdMkp65Kwl4bNqb/ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hWRt9ul/; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K2BDpG011177;
	Wed, 19 Jun 2024 21:11:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=XWnj4ONUS/ovCa4f3QMkVHdw/
	rulYtFuoQI/7xgK/EM=; b=hWRt9ul/knNg1ldSxlpYHUnmbx5xjjppHCrGWxNQz
	LwMUSciNIDrbXXdM0rKoGiKlNFehidS5n4cwWHwPJVD6RlCd81Jpk8gQXBrNZiMX
	57kbogMcnexY8M6ZQZOEtKM76ME2u3mFt0zivCbkkgfruwmLxWnEgPegDK44g7+e
	PeNLTsA4o4DUx3tDC9sH0waeJFNz3dqh+vuzSACW4rNjiAqZZ4dtvQ4+vNZYJfkZ
	jDsbC+XTg5GkoFg7y22+X8zXL1B0/sqS8TnNZ3Lr7mq4B6+4Kw6ofuO+fErRnD3P
	PQLcI9SSG34CmIwGNwnCzDdiD9r4Z57krYyIJADTbXfPA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yvbdy8999-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 21:11:00 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 19 Jun 2024 21:10:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 19 Jun 2024 21:10:59 -0700
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with SMTP id 9A76B3F704D;
	Wed, 19 Jun 2024 21:10:55 -0700 (PDT)
Date: Thu, 20 Jun 2024 09:40:54 +0530
From: Linu Cherian <lcherian@marvell.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
CC: <mike.leach@linaro.org>, <james.clark@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>
Subject: Re: [PATCH v9 4/7] coresight: tmc: Enable panic sync handling
Message-ID: <20240620041054.GC125816@hyd1403.caveonetworks.com>
References: <20240605081725.622953-1-lcherian@marvell.com>
 <20240605081725.622953-5-lcherian@marvell.com>
 <f885b6df-e9c4-4c19-9587-b4e0c84d31c4@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f885b6df-e9c4-4c19-9587-b4e0c84d31c4@arm.com>
X-Proofpoint-ORIG-GUID: toJOU_80aYEqhuGBzHjHp-mvF4slYOQM
X-Proofpoint-GUID: toJOU_80aYEqhuGBzHjHp-mvF4slYOQM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_01,2024-06-19_01,2024-05-17_01

On 2024-06-10 at 18:32:33, Suzuki K Poulose (suzuki.poulose@arm.com) wrote:
> On 05/06/2024 09:17, Linu Cherian wrote:
> > - Get reserved region from device tree node for metadata
> > - Define metadata format for TMC
> > - Add TMC ETR panic sync handler that syncs register snapshot
> >    to metadata region
> > - Add TMC ETF panic sync handler that syncs register snapshot
> >    to metadata region and internal SRAM to reserved trace buffer
> >    region.
> > 
> > Signed-off-by: Linu Cherian <lcherian@marvell.com>
> > Reviewed-by: James Clark <james.clark@arm.com>
> > ---
> > Changelog from v8:
> > Added Reviewed-by tag.
> > 
> >   .../hwtracing/coresight/coresight-tmc-core.c  | 25 +++++++
> >   .../hwtracing/coresight/coresight-tmc-etf.c   | 72 +++++++++++++++++++
> >   .../hwtracing/coresight/coresight-tmc-etr.c   | 70 ++++++++++++++++++
> >   drivers/hwtracing/coresight/coresight-tmc.h   | 45 +++++++++++-
> >   4 files changed, 211 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> > index 6beb69d74d0a..daad08bc693d 100644
> > --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> > @@ -443,6 +443,31 @@ static void tmc_get_reserved_region(struct device *parent)
> >   	drvdata->crash_tbuf.paddr = res.start;
> >   	drvdata->crash_tbuf.size  = resource_size(&res);
> > +
> > +	/* Metadata region */
> > +	node = tmc_get_region_byname(parent->of_node, "metadata");
> > +	if (IS_ERR_OR_NULL(node)) {
> > +		dev_dbg(parent, "No metadata memory-region specified\n");
> > +		return;
> > +	}
> > +
> > +	rc = of_address_to_resource(node, 0, &res);
> > +	of_node_put(node);
> > +	if (rc || res.start == 0 || resource_size(&res) == 0) {
> > +		dev_err(parent, "Metadata memory is invalid\n");
> > +		return;
> > +	}
> > +
> > +	drvdata->crash_mdata.vaddr = memremap(res.start,
> > +					       resource_size(&res),
> > +					       MEMREMAP_WC);
> > +	if (IS_ERR_OR_NULL(drvdata->crash_mdata.vaddr)) {
> > +		dev_err(parent, "Metadata memory mapping failed\n");
> > +		return;
> > +	}
> > +
> > +	drvdata->crash_mdata.paddr = res.start;
> > +	drvdata->crash_mdata.size  = resource_size(&res);
> >   }
> >   /* Detect and initialise the capabilities of a TMC ETR */
> > diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> > index d4f641cd9de6..f9569585e9f8 100644
> > --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> > +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> > @@ -590,6 +590,73 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
> >   	return to_read;
> >   }
> > +static int tmc_panic_sync_etf(struct coresight_device *csdev)
> > +{
> > +	u32 val;
> > +	struct csdev_access *csa;
> > +	struct tmc_crash_metadata *mdata;
> > +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> > +
> > +	csa = &drvdata->csdev->access;
> > +
> > +	/* Make sure we have valid reserved memory */
> > +	if (!is_tmc_reserved_region_valid(csdev->dev.parent))
> > +		return 0;
> > +
> > +	mdata = (struct tmc_crash_metadata *)drvdata->crash_mdata.vaddr;
> > +	mdata->valid = false;
> > +
> > +	CS_UNLOCK(drvdata->base);
> > +
> > +	/* Proceed only if ETF is enabled or configured as sink */
> > +	val = readl(drvdata->base + TMC_CTL);
> > +	if (!(val & TMC_CTL_CAPT_EN))
> > +		goto out;
> > +
> > +	val = readl(drvdata->base + TMC_MODE);
> > +	if (val != TMC_MODE_CIRCULAR_BUFFER)
> > +		goto out;
> > +
> > +	val = readl(drvdata->base + TMC_FFSR);
> > +	/* Do manual flush and stop only if its not auto-stopped */
> > +	if (!(val & TMC_FFSR_FT_STOPPED)) {
> > +		dev_info(&csdev->dev,
> > +			 "%s: Triggering manual flush\n", __func__);
> > +		tmc_flush_and_stop(drvdata);
> > +	} else
> > +		tmc_wait_for_tmcready(drvdata);
> > +
> > +	/* Sync registers from hardware to metadata region */
> > +	mdata->sts = csdev_access_relaxed_read32(csa, TMC_STS);
> > +	mdata->trc_paddr = drvdata->crash_tbuf.paddr;
> > +
> > +	/* Sync Internal SRAM to reserved trace buffer region */
> > +	drvdata->buf = drvdata->crash_tbuf.vaddr;
> > +	tmc_etb_dump_hw(drvdata);
> > +	/* Store as per RSZ register convention */
> > +	mdata->size = drvdata->len >> 2;
> > +
> > +	/*
> > +	 * Make sure all previous writes are completed,
> > +	 * before we mark valid
> > +	 */
> > +	dsb(sy);
> > +	mdata->valid = true;
> > +	/*
> > +	 * Below order need to maintained, since crc of metadata
> > +	 * is dependent on first
> > +	 */
> > +	mdata->crc32_tdata = find_crash_tracedata_crc(drvdata, mdata);
> > +	mdata->crc32_mdata = find_crash_metadata_crc(mdata);
> > +
> > +	tmc_disable_hw(drvdata);
> > +
> > +	dev_info(&csdev->dev, "%s: success\n", __func__);
> > +out:
> > +	CS_UNLOCK(drvdata->base);
> > +	return 0;
> > +}
> > +
> >   static const struct coresight_ops_sink tmc_etf_sink_ops = {
> >   	.enable		= tmc_enable_etf_sink,
> >   	.disable	= tmc_disable_etf_sink,
> > @@ -603,6 +670,10 @@ static const struct coresight_ops_link tmc_etf_link_ops = {
> >   	.disable	= tmc_disable_etf_link,
> >   };
> > +static const struct coresight_ops_panic tmc_etf_sync_ops = {
> > +	.sync		= tmc_panic_sync_etf,
> > +};
> > +
> >   const struct coresight_ops tmc_etb_cs_ops = {
> >   	.sink_ops	= &tmc_etf_sink_ops,
> >   };
> > @@ -610,6 +681,7 @@ const struct coresight_ops tmc_etb_cs_ops = {
> >   const struct coresight_ops tmc_etf_cs_ops = {
> >   	.sink_ops	= &tmc_etf_sink_ops,
> >   	.link_ops	= &tmc_etf_link_ops,
> > +	.panic_ops	= &tmc_etf_sync_ops,
> >   };
> >   int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
> > diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> > index 041c428dd7cd..be1079e8fd64 100644
> > --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> > +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> > @@ -1813,6 +1813,71 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
> >   	return 0;
> >   }
> > +static int tmc_panic_sync_etr(struct coresight_device *csdev)
> > +{
> > +	u32 val;
> > +	struct csdev_access *csa;
> > +	struct tmc_crash_metadata *mdata;
> > +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> > +
> > +	csa = &drvdata->csdev->access;
> > +
> > +	if (!drvdata->etr_buf)
> > +		return 0;
> > +
> > +	/* Being in RESRV mode implies valid reserved memory as well */
> > +	if (drvdata->etr_buf->mode != ETR_MODE_RESRV)
> > +		return 0;
> > +
> > +	mdata = (struct tmc_crash_metadata *)drvdata->crash_mdata.vaddr;
> > +	mdata->valid = false;
> > +
> > +	CS_UNLOCK(drvdata->base);
> > +
> > +	/* Proceed only if ETR is enabled */
> > +	val = readl(drvdata->base + TMC_CTL);
> > +	if (!(val & TMC_CTL_CAPT_EN))
> > +		goto out;
> > +
> > +	val = readl(drvdata->base + TMC_FFSR);
> > +	/* Do manual flush and stop only if its not auto-stopped */
> > +	if (!(val & TMC_FFSR_FT_STOPPED)) {
> > +		dev_info(&csdev->dev,
> > +			 "%s: Triggering manual flush\n", __func__);
> > +		tmc_flush_and_stop(drvdata);
> > +	} else
> > +		tmc_wait_for_tmcready(drvdata);
> > +
> > +	/* Sync registers from hardware to metadata region */
> > +	mdata->size = csdev_access_relaxed_read32(csa, TMC_RSZ);
> > +	mdata->sts = csdev_access_relaxed_read32(csa, TMC_STS);
> > +	mdata->rrp = tmc_read_rrp(drvdata);
> > +	mdata->rwp = tmc_read_rwp(drvdata);
> > +	mdata->dba = tmc_read_dba(drvdata);
> > +	mdata->trc_paddr = drvdata->crash_tbuf.paddr;
> > +
> > +	/*
> > +	 * Make sure all previous writes are completed,
> > +	 * before we mark valid
> > +	 */
> > +	dsb(sy);
> > +	mdata->valid = true;
> > +	/*
> > +	 * Below order need to maintained, since crc of metadata
> > +	 * is dependent on first
> > +	 */
> > +	mdata->crc32_tdata = find_crash_tracedata_crc(drvdata, mdata);
> > +	mdata->crc32_mdata = find_crash_metadata_crc(mdata);
> > +
> > +	tmc_disable_hw(drvdata);
> > +
> > +	dev_info(&csdev->dev, "%s: success\n", __func__);
> > +out:
> > +	CS_UNLOCK(drvdata->base);
> > +
> > +	return 0;
> > +}
> > +
> >   static const struct coresight_ops_sink tmc_etr_sink_ops = {
> >   	.enable		= tmc_enable_etr_sink,
> >   	.disable	= tmc_disable_etr_sink,
> > @@ -1821,8 +1886,13 @@ static const struct coresight_ops_sink tmc_etr_sink_ops = {
> >   	.free_buffer	= tmc_free_etr_buffer,
> >   };
> > +static const struct coresight_ops_panic tmc_etr_sync_ops = {
> > +	.sync		= tmc_panic_sync_etr,
> > +};
> > +
> >   const struct coresight_ops tmc_etr_cs_ops = {
> >   	.sink_ops	= &tmc_etr_sink_ops,
> > +	.panic_ops	= &tmc_etr_sync_ops,
> >   };
> >   int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
> > diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> > index c23dc9917ab9..35beee53584a 100644
> > --- a/drivers/hwtracing/coresight/coresight-tmc.h
> > +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> > @@ -12,6 +12,7 @@
> >   #include <linux/miscdevice.h>
> >   #include <linux/mutex.h>
> >   #include <linux/refcount.h>
> > +#include <linux/crc32.h>
> >   #define TMC_RSZ			0x004
> >   #define TMC_STS			0x00c
> > @@ -76,6 +77,9 @@
> >   #define TMC_AXICTL_AXCACHE_OS	(0xf << 2)
> >   #define TMC_AXICTL_ARCACHE_OS	(0xf << 16)
> > +/* TMC_FFSR - 0x300 */
> > +#define TMC_FFSR_FT_STOPPED	BIT(1)
> > +
> >   /* TMC_FFCR - 0x304 */
> >   #define TMC_FFCR_FLUSHMAN_BIT	6
> >   #define TMC_FFCR_EN_FMT		BIT(0)
> > @@ -131,6 +135,21 @@ enum tmc_mem_intf_width {
> >   #define CORESIGHT_SOC_600_ETR_CAPS	\
> >   	(TMC_ETR_SAVE_RESTORE | TMC_ETR_AXI_ARCACHE)
> 
> 
> 
> 
> > +/* TMC metadata region for ETR and ETF configurations */
> 
> I strongly think we should version the data layout to handle
> the future changes better (if at all).


> 
> 
> > +struct tmc_crash_metadata {
> > +	uint32_t crc32_mdata;	/* crc of metadata */
> > +	uint32_t crc32_tdata;	/* crc of tracedata */
> 
> 	uint32_t version;	/* Version of the structure = 1 */

Ack.

> 
> > +	uint32_t valid;         /* Indicate if this ETF/ETR was enabled */
> > +	uint32_t size;          /* Ram Size register */
> 
> Please save the size in bytes and also rename it :
> 
> 	uint32_t trace_size;	/* Trace size in Bytes */

The idea was to only take a register snapshot by kernel/firmware at the time of
panic/watchdog reset and thought that keeping that panic handler/watchdog reset
handler without any conversions would be better when external entities like firmware
is involved.

Please let me know if you still prefer adding this field.

> 
> 
> > +	uint32_t sts;           /* Status register */
> > +	uint32_t reserved32[3];
> > +	uint64_t rrp;           /* Ram Read pointer register */
> > +	uint64_t rwp;           /* Ram Write pointer register */
> 
> 
> 
> > +	uint64_t dba;		/* Data buffer address register */
> 
> Is this field useful ? And we store RRP/RWP relative to the DBA ? Could

RRP/RWP/DBA fields are just register snapshots.
Yes we use the DBA to calculate offsets. 
ie. etr_buf->offset = rrp - dba;


> we instead :
> 
> 1. Drop DBA
> 2. Store RRP and RWP as offsets from DBA. Or even convert them to the
> actual PADDRs relative to the trc_paddr.

Converting to actual PADDRs would be difficult in case of watchdog reset
scenarios where firmware is involved.

> 
> DBA could be a "DMA" Address and not necessarily the PA Address.
> We already have the trc_paddr below. (And for ETF, we already copy
> the buffer to the reserved buffer). So all the user needs to know
> is where the pointers are within the buffer. Having them relative
> to the "actual" location of the buffer is much useful than basing
> it on some unusable base address.

As pointed out above, the idea was to only take a register snapshot without
any conversions. Please let me know if you still prefer dropping the DBA.

> 
> > +	uint64_t trc_paddr;	/* Phys address of trace buffer */
> 
> s/trc/trace
> 
> Move RRP and RWP, after the above field.
> 
> For the sake of completeness, you are also missing :
> 
> 1) FFCR register => That tells you whether the Formatting was enabled or not
> (among other things) ? Though we always enable it, its good to
> capture it, if we ever decide to turn off the formatting.
> 
> 
> 2) MODE => Which mode was selected. Again, CIRCULAR_BUFFER for now,
> but lets seal it for the future, so that you can infer the trace buffer
> correctly with RRP/RWP.
> 
> 3) And may be FFSR, just in case the flush never completed and the
> data is not reliable ?

Sure will add the above three fields.

> 
> > +	uint64_t reserved64[3];
> > +};
> 
> 
> 
> 
> > +
> >   enum etr_mode {
> >   	ETR_MODE_FLAT,		/* Uses contiguous flat buffer */
> >   	ETR_MODE_ETR_SG,	/* Uses in-built TMC ETR SG mechanism */
> > @@ -204,6 +223,8 @@ struct tmc_resrv_buf {
> >    *		retention (after crash) only when ETR_MODE_RESRV buffer
> >    *		mode is enabled. Used by ETF for trace data retention
> >    *		(after crash) by default.
> > + * @crash_mdata: Reserved memory for storing tmc crash metadata.
> > + *		 Used by ETR/ETF.
> >    */
> >   struct tmc_drvdata {
> >   	struct clk		*pclk;
> > @@ -230,6 +251,7 @@ struct tmc_drvdata {
> >   	struct etr_buf		*sysfs_buf;
> >   	struct etr_buf		*perf_buf;
> >   	struct tmc_resrv_buf	crash_tbuf;
> > +	struct tmc_resrv_buf	crash_mdata;
> >   };
> >   struct etr_buf_operations {
> > @@ -352,11 +374,32 @@ static inline bool is_tmc_reserved_region_valid(struct device *dev)
> >   	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
> >   	if (drvdata->crash_tbuf.paddr &&
> > -		drvdata->crash_tbuf.size)
> > +		drvdata->crash_tbuf.size &&
> > +		drvdata->crash_mdata.paddr &&
> > +		drvdata->crash_mdata.size)
> 
> Why do we need to tie the "reserved" region to metdata region availability ?
> It is perfectly possible for another usecase
> to dedicate a buffer for trace and use it without metadata ?

Okay that can be reworked.

> 
> Suzuki
> 
> 
> >   		return true;
> >   	return false;
> >   }
> > +static inline uint32_t find_crash_metadata_crc(struct tmc_crash_metadata *md)
> > +{
> > +	unsigned long crc_size;
> > +
> > +	crc_size = sizeof(struct tmc_crash_metadata) -
> > +		offsetof(struct tmc_crash_metadata, crc32_tdata);
> > +	return crc32_le(0, (void *)&md->crc32_tdata, crc_size);
> > +}
> > +
> > +static inline uint32_t find_crash_tracedata_crc(struct tmc_drvdata *drvdata,
> > +						struct tmc_crash_metadata *md)
> > +{
> > +	unsigned long crc_size;
> > +
> > +	/* Take CRC of configured buffer size to keep it simple */
> > +	crc_size = md->size << 2;
> > +	return crc32_le(0, (void *)drvdata->crash_tbuf.vaddr, crc_size);
> > +}
> > +
> >   struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
> >   void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu);
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

