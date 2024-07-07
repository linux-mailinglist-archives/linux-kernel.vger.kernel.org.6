Return-Path: <linux-kernel+bounces-243431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 225BC929614
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 02:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA611F21A0E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 00:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DBAAD48;
	Sun,  7 Jul 2024 00:21:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1906C79CD;
	Sun,  7 Jul 2024 00:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720311703; cv=none; b=vA6VEkyt7pyiz2xjT7druasW53imN61VThslj9IvgU+FkuNZdWjOM+4/UqE5C0rEyvQbTRi4GWyPTQYYppZlXHIljK9KSypNsyHj3us0wfkegmQNiHPDLKgkPqoSFanRXCOSu2DKh09eiypkJ+PFu+vbw3IbvybzaSmwxYRIdPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720311703; c=relaxed/simple;
	bh=EJNZ/d5KbREkuKqiPc/RoYeYwuKSYgqe0YIgbqds4Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwrCZ/uSyxL9SMnYZIAcFt12awyPLr9f3isvD2LViuw5D5kMRvo39DdtXBEr04ggRqMxaOPMmI0eF5oPp13Zx2nunjWanRE4ma8XcHWfnYRdAP7zu3/2IiFMvG8udoAelbb0WYEhwnSoJBwKCzn0R4AVbm/NfbHVtC6NeF15dg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA099DA7;
	Sat,  6 Jul 2024 17:22:05 -0700 (PDT)
Received: from pluto.. (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 694D63F73B;
	Sat,  6 Jul 2024 17:21:38 -0700 (PDT)
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
Subject: [PATCH 3/8] firmware: arm_scmi: Add support for standalone transport drivers
Date: Sun,  7 Jul 2024 01:20:50 +0100
Message-ID: <20240707002055.1835121-4-cristian.marussi@arm.com>
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

Extend the core SCMI stack with structures and methods to allow for transports
to be split out as standalone drivers, while still supporting old style
transports, defined as built into the SCMI core stack.

No functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Old style transport support will be removed later in this series.
---
 drivers/firmware/arm_scmi/common.h | 84 ++++++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/driver.c | 44 +++++++++++++++-
 drivers/firmware/arm_scmi/msg.c    |  5 ++
 drivers/firmware/arm_scmi/shmem.c  |  5 ++
 4 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 34df078d1cd3..fda6f96b6750 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -348,6 +348,8 @@ struct scmi_shared_mem_operations {
 				     struct device *dev, bool tx);
 };
 
+const struct scmi_shared_mem_operations *scmi_shared_mem_operations_get(void);
+
 /* declarations for message passing transports */
 struct scmi_msg_payld;
 
@@ -375,6 +377,88 @@ struct scmi_message_operations {
 				   size_t max_len, struct scmi_xfer *xfer);
 };
 
+const struct scmi_message_operations *scmi_message_operations_get(void);
+
+/**
+ * struct scmi_transport_core_operations  - Transpoert core operations
+ *
+ * @bad_message_trace: An helper to report a malformed/unexpected message
+ * @rx_callback: Callback to report received messages
+ * @shmem: Datagram operations for shared memory based transports
+ * @msg: Datagram operations for message based transports
+ */
+struct scmi_transport_core_operations {
+	void (*bad_message_trace)(struct scmi_chan_info *cinfo,
+				  u32 msg_hdr, enum scmi_bad_msg err);
+	void (*rx_callback)(struct scmi_chan_info *cinfo, u32 msg_hdr,
+			    void *priv);
+	const struct scmi_shared_mem_operations *shmem;
+	const struct scmi_message_operations *msg;
+};
+
+/**
+ * struct scmi_transport  - A structure representing a configured transport
+ *
+ * @supplier: Device representimng the transport and acting as a supplier for
+ *	      the core SCMI stack
+ * @desc: Transport descriptor
+ * @core_ops: A pointer to a pointer used by the core SCMI stack to make the
+ *	      core transport operations accessible to the transports.
+ */
+struct scmi_transport {
+	struct device *supplier;
+	const struct scmi_desc *desc;
+	struct scmi_transport_core_operations **core_ops;
+};
+
+#define DEFINE_SCMI_TRANSPORT_DRIVER(__trans, __match_table, __core_ptr)\
+static int __trans##_probe(struct platform_device *pdev)		\
+{									\
+	struct scmi_transport *scmi_trans;				\
+	struct platform_device *scmi_pdev;				\
+	struct device *dev = &pdev->dev;				\
+									\
+	scmi_trans = devm_kzalloc(dev, sizeof(*scmi_trans), GFP_KERNEL);\
+	if (!scmi_trans)						\
+		return -ENOMEM;						\
+									\
+	scmi_pdev = devm_kzalloc(dev, sizeof(*scmi_pdev), GFP_KERNEL);	\
+	if (!scmi_pdev)							\
+		return -ENOMEM;						\
+									\
+	scmi_trans->supplier = dev;					\
+	scmi_trans->desc = &__trans##_desc;				\
+	scmi_trans->core_ops = __core_ptr;				\
+									\
+	scmi_pdev->name = "arm-scmi";					\
+	scmi_pdev->id = PLATFORM_DEVID_AUTO;				\
+	scmi_pdev->dev.platform_data = scmi_trans;			\
+									\
+	device_set_of_node_from_dev(&scmi_pdev->dev, dev);		\
+									\
+	dev_set_drvdata(dev, scmi_pdev);				\
+									\
+	return platform_device_register(scmi_pdev);			\
+}									\
+									\
+static void __trans##_remove(struct platform_device *pdev)		\
+{									\
+	struct platform_device *scmi_pdev;				\
+									\
+	scmi_pdev = dev_get_drvdata(&pdev->dev);			\
+									\
+	platform_device_unregister(scmi_pdev);				\
+}									\
+									\
+static struct platform_driver __trans##_driver = {			\
+	.driver = {							\
+		   .name = #__trans "_transport",			\
+		   .of_match_table = __match_table,			\
+		   },							\
+	.probe = __trans##_probe,					\
+	.remove_new = __trans##_remove,					\
+}
+
 extern const struct scmi_shared_mem_operations scmi_shmem_ops;
 extern const struct scmi_message_operations scmi_msg_ops;
 
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 6b6957f4743f..a1892d4d8c69 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -194,6 +194,11 @@ struct scmi_info {
 #define bus_nb_to_scmi_info(nb)	container_of(nb, struct scmi_info, bus_nb)
 #define req_nb_to_scmi_info(nb)	container_of(nb, struct scmi_info, dev_req_nb)
 
+static struct scmi_transport_core_operations scmi_trans_core_ops = {
+	.bad_message_trace = scmi_bad_message_trace,
+	.rx_callback = scmi_rx_callback,
+};
+
 static unsigned long
 scmi_vendor_protocol_signature(unsigned int protocol_id, char *vendor_id,
 			       char *sub_vendor_id, u32 impl_ver)
@@ -2950,6 +2955,28 @@ static int scmi_debugfs_raw_mode_setup(struct scmi_info *info)
 	return ret;
 }
 
