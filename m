Return-Path: <linux-kernel+bounces-248028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAED92D783
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712911C215FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362CF197A98;
	Wed, 10 Jul 2024 17:32:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E08D197A88;
	Wed, 10 Jul 2024 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632757; cv=none; b=JaACVr8sQ+ScsWg2b71N5fh9hcF/jYdZUTeSu5W9O+NzZ5bQ5LZbB0xpOGJyF2HgUNrWxagCgFFt6iMrl100ChG6xLLUxoYG+RoAnz97lpi1I69y6wG8h2d+1Ajry3Gvci9QlssmZufhpLkn7peLkb6YisPH35TyiYSkIUEqAYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632757; c=relaxed/simple;
	bh=ADbJjwGVqh8W3TF+DnMKi1ZX/uyh/FN1sMMyszzEpsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWPxhetpUe/t+Q62ZHHKXpWewOWDVJyDVuWPNuQmPjBrpEUvbtl702Ixzs8TSeDnGuMqf0/EVSFZLTvbx4ih41svSnZ+37IY/iEzuF9MkTowvvaHE5DSRw9liDpp+4NiQnr27ZTJl5Z6BlzrPDtJrTLarWSF1TlAed2HHGwXl1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 306301042;
	Wed, 10 Jul 2024 10:33:00 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F9383F766;
	Wed, 10 Jul 2024 10:32:32 -0700 (PDT)
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
	Cristian Marussi <cristian.marussi@arm.com>,
	Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v2 6/8] firmware: arm_scmi: Make OPTEE transport a standalone driver
Date: Wed, 10 Jul 2024 18:31:51 +0100
Message-ID: <20240710173153.4060457-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710173153.4060457-1-cristian.marussi@arm.com>
References: <20240710173153.4060457-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make SCMI OPTEE transport a standalone driver that can be optionally
loaded as a module.

CC: Etienne Carriere <etienne.carriere@foss.st.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v1 --> v2
- handle platform_driver_register() failures
---
 drivers/firmware/arm_scmi/Kconfig             |  6 +-
 drivers/firmware/arm_scmi/Makefile            |  2 +-
 drivers/firmware/arm_scmi/common.h            |  3 -
 drivers/firmware/arm_scmi/driver.c            |  3 -
 .../{optee.c => scmi_transport_optee.c}       | 91 ++++++++++---------
 5 files changed, 52 insertions(+), 53 deletions(-)
 rename drivers/firmware/arm_scmi/{optee.c => scmi_transport_optee.c} (90%)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index a4d44ef8bf45..def7e3f09356 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -89,8 +89,8 @@ config ARM_SCMI_TRANSPORT_MAILBOX
 	  will be called scmi_transport_mailbox.
 
 config ARM_SCMI_TRANSPORT_OPTEE
-	bool "SCMI transport based on OP-TEE service"
-	depends on OPTEE=y || OPTEE=ARM_SCMI_PROTOCOL
+	tristate "SCMI transport based on OP-TEE service"
+	depends on OPTEE
 	select ARM_SCMI_HAVE_TRANSPORT
 	select ARM_SCMI_HAVE_SHMEM
 	select ARM_SCMI_HAVE_MSG
@@ -100,6 +100,8 @@ config ARM_SCMI_TRANSPORT_OPTEE
 
 	  If you want the ARM SCMI PROTOCOL stack to include support for a
 	  transport based on OP-TEE SCMI service, answer Y.
+	  This driver can also be built as a module.  If so, the module
+	  will be called scmi_transport_optee.
 
 config ARM_SCMI_TRANSPORT_SMC
 	tristate "SCMI transport based on SMC"
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 6868a47fa4ab..b04119ce972f 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -7,13 +7,13 @@ scmi-driver-$(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) += raw_mode.o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
-scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
 scmi-protocols-y := base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
 scmi-protocols-y += pinctrl.o
 scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
 
 obj-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += scmi_transport_smc.o
 obj-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += scmi_transport_mailbox.o
