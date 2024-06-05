Return-Path: <linux-kernel+bounces-201586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1ED8FC077
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509511F21AEC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154728F59;
	Wed,  5 Jun 2024 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HPL++jCd"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C341E4409
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547057; cv=none; b=Y81uy1GwQ0QSI+kr7r7kggQDVwByhC1ahG8d5vL74gM+Q6v3M7QyAy3FusBjnlNnrH8Y5tc3GxfQrM31fLGIFBvtplHNqNbJwH5D2LtI7b5xct99fg39KEQF9Q+q6DpdS6zZcHaWV4NU5lcBehHMgLRgDXC9psZkPfCLLciux6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547057; c=relaxed/simple;
	bh=kwdPU1qbN1GChGRQI4ADk5uJrc5stY/TlBaj+rld0uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oL19gIr5e7EvDGVoC1fvSHNpeayOvdzt/sP59t8rMrUwZyFLBgf+o+p429w/sNUh+8xBkgxTlZBUQUNT272kGqpAXHFVAXi8bPxXLxfYmFFF3PdugDzpaL+VLo3K97Edqx9bT3VeL6YkuZqWbtK1pbyLL25H5ZrBXHXmUuACwPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HPL++jCd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f4a5344ec7so2936295ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547055; x=1718151855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsRu3jEWU9sK1vmuNiyJjPrhOLNs5NH11TNjKSLZ2vI=;
        b=HPL++jCdAeWiQdvtuLhsMWjeeVQzSdwCtIZuweh/30rlgNKoecRIsxWqrJinEJbTr4
         eJAjiTVl/CVK8lfpqZUNeONrovoNlobLqyILVOJs6KhCs7x7cGdOQWU80Kq8zz2op3cT
         acYBiJVFw/bveOJF1UVILKiw/zyMxQ12aznro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547055; x=1718151855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsRu3jEWU9sK1vmuNiyJjPrhOLNs5NH11TNjKSLZ2vI=;
        b=L0zGc0YQpMtu5zWjltM7FEdCcFtVlq7IwOww6uTUjcjtxgLUsxCJa5OPw3I6dWViYD
         3+OhuWdjjttBOPHsWhvTFdbBqaKAu96ZBRzXOfOD5sYOJUXrBxIIvUNzSBHbbOC/u1v6
         7lApsp46+HxVUOSBn792GdLR84RBx8zVyf5edeNsK3pPUwk8lX4MmzzL4XuKp2P3Sne9
         zeboBMXS9jD6EmcIM2laQtXXFkPjIwQ6+n0K1YHV42O4TQx8uohu9kI30twDNOmRIwv+
         8eQqhoXk3wlM+PYMcrROiQN2s3AL4USNTOp4Lrvj/pU31vKQHlIVxPnDGm+yZE7ub4UA
         H3SA==
X-Forwarded-Encrypted: i=1; AJvYcCUC6dZ52VWNNyIGnQ7wQNQuCKURUtUNRCb/i8o5Q/ZhoZXJ65urpkohSyhL4SRf0s2slJuE7/9isR9DHUNyBO08QBx9EVvuuO6BDZuT
X-Gm-Message-State: AOJu0Yzx41H4fwCVj5tCJTK7KsB59RYN6z2H4QBuyCLxuaxANnn8eIf5
	2xD1rKl1MmlZmDnS/SwCRZJykMi6+PpWG3BoyFKFdjsD14PRbWQcXGrrkA1ApQ==
X-Google-Smtp-Source: AGHT+IEuttE4Gs9JJB+IuOsNqsKWp7EyRVQUbEuRZzgK3b55KLaK0AVYQ/oG9ywbjEwvWBwh98g+5w==
X-Received: by 2002:a17:903:2303:b0:1f6:a572:86ab with SMTP id d9443c01a7336-1f6a572a1d3mr22763635ad.15.1717547055143;
        Tue, 04 Jun 2024 17:24:15 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:14 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Jerry Han <jerry.han.hq@gmail.com>,
	Jitao Shi <jitao.shi@mediatek.com>,
	Rock Wang <rock_wang@himax.com.cn>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 02/24] drm/panel: boe-himax8279d: Don't call unprepare+disable at shutdown/remove
Date: Tue,  4 Jun 2024 17:22:48 -0700
Message-ID: <20240604172305.v3.2.I19086c524d38f28f746befe85cb39ffda9d2f666@changeid>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240605002401.2848541-1-dianders@chromium.org>
References: <20240605002401.2848541-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's the responsibility of a correctly written DRM modeset driver to
call drm_atomic_helper_shutdown() at shutdown time and that should be
disabling / unpreparing the panel if needed. Panel drivers shouldn't
be calling these functions themselves.

A recent effort was made to fix as many DRM modeset drivers as
possible [1] [2] [3] and most drivers are fixed now.

Unfortunately, grepping mainline for this panel's compatible string
shows no hits, so we can't be 100% sure if the DRM modeset driver used
with this panel has been fixed. If it is found that the DRM modeset
driver hasn't been fixed then this patch could be temporarily reverted
until it is.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Cc: Jerry Han <jerry.han.hq@gmail.com>
Cc: Jitao Shi <jitao.shi@mediatek.com>
Cc: Rock Wang <rock_wang@himax.com.cn>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-boe-himax8279d.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-himax8279d.c b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
index 12e14615298b..df746baae301 100644
--- a/drivers/gpu/drm/panel/panel-boe-himax8279d.c
+++ b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
@@ -894,14 +894,6 @@ static void panel_remove(struct mipi_dsi_device *dsi)
 	struct panel_info *pinfo = mipi_dsi_get_drvdata(dsi);
 	int err;
 
-	err = drm_panel_disable(&pinfo->base);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to disable panel: %d\n", err);
-
-	err = drm_panel_unprepare(&pinfo->base);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to unprepare panel: %d\n", err);
-
 	err = mipi_dsi_detach(dsi);
 	if (err < 0)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
@@ -909,14 +901,6 @@ static void panel_remove(struct mipi_dsi_device *dsi)
 	drm_panel_remove(&pinfo->base);
 }
 
-static void panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct panel_info *pinfo = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_disable(&pinfo->base);
-	drm_panel_unprepare(&pinfo->base);
-}
-
 static struct mipi_dsi_driver panel_driver = {
 	.driver = {
 		.name = "panel-boe-himax8279d",
@@ -924,7 +908,6 @@ static struct mipi_dsi_driver panel_driver = {
 	},
 	.probe = panel_probe,
 	.remove = panel_remove,
-	.shutdown = panel_shutdown,
 };
 module_mipi_dsi_driver(panel_driver);
 
-- 
2.45.1.288.g0e0cd299f1-goog


