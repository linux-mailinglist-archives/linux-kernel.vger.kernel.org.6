Return-Path: <linux-kernel+bounces-239655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DEE926396
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8551286A54
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F3117C23E;
	Wed,  3 Jul 2024 14:38:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F3717BB13;
	Wed,  3 Jul 2024 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017514; cv=none; b=bnQhAWV2PJtXjUmxIavVrgrfBDWNnSJ48gBayAXpxxjtdWCNyF47P22c/Y+Swn1W0Qx1hoK/3Y7UFCy8iH/PBiusNVY9Xz71lYIilbNKEoRWRQn0GzyIfayanFMw1UC95XoP7kzSq4fT4Slb5GhiDTUWQKgTWkz2W/0NaKNlji0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017514; c=relaxed/simple;
	bh=erSLUW9xHIYQlmmCQqx868PG0S+Z7gq7cNErpAEdZ58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PrYcH6fYjlxxB4v9OPG0Jr7EHRmhNJOgFg0yKIkFc+A0fZ3N73kUq+LqsEbtwG7X9ubXCuOzA1d29GkbUhcArevH+26jgbddvwIRPQGbjgyfkokgD1TxdG6qgEIcHbBcnKurAloFCo/ke3BgGYVWsQMNBdGOVN0awCkot0FiIEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F1C7367;
	Wed,  3 Jul 2024 07:38:57 -0700 (PDT)
Received: from thinkcentre-m93p.cambridge.arm.com (thinkcentre-m93p.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F2003F766;
	Wed,  3 Jul 2024 07:38:31 -0700 (PDT)
From: Luke Parkin <luke.parkin@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	Luke Parkin <luke.parkin@arm.com>
Subject: [PATCH v2 2/4] firmware: arm_scmi: Add support for tracking statistics
Date: Wed,  3 Jul 2024 15:37:36 +0100
Message-Id: <20240703143738.2007457-3-luke.parkin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703143738.2007457-1-luke.parkin@arm.com>
References: <20240703143738.2007457-1-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new config option for statistic tracking in SCMI subsystem
Add a struct for tracking statistics
Add scmi_log_stats op/no-op function for incrementing statistics

Signed-off-by: Luke Parkin <luke.parkin@arm.com>
v1->v2
Config option now depends on DEBUG_FS
Add scmi_log_stats rather than if(IS_ENABLED)
Move location of scmi_debug_stats in the scmi_info struct
---
 drivers/firmware/arm_scmi/Kconfig  | 11 +++++++++++
 drivers/firmware/arm_scmi/common.h |  9 +++++++++
 drivers/firmware/arm_scmi/driver.c | 18 ++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index aa5842be19b2..45e8e7df927e 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -55,6 +55,17 @@ config ARM_SCMI_RAW_MODE_SUPPORT_COEX
 	  operate normally, thing which could make an SCMI test suite using the
 	  SCMI Raw mode support unreliable. If unsure, say N.
 
+config ARM_SCMI_DEBUG_STATISTICS
+	bool "Enable SCMI Raw mode statistic tracking"
+	select ARM_SCMI_NEED_DEBUGFS
+	depends on DEBUG_FS
+	help
+	  Enables statistic tracking for the SCMI subsystem.
+
+	  Enable this option to create a new debugfs directory which contains
+	  several useful statistics on various SCMI features. This can be useful
+	  for debugging and SCMI monitoring. If unsure, say N.
+
 config ARM_SCMI_HAVE_TRANSPORT
 	bool
 	help
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index b5ac25dbc1ca..1f50c4a209d7 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -301,6 +301,15 @@ extern const struct scmi_desc scmi_optee_desc;
 
 void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv);
 
+#ifdef CONFIG_ARM_SCMI_DEBUG_STATISTICS
+static inline void scmi_log_stats(atomic_t *atm)
+{
+	atomic_inc(atm);
+}
+#else
+static inline void scmi_log_stats(atomic_t *atm) {}
+#endif
+
 enum scmi_bad_msg {
 	MSG_UNEXPECTED = -1,
 	MSG_INVALID = -2,
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 56a93d20bf23..df3eb17cf439 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -125,6 +125,22 @@ struct scmi_debug_info {
 	bool is_atomic;
 };
 
+/**
+ * struct scmi_debug_stats - Debug statistics
+ * @sent_ok: Count of successful sends
+ * @sent_fail: Count of failed sends
+ * @response_ok: Count of successful responses
+ * @dlyd_response_ok: Count of successful delayed responses
+ * @xfers_response_timeout: Count of xfer response timeouts
+ */
+struct scmi_debug_stats {
+	atomic_t sent_ok;
+	atomic_t sent_fail;
+	atomic_t response_ok;
+	atomic_t dlyd_response_ok;
+	atomic_t xfers_response_timeout;
+};
+
 /**
  * struct scmi_info - Structure representing a SCMI instance
  *
@@ -161,6 +177,7 @@ struct scmi_debug_info {
  *		bus
  * @devreq_mtx: A mutex to serialize device creation for this SCMI instance
  * @dbg: A pointer to debugfs related data (if any)
+ * @stats: Contains several atomic_t's for tracking various statistics
  * @raw: An opaque reference handle used by SCMI Raw mode.
  */
 struct scmi_info {
@@ -187,6 +204,7 @@ struct scmi_info {
 	/* Serialize device creation process for this instance */
 	struct mutex devreq_mtx;
 	struct scmi_debug_info *dbg;
+	struct scmi_debug_stats stats;
 	void *raw;
 };
 
-- 
2.34.1


