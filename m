Return-Path: <linux-kernel+bounces-415293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E8F9D33FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049D82856B1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FC415F330;
	Wed, 20 Nov 2024 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LdDEAIgn"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BC615B551
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732086406; cv=none; b=jlhxi7DZgWRgBJTfTryYOGTVuMPhkO/pCjWE+gMurZEjTAM7Su5CUzhIK1zij64SQIRxWOqJMKNj8j4jH0rqw57dwXwpNMxbVUGrA8gLMif3ocV3NdKvkyVgmd1Rls1Vpl5jfhH3jA/LuUICTx+Uk2A8FI79ijgRlyPHkIvacgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732086406; c=relaxed/simple;
	bh=nnpmpA+suKLTyU9BKB+UJneKooi1vgCVXUcixQT6vNE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tnCGbLZBaYkclwfd4YO7rMTIi0ABjdMENn6t5f2STyJWg1msGyBPIlgyYwsV1//O1QoUmVX9s8TsJTnVcqPbTuWdTfRNWTT3q4waRDL5D8agRUnniAaAfAYb397Z/glxkAgjaTG5jUMbWGxAGO70dKCS3B9Pd8pJRmvzUR7usxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LdDEAIgn; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK5jOsZ006908;
	Tue, 19 Nov 2024 23:06:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=65/dyEOujDIOh+5FxgDFWe1
	XbVSBH9Bj6k446Cd7MZ4=; b=LdDEAIgnCvzWYTCbnl9SqzVn44ujISRu6Wav7Cb
	NU/qVgf4XEOLr6jC0q3lu6ViQDt1gN0JHmXYNijhhBR+mkvtuf3CjRI40fPsMLzQ
	a9nXLDLJ3XyzEj0cimygfgwuOB40Ulc0i4DKc3f96pJidBUEPZVgpeZfkWq0JKmf
	ZreMBJpTP1z8Iq9GijnoqviwYhJKeJyR9tu79wb4OZk6OAZ3Gs3TQno0DwH8PsZ0
	lzdpTiNP3gUQ78X0T4mI1JHDv0dSyZ8ozOVckdPfBI1gMzPKOAuRTPkf930MD8BK
	oKFaTYAN84LTbtCUL0iV3BjWRPy+NYfY5ULh79dzZ8icjLA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4319w7r4e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 23:06:29 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 19 Nov 2024 23:06:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 19 Nov 2024 23:06:29 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
	by maili.marvell.com (Postfix) with ESMTP id 387363F7062;
	Tue, 19 Nov 2024 23:06:24 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <virtualization@lists.linux.dev>, <mst@redhat.com>, <jasowang@redhat.com>
CC: Shijith Thotton <sthotton@marvell.com>, <schalla@marvell.com>,
        <vattunuru@marvell.com>, <ndabilpuram@marvell.com>,
        <jerinj@marvell.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Satha Rao
	<skoteshwar@marvell.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] vdpa/octeon_ep: enable support for multiple interrupts per device
Date: Wed, 20 Nov 2024 12:34:50 +0530
Message-ID: <20241120070508.789508-1-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: stmRyQl8NuF_vAqTgoMNXMz5uaA88yDJ
X-Proofpoint-ORIG-GUID: stmRyQl8NuF_vAqTgoMNXMz5uaA88yDJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Updated the driver to utilize all the MSI-X interrupt vectors supported
by each OCTEON endpoint VF, instead of relying on a single vector.
Enabling more interrupts allows packets from multiple rings to be
distributed across multiple cores, improving parallelism and
performance.

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 drivers/vdpa/octeon_ep/octep_vdpa.h      | 10 +--
 drivers/vdpa/octeon_ep/octep_vdpa_hw.c   |  2 -
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 88 ++++++++++++++++--------
 3 files changed, 63 insertions(+), 37 deletions(-)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa.h b/drivers/vdpa/octeon_ep/octep_vdpa.h
index 046710ec4d42..2d4bb07f91b3 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa.h
+++ b/drivers/vdpa/octeon_ep/octep_vdpa.h
@@ -29,12 +29,12 @@
 #define OCTEP_EPF_RINFO(x) (0x000209f0 | ((x) << 25))
 #define OCTEP_VF_MBOX_DATA(x) (0x00010210 | ((x) << 17))
 #define OCTEP_PF_MBOX_DATA(x) (0x00022000 | ((x) << 4))
