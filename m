Return-Path: <linux-kernel+bounces-256147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C21E9349D4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEFBE28617A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCF47A715;
	Thu, 18 Jul 2024 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dOaL89Mt"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE278C89
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721291099; cv=none; b=Z5S1IU7/L+u8UUTiSUY90lIj2Ph2B6LXXeyiskqTTIZlhm9RM4WmkHfvdazBA0molVOeTwEq1J9B1q5q4LQJ2f6NrMiW0ivCoGOU6pblm0czJUk/S1IaGK0ALGcQKrP3QTYt5mjF0BH1guXosGkqINfhF6SNLn7EuJtNpYXTVwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721291099; c=relaxed/simple;
	bh=ZgrQFJ7/oULh9Q6A7i2K3WLnjzFHQSZPA2NyP1+Yons=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BmGvXiXqfZHacgGBYhlZILsGgP/IWbNsettfB9/zuWFlH3xCjWdClZEeMRnDbGcwP4Tls+T6iOx38QJGCjs74yy6DeENXp3ky4kHq2RuVc0OqWnYJ9yEfKVPWdmp30CkPwN0b3ogrTB0M+TgxTNI1Jbu68ST9kTNqWgc3RUaP/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dOaL89Mt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721291089;
	bh=ZgrQFJ7/oULh9Q6A7i2K3WLnjzFHQSZPA2NyP1+Yons=;
	h=From:To:Cc:Subject:Date:From;
	b=dOaL89MtzMwa9QoFcu9LIp6ohBOI59uJ0Gcnsn6uGpM0ub+K2Qf/bnRrW8BiNEG3h
	 QthT0HtMDJ4zlqEjejGxFcmQtbKtg3p18vgfwwUYFY9ExaJj1N2RW1ecY2QlizHcC+
	 MB9FPDZa8ghV1H/eJYnPtH/+bSWILA0mZPOVp7NcAK6kLJyYW0XAuyweFcPifuAyKt
	 K2Q+X2CA/9U5WRU+2lkL7OOFbcBz5HF/ZhFjjeQCZnhFkcARCxjLrIJ9VT/0LqoH2s
	 N5qhU5p6s6Pf4YiLB9W/CZpz8xUVgbcpJtEDr9FjAGN3VCubzJwJE3y9r22kgDBK22
	 Fu7u1o8sxE2mQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BE69D3780EC6;
	Thu, 18 Jul 2024 08:24:48 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	shawn.sung@mediatek.com,
	ck.hu@mediatek.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] drm/mediatek: Set sensible cursor width/height values to fix crash
Date: Thu, 18 Jul 2024 10:24:10 +0200
Message-ID: <20240718082410.204459-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hardware-speaking, there is no feature-reduced cursor specific
plane, so this driver reserves the last all Overlay plane as a
Cursor plane, but sets the maximum cursor width/height to the
maximum value that the full overlay plane can use.

While this could be ok, it raises issues with common userspace
using libdrm (especially Mutter, but other compositors too) which
will crash upon performing allocations and/or using said cursor
plane.

Reduce the maximum width/height for the cursor to 512x512 pixels,
value taken from IGT's maximum cursor size test, which succeeds.

Fixes: a4c9410b31ca ("drm/mediatek: Set DRM mode configs accordingly")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 6f0b415a978d..b96763664c4f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -540,8 +540,8 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	}
 
 	/* IGT will check if the cursor size is configured */
-	drm->mode_config.cursor_width = drm->mode_config.max_width;
-	drm->mode_config.cursor_height = drm->mode_config.max_height;
+	drm->mode_config.cursor_width = 512;
+	drm->mode_config.cursor_height = 512;
 
 	/* Use OVL device for all DMA memory allocations */
 	crtc = drm_crtc_from_index(drm, 0);
-- 
2.45.2


