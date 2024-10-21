Return-Path: <linux-kernel+bounces-374343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510A99A68E2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB8FB21A91
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25221F1310;
	Mon, 21 Oct 2024 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OysBoxRO"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04C1D1310;
	Mon, 21 Oct 2024 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514468; cv=none; b=NsyJfiiAmu3iDFv6ZBINflqwONcFiJVjPDqbr8NkrhKcQhpurj27BRjUJmLrqGnaeltBdShHh2zli1Y/nggtrDHBXsjFVqkbKhuG5aymDwez1aKZGtAOiKZccsLPIoeZbLY07kTmMmreeWv95COaCpIRbbymYWkXyXBSNfrZFm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514468; c=relaxed/simple;
	bh=BCeF9JXt9qTUZ9ovOcpS/RK5Lz3VTojSM3p95XaLgYM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaLUeUAIQ9SoGLAsNHqS2JSPwW7vW9SHiT+jLjNif3ExBqn/TF3pcdtbveegaL/OiwG2H94vGZrF5x6YCenhtxT4x1ypYmDDd30BawAthg0i/ZBirkAe70nulrQ7NzaMiX+DPMK1EOq6Jr2VTB38IEfuUvKqOXhD1xpr3bsyVbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=OysBoxRO; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L7X56P026105;
	Mon, 21 Oct 2024 05:40:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=w5txLHkToEiekJfqCBwHzU6GN
	aYOgBx52aZbHKtYgpE=; b=OysBoxROJYTAEwdAWlRcr8sDCkKG6vnOPv/T5vg/+
	HR+2BazFiNKapb+y/na5I2Z+9dcbpPQLb94WKJejZArayCkQcEfnDQMhVKFZoYmG
	umvdHKqGusVSmQDjxQIN8wbp0I43JFoFP6ereudogXNqMkhvZ9p9wkXIY6ubHymY
	fv+1VeMxirk7+Z4iYofG0Rm3xgbTFw353ZF6CrTF13LuyJoNRUkytsFpwVDRoyXn
	db0715qQl3+QtghijNrp6wr5/XH4/54FTkIjdNwsK1FZPpoycge3uR8FZRXXX73e
	bY3vavAASCRa2rgX2zE4/ybJWjKzNMHhwP9NT6cWLsBEw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42djnmrk90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 05:40:48 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 21 Oct 2024 05:40:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 05:40:46 -0700
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with SMTP id E7F803F7048;
	Mon, 21 Oct 2024 05:40:41 -0700 (PDT)
Date: Mon, 21 Oct 2024 18:10:40 +0530
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
Message-ID: <20241021124040.GA929726@hyd1403.caveonetworks.com>
References: <20240916103437.226816-1-lcherian@marvell.com>
 <20240916103437.226816-6-lcherian@marvell.com>
 <f1acfd07-7317-4b7e-bb81-ea9a894f25ac@arm.com>
 <20241017114054.GC896339@hyd1403.caveonetworks.com>
 <05ed4a6f-cb41-4953-a654-9988f0fcd373@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <05ed4a6f-cb41-4953-a654-9988f0fcd373@arm.com>
X-Proofpoint-GUID: E0ksCmPdMJ2sw12NOWznG_WvKs8EnugA
X-Proofpoint-ORIG-GUID: E0ksCmPdMJ2sw12NOWznG_WvKs8EnugA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi Suzuki,

