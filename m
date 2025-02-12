Return-Path: <linux-kernel+bounces-511069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E76EA3255E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D401889DD8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83A520DD46;
	Wed, 12 Feb 2025 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SU7ggT3J"
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED35C20B808;
	Wed, 12 Feb 2025 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739361006; cv=none; b=FMla4CwBCcOLFPPPHmAmh/Eiiehp4Kf/K7SG9q/5xJi17hQkaGhu5ysYVj2wQKBVoHoFWfX+mPFXOwiqT8Wyb+xaBVCvRAQ45XmYr/zD3Dy7y8NFwBeUrqJP3L/2udBnc60T4HNpmw7qxeOGd6WlfJ0W2QE50Q8cTdL7GZaUyX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739361006; c=relaxed/simple;
	bh=3RLzC+/71H8po3gQfmQiKWuBbp4DO1pmYovuXNZT/yI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZ1QIa4+bew2+JRqLqk+ati+SYtPPNNbASyljZW61XUkUEeRT4raffB8kr6SOvwK2u6SiycmLtteMN9OOqpPHp+TtJSEFYgOG4rOoMTv0e5MKybFdfR4i0QjE19nQX6qJJieaFS8eebvyF+e+FBzpHz+KoAU3jqwbOSaQXOjRpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SU7ggT3J; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C41KcC002226;
	Wed, 12 Feb 2025 03:49:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
	RHs/Oqont3fSLDo7bNEypA/4JYpaZVXBaQtpVyzh+Y=; b=SU7ggT3JoJwrMYNmo
	ubKOA0d+qODfo8Cqhp4gOnLzy5lneGPOblLmmYUtFrH6f9yL6aFVDfvxgTILwfrv
	gDbwLRImKJ4GQkJPvdkTpKbWOcpplmIOPiojCWetVcYIcvBwURqW455iANxpLpEP
	WBbkhVveG3OUGV626tAwyuVJrqSp0hie3RENTzJ3OhZoO7rjyBvluistCzLGapU+
	FATxynj5WJsIJpChZqg0g42q2+bzihWVBbbESXdUwF3LcgezJMhuT8tnre+YqfMe
	cmRz06C2Kakc+TRX6iVDPfLw4DLlOKFWcBAfv9ognZINzab2GS6ULH6RwrmwT4Zx
	7xszg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44rm878s4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 03:49:56 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Feb 2025 03:49:55 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Feb 2025 03:49:55 -0800
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 2FE5C5B693C;
	Wed, 12 Feb 2025 03:49:49 -0800 (PST)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>,
        Anil Kumar Reddy
	<areddy3@marvell.com>,
        Tanmay Jagdale <tanmay@marvell.com>
Subject: [PATCH v14 5/8] coresight: tmc: Add support for reading crash data
Date: Wed, 12 Feb 2025 17:19:15 +0530
Message-ID: <20250212114918.548431-6-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212114918.548431-1-lcherian@marvell.com>
References: <20250212114918.548431-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: wRA_SDbhA5XUh1hDr402i9t6uqsnSsTj
X-Proofpoint-ORIG-GUID: wRA_SDbhA5XUh1hDr402i9t6uqsnSsTj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_04,2025-02-11_01,2024-11-22_01

* Add support for reading crashdata using special device files.
  The special device files /dev/crash_tmc_xxx would be available
  for read file operation only when the crash data is valid.

* User can read the crash data as below

  For example, for reading crash data from tmc_etf sink

  #dd if=/dev/crash_tmc_etfXX of=~/cstrace.bin

Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v13:
* Changed the log levels of crc error check failure prints from dev_dbg to
  dev_err 
* Added CRC recalculation upon barrier packet insertion for overflow
  cases, this fixes wrong crc check failures for subsequent boots
* Add metadata valid flag checks for successfully opening crashdata files
* Report to the user during probe if valid crash tracedata is found
* Few other trivial cleanups

 .../hwtracing/coresight/coresight-tmc-core.c  | 226 +++++++++++++++++-
 .../hwtracing/coresight/coresight-tmc-etr.c   |  22 +-
 drivers/hwtracing/coresight/coresight-tmc.h   |  14 +-
 3 files changed, 259 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index c6224eed705d..045d37606750 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -105,6 +105,128 @@ u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata)
 	return mask;
 }
 
