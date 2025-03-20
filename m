Return-Path: <linux-kernel+bounces-569353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C2BA6A1CB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE6A467233
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679B0220696;
	Thu, 20 Mar 2025 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Xn9Ht6ra"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D334D2066C8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460558; cv=none; b=aJ15YtJBv592Eix7hKjVAY1txcnI7KoINZ9aqB0SE9FtCp76ywSzLJPitlmX5pyJ8hrny7bxh8jS8xrMBu6mt1hX0ei9Mk6n7a6M9Nw7PT25+Bc8tI456Gf/G9tA0JGII2qdpepuJfg0+5DGiyNQKqXyGp/knJOTBtiQmFaHODY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460558; c=relaxed/simple;
	bh=gHl0LdUTqSzXFqfH/bwqt0Qp3EzE+6UWudOR8k0D9wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kcnVk9Fqtu22SpUwA4af1udOCm1w4rB7pUpekaW/qSqO07KJfr0X63lvyEw5uV59hFgVJ6mM6Pu6TenlJpO1mF4ZAUoILyN8cEyZySDYbJrighcEWGlfSQhiJJQs9rRGR1DjtGU+609yDCoWJb5V8Et2wcJrYQ96dADGCpw/n1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Xn9Ht6ra; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso2961425e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742460555; x=1743065355; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJV9USVZmsP9ZdAAuuoldoMM46JkHDHsnIzVnX7GtUI=;
        b=Xn9Ht6ra+BtScPoyBSPbPiUyir+F6kd+sL/DRYI6PPFm1B7WHVxKROM9gOQ+jPtfW7
         CtNr4Z8Gn+SEwvPasnyvCDEbU01jvldB9Qk5v9FCG+It7JDurlUJFzlAsAwNIbSD/tju
         JZq4uSVRACsdFu4OQylxBharPTfiO9DTXH0j1/ex+4cGqIoL273hV7rXsdyIp4eyKmUB
         zzNekqlhc9GH0qf3o7gVY1Alp8hKuceBI2dEkJE4dhlo+VIw/DJjFc1S0Rrix0y56jof
         B+Nd+kCbqXR653mk6m9STLjAcBsrkbdMpP/5kkc7L0xvu/FuTN/aMFr/JLHVN3iqGEHV
         GbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742460555; x=1743065355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJV9USVZmsP9ZdAAuuoldoMM46JkHDHsnIzVnX7GtUI=;
        b=km/gBt+cLe4Hho1/+MzBhcTjNiGy2AaZVMSwGt5eIB268x2xBGM+0z3HqSKk9LPuyZ
         1hxjDb3Pn5H+36hFXj1/M96cjOqoXvyvG7EsT5Bw8gk9pADrPS1n1FQWSiuGQf0mpfB7
         7ejCNUc9IKRUDHctse0aYTAVLnCi9Pbq5VlETPjNGcKbNTwu8FqurhRXWOcws1ynk4pj
         B6XrI4okhnADLsRCxOjA8/dxMhrR+oIWJmFT1toBos7sA32CUi3DFy8fdwX4cM0L7QTq
         LIZ2Hv1AZbsgrBowReSw9p+ftLE9nQl4CGCVeGTcIHugU9J46H0t6yBfjHOiU/BZPOk7
         pmHA==
X-Forwarded-Encrypted: i=1; AJvYcCV5LWFep70VPvlQCQIiQtnz9UsWReby4A3+UFUIEEGZ07+pDRkM11UTdDIrwcVIu8sHiZRzxRDnQ0jU+Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoQS5jHkJAil7AIi1hZ5Igs95aIlbJBAE5uxGP1Re5Yw+0mLzQ
	ugq0buAHfrBUocbLbyaaoiRU7y83olqR7CPBeIqHT0p9vaXgVI8N2o5zBSHu4R4=
X-Gm-Gg: ASbGncs+ko6SqWxkcStY/tCw+OUytJzRwuw0mFKWaRR+nt64ZImvQuyZYJ8B/U+MI/K
	LJRXXsFPoJ/psYwcmj032rLHhZ4dZFxsymjWHdboAlLAwbH68afuYOQxwa8hZMN0CluZeirtjMP
	juPnKqmm//0juA1GRkGUR+GVceaw7FfhCyLt+AX+pRMADyjr2f9jHn1A6THt8jjeFwxs+Txmgdr
	jzUMCzAduEmj7qGFJEiUnyXknr0GvqHiTqXK6EvkTDB3rH+juZANVNAb4zeWxhMGO1AwQ3xic8w
	QnGJP4DKhKvSbCjHKp0quk3Z8ruemPcrATfdUMildwZh/6SzYWpDZvVpU6I=
X-Google-Smtp-Source: AGHT+IGvyzObe3HUgUPIOkcUmHLI+6xANcIGJKxeOg9jouXNulvNZlxlIH6nFdT6PpdEkn3OcgskSQ==
X-Received: by 2002:a05:600c:138d:b0:43b:4829:8067 with SMTP id 5b1f17b1804b1-43d4ac2b356mr13977715e9.6.1742460555324;
        Thu, 20 Mar 2025 01:49:15 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:5ee:79d0:c11c:487d:c821:54a0])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d43fdac9dsm41381655e9.30.2025.03.20.01.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 01:49:14 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 20 Mar 2025 09:48:46 +0100
