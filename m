Return-Path: <linux-kernel+bounces-374816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EDD9A709F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9623B213B8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411331EF090;
	Mon, 21 Oct 2024 17:07:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875B55FEE4;
	Mon, 21 Oct 2024 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530477; cv=none; b=INBtjak4AkgcPSKypfBb0IOVQVOnKokcpjOaue4rOa6q46HUJ11NEHPRD8xeP8UX7jaoJhzz3S8P95HvRoyFXveNze2AdzCCXjtVICDWtTqnOyLa6n1OjrozhspPEvZkVWwt+6kLG2eMb0dSM54bBpngZ9FkJHDtdjjOizxUPkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530477; c=relaxed/simple;
	bh=8rcG9F8Uqd+aePWWiv52iJ62M9YyiNOckXge+WZno0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsVUs5Pk/DVADAT/lfRc6+4DXgXyrgx9lCLe73Z11DlsSUxx8Y2V8Y7ZVR/wZAauq/ICsilOrgOSUxzbpARV3zCDd7XxoYCalG8xNpSHic9Q8Xfe03y9HsRiMOk1Tk9JGa4z25QeWMMW6mDdK21gfSAcICEBnvzqnHjJsIB8gTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C322FEC;
	Mon, 21 Oct 2024 10:08:24 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 193403F528;
	Mon, 21 Oct 2024 10:07:52 -0700 (PDT)
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
	dan.carpenter@linaro.org,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 1/5] firmware: arm_scmi: Account for SHMEM memory overhead
Date: Mon, 21 Oct 2024 18:07:22 +0100
Message-ID: <20241021170726.2564329-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241021170726.2564329-1-cristian.marussi@arm.com>
References: <20241021170726.2564329-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Transports using shared memory have to consider the overhead due to the
layout area when determining the area effectively available for messages.

Till now, such definitions were ambiguos across the SCMI stack and the
overhead layout area was not considered at all.

Add proper checks in the shmem layer to validate the provided max_msg_size
against the effectively available memory area, less the layout.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Note that as a consequence of this fix the default max_msg_size is reduced
to 104 bytes for shmem-based transports, in order to fit into the most
common implementations where the whole shmem area is sized at 128,
including the 24 bytes of standard layout area.

This should have NO bad side effects, since the current maximum payload
size of any messages across any protocol (including all the known vendor
ones) is 76 bytes.
---
 drivers/firmware/arm_scmi/common.h             | 4 +++-
 drivers/firmware/arm_scmi/driver.c             | 1 +
 drivers/firmware/arm_scmi/shmem.c              | 7 +++++++
 drivers/firmware/arm_scmi/transports/mailbox.c | 4 +++-
 drivers/firmware/arm_scmi/transports/optee.c   | 2 +-
 drivers/firmware/arm_scmi/transports/smc.c     | 4 +++-
 6 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 6c2032d4f767..d867bcc6883b 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -165,6 +165,7 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id);
  *	 channel
  * @is_p2a: A flag to identify a channel as P2A (RX)
  * @rx_timeout_ms: The configured RX timeout in milliseconds.
+ * @max_msg_size: Maximum size of message payload.
  * @handle: Pointer to SCMI entity handle
  * @no_completion_irq: Flag to indicate that this channel has no completion
  *		       interrupt mechanism for synchronous commands.
