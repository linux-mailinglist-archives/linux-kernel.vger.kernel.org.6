Return-Path: <linux-kernel+bounces-201602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AF78FC095
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5AFCB26C37
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DC25577E;
	Wed,  5 Jun 2024 00:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CxGc8FjA"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2744F4EB37
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547095; cv=none; b=aD8/t1ukhCNJFfkWb74H48Fu2KFpejNBRrX1Ux4OMMxtnkcJ4r5oRJ27AXGai61R1+mMK+7AIn7khsqSPJpro/LrqNYNGMOLl3kbMAWPEqlG95tnuSd1rVtSW4zH6lv6yFjN2ds2AemuG16zGel0UIU6Z10Lo9Y5MfI8GtsDivw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547095; c=relaxed/simple;
	bh=JYmrKcAo8MkbRM8xm+WkfPa4qdZWXauqIRbxsbjr04s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksPDQg7A4rm355xPIdwkBnVBj4Ui4cJFE/tZkx+/kTKpIfAAp9rNrAHsqxk+Q9qdQIHdouPnujtkyIJfwMKWHs+hp80mqz4zXHJhkclGRzwxpTcSFYehyuM5gmdhhc87WQN1bVYRaY4Do3psg6YH73d13ooGMqMAz2oNiytptlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CxGc8FjA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f44b45d6abso15504255ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547093; x=1718151893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUlBvWo2T1mUjKsAM9UGlJV07qR//zMbx5vVmNvhsHw=;
        b=CxGc8FjAqnNwd8X7lgjuBfj1gs1bqt8lXm+vH3AF72wnJhErgQsyUPRumKeWd1L0k1
         eDwA8cLvJIzk1geMf3cVMFokMMjcEAiM9GTWIDoY4xZrK/W6wiWTw9krIYMMqmkbeOEd
         dh1Yr1dOyyFNREW3MHUwsWN7v5VV4fKcjI8bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547093; x=1718151893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUlBvWo2T1mUjKsAM9UGlJV07qR//zMbx5vVmNvhsHw=;
        b=MqOiEnMkuPPcvA2xY2wYL3G/oG8J2bfo+29Dx98NTN7IpNcsR7+4cST9B2i+IT9b/i
         0efd+a9ZG0Ckx+mLgaVse1nDb+E1Vi+yEvaJvPuN2kHfRfTMd3lttbMKKruDqW3z0UkQ
         ysYOnZSykcA7CCkx9Tf9YEwQ5vAyloLslXwv+o2tbCDVwMvKuVqrPrC+mpe0Ip9b5S/4
         O5eeTrdBC6XaPfsMto3dDxnheqe0vuuofXPxefcr/HPuotJrJidq+r3N5hfGiyWUuzrd
         5BwYZZ3vcQF38eGrDquNO0Hk6AnY5DIG9YSZY2iDCMnb8Pl9dzHSB4CiNVYcIcKMYepm
         m5Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVn7qjngSqPhoL6bz5wHVmTWMUNRkFfSCg46ZcQ5yL6uTRBM/pcRgl0L9J3Hf1Z3nIBqpBI6SLuRScRwSMWto+vbUFiZCRXpuIEvv2x
X-Gm-Message-State: AOJu0YwI3WLRFAdyXVsDp1r7hAZ2UyXq6R6CHfghW/CQ9aZgWFVSgNTC
	aQGR59VYnwXBqmJKdLwNi7yMHc1iR/LfkxC8cEG6sOAecfxbvwAg1gsPi/lsDA==
X-Google-Smtp-Source: AGHT+IEBCjVCwzRlhQ5yGZdUyRhLI5wJLXlZzSHlXxP5GByBVUh3AdvfEeSHGA0EtYaytavcaHqdcQ==
X-Received: by 2002:a17:903:40c1:b0:1f6:8235:dba7 with SMTP id d9443c01a7336-1f6a5a900a0mr14151585ad.69.1717547093361;
        Tue, 04 Jun 2024 17:24:53 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:51 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Thierry Reding <treding@nvidia.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 18/24] drm/panel: sharp-lq101r1sx01: Don't call disable at shutdown/remove
Date: Tue,  4 Jun 2024 17:23:04 -0700
Message-ID: <20240604172305.v3.18.I6a87fce1ee027c96f71c7adf74248b865f50b336@changeid>
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

A grep through mainline for compatible strings used by this driver
indicates that it is used by Tegra boards. The Tegra driver appears to
be correctly calling drm_atomic_helper_shutdown() so we can remove the
calls.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Cc: Thierry Reding <treding@nvidia.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 .../gpu/drm/panel/panel-sharp-lq101r1sx01.c   | 24 ++-----------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
index 8f6c21b99522..edc9425bb143 100644
--- a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
@@ -357,32 +357,13 @@ static void sharp_panel_remove(struct mipi_dsi_device *dsi)
 	struct sharp_panel *sharp = mipi_dsi_get_drvdata(dsi);
 	int err;
 
-	/* only detach from host for the DSI-LINK2 interface */
-	if (!sharp) {
-		mipi_dsi_detach(dsi);
-		return;
-	}
-
-	err = drm_panel_disable(&sharp->base);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to disable panel: %d\n", err);
-
 	err = mipi_dsi_detach(dsi);
 	if (err < 0)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
 
-	sharp_panel_del(sharp);
-}
-
-static void sharp_panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct sharp_panel *sharp = mipi_dsi_get_drvdata(dsi);
-
-	/* nothing to do for DSI-LINK2 */
+	/* only detach from host for the DSI-LINK2 interface */
 	if (!sharp)
-		return;
-
-	drm_panel_disable(&sharp->base);
+		sharp_panel_del(sharp);
 }
 
 static struct mipi_dsi_driver sharp_panel_driver = {
@@ -392,7 +373,6 @@ static struct mipi_dsi_driver sharp_panel_driver = {
 	},
 	.probe = sharp_panel_probe,
 	.remove = sharp_panel_remove,
-	.shutdown = sharp_panel_shutdown,
 };
 module_mipi_dsi_driver(sharp_panel_driver);
 
-- 
2.45.1.288.g0e0cd299f1-goog


