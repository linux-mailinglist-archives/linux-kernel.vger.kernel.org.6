Return-Path: <linux-kernel+bounces-239654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0763E92639A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08A90B2853D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765DC17C218;
	Wed,  3 Jul 2024 14:38:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0DD17BB13;
	Wed,  3 Jul 2024 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017504; cv=none; b=Kp8pRamph/CXKK2NXEeQE8N0f0IjPPUSSwdeit91GsN4w+Q95heU5YS9g1Kyy9woQqYEKk3RimP8mTUAsSOH4g+6Ht+IpZdz/Ocmyv56ZIl73qduxO4n2UTzdQgYLhJKyVI/LtfDE+AvtVw3XFfYoyukgYMOEh8PyKn4Wsfxmm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017504; c=relaxed/simple;
	bh=9ZdUurG27ClZrOWTl3VHl2nqkq5xVOtJrtbqrj6LutU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RvaJAamyyzvQdyUjCitQ7lnAeBg1Vz4zl9OO7anebuATHGDE/PywBEmP1xA8fCCjcpklLOXAAlTbVIACPMF+68FVqpP9prdMatpiNFIpF3ktSpu30/RQHNoEhfV2SD4c9mFgNnzPGC8obXc9EO82vyJquAUDZX5mKEVwha8+bXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFAE2367;
	Wed,  3 Jul 2024 07:38:45 -0700 (PDT)
Received: from thinkcentre-m93p.cambridge.arm.com (thinkcentre-m93p.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF5D23F766;
	Wed,  3 Jul 2024 07:38:19 -0700 (PDT)
From: Luke Parkin <luke.parkin@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	Luke Parkin <luke.parkin@arm.com>
Subject: [PATCH v2 1/4] firmware: arm_scmi: Remove superfluous handle_to_scmi_info
Date: Wed,  3 Jul 2024 15:37:35 +0100
Message-Id: <20240703143738.2007457-2-luke.parkin@arm.com>
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

Remove duplicate handle_to_scmi_info

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


