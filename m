Return-Path: <linux-kernel+bounces-303930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E26E996170C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA121F23EDD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD0D1D2796;
	Tue, 27 Aug 2024 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DvgWwaVU"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCC57D405;
	Tue, 27 Aug 2024 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724783689; cv=none; b=XzWLC34OjV6F3XCRW32q0XfjY6vpOU+ZY6n4eW6HeikL5e+3hUmImNc6HOSSHrpAPrZgo2cTgPpTX3Xyo3f4CqRG4yLJGNBjV76SQHSu0Z8SM5gsiycfbg0n9q791kj6z3cItXfU4eL7HSLfresMEfx+13jkwtsH9xfVQRpBRrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724783689; c=relaxed/simple;
	bh=00yhDg6wTKBvyoqA/HsobzG0yYt1gEx8SsEpCSHFgAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WI2g1Qa7pbwv0Y/FtC/egKzbe0jdcKlBIZPjbw+1szeRCTAmt/EWVMOEhilcjtdaF3ReA3jVSPsB+FkAApjvyR0uqES1xAoEKwffzWIB2Gi0VYsg2cLAKRcG9s96KkXnoXZo476O5TsugEWzZ6BmwkthrnrrPSRdoe/v6+aEOQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DvgWwaVU; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 940ADC0000F5;
	Tue, 27 Aug 2024 11:24:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 940ADC0000F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1724783094;
	bh=00yhDg6wTKBvyoqA/HsobzG0yYt1gEx8SsEpCSHFgAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvgWwaVUp2wVJEdM+rI50QBdFThRCRTZP1mInzbtxYFathVgIadNRIa9tLqyGNvJB
	 TX8425xyrJU+7z5NLTeuXFi2TMjf7b8/G2xFN2ri08+ApklpYP2IryeN4PB757Ruzm
	 8XZs6mWGSYvZHyH6CRChjB5TTe3uJLfsznpIHA9Y=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 380BE18045EF45;
	Tue, 27 Aug 2024 11:24:54 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	arm-scmi@vger.kernel.org (open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE),
	justin.chen@broadcom.com,
	opendmb@gmail.com,
	kapil.hali@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 2/2] firmware: arm_scmi: Support 'reg-io-width' property for shared memory
Date: Tue, 27 Aug 2024 11:24:50 -0700
Message-Id: <20240827182450.3608307-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827182450.3608307-1-florian.fainelli@broadcom.com>
References: <20240827182450.3608307-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some shared memory areas might only support a certain access width,
such as 32-bit, which memcpy_{from,to}_io() does not adhere to at least
on ARM64 by making both 8-bit and 64-bit accesses to such memory.

Update the shmem layer to support reading from and writing to such
shared memory area using the specified I/O width in the Device Tree. The
various transport layers making use of the shmem.c code are updated
accordingly to pass the I/O accessors that they store.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/firmware/arm_scmi/common.h            | 32 +++++++-
 .../arm_scmi/scmi_transport_mailbox.c         | 13 +++-
 .../firmware/arm_scmi/scmi_transport_optee.c  | 11 ++-
 .../firmware/arm_scmi/scmi_transport_smc.c    | 11 ++-
 drivers/firmware/arm_scmi/shmem.c             | 78 +++++++++++++++++--
 5 files changed, 124 insertions(+), 21 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 69928bbd01c2..a13f79b37c99 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -316,6 +316,26 @@ enum scmi_bad_msg {
 	MSG_MBOX_SPURIOUS = -5,
 };
 
+/* Used for compactness and signature validation of the function pointers being
+ * passed.
+ */
+typedef void (*shmem_copy_toio_t)(void __iomem *to, const void *from,
+				  size_t count);
+typedef void (*shmem_copy_fromio_t)(void *to, const void __iomem *from,
+				    size_t count);
+
+/**
+ * struct scmi_shmem_io_ops  - I/O operations to read from/write to
+ * Shared Memory
+ *
+ * @toio: Copy data to the shared memory area
+ * @fromio: Copy data from the shared memory area
+ */
+struct scmi_shmem_io_ops {
+	shmem_copy_fromio_t fromio;
+	shmem_copy_toio_t toio;
+};
+
 /* shmem related declarations */
 struct scmi_shared_mem;
 
