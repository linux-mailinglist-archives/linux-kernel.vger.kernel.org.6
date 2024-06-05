Return-Path: <linux-kernel+bounces-201606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B88B8FC09B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7251F21C99
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A8B73454;
	Wed,  5 Jun 2024 00:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CRkcT26u"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E875F6A340
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547105; cv=none; b=CbqQsN4Gd9WY1L4hLB/aYlLMitPlyCm40hfnkv0CxU/7w4+UpdHyok9W4FeF/RXg+CuVly34v6T8/NQcFpO+KRRPFJUbUzxjkVbNJLdbVSbfSkbxz97NPASBSQufcuO9Ht+ag9uJmjaciTvy2WMhk4SStJK4b+TU50XSnsQrAeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547105; c=relaxed/simple;
	bh=k8l7AEga1GtNZl4aI36tgvWb4+r7pet0wCh09mUWrH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/M27yzTi8wXdY+v2DDWdcGNO2U2T/yUmZED8Le/aAJOZuUNm0nJG5OCw+Wj0fGZmehcscvL78OFnEa7df6ZvitjmgAh+D38TE43Z3wYH6vhpmKCknu7kTNZuvZSFEoz94A3OygOyZlErbCWrqHiCznEWahjvTn7DUAd7mQtlPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CRkcT26u; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f61f775738so44201015ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547103; x=1718151903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WueavCuqsC++tgdW3b4kChJiO3Z5diw3u/WttA4fZGU=;
        b=CRkcT26ugTveGWAUaA0lhv0RQS/RRMK7d54mUSzpbbDs3ybD695XFkxiciJWQnu0A/
         cZz6UBXltDZa2eSQouptNVQnKwWgG/h1WPOZDvk/FKWlj7QiNkRC10pQTStWpcfE7T+h
         AGfw8HtwpBsgp1E3zhVvQ41axEIReIzB1lGvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547103; x=1718151903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WueavCuqsC++tgdW3b4kChJiO3Z5diw3u/WttA4fZGU=;
        b=aMH/APcHTp8MuFA6j16dXMgiEKoRCTAVHjaJnBlVE536/mkVsJpOGTymKB0VQ6VGZk
         KUKbEWyZAa5USzkciSduNgazxZeHqdG+TGS52QEz6UR0WxRyAV568W1aPWi/Px0GPwg3
         Aph/HBjucGdonF1ieieLEjAKmBlhvo16zGqUOgRgUPrqoMgF2XZtfIQBnT0iiihp1feY
         UFWN2tFewREFpteVZ7NTXUwdbiXLtH5wLxN76ZELGNqDzC4v/e8RuZsUsgWlRviAAhM0
         sObuRFKbhd2JFo791OM+DX9uSGAqszE3x0l/CeCNR7ViR8iJCTX4j7N6mOTbO0GWtQLa
         WZZg==
X-Forwarded-Encrypted: i=1; AJvYcCXVIv+9yeT29JO2NASPHCqtJZ+V89t9dgbuOxGUgJ7GDeEx7dDQX/RAxARHH3maxf9cfyUqjAeFlmNQj8Q5iCjf2/Tkjafx15NSr/Jw
X-Gm-Message-State: AOJu0YxYHnU7SLf7R8RSSEKsAcU4HLRP6xMF4TPQvxiLmiHCncBmINOH
	+ObRC2MphXICuQvMkLiAZ1Dtx2NP6rE5NZCrz84zNmTLPbOT5o9tjmR5bxedNw==
X-Google-Smtp-Source: AGHT+IHZV8rnTIG07xU0wk0unrHRbIjagmzYiGL/t8yAbJMj8hc5iEhhmcsmlBP97t06k9Tu/aYGNQ==
X-Received: by 2002:a17:902:b7ca:b0:1f4:b702:f143 with SMTP id d9443c01a7336-1f6a5a094d5mr10864515ad.15.1717547103166;
        Tue, 04 Jun 2024 17:25:03 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:25:01 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Robert Chiras <robert.chiras@nxp.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 22/24] drm/panel: raydium-rm67191: Don't call unprepare+disable at shutdown
Date: Tue,  4 Jun 2024 17:23:08 -0700
Message-ID: <20240604172305.v3.22.Id14188f1a8af7d524751c27c343a5b583ff5361f@changeid>
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
indicates that it is used by IMX boards. The IMX driver appears to be
correctly calling drm_atomic_helper_shutdown() so we can remove the
calls.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Cc: Robert Chiras <robert.chiras@nxp.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-raydium-rm67191.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm67191.c b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
index fa9bf89d3bb5..b2029e035635 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm67191.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
@@ -612,14 +612,6 @@ static void rad_panel_remove(struct mipi_dsi_device *dsi)
 	drm_panel_remove(&rad->panel);
 }
 
-static void rad_panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct rad_panel *rad = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_disable(&rad->panel);
-	drm_panel_unprepare(&rad->panel);
-}
-
 static const struct of_device_id rad_of_match[] = {
 	{ .compatible = "raydium,rm67191", },
 	{ /* sentinel */ }
@@ -633,7 +625,6 @@ static struct mipi_dsi_driver rad_panel_driver = {
 	},
 	.probe = rad_panel_probe,
 	.remove = rad_panel_remove,
-	.shutdown = rad_panel_shutdown,
 };
 module_mipi_dsi_driver(rad_panel_driver);
 
-- 
2.45.1.288.g0e0cd299f1-goog


