Return-Path: <linux-kernel+bounces-176569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4E38C31C5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 16:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C168C1C20C31
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 14:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0275A535D4;
	Sat, 11 May 2024 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M/Vq35uZ"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9159B51034
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715436669; cv=none; b=KIL5rbz+Ewo2ByNSVVAYPKnX2xr0K5cUnTAac4SYxMv3mxIzTPTZsj8aNl9wObTAfbB5h6DcAcZxfMHe5T7lUYZUOP52xGQsyYC8UFr274NHXaZ8Q3kc+1CUlRa7Y/musHVv9Sziby3KOwkz86dbeFc4nTLgaXiZ4Su4t/VSn5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715436669; c=relaxed/simple;
	bh=SClFnaNaoUPwOLdLRJZQWQoVTWwBBrMs120hgkj+3CM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gmr534ypEjokRcPy0nrmrT0xZc7S+aGkCSEYj3eilyQnxQDf7xpWaBypUt3dpce2l7CsTJUDk1pX3+u/V9KHtH6xn8sYc/nn5Lc3ess5JqIIl4sgWgfMB1YCFH7bi4y0tV/Z6Dp9H+g/2oBT2hShKhD2C8MnY226V671bLlcXJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M/Vq35uZ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715436664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a8dPyaiCOoPY+Q3gecWjt41rdV234ZLMDok9YAx2su8=;
	b=M/Vq35uZifBgcnTC/F4xsKyYQDfznva+NcK89//UhM+bURMQYzJ7aA92POckzjBp8cNQjZ
	UTw51PJgIczbbzktCRAQpzXbG4gTEQbjKtoKWIJKOf2KdIsop22c5I1QQJZen2WDaHyNEI
	dbYZVXTIjyiIQ8Ofv7YSaM3RAVI9ExY=
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
Subject: [PATCH] drm/bridge: it6505: Remove a redundant check on existence of bridge->encoder
Date: Sat, 11 May 2024 22:10:56 +0800
Message-ID: <20240511141056.318679-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In it6505_bridge_attach(), the check on the existence of bridge->encoder
has already been done in the implementation of drm_bridge_attach(). And
it is done before the bridge->funcs->attach function hook is called. Hence,
it is guaranteed that the .encoder member of the struct drm_bridge is not
NULL when the panel_bridge_attach() is called.

There is no need to check the existence of bridge->encoder another time,
remove the redundant checking codes "if (!bridge->encoder) { ... }".

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 27334173e911..494030a75dba 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2881,11 +2881,6 @@ static int it6505_bridge_attach(struct drm_bridge *bridge,
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


