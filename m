Return-Path: <linux-kernel+bounces-449546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762889F50A6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A7A163E6C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B1A1FCFD4;
	Tue, 17 Dec 2024 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ha2xr/22"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA961FCCE5
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451379; cv=none; b=m2/3IToKxFPwfycCoL2NRi3MEi7aRW+I+irYNnYd1vYUTatly8cFNy+LIZP7qFpwpMWwLYvjntnlas1YKQYAUzpkkNEvXofyXPLdeFRH5vT1ag3pUySnZaPMECXa0XjADz1Sggf0tZGtslNcuSGzwbWvpvq48NG8NZq6f2vSmYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451379; c=relaxed/simple;
	bh=hJzS1uo5+givsqL/5fb54+VJQKeg4alSF/j4ZEKpylY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f3bD1t8uyYRZt4g8Sr37QpJB/s0vYxj1rlN7HWPZE7lvWoCTF6SRSSMo1xlpX8ySg38B/89xWeab0geIABb9BFwUxyeqFcz2TLzfcCZal6HFyGTNhb8ogn4nse17HVaiKTeFPQaq47Mn8k+rgB3lomItbWPpYwewzcn5dcKWNGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ha2xr/22; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 155DEE0006;
	Tue, 17 Dec 2024 16:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734451375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qROB54l4sTs9Za95ZZ+CXnKyMonixc5fKm8IMcBZfU0=;
	b=Ha2xr/22XbkzbEN44/OSSwdMsqu3iRQYv/yK46xgxRlq7nLcv+2x8cBOruzH4zRQO6hrlb
	N7aNcMywkMUp/usvM/QEeFDLILZH6N7s6A3jaF/CgF390jHj0GP3BdHmrv/M9OyghGD6PX
	k1JwIc0og9CvutWxm3mHoTvVM5eFSBam54+OMCFUtTQUui3/kNE+vVrSr3WZOa9Rj4i+RA
	zkk62iQaPgkOxrYoVtl/QHVcNzdQuBV0i+fHmrOLcp/703O7JDu3ihXDynF/+L4mFOw05F
	HqMY9kViMtVzCkbqLtXtmKd/+sr4Nar3hTa2uEkLcKIsMD6E52GL9nDQNflquQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 17 Dec 2024 17:02:51 +0100
Subject: [PATCH RESEND] drm/bridge: ti-sn65dsi83: use dev_err_probe when
 failing to get panel bridge
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-ti-sn65dsi83-dev_err_probe-v1-1-3fdce386400c@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Herve Codina <herve.codina@bootlin.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: luca.ceresoli@bootlin.com

When devm_drm_of_get_bridge() fails, the probe fails silently. Use
dev_err_probe() instead to log an error or report the deferral reason,
whichever is applicable.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 57a7ed13f9965db5a32b601a2a7ca92314c68f7d..60b9f14d769a5489acdfca6c2bb5744d02081315 100644
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