@@ -336,13 +356,16 @@ struct scmi_shared_mem;
 struct scmi_shared_mem_operations {
 	void (*tx_prepare)(struct scmi_shared_mem __iomem *shmem,
 			   struct scmi_xfer *xfer,
-			   struct scmi_chan_info *cinfo);
+			   struct scmi_chan_info *cinfo,
+			   shmem_copy_toio_t toio);
 	u32 (*read_header)(struct scmi_shared_mem __iomem *shmem);
 
 	void (*fetch_response)(struct scmi_shared_mem __iomem *shmem,
-			       struct scmi_xfer *xfer);
+			       struct scmi_xfer *xfer,
+			       shmem_copy_fromio_t fromio);
 	void (*fetch_notification)(struct scmi_shared_mem __iomem *shmem,
-				   size_t max_len, struct scmi_xfer *xfer);
+				   size_t max_len, struct scmi_xfer *xfer,
+				   shmem_copy_fromio_t fromio);
 	void (*clear_channel)(struct scmi_shared_mem __iomem *shmem);
 	bool (*poll_done)(struct scmi_shared_mem __iomem *shmem,
 			  struct scmi_xfer *xfer);
@@ -350,7 +373,8 @@ struct scmi_shared_mem_operations {
 	bool (*channel_intr_enabled)(struct scmi_shared_mem __iomem *shmem);
 	void __iomem *(*setup_iomap)(struct scmi_chan_info *cinfo,
 				     struct device *dev,
-				     bool tx, struct resource *res);
+				     bool tx, struct resource *res,
+				     struct scmi_shmem_io_ops **ops);
 };
 
 const struct scmi_shared_mem_operations *scmi_shared_mem_operations_get(void);
diff --git a/drivers/firmware/arm_scmi/scmi_transport_mailbox.c b/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
index dc5ca894d5eb..1a2e90e5c765 100644
--- a/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
+++ b/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
@@ -25,6 +25,7 @@
  * @chan_platform_receiver: Optional Platform Receiver mailbox unidirectional channel
  * @cinfo: SCMI channel info
  * @shmem: Transmit/Receive shared memory area
