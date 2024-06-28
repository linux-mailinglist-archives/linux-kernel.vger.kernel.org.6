Return-Path: <linux-kernel+bounces-234530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D5091C7A3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D401C2607F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065C81304A3;
	Fri, 28 Jun 2024 20:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LoRjkfuf"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDCD7A715
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608171; cv=none; b=f5fMkVGNJ/TQWKbAeQLnDyvwK2mOSh8diFZXtvPDeCS47o5lgObD5tpy6fjwYoyNpkwdo4kjw7vByF4H0AV6rXKfMd12K5C+tXu/Kmcf/w604iqiuEpOLhmN4F6XDgtlBgTWzeNoHRJMX4jd/mB+bQqF99NRiweBgEalQU4bnZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608171; c=relaxed/simple;
	bh=fGwvdcJajYq+BAliIScip+LfollDtBbRdL8TeQU386Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XNWXIUX9SEF2hzT0T1hf86lVmfQxiD784XCZ1PQkz2BOaBr3tWTF89XlzYKzdVV7i0ELJiT8e7J2NmwaH3BKdl3tYMP7pIAICFEwTvQiLbJ6Hn3kRWwysUcwiQhUNxYle/PLwkKV56BlazkAmZvA1dcv0SJZe/JnEVVLYRZwgxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LoRjkfuf; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: radhey.shyam.pandey@amd.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719608167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePtnv+mOy1V2a9C9AGkoMpYJ4bWTIeHu876bvQ6PA7w=;
	b=LoRjkfufmI+It1uHsu+j94T3quZNHVJZk802KYnAcvZadmEkuQvNWwdhnFHJ4kw+oR2Ajg
	p6tUKCEhXJioBIeC4VbIwlNoiQnr6fhdJV6h52a03Xhh2CiwUHtWPLPzjFNlBEEx0KrMkM
	SF3sSn/s3gj1eQhQb7b1oiKD9rrpHro=
X-Envelope-To: laurent.pinchart@ideasonboard.com
X-Envelope-To: linux-phy@lists.infradead.org
X-Envelope-To: vkoul@kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: kishon@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v3 4/5] phy: zynqmp: Take the phy mutex in xlate
Date: Fri, 28 Jun 2024 16:55:39 -0400
Message-Id: <20240628205540.3098010-5-sean.anderson@linux.dev>
In-Reply-To: <20240628205540.3098010-1-sean.anderson@linux.dev>
References: <20240628205540.3098010-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Take the phy mutex in xlate to protect against concurrent
modification/access to gtr_phy. This does not typically cause any
issues, since in most systems the phys are only xlated once and
thereafter accessed with the phy API (which takes the locks). However,
we are about to allow userspace to access phys for debugging, so it's
important to avoid any data races.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v3:
- New

 drivers/phy/xilinx/phy-zynqmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index 4d697e11d8eb..991be42eef3d 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -759,6 +759,7 @@ static struct phy *xpsgtr_xlate(struct device *dev,
 	phy_type = args->args[1];
 	phy_instance = args->args[2];
 
+	guard(mutex)(&gtr_phy->phy->mutex);
 	ret = xpsgtr_set_lane_type(gtr_phy, phy_type, phy_instance);
 	if (ret < 0) {
 		dev_err(gtr_dev->dev, "Invalid PHY type and/or instance\n");
-- 
2.35.1.1320.gc452695387.dirty


