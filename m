Return-Path: <linux-kernel+bounces-415296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D384C9D3404
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AACFB22C9E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA19161321;
	Wed, 20 Nov 2024 07:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IdWXlVOY"
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3753E160783
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 07:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732086446; cv=none; b=LTFUBMY3LE76b1Z2SkKihgpV5epsZowdAiDVmvqB4aGnUaJBEgVFdjUwU9UcH7ALJ7KmfEUnPemwJyRmoMHrWLtt73f+0/0DtPZVJBhQ+0vI8IadHXUUosh85IZbd7AcQV6Fi9GKKOVpGjGKCz4eNO4EvmC0cz5g/ssG1Z2F+Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732086446; c=relaxed/simple;
	bh=QjpJbq013nostxLse9Lh8wIY37svrRC5Caf3PObOb+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgt6zXNb50vTSuC8f306ANpzpZLuhexzBa0jt0tI590mAwnLvEtkndkd4urlX+Pg+SpMm3odIMAxN+C/z8dZcqmHLmpW/1vKcKiW4/NXmFNQmx5FbAjnFX0iMEQk+PUaoS3EJM/21KG+OQorov7zMPHZZyNqv2DgL1slJN4Oi7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IdWXlVOY; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJMmeed003104;
	Tue, 19 Nov 2024 23:07:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
	FXD3AS2KBH6vnHmuro+c0L6OCeD3n8FHywMgLoBwR8=; b=IdWXlVOYey5bn1KE1
	yWeIfgPITuxJLrEDdunNJzfSTCP5F3jNHsU6VH9WxE4JG5hmk2U8I1hAYdF7rmpJ
	ZkphJI7bn3xhFtsvUMiQGfka/ql0u1kUZadM77jR1yibyna66AzN/pYmENX6JeME
	sE002vMxxpN/3NJJvTaDWIjx/zdP1OlnY9T+3Sid/Yh7J5UBwX+HAo7BIPnKjqtE
	AXkIBM+rnGMrGKFaHdtc41LLKWM4WaocpsnPA6W4c/QsrFsWcXfAxJJoia0JG3TJ
	KO3ZjZd7z1MSxqoX/X5p3+SdmAdkyiaHAU4Pjvam8rWDjsN0IOMjiFEwckzaQnEh
	O8TgQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4313t10xjr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 23:07:16 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 19 Nov 2024 23:07:07 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 19 Nov 2024 23:07:07 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
	by maili.marvell.com (Postfix) with ESMTP id 76AC13F7062;
	Tue, 19 Nov 2024 23:07:03 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <virtualization@lists.linux.dev>, <mst@redhat.com>, <jasowang@redhat.com>
CC: Shijith Thotton <sthotton@marvell.com>, <schalla@marvell.com>,
        <vattunuru@marvell.com>, <ndabilpuram@marvell.com>,
        <jerinj@marvell.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        Satha Rao <skoteshwar@marvell.com>,
        open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] vdpa/octeon_ep: add interrupt handler for virtio crypto device
Date: Wed, 20 Nov 2024 12:34:53 +0530
Message-ID: <20241120070508.789508-4-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241120070508.789508-1-sthotton@marvell.com>
References: <20241120070508.789508-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: m3W3Ereg19Xt5hLzETEOPamsCbsT3a_k
X-Proofpoint-GUID: m3W3Ereg19Xt5hLzETEOPamsCbsT3a_k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Introduced an interrupt handler for the virtio crypto device, as its
queue usage differs from that of network devices. While virtio network
device receives packets only on even-indexed queues, virtio crypto
device utilize all available queues for processing data.

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 drivers/vdpa/octeon_ep/octep_vdpa_main.c | 51 +++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index 6ead42d76415..1b65cb697fa5 100644
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
@@ -103,6 +143,7 @@ static void octep_free_irqs(struct octep_hw *oct_hw)
 
 static int octep_request_irqs(struct octep_hw *oct_hw)
 {
+	irqreturn_t (*irq_handler)(int irq, void *data);
 	struct pci_dev *pdev = oct_hw->pdev;
 	int ret, irq, idx;
 
@@ -119,10 +160,16 @@ static int octep_request_irqs(struct octep_hw *oct_hw)
 	}
 
 	memset(oct_hw->irqs, -1, sizeof(oct_hw->irqs));
+	irq_handler = octep_vdpa_get_irq_handler(oct_hw->dev_id);
+	if (!irq_handler) {
+		dev_err(&pdev->dev, "Invalid device id %d\n", oct_hw->dev_id);
+		ret = -EINVAL;
+		goto free_irqs;
+	}
 
 	for (idx = 0; idx < oct_hw->nb_irqs; idx++) {
 		irq = pci_irq_vector(pdev, idx);
-		ret = devm_request_irq(&pdev->dev, irq, octep_vdpa_intr_handler, 0,
+		ret = devm_request_irq(&pdev->dev, irq, irq_handler, 0,
 				       dev_name(&pdev->dev), oct_hw);
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to register interrupt handler\n");
-- 
2.25.1


