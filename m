Return-Path: <linux-kernel+bounces-404057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3249C3E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5C02811B7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529C119D8BD;
	Mon, 11 Nov 2024 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="e4iBeLvs"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B18F8F77;
	Mon, 11 Nov 2024 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329301; cv=none; b=pqQO9mINo/2BXh+WnULntqRTKun4xxV5doqldIDee1QECmGq7yPwAAueNaZENZrVsam3Ckg33NAh0rBo3WfgQJr4d464CtlGIbBreegHWZfIcaYSEylxmfMJ2mU6GaakOdU/ujao/yPr2MB1zNLvn39jBuF0iqSto/YMT2UftuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329301; c=relaxed/simple;
	bh=pFPY65RTZX6vCUrobMEMIvacAJTvinOuLIpUXw1nDy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJJ3ZHBmmYn/emz21r0X/BHt8WqWx7AifMKh+LZOH7A7RUWfRN1kyavMNZOJSlyo3BhDqOmejm8qsizPdw66gYkGMNcFjUIPQ3NjjKWoSQzc6yy9wNPhbsI8ftP7hd8BNRTDMn7fdSd3wK3VbZfB0BBxSGwMW9cTiyAPolS0bXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=e4iBeLvs; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABCFCKC031413;
	Mon, 11 Nov 2024 04:48:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
	4WINJpPNYoL+HwZvSa4rbFbRC23N34MNLK9HI35xUw=; b=e4iBeLvslpMwA2wJA
	NuZm5mkiQtIqd99RJaFut65i5E0crxoFTFk7anqTKP4I9hK+DN03rXb6bfmJrIBA
	Lvgi31jrUxFR3VnmLuW9TOlubg3i7NHtD7CXhadN9IXZ2M1Tz6P6/exz0pX4GT/l
	QYUTV+LUJH3v+7WwCw8UR5MVWQVpPhSO/5EY4k4QcW3nBn/xhNKiycSGU6VNdDbU
	rW/1TaS/NhHKkqKIiErAE1ZDHqrjzO+9eKHLRbGX2KQxu/Q6zuZkG8yvvQbj2+w1
	ZSnTggDn1+9+w+jw7b6v5GqSm3KQoqa+78OD3Ae7iWdE0bde2BHShJD1jDuA3FCb
	IT0rA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42uhrrg1bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 04:48:08 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 11 Nov 2024 04:48:07 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 11 Nov 2024 04:48:07 -0800
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 900103F70AE;
	Mon, 11 Nov 2024 04:48:02 -0800 (PST)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>,
        Anil Kumar Reddy
	<areddy3@marvell.com>
Subject: [PATCH v11 2/8] coresight: tmc-etr: Add support to use reserved trace memory
Date: Mon, 11 Nov 2024 18:17:40 +0530
Message-ID: <20241111124746.2210378-3-lcherian@marvell.com>
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
X-Proofpoint-GUID: I4iBfOjLcCl2v93d0JFU7T-C0buUAo_5
X-Proofpoint-ORIG-GUID: I4iBfOjLcCl2v93d0JFU7T-C0buUAo_5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Add support to use reserved memory for coresight ETR trace buffer.

Introduce a new ETR buffer mode called ETR_MODE_RESRV, which
becomes available when ETR device tree node is supplied with a valid
reserved memory region.

ETR_MODE_RESRV can be selected only by explicit user request.

$ echo resrv >/sys/bus/coresight/devices/tmc_etr<N>/buf_mode_preferred

Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
Signed-off-by: Linu Cherian <lcherian@marvell.com>
Reviewed-by: James Clark <james.clark@arm.com>
---
Changelog from v10:
No changes.

 .../hwtracing/coresight/coresight-tmc-core.c  | 50 ++++++++++++
 .../hwtracing/coresight/coresight-tmc-etr.c   | 79 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h   | 25 ++++++
 3 files changed, 154 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 3a482fd2cb22..248989833b20 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -23,6 +23,7 @@
 #include <linux/spinlock.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/coresight.h>
 #include <linux/amba/bus.h>
 #include <linux/platform_device.h>
@@ -398,6 +399,53 @@ static inline bool tmc_etr_has_non_secure_access(struct tmc_drvdata *drvdata)
 
 static const struct amba_id tmc_ids[];
 
