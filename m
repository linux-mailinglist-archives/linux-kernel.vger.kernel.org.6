Return-Path: <linux-kernel+bounces-176583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFA38C31EA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 16:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD391C20C35
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 14:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE615579F;
	Sat, 11 May 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d3yVAzsb"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED38237169
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715438847; cv=none; b=WPqL6I8S6ZjMRXAjXw1L4bhKdqUE4drgM9Ag9UjiaOMomC+GbB/LR06XVrnOHBjMNAxUiefn11/HvXFemwTATIXEbqevT3mGhxgr8+FTeY0O98Ab6opJazlSHWfykV/irq+T4pYuOhqCguCyG4nbo33nCEu36N+7EBHs9h4MkYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715438847; c=relaxed/simple;
	bh=Fx28MQST8ByqGaLf3JVQVmXNpCZ5f7j41vlyIHTb58E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vc1/ugKRTqfB6qn40Q/7ZQLnwUqG6MxzNpTDZtTqY93zJ0JoSGZdHixEZ8lTplYChNtwIi94U6JjQE5WfVs246OsgwRoyNs61Ou2w4P73jNzXqMq0jWjMLhrT4DPdTgjaD2jok38w2CSlTdJlCxgDPds4WGXTzdsLV/zSZPHLds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d3yVAzsb; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715438843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7yOqpZKsUKDB1a0tUagb9Qur9MXv1mW2mjyu4D7NkSE=;
	b=d3yVAzsbzdpSfkT78RVPvEMqZ/aV+HAl9d9PnPMHjixfIjK6vovt1sjtxrjX2d616YAyM5
	ADA3b26o/ZqjrQrx87t3Y+jmSJKtvpgShsFqrIbQ/zGiv41dlCNZieyMLFQyGjbiPzsav2
	LyALftzDxf8kQ08yANNcgXO61YsNT0k=
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
Subject: [PATCH] drm/bridge: synopsys: dw-mipi-dsi: Remove a redundant check on existence of bridge->encoder
Date: Sat, 11 May 2024 22:47:13 +0800
Message-ID: <20240511144713.325156-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the dw_mipi_dsi_bridge_attach() function, the check on the existence
of bridge->encoder is not necessary, as it has already been done in the
drm_bridge_attach() function. And the check on the drm bridge core
happens before check in the implementation. Hence, it is guaranteed that
the .encoder member of the struct drm_bridge is not NULL when
dw_mipi_dsi_bridge_attach() function gets called.

Remove the redundant checking codes "if (!bridge->encoder) { ... }".

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index 824fb3c65742..c4e9d96933dc 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -1071,11 +1071,6 @@ static int dw_mipi_dsi_bridge_attach(struct drm_bridge *bridge,
 {
 	struct dw_mipi_dsi *dsi = bridge_to_dsi(bridge);
 
-	if (!bridge->encoder) {
-		DRM_ERROR("Parent encoder object not found\n");
-		return -ENODEV;
-	}
-
 	/* Set the encoder type as caller does not know it */
 	bridge->encoder->encoder_type = DRM_MODE_ENCODER_DSI;
 
-- 
2.43.0


