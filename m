Return-Path: <linux-kernel+bounces-330505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74108979F71
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D49D8B23663
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ABF15687C;
	Mon, 16 Sep 2024 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HBtugHWW"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409C115350B;
	Mon, 16 Sep 2024 10:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726482926; cv=none; b=hHYIZlU1EAL9XPNFbUS4y1LqMSwwqKn+lKAsGPu3SCKCZ4wUIeYiQG7LN+w3N2Q0FPp0ohdMoUDwGVuYB8Oxm9MSXVjVr3sIve+UB3vnmdyqGqymlk4QTkYNvIiipiI/dxQZxApJ0+41B+coXt62baLmOl19S2F9pYHNDtRd+/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726482926; c=relaxed/simple;
	bh=UFXpNi7YIJTrOsswuSPqIW/4d7Bfn64PO9mkgI1/oPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dzc3pmoPhJA2/aXSbHeqAsFvR/TZnUZCTiitJ53k95lq0cfKNKrRyeSKJFIV4exXzM/OosulL4eu2tUP8LEg/Fbw7i/VbAxeyygzpBWwWQpww3ERK+L7Ny6fzxkPXnGwrD2n+or0c3Aw0carrEfybPNttm8RxFosB94Z9vjhVE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HBtugHWW; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48FMeVfQ017329;
	Mon, 16 Sep 2024 03:35:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=W
	XFEvKIP4/DCJfUZn9tIpiBgTOC39jiSetSrP4L3QbQ=; b=HBtugHWWIQzW5lCc6
	2vMpGUtPDbNrHtLzGigEuCj66CThrZzeng2yjQ4ZoRfxNUbbiNkzFCYHdB6vEDr0
	8n2N3UsT7lF6dqZNujUnG9kwrrK5+k9Kv+zzy4KOVaMITbgyYT2I46tcG1Uu6JLe
	N/xZ25fG0Nc46M0PGt/dzPfvypuwWo1h0B/8uRxK1PN9hCfZDhu/U6B61PCaE8jx
	Eeps5n45rZ70a+HMsKFxPespuEhrnEXKWpBWZP60dwCWE0se554hiDAJQjnpKQLf
	cfnkAfXm8zh5ZC882jAFCLTyLIaSHEnm0EfOFKzcJWFL7sdHQtzkf+LvYjIz4Zl0
	Sp8wQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41na0fw3qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 03:35:13 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 16 Sep 2024 03:35:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 16 Sep 2024 03:35:13 -0700
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 589E33F704A;
	Mon, 16 Sep 2024 03:35:08 -0700 (PDT)
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
Subject: [PATCH v10 5/8] coresight: tmc: Add support for reading crash data
Date: Mon, 16 Sep 2024 16:04:34 +0530
Message-ID: <20240916103437.226816-6-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916103437.226816-1-lcherian@marvell.com>
References: <20240916103437.226816-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1s_R8uBHdiLkJC6cqcVnpOFf-ZM_z0IP
X-Proofpoint-GUID: 1s_R8uBHdiLkJC6cqcVnpOFf-ZM_z0IP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

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
Changelog from v9:
- Removed READ_CRASHDATA mode meant for special casing crashdata read
- Added new fields full, len, offset to struct tmc_resrv_buf    
  so as to have a common read function for ETR and ETF
- Introduced read file operation, tmc_crashdata_read
  specific to crashdata reads common for both ETR and ETF 
- Introduced is_tmc_crashdata_valid function
  Special device file /dev/crash_tmc_xxx will be available only when
  crashdata is valid.
