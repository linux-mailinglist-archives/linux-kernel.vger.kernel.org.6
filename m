Return-Path: <linux-kernel+bounces-303541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0399960DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A5E1F254A0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251221C4EF6;
	Tue, 27 Aug 2024 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YsTFx34P"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601651C463D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769204; cv=none; b=FpTxCe9F5qi47KcBMhWCElHL4YnYsaP8Tt7GxiDEg8TFMI+P3ZZJZ1/J6SurDqiazZlzp1GiMgA2AODzTnlEwTb6FHM8QsXefHnLV8VyGjqVgRHXnw1gG1TXvePz5psW1+TLXE2alc0sZi8URg7a3OrYeZN7qRbfujQoQwVNMI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769204; c=relaxed/simple;
	bh=kw6eRbhzPA7Zv3CWuWU9FhO931fHSePK83ZX0rF4IEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p3MfFTFbLXK1X040+W+wvgzj/tDG+RMGqmW7+O0Ee/mi2Ks1HLTZCR1twRo4+qkGk/PM041t2S0deatRvXl1Mo68PR+E4RzmkKpUVbXCp6FzOjP8+MEMuFuGgT7LKS5j/Xjz7l7Fx9cJCYU2N+b5/sV5Rf9pHkjmT1l23W03mIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YsTFx34P; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724769199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XWmaGsFV8+sUx0IL98EYus9x9tg6qc5lWhD4xE5HgsQ=;
	b=YsTFx34PNk7Ga/NYjNt19CsN8uHxJDTJGmwk4VC2VD8wqw41gMqdN5xPAf6wXdOAdJJyHb
	/KVl0xPAYKz43cJn6S89wGjU1SHV2qsiwMiOhK4JAADXH0cuvQFjlODwbK4bNPXwdF1Ift
	bo5xJtylWC6MKUV3txwzr7oKOhQhEaY=
From: Wen Yang <wen.yang@linux.dev>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Wen Yang <wen.yang@linux.dev>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: protect xfer->async_done with xfer->lock when changing and using it
Date: Tue, 27 Aug 2024 22:32:37 +0800
Message-Id: <20240827143237.10208-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

do_xfer_with_response() first assigns xfer->async_done to &async_response,
then calls wait_for_completion_timeout(), and finally sets xfer->async_done
to null.
However, scmi_handle_response() may calls complete(xfer->async_done) while
xfer->async_done is null, may causing a crash.

Protect xfer->async_done with xfer->lock when changing and using it,
just like scmi_msg_response_validate().

Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>
Cc: arm-scmi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/firmware/arm_scmi/driver.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 66806578df5a..24ed94e3cbd4 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1110,6 +1110,7 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 {
 	struct scmi_xfer *xfer;
 	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
+	unsigned long flags;
 
 	xfer = scmi_xfer_command_acquire(cinfo, msg_hdr);
 	if (IS_ERR(xfer)) {
@@ -1144,7 +1145,10 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 
 	if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP) {
 		scmi_clear_channel(info, cinfo);
-		complete(xfer->async_done);
+		spin_lock_irqsave(&xfer->lock, flags);
+		if (xfer->async_done)
+			complete(xfer->async_done);
+		spin_unlock_irqrestore(&xfer->lock, flags);
 		scmi_inc_count(info->dbg->counters, DELAYED_RESPONSE_OK);
 	} else {
 		complete(&xfer->done);
@@ -1479,9 +1483,13 @@ static int do_xfer_with_response(const struct scmi_protocol_handle *ph,
 				 struct scmi_xfer *xfer)
 {
 	int ret, timeout = msecs_to_jiffies(SCMI_MAX_RESPONSE_TIMEOUT);
+	unsigned long flags;
+
 	DECLARE_COMPLETION_ONSTACK(async_response);
 
+	spin_lock_irqsave(&xfer->lock, flags);
 	xfer->async_done = &async_response;
+	spin_unlock_irqrestore(&xfer->lock, flags);
 
 	/*
 	 * Delayed responses should not be polled, so an async command should
@@ -1503,7 +1511,10 @@ static int do_xfer_with_response(const struct scmi_protocol_handle *ph,
 		}
 	}
 
+	spin_lock_irqsave(&xfer->lock, flags);
 	xfer->async_done = NULL;
+	spin_unlock_irqrestore(&xfer->lock, flags);
+
 	return ret;
 }
 
-- 
2.25.1


