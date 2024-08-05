Return-Path: <linux-kernel+bounces-274700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC96947B99
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1111C21BAC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB9515B12C;
	Mon,  5 Aug 2024 13:10:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC6B1591F0;
	Mon,  5 Aug 2024 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863424; cv=none; b=EgIMKxmIDd/1sid+EY2gvtlKnXy0y1Eq5nbJ+wfM75cGA94z5kfs5kiPUT6xYi3u1Rxq5EQRO34YBOodM6hpehTXiA5loMcAo9SxFXLUVGJMKZh0E4rM1pm+zNr3yhqkEP8sRpiC7uqX6cjRmOB7ruWhfLZ8MByjpdeTMPgpPo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863424; c=relaxed/simple;
	bh=7TMVD6DyD9AS0Vhz1IhLZSVWy7jBr2pjzpfg+DfI4a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuVcEt8YWc+3AAkdP17i3533Jn0jibsFHe/G12beJD3oqLyVVMoLNZJ4OcOjDi08ESKzF2mVPBO6mEC02xUOohPSpah+fnVyGVx7IwpboVNr/I8nXfNawk+trtbgjvn5DfZVXTtGVlWUh1Nleyn66B3BQUXTPurK+qkwf40qoUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D321143D;
	Mon,  5 Aug 2024 06:10:48 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A4D2B3F836;
	Mon,  5 Aug 2024 06:10:21 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Luke Parkin <luke.parkin@arm.com>
Subject: [PATCH v5 2/5] firmware: arm_scmi: Add support for debug metrics at the interface
Date: Mon,  5 Aug 2024 14:10:09 +0100
Message-ID: <20240805131013.587016-3-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240805131013.587016-1-sudeep.holla@arm.com>
References: <20240805131013.587016-1-sudeep.holla@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luke Parkin <luke.parkin@arm.com>

Since SCMI involves interaction with the entity(software, firmware and/or
hardware) providing services or features, it is quite useful to track
certain metrics(for pure debugging purposes) like how many messages were
sent or received, were there any failures, what kind of failures, ..etc.

Add a new optional config option for the above purpose and the initial
support for counting such key debug metrics.

Signed-off-by: Luke Parkin <luke.parkin@arm.com>
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/Kconfig  | 14 ++++++++++++++
 drivers/firmware/arm_scmi/common.h | 10 ++++++++++
 drivers/firmware/arm_scmi/driver.c |  2 ++
 3 files changed, 26 insertions(+)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index aa5842be19b2..f35784d0a8dd 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -55,6 +55,20 @@ config ARM_SCMI_RAW_MODE_SUPPORT_COEX
 	  operate normally, thing which could make an SCMI test suite using the
 	  SCMI Raw mode support unreliable. If unsure, say N.
 
+config ARM_SCMI_DEBUG_COUNTERS
+	bool "Enable SCMI communication debug metrics tracking"
+	select ARM_SCMI_NEED_DEBUGFS
+	depends on DEBUG_FS
+	default n
+	help
+	  Enables tracking of some key communication metrics for debug
+	  purposes. It may track metrics like how many messages were sent
+	  or received, were there any failures, what kind of failures, ..etc.
+
+	  Enable this option to create a new debugfs directory which contains
+	  such useful debug counters. This can be helpful for debugging and
+	  SCMI monitoring.
+
 config ARM_SCMI_HAVE_TRANSPORT
 	bool
 	help
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 4b8c5250cdb5..d414b0a43b3b 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -301,6 +301,16 @@ extern const struct scmi_desc scmi_optee_desc;
 
 void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv);
 
+enum debug_counters {
+	SCMI_DEBUG_COUNTERS_LAST
+};
+
+static inline void scmi_inc_count(atomic_t *arr, int stat)
+{
+	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_COUNTERS))
+		atomic_inc(&arr[stat]);
+}
+
 enum scmi_bad_msg {
 	MSG_UNEXPECTED = -1,
 	MSG_INVALID = -2,
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 56a93d20bf23..958b2ac92050 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -117,12 +117,14 @@ struct scmi_protocol_instance {
  * @name: Name of this SCMI instance
  * @type: Type of this SCMI instance
  * @is_atomic: Flag to state if the transport of this instance is atomic
+ * @counters: An array of atomic_c's used for tracking statistics (if enabled)
  */
 struct scmi_debug_info {
 	struct dentry *top_dentry;
 	const char *name;
 	const char *type;
 	bool is_atomic;
+	atomic_t counters[SCMI_DEBUG_COUNTERS_LAST];
 };
 
 /**
-- 
2.46.0


