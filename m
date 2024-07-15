Return-Path: <linux-kernel+bounces-252613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC239315E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EAF01C21A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4242218E75B;
	Mon, 15 Jul 2024 13:38:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7351518C180;
	Mon, 15 Jul 2024 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050686; cv=none; b=LV6oxz9gMkkyDkmo6KRUPRzNl3v5mfhn4dHpCMtQSNwTn0sHMDyw6gB/SderuMYFPaZoZBE/yovBz7of9qaeqpolK4/530TQxTGqRO8qD464+wTDWNfMd4zrl2Z5wwzv14zfiZYx3H9cvT8tihQeSDwgh4JeyJcgXyslYB8NrHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050686; c=relaxed/simple;
	bh=lcxcZWyLm/91dxaFT0lTwPZ6IbZKcEviGnNfpG0ef4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MXOZK6jctWrb6Ynd+p6rn6nMNzJtgal34pXkmZqYE/a8f2HPlFHXkZk/e72xM2G//MRflRpeOzOLSomh6GAM6sLbYLXdLewlsiCOfbm4cTBAwuAUaxdOz4hBZeL8lm5mo5x85Qge2JEDxmh023U3KuWAEUYw7SwSQnNvMxVdJEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CB90DA7;
	Mon, 15 Jul 2024 06:38:30 -0700 (PDT)
Received: from thinkcentre-m93p.cambridge.arm.com (thinkcentre-m93p.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BE643F73F;
	Mon, 15 Jul 2024 06:38:03 -0700 (PDT)
From: Luke Parkin <luke.parkin@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	Luke Parkin <luke.parkin@arm.com>
Subject: [PATCH v3 1/5] firmware: arm_scmi: Remove superfluous handle_to_scmi_info
Date: Mon, 15 Jul 2024 14:37:47 +0100
Message-Id: <20240715133751.2877197-2-luke.parkin@arm.com>
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

Remove duplicate handle_to_scmi_info

Signed-off-by: Luke Parkin <luke.parkin@arm.com>
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
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


