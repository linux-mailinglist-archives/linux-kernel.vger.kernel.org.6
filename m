Return-Path: <linux-kernel+bounces-388141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E213D9B5B39
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0EC1F23044
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85F21CF5E0;
	Wed, 30 Oct 2024 05:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="RN78hWWq"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759D61CF289;
	Wed, 30 Oct 2024 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730266485; cv=none; b=tNeQmfHWbaxskDMlNX9CAzTa/O7Y24vgF+Fecc9LAnGVpttB9WZgp5FfDBlAg7uGkuJJwYSFUWWdTkAqe/QdU8Z5iNf4qq4S4+E0pC8zmYegm4IgWHuQ+VWKiZt4zi3sgwe41utwXVvhflXzXQqTZYPkTV8lvZxVGnVcnZOk/RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730266485; c=relaxed/simple;
	bh=dHhuB2IE27lAAeAOVaI08udg5UR0ckWSZPoSDjGgyDY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnwkIu5Rf3Vhn4JombY+Vf7GXzvWSLw6Tg8UCZTA2fxKWFUCtXKw9mFLVDmQDFNwsQAS7L3ZDITWkHVO50/RGqhwPzygmxsqJNj31jVKZBwXJlU+xI7DWyPwQqyj5BEsG3ZvLEAjYSm2/jIjWBe9VnRxStDcL/6+4nNadTDpIbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=RN78hWWq; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U43fa1003644;
	Tue, 29 Oct 2024 22:34:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=EuPLCTaaZkOVLsRjkJ81O2nbg
	SZwu3PbWuJ71l62EK0=; b=RN78hWWq+zYo5mGjfLoaNkr6xEe2eiLnX8DmPZtgw
	4wnwZDfm69EN/UEG5XVuKU6IBl+VESC4vEEqVbMpaczPF0gJEv3njwLKIJ4/DWc7
	7Zdvbunh4h3Vjylt/XdqD9bG/KuFyK+Nm8mutYB9ZS6FWlPK6MzoYh+AL5s0TRio
	pxVvrKyJOsxdJG76VvveDup//zBsbuwVixh4R7CYPmLisWHTtwEifrjtA2WPkrFy
	L8rxIMRETEzNwV8o/Oyx8ePSTGRLNK3qLlIwf/ZrLxUZeFLmLbJTXf3Wuv2DTM6Y
	W1h9h/Un/pkkK3wFcRsW8PUgY1ilFsUTjgtQWXv6Bpk+Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42kdenr538-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 22:34:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 29 Oct 2024 22:34:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 29 Oct 2024 22:34:24 -0700
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with SMTP id 2CBB65E6870;
	Tue, 29 Oct 2024 22:34:19 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:04:19 +0530
From: Linu Cherian <lcherian@marvell.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
CC: <mike.leach@linaro.org>, <james.clark@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Anil Kumar Reddy <areddy3@marvell.com>,
        "Tanmay
 Jagdale" <tanmay@marvell.com>
Subject: Re: [PATCH v10 5/8] coresight: tmc: Add support for reading crash
 data
Message-ID: <20241030053419.GA984012@hyd1403.caveonetworks.com>
References: <20240916103437.226816-1-lcherian@marvell.com>
 <20240916103437.226816-6-lcherian@marvell.com>
 <f1acfd07-7317-4b7e-bb81-ea9a894f25ac@arm.com>
 <20241017114054.GC896339@hyd1403.caveonetworks.com>
 <05ed4a6f-cb41-4953-a654-9988f0fcd373@arm.com>
 <20241021124040.GA929726@hyd1403.caveonetworks.com>
 <20241029062112.GA978396@hyd1403.caveonetworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241029062112.GA978396@hyd1403.caveonetworks.com>
X-Proofpoint-GUID: lFDf-iV9kTHpZR2ZAKiqkqcGhfZO1D4G
X-Proofpoint-ORIG-GUID: lFDf-iV9kTHpZR2ZAKiqkqcGhfZO1D4G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Hi Suzuki,

