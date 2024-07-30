Return-Path: <linux-kernel+bounces-267531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A5594128B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D251C21FFC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44EB1A00EC;
	Tue, 30 Jul 2024 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U1SuT9da"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3A81991A7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343839; cv=none; b=SO//jJ7FK8MoQA2Vc6vj8VlqxAbRYoJ7JLLyQ2sUKM4sEQkXcrXvwIswQ6jFVJrN/EiZ/OKJg/zqPOmaHhMsXTW5V/dIyGx1KiAv0+eu19wwK6OuNYt1IB02wloofBnsGO2elNExy8hL0IqYup5jeWV/z392g6xQDt5fozG3dhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343839; c=relaxed/simple;
	bh=P1CtOnOqH6yN6P04g5ZMgYLfLzSMfwfPcafR7XoHG9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuZtRf+qIbMrnBmLlHk5d8z+Y6f9oW6hsGXn3oMae8nCqXigRVDr9keb1ovJfEkpsronLn38kSoYYfF3sQdRmjKX5GSoOmePRq8cyT3srk00hcGQn1t/CVh5cH/aNd95UuGwN1uPKRSoSgOj9I+SBn4AvHVC1+XF0CftZzXkIg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U1SuT9da; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428243f928fso7585895e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722343835; x=1722948635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+llf/AzXlKp78omF5xhKmy0SCTLK8xhdI8HSdAi9g1k=;
        b=U1SuT9daLh0FpDjzYCV4pQLh41jOgJn5mFs6n7GTWea4+PcxIb8SM6lxYF0/RuJDj+
         sg5EzcR3nBdpObGEeUOiKvWzPmVgeSBy/iTUfc+e0poXqDfKYlrMckOfsgB2cQy0PPHD
         m7PYWAXeFJu5Lu9H0KSceJAka+P43dg9nc499b8LnKr1AxkWhl1pIPd5OfIgLuP60Dqp
         wQAy5P4uV7Zl9Lxg4VAARP0PwVeXb4czudCAZIyawgAhUt/MMRPTKMt+VQrRXLoQwaOK
         BUt56GbnuKciz6i7WuXLUOA4NtcN/hnWDqtIwUSAs/atse5RP2qsqEhYhRWWMRYwFaIW
         B/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722343835; x=1722948635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+llf/AzXlKp78omF5xhKmy0SCTLK8xhdI8HSdAi9g1k=;
        b=Ggy4CBtuaOI1pEkzhshQCcHNZtfTjax7NTMbYs6/z0XjPtkB1V+VFsst56qGIJuoHM
         qKqTD0dPOsFcWLcYeWHxT/gwe8Qz690SiVKLt0/1Q32r3ZSnajijqBcFOSoM9FAw6k+O
         SG9YuJ57QM0uyCqbWN56G3NQP0mbR70EXnFfHi5SHHblTC1dXi8jLKRdGZanXhsIBDJL
         cTTJiwtmBYgB9dZZ0ymjzhiJy2qjTkAFWst1mwA0tMStYdJZyx/IMmJqBlDacz55iXul
         +jmgo8z6RJHKDLRej3pX0v4YPR1+NMG6ETAWro2fTCQzTw/nqnzN/F4V7uVhqp270qiE
         +wQw==
X-Forwarded-Encrypted: i=1; AJvYcCU0OSthqE/ppGFO85Gyw8Se3YNY856h7BmMhMitxLJ4xph9J2kW3JS13mqEIBcXgRtKBQfbpFQTDzz/kmb+zRwaYEdbKduQkN3aMrat
X-Gm-Message-State: AOJu0YwTIcvUmEGr75+9XR2/fBLGzEu0v7Swodp1dKoLligh0Mi/ZL4h
	cY+6Z0bLiWUEUbTjq57hEQkDEa31uW+7NMDyGYsApnuXZR6xsV+9jce+JZ/9qDw=
X-Google-Smtp-Source: AGHT+IHNrX2bheZchsP7m4fuUtkC/sP1H3A6/6koS/47y+kuPZKBI5FQcJ6s4Qb6HTNFzzD3vSexkg==
X-Received: by 2002:a05:600c:1c8f:b0:426:5269:982c with SMTP id 5b1f17b1804b1-42811dd3c2bmr85628895e9.28.1722343835329;
        Tue, 30 Jul 2024 05:50:35 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:291e:4a48:358e:6f49])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42805730e68sm216521405e9.9.2024.07.30.05.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:50:34 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	dri-devel@lists.freedesktop.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] drm/meson: hdmi: move encoder settings out of phy driver
Date: Tue, 30 Jul 2024 14:50:11 +0200
Message-ID: <20240730125023.710237-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730125023.710237-1-jbrunet@baylibre.com>
References: <20240730125023.710237-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

This relocates register pokes of the HDMI VPU encoder out of the
HDMI phy driver. As far as HDMI is concerned, the sequence in which
the setup is done remains mostly the same.

This was tested with modetest, cycling through the following resolutions:
  #0 3840x2160 60.00
  #1 3840x2160 59.94
  #2 3840x2160 50.00
  #3 3840x2160 30.00
  #4 3840x2160 29.97
  #5 3840x2160 25.00
  #6 3840x2160 24.00
  #7 3840x2160 23.98
  #8 1920x1080 60.00
  #9 1920x1080 60.00
  #10 1920x1080 59.94
  #11 1920x1080i 30.00
  #12 1920x1080i 29.97
  #13 1920x1080 50.00
  #14 1920x1080i 25.00
  #15 1920x1080 30.00
  #16 1920x1080 29.97
  #17 1920x1080 25.00
  #18 1920x1080 24.00
  #19 1920x1080 23.98
  #20 1280x1024 60.02
  #21 1152x864 59.97
  #22 1280x720 60.00
  #23 1280x720 59.94
  #24 1280x720 50.00
  #25 1024x768 60.00
  #26 800x600 60.32
  #27 720x576 50.00
  #28 720x480 59.94

