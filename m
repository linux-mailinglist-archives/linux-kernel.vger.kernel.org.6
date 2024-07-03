Return-Path: <linux-kernel+bounces-239657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD15A9263A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2000B28D98
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A856E180A68;
	Wed,  3 Jul 2024 14:38:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6244F17DA3E;
	Wed,  3 Jul 2024 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017518; cv=none; b=EY7BfnRpHDNxBbCiYm5ov973pqF9NlKKg8jKIpwMgJoODW0TSdkSqAEY2E6ZLB2oiBTg+RWzS//DlEXnfKaPfN+x5Rz6QPLbYjExGBY16An9yYrGjJwmml5v4b6yo/Nq6gA1kgoq7J1e0brlSMQ2LiDmVIiWwDM+laP8F83/Ho8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017518; c=relaxed/simple;
	bh=1pyvTHvgPYCtPb4G+O/6/6OTk21US0vpzPZTUyPuZZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PQ64HsEnbgfxC7pV96DLsGG47yD08OK2OeOIC619vj7eBJiDm/AAPcBMtOpaJlRO+fSu67yWKcDk3yzg+WKqtHifUQG0reW2TyxwF8I+4mK8Wfb9O9DUD9P6OsIcPzsVwX2j2HdHnJh5FpKeOh1mDsk3hRniSREmmrYTq32xZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 040BF1688;
	Wed,  3 Jul 2024 07:39:01 -0700 (PDT)
Received: from thinkcentre-m93p.cambridge.arm.com (thinkcentre-m93p.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 245DB3F766;
	Wed,  3 Jul 2024 07:38:35 -0700 (PDT)
From: Luke Parkin <luke.parkin@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	Luke Parkin <luke.parkin@arm.com>
Subject: [PATCH v2 4/4] firmware: arm_scmi: Create debugfs files for statistics
Date: Wed,  3 Jul 2024 15:37:38 +0100
Message-Id: <20240703143738.2007457-5-luke.parkin@arm.com>
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

Create debugfs files for the statistics in the scmi_debug_stats struct

Signed-off-by: Luke Parkin <luke.parkin@arm.com>
v1->v2
Only create stats pointer if stats are enabled
Move stats debugfs creation into a seperate helper function
---
 drivers/firmware/arm_scmi/driver.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 937546397cf2..10cd9a319ffb 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2858,6 +2858,24 @@ static int scmi_device_request_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static void scmi_debugfs_stats_setup(struct scmi_info *info,
+				     struct dentry *trans)
+{
+	struct dentry *stats;
+
+	stats = debugfs_create_dir("stats", trans);
+	debugfs_create_atomic_t("response_ok", 0400, stats,
+				&info->stats.response_ok);
+	debugfs_create_atomic_t("dlyd_response_ok", 0400, stats,
+				&info->stats.dlyd_response_ok);
+	debugfs_create_atomic_t("sent_ok", 0400, stats,
+				&info->stats.sent_ok);
+	debugfs_create_atomic_t("sent_fail", 0400, stats,
+				&info->stats.sent_fail);
+	debugfs_create_atomic_t("xfers_response_timeout", 0400, stats,
+				&info->stats.xfers_response_timeout);
+}
+
 static void scmi_debugfs_common_cleanup(void *d)
 {
 	struct scmi_debug_info *dbg = d;
@@ -2924,6 +2942,9 @@ static struct scmi_debug_info *scmi_debugfs_common_setup(struct scmi_info *info)
 	debugfs_create_u32("rx_max_msg", 0400, trans,
 			   (u32 *)&info->rx_minfo.max_msg);
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_STATISTICS))
+		scmi_debugfs_stats_setup(info, trans);
+
 	dbg->top_dentry = top_dentry;
 
 	if (devm_add_action_or_reset(info->dev,
-- 
2.34.1


