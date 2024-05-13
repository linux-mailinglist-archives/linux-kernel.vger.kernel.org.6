Return-Path: <linux-kernel+bounces-177755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72078C4445
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4072B1F2473F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A58155388;
	Mon, 13 May 2024 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f1Rtkm23"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CF3155382
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614312; cv=none; b=CJSfUYFYKdq3cvXGfHuSV+gR9/bKYnQWOm+mIfiu17NsYgYTZCvGaxUBY5MH7y+SL4F+OI8ZkTmG1xMeOAt+a3xRDlqHQh21XQdtPfP2Pi8+Nicg/sc3lXvkoLAydcGSqsQ1USUp8bA/mjS9ZmBHgohXLJRPYkD55rwrKos0qic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614312; c=relaxed/simple;
	bh=NXt/J5Ng7rTdX/rOZFBxwTNCGIqRGOYouh6RODjoTzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AaZ2F8n6tZhamwqUzGW1KzUllXqIeObg2sn/EvUrWDd0HqQtfzqHPX8VJfoVZS8GPZsyjRD2ddm7zgZMgh5nvPp/ISpQVQnglrhKGtvipJAaD+7jQTHvkMm/5Vk7dobzEV233AE+0ZgiPU9X6T2MXSwGT73byo1vvSF/fPT0tmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f1Rtkm23; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715614309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5sKe1OXm7dCFpe5iXrNPA4j8NtVh7Vk3MKA9L+jmF7U=;
	b=f1Rtkm23m84bvTk5isa5i8HFrv2NBLfD1VZ4DOeQF3C3SV6nePD4umUszD0aP2H6sc+3DY
	Q/fMSSzb5w5HkaDhhxdkoRQpHJn/lECZ+Z1fKEzaSe/215tKHgh7ArE5q9jHGfvFwUEvIB
	blWGtOJVwsv+ZKCIpAczRr7wxmzNHPI=
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
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 09/12] drm/bridge: synopsys: dw-mipi-dsi: Remove a redundant check on existence of bridge->encoder
Date: Mon, 13 May 2024 23:31:06 +0800
Message-ID: <20240513153109.46786-10-sui.jingfeng@linux.dev>
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

In the dw_mipi_dsi_bridge_attach() function, the check on the existence
of bridge->encoder is not necessary, as it has already been checked in
the drm_bridge_attach() function invocked by previous bridge or KMS driver.
The previous drm_bridge_attach() will quit with a negative error code
returned if it fails for some reasons, hence, it is guaranteed that the
encoder member of the struct drm_bridge is not NULL when
dw_mipi_dsi_bridge_attach() function gets called.

Remove the redundant checking codes "if (!bridge->encoder) { ... }".

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
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


