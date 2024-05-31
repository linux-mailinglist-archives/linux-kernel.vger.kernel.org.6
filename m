Return-Path: <linux-kernel+bounces-196246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC338D595A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB771C2361C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4067F7D1;
	Fri, 31 May 2024 04:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OCzp+kyS"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797BC7C0B7;
	Fri, 31 May 2024 04:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717129720; cv=none; b=FFthFP+vgxjT2JmYiv1pDIEVXavFlADioc1FTxp+0Oth3L4+8Gn3PUD/fLEnuAWOKogvE987Ps+e/wKAJg9OFKGjstvT3I9+KyioZfP+f5+5g8+fnGmqk/qLvpMJ7istAXjDMJirkCsDFdcj5pIwjAbbVEaCDCTxic8zAT7XCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717129720; c=relaxed/simple;
	bh=46U5h53per638tT5ywpe2e5OChumG9O+v/gM7n6awIg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GhWwnUDZN8vyomgQZqeJreM6P+HsZxkSwtxVrXeO4SeKWbxF7p+qi3gQT0A2XaEyKxMoIgBelCRvciXyximNQ+rDAvDu0mmXgBPIGeFmsBxQf9gSVx2jBbObHec30OVuFa1LV/dNL/F4yNcNuBwhQWGutRV8CIJfI+PALqsto08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=OCzp+kyS; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UIqSo8025798;
	Thu, 30 May 2024 21:28:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
	qBuXUE6Nbw/vjzYr741WO/jvCC0/+xRi3M1BdX6bfI=; b=OCzp+kyS25+w0RvVw
	OsbbfPXX2Tu1muIdSvb4mecAokktRDuzVnmi394f00NnXcGXKbaLK6nBB5PedqJh
	cwhrPCY6CorBA24fUEpg2ObEEs5TbQXLvn8qZlQP3yAH3Lh7Irf4oRPJCy7QhHTV
	OUZ0B18C3FF8yH/vICwknyz0b/Mtz87OATnPHzDsdU8tmOl1pPHJ8/LcaECi58YI
	JCD1e2skNeTikgLrStQOn4KE4kRqyoBX7ZETRekCV3Nsowcee/3s5NbFMfiO3HQu
	/oLpDE2kqQqHad/rXoHMYAMfTc/QKwoYo/GI05B6X1z5ZfirOW7OdEBHh9uYimDP
	MDIaQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yegkn4xsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 21:28:20 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 30 May 2024 21:28:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 30 May 2024 21:28:19 -0700
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 5756F3F7097;
	Thu, 30 May 2024 21:28:15 -0700 (PDT)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>,
        Anil Kumar Reddy <areddy3@marvell.com>,
        Tanmay Jagdale <tanmay@marvell.com>
Subject: [PATCH v8 5/7] coresight: tmc: Add support for reading crash data
Date: Fri, 31 May 2024 09:57:43 +0530
Message-ID: <20240531042745.494222-6-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531042745.494222-1-lcherian@marvell.com>
References: <20240531042745.494222-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: R9K0AjdtS2y_0StCpt08_mWZgc296ByL
X-Proofpoint-GUID: R9K0AjdtS2y_0StCpt08_mWZgc296ByL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01

* Introduce a new mode CS_MODE_READ_CRASHDATA for reading trace
  captured in previous crash/watchdog reset.

* Add special device files for reading ETR/ETF crash data.

* User can read the crash data as below

  For example, for reading crash data from tmc_etf sink

  #dd if=/dev/crash_tmc_etfXX of=~/cstrace.bin

Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v7:
* Moved crash dev registration into new function,
  register_crash_dev_interface
