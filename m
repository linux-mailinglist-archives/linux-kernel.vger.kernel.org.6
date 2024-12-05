Return-Path: <linux-kernel+bounces-433744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708C09E5C78
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B81028994B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A47226ED7;
	Thu,  5 Dec 2024 17:01:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC621773A;
	Thu,  5 Dec 2024 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418117; cv=none; b=uvcW6H9dCXagGvWZvKoDajSmTDpjo2CUW0IuO7tadpsq6hbRMYo86DvwOMX4vn0iMrrSa5MY22U8IUq1ueq3OX9qmS7ONbaX4TGRaNLj7vqOV7qtNkq59sUEPx6bNAjt5+j5hwpL2ruxbwvKrXnjzedoV7WBIvtQNXg9/ee6+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418117; c=relaxed/simple;
	bh=Whapanp2F9YUEI+YugJVd+euaX5xRY4YjBBljMVWfcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFgcYouD1Ourd2CTZrXIr1/SXqIN4On2Tgmlr2rpGK2LSiPO/+FePLNVgUva3RiVyuPcxnv96VXsRKELv/cWtm0alLcdaW1mSl47jyz5fKfRKD/QD/LdcUDFqNE2oVUXVi2WY4E4wSDwLq6nYzlD4WlVuGDZFFaAPtZeZ9Sk79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 569091063;
	Thu,  5 Dec 2024 09:02:23 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 682513F71E;
	Thu,  5 Dec 2024 09:01:53 -0800 (PST)
Message-ID: <b56cbd79-61a4-49c3-82ce-12ca55a40991@arm.com>
Date: Thu, 5 Dec 2024 17:01:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/8] coresight: tmc: Add support for reading crash
 data
To: Linu Cherian <lcherian@marvell.com>, mike.leach@linaro.org,
 james.clark@arm.com
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
 devicetree@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com,
 Anil Kumar Reddy <areddy3@marvell.com>, Tanmay Jagdale <tanmay@marvell.com>
References: <20241129084714.3057080-1-lcherian@marvell.com>
 <20241129084714.3057080-6-lcherian@marvell.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20241129084714.3057080-6-lcherian@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linu,

On 29/11/2024 08:47, Linu Cherian wrote:
> * Add support for reading crashdata using special device files.
>    The special device files /dev/crash_tmc_xxx would be available
>    for read file operation only when the crash data is valid.
> 
> * User can read the crash data as below
> 
>    For example, for reading crash data from tmc_etf sink
> 
>    #dd if=/dev/crash_tmc_etfXX of=~/cstrace.bin
> 

Unfortunately there is still a bug that I picked up, see below for the 
barrier_packet insertion.

> Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
>   .../hwtracing/coresight/coresight-tmc-core.c  | 231 +++++++++++++++++-
>   .../hwtracing/coresight/coresight-tmc-etr.c   |  19 +-
>   drivers/hwtracing/coresight/coresight-tmc.h   |  13 +-
>   3 files changed, 260 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index 1e3938ec12cb..5f3789314c4d 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -105,6 +105,151 @@ u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata)
>   	return mask;
>   }
>   
> +bool is_tmc_crashdata_valid(struct tmc_drvdata *drvdata)
> +{
> +	struct tmc_crash_metadata *mdata;
> +
> +	if (!tmc_has_reserved_buffer(drvdata) ||
> +	    !tmc_has_crash_mdata_buffer(drvdata))
> +		return false;
> +
> +	mdata = drvdata->crash_mdata.vaddr;
> +
> +	/* Check version match */
> +	if (mdata->version != CS_CRASHDATA_VERSION)
> +		return false;
> +
> +	/* Check for valid metadata */
> +	if (!mdata->valid) {
> +		dev_dbg(&drvdata->csdev->dev,
> +			"Data invalid in tmc crash metadata\n");
> +		return false;
> +	}
> +
> +	/*
> +	 * Buffer address given by metadata for retrieval of trace data
> +	 * from previous boot is expected to be same as the reserved
> +	 * trace buffer memory region provided through DTS
> +	 */
> +	if (drvdata->resrv_buf.paddr != mdata->trace_paddr) {
> +		dev_dbg(&drvdata->csdev->dev,
> +			"Trace buffer address of previous boot invalid\n");
> +		return false;
> +	}
> +
> +	/* Check data integrity of metadata */
> +	if (mdata->crc32_mdata != find_crash_metadata_crc(mdata)) {
> +		dev_dbg(&drvdata->csdev->dev,
> +			"CRC mismatch in tmc crash metadata\n");
> +		return false;
> +	}
> +	/* Check data integrity of tracedata */
> +	if (mdata->crc32_tdata != find_crash_tracedata_crc(drvdata, mdata)) {
> +		dev_dbg(&drvdata->csdev->dev,
> +			"CRC mismatch in tmc crash tracedata\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +int tmc_read_prepare_crashdata(struct tmc_drvdata *drvdata)
> +{
> +	int ret = 0;
> +	u32 status, size;
> +	u64 rrp, rwp, dba;
> +	unsigned long flags;
> +	struct tmc_resrv_buf *rbuf;
> +	struct tmc_crash_metadata *mdata;
> +
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +
> +	if (drvdata->reading) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	if (!is_tmc_crashdata_valid(drvdata)) {
> +		ret = -ENXIO;
> +		goto out;
> +	}
> +
> +	mdata = drvdata->crash_mdata.vaddr;
> +	rbuf = &drvdata->resrv_buf;
> +
> +	rrp = mdata->tmc_rrp;
> +	rwp = mdata->tmc_rwp;
> +	dba = mdata->tmc_dba;
> +	status = mdata->tmc_sts;
> +	size = mdata->tmc_ram_size << 2;
> +
> +	/* Sync the buffer pointers */
> +	rbuf->offset = rrp - dba;
> +	if (status & TMC_STS_FULL)
> +		rbuf->len = size;
> +	else
> +		rbuf->len = rwp - rrp;
> +

I believe all of the above can be done one time probe and don't need to
be repeated every time we do a read_prepare() ?


> +	/* Additional sanity checks for validating metadata */
> +	if ((rbuf->offset > size) ||
> +	    (rbuf->len > size)) {
> +		dev_dbg(&drvdata->csdev->dev,
> +			"Offset and length invalid in tmc crash metadata\n");
> +		return -EINVAL;
> +	}

Ideally this should also be done once and "don't expose" crash_tmc
device if the above is invalid in metada.


> +
> +	if (status & 0x1)

minor nit: s/0x1/TMC_STS_FULL ?

> +		coresight_insert_barrier_packet(drvdata->buf);

And this looks completely out of nowhere and corrupting the drvdata->buf 
? drvdata->buf is for active sessions, which we haven't set here ?


> +
> +	drvdata->reading = true;

Also, we agreed to not overload "drvdata->reading" ?

See 
https://lkml.kernel.org/r/20241017114054.GC896339@hyd1403.caveonetworks.com

We are allowed to the ETR (which drvdata->reading prevents from btw) 
while crash data is being read. You could instead move it to
drvdata->resrv_buf->reading ?



Suzuki


> +out:
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +	return ret;
> +}
> +
> +int tmc_read_unprepare_crashdata(struct tmc_drvdata *drvdata)
> +{
> +	unsigned long flags;
> +	struct tmc_resrv_buf *rbuf;
> +
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +
> +	rbuf = &drvdata->resrv_buf;
> +	/* Reset valid length */
> +	rbuf->len = 0;
> +
> +	drvdata->reading = false;
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +
> +	return 0;
> +}
> +
> +static inline ssize_t tmc_get_resvbuf_trace(struct tmc_drvdata *drvdata,
> +					  loff_t pos, size_t len, char **bufpp)
> +{
> +	s64 offset;
> +	ssize_t actual = len;
> +	struct tmc_resrv_buf *rbuf = &drvdata->resrv_buf;
> +
> +	if (pos + actual > rbuf->len)
> +		actual = rbuf->len - pos;
> +	if (actual <= 0)
> +		return 0;
> +
> +	/* Compute the offset from which we read the data */
> +	offset = rbuf->offset + pos;
> +	if (offset >= rbuf->size)
> +		offset -= rbuf->size;
> +
> +	/* Adjust the length to limit this transaction to end of buffer */
> +	actual = (actual < (rbuf->size - offset)) ?
> +		actual : rbuf->size - offset;
> +
> +	*bufpp = (char *)rbuf->vaddr + offset;
> +
> +	return actual;
> +}
> +
>   static int tmc_read_prepare(struct tmc_drvdata *drvdata)
>   {
>   	int ret = 0;
> @@ -223,6 +368,69 @@ static const struct file_operations tmc_fops = {
>   	.release	= tmc_release,
>   };
>   
> +static int tmc_crashdata_open(struct inode *inode, struct file *file)
> +{
> +	int ret;
> +	struct tmc_drvdata *drvdata = container_of(file->private_data,
> +						   struct tmc_drvdata,
> +						   crashdev);
> +
> +	ret = tmc_read_prepare_crashdata(drvdata);
> +	if (ret)
> +		return ret;
> +
> +	nonseekable_open(inode, file);
> +
> +	dev_dbg(&drvdata->csdev->dev, "%s: successfully opened\n", __func__);
> +	return 0;
> +}
> +
> +static ssize_t tmc_crashdata_read(struct file *file, char __user *data,
> +				  size_t len, loff_t *ppos)
> +{
> +	char *bufp;
> +	ssize_t actual;
> +	struct tmc_drvdata *drvdata = container_of(file->private_data,
> +						   struct tmc_drvdata,
> +						   crashdev);
> +
> +	actual = tmc_get_resvbuf_trace(drvdata, *ppos, len, &bufp);
> +	if (actual <= 0)
> +		return 0;
> +
> +	if (copy_to_user(data, bufp, actual)) {
> +		dev_dbg(&drvdata->csdev->dev,
> +			"%s: copy_to_user failed\n", __func__);
> +		return -EFAULT;
> +	}
> +
> +	*ppos += actual;
> +	dev_dbg(&drvdata->csdev->dev, "%zu bytes copied\n", actual);
> +
> +	return actual;
> +
> +}
> +
> +static int tmc_crashdata_release(struct inode *inode, struct file *file)
> +{
> +	int ret = 0;
> +	struct tmc_drvdata *drvdata = container_of(file->private_data,
> +						   struct tmc_drvdata,
> +						   crashdev);
> +
> +	ret = tmc_read_unprepare_crashdata(drvdata);
> +
> +	dev_dbg(&drvdata->csdev->dev, "%s: released\n", __func__);
> +	return ret;
> +}
> +
> +static const struct file_operations tmc_crashdata_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= tmc_crashdata_open,
> +	.read		= tmc_crashdata_read,
> +	.release	= tmc_crashdata_release,
> +};
> +
>   static enum tmc_mem_intf_width tmc_get_memwidth(u32 devid)
>   {
>   	enum tmc_mem_intf_width memwidth;
> @@ -532,6 +740,20 @@ static u32 tmc_etr_get_max_burst_size(struct device *dev)
>   	return burst_size;
>   }
>   
> +static void register_crash_dev_interface(struct tmc_drvdata *drvdata,
> +					 const char *name)
> +{
> +	drvdata->crashdev.name =
> +		devm_kasprintf(&drvdata->csdev->dev, GFP_KERNEL, "%s_%s", "crash", name);
> +	drvdata->crashdev.minor = MISC_DYNAMIC_MINOR;
> +	drvdata->crashdev.fops = &tmc_crashdata_fops;
> +	if (misc_register(&drvdata->crashdev)) {
> +		dev_dbg(&drvdata->csdev->dev,
> +			"Failed to setup user interface for crashdata\n");
> +		drvdata->crashdev.fops = NULL;
> +	}
> +}
> +
>   static int __tmc_probe(struct device *dev, struct resource *res)
>   {
>   	int ret = 0;
> @@ -632,8 +854,13 @@ static int __tmc_probe(struct device *dev, struct resource *res)
>   	drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
>   	drvdata->miscdev.fops = &tmc_fops;
>   	ret = misc_register(&drvdata->miscdev);
> -	if (ret)
> +	if (ret) {
>   		coresight_unregister(drvdata->csdev);
> +		goto out;
> +	}
> +
> +	if (is_tmc_crashdata_valid(drvdata))
> +		register_crash_dev_interface(drvdata, desc.name);
>   out:
>   	return ret;
>   }
> @@ -687,6 +914,8 @@ static void __tmc_remove(struct device *dev)
>   	 * handler to this device is closed.
>   	 */
>   	misc_deregister(&drvdata->miscdev);
> +	if (drvdata->crashdev.fops)
> +		misc_deregister(&drvdata->crashdev);
>   	coresight_unregister(drvdata->csdev);
>   }
>   
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index fb944a68a11c..18752f58dfa6 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -2012,6 +2012,23 @@ static ssize_t buf_mode_preferred_show(struct device *dev,
>   	return sysfs_emit(buf, "%s\n", buf_modes_str[drvdata->etr_mode]);
>   }
>   
> +static int buf_mode_set_resrv(struct tmc_drvdata *drvdata)
> +{
> +	unsigned long flags;
> +	int err = 0;
> +
> +	/* Ensure there are no active crashdata read sessions */
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +	if (!drvdata->reading) {
> +		tmc_crashdata_set_invalid(drvdata);
> +		drvdata->etr_mode = ETR_MODE_RESRV;
> +
> +	} else
> +		err = -1;
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +	return err;
> +}
> +
>   static ssize_t buf_mode_preferred_store(struct device *dev,
>   					  struct device_attribute *attr,
>   					  const char *buf, size_t size)
> @@ -2027,7 +2044,7 @@ static ssize_t buf_mode_preferred_store(struct device *dev,
>   	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_CATU]) && buf_hw.has_catu)
>   		drvdata->etr_mode = ETR_MODE_CATU;
>   	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_RESRV]) && buf_hw.has_resrv)
> -		drvdata->etr_mode = ETR_MODE_RESRV;
> +		return buf_mode_set_resrv(drvdata) ? -EBUSY : size;
>   	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_AUTO]))
>   		drvdata->etr_mode = ETR_MODE_AUTO;
>   	else
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index d76e83fc840b..2ece44e09911 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -195,11 +195,15 @@ struct etr_buf {
>    * @paddr	: Start address of reserved memory region.
>    * @vaddr	: Corresponding CPU virtual address.
>    * @size	: Size of reserved memory region.
> + * @offset	: Offset of the trace data in the buffer for consumption.
> + * @len	: Available trace data @buf (may round up to the beginning).
>    */
>   struct tmc_resrv_buf {
>   	phys_addr_t     paddr;
>   	void		*vaddr;
>   	size_t		size;
> +	unsigned long	offset;
> +	s64		len;
>   };
>   
>   /**
> @@ -208,6 +212,8 @@ struct tmc_resrv_buf {
>    * @base:	memory mapped base address for this component.
>    * @csdev:	component vitals needed by the framework.
>    * @miscdev:	specifics to handle "/dev/xyz.tmc" entry.
> + * @crashdev:	specifics to handle "/dev/crash_tmc_xyz" entry for reading
> + *		crash tracedata.
>    * @spinlock:	only one at a time pls.
>    * @pid:	Process ID of the process that owns the session that is using
>    *		this component. For example this would be the pid of the Perf
> @@ -227,7 +233,7 @@ struct tmc_resrv_buf {
>    * @idr_mutex:	Access serialisation for idr.
>    * @sysfs_buf:	SYSFS buffer for ETR.
>    * @perf_buf:	PERF buffer for ETR.
> - * @resrv_buf:	Used by ETR as hardware trace buffer and for trace data
> + * @resrv_buf:  Used by ETR as hardware trace buffer and for trace data
>    *		retention (after crash) only when ETR_MODE_RESRV buffer
>    *		mode is enabled. Used by ETF for trace data retention
>    *		(after crash) by default.
> @@ -239,6 +245,7 @@ struct tmc_drvdata {
>   	void __iomem		*base;
>   	struct coresight_device	*csdev;
>   	struct miscdevice	miscdev;
> +	struct miscdevice	crashdev;
>   	spinlock_t		spinlock;
>   	pid_t			pid;
>   	bool			reading;
> @@ -309,6 +316,8 @@ void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
>   void tmc_enable_hw(struct tmc_drvdata *drvdata);
>   void tmc_disable_hw(struct tmc_drvdata *drvdata);
>   u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata);
> +int tmc_read_prepare_crashdata(struct tmc_drvdata *drvdata);
> +int tmc_read_unprepare_crashdata(struct tmc_drvdata *drvdata);
>   
>   /* ETB/ETF functions */
>   int tmc_read_prepare_etb(struct tmc_drvdata *drvdata);
> @@ -371,6 +380,8 @@ void tmc_sg_table_sync_data_range(struct tmc_sg_table *table,
>   				  u64 offset, u64 size);
>   ssize_t tmc_sg_table_get_data(struct tmc_sg_table *sg_table,
>   			      u64 offset, size_t len, char **bufpp);
> +
> +bool is_tmc_crashdata_valid(struct tmc_drvdata *drvdata);
>   static inline unsigned long
>   tmc_sg_table_buf_size(struct tmc_sg_table *sg_table)
>   {


