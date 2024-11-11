Return-Path: <linux-kernel+bounces-404061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0059C3EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAA228118F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2D819F117;
	Mon, 11 Nov 2024 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="NCdaVIkn"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1A419D89B;
	Mon, 11 Nov 2024 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329317; cv=none; b=CdLbt9mY1evm5+JB9LIF+jqg6Ui7DwMkeaFCWAYq4I/VjseB+WeuDdcYcIQpf34b8aey2OwPPirGWkt9ElSNgIf94N4Onry5AACPEz379MV2+VVCHoLx/penwlOwpmStmBDcqS2NyrkxLE/skj2Wwq+PdmuvbORFTmt1aGRjp8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329317; c=relaxed/simple;
	bh=lfhbPVUH3p/gjo8okZmJUjJHatCtXpQvP97hzxFilU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LuUDknO+YDexLEm7ZlcARbLKoDuJ09Bj6sZ5UHUmhjFqM8DiqqgZr0AFowRn/rUzUet1RJlYIW+1zPEgrq8izJGU8RKvmJ1lOJ1Ja4B67/XwGBKL+OG4DDQII8iH5DQzmyJVOVKcIP6WPxlAk1e0LjFZk1Cp6LyXUL/5gQJ5728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=NCdaVIkn; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABCEwcr030976;
	Mon, 11 Nov 2024 04:48:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
	x0zdw19VPfqMHf0GQj7ZkxZEGRG3Ok8wsb+OzipXDU=; b=NCdaVIkny1wObi8T/
	6DtV74cVgzFdjTrqvOTF1DuU6FPwTlRwW7AOJIAJgaITpOaFljso6ffyNd56I9/I
	jk+praxo94sjwU2ZxCbAbur4HDudVVZY9Ry36hSuZiyoh62kJwpMC6yAF9mgeqQm
	dgs03E+hIqGsiD94tYHLFTgSfAxHXN+IdSs2KIGYU48drRY5rpnUfhMZLmiOSpvc
	q/HsdxkxnC/B2ezMhuGV6lmv6/+abmk/neyJ+ADq6O1JXFmCrakyTyAo5VPBQCtE
	052BcZl/V9JmZpNBX36p5qZjsozl+yn6We8h7CBI/6SlhKUsySn56io1V52BOZ7Q
	bi08g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42uhrrg1c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 04:48:23 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 11 Nov 2024 04:48:22 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 11 Nov 2024 04:48:22 -0800
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 77FFE3F70AE;
	Mon, 11 Nov 2024 04:48:17 -0800 (PST)
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
Subject: [PATCH v11 5/8] coresight: tmc: Add support for reading crash data
Date: Mon, 11 Nov 2024 18:17:43 +0530
Message-ID: <20241111124746.2210378-6-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111124746.2210378-1-lcherian@marvell.com>
References: <20241111124746.2210378-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: aYtpbiS-scsjRnKmumqWDSwWD5RZtttr
X-Proofpoint-ORIG-GUID: aYtpbiS-scsjRnKmumqWDSwWD5RZtttr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

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
Changelog from v10:
* Got rid of sink specific prepare/unprepare invocations  
* Fixed marking metadata as invalid when a user is trying to use the
  reserved buffer. Earlier this was wrongly set at the time of reading
  reserved trace buffer.
* Moved common validation checks to is_tmc_crashdata_valid and minor
  code rearrangements for efficiency
* Got rid of "full" member from struct tmc_resrv_buf
* While reading crashdata, size is now calculated from metdata instead 
  of relying on reserved buffer size populated by dtb 


 .../hwtracing/coresight/coresight-tmc-core.c  | 231 +++++++++++++++++-
 .../hwtracing/coresight/coresight-tmc-etr.c   |  19 +-
 drivers/hwtracing/coresight/coresight-tmc.h   |  13 +-
 3 files changed, 260 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 1e3938ec12cb..5f3789314c4d 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -105,6 +105,151 @@ u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata)
 	return mask;
 }
 
