Return-Path: <linux-kernel+bounces-236447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 340D391E273
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B437BB279A4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B693169ADA;
	Mon,  1 Jul 2024 14:29:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B8A16848A;
	Mon,  1 Jul 2024 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719844174; cv=none; b=HIQEjY8ayyFowbr1wRklFouMIJMIyGBOpdPnl8GLNGBBoegLmJI5eXtkpY9QuNpBi2SpCOdJFEBgCk/82s7DKU+Zsa/FPvway+LA+DEjunbJlw7VpM/xptjYSlSjAd6kDpAcHFoxPYozlpMPzDDq8UHb6Bd49lOALIrUguHOVTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719844174; c=relaxed/simple;
	bh=KnbCTh2kQyRbRrvFz2hnIOf9ZlZVQ3SBI8hzA4q53Rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Thhb4bhW1Fdf/rT4FtNJgdVilFIMvMK9yVZbkAe2F4PMqsOVgue9fLmN7PnAPS08eVW5d+TUn1XqgAOmhkRUGSAWaJBslrqOaSHay6O3yl/D6kBNlcV2ZaTZXznHWeEZabmnR+VO0kVF8ASO0KMAxOf2POGzwX6b5gBMKmg4yUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2A12339;
	Mon,  1 Jul 2024 07:29:55 -0700 (PDT)
Received: from thinkcentre-m93p.cambridge.arm.com (thinkcentre-m93p.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD7683F762;
	Mon,  1 Jul 2024 07:29:29 -0700 (PDT)
From: Luke Parkin <luke.parkin@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	Luke Parkin <luke.parkin@arm.com>
Subject: [PATCH 2/3] Track basic SCMI statistics
Date: Mon,  1 Jul 2024 15:28:50 +0100
Message-Id: <20240701142851.1448515-3-luke.parkin@arm.com>
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

Add scmi_debug_stats struct with atomic_t types to prevent racing.

Add tracking of 5 initial statistics
- sent_ok & sent_fail
- response_ok & dlyd_response_ok
- xfers_response_timeout

Signed-off-by: Luke Parkin <luke.parkin@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 46 +++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 6b6957f4743f..f69dff699d48 100644
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
@@ -141,6 +157,7 @@ struct scmi_debug_info {
  * @protocols: IDR for protocols' instance descriptors initialized for
  *	       this SCMI instance: populated on protocol's first attempted
  *	       usage.
+ * @stats: Contains several atomic_t's for tracking various statistics
  * @protocols_mtx: A mutex to protect protocols instances initialization.
  * @protocols_imp: List of protocols implemented, currently maximum of
  *		   scmi_revision_info.num_protocols elements allocated by the
@@ -174,6 +191,7 @@ struct scmi_info {
 	struct idr tx_idr;
 	struct idr rx_idr;
 	struct idr protocols;
+	struct scmi_debug_stats stats;
 	/* Ensure mutual exclusive access to protocols instance array */
 	struct mutex protocols_mtx;
 	u8 *protocols_imp;
@@ -1143,7 +1161,12 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 						SCMI_RAW_REPLY_QUEUE,
 						cinfo->id);
 	}
-
+	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_STATISTICS)) {
+		if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP)
+			atomic_inc(&info->stats.dlyd_response_ok);
+		else
+			atomic_inc(&info->stats.response_ok);
+	}
 	scmi_xfer_command_release(info, xfer);
 }
 
@@ -1279,6 +1302,12 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_STATISTICS) && ret == -ETIMEDOUT) {
+		struct scmi_info *info =
+					handle_to_scmi_info(cinfo->handle);
+		atomic_inc(&info->stats.xfers_response_timeout);
+	}
+
 	return ret;
 }
 
@@ -1414,6 +1443,13 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	trace_scmi_xfer_end(xfer->transfer_id, xfer->hdr.id,
 			    xfer->hdr.protocol_id, xfer->hdr.seq, ret);
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_STATISTICS)) {
+		if (ret == 0)
+			atomic_inc(&info->stats.sent_ok);
+		else
+			atomic_inc(&info->stats.sent_fail);
+	}
+
 	return ret;
 }
 
@@ -2994,6 +3030,14 @@ static int scmi_probe(struct platform_device *pdev)
 	handle->devm_protocol_get = scmi_devm_protocol_get;
 	handle->devm_protocol_put = scmi_devm_protocol_put;
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_STATISTICS)) {
+		atomic_set(&info->stats.response_ok, 0);
+		atomic_set(&info->stats.sent_fail, 0);
+		atomic_set(&info->stats.sent_ok, 0);
+		atomic_set(&info->stats.dlyd_response_ok, 0);
+		atomic_set(&info->stats.xfers_response_timeout, 0);
+	}
+
 	/* System wide atomic threshold for atomic ops .. if any */
 	if (!of_property_read_u32(np, "atomic-threshold-us",
 				  &info->atomic_threshold))
-- 
2.34.1