+static bool is_tmc_crashdata_valid(struct tmc_drvdata *drvdata)
+{
+	struct tmc_crash_metadata *mdata;
+
+	if (!tmc_has_reserved_buffer(drvdata) ||
+	    !tmc_has_crash_mdata_buffer(drvdata))
+		return false;
+
+	mdata = drvdata->crash_mdata.vaddr;
+
+	/* Check version match */
+	if (mdata->version != CS_CRASHDATA_VERSION)
+		return false;
+
+	/* Check for valid metadata */
+	if (!mdata->valid) {
+		dev_dbg(&drvdata->csdev->dev,
+			"Data invalid in tmc crash metadata\n");
+		return false;
+	}
+
+	/*
+	 * Buffer address given by metadata for retrieval of trace data
+	 * from previous boot is expected to be same as the reserved
+	 * trace buffer memory region provided through DTS
+	 */
+	if (drvdata->resrv_buf.paddr != mdata->trace_paddr) {
+		dev_dbg(&drvdata->csdev->dev,
+			"Trace buffer address of previous boot invalid\n");
+		return false;
+	}
+
+	/* Check data integrity of metadata */
+	if (mdata->crc32_mdata != find_crash_metadata_crc(mdata)) {
+		dev_err(&drvdata->csdev->dev,
+			"CRC mismatch in tmc crash metadata\n");
+		return false;
+	}
+	/* Check data integrity of tracedata */
+	if (mdata->crc32_tdata != find_crash_tracedata_crc(drvdata, mdata)) {
+		dev_err(&drvdata->csdev->dev,
+			"CRC mismatch in tmc crash tracedata\n");
+		return false;
+	}
+
+	return true;
+}
+
+static inline ssize_t tmc_get_resvbuf_trace(struct tmc_drvdata *drvdata,
+					  loff_t pos, size_t len, char **bufpp)
+{
+	s64 offset;
+	ssize_t actual = len;
+	struct tmc_resrv_buf *rbuf = &drvdata->resrv_buf;
+
+	if (pos + actual > rbuf->len)
+		actual = rbuf->len - pos;
+	if (actual <= 0)
+		return 0;
+
+	/* Compute the offset from which we read the data */
+	offset = rbuf->offset + pos;
+	if (offset >= rbuf->size)
+		offset -= rbuf->size;
+
+	/* Adjust the length to limit this transaction to end of buffer */
+	actual = (actual < (rbuf->size - offset)) ?
+		actual : rbuf->size - offset;
+
+	*bufpp = (char *)rbuf->vaddr + offset;
+
+	return actual;
+}
+
+static int tmc_prepare_crashdata(struct tmc_drvdata *drvdata)
+{
+	char *bufp;
+	ssize_t len;
+	u32 status, size;
+	u64 rrp, rwp, dba;
+	struct tmc_resrv_buf *rbuf;
+	struct tmc_crash_metadata *mdata;
+
+	mdata = drvdata->crash_mdata.vaddr;
+	rbuf = &drvdata->resrv_buf;
+
+	rrp = mdata->tmc_rrp;
+	rwp = mdata->tmc_rwp;
+	dba = mdata->tmc_dba;
+	status = mdata->tmc_sts;
+	size = mdata->tmc_ram_size << 2;
+
+	/* Sync the buffer pointers */
+	rbuf->offset = rrp - dba;
+	if (status & TMC_STS_FULL)
+		rbuf->len = size;
+	else
+		rbuf->len = rwp - rrp;
+
+	/* Additional sanity checks for validating metadata */
+	if ((rbuf->offset > size) ||
+	    (rbuf->len > size)) {
+		dev_dbg(&drvdata->csdev->dev,
+			"Offset and length invalid in tmc crash metadata\n");
+		return -EINVAL;
+	}
+
+	if (status & TMC_STS_FULL) {
+		len = tmc_get_resvbuf_trace(drvdata, 0x0,
+					    CORESIGHT_BARRIER_PKT_SIZE, &bufp);
+		if (len >= CORESIGHT_BARRIER_PKT_SIZE) {
+			coresight_insert_barrier_packet(bufp);
+			/* Recalculate crc */
+			mdata->crc32_tdata = find_crash_tracedata_crc(drvdata,
+								      mdata);
+			mdata->crc32_mdata = find_crash_metadata_crc(mdata);
+		}
+	}
+
+	return 0;
+}
+
 static int tmc_read_prepare(struct tmc_drvdata *drvdata)
 {
 	int ret = 0;
@@ -223,6 +345,84 @@ static const struct file_operations tmc_fops = {
 	.release	= tmc_release,
 };
 
+static int tmc_crashdata_open(struct inode *inode, struct file *file)
+{
+	int err = 0;
+	unsigned long flags;
+	struct tmc_resrv_buf *rbuf;
+	struct tmc_crash_metadata *mdata;
+	struct tmc_drvdata *drvdata = container_of(file->private_data,
+						   struct tmc_drvdata,
+						   crashdev);
+
+	mdata = drvdata->crash_mdata.vaddr;
+	rbuf = &drvdata->resrv_buf;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (mdata->valid)
+		rbuf->reading = true;
+	else
+		err = -ENOENT;
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	if (err)
+		goto exit;
+
+	nonseekable_open(inode, file);
+	dev_dbg(&drvdata->csdev->dev, "%s: successfully opened\n", __func__);
+exit:
+	return err;
+}
+
+static ssize_t tmc_crashdata_read(struct file *file, char __user *data,
+				  size_t len, loff_t *ppos)
+{
+	char *bufp;
+	ssize_t actual;
+	struct tmc_drvdata *drvdata = container_of(file->private_data,
+						   struct tmc_drvdata,
+						   crashdev);
+
+	actual = tmc_get_resvbuf_trace(drvdata, *ppos, len, &bufp);
+	if (actual <= 0)
+		return 0;
+
+	if (copy_to_user(data, bufp, actual)) {
+		dev_dbg(&drvdata->csdev->dev,
+			"%s: copy_to_user failed\n", __func__);
+		return -EFAULT;
+	}
+
+	*ppos += actual;
+	dev_dbg(&drvdata->csdev->dev, "%zu bytes copied\n", actual);
+
+	return actual;
+}
+
+static int tmc_crashdata_release(struct inode *inode, struct file *file)
+{
+	int ret = 0;
+	unsigned long flags;
+	struct tmc_resrv_buf *rbuf;
+	struct tmc_drvdata *drvdata = container_of(file->private_data,
+						   struct tmc_drvdata,
+						   crashdev);
+
+	rbuf = &drvdata->resrv_buf;
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	rbuf->reading = false;
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	dev_dbg(&drvdata->csdev->dev, "%s: released\n", __func__);
+	return ret;
+}
+
+static const struct file_operations tmc_crashdata_fops = {
+	.owner		= THIS_MODULE,
+	.open		= tmc_crashdata_open,
+	.read		= tmc_crashdata_read,
+	.release	= tmc_crashdata_release,
+};
+
 static enum tmc_mem_intf_width tmc_get_memwidth(u32 devid)
 {
 	enum tmc_mem_intf_width memwidth;
@@ -532,6 +732,22 @@ static u32 tmc_etr_get_max_burst_size(struct device *dev)
 	return burst_size;
 }
 
+static void register_crash_dev_interface(struct tmc_drvdata *drvdata,
+					 const char *name)
+{
+	drvdata->crashdev.name =
+		devm_kasprintf(&drvdata->csdev->dev, GFP_KERNEL, "%s_%s", "crash", name);
+	drvdata->crashdev.minor = MISC_DYNAMIC_MINOR;
+	drvdata->crashdev.fops = &tmc_crashdata_fops;
+	if (misc_register(&drvdata->crashdev)) {
+		dev_dbg(&drvdata->csdev->dev,
+			"Failed to setup user interface for crashdata\n");
+		drvdata->crashdev.fops = NULL;
+	} else
+		dev_info(&drvdata->csdev->dev,
+			"Valid crash tracedata found\n");
+}
+
 static int __tmc_probe(struct device *dev, struct resource *res)
 {
 	int ret = 0;
@@ -632,9 +848,15 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 	drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
 	drvdata->miscdev.fops = &tmc_fops;
 	ret = misc_register(&drvdata->miscdev);
-	if (ret)
+	if (ret) {
 		coresight_unregister(drvdata->csdev);
+		goto out;
+	}
+
 out:
+	if (is_tmc_crashdata_valid(drvdata) &&
+	    !tmc_prepare_crashdata(drvdata))
+		register_crash_dev_interface(drvdata, desc.name);
 	return ret;
 }
 
@@ -687,6 +909,8 @@ static void __tmc_remove(struct device *dev)
 	 * handler to this device is closed.
 	 */
 	misc_deregister(&drvdata->miscdev);
+	if (drvdata->crashdev.fops)
+		misc_deregister(&drvdata->crashdev);
 	coresight_unregister(drvdata->csdev);
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index fb944a68a11c..c92556e1b4db 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -2012,6 +2012,26 @@ static ssize_t buf_mode_preferred_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", buf_modes_str[drvdata->etr_mode]);
 }
 
