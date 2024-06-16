Return-Path: <linux-kernel+bounces-216190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7E0909C8B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 10:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05CB81C21746
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5F1186E56;
	Sun, 16 Jun 2024 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHhknxq0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F471850B3
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718526555; cv=none; b=JR+6ziMEK1FVwCZtMNr4MbktKIqyemDNUXBjZnl4saB2WOIN/oXTx6ppvQoBRpyrMISo5yTCUzNHr3jjEe6I+lDrH5Kzf3xKk4/LKZY2iWQVkAL8/uj6lRlSmVkjuAK/1mmuZ8u3rlthuoB/NDgUVJvnnAKJAA41Vd6J506W/Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718526555; c=relaxed/simple;
	bh=r10waYEMGAymNOh3QIyIV85JK6+0pN1kGYW3MVMVAVg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Av64aT4DtGhMRGDJbakCz/2we5HfaqvA8ZoMk+B3xMRtmSgvfWsPCfK23qJXIhfw6ZzYnBMBnYUMIYMO8xVaza8+6piwzIxXgEu5BJ4IH/L/htq7xA5y15LB2dheTqZ+jLwnTAlJkeUAnBtQ9Cbrybx+1I8bPZjJTKlw/6rGdIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHhknxq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C19DEC2BBFC;
	Sun, 16 Jun 2024 08:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718526554;
	bh=r10waYEMGAymNOh3QIyIV85JK6+0pN1kGYW3MVMVAVg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JHhknxq0z6n0TCJmxlOa3vL7BhNIBTyulXx/ftmfPiZRB2t9ESD1JFIGqeXwFqRus
	 d85HzY1IviXo802XZvDksLD+yLAeo/t9NFF3sHkT5aVXdO43OhUsXgPcexfuxgXmNf
	 2Gy1r8Xrt8gMJTCy7F6lp7sJ4QPqGZ0Q+HM/RtdPItIx5RYuOZ0sW/C/TVUB290Y9J
	 eibkwV8tx8DVMjDLmXcs3h6VW/yYl+qWVtvq/4Hqcxv/6sy9O1BCFphtsDVqfUo0Uz
	 9il9Vne3rxX4j396JmfUKg2fy8Kmmpa2WYfKtF4mk1Ifb/ET8ezXaTW7M7A6cBrI5Q
	 aavpwTuyYGFNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EA9C27C6E;
	Sun, 16 Jun 2024 08:29:14 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Subject: [PATCH 00/13] Fix the errors of MediaTek display driver found by
 IGT
Date: Sun, 16 Jun 2024 16:29:10 +0800
Message-Id: <20240616-mediatek-drm-next-v1-0-7e8f9cf785d8@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFaibmYC/x3MTQqAIBBA4avIrBtQ+4G6SrSwnGoILTQiEO+et
 PwW7yWIFJgiDCJBoIcjn75AVQKW3fiNkG0xaKkb2akWHVk2Nx1og0NP743GdlLNddOvuobSXYF
 Wfv/nOOX8ASDqfQljAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718526553; l=1639;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=r10waYEMGAymNOh3QIyIV85JK6+0pN1kGYW3MVMVAVg=;
 b=tingLMnjsTKtbIyzbXebc3jnQb0ioiL1lqGVFCw4e0VaknTStBGtN+rZoSzvDVFJUrNJ/nvBW
 txWOmGBNVd5AWc8Num1/KDshCYgGD3L1Kwcf8Ys7mnaoMpLEmfUC+Sz
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=lq1w8BuWDINX+4JHjGHhhbAU5ICP+cL9VCj7wn+cEDA=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240616 with
 auth_id=172
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

This series fixes the errors of MediaTek display driver found by IGT.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
Hsiao Chien Sung (13):
      soc: mediatek: Disable 9-bit alpha in ETHDR
      drm/mediatek: Add OVL compatible name for MT8195
      drm/mediatek: Add missing plane settings when async update
      drm/mediatek: Add DRM_MODE_ROTATE_0 to rotation property
      drm/mediatek: Set DRM mode configs accordingly
      drm/mediatek: Turn off the layers with zero width or height
      drm/mediatek: Support more 10bit formats in OVL
      drm/mediatek: Support RGBA8888 and RGBX8888 in OVL on MT8195
      drm/mediatek: Fix XRGB setting error in OVL
      drm/mediatek: Fix XRGB setting error in Mixer
      drm/mediatek: Add new color format MACROs in OVL
      drm/mediatek: Support DRM plane alpha in OVL
      drm/mediatek: Support DRM plane alpha in Mixer

 drivers/gpu/drm/mediatek/mtk_ddp_comp.h         |  6 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c         | 85 +++++++++++++++++--------
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c          | 24 +++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.h          |  4 ++
 drivers/gpu/drm/mediatek/mtk_ethdr.c            | 26 ++++++--
 drivers/gpu/drm/mediatek/mtk_plane.c            |  4 +-
 drivers/soc/mediatek/mtk-mmsys.c                |  1 +
 8 files changed, 118 insertions(+), 34 deletions(-)
---
base-commit: 62fe4b067581d480e863191305f108bebffbc0e9
change-id: 20240615-mediatek-drm-next-ad601b349f23

Best regards,
-- 
Hsiao Chien Sung <shawn.sung@mediatek.com>