+obj-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += scmi_transport_optee.o
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index edb786cde25c..0ce1d804b3fc 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -289,9 +289,6 @@ int scmi_xfer_raw_wait_for_message_response(struct scmi_chan_info *cinfo,
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
 extern const struct scmi_desc scmi_virtio_desc;
 #endif
-#ifdef CONFIG_ARM_SCMI_TRANSPORT_OPTEE
-extern const struct scmi_desc scmi_optee_desc;
-#endif
 
 void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv);
 
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index b14c5326930a..67b416c7f2f5 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -3251,9 +3251,6 @@ ATTRIBUTE_GROUPS(versions);
 
 /* Each compatible listed below must have descriptor associated with it */
 static const struct of_device_id scmi_of_match[] = {
-#ifdef CONFIG_ARM_SCMI_TRANSPORT_OPTEE
-	{ .compatible = "linaro,scmi-optee", .data = &scmi_optee_desc },
-#endif
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
 	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
 #endif
diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/scmi_transport_optee.c
similarity index 90%
rename from drivers/firmware/arm_scmi/optee.c
rename to drivers/firmware/arm_scmi/scmi_transport_optee.c
index 99f3b0bfb956..7a16c8d3e213 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/scmi_transport_optee.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2019-2021 Linaro Ltd.
+ * Copyright (C) 2019-2024 Linaro Ltd.
  */
 
 #include <linux/io.h>
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
 #include <linux/uuid.h>
@@ -148,12 +149,11 @@ struct scmi_optee_agent {
 	struct list_head channel_list;
 };
 
+static struct scmi_transport_core_operations *core;
+
 /* There can be only 1 SCMI service in OP-TEE we connect to */
 static struct scmi_optee_agent *scmi_optee_private;
 
-/* Forward reference to scmi_optee transport initialization */
-static int scmi_optee_init(void);
-
 /* Open a session toward SCMI OP-TEE service with REE_KERNEL identity */
 static int open_session(struct scmi_optee_agent *agent, u32 *tee_session)
 {
@@ -312,24 +312,6 @@ static int invoke_process_msg_channel(struct scmi_optee_channel *channel, size_t
 	return 0;
 }
 
-static int scmi_optee_link_supplier(struct device *dev)
-{
-	if (!scmi_optee_private) {
-		if (scmi_optee_init())
-			dev_dbg(dev, "Optee bus not yet ready\n");
-
-		/* Wait for optee bus */
-		return -EPROBE_DEFER;
-	}
-
-	if (!device_link_add(dev, scmi_optee_private->dev, DL_FLAG_AUTOREMOVE_CONSUMER)) {
-		dev_err(dev, "Adding link to supplier optee device failed\n");
-		return -ECANCELED;
-	}
-
-	return 0;
-}
-
 static bool scmi_optee_chan_available(struct device_node *of_node, int idx)
 {
 	u32 channel_id;
@@ -343,7 +325,7 @@ static void scmi_optee_clear_channel(struct scmi_chan_info *cinfo)
 	struct scmi_optee_channel *channel = cinfo->transport_info;
 
 	if (!channel->tee_shm)
-		scmi_shmem_ops.clear_channel(channel->req.shmem);
+		core->shmem->clear_channel(channel->req.shmem);
 }
 
 static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *channel)
@@ -368,7 +350,7 @@ static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *ch
 static int setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
 			      struct scmi_optee_channel *channel)
 {
-	channel->req.shmem = scmi_shmem_ops.setup_iomap(cinfo, dev, true, NULL);
+	channel->req.shmem = core->shmem->setup_iomap(cinfo, dev, true, NULL);
 	if (IS_ERR(channel->req.shmem))
 		return PTR_ERR(channel->req.shmem);
 
@@ -472,10 +454,11 @@ static int scmi_optee_send_message(struct scmi_chan_info *cinfo,
 	mutex_lock(&channel->mu);
 
 	if (channel->tee_shm) {
-		scmi_msg_ops.tx_prepare(channel->req.msg, xfer);
-		ret = invoke_process_msg_channel(channel, scmi_msg_ops.command_size(xfer));
+		core->msg->tx_prepare(channel->req.msg, xfer);
+		ret = invoke_process_msg_channel(channel,
+						 core->msg->command_size(xfer));
 	} else {
-		scmi_shmem_ops.tx_prepare(channel->req.shmem, xfer, cinfo);
+		core->shmem->tx_prepare(channel->req.shmem, xfer, cinfo);
 		ret = invoke_process_smt_channel(channel);
 	}
 
@@ -491,9 +474,10 @@ static void scmi_optee_fetch_response(struct scmi_chan_info *cinfo,
 	struct scmi_optee_channel *channel = cinfo->transport_info;
 
 	if (channel->tee_shm)
-		scmi_msg_ops.fetch_response(channel->req.msg, channel->rx_len, xfer);
+		core->msg->fetch_response(channel->req.msg,
+					  channel->rx_len, xfer);
 	else
-		scmi_shmem_ops.fetch_response(channel->req.shmem, xfer);
+		core->shmem->fetch_response(channel->req.shmem, xfer);
 }
 
 static void scmi_optee_mark_txdone(struct scmi_chan_info *cinfo, int ret,
@@ -505,7 +489,6 @@ static void scmi_optee_mark_txdone(struct scmi_chan_info *cinfo, int ret,
 }
 
 static struct scmi_transport_ops scmi_optee_ops = {
-	.link_supplier = scmi_optee_link_supplier,
 	.chan_available = scmi_optee_chan_available,
 	.chan_setup = scmi_optee_chan_setup,
 	.chan_free = scmi_optee_chan_free,
@@ -520,6 +503,21 @@ static int scmi_optee_ctx_match(struct tee_ioctl_version_data *ver, const void *
 	return ver->impl_id == TEE_IMPL_ID_OPTEE;
 }
 
+static const struct scmi_desc scmi_optee_desc = {
+	.ops = &scmi_optee_ops,
+	.max_rx_timeout_ms = 30,
+	.max_msg = 20,
+	.max_msg_size = SCMI_OPTEE_MAX_MSG_SIZE,
+	.sync_cmds_completed_on_ret = true,
+};
+
+static const struct of_device_id scmi_of_match[] = {
+	{ .compatible = "linaro,scmi-optee" },
+	{ /* Sentinel */ },
+};
+
+DEFINE_SCMI_TRANSPORT_DRIVER(scmi_optee, scmi_of_match, &core);
+
 static int scmi_optee_service_probe(struct device *dev)
 {
 	struct scmi_optee_agent *agent;
@@ -555,6 +553,12 @@ static int scmi_optee_service_probe(struct device *dev)
 	smp_mb();
 	scmi_optee_private = agent;
 
+	ret = platform_driver_register(&scmi_optee_driver);
+	if (ret) {
+		scmi_optee_private = NULL;
+		goto err;
+	}
+
 	return 0;
 
 err:
@@ -573,6 +577,8 @@ static int scmi_optee_service_remove(struct device *dev)
 	if (!list_empty(&scmi_optee_private->channel_list))
 		return -EBUSY;
 
+	platform_driver_unregister(&scmi_optee_driver);
+
 	/* Ensure cleared reference is visible before resources are released */
 	smp_store_mb(scmi_optee_private, NULL);
 
@@ -591,7 +597,7 @@ static const struct tee_client_device_id scmi_optee_service_id[] = {
 
 MODULE_DEVICE_TABLE(tee, scmi_optee_service_id);
 
-static struct tee_client_driver scmi_optee_driver = {
+static struct tee_client_driver scmi_optee_service_driver = {
 	.id_table	= scmi_optee_service_id,
 	.driver		= {
 		.name = "scmi-optee",
@@ -601,22 +607,19 @@ static struct tee_client_driver scmi_optee_driver = {
 	},
 };
 
-static int scmi_optee_init(void)
+static int __init scmi_transport_optee_init(void)
 {
-	return driver_register(&scmi_optee_driver.driver);
+	return driver_register(&scmi_optee_service_driver.driver);
 }
+module_init(scmi_transport_optee_init);
 
-static void scmi_optee_exit(void)
+static void __exit scmi_transport_optee_exit(void)
 {
-	if (scmi_optee_private)
-		driver_unregister(&scmi_optee_driver.driver);
+	driver_unregister(&scmi_optee_service_driver.driver);
 }
+module_exit(scmi_transport_optee_exit);
 
-const struct scmi_desc scmi_optee_desc = {
-	.transport_exit = scmi_optee_exit,
-	.ops = &scmi_optee_ops,
-	.max_rx_timeout_ms = 30,
-	.max_msg = 20,
-	.max_msg_size = SCMI_OPTEE_MAX_MSG_SIZE,
-	.sync_cmds_completed_on_ret = true,
-};
+MODULE_ALIAS("scmi-transport-optee");
+MODULE_AUTHOR("Etienne Carriere <etienne.carriere@foss.st.com>");
+MODULE_DESCRIPTION("SCMI OPTEE Transport driver");
+MODULE_LICENSE("GPL");
-- 
2.45.2


