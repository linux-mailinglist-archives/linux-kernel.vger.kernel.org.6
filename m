Return-Path: <linux-kernel+bounces-267163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1B4940DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB792863D9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699C7195804;
	Tue, 30 Jul 2024 09:33:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0F0194C74;
	Tue, 30 Jul 2024 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332035; cv=none; b=q9kQxusWY21rJw0ipBWoT1w/2UfjV+dO74quzIM7gUoijMeSCFCWg1C4sW/PCuHwvhKg4t+ggmYwoqXgc7rZ0gZHkof7HUm1fy1f8VDgykl2Oq1AZOWiemx3VGY5BZNV4MpZEqlkmCfwf1RrnsVEhqOM83+XcqBpq/8jIKpM5hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332035; c=relaxed/simple;
	bh=qcc48r0QNqOKv/1oBmIsBMRBmf2e/xjA2QwqJq4kc2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=odv7GcWjo1cVc4D6XMRzOrHKIhjKm0O4toylz1aFAnaIxhTOnN21Er8oDdAlf+cXgeCdm3aBGT1+awQkCW/XE0qLikodnNJUkGTXE3P8ypIY/4wOxucKejqnmxzTTKvJqTYmsIp5G5Oc3YkzPwQZ/3VExSkN56Wv3mBuCYmaFw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09281106F;
	Tue, 30 Jul 2024 02:34:18 -0700 (PDT)
Received: from thinkcentre-m93p.cambridge.arm.com (thinkcentre-m93p.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68DD53F5A1;
	Tue, 30 Jul 2024 02:33:51 -0700 (PDT)
From: Luke Parkin <luke.parkin@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	Luke Parkin <luke.parkin@arm.com>
Subject: [PATCH v4 1/5] firmware: arm_scmi: Remove superfluous handle_to_scmi_info
Date: Tue, 30 Jul 2024 10:33:38 +0100
Message-Id: <20240730093342.3558162-2-luke.parkin@arm.com>
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

Remove duplicate handle_to_scmi_info

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Luke Parkin <luke.parkin@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 6b6957f4743f..56a93d20bf23 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1261,9 +1261,6 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 					    xfer->rx.buf, xfer->rx.len);
 
 			if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
-				struct scmi_info *info =
-					handle_to_scmi_info(cinfo->handle);
-
 				scmi_raw_message_report(info->raw, xfer,
 							SCMI_RAW_REPLY_QUEUE,
 							cinfo->id);
-- 
2.34.1


