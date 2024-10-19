Return-Path: <linux-kernel+bounces-373004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D519A508C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 21:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6CB1F20F03
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 19:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B277DA68;
	Sat, 19 Oct 2024 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TvKMX9Mi"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED66191F7C
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729367674; cv=none; b=ZBWtXxYFG2R4bYNsal8FQ8SmULIJpOMR50qcfp68PdjSheNN5hbXnRiPRULAS9q1yuuTMlgmSZ9jK3eEIdZW5CIJF5YcJRtc2tsZnLSPdVt6G1dZ6nja1T+dlQmLMfVJ+pFq6MQP/nkwOOaWPwxoKWgQusMPr73TULKYze8ve3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729367674; c=relaxed/simple;
	bh=5xBLjWfyU3w0VRNk7+y/qaxa59D53HCMS5fOnDwQjUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rxvS+esPXeea8eYnBy8T4j2upZEPS/9W80uZvQyYwQRxW2WEpSuBEwJz7THb6N5mC8eNK72PvPbkagKYehtiC7gGRUdJ13j7vW++Xwv6fnOP0obH3LNfljc91EBXpvTD6zO0HfhYwMeT4mBdd9/YwnqRQis3maQL6vgdePyJfuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TvKMX9Mi; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729367670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9EMIQ/U97FhJEvG6NAwh17rZuz9z3Ih7xl0oOUdfUfQ=;
	b=TvKMX9MiW5jMAgOVdUwP32cl5vbDw/nGVjjt5P8ixcoy1k6H5fXOIw9vtAInd6cgtfnZYa
	HiwqShdPWPQWHTMw6ochBegLBH+dvW1PeXs6wMzTc1wnxwkoBVRlRjzCwt7PMdPhmpV9Wo
	apB2cDzhX1M+V74QgTN9oTLMLhAQETI=
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Dominik Haller <d.haller@phytec.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Devarsh Thakkar <devarsht@ti.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	DRI Development List <dri-devel@lists.freedesktop.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>
Subject: [PATCH v5 01/13] drm/bridge: cdns-dsi: Fix connecting to next bridge
Date: Sun, 20 Oct 2024 01:23:59 +0530
Message-Id: <20241019195411.266860-2-aradhya.bhatia@linux.dev>
In-Reply-To: <20241019195411.266860-1-aradhya.bhatia@linux.dev>
References: <20241019195411.266860-1-aradhya.bhatia@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Aradhya Bhatia <a-bhatia1@ti.com>

Fix the OF node pointer passed to the of_drm_find_bridge() call to find
the next bridge in the display chain.

The code to find the next panel (and create its panel-bridge) works
fine, but to find the next (non-panel) bridge does not.

To find the next bridge in the pipeline, we need to pass "np" - the OF
node pointer of the next entity in the devicetree chain. Passing
"of_node" to of_drm_find_bridge (which is what the code does currently)
will fetch the bridge for the cdns-dsi which is not what's required.

Fix that.

Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 7457d38622b0..b016f2ba06bb 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -952,7 +952,7 @@ static int cdns_dsi_attach(struct mipi_dsi_host *host,
 		bridge = drm_panel_bridge_add_typed(panel,
 						    DRM_MODE_CONNECTOR_DSI);
 	} else {
-		bridge = of_drm_find_bridge(dev->dev.of_node);
+		bridge = of_drm_find_bridge(np);
 		if (!bridge)
 			bridge = ERR_PTR(-EINVAL);
 	}
-- 
2.34.1


