Return-Path: <linux-kernel+bounces-169918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253D38BCF49
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D636A285685
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D8C12838B;
	Mon,  6 May 2024 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQlzbcin"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5CE86AC8
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002591; cv=none; b=V3IM+frDkKvCAXc/Ralgwbc9YznmC20SzfFxRsu/GYAq2yOrtaL+C3ydWalrHSY28fqSZFXSlA7uJPtiATXAujlmsBJ6od5JfispBhrnkLVtOpA5DEc8IEreZwKXVQyQ/bJYfLWdI5zyVejRnRDi601W4gFOmVF441nQJQo08R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002591; c=relaxed/simple;
	bh=CdCWrZhe83V0sESOJK7U77pyux4Xw5LMdp8ycoT3WUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MK6EMgYZyifq78rvZP4qbvUjwVh4rDnCVKOPTWF3MZG4wlpPv+oEB2DQBfZjEELsinxZ2uqd+ia1OAGc8K/oIRR7dqi1DZN8eCv+H+ZsJxMh8BcLYq97Qb/R1877bM11Kgn/rZpJBHftYBCYGcwfySLFlSNZUg/IIEfAq2KVszg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQlzbcin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062EAC116B1;
	Mon,  6 May 2024 13:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002591;
	bh=CdCWrZhe83V0sESOJK7U77pyux4Xw5LMdp8ycoT3WUE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MQlzbcin9J88aETS0zLDb0nvobS3wtLI2Y4BBLQYro4df7gUI0X62eehQlcKCMs9K
	 WzNcODU+CgRa7rRgSlZR2PuZy/juDvvKr2lyV7KBnids0vcCKxinOR55C1pha6uQZy
	 pqhtmhvqQ3aNOvtmJLcr7CO0vbwcd9m5eT1d1rccugbqf89CHBIJmAdTtGhnqwrCSC
	 gxtn3C9GumjieD7KwgVLmf/H/GEYj6kGebzI6Dt52QbdqE8wyjHv8AwnQ4QdFdcdhg
	 Gai+zjxlTch4LRJBulxLPBOxb6dED1DZOygysJFpsJ5sS4d0sWRi8dBJl54Mw7abqd
	 pUu86gTg+hSrg==
From: Michael Walle <mwalle@kernel.org>
Date: Mon, 06 May 2024 15:34:47 +0200
Subject: [PATCH 18/20] drm/bridge: tc358775: fix the power-up/down delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-tc358775-fix-powerup-v1-18-545dcf00b8dd@kernel.org>
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

Implement the delays according to Figure 8-10 and 8-11 of the datasheet.
In particular, the datasheet states that the *maximum* time between
enabling the VDDIO and VDD is 10ms. Currently, as implemented this is
always violated. Of course, this is only a best effort because we cannot
be sure enabling of the two regulators will be that fast.
The time between releasing the stby GPIO and releasing the reset GPIO
must be at least 10us and not 10ms as it was before this patch. After
reset is released, there must be at least a delay of 200us until the
first HS clock is received.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/bridge/tc358775.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index d5b3d691d2c1..99dbbb1fee78 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -242,18 +242,16 @@ static void tc358775_power_up(struct tc_data *tc)
 	ret = regulator_enable(tc->vddio);
 	if (ret < 0)
 		dev_err(dev, "regulator vddio enable failed, %d\n", ret);
-	usleep_range(10000, 11000);
 
 	ret = regulator_enable(tc->vdd);
 	if (ret < 0)
 		dev_err(dev, "regulator vdd enable failed, %d\n", ret);
-	usleep_range(10000, 11000);
 
 	gpiod_set_value(tc->stby_gpio, 0);
-	usleep_range(10000, 11000);
+	usleep_range(10, 20);
 
 	gpiod_set_value(tc->reset_gpio, 0);
-	usleep_range(10, 20);
+	usleep_range(200, 250);
 }
 
 static void tc358775_power_down(struct tc_data *tc)
@@ -265,17 +263,14 @@ static void tc358775_power_down(struct tc_data *tc)
 	usleep_range(10, 20);
 
 	gpiod_set_value(tc->stby_gpio, 1);
-	usleep_range(10000, 11000);
 
 	ret = regulator_disable(tc->vdd);
 	if (ret < 0)
 		dev_err(dev, "regulator vdd disable failed, %d\n", ret);
-	usleep_range(10000, 11000);
 
 	ret = regulator_disable(tc->vddio);
 	if (ret < 0)
 		dev_err(dev, "regulator vddio disable failed, %d\n", ret);
-	usleep_range(10000, 11000);
 }
 
 static void tc_bridge_pre_enable(struct drm_bridge *bridge)

-- 
2.39.2


