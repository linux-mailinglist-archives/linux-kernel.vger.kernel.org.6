Return-Path: <linux-kernel+bounces-274702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCB1947B9B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F52C1C21278
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A97B15ADB8;
	Mon,  5 Aug 2024 13:10:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1401015B118;
	Mon,  5 Aug 2024 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863426; cv=none; b=kZC93WkVB611FcXavTbEVexewo7gq+SIlMvePHN0pi2a5fi1KoZf8YnaoFxCZybRxYK5apyf/55zoH4QWcjqiL0eS0Of5D1CXtEgptnVDI1uyoIbBX4sagMJY+S75AZ89CHt4PnIo/QTLbdo5tZNo6AaanMi2XLBqge+EHm+huk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863426; c=relaxed/simple;
	bh=Ne/FM0J6cQ7zpW8OxdJR36nwTuff4t9FW3LmiK9Aixc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m68Jz76tu4r2Wm2WzVQZddmvtTRnsBakzqympVfcTBaDQHzJDAOD/L+YA4CPuqMKeUB1unOSOC+w5uHpsVGIe+qZCqF6foit3KF/k7/frm1BrxOJOGJGkR63qBJRpfE+ZDwcmotRbhQhMUfVWR+VKXuLCuFkJ9oxuwhLLUmrHQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FD5216F8;
	Mon,  5 Aug 2024 06:10:49 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B762C3F5A1;
	Mon,  5 Aug 2024 06:10:22 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Luke Parkin <luke.parkin@arm.com>
Subject: [PATCH v5 3/5] firmware: arm_scmi: Track basic SCMI communication debug metrics
Date: Mon,  5 Aug 2024 14:10:10 +0100
Message-ID: <20240805131013.587016-4-sudeep.holla@arm.com>
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

Add the support for counting some of the SCMI communication debug metrics
like how many were sent successfully or with some errors, responses
received, notifications and delayed responses, transfer timeouts and
errors from the firmware/platform.

In many cases, the traces exists. But the traces are not always necessarily
enabled and getting such cumulative SCMI communication debug metrics helps
in understanding if there are any possible improvements that can be made
on either side of SCMI communication.

Signed-off-by: Luke Parkin <luke.parkin@arm.com>
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/common.h | 14 ++++++++++++++
 drivers/firmware/arm_scmi/driver.c | 25 ++++++++++++++++++++-----
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index d414b0a43b3b..21c94deaf614 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -302,6 +302,20 @@ extern const struct scmi_desc scmi_optee_desc;
 void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv);
 
 enum debug_counters {
+	SENT_OK,
+	SENT_FAIL,
+	SENT_FAIL_POLLING_UNSUPPORTED,
+	SENT_FAIL_CHANNEL_NOT_FOUND,
+	RESPONSE_OK,
+	NOTIFICATION_OK,
+	DELAYED_RESPONSE_OK,
+	XFERS_RESPONSE_TIMEOUT,
+	XFERS_RESPONSE_POLLED_TIMEOUT,
+	RESPONSE_POLLED_OK,
+	ERR_MSG_UNEXPECTED,
+	ERR_MSG_INVALID,
+	ERR_MSG_NOMEM,
+	ERR_PROTOCOL,
 	SCMI_DEBUG_COUNTERS_LAST
 };
 
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 958b2ac92050..943ba03315de 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -990,6 +990,7 @@ scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
 		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
 
 		scmi_bad_message_trace(cinfo, msg_hdr, MSG_UNEXPECTED);
+		scmi_inc_count(info->dbg->counters, ERR_MSG_UNEXPECTED);
 
 		return xfer;
 	}
@@ -1017,6 +1018,8 @@ scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
 			msg_type, xfer_id, msg_hdr, xfer->state);
 
 		scmi_bad_message_trace(cinfo, msg_hdr, MSG_INVALID);
+		scmi_inc_count(info->dbg->counters, ERR_MSG_INVALID);
+
 
 		/* On error the refcount incremented above has to be dropped */
 		__scmi_xfer_put(minfo, xfer);
@@ -1056,6 +1059,7 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 			PTR_ERR(xfer));
 
 		scmi_bad_message_trace(cinfo, msg_hdr, MSG_NOMEM);
+		scmi_inc_count(info->dbg->counters, ERR_MSG_NOMEM);
 
 		scmi_clear_channel(info, cinfo);
 		return;
