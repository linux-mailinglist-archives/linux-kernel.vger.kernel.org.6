Return-Path: <linux-kernel+bounces-177750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A398C4440
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36AAD1C23455
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33712154C12;
	Mon, 13 May 2024 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CDm7CqHc"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10782154BF3
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614295; cv=none; b=QlemRfoWNf/0ygQzNqZnEr/0qQWTyHu3DLXV+mYreTsk+dVV2TYUhYSniS/U1ADC/UjPf4F1AoKl3J9pkx7ddxmNpiunFFMRnIKTGRXwS9bnchkQGdcr0qwcdDzacKWRv2Zal6NdwgZ/PcUTLx2qQMo7jLifuGNBbhOigHWzeLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614295; c=relaxed/simple;
	bh=dxoRAAr7aO9h0vQTtim6PDbtF3Jv9vhywmIqCc4bpYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KB1XEvt7VBoce1YS1lrLxzBh82kegxjYzstiLB0aHfVGmubZC024FrwI+sKtwI5/d6k/AAshZYM1SbIHHhlLv/8cjJhWsTo25dSS/yysHfYWdtoClwAEJKc2By1tk5kjQ7/HTAo/lMfPr3P4RxlACusiyzTrVqV4qtMeZoirEfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CDm7CqHc; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715614292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VuurdJj3GDklou0Of2HgmHbA6rBjSJAex3DjQZYdsF0=;
	b=CDm7CqHceFKy5OciFO5Mvsz8tZq+kJdT2xpaNPs7kweW+u7wPvo+d1weU0CekuYKywg3bo
	R0B0oLhklrWIKJN2NRxFMzdNaSPA1lr8rPMjXo6JZWvMswqf+37LLuaOkopxisneLn8No1
	iBo5Jq70dtVZzgMc/5dKvoPgj62qCYY=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Douglas Anderson <dianders@chromium.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Liu Ying <victor.liu@nxp.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 04/12] drm/bridge: panel: Remove a redundant check on existence of bridge->encoder
Date: Mon, 13 May 2024 23:31:01 +0800
Message-ID: <20240513153109.46786-5-sui.jingfeng@linux.dev>
In-Reply-To: <20240513153109.46786-1-sui.jingfeng@linux.dev>
References: <20240513153109.46786-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Because the existence of 'bridge->encoder' has already been checked before
the panel_bridge_attach() function get called, and the drm_bridge_attach()
will quit with a negative error code returned if it fails for some reasons.
Hence, it is guaranteed that the .encoder member of the drm_bridge instance
is not NULL when panel_bridge_attach() function get called.

Remove the redundant checking codes "if (!bridge->encoder) { ... }".

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/panel.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 32506524d9a2..56c40b516a8f 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -67,11 +67,6 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
 		return 0;
 
-	if (!bridge->encoder) {
-		DRM_ERROR("Missing encoder\n");
-		return -ENODEV;
-	}
-
 	drm_connector_helper_add(connector,
 				 &panel_bridge_connector_helper_funcs);
 
-- 
2.43.0


