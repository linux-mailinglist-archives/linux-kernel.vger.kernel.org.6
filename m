Return-Path: <linux-kernel+bounces-201588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FF98FC082
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F90D284C0B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B04D52A;
	Wed,  5 Jun 2024 00:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VpgZGrOw"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A841C153
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547062; cv=none; b=eO7ls2ANb01Zph8CKQf5xkX06hH/3D6w52pHjvvZeXI+T+4G2gbXTlxdjEAG5vmtcnacHOOS2nwNSEk5O5lUQvfUK7+iSSdPjCl4cZeBlcQWrBXJfGNbQ+yik4FAHDLT2L8Jd9xXgPH3TklelI23FcUe1q4xfaPUzszT7C6cm5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547062; c=relaxed/simple;
	bh=EGAd7NfTm2lm23LtYlpCf7xm+rdVxrXwzRc10j/tass=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PztB1J5RBEb82LVawZA+hutpm9SPYF2+yS5wax9MkmKufEWbrLkuyODlkheugeVlSxDuNOVNb+6B6gaxN2Wz1ct0gGFGvUJV1nnSmhCZ+gPbqtKWWQtiHfDQsaFbWHabKVxMSzCrIC9cvkq6XK9dk+a9Z+jMOsDTUEBOS0xaOjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VpgZGrOw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f4a5344ec7so2936785ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547060; x=1718151860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGL1XAJY8XhKpAWsqPFbzgWXo/pkMzXKNmiwvtJp4Hk=;
        b=VpgZGrOwdhoutJ66gzjzOWpEF2cCvksJB5Ri7i50ut6oP4MtRKFk6BEDe6pb2ai5yj
         cHxN4rUiOBl2S4rJA9M3Ks+Ij4BwaVrQe1S5VSwwD3/ex9IU8rtjjLLGh9ux9p2jDG7N
         EggVrVJVB8IJovjXY3LWXB/zD7dhA/3xw0bzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547060; x=1718151860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGL1XAJY8XhKpAWsqPFbzgWXo/pkMzXKNmiwvtJp4Hk=;
        b=YDRGc+wyhcNGOlg8wC0bYPvHkWLO2Et7DSoTcxFlAzBsvJgZWoqXY36pBsqAWCqqpc
         YVE8fu/sdp8hBVRvd16y9QnMtWmkhesmSj4DfSu5htjlQEXVspx30x9TFWPiR96uyskV
         L3YaPFuufJc4FgQA2kYXTHWKsYvYuTOJGcwnsfu1UZFh44QQncw/N1haQP/DGyUJq5JS
         0lmGISXg0Q+Z97TaQi2jWqTS07aLnt1CKPfybiPTrCkfQGj/zGFFkUkC6EV7z5VKpwr/
         smEYKVibpsXwi25P5BrUS1JNE9nn+LLcfUquN5RGz9mtqaAA0u0wpIu07gGPkm57cZcp
         JA6A==
X-Forwarded-Encrypted: i=1; AJvYcCUXxCVn0r4r7+Y/ORvcFMwKWjJBLD7vd66Ehz4078pPJ26DheB4Gi0j5uY1xZcb7I3rqWgbIya2T3ztycgxwEXKXG+isQAmMC3102Z0
X-Gm-Message-State: AOJu0Yx244O4SRm4qMWKw30cTNKMZHIOmBLzXJAyOUJvPDA2QrLRdsq3
	xBVXi1zUJlUZgxN5qjlAfsdMSDkymjFBdjcl080W5NiBrZUO/wgTczngZ8IJiA==
X-Google-Smtp-Source: AGHT+IHoXvg8VOvFaoaofPi1Wy0+ieuiJmAHAvk6TPPRDaDW+DtShADzHcHhWak9Q2qUznFX99fpfQ==
X-Received: by 2002:a17:903:1ca:b0:1f4:8a31:5a4c with SMTP id d9443c01a7336-1f6a56ebf71mr12680595ad.24.1717547060328;
        Tue, 04 Jun 2024 17:24:20 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:19 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Jacobe Zang <jacobe.zang@wesion.com>,
	Nicolas Belin <nbelin@baylibre.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/24] drm/panel: khadas-ts050: Don't call unprepare+disable at shutdown/remove
Date: Tue,  4 Jun 2024 17:22:50 -0700
Message-ID: <20240604172305.v3.4.I1ee65e7905bf5bf46a0e6c5126ac3c7aa25cb80b@changeid>
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

Cc: Jacobe Zang <jacobe.zang@wesion.com>
Cc: Nicolas Belin <nbelin@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-khadas-ts050.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-khadas-ts050.c b/drivers/gpu/drm/panel/panel-khadas-ts050.c
index e35762ebdbd1..14932cb3defc 100644
--- a/drivers/gpu/drm/panel/panel-khadas-ts050.c
+++ b/drivers/gpu/drm/panel/panel-khadas-ts050.c
@@ -880,16 +880,6 @@ static void khadas_ts050_panel_remove(struct mipi_dsi_device *dsi)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
 
 	drm_panel_remove(&khadas_ts050->base);
-	drm_panel_disable(&khadas_ts050->base);
-	drm_panel_unprepare(&khadas_ts050->base);
-}
-
-static void khadas_ts050_panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct khadas_ts050_panel *khadas_ts050 = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_disable(&khadas_ts050->base);
-	drm_panel_unprepare(&khadas_ts050->base);
 }
 
 static struct mipi_dsi_driver khadas_ts050_panel_driver = {
@@ -899,7 +889,6 @@ static struct mipi_dsi_driver khadas_ts050_panel_driver = {
 	},
 	.probe = khadas_ts050_panel_probe,
 	.remove = khadas_ts050_panel_remove,
-	.shutdown = khadas_ts050_panel_shutdown,
 };
 module_mipi_dsi_driver(khadas_ts050_panel_driver);
 
-- 
2.45.1.288.g0e0cd299f1-goog