- Version checks added to crashdata validity checks
- Mark crashdata as invalid when user starts tracing with ETR sink in
  "resrv" buffer mode

 .../hwtracing/coresight/coresight-tmc-core.c  | 206 +++++++++++++++++-
 .../hwtracing/coresight/coresight-tmc-etf.c   |  36 +++
 .../hwtracing/coresight/coresight-tmc-etr.c   |  63 ++++++
 drivers/hwtracing/coresight/coresight-tmc.h   |  18 +-
 include/linux/coresight.h                     |  12 +
 5 files changed, 333 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 54bf8ae2bff8..47b6b3f88750 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -105,6 +105,125 @@ u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata)
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
+	/* Check for valid metadata */
+	if (!mdata->valid) {
+		dev_dbg(&drvdata->csdev->dev,
+			"Data invalid in tmc crash metadata\n");
+		return false;
+	}
+
+	return true;
+}
+
+int tmc_read_prepare_crashdata(struct tmc_drvdata *drvdata)
+{
+	int ret = 0;
+	unsigned long flags;
+	struct tmc_crash_metadata *mdata;
+	struct coresight_device *csdev = drvdata->csdev;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	if (!is_tmc_crashdata_valid(drvdata)) {
+		ret = -ENXIO;
+		goto out;
+	}
+
+	mdata = drvdata->crash_mdata.vaddr;
+	/*
+	 * Buffer address given by metadata for retrieval of trace data
+	 * from previous boot is expected to be same as the reserved
+	 * trace buffer memory region provided through DTS
+	 */
+	if (drvdata->resrv_buf.paddr != mdata->trace_paddr) {
+		dev_dbg(&csdev->dev, "Trace buffer address of previous boot invalid\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Sink specific crashdata mode preparation */
+	ret = crashdata_ops(csdev)->prepare(csdev);
+	if (ret)
+		goto out;
+
+	if (mdata->sts & 0x1)
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
+	int ret;
+	unsigned long flags;
+	struct coresight_device *csdev = drvdata->csdev;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	/* Sink specific crashdata mode preparation */
+	ret = crashdata_ops(csdev)->unprepare(csdev);
+
+	drvdata->reading = false;
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	return ret;
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
+		return actual;
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
@@ -224,6 +343,70 @@ static const struct file_operations tmc_fops = {
 	.llseek		= no_llseek,
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
+	.llseek		= no_llseek,
+};
+
 static enum tmc_mem_intf_width tmc_get_memwidth(u32 devid)
 {
 	enum tmc_mem_intf_width memwidth;
@@ -533,6 +716,20 @@ static u32 tmc_etr_get_max_burst_size(struct device *dev)
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
@@ -633,8 +830,13 @@ static int __tmc_probe(struct device *dev, struct resource *res)
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
@@ -688,6 +890,8 @@ static void __tmc_remove(struct device *dev)
 	 * handler to this device is closed.
 	 */
 	misc_deregister(&drvdata->miscdev);
+	if (drvdata->crashdev.fops)
+		misc_deregister(&drvdata->crashdev);
 	coresight_unregister(drvdata->csdev);
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index d77ec9307e98..2b4639a1def2 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -662,6 +662,36 @@ static int tmc_panic_sync_etf(struct coresight_device *csdev)
 	return 0;
 }
 
+static int tmc_etb_prepare_crashdata(struct coresight_device *csdev)
+{
+	unsigned long size;
+	struct tmc_resrv_buf *rbuf;
+	struct tmc_crash_metadata *mdata;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	rbuf = &drvdata->resrv_buf;
+	mdata = drvdata->crash_mdata.vaddr;
+	size = mdata->size << 2;
+
+	rbuf->len = size;
+	rbuf->offset = 0;
+	rbuf->full = 0;
+
+	return 0;
+}
+
+static int tmc_etb_unprepare_crashdata(struct coresight_device *csdev)
+{
+	struct tmc_resrv_buf *rbuf;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	rbuf = &drvdata->resrv_buf;
+	/* Reset valid length */
+	rbuf->len = 0;
+
+	return 0;
+}
+
 static const struct coresight_ops_sink tmc_etf_sink_ops = {
 	.enable		= tmc_enable_etf_sink,
 	.disable	= tmc_disable_etf_sink,
@@ -679,6 +709,11 @@ static const struct coresight_ops_panic tmc_etf_sync_ops = {
 	.sync		= tmc_panic_sync_etf,
 };
 
+static const struct coresight_ops_crashdata tmc_etf_crashdata_ops = {
+	.prepare	= tmc_etb_prepare_crashdata,
+	.unprepare	= tmc_etb_unprepare_crashdata,
+};
+
 const struct coresight_ops tmc_etb_cs_ops = {
 	.sink_ops	= &tmc_etf_sink_ops,
 };
@@ -687,6 +722,7 @@ const struct coresight_ops tmc_etf_cs_ops = {
 	.sink_ops	= &tmc_etf_sink_ops,
 	.link_ops	= &tmc_etf_link_ops,
 	.panic_ops	= &tmc_etf_sync_ops,
+	.crashdata_ops	= &tmc_etf_crashdata_ops,
 };
 
 int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 8228d7aaa361..7688b8d70ced 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1887,6 +1887,55 @@ static int tmc_panic_sync_etr(struct coresight_device *csdev)
 	return 0;
 }
 
+static int tmc_etr_prepare_crashdata(struct coresight_device *csdev)
+{
+	u32 status;
+	u64 rrp, rwp, dba;
+	struct tmc_resrv_buf *rbuf;
+	struct tmc_crash_metadata *mdata;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	rbuf = &drvdata->resrv_buf;
+	mdata = drvdata->crash_mdata.vaddr;
+
+	rrp = mdata->rrp;
+	rwp = mdata->rwp;
+	dba = mdata->dba;
+	status = mdata->sts;
+
+	rbuf->full = !!(status & TMC_STS_FULL);
+
+	/* Sync the buffer pointers */
+	rbuf->offset = rrp - dba;
+	if (rbuf->full)
+		rbuf->len = rbuf->size;
+	else
+		rbuf->len = rwp - rrp;
+
+	/* Additional sanity checks for validating metadata */
+	if ((rbuf->offset > rbuf->size) ||
+	    (rbuf->len > rbuf->size)) {
+		dev_dbg(&drvdata->csdev->dev,
+			"Offset and length invalid in tmc crash metadata\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int tmc_etr_unprepare_crashdata(struct coresight_device *csdev)
+{
+	struct tmc_resrv_buf *rbuf;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	rbuf = &drvdata->resrv_buf;
+
+	/* Reset valid length */
+	rbuf->len = 0;
+
+	return 0;
+}
+
 static const struct coresight_ops_sink tmc_etr_sink_ops = {
 	.enable		= tmc_enable_etr_sink,
 	.disable	= tmc_disable_etr_sink,
@@ -1899,9 +1948,15 @@ static const struct coresight_ops_panic tmc_etr_sync_ops = {
 	.sync		= tmc_panic_sync_etr,
 };
 
+static const struct coresight_ops_crashdata tmc_etr_crashdata_ops = {
+	.prepare	= tmc_etr_prepare_crashdata,
+	.unprepare	= tmc_etr_unprepare_crashdata,
+};
+
 const struct coresight_ops tmc_etr_cs_ops = {
 	.sink_ops	= &tmc_etr_sink_ops,
 	.panic_ops	= &tmc_etr_sync_ops,
+	.crashdata_ops	= &tmc_etr_crashdata_ops,
 };
 
 int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
@@ -1934,6 +1989,14 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 		__tmc_etr_disable_hw(drvdata);
 
 	drvdata->reading = true;
+
+	/*
+	 * The only other place we mark the metadata invalid is during
+	 * panic handler. Normally this won't race with panic handler,
+	 * as all cpus would be stopped before running panic handler.
+	 */
+	if (drvdata->etr_mode == ETR_MODE_RESRV)
+		tmc_crashdata_set_invalid(drvdata);
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 75e504e51956..a6daa35c7cc1 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -195,11 +195,17 @@ struct etr_buf {
  * @paddr	: Start address of reserved memory region.
  * @vaddr	: Corresponding CPU virtual address.
  * @size	: Size of reserved memory region.
+ * @full	: Trace data overflow
+ * @offset	: Offset of the trace data in the buffer for consumption.
+ * @len		: Available trace data @buf (may round up to the beginning).
  */
 struct tmc_resrv_buf {
 	phys_addr_t     paddr;
 	void		*vaddr;
 	size_t		size;
+	bool		full;
+	unsigned long	offset;
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
@@ -227,7 +235,10 @@ struct tmc_resrv_buf {
  * @idr_mutex:	Access serialisation for idr.
  * @sysfs_buf:	SYSFS buffer for ETR.
  * @perf_buf:	PERF buffer for ETR.
- * @resrv_buf:	Used by ETR as hardware trace buffer and for trace data
+ * @sysfs_crash_buf: Sysfs crashdata buffer for ETR. This is a special purpose
+ *		buffer that is used only for mapping the trace buffer from
+ *		previous crash and not for capturing trace.
+ * @resrv_buf:  Used by ETR as hardware trace buffer and for trace data
  *		retention (after crash) only when ETR_MODE_RESRV buffer
  *		mode is enabled. Used by ETF for trace data retention
  *		(after crash) by default.
@@ -239,6 +250,7 @@ struct tmc_drvdata {
 	void __iomem		*base;
 	struct coresight_device	*csdev;
 	struct miscdevice	miscdev;
+	struct miscdevice	crashdev;
 	spinlock_t		spinlock;
 	pid_t			pid;
 	bool			reading;
@@ -309,6 +321,8 @@ void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
 void tmc_enable_hw(struct tmc_drvdata *drvdata);
 void tmc_disable_hw(struct tmc_drvdata *drvdata);
 u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata);
+int tmc_read_prepare_crashdata(struct tmc_drvdata *drvdata);
+int tmc_read_unprepare_crashdata(struct tmc_drvdata *drvdata);
 
 /* ETB/ETF functions */
 int tmc_read_prepare_etb(struct tmc_drvdata *drvdata);
@@ -371,6 +385,8 @@ void tmc_sg_table_sync_data_range(struct tmc_sg_table *table,
 				  u64 offset, u64 size);
 ssize_t tmc_sg_table_get_data(struct tmc_sg_table *sg_table,
 			      u64 offset, size_t len, char **bufpp);
+
+bool is_tmc_crashdata_valid(struct tmc_drvdata *drvdata);
 static inline unsigned long
 tmc_sg_table_buf_size(struct tmc_sg_table *sg_table)
 {
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 2e63f7614551..f04e40828885 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -336,6 +336,7 @@ enum cs_mode {
 #define helper_ops(csdev)	csdev->ops->helper_ops
 #define ect_ops(csdev)		csdev->ops->ect_ops
 #define panic_ops(csdev)	csdev->ops->panic_ops
+#define crashdata_ops(csdev)	csdev->ops->crashdata_ops
 
 /**
  * struct coresight_ops_sink - basic operations for a sink
@@ -415,12 +416,23 @@ struct coresight_ops_panic {
 	int (*sync)(struct coresight_device *csdev);
 };
 
+/**
+ * struct coresight_ops_crashdata - Generic device ops for crashdata mode
+ *
+ * @prepare	: Preparation for reading crashdata mode
+ */
+struct coresight_ops_crashdata {
+	int (*prepare)(struct coresight_device *csdev);
+	int (*unprepare)(struct coresight_device *csdev);
+};
+
 struct coresight_ops {
 	const struct coresight_ops_sink *sink_ops;
 	const struct coresight_ops_link *link_ops;
 	const struct coresight_ops_source *source_ops;
 	const struct coresight_ops_helper *helper_ops;
 	const struct coresight_ops_panic *panic_ops;
+	const struct coresight_ops_crashdata *crashdata_ops;
 };
 
 static inline u32 csdev_access_relaxed_read32(struct csdev_access *csa,
-- 
2.34.1


