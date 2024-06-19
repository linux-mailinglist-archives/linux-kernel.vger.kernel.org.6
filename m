Return-Path: <linux-kernel+bounces-221533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7132290F50D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838021C22CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA2E158A0E;
	Wed, 19 Jun 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVxn9UF3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33ED156237
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818032; cv=none; b=cObTmCDUotS/necfM9bPgWjvuhACJCbGAWUxqjYVO6Y+eQvKguH5Il7zce5uweihaHvGKoR5R5ZvPJGQGocdMxh8WVosX2U2cKWIfrS8dGUzT6eJ6AWQY9RUgSiFi4pTHO4AALwtcZxHP0VtxziseYbcP0Y/lAO3oHqCfJ6MYdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818032; c=relaxed/simple;
	bh=jv4d4Oqc5NFEU23JiIU4PcDVItnFp27R9cyRY1Vnzh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hoze8hw37iHBMDhEtQLAs2U8TY87vtq30bMEoPmjoOauQoxZmwyFJRtXyFrySG3JKVrwWKO/2vw/nDNdSZ8aUMljLaMkOdWL0WtGDcMPrVDErpr3hXNIlSANDhy6/+rsltDqehFob4rrsUfpbBY4WPLp2GSOkKoyCxjMzW/c+BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVxn9UF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BBFFC4AF0D;
	Wed, 19 Jun 2024 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718818032;
	bh=jv4d4Oqc5NFEU23JiIU4PcDVItnFp27R9cyRY1Vnzh0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dVxn9UF3ZCDJ7hmqWCGoH64f9+8D3FG6Hn7aJSlGePexeuo+7vGEHn/yh+tyQ7UlE
	 if3dreFQ9aR5ax5K4LntNvbyYJ6tUG8Kf5xZnirTOx6bTlR5vhgqE71x+Vd9bFHdDk
	 l4aWR6gKRIGzd0Rzv449PZnQxy8iNCBqTbw9mvamy1Zv3cs7yntmmVLVkpjGpFBFB1
	 qosAh52qS7MjEIeg91mOL0HuceLUw8xYw4ILF21/ZVaAewoZBfS+JcK9lEmQtNFAz3
	 1q78fV7qhCSoC/oRg2raFONuMkXfSYqzih8PcsNz8c8nzJtxM21D9cBrpkBP3ihx3k
	 sU2yo7tzpJ/VA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F3EC2BD05;
	Wed, 19 Jun 2024 17:27:12 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Thu, 20 Jun 2024 01:27:10 +0800
Subject: [PATCH 5/5] drm/mediatek: Support alpha blending in display driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-blend-v1-5-72670072ca20@mediatek.com>
References: <20240620-blend-v1-0-72670072ca20@mediatek.com>
In-Reply-To: <20240620-blend-v1-0-72670072ca20@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.com>, CK Hu <ck.hu@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718818030; l=2212;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=ZXEEgZdYr6sFLsFE3tObHfLlq5Jjp3gd57RSpJwiaWk=;
 b=cpty0i5L97fiTXnZ0dYhFyfpl2UpFSYmEhpFLKHWC0s/PCJdwNQEYos4jPVBR/lcE9LJuActy
 ELMxdETYKawBFMZNbBHIXqs2vYwFTAh2OPJP9YZv98dfNiHvIeaE98j
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=lq1w8BuWDINX+4JHjGHhhbAU5ICP+cL9VCj7wn+cEDA=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240616 with
 auth_id=172
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
Git-146)



