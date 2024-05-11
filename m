Return-Path: <linux-kernel+bounces-176771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 884BA8C34AB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 01:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC76281F20
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 23:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EB35102E;
	Sat, 11 May 2024 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hb+wfR0d"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D99F3FB1E
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715468433; cv=none; b=FHjMrFbHmYj9YZjFIPkJomG42hk7FDrJQqL7fYPbSLve5yqMv7plitEEJWYOMVBAL4MFaDXvPA5Qq/LjmUZAF+ucED0p3U6KsoF+uXrhYaVhO0Konf4OAoD2384UyI71fjqTTKECAcbL8zXLY7zCbRKYpJc5RzItT3UGXfYb1kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715468433; c=relaxed/simple;
	bh=DOHrqeOiwanjV11JDXphoCFUegn+i/jlXSehEJEsJf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HfjIwO++ZQ2dCMHPtcBwq+NguQRdwuyRkhwo7qguNGKTDuAjl322pnSANDGkertBqnwTsDCY5nZVEyAP2HgtfiHOEu9m4EJVLjp3KqBW2pR09TKeGWwylDL68osU/MH8XjfVs4v/8uv2PAztZI1qzEKc8FAmKLWB6OXr1Vl0+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hb+wfR0d; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51f1bf83f06so3810246e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 16:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715468429; x=1716073229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/qHpoqYTUuOwsjGMAXRWRB1z/cT96H3/x5oO5XeWouE=;
        b=hb+wfR0df+DfKw+wBM5MlTBe9leQ/FzLEcZpzGajW2xuhiv1usmLvMlrwyPTyA+CQT
         y55pjf2TrKXTjcEvb/TxeM2uIqTyDu/MwzYHMvzDrZT2Si61zelY/J4RQAKWw+KH/jfP
         n5EBvMb95vBnOuq4ImQ/qxNACOo7ZtQX8/b+OKs5ACSGMHizPznAfroyh944V3Wkov2e
         gUy0g45iSEnXCvAdaC0ZaNm6SD3dd8CZb03YAopgQwyC7k11h8CoQhT2LPPSGX4RFnMb
         QFKQTcMjbEEV72JdInJRyxWo+4xHxlUbbvqA5P/Scdz3eNoxJsdV7/FNtz0gw8fY/xue
         B9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715468429; x=1716073229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qHpoqYTUuOwsjGMAXRWRB1z/cT96H3/x5oO5XeWouE=;
        b=YCt0Df5v/lBm2XF2B76xffXGmipCi4wOCmvl9du+CyZJXYttiv/vrz6ZVdnYD1Fqpu
         z5fzFR0s8MIeabkokQmmel1Zc/Xl1c/NghFvp2z1oRn3KRe3yEANaW3qsy38r/5dI+to
         lIj5aF7krRTS+GtJIHAjOfD/XQz8bITHTFn3+1eaKtNOniUPN4Y2RIcjnHvsRCR/qoA4
         JaOpp6+4FH81VzBya1KlQbBGUe7Yk0+S+W3/ur48n5eelAywZJtrC449wYuIXxEb9fUc
         6ij5Mh7hNBkwG4dIvxA4chz85T3Jrt+HtMplHohpN3qTafsV3AtatDXzwx3XxhsO9LpY
         aVuw==
X-Forwarded-Encrypted: i=1; AJvYcCXqowgu61qApGOYWVckMn7C4k9bjDU9kQWjztdjqlb0yHm5PP+BEcTyOLVhdQzbPKmfOpTVrndG8JGMKSQnWTjP+ZhQ8/Rxm2DMfbo0
X-Gm-Message-State: AOJu0YwzNSKRxCt+wRjgb77/JwB5zmAXEMbBR3dKTPRWcbnOPHnrgqxe
	DKFeYq3wk49SuyV0YjLxZX69V1W7rwS8j2b3snKxajcnxYLy9lNn/dlLixwh50A=
X-Google-Smtp-Source: AGHT+IE59BTbplb1hjthCMm6iJl5mfrsnrvXEpw54uV1KjAjRpehYXJtF5g8OLkmTkJPEP9brZ7nKA==
X-Received: by 2002:ac2:454b:0:b0:51d:8283:cf72 with SMTP id 2adb3069b0e04-5221017e670mr3705647e87.57.1715468429712;
        Sat, 11 May 2024 16:00:29 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d3717sm1134222e87.173.2024.05.11.16.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 16:00:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 12 May 2024 02:00:21 +0300
