Return-Path: <linux-kernel+bounces-283523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E55294F5E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DFBBB21FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E971898F3;
	Mon, 12 Aug 2024 17:34:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEF518953F;
	Mon, 12 Aug 2024 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484080; cv=none; b=Ij9RZSbmA/zhPMkRxLdmkVqnZHsqiO6ejWY8aqY3gRtcfUmSS0FkZOt19dzC/ngyEqkeQKV0N0RzmfLP89Bggm3FLZ+CaWSbb5P8E26D5qLkvBddVRJaEbYQnimA7WE+P0UhXmRsm2bhcVfnUmRcOHl4M2A4pEPq5VMRhQIVqH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484080; c=relaxed/simple;
	bh=jG8EctsdMARclVDUZRNdcrM8SilmA8G7JpOcKOaQB9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOHcGZ/T1Z+gCkUU+InjfBI8UBJv90aNHjUaYDwF7sn2TIpaNncpeOBS7Z3ekCQsS8nOnQlznrfCVIJ1oVbE0Sw3NJv3S5OTC31j21dYFEkyOwDZTA9NEBdNtanv8YKOpF0I/L/x7MeMycWKqhrXM9tCXsG4myxKE4uSSALjtPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F382BFEC;
	Mon, 12 Aug 2024 10:35:03 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F93B3F40C;
	Mon, 12 Aug 2024 10:34:35 -0700 (PDT)
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
Subject: [PATCH v4 9/9] firmware: arm_scmi: Remove legacy transport-layer code
Date: Mon, 12 Aug 2024 18:33:40 +0100
Message-ID: <20240812173340.3912830-10-cristian.marussi@arm.com>
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

