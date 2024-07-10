Return-Path: <linux-kernel+bounces-248026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EED92D780
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2391C20883
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7F119753B;
	Wed, 10 Jul 2024 17:32:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7B3194C88;
	Wed, 10 Jul 2024 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632751; cv=none; b=mDzcl8hShtZKBnVAhdq7B8NVuT7glEs2mHnNHumYeusDSm/Z+XiZEAtRxnt84ihd3jHuH0FIkBGDsWxedhhL2SGSvvOqSje0FWj/C1h1ooJlGryDLcERx92rLu9pgxYHbPOSJ71X/BdSkpaFAeMi5p/dDsItDe3xKeLBXCc5b+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632751; c=relaxed/simple;
	bh=azKO0ZcJaRXuHqmu47DvdNZen+or7UxJmQa7vt2PFBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gm0BPfW0TOfriBHXTVLD9PwN1gRdDgMCrNKgCL4K0ASA04jIZZAzlbtlVBjS950R21+AjZ17NyMvyvjIJZYg7VW2kDMd4LMolWOfEWSvWMJf1qdzLVgJ44vvlVEOpNnF+vuBrSDO5qVdr84hz6W0ODDyYbGq6WUmkbvVwDdiORw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 058171042;
	Wed, 10 Jul 2024 10:32:54 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31BB73F766;
	Wed, 10 Jul 2024 10:32:26 -0700 (PDT)
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
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 4/8] firmware: arm_scmi: Make MBOX transport a standalone driver
Date: Wed, 10 Jul 2024 18:31:49 +0100
Message-ID: <20240710173153.4060457-5-cristian.marussi@arm.com>
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

Make SCMI mailbox transport a standalne driver that can be optionally
loaded as a module.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/Kconfig             |  4 +-
 drivers/firmware/arm_scmi/Makefile            |  3 +-
 drivers/firmware/arm_scmi/common.h            |  3 --
 drivers/firmware/arm_scmi/driver.c            |  3 --
 .../{mailbox.c => scmi_transport_mailbox.c}   | 44 +++++++++++++------
 5 files changed, 36 insertions(+), 21 deletions(-)
 rename drivers/firmware/arm_scmi/{mailbox.c => scmi_transport_mailbox.c} (88%)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index aa5842be19b2..135e34aefd70 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -75,7 +75,7 @@ config ARM_SCMI_HAVE_MSG
 	  available.
 
 config ARM_SCMI_TRANSPORT_MAILBOX
-	bool "SCMI transport based on Mailbox"
+	tristate "SCMI transport based on Mailbox"
 	depends on MAILBOX
 	select ARM_SCMI_HAVE_TRANSPORT
 	select ARM_SCMI_HAVE_SHMEM
@@ -85,6 +85,8 @@ config ARM_SCMI_TRANSPORT_MAILBOX
 
 	  If you want the ARM SCMI PROTOCOL stack to include support for a
 	  transport based on mailboxes, answer Y.
+	  This driver can also be built as a module.  If so, the module
+	  will be called scmi_transport_mailbox.
 
 config ARM_SCMI_TRANSPORT_OPTEE
 	bool "SCMI transport based on OP-TEE service"
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index fd59f58ce8a2..121612d75f0b 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -5,7 +5,6 @@ scmi-core-objs := $(scmi-bus-y)
 scmi-driver-y = driver.o notify.o
 scmi-driver-$(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) += raw_mode.o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
-scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += mailbox.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
 scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
@@ -14,6 +13,8 @@ scmi-protocols-y := base.o clock.o perf.o power.o reset.o sensors.o system.o vol
 scmi-protocols-y += pinctrl.o
 scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
 