Subject: [PATCH v2 4/7] drm/panel: ilitek-ili9882t: use wrapped MIPI DCS
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240512-dsi-panels-upd-api-v2-4-e31ca14d102e@linaro.org>
References: <20240512-dsi-panels-upd-api-v2-0-e31ca14d102e@linaro.org>
In-Reply-To: <20240512-dsi-panels-upd-api-v2-0-e31ca14d102e@linaro.org>
To: Douglas Anderson <dianders@chromium.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Vinod Koul <vkoul@kernel.org>
Cc: Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2547;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=DOHrqeOiwanjV11JDXphoCFUegn+i/jlXSehEJEsJf0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmP/iJCMI0EmGQFpfABnhOIgzvW0Z2hfEur/bwd
 ugzH9cTMtOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj/4iQAKCRCLPIo+Aiko
 1dm6B/9UyHT0uKo3SGYHl3YEsREl/QK/u8yxWXXZGGKUeL6QEasG5JyllkZFtnO+imD5Ymx3bp0
 qDxkn2q9eZXR15gVxhb6zBJo2I7vwAcY8iANJFj8e2Pb33sUuH7xK7WaAsC4fHTQ8TrCB0foybd
 AXinWoceTGIIzNIAG2YcxkdD7c9LCgNsXa1L60Id9fx6sO2rzZTs2EypVKAM7Jl7cTx0vuOSHp0
 sdupSoLMb0KAfvMc6kykz1/IsflTSETD0/ajwNsvk4jceIGjbYFsMWrve54LRZBczwLnqUm9Q+q
 EzQ+nDtBl+of7NvZPFyDPxftwjiqewsCCf20OlCe6uhIxVou
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Remove conditional code and always use mipi_dsi_dcs_*multi() wrappers to
simplify driver's init/exit code.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 48 ++++++---------------------
 1 file changed, 11 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
index 58fc1d799371..830d7cfbe857 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
@@ -402,19 +402,15 @@ static int starry_ili9882t_init(struct ili9882t *ili)
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0x92, 0x22);
 
 	ili9882t_switch_page(&ctx, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, MIPI_DCS_EXIT_SLEEP_MODE);
-	if (ctx.accum_err)
-		return ctx.accum_err;
+	mipi_dsi_dcs_exit_sleep_mode_multi(&ctx);
 
-	msleep(120);
+	mipi_dsi_msleep(&ctx, 120);
 
-	mipi_dsi_dcs_write_seq_multi(&ctx, MIPI_DCS_SET_DISPLAY_ON);
-	if (ctx.accum_err)
-		return ctx.accum_err;
+	mipi_dsi_dcs_set_display_on_multi(&ctx);
 
-	msleep(20);
+	mipi_dsi_msleep(&ctx, 20);
 
-	return 0;
+	return ctx.accum_err;
 };
 
 static inline struct ili9882t *to_ili9882t(struct drm_panel *panel)
@@ -422,43 +418,21 @@ static inline struct ili9882t *to_ili9882t(struct drm_panel *panel)
 	return container_of(panel, struct ili9882t, base);
 }
 
-static int ili9882t_enter_sleep_mode(struct ili9882t *ili)
-{
-	struct mipi_dsi_device *dsi = ili->dsi;
-	int ret;
-
-	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
-
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0)
-		return ret;
-
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
 static int ili9882t_disable(struct drm_panel *panel)
 {
 	struct ili9882t *ili = to_ili9882t(panel);
 	struct mipi_dsi_multi_context ctx = { .dsi = ili->dsi };
-	int ret;
 
 	ili9882t_switch_page(&ctx, 0x00);
-	if (ctx.accum_err)
-		return ctx.accum_err;
 
-	ret = ili9882t_enter_sleep_mode(ili);
-	if (ret < 0) {
-		dev_err(panel->dev, "failed to set panel off: %d\n", ret);
-		return ret;
-	}
+	ili->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
-	msleep(150);
+	mipi_dsi_dcs_set_display_off_multi(&ctx);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
 
-	return 0;
+	mipi_dsi_msleep(&ctx, 150);
+
+	return ctx.accum_err;
 }
 
 static int ili9882t_unprepare(struct drm_panel *panel)

-- 
2.39.2


