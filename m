Return-Path: <linux-kernel+bounces-386382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2909B42B8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7F2281521
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0594200BB7;
	Tue, 29 Oct 2024 07:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hkcIfJqd"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2021DED6B;
	Tue, 29 Oct 2024 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730185223; cv=none; b=DlGg8f/oJWON+VO44W7eBuUk8GcKuPgQuEkQ6TvN6n1RYASP2eS07TIP03yg2I1dBO3JvBxHxCw5CKkXK9W6/16EJHo1g5pO1MMFHYNKAEwefye0sYacQX6laBFC+TahfWdKTNzEsqyTF5PHkEIA/+1z9F+wy/1WhWzWRmbKHvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730185223; c=relaxed/simple;
	bh=2usq/j3w0o7NMzz2zJBpQqw7GKmCthgcv6aQ4u1GSf8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9cuOliJCt7SX2gQtlOBShZZ1U/8D2vvj4mHaSPaz8w0Tfkty6qu4fmOubqaBAScgnlKQE4zzMpL9ghsu8q+5IZxIVCWs+XSiGwDFzy/XMJkZmkozJcYy3GM4JLzJ6VpB7zOKaCXZq5rdYosU9HI/E82i8gRTBkauxMFpy84F+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hkcIfJqd; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SGnAV9020366;
	Tue, 29 Oct 2024 00:00:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=r/d++t72qxiSMU9ynlig/eIK1
	G088S4b/H+mGkfwHJQ=; b=hkcIfJqdgV6rqKhtPy1Q9z9tK1W8dz9M3bEgV7I1k
	iXiQ/wVExdUte3HC7EDVqsvmoijWa2ArUvohJpGMP9/yTuKVDTRTi3KawpDI3win
	AB+57OD3/w6bjMsLgK2pEYzOZif//qCVYzw+M5xsyyS1artUi+B6K8wfpQI22DFO
	JZ3BBvXsQSxWgCODjOypYGRAkMDHUNXkRKsXSZwH90gDezUvbLpdzRkPTU9pmJkX
	SycSCJnXf3cEx7H1J7QHjoY7aWSkkn0vG8OE1bC09nKdcPSEO8wveTk/TxMsNOxc
	N19rOkjXf9ms+lVnBNRi6Xg1LhbGw4F7NU3WSNXIvcF4A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42gyxf5pjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 00:00:06 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 29 Oct 2024 00:00:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 29 Oct 2024 00:00:01 -0700
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with SMTP id D6EA55E68A7;
	Mon, 28 Oct 2024 23:59:56 -0700 (PDT)
Date: Tue, 29 Oct 2024 12:29:55 +0530
From: Linu Cherian <lcherian@marvell.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
CC: <mike.leach@linaro.org>, <james.clark@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>
Subject: Re: [PATCH v10 4/8] coresight: tmc: Enable panic sync handling
Message-ID: <20241029065955.GA978983@hyd1403.caveonetworks.com>
References: <20240916103437.226816-1-lcherian@marvell.com>
 <20240916103437.226816-5-lcherian@marvell.com>
 <6b405b22-9b1e-487b-9b9c-5944358488e2@arm.com>
 <20241017121221.GA901001@hyd1403.caveonetworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241017121221.GA901001@hyd1403.caveonetworks.com>
X-Proofpoint-ORIG-GUID: v2fQmBp5gRzZRNhSFUCvhCtgPOaqssTc
X-Proofpoint-GUID: v2fQmBp5gRzZRNhSFUCvhCtgPOaqssTc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi Suzuki,

