Return-Path: <linux-kernel+bounces-169920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF4D8BCF4C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BB52838EB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B04012AAE6;
	Mon,  6 May 2024 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqI6QqBA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33ED7BB0F
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002601; cv=none; b=kRq96D285ne2g5YPC/8myY9Hxt1COYT14gr/J7U2kxo3YqD6ADUECkJel7gMwxvT8R8++P/vV1A1fFyNdm+9WjRjdXdg7yEag7gQjKDiSpHJGQTk55uh9lifYnI9C3uCs77dTtxOHVj2XN0CnXhiOv4OLmyQ08u7MJYwacEhdho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002601; c=relaxed/simple;
	bh=paegLAtAIiOzY5eKQeauNPYuwsGxSeeUGgOBWr0kV1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jY3LiY6trMQZ4JDEhzgRJCU2Mhe2nUR+ld4Dje6gCpF+VrYvjwC91w1cdP5SCaBZmQ1HYU5Bb1+hmBsHy3X1alTeuadzYiQ0jC5+/UrEhEVMXwvLOD+NQNnapIFdrFwFRRcctK/5MYplWtQv/q4WjRG0AHtQns35q2xLSnT666U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqI6QqBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D83C4AF63;
	Mon,  6 May 2024 13:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002601;
	bh=paegLAtAIiOzY5eKQeauNPYuwsGxSeeUGgOBWr0kV1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DqI6QqBAEh0SLMoX6jxGMlYEF7hX2qBs28XSz8VMiI1jujVuLsNYoAqiEcAspAaz4
	 Zyp+ea/4k4F9fQg4bs2/DWeuY4Yc/FWTDEInQn8XN1MgHgpeGwF8VYsX1NeIcs6ivM
	 xQ3sJb4SWDoKdOYIC80ppCzDUcx7HYU8Ig8tmph0+spRJzQziEZeyuPuySnCn3hxJS
	 OEMPgZx4Bejm8cLNBMRfkb/Oyfu+1rxtZYXfsR82ol9U4DF4tPlZsBEWbTCONNoGq+
	 +bLz1C7cSHzISiOvmcR+xzL93l5nKPDCoOcpVQgg1xR0NePq2Uj5hlocb3aP95yCM4
	 eZGn1TO44UzPQ==
From: Michael Walle <mwalle@kernel.org>
Date: Mon, 06 May 2024 15:34:49 +0200
Subject: [PATCH 20/20] drm/bridge: tc358775: use devm_drm_bridge_add()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-tc358775-fix-powerup-v1-20-545dcf00b8dd@kernel.org>
References: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
In-Reply-To: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sam Ravnborg <sam@ravnborg.org>, Vinay Simha BN <simhavcs@gmail.com>, 
 Tony Lindgren <tony@atomide.com>
Cc: Daniel Semkowicz <dse@thaumatec.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.4

Use the device resource managed version of drm_bridge_add(). This
simplifies the error handling and we can get rid of tc_remove_bridge().
Also, add a check for the return code.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/bridge/tc358775.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 31f89b7d5a3a..1d2547e4c4e3 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -762,26 +762,14 @@ static int tc_probe(struct i2c_client *client)
 	tc->bridge.funcs = &tc_bridge_funcs;
 	tc->bridge.of_node = dev->of_node;
 	tc->bridge.pre_enable_prev_first = true;
-	drm_bridge_add(&tc->bridge);
 
-	i2c_set_clientdata(client, tc);
-
-	ret = tc_attach_host(tc);
+	ret = devm_drm_bridge_add(tc->dev, &tc->bridge);
 	if (ret)
-		goto err_bridge_remove;
-
-	return 0;
-
-err_bridge_remove:
-	drm_bridge_remove(&tc->bridge);
-	return ret;
-}
+		return ret;
 
-static void tc_remove(struct i2c_client *client)
-{
-	struct tc_data *tc = i2c_get_clientdata(client);
+	i2c_set_clientdata(client, tc);
 
-	drm_bridge_remove(&tc->bridge);
+	return tc_attach_host(tc);
 }
 
 static const struct i2c_device_id tc358775_i2c_ids[] = {
@@ -805,7 +793,6 @@ static struct i2c_driver tc358775_driver = {
 	},
 	.id_table = tc358775_i2c_ids,
 	.probe = tc_probe,
-	.remove	= tc_remove,
 };
 module_i2c_driver(tc358775_driver);
 

-- 
2.39.2


