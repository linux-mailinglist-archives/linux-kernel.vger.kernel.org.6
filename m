Return-Path: <linux-kernel+bounces-252615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 244A99315E9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C6E1F2338A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42D618EA72;
	Mon, 15 Jul 2024 13:38:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C1D18E74C;
	Mon, 15 Jul 2024 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050693; cv=none; b=PKh3QtsyelB0exbPYvRsMJZ8aX1mxD1bIDMiPIfQiFNm/J8iAGTBAeWnNtWtO+aNX7UFwWMRJY3J2wFw0oLhvs+ZafI0b9vD8bDDgUsGljjr40lH+vHjKaxoWHs8YE08Fmkga4bhS58HbuRvwbqayQJC1FFAdaNspIo2KHeeLgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050693; c=relaxed/simple;
	bh=OPCGX5PnpXMJUGtF9e9JQoxpCoiD9hRvDhJq11Z6vUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e6FWRc1U+7ibMjX6f9zqymzqbgCMcokQz6i6DIHrVlQF5ryJWaIGjl49FfhHjO/4wjjI5yhCy4bGWdCVnid2ZcIsLdJhUcf3UaehNoYIR0EUQ6sRY/EmfbuhGcFTRhZfKcbnSD3jjo1i7P0QY8W/PN/Xz1kNFyl5ridUm2WE7ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D2B4DA7;
	Mon, 15 Jul 2024 06:38:36 -0700 (PDT)
Received: from thinkcentre-m93p.cambridge.arm.com (thinkcentre-m93p.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2B793F73F;
	Mon, 15 Jul 2024 06:38:09 -0700 (PDT)
From: Luke Parkin <luke.parkin@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	Luke Parkin <luke.parkin@arm.com>
Subject: [PATCH v3 3/5] firmware: arm_scmi: Track basic SCMI statistics
Date: Mon, 15 Jul 2024 14:37:49 +0100
Message-Id: <20240715133751.2877197-4-luke.parkin@arm.com>
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

Add tracking of initial statistics

Signed-off-by: Luke Parkin <luke.parkin@arm.com>
---
V2->V3
Add more statistics
Use new log_stats method.
V1->V2
Drop unneccesary atomic_set's
Use new 'scmi_log_stats' to simplify incrementing of atomics
Move scmi_log_stats to locations which mean no extra conditionals
	are needed
---
 drivers/firmware/arm_scmi/driver.c | 39 ++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 6edec6ec912d..b22f104cda36 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -126,6 +126,20 @@ struct scmi_debug_info {
 };
 
 enum debug_stat_counters {
+	SENT_OK,
+	SENT_FAIL,
+	SENT_FAIL_POLLING_UNSUPPORTED,
+	SENT_FAIL_CHANNEL_NOT_FOUND,
+	RESPONSE_OK,
+	NOTIF_OK,
+	DLYD_RESPONSE_OK,
+	XFERS_RESPONSE_TIMEOUT,
+	XFERS_RESPONSE_POLLED_TIMEOUT,
+	RESPONSE_POLLED_OK,
+	ERR_MSG_UNEXPECTED,
+	ERR_MSG_INVALID,
+	ERR_MSG_NOMEM,
+	ERR_PROTOCOL,
 	LAST
 };
 
@@ -994,6 +1008,7 @@ scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
 		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
 
 		scmi_bad_message_trace(cinfo, msg_hdr, MSG_UNEXPECTED);
+		scmi_log_stats(info->dbg_stats, ERR_MSG_UNEXPECTED);
 
 		return xfer;
 	}
@@ -1021,6 +1036,8 @@ scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
 			msg_type, xfer_id, msg_hdr, xfer->state);
 
 		scmi_bad_message_trace(cinfo, msg_hdr, MSG_INVALID);
+		scmi_log_stats(info->dbg_stats, ERR_MSG_INVALID);
+
 
 		/* On error the refcount incremented above has to be dropped */
 		__scmi_xfer_put(minfo, xfer);
@@ -1060,6 +1077,7 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 			PTR_ERR(xfer));
 
 		scmi_bad_message_trace(cinfo, msg_hdr, MSG_NOMEM);
+		scmi_log_stats(info->dbg_stats, ERR_MSG_NOMEM);
 
 		scmi_clear_channel(info, cinfo);
 		return;