@@ -177,6 +178,7 @@ struct scmi_chan_info {
 	struct device *dev;
 	bool is_p2a;
 	unsigned int rx_timeout_ms;
+	unsigned int max_msg_size;
 	struct scmi_handle *handle;
 	bool no_completion_irq;
 	void *transport_info;
@@ -224,7 +226,7 @@ struct scmi_transport_ops {
  * @max_msg: Maximum number of messages for a channel type (tx or rx) that can
  *	be pending simultaneously in the system. May be overridden by the
  *	get_max_msg op.
- * @max_msg_size: Maximum size of data per message that can be handled.
+ * @max_msg_size: Maximum size of data payload per message that can be handled.
  * @force_polling: Flag to force this whole transport to use SCMI core polling
  *		   mechanism instead of completion interrupts even if available.
  * @sync_cmds_completed_on_ret: Flag to indicate that the transport assures
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index dccd066e3ba8..015a4d52ae37 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2645,6 +2645,7 @@ static int scmi_chan_setup(struct scmi_info *info, struct device_node *of_node,
 
 	cinfo->is_p2a = !tx;
 	cinfo->rx_timeout_ms = info->desc->max_rx_timeout_ms;
+	cinfo->max_msg_size = info->desc->max_msg_size;
 
 	/* Create a unique name for this transport device */
 	snprintf(name, 32, "__scmi_transport_device_%s_%02X",
diff --git a/drivers/firmware/arm_scmi/shmem.c b/drivers/firmware/arm_scmi/shmem.c
index e9f30ab671a8..11c347bff766 100644
--- a/drivers/firmware/arm_scmi/shmem.c
+++ b/drivers/firmware/arm_scmi/shmem.c
@@ -16,6 +16,8 @@
 
 #include "common.h"
 
+#define SCMI_SHMEM_LAYOUT_OVERHEAD	24
+
 /*
  * SCMI specification requires all parameters, message headers, return
  * arguments or any protocol data to be expressed in little endian
@@ -221,6 +223,11 @@ static void __iomem *shmem_setup_iomap(struct scmi_chan_info *cinfo,
 	}
 
 	size = resource_size(res);
+	if (cinfo->max_msg_size + SCMI_SHMEM_LAYOUT_OVERHEAD > size) {
+		dev_err(dev, "misconfigured SCMI shared memory\n");
+		return IOMEM_ERR_PTR(-ENOSPC);
+	}
+
 	addr = devm_ioremap(dev, res->start, size);
 	if (!addr) {
 		dev_err(dev, "failed to ioremap SCMI %s shared memory\n", desc);
diff --git a/drivers/firmware/arm_scmi/transports/mailbox.c b/drivers/firmware/arm_scmi/transports/mailbox.c
index e7efa3376aae..4e0396250ad0 100644
--- a/drivers/firmware/arm_scmi/transports/mailbox.c
+++ b/drivers/firmware/arm_scmi/transports/mailbox.c
@@ -16,6 +16,8 @@
 
 #include "../common.h"
 
+#define SCMI_MAILBOX_MAX_MSG_SIZE	104
+
 /**
  * struct scmi_mailbox - Structure representing a SCMI mailbox transport
  *
@@ -371,7 +373,7 @@ static struct scmi_desc scmi_mailbox_desc = {
 	.ops = &scmi_mailbox_ops,
 	.max_rx_timeout_ms = 30, /* We may increase this if required */
 	.max_msg = 20, /* Limited by MBOX_TX_QUEUE_LEN */
-	.max_msg_size = 128,
+	.max_msg_size = SCMI_MAILBOX_MAX_MSG_SIZE,
 };
 
 static const struct of_device_id scmi_of_match[] = {
diff --git a/drivers/firmware/arm_scmi/transports/optee.c b/drivers/firmware/arm_scmi/transports/optee.c
index 663272879edf..9c0bc2c4dbcd 100644
--- a/drivers/firmware/arm_scmi/transports/optee.c
+++ b/drivers/firmware/arm_scmi/transports/optee.c
@@ -17,7 +17,7 @@
 
 #include "../common.h"
 
-#define SCMI_OPTEE_MAX_MSG_SIZE		128
+#define SCMI_OPTEE_MAX_MSG_SIZE		104
 
 enum scmi_optee_pta_cmd {
 	/*
diff --git a/drivers/firmware/arm_scmi/transports/smc.c b/drivers/firmware/arm_scmi/transports/smc.c
index 2f0e981e7599..098bbd7e67b8 100644
--- a/drivers/firmware/arm_scmi/transports/smc.c
+++ b/drivers/firmware/arm_scmi/transports/smc.c
@@ -22,6 +22,8 @@
 
 #include "../common.h"
 
+#define SCMI_SMC_MAX_MSG_SIZE	104
+
 /*
  * The shmem address is split into 4K page and offset.
  * This is to make sure the parameters fit in 32bit arguments of the
@@ -282,7 +284,7 @@ static struct scmi_desc scmi_smc_desc = {
 	.ops = &scmi_smc_ops,
 	.max_rx_timeout_ms = 30,
 	.max_msg = 20,
-	.max_msg_size = 128,
+	.max_msg_size = SCMI_SMC_MAX_MSG_SIZE,
 	/*
 	 * Setting .sync_cmds_atomic_replies to true for SMC assumes that,
 	 * once the SMC instruction has completed successfully, the issued
-- 
2.46.1


