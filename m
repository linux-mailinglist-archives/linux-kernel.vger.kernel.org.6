Return-Path: <linux-kernel+bounces-274701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9097947B9A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B611F23419
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A9715B96C;
	Mon,  5 Aug 2024 13:10:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FC715B10F;
	Mon,  5 Aug 2024 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863426; cv=none; b=DneGyF3zZ5Oa11ig7+yzEQQPF62EK0bMK3PkuQcxNwS/vr5zCXaOCBelP1314VRzoJ+ULZbnRxIq0q6YUwZsGWECG6Ze4EbRe3RmhNUirzYnHjpEVJcIsTGDubbEgI6lQgNwZrPsHprtLRcFMUHPJTL27+VWYgdldJNgVhv+YXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863426; c=relaxed/simple;
	bh=JLdFEuKuNZUKZ/LMElSgzXFfm+queRPCNHEVOJZ3m+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQt2kNba6gaSlsh/+p5Hbt3bb7SNTpYJc3LbaiaEkjxb2kaFnct7GWeZHHnfC1PUt+/DNiM2qxzkrlaW7YHHqHZzuKhwtlLCf4T3R12YPhWFsZMkxXPdYGQbgABNjRXoOGdpB1LBwVoXRZyuIaGfKybwwbw/3CafZ5vbt2H68wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 625D81474;
	Mon,  5 Aug 2024 06:10:50 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C9D323F5A1;
	Mon,  5 Aug 2024 06:10:23 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Luke Parkin <luke.parkin@arm.com>
Subject: [PATCH v5 4/5] firmware: arm_scmi: Create debugfs files for SCMI communication debug metrics
Date: Mon,  5 Aug 2024 14:10:11 +0100
Message-ID: <20240805131013.587016-5-sudeep.holla@arm.com>
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

Now that the basic support to collect the SCMI communication debug
metrics is in place, let us create debugfs files for the same so
that they are accessible to the users/debuggers.

Signed-off-by: Luke Parkin <luke.parkin@arm.com>
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 33 ++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 943ba03315de..ade32a67ab63 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2847,6 +2847,36 @@ static int scmi_device_request_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static const char * const dbg_counter_strs[] = {
+	"sent_ok",
+	"sent_fail",
+	"sent_fail_polling_unsupported",
+	"sent_fail_channel_not_found",
+	"response_ok",
+	"notification_ok",
+	"delayed_response_ok",
+	"xfers_response_timeout",
+	"xfers_response_polled_timeout",
+	"response_polled_ok",
+	"err_msg_unexpected",
+	"err_msg_invalid",
+	"err_msg_nomem",
+	"err_protocol",
+};
+
+static void scmi_debugfs_counters_setup(struct scmi_debug_info *dbg,
+					struct dentry *trans)
+{
+	struct dentry *counters;
+	int idx;
+
+	counters = debugfs_create_dir("counters", trans);
+
+	for (idx = 0; idx < SCMI_DEBUG_COUNTERS_LAST; idx++)
+		debugfs_create_atomic_t(dbg_counter_strs[idx], 0400, counters,
+					&dbg->counters[idx]);
+}
+
 static void scmi_debugfs_common_cleanup(void *d)
 {
 	struct scmi_debug_info *dbg = d;
@@ -2913,6 +2943,9 @@ static struct scmi_debug_info *scmi_debugfs_common_setup(struct scmi_info *info)
 	debugfs_create_u32("rx_max_msg", 0400, trans,
 			   (u32 *)&info->rx_minfo.max_msg);
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_COUNTERS))
+		scmi_debugfs_counters_setup(dbg, trans);
+
 	dbg->top_dentry = top_dentry;
 
 	if (devm_add_action_or_reset(info->dev,
-- 
2.46.0


