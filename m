Return-Path: <linux-kernel+bounces-221478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C04590F443
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C6B1C21287
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27935156669;
	Wed, 19 Jun 2024 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/5JCVZ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5DD153819
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815125; cv=none; b=CVmtFFGiywtIKwP6qN6SXGofuySQq3DCQVM/eUpWigrF+hc3lYWpJpm5ch6eoK57mppRsfy5r8Fe4aMIF+8NmW2W/1I91VNSj7jMfFj4jpeJREpt5i++ziWCVPaw10WjbM/lYza5BCis5baG483BRpBWPAxo1xCrQ+x60ZAeYZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815125; c=relaxed/simple;
	bh=1/Deizd7VSTe2iJzo6qC6np7IrGYcl14e1WZr+sIbJg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BnqNCwmUfywWYVk/8JPHByiHzEXVPx2CeYrM98vUSgvGKg/9NgT8EfsqgVui0e3XNcl8A+Xa2fchFNGEIIZOLHb2o/CGx0Wq7kbU8h3V2EQzBeUcjoylO/f96p+6fdxlbWY8f3uQwzkj7mErk2glS6J0G7leUetTzY453N0C74E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/5JCVZ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB0AFC2BBFC;
	Wed, 19 Jun 2024 16:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718815124;
	bh=1/Deizd7VSTe2iJzo6qC6np7IrGYcl14e1WZr+sIbJg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=E/5JCVZ3BXVCdiSjx9yM6gRmqvoaNrjaDAZ9UzqD54YJWOUxOuEK6HIVRNA3cb3Zq
	 4WHOG1iCPEAQBJAoRLgnEX7YzNacY9eYqfb0xbvDWPhwFcrxdcYcOG3xSz3lKKNgaa
	 BVzDrrkH7rehZdbmFjN6PTL1aXaUA2adXUnyrjWp0TZgF4+XMZNUQSyBaamh+F8uVU
	 DWE5gKDxVSeCsT7DKH1Hg3e5+0DjDY+qvr3WtBH0o5UiLAH4O1ZMhQLoea8vKyCHvC
	 OHpxkPm8+8atc0MSJoscKEDVwAeHSp2c24AFEcQqlZEP7JVaJxobdPQMiZtZ6hx39J
	 rk6Pd6JT0/tkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE18CC27C53;
	Wed, 19 Jun 2024 16:38:44 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Subject: [PATCH v3 00/14] This series fixes the errors of MediaTek display
 driver found by IGT.
Date: Thu, 20 Jun 2024 00:38:40 +0800
Message-Id: <20240620-igt-v3-0-a9d62d2e2c7e@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJEJc2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0NL3cz0El0TS0NL01QjQxMDkxQloMqCotS0zAqwKdGxtbUATts7MVU
 AAAA=
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>, Bibby Hsieh <bibby.hsieh@mediatek.com>, 
 Daniel Kurtz <djkurtz@chromium.org>, Mao Huang <littlecvr@chromium.org>, 
 "Nancy.Lin" <nancy.lin@mediatek.com>
Cc: YT Shen <yt.shen@mediatek.com>, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718815123; l=3450;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=1/Deizd7VSTe2iJzo6qC6np7IrGYcl14e1WZr+sIbJg=;
 b=jSxUNwpSULh9lrpbHUH8cTlzzmFaSiiiXN/JGo95ZbDBiwweC8/NdnathsAnu4DUUsl0rdBqS
 W1fy/hLtNqyAnnI5vunPJ8Dp2Lr+D0ZUFHe+rnoexYNx/E+2jypPD2x
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=lq1w8BuWDINX+4JHjGHhhbAU5ICP+cL9VCj7wn+cEDA=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240616 with
 auth_id=172
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
Changes in v3:
- Modify the commit message
- Add a patch to fix destination alpha error in OVL
- Link to v2: https://lore.kernel.org/all/20240619-mediatek-drm-next-v2-0-abf68f46f8d2@mediatek.com

---
Changes in v2:
- Seperate the changes that belong to another repo (driver/soc/mediatek)
- Move the fix patches to the front of the series
- Link to v1: https://lore.kernel.org/r/20240616-mediatek-drm-next-v1-0-7e8f9cf785d8@mediatek.com

---
Hsiao Chien Sung (14):
      drm/mediatek: Add missing plane settings when async update
      drm/mediatek: Disable 9-bit alpha in ETHDR
      drm/mediatek: Fix XRGB setting error in OVL
      drm/mediatek: Fix XRGB setting error in Mixer
      drm/mediatek: Turn off the layers with zero width or height
      drm/mediatek: Add OVL compatible name for MT8195
      drm/mediatek: Add DRM_MODE_ROTATE_0 to rotation property
      drm/mediatek: Add new color format MACROs in OVL
      drm/mediatek: Set DRM mode configs accordingly
      drm/mediatek: Support more 10bit formats in OVL
      drm/mediatek: Support RGBA8888 and RGBX8888 in OVL on MT8195
      drm/mediatek: Support DRM plane alpha in OVL
      drm/mediatek: Support DRM plane alpha in Mixer
      drm/mediatek: Fix XRGB setting error in OVL

 drivers/gpu/drm/mediatek/mtk_ddp_comp.h         |  6 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c         | 93 ++++++++++++++++++-------
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c          | 24 +++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.h          |  4 ++
 drivers/gpu/drm/mediatek/mtk_ethdr.c            | 27 +++++--
 drivers/gpu/drm/mediatek/mtk_plane.c            |  4 +-
 7 files changed, 126 insertions(+), 34 deletions(-)
---
base-commit: 62fe4b067581d480e863191305f108bebffbc0e9
change-id: 20240615-mediatek-drm-next-ad601b349f23

Best regards,

---
Hsiao Chien Sung (14):
      drm/mediatek: Add missing plane settings when async update
      drm/mediatek: Use 8-bit alpha in ETHDR
      drm/mediatek: Fix XRGB setting error in OVL
      drm/mediatek: Fix XRGB setting error in Mixer
      drm/mediatek: Fix destination alpha error in OVL
      drm/mediatek: Turn off the layers with zero width or height
      drm/mediatek: Add OVL compatible name for MT8195
      drm/mediatek: Add DRM_MODE_ROTATE_0 to rotation property
      drm/mediatek: Add new color format MACROs in OVL
      drm/mediatek: Set DRM mode configs accordingly
      drm/mediatek: Support more 10bit formats in OVL
      drm/mediatek: Support RGBA8888 and RGBX8888 in OVL on MT8195
      drm/mediatek: Support DRM plane alpha in OVL
      drm/mediatek: Support DRM plane alpha in Mixer

 drivers/gpu/drm/mediatek/mtk_ddp_comp.h         |  6 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c         | 95 ++++++++++++++++++-------
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c          | 24 +++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.h          |  4 ++
 drivers/gpu/drm/mediatek/mtk_ethdr.c            | 27 +++++--
 drivers/gpu/drm/mediatek/mtk_plane.c            |  4 +-
 7 files changed, 127 insertions(+), 35 deletions(-)
---
base-commit: 62fe4b067581d480e863191305f108bebffbc0e9
change-id: 20240619-igt-49195e21404d

Best regards,
-- 
Hsiao Chien Sung <shawn.sung@mediatek.com>



