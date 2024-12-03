Return-Path: <linux-kernel+bounces-430066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E43D9E2C27
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655A11658F7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961992036E9;
	Tue,  3 Dec 2024 19:36:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0ED1FECC3;
	Tue,  3 Dec 2024 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733254569; cv=none; b=cxOWnqfM0BEpZA5/yBg4d/1EjzCfLFO2qTQEb9vLL50gv4ZwKoX8vE3hArW9VyhGnjtAInNrs6W07xSbEjlPDBfpajqpPxp3Rjw06oJvU8QtpuAmq8+Jf9NiZBlTbReDVPnPekDw7eN+lESgXlN+2jhqDd+kO0IzTIR0RV6iXQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733254569; c=relaxed/simple;
	bh=wFSaemFvuGcgSlHagL7sx6SZgmpqWoAgDeGFJAVoAuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G+Os9uUyfVPytQ2jHOvAmlhNZz+a7qzpwnHGGkaqA6b2GwzHRK4PX4hdDJ0F6cGb29Q//08t1Nrd6qQBj9sBgdvB+3OVsYmXgRjQYHVvxOLBMaBaNs+iAkqKCY48KwNlU5CFHvI4NKZs5bjydDjsDw272U64Pk0SURDuRq4Ema4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45573FEC;
	Tue,  3 Dec 2024 11:36:33 -0800 (PST)
Received: from pluto.guest.local (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CC2A3F58B;
	Tue,  3 Dec 2024 11:36:04 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scmi: Allow transport properties for multiple instances
Date: Tue,  3 Dec 2024 19:35:44 +0000
Message-ID: <20241203193544.3895173-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Default SCMI transport properties values can be overridden with devicetree
provided descriptors; in order to support multiple SCMI instances, make the
properties-update happen on a per-instance copy of the original transport
descriptor.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h |  4 ++--
 drivers/firmware/arm_scmi/driver.c | 18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 48b12f81141d..10ea7962323e 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -442,7 +442,7 @@ struct scmi_transport_core_operations {
  */
 struct scmi_transport {
 	struct device *supplier;
-	struct scmi_desc *desc;
+	struct scmi_desc desc;
 	struct scmi_transport_core_operations **core_ops;
 };
 
@@ -468,7 +468,7 @@ static int __tag##_probe(struct platform_device *pdev)			       \
 	device_set_of_node_from_dev(&spdev->dev, dev);			       \
 									       \
 	strans.supplier = dev;						       \
-	strans.desc = &(__desc);					       \
+	memcpy(&strans.desc, &(__desc), sizeof(strans.desc));		       \
 	strans.core_ops = &(__core_ops);				       \
 									       \
 	ret = platform_device_add_data(spdev, &strans, sizeof(strans));	       \
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 1b5fb2c4ce86..eeed1689b208 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -3028,7 +3028,7 @@ static const struct scmi_desc *scmi_transport_setup(struct device *dev)
 	int ret;
 
 	trans = dev_get_platdata(dev);
-	if (!trans || !trans->desc || !trans->supplier || !trans->core_ops)
+	if (!trans || !trans->supplier || !trans->core_ops)
 		return NULL;
 
 	if (!device_link_add(dev, trans->supplier, DL_FLAG_AUTOREMOVE_CONSUMER)) {
@@ -3043,33 +3043,33 @@ static const struct scmi_desc *scmi_transport_setup(struct device *dev)
 	dev_info(dev, "Using %s\n", dev_driver_string(trans->supplier));
 
 	ret = of_property_read_u32(dev->of_node, "arm,max-rx-timeout-ms",
-				   &trans->desc->max_rx_timeout_ms);
+				   &trans->desc.max_rx_timeout_ms);
 	if (ret && ret != -EINVAL)
 		dev_err(dev, "Malformed arm,max-rx-timeout-ms DT property.\n");
 
 	ret = of_property_read_u32(dev->of_node, "arm,max-msg-size",
-				   &trans->desc->max_msg_size);
+				   &trans->desc.max_msg_size);
 	if (ret && ret != -EINVAL)
 		dev_err(dev, "Malformed arm,max-msg-size DT property.\n");
 
 	ret = of_property_read_u32(dev->of_node, "arm,max-msg",
-				   &trans->desc->max_msg);
+				   &trans->desc.max_msg);
 	if (ret && ret != -EINVAL)
 		dev_err(dev, "Malformed arm,max-msg DT property.\n");
 
 	dev_info(dev,
 		 "SCMI max-rx-timeout: %dms / max-msg-size: %dbytes / max-msg: %d\n",
-		 trans->desc->max_rx_timeout_ms, trans->desc->max_msg_size,
-		 trans->desc->max_msg);
+		 trans->desc.max_rx_timeout_ms, trans->desc.max_msg_size,
+		 trans->desc.max_msg);
 
 	/* System wide atomic threshold for atomic ops .. if any */
 	if (!of_property_read_u32(dev->of_node, "atomic-threshold-us",
-				  &trans->desc->atomic_threshold))
+				  &trans->desc.atomic_threshold))
 		dev_info(dev,
 			 "SCMI System wide atomic threshold set to %u us\n",
-			 trans->desc->atomic_threshold);
+			 trans->desc.atomic_threshold);
 
-	return trans->desc;
+	return &trans->desc;
 }
 
 static int scmi_probe(struct platform_device *pdev)
-- 
2.47.0