@@ -1071,6 +1075,7 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 	trace_scmi_msg_dump(info->id, cinfo->id, xfer->hdr.protocol_id,
 			    xfer->hdr.id, "NOTI", xfer->hdr.seq,
 			    xfer->hdr.status, xfer->rx.buf, xfer->rx.len);
+	scmi_inc_count(info->dbg->counters, NOTIFICATION_OK);
 
 	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
 		    xfer->hdr.id, xfer->rx.buf, xfer->rx.len, ts);
@@ -1130,8 +1135,10 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 	if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP) {
 		scmi_clear_channel(info, cinfo);
 		complete(xfer->async_done);
+		scmi_inc_count(info->dbg->counters, DELAYED_RESPONSE_OK);
 	} else {
 		complete(&xfer->done);
+		scmi_inc_count(info->dbg->counters, RESPONSE_OK);
 	}
 
 	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
@@ -1215,6 +1222,7 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 			       struct scmi_xfer *xfer, unsigned int timeout_ms)
 {
 	int ret = 0;
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
 
 	if (xfer->hdr.poll_completion) {
 		/*
@@ -1235,13 +1243,12 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 					"timed out in resp(caller: %pS) - polling\n",
 					(void *)_RET_IP_);
 				ret = -ETIMEDOUT;
+				scmi_inc_count(info->dbg->counters, XFERS_RESPONSE_POLLED_TIMEOUT);
 			}
 		}
 
 		if (!ret) {
 			unsigned long flags;
-			struct scmi_info *info =
-				handle_to_scmi_info(cinfo->handle);
 
 			/*
 			 * Do not fetch_response if an out-of-order delayed
@@ -1261,6 +1268,7 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 					    "RESP" : "resp",
 					    xfer->hdr.seq, xfer->hdr.status,
 					    xfer->rx.buf, xfer->rx.len);
+			scmi_inc_count(info->dbg->counters, RESPONSE_POLLED_OK);
 
 			if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
 				scmi_raw_message_report(info->raw, xfer,
@@ -1275,6 +1283,7 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 			dev_err(dev, "timed out in resp(caller: %pS)\n",
 				(void *)_RET_IP_);
 			ret = -ETIMEDOUT;
+			scmi_inc_count(info->dbg->counters, XFERS_RESPONSE_TIMEOUT);
 		}
 	}
 
@@ -1358,13 +1367,15 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	    !is_transport_polling_capable(info->desc)) {
 		dev_warn_once(dev,
 			      "Polling mode is not supported by transport.\n");
+		scmi_inc_count(info->dbg->counters, SENT_FAIL_POLLING_UNSUPPORTED);
 		return -EINVAL;
 	}
 
 	cinfo = idr_find(&info->tx_idr, pi->proto->id);
-	if (unlikely(!cinfo))
+	if (unlikely(!cinfo)) {
+		scmi_inc_count(info->dbg->counters, SENT_FAIL_CHANNEL_NOT_FOUND);
 		return -EINVAL;
-
+	}
 	/* True ONLY if also supported by transport. */
 	if (is_polling_enabled(cinfo, info->desc))
 		xfer->hdr.poll_completion = true;
@@ -1396,16 +1407,20 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	ret = info->desc->ops->send_message(cinfo, xfer);
 	if (ret < 0) {
 		dev_dbg(dev, "Failed to send message %d\n", ret);
+		scmi_inc_count(info->dbg->counters, SENT_FAIL);
 		return ret;
 	}
 
 	trace_scmi_msg_dump(info->id, cinfo->id, xfer->hdr.protocol_id,
 			    xfer->hdr.id, "CMND", xfer->hdr.seq,
 			    xfer->hdr.status, xfer->tx.buf, xfer->tx.len);
+	scmi_inc_count(info->dbg->counters, SENT_OK);
 
 	ret = scmi_wait_for_message_response(cinfo, xfer);
-	if (!ret && xfer->hdr.status)
+	if (!ret && xfer->hdr.status) {
 		ret = scmi_to_linux_errno(xfer->hdr.status);
+		scmi_inc_count(info->dbg->counters, ERR_PROTOCOL);
+	}
 
 	if (info->desc->ops->mark_txdone)
 		info->desc->ops->mark_txdone(cinfo, ret, xfer);
-- 
2.46.0


