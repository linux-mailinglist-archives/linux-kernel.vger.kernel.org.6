Return-Path: <linux-kernel+bounces-221239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E3F90F0BE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BBD31F25A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA8B1527A0;
	Wed, 19 Jun 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNpuobnk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BF645BEF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807535; cv=none; b=bdWo4z+0mx3KC9ig9rHPrXCe0Tp6+MU6IHiuP9VLOO6yzcdIRyh7rF6+4bv0Pi6ct1ymG9DMaISZ7psT20fE3D8gwGXPC1Xykth8KUTUaJLh1GhP9IcU5/5EY2UBpk8co4yBn1KidJD6CaIrA4ci4glgd6ySOlLcCSQE0q6EUjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807535; c=relaxed/simple;
	bh=7I8aImA7pkdTjSfDGsH5pzBGFaEl5gU0gk3Hz8BCIzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rVHCE6HUQaD6x5nv9c5h8Bytf7fJ+gUdo0ILSkDZ3Mt9RcX9IxgSPmPPG5fRqMeXTpmh2mN+cvY4WJpAIVWb/HcCNqL1oe35HBxIInnIq2K5nQ80HU3XQDkPKhZLLTv9/0ODbIYGJAu0V7U4zdo7dOoV3ZVF8jDx0itK5zJVB5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNpuobnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21F20C4AF5F;
	Wed, 19 Jun 2024 14:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718807535;
	bh=7I8aImA7pkdTjSfDGsH5pzBGFaEl5gU0gk3Hz8BCIzM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HNpuobnklSoOj6aoufKEc5UePTl0BWcI/G/ndpkPM9zPy5kj3U2LDjds5ybUlp75S
	 8fnLhqeQ8t6DWJbl8zF1D6Sf51KoN/4KPDsykjLTRurzzE3tbohiHoGajXwD9b7P9X
	 9uwhUlPOVYE4e04JaQdiUX4CCL8eFoqk2i+jQzAtFk6yDymQNpmU2RGs4/WRyQ/SUf
	 myWdceJQIhMTa3tr3ld/0GdrZBOnclo8lbLJr1Bxor0+CwYt2kBvo7nbXDGLGUL7YQ
	 9UipZRzs9uSXx9lAvq+Oa6XFRGrJqvFwf16yAlzMy8NA1Np8Mr+4TVI4GSpIgt4g1q
	 HTGTjPhv/9bYg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BE9C27C79;
	Wed, 19 Jun 2024 14:32:15 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Wed, 19 Jun 2024 22:30:54 +0800
Subject: [PATCH v2 13/14] drm/mediatek: Support DRM plane alpha in Mixer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-mediatek-drm-next-v2-13-abf68f46f8d2@mediatek.com>
References: <20240619-mediatek-drm-next-v2-0-abf68f46f8d2@mediatek.com>
In-Reply-To: <20240619-mediatek-drm-next-v2-0-abf68f46f8d2@mediatek.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718807531; l=984;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=wRuukHEj6ar3MzrXsZ6wMBC1YWkwtR1Cd5NiPWkH4fQ=;
 b=mXffXrDFXrHd8s/MoUIUUbt/P7yp7KbzAnh4zOUemxlxHfiBroL5wHk35yF0/DMHdRIAWLfR2
 d4oOEUBWMpeA2jzbQDTSaw/jhwFjI+xMSQDX1+voFSDc/N3erHWWKGS
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=lq1w8BuWDINX+4JHjGHhhbAU5ICP+cL9VCj7wn+cEDA=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240616 with
 auth_id=172
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

Set the plane alpha according to DRM plane property.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_ethdr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
index bf5826b7e776..36021cb8df62 100644
--- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
+++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
@@ -170,8 +170,10 @@ void mtk_ethdr_layer_config(struct device *dev, unsigned int idx,
 		return;
 	}
 
-	if (state->base.fb && state->base.fb->format->has_alpha)
-		alpha_con = MIXER_ALPHA_AEN | MIXER_ALPHA;
+	if (state->base.fb) {
+		alpha_con |= MIXER_ALPHA_AEN;
+		alpha_con |= state->base.alpha & MIXER_ALPHA;
+	}
 
 	if (state->base.fb && !state->base.fb->format->has_alpha) {
 		/*

-- 
Git-146)



