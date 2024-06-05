Return-Path: <linux-kernel+bounces-201598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC7D8FC090
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480C91F231BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2533A260;
	Wed,  5 Jun 2024 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ejlu6ywQ"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958FD2E62C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547085; cv=none; b=RrCvKScXaTdL2YrkZy259GmnUIdTg3MzFGMrk9mZMEbk1+mdMAd8uT273LCRQg6GSl0IWBLhHxK0WDJNqsqE7vFXT3BeZdcuVfoSIOFWPiBk6mVV+2VgvXaHt+sBX5FOccLRm80oBENbi0GLBCG+E4uB9ymlXtY2+G4oXbu055Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547085; c=relaxed/simple;
	bh=DFjnq2opIjVPngSaFGfLurlZ3AfJMPI5t45nfJZwkyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZkmGIjui8gjr1UBjqp50xGlIhgwdyoiQsI4/B2ne14heAjk38uH1LL0lWa9VifLZ0P0Ci/GjL8M/qJSUKzonFdE8/ebsDTNZJUYTy1nSv+uG+8LZE5c8G96H6zpML7zSTxhFYyczM/kT/UjEWZYyj+s1Diee9x1C/ishWgkYTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ejlu6ywQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-702621d8725so3556181b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547083; x=1718151883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sysQzdwXJkfbSDELyE+0q9H4w1SnddVJlaF6DxjB+qk=;
        b=ejlu6ywQSEtGg1gJo/zmJ5+gEzZmWPogoPTv0fApd4DzSAJYUvuGsMhdal1TgWFw79
         j0JqBjuvsuLAWIS0K0qdRbKyPeObpaJc3MH9SFkBo43R5E7gqfyjbOIHSqfd3jLJW2pX
         o0YT2umTYxP5byYcNhcMNgKQIY2KRVeAQ1Hjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547083; x=1718151883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sysQzdwXJkfbSDELyE+0q9H4w1SnddVJlaF6DxjB+qk=;
        b=eLF/cycPuwYvnH2Ys53Mrl/ytH0gm+KdGOXpIb0/iYJblgLys9lV49yQK5sQepcjBm
         lDTNspau6bgztwQX9GOIjTV9gCgisclyouMI1r+JoX+3LYk5qoFq6JtvszUARr/rVeLr
         QMlwfI6R+OxRJSltvB2rb13G9VDcGtRKpGIKUFeSFGwETyL7MOlXS9QyFrmvgP7GlQBK
         F/jRc10NFXGRcuicwpSds6DmnWVKW9IFwRjaLMVPYiaa4p6l1SK8O8gkWE8VVN2b067X
         xucKGoB7YUwDoCtgNdz/Wm/qIGJ0zed2hTikgCgyV2MQVhBY6JARk0AkGQqKegY+CJjl
         f9qA==
X-Forwarded-Encrypted: i=1; AJvYcCUtG5XHRaGgvIjh5/QxG1bF8k51v6D02l7ptjPTKXUuFDh8rDjH1OTz8SViMGPtH+XDrDu6+2F0yjjCJe+4/0WzH+wYmz4oCunozZ8+
X-Gm-Message-State: AOJu0Ywc0Mtx6/atTiSbeGRzE/Cg2bgfPPEelteJSmJXA53tDbZTS+Ze
	i3mSP42hTdKjAIUHEW1epCTEvOorqqiyGkYld0QCchEbMobjvXnGcc5NSDdMow==
X-Google-Smtp-Source: AGHT+IHwO5H/zzgdm51Mput5e8kDxkReWlPt+ysnTlv9tYtyUriDJs0DOGcaXJK8sR0lU669dWg0YA==
X-Received: by 2002:a05:6a21:6da9:b0:1af:a37e:367e with SMTP id adf61e73a8af0-1b2b6f81145mr1642375637.15.1717547082896;
        Tue, 04 Jun 2024 17:24:42 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:42 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Werner Johansson <werner.johansson@sonymobile.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/24] drm/panel: panasonic-vvx10f034n00: Don't call disable at shutdown/remove
Date: Tue,  4 Jun 2024 17:23:00 -0700
Message-ID: <20240604172305.v3.14.I1562c864ee35a9c166765488c95104b7e4e562da@changeid>
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

Cc: Werner Johansson <werner.johansson@sonymobile.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
index 822ca2f971eb..d1c5c9bc3c56 100644
--- a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
+++ b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
@@ -222,10 +222,6 @@ static void wuxga_nt_panel_remove(struct mipi_dsi_device *dsi)
 	struct wuxga_nt_panel *wuxga_nt = mipi_dsi_get_drvdata(dsi);
 	int ret;
 
-	ret = drm_panel_disable(&wuxga_nt->base);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to disable panel: %d\n", ret);
-
 	ret = mipi_dsi_detach(dsi);
 	if (ret < 0)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
@@ -233,13 +229,6 @@ static void wuxga_nt_panel_remove(struct mipi_dsi_device *dsi)
 	wuxga_nt_panel_del(wuxga_nt);
 }
 
-static void wuxga_nt_panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct wuxga_nt_panel *wuxga_nt = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_disable(&wuxga_nt->base);
-}
-
 static struct mipi_dsi_driver wuxga_nt_panel_driver = {
 	.driver = {
 		.name = "panel-panasonic-vvx10f034n00",
@@ -247,7 +236,6 @@ static struct mipi_dsi_driver wuxga_nt_panel_driver = {
 	},
 	.probe = wuxga_nt_panel_probe,
 	.remove = wuxga_nt_panel_remove,
-	.shutdown = wuxga_nt_panel_shutdown,
 };
 module_mipi_dsi_driver(wuxga_nt_panel_driver);
 
-- 
2.45.1.288.g0e0cd299f1-goog


