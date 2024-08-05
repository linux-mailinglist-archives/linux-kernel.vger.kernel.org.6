Return-Path: <linux-kernel+bounces-274703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FDD947B9C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E441F23372
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD5015C15A;
	Mon,  5 Aug 2024 13:10:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6A815B104;
	Mon,  5 Aug 2024 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863428; cv=none; b=sSYpMG8whLV7wybRqWSw4jnhqjl4zBJQ/C66mgdiyhbZ4Kq8SSPcuRP9zYUFtFTLTJ5vOq7HAvtrLUZ6foh8WkxpUl2wzXEpfCtcv344sOj4lWtZ6qwzjHo0zDWHosgY9E30XxrbtXSaRZ2PcmmM+n/6yJlfbD2pwYbI/i8B6EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863428; c=relaxed/simple;
	bh=X8XPp8bcUgR2UZaLcygJarmXYBYzlmio5PZaLOZMW84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSQFnwe8MVYGKYmzQbKUBWyUggm61ytA9nyzI7n7Fd9PLBbYAI3/jAslK/geu0ldo1p+uprrqIp0e6Xehgm0KY8mL/UrwExljoD24Z3SPh/gIT5/kkYHkWbM+DGKqFDmpf+b890zoZWrsAEivXG5gCF3PzMd46flkn/5CWEXu+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C24D1143D;
	Mon,  5 Aug 2024 06:10:51 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DC4AD3F5A1;
	Mon,  5 Aug 2024 06:10:24 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Luke Parkin <luke.parkin@arm.com>
Subject: [PATCH v5 5/5] firmware: arm_scmi: Add support to reset the debug metrics
Date: Mon,  5 Aug 2024 14:10:12 +0100
Message-ID: <20240805131013.587016-6-sudeep.holla@arm.com>
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

It is sometimes useful to reset all these SCMI communication debug
metrics especially when we are interested in analysing these metrics
during a particular workload or for a fixed time duration. Let us
add the capability to reset all these metrics as once so that they
can be counted during the period of interest.

Signed-off-by: Luke Parkin <luke.parkin@arm.com>
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index ade32a67ab63..ca910079d718 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2864,6 +2864,24 @@ static const char * const dbg_counter_strs[] = {
 	"err_protocol",
 };
 
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
@@ -2873,8 +2891,10 @@ static void scmi_debugfs_counters_setup(struct scmi_debug_info *dbg,
 	counters = debugfs_create_dir("counters", trans);
 
 	for (idx = 0; idx < SCMI_DEBUG_COUNTERS_LAST; idx++)
-		debugfs_create_atomic_t(dbg_counter_strs[idx], 0400, counters,
+		debugfs_create_atomic_t(dbg_counter_strs[idx], 0600, counters,
 					&dbg->counters[idx]);
+
+	debugfs_create_file("reset", 0200, counters, dbg, &fops_reset_counts);
 }
 
 static void scmi_debugfs_common_cleanup(void *d)
-- 
2.46.0


