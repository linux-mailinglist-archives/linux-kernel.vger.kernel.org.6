Return-Path: <linux-kernel+bounces-243430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E29C929613
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 02:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2180B1C20AFC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 00:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779D7A920;
	Sun,  7 Jul 2024 00:21:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53CD4A24;
	Sun,  7 Jul 2024 00:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720311701; cv=none; b=NJ8Qncf9B64YqEqRgG6GqG14QF9YP+78VUfOB0KeYVDWnKJLKBAXKk9c11rdbC1aGwLDx+VaU/TUh4qv0LluuZTruuBCqjp/24DILTzuav4drmTA+bpkTYmiDTnNpswK5sj4iYNJyksTkJQ+d83XI2YThkEPNDhFLQh8UKzi3zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720311701; c=relaxed/simple;
	bh=S/4wio+sfzQt6lbA+BSiVwVrQzlI/XeGjl49C7mNJIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sjp9kXoLM8y0dBNWCeSvY/rsDz8/BBDbpNdo8lNNFBT3mWEyF9/I2lwUwhRLxnudgp6ouc6rg6GpRnfs1fqTHAjf53zc+xFrOMH7d6kWxhhyTgmSCasMvks1qvrMnJBXpFBrj5trOkg0DoJ3KB3BMMzU05FCHvvgZCuhYjDA3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E48415BF;
	Sat,  6 Jul 2024 17:22:03 -0700 (PDT)
Received: from pluto.. (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3CE33F73B;
	Sat,  6 Jul 2024 17:21:35 -0700 (PDT)
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
Subject: [PATCH 2/8] firmware: arm_scmi: Introduce packet handling helpers
Date: Sun,  7 Jul 2024 01:20:49 +0100
Message-ID: <20240707002055.1835121-3-cristian.marussi@arm.com>
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

Introduce a pair of structures initialized to contain ll the existing packet
handling helpers, both for transports based on shared memory and messages.

No functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h  | 77 ++++++++++++++++++++---------
 drivers/firmware/arm_scmi/mailbox.c | 20 ++++----
 drivers/firmware/arm_scmi/msg.c     | 29 +++++++----
 drivers/firmware/arm_scmi/optee.c   | 14 +++---
 drivers/firmware/arm_scmi/shmem.c   | 43 ++++++++++------
 drivers/firmware/arm_scmi/smc.c     |  8 +--
 drivers/firmware/arm_scmi/virtio.c  | 14 +++---
 7 files changed, 130 insertions(+), 75 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index b4c217641e3a..34df078d1cd3 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -4,7 +4,7 @@
  * driver common header file containing some definitions, structures
  * and function prototypes used in all the different SCMI protocols.
  *
- * Copyright (C) 2018-2022 ARM Ltd.
+ * Copyright (C) 2018-2024 ARM Ltd.
  */
 #ifndef _SCMI_COMMON_H
 #define _SCMI_COMMON_H
@@ -315,20 +315,38 @@ void scmi_bad_message_trace(struct scmi_chan_info *cinfo, u32 msg_hdr,
 /* shmem related declarations */
 struct scmi_shared_mem;
 
-void shmem_tx_prepare(struct scmi_shared_mem __iomem *shmem,
-		      struct scmi_xfer *xfer, struct scmi_chan_info *cinfo);
-u32 shmem_read_header(struct scmi_shared_mem __iomem *shmem);
-void shmem_fetch_response(struct scmi_shared_mem __iomem *shmem,
+/**
+ * struct scmi_shared_mem_operations  - Transport core operations for
+ * Shared Memory
+ *
+ * @tx_prepare: Prepare the @xfer message for transmission on the chosen @shmem
+ * @read_header: Read header of the message currently hold in @shmem
+ * @fetch_response: Copy the message response from @shmem into @xfer
+ * @fetch_notification: Copy the message notification from @shmem into @xfer
+ * @clear_channel: Clear the @shmem channel busy flag
+ * @poll_done: Check if poll has completed for @xfer on @shmem
+ * @channel_free: Check if @shmem channel is marked as free
+ * @channel_intr_enabled: Check is @shmem channel has requested a completion irq
+ * @setup_iomap: Setup IO shared memory for channel @cinfo
+ */
+struct scmi_shared_mem_operations {
+	void (*tx_prepare)(struct scmi_shared_mem __iomem *shmem,
+			   struct scmi_xfer *xfer,
+			   struct scmi_chan_info *cinfo);
+	u32 (*read_header)(struct scmi_shared_mem __iomem *shmem);
+
+	void (*fetch_response)(struct scmi_shared_mem __iomem *shmem,
+			       struct scmi_xfer *xfer);
+	void (*fetch_notification)(struct scmi_shared_mem __iomem *shmem,
+				   size_t max_len, struct scmi_xfer *xfer);
+	void (*clear_channel)(struct scmi_shared_mem __iomem *shmem);
+	bool (*poll_done)(struct scmi_shared_mem __iomem *shmem,
 			  struct scmi_xfer *xfer);
-void shmem_fetch_notification(struct scmi_shared_mem __iomem *shmem,
-			      size_t max_len, struct scmi_xfer *xfer);
-void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem);
-bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
-		     struct scmi_xfer *xfer);
-bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem);
-bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem *shmem);
-void __iomem *setup_shmem_iomap(struct scmi_chan_info *cinfo, struct device *dev,
-				bool tx);
+	bool (*channel_free)(struct scmi_shared_mem __iomem *shmem);
+	bool (*channel_intr_enabled)(struct scmi_shared_mem __iomem *shmem);
+	void __iomem *(*setup_iomap)(struct scmi_chan_info *cinfo,
+				     struct device *dev, bool tx);
+};
 
 /* declarations for message passing transports */
 struct scmi_msg_payld;
