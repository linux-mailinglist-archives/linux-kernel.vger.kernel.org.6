Return-Path: <linux-kernel+bounces-221228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7FD90F0B1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36F528356C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5627647F58;
	Wed, 19 Jun 2024 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N50jyaLT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F15D1F94D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807534; cv=none; b=q5UBiEN2wERbFYLCn3kjHFeqnH+jhnJ5UnEwgCF0OMHDxo4LbYiHJSdQPuapFxzec46n1Htm52czH+dnigWgA1+yYMhWuY92K7EQTvKrgaO4jQqpVdGA+zfEFzpAN6rZtzymLMQfGr6uXdUdKzIUuGmsZZBJEjO7HkiZu/Pox4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807534; c=relaxed/simple;
	bh=Ex+r9nIcVGsNaV245AkMYgu2Uumjenu/XGyFtzZeBh8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Kf4zQKgJHmGc1fbwbYIuRUjuCNKIRDvVDxeOc4qxS2KRNP5AJF2f0RAMtX+xl0LrJF8slM6ExUz1KC2B81zo8xH+f4FZ1O5fO37Wbxn89ohQ2SgZFIJzLYoLRe5fnw2xNp3Egz7iA7pVXII2EbbnQ+UYNScdgpX3UTbbgqk+o4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N50jyaLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 274FDC32781;
	Wed, 19 Jun 2024 14:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718807534;
	bh=Ex+r9nIcVGsNaV245AkMYgu2Uumjenu/XGyFtzZeBh8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=N50jyaLTG9PznN0A0dDA1e/+qkNYARvgyM7yIjEhzw5BwTilaJpfosYaivBWn1FI7
	 nZLVWUNxdjILMW8XQrAxwhVQryp0pk5B27U2mEDEPP5c0ji6Ns284M/hMJZk/67TAr
	 oLR4fwGxIPv2TUm8tGw00aHrbqY+DRYhqCYb7wz97h1Hjq6mmnb2uEyxcWlUOsSve5
	 FjuBp5Uywkn4g0P8YsrwJrDDJ+iPu2ZjC6TAkaosGzwMsch8MnpG5qsjZp9lXcak+x
	 SU8/J50sGOxynumhwZkGPYkeqIeX1NA+QAADFDZKMT19Nv8j5nzy3GwnGjVGj7CSjL
	 agOsyRBYlMyKw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1730AC27C53;
	Wed, 19 Jun 2024 14:32:14 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Subject: [PATCH v2 00/14] Fix the errors of MediaTek display driver found
 by IGT
Date: Wed, 19 Jun 2024 22:30:41 +0800
Message-Id: <20240619-mediatek-drm-next-v2-0-abf68f46f8d2@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJHrcmYC/22NwQqDMBBEf0X23C1J1Kg99T+KB5ts6lI0kohYx
 H9vKnjr8Q0zbzaIFJgi3LINAi0c2Y8J1CUD03fji5BtYlBCFULLEgey3M30RhsGHGmdsbNayGd
 eNE7lkHZTIMfr4Xy0iXuOsw+f42KRv/S06T+2RaLAimrXGFfVpa3vZ+dq/ADtvu9f2iX4AbUAA
 AA=
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>, Bibby Hsieh <bibby.hsieh@mediatek.com>, 
 Daniel Kurtz <djkurtz@chromium.org>, YT Shen <yt.shen@mediatek.com>, 
 Mao Huang <littlecvr@chromium.org>, "Nancy.Lin" <nancy.lin@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718807531; l=1878;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=Ex+r9nIcVGsNaV245AkMYgu2Uumjenu/XGyFtzZeBh8=;
 b=IEF5hiIG3ifgryrF+Y8MlCMNwmu37nVrxSNel1hAFKQ2wAABZithABFddvDCkn8Y1YnQgDEZp
 LDA1of5lYZGBDNJ+BZ1PmMzu1sfs+34qS65GE0u8ENXf099f8DQ9dUY
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=lq1w8BuWDINX+4JHjGHhhbAU5ICP+cL9VCj7wn+cEDA=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240616 with
 auth_id=172
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

This series fixes the errors of MediaTek display driver found by IGT.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
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
-- 
Hsiao Chien Sung <shawn.sung@mediatek.com>



