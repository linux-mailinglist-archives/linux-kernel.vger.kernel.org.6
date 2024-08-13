Return-Path: <linux-kernel+bounces-285315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6BF950BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AD4AB22277
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8998B1A38F3;
	Tue, 13 Aug 2024 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UZxeTPoe"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7141A2C18;
	Tue, 13 Aug 2024 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723572478; cv=none; b=dPF5/+6tLZdDST+hCgvEF9abvqvE+uE9Plo3IXbWUHbaXlhtOzLMeArFiadFoJLtadpcmFYUkqb9vdUnjBrtyzNM5EJsFy8rkeOB9K4m30MfapO2EHBQF2Gjyae6NSmuw81vDb5saUz/su8y+gJtbmBZjqlxWwzNsqmqXHVFpkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723572478; c=relaxed/simple;
	bh=lM3Z2jPjDQ5WyADBGpna8WNUGMeCQpGV2JVFydaHt5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n2TohJbr8aRYwnX050Cjfwft9YI5ya8Z+azC6A2PN/F7QXDn/OOM5+3hADdrltxLSAQ09KTLaqxo97H4V88FVG9o8KUYqPW5j6GD59ONJuVyx/m1Acokcpz9Kagk7uvDIkp536XWob7SnpT+GNeVRre3fU7yGUPNWXF4ge032mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UZxeTPoe; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 8727BC0000D8;
	Tue, 13 Aug 2024 11:07:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 8727BC0000D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1723572469;
	bh=lM3Z2jPjDQ5WyADBGpna8WNUGMeCQpGV2JVFydaHt5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZxeTPoeiz168pXYjrrqEYn/zUIPi1TtQNCtDSFKoFDft3nndle0xULYrPsFbcswJ
	 4BPFGlJaK7G25+ZoufJtYTu+tQrw/8OHdJMfZUWvLa98uB5cCx3dgr4kPai0lK/3Hj
	 rh+HmxekHDqrQpT/Eq0d6q/KcNjUnkN+7H9RjA+Y=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id B9E0518041CAC7;
	Tue, 13 Aug 2024 11:07:46 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	arm-scmi@vger.kernel.org (open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE),
	linux-arm-kernel@lists.infradead.org (moderated list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE),
	justin.chen@broadcom.com,
	opendmb@gmail.com,
	kapil.hali@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v2 2/2] firmware: arm_scmi: Support 'reg-io-width' property for shared memory
Date: Tue, 13 Aug 2024 11:07:47 -0700
Message-Id: <20240813180747.1439034-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813180747.1439034-1-florian.fainelli@broadcom.com>
References: <20240813180747.1439034-1-florian.fainelli@broadcom.com>
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
 .../arm_scmi/scmi_transport_mailbox.c         | 13 ++-
 .../firmware/arm_scmi/scmi_transport_optee.c  | 10 ++-
 .../firmware/arm_scmi/scmi_transport_smc.c    | 11 ++-
 drivers/firmware/arm_scmi/shmem.c             | 81 +++++++++++++++++--
 5 files changed, 126 insertions(+), 21 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 69928bbd01c2..73bb496fac01 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -316,6 +316,26 @@ enum scmi_bad_msg {
 	MSG_MBOX_SPURIOUS = -5,
 };
 
+/* Used for compactness and signature validation of the function pointers being
+ * passed.
+ */
+typedef void (*shmem_copy_toio_t)(volatile void __iomem *to, const void *from,
+				  size_t count);
+typedef void (*shmem_copy_fromio_t)(void *to, const volatile void __iomem *from,
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
index dc5ca894d5eb..2a624870954d 100644
--- a/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
+++ b/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
@@ -25,6 +25,7 @@
  * @chan_platform_receiver: Optional Platform Receiver mailbox unidirectional channel
  * @cinfo: SCMI channel info
  * @shmem: Transmit/Receive shared memory area
+ * @shmem_io_ops: Transport specific I/O operations
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
index 08911f40d1ff..fba312128426 100644
--- a/drivers/firmware/arm_scmi/scmi_transport_optee.c
+++ b/drivers/firmware/arm_scmi/scmi_transport_optee.c
@@ -128,6 +128,7 @@ struct scmi_optee_channel {
 		struct scmi_shared_mem __iomem *shmem;
 		struct scmi_msg_payld *msg;
 	} req;
+	struct scmi_shmem_io_ops *io_ops;
 	struct tee_shm *tee_shm;
 	struct list_head link;
 };
