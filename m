Return-Path: <linux-kernel+bounces-252617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A079315EB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8371F22B49
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8782418EFD9;
	Mon, 15 Jul 2024 13:38:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4539A18EA94;
	Mon, 15 Jul 2024 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050697; cv=none; b=Gu/33M6juqRLI3Jmi6+FI5tf7zThCydNLstQ7rTiZgjmSIBP1W2My2Fm04tSShV1IYaUxmf2LJEXv5XnQ0lPN/mhpXJNF8cfXl4K9hxAm7VNKGFN0QaAOfkKP9FFACoDsw8j5+OwLYOofGoZQmHuIneTUHLlvpv6B25H51rlZsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050697; c=relaxed/simple;
	bh=jM8LP7FXhR80SsDLNs2eNIiSfrLcOdG/CcG7rYcZWbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z1VNJy4btmxJ1bkcedCvbjBMs4ImUIAmIuyJ2b+czakN6WZanXWwF/qi2Z+5AKZX10Dhj+YGaI/YzWIugbzPuT7BpcS3W4k1EfVQkE5yMJOsbKx/iUlPyNNM+t9xD/eTd+lPaiH+31eqMzmUAwPWior3YbsjNRT/iX6C63q/r70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DABCDA7;
	Mon, 15 Jul 2024 06:38:40 -0700 (PDT)
