Return-Path: <linux-kernel+bounces-283521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E3C94F5E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA7E1C21900
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7166018E030;
	Mon, 12 Aug 2024 17:34:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D056818CC0B;
	Mon, 12 Aug 2024 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484074; cv=none; b=Fjx92MdOVJpMApNeB2YjyYtKeUhihfECScB7554a6AbNTQS7oaj08ziVC44fIdktnTom/CLEQX+05r0kEhsVyU4WvVl8fBiLN5KpYP9heoa38Id6vdZtGUoODcOGYnFunWMsNDsK7RTtYgAKZ23e2MiBOEFNE0OAiP0vBf/9BG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484074; c=relaxed/simple;
	bh=KBnqUhVGfNF92Ak0STXPU7yuna/C3R/Sg5GxXF3kUV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTohMqnR4zWnJ03iOzHT8/fEnLYcsolZmauvt40NcEUrXWJ5DQdPJJsZUtaXKIjJutxVXXbJ3VQ9fJqO+L3d0uXzSxZnzhrGplb6Hhg+2cjTd+ukWlJPZvFPt9A/x0d+8jQWuL4a7QxxvWn8SB6BV1NCbia4rsKB38PDbQ6HFs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD544FEC;
	Mon, 12 Aug 2024 10:34:57 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AE6D3F40C;
	Mon, 12 Aug 2024 10:34:29 -0700 (PDT)
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
Subject: [PATCH v4 7/9] firmware: arm_scmi: Make OPTEE transport a standalone driver
Date: Mon, 12 Aug 2024 18:33:38 +0100
Message-ID: <20240812173340.3912830-8-cristian.marussi@arm.com>
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

Make SCMI OPTEE transport a standalone driver that can be optionally
loaded as a module.

CC: Etienne Carriere <etienne.carriere@foss.st.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> v4
- dropped MODULE_ALIAS
- moved OPTEE driver to dedicated transports subdir and submenu
v2 --> v3
- fixed spacing in Kconfig and Copyright
- fixed platform_driver_unregister call in .remove
  (was called to late to work...)
- use new params in DEFINE_SCMI_TRANSPORT_DRIVER
v1 --> v2
- handle platform_driver_register() failures
---
 drivers/firmware/arm_scmi/Kconfig             | 13 ---
 drivers/firmware/arm_scmi/Makefile            |  1 -
 drivers/firmware/arm_scmi/common.h            |  3 -
 drivers/firmware/arm_scmi/driver.c            |  3 -
 drivers/firmware/arm_scmi/transports/Kconfig  | 15 +++
 drivers/firmware/arm_scmi/transports/Makefile |  3 +-
 .../arm_scmi/{ => transports}/optee.c         | 91 ++++++++++---------
 7 files changed, 64 insertions(+), 65 deletions(-)
 rename drivers/firmware/arm_scmi/{ => transports}/optee.c (91%)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 27de15ad6444..b5e3634a8399 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -71,19 +71,6 @@ config ARM_SCMI_DEBUG_COUNTERS
 
 source "drivers/firmware/arm_scmi/transports/Kconfig"
 