+static const struct scmi_desc *scmi_transport_lookup(struct device *dev)
+{
+	struct scmi_transport *trans;
+
+	trans = dev_get_platdata(dev);
+	if (!trans || !trans->desc || !trans->supplier || !trans->core_ops)
+		return NULL;
+
+	if (!device_link_add(dev, trans->supplier, DL_FLAG_AUTOREMOVE_CONSUMER)) {
+		dev_err(dev,
+			"Adding link to supplier transport device failed\n");
+		return NULL;
+	}
+
+	/* Provide core transport ops */
+	*trans->core_ops = &scmi_trans_core_ops;
+
+	dev_info(dev, "Using %s\n", dev_driver_string(trans->supplier));
+
+	return trans->desc;
+}
+
 static int scmi_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -2962,8 +2989,14 @@ static int scmi_probe(struct platform_device *pdev)
 	struct device_node *child, *np = dev->of_node;
 
 	desc = of_device_get_match_data(dev);
-	if (!desc)
-		return -EINVAL;
+	if (!desc) {
+		desc = scmi_transport_lookup(dev);
+		if (!desc) {
+			err_str = "transport invalid\n";
+			ret = -EINVAL;
+			goto out_err;
+		}
+	}
 
 	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
@@ -3130,6 +3163,7 @@ static int scmi_probe(struct platform_device *pdev)
 clear_ida:
 	ida_free(&scmi_id, info->id);
 
+out_err:
 	return dev_err_probe(dev, ret, "%s", err_str);
 }
 
@@ -3321,6 +3355,12 @@ static int __init scmi_driver_init(void)
 	if (ret)
 		return ret;
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_HAVE_SHMEM))
+		scmi_trans_core_ops.shmem = scmi_shared_mem_operations_get();
+
+	if (IS_ENABLED(CONFIG_ARM_SCMI_HAVE_MSG))
+		scmi_trans_core_ops.msg = scmi_message_operations_get();
+
 	if (IS_ENABLED(CONFIG_ARM_SCMI_NEED_DEBUGFS))
 		scmi_top_dentry = scmi_debugfs_init();
 
diff --git a/drivers/firmware/arm_scmi/msg.c b/drivers/firmware/arm_scmi/msg.c
index f4ba38afe0bb..0bed1d2825af 100644
--- a/drivers/firmware/arm_scmi/msg.c
+++ b/drivers/firmware/arm_scmi/msg.c
@@ -118,3 +118,8 @@ const struct scmi_message_operations scmi_msg_ops = {
 	.fetch_response = msg_fetch_response,
 	.fetch_notification = msg_fetch_notification,
 };
+
+const struct scmi_message_operations *scmi_message_operations_get(void)
+{
+	return &scmi_msg_ops;
+}
diff --git a/drivers/firmware/arm_scmi/shmem.c b/drivers/firmware/arm_scmi/shmem.c
index c84321ff5428..feb4215831dc 100644
--- a/drivers/firmware/arm_scmi/shmem.c
+++ b/drivers/firmware/arm_scmi/shmem.c
@@ -182,3 +182,8 @@ const struct scmi_shared_mem_operations scmi_shmem_ops = {
 	.channel_intr_enabled = shmem_channel_intr_enabled,
 	.setup_iomap = shmem_setup_iomap,
 };
+
+const struct scmi_shared_mem_operations *scmi_shared_mem_operations_get(void)
+{
+	return &scmi_shmem_ops;
+}
-- 
2.45.2