On 2024-10-29 at 11:51:12, Linu Cherian (lcherian@marvell.com) wrote:
> Hi Suzuki,
> 
> On 2024-10-21 at 18:10:40, Linu Cherian (lcherian@marvell.com) wrote:
> > Hi Suzuki,
> > 
> > On 2024-10-18 at 15:16:17, Suzuki K Poulose (suzuki.poulose@arm.com) wrote:
> > > On 17/10/2024 12:40, Linu Cherian wrote:
> > > > On 2024-10-03 at 18:55:54, Suzuki K Poulose (suzuki.poulose@arm.com) wrote:
> > > > > Hi Linu
> > > > > 
> > > > > On 16/09/2024 11:34, Linu Cherian wrote:
> > > > > > * Add support for reading crashdata using special device files.
> > > > > >     The special device files /dev/crash_tmc_xxx would be available
> > > > > >     for read file operation only when the crash data is valid.
> > > > > > 
> > > > > > * User can read the crash data as below
> > > > > > 
> > > > > >     For example, for reading crash data from tmc_etf sink
> > > > > > 
> > > > > >     #dd if=/dev/crash_tmc_etfXX of=~/cstrace.bin
> > > > > 
> > > > > There are some comments below, please take a look.
> > > > > 
> > > > > > 
> > > > > > Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
> > > > > > Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
> > > > > > Signed-off-by: Linu Cherian <lcherian@marvell.com>
> > > > > > ---
> > > > > > Changelog from v9:
> > > > > > - Removed READ_CRASHDATA mode meant for special casing crashdata read
> > > > > > - Added new fields full, len, offset to struct tmc_resrv_buf
> > > > > 
> > > > > Why do we need "full" ? See more on that below.
> > > > > 
> > > > > >     so as to have a common read function for ETR and ETF
> > > > > > - Introduced read file operation, tmc_crashdata_read
> > > > > >     specific to crashdata reads common for both ETR and ETF
> > > > > > - Introduced is_tmc_crashdata_valid function
> > > > > >     Special device file /dev/crash_tmc_xxx will be available only when
> > > > > >     crashdata is valid.
> > > > > > - Version checks added to crashdata validity checks
> > > > > > - Mark crashdata as invalid when user starts tracing with ETR sink in
> > > > > >     "resrv" buffer mode
> > > > > > 
> > > > > >    .../hwtracing/coresight/coresight-tmc-core.c  | 206 +++++++++++++++++-
> > > > > >    .../hwtracing/coresight/coresight-tmc-etf.c   |  36 +++
> > > > > >    .../hwtracing/coresight/coresight-tmc-etr.c   |  63 ++++++
> > > > > >    drivers/hwtracing/coresight/coresight-tmc.h   |  18 +-
> > > > > >    include/linux/coresight.h                     |  12 +
> > > > > >    5 files changed, 333 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> > > > > > index 54bf8ae2bff8..47b6b3f88750 100644
> > > > > > --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> > > > > > +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> > > > > > @@ -105,6 +105,125 @@ u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata)
> > > > > >    	return mask;
> > > > > >    }
> > > > > > +bool is_tmc_crashdata_valid(struct tmc_drvdata *drvdata)
> > > > > > +{
> > > > > > +	struct tmc_crash_metadata *mdata;
> > > > > > +
> > > > > > +	if (!tmc_has_reserved_buffer(drvdata) ||
> > > > > > +	    !tmc_has_crash_mdata_buffer(drvdata))
> > > > > > +		return false;
> > > > > > +
> > > > > > +	mdata = drvdata->crash_mdata.vaddr;
> > > > > > +
> > > > > > +	/* Check version match */
> > > > > > +	if (mdata->version != CS_CRASHDATA_VERSION)
> > > > > > +		return false;
> > > > > > +
> > > > > > +	/* Check data integrity of metadata */
> > > > > > +	if (mdata->crc32_mdata != find_crash_metadata_crc(mdata)) {
> > > > > > +		dev_dbg(&drvdata->csdev->dev,
> > > > > > +			"CRC mismatch in tmc crash metadata\n");
> > > > > > +		return false;
> > > > > > +	}
> > > > > > +	/* Check data integrity of tracedata */
> > > > > > +	if (mdata->crc32_tdata != find_crash_tracedata_crc(drvdata, mdata)) {
> > > > > > +		dev_dbg(&drvdata->csdev->dev,
> > > > > > +			"CRC mismatch in tmc crash tracedata\n");
> > > > > > +		return false;
> > > > > > +	}
> > > > > > +	/* Check for valid metadata */
> > > > > > +	if (!mdata->valid) {
> > > > > 
> > > > > minor nit: This could be checked right after the VERSION and we verify
> > > > > the CRC anyway later and thus could skip all the CRC calculations if
> > > > > !valid.
> > > > 
> > > > 
> > > > Ack.
> > > > 
> > > > > 
> > > > > > +		dev_dbg(&drvdata->csdev->dev,
> > > > > > +			"Data invalid in tmc crash metadata\n");
> > > > > > +		return false;
> > > > > > +	}
> > > > > > +
> > > > > > +	return true;
> > > > > > +}
> > > > > > +
> > > > > > +int tmc_read_prepare_crashdata(struct tmc_drvdata *drvdata)
> > > > > > +{
> > > > > > +	int ret = 0;
> > > > > > +	unsigned long flags;
> > > > > > +	struct tmc_crash_metadata *mdata;
> > > > > > +	struct coresight_device *csdev = drvdata->csdev;
> > > > > > +
> > > > > > +	spin_lock_irqsave(&drvdata->spinlock, flags);
> > > > > > +
> > > > > > +	if (!is_tmc_crashdata_valid(drvdata)) {
> > > > > > +		ret = -ENXIO;
> > > > > > +		goto out;
> > > > > > +	}
> > > > > > +
> > > > > > +	mdata = drvdata->crash_mdata.vaddr;
> > > > > > +	/*
> > > > > > +	 * Buffer address given by metadata for retrieval of trace data
> > > > > > +	 * from previous boot is expected to be same as the reserved
> > > > > > +	 * trace buffer memory region provided through DTS
> > > > > > +	 */
> > > > > > +	if (drvdata->resrv_buf.paddr != mdata->trace_paddr) {
> > > > > > +		dev_dbg(&csdev->dev, "Trace buffer address of previous boot invalid\n");
> > > > > 
> > > > > Couldn't this be made part of the "is_tmc_crashdata_valid()" and not
> > > > > repeated everytime we do the read ? Surely, this can't change after
> > > > > boot.
> > > > 
> > > > Ack. Will move.
> > > > 
> > > > > 
> > > > > > +		ret = -EINVAL;
> > > > > > +		goto out;
> > > > > > +	}
> > > > > > +
> > > > > > +	/* Sink specific crashdata mode preparation */
> > > > > > +	ret = crashdata_ops(csdev)->prepare(csdev);
> > > > > > +	if (ret)
> > > > > > +		goto out;
> > > > > > +
> > > > > > +	if (mdata->sts & 0x1)
> > > > > > +		coresight_insert_barrier_packet(drvdata->buf);
> > > > > > +
> > > > > > +	drvdata->reading = true;
> > > > > 
> > > > > Why are we dealing with drvdata->reading ? That is supposed to be only
> > > > > for the normal trace reading ?
> > > > 
> > > > Ack. Will remove, we dont need this.
> > > > 

Looked into this further and it seems like, retaining the
drvdata->reading flags would be useful to avoid simultaneous crashdata reads
and regular trace capture sessions using reserve buffers.

Something like this,

+static int buf_mode_set_resrv(struct tmc_drvdata *drvdata)
+{
+	unsigned long flags;
+	int err = 0;
+
+	/* Ensure there are no active crashdata read sessions */
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (!drvdata->reading) {
+		tmc_crashdata_set_invalid(drvdata);
+		drvdata->etr_mode = ETR_MODE_RESRV;
+
+	} else
+		err = -EINVAL;
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	return err;
+}
+
 static ssize_t buf_mode_preferred_store(struct device *dev,
 					  struct device_attribute *attr,
 					  const char *buf, size_t size)
 {
 	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etr_buf_hw buf_hw;
 
 	get_etr_buf_hw(dev, &buf_hw);
@@ -2039,7 +2050,7 @@ static ssize_t buf_mode_preferred_store(struct device *dev,
 	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_CATU]) && buf_hw.has_catu)
 		drvdata->etr_mode = ETR_MODE_CATU;
 	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_RESRV]) && buf_hw.has_resrv)
-		drvdata->etr_mode = ETR_MODE_RESRV;
+		return buf_mode_set_resrv(drvdata);
 	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_AUTO]))
 		drvdata->etr_mode = ETR_MODE_AUTO;
 	else


Was acutally calling the tmc_crashdata_set_invalid in the wrong place in v10 patch.