+static int of_tmc_get_reserved_resource_by_name(struct device *dev,
+						const char *name,
+						struct resource *res)
+{
+	int index, rc = -ENODEV;
+	struct device_node *node;
+
+	if (!is_of_node(dev->fwnode))
+		return -ENODEV;
+
+	index = of_property_match_string(dev->of_node, "memory-region-names",
+					 name);
+	if (index < 0)
+		return rc;
+
+	node = of_parse_phandle(dev->of_node, "memory-region", index);
+	if (!node)
+		return rc;
+
+	if (!of_address_to_resource(node, 0, res) &&
+	    res->start != 0 && resource_size(res) != 0)
+		rc = 0;
+	of_node_put(node);
+
+	return rc;
+}
+
+static void tmc_get_reserved_region(struct device *parent)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(parent);
+	struct resource res;
+
+	if (of_tmc_get_reserved_resource_by_name(parent, "tracedata", &res))
+		return;
+
+	drvdata->resrv_buf.vaddr = memremap(res.start,
+						resource_size(&res),
+						MEMREMAP_WC);
+	if (IS_ERR_OR_NULL(drvdata->resrv_buf.vaddr)) {
+		dev_err(parent, "Reserved trace buffer mapping failed\n");
+		return;
+	}
+
+	drvdata->resrv_buf.paddr = res.start;
+	drvdata->resrv_buf.size  = resource_size(&res);
+}
+
 /* Detect and initialise the capabilities of a TMC ETR */
 static int tmc_etr_setup_caps(struct device *parent, u32 devid,
 			      struct csdev_access *access)
@@ -508,6 +556,8 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 		drvdata->size = readl_relaxed(drvdata->base + TMC_RSZ) * 4;
 	}
 
+	tmc_get_reserved_region(dev);
+
 	desc.dev = dev;
 
 	switch (drvdata->config_type) {
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index a48bb85d0e7f..8bca5b36334a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -30,6 +30,7 @@ struct etr_buf_hw {
 	bool	has_iommu;
 	bool	has_etr_sg;
 	bool	has_catu;
+	bool	has_resrv;
 };
 
 /*
@@ -695,6 +696,75 @@ static const struct etr_buf_operations etr_flat_buf_ops = {
 	.get_data = tmc_etr_get_data_flat_buf,
 };
 
+/*
+ * tmc_etr_alloc_resrv_buf: Allocate a contiguous DMA buffer from reserved region.
+ */
+static int tmc_etr_alloc_resrv_buf(struct tmc_drvdata *drvdata,
+				  struct etr_buf *etr_buf, int node,
+				  void **pages)
+{
+	struct etr_flat_buf *resrv_buf;
+	struct device *real_dev = drvdata->csdev->dev.parent;
+
+	/* We cannot reuse existing pages for resrv buf */
+	if (pages)
+		return -EINVAL;
+
+	resrv_buf = kzalloc(sizeof(*resrv_buf), GFP_KERNEL);
+	if (!resrv_buf)
+		return -ENOMEM;
+
+	resrv_buf->daddr = dma_map_resource(real_dev, drvdata->resrv_buf.paddr,
+					   drvdata->resrv_buf.size,
+					   DMA_FROM_DEVICE, 0);
+	if (dma_mapping_error(real_dev, resrv_buf->daddr)) {
+		dev_err(real_dev, "failed to map source buffer address\n");
+		kfree(resrv_buf);
+		return -ENOMEM;
+	}
+
+	resrv_buf->vaddr = drvdata->resrv_buf.vaddr;
+	resrv_buf->size = etr_buf->size = drvdata->resrv_buf.size;
+	resrv_buf->dev = &drvdata->csdev->dev;
+	etr_buf->hwaddr = resrv_buf->daddr;
+	etr_buf->mode = ETR_MODE_RESRV;
+	etr_buf->private = resrv_buf;
+	return 0;
+}
+
+static void tmc_etr_free_resrv_buf(struct etr_buf *etr_buf)
+{
+	struct etr_flat_buf *resrv_buf = etr_buf->private;
+
+	if (resrv_buf && resrv_buf->daddr) {
+		struct device *real_dev = resrv_buf->dev->parent;
+
+		dma_unmap_resource(real_dev, resrv_buf->daddr,
+				resrv_buf->size, DMA_FROM_DEVICE, 0);
+	}
+	kfree(resrv_buf);
+}
+
+static void tmc_etr_sync_resrv_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
+{
+	/*
+	 * Adjust the buffer to point to the beginning of the trace data
+	 * and update the available trace data.
+	 */
+	etr_buf->offset = rrp - etr_buf->hwaddr;
+	if (etr_buf->full)
+		etr_buf->len = etr_buf->size;
+	else
+		etr_buf->len = rwp - rrp;
+}
+
+static const struct etr_buf_operations etr_resrv_buf_ops = {
+	.alloc = tmc_etr_alloc_resrv_buf,
+	.free = tmc_etr_free_resrv_buf,
+	.sync = tmc_etr_sync_resrv_buf,
+	.get_data = tmc_etr_get_data_flat_buf,
+};
+
 /*
  * tmc_etr_alloc_sg_buf: Allocate an SG buf @etr_buf. Setup the parameters
  * appropriately.
@@ -801,6 +871,7 @@ static const struct etr_buf_operations *etr_buf_ops[] = {
 	[ETR_MODE_FLAT] = &etr_flat_buf_ops,
 	[ETR_MODE_ETR_SG] = &etr_sg_buf_ops,
 	[ETR_MODE_CATU] = NULL,
+	[ETR_MODE_RESRV] = &etr_resrv_buf_ops
 };
 
 void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu)
@@ -826,6 +897,7 @@ static inline int tmc_etr_mode_alloc_buf(int mode,
 	case ETR_MODE_FLAT:
 	case ETR_MODE_ETR_SG:
 	case ETR_MODE_CATU:
+	case ETR_MODE_RESRV:
 		if (etr_buf_ops[mode] && etr_buf_ops[mode]->alloc)
 			rc = etr_buf_ops[mode]->alloc(drvdata, etr_buf,
 						      node, pages);
@@ -844,6 +916,7 @@ static void get_etr_buf_hw(struct device *dev, struct etr_buf_hw *buf_hw)
 	buf_hw->has_iommu = iommu_get_domain_for_dev(dev->parent);
 	buf_hw->has_etr_sg = tmc_etr_has_cap(drvdata, TMC_ETR_SG);
 	buf_hw->has_catu = !!tmc_etr_get_catu_device(drvdata);
+	buf_hw->has_resrv = tmc_has_reserved_buffer(drvdata);
 }
 
 static bool etr_can_use_flat_mode(struct etr_buf_hw *buf_hw, ssize_t etr_buf_size)
@@ -1831,6 +1904,7 @@ static const char *const buf_modes_str[] = {
 	[ETR_MODE_FLAT]		= "flat",
 	[ETR_MODE_ETR_SG]	= "tmc-sg",
 	[ETR_MODE_CATU]		= "catu",
+	[ETR_MODE_RESRV]	= "resrv",
 	[ETR_MODE_AUTO]		= "auto",
 };
 
@@ -1849,6 +1923,9 @@ static ssize_t buf_modes_available_show(struct device *dev,
 	if (buf_hw.has_catu)
 		size += sysfs_emit_at(buf, size, "%s ", buf_modes_str[ETR_MODE_CATU]);
 
+	if (buf_hw.has_resrv)
+		size += sysfs_emit_at(buf, size, "%s ", buf_modes_str[ETR_MODE_RESRV]);
+
 	size += sysfs_emit_at(buf, size, "\n");
 	return size;
 }
@@ -1876,6 +1953,8 @@ static ssize_t buf_mode_preferred_store(struct device *dev,
 		drvdata->etr_mode = ETR_MODE_ETR_SG;
 	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_CATU]) && buf_hw.has_catu)
 		drvdata->etr_mode = ETR_MODE_CATU;
+	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_RESRV]) && buf_hw.has_resrv)
+		drvdata->etr_mode = ETR_MODE_RESRV;
 	else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_AUTO]))
 		drvdata->etr_mode = ETR_MODE_AUTO;
 	else
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 2671926be62a..d2261eddab71 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -135,6 +135,7 @@ enum etr_mode {
 	ETR_MODE_FLAT,		/* Uses contiguous flat buffer */
 	ETR_MODE_ETR_SG,	/* Uses in-built TMC ETR SG mechanism */
 	ETR_MODE_CATU,		/* Use SG mechanism in CATU */
+	ETR_MODE_RESRV,		/* Use reserved region contiguous buffer */
 	ETR_MODE_AUTO,		/* Use the default mechanism */
 };
 