-config ARM_SCMI_TRANSPORT_OPTEE
-	bool "SCMI transport based on OP-TEE service"
-	depends on OPTEE=y || OPTEE=ARM_SCMI_PROTOCOL
-	select ARM_SCMI_HAVE_TRANSPORT
-	select ARM_SCMI_HAVE_SHMEM
-	select ARM_SCMI_HAVE_MSG
-	default y
-	help
-	  This enables the OP-TEE service based transport for SCMI.
-
-	  If you want the ARM SCMI PROTOCOL stack to include support for a
-	  transport based on OP-TEE SCMI service, answer Y.
-
 config ARM_SCMI_TRANSPORT_VIRTIO
 	bool "SCMI transport based on VirtIO"
 	depends on VIRTIO=y || VIRTIO=ARM_SCMI_PROTOCOL
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 524a8ff381db..b80b302186da 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -7,7 +7,6 @@ scmi-driver-$(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) += raw_mode.o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
-scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
 scmi-protocols-y := base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
 scmi-protocols-y += pinctrl.o
 scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 231b061dadb9..18026d446b59 100644
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
index bdb952c385d2..084936e9575d 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -3318,9 +3318,6 @@ ATTRIBUTE_GROUPS(versions);
 
 /* Each compatible listed below must have descriptor associated with it */
 static const struct of_device_id scmi_of_match[] = {
-#ifdef CONFIG_ARM_SCMI_TRANSPORT_OPTEE
-	{ .compatible = "linaro,scmi-optee", .data = &scmi_optee_desc },
-#endif
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_VIRTIO
 	{ .compatible = "arm,scmi-virtio", .data = &scmi_virtio_desc},
 #endif
diff --git a/drivers/firmware/arm_scmi/transports/Kconfig b/drivers/firmware/arm_scmi/transports/Kconfig
index 85d693811a1c..7d478a4f69df 100644
--- a/drivers/firmware/arm_scmi/transports/Kconfig
+++ b/drivers/firmware/arm_scmi/transports/Kconfig
@@ -62,4 +62,19 @@ config ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE
 	  in atomic context too, at the price of using a number of busy-waiting
 	  primitives all over instead. If unsure say N.
 
+config ARM_SCMI_TRANSPORT_OPTEE
+	tristate "SCMI transport based on OP-TEE service"
+	depends on OPTEE
+	select ARM_SCMI_HAVE_TRANSPORT
+	select ARM_SCMI_HAVE_SHMEM
+	select ARM_SCMI_HAVE_MSG
+	default y
+	help
+	  This enables the OP-TEE service based transport for SCMI.
+
+	  If you want the ARM SCMI PROTOCOL stack to include support for a
+	  transport based on OP-TEE SCMI service, answer Y.
+	  This driver can also be built as a module. If so, the module
+	  will be called scmi_transport_optee.
+
 endmenu
diff --git a/drivers/firmware/arm_scmi/transports/Makefile b/drivers/firmware/arm_scmi/transports/Makefile
index 2c8b38a2d598..7c06d36a38fb 100644
--- a/drivers/firmware/arm_scmi/transports/Makefile
+++ b/drivers/firmware/arm_scmi/transports/Makefile
@@ -3,4 +3,5 @@ scmi_transport_mailbox-objs := mailbox.o
 obj-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += scmi_transport_mailbox.o
 scmi_transport_smc-objs := smc.o
 obj-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += scmi_transport_smc.o
-
+scmi_transport_optee-objs := optee.o
+obj-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += scmi_transport_optee.o
diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/transports/optee.c
similarity index 91%
rename from drivers/firmware/arm_scmi/optee.c
rename to drivers/firmware/arm_scmi/transports/optee.c
index dae68adf6f9e..978750aaf6b7 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/transports/optee.c
@@ -9,12 +9,13 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
 #include <linux/uuid.h>
 #include <uapi/linux/tee.h>
 
-#include "common.h"
+#include "../common.h"
 
 #define SCMI_OPTEE_MAX_MSG_SIZE		128
 
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
 
@@ -479,10 +461,11 @@ static int scmi_optee_send_message(struct scmi_chan_info *cinfo,
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
 
@@ -498,9 +481,10 @@ static void scmi_optee_fetch_response(struct scmi_chan_info *cinfo,
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
@@ -512,7 +496,6 @@ static void scmi_optee_mark_txdone(struct scmi_chan_info *cinfo, int ret,
 }
 
 static struct scmi_transport_ops scmi_optee_ops = {
-	.link_supplier = scmi_optee_link_supplier,
 	.chan_available = scmi_optee_chan_available,
 	.chan_setup = scmi_optee_chan_setup,
 	.chan_free = scmi_optee_chan_free,
@@ -527,6 +510,22 @@ static int scmi_optee_ctx_match(struct tee_ioctl_version_data *ver, const void *
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
+DEFINE_SCMI_TRANSPORT_DRIVER(scmi_optee, scmi_optee_driver, scmi_optee_desc,
+			     scmi_of_match, core);
+
 static int scmi_optee_service_probe(struct device *dev)
 {
 	struct scmi_optee_agent *agent;
@@ -562,6 +561,12 @@ static int scmi_optee_service_probe(struct device *dev)
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
@@ -577,6 +582,8 @@ static int scmi_optee_service_remove(struct device *dev)
 	if (!scmi_optee_private)
 		return -EINVAL;
 
+	platform_driver_unregister(&scmi_optee_driver);
+
 	if (!list_empty(&scmi_optee_private->channel_list))
 		return -EBUSY;
 
@@ -598,7 +605,7 @@ static const struct tee_client_device_id scmi_optee_service_id[] = {
 
 MODULE_DEVICE_TABLE(tee, scmi_optee_service_id);
 
-static struct tee_client_driver scmi_optee_driver = {
+static struct tee_client_driver scmi_optee_service_driver = {
 	.id_table	= scmi_optee_service_id,
 	.driver		= {
 		.name = "scmi-optee",
@@ -608,22 +615,18 @@ static struct tee_client_driver scmi_optee_driver = {
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
+MODULE_AUTHOR("Etienne Carriere <etienne.carriere@foss.st.com>");
+MODULE_DESCRIPTION("SCMI OPTEE Transport driver");
+MODULE_LICENSE("GPL");
-- 
2.45.2