* Removed redundant variable trace_addr in
  tmc_etr_setup_crashdata_buf

 .../coresight/coresight-etm4x-core.c          |   1 +
 .../hwtracing/coresight/coresight-tmc-core.c  | 148 ++++++++++++++++-
 .../hwtracing/coresight/coresight-tmc-etf.c   |  73 +++++++++
 .../hwtracing/coresight/coresight-tmc-etr.c   | 152 +++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tmc.h   |  11 +-
 include/linux/coresight.h                     |  13 ++
 6 files changed, 391 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index c2ca4a02dfce..5eb411e39b01 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1011,6 +1011,7 @@ static void etm4_disable(struct coresight_device *csdev,
 
 	switch (mode) {
 	case CS_MODE_DISABLED:
+	case CS_MODE_READ_CRASHDATA:
 		break;
 	case CS_MODE_SYSFS:
 		etm4_disable_sysfs(csdev);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 7170416c3e1a..aaa9de9f4cd2 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -103,6 +103,60 @@ u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata)
 	return mask;
 }
 
+int tmc_read_prepare_crashdata(struct tmc_drvdata *drvdata)
+{
+	int ret = 0;
+	struct tmc_crash_metadata *mdata;
+	struct coresight_device *csdev = drvdata->csdev;
+
+	if (!drvdata->crash_mdata.vaddr) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	mdata = drvdata->crash_mdata.vaddr;
+	/* Check data integrity of metadata */
+	if (mdata->crc32_mdata != find_crash_metadata_crc(mdata)) {
+		dev_dbg(&drvdata->csdev->dev,
+			"CRC mismatch in tmc crash metadata\n");
+		ret = -EINVAL;
+		goto out;
+	}
+	/* Check data integrity of tracedata */
+	if (mdata->crc32_tdata != find_crash_tracedata_crc(drvdata, mdata)) {
+		dev_dbg(&drvdata->csdev->dev,
+			"CRC mismatch in tmc crash tracedata\n");
+		ret = -EINVAL;
+		goto out;
+	}
+	/* Check for valid metadata */
+	if (!mdata->valid) {
+		dev_dbg(&drvdata->csdev->dev,
+			"Data invalid in tmc crash metadata\n");
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
+out:
+	return ret;
+}
+
+int tmc_read_unprepare_crashdata(struct tmc_drvdata *drvdata)
+{
+	struct coresight_device *csdev = drvdata->csdev;
+
+	/* Sink specific crashdata mode preparation */
+	return crashdata_ops(csdev)->unprepare(csdev);
+}
+
 static int tmc_read_prepare(struct tmc_drvdata *drvdata)
 {
 	int ret = 0;
@@ -153,6 +207,9 @@ static int tmc_open(struct inode *inode, struct file *file)
 	struct tmc_drvdata *drvdata = container_of(file->private_data,
 						   struct tmc_drvdata, miscdev);
 
+	if (coresight_get_mode(drvdata->csdev) == CS_MODE_READ_CRASHDATA)
+		return -EBUSY;
+
 	ret = tmc_read_prepare(drvdata);
 	if (ret)
 		return ret;
@@ -177,13 +234,12 @@ static inline ssize_t tmc_get_sysfs_trace(struct tmc_drvdata *drvdata,
 	return -EINVAL;
 }
 
-static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
-			loff_t *ppos)
+static ssize_t tmc_read_common(struct tmc_drvdata *drvdata, char __user *data,
+			       size_t len, loff_t *ppos)
 {
 	char *bufp;
 	ssize_t actual;
-	struct tmc_drvdata *drvdata = container_of(file->private_data,
-						   struct tmc_drvdata, miscdev);
+
 	actual = tmc_get_sysfs_trace(drvdata, *ppos, len, &bufp);
 	if (actual <= 0)
 		return 0;
@@ -200,6 +256,16 @@ static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
 	return actual;
 }
 
+static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
+			loff_t *ppos)
+{
+	struct tmc_drvdata *drvdata = container_of(file->private_data,
+						   struct tmc_drvdata, miscdev);
+
+	return tmc_read_common(drvdata, data, len, ppos);
+}
+
+
 static int tmc_release(struct inode *inode, struct file *file)
 {
 	int ret;
@@ -222,6 +288,61 @@ static const struct file_operations tmc_fops = {
 	.llseek		= no_llseek,
 };
 
+static int tmc_crashdata_open(struct inode *inode, struct file *file)
+{
+	int ret;
+	struct tmc_drvdata *drvdata = container_of(file->private_data,
+						   struct tmc_drvdata,
+						   crashdev);
+
+	if (!coresight_take_mode(drvdata->csdev, CS_MODE_READ_CRASHDATA))
+		return -EBUSY;
+
+	ret = tmc_read_prepare(drvdata);
+	if (ret) {
+		coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
+		return ret;
+	}
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
+	struct tmc_drvdata *drvdata = container_of(file->private_data,
+						   struct tmc_drvdata,
+						   crashdev);
+
+	return tmc_read_common(drvdata, data, len, ppos);
+}
+
+static int tmc_crashdata_release(struct inode *inode, struct file *file)
+{
+	int ret = 0;
+	struct tmc_drvdata *drvdata = container_of(file->private_data,
+						   struct tmc_drvdata,
+						   crashdev);
+
+	ret = tmc_read_unprepare(drvdata);
+
+	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
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
@@ -507,6 +628,18 @@ static u32 tmc_etr_get_max_burst_size(struct device *dev)
 	return burst_size;
 }
 
+static void register_crash_dev_interface(struct tmc_drvdata * drvdata,
+					 const char *name)
+{
+	drvdata->crashdev.name =
+		devm_kasprintf(&drvdata->csdev->dev, GFP_KERNEL, "%s_%s", "crash", name);
+	drvdata->crashdev.minor = MISC_DYNAMIC_MINOR;
+	drvdata->crashdev.fops = &tmc_crashdata_fops;
+	if (misc_register(&drvdata->crashdev))
+		dev_dbg(&drvdata->csdev->dev,
+			"Failed to setup user interface for crashdata\n");
+}
+
 static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	int ret = 0;
@@ -619,6 +752,10 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		coresight_unregister(drvdata->csdev);
 	else
 		pm_runtime_put(&adev->dev);
+
+	if (is_tmc_reserved_region_valid(dev))
+		register_crash_dev_interface(drvdata, desc.name);
+
 out:
 	return ret;
 }
