Return-Path: <linux-kernel+bounces-274699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7993947B98
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9326F1F23360
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D768615AD9C;
	Mon,  5 Aug 2024 13:10:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846911E49F;
	Mon,  5 Aug 2024 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863424; cv=none; b=Ln0ytU106IS2tFvpxmVec61dfGj6cMQwHLd0EHfz4x1pMx5f93JApgdyLMSDddyGp9oewyhwN5VosQj3sbG/baDHNpD5XHkQFeq/DHVeOaHtOSuGr51ZzbTMzqRxpEJV/432JMWnehV+3SBRkDoBo4tfFKWu9MPAxnTk+v57C1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863424; c=relaxed/simple;
	bh=lReTlhDxZ5BIatvaKYtNZ+rVq0AZkMYxeWbdxseKuFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVCpgim2dH/L5oALv0GciQOXjakWolasXVzky+OAQfczrN+Nxt5p6fOpmSIVDBnFNb0v5lld8Yi2SvmQy1y4xWuLL905Z2QVrqhkzFNTh5XRq0hGpM9vExRYnI0y8JZEO09dWBKifi8qA5yzN+Ty1aZZzfa//BI42Z4ZsYZWWnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F0F21474;
	Mon,  5 Aug 2024 06:10:47 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 89B773F5A1;
	Mon,  5 Aug 2024 06:10:20 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Luke Parkin <luke.parkin@arm.com>
Subject: [PATCH v5 1/5] firmware: arm_scmi: Remove superfluous handle_to_scmi_info
Date: Mon,  5 Aug 2024 14:10:08 +0100
Message-ID: <20240805131013.587016-2-sudeep.holla@arm.com>
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

Variable info is already defined in the outer code block and there is no
need to define the same again in the inner code block. Let us just remove
that duplicate definition of the variable info. No functional change.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Luke Parkin <luke.parkin@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
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
2.46.0