+bool is_tmc_crashdata_valid(struct tmc_drvdata *drvdata)
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
+		dev_dbg(&drvdata->csdev->dev,
+			"CRC mismatch in tmc crash metadata\n");
+		return false;
+	}
+	/* Check data integrity of tracedata */
+	if (mdata->crc32_tdata != find_crash_tracedata_crc(drvdata, mdata)) {
+		dev_dbg(&drvdata->csdev->dev,
+			"CRC mismatch in tmc crash tracedata\n");
+		return false;
+	}
+
+	return true;
+}
+
+int tmc_read_prepare_crashdata(struct tmc_drvdata *drvdata)
+{
+	int ret = 0;
+	u32 status, size;
+	u64 rrp, rwp, dba;
+	unsigned long flags;
+	struct tmc_resrv_buf *rbuf;
+	struct tmc_crash_metadata *mdata;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	if (drvdata->reading) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (!is_tmc_crashdata_valid(drvdata)) {
+		ret = -ENXIO;
+		goto out;
+	}
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
+	if (status & 0x1)
+		coresight_insert_barrier_packet(drvdata->buf);
+
+	drvdata->reading = true;
+out:
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	return ret;
+}
+
+int tmc_read_unprepare_crashdata(struct tmc_drvdata *drvdata)
+{
+	unsigned long flags;
+	struct tmc_resrv_buf *rbuf;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	rbuf = &drvdata->resrv_buf;
+	/* Reset valid length */
+	rbuf->len = 0;
+
+	drvdata->reading = false;
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	return 0;
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
 static int tmc_read_prepare(struct tmc_drvdata *drvdata)
 {
 	int ret = 0;
@@ -223,6 +368,69 @@ static const struct file_operations tmc_fops = {
 	.release	= tmc_release,
 };
 
+static int tmc_crashdata_open(struct inode *inode, struct file *file)
+{
+	int ret;
+	struct tmc_drvdata *drvdata = container_of(file->private_data,
+						   struct tmc_drvdata,
+						   crashdev);
+
+	ret = tmc_read_prepare_crashdata(drvdata);
+	if (ret)
+		return ret;
+
+	nonseekable_open(inode, file);
+
+	dev_dbg(&drvdata->csdev->dev, "%s: successfully opened\n", __func__);
+	return 0;
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
+
+}
+
+static int tmc_crashdata_release(struct inode *inode, struct file *file)
+{
+	int ret = 0;
+	struct tmc_drvdata *drvdata = container_of(file->private_data,
+						   struct tmc_drvdata,
+						   crashdev);
+
+	ret = tmc_read_unprepare_crashdata(drvdata);
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
@@ -532,6 +740,20 @@ static u32 tmc_etr_get_max_burst_size(struct device *dev)
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
+	}
+}
+
 static int __tmc_probe(struct device *dev, struct resource *res)
 {
 	int ret = 0;
@@ -632,8 +854,13 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 	drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
 	drvdata->miscdev.fops = &tmc_fops;
 	ret = misc_register(&drvdata->miscdev);
-	if (ret)
+	if (ret) {
 		coresight_unregister(drvdata->csdev);
+		goto out;
+	}
+
+	if (is_tmc_crashdata_valid(drvdata))
+		register_crash_dev_interface(drvdata, desc.name);
 out:
 	return ret;
 }
@@ -687,6 +914,8 @@ static void __tmc_remove(struct device *dev)
 	 * handler to this device is closed.
 	 */
 	misc_deregister(&drvdata->miscdev);
+	if (drvdata->crashdev.fops)
+		misc_deregister(&drvdata->crashdev);
 	coresight_unregister(drvdata->csdev);
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index fb944a68a11c..18752f58dfa6 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -2012,6 +2012,23 @@ static ssize_t buf_mode_preferred_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", buf_modes_str[drvdata->etr_mode]);
 }
 
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
+		err = -1;
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	return err;
+}
+
 static ssize_t buf_mode_preferred_store(struct device *dev,
 					  struct device_attribute *attr,
 					  const char *buf, size_t size)
