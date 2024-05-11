Return-Path: <linux-kernel+bounces-176591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469138C31FA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 16:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90571F217D0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 14:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD5756B7C;
	Sat, 11 May 2024 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F04Q+4K1"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BACD56773
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715439362; cv=none; b=DmXE62HLgXptoQFk1Vqxmmu/yL3oZA6Xy3a/LLvWsfboni5mwraea2eWQeQDonnmTC70LeX8QFq76/NTcEvpUBZF9Xb38rDHjxWK7hFbPl01Drm54ISsvuCKxN5/ojNY4zaMVf21yCegVj79LlyVB9Wc9BJbSkqbEuOcD6g8n2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715439362; c=relaxed/simple;
	bh=SVQMqa2r/6vMx/PrKmXTy9Z/bnq/aQVKbgm1YzdvXUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IA4P+QsIrjqfsom6SdN++W3J3fde1ln7TsRbcCO0r7Bcvdct1HJnxIjOLuAiuw8Hv5pnSMBLOYNdwlmsOTENmvfEwTR+yhWUgJC45BxVV06ItOtZKPOUQphlLe/6pOARFI94M5onBcXT0xdq5kJsW4CWBvD8kLKiiCqQ/4yvKP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F04Q+4K1; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715439358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fLoNj1TdFzof77QtMBY2FlaBpFNEQWVn75IC8HxaP3o=;
	b=F04Q+4K1f8y3k4yMDVAKeGMfPgpAZNodhB7eRwQ9ieT+62zs0QcKeUakgZSvGCjKHry1l5
	+fNjggxspxAtog+lUihviY8Zek920ATjlGIqwpZ3LtlL4UoNhoN5ufEGS1D2E6r2qRFwBE
	WypcdHnmW+h7CwPlmhutGgX9aV94UI8=
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
Subject: [PATCH] drm/bridge: lt9611uxc: Remove a redundant check on existence of bridge->encoder
Date: Sat, 11 May 2024 22:55:49 +0800
Message-ID: <20240511145549.325852-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the lt9611uxc_connector_init() function, the check on the existence
of bridge->encoder is not necessary, as it has already been done in the
drm_bridge_attach() function. And the check on the drm bridge core
happens before check in the implementation. Hence, it is guaranteed that
the .encoder member of the struct drm_bridge is not NULL when
lt9611uxc_connector_init() function gets called.

Remove the redundant checking codes "if (!bridge->encoder) { ... }".

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index f4f593ad8f79..f1fccfe6c534 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -339,11 +339,6 @@ static int lt9611uxc_connector_init(struct drm_bridge *bridge, struct lt9611uxc
 {
 	int ret;
 
-	if (!bridge->encoder) {
-		DRM_ERROR("Parent encoder object not found");
-		return -ENODEV;
-	}
-
 	lt9611uxc->connector.polled = DRM_CONNECTOR_POLL_HPD;
 
 	drm_connector_helper_add(&lt9611uxc->connector,
-- 
2.43.0


