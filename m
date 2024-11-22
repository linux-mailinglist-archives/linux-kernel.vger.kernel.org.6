Return-Path: <linux-kernel+bounces-418000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F39B9D5BB2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45832287D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B761DFDA8;
	Fri, 22 Nov 2024 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="boQTSLxW"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B50F1DE896
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732266813; cv=none; b=GDU5FBmPkPaY/Snn/sksKEQRCRV4kYgt3U4PhtFrjVgDyyU4ihwqWXliEV/0cwYTZr1tN4NkTqju+9hW4j4m1kurGI3wJHuDp4QVL40ZPjy0ZeelgB00XclN8NRSPzF3vqZ928FxwCNLu1GdCf5SccWNmnDHrO5ZhzTNAHId0hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732266813; c=relaxed/simple;
	bh=CHPPIcbOk/4oF+oFDkgVgA19LBW1SDNLoLgjIjG3wi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VG2q+DQnyFq4rJEdw2KG2HbA//3L2yvb0M5/GULhBpTWqjndwh0MsJengP/t6c+k/cJx8LxaTwt3MFMftnXmrlqjfWM4notXleDvkbTNQrUPx/eT6QXAo90NJWd/yThBh3XbCRIXoNZ0h2IYhf2ZYJHJt5icSiTv2ESBUQZAeyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=boQTSLxW; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53da6801c6dso1628398e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732266809; x=1732871609; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hHECBYEofE1LVFfISufmiOFENr43Xg+pptUAkUKUyA=;
        b=boQTSLxWLpdTG3fJix388xicu1XtVuf0VnpJZ1slsHBZh8jWJKsqZCICmbsskKfM9O
         FHghq9c74iZS6mdypQY7UyEEb0FYE40AuWeNC/qbTD6WehgdbQ0/+S6ePypvNq1AyWwY
         ZO1k2lsGYlJElzBoLQwQw6yaGyh4MT4j+J4LYJZldr/1oCDEh2JroIObuY4rT/FW2zX0
         3pE8ULj3FrDSp7kZsxTOLgOLhXqnxk78sRQbvKRbjMsDbap/+wDdxrsNiPpXMpRC6FpM
         oi8czz36NeSymQfQAmvjM+TmBoWhFWi9KntKxlo5axUa7c4EhH0ZFBHKQjuhI82+Kyep
         Zi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732266809; x=1732871609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hHECBYEofE1LVFfISufmiOFENr43Xg+pptUAkUKUyA=;
        b=qgPO3ief5qyxWZ8gM68Iw29W/lX8vSneNR5DIIrD8Q5uFa8yNbe1+r+/hID3En08uc
         eDdp85qE2vRgOsQtYs1kc/r67WAUQtaG0CpQSUqnGLiH+jlficuI5XhM7XffOGa4X9IN
         l/33wj8MsW2rXWCtGFeUe7CPrzKpJ19XH9jlau8R4et2k7gpOzqYCNCkdXQp8Ddw1Mmn
         X86fZDT203DCOblbQb9T++MCHnyk9//XSDL3RP4QV7dZhf6jee3udR+Rk/VqakC6pSSw
         K0jEJQ8Bg+tlYKHuqcaSRbkgZGwpWGLKJ+AUAv4pNge9Kgmho5LgOEZsIDEMD8GPoUWk
         JsKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFGcfPp3Y2Ni+JotJIsl7ifiiT38UX3JyFPJ9BRWkmNHHjSFc24zaOzxRnBAEC7C36yGPycgAvQw8qQWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlptE0zZdTXZhFskend07wHASjxm4TAan7i4G0sN1/K6B+8nkZ
	Uaw53YdLJN+BzGwx373SWBw5fpwdDVlUzxE99ADhOH+MUx5Hx3DhtwAn3OEmizpUxm7A0jWBQwy
	B
