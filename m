Return-Path: <linux-kernel+bounces-176575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B31EE8C31D3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 16:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756C72820B1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 14:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1785381A;
	Sat, 11 May 2024 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oh3oh/Uv"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9F5674D
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715437398; cv=none; b=heeUa2oTwIEHP+1ivR/r1bKxI5B5xxXIw0lfrSQRj4KALA1d7u8gRMqfHcfE0H5WGkxhjTI7E6BwbDdx+Ro1WPwu2MHFxKGbd+wZfJZLhxy0WcFvoBFKQ6o68X4XFHrwPyVrzLYBzo9lrKENWuiHtT0HYQpXloUks0RwDlc7uVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715437398; c=relaxed/simple;
	bh=c7fqYBpE6QvcP0bozISJLly85HHN5z+I+0WYEQzIpt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3M4ou9sFC6EDg9iCaEsE9bQMQM362KGOASIJtdyKO0AqtLcKcE2+C8Zr0blFHUWgCb84VaBgiup8R8rZWUPiXzVUOSFcKYq/wIIu2XDSlOiAs9pL3cqD8XejpLV/SECB9l8hZXtYZp/hDanfclJwu/vT58yHK483C8rScucI0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oh3oh/Uv; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715437394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zcYhP9OjsZHGRPynpEjy4cHU+TvGSKNPfAx6ChvpYtU=;
	b=oh3oh/UvEZf9JxPeVrdZ69ZtvLqamC5Pm46sS650b3AqCwuqXt1Jk9Uwfz/bpMkH93VS2E
	lhy9bF+FNiwa0GGlre15fkSw/jKqkOiLkuBNbROyBZX/fceJkFHzdcq3uBGgvNtlahmKab
	04/wkN0zlowYz1seGuhBL+mM5JhKoTs=
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
Subject: [PATCH] drm/bridge: adv7511: Remove a redundant check on existence of bridge->encoder
Date: Sat, 11 May 2024 22:23:08 +0800
Message-ID: <20240511142308.319541-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the adv7511_connector_init() function, the check on the existence
of bridge->encoder is not necessary, as it has already been done in the
drm_bridge_attach() function. And the check on the drm bridge core
happens before check in the implementation. Hence, it is guaranteed that
the .encoder member of the struct drm_bridge is not NULL when
adv7511_bridge_attach() function is called.

Remove the redundant checking codes "if (!bridge->encoder) { ... }".

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index b5518ff97165..1a0e614e0fd3 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -871,11 +871,6 @@ static int adv7511_connector_init(struct adv7511 *adv)
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