+ * @io_ops: Transport specific I/O operations
  */
 struct scmi_mailbox {
 	struct mbox_client cl;
@@ -33,6 +34,7 @@ struct scmi_mailbox {
 	struct mbox_chan *chan_platform_receiver;
 	struct scmi_chan_info *cinfo;
 	struct scmi_shared_mem __iomem *shmem;
+	struct scmi_shmem_io_ops *io_ops;
 };
 
 #define client_to_scmi_mailbox(c) container_of(c, struct scmi_mailbox, cl)
@@ -43,7 +45,8 @@ static void tx_prepare(struct mbox_client *cl, void *m)
 {
 	struct scmi_mailbox *smbox = client_to_scmi_mailbox(cl);
 
-	core->shmem->tx_prepare(smbox->shmem, m, smbox->cinfo);
+	core->shmem->tx_prepare(smbox->shmem, m, smbox->cinfo,
+				smbox->io_ops->toio);
 }
 
 static void rx_callback(struct mbox_client *cl, void *m)
@@ -197,7 +200,8 @@ static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	if (!smbox)
 		return -ENOMEM;
 
-	smbox->shmem = core->shmem->setup_iomap(cinfo, dev, tx, NULL);
+	smbox->shmem = core->shmem->setup_iomap(cinfo, dev, tx, NULL,
+						&smbox->io_ops);
 	if (IS_ERR(smbox->shmem))
 		return PTR_ERR(smbox->shmem);
 
@@ -298,7 +302,7 @@ static void mailbox_fetch_response(struct scmi_chan_info *cinfo,
 {
 	struct scmi_mailbox *smbox = cinfo->transport_info;
 
-	core->shmem->fetch_response(smbox->shmem, xfer);
+	core->shmem->fetch_response(smbox->shmem, xfer, smbox->io_ops->fromio);
 }
 
 static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
@@ -306,7 +310,8 @@ static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
 {
 	struct scmi_mailbox *smbox = cinfo->transport_info;
 
-	core->shmem->fetch_notification(smbox->shmem, max_len, xfer);
+	core->shmem->fetch_notification(smbox->shmem, max_len, xfer,
+					smbox->io_ops->fromio);
 }
 
 static void mailbox_clear_channel(struct scmi_chan_info *cinfo)
diff --git a/drivers/firmware/arm_scmi/scmi_transport_optee.c b/drivers/firmware/arm_scmi/scmi_transport_optee.c
index 08911f40d1ff..2be4124c6826 100644
--- a/drivers/firmware/arm_scmi/scmi_transport_optee.c
+++ b/drivers/firmware/arm_scmi/scmi_transport_optee.c
@@ -114,6 +114,7 @@ enum scmi_optee_pta_cmd {
  * @req.shmem: Virtual base address of the shared memory
  * @req.msg: Shared memory protocol handle for SCMI request and
  *   synchronous response
+ * @io_ops: Transport specific I/O operations
  * @tee_shm: TEE shared memory handle @req or NULL if using IOMEM shmem
  * @link: Reference in agent's channel list
  */
@@ -128,6 +129,7 @@ struct scmi_optee_channel {
 		struct scmi_shared_mem __iomem *shmem;
 		struct scmi_msg_payld *msg;
 	} req;
+	struct scmi_shmem_io_ops *io_ops;
 	struct tee_shm *tee_shm;
 	struct list_head link;
 };
@@ -350,7 +352,8 @@ static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *ch
 static int setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
 			      struct scmi_optee_channel *channel)
 {
-	channel->req.shmem = core->shmem->setup_iomap(cinfo, dev, true, NULL);
+	channel->req.shmem = core->shmem->setup_iomap(cinfo, dev, true, NULL,
+						      &channel->io_ops);
 	if (IS_ERR(channel->req.shmem))
 		return PTR_ERR(channel->req.shmem);
 
@@ -465,7 +468,8 @@ static int scmi_optee_send_message(struct scmi_chan_info *cinfo,
 		ret = invoke_process_msg_channel(channel,
 						 core->msg->command_size(xfer));
 	} else {
-		core->shmem->tx_prepare(channel->req.shmem, xfer, cinfo);
+		core->shmem->tx_prepare(channel->req.shmem, xfer, cinfo,
+					channel->io_ops->toio);
 		ret = invoke_process_smt_channel(channel);
 	}
 
@@ -484,7 +488,8 @@ static void scmi_optee_fetch_response(struct scmi_chan_info *cinfo,
 		core->msg->fetch_response(channel->req.msg,
 					  channel->rx_len, xfer);
 	else
-		core->shmem->fetch_response(channel->req.shmem, xfer);
+		core->shmem->fetch_response(channel->req.shmem, xfer,
+					    channel->io_ops->fromio);
 }
 
 static void scmi_optee_mark_txdone(struct scmi_chan_info *cinfo, int ret,
diff --git a/drivers/firmware/arm_scmi/scmi_transport_smc.c b/drivers/firmware/arm_scmi/scmi_transport_smc.c
index c6c69a17a9cc..04e715ec1570 100644
--- a/drivers/firmware/arm_scmi/scmi_transport_smc.c
+++ b/drivers/firmware/arm_scmi/scmi_transport_smc.c
@@ -45,6 +45,7 @@
  * @irq: An optional IRQ for completion
  * @cinfo: SCMI channel info
  * @shmem: Transmit/Receive shared memory area
+ * @io_ops: Transport specific I/O operations
  * @shmem_lock: Lock to protect access to Tx/Rx shared memory area.
  *		Used when NOT operating in atomic mode.
  * @inflight: Atomic flag to protect access to Tx/Rx shared memory area.
@@ -60,6 +61,7 @@ struct scmi_smc {
 	int irq;
 	struct scmi_chan_info *cinfo;
 	struct scmi_shared_mem __iomem *shmem;
+	struct scmi_shmem_io_ops *io_ops;
 	/* Protect access to shmem area */
 	struct mutex shmem_lock;
 #define INFLIGHT_NONE	MSG_TOKEN_MAX
@@ -144,7 +146,8 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	if (!scmi_info)
 		return -ENOMEM;
 
-	scmi_info->shmem = core->shmem->setup_iomap(cinfo, dev, tx, &res);
+	scmi_info->shmem = core->shmem->setup_iomap(cinfo, dev, tx, &res,
+						    &scmi_info->io_ops);
 	if (IS_ERR(scmi_info->shmem))
 		return PTR_ERR(scmi_info->shmem);
 
@@ -229,7 +232,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 	 */
 	smc_channel_lock_acquire(scmi_info, xfer);
 
-	core->shmem->tx_prepare(scmi_info->shmem, xfer, cinfo);
+	core->shmem->tx_prepare(scmi_info->shmem, xfer, cinfo,
+				scmi_info->io_ops->toio);
 
 	if (scmi_info->cap_id != ULONG_MAX)
 		arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->cap_id, 0,
@@ -253,7 +257,8 @@ static void smc_fetch_response(struct scmi_chan_info *cinfo,
 {
 	struct scmi_smc *scmi_info = cinfo->transport_info;
 
-	core->shmem->fetch_response(scmi_info->shmem, xfer);
+	core->shmem->fetch_response(scmi_info->shmem, xfer,
+				    scmi_info->io_ops->fromio);
 }
 
 static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret,
diff --git a/drivers/firmware/arm_scmi/shmem.c b/drivers/firmware/arm_scmi/shmem.c
index 01d8a9398fe8..e9f30ab671a8 100644
--- a/drivers/firmware/arm_scmi/shmem.c
+++ b/drivers/firmware/arm_scmi/shmem.c
@@ -34,9 +34,59 @@ struct scmi_shared_mem {
 	u8 msg_payload[];
 };
 
+static inline void shmem_memcpy_fromio32(void *to,
+					 const void __iomem *from,
+					 size_t count)
+{
+	WARN_ON(!IS_ALIGNED((unsigned long)from, 4) ||
+		!IS_ALIGNED((unsigned long)to, 4) ||
+		count % 4);
+
+	__ioread32_copy(to, from, count / 4);
+}
+
+static inline void shmem_memcpy_toio32(void __iomem *to,
+				       const void *from,
+				       size_t count)
+{
+	WARN_ON(!IS_ALIGNED((unsigned long)to, 4) ||
+		!IS_ALIGNED((unsigned long)from, 4) ||
+		count % 4);
+
+	__iowrite32_copy(to, from, count / 4);
+}
+
+static struct scmi_shmem_io_ops shmem_io_ops32 = {
+	.fromio	= shmem_memcpy_fromio32,
+	.toio	= shmem_memcpy_toio32,
+};
+
+/* Wrappers are needed for proper memcpy_{from,to}_io expansion by the
+ * pre-processor.
+ */
+static inline void shmem_memcpy_fromio(void *to,
+				       const void __iomem *from,
+				       size_t count)
+{
+	memcpy_fromio(to, from, count);
+}
+
+static inline void shmem_memcpy_toio(void __iomem *to,
+				     const void *from,
+				     size_t count)
+{
+	memcpy_toio(to, from, count);
+}
+
+static struct scmi_shmem_io_ops shmem_io_ops_default = {
+	.fromio = shmem_memcpy_fromio,
+	.toio	= shmem_memcpy_toio,
+};
+
 static void shmem_tx_prepare(struct scmi_shared_mem __iomem *shmem,
 			     struct scmi_xfer *xfer,
-			     struct scmi_chan_info *cinfo)
+			     struct scmi_chan_info *cinfo,
+			     shmem_copy_toio_t copy_toio)
 {
 	ktime_t stop;
 
@@ -73,7 +123,7 @@ static void shmem_tx_prepare(struct scmi_shared_mem __iomem *shmem,
 	iowrite32(sizeof(shmem->msg_header) + xfer->tx.len, &shmem->length);
 	iowrite32(pack_scmi_header(&xfer->hdr), &shmem->msg_header);
 	if (xfer->tx.buf)
-		memcpy_toio(shmem->msg_payload, xfer->tx.buf, xfer->tx.len);
+		copy_toio(shmem->msg_payload, xfer->tx.buf, xfer->tx.len);
 }
 
 static u32 shmem_read_header(struct scmi_shared_mem __iomem *shmem)
@@ -82,7 +132,8 @@ static u32 shmem_read_header(struct scmi_shared_mem __iomem *shmem)
 }
 
 static void shmem_fetch_response(struct scmi_shared_mem __iomem *shmem,
-				 struct scmi_xfer *xfer)
+				 struct scmi_xfer *xfer,
+				 shmem_copy_fromio_t copy_fromio)
 {
 	size_t len = ioread32(&shmem->length);
 
@@ -91,11 +142,12 @@ static void shmem_fetch_response(struct scmi_shared_mem __iomem *shmem,
 	xfer->rx.len = min_t(size_t, xfer->rx.len, len > 8 ? len - 8 : 0);
 
 	/* Take a copy to the rx buffer.. */
-	memcpy_fromio(xfer->rx.buf, shmem->msg_payload + 4, xfer->rx.len);
+	copy_fromio(xfer->rx.buf, shmem->msg_payload + 4, xfer->rx.len);
 }
 
 static void shmem_fetch_notification(struct scmi_shared_mem __iomem *shmem,
-				     size_t max_len, struct scmi_xfer *xfer)
+				     size_t max_len, struct scmi_xfer *xfer,
+				     shmem_copy_fromio_t copy_fromio)
 {
 	size_t len = ioread32(&shmem->length);
 
@@ -103,7 +155,7 @@ static void shmem_fetch_notification(struct scmi_shared_mem __iomem *shmem,
 	xfer->rx.len = min_t(size_t, max_len, len > 4 ? len - 4 : 0);
 
 	/* Take a copy to the rx buffer.. */
-	memcpy_fromio(xfer->rx.buf, shmem->msg_payload, xfer->rx.len);
+	copy_fromio(xfer->rx.buf, shmem->msg_payload, xfer->rx.len);
 }
 
 static void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem)
@@ -139,7 +191,8 @@ static bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem *shmem)
 
 static void __iomem *shmem_setup_iomap(struct scmi_chan_info *cinfo,
 				       struct device *dev, bool tx,
-				       struct resource *res)
+				       struct resource *res,
+				       struct scmi_shmem_io_ops **ops)
 {
 	struct device_node *shmem __free(device_node);
 	const char *desc = tx ? "Tx" : "Rx";
@@ -148,6 +201,7 @@ static void __iomem *shmem_setup_iomap(struct scmi_chan_info *cinfo,
 	struct resource lres = {};
 	resource_size_t size;
 	void __iomem *addr;
+	u32 reg_io_width;
 
 	shmem = of_parse_phandle(cdev->of_node, "shmem", idx);
 	if (!shmem)
@@ -173,6 +227,16 @@ static void __iomem *shmem_setup_iomap(struct scmi_chan_info *cinfo,
 		return IOMEM_ERR_PTR(-EADDRNOTAVAIL);
 	}
 
+	of_property_read_u32(shmem, "reg-io-width", &reg_io_width);
+	switch (reg_io_width) {
+	case 4:
+		*ops = &shmem_io_ops32;
+		break;
+	default:
+		*ops = &shmem_io_ops_default;
+		break;
+	}
+
 	return addr;
 }
 
-- 
2.34.1


