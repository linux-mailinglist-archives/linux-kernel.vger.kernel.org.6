Return-Path: <linux-kernel+bounces-239656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81880926397
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37D61C219A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ABC17E8F8;
	Wed,  3 Jul 2024 14:38:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA83617C237;
	Wed,  3 Jul 2024 14:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017517; cv=none; b=P5AG+LlloPhLo2ZFwW8yEZyjEXTcd7agpNdlxDMDos2DTg2oZ59kHyHrXKZ9zktv0gEaXeZVvoq4dlqPawwF63Vah9EGS1Loy+wzijJkisqsJnk9uxZ0fJjpW+MRvAC9afOosV/IadyCsoBYWuNlo05g3GHZwY+ZAkTUOvAxH9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017517; c=relaxed/simple;
	bh=0opBgfznT6wfL/z88iog+TIcqkkfL4b4o6bWKh2z4PA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rybwLm2ZIxwOzeFIsQ6fvSkZNEgFp5e9onzXV7K76zutdEpD/9WZFTRx3sLQPpiiYOWU8+SSFDs6fZ2zHNT3I3N/HCUoES6s7vlgLY1mJPXOYRzllA1pRuQL7Xx8kz7EsO2x9m9uxtvMRfrTEd4/jhV8OrYdM554rURkPXzASyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50DCB1007;
	Wed,  3 Jul 2024 07:38:59 -0700 (PDT)
Received: from thinkcentre-m93p.cambridge.arm.com (thinkcentre-m93p.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70EC83F766;
	Wed,  3 Jul 2024 07:38:33 -0700 (PDT)
From: Luke Parkin <luke.parkin@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	Luke Parkin <luke.parkin@arm.com>
Subject: [PATCH v2 3/4] firmware: arm_scmi: Track basic SCMI statistics
Date: Wed,  3 Jul 2024 15:37:37 +0100
Message-Id: <20240703143738.2007457-4-luke.parkin@arm.com>
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

Add tracking of 5 initial statistics

Signed-off-by: Luke Parkin <luke.parkin@arm.com>
V1->V2
Drop unneccesary atomic_set's
Use new 'scmi_log_stats' to simplify incrementing of atomics
Move scmi_log_stats to locations which mean no extra conditionals
	are needed
---
 drivers/firmware/arm_scmi/driver.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index df3eb17cf439..937546397cf2 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1146,8 +1146,10 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 	if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP) {
 		scmi_clear_channel(info, cinfo);
 		complete(xfer->async_done);
+		scmi_log_stats(&info->stats.dlyd_response_ok);
 	} else {
 		complete(&xfer->done);
+		scmi_log_stats(&info->stats.response_ok);
 	}
 
 	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
@@ -1231,6 +1233,7 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 			       struct scmi_xfer *xfer, unsigned int timeout_ms)
 {
 	int ret = 0;
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
 
 	if (xfer->hdr.poll_completion) {
 		/*
@@ -1251,13 +1254,12 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 					"timed out in resp(caller: %pS) - polling\n",
 					(void *)_RET_IP_);
 				ret = -ETIMEDOUT;
+				scmi_log_stats(&info->stats.xfers_response_timeout);
 			}
 		}
 
 		if (!ret) {
 			unsigned long flags;
-			struct scmi_info *info =
-				handle_to_scmi_info(cinfo->handle);
 
 			/*
 			 * Do not fetch_response if an out-of-order delayed
@@ -1291,6 +1293,7 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 			dev_err(dev, "timed out in resp(caller: %pS)\n",
 				(void *)_RET_IP_);
 			ret = -ETIMEDOUT;
+			scmi_log_stats(&info->stats.xfers_response_timeout);
 		}
 	}
 
@@ -1374,13 +1377,15 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	    !is_transport_polling_capable(info->desc)) {
 		dev_warn_once(dev,
 			      "Polling mode is not supported by transport.\n");
+		scmi_log_stats(&info->stats.sent_fail);
 		return -EINVAL;
 	}
 
 	cinfo = idr_find(&info->tx_idr, pi->proto->id);
-	if (unlikely(!cinfo))
+	if (unlikely(!cinfo)) {
+		scmi_log_stats(&info->stats.sent_fail);
 		return -EINVAL;
-
+	}
 	/* True ONLY if also supported by transport. */
 	if (is_polling_enabled(cinfo, info->desc))
 		xfer->hdr.poll_completion = true;
@@ -1412,6 +1417,7 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	ret = info->desc->ops->send_message(cinfo, xfer);
 	if (ret < 0) {
 		dev_dbg(dev, "Failed to send message %d\n", ret);
+		scmi_log_stats(&info->stats.sent_fail);
 		return ret;
 	}
 
@@ -1420,8 +1426,12 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 			    xfer->hdr.status, xfer->tx.buf, xfer->tx.len);
 
 	ret = scmi_wait_for_message_response(cinfo, xfer);
-	if (!ret && xfer->hdr.status)
+	if (!ret && xfer->hdr.status) {
 		ret = scmi_to_linux_errno(xfer->hdr.status);
+		scmi_log_stats(&info->stats.sent_fail);
+	} else {
+		scmi_log_stats(&info->stats.sent_ok);
+	}
 
 	if (info->desc->ops->mark_txdone)
 		info->desc->ops->mark_txdone(cinfo, ret, xfer);
-- 
2.34.1