X-Gm-Gg: ASbGnctvT/BhPQps+SsYi+3TyX9gB8rk6xfKDvf6DM6hawa8OapJvbHJYuLcfdlW93v
	TMmEJXOObZy0l2TgCVofZyg+Rp6BKIsf+LjgYADM0UmSzytS8vEdr1ex8iLtaE87Xt76wbI7o+U
	f2DPWm3Ftg0rsdCy6rQHLsS6H2yE5NwnAlp08AM/nBM/cgS2k9qP6n/jPIZOTRZPg1m2lmk6tmQ
	k32nmE4faFTWiUg4EwxIzesrc8LSMwNG+PDMCwZf50eZvgCKird60bVKw==
X-Google-Smtp-Source: AGHT+IEacF2R7IM1WOXDiiyEZw72yOQOODx70vgQAIsHBOvrbaiI7+vacg+XzA2nbeGhQv/5FVkoNw==
X-Received: by 2002:a05:6512:33d1:b0:53d:d661:ada with SMTP id 2adb3069b0e04-53dd6610bdcmr495351e87.8.1732266809396;
        Fri, 22 Nov 2024 01:13:29 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2451386sm299530e87.77.2024.11.22.01.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:13:28 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 22 Nov 2024 11:13:04 +0200
Subject: [PATCH v4 08/10] drm/bridge: lontium-lt9611: drop TMDS char rate
 check in mode_valid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-hdmi-mode-valid-v4-8-2fee4a83ab79@linaro.org>
References: <20241122-hdmi-mode-valid-v4-0-2fee4a83ab79@linaro.org>
In-Reply-To: <20241122-hdmi-mode-valid-v4-0-2fee4a83ab79@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=CHPPIcbOk/4oF+oFDkgVgA19LBW1SDNLoLgjIjG3wi4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnQEsiedj1vWQXgZXcLJ02DcFxwDE5gszj18sAt
 X34dCGJZmKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0BLIgAKCRCLPIo+Aiko
 1bSCB/9slyF05dGTP/R8bS3bpgFrC80+3aCli/HGX/hh9ZecB7M0/4Gtv1SuBYM+KdZhbrux6LE
 pczE2VQiA9zmyEtW0G5wbp1FeQvVBM8ruyAQIhmvjHQQTlnjC8Upiw/vuPynB4nUVZWHfhhYQmL
 zAEr0NKRnfHyVcsBRwxOdxyoVLnAqyl4aW9Ms616ITIiIb8MXaArqLlDxULPZrDRxxX17OEl0V6
 PCmq7Qc1dmPgMoaJfFSHCVIrgBet7swGVQ7Bft4pgEsIeljuwq+YPquR/XJM8bitfAaIpRNn1BX
 frUWcluAbmUtixwbfjgPP6l9mfVYq5tjcrdl+FwRNElIvckp
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Drop manual check of the TMDS char rate in the mode_valid callback. This
check is now being performed by the core.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 8f25b338a8d8f95dc0691735ac6343675098f7f7..1ffbe473e4103dfc315a8cd3571e9407bf518797 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -757,7 +757,6 @@ static enum drm_mode_status lt9611_bridge_mode_valid(struct drm_bridge *bridge,
 						     const struct drm_display_mode *mode)
 {
 	struct lt9611 *lt9611 = bridge_to_lt9611(bridge);
-	unsigned long long rate;
 
 	if (mode->hdisplay > 3840)
 		return MODE_BAD_HVALUE;
@@ -765,8 +764,7 @@ static enum drm_mode_status lt9611_bridge_mode_valid(struct drm_bridge *bridge,
 	if (mode->hdisplay > 2000 && !lt9611->dsi1_node)
 		return MODE_PANEL;
 
-	rate = drm_hdmi_compute_mode_clock(mode, 8, HDMI_COLORSPACE_RGB);
-	return bridge->funcs->hdmi_tmds_char_rate_valid(bridge, mode, rate);
+	return MODE_OK;
 }
 
 static int lt9611_bridge_atomic_check(struct drm_bridge *bridge,

-- 
2.39.5


