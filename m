Return-Path: <linux-kernel+bounces-221483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E8090F446
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DDC28379D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66168158A3A;
	Wed, 19 Jun 2024 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MT+yBYIu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830FE154BE5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815125; cv=none; b=IYQvWh2DxwCQCFijMvNWMLJLvL7GIYn/NPPoEMBkGPOATu6lwlsneBLL4Ld/zqX6n+1NAixE+Bl7UFkcXox5HlcgHMkk8ZDBb3SO2kigO3/aEXUEns+Q6Xz7C02Dd5E+Bg8PDi+WF/AbGeOXws9CoEIsMaZw3cFBQf4Ep+1TUcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815125; c=relaxed/simple;
	bh=QFJzZ2f8/HswaPFNTTO8YkFgvDDXRL8Qp41YYaAOvug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N8mOKayN2QRpnhRF/sh0bHU8dmkvfbxWf4j/BWry3SHWBGQjk+QgGozPTxziC+vgxx3Fhr96QwTprDl9T4yTyYuZ6yh+xtPxgI2aQwrAJh3sBnCYCycbjGJoEag1mfsDTHtF0wh3+wMc+tiXx2rsbhSuWu1U2XN5L4S2vSiy9J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MT+yBYIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CEB8C4AF0E;
	Wed, 19 Jun 2024 16:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718815125;
	bh=QFJzZ2f8/HswaPFNTTO8YkFgvDDXRL8Qp41YYaAOvug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MT+yBYIuVNZ7cmjAI2XU4w5cMbPBYD3vj6rdg0cHG5Dmk7tWYhQUZYSDQjIPeL7Eg
	 Rq0gYVWubH5T+iqTZKYcxbW3/ZWHGzanjNvS5gpjrYOWlTXGHFGz2s492sUdSLRUlG
	 faWngpulACBpUZcrxjA6dM4Zq1pYEuxX9KByHRbyZeB/vrenS+Q0k0aacDiYCsOSsh
	 tAXla22HzGPi/mPSoq2ty0SlNMshf2SXIOCzBYyv/2znfb5neGKoLwz98sEoHTFpsJ
	 XEJeQwC+CJg4/+9pIp0dNo1Kpj5SPiHEso/Aeh1TJ3QQn+ZbwRNiX+DAt6gw8lTwW3
	 yqUlSaA051y5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB5EC2BC81;
	Wed, 19 Jun 2024 16:38:45 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Thu, 20 Jun 2024 00:38:45 +0800
Subject: [PATCH v3 05/14] drm/mediatek: Fix destination alpha error in OVL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-igt-v3-5-a9d62d2e2c7e@mediatek.com>
References: <20240620-igt-v3-0-a9d62d2e2c7e@mediatek.com>
In-Reply-To: <20240620-igt-v3-0-a9d62d2e2c7e@mediatek.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718815123; l=2135;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=rAChFGdFoC8c4exvZmv1sFfltc3v4bPxNFkorgTlPyw=;
 b=/nzXSR2LT5b/JzbTE2HsfTlQ/Sm2B6QzhhZM9OPWslO+9oQ2A2nd0ih+48/0SEhG0JZdjIBLk
 3pmcNsQCRI9B/t1R4U1FwCFw8IPjG3kbqaZJp18j8KDwqTYzHAeEjFT
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=lq1w8BuWDINX+4JHjGHhhbAU5ICP+cL9VCj7wn+cEDA=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240616 with
 auth_id=172
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

The formula of Coverage alpha blending is:
dst.a = dst.a * (0xff - src.a * SCA / 0xff) / 0xff
      + src.a * SCA / 0xff

dst.a: destination alpha
src.a: pixel alpha
SCA  : plane alpha

When SCA = 0xff, the formula becomes:
dst.a = dst.a * (0xff - src.a) + src.a

This patch is to set the destination alpha (background) to 0xff:
- When dst.a = 0    (before), dst.a = src.a
- When dst.a = 0xff (after) , dst.a = 0xff * (0xff - src.a) + src.a

According to the fomula above:
- When src.a = 0   , dst.a = 0
- When src.a = 0xff, dst.a = 0xff
This two cases are just still correct. But when src.a is
between 0 and 0xff, the difference starts to appear

Fixes: 616443ca577e ("drm/mediatek: Move cmdq_reg info from struct mtk_ddp_comp to sub driver private data")
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index bd00e5e85deb..693560fa34e8 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -72,6 +72,8 @@
 #define	OVL_CON_VIRT_FLIP	BIT(9)
 #define	OVL_CON_HORZ_FLIP	BIT(10)
 
+#define OVL_COLOR_ALPHA		GENMASK(31, 24)
+
 static const u32 mt8173_formats[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
@@ -274,7 +276,13 @@ void mtk_ovl_config(struct device *dev, unsigned int w,
 	if (w != 0 && h != 0)
 		mtk_ddp_write_relaxed(cmdq_pkt, h << 16 | w, &ovl->cmdq_reg, ovl->regs,
 				      DISP_REG_OVL_ROI_SIZE);
-	mtk_ddp_write_relaxed(cmdq_pkt, 0x0, &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_ROI_BGCLR);
+
+	/*
+	 * The background color must be opaque black (ARGB),
+	 * otherwise the alpha blending will have no effect
+	 */
+	mtk_ddp_write_relaxed(cmdq_pkt, OVL_COLOR_ALPHA, &ovl->cmdq_reg,
+			      ovl->regs, DISP_REG_OVL_ROI_BGCLR);
 
 	mtk_ddp_write(cmdq_pkt, 0x1, &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_RST);
 	mtk_ddp_write(cmdq_pkt, 0x0, &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_RST);

-- 
Git-146)