@@ -336,14 +354,29 @@ struct scmi_msg_payld;
 /* Maximum overhead of message w.r.t. struct scmi_desc.max_msg_size */
 #define SCMI_MSG_MAX_PROT_OVERHEAD (2 * sizeof(__le32))
 
-size_t msg_response_size(struct scmi_xfer *xfer);
-size_t msg_command_size(struct scmi_xfer *xfer);
-void msg_tx_prepare(struct scmi_msg_payld *msg, struct scmi_xfer *xfer);
-u32 msg_read_header(struct scmi_msg_payld *msg);
-void msg_fetch_response(struct scmi_msg_payld *msg, size_t len,
-			struct scmi_xfer *xfer);
-void msg_fetch_notification(struct scmi_msg_payld *msg, size_t len,
-			    size_t max_len, struct scmi_xfer *xfer);
+/**
+ * struct scmi_message_operations  - Transport core operations for Message
+ *
+ * @response_size: Get calculated response size for @xfer
+ * @command_size: Get calculated command size for @xfer
+ * @tx_prepare: Prepare the @xfer message for transmission on the provided @msg
+ * @read_header: Read header of the message currently hold in @msg
+ * @fetch_response: Copy the message response from @msg into @xfer
+ * @fetch_notification: Copy the message notification from @msg into @xfer
+ */
+struct scmi_message_operations {
+	size_t (*response_size)(struct scmi_xfer *xfer);
+	size_t (*command_size)(struct scmi_xfer *xfer);
+	void (*tx_prepare)(struct scmi_msg_payld *msg, struct scmi_xfer *xfer);
+	u32 (*read_header)(struct scmi_msg_payld *msg);
+	void (*fetch_response)(struct scmi_msg_payld *msg, size_t len,
+			       struct scmi_xfer *xfer);
+	void (*fetch_notification)(struct scmi_msg_payld *msg, size_t len,
+				   size_t max_len, struct scmi_xfer *xfer);
+};
+
+extern const struct scmi_shared_mem_operations scmi_shmem_ops;
+extern const struct scmi_message_operations scmi_msg_ops;
 
 void scmi_notification_instance_data_set(const struct scmi_handle *handle,
 					 void *priv);
diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index b0a579f31905..b891310d2670 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -40,7 +40,7 @@ static void tx_prepare(struct mbox_client *cl, void *m)
 {
 	struct scmi_mailbox *smbox = client_to_scmi_mailbox(cl);
 
-	shmem_tx_prepare(smbox->shmem, m, smbox->cinfo);
+	scmi_shmem_ops.tx_prepare(smbox->shmem, m, smbox->cinfo);
 }
 
 static void rx_callback(struct mbox_client *cl, void *m)
@@ -56,15 +56,15 @@ static void rx_callback(struct mbox_client *cl, void *m)
 	 * a previous timed-out reply which arrived late could be wrongly
 	 * associated with the next pending transaction.
 	 */