@@ -630,7 +767,8 @@ static void tmc_shutdown(struct amba_device *adev)
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
-	if (coresight_get_mode(drvdata->csdev) == CS_MODE_DISABLED)
+	if ((coresight_get_mode(drvdata->csdev) == CS_MODE_DISABLED) ||
+	    (coresight_get_mode(drvdata->csdev) == CS_MODE_READ_CRASHDATA))
 		goto out;
 
 	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index f9569585e9f8..655c0c0ba54b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -657,6 +657,56 @@ static int tmc_panic_sync_etf(struct coresight_device *csdev)
 	return 0;
 }
 
+static int tmc_etb_setup_crashdata_buf(struct tmc_drvdata *drvdata)
+{
+	unsigned long size;
+	struct tmc_crash_metadata *mdata;
+	struct device *dev = &drvdata->csdev->dev;
+
+	mdata = drvdata->crash_mdata.vaddr;
+	size = mdata->size << 2;
+
+	/*
+	 * Buffer address given by metadata for retrieval of trace data
+	 * from previous boot is expected to be same as the reserved
+	 * trace buffer memory region provided through DTS
+	 */
+	if (is_tmc_reserved_region_valid(dev->parent)
+	    && (drvdata->crash_tbuf.paddr == mdata->trc_paddr))
+		drvdata->buf = drvdata->crash_tbuf.vaddr;
+	else {
+		dev_dbg(dev, "Trace buffer address of previous boot invalid\n");
+		return -EINVAL;
+	}
+
+	drvdata->len = size;
+	return 0;
+}
+
+static void tmc_etb_free_crashdata_buf(struct tmc_drvdata *drvdata)
+{
+	void *buf = drvdata->buf;
+
+	if (!buf)
+		return;
+	drvdata->buf = NULL;
+}
+
+static int tmc_etb_prepare_crashdata(struct coresight_device *csdev)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	return  tmc_etb_setup_crashdata_buf(drvdata);
+}
+
+static int tmc_etb_unprepare_crashdata(struct coresight_device *csdev)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	tmc_etb_free_crashdata_buf(drvdata);
+	return 0;
+}
+
 static const struct coresight_ops_sink tmc_etf_sink_ops = {
 	.enable		= tmc_enable_etf_sink,
 	.disable	= tmc_disable_etf_sink,
@@ -674,6 +724,11 @@ static const struct coresight_ops_panic tmc_etf_sync_ops = {
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
@@ -682,6 +737,7 @@ const struct coresight_ops tmc_etf_cs_ops = {
 	.sink_ops	= &tmc_etf_sink_ops,
 	.link_ops	= &tmc_etf_link_ops,
 	.panic_ops	= &tmc_etf_sync_ops,
+	.crashdata_ops	= &tmc_etf_crashdata_ops,
 };
 
 int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
@@ -702,6 +758,14 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 		goto out;
 	}
 
+	if (coresight_get_mode(drvdata->csdev) == CS_MODE_READ_CRASHDATA) {
+		ret = tmc_read_prepare_crashdata(drvdata);
+		if (ret)
+			goto out;
+		else
+			goto mode_valid;
+	}
+
 	/* Don't interfere if operated from Perf */
 	if (coresight_get_mode(drvdata->csdev) == CS_MODE_PERF) {
 		ret = -EINVAL;
@@ -725,6 +789,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 		__tmc_etb_disable_hw(drvdata);
 	}
 
+mode_valid:
 	drvdata->reading = true;
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -744,8 +809,16 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
 			 drvdata->config_type != TMC_CONFIG_TYPE_ETF))
 		return -EINVAL;
 
