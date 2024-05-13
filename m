Return-Path: <linux-kernel+bounces-177749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFC78C443F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562141C23232
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6336015443A;
	Mon, 13 May 2024 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bq1IkHpU"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C50E15444E
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614292; cv=none; b=K5T1WCGzBbI+jocbYNs0JNX+3Cru5OzKv6BT+aTpm9jrhrxW9BvN3oYsfO6wV4+BxgqqUuGB4RVuwh2eGK6X1g7H0v56AwyEorqWAjyM1BVBi7AprNO9AA1BgIQcPsLikW4Tynvxa33KNDD1+BkY02Jv2j3Bi1VV41BFUsP9Iu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614292; c=relaxed/simple;
	bh=3pIkhFZutgRbunZ+6pvSexYNkmFQyMQV3MN2fvC5RqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twW4hpf/DiwLz8Y2e2jvApdvCrtqNvlExsrY+ABSM20+SQy91QJ80PZDyrDITyoSpRl8SQDREZq0s2/0VjyCpKigeM0E/aUuKofPNBJByhrhNszaaLo/S/7xljFTAmgZiiBg7S4NPZ7uyRg2TMbHuMBT8Yo37tS3Yabwq8YOtqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bq1IkHpU; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715614289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fieuYk+nURcP7QzRErE1UcUcoViv3rOVeaNarCw66hk=;
	b=bq1IkHpUh3PVQqMCH65q9MHUERq13wniLIxTv634zzNyy189ZqQdXuT9FLRwNpt+pksh0A
	ILgI/8m83EnRIHiJNgd1pWUIs5m35IGlPiH7AZVdD3wYwmrVnmlRtopWdQcgq0WyJZuDGL
	y+KISuWRztOl1y5CmjgADb2YqJkzNQY=
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
Subject: [PATCH v2 03/12] drm/bridge: nxp-ptn3460: Remove a redundant check on existence of bridge->encoder
Date: Mon, 13 May 2024 23:31:00 +0800
Message-ID: <20240513153109.46786-4-sui.jingfeng@linux.dev>
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
the ptn3460_bridge_attach() function get called, and drm_bridge_attach()
will quit with a negative error code returned if it fails for some reasons.
Hence, it is guaranteed that the .encoder member of the drm_bridge instance
is not NULL when the ptn3460_bridge_attach() function get called.

Remove the redundant checking codes "if (!bridge->encoder) { ... }".

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/nxp-ptn3460.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
index ed93fd4c3265..e77aab965fcf 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -229,11 +229,6 @@ static int ptn3460_bridge_attach(struct drm_bridge *bridge,
 	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
 		return 0;
 
-	if (!bridge->encoder) {
-		DRM_ERROR("Parent encoder object not found");
-		return -ENODEV;
-	}
-
 	ptn_bridge->connector.polled = DRM_CONNECTOR_POLL_HPD;
 	ret = drm_connector_init(bridge->dev, &ptn_bridge->connector,
 			&ptn3460_connector_funcs, DRM_MODE_CONNECTOR_LVDS);
-- 
2.43.0


