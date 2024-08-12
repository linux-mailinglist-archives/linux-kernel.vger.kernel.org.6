Return-Path: <linux-kernel+bounces-283518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D428194F5DD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044991C2134D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A939F189F2D;
	Mon, 12 Aug 2024 17:34:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDCD189BAD;
	Mon, 12 Aug 2024 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484066; cv=none; b=eSC6/gCHLCgqp9zllZ05o1ya70uc8m4saFj0OT6/6ysfmkRS0GLIWf9X7IIDNYHIY0iBepd2ZhRf3XQkC7RrIGn+pd2bais5BlXHSitmTVppnD3ntlz39leS/LhjdZnbPEXmeJcOltmAw/Ha48npJjJxWOpB/H+XjfeGLxDZrXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484066; c=relaxed/simple;
	bh=vxRSvhhsbo4G133lqlVlIThjQPU65lzSnZVnHux1c70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWRWLJaoa+9/LVlqm7/nJIBzP5KXnVO97gNfHhidru+ch6VpU8564YKPoPLr/w7fPAKFOW0tokzfb2+Barw84XSHxHSWyCX0+TvHFyeBHre5PkHlDrSP4JjMBK853A6urSs+kuZTpiqENvhgnJOkm+LIjjvATfoDEyO0IOIQUb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1FDCFEC;
	Mon, 12 Aug 2024 10:34:48 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39FA93F40C;
	Mon, 12 Aug 2024 10:34:20 -0700 (PDT)
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
Subject: [PATCH v4 4/9] firmware: arm_scmi: Add support for standalone transport drivers
Date: Mon, 12 Aug 2024 18:33:35 +0100
Message-ID: <20240812173340.3912830-5-cristian.marussi@arm.com>
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

Extend the core SCMI stack with structures and methods to allow for
transports to be split out as standalone drivers, while still supporting
old style transports, defined as built into the SCMI core stack.

No functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
NOTE: old style transport support will be removed later in this series.

v2 --> v3
- reworked DEFINE_SCMI_TRANSPORT
  + using platform device_alloc + add_data + add
    (so as to gain a proper default device_release method)
  + dropped remove in favour of devres_add_action_or_reset
  + using explicit parameters for driver/desc structs naming
- renamed scmi_transport_lookup() to scmi_transport_setup()
- fixed typo in comments
v1 --> v2
- fixed comit message
---
 drivers/firmware/arm_scmi/common.h | 84 ++++++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/driver.c | 44 +++++++++++++++-
 drivers/firmware/arm_scmi/msg.c    |  5 ++
 drivers/firmware/arm_scmi/shmem.c  |  5 ++
 4 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index d5b78681b292..90404ac0629f 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -373,6 +373,8 @@ struct scmi_shared_mem_operations {
 				     bool tx, struct resource *res);
 };
 
+const struct scmi_shared_mem_operations *scmi_shared_mem_operations_get(void);
+
 /* declarations for message passing transports */
 struct scmi_msg_payld;
 
@@ -400,6 +402,88 @@ struct scmi_message_operations {
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
+ * @supplier: Device representing the transport and acting as a supplier for
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
+#define DEFINE_SCMI_TRANSPORT_DRIVER(__tag, __drv, __desc, __match, __core_ops)\
+static void __tag##_dev_free(void *data)				       \
+{									       \
+	struct platform_device *spdev = data;				       \
+									       \
+	platform_device_unregister(spdev);				       \
+}									       \
+									       \
+static int __tag##_probe(struct platform_device *pdev)			       \
+{									       \
+	struct device *dev = &pdev->dev;				       \
+	struct platform_device *spdev;					       \
+	struct scmi_transport strans;					       \
+	int ret;							       \
+									       \
+	spdev = platform_device_alloc("arm-scmi", PLATFORM_DEVID_AUTO);	       \
+	if (!spdev)							       \
+		return -ENOMEM;						       \
+									       \
+	device_set_of_node_from_dev(&spdev->dev, dev);			       \
+									       \
+	strans.supplier = dev;						       \
+	strans.desc = &(__desc);					       \
+	strans.core_ops = &(__core_ops);				       \
+									       \
+	ret = platform_device_add_data(spdev, &strans, sizeof(strans));	       \
+	if (ret)							       \
+		goto err;						       \
+									       \
+	ret = platform_device_add(spdev);				       \
+	if (ret)							       \
+		goto err;						       \
+									       \
+	return devm_add_action_or_reset(dev, __tag##_dev_free, spdev);	       \
+									       \
+err:									       \
+	platform_device_put(spdev);					       \
+	return ret;							       \
+}									       \
+									       \
+static struct platform_driver __drv = {					       \
+	.driver = {							       \
+		   .name = #__tag "_transport",				       \
+		   .of_match_table = __match,				       \
+		   },							       \
+	.probe = __tag##_probe,						       \
+}
+
 extern const struct scmi_shared_mem_operations scmi_shmem_ops;
 extern const struct scmi_message_operations scmi_msg_ops;
 
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index ca910079d718..708efe6f9be6 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -196,6 +196,11 @@ struct scmi_info {
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
@@ -3017,6 +3022,28 @@ static int scmi_debugfs_raw_mode_setup(struct scmi_info *info)
 	return ret;
 }
 
+static const struct scmi_desc *scmi_transport_setup(struct device *dev)
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
@@ -3029,8 +3056,14 @@ static int scmi_probe(struct platform_device *pdev)
 	struct device_node *child, *np = dev->of_node;
 
 	desc = of_device_get_match_data(dev);
-	if (!desc)
-		return -EINVAL;
+	if (!desc) {
+		desc = scmi_transport_setup(dev);
+		if (!desc) {
+			err_str = "transport invalid\n";
+			ret = -EINVAL;
+			goto out_err;
+		}
+	}
 
 	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
@@ -3197,6 +3230,7 @@ static int scmi_probe(struct platform_device *pdev)
 clear_ida:
 	ida_free(&scmi_id, info->id);
 
+out_err:
 	return dev_err_probe(dev, ret, "%s", err_str);
 }
 
@@ -3388,6 +3422,12 @@ static int __init scmi_driver_init(void)
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
index f5f6c2c55577..18337f9191d0 100644
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
index 477d391968c6..3fba05e1560c 100644
--- a/drivers/firmware/arm_scmi/shmem.c
+++ b/drivers/firmware/arm_scmi/shmem.c
@@ -187,3 +187,8 @@ const struct scmi_shared_mem_operations scmi_shmem_ops = {
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


