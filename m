Return-Path: <linux-kernel+bounces-384868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E319B2F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518D31F22854
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7F11D9339;
	Mon, 28 Oct 2024 12:02:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DAE1DA636;
	Mon, 28 Oct 2024 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116940; cv=none; b=odgqpjZBrXBe4S4M8uWKGsjvU9Rc8DEz7UZxo3Y0XV0lhNArKGwnPKqRdh4Bzl8v5j+eun3LUgaO1vWAYXh+moV9eZDNsOBTV1Ve8NzQ9Z78v8zZPCtrnwcbg1IIaiYRRrOitlX2vwmd0Sr+K8JSu32f0ZZwIHdlAyRs2r8E9LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116940; c=relaxed/simple;
	bh=YhowQ+kRplF5ppw0lNNCfnRc5+vM7PeuhHMYj88V+Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6OYa0ZrU+sFNok+Nc26iau7mdkdAccQa24M04W2+Zd4XwnkXoYZV2Vz5/ry8lLzV5VwTmrrsbhzd5lWZ61ivXno9Q2bodT9ea4iX61RuImR1bRHXdmg9qlAIWFa1cGqV/76Osk/rnUO83e6UA83eYf5FFGDVa7kLtEkIXwzBIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39A86497;
	Mon, 28 Oct 2024 05:02:47 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7DA03F73B;
	Mon, 28 Oct 2024 05:02:15 -0700 (PDT)
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
Subject: [PATCH v3 5/7] firmware: arm_scmi: Relocate atomic_threshold to scmi_desc
Date: Mon, 28 Oct 2024 12:01:49 +0000
Message-ID: <20241028120151.1301177-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028120151.1301177-1-cristian.marussi@arm.com>
References: <20241028120151.1301177-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Relocate the atomic_threshold field to scmi_desc and move the related code
to scmi_transport_setup.

No functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v2 --> v3
- fixed format string using %u instead of %d
---
 drivers/firmware/arm_scmi/common.h |  7 +++++++
 drivers/firmware/arm_scmi/driver.c | 25 +++++++++----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index cb39b6bbcffd..48b12f81141d 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -229,6 +229,12 @@ struct scmi_transport_ops {
  *	be pending simultaneously in the system. May be overridden by the
  *	get_max_msg op.
  * @max_msg_size: Maximum size of data payload per message that can be handled.
+ * @atomic_threshold: Optional system wide DT-configured threshold, expressed
+ *		      in microseconds, for atomic operations.
+ *		      Only SCMI synchronous commands reported by the platform
+ *		      to have an execution latency lesser-equal to the threshold
+ *		      should be considered for atomic mode operation: such
+ *		      decision is finally left up to the SCMI drivers.
  * @force_polling: Flag to force this whole transport to use SCMI core polling
  *		   mechanism instead of completion interrupts even if available.
  * @sync_cmds_completed_on_ret: Flag to indicate that the transport assures
@@ -247,6 +253,7 @@ struct scmi_desc {
 	int max_rx_timeout_ms;
 	int max_msg;
 	int max_msg_size;
+	unsigned int atomic_threshold;
 	const bool force_polling;
 	const bool sync_cmds_completed_on_ret;
 	const bool atomic_enabled;
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index b9a1d8c1034f..9bc1bb7caa55 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -149,12 +149,6 @@ struct scmi_debug_info {
  *		   base protocol
  * @active_protocols: IDR storing device_nodes for protocols actually defined
  *		      in the DT and confirmed as implemented by fw.
- * @atomic_threshold: Optional system wide DT-configured threshold, expressed
- *		      in microseconds, for atomic operations.
- *		      Only SCMI synchronous commands reported by the platform
- *		      to have an execution latency lesser-equal to the threshold
- *		      should be considered for atomic mode operation: such
- *		      decision is finally left up to the SCMI drivers.
  * @notify_priv: Pointer to private data structure specific to notifications.
  * @node: List head
  * @users: Number of users of this instance
@@ -180,7 +174,6 @@ struct scmi_info {
 	struct mutex protocols_mtx;
 	u8 *protocols_imp;
 	struct idr active_protocols;
-	unsigned int atomic_threshold;
 	void *notify_priv;
 	struct list_head node;
 	int users;
@@ -2445,7 +2438,7 @@ static bool scmi_is_transport_atomic(const struct scmi_handle *handle,
 	ret = info->desc->atomic_enabled &&
 		is_transport_polling_capable(info->desc);
 	if (ret && atomic_threshold)
-		*atomic_threshold = info->atomic_threshold;
+		*atomic_threshold = info->desc->atomic_threshold;
 
 	return ret;
 }
@@ -2959,7 +2952,7 @@ static struct scmi_debug_info *scmi_debugfs_common_setup(struct scmi_info *info)
 			   (char **)&dbg->name);
 
 	debugfs_create_u32("atomic_threshold_us", 0400, top_dentry,
-			   &info->atomic_threshold);
+			   (u32 *)&info->desc->atomic_threshold);
 
 	debugfs_create_str("type", 0400, trans, (char **)&dbg->type);
 
@@ -3071,6 +3064,13 @@ static const struct scmi_desc *scmi_transport_setup(struct device *dev)
 		 trans->desc->max_rx_timeout_ms, trans->desc->max_msg_size,
 		 trans->desc->max_msg);
 
+	/* System wide atomic threshold for atomic ops .. if any */
+	if (!of_property_read_u32(dev->of_node, "atomic-threshold-us",
+				  &trans->desc->atomic_threshold))
+		dev_info(dev,
+			 "SCMI System wide atomic threshold set to %u us\n",
+			 trans->desc->atomic_threshold);
+
 	return trans->desc;
 }
 
@@ -3120,13 +3120,6 @@ static int scmi_probe(struct platform_device *pdev)
 	handle->devm_protocol_acquire = scmi_devm_protocol_acquire;
 	handle->devm_protocol_get = scmi_devm_protocol_get;
 	handle->devm_protocol_put = scmi_devm_protocol_put;
-
-	/* System wide atomic threshold for atomic ops .. if any */
-	if (!of_property_read_u32(np, "atomic-threshold-us",
-				  &info->atomic_threshold))
-		dev_info(dev,
-			 "SCMI System wide atomic threshold set to %d us\n",
-			 info->atomic_threshold);
 	handle->is_transport_atomic = scmi_is_transport_atomic;
 
 	/* Setup all channels described in the DT at first */
-- 
2.47.0


