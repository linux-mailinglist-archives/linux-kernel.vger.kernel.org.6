Return-Path: <linux-kernel+bounces-267535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5454094128F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A1C1F2464A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABF41A2549;
	Tue, 30 Jul 2024 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IQDw6a7u"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7FC1A00E6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343842; cv=none; b=O88VfgjXW4t4jbPLa58Q7Tdds0wPCjx4ytvFCD9l0+PntD+ZX+BuHVUc0WF/FYl7EiCtl6qoyFjPXuLg4sr359YfdALsYho0yygMAV1EeOTn9GX/fSuAot/7c1XeJIfHCeMZQJv2MbjRrmg7n6R94mrXCqkXNBYpwfrfg1uOE9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343842; c=relaxed/simple;
	bh=DMsUH1wkM5FQeR+Q94gKxFOskWK5JayWf+Su90i3p4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExT6X8Xb4c88rEZx8T/8C091JO+6/DHfMEVb4jUvn3ZDDwnCHOgTOJBtW/Y5Rwp0fncvmIJfPFPCM4OFlE8ev9JRBNsb8aGN3diDvfhsjRwVRivIN/GmjLpcvz7R/H0sxpjAjbqKHgTBOqdR0yivbtkkC6R+x2koIj9is677Y5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IQDw6a7u; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso27071805e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722343839; x=1722948639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nb/qSKjbB/ZuPlpTHCI0SwTZiwfEpxk2uiLYY2slQL4=;
        b=IQDw6a7uh/XlG9YuA1Aua1itA+07UlpaBvFZtSnQHP8Gyq5Z1FAOHbmt6PuB/9Yl4I
         wizVzx1XX50ubkPjMNXUKAjCzYfXqM+tQzCPWtQQ0Qa5AbM6LOgYjNcx8k6QHVxFR8Iz
         lczwOriE+hlwnldW41l/OTCIBY2kEGmoXe6PTdn/HgFqu+l9tasLt3zafLZDXgbMQOCh
         FzHz23Qpvk0CLRTawrh2/m8W0/M19/GkJEYvGCdc49waEBToLGv48/BL7aC1NSdQJ8Av
         0ofUozXJPhsrqdxAXWGTE0pMidiHVx0yLPtscjVg4Qss+xrl/N1/CtFK/qk1w5xA3zGm
         koDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722343839; x=1722948639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nb/qSKjbB/ZuPlpTHCI0SwTZiwfEpxk2uiLYY2slQL4=;
        b=FlOhAhCWL1wPAHCQ5SqxYvtlYtjj8UnlSb02Q/dt9DeB7JOVFB4rP7ePf0PkLz83XT
         6tBvnSLSOP2hH4LuiSpKm11HdDty4ghrh9lUdDHeRMGZs4lALhvBQCCrd+sQn53TqJLV
         XCRz5UMQcZZVmpf91NTHQzY9UUCgRYcG8HRF5laGKGY/0wGBgI7chOhiCWa6bTqw88Jr
         LkZABn8TWCpHf6I3dC7ZfiLjK8wwpzDOmNDD+fcf9+H9BYs1zLiDJ0y0KBUsPkVvrtBf
         2G0EkYiKJ+StEzMboH6sR5R8SAt9EkcAoZI8BQxzPwB++9P0yZW3JlMcFPaE9m+3vvqP
         SJEg==
X-Forwarded-Encrypted: i=1; AJvYcCWiLlsHhJEZEsWNga1mq+dRupB5NvR9tQ2IjSy2OJFnt5H3rFRadc6poZT1BxAF5MrWDDRH2BUqVOu3bSJBnGsM+bURDMcESMf7w6my
X-Gm-Message-State: AOJu0YyUzg4x5k+Cyep8Bh81m3lmDddyUwz+E4cTI7Lb9i2mYRKOuOBt
	swIuncT9LfBrBr7ilEGW2aEfUnoAkSQRKMFMLW6F4hTUVGjrQivxpV8cYhwsBRo=
X-Google-Smtp-Source: AGHT+IGtrN/qyndOtU5EbVTBBPgvlT3scXPmXKI31g3Y8pvJ2hEwbqVrraWIOB4B+x6XQNOoMWE1ow==
X-Received: by 2002:a05:600c:1ca3:b0:427:dac4:d36 with SMTP id 5b1f17b1804b1-42811d73a0cmr67316145e9.7.1722343838742;
        Tue, 30 Jul 2024 05:50:38 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:291e:4a48:358e:6f49])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42805730e68sm216521405e9.9.2024.07.30.05.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:50:38 -0700 (PDT)
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
Subject: [PATCH 5/9] drm/meson: dw-hdmi: split resets out of hw init.
Date: Tue, 30 Jul 2024 14:50:15 +0200
Message-ID: <20240730125023.710237-6-jbrunet@baylibre.com>
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

This prepares the migration to regmap usage.

To properly setup regmap, the APB needs to be in working order.
This is easier handled if the resets are not mixed with hw init.

More checks are required to determine if the resets are needed
on resume or not. Add a note for this.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 5cd3264ab874..47aa3e184e98 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -581,11 +581,6 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
 	/* Bring HDMITX MEM output of power down */
 	regmap_update_bits(priv->hhi, HHI_MEM_PD_REG0, 0xff << 8, 0);
 
-	/* Reset HDMITX APB & TX & PHY */
-	reset_control_reset(meson_dw_hdmi->hdmitx_apb);
-	reset_control_reset(meson_dw_hdmi->hdmitx_ctrl);
-	reset_control_reset(meson_dw_hdmi->hdmitx_phy);
-
 	/* Enable APB3 fail on error */
 	if (!meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
 		writel_bits_relaxed(BIT(15), BIT(15),
@@ -675,6 +670,10 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 		return PTR_ERR(meson_dw_hdmi->hdmitx_phy);
 	}
 
+	reset_control_reset(meson_dw_hdmi->hdmitx_apb);
+	reset_control_reset(meson_dw_hdmi->hdmitx_ctrl);
+	reset_control_reset(meson_dw_hdmi->hdmitx_phy);
+
 	meson_dw_hdmi->hdmitx = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(meson_dw_hdmi->hdmitx))
 		return PTR_ERR(meson_dw_hdmi->hdmitx);
@@ -765,6 +764,11 @@ static int __maybe_unused meson_dw_hdmi_pm_resume(struct device *dev)
 	if (!meson_dw_hdmi)
 		return 0;
 
+	/* TODO: Is this really necessary/desirable on resume ? */
+	reset_control_reset(meson_dw_hdmi->hdmitx_apb);
+	reset_control_reset(meson_dw_hdmi->hdmitx_ctrl);
+	reset_control_reset(meson_dw_hdmi->hdmitx_phy);
+
 	meson_dw_hdmi_init(meson_dw_hdmi);
 
 	dw_hdmi_resume(meson_dw_hdmi->hdmi);
-- 
2.43.0