Received: from thinkcentre-m93p.cambridge.arm.com (thinkcentre-m93p.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2DBA3F73F;
	Mon, 15 Jul 2024 06:38:13 -0700 (PDT)
From: Luke Parkin <luke.parkin@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	Luke Parkin <luke.parkin@arm.com>
Subject: [PATCH v3 5/5] firmware: arm_scmi: Reset statistics
Date: Mon, 15 Jul 2024 14:37:51 +0100
Message-Id: <20240715133751.2877197-6-luke.parkin@arm.com>
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

Create write function to reset individual statistics on write
Create reset_all stats debugfs file to reset all statistics

Signed-off-by: Luke Parkin <luke.parkin@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 104 +++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 26 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 9378e2d8af4f..6a90311f764d 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2865,6 +2865,47 @@ static int scmi_device_request_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static int read_atomic(void *atomic, u64 *val)
+{
+	atomic_t *atm = (atomic_t *)atomic;
+
+	*val = atomic_read(atm);
+	return 0;
+}
+
+static int reset_single(void *atomic, u64 val)
+{
+	atomic_t *atm = (atomic_t *)atomic;
+
+	atomic_set(atm, 0);
+	return 0;
+}
+
+static void reset_all_stats(struct scmi_info *info)
+{
+	for (int i = 0; i < LAST; i++)
+		atomic_set(&info->dbg_stats[i], 0);
+}
+
+static ssize_t reset_all_on_write(struct file *filp,
+				  const char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	struct scmi_info *info = filp->private_data;
+
+	reset_all_stats(info);
+	return count;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_reset_on_write, read_atomic, reset_single, "%llu\n");
+
+static const struct file_operations fops_reset_stats = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.llseek = no_llseek,
+	.write = reset_all_on_write,
+};
+
 static void scmi_debugfs_stats_setup(struct scmi_info *info,
 				     struct dentry *trans)
 {
@@ -2872,32 +2913,43 @@ static void scmi_debugfs_stats_setup(struct scmi_info *info,
 
 	stats = debugfs_create_dir("stats", trans);
 
-	debugfs_create_atomic_t("sent_ok", 0400, stats,
-				&info->dbg_stats[SENT_OK]);
-	debugfs_create_atomic_t("sent_fail", 0400, stats,
-				&info->dbg_stats[SENT_FAIL]);
-	debugfs_create_atomic_t("sent_fail_polling_unsupported", 0400, stats,
-				&info->dbg_stats[SENT_FAIL_POLLING_UNSUPPORTED]);
-	debugfs_create_atomic_t("sent_fail_channel_not_found", 0400, stats,
-				&info->dbg_stats[SENT_FAIL_CHANNEL_NOT_FOUND]);
-	debugfs_create_atomic_t("response_ok", 0400, stats,
-				&info->dbg_stats[RESPONSE_OK]);
-	debugfs_create_atomic_t("notif_ok", 0400, stats,
-				&info->dbg_stats[NOTIF_OK]);
-	debugfs_create_atomic_t("dlyd_resp_ok", 0400, stats,
-				&info->dbg_stats[DLYD_RESPONSE_OK]);
-	debugfs_create_atomic_t("xfers_resp_timeout", 0400, stats,
-				&info->dbg_stats[XFERS_RESPONSE_TIMEOUT]);
-	debugfs_create_atomic_t("response_polled_ok", 0400, stats,
-				&info->dbg_stats[RESPONSE_POLLED_OK]);
-	debugfs_create_atomic_t("err_msg_unexpected", 0400, stats,
-				&info->dbg_stats[ERR_MSG_UNEXPECTED]);
-	debugfs_create_atomic_t("err_msg_invalid", 0400, stats,
-				&info->dbg_stats[ERR_MSG_INVALID]);
-	debugfs_create_atomic_t("err_msg_nomem", 0400, stats,
-				&info->dbg_stats[ERR_MSG_NOMEM]);
-	debugfs_create_atomic_t("err_protocol", 0400, stats,
-				&info->dbg_stats[ERR_PROTOCOL]);
+	debugfs_create_file("sent_ok", 0400, stats, &info->dbg_stats[SENT_OK],
+			    &fops_reset_on_write);
+	debugfs_create_file("sent_fail", 0400, stats,
+			    &info->dbg_stats[SENT_FAIL], &fops_reset_on_write);
+	debugfs_create_file("sent_fail_polling_unsupported", 0400, stats,
+			    &info->dbg_stats[SENT_FAIL_POLLING_UNSUPPORTED],
+			    &fops_reset_on_write);
+	debugfs_create_file("sent_fail_channel_not_found", 0400, stats,
+			    &info->dbg_stats[SENT_FAIL_CHANNEL_NOT_FOUND],
+			    &fops_reset_on_write);
+	debugfs_create_file("response_ok", 0400, stats,
+			    &info->dbg_stats[RESPONSE_OK],
+			    &fops_reset_on_write);
+	debugfs_create_file("notif_ok", 0400, stats, &info->dbg_stats[NOTIF_OK],
+			    &fops_reset_on_write);
+	debugfs_create_file("dlyd_resp_ok", 0400, stats,
+			    &info->dbg_stats[DLYD_RESPONSE_OK],
+			    &fops_reset_on_write);
+	debugfs_create_file("xfers_resp_timeout", 0400, stats,
+			    &info->dbg_stats[XFERS_RESPONSE_TIMEOUT],
+			    &fops_reset_on_write);
+	debugfs_create_file("response_polled_ok", 0400, stats,
+			    &info->dbg_stats[RESPONSE_POLLED_OK],
+			    &fops_reset_on_write);
+	debugfs_create_file("err_msg_unexpected", 0400, stats,
+			    &info->dbg_stats[ERR_MSG_UNEXPECTED],
+			    &fops_reset_on_write);
+	debugfs_create_file("err_msg_invalid", 0400, stats,
+			    &info->dbg_stats[ERR_MSG_INVALID],
+			    &fops_reset_on_write);
+	debugfs_create_file("err_msg_nomem", 0400, stats,
+			    &info->dbg_stats[ERR_MSG_NOMEM],
+			    &fops_reset_on_write);
+	debugfs_create_file("err_protocol", 0400, stats,
+			    &info->dbg_stats[ERR_PROTOCOL],
+			    &fops_reset_on_write);
+	debugfs_create_file("reset", 0200, stats, info, &fops_reset_stats);
 }
 
 static void scmi_debugfs_common_cleanup(void *d)
-- 
2.34.1


