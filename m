Return-Path: <linux-kernel+bounces-177752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3508C4442
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE631F24E95
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAE6155310;
	Mon, 13 May 2024 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DrUk8JYN"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D447155301
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614302; cv=none; b=nYYO8NEJWCdJczMZgkixKltXCDgE7iGH3cgpBw6B9ejwKxTEZPd2gTyqKLqfm3IO5hlyeYjJnnqewCJlJZc9FARx8AtCY/IW7fOv9SXkUYNMh1JPOokrUvoFoFXWuo1JNb6fiL+sLjfqkdHtu0am4uF0N44eEVcximFEReTLUoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614302; c=relaxed/simple;
	bh=lnqw1YTHyaD5vTzvWJEUqngsLI3DDxbgjrRrlUhJypM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlKl3XQDvOcr6VhrCDTyjdbJicYEz3clI8poWr5JwHUB76mNSp9BrooiWrHHTmhXdpL7g1JKQ8WqfjURnHCmiaTWIGxbsIMVW+s6N68g57D4aujEnoN4DLaxO+vgEUudcckX/B8Qktotl43BZYfo4BRhLSopLlD4cWATwP5HCQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DrUk8JYN; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715614299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LGJqJECahkwNkaZ/cGV67QeDc8nXZjPhmnwOmMDzO3M=;
	b=DrUk8JYNcWvrAlPWGbKZ5vymd+/ZTLOLrTm+IESf6ZAkLPN8sjXypzROs9T1GaPvu9cZek
	kT48XheRlnJJSwe86kbdejo7BdYhAMAR6lsT/ZMAEG1y3QB8VLVUy3Cs5znhiSGDlzLzRA
	Fd7poJ1Duj8us1n0DLskdDHmVok2voA=
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
Subject: [PATCH v2 06/12] drm/bridge: adv7511: Remove a redundant check on existence of bridge->encoder
Date: Mon, 13 May 2024 23:31:03 +0800
Message-ID: <20240513153109.46786-7-sui.jingfeng@linux.dev>
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

In the adv7511_connector_init() function, the check on the existence of
bridge->encoder is not necessary. As it has already been checked in the
drm_bridge_attach() which happens prior to the adv7511_bridge_attach()
get called. Also note that the adv7511_connector_init() is only called by
adv7511_bridge_attach(). Hence, it is guaranteed that the .encoder member
of the drm_bridge instance is not NULL when adv7511_connector_init() get
called.

Remove the redundant checking codes "if (!bridge->encoder) { ... }".

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index dd21b81bd28f..6089b0bb9321 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -877,11 +877,6 @@ static int adv7511_connector_init(struct adv7511 *adv)
 	struct drm_bridge *bridge = &adv->bridge;
 	int ret;
 
-	if (!bridge->encoder) {
-		DRM_ERROR("Parent encoder object not found");
-		return -ENODEV;
-	}
-
 	if (adv->i2c_main->irq)
 		adv->connector.polled = DRM_CONNECTOR_POLL_HPD;
 	else
-- 
2.43.0


