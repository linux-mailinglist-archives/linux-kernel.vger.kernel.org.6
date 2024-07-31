Return-Path: <linux-kernel+bounces-269792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647AC9436ED
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF6E4B213BC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2412E16C437;
	Wed, 31 Jul 2024 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWWXQTvV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A9116A39E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456878; cv=none; b=Fz8Nui365ELasDUs11Uf3eG0L754nIGXrUjopf0nqXzIZJSKnNOHxTE8Wn4N044HGGKWWvNax09kbDuUp4UHoTaK45LMC8TJpeTc2QzkZZIDr/6ln3FvFsep+6iCuEWgsKhNskwG1UDzHp9/lRJehz5wf/XQYmp5s2c3Lx02kss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456878; c=relaxed/simple;
	bh=rs9OKvs3MRnvwNaZmqBZdZEDA/cG0O5dn7GKWEKIHpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hJ7yY9b8mHleeliCOCdBL64paXN+YyPczooXxsIK18FhZE8Z2IsEny2AT4HCkwiN55qQ/XMa+ohA4nTgYIxQjV5D4IDxlUpafHdm0Cq6rwGEFl5UQfkQHiloZrNiro4M5p1CIDhm+zGnbE8+/teR89jXyMPUj5WqnCKBnWVpgkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWWXQTvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBABC4AF0C;
	Wed, 31 Jul 2024 20:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722456878;
	bh=rs9OKvs3MRnvwNaZmqBZdZEDA/cG0O5dn7GKWEKIHpk=;
	h=From:To:Cc:Subject:Date:From;
	b=VWWXQTvVkuh0fARMRE9rCRbAybQnMtOqEsT5g5U2N5tIKHLlJgmsDV3sxFO7ZydRT
	 w/bgoWOU51yXntaFiVjSJD0blXEgOEC1Us9eY3gAuzbwy9ujFME1wA9vf8NyF3aVfA
	 VXuZyjpMs69KgZxIJeW6tV81RybpPKfNvaP/GU8TTx3T+lSV+voXdwQcD7rYeKPT6C
	 AO9lg5zwbvnL4UQki1upXsya1H4m3Qc1sq9aKW4xnWCqwU8mJObEHqNXH+OUcIXY+s
	 P5wPP1Zdlk7hr7U/WXqE/f9x+UJeV+8jfIH6UmFhJP+sn8zctTBy95F3f3MFvC66ke
	 /zFWbndvLuHEQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: ti: knav: Use of_property_read_variable_u32_array()
Date: Wed, 31 Jul 2024 14:13:58 -0600
Message-ID: <20240731201407.1838385-3-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need to get the length of an DT array property before
parsing the array. of_property_read_variable_u32_array() takes a minimum
and maximum length and returns the actual length (or error code).

This is part of a larger effort to remove callers of of_find_property()
and similar functions. of_find_property() leaks the DT struct property
and data pointers which is a problem for dynamically allocated nodes
which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/soc/ti/knav_dma.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 6023006685fc..fb0746d8caad 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -602,7 +602,7 @@ static int dma_init(struct device_node *cloud, struct device_node *dma_node)
 	unsigned max_tx_chan, max_rx_chan, max_rx_flow, max_tx_sched;
 	struct device_node *node = dma_node;
 	struct knav_dma_device *dma;
-	int ret, len, num_chan = 0;
+	int ret, num_chan = 0;
 	resource_size_t size;
 	u32 timeout;
 	u32 i;
@@ -615,25 +615,13 @@ static int dma_init(struct device_node *cloud, struct device_node *dma_node)
 	INIT_LIST_HEAD(&dma->list);
 	INIT_LIST_HEAD(&dma->chan_list);
 
-	if (!of_find_property(cloud, "ti,navigator-cloud-address", &len)) {
-		dev_err(kdev->dev, "unspecified navigator cloud addresses\n");
-		return -ENODEV;
-	}
-
-	dma->logical_queue_managers = len / sizeof(u32);
-	if (dma->logical_queue_managers > DMA_MAX_QMS) {
-		dev_warn(kdev->dev, "too many queue mgrs(>%d) rest ignored\n",
-			 dma->logical_queue_managers);
-		dma->logical_queue_managers = DMA_MAX_QMS;
-	}
-
-	ret = of_property_read_u32_array(cloud, "ti,navigator-cloud-address",
-					dma->qm_base_address,
-					dma->logical_queue_managers);
-	if (ret) {
+	ret = of_property_read_variable_u32_array(cloud, "ti,navigator-cloud-address",
+						  dma->qm_base_address, 1, DMA_MAX_QMS);
+	if (ret < 0) {
 		dev_err(kdev->dev, "invalid navigator cloud addresses\n");
 		return -ENODEV;
 	}
+	dma->logical_queue_managers = ret;
 
 	dma->reg_global	 = pktdma_get_regs(dma, node, 0, &size);
 	if (IS_ERR(dma->reg_global))
-- 
2.43.0