-	if (cl->knows_txdone && !shmem_channel_free(smbox->shmem)) {
+	if (cl->knows_txdone && !scmi_shmem_ops.channel_free(smbox->shmem)) {
 		dev_warn(smbox->cinfo->dev, "Ignoring spurious A2P IRQ !\n");
 		scmi_bad_message_trace(smbox->cinfo,
-				       shmem_read_header(smbox->shmem),
+				       scmi_shmem_ops.read_header(smbox->shmem),
 				       MSG_MBOX_SPURIOUS);
 		return;
 	}
 
-	scmi_rx_callback(smbox->cinfo, shmem_read_header(smbox->shmem), NULL);
+	scmi_rx_callback(smbox->cinfo, scmi_shmem_ops.read_header(smbox->shmem), NULL);
 }
 
 static bool mailbox_chan_available(struct device_node *of_node, int idx)
@@ -192,7 +192,7 @@ static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	if (!smbox)
 		return -ENOMEM;
 
-	smbox->shmem = setup_shmem_iomap(cinfo, dev, tx);
+	smbox->shmem = scmi_shmem_ops.setup_iomap(cinfo, dev, tx);
 	if (IS_ERR(smbox->shmem))
 		return PTR_ERR(smbox->shmem);
 
@@ -293,7 +293,7 @@ static void mailbox_fetch_response(struct scmi_chan_info *cinfo,
 {
 	struct scmi_mailbox *smbox = cinfo->transport_info;
 
-	shmem_fetch_response(smbox->shmem, xfer);
+	scmi_shmem_ops.fetch_response(smbox->shmem, xfer);
 }
 
 static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
@@ -301,7 +301,7 @@ static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
 {
 	struct scmi_mailbox *smbox = cinfo->transport_info;
 
-	shmem_fetch_notification(smbox->shmem, max_len, xfer);
+	scmi_shmem_ops.fetch_notification(smbox->shmem, max_len, xfer);
 }
 
 static void mailbox_clear_channel(struct scmi_chan_info *cinfo)
@@ -310,9 +310,9 @@ static void mailbox_clear_channel(struct scmi_chan_info *cinfo)
 	struct mbox_chan *intr_chan;
 	int ret;
 
-	shmem_clear_channel(smbox->shmem);
+	scmi_shmem_ops.clear_channel(smbox->shmem);
 
-	if (!shmem_channel_intr_enabled(smbox->shmem))
+	if (!scmi_shmem_ops.channel_intr_enabled(smbox->shmem))
 		return;
 
 	if (smbox->chan_platform_receiver)
@@ -335,7 +335,7 @@ mailbox_poll_done(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer)
 {
 	struct scmi_mailbox *smbox = cinfo->transport_info;
 
-	return shmem_poll_done(smbox->shmem, xfer);
+	return scmi_shmem_ops.poll_done(smbox->shmem, xfer);
 }
 
 static const struct scmi_transport_ops scmi_mailbox_ops = {
diff --git a/drivers/firmware/arm_scmi/msg.c b/drivers/firmware/arm_scmi/msg.c
index d33a704e5814..f4ba38afe0bb 100644
--- a/drivers/firmware/arm_scmi/msg.c
+++ b/drivers/firmware/arm_scmi/msg.c
@@ -4,8 +4,8 @@
  *
  * Derived from shm.c.
  *
- * Copyright (C) 2019-2021 ARM Ltd.
- * Copyright (C) 2020-2021 OpenSynergy GmbH
+ * Copyright (C) 2019-2024 ARM Ltd.
+ * Copyright (C) 2020-2024 OpenSynergy GmbH
  */
 
 #include <linux/types.h>
@@ -30,7 +30,7 @@ struct scmi_msg_payld {
  *
  * Return: transport SDU size.
  */
-size_t msg_command_size(struct scmi_xfer *xfer)
+static size_t msg_command_size(struct scmi_xfer *xfer)
 {
 	return sizeof(struct scmi_msg_payld) + xfer->tx.len;
 }
@@ -42,7 +42,7 @@ size_t msg_command_size(struct scmi_xfer *xfer)
  *
  * Return: transport SDU size.
  */
-size_t msg_response_size(struct scmi_xfer *xfer)
+static size_t msg_response_size(struct scmi_xfer *xfer)
 {
 	return sizeof(struct scmi_msg_payld) + sizeof(__le32) + xfer->rx.len;
 }
@@ -53,7 +53,7 @@ size_t msg_response_size(struct scmi_xfer *xfer)
  * @msg: transport SDU for command
  * @xfer: message which is being sent
  */
-void msg_tx_prepare(struct scmi_msg_payld *msg, struct scmi_xfer *xfer)
+static void msg_tx_prepare(struct scmi_msg_payld *msg, struct scmi_xfer *xfer)
 {
 	msg->msg_header = cpu_to_le32(pack_scmi_header(&xfer->hdr));
 	if (xfer->tx.buf)
@@ -67,7 +67,7 @@ void msg_tx_prepare(struct scmi_msg_payld *msg, struct scmi_xfer *xfer)
  *
  * Return: SCMI header
  */
-u32 msg_read_header(struct scmi_msg_payld *msg)
+static u32 msg_read_header(struct scmi_msg_payld *msg)
 {
 	return le32_to_cpu(msg->msg_header);
 }
@@ -79,8 +79,8 @@ u32 msg_read_header(struct scmi_msg_payld *msg)
  * @len: transport SDU size
  * @xfer: message being responded to
  */
-void msg_fetch_response(struct scmi_msg_payld *msg, size_t len,
-			struct scmi_xfer *xfer)
+static void msg_fetch_response(struct scmi_msg_payld *msg,
+			       size_t len, struct scmi_xfer *xfer)
 {
 	size_t prefix_len = sizeof(*msg) + sizeof(msg->msg_payload[0]);
 
@@ -100,8 +100,8 @@ void msg_fetch_response(struct scmi_msg_payld *msg, size_t len,
  * @max_len: maximum SCMI payload size to fetch
  * @xfer: notification message
  */
-void msg_fetch_notification(struct scmi_msg_payld *msg, size_t len,
-			    size_t max_len, struct scmi_xfer *xfer)
+static void msg_fetch_notification(struct scmi_msg_payld *msg, size_t len,
+				   size_t max_len, struct scmi_xfer *xfer)
 {
 	xfer->rx.len = min_t(size_t, max_len,
 			     len >= sizeof(*msg) ? len - sizeof(*msg) : 0);
@@ -109,3 +109,12 @@ void msg_fetch_notification(struct scmi_msg_payld *msg, size_t len,
 	/* Take a copy to the rx buffer.. */
 	memcpy(xfer->rx.buf, msg->msg_payload, xfer->rx.len);
 }
+
+const struct scmi_message_operations scmi_msg_ops = {
+	.tx_prepare = msg_tx_prepare,
+	.command_size = msg_command_size,
+	.response_size = msg_response_size,
+	.read_header = msg_read_header,
+	.fetch_response = msg_fetch_response,
+	.fetch_notification = msg_fetch_notification,
+};
diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index 8abcd668108c..c26527f3b8f4 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -343,7 +343,7 @@ static void scmi_optee_clear_channel(struct scmi_chan_info *cinfo)
 	struct scmi_optee_channel *channel = cinfo->transport_info;
 
 	if (!channel->tee_shm)
-		shmem_clear_channel(channel->req.shmem);
+		scmi_shmem_ops.clear_channel(channel->req.shmem);
 }
 
 static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *channel)
@@ -368,7 +368,7 @@ static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *ch
 static int setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
 			      struct scmi_optee_channel *channel)
 {
-	channel->req.shmem = setup_shmem_iomap(cinfo, dev, true);
+	channel->req.shmem = scmi_shmem_ops.setup_iomap(cinfo, dev, true);
 	if (IS_ERR(channel->req.shmem))
 		return PTR_ERR(channel->req.shmem);
 
@@ -472,10 +472,10 @@ static int scmi_optee_send_message(struct scmi_chan_info *cinfo,
 	mutex_lock(&channel->mu);
 
 	if (channel->tee_shm) {
-		msg_tx_prepare(channel->req.msg, xfer);
-		ret = invoke_process_msg_channel(channel, msg_command_size(xfer));
+		scmi_msg_ops.tx_prepare(channel->req.msg, xfer);
+		ret = invoke_process_msg_channel(channel, scmi_msg_ops.command_size(xfer));
 	} else {
-		shmem_tx_prepare(channel->req.shmem, xfer, cinfo);
+		scmi_shmem_ops.tx_prepare(channel->req.shmem, xfer, cinfo);
 		ret = invoke_process_smt_channel(channel);
 	}
 
@@ -491,9 +491,9 @@ static void scmi_optee_fetch_response(struct scmi_chan_info *cinfo,
 	struct scmi_optee_channel *channel = cinfo->transport_info;
 
 	if (channel->tee_shm)
-		msg_fetch_response(channel->req.msg, channel->rx_len, xfer);
+		scmi_msg_ops.fetch_response(channel->req.msg, channel->rx_len, xfer);
 	else
-		shmem_fetch_response(channel->req.shmem, xfer);
+		scmi_shmem_ops.fetch_response(channel->req.shmem, xfer);
 }
 
 static void scmi_optee_mark_txdone(struct scmi_chan_info *cinfo, int ret,
diff --git a/drivers/firmware/arm_scmi/shmem.c b/drivers/firmware/arm_scmi/shmem.c
index c31f188d74ef..c84321ff5428 100644
--- a/drivers/firmware/arm_scmi/shmem.c
+++ b/drivers/firmware/arm_scmi/shmem.c
@@ -2,7 +2,7 @@
 /*
  * For transport using shared mem structure.
  *
- * Copyright (C) 2019 ARM Ltd.
+ * Copyright (C) 2019-2024 ARM Ltd.
  */
 
 #include <linux/ktime.h>
@@ -34,8 +34,9 @@ struct scmi_shared_mem {
 	u8 msg_payload[];
 };
 
-void shmem_tx_prepare(struct scmi_shared_mem __iomem *shmem,
-		      struct scmi_xfer *xfer, struct scmi_chan_info *cinfo)
+static void shmem_tx_prepare(struct scmi_shared_mem __iomem *shmem,
+			     struct scmi_xfer *xfer,
+			     struct scmi_chan_info *cinfo)
 {
 	ktime_t stop;
 
@@ -75,13 +76,13 @@ void shmem_tx_prepare(struct scmi_shared_mem __iomem *shmem,
 		memcpy_toio(shmem->msg_payload, xfer->tx.buf, xfer->tx.len);
 }
 
-u32 shmem_read_header(struct scmi_shared_mem __iomem *shmem)
+static u32 shmem_read_header(struct scmi_shared_mem __iomem *shmem)
 {
 	return ioread32(&shmem->msg_header);
 }
 
-void shmem_fetch_response(struct scmi_shared_mem __iomem *shmem,
-			  struct scmi_xfer *xfer)
+static void shmem_fetch_response(struct scmi_shared_mem __iomem *shmem,
+				 struct scmi_xfer *xfer)
 {
 	size_t len = ioread32(&shmem->length);
 
@@ -93,8 +94,8 @@ void shmem_fetch_response(struct scmi_shared_mem __iomem *shmem,
 	memcpy_fromio(xfer->rx.buf, shmem->msg_payload + 4, xfer->rx.len);
 }
 
-void shmem_fetch_notification(struct scmi_shared_mem __iomem *shmem,
-			      size_t max_len, struct scmi_xfer *xfer)
+static void shmem_fetch_notification(struct scmi_shared_mem __iomem *shmem,
+				     size_t max_len, struct scmi_xfer *xfer)
 {
 	size_t len = ioread32(&shmem->length);
 
@@ -105,13 +106,13 @@ void shmem_fetch_notification(struct scmi_shared_mem __iomem *shmem,
 	memcpy_fromio(xfer->rx.buf, shmem->msg_payload, xfer->rx.len);
 }
 
-void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem)
+static void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem)
 {
 	iowrite32(SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE, &shmem->channel_status);
 }
 
-bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
-		     struct scmi_xfer *xfer)
+static bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
+			    struct scmi_xfer *xfer)
 {
 	u16 xfer_id;
 
@@ -125,19 +126,19 @@ bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
 		 SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE);
 }
 
-bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem)
+static bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem)
 {
 	return (ioread32(&shmem->channel_status) &
 			SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE);
 }
 
-bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem *shmem)
+static bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem *shmem)
 {
 	return ioread32(&shmem->flags) & SCMI_SHMEM_FLAG_INTR_ENABLED;
 }
 
-void *__iomem
-setup_shmem_iomap(struct scmi_chan_info *cinfo, struct device *dev, bool tx)
+static void *__iomem shmem_setup_iomap(struct scmi_chan_info *cinfo,
+				       struct device *dev, bool tx)
 {
 	const char *desc = tx ? "Tx" : "Rx";
 	int ret, idx = tx ? 0 : 1;
@@ -169,3 +170,15 @@ setup_shmem_iomap(struct scmi_chan_info *cinfo, struct device *dev, bool tx)
 
 	return addr;
 }
+
+const struct scmi_shared_mem_operations scmi_shmem_ops = {
+	.tx_prepare = shmem_tx_prepare,
+	.read_header = shmem_read_header,
+	.fetch_response = shmem_fetch_response,
+	.fetch_notification = shmem_fetch_notification,
+	.clear_channel = shmem_clear_channel,
+	.poll_done = shmem_poll_done,
+	.channel_free = shmem_channel_free,
+	.channel_intr_enabled = shmem_channel_intr_enabled,
+	.setup_iomap = shmem_setup_iomap,
+};
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index a640a4312472..cb26b8aee01d 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -74,7 +74,7 @@ static irqreturn_t smc_msg_done_isr(int irq, void *data)
 	struct scmi_smc *scmi_info = data;
 
 	scmi_rx_callback(scmi_info->cinfo,
-			 shmem_read_header(scmi_info->shmem), NULL);
+			 scmi_shmem_ops.read_header(scmi_info->shmem), NULL);
 
 	return IRQ_HANDLED;
 }