@@ -350,7 +351,8 @@ static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *ch
 static int setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
 			      struct scmi_optee_channel *channel)
 {
-	channel->req.shmem = core->shmem->setup_iomap(cinfo, dev, true, NULL);
+	channel->req.shmem = core->shmem->setup_iomap(cinfo, dev, true, NULL,
+						      &channel->io_ops);
 	if (IS_ERR(channel->req.shmem))
 		return PTR_ERR(channel->req.shmem);
 
@@ -465,7 +467,8 @@ static int scmi_optee_send_message(struct scmi_chan_info *cinfo,
 		ret = invoke_process_msg_channel(channel,
 						 core->msg->command_size(xfer));
 	} else {
-		core->shmem->tx_prepare(channel->req.shmem, xfer, cinfo);
+		core->shmem->tx_prepare(channel->req.shmem, xfer, cinfo,
+					channel->io_ops->toio);
 		ret = invoke_process_smt_channel(channel);
 	}
 
@@ -484,7 +487,8 @@ static void scmi_optee_fetch_response(struct scmi_chan_info *cinfo,
 		core->msg->fetch_response(channel->req.msg,
 					  channel->rx_len, xfer);
 	else
-		core->shmem->fetch_response(channel->req.shmem, xfer);
+		core->shmem->fetch_response(channel->req.shmem, xfer,
+					    channel->io_ops->fromio);
 }
 
 static void scmi_optee_mark_txdone(struct scmi_chan_info *cinfo, int ret,
diff --git a/drivers/firmware/arm_scmi/scmi_transport_smc.c b/drivers/firmware/arm_scmi/scmi_transport_smc.c
index c6c69a17a9cc..1de06c2fc63a 100644
--- a/drivers/firmware/arm_scmi/scmi_transport_smc.c
+++ b/drivers/firmware/arm_scmi/scmi_transport_smc.c
@@ -45,6 +45,7 @@
  * @irq: An optional IRQ for completion
  * @cinfo: SCMI channel info
  * @shmem: Transmit/Receive shared memory area
+ * @shmem_io_ops: Transport specific I/O operations
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
index 01d8a9398fe8..139bbbc4b2ee 100644
--- a/drivers/firmware/arm_scmi/shmem.c
+++ b/drivers/firmware/arm_scmi/shmem.c
@@ -34,9 +34,62 @@ struct scmi_shared_mem {
 	u8 msg_payload[];
 };
 
+#define SHMEM_IO_OPS(w, s, amt)						\
+static inline void shmem_memcpy_fromio##s(void *to,			\
+					  const volatile void __iomem *from, \
+					  size_t count)			\
+{									\
+	while (count) {							\
+		*(u##s *)to = __raw_read##w(from);			\
+		from += amt;						\
+		to += amt;						\
+		count -= amt;						\
+	}								\
+}									\
+static inline void shmem_memcpy_toio##s(volatile void __iomem *to,	\
+					const void *from,		\
+					size_t count)			\
+{									\
+	while (count) {							\
+		__raw_write##w(*(u##s *)from, to);			\
+		from += amt;						\
+		to += amt;						\
+		count -= amt;						\
+	}								\
+}									\
+static struct scmi_shmem_io_ops shmem_io_ops##s = {			\
+	.fromio	= shmem_memcpy_fromio##s,				\
+	.toio	= shmem_memcpy_toio##s,					\
+};
+
+SHMEM_IO_OPS(l, 32, 4)
+
+/* Wrappers are needed for proper memcpy_{from,to}_io expansion by the
+ * pre-processor.
+ */
+static inline void shmem_memcpy_fromio(void *to,
+				       const volatile void __iomem *from,
+				       size_t count)
+{
+	memcpy_fromio(to, from, count);
+}
+
+static inline void shmem_memcpy_toio(volatile void __iomem *to,
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
 
@@ -73,7 +126,7 @@ static void shmem_tx_prepare(struct scmi_shared_mem __iomem *shmem,
 	iowrite32(sizeof(shmem->msg_header) + xfer->tx.len, &shmem->length);
 	iowrite32(pack_scmi_header(&xfer->hdr), &shmem->msg_header);
 	if (xfer->tx.buf)
-		memcpy_toio(shmem->msg_payload, xfer->tx.buf, xfer->tx.len);
+		copy_toio(shmem->msg_payload, xfer->tx.buf, xfer->tx.len);
 }
 
 static u32 shmem_read_header(struct scmi_shared_mem __iomem *shmem)
@@ -82,7 +135,8 @@ static u32 shmem_read_header(struct scmi_shared_mem __iomem *shmem)
 }
 
 static void shmem_fetch_response(struct scmi_shared_mem __iomem *shmem,
-				 struct scmi_xfer *xfer)
+				 struct scmi_xfer *xfer,
+				 shmem_copy_fromio_t copy_fromio)
 {
 	size_t len = ioread32(&shmem->length);
 
@@ -91,11 +145,12 @@ static void shmem_fetch_response(struct scmi_shared_mem __iomem *shmem,
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
 
@@ -103,7 +158,7 @@ static void shmem_fetch_notification(struct scmi_shared_mem __iomem *shmem,
 	xfer->rx.len = min_t(size_t, max_len, len > 4 ? len - 4 : 0);
 
 	/* Take a copy to the rx buffer.. */
-	memcpy_fromio(xfer->rx.buf, shmem->msg_payload, xfer->rx.len);
+	copy_fromio(xfer->rx.buf, shmem->msg_payload, xfer->rx.len);
 }
 
 static void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem)
@@ -139,7 +194,8 @@ static bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem *shmem)
 
 static void __iomem *shmem_setup_iomap(struct scmi_chan_info *cinfo,
 				       struct device *dev, bool tx,
-				       struct resource *res)
+				       struct resource *res,
+				       struct scmi_shmem_io_ops **ops)
 {
 	struct device_node *shmem __free(device_node);
 	const char *desc = tx ? "Tx" : "Rx";
@@ -148,6 +204,7 @@ static void __iomem *shmem_setup_iomap(struct scmi_chan_info *cinfo,
 	struct resource lres = {};
 	resource_size_t size;
 	void __iomem *addr;
+	u32 reg_io_width;
 
 	shmem = of_parse_phandle(cdev->of_node, "shmem", idx);
 	if (!shmem)
@@ -173,6 +230,16 @@ static void __iomem *shmem_setup_iomap(struct scmi_chan_info *cinfo,
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