+obj-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += scmi_transport_mailbox.o
+
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
 
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 4af06810eb39..0f2256a61622 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -286,9 +286,6 @@ int scmi_xfer_raw_inflight_register(const struct scmi_handle *handle,
 int scmi_xfer_raw_wait_for_message_response(struct scmi_chan_info *cinfo,
 					    struct scmi_xfer *xfer,
 					    unsigned int timeout_ms);
-#ifdef CONFIG_ARM_SCMI_TRANSPORT_MAILBOX
-extern const struct scmi_desc scmi_mailbox_desc;
-#endif
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_SMC
 extern const struct scmi_desc scmi_smc_desc;
 #endif
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index a1892d4d8c69..96cf8ab4421e 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -3251,9 +3251,6 @@ ATTRIBUTE_GROUPS(versions);
 
 /* Each compatible listed below must have descriptor associated with it */
 static const struct of_device_id scmi_of_match[] = {
-#ifdef CONFIG_ARM_SCMI_TRANSPORT_MAILBOX
-	{ .compatible = "arm,scmi", .data = &scmi_mailbox_desc },
-#endif
 #ifdef CONFIG_ARM_SCMI_TRANSPORT_OPTEE
 	{ .compatible = "linaro,scmi-optee", .data = &scmi_optee_desc },
 #endif
diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
similarity index 88%
rename from drivers/firmware/arm_scmi/mailbox.c
rename to drivers/firmware/arm_scmi/scmi_transport_mailbox.c
index 60698efe8442..c19513e6dbdf 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
@@ -11,6 +11,7 @@
 #include <linux/mailbox_client.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 #include "common.h"
@@ -36,11 +37,13 @@ struct scmi_mailbox {
 
 #define client_to_scmi_mailbox(c) container_of(c, struct scmi_mailbox, cl)
 
+static struct scmi_transport_core_operations *core;
+
 static void tx_prepare(struct mbox_client *cl, void *m)
 {
 	struct scmi_mailbox *smbox = client_to_scmi_mailbox(cl);
 
-	scmi_shmem_ops.tx_prepare(smbox->shmem, m, smbox->cinfo);
+	core->shmem->tx_prepare(smbox->shmem, m, smbox->cinfo);
 }
 
 static void rx_callback(struct mbox_client *cl, void *m)
@@ -56,15 +59,17 @@ static void rx_callback(struct mbox_client *cl, void *m)
 	 * a previous timed-out reply which arrived late could be wrongly
 	 * associated with the next pending transaction.
 	 */
-	if (cl->knows_txdone && !scmi_shmem_ops.channel_free(smbox->shmem)) {
+	if (cl->knows_txdone &&
+	    !core->shmem->channel_free(smbox->shmem)) {
 		dev_warn(smbox->cinfo->dev, "Ignoring spurious A2P IRQ !\n");
-		scmi_bad_message_trace(smbox->cinfo,
-				       scmi_shmem_ops.read_header(smbox->shmem),
-				       MSG_MBOX_SPURIOUS);
+		core->bad_message_trace(smbox->cinfo,
+			     core->shmem->read_header(smbox->shmem),
+							     MSG_MBOX_SPURIOUS);
 		return;
 	}
 
-	scmi_rx_callback(smbox->cinfo, scmi_shmem_ops.read_header(smbox->shmem), NULL);
+	core->rx_callback(smbox->cinfo,
+		      core->shmem->read_header(smbox->shmem), NULL);
 }
 
 static bool mailbox_chan_available(struct device_node *of_node, int idx)
@@ -192,7 +197,7 @@ static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	if (!smbox)
 		return -ENOMEM;
 
-	smbox->shmem = scmi_shmem_ops.setup_iomap(cinfo, dev, tx, NULL);
+	smbox->shmem = core->shmem->setup_iomap(cinfo, dev, tx, NULL);
 	if (IS_ERR(smbox->shmem))
 		return PTR_ERR(smbox->shmem);
 
@@ -293,7 +298,7 @@ static void mailbox_fetch_response(struct scmi_chan_info *cinfo,
 {
 	struct scmi_mailbox *smbox = cinfo->transport_info;
 
-	scmi_shmem_ops.fetch_response(smbox->shmem, xfer);
+	core->shmem->fetch_response(smbox->shmem, xfer);
 }
 
 static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
@@ -301,7 +306,7 @@ static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
 {
 	struct scmi_mailbox *smbox = cinfo->transport_info;
 
-	scmi_shmem_ops.fetch_notification(smbox->shmem, max_len, xfer);
+	core->shmem->fetch_notification(smbox->shmem, max_len, xfer);
 }
 
 static void mailbox_clear_channel(struct scmi_chan_info *cinfo)
@@ -310,9 +315,9 @@ static void mailbox_clear_channel(struct scmi_chan_info *cinfo)
 	struct mbox_chan *intr_chan;
 	int ret;
 
-	scmi_shmem_ops.clear_channel(smbox->shmem);
+	core->shmem->clear_channel(smbox->shmem);
 
-	if (!scmi_shmem_ops.channel_intr_enabled(smbox->shmem))
+	if (!core->shmem->channel_intr_enabled(smbox->shmem))
 		return;
 
 	if (smbox->chan_platform_receiver)
@@ -335,7 +340,7 @@ mailbox_poll_done(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer)
 {
 	struct scmi_mailbox *smbox = cinfo->transport_info;
 
-	return scmi_shmem_ops.poll_done(smbox->shmem, xfer);
+	return core->shmem->poll_done(smbox->shmem, xfer);
 }
 
 static const struct scmi_transport_ops scmi_mailbox_ops = {
@@ -350,9 +355,22 @@ static const struct scmi_transport_ops scmi_mailbox_ops = {
 	.poll_done = mailbox_poll_done,
 };
 
-const struct scmi_desc scmi_mailbox_desc = {
+static const struct scmi_desc scmi_mailbox_desc = {
 	.ops = &scmi_mailbox_ops,
 	.max_rx_timeout_ms = 30, /* We may increase this if required */
 	.max_msg = 20, /* Limited by MBOX_TX_QUEUE_LEN */
 	.max_msg_size = 128,
 };
+
+static const struct of_device_id scmi_of_match[] = {
+	{ .compatible = "arm,scmi" },
+	{ /* Sentinel */ },
+};
+
+DEFINE_SCMI_TRANSPORT_DRIVER(scmi_mailbox, scmi_of_match, &core);
+module_platform_driver(scmi_mailbox_driver);
+
+MODULE_ALIAS("scmi-transport-mailbox");
+MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
+MODULE_DESCRIPTION("SCMI Mailbox Transport driver");
+MODULE_LICENSE("GPL");
-- 
2.45.2


