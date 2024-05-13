Return-Path: <linux-kernel+bounces-177751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7118C4441
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A731F24AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869671552EE;
	Mon, 13 May 2024 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cw4tRIsd"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07ED1552E6
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614299; cv=none; b=obqN7/lRgDKx+B0tVbN8Z86mgasvfYBsJPSkXMSWaLuQ74fsjvwPcZPB86kVVlDngWwBgyTxA1oGxxta5n+6ejLhSKTZqepLDMEv0Jd8OlhzTEf0JqF5lHJT2PlyA8qoLkO/BAouM+iYdQcV6kf8qzvfWJXDj3Cn6W21O/x3Cbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614299; c=relaxed/simple;
	bh=wa+tJxJQlgXE02oZU23FSCgQH8hmKCXfTbUikz2I43g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFofJHDtZOEFW1CHbf0dvgDmS36WAh6FfyRu5GDpDrKSt56FraRLOMytPL+ZtSlh2B3ImSkxgEMPnP8RTNluvJpFGQBqMKOKKvpQODCFe61dE3/Kc/pmnZbep9UCchMqI44sNiw04Lp6BlD2kANnNCFVtqsgXUHkifwwFmhlMMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cw4tRIsd; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715614296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDFYXwTyTrz+GVTosm5TTL0X5z5slov+AkciH3erF0Y=;
	b=cw4tRIsdJz9b1hZUYpylnVeS3YuHdagO7osHbd96/U6R0w3jlXpGYMVZ8ET5QL0p6hWQUY
	V4K56+7jLQ0Hc+i5z2Kmu+hEMA6CgLc8OLZgTGCda5zmYkfGmtzdBRuVr3G6Yq+3IAdpRc
	LUqoYXZiY1D2ML2QT/FRax/EQfVZB5w=
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
Subject: [PATCH v2 05/12] drm/bridge: it6505: Remove a redundant check on existence of bridge->encoder
Date: Mon, 13 May 2024 23:31:02 +0800
Message-ID: <20240513153109.46786-6-sui.jingfeng@linux.dev>
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

In it6505_bridge_attach(), the check on the existence of 'bridge->encoder'
is not necessary, as it has already been checked in the drm_bridge_attach()
which happens prior to it6505_bridge_attach() get called. Note that the
it6505_bridge_attach() will only be called by .attach() of the previous
bridge or KMS driver. The previous drm_bridge_attach() will quit with a
negative error code returned if it fails for some reasons. Hence, it is
guaranteed that the .encoder member of the drm_bridge instance is not NULL
when it6505_bridge_attach() function get called.

Remove the redundant checking codes "if (!bridge->encoder) { ... }".

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 3f68c82888c2..469157341f3a 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2882,11 +2882,6 @@ static int it6505_bridge_attach(struct drm_bridge *bridge,
 		return -EINVAL;
 	}
 
-	if (!bridge->encoder) {
-		dev_err(dev, "Parent encoder object not found");
-		return -ENODEV;
-	}
-
 	/* Register aux channel */
 	it6505->aux.drm_dev = bridge->dev;
 
-- 
2.43.0


