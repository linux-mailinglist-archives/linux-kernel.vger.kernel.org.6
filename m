Return-Path: <linux-kernel+bounces-252616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 820C69315EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1712842F6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAB518EA8F;
	Mon, 15 Jul 2024 13:38:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A45D18E74D;
	Mon, 15 Jul 2024 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050694; cv=none; b=VEQQlv50vTrd5YtIigEmfSG0xMh3yrcGfSaN9NFrrtRjG11F+ZbMIKWgq9BGu+VOHZeqoIINPMctyWYzHiNrOfxYVuEker6CzgGZ1Qeb9yUVi5kjiGSGPTlTsCqg1Lh9fO4KMPLJwfQV6oFjBTElol/dxud0SNGw2/2ZdW8sFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050694; c=relaxed/simple;
	bh=38W9XpvJ3IkrWRxld1xu0CaGHHvvmKJ3J37LE4kQ7aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hvgAEyN4RBxZ/Y+VgsTCLWjQ8EyL9hBq8LRxjIjlk+PtFvB+lsCUwYoeIG9FgK4Uv1VLFNUkUhTLbsxxmY0nvnMY9wDZT3k2JLbRfbJf5dhHdZ27oiofNLBsrW1CVvffUA9FjAGJTk32Q2ldQVeHCqU786vqjEgKbq62DYp12kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 169E7FEC;
	Mon, 15 Jul 2024 06:38:38 -0700 (PDT)
Received: from thinkcentre-m93p.cambridge.arm.com (thinkcentre-m93p.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB8D03F73F;
	Mon, 15 Jul 2024 06:38:11 -0700 (PDT)
From: Luke Parkin <luke.parkin@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	Luke Parkin <luke.parkin@arm.com>
Subject: [PATCH v3 4/5] firmware: arm_scmi: Create debugfs files for statistics
Date: Mon, 15 Jul 2024 14:37:50 +0100
Message-Id: <20240715133751.2877197-5-luke.parkin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715133751.2877197-1-luke.parkin@arm.com>
References: <20240715133751.2877197-1-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create debugfs files for the statistics in the scmi_debug_stats struct

Signed-off-by: Luke Parkin <luke.parkin@arm.com>
v2->v3
Add extra statistics also added in v3
v1->v2
Only create stats pointer if stats are enabled
Move stats debugfs creation into a seperate helper function
---
 drivers/firmware/arm_scmi/driver.c | 38 ++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index b22f104cda36..9378e2d8af4f 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2865,6 +2865,41 @@ static int scmi_device_request_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static void scmi_debugfs_stats_setup(struct scmi_info *info,
+				     struct dentry *trans)
+{
+	struct dentry *stats;
+
+	stats = debugfs_create_dir("stats", trans);
+
+	debugfs_create_atomic_t("sent_ok", 0400, stats,
+				&info->dbg_stats[SENT_OK]);
+	debugfs_create_atomic_t("sent_fail", 0400, stats,
+				&info->dbg_stats[SENT_FAIL]);
+	debugfs_create_atomic_t("sent_fail_polling_unsupported", 0400, stats,
+				&info->dbg_stats[SENT_FAIL_POLLING_UNSUPPORTED]);
+	debugfs_create_atomic_t("sent_fail_channel_not_found", 0400, stats,
+				&info->dbg_stats[SENT_FAIL_CHANNEL_NOT_FOUND]);
+	debugfs_create_atomic_t("response_ok", 0400, stats,
+				&info->dbg_stats[RESPONSE_OK]);
+	debugfs_create_atomic_t("notif_ok", 0400, stats,
+				&info->dbg_stats[NOTIF_OK]);
+	debugfs_create_atomic_t("dlyd_resp_ok", 0400, stats,
+				&info->dbg_stats[DLYD_RESPONSE_OK]);
+	debugfs_create_atomic_t("xfers_resp_timeout", 0400, stats,
+				&info->dbg_stats[XFERS_RESPONSE_TIMEOUT]);
+	debugfs_create_atomic_t("response_polled_ok", 0400, stats,
+				&info->dbg_stats[RESPONSE_POLLED_OK]);
+	debugfs_create_atomic_t("err_msg_unexpected", 0400, stats,
+				&info->dbg_stats[ERR_MSG_UNEXPECTED]);
+	debugfs_create_atomic_t("err_msg_invalid", 0400, stats,
+				&info->dbg_stats[ERR_MSG_INVALID]);
+	debugfs_create_atomic_t("err_msg_nomem", 0400, stats,
+				&info->dbg_stats[ERR_MSG_NOMEM]);
+	debugfs_create_atomic_t("err_protocol", 0400, stats,
+				&info->dbg_stats[ERR_PROTOCOL]);
+}
+
 static void scmi_debugfs_common_cleanup(void *d)
 {
 	struct scmi_debug_info *dbg = d;
@@ -2931,6 +2966,9 @@ static struct scmi_debug_info *scmi_debugfs_common_setup(struct scmi_info *info)
 	debugfs_create_u32("rx_max_msg", 0400, trans,
 			   (u32 *)&info->rx_minfo.max_msg);
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_STATISTICS))
+		scmi_debugfs_stats_setup(info, trans);
+
 	dbg->top_dentry = top_dentry;
 
 	if (devm_add_action_or_reset(info->dev,
-- 
2.34.1


