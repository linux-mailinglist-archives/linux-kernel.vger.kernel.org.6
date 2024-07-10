Return-Path: <linux-kernel+bounces-247258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0462C92CD39
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F04DB24BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB557145B0C;
	Wed, 10 Jul 2024 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyproQ6O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2638D13D509
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600643; cv=none; b=YIq6t5zATl2+1LPaaB7Rdph11mdkpI41KP39CmbgmJCwpi4lDfsI12d1BNANrqiNPgTPxPH9XqefuCFWnyJhsfN3cbdYMy3E/poS5AF+q1e8Jl/HL7CTNRGM+JUEPe6yfeanajVsAhJm13Ucxd6+lr91S4z/xUjVIe/GA0huOZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600643; c=relaxed/simple;
	bh=mpbbUI/mfwuOOro+o5eOZMLj6A6beyQDhQ6pgkpGycU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ois4OBtZuJRDVzNEC03PtRZfJFlXnhi5Tw3ZTzpn7CQDoPNwPko5b8Accg5FDvOrgnnJCO5Qkj3KSVs+7ob4eiSG62KzjZPIpS02UHsQRuyCoatBlaVAqaueYYJ/baoKe3qWiZ2EuKYPwJbfTufyHsVqJtynQQB52YrJ9azr194=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyproQ6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8879C4AF0C;
	Wed, 10 Jul 2024 08:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720600642;
	bh=mpbbUI/mfwuOOro+o5eOZMLj6A6beyQDhQ6pgkpGycU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WyproQ6Ok09KxPh5i3X68h/IMVMV8hpu+9K1W5PGqCr+8OTwIi/0KCWkzy4qT5VuY
	 LOnyBKb03nTmqiqmCUXNAclGyhySdoc1gLhlaW1R/IeshrDlPzMjvCTn8A+JCeLL/N
	 06hI6jpFoJjVp9II+rMww+Yq0XG61MT7IaFeG6yPkNVmwFWxGj0SW49DgTP3wk7AcM
	 A2AwU2entnR/fdUPsegQOQI4NTQ68PQfLzSu/3mUKqLt42XSNIieHxTnEYXydPMbFp
	 x1i0lo0Ubw7kBF4SnGuP+WFOe6mMhKco50DD6D3y+LjbHMfGbTl2VZ3rmVzLa1boRM
	 xON0EgFD0BH8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BDFC3DA45;
	Wed, 10 Jul 2024 08:37:22 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Wed, 10 Jul 2024 16:37:20 +0800
Subject: [PATCH v2 2/5] drm/mediatek: Support "None" blending in Mixer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-alpha-blending-v2-2-d4b505e6980a@mediatek.com>
References: <20240710-alpha-blending-v2-0-d4b505e6980a@mediatek.com>
In-Reply-To: <20240710-alpha-blending-v2-0-d4b505e6980a@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>, 
 Hsiao Chien Sung <shawn.sung@mediatek.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720600641; l=1135;
 i=shawn.sung@mediatek.com; s=20240710; h=from:subject:message-id;
 bh=V+WmuBOlE61kgcB5A/JpymRNWhSW2cZJELqH7p6yZBM=;
 b=qo2kqnA8BYODr1XXhQEwuQy1ZySuB5FV/+zsYdB9VQTWywlOfLdLbbFntw8gDVjlJfaZGWEuT
 qNjVJikekxxCiDFFrN/P9CS7YhwuSJmQj8ZUIjGXMcDRwEN5LkLHP9I
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=VRlGZ3diQkQtpDd8fCL9/mx+TpZStm08pg8UPaG1NGc=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240710 with
 auth_id=184
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

Support "None" alpha blending mode on MediaTek's chips.

Change-Id: I9455c367bb74b75461935ecf4a3eb8e429f6e95e
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