+static int buf_mode_set_resrv(struct tmc_drvdata *drvdata)
+{
+	int err = -EBUSY;
+	unsigned long flags;
+	struct tmc_resrv_buf *rbuf;
+
+	rbuf = &drvdata->resrv_buf;
+
+	/* Ensure there are no active crashdata read sessions */
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (!rbuf->reading) {
+		tmc_crashdata_set_invalid(drvdata);
+		rbuf->len = 0;
+		drvdata->etr_mode = ETR_MODE_RESRV;
+		err = 0;
+	}
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	return err;
+}
+
 static ssize_t buf_mode_preferred_store(struct device *dev,
 					  struct device_attribute *attr,
 					  const char *buf, size_t size)
@@ -2027,7 +2047,7 @@ static ssize_t buf_mode_preferred_store(struct device *dev,
 	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_CATU]) && buf_hw.has_catu)
 		drvdata->etr_mode = ETR_MODE_CATU;
 	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_RESRV]) && buf_hw.has_resrv)
-		drvdata->etr_mode = ETR_MODE_RESRV;
+		return buf_mode_set_resrv(drvdata) ? : size;
 	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_AUTO]))
 		drvdata->etr_mode = ETR_MODE_AUTO;
 	else
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index d76e83fc840b..e3707b69abff 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -195,11 +195,17 @@ struct etr_buf {
  * @paddr	: Start address of reserved memory region.
  * @vaddr	: Corresponding CPU virtual address.
  * @size	: Size of reserved memory region.
+ * @offset	: Offset of the trace data in the buffer for consumption.
+ * @reading	: Flag to indicate if reading is active
+ * @len	: Available trace data @buf (may round up to the beginning).
  */
 struct tmc_resrv_buf {
 	phys_addr_t     paddr;
 	void		*vaddr;
 	size_t		size;
+	unsigned long	offset;
+	bool		reading;
+	s64		len;
 };
 
 /**
@@ -208,6 +214,8 @@ struct tmc_resrv_buf {
  * @base:	memory mapped base address for this component.
  * @csdev:	component vitals needed by the framework.
  * @miscdev:	specifics to handle "/dev/xyz.tmc" entry.
+ * @crashdev:	specifics to handle "/dev/crash_tmc_xyz" entry for reading
+ *		crash tracedata.
  * @spinlock:	only one at a time pls.
  * @pid:	Process ID of the process that owns the session that is using
  *		this component. For example this would be the pid of the Perf
@@ -227,7 +235,7 @@ struct tmc_resrv_buf {
  * @idr_mutex:	Access serialisation for idr.
  * @sysfs_buf:	SYSFS buffer for ETR.
  * @perf_buf:	PERF buffer for ETR.
- * @resrv_buf:	Used by ETR as hardware trace buffer and for trace data
+ * @resrv_buf:  Used by ETR as hardware trace buffer and for trace data
  *		retention (after crash) only when ETR_MODE_RESRV buffer
  *		mode is enabled. Used by ETF for trace data retention
  *		(after crash) by default.
@@ -239,6 +247,7 @@ struct tmc_drvdata {
 	void __iomem		*base;
 	struct coresight_device	*csdev;
 	struct miscdevice	miscdev;
+	struct miscdevice	crashdev;
 	spinlock_t		spinlock;
 	pid_t			pid;
 	bool			reading;
@@ -309,6 +318,8 @@ void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
 void tmc_enable_hw(struct tmc_drvdata *drvdata);
 void tmc_disable_hw(struct tmc_drvdata *drvdata);
 u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata);
+int tmc_read_prepare_crashdata(struct tmc_drvdata *drvdata);
+int tmc_read_unprepare_crashdata(struct tmc_drvdata *drvdata);
 
 /* ETB/ETF functions */
 int tmc_read_prepare_etb(struct tmc_drvdata *drvdata);
@@ -371,6 +382,7 @@ void tmc_sg_table_sync_data_range(struct tmc_sg_table *table,
 				  u64 offset, u64 size);
 ssize_t tmc_sg_table_get_data(struct tmc_sg_table *sg_table,
 			      u64 offset, size_t len, char **bufpp);
+
 static inline unsigned long
 tmc_sg_table_buf_size(struct tmc_sg_table *sg_table)
 {
-- 
2.34.1