-
-#define OCTEP_EPF_RINFO_RPVF(val) (((val) >> 32) & 0xF)
-#define OCTEP_EPF_RINFO_NVFS(val) (((val) >> 48) & 0x7F)
+#define OCTEP_VF_IN_CTRL(x)        (0x00010000 | ((x) << 17))
+#define OCTEP_VF_IN_CTRL_RPVF(val) (((val) >> 48) & 0xF)
 
 #define OCTEP_FW_READY_SIGNATURE0  0xFEEDFEED
 #define OCTEP_FW_READY_SIGNATURE1  0x3355ffaa
+#define OCTEP_MAX_CB_INTR          8
 
 enum octep_vdpa_dev_status {
 	OCTEP_VDPA_DEV_STATUS_INVALID,
@@ -50,7 +50,6 @@ struct octep_vring_info {
 	void __iomem *notify_addr;
 	u32 __iomem *cb_notify_addr;
 	phys_addr_t notify_pa;
-	char msix_name[256];
 };
 
 struct octep_hw {
@@ -68,7 +67,8 @@ struct octep_hw {
 	u64 features;
 	u16 nr_vring;
 	u32 config_size;
-	int irq;
+	int nb_irqs;
+	int *irqs;
 };
 
 u8 octep_hw_get_status(struct octep_hw *oct_hw);
diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
index 1d4767b33315..d5a599f87e18 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
@@ -495,8 +495,6 @@ int octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev)
 	if (!oct_hw->vqs)
 		return -ENOMEM;
 
-	oct_hw->irq = -1;
-
 	dev_info(&pdev->dev, "Device features : %llx\n", oct_hw->features);
 	dev_info(&pdev->dev, "Maximum queues : %u\n", oct_hw->nr_vring);
 
diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index cd55b1aac151..482c178a5221 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -47,13 +47,30 @@ static struct octep_hw *vdpa_to_octep_hw(struct vdpa_device *vdpa_dev)
 static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
 {
 	struct octep_hw *oct_hw = data;
-	int i;
+	int i, ring_start, ring_stride;
+
+	/* Each device has multiple interrupts (nb_irqs) shared among receive
+	 * rings (nr_vring). Device interrupts are mapped to specific receive
+	 * rings in a round-robin fashion. Only rings handling receive
+	 * operations require interrupts, and these are at even indices.
+	 *
+	 * For example, if nb_irqs = 8 and nr_vring = 64:
+	 * 0 -> 0, 16, 32, 48;
+	 * 1 -> 2, 18, 34, 50;
+	 * ...
+	 * 7 -> 14, 30, 46, 62;
+	 */
+	ring_start = (irq - oct_hw->irqs[0]) * 2;
+	ring_stride = oct_hw->nb_irqs * 2;
 
-	for (i = 0; i < oct_hw->nr_vring; i++) {
-		if (oct_hw->vqs[i].cb.callback && ioread32(oct_hw->vqs[i].cb_notify_addr)) {
-			/* Acknowledge the per queue notification to the device */
+	for (i = ring_start; i < oct_hw->nr_vring; i += ring_stride) {
+		if (ioread32(oct_hw->vqs[i].cb_notify_addr)) {
+			/* Acknowledge the per ring notification to the device */
 			iowrite32(0, oct_hw->vqs[i].cb_notify_addr);
-			oct_hw->vqs[i].cb.callback(oct_hw->vqs[i].cb.private);
+
+			if (likely(oct_hw->vqs[i].cb.callback))
+				oct_hw->vqs[i].cb.callback(oct_hw->vqs[i].cb.private);
+			break;
 		}
 	}
 
@@ -63,44 +80,53 @@ static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
 static void octep_free_irqs(struct octep_hw *oct_hw)
 {
 	struct pci_dev *pdev = oct_hw->pdev;
+	int irq;
+
+	for (irq = 0; irq < oct_hw->nb_irqs && oct_hw->irqs; irq++) {
+		if (oct_hw->irqs[irq] < 0)
+			continue;
 
-	if (oct_hw->irq != -1) {
-		devm_free_irq(&pdev->dev, oct_hw->irq, oct_hw);
-		oct_hw->irq = -1;
+		devm_free_irq(&pdev->dev, oct_hw->irqs[irq], oct_hw);
 	}
+
 	pci_free_irq_vectors(pdev);
+	kfree(oct_hw->irqs);
 }
 
 static int octep_request_irqs(struct octep_hw *oct_hw)
 {
 	struct pci_dev *pdev = oct_hw->pdev;
-	int ret, irq;
+	int ret, irq, idx;
 
-	/* Currently HW device provisions one IRQ per VF, hence
-	 * allocate one IRQ for all virtqueues call interface.
-	 */
-	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
+	ret = pci_alloc_irq_vectors(pdev, 1, oct_hw->nb_irqs, PCI_IRQ_MSIX);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to alloc msix vector");
 		return ret;
 	}
 
-	snprintf(oct_hw->vqs->msix_name, sizeof(oct_hw->vqs->msix_name),
-		 OCTEP_VDPA_DRIVER_NAME "-vf-%d", pci_iov_vf_id(pdev));
+	oct_hw->irqs = kcalloc(oct_hw->nb_irqs, sizeof(int), GFP_KERNEL);
+	if (!oct_hw->irqs) {
+		ret = -ENOMEM;
+		goto free_irqs;
+	}
 
-	irq = pci_irq_vector(pdev, 0);
-	ret = devm_request_irq(&pdev->dev, irq, octep_vdpa_intr_handler, 0,
-			       oct_hw->vqs->msix_name, oct_hw);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to register interrupt handler\n");
-		goto free_irq_vec;
+	memset(oct_hw->irqs, -1, sizeof(oct_hw->irqs));
+
+	for (idx = 0; idx < oct_hw->nb_irqs; idx++) {
+		irq = pci_irq_vector(pdev, idx);
+		ret = devm_request_irq(&pdev->dev, irq, octep_vdpa_intr_handler, 0,
+				       dev_name(&pdev->dev), oct_hw);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to register interrupt handler\n");
+			goto free_irqs;
+		}
+		oct_hw->irqs[idx] = irq;
 	}
-	oct_hw->irq = irq;
 
 	return 0;
 
-free_irq_vec:
-	pci_free_irq_vectors(pdev);
+free_irqs:
+	octep_free_irqs(oct_hw);
 	return ret;
 }
 
@@ -559,6 +585,7 @@ static void octep_vdpa_setup_task(struct work_struct *work)
 	struct device *dev = &pdev->dev;
 	struct octep_hw *oct_hw;
 	unsigned long timeout;
+	u64 val;
 	int ret;
 
 	oct_hw = &mgmt_dev->oct_hw;
@@ -590,6 +617,13 @@ static void octep_vdpa_setup_task(struct work_struct *work)
 	if (ret)
 		return;
 
+	val = readq(oct_hw->base[OCTEP_HW_MBOX_BAR] + OCTEP_VF_IN_CTRL(0));
+	oct_hw->nb_irqs = OCTEP_VF_IN_CTRL_RPVF(val);
+	if (!oct_hw->nb_irqs || oct_hw->nb_irqs > OCTEP_MAX_CB_INTR) {
+		dev_err(dev, "Invalid number of interrupts %d\n", oct_hw->nb_irqs);
+		goto unmap_region;
+	}
+
 	ret = octep_hw_caps_read(oct_hw, pdev);
 	if (ret < 0)
 		goto unmap_region;
@@ -768,12 +802,6 @@ static int octep_vdpa_pf_setup(struct octep_pf *octpf)
 		return -EINVAL;
 	}
 
-	if (OCTEP_EPF_RINFO_RPVF(val) != BIT_ULL(0)) {
-		val &= ~GENMASK_ULL(35, 32);
-		val |= BIT_ULL(32);
-		writeq(val, addr + OCTEP_EPF_RINFO(0));
-	}
-
 	len = pci_resource_len(pdev, OCTEP_HW_CAPS_BAR);
 
 	octpf->vf_stride = len / totalvfs;
-- 
2.25.1