@@ -1075,6 +1093,7 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 	trace_scmi_msg_dump(info->id, cinfo->id, xfer->hdr.protocol_id,
 			    xfer->hdr.id, "NOTI", xfer->hdr.seq,
 			    xfer->hdr.status, xfer->rx.buf, xfer->rx.len);
+	scmi_log_stats(info->dbg_stats, NOTIF_OK);
 
 	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
 		    xfer->hdr.id, xfer->rx.buf, xfer->rx.len, ts);
@@ -1134,8 +1153,10 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 	if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP) {
 		scmi_clear_channel(info, cinfo);
 		complete(xfer->async_done);
+		scmi_log_stats(info->dbg_stats, DLYD_RESPONSE_OK);
 	} else {
 		complete(&xfer->done);
+		scmi_log_stats(info->dbg_stats, RESPONSE_OK);
 	}
 
 	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
@@ -1219,6 +1240,7 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 			       struct scmi_xfer *xfer, unsigned int timeout_ms)
 {
 	int ret = 0;
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
 
 	if (xfer->hdr.poll_completion) {
 		/*
@@ -1239,13 +1261,12 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 					"timed out in resp(caller: %pS) - polling\n",
 					(void *)_RET_IP_);
 				ret = -ETIMEDOUT;
+				scmi_log_stats(info->dbg_stats, XFERS_RESPONSE_POLLED_TIMEOUT);
 			}
 		}
 
 		if (!ret) {
 			unsigned long flags;
-			struct scmi_info *info =
-				handle_to_scmi_info(cinfo->handle);
 
 			/*
 			 * Do not fetch_response if an out-of-order delayed
@@ -1265,6 +1286,7 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 					    "RESP" : "resp",
 					    xfer->hdr.seq, xfer->hdr.status,
 					    xfer->rx.buf, xfer->rx.len);
+			scmi_log_stats(info->dbg_stats, RESPONSE_POLLED_OK);
 
 			if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
 				scmi_raw_message_report(info->raw, xfer,
@@ -1279,6 +1301,7 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 			dev_err(dev, "timed out in resp(caller: %pS)\n",
 				(void *)_RET_IP_);
 			ret = -ETIMEDOUT;
+			scmi_log_stats(info->dbg_stats, XFERS_RESPONSE_TIMEOUT);
 		}
 	}
 
@@ -1362,13 +1385,15 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	    !is_transport_polling_capable(info->desc)) {
 		dev_warn_once(dev,
 			      "Polling mode is not supported by transport.\n");
+		scmi_log_stats(info->dbg_stats, SENT_FAIL_POLLING_UNSUPPORTED);
 		return -EINVAL;
 	}
 
 	cinfo = idr_find(&info->tx_idr, pi->proto->id);
-	if (unlikely(!cinfo))
+	if (unlikely(!cinfo)) {
+		scmi_log_stats(info->dbg_stats, SENT_FAIL_CHANNEL_NOT_FOUND);
 		return -EINVAL;
-
+	}
 	/* True ONLY if also supported by transport. */
 	if (is_polling_enabled(cinfo, info->desc))
 		xfer->hdr.poll_completion = true;
@@ -1400,16 +1425,20 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	ret = info->desc->ops->send_message(cinfo, xfer);
 	if (ret < 0) {
 		dev_dbg(dev, "Failed to send message %d\n", ret);
+		scmi_log_stats(info->dbg_stats, SENT_FAIL);
 		return ret;
 	}
 
 	trace_scmi_msg_dump(info->id, cinfo->id, xfer->hdr.protocol_id,
 			    xfer->hdr.id, "CMND", xfer->hdr.seq,
 			    xfer->hdr.status, xfer->tx.buf, xfer->tx.len);
+	scmi_log_stats(info->dbg_stats, SENT_OK);
 
 	ret = scmi_wait_for_message_response(cinfo, xfer);
-	if (!ret && xfer->hdr.status)
+	if (!ret && xfer->hdr.status) {
 		ret = scmi_to_linux_errno(xfer->hdr.status);
+		scmi_log_stats(info->dbg_stats, ERR_PROTOCOL);
+	}
 
 	if (info->desc->ops->mark_txdone)
 		info->desc->ops->mark_txdone(cinfo, ret, xfer);
-- 
2.34.1


