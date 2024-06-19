Return-Path: <linux-kernel+bounces-221490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7E490F44C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAAB71F2350A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB91158DC2;
	Wed, 19 Jun 2024 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5OeZAyv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4422155C9A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815125; cv=none; b=IlcEHwgLiplsN3ElkVM31hzZ9BDiJbCqOVikNjB5JJhW0UYBekWrHR3zCdWy2L8x8i6btWIjJYgs1qZQUa9Mb29wn+yXfrXWnUjIBeJcKsJ7khtulHIgw+AfYxpE/0fh93RnGh9OlzrTAkncIJ3mdIjwKtObrn5b2ENeNHy53a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815125; c=relaxed/simple;
	bh=174xgO3FAaMIMEutv8ul3EAHVALJuN8tZ9V4NP+gdoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CX6BMCWtOkH1tI4EumlBvYcUw8UICMwflbuEJ/LLFZ5fTnf72K9KJnkZ61NGcpt9AwX+Dc5kdUf7VdzPYN5vdWDYj1fYnm/xU4t+/Plp+RBYD+xbmRybwJ1PP2xpAjVbRXoB9dGx9YqXVlx/AtODGEIncuu2moHG8fMj8Es5enQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5OeZAyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72CB7C4AF19;
	Wed, 19 Jun 2024 16:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718815125;
	bh=174xgO3FAaMIMEutv8ul3EAHVALJuN8tZ9V4NP+gdoE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=N5OeZAyvSdTN2gEAkoJyOI0UFeYqSQQ+4iODSYKA3g7O3JH/cfIcOmIwhxQ6COzPd
	 ur7NILEURakB/4xpEVxJteo1lfS3y90IxXIT0eLEDVPqIZ27sgFd9AP+DN2Q6PNPIt
	 QDFdNCCzX+vgN7IDGJLRixsL9kIEbn7h7Fhl2iGhQLBSpq46YBWFA90p2NABwVma29
	 LU+2qMNq4Q33wxW9o/5uCd2kdg6vjQ10afrCwHqubjbvHt+tmiusXVoZ0PY6DKEi2d
	 AtYvzSlJBeq8u04BvjOj/09diw+I4fR8R0PBWYO4J+971YlDIyzsNK23NKuK4GMZ0f
	 4cMeIXikuoNxA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0FFC27C79;
	Wed, 19 Jun 2024 16:38:45 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Thu, 20 Jun 2024 00:38:52 +0800
Subject: [PATCH v3 12/14] drm/mediatek: Support RGBA8888 and RGBX8888 in
 OVL on MT8195
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-igt-v3-12-a9d62d2e2c7e@mediatek.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718815123; l=920;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=NNek4fczNw9y3anmAELzLLOsbkQDIWEXnqDftyXPIKc=;
 b=L4LJnpsi/Uyl4YnnTuIjtET3CKtDN9lZ49OkTJ8RnvZ0VdCUDJh1YFO2FdQg2L5cqKofESSN8
 K8dDBj+9NJcD2JgiqzOOnJMviXP0rzs4LVJQkXYUwMszkf4RXCsI2Hs
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=lq1w8BuWDINX+4JHjGHhhbAU5ICP+cL9VCj7wn+cEDA=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240616 with
 auth_id=172
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

Support RGBA8888 and RGBX8888 formats in OVL on MT8195.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 767338206780..943db4f1bd6b 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -119,6 +119,8 @@ static const u32 mt8195_formats[] = {
 	DRM_FORMAT_XBGR8888,
 	DRM_FORMAT_XBGR2101010,
 	DRM_FORMAT_ABGR2101010,
+	DRM_FORMAT_RGBX8888,
+	DRM_FORMAT_RGBA8888,
 	DRM_FORMAT_RGBX1010102,
 	DRM_FORMAT_RGBA1010102,
 	DRM_FORMAT_RGB888,

-- 
Git-146)



