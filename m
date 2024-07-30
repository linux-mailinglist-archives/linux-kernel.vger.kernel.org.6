Return-Path: <linux-kernel+bounces-267726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40199414C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35C42851C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2C4CA6B;
	Tue, 30 Jul 2024 14:48:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302631A3BD7;
	Tue, 30 Jul 2024 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350894; cv=none; b=FrSM4gqwbxxnhXhcOLumSTxndEgWoIsv9t4/VpY0Lnr2Rz34ICe7GEVJDlQag3TiC4zrJi55g7rCFKmH7h+l8mTbBRh++86YGBiQZcRhFscRqz49Lr/wC6d/0YlBLl89BBBZGEbdMEj43z3OFxQoZXEgLDZubpUiMH1EV8dUa4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350894; c=relaxed/simple;
	bh=/98SPjl3bs049AFP8/MXLSTbsr2VdIQZ/hmRsPc75N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bg7UdZur+hKANKnBIuHeKOr0Zaam1/QjRzCcMXjc1mB5RpDNaDX/4qzUf/a6VikK3/89G+ycYwIxZJ/VaSydBnW1ZOCFzWCTB1pOesb4jgB0qu/HqcXtg3Df0ErTDrF5P6WQhd6HMfD9w/z4ckiZj4oGcZyZ5MlYz0BDy5Tie9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 255921007;
	Tue, 30 Jul 2024 07:48:38 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BD2D3F766;
	Tue, 30 Jul 2024 07:48:09 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	devicetree@vger.kernel.org
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
	souvik.chakravarty@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v1 6/6] firmware: arm_scmi: Relocate atomic_threshold to scmi_desc
Date: Tue, 30 Jul 2024 15:47:07 +0100
Message-ID: <20240730144707.1647025-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730144707.1647025-1-cristian.marussi@arm.com>
References: <20240730144707.1647025-1-cristian.marussi@arm.com>
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
 drivers/firmware/arm_scmi/common.h |  7 +++++++
 drivers/firmware/arm_scmi/driver.c | 25 +++++++++----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 5261dc9b5f96..3bb5fdc0d57d 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -223,6 +223,12 @@ struct scmi_transport_ops {
  *	be pending simultaneously in the system. May be overridden by the
  *	get_max_msg op.
  * @max_msg_size: Maximum size of data per message that can be handled.
+ * @atomic_threshold: Optional system wide DT-configured threshold, expressed
+ *		      in microseconds, for atomic operations.
+ *		      Only SCMI synchronous commands reported by the platform
+ *		      to have an execution latency lesser-equal to the threshold
+ *		      should be considered for atomic mode operation: such
+ *		      decision is finally left up to the SCMI drivers.
  * @force_polling: Flag to force this whole transport to use SCMI core polling
  *		   mechanism instead of completion interrupts even if available.
  * @sync_cmds_completed_on_ret: Flag to indicate that the transport assures
@@ -241,6 +247,7 @@ struct scmi_desc {
 	int max_rx_timeout_ms;
 	int max_msg;
 	int max_msg_size;
+	unsigned int atomic_threshold;
 	const bool force_polling;
 	const bool sync_cmds_completed_on_ret;
 	const bool atomic_enabled;
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 8295e63be38e..26781e678cc3 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -147,12 +147,6 @@ struct scmi_debug_info {
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
@@ -178,7 +172,6 @@ struct scmi_info {
 	struct mutex protocols_mtx;
 	u8 *protocols_imp;
 	struct idr active_protocols;
-	unsigned int atomic_threshold;
 	void *notify_priv;
 	struct list_head node;
 	int users;
@@ -2427,7 +2420,7 @@ static bool scmi_is_transport_atomic(const struct scmi_handle *handle,
 	ret = info->desc->atomic_enabled &&
 		is_transport_polling_capable(info->desc);
 	if (ret && atomic_threshold)
-		*atomic_threshold = info->atomic_threshold;
+		*atomic_threshold = info->desc->atomic_threshold;
 
 	return ret;
 }
@@ -2892,7 +2885,7 @@ static struct scmi_debug_info *scmi_debugfs_common_setup(struct scmi_info *info)
 			   (char **)&dbg->name);
 
 	debugfs_create_u32("atomic_threshold_us", 0400, top_dentry,
-			   &info->atomic_threshold);
+			   (u32 *)&info->desc->atomic_threshold);
 
 	debugfs_create_str("type", 0400, trans, (char **)&dbg->type);
 
@@ -3001,6 +2994,13 @@ static const struct scmi_desc *scmi_transport_setup(struct device *dev)
 		 trans->desc->max_rx_timeout_ms, trans->desc->max_msg_size,
 		 trans->desc->max_msg);
 
+	/* System wide atomic threshold for atomic ops .. if any */
+	if (!of_property_read_u32(dev->of_node, "atomic-threshold-us",
+				  &trans->desc->atomic_threshold))
+		dev_info(dev,
+			 "SCMI System wide atomic threshold set to %d us\n",
+			 trans->desc->atomic_threshold);
+
 	return trans->desc;
 }
 
@@ -3050,13 +3050,6 @@ static int scmi_probe(struct platform_device *pdev)
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
2.45.2


