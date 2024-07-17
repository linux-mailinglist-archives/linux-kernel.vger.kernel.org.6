Return-Path: <linux-kernel+bounces-254689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AF5933664
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6457C1F23D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB45200DB;
	Wed, 17 Jul 2024 05:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0DNpzQR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB0F11720
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 05:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721193886; cv=none; b=NZbGDNcWz27dYV1mD9EUTt6GZxmjo/FH6EkcZoRUwC3NlswDemRb86vpbmlyBfzbWYE9DTw7tz9chCzoEYbhvmNHjHJDQtZcNQQdpMlUKAHnjo34aj6D4sqlDEjomaZm7p4DzDvFeOuDoO/nLT9vplWoj+tpYeDSMEqnujYME2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721193886; c=relaxed/simple;
	bh=fyYXOHu9fHp+yDLi4tjopWasn0OOj6F3xVVYEta73ZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b4XpeuygFiFmxbDWU10rN+fInbIH71EeUKMEOwxKYK5/uS+O79vPg1fwOGQ4dVVJKcCPmXQxWcWAfj4M7D228bT8FyB05FiCT1Ejkt+UfzuKFpNOe9r08JrjlZabwDykbZIMkk4Utsfz/r+n9sWWX2Z+yP2lGaJ9JsdFgFzZiV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0DNpzQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51F5BC4AF13;
	Wed, 17 Jul 2024 05:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721193886;
	bh=fyYXOHu9fHp+yDLi4tjopWasn0OOj6F3xVVYEta73ZQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=k0DNpzQRDPx8LLqKG59JC5qmy1YOqQNEs5bmabn55M8xUFp+wSFVRridT70TnduvY
	 7aa/RKNIbJ7RtRBsnY2HBr2yq4y6HFjTg6SeJXr68oIgO7FPb1sL0EXGut/TsIxEgE
	 DHQ7288/sYeqZHYstp0FX65EGpscS1NudXr15mRw7mrmpWRCtgd62xDoTR/jMO040k
	 E1+Q1pG126js6wtx+0kgZLlxl0tj3vCgnZIi2ef/x4iHNcrEh+uSLwpplvqbcX42mp
	 yK7o5nCZeiV/rsy+2uKV7dMv6UfRu8txklj8S/8c4Rn0QLhTk2/DzBZRWDvEMQaeDs
	 d11yircN7bVlg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4638FC3DA42;
	Wed, 17 Jul 2024 05:24:46 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Wed, 17 Jul 2024 13:24:45 +0800
Subject: [PATCH v4 5/5] drm/mediatek: Support alpha blending in display
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-alpha-blending-v4-5-4b1c806c0749@mediatek.com>
References: <20240717-alpha-blending-v4-0-4b1c806c0749@mediatek.com>
In-Reply-To: <20240717-alpha-blending-v4-0-4b1c806c0749@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>, 
 CK Hu <ck.hu@mediatek.com>, Hsiao Chien Sung <shawn.sung@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721193884; l=2210;
 i=shawn.sung@mediatek.com; s=20240710; h=from:subject:message-id;
 bh=NXMVY+5up48Xsv5+9pKY3kYmUYHXnlx5rItB6cJy0f4=;
 b=qPLQi6C96RpE78tAkBytO4OSi0fwdJOcpP6FcHQkDdR6SkrD9IfkRhPs4zgCjQBF2Ay17XZG8
 NldT43LQNpXDF1jgUO2PAxdkGHLEeBuiGP2EyvG/Km0DHDHnxYI8UgX
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=VRlGZ3diQkQtpDd8fCL9/mx+TpZStm08pg8UPaG1NGc=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240710 with
 auth_id=184
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

Support "Pre-multiplied" and "None" blend mode on MediaTek's chips by
adding correct blend mode property when the planes init.
Before this patch, only the "Coverage" mode (default) is supported.

For more information, there are three pixel blend modes in DRM driver:
"None", "Pre-multiplied", and "Coverage".

To understand the difference between these modes, let's take a look at
the following two approaches to do alpha blending:

1. Straight:
dst.RGB = src.RGB * src.A + dst.RGB * (1 - src.A)
This is straightforward and easy to understand, when the source layer is
compositing with the destination layer, it's alpha will affect the
result. This is also known as "post-multiplied", or "Coverage" mode.

2. Pre-multiplied:
dst.RGB = src.RGB + dst.RGB * (1 - src.A)
Since the source RGB have already multiplied its alpha, only destination
RGB need to multiply it. This is the "Pre-multiplied" mode in DRM.

For the "None" blend mode in DRM, it means the pixel alpha is ignored
when compositing the layers, only the constant alpha for the composited
layer will take effects.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_plane.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_plane.c b/drivers/gpu/drm/mediatek/mtk_plane.c
index 1723d4333f37..5bf757a3ef20 100644
--- a/drivers/gpu/drm/mediatek/mtk_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_plane.c
@@ -346,6 +346,17 @@ int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
 			DRM_INFO("Create rotation property failed\n");
 	}
 
+	err = drm_plane_create_alpha_property(plane);
+	if (err)
+		DRM_ERROR("failed to create property: alpha\n");
+
+	err = drm_plane_create_blend_mode_property(plane,
+						   BIT(DRM_MODE_BLEND_PREMULTI) |
+						   BIT(DRM_MODE_BLEND_COVERAGE) |
+						   BIT(DRM_MODE_BLEND_PIXEL_NONE));
+	if (err)
+		DRM_ERROR("failed to create property: blend_mode\n");
+
 	drm_plane_helper_add(plane, &mtk_plane_helper_funcs);
 
 	return 0;

-- 
2.43.0



