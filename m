Return-Path: <linux-kernel+bounces-417027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E12E9D4DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D58D2B244C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDB71D90D9;
	Thu, 21 Nov 2024 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Iu7HHcnL"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893961D90C9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732196631; cv=none; b=q4GPh9IX8W1sDEwGjtCQ7tvhv02oZHzw2tvZOTpTBBrG064u/qGivQVJk586M2twRkKVuOJwUXGRHLf5ebNLFaLQJSkF8JX05qvMx27OKEvpvUUSpdxpco7zFyH5YYSx0UcuxghhnA33caEKdHpyH/KWOquih/lnohP5vs+Jmwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732196631; c=relaxed/simple;
	bh=bi2TgrFIAADTQaEoc0SbA4vMl2Ic3zTJSmj0mM2NJic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTEIdplpGq0SnmjyBECFjiermlbogBu/obBf9zCUxpOhFQAA5kY9cV2/bIw4lTeA9JGV7gshWBU/bUbgYxA18Izq6XNw0GSEmIiW/NDQZcAP2mB70PbSB6p320ncE1wCa5peOS/msttytU+zPWuyDBecp7X566/riQE9BBrUWkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Iu7HHcnL; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALCOTm6018637;
	Thu, 21 Nov 2024 05:43:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
	zINpovljhPzI4/rMho01LMLd8GtFYf82lRaDepGCaY=; b=Iu7HHcnLk/4YuKZJn
	Nw25tBgBg1uDy20+bmbT9roDHCG53Q0ScFNglNtVPqyMhbWy0W3879P7ix5t8bAD
	lY9W8seQ6CQwoaIIWPj8D19K8ggulDBEcb/OBYLzOFTKN6mxsZdSwT7oaNPoO8GY
	ysDQhtAcMPePhedu2magxprDTCTBQbnNjIbpiReH5ybtbmDb/dakz2G/BuJTMJF2
	XNpeQbyM+ZhJoKv0GuQYC2xWwAvvGL1JqPEvq7o8BBOP5sIpKszmDUg2nFuJBdWT
	/D+i9B7IhvD+xIf3xSTcJJDLkhLJvzZJh+Aqbggpa/m7nj3jAKZZbE5q+CQHQUYs
	+sU+A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4322bjgbvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 05:43:40 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 21 Nov 2024 05:43:39 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 21 Nov 2024 05:43:39 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
	by maili.marvell.com (Postfix) with ESMTP id 662993F7067;
	Thu, 21 Nov 2024 05:43:35 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <virtualization@lists.linux.dev>, <mst@redhat.com>, <jasowang@redhat.com>,
        <dan.carpenter@linaro.org>
CC: Shijith Thotton <sthotton@marvell.com>, <schalla@marvell.com>,
        <vattunuru@marvell.com>, <ndabilpuram@marvell.com>,
        <jerinj@marvell.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        Satha Rao <skoteshwar@marvell.com>,
        open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] vdpa/octeon_ep: add interrupt handler for virtio crypto device
Date: Thu, 21 Nov 2024 19:09:46 +0530
Message-ID: <20241121134002.990285-4-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241121134002.990285-1-sthotton@marvell.com>
References: <20241121134002.990285-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OWfc79f2fcZ7csua2ZBuILGtQZQ-JzcR
X-Proofpoint-GUID: OWfc79f2fcZ7csua2ZBuILGtQZQ-JzcR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Introduced an interrupt handler for the virtio crypto device, as its
queue usage differs from that of network devices. While virtio network
device receives packets only on even-indexed queues, virtio crypto
device utilize all available queues for processing data.

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 52 +++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index d674b9678428..1bdf7a8111ce 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -44,7 +44,35 @@ static struct octep_hw *vdpa_to_octep_hw(struct vdpa_device *vdpa_dev)
 	return oct_vdpa->oct_hw;
 }
 
-static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
+static irqreturn_t octep_vdpa_crypto_irq_handler(int irq, void *data)
+{
+	struct octep_hw *oct_hw = data;
+	int i;
+
+	/* Each device interrupt (nb_irqs) maps to specific receive rings
+	 * (nr_vring) in a round-robin fashion.
+	 *
+	 * For example, if nb_irqs = 8 and nr_vring = 64:
+	 * 0 -> 0, 8, 16, 24, 32, 40, 48, 56;
+	 * 1 -> 1, 9, 17, 25, 33, 41, 49, 57;
+	 * ...
+	 * 7 -> 7, 15, 23, 31, 39, 47, 55, 63;
+	 */
+	for (i = irq - oct_hw->irqs[0]; i < oct_hw->nr_vring; i += oct_hw->nb_irqs) {
+		if (ioread32(oct_hw->vqs[i].cb_notify_addr)) {
+			/* Acknowledge the per ring notification to the device */
+			iowrite32(0, oct_hw->vqs[i].cb_notify_addr);
+
+			if (likely(oct_hw->vqs[i].cb.callback))
+				oct_hw->vqs[i].cb.callback(oct_hw->vqs[i].cb.private);
+			break;
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t octep_vdpa_net_irq_handler(int irq, void *data)
 {
 	struct octep_hw *oct_hw = data;
 	int i, ring_start, ring_stride;
@@ -85,6 +113,18 @@ static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t (*octep_vdpa_get_irq_handler(u32 dev_id))(int, void *)
+{
+	switch (dev_id) {
+	case VIRTIO_ID_NET:
+		return octep_vdpa_net_irq_handler;
+	case VIRTIO_ID_CRYPTO:
+		return octep_vdpa_crypto_irq_handler;
+	default:
+		return NULL;
+	}
+}
+
 static void octep_free_irqs(struct octep_hw *oct_hw)
 {
 	struct pci_dev *pdev = oct_hw->pdev;
@@ -107,6 +147,7 @@ static void octep_free_irqs(struct octep_hw *oct_hw)
 
 static int octep_request_irqs(struct octep_hw *oct_hw)
 {
+	irqreturn_t (*irq_handler)(int irq, void *data);
 	struct pci_dev *pdev = oct_hw->pdev;
 	int ret, irq, idx;
 
@@ -120,9 +161,16 @@ static int octep_request_irqs(struct octep_hw *oct_hw)
 		return ret;
 	}
 
+	irq_handler = octep_vdpa_get_irq_handler(oct_hw->dev_id);
+	if (!irq_handler) {
+		dev_err(&pdev->dev, "Invalid device id %d\n", oct_hw->dev_id);
+		ret = -EINVAL;
+		goto free_irqs;
+	}
+
 	for (idx = 0; idx < oct_hw->nb_irqs; idx++) {
 		irq = pci_irq_vector(pdev, idx);
-		ret = devm_request_irq(&pdev->dev, irq, octep_vdpa_intr_handler, 0,
+		ret = devm_request_irq(&pdev->dev, irq, irq_handler, 0,
 				       dev_name(&pdev->dev), oct_hw);
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to register interrupt handler\n");
-- 
2.25.1


