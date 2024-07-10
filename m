Return-Path: <linux-kernel+bounces-247285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ECB92CD8A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1541C1C20CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88DE17B43D;
	Wed, 10 Jul 2024 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T45LtMP5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC41F176254
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601575; cv=none; b=M21oZ5qlVcloIbqquozwldR0JAis2gRogDyZuDTenDAxi1RFAsuMt0kv9bEN4kkWfV7qFdKqm1pZOQyBmiX+XoPXLDsVG2H3UevQGgi+qlnVIle7TfyWLerHfYQd/ZHqmZS2PtKqXuTM2fmb91oOAgMbuiW8ddYEdbi60ifqcNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601575; c=relaxed/simple;
	bh=/Qr7i785NyZoohBvA3+3RT0TBw/MYaFLTRvo1jxRrWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RGHa7Vs1k6JQcfG/R7oo8CDr4p+rxjWUxYHCeJsSHfGrtCyVPf/ybKfS1cm9qwyhFP4+38VHwK1UYRnybO5K+3Q5VUhYwABvewTvkCvoGPfnpJkoynAyZSWIso4e1EQBRYgz7dP8fUo/H77y9OwFg1TiUiZFbxK5TGs8g2QdQR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T45LtMP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A075FC4AF0A;
	Wed, 10 Jul 2024 08:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720601574;
	bh=/Qr7i785NyZoohBvA3+3RT0TBw/MYaFLTRvo1jxRrWk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T45LtMP5wRsE5Ej0WKRR9LkjyAmoyKz5/rduzGT/jyLgqFG1r/2WXEG9uyJmp5BIz
	 dYg02tMV8lN/bGok++PrQ8w3gjibm9fkWwal9o5L2B1j3Zpm9Uuar/IE2FotIkcOA/
	 Pd/Wmvx8A1JkgEteg3jrvBUNuNEmj9xu8p7Uuu/HbP9tc7PGNE85wg27KAWahpGtXf
	 1I4X0xmbBJtPqYw8pNSf+f8LbUWSEO6UeD1xrfaVBQ0kxScIPsLS4Ob7qVLvYmE6N2
	 U7+lyn7RcZYtThjjJ9PidlKz7/Vdz0yiGnegm27fG6AiXOZ/MsPv6epuXXcz5ZtP8L
	 inORK0XAq18hg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B03AC3DA4A;
	Wed, 10 Jul 2024 08:52:54 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Wed, 10 Jul 2024 16:52:52 +0800
Subject: [PATCH v3 2/5] drm/mediatek: Support "None" blending in Mixer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-alpha-blending-v3-2-289c187f9c6f@mediatek.com>
References: <20240710-alpha-blending-v3-0-289c187f9c6f@mediatek.com>
In-Reply-To: <20240710-alpha-blending-v3-0-289c187f9c6f@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>, 
 Hsiao Chien Sung <shawn.sung@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720601573; l=1081;
 i=shawn.sung@mediatek.com; s=20240710; h=from:subject:message-id;
 bh=NVAbOi4mzHiTnH39+TnJjdV+FkeJtbkfCIlftGcvapk=;
 b=UlEWkcPuj+I5gioedwm26FdRkzB4Ci1DkJbei4KhGpz+0voJUedCYLzEwZnsCPWsQzWjc593Z
 vwS+slcoeYLB7huq8B+wvfVNiu/Qpklx8a+X1eZub8aYT66+0AXTyg/
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=VRlGZ3diQkQtpDd8fCL9/mx+TpZStm08pg8UPaG1NGc=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240710 with
 auth_id=184
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

Support "None" alpha blending mode on MediaTek's chips.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_ethdr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
index 9dfd13d32dfa..80ccdad3741b 100644
--- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
+++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2021 MediaTek Inc.
  */
 
+#include <drm/drm_blend.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <linux/clk.h>
@@ -175,7 +176,8 @@ void mtk_ethdr_layer_config(struct device *dev, unsigned int idx,
 		alpha_con |= state->base.alpha & MIXER_ALPHA;
 	}
 
-	if (state->base.fb && !state->base.fb->format->has_alpha) {
+	if ((state->base.fb && !state->base.fb->format->has_alpha) ||
+	    state->base.pixel_blend_mode == DRM_MODE_BLEND_PIXEL_NONE) {
 		/*
 		 * Mixer doesn't support CONST_BLD mode,
 		 * use a trick to make the output equivalent

-- 
2.43.0