On 2024-10-18 at 15:16:17, Suzuki K Poulose (suzuki.poulose@arm.com) wrote:
> On 17/10/2024 12:40, Linu Cherian wrote:
> > On 2024-10-03 at 18:55:54, Suzuki K Poulose (suzuki.poulose@arm.com) wrote:
> > > Hi Linu
> > > 
> > > On 16/09/2024 11:34, Linu Cherian wrote:
> > > > * Add support for reading crashdata using special device files.
> > > >     The special device files /dev/crash_tmc_xxx would be available
> > > >     for read file operation only when the crash data is valid.
> > > > 
> > > > * User can read the crash data as below
> > > > 
> > > >     For example, for reading crash data from tmc_etf sink
> > > > 
> > > >     #dd if=/dev/crash_tmc_etfXX of=~/cstrace.bin
> > > 
> > > There are some comments below, please take a look.
> > > 
> > > > 
> > > > Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
> > > > Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
> > > > Signed-off-by: Linu Cherian <lcherian@marvell.com>
> > > > ---
> > > > Changelog from v9:
> > > > - Removed READ_CRASHDATA mode meant for special casing crashdata read
> > > > - Added new fields full, len, offset to struct tmc_resrv_buf
> > > 
> > > Why do we need "full" ? See more on that below.
> > > 
> > > >     so as to have a common read function for ETR and ETF
> > > > - Introduced read file operation, tmc_crashdata_read
> > > >     specific to crashdata reads common for both ETR and ETF
> > > > - Introduced is_tmc_crashdata_valid function
> > > >     Special device file /dev/crash_tmc_xxx will be available only when
> > > >     crashdata is valid.
> > > > - Version checks added to crashdata validity checks
> > > > - Mark crashdata as invalid when user starts tracing with ETR sink in
> > > >     "resrv" buffer mode
> > > > 
> > > >    .../hwtracing/coresight/coresight-tmc-core.c  | 206 +++++++++++++++++-
> > > >    .../hwtracing/coresight/coresight-tmc-etf.c   |  36 +++
> > > >    .../hwtracing/coresight/coresight-tmc-etr.c   |  63 ++++++
> > > >    drivers/hwtracing/coresight/coresight-tmc.h   |  18 +-
> > > >    include/linux/coresight.h                     |  12 +
> > > >    5 files changed, 333 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> > > > index 54bf8ae2bff8..47b6b3f88750 100644
> > > > --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> > > > +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> > > > @@ -105,6 +105,125 @@ u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata)
> > > >    	return mask;
> > > >    }
> > > > +bool is_tmc_crashdata_valid(struct tmc_drvdata *drvdata)
> > > > +{
> > > > +	struct tmc_crash_metadata *mdata;
> > > > +
> > > > +	if (!tmc_has_reserved_buffer(drvdata) ||
> > > > +	    !tmc_has_crash_mdata_buffer(drvdata))
> > > > +		return false;
> > > > +
> > > > +	mdata = drvdata->crash_mdata.vaddr;
> > > > +
> > > > +	/* Check version match */
> > > > +	if (mdata->version != CS_CRASHDATA_VERSION)
> > > > +		return false;
> > > > +
> > > > +	/* Check data integrity of metadata */
> > > > +	if (mdata->crc32_mdata != find_crash_metadata_crc(mdata)) {
> > > > +		dev_dbg(&drvdata->csdev->dev,
> > > > +			"CRC mismatch in tmc crash metadata\n");
> > > > +		return false;
> > > > +	}
> > > > +	/* Check data integrity of tracedata */
> > > > +	if (mdata->crc32_tdata != find_crash_tracedata_crc(drvdata, mdata)) {
> > > > +		dev_dbg(&drvdata->csdev->dev,
> > > > +			"CRC mismatch in tmc crash tracedata\n");
> > > > +		return false;
> > > > +	}
> > > > +	/* Check for valid metadata */
> > > > +	if (!mdata->valid) {
> > > 
> > > minor nit: This could be checked right after the VERSION and we verify
> > > the CRC anyway later and thus could skip all the CRC calculations if
> > > !valid.
> > 
> > 
> > Ack.
> > 
> > > 
> > > > +		dev_dbg(&drvdata->csdev->dev,
> > > > +			"Data invalid in tmc crash metadata\n");
> > > > +		return false;
> > > > +	}
> > > > +
> > > > +	return true;
> > > > +}
> > > > +
> > > > +int tmc_read_prepare_crashdata(struct tmc_drvdata *drvdata)
> > > > +{
> > > > +	int ret = 0;
> > > > +	unsigned long flags;
> > > > +	struct tmc_crash_metadata *mdata;
> > > > +	struct coresight_device *csdev = drvdata->csdev;
> > > > +
> > > > +	spin_lock_irqsave(&drvdata->spinlock, flags);
> > > > +
> > > > +	if (!is_tmc_crashdata_valid(drvdata)) {
> > > > +		ret = -ENXIO;
> > > > +		goto out;
> > > > +	}
> > > > +
> > > > +	mdata = drvdata->crash_mdata.vaddr;
> > > > +	/*
> > > > +	 * Buffer address given by metadata for retrieval of trace data
> > > > +	 * from previous boot is expected to be same as the reserved
> > > > +	 * trace buffer memory region provided through DTS
> > > > +	 */
> > > > +	if (drvdata->resrv_buf.paddr != mdata->trace_paddr) {
> > > > +		dev_dbg(&csdev->dev, "Trace buffer address of previous boot invalid\n");
> > > 
> > > Couldn't this be made part of the "is_tmc_crashdata_valid()" and not
> > > repeated everytime we do the read ? Surely, this can't change after
> > > boot.
> > 
> > Ack. Will move.
> > 
> > > 
> > > > +		ret = -EINVAL;
> > > > +		goto out;
> > > > +	}
> > > > +
> > > > +	/* Sink specific crashdata mode preparation */
> > > > +	ret = crashdata_ops(csdev)->prepare(csdev);
> > > > +	if (ret)
> > > > +		goto out;
> > > > +
> > > > +	if (mdata->sts & 0x1)
> > > > +		coresight_insert_barrier_packet(drvdata->buf);
> > > > +
> > > > +	drvdata->reading = true;
> > > 
> > > Why are we dealing with drvdata->reading ? That is supposed to be only
> > > for the normal trace reading ?
> > 
> > Ack. Will remove, we dont need this.
> > 
> > > 
> > > > +out:
> > > > +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +int tmc_read_unprepare_crashdata(struct tmc_drvdata *drvdata)
> > > > +{
> > > > +	int ret;
> > > > +	unsigned long flags;
> > > > +	struct coresight_device *csdev = drvdata->csdev;
> > > > +
> > > > +	spin_lock_irqsave(&drvdata->spinlock, flags);
> > > > +
> > > > +	/* Sink specific crashdata mode preparation */
> > > > +	ret = crashdata_ops(csdev)->unprepare(csdev);
> > > > +
> > > > +	drvdata->reading = false;
> > > 
> > > 
> > > 
> > > > +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static inline ssize_t tmc_get_resvbuf_trace(struct tmc_drvdata *drvdata,
> > > > +					  loff_t pos, size_t len, char **bufpp)
> > > > +{
> > > > +	s64 offset;
> > > > +	ssize_t actual = len;
> > > > +	struct tmc_resrv_buf *rbuf = &drvdata->resrv_buf;
> > > > +
> > > > +	if (pos + actual > rbuf->len)
> > > > +		actual = rbuf->len - pos;
> > > > +	if (actual <= 0)
> > > > +		return actual;
> > > 
> > > return 0 ? Because, we went beyond the file position, not because there was
> > > an error. So, that it doesn't look like we are suppressing an ERROR ?
> > 
> > 
> > return 0 looks fine to me. Will recheck on this.
> > 
> > > 
> > > 
> > > > +
> > > > +	/* Compute the offset from which we read the data */
> > > > +	offset = rbuf->offset + pos;
> > > > +	if (offset >= rbuf->size)
> > > > +		offset -= rbuf->size;
> > > > +
> > > > +	/* Adjust the length to limit this transaction to end of buffer */
> > > > +	actual = (actual < (rbuf->size - offset)) ?
> > > > +		actual : rbuf->size - offset;
> > > > +
> > > > +	*bufpp = (char *)rbuf->vaddr + offset;
> > > > +
> > > > +	return actual;
> > > > +}
> > > > +
> > > >    static int tmc_read_prepare(struct tmc_drvdata *drvdata)
> > > >    {
> > > >    	int ret = 0;
> > > > @@ -224,6 +343,70 @@ static const struct file_operations tmc_fops = {
> > > >    	.llseek		= no_llseek,
> > > >    };
> > > > +static int tmc_crashdata_open(struct inode *inode, struct file *file)
> > > > +{
> > > > +	int ret;
> > > > +	struct tmc_drvdata *drvdata = container_of(file->private_data,
> > > > +						   struct tmc_drvdata,
> > > > +						   crashdev);
> > > > +
> > > > +	ret = tmc_read_prepare_crashdata(drvdata);
> > > 
> > > I don't see the point of this "prepare" and unprepare callbacks, as they
> > > can be made generic by populating the mdata->rrp,rwp fields accordingly ?
> > > 
> > > i.e., while populating the mdata-> fields, for ETR, do what you do now.
> > > For ETF you could :
> > > 
> > > mdata->rrp = 0;
> > > mdata->dba = 0;
> > > mdata->rwp = drvdata->len;
> > > mdata->size = drvdata->len >> 2;
> > > mdata->sts = TMC_STS_FULL;
> > 
> > Agree with your point that this would get rid of sink specific
> > callbacks.
> > 
> > But few points to consider before we go with the above approach,
> > 
> > * mdata register snapshots wont be true to their definition,
> >    with such encodings.
> > 
> >    We had a similar discussion on this earlier regarding mdata->size,
> >    ie. We decided to stick to register format instead of storing bytes.
> >    https://lore.kernel.org/linux-arm-kernel/20240620041054.GC125816@hyd1403.caveonetworks.com/
> 
> Understood. But whoever fills in the metdata does need to fill the
> mdata information above ? Including calculating the hash. So, I think it
> is fair to say that mdata is populated in a way that makes sense
> just by looking at it. In fact, we should :
> 
> 
> mdata->dba = <address of the tracedata>
> mdata->rrp = mdata->dba;
> mdata->rwp = mdata->rrp + drvdata->len;
> mdata->size = drvdata->len >> 2;
> mdata->sts = TMC_STS_FULL;
> 
> Rather than filling in 0's.


Okay, will make this change for ETF and avoid the sink specific
callbacks.

> 
> 
> > 
> > * We will have more comparable code between normal trace buffer reading
> >    and reading trace buffer after panic with sink specific callbacks,
> >    even though we keep the code seperate.
> 
> Lets not create "customs" here. We have a callback for a reason. i.e,
> the ETF has an internal SRAM which is not accessible directly by the CPU
> and ETR uses normal RAM.
> 
> While in this case, we have the data in CPU accessible RAM and the
> "driver" in this case is crash handling and can be agnostic of where
> the data was captured (ETF vs ETR)


Okay fine.

> 
> 
> Suzuki
> 
> 
> > 
> > Please let me know your thoughts on this.
> 
> 
> 

