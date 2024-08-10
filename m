Return-Path: <linux-kernel+bounces-282041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BC394DED6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 23:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8711D1C20C59
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 21:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AC7141987;
	Sat, 10 Aug 2024 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="oBQgde3W"
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7373FBA7;
	Sat, 10 Aug 2024 21:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723326389; cv=none; b=QJGeVSFvSzVdFqWWCzGkqgMBAGML9PANaqVTjB7gvY9xjOHzB5KXn3/f+94JLk0D3Q9uojpr3y6nub0/y9QLtmUXmGZOzT6GFvhrZSb2FATyyQpkd8gl7kkY/qgu7H8yWryxTgb78yZj9bQSoILForsobsbacormwSFi9I7UoIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723326389; c=relaxed/simple;
	bh=YoqW+XUQ95fii35IBnj6MfmK8HxLNFxecdC35BrZ6C8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GJvG/Ib8G+IVs9m8mz2cOg2iaS/phY493LodJYiCxo75mYlh6fqqTdUBCCtuUInteuuW1vhCCmVaelqzC/zfBuTcL6ZRyDDvRDSnLcTsQ8caIIfhhh79r6F7SCjZ5eVniZ+4yUpd6c3Mch8qlCoMqpQnARGdW/VwGJUZziV5kVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=oBQgde3W; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 19186C004D0A;
	Sat, 10 Aug 2024 14:46:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 19186C004D0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1723326381;
	bh=YoqW+XUQ95fii35IBnj6MfmK8HxLNFxecdC35BrZ6C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oBQgde3W0qvnbjP3lcbXZnrGXc9IsQbtGcwRIHwDW4oOUW3cn++W5Vi/ci6inyF8J
	 xC4Ti9lE2maRtN6W57ujiH/jR4fIewGkmzEFvUXRlPSvWcCX8o+FvqaVjevCsShiXE
	 LwHII4QsFM6+5BR8rxGV0NCDyHGwGDEDAt6zZRaM=
Received: from 7YHHR73.igp.broadcom.net (unknown [10.230.29.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id A734418041CAC4;
	Sat, 10 Aug 2024 14:46:17 -0700 (PDT)
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
	arm-scmi@vger.kernel.org,
	james.quinlan@broadcom.com,
	justin.chen@broadcom.com,
	kapil.hali@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 2/2] firmware: arm_scmi: Support 'reg-io-width' property for shared memory
Date: Sat, 10 Aug 2024 14:46:21 -0700
Message-Id: <20240810214621.14417-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240810214621.14417-1-florian.fainelli@broadcom.com>
References: <20240810214621.14417-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some shared memory areas might only support a certain access width,
(e.g.: 32 bits accesses only). Update the shmem layer to support
reading from and writing to such shared memory area using the specified
I/O width in the Device Tree. The various transport layers making use of
the shmem.c code are updated accordingly to pass the I/O width to the
routines that need it.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/firmware/arm_scmi/common.h            | 14 +++-
 .../arm_scmi/scmi_transport_mailbox.c         | 12 ++-
 .../firmware/arm_scmi/scmi_transport_optee.c  |  7 +-
 .../firmware/arm_scmi/scmi_transport_smc.c    | 10 ++-
 drivers/firmware/arm_scmi/shmem.c             | 77 ++++++++++++++++---
 5 files changed, 96 insertions(+), 24 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 69928bbd01c2..97dae844a190 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -170,6 +170,7 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id);
  *		       This can be dynamically set by transports at run-time
  *		       inside their provided .chan_setup().
  * @transport_info: Transport layer related information
