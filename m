Return-Path: <linux-kernel+bounces-267168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011F6940DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E62A9B27EB6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38C419D88A;
	Tue, 30 Jul 2024 09:33:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1D9195F1B;
	Tue, 30 Jul 2024 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332039; cv=none; b=FF9L9zknLFv3QkpTfUmomQX1J2EeX7Gzo8l8/8MVGVo4QwhBYlphWHd9H+rQP9bvMLRx/YWxXPIrUZ5djX8XoLn/fAwOvHm9EjzGDl6BAhzkw8jo/wQcPvoglRE6uBRxSyV1vZ3a5jtInAeM5552tjwjKL5+L7k02IBJsIPwObg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332039; c=relaxed/simple;
	bh=TJPENER+B2Jz4m32spSDSEAwTA4y6ADJgEabTovBD50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sbTjDtRKKfaetJ2pz4RfZ/OQeOafmW0SAB/7CZW5Ec7kqeuOhUshr4txJL9KDExNbM9VqHc8ZRlX7K5Di+3QOyyd2hpCdIG80Ycrji1R/36t1H6W61nBbHYP164aEqb9zKgV0o9xbCnIic2+4tK1P8A0inFt63FW59wcer/QDTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CF93168F;
	Tue, 30 Jul 2024 02:34:23 -0700 (PDT)
Received: from thinkcentre-m93p.cambridge.arm.com (thinkcentre-m93p.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D41D3F5A1;
	Tue, 30 Jul 2024 02:33:56 -0700 (PDT)
From: Luke Parkin <luke.parkin@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	Luke Parkin <luke.parkin@arm.com>
Subject: [PATCH v4 5/5] firmware: arm_scmi: Reset counters
Date: Tue, 30 Jul 2024 10:33:42 +0100
Message-Id: <20240730093342.3558162-6-luke.parkin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730093342.3558162-1-luke.parkin@arm.com>
References: <20240730093342.3558162-1-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow writing to atomics to reset
Create reset_all counters debugfs file to reset all counters

Signed-off-by: Luke Parkin <luke.parkin@arm.com>
---
v3->v4
Use basic writing to allow any number to be set rather than forcing
	a set to 0
---
 drivers/firmware/arm_scmi/driver.c | 45 +++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index ec6434692d1a..9e8720c27d51 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2847,6 +2847,24 @@ static int scmi_device_request_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static ssize_t reset_all_on_write(struct file *filp, const char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	struct scmi_debug_info *dbg = filp->private_data;
+
+	for (int i = 0; i < SCMI_DEBUG_COUNTERS_LAST; i++)
+		atomic_set(&dbg->counters[i], 0);
+
+	return count;
+}
+
+static const struct file_operations fops_reset_counts = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.llseek = no_llseek,
+	.write = reset_all_on_write,
+};
+
 static void scmi_debugfs_counters_setup(struct scmi_debug_info *dbg,
 					struct dentry *trans)
 {
@@ -2854,32 +2872,33 @@ static void scmi_debugfs_counters_setup(struct scmi_debug_info *dbg,
 
 	counters = debugfs_create_dir("counters", trans);
 
-	debugfs_create_atomic_t("sent_ok", 0400, counters,
+	debugfs_create_atomic_t("sent_ok", 0600, counters,
 				&dbg->counters[SENT_OK]);
-	debugfs_create_atomic_t("sent_fail", 0400, counters,
+	debugfs_create_atomic_t("sent_fail", 0600, counters,
 				&dbg->counters[SENT_FAIL]);
-	debugfs_create_atomic_t("sent_fail_polling_unsupported", 0400, counters,
+	debugfs_create_atomic_t("sent_fail_polling_unsupported", 0600, counters,
 				&dbg->counters[SENT_FAIL_POLLING_UNSUPPORTED]);
-	debugfs_create_atomic_t("sent_fail_channel_not_found", 0400, counters,
+	debugfs_create_atomic_t("sent_fail_channel_not_found", 0600, counters,
 				&dbg->counters[SENT_FAIL_CHANNEL_NOT_FOUND]);
-	debugfs_create_atomic_t("response_ok", 0400, counters,
+	debugfs_create_atomic_t("response_ok", 0600, counters,
 				&dbg->counters[RESPONSE_OK]);
-	debugfs_create_atomic_t("notif_ok", 0400, counters,
+	debugfs_create_atomic_t("notif_ok", 0600, counters,
 				&dbg->counters[NOTIF_OK]);
-	debugfs_create_atomic_t("dlyd_resp_ok", 0400, counters,
+	debugfs_create_atomic_t("dlyd_resp_ok", 0600, counters,
 				&dbg->counters[DLYD_RESPONSE_OK]);
-	debugfs_create_atomic_t("xfers_resp_timeout", 0400, counters,
+	debugfs_create_atomic_t("xfers_resp_timeout", 0600, counters,
 				&dbg->counters[XFERS_RESPONSE_TIMEOUT]);
-	debugfs_create_atomic_t("response_polled_ok", 0400, counters,
+	debugfs_create_atomic_t("response_polled_ok", 0600, counters,
 				&dbg->counters[RESPONSE_POLLED_OK]);
-	debugfs_create_atomic_t("err_msg_unexpected", 0400, counters,
+	debugfs_create_atomic_t("err_msg_unexpected", 0600, counters,
 				&dbg->counters[ERR_MSG_UNEXPECTED]);
-	debugfs_create_atomic_t("err_msg_invalid", 0400, counters,
+	debugfs_create_atomic_t("err_msg_invalid", 0600, counters,
 				&dbg->counters[ERR_MSG_INVALID]);
-	debugfs_create_atomic_t("err_msg_nomem", 0400, counters,
+	debugfs_create_atomic_t("err_msg_nomem", 0600, counters,
 				&dbg->counters[ERR_MSG_NOMEM]);
-	debugfs_create_atomic_t("err_protocol", 0400, counters,
+	debugfs_create_atomic_t("err_protocol", 0600, counters,
 				&dbg->counters[ERR_PROTOCOL]);
+	debugfs_create_file("reset", 0200, counters, dbg, &fops_reset_counts);
 }
 
 static void scmi_debugfs_common_cleanup(void *d)
-- 
2.34.1