@@ -164,6 +165,17 @@ struct etr_buf {
 	void				*private;
 };
 
+/**
+ * @paddr	: Start address of reserved memory region.
+ * @vaddr	: Corresponding CPU virtual address.
+ * @size	: Size of reserved memory region.
+ */
+struct tmc_resrv_buf {
+	phys_addr_t     paddr;
+	void		*vaddr;
+	size_t		size;
+};
+
 /**
  * struct tmc_drvdata - specifics associated to an TMC component
  * @pclk:	APB clock if present, otherwise NULL
@@ -189,6 +201,10 @@ struct etr_buf {
  * @idr_mutex:	Access serialisation for idr.
  * @sysfs_buf:	SYSFS buffer for ETR.
  * @perf_buf:	PERF buffer for ETR.
+ * @resrv_buf:	Used by ETR as hardware trace buffer and for trace data
+ *		retention (after crash) only when ETR_MODE_RESRV buffer
+ *		mode is enabled. Used by ETF for trace data retention
+ *		(after crash) by default.
  */
 struct tmc_drvdata {
 	struct clk		*pclk;
@@ -214,6 +230,7 @@ struct tmc_drvdata {
 	struct mutex		idr_mutex;
 	struct etr_buf		*sysfs_buf;
 	struct etr_buf		*perf_buf;
+	struct tmc_resrv_buf	resrv_buf;
 };
 
 struct etr_buf_operations {
@@ -331,6 +348,14 @@ tmc_sg_table_buf_size(struct tmc_sg_table *sg_table)
 	return (unsigned long)sg_table->data_pages.nr_pages << PAGE_SHIFT;
 }
 
+static inline bool tmc_has_reserved_buffer(struct tmc_drvdata *drvdata)
+{
+	if (drvdata->resrv_buf.vaddr &&
+	    drvdata->resrv_buf.size)
+		return true;
+	return false;
+}
+
 struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
 
 void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu);
-- 
2.34.1