Subject: [PATCH v8 2/3] drm/panel: startek-kd070fhfid015: add another init
 step
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v8-2-c2dd7b0fb2bd@baylibre.com>
References: <20231023-display-support-v8-0-c2dd7b0fb2bd@baylibre.com>
In-Reply-To: <20231023-display-support-v8-0-c2dd7b0fb2bd@baylibre.com>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2311; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=gHl0LdUTqSzXFqfH/bwqt0Qp3EzE+6UWudOR8k0D9wo=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBn29aHBpzXiGFeZYZjQ2WV79w2etmusdRumeCDA2/j
 En4xIveJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZ9vWhwAKCRArRkmdfjHURUS3D/
 9vN0KMVYZZKmprhPA5LN7rawwuTGP/uyEhk9jFV0/j6JL6U4PVd0nArK1OQLjxBSyc8nUS1QhpHFhL
 GNVR07l6xuu0efimjhIgzKpfapyc0xJDcsSLokHgtrFYnnFsxhYNegLt2qFhQnAzfhs6CkD8JQRe7j
 K5ZiuZbQaE9rSuPU9dMg9/Nc9+eO8HpPVfckzLWretHlNh7yz42U0FAUp9KvfnDilzIcxzydGuuNzy
 Jd/N0DstuCiy80SPtbL4cE8FVcQZpZe5jPrx+mMVIUtyaVPTkJwyP++ureQvWDzAQ334cDPfrwy2Ei
 Oeh0VnncqzOktXqxToMmHFzuFwKfoDr0/6LV+dlVtsI2RP/3/bW67t8xKV0I6eMGMGESBck72W9vwD
 ca1+TzhnFFesumJlEkaj/XnlS6mvr4PPLAaqauBwaKTiAXgZT/btqNWTVJBx+sYj3/dyd+1Sy0NtJ2
 lpmstf0PEKIOMLotSfh7vkJ/+71UqXjgjVbmV6k0f1lgMLHIpGEEqNz/Us0zURzuYQEVwsj6cFRsyw
 W6Lz1Pgec4nQ9wjY5aeCuLQPAkLl9D87UWlEs4SeCgePB7fs9v/PogO0y5kTxHItyjqRqV2XGGIAxe
 Lu9b+dTaPTCrjNEDXVF5nGl/HyIMiJ8yrA1aWPFooOUtSOMg18/vt4NOuirQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Currently, the panel set power, set gpio and enable the display link
in stk_panel_prepare, pointed by drm_panel_funcs.prepare, called by
panel_bridge_atomic_pre_enable, pointed by
drm_bridge_funcs.atomic_pre_enable. According to the drm_bridge.h,
atomic_pre_enable must not enable the display link

Since the DSI driver is properly inited by the DRM, the panel try to
communicate with the panel before DSI is powered on.

To solve that, use stk_panel_enable to enable the display link because
it's called after the mtk_dsi_bridge_atomic_pre_enable which is power
on the DSI.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../gpu/drm/panel/panel-startek-kd070fhfid015.c    | 25 +++++++++++++---------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c b/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
index c0c95355b7435..bc3c4038bf4f5 100644
--- a/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
+++ b/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
@@ -135,19 +135,9 @@ static int stk_panel_prepare(struct drm_panel *panel)
 	gpiod_set_value(stk->enable_gpio, 1);
 	mdelay(20);
 	gpiod_set_value(stk->reset_gpio, 1);
-	mdelay(10);
-	ret = stk_panel_init(stk);
-	if (ret < 0)
-		goto poweroff;
-
-	ret = stk_panel_on(stk);
-	if (ret < 0)
-		goto poweroff;
 
 	return 0;
 
-poweroff:
-	regulator_disable(stk->supplies[POWER].consumer);
 iovccoff:
 	regulator_disable(stk->supplies[IOVCC].consumer);
 	gpiod_set_value(stk->reset_gpio, 0);
@@ -156,6 +146,20 @@ static int stk_panel_prepare(struct drm_panel *panel)
 	return ret;
 }
 
+static int stk_panel_enable(struct drm_panel *panel)
+{
+	struct stk_panel *stk = to_stk_panel(panel);
+	int ret;
+
+	ret = stk_panel_init(stk);
+	if (ret < 0)
+		return ret;
+
+	ret = stk_panel_on(stk);
+
+	return ret;
+}
+
 static const struct drm_display_mode default_mode = {
 		.clock = 163204,
 		.hdisplay = 1200,
@@ -239,6 +243,7 @@ drm_panel_create_dsi_backlight(struct mipi_dsi_device *dsi)
 }
 
 static const struct drm_panel_funcs stk_panel_funcs = {
+	.enable = stk_panel_enable,
 	.unprepare = stk_panel_unprepare,
 	.prepare = stk_panel_prepare,
 	.get_modes = stk_panel_get_modes,

-- 
2.25.1


