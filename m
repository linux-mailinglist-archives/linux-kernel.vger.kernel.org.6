Return-Path: <linux-kernel+bounces-201604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C99E8FC097
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D89284808
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC11861FD5;
	Wed,  5 Jun 2024 00:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QDKnoDBU"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AEE5FDA5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547100; cv=none; b=MpkejaCdOV4/gi2+83OQXgYicR1zSKimHtcF6xK5t2RhMgmqPXIeIYcLHK2mDZ/wL8ejhzdWsom+4RcpZpGuKFyi+zxqEPq/voP+3SsPdl/qAI8e0rfAQo6ZU+PYy/UO/PecNBEYuKrqKz5rsEeoCIVgDLRM5fzIh96ShN/QP9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547100; c=relaxed/simple;
	bh=FQKiizhZ8vcg7Ag7A25RUwqNF6hI3SccADd32dafVj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8BQZuKY3suvkHQPd7I3dDj1aOsmOVQn0te1XHu2ad8iTZcPX8ISh4q4cooYZYe9fGwc5rxNxfSsep1NiLMy93vZSH1Iy5P5e428LlYH8SwyX8BIZqj32FUWwEsEKOEYj7/rrbDaVZlCeqCNRrjMwN2titEjfMYQVV1ENWpGAUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QDKnoDBU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f61f775738so44200585ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547098; x=1718151898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPVmtOP7OzClmuYgtUVqnYcO82gUWMj5hZYUvdlHA1M=;
        b=QDKnoDBU8NADr6hEiLxSZ8qkIMcv47tQmZ3HITQVgqH4MKenI25RwM+EUoVyN7PPVv
         Nt0J5qqCS4TweJLsdNk5/YnX1/oOvmRLsjnpesvD8JQyXUOCuDSjj59hgERcbm+A8kAD
         KEOht7KGdEBv/X4T9NPCqiYkyDLBPlD1c2Ekg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547098; x=1718151898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPVmtOP7OzClmuYgtUVqnYcO82gUWMj5hZYUvdlHA1M=;
        b=GsUNUuwAskjMn5q7YoRgLlReIV3fVVDWhVB/+YT5sdZQSsLHe8I1WmzcPWCd818jYY
         Ns74lQFgYi8iK+YePrG7Zzb5L/ZUKHUDo/Efc+/tI7Klt0p0zrp2dADjFchu+nMqBpqw
         IP6KqBVSGuwsONwBn16ihgYbwWJHRnZYm7O+4FO/PwLRC/MkThVpgs3/zki+IMZKJ6Y/
         jpCPBuBipicffvz1OI2C/f9dO1EHwzECoxhaMdKHqmlHh6BDDR3EJqghU7DPqEjOZ6Ol
         O7N1mEgVEQlnlCLxw7aP4Ei5vgnLTIGgbhrqQUtV892++/BEOGbYU8LOcdTgZlSRRgey
         wYbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUN32dAbQEYHZL8OCtmsBS2ItVoBFIg6rVj3Z/yGAH2Tr52Y3gNJ3crymYi+TAqvVhXIozuI96c+psMbcXn2jU6wivgwIy7lCEeBLK
X-Gm-Message-State: AOJu0YyAgmzk7xN//sRlB6ObHFVRfIS5/6t1bJ2SZVtaMOK8hV/5sLxp
	ukcQHzBcDPVDPVM0VtRsz+pxZuilF9BDG9iL90ZtNpFiT0uSNKaZnSzFMzlF5g==
X-Google-Smtp-Source: AGHT+IH67K070V0V8KqyhBHJzGDM8yQfGPIOd6KDxeebE42qN9cRh+u2DvVgSXDxiouyJBsaN27tUw==
X-Received: by 2002:a17:902:d2ce:b0:1f6:6939:ad23 with SMTP id d9443c01a7336-1f6a5a1976emr12033745ad.37.1717547097993;
        Tue, 04 Jun 2024 17:24:57 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:57 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Werner Johansson <werner.johansson@sonymobile.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 20/24] drm/panel: sharp-ls043t1le01: Don't call disable at shutdown/remove
Date: Tue,  4 Jun 2024 17:23:06 -0700
Message-ID: <20240604172305.v3.20.I89ee53f7fc2f0806cab318128e5fa927990d830f@changeid>
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

Cc: Werner Johansson <werner.johansson@sonymobile.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
index c86337954ad7..729cbb0d8403 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
@@ -267,10 +267,6 @@ static void sharp_nt_panel_remove(struct mipi_dsi_device *dsi)
 	struct sharp_nt_panel *sharp_nt = mipi_dsi_get_drvdata(dsi);
 	int ret;
 
-	ret = drm_panel_disable(&sharp_nt->base);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to disable panel: %d\n", ret);
-
 	ret = mipi_dsi_detach(dsi);
 	if (ret < 0)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
@@ -278,13 +274,6 @@ static void sharp_nt_panel_remove(struct mipi_dsi_device *dsi)
 	sharp_nt_panel_del(sharp_nt);
 }
 
-static void sharp_nt_panel_shutdown(struct mipi_dsi_device *dsi)
-{
-	struct sharp_nt_panel *sharp_nt = mipi_dsi_get_drvdata(dsi);
-
-	drm_panel_disable(&sharp_nt->base);
-}
-
 static const struct of_device_id sharp_nt_of_match[] = {
 	{ .compatible = "sharp,ls043t1le01-qhd", },
 	{ }
@@ -298,7 +287,6 @@ static struct mipi_dsi_driver sharp_nt_panel_driver = {
 	},
 	.probe = sharp_nt_panel_probe,
 	.remove = sharp_nt_panel_remove,
-	.shutdown = sharp_nt_panel_shutdown,
 };
 module_mipi_dsi_driver(sharp_nt_panel_driver);
 
-- 
2.45.1.288.g0e0cd299f1-goog


