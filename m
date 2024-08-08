Return-Path: <linux-kernel+bounces-279241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4174094BADF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B222B226F2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F7818A6A8;
	Thu,  8 Aug 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="knX2YFbF"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3DF184526
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112783; cv=none; b=hywRTg5E9N3mySg2flh5SyTtu25WYOfJBNFAttNpY2UNyv49T7SkEZRW3u9mmPts7/BKachW263LM5Sd0GKFIj7jKhs4FNnFQYLF+ad8JChamv7eafBIgQqXQC3e8ffyk5D+OAHL+c/e/OxZ/SMugs4thCw+tgVs8LRZWQHUrIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112783; c=relaxed/simple;
	bh=rflHku7qbVAbCcQdQgA7LvHtyIZj06d1LIF0k/gF8Kg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mjd41uktRji6rikcJwC3UkSXSvFVeEs8BhdZHp+mU4oIhwjXwFwlQIeSP6gGLMduiDAPNaV9GZV2fLCAxr9OJ2MHnN92pPYZKlhxfwmx8kej4RYo96+1lpvgpbD9t5NoJi/zYSvASWp8GT7jkYYyEj5dUq2+ivPJCgnmAz/8hz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=knX2YFbF; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 43328C0008;
	Thu,  8 Aug 2024 10:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723112779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VKqPc2zvztu8ZjTTtHQ7KbDNfyDn+rWRkCx6dA0D/as=;
	b=knX2YFbF0IkUaVgtfA7NITlpMDxKAXD+0Dcpwpzg2lmoZi/VUqS8S0Ztg+y2bFoFdD3afk
	6M2DoTG3UbOxyWDWB1uCT5iRJbjE6vl+iu97LAGIBVXACkdTWYXKWuBvu6vCABxP2FOfAW
	2PiLr4QvfcpqPVxEQk6aCutL2z/FsBq1TM9jWpEKxRwrDnXqHBqQ71tpsMqAauWb34/CWd
	6MEAXUmtvB20zo98owfxLdkyOAtV88a70kXSoMTY9gkLhmBVWPb4u3BH1DdL6ysMabIxLc
	YPXHiCjU3Tj61gLaLU1DXVBqUzMqZ1bcZUFoZCOqokM72h2IVfq7oDUW3w7zEg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 08 Aug 2024 12:26:14 +0200
Subject: [PATCH] drm/bridge: ti-sn65dsi83: use dev_err_probe when failing
 to get panel bridge
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-ti-sn65dsi83-dev_err_probe-v1-1-72417aa275ab@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAEWdtGYC/x3MzQpAUBBA4VfRrE1dv11eRRJmMJtLM5KSd3ezO
 fVtzgPGKmzQJg8oX2Kyh4gsTWDexrAyCkVD7vLSeefxFLRQV2TiCyS+BlYdDt0nxsbTuDiKmTK
 Ig0N5kfufd/37ft+746tsAAAA
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: luca.ceresoli@bootlin.com

When devm_drm_of_get_bridge() fails, the probe fails silently. Use
dev_err_probe() instead to log an error or report the deferral reason,
whichever is applicable.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 57a7ed13f996..60b9f14d769a 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -606,7 +606,7 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
 
 	panel_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 2, 0);
 	if (IS_ERR(panel_bridge))
-		return PTR_ERR(panel_bridge);
+		return dev_err_probe(dev, PTR_ERR(panel_bridge), "Failed to get panel bridge\n");
 
 	ctx->panel_bridge = panel_bridge;
 

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240808-ti-sn65dsi83-dev_err_probe-98daf0ddafb1

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