+
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
+	if (coresight_get_mode(drvdata->csdev) == CS_MODE_READ_CRASHDATA) {
+		tmc_read_unprepare_crashdata(drvdata);
+		drvdata->reading = false;
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return 0;
+	}
+
 	/* Re-enable the TMC if need be */
 	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS) {
 		/* There is no point in reading a TMC in HW FIFO mode */
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index be1079e8fd64..74f53972ce3c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1160,7 +1160,12 @@ ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
 {
 	s64 offset;
 	ssize_t actual = len;
-	struct etr_buf *etr_buf = drvdata->sysfs_buf;
+	struct etr_buf *etr_buf;
+
+	if (coresight_get_mode(drvdata->csdev) == CS_MODE_READ_CRASHDATA)
+		etr_buf = drvdata->sysfs_crash_buf;
+	else
+		etr_buf = drvdata->sysfs_buf;
 
 	if (pos + actual > etr_buf->len)
 		actual = etr_buf->len - pos;
@@ -1878,6 +1883,128 @@ static int tmc_panic_sync_etr(struct coresight_device *csdev)
 	return 0;
 }
 
+static int tmc_etr_setup_crashdata_buf(struct tmc_drvdata *drvdata)
+{
+	int rc = 0;
+	struct etr_buf *etr_buf;
+	struct etr_flat_buf *resrv_buf;
+	struct tmc_crash_metadata *mdata;
+	struct device *dev = &drvdata->csdev->dev;
+
+	mdata = drvdata->crash_mdata.vaddr;
+
+	etr_buf = kzalloc(sizeof(*etr_buf), GFP_ATOMIC);
+	if (!etr_buf) {
+		rc = -ENOMEM;
+		goto out;
+	}
+	etr_buf->size = drvdata->crash_tbuf.size;
+
+	resrv_buf = kzalloc(sizeof(*resrv_buf), GFP_ATOMIC);
+	if (!resrv_buf) {
+		rc = -ENOMEM;
+		goto rmem_err;
+	}
+
+	/*
+	 * Buffer address given by metadata for retrieval of trace data
+	 * from previous boot is expected to be same as the reserved
+	 * trace buffer memory region provided through DTS
+	 */
+	if (is_tmc_reserved_region_valid(dev->parent)
+	    && (drvdata->crash_tbuf.paddr == mdata->trc_paddr))
+		resrv_buf->vaddr = drvdata->crash_tbuf.vaddr;
+	else {
+		dev_dbg(dev, "Trace buffer address of previous boot invalid\n");
+		rc = -EINVAL;
+		goto map_err;
+	}
+
+	resrv_buf->size = etr_buf->size;
+	resrv_buf->dev = &drvdata->csdev->dev;
+	etr_buf->mode = ETR_MODE_RESRV;
+	etr_buf->private = resrv_buf;
+	etr_buf->ops = etr_buf_ops[ETR_MODE_RESRV];
+
+	drvdata->sysfs_crash_buf = etr_buf;
+
+	return 0;
+
+map_err:
+	kfree(resrv_buf);
+
+rmem_err:
+	kfree(etr_buf);
+
+out:
+	return rc;
+}
+
+static int tmc_etr_sync_crashdata_buf(struct tmc_drvdata *drvdata)
+{
+	u32 status;
+	u64 rrp, rwp, dba;
+	struct tmc_crash_metadata *mdata;
+	struct etr_buf *etr_buf = drvdata->sysfs_crash_buf;
+
+	mdata = drvdata->crash_mdata.vaddr;
+
+	rrp = mdata->rrp;
+	rwp = mdata->rwp;
+	dba = mdata->dba;
+	status = mdata->sts;
+
+	etr_buf->full = !!(status & TMC_STS_FULL);
+
+	/* Sync the buffer pointers */
+	etr_buf->offset = rrp - dba;
+	if (etr_buf->full)
+		etr_buf->len = etr_buf->size;
+	else
+		etr_buf->len = rwp - rrp;
+
+	/* Additional sanity checks for validating metadata */
+	if ((etr_buf->offset > etr_buf->size) ||
+	    (etr_buf->len > etr_buf->size)) {
+		dev_dbg(&drvdata->csdev->dev,
+			"Offset and length invalid in tmc crash metadata\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void tmc_etr_free_crashdata_buf(struct tmc_drvdata *drvdata)
+{
+	struct etr_buf *etr_buf = drvdata->sysfs_crash_buf;
+
+	if (!etr_buf)
+		return;
+	drvdata->sysfs_crash_buf = NULL;
+}
+
+static int tmc_etr_prepare_crashdata(struct coresight_device *csdev)
+{
+	int ret = 0;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	ret = tmc_etr_setup_crashdata_buf(drvdata);
+	if (ret)
+		goto out;
+	ret = tmc_etr_sync_crashdata_buf(drvdata);
+
+out:
+	return ret;
+}
+
+static int tmc_etr_unprepare_crashdata(struct coresight_device *csdev)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	tmc_etr_free_crashdata_buf(drvdata);
+	return 0;
+}
+
 static const struct coresight_ops_sink tmc_etr_sink_ops = {
 	.enable		= tmc_enable_etr_sink,
 	.disable	= tmc_disable_etr_sink,
@@ -1890,9 +2017,15 @@ static const struct coresight_ops_panic tmc_etr_sync_ops = {
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
@@ -1904,12 +2037,21 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 	if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETR))
 		return -EINVAL;
 
+
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
 		ret = -EBUSY;
 		goto out;
 	}
 
+	if (coresight_get_mode(drvdata->csdev) == CS_MODE_READ_CRASHDATA) {
+		ret = tmc_read_prepare_crashdata(drvdata);
+		if (ret)
+			goto out;
+		else
+			goto mode_valid;
+	}
+
 	/*
 	 * We can safely allow reads even if the ETR is operating in PERF mode,
 	 * since the sysfs session is captured in mode specific data.
@@ -1924,6 +2066,7 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
 		__tmc_etr_disable_hw(drvdata);
 
+mode_valid:
 	drvdata->reading = true;
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -1942,6 +2085,12 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
+	if (coresight_get_mode(drvdata->csdev) == CS_MODE_READ_CRASHDATA) {
+		sysfs_buf = drvdata->sysfs_crash_buf;
+		tmc_read_unprepare_crashdata(drvdata);
+		goto out;
+	}
+
 	/* RE-enable the TMC if need be */
 	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS) {
 		/*
@@ -1959,6 +2108,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 		drvdata->sysfs_buf = NULL;
 	}
 
+out:
 	drvdata->reading = false;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 875d4129da7c..528174283ecc 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -200,6 +200,8 @@ struct tmc_resrv_buf {
  * @base:	memory mapped base address for this component.
  * @csdev:	component vitals needed by the framework.
  * @miscdev:	specifics to handle "/dev/xyz.tmc" entry.
+ * @crashdev:	specifics to handle "/dev/crash_tmc_xyz" entry for reading
+ *		crash tracedata.
  * @spinlock:	only one at a time pls.
  * @pid:	Process ID of the process being monitored by the session
  *		that is using this component.
@@ -218,7 +220,10 @@ struct tmc_resrv_buf {
  * @idr_mutex:	Access serialisation for idr.
  * @sysfs_buf:	SYSFS buffer for ETR.
  * @perf_buf:	PERF buffer for ETR.
- * @crash_tbuf:	Used by ETR as hardware trace buffer and for trace data
+ * @sysfs_crash_buf: Sysfs crashdata buffer for ETR. This is a special purpose
+ *		buffer that is used only for mapping the trace buffer from
+ *		previous crash and not for capturing trace.
+ * @crash_tbuf: Used by ETR as hardware trace buffer and for trace data
  *		retention (after crash) only when ETR_MODE_RESRV buffer
  *		mode is enabled. Used by ETF for trace data retention
  *		(after crash) by default.
@@ -229,6 +234,7 @@ struct tmc_drvdata {
 	void __iomem		*base;
 	struct coresight_device	*csdev;
 	struct miscdevice	miscdev;
+	struct miscdevice	crashdev;
 	spinlock_t		spinlock;
 	pid_t			pid;
 	bool			reading;
@@ -248,6 +254,7 @@ struct tmc_drvdata {
 	struct mutex		idr_mutex;
 	struct etr_buf		*sysfs_buf;
 	struct etr_buf		*perf_buf;
+	struct etr_buf		*sysfs_crash_buf;
 	struct tmc_resrv_buf	crash_tbuf;
 	struct tmc_resrv_buf	crash_mdata;
 };
@@ -299,6 +306,8 @@ void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
 void tmc_enable_hw(struct tmc_drvdata *drvdata);
 void tmc_disable_hw(struct tmc_drvdata *drvdata);
 u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata);
+int tmc_read_prepare_crashdata(struct tmc_drvdata *drvdata);
+int tmc_read_unprepare_crashdata(struct tmc_drvdata *drvdata);
 
 /* ETB/ETF functions */
 int tmc_read_prepare_etb(struct tmc_drvdata *drvdata);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index b156467c9baa..b5e825b25e9d 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -308,6 +308,7 @@ enum cs_mode {
 	CS_MODE_DISABLED,
 	CS_MODE_SYSFS,
 	CS_MODE_PERF,
+	CS_MODE_READ_CRASHDATA, /* Trace data from previous crash */
 };
 
 #define source_ops(csdev)	csdev->ops->source_ops
@@ -316,6 +317,7 @@ enum cs_mode {
 #define helper_ops(csdev)	csdev->ops->helper_ops
 #define ect_ops(csdev)		csdev->ops->ect_ops
 #define panic_ops(csdev)	csdev->ops->panic_ops
+#define crashdata_ops(csdev)	csdev->ops->crashdata_ops
 
 /**
  * struct coresight_ops_sink - basic operations for a sink
@@ -395,12 +397,23 @@ struct coresight_ops_panic {
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


