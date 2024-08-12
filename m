Return-Path: <linux-kernel+bounces-283516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0161394F5DB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2BC28305C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E63B189901;
	Mon, 12 Aug 2024 17:34:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CD41898E6;
	Mon, 12 Aug 2024 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484059; cv=none; b=Ucb8uiv3sslc2VcRdABvFsPTaoHr2C1z3XGegmhYafYRviUN2d5uiJ2yDSyOaWtuQTpe+OpwFQPnJuxwcZY65ykLSQtutLywXkXg6DSOHJ7d/WVwdLerME2VwZ1sFQ8D/2M6T0gRxx7P1iXqFLFmzDp+up0sFsHlpyYF4VFR7bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484059; c=relaxed/simple;
	bh=aIlg2n3MSI9VaeKTKipJH66f5p0gDcyyY0Q1l59XYS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaOy1qJarZ7Z0a1pbVxy9O7B1daCtiv9hnq8rKBGT0man6IiltUUERSVBswmy/ZOosLiRRIfdp6rRABOmRVuq2PNoHKRVONM5J/MX4VJwakLFANtrhnzNSQo1fuV8jwD1G+5XR8mxlxLR0NBEc+Vmzk+TeUZpV3wZEBB2LdfY5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C743BFEC;
	Mon, 12 Aug 2024 10:34:42 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A6673F40C;
	Mon, 12 Aug 2024 10:34:14 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	ptosi@google.com,
	dan.carpenter@linaro.org,
	souvik.chakravarty@arm.com,
	Peng Fan <peng.fan@nxp.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v4 2/9] firmware: arm_scmi: Introduce setup_shmem_iomap
Date: Mon, 12 Aug 2024 18:33:33 +0100
Message-ID: <20240812173340.3912830-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812173340.3912830-1-cristian.marussi@arm.com>
References: <20240812173340.3912830-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Fan <peng.fan@nxp.com>

To get the address of shmem could be generalized by introducing
setup_shmem_iomap. Then the duplicated code in mailbox.c, optee.c
and smc.c could be dropped.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
[ Cristian: use OF __free and make use of the new helper also in smc.c ]
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v2 --> v3
- use IOMEM_ERR_PTR to avoid sparse errors
v1 --> v2
- add optional *res param to setup_shmem_iomap
- fixed __iomem tagging
- use OF __free cleanup.h magic to of_put()
---
 drivers/firmware/arm_scmi/common.h  |  2 ++
 drivers/firmware/arm_scmi/mailbox.c | 27 +++----------------
 drivers/firmware/arm_scmi/optee.c   | 35 +++---------------------
 drivers/firmware/arm_scmi/shmem.c   | 41 +++++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/smc.c     | 27 ++++---------------
 5 files changed, 56 insertions(+), 76 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 21c94deaf614..28c963358e01 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -351,6 +351,8 @@ bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
 		     struct scmi_xfer *xfer);
 bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem);
 bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem *shmem);
+void __iomem *setup_shmem_iomap(struct scmi_chan_info *cinfo, struct device *dev,
+				bool tx, struct resource *res);
 
 /* declarations for message passing transports */
 struct scmi_msg_payld;
diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index 0219a12e3209..886fc4eedb4a 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -178,11 +178,8 @@ static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	const char *desc = tx ? "Tx" : "Rx";
 	struct device *cdev = cinfo->dev;
 	struct scmi_mailbox *smbox;
-	struct device_node *shmem;
-	int ret, a2p_rx_chan, p2a_chan, p2a_rx_chan, idx = tx ? 0 : 1;
+	int ret, a2p_rx_chan, p2a_chan, p2a_rx_chan;
 	struct mbox_client *cl;
-	resource_size_t size;
-	struct resource res;
 
 	ret = mailbox_chan_validate(cdev, &a2p_rx_chan, &p2a_chan, &p2a_rx_chan);
 	if (ret)
@@ -195,25 +192,9 @@ static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	if (!smbox)
 		return -ENOMEM;
 
-	shmem = of_parse_phandle(cdev->of_node, "shmem", idx);
-	if (!of_device_is_compatible(shmem, "arm,scmi-shmem")) {
-		of_node_put(shmem);
-		return -ENXIO;
-	}
-
-	ret = of_address_to_resource(shmem, 0, &res);
-	of_node_put(shmem);
-	if (ret) {
-		dev_err(cdev, "failed to get SCMI %s shared memory\n", desc);
-		return ret;
-	}
-
-	size = resource_size(&res);
-	smbox->shmem = devm_ioremap(dev, res.start, size);
-	if (!smbox->shmem) {
-		dev_err(dev, "failed to ioremap SCMI %s shared memory\n", desc);
-		return -EADDRNOTAVAIL;
-	}
+	smbox->shmem = setup_shmem_iomap(cinfo, dev, tx, NULL);
+	if (IS_ERR(smbox->shmem))
+		return PTR_ERR(smbox->shmem);
 
 	cl = &smbox->cl;
 	cl->dev = cdev;
diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index 0c8908d3b1d6..ee9cda1a8211 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -368,38 +368,11 @@ static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *ch
 static int setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
 			      struct scmi_optee_channel *channel)
 {
-	struct device_node *np;
-	resource_size_t size;
-	struct resource res;
-	int ret;
-
-	np = of_parse_phandle(cinfo->dev->of_node, "shmem", 0);
-	if (!of_device_is_compatible(np, "arm,scmi-shmem")) {
-		ret = -ENXIO;
-		goto out;
-	}
-
-	ret = of_address_to_resource(np, 0, &res);
-	if (ret) {
-		dev_err(dev, "Failed to get SCMI Tx shared memory\n");
-		goto out;
-	}
-
-	size = resource_size(&res);
+	channel->req.shmem = setup_shmem_iomap(cinfo, dev, true, NULL);
+	if (IS_ERR(channel->req.shmem))
+		return PTR_ERR(channel->req.shmem);
 
-	channel->req.shmem = devm_ioremap(dev, res.start, size);
-	if (!channel->req.shmem) {
-		dev_err(dev, "Failed to ioremap SCMI Tx shared memory\n");
-		ret = -EADDRNOTAVAIL;
-		goto out;
-	}
-
-	ret = 0;
-
-out:
-	of_node_put(np);
-
-	return ret;
+	return 0;
 }
 
 static int setup_shmem(struct device *dev, struct scmi_chan_info *cinfo,
diff --git a/drivers/firmware/arm_scmi/shmem.c b/drivers/firmware/arm_scmi/shmem.c
index b74e5a740f2c..a0d6f68172fc 100644
--- a/drivers/firmware/arm_scmi/shmem.c
+++ b/drivers/firmware/arm_scmi/shmem.c
@@ -7,6 +7,8 @@
 
 #include <linux/ktime.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/processor.h>
 #include <linux/types.h>
 
@@ -133,3 +135,42 @@ bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem *shmem)
 {
 	return ioread32(&shmem->flags) & SCMI_SHMEM_FLAG_INTR_ENABLED;
 }
+
+void __iomem *setup_shmem_iomap(struct scmi_chan_info *cinfo,
+				struct device *dev, bool tx,
+				struct resource *res)
+{
+	struct device_node *shmem __free(device_node);
+	const char *desc = tx ? "Tx" : "Rx";
+	int ret, idx = tx ? 0 : 1;
+	struct device *cdev = cinfo->dev;
+	struct resource lres = {};
+	resource_size_t size;
+	void __iomem *addr;
+
+	shmem = of_parse_phandle(cdev->of_node, "shmem", idx);
+	if (!shmem)
+		return IOMEM_ERR_PTR(-ENODEV);
+
+	if (!of_device_is_compatible(shmem, "arm,scmi-shmem"))
+		return IOMEM_ERR_PTR(-ENXIO);
+
+	/* Use a local on-stack as a working area when not provided */
+	if (!res)
+		res = &lres;
+
+	ret = of_address_to_resource(shmem, 0, res);
+	if (ret) {
+		dev_err(cdev, "failed to get SCMI %s shared memory\n", desc);
+		return IOMEM_ERR_PTR(ret);
+	}
+
+	size = resource_size(res);
+	addr = devm_ioremap(dev, res->start, size);
+	if (!addr) {
+		dev_err(dev, "failed to ioremap SCMI %s shared memory\n", desc);
+		return IOMEM_ERR_PTR(-EADDRNOTAVAIL);
+	}
+
+	return addr;
+}
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 39936e1dd30e..59b6c04b52bc 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -130,9 +130,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	struct device *cdev = cinfo->dev;
 	unsigned long cap_id = ULONG_MAX;
 	struct scmi_smc *scmi_info;
-	resource_size_t size;
-	struct resource res;
-	struct device_node *np;
+	struct resource res = {};
 	u32 func_id;
 	int ret;
 
@@ -143,31 +141,16 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	if (!scmi_info)
 		return -ENOMEM;
 
-	np = of_parse_phandle(cdev->of_node, "shmem", 0);
-	if (!of_device_is_compatible(np, "arm,scmi-shmem")) {
-		of_node_put(np);
-		return -ENXIO;
-	}
-
-	ret = of_address_to_resource(np, 0, &res);
-	of_node_put(np);
-	if (ret) {
-		dev_err(cdev, "failed to get SCMI Tx shared memory\n");
-		return ret;
-	}
-
-	size = resource_size(&res);
-	scmi_info->shmem = devm_ioremap(dev, res.start, size);
-	if (!scmi_info->shmem) {
-		dev_err(dev, "failed to ioremap SCMI Tx shared memory\n");
-		return -EADDRNOTAVAIL;
-	}
+	scmi_info->shmem = setup_shmem_iomap(cinfo, dev, tx, &res);
+	if (IS_ERR(scmi_info->shmem))
+		return PTR_ERR(scmi_info->shmem);
 
 	ret = of_property_read_u32(dev->of_node, "arm,smc-id", &func_id);
 	if (ret < 0)
 		return ret;
 
 	if (of_device_is_compatible(dev->of_node, "qcom,scmi-smc")) {
+		resource_size_t size = resource_size(&res);
 		void __iomem *ptr = (void __iomem *)scmi_info->shmem + size - 8;
 		/* The capability-id is kept in last 8 bytes of shmem.
 		 *     +-------+ <-- 0
-- 
2.45.2