+ * @shmem_io_width: I/O width in bytes of the shared memory area
  */
 struct scmi_chan_info {
 	int id;
@@ -178,6 +179,7 @@ struct scmi_chan_info {
 	struct scmi_handle *handle;
 	bool no_completion_irq;
 	void *transport_info;
+	u32 shmem_io_width;
 };
 
 /**
@@ -336,13 +338,16 @@ struct scmi_shared_mem;
 struct scmi_shared_mem_operations {
 	void (*tx_prepare)(struct scmi_shared_mem __iomem *shmem,
 			   struct scmi_xfer *xfer,
-			   struct scmi_chan_info *cinfo);
+			   struct scmi_chan_info *cinfo,
+			   u32 shmem_io_width);
 	u32 (*read_header)(struct scmi_shared_mem __iomem *shmem);
 
 	void (*fetch_response)(struct scmi_shared_mem __iomem *shmem,
-			       struct scmi_xfer *xfer);
+			       struct scmi_xfer *xfer,
+			       u32 shmem_io_width);
 	void (*fetch_notification)(struct scmi_shared_mem __iomem *shmem,
-				   size_t max_len, struct scmi_xfer *xfer);
+				   size_t max_len, struct scmi_xfer *xfer,
+				   u32 shmem_io_width);
 	void (*clear_channel)(struct scmi_shared_mem __iomem *shmem);
 	bool (*poll_done)(struct scmi_shared_mem __iomem *shmem,
 			  struct scmi_xfer *xfer);
@@ -350,7 +355,8 @@ struct scmi_shared_mem_operations {
 	bool (*channel_intr_enabled)(struct scmi_shared_mem __iomem *shmem);
 	void __iomem *(*setup_iomap)(struct scmi_chan_info *cinfo,
 				     struct device *dev,
-				     bool tx, struct resource *res);
+				     bool tx, struct resource *res,
+				     u32 *shmem_io_width);
 };
 
 const struct scmi_shared_mem_operations *scmi_shared_mem_operations_get(void);
diff --git a/drivers/firmware/arm_scmi/scmi_transport_mailbox.c b/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
index dc5ca894d5eb..6bd876875655 100644
--- a/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
+++ b/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
@@ -33,6 +33,7 @@ struct scmi_mailbox {
 	struct mbox_chan *chan_platform_receiver;
 	struct scmi_chan_info *cinfo;
 	struct scmi_shared_mem __iomem *shmem;
+	u32 shmem_io_width;
 };
 
 #define client_to_scmi_mailbox(c) container_of(c, struct scmi_mailbox, cl)
@@ -43,7 +44,8 @@ static void tx_prepare(struct mbox_client *cl, void *m)
 {
 	struct scmi_mailbox *smbox = client_to_scmi_mailbox(cl);
 
-	core->shmem->tx_prepare(smbox->shmem, m, smbox->cinfo);
+	core->shmem->tx_prepare(smbox->shmem, m, smbox->cinfo,
+				smbox->shmem_io_width);
 }
 
 static void rx_callback(struct mbox_client *cl, void *m)
@@ -197,7 +199,8 @@ static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	if (!smbox)
 		return -ENOMEM;
 
-	smbox->shmem = core->shmem->setup_iomap(cinfo, dev, tx, NULL);
+	smbox->shmem = core->shmem->setup_iomap(cinfo, dev, tx, NULL,
+						&smbox->shmem_io_width);
 	if (IS_ERR(smbox->shmem))
 		return PTR_ERR(smbox->shmem);
 
@@ -298,7 +301,7 @@ static void mailbox_fetch_response(struct scmi_chan_info *cinfo,
 {
 	struct scmi_mailbox *smbox = cinfo->transport_info;
 
-	core->shmem->fetch_response(smbox->shmem, xfer);
+	core->shmem->fetch_response(smbox->shmem, xfer, smbox->shmem_io_width);
 }
 
 static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
@@ -306,7 +309,8 @@ static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
 {
 	struct scmi_mailbox *smbox = cinfo->transport_info;
 
-	core->shmem->fetch_notification(smbox->shmem, max_len, xfer);
+	core->shmem->fetch_notification(smbox->shmem, max_len, xfer,
+					smbox->shmem_io_width);
 }
 
 static void mailbox_clear_channel(struct scmi_chan_info *cinfo)
diff --git a/drivers/firmware/arm_scmi/scmi_transport_optee.c b/drivers/firmware/arm_scmi/scmi_transport_optee.c
index 08911f40d1ff..9f6804647b29 100644
--- a/drivers/firmware/arm_scmi/scmi_transport_optee.c
+++ b/drivers/firmware/arm_scmi/scmi_transport_optee.c
@@ -350,7 +350,8 @@ static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *ch
 static int setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
 			      struct scmi_optee_channel *channel)
 {
-	channel->req.shmem = core->shmem->setup_iomap(cinfo, dev, true, NULL);
+	channel->req.shmem = core->shmem->setup_iomap(cinfo, dev, true, NULL,
+						      NULL);
 	if (IS_ERR(channel->req.shmem))
 		return PTR_ERR(channel->req.shmem);
 
@@ -465,7 +466,7 @@ static int scmi_optee_send_message(struct scmi_chan_info *cinfo,
 		ret = invoke_process_msg_channel(channel,
 						 core->msg->command_size(xfer));
 	} else {
-		core->shmem->tx_prepare(channel->req.shmem, xfer, cinfo);
+		core->shmem->tx_prepare(channel->req.shmem, xfer, cinfo, 0);
 		ret = invoke_process_smt_channel(channel);
 	}
 
@@ -484,7 +485,7 @@ static void scmi_optee_fetch_response(struct scmi_chan_info *cinfo,
 		core->msg->fetch_response(channel->req.msg,
 					  channel->rx_len, xfer);
 	else
-		core->shmem->fetch_response(channel->req.shmem, xfer);
+		core->shmem->fetch_response(channel->req.shmem, xfer, 0);
 }
 
 static void scmi_optee_mark_txdone(struct scmi_chan_info *cinfo, int ret,
diff --git a/drivers/firmware/arm_scmi/scmi_transport_smc.c b/drivers/firmware/arm_scmi/scmi_transport_smc.c
index c6c69a17a9cc..4e7b2ac1c7e8 100644
--- a/drivers/firmware/arm_scmi/scmi_transport_smc.c
+++ b/drivers/firmware/arm_scmi/scmi_transport_smc.c
@@ -60,6 +60,7 @@ struct scmi_smc {
 	int irq;
 	struct scmi_chan_info *cinfo;
 	struct scmi_shared_mem __iomem *shmem;
+	u32 shmem_io_width;
 	/* Protect access to shmem area */
 	struct mutex shmem_lock;
 #define INFLIGHT_NONE	MSG_TOKEN_MAX
@@ -144,7 +145,8 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	if (!scmi_info)
 		return -ENOMEM;
 
-	scmi_info->shmem = core->shmem->setup_iomap(cinfo, dev, tx, &res);
+	scmi_info->shmem = core->shmem->setup_iomap(cinfo, dev, tx, &res,
+						    &scmi_info->shmem_io_width);
 	if (IS_ERR(scmi_info->shmem))
 		return PTR_ERR(scmi_info->shmem);
 
@@ -229,7 +231,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 	 */
 	smc_channel_lock_acquire(scmi_info, xfer);
 
-	core->shmem->tx_prepare(scmi_info->shmem, xfer, cinfo);
+	core->shmem->tx_prepare(scmi_info->shmem, xfer, cinfo,
+				scmi_info->shmem_io_width);
 
 	if (scmi_info->cap_id != ULONG_MAX)
 		arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->cap_id, 0,
@@ -253,7 +256,8 @@ static void smc_fetch_response(struct scmi_chan_info *cinfo,
 {
 	struct scmi_smc *scmi_info = cinfo->transport_info;
 
-	core->shmem->fetch_response(scmi_info->shmem, xfer);
+	core->shmem->fetch_response(scmi_info->shmem, xfer,
+				    scmi_info->shmem_io_width);
 }
 
 static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret,
diff --git a/drivers/firmware/arm_scmi/shmem.c b/drivers/firmware/arm_scmi/shmem.c
index 01d8a9398fe8..192262d63baa 100644
--- a/drivers/firmware/arm_scmi/shmem.c
+++ b/drivers/firmware/arm_scmi/shmem.c
@@ -34,9 +34,20 @@ struct scmi_shared_mem {
 	u8 msg_payload[];
 };
 
+#define __shmem_copy_toio_tpl(s)			\
+	for (unsigned int i = 0; i < xfer->tx.len; i += shmem_io_width)		\
+		iowrite##s(((u##s *)(xfer->tx.buf))[i / shmem_io_width],	\
+			   shmem->msg_payload + i);
+
+#define __shmem_copy_fromio_tpl(s)			\
+	for (unsigned int i = 0; i < xfer->rx.len; i += shmem_io_width)		\
+		((u##s *)(xfer->rx.buf))[i / shmem_io_width] = 			\
+			 ioread##s(shmem->msg_payload + shmem_io_width + i);
+
 static void shmem_tx_prepare(struct scmi_shared_mem __iomem *shmem,
 			     struct scmi_xfer *xfer,
-			     struct scmi_chan_info *cinfo)
+			     struct scmi_chan_info *cinfo,
+			     u32 shmem_io_width)
 {
 	ktime_t stop;
 
@@ -72,8 +83,25 @@ static void shmem_tx_prepare(struct scmi_shared_mem __iomem *shmem,
 		  &shmem->flags);
 	iowrite32(sizeof(shmem->msg_header) + xfer->tx.len, &shmem->length);
 	iowrite32(pack_scmi_header(&xfer->hdr), &shmem->msg_header);
-	if (xfer->tx.buf)
-		memcpy_toio(shmem->msg_payload, xfer->tx.buf, xfer->tx.len);
+	if (xfer->tx.buf) {
+		switch (shmem_io_width) {
+		case 1:
+			__shmem_copy_toio_tpl(8);
+			break;
+		case 2:
+			__shmem_copy_toio_tpl(16);
+			break;
+		case 4:
+			__shmem_copy_toio_tpl(32);
+			break;
+		case 8:
+			__shmem_copy_toio_tpl(64);
+			break;
+		default:
+			memcpy_toio(shmem->msg_payload, xfer->tx.buf, xfer->tx.len);
+			break;
+		}
+	}
 }
 
 static u32 shmem_read_header(struct scmi_shared_mem __iomem *shmem)
@@ -81,8 +109,34 @@ static u32 shmem_read_header(struct scmi_shared_mem __iomem *shmem)
 	return ioread32(&shmem->msg_header);
 }
 
+static void __shmem_fetch_resp_notif_data(struct scmi_xfer *xfer,
+					  struct scmi_shared_mem __iomem *shmem,
+					  u32 shmem_io_width)
+{
+	/* Take a copy to the rx buffer.. */
+	switch (shmem_io_width) {
+	case 1:
+		__shmem_copy_fromio_tpl(8);
+		break;
+	case 2:
+		__shmem_copy_fromio_tpl(16);
+		break;
+	case 4:
+		__shmem_copy_fromio_tpl(32);
+		break;
+	case 8:
+		__shmem_copy_fromio_tpl(32);
+		break;
+	default:
+		memcpy_fromio(xfer->rx.buf, shmem->msg_payload + 4,
+			      xfer->rx.len);
+		break;
+	}
+}
+
 static void shmem_fetch_response(struct scmi_shared_mem __iomem *shmem,
-				 struct scmi_xfer *xfer)
+				 struct scmi_xfer *xfer,
+				 u32 shmem_io_width)
 {
 	size_t len = ioread32(&shmem->length);
 
@@ -90,20 +144,19 @@ static void shmem_fetch_response(struct scmi_shared_mem __iomem *shmem,
 	/* Skip the length of header and status in shmem area i.e 8 bytes */
 	xfer->rx.len = min_t(size_t, xfer->rx.len, len > 8 ? len - 8 : 0);
 
-	/* Take a copy to the rx buffer.. */
-	memcpy_fromio(xfer->rx.buf, shmem->msg_payload + 4, xfer->rx.len);
+	__shmem_fetch_resp_notif_data(xfer, shmem, shmem_io_width);
 }
 
 static void shmem_fetch_notification(struct scmi_shared_mem __iomem *shmem,
-				     size_t max_len, struct scmi_xfer *xfer)
+				     size_t max_len, struct scmi_xfer *xfer,
+				     u32 shmem_io_width)
 {
 	size_t len = ioread32(&shmem->length);
 
 	/* Skip only the length of header in shmem area i.e 4 bytes */
 	xfer->rx.len = min_t(size_t, max_len, len > 4 ? len - 4 : 0);
 
-	/* Take a copy to the rx buffer.. */
-	memcpy_fromio(xfer->rx.buf, shmem->msg_payload, xfer->rx.len);
+	__shmem_fetch_resp_notif_data(xfer, shmem, shmem_io_width);
 }
 
 static void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem)
@@ -139,7 +192,8 @@ static bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem *shmem)
 
 static void __iomem *shmem_setup_iomap(struct scmi_chan_info *cinfo,
 				       struct device *dev, bool tx,
-				       struct resource *res)
+				       struct resource *res,
+				       u32 *shmem_io_width)
 {
 	struct device_node *shmem __free(device_node);
 	const char *desc = tx ? "Tx" : "Rx";
@@ -173,6 +227,9 @@ static void __iomem *shmem_setup_iomap(struct scmi_chan_info *cinfo,
 		return IOMEM_ERR_PTR(-EADDRNOTAVAIL);
 	}
 
+	if (shmem_io_width)
+		of_property_read_u32(shmem, "reg-io-width", shmem_io_width);
+
 	return addr;
 }
 
-- 
2.25.1


