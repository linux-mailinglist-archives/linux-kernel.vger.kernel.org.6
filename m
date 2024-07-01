Return-Path: <linux-kernel+bounces-236448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AF291E274
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB9A28362E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C70216A950;
	Mon,  1 Jul 2024 14:29:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3421684BD;
	Mon,  1 Jul 2024 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719844175; cv=none; b=AXpo4T3qDSMwkVhhTM+sOlPWpawz7DtXGl1g00sPsxmLc7EamjM3b8kbKIcIUW9pOc9HValpLzNRmYABMCNqclwjVLHOHeZ7aNwFTrd5jd3PclJbcSjykLMvu2DSKqHNYwnbHLgzpPU6JdYXwVm/ZVgI7LegzRmhOInFGCqwAZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719844175; c=relaxed/simple;
	bh=RaUcUsCsJULxcj53PVFIPVEf5NAcdvwQU8sNh4SOEJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FnAvgqylNzuUWycsVm1PSQ7WykYneb7oL/haBbpPe9QSQn+87U+Qki+9jaG+HfW3zA3t7lo9xgui4GAO14iwnEw1rgJA3pu6vUqdpHrw3UYUbfB1Cij6s24UuHRrB2WQwfWGbWBYbeqWDf7ytUcwQDgNrbh6oxqOE/rQDpwTcMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB64F367;
	Mon,  1 Jul 2024 07:29:57 -0700 (PDT)
Received: from thinkcentre-m93p.cambridge.arm.com (thinkcentre-m93p.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 214883F762;
	Mon,  1 Jul 2024 07:29:32 -0700 (PDT)
From: Luke Parkin <luke.parkin@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	Luke Parkin <luke.parkin@arm.com>
Subject: [PATCH 3/3] Create debugfs files for statistics
Date: Mon,  1 Jul 2024 15:28:51 +0100
Message-Id: <20240701142851.1448515-4-luke.parkin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701142851.1448515-1-luke.parkin@arm.com>
References: <20240701142851.1448515-1-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create debugfs files for the statistics in the scmi_debug_stats struct

Signed-off-by: Luke Parkin <luke.parkin@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index f69dff699d48..509ea42d17bf 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2884,7 +2884,7 @@ static void scmi_debugfs_common_cleanup(void *d)
 static struct scmi_debug_info *scmi_debugfs_common_setup(struct scmi_info *info)
 {
 	char top_dir[16];
-	struct dentry *trans, *top_dentry;
+	struct dentry *trans, *top_dentry, *stats;
 	struct scmi_debug_info *dbg;
 	const char *c_ptr = NULL;
 
@@ -2935,6 +2935,19 @@ static struct scmi_debug_info *scmi_debugfs_common_setup(struct scmi_info *info)
 	debugfs_create_u32("rx_max_msg", 0400, trans,
 			   (u32 *)&info->rx_minfo.max_msg);
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_STATISTICS)) {
+		stats = debugfs_create_dir("stats", trans);
+		debugfs_create_atomic_t("response_ok", 0400, stats,
+					&info->stats.response_ok);
+		debugfs_create_atomic_t("dlyd_response_ok", 0400, stats,
+					&info->stats.dlyd_response_ok);
+		debugfs_create_atomic_t("sent_ok", 0400, stats,
+					&info->stats.sent_ok);
+		debugfs_create_atomic_t("sent_fail", 0400, stats,
+					&info->stats.sent_fail);
+		debugfs_create_atomic_t("xfers_response_timeout", 0400, stats,
+					&info->stats.xfers_response_timeout);
+	}
 	dbg->top_dentry = top_dentry;
 
 	if (devm_add_action_or_reset(info->dev,
-- 
2.34.1