@@ -142,7 +142,7 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	if (!scmi_info)
 		return -ENOMEM;
 
-	scmi_info->shmem = setup_shmem_iomap(cinfo, dev, tx);
+	scmi_info->shmem = scmi_shmem_ops.setup_iomap(cinfo, dev, tx);
 	if (IS_ERR(scmi_info->shmem))
 		return PTR_ERR(scmi_info->shmem);
 
@@ -226,7 +226,7 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 	 */
 	smc_channel_lock_acquire(scmi_info, xfer);
 
-	shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
+	scmi_shmem_ops.tx_prepare(scmi_info->shmem, xfer, cinfo);
 
 	if (scmi_info->cap_id != ULONG_MAX)
 		arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->cap_id, 0,
@@ -250,7 +250,7 @@ static void smc_fetch_response(struct scmi_chan_info *cinfo,
 {
 	struct scmi_smc *scmi_info = cinfo->transport_info;
 
-	shmem_fetch_response(scmi_info->shmem, xfer);
+	scmi_shmem_ops.fetch_response(scmi_info->shmem, xfer);
 }
 
 static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret,
diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 4892058445ce..736a0d41a458 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -295,7 +295,7 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
 		if (msg) {
 			msg->rx_len = length;
 			scmi_rx_callback(vioch->cinfo,
-					 msg_read_header(msg->input), msg);
+					 scmi_msg_ops.read_header(msg->input), msg);
 
 			scmi_finalize_message(vioch, msg);
 		}