@@ -2027,7 +2044,7 @@ static ssize_t buf_mode_preferred_store(struct device *dev,
 	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_CATU]) && buf_hw.has_catu)
 		drvdata->etr_mode = ETR_MODE_CATU;
 	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_RESRV]) && buf_hw.has_resrv)
-		drvdata->etr_mode = ETR_MODE_RESRV;
+		return buf_mode_set_resrv(drvdata) ? -EBUSY : size;
 	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_AUTO]))
 		drvdata->etr_mode = ETR_MODE_AUTO;
 	else
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index d76e83fc840b..2ece44e09911 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -195,11 +195,15 @@ struct etr_buf {
  * @paddr	: Start address of reserved memory region.
  * @vaddr	: Corresponding CPU virtual address.
  * @size	: Size of reserved memory region.
+ * @offset	: Offset of the trace data in the buffer for consumption.
+ * @len	: Available trace data @buf (may round up to the beginning).
  */
 struct tmc_resrv_buf {
 	phys_addr_t     paddr;
 	void		*vaddr;
 	size_t		size;
+	unsigned long	offset;
+	s64		len;
 };
 
 /**
@@ -208,6 +212,8 @@ struct tmc_resrv_buf {
  * @base:	memory mapped base address for this component.
  * @csdev:	component vitals needed by the framework.
  * @miscdev:	specifics to handle "/dev/xyz.tmc" entry.
+ * @crashdev:	specifics to handle "/dev/crash_tmc_xyz" entry for reading
+ *		crash tracedata.
  * @spinlock:	only one at a time pls.
  * @pid:	Process ID of the process that owns the session that is using
  *		this component. For example this would be the pid of the Perf
@@ -227,7 +233,7 @@ struct tmc_resrv_buf {
  * @idr_mutex:	Access serialisation for idr.
  * @sysfs_buf:	SYSFS buffer for ETR.
  * @perf_buf:	PERF buffer for ETR.
- * @resrv_buf:	Used by ETR as hardware trace buffer and for trace data
+ * @resrv_buf:  Used by ETR as hardware trace buffer and for trace data
  *		retention (after crash) only when ETR_MODE_RESRV buffer
  *		mode is enabled. Used by ETF for trace data retention
  *		(after crash) by default.
@@ -239,6 +245,7 @@ struct tmc_drvdata {
 	void __iomem		*base;
 	struct coresight_device	*csdev;
 	struct miscdevice	miscdev;
+	struct miscdevice	crashdev;
 	spinlock_t		spinlock;
 	pid_t			pid;
 	bool			reading;
@@ -309,6 +316,8 @@ void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
 void tmc_enable_hw(struct tmc_drvdata *drvdata);
 void tmc_disable_hw(struct tmc_drvdata *drvdata);
 u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata);
+int tmc_read_prepare_crashdata(struct tmc_drvdata *drvdata);
+int tmc_read_unprepare_crashdata(struct tmc_drvdata *drvdata);
 
 /* ETB/ETF functions */
 int tmc_read_prepare_etb(struct tmc_drvdata *drvdata);
@@ -371,6 +380,8 @@ void tmc_sg_table_sync_data_range(struct tmc_sg_table *table,
 				  u64 offset, u64 size);
 ssize_t tmc_sg_table_get_data(struct tmc_sg_table *sg_table,
 			      u64 offset, size_t len, char **bufpp);
+
+bool is_tmc_crashdata_valid(struct tmc_drvdata *drvdata);
 static inline unsigned long
 tmc_sg_table_buf_size(struct tmc_sg_table *sg_table)
 {
-- 
2.34.1


