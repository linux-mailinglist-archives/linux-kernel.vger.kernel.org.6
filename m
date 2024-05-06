Return-Path: <linux-kernel+bounces-169894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BBD8BCF17
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5B01C227DB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BF87E0E4;
	Mon,  6 May 2024 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtKnAA/X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF17078C9E
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002503; cv=none; b=Sr9ZQV1QfvNKDib5m8BYASaa2cETCu1ZitZ7020wMWa40YVtlt3kqbk1FxOGGyXIoSwMlQPVQEpeIFCSJ+CPDcodM62X09csxkdkDs/Lb4uKyzcA9WFS2FdEdEQqaQGGxSy2iSfOeI1HMASO9V+KyduB46ulU3pHQbJqpYza7tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002503; c=relaxed/simple;
	bh=7KQKdwRJtBFZkLdfMhs2OLN3qUwlGvTF8MBUDqOjd3s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KHLsthptXWe7tsLOqF2mj8m6FMwU3biE1eDf0tZ2eUWKjC7Ld76oZxd3kF/VvCKFCMxelOFgL5hF9AsSSsIbdsSpb3+KuPrtvYl4YUW6t6p/U2uc1GqpZ6rf3AeG4XP7dQGdOAI40Lafi8F9iB3JQQCg/yDLwqWzQqYJj5bqm38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtKnAA/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0E4C116B1;
	Mon,  6 May 2024 13:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002503;
	bh=7KQKdwRJtBFZkLdfMhs2OLN3qUwlGvTF8MBUDqOjd3s=;
	h=From:Subject:Date:To:Cc:From;
	b=XtKnAA/XWOfsPqfFPNMzDVsGyICjYHcSlf8yN7QfZtjlSZqSiy5hAzHxSY8rsgFJw
	 3/hyujLhOEw1+5r+M6JvWl7pIFUa759fB+oMeFWlMjrnpyy/jbd6Wcgfw5Y7L8e4ew
	 FOZG46X4xaoX09TdyFSn6ZQf1dSKkjYei64HiVGsq42hEqOtxuBnw7BwPEPZRpVhhy
	 KTQDbLBkXcbirv4Ug2rw8AvhFbgFpQcT2myKjRx2vLHBf83Szm0wich1/Jp9Zq51Ge
	 s0S261RfU+xxKJ0DjL64p/1LO0WzWkNKtRwEyPkWRG/lQJshAOVx0XKzGhpo1TToeS
	 9xAidLnwcpCgg==
From: Michael Walle <mwalle@kernel.org>
Subject: [PATCH 00/20] drm/bridge: tc358775: proper bridge bringup and code
 cleanup
Date: Mon, 06 May 2024 15:34:29 +0200
Message-Id: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGXcOGYC/x2Myw5AMBAAf0X2bJOlreJXxEFY7IWm9Uoa/65xn
 ExmIgT2wgHaLILnS4LsW4Iiz2Bch21hlCkxlFRqMlThMSpTW2twlgfdfrM/HRo164ZIq8I2kFL
 nOel/2/Xv+wEve/DHZgAAAA==
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

This patchset fixes the bridge initialization according to the
datasheet. Not sure how that even worked before. Maybe because the
initialization was done prior to linux (?).

The bridge has some peculiarities:
 (1) The reset has to be deasserted in LP-11 mode
 (2) For I2C access the bridge needs the DSI clock
 (3) The bridge has to be configured while the video stream is
     disabled.
 (4) The bridge has limitations on the display timings. In particular,
     the horizontal pulse width has to be at least 8 pixels wide and
     both the horizontal pulse width as well as the back porch has to
     be even. According to the datasheet the horizontal front porch as
     well but in line sync mode, this is ignored. Also line sync is the
     only supported mode for this bridge, therefore, the front porch
     is always ignored.

The most controversial patch is probably "drm/bridge: add
dsi_lp11_notify mechanism" which is needed for (1) above. Some time ago
there was a series [1] to add a manual power-up, which was abandoned and
which didn't suite the needs for this bridge anyway.

Also, this will gradually change the tc_ prefix to tc358775_ while the
functions are refactored.

The bridge was successfully tested on a Mediatek MT8195 SoC with the
following panels:
 - Innolux G101ICE
 - AUO G121EAN01.0
 - Innolux G156HCE (dual-link LVDS)

[1] https://lore.kernel.org/r/20231016165355.1327217-1-dmitry.baryshkov@linaro.org/

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
Michael Walle (20):
      drm/bridge: add dsi_lp11_notify mechanism
      drm/mediatek: dsi: provide LP-11 mode during .pre_enable
      drm/mediatek: dsi: add support for .dsi_lp11_notity()
      drm/bridge: tc358775: fix regulator supply id
      drm/bridge: tc358775: add crtc modes fixup
      drm/bridge: tc358775: redefine LV_MX()
      drm/bridge: tc358775: use regmap instead of open coded access functions
      drm/bridge: tc358775: remove error message if regulator is missing
      drm/bridge: tc358775: remove complex vsdelay calculation
      drm/bridge: tc358775: simplify lvds_link property
      drm/bridge: tc358775: reformat weird indentation
      drm/bridge: tc358775: correctly configure LVDS clock
      drm/bridge: tc358775: split the init code
      drm/bridge: tc358775: configure PLL depending on the LVDS clock
      drm/bridge: tc358775: dynamically configure DSI link settings
      drm/bridge: tc358775: use proper defines to configure LVDS timings
      drm/bridge: tc358775: move bridge power up/down into functions
      drm/bridge: tc358775: fix the power-up/down delays
      drm/bridge: tc358775: fix power-up sequencing
      drm/bridge: tc358775: use devm_drm_bridge_add()

 drivers/gpu/drm/bridge/Kconfig     |   1 +
 drivers/gpu/drm/bridge/tc358775.c  | 601 ++++++++++++++++++++-----------------
 drivers/gpu/drm/drm_bridge.c       |  16 +
 drivers/gpu/drm/mediatek/mtk_dsi.c |   8 +-
 include/drm/drm_bridge.h           |  12 +
 5 files changed, 355 insertions(+), 283 deletions(-)
---
base-commit: 9221b2819b8a4196eecf5476d66201be60fbcf29
change-id: 20240506-tc358775-fix-powerup-53f490043179


