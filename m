Return-Path: <linux-kernel+bounces-243432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AAB929615
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 02:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA02D1C20A2E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 00:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235C8FBEA;
	Sun,  7 Jul 2024 00:21:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6481279D2;
	Sun,  7 Jul 2024 00:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720311705; cv=none; b=ZIVvvQkjKQV4xRoFvAG0+UsXTf33sJzYur+HdtF60nWAjmZsuuYbOhjf41o4laqUYplB3B+3z7E08grKwQL294bUi9NioOuDG3u3kcvfLRVCF9obZtFC4cvOsA0ADZ+78tu7uzHuPoPjFoY48mdnqPBmNlyj1GnKAQB6wzab/F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720311705; c=relaxed/simple;
	bh=fRfVl/5pzR3p0aY+pdolGdAJ80U5Bjc+kzsxqWadUnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiZQqkW20ateH1RxoB24hJdP4MvHtC3Ouuqt0YCBACT2B/teAxFUX1j3ZaXM0HN6LYgn63aURuJq3Vq+iEF3kpOBA++mCYzg790QBvtkImH9KwHFHWJF4cgItJKXkyWFo/P7u5yikH9Ls+wLmYtKZMwJ+kKQ36HeChUjfpr9iZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20CB612FC;
	Sat,  6 Jul 2024 17:22:08 -0700 (PDT)
Received: from pluto.. (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3DA53F73B;
	Sat,  6 Jul 2024 17:21:40 -0700 (PDT)
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
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 4/8] firmware: arm_scmi: Make MBOX transport a standalone driver
Date: Sun,  7 Jul 2024 01:20:51 +0100
Message-ID: <20240707002055.1835121-5-cristian.marussi@arm.com>
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
index fda6f96b6750..c03f30db92e0 100644
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
index b891310d2670..4d8607c6df23 100644
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
 
-	smbox->shmem = scmi_shmem_ops.setup_iomap(cinfo, dev, tx);
+	smbox->shmem = core->shmem->setup_iomap(cinfo, dev, tx);
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


