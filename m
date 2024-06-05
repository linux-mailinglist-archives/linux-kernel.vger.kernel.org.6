Return-Path: <linux-kernel+bounces-201596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F918FC08E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1C21C225F5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045DA22079;
	Wed,  5 Jun 2024 00:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F6o4GX34"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42F82837A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547081; cv=none; b=fFpLMVBjKRbvGSi6beiV++df3cwdw5Fn0lLzt/Pmg9obHDhF4YSIfp3R0351nzclc4Kj6Egc/wrfkkYWvCxmII7fvp4T6wbrzWlofvrpSFLhQ/IJcRufgh+MDIE4RwBEenBLJJQyx0ys1Umr7yfOHxng7+v/nbeK24r5aJerwSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547081; c=relaxed/simple;
	bh=y5P6GSVJaqX9fygi7NCZQL6iQCjLJjz3fWYqF7675rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwDDpJj8ecpOlsT4YF/vQQzhMCVhIdyG0ZwmCWGnJdTkDdfa2NFEYpkuZP6bCplVt1pPWHtzMJ37xC5pcxNBmgPJEwL8nzdNHNk2LHY8t7eU4zSbyT/pMn5O0JDhgRE2Vi8jX35IqCQDnzBq15IM5lxHnFKVGrb806zMIkD6L3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F6o4GX34; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f44b5d0c50so46523255ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547079; x=1718151879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfrcD8JBjZkCaL7eZQ01Qcv1YJLZOCOi3SqrruG0MFA=;
        b=F6o4GX34sbSECfeX7qcanzjWX+hKofI0P+WFAOnHx0IltLkTYcxR/dcy9XSULJ5K6H
         YOoQgyZ7f+5gE1+LtU7l0WwCDLXFFZrxZI7i1UhLh2AScKbeb4nCTwTthPuqZbSngNRY
         m/Xcuh5tXEWCocA1F0n7sqCgu5Z4FF7E8DuOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547079; x=1718151879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfrcD8JBjZkCaL7eZQ01Qcv1YJLZOCOi3SqrruG0MFA=;
        b=YA82t052EkAc2XvFB4ezEI6RXObz0WprdrpsNeHwGQF9qHhlEOyuSN5c6qYV/UmmjV
         EDlOMmo1V6K8KFI9tBtlLBTcIimHBbzVdwt+EYTqCmaZdCV86s80p4Ng9FxhpB4eeCiW
         DKQ2VK0gpKDKJd4UsI2iI80u2o4lb/q54wfjT4yunr5MJFvru7PpLV57pm6u7FgjPgdI
         khrkYNjZTicxV/Yq0PukUkDGzRAxhmFSpA2COb1j9CZIzgJ0FA5YjyRo3i2znWe1dF6i
         9l+UnjSI087b/att4vzKed5v+suYB08YqT+Vy8elBpg2/ZmyLu/6y6UwZDf2XRbzgnrV
         IvcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo+SWfhtzaq7h9Hj7CjWlMYHXPjZ3zV84JljH3tJ5KHvolG8pIucRh0+e607ajzodlRPsniLqbs4tWJU7+GLTXqvkg15Y+UHpPvhjW
X-Gm-Message-State: AOJu0YwAQsJS9+fTSPB/eFwf7e3WcFOc8s3RHD/tBb8KG7OltvVTEWKY
	p4d9BHXfP/joHPsmTCKgnRT8ZcSn39FTall8G+sfa+7M4yvPwrWI00w38/tyfA==
X-Google-Smtp-Source: AGHT+IEEXeKEFU3e6/tB86kEEDxmpRztg5jwJKvGuNYwl+8Zuu/KCQ9s/CpPfv0EO0JOLP/Q6+umFg==
X-Received: by 2002:a17:903:2289:b0:1f6:6c64:a7b6 with SMTP id d9443c01a7336-1f6a5a24e16mr13838715ad.37.1717547078652;
        Tue, 04 Jun 2024 17:24:38 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:37 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Vinay Simha BN <simhavcs@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/24] drm/panel: jdi-lt070me05000: Don't call disable at shutdown/remove
Date: Tue,  4 Jun 2024 17:22:58 -0700
Message-ID: <20240604172305.v3.12.I5f3426e511e77b93c247e0aac114bd12b2b2a933@changeid>
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
indicates that it is used by Qualcomm boards. The Qualcomm driver
appears to be correctly calling drm_atomic_helper_shutdown() so we can
remove the calls.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Cc: Vinay Simha BN <simhavcs@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
index 4ddddee6fa1e..b1ce186de261 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
@@ -452,10 +452,6 @@ static void jdi_panel_remove(struct mipi_dsi_device *dsi)
 	struct jdi_panel *jdi = mipi_dsi_get_drvdata(dsi);
 	int ret;
 
-	ret = drm_panel_disable(&jdi->base);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to disable panel: %d\n", ret);
-
 	ret = mipi_dsi_detach(dsi);
 	if (ret < 0)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n",
@@ -464,13 +460,6 @@ static void jdi_panel_remove(struct mipi_dsi_device *dsi)
 	jdi_panel_del(jdi);
 }
 
-static void jdi_panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct jdi_panel *jdi = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_disable(&jdi->base);
-}
-
 static struct mipi_dsi_driver jdi_panel_driver = {
 	.driver = {
 		.name = "panel-jdi-lt070me05000",
@@ -478,7 +467,6 @@ static struct mipi_dsi_driver jdi_panel_driver = {
 	},
 	.probe = jdi_panel_probe,
 	.remove = jdi_panel_remove,
-	.shutdown = jdi_panel_shutdown,
 };
 module_mipi_dsi_driver(jdi_panel_driver);
 
-- 
2.45.1.288.g0e0cd299f1-goog