Since all SCMI transports have been made standalone drivers, remove all the
core SCMI stack legacy support that was needed to run transports as built
into the stack.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v2 --> v3
- updated Copyright
---
 drivers/firmware/arm_scmi/common.h | 18 ------
 drivers/firmware/arm_scmi/driver.c | 98 +++++-------------------------
 drivers/firmware/arm_scmi/msg.c    |  2 +-
 drivers/firmware/arm_scmi/shmem.c  |  2 +-
 4 files changed, 16 insertions(+), 104 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 7a53412fc41c..e44f7d1b4417 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -183,7 +183,6 @@ struct scmi_chan_info {
 /**
  * struct scmi_transport_ops - Structure representing a SCMI transport ops
  *
- * @link_supplier: Optional callback to add link to a supplier device
  * @chan_available: Callback to check if channel is available or not
  * @chan_setup: Callback to allocate and setup a channel
  * @chan_free: Callback to free a channel
@@ -198,7 +197,6 @@ struct scmi_chan_info {
  * @poll_done: Callback to poll transfer status
  */
 struct scmi_transport_ops {
-	int (*link_supplier)(struct device *dev);
 	bool (*chan_available)(struct device_node *of_node, int idx);
 	int (*chan_setup)(struct scmi_chan_info *cinfo, struct device *dev,
 			  bool tx);
@@ -219,12 +217,6 @@ struct scmi_transport_ops {
 /**
  * struct scmi_desc - Description of SoC integration
  *
- * @transport_init: An optional function that a transport can provide to
- *		    initialize some transport-specific setup during SCMI core
- *		    initialization, so ahead of SCMI core probing.
- * @transport_exit: An optional function that a transport can provide to
- *		    de-initialize some transport-specific setup during SCMI core
- *		    de-initialization, so after SCMI core removal.
  * @ops: Pointer to the transport specific ops structure
  * @max_rx_timeout_ms: Timeout for communication with SoC (in Milliseconds)
  * @max_msg: Maximum number of messages for a channel type (tx or rx) that can
@@ -245,8 +237,6 @@ struct scmi_transport_ops {
  *		    when requested.
  */
 struct scmi_desc {
-	int (*transport_init)(void);
-	void (*transport_exit)(void);
 	const struct scmi_transport_ops *ops;
 	int max_rx_timeout_ms;
 	int max_msg;
@@ -287,8 +277,6 @@ int scmi_xfer_raw_wait_for_message_response(struct scmi_chan_info *cinfo,
 					    struct scmi_xfer *xfer,
 					    unsigned int timeout_ms);
 
-void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv);
-
 enum debug_counters {
 	SENT_OK,
 	SENT_FAIL,
@@ -321,9 +309,6 @@ enum scmi_bad_msg {
 	MSG_MBOX_SPURIOUS = -5,
 };
 
-void scmi_bad_message_trace(struct scmi_chan_info *cinfo, u32 msg_hdr,
-			    enum scmi_bad_msg err);
-
 /* shmem related declarations */
 struct scmi_shared_mem;
 
@@ -472,9 +457,6 @@ static struct platform_driver __drv = {					       \
 	.probe = __tag##_probe,						       \
 }
 
-extern const struct scmi_shared_mem_operations scmi_shmem_ops;
-extern const struct scmi_message_operations scmi_msg_ops;
-
 void scmi_notification_instance_data_set(const struct scmi_handle *handle,
 					 void *priv);
 void *scmi_notification_instance_data_get(const struct scmi_handle *handle);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 12643b4c0db3..119c9b6ae3c1 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -11,7 +11,7 @@
  * various power domain DVFS including the core/cluster, certain system
  * clocks configuration, thermal sensors and many others.
  *
- * Copyright (C) 2018-2021 ARM Ltd.
+ * Copyright (C) 2018-2024 ARM Ltd.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -196,6 +196,11 @@ struct scmi_info {
 #define bus_nb_to_scmi_info(nb)	container_of(nb, struct scmi_info, bus_nb)
 #define req_nb_to_scmi_info(nb)	container_of(nb, struct scmi_info, dev_req_nb)
 
+static void scmi_rx_callback(struct scmi_chan_info *cinfo,
+			     u32 msg_hdr, void *priv);
+static void scmi_bad_message_trace(struct scmi_chan_info *cinfo,
+				   u32 msg_hdr, enum scmi_bad_msg err);
+
 static struct scmi_transport_core_operations scmi_trans_core_ops = {
 	.bad_message_trace = scmi_bad_message_trace,
 	.rx_callback = scmi_rx_callback,
@@ -840,8 +845,8 @@ scmi_xfer_lookup_unlocked(struct scmi_xfers_info *minfo, u16 xfer_id)
  * timed-out message that arrives and as such, can be traced only referring to
  * the header content, since the payload is missing/unreliable.
  */
-void scmi_bad_message_trace(struct scmi_chan_info *cinfo, u32 msg_hdr,
-			    enum scmi_bad_msg err)
+static void scmi_bad_message_trace(struct scmi_chan_info *cinfo, u32 msg_hdr,
+				   enum scmi_bad_msg err)
 {
 	char *tag;
 	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
@@ -1174,7 +1179,8 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
  * NOTE: This function will be invoked in IRQ context, hence should be
  * as optimal as possible.
  */
-void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv)
+static void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr,
+			     void *priv)
 {
 	u8 msg_type = MSG_XTRACT_TYPE(msg_hdr);
 
@@ -3055,14 +3061,11 @@ static int scmi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *child, *np = dev->of_node;
 
-	desc = of_device_get_match_data(dev);
+	desc = scmi_transport_setup(dev);
 	if (!desc) {
-		desc = scmi_transport_setup(dev);
-		if (!desc) {
-			err_str = "transport invalid\n";
-			ret = -EINVAL;
-			goto out_err;
-		}
+		err_str = "transport invalid\n";
+		ret = -EINVAL;
+		goto out_err;
 	}
 
 	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
@@ -3102,14 +3105,6 @@ static int scmi_probe(struct platform_device *pdev)
 			 info->atomic_threshold);
 	handle->is_transport_atomic = scmi_is_transport_atomic;
 
-	if (desc->ops->link_supplier) {
-		ret = desc->ops->link_supplier(dev);
-		if (ret) {
-			err_str = "transport not ready\n";
-			goto clear_ida;
-		}
-	}
-
 	/* Setup all channels described in the DT at first */
 	ret = scmi_channels_setup(info);
 	if (ret) {
@@ -3316,72 +3311,16 @@ static struct attribute *versions_attrs[] = {
 };
 ATTRIBUTE_GROUPS(versions);
 
-/* Each compatible listed below must have descriptor associated with it */
-static const struct of_device_id scmi_of_match[] = {
-	{ /* Sentinel */ },
-};
-
-MODULE_DEVICE_TABLE(of, scmi_of_match);
-
 static struct platform_driver scmi_driver = {
 	.driver = {
 		   .name = "arm-scmi",
 		   .suppress_bind_attrs = true,
-		   .of_match_table = scmi_of_match,
 		   .dev_groups = versions_groups,
 		   },
 	.probe = scmi_probe,
 	.remove_new = scmi_remove,
 };
 
-/**
- * __scmi_transports_setup  - Common helper to call transport-specific
- * .init/.exit code if provided.
- *
- * @init: A flag to distinguish between init and exit.
- *
- * Note that, if provided, we invoke .init/.exit functions for all the
- * transports currently compiled in.
- *
- * Return: 0 on Success.
- */
-static inline int __scmi_transports_setup(bool init)
-{
-	int ret = 0;
-	const struct of_device_id *trans;
-
-	for (trans = scmi_of_match; trans->data; trans++) {
-		const struct scmi_desc *tdesc = trans->data;
-
-		if ((init && !tdesc->transport_init) ||
-		    (!init && !tdesc->transport_exit))
-			continue;
-
-		if (init)
-			ret = tdesc->transport_init();
-		else
-			tdesc->transport_exit();
-
-		if (ret) {
-			pr_err("SCMI transport %s FAILED initialization!\n",
-			       trans->compatible);
-			break;
-		}
-	}
-
-	return ret;
-}
-
-static int __init scmi_transports_init(void)
-{
-	return __scmi_transports_setup(true);
-}
-
-static void __exit scmi_transports_exit(void)
-{
-	__scmi_transports_setup(false);
-}
-
 static struct dentry *scmi_debugfs_init(void)
 {
 	struct dentry *d;
@@ -3397,17 +3336,10 @@ static struct dentry *scmi_debugfs_init(void)
 
 static int __init scmi_driver_init(void)
 {
-	int ret;
-
 	/* Bail out if no SCMI transport was configured */
 	if (WARN_ON(!IS_ENABLED(CONFIG_ARM_SCMI_HAVE_TRANSPORT)))
 		return -EINVAL;
 
-	/* Initialize any compiled-in transport which provided an init/exit */
-	ret = scmi_transports_init();
-	if (ret)
-		return ret;
-
 	if (IS_ENABLED(CONFIG_ARM_SCMI_HAVE_SHMEM))
 		scmi_trans_core_ops.shmem = scmi_shared_mem_operations_get();
 
@@ -3447,8 +3379,6 @@ static void __exit scmi_driver_exit(void)
 	scmi_powercap_unregister();
 	scmi_pinctrl_unregister();
 
-	scmi_transports_exit();
-
 	platform_driver_unregister(&scmi_driver);
 
 	debugfs_remove_recursive(scmi_top_dentry);
diff --git a/drivers/firmware/arm_scmi/msg.c b/drivers/firmware/arm_scmi/msg.c
index 18337f9191d0..2cc74e6bbd72 100644
--- a/drivers/firmware/arm_scmi/msg.c
+++ b/drivers/firmware/arm_scmi/msg.c
@@ -110,7 +110,7 @@ static void msg_fetch_notification(struct scmi_msg_payld *msg, size_t len,
 	memcpy(xfer->rx.buf, msg->msg_payload, xfer->rx.len);
 }
 
-const struct scmi_message_operations scmi_msg_ops = {
+static const struct scmi_message_operations scmi_msg_ops = {
 	.tx_prepare = msg_tx_prepare,
 	.command_size = msg_command_size,
 	.response_size = msg_response_size,
diff --git a/drivers/firmware/arm_scmi/shmem.c b/drivers/firmware/arm_scmi/shmem.c
index 3fba05e1560c..01d8a9398fe8 100644
--- a/drivers/firmware/arm_scmi/shmem.c
+++ b/drivers/firmware/arm_scmi/shmem.c
@@ -176,7 +176,7 @@ static void __iomem *shmem_setup_iomap(struct scmi_chan_info *cinfo,
 	return addr;
 }
 
-const struct scmi_shared_mem_operations scmi_shmem_ops = {
+static const struct scmi_shared_mem_operations scmi_shmem_ops = {
 	.tx_prepare = shmem_tx_prepare,
 	.read_header = shmem_read_header,
 	.fetch_response = shmem_fetch_response,
-- 
2.45.2