No regression to report.

This is part of an effort to clean up Amlogic HDMI related drivers which
should eventually allow to stop using the component API and HHI syscon.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c      | 38 ----------------------
 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 16 +++++++++
 2 files changed, 16 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 5565f7777529..bcf4f83582f2 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -115,12 +115,6 @@
 
 static DEFINE_SPINLOCK(reg_lock);
 
-enum meson_venc_source {
-	MESON_VENC_SOURCE_NONE = 0,
-	MESON_VENC_SOURCE_ENCI = 1,
-	MESON_VENC_SOURCE_ENCP = 2,
-};
-
 struct meson_dw_hdmi;
 
 struct meson_dw_hdmi_data {
@@ -376,8 +370,6 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 	struct meson_dw_hdmi *dw_hdmi = (struct meson_dw_hdmi *)data;
 	bool is_hdmi2_sink = display->hdmi.scdc.supported;
 	struct meson_drm *priv = dw_hdmi->priv;
-	unsigned int wr_clk =
-		readl_relaxed(priv->io_base + _REG(VPU_HDMI_SETTING));
 	bool mode_is_420 = false;
 
 	DRM_DEBUG_DRIVER("\"%s\" div%d\n", mode->name,
@@ -421,36 +413,6 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 	meson_dw_hdmi_phy_reset(dw_hdmi);
 	meson_dw_hdmi_phy_reset(dw_hdmi);
 
-	/* Temporary Disable VENC video stream */
-	if (priv->venc.hdmi_use_enci)
-		writel_relaxed(0, priv->io_base + _REG(ENCI_VIDEO_EN));
-	else
-		writel_relaxed(0, priv->io_base + _REG(ENCP_VIDEO_EN));
-
-	/* Temporary Disable HDMI video stream to HDMI-TX */
-	writel_bits_relaxed(0x3, 0,
-			    priv->io_base + _REG(VPU_HDMI_SETTING));
-	writel_bits_relaxed(0xf << 8, 0,
-			    priv->io_base + _REG(VPU_HDMI_SETTING));
-
-	/* Re-Enable VENC video stream */
-	if (priv->venc.hdmi_use_enci)
-		writel_relaxed(1, priv->io_base + _REG(ENCI_VIDEO_EN));
-	else
-		writel_relaxed(1, priv->io_base + _REG(ENCP_VIDEO_EN));
-
-	/* Push back HDMI clock settings */
-	writel_bits_relaxed(0xf << 8, wr_clk & (0xf << 8),
-			    priv->io_base + _REG(VPU_HDMI_SETTING));
-
-	/* Enable and Select HDMI video source for HDMI-TX */
-	if (priv->venc.hdmi_use_enci)
-		writel_bits_relaxed(0x3, MESON_VENC_SOURCE_ENCI,
-				    priv->io_base + _REG(VPU_HDMI_SETTING));
-	else
-		writel_bits_relaxed(0x3, MESON_VENC_SOURCE_ENCP,
-				    priv->io_base + _REG(VPU_HDMI_SETTING));
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index 0593a1cde906..1c3e3e5526eb 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -45,6 +45,12 @@ struct meson_encoder_hdmi {
 	struct cec_notifier *cec_notifier;
 };
 
+enum meson_venc_source {
+	MESON_VENC_SOURCE_NONE = 0,
+	MESON_VENC_SOURCE_ENCI = 1,
+	MESON_VENC_SOURCE_ENCP = 2,
+};
+
 #define bridge_to_meson_encoder_hdmi(x) \
 	container_of(x, struct meson_encoder_hdmi, bridge)
 
@@ -247,6 +253,14 @@ static void meson_encoder_hdmi_atomic_enable(struct drm_bridge *bridge,
 		writel_relaxed(1, priv->io_base + _REG(ENCI_VIDEO_EN));
 	else
 		writel_relaxed(1, priv->io_base + _REG(ENCP_VIDEO_EN));
+
+	/* Enable and Select HDMI video source for HDMI-TX */
+	if (priv->venc.hdmi_use_enci)
+		writel_bits_relaxed(0x3, MESON_VENC_SOURCE_ENCI,
+				    priv->io_base + _REG(VPU_HDMI_SETTING));
+	else
+		writel_bits_relaxed(0x3, MESON_VENC_SOURCE_ENCP,
+				    priv->io_base + _REG(VPU_HDMI_SETTING));
 }
 
 static void meson_encoder_hdmi_atomic_disable(struct drm_bridge *bridge,
@@ -257,6 +271,8 @@ static void meson_encoder_hdmi_atomic_disable(struct drm_bridge *bridge,
 
 	writel_bits_relaxed(0x3, 0,
 			    priv->io_base + _REG(VPU_HDMI_SETTING));
+	writel_bits_relaxed(0xf << 8, 0,
+			    priv->io_base + _REG(VPU_HDMI_SETTING));
 
 	writel_relaxed(0, priv->io_base + _REG(ENCI_VIDEO_EN));
 	writel_relaxed(0, priv->io_base + _REG(ENCP_VIDEO_EN));
-- 
2.43.0


