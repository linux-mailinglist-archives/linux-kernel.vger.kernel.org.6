Return-Path: <linux-kernel+bounces-243429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1135929612
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 02:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106DB1C20AAC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 00:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D355227;
	Sun,  7 Jul 2024 00:21:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76663193;
	Sun,  7 Jul 2024 00:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720311699; cv=none; b=VdVLE8ZnD7IGtoU9JGo2dUHaAY3p3aucm8pzEgBjR8/j7IMtdwD7X+YIYkuPe+ULBNc4wmH/vo4BnKs4bCsthkS1z7BoBpYkTK/fatI/CwASuwogwa697X46e5n1qBzzgmV2GtB/9TrTonuiVCq6nPMLsZNDEPQ3dTc0n+867nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720311699; c=relaxed/simple;
	bh=fvYVkid4xNQYOkrpLZpVtAO6NQzzzIVgPpuSdSeBdtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nv/kgtPDFfJMuJUS4JGS93HkPYc2ItTWE5+HiIdYkWWXUHKFR3jjHRezjmkhxIMPs/1TmK2wQweG4Lp/j6zU2ttQMP5Wv0Mx7AxcdlwPUBJMYiFzmsab5awTK1ffdzgeR1WfIH35F3uPLwItJyu+0z9tcpLBTLU9AC1NAIoNecw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A763612FC;
	Sat,  6 Jul 2024 17:22:00 -0700 (PDT)
Received: from pluto.. (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43C3C3F73B;
	Sat,  6 Jul 2024 17:21:33 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@foss.st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	ptosi@google.com,
	dan.carpenter@linaro.org,
	souvik.chakravarty@arm.com,
	Peng Fan <peng.fan@nxp.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 1/8] firmware: arm_scmi: Introduce setup_shmem_iomap
Date: Sun,  7 Jul 2024 01:20:48 +0100
Message-ID: <20240707002055.1835121-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240707002055.1835121-1-cristian.marussi@arm.com>
References: <20240707002055.1835121-1-cristian.marussi@arm.com>
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
[ Cristian: make use of the new helper also in smc.c ]
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h  |  2 ++
 drivers/firmware/arm_scmi/mailbox.c | 27 ++++------------------
 drivers/firmware/arm_scmi/optee.c   | 35 ++++------------------------
 drivers/firmware/arm_scmi/shmem.c   | 36 +++++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/smc.c     | 23 +++---------------
 5 files changed, 49 insertions(+), 74 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 4b8c5250cdb5..b4c217641e3a 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -327,6 +327,8 @@ bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
 		     struct scmi_xfer *xfer);
 bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem);
 bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem *shmem);
+void __iomem *setup_shmem_iomap(struct scmi_chan_info *cinfo, struct device *dev,
+				bool tx);
 
 /* declarations for message passing transports */
 struct scmi_msg_payld;
diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index 0219a12e3209..b0a579f31905 100644
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
+	smbox->shmem = setup_shmem_iomap(cinfo, dev, tx);
+	if (IS_ERR(smbox->shmem))
+		return PTR_ERR(smbox->shmem);
 
 	cl = &smbox->cl;
 	cl->dev = cdev;
diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index 4e7944b91e38..8abcd668108c 100644
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
+	channel->req.shmem = setup_shmem_iomap(cinfo, dev, true);
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
index b74e5a740f2c..c31f188d74ef 100644
--- a/drivers/firmware/arm_scmi/shmem.c
+++ b/drivers/firmware/arm_scmi/shmem.c
@@ -7,6 +7,8 @@
 
 #include <linux/ktime.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/processor.h>
 #include <linux/types.h>
 
@@ -133,3 +135,37 @@ bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem *shmem)
 {
 	return ioread32(&shmem->flags) & SCMI_SHMEM_FLAG_INTR_ENABLED;
 }
+
+void *__iomem
+setup_shmem_iomap(struct scmi_chan_info *cinfo, struct device *dev, bool tx)
+{
+	const char *desc = tx ? "Tx" : "Rx";
+	int ret, idx = tx ? 0 : 1;
+	struct device *cdev = cinfo->dev;
+	struct device_node *shmem;
+	resource_size_t size;
+	struct resource res;
+	void __iomem *addr;
+
+	shmem = of_parse_phandle(cdev->of_node, "shmem", idx);
+	if (!of_device_is_compatible(shmem, "arm,scmi-shmem")) {
+		of_node_put(shmem);
+		return ERR_PTR(-ENXIO);
+	}
+
+	ret = of_address_to_resource(shmem, 0, &res);
+	of_node_put(shmem);
+	if (ret) {
+		dev_err(cdev, "failed to get SCMI %s shared memory\n", desc);
+		return ERR_PTR(ret);
+	}
+
+	size = resource_size(&res);
+	addr = devm_ioremap(dev, res.start, size);
+	if (!addr) {
+		dev_err(dev, "failed to ioremap SCMI %s shared memory\n", desc);
+		return ERR_PTR(-EADDRNOTAVAIL);
+	}
+
+	return addr;
+}
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 39936e1dd30e..a640a4312472 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -132,7 +132,6 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	struct scmi_smc *scmi_info;
 	resource_size_t size;
 	struct resource res;
-	struct device_node *np;
 	u32 func_id;
 	int ret;
 
@@ -143,25 +142,9 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
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
+	scmi_info->shmem = setup_shmem_iomap(cinfo, dev, tx);
+	if (IS_ERR(scmi_info->shmem))
+		return PTR_ERR(scmi_info->shmem);
 
 	ret = of_property_read_u32(dev->of_node, "arm,smc-id", &func_id);
 	if (ret < 0)
-- 
2.45.2


