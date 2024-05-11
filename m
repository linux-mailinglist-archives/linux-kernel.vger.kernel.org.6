Return-Path: <linux-kernel+bounces-176580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 905098C31DF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 16:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900961C20B4E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 14:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C15454F83;
	Sat, 11 May 2024 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Oclv2g5M"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93C451034
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715438310; cv=none; b=HM8S0fZuVSLVI0flcZnSukid0/+25sq/0Tu39aOIZi+Nu8CWzdq7ut8OcSeN43eedU3IGapfjLq9lmRz09XXfe7q5v6JHLnoatUyDeBvgTs+IOx3dZ9+SupETdXd7MzlScuAFQWAvmkGV0KsB8km0mC9chrtPppdDRYncGHat64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715438310; c=relaxed/simple;
	bh=ARN1LqUaqN185QT2ahXkPm1gs9oNTPlneGEV9vazkcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TtxgXLZ1zCdjnALAWI6ajaP/UCVOtqqYkDVCdSTc1QdZAtcSAI0m5jwNjrxHD/SlqJXdGkQaq1TjmLB/lodtLJ3vsyJSraXwrisUZu2l3oqY5fgArPdRCi3Vgb5C+ji++u2eXSLNxZ1D6HV6okFH03T+h264HksTS37wcTQVU3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Oclv2g5M; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715438306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7oYbAK6V3PMtAQPp3g/jPrpGniPO9Da3WJamUNyoSGs=;
	b=Oclv2g5M1gH3fwibfFPG3GLpshvJyT1MiFS5oK9R/F4GPl1j1/YTizCaga0maO6i5NFvS5
	y86vOIBu/ffajTAm6v6AkUUOKGgkyoSwCyjboNxcj4LNXkWYvQas6zBl5iGyS/DT3ilvnY
	/YEJWW3pKt7Yib3YrHH4fEOB12s0Xck=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Remove a redundant check on existence of bridge->encoder
Date: Sat, 11 May 2024 22:38:20 +0800
Message-ID: <20240511143820.324369-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the ge_b850v3_lvds_create_connector function, the check on the existence
of bridge->encoder is not necessary, as it has already been done in the
drm_bridge_attach() function. And the check on the drm bridge core
happens before check in the implementation. Hence, it is guaranteed that
the .encoder member of the struct drm_bridge is not NULL when
ge_b850v3_lvds_attach() function gets called.

Remove the redundant checking codes "if (!bridge->encoder) { ... }".

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index 4480523244e4..37f1acf5c0f8 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -165,11 +165,6 @@ static int ge_b850v3_lvds_create_connector(struct drm_bridge *bridge)
 	struct drm_connector *connector = &ge_b850v3_lvds_ptr->connector;
 	int ret;
 
-	if (!bridge->encoder) {
-		DRM_ERROR("Parent encoder object not found");
-		return -ENODEV;
-	}
-
 	connector->polled = DRM_CONNECTOR_POLL_HPD;
 
 	drm_connector_helper_add(connector,
-- 
2.43.0