On 2024-10-17 at 17:42:21, Linu Cherian (lcherian@marvell.com) wrote:
> Hi Suzuki,
> 
> On 2024-10-01 at 22:13:12, Suzuki K Poulose (suzuki.poulose@arm.com) wrote:
> > Hi Linu
> > 
> > On 16/09/2024 11:34, Linu Cherian wrote:
> > > - Get reserved region from device tree node for metadata
> > > - Define metadata format for TMC
> > > - Add TMC ETR panic sync handler that syncs register snapshot
> > >    to metadata region
> > > - Add TMC ETF panic sync handler that syncs register snapshot
> > >    to metadata region and internal SRAM to reserved trace buffer
> > >    region.
> > 
> > The patch looks good overall. Some minor comments below.
> > 
> > > 
> > > Signed-off-by: Linu Cherian <lcherian@marvell.com>
> > > ---
> > > Changelog from v9:
> > > - Add common helper function of_tmc_get_reserved_resource_by_name
> > >    for better code reuse
> > > - Inorder to keep the reserved buffer validity and crashdata validity
> > >    independent, is_tmc_reserved_region_valid renamed to tmc_has_reserved_buffer
> > > - drvdata->crash_tbuf renamed to drvdata->resrv_buf
> > > - New fields added to crash metadata: version, ffcr, ffsr, mode
> > > - Defined crashdata version with Major version 1, Minor version 0
> > > - Set version while creating crashdata record
> > > - Removed Reviewed-by tag due to the above changes
> > >   .../hwtracing/coresight/coresight-tmc-core.c  | 14 ++++
> > >   .../hwtracing/coresight/coresight-tmc-etf.c   | 77 ++++++++++++++++++
> > >   .../hwtracing/coresight/coresight-tmc-etr.c   | 78 +++++++++++++++++++
> > >   drivers/hwtracing/coresight/coresight-tmc.h   | 66 ++++++++++++++++
> > >   4 files changed, 235 insertions(+)
> > > 
> > > diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> > > index 0764c21aba0f..54bf8ae2bff8 100644
> > > --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> > > +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> > > @@ -445,6 +445,20 @@ static void tmc_get_reserved_region(struct device *parent)
> > >   	drvdata->resrv_buf.paddr = res.start;
> > >   	drvdata->resrv_buf.size  = resource_size(&res);
> > > +
> > > +	if (of_tmc_get_reserved_resource_by_name(parent, "metadata", &res))
> > > +		return;
> > > +
> > > +	drvdata->crash_mdata.vaddr = memremap(res.start,
> > > +					       resource_size(&res),
> > > +					       MEMREMAP_WC);
> > > +	if (IS_ERR_OR_NULL(drvdata->crash_mdata.vaddr)) {
> > > +		dev_err(parent, "Metadata memory mapping failed\n");
> > > +		return;
> > > +	}
> > > +
> > > +	drvdata->crash_mdata.paddr = res.start;
> > > +	drvdata->crash_mdata.size  = resource_size(&res);
> > >   }
> > >   /* Detect and initialise the capabilities of a TMC ETR */
> > > diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> > > index d4f641cd9de6..d77ec9307e98 100644
> > > --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> > > +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> > > @@ -590,6 +590,78 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
> > >   	return to_read;
> > >   }
> > > +static int tmc_panic_sync_etf(struct coresight_device *csdev)
> > > +{
> > > +	u32 val;
> > > +	struct csdev_access *csa;
> > > +	struct tmc_crash_metadata *mdata;
> > > +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> > > +
> > > +	csa = &drvdata->csdev->access;
> > > +	mdata = (struct tmc_crash_metadata *)drvdata->crash_mdata.vaddr;
> > > +
> > > +	/* Make sure we have valid reserved memory */
> > > +	if (!tmc_has_reserved_buffer(drvdata) ||
> > > +	    !tmc_has_crash_mdata_buffer(drvdata))
> > > +		return 0;
> > > +
> > > +	tmc_crashdata_set_invalid(drvdata);
> > > +
> > > +	CS_UNLOCK(drvdata->base);
> > > +
> > > +	/* Proceed only if ETF is enabled or configured as sink */
> > > +	val = readl(drvdata->base + TMC_CTL);
> > > +	if (!(val & TMC_CTL_CAPT_EN))
> > > +		goto out;
> > > +
> > 
> > minor nit : Since the check below is "covered" by the same comment
> > above, please drop the extra line here to make it clear that "we check
> > for sink" by checking the "MODE == CIRCULAR_BUFFER".
> 
> Ack.
> 
> > 
> > > +	val = readl(drvdata->base + TMC_MODE);
> > > +	if (val != TMC_MODE_CIRCULAR_BUFFER)
> > > +		goto out;
> > > +
> > > +	val = readl(drvdata->base + TMC_FFSR);
> > > +	/* Do manual flush and stop only if its not auto-stopped */
> > > +	if (!(val & TMC_FFSR_FT_STOPPED)) {
> > > +		dev_info(&csdev->dev,
> > > +			 "%s: Triggering manual flush\n", __func__);
> > 
> > Please drop the ^^^ line. We don't want to do anything like that from a
> > panic callback.
> 
> Ack.
> 
> > 
> > > +		tmc_flush_and_stop(drvdata);
> > > +	} else
> > > +		tmc_wait_for_tmcready(drvdata);
> > > +
> > > +	/* Sync registers from hardware to metadata region */
> > > +	mdata->sts = csdev_access_relaxed_read32(csa, TMC_STS);
> > 
> > Why are we using "csa" here and not for TMC_CTL etc ? Simply drop the "csa"
> > and use the raw reads like above. TMC doesn't have anyother modes
> > of access.
> > 
> 
> Okay.
> 
> > > +	mdata->mode = csdev_access_relaxed_read32(csa, TMC_MODE);
> > > +	mdata->ffcr = csdev_access_relaxed_read32(csa, TMC_FFCR);
> > > +	mdata->ffsr = csdev_access_relaxed_read32(csa, TMC_FFSR);
> > > +	mdata->trace_paddr = drvdata->resrv_buf.paddr;
> > > +
> > > +	/* Sync Internal SRAM to reserved trace buffer region */
> > > +	drvdata->buf = drvdata->resrv_buf.vaddr;
> > > +	tmc_etb_dump_hw(drvdata);
> > > +	/* Store as per RSZ register convention */
> > > +	mdata->size = drvdata->len >> 2;
> > > +	mdata->version = CS_CRASHDATA_VERSION;
> > > +
> > > +	/*
> > > +	 * Make sure all previous writes are completed,
> > > +	 * before we mark valid
> > > +	 */
> > > +	dsb(sy);
> > 
> > I don't think this matters much, as this would only be read by a
> > secondary kernel. In the worst case, you only need `dmb(ish)` to make
> > sure the writes are visible before valid is set to true.
> 
> Ack. Will change that.
> 
> > 
> > > +	mdata->valid = true;
> > > +	/*
> > > +	 * Below order need to maintained, since crc of metadata
> > > +	 * is dependent on first
> > > +	 */
> > > +	mdata->crc32_tdata = find_crash_tracedata_crc(drvdata, mdata);
> > > +	mdata->crc32_mdata = find_crash_metadata_crc(mdata);
> > > +
> > > +	tmc_disable_hw(drvdata);
> > > +
> > > +	dev_info(&csdev->dev, "%s: success\n", __func__);
> > 
> > Please no "prints" from a panic call back, unless it absolutely CRITICAL.
> 
> Ack.
> 
> > 
> > > +out:
> > > +	CS_UNLOCK(drvdata->base);
> > > +	return 0;
> > > +}
> > > +
> > >   static const struct coresight_ops_sink tmc_etf_sink_ops = {
> > >   	.enable		= tmc_enable_etf_sink,
> > >   	.disable	= tmc_disable_etf_sink,
> > > @@ -603,6 +675,10 @@ static const struct coresight_ops_link tmc_etf_link_ops = {
> > >   	.disable	= tmc_disable_etf_link,
> > >   };
> > > +static const struct coresight_ops_panic tmc_etf_sync_ops = {
> > > +	.sync		= tmc_panic_sync_etf,
> > > +};
> > > +
> > >   const struct coresight_ops tmc_etb_cs_ops = {
> > >   	.sink_ops	= &tmc_etf_sink_ops,
> > >   };
> > > @@ -610,6 +686,7 @@ const struct coresight_ops tmc_etb_cs_ops = {
> > >   const struct coresight_ops tmc_etf_cs_ops = {
> > >   	.sink_ops	= &tmc_etf_sink_ops,
> > >   	.link_ops	= &tmc_etf_link_ops,
> > > +	.panic_ops	= &tmc_etf_sync_ops,
> > >   };
> > >   int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
> > > diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> > > index 8bca5b36334a..8228d7aaa361 100644
> > > --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> > > +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> > > @@ -1814,6 +1814,79 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
> > >   	return 0;
> > >   }
> > > +static int tmc_panic_sync_etr(struct coresight_device *csdev)
> > > +{
> > > +	u32 val;
> > > +	struct csdev_access *csa;
> > > +	struct tmc_crash_metadata *mdata;
> > > +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> > > +
> > > +	csa = &drvdata->csdev->access;
> > 
> > As earlier, drop the csa.
> 
> 
> Okay.
> 
> > 
> > > +	mdata = (struct tmc_crash_metadata *)drvdata->crash_mdata.vaddr;
> > > +
> > > +	if (!drvdata->etr_buf)
> > > +		return 0;
> > > +
> > > +	/* Being in RESRV mode implies valid reserved memory as well */
> > > +	if (drvdata->etr_buf->mode != ETR_MODE_RESRV)
> > > +		return 0;
> > > +
> > > +	if (!tmc_has_reserved_buffer(drvdata) ||
> > 
> > Do we need to check this again ? We wouldn't be in ETR_MODE_RESRV
> > otherwise, also indicated by the comment.
> 
> Will drop.
> 
> > 
> > > +	    !tmc_has_crash_mdata_buffer(drvdata))
> > > +		return 0;
> > > +
> > > +	tmc_crashdata_set_invalid(drvdata);
> > > +
> > > +	CS_UNLOCK(drvdata->base);
> > > +
> > > +	/* Proceed only if ETR is enabled */
> > > +	val = readl(drvdata->base + TMC_CTL);
> > > +	if (!(val & TMC_CTL_CAPT_EN))
> > > +		goto out;
> > > +
> > > +	val = readl(drvdata->base + TMC_FFSR);
> > > +	/* Do manual flush and stop only if its not auto-stopped */
> > > +	if (!(val & TMC_FFSR_FT_STOPPED)) {
> > > +		dev_info(&csdev->dev,
> > > +			 "%s: Triggering manual flush\n", __func__);
> > 
> > Drop the info
> 
> Ack.
> 
> > 
> > > +		tmc_flush_and_stop(drvdata);
> > > +	} else
> > > +		tmc_wait_for_tmcready(drvdata);
> > > +
> > > +	/* Sync registers from hardware to metadata region */
> > > +	mdata->size = csdev_access_relaxed_read32(csa, TMC_RSZ);
> > > +	mdata->sts = csdev_access_relaxed_read32(csa, TMC_STS);
> > > +	mdata->mode = csdev_access_relaxed_read32(csa, TMC_MODE);
> > > +	mdata->ffcr = csdev_access_relaxed_read32(csa, TMC_FFCR);
> > > +	mdata->ffsr = csdev_access_relaxed_read32(csa, TMC_FFSR);
> > 
> > Please use raw reads, don't mix csa and raw reads.
> 
> Ack.
> 
> > 
> > > +	mdata->rrp = tmc_read_rrp(drvdata);
> > > +	mdata->rwp = tmc_read_rwp(drvdata);
> > > +	mdata->dba = tmc_read_dba(drvdata);
> > > +	mdata->trace_paddr = drvdata->resrv_buf.paddr;
> > > +	mdata->version = CS_CRASHDATA_VERSION;
> > > +
> > > +	/*
> > > +	 * Make sure all previous writes are completed,
> > > +	 * before we mark valid
> > > +	 */
> > > +	dsb(sy);
> > 
> > Same as earlier, doesn't buy us much
> 
> Will convert to dmb.
> 
> > 
> > > +	mdata->valid = true;
> > > +	/*
> > > +	 * Below order need to maintained, since crc of metadata
> > > +	 * is dependent on first
> > > +	 */
> > > +	mdata->crc32_tdata = find_crash_tracedata_crc(drvdata, mdata);
> > > +	mdata->crc32_mdata = find_crash_metadata_crc(mdata);
> > > +
> > > +	tmc_disable_hw(drvdata);
> > > +
> > > +	dev_info(&csdev->dev, "%s: success\n", __func__);
> > 
> > Drop
> > 
> > > +out:
> > > +	CS_UNLOCK(drvdata->base);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   static const struct coresight_ops_sink tmc_etr_sink_ops = {
> > >   	.enable		= tmc_enable_etr_sink,
> > >   	.disable	= tmc_disable_etr_sink,
> > > @@ -1822,8 +1895,13 @@ static const struct coresight_ops_sink tmc_etr_sink_ops = {
> > >   	.free_buffer	= tmc_free_etr_buffer,
> > >   };
> > > +static const struct coresight_ops_panic tmc_etr_sync_ops = {
> > > +	.sync		= tmc_panic_sync_etr,
> > > +};
> > > +
> > >   const struct coresight_ops tmc_etr_cs_ops = {
> > >   	.sink_ops	= &tmc_etr_sink_ops,
> > > +	.panic_ops	= &tmc_etr_sync_ops,
> > >   };
> > >   int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
> > > diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> > > index d2261eddab71..75e504e51956 100644
> > > --- a/drivers/hwtracing/coresight/coresight-tmc.h
> > > +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> > > @@ -12,6 +12,7 @@
> > >   #include <linux/miscdevice.h>
> > >   #include <linux/mutex.h>
> > >   #include <linux/refcount.h>
> > > +#include <linux/crc32.h>
> > >   #define TMC_RSZ			0x004
> > >   #define TMC_STS			0x00c
> > > @@ -76,6 +77,9 @@
> > >   #define TMC_AXICTL_AXCACHE_OS	(0xf << 2)
> > >   #define TMC_AXICTL_ARCACHE_OS	(0xf << 16)
> > > +/* TMC_FFSR - 0x300 */
> > > +#define TMC_FFSR_FT_STOPPED	BIT(1)
> > > +
> > >   /* TMC_FFCR - 0x304 */
> > >   #define TMC_FFCR_FLUSHMAN_BIT	6
> > >   #define TMC_FFCR_EN_FMT		BIT(0)
> > > @@ -94,6 +98,9 @@
> > >   #define TMC_AUTH_NSID_MASK	GENMASK(1, 0)
> > > +/* Major version 1 Minor version 0 */
> > > +#define CS_CRASHDATA_VERSION	(1 << 16)
> > > +
> > >   enum tmc_config_type {
> > >   	TMC_CONFIG_TYPE_ETB,
> > >   	TMC_CONFIG_TYPE_ETR,
> > > @@ -131,6 +138,25 @@ enum tmc_mem_intf_width {
> > >   #define CORESIGHT_SOC_600_ETR_CAPS	\
> > >   	(TMC_ETR_SAVE_RESTORE | TMC_ETR_AXI_ARCACHE)
> > > +/* TMC metadata region for ETR and ETF configurations */
> > > +struct tmc_crash_metadata {
> > > +	uint32_t crc32_mdata;	/* crc of metadata */
> > > +	uint32_t crc32_tdata;	/* crc of tracedata */
> > > +	uint32_t version;	/* 31:16 Major version, 15:0 Minor version */
> > > +	uint32_t valid;         /* Indicate if this ETF/ETR was enabled */
> > > +	uint32_t size;          /* Ram Size register */
> > 
> > Please could you not keep this "plain bytes" ? Or rename the field to
> > tmc_ram_size if we want to stick to TMC RAM SIZE register. It is very
> > easy to confuse it with "normal" bytes.
> 
> Okay. Will change the name.
> 
> > 
> > > +	uint32_t sts;           /* Status register */
> > 
> > tmc_sts
> > 
> > > +	uint32_t mode;		/* Mode register */
> > 
> > tmc_mode
> > 
> > This doesn't look packed. Please could you add a padding here to make sure
> > the fields are 64bit aligned ?
> > 
> > > +	uint64_t ffcr;		/* Formatter and flush control register */
> > 
> > tmc_ffcr
> > 
> > > +	uint64_t ffsr;		/* Formatter and flush status register */
> > 
> > tmc_ffsr

Guess we should prefix the rwp, rrp and dba also with tmc since they
are register snapshots ?

 