@@ -340,7 +340,7 @@ static void scmi_vio_deferred_tx_worker(struct work_struct *work)
 		 */
 		if (msg->poll_status == VIO_MSG_NOT_POLLED)
 			scmi_rx_callback(vioch->cinfo,
-					 msg_read_header(msg->input), msg);
+					 scmi_msg_ops.read_header(msg->input), msg);
 
 		/* Free the processed message once done */
 		scmi_vio_msg_release(vioch, msg);
@@ -512,10 +512,10 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
 		return -EBUSY;
 	}
 
-	msg_tx_prepare(msg->request, xfer);
+	scmi_msg_ops.tx_prepare(msg->request, xfer);
 
-	sg_init_one(&sg_out, msg->request, msg_command_size(xfer));
-	sg_init_one(&sg_in, msg->input, msg_response_size(xfer));
+	sg_init_one(&sg_out, msg->request, scmi_msg_ops.command_size(xfer));
+	sg_init_one(&sg_in, msg->input, scmi_msg_ops.response_size(xfer));
 
 	spin_lock_irqsave(&vioch->lock, flags);
 
@@ -562,7 +562,7 @@ static void virtio_fetch_response(struct scmi_chan_info *cinfo,
 	struct scmi_vio_msg *msg = xfer->priv;
 
 	if (msg)
-		msg_fetch_response(msg->input, msg->rx_len, xfer);
+		scmi_msg_ops.fetch_response(msg->input, msg->rx_len, xfer);
 }
 
 static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
@@ -571,7 +571,7 @@ static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
 	struct scmi_vio_msg *msg = xfer->priv;
 
 	if (msg)
-		msg_fetch_notification(msg->input, msg->rx_len, max_len, xfer);
+		scmi_msg_ops.fetch_notification(msg->input, msg->rx_len, max_len, xfer);
 }
 
 /**
-- 
2.45.2


