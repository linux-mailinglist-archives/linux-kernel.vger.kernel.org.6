Return-Path: <linux-kernel+bounces-175041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C378C197D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4242817FA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9441C12D77F;
	Thu,  9 May 2024 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MziOdwdB"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEE4129A70
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715294261; cv=none; b=EZ9k5mAFiWCsih5pgfSsgT/XpBL159kupYgruFumGvlv4YLmV+mLrrjnW5/1TJFjw2HBPCi7uWPcVPUoQ/Ilvz8s7gn0zNHQ9lYXxEVJIUOb2SDH7uvRlf9gTiT7MjjZGTqBsLm845D99U47tBZ//d9+j8RhxRXFTLDAGHuacxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715294261; c=relaxed/simple;
	bh=LbXKWqiDtaK+AQ1NXY6dRRGJIa5nbJ3JMjRjO+iNdK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ex++hIO0zAVrBhMgeMXMnSladie06YyqWuWoCpyu1SqJht5HlFcNVX//2u1Fqhoy0rzSB9mKNaQWhPJ5YfYJ8JMPWRLN4Lh6tGxj21pHHDVQ1c3o0YUMq0Z/d8wLe59w7QyvZ+AFDsgpKZFV0w6qrO97rQBPQDQJx6edfGBJzZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MziOdwdB; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e43c481b53so18205291fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 15:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715294258; x=1715899058; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJY1WdpDYNtMmaPK1COHpoOEPTHjLRXGYqacL5vf5B8=;
        b=MziOdwdBWQ3YQ1JOZS/BBqkzOq0ai2/CBJmYW4VxHxl36Q6cpk9iWd+vv4Y8QwRV5L
         DnCE6BR6tU6zLJWm3LQ3ewJldqmATBVMt6JR4A+fDconEd19HV3+cKWeyOuq8lqpFZTr
         fRhUZWOj2U2VcDY51S33QfGfbkF9xOc93hlWqV/GJP+XkvWbSSATpuUFSwyB1tfj4VUr
         lIA0H9ry2QLc4EjP02CQxSibPdi+/twcX5Jwg4yXYniOoRdcdsnMyzJpZu4pV+I+AUOn
         eWLZpWwUCMrSTNTKH29B5lAWAbXqYUTHBtdyayyAHbLbv/hI20tB0dv8rpggqP1LnR1R
         G6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715294258; x=1715899058;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJY1WdpDYNtMmaPK1COHpoOEPTHjLRXGYqacL5vf5B8=;
        b=YkjRwJK62MNqLYC+lun46eK/hgY8aILah8rMGILeH1yv6qAEJUtSe4KxEfabeIBJQs
         nkv6JhugzSyKldelbkvvovfwJnyvc7DUpXL0yNiqiaZtGsB7wLNICYhvbkCZkzHfpW2r
         RJyMIJHZl8WBNQ2Esc49xWqy3SBPBOK0wHAkVPyjlvdRzdDh7lEnT5L7X+2DyNsHrXWK
         e7dzm1OUFVZHy/kIcXrTbbKnnZCUatN0FQmc8hMe0gSVtUpWaCIroze6UpU4irBgdMoE
         +67hnroDL/zjQXuvfaGfQPV9SEGkAyXao2aWqHf7c1bgp6ROz3RKiGE8Q6DtG1hjiU0O
         KZMg==
X-Forwarded-Encrypted: i=1; AJvYcCVRjT0ctcum5uA/Nr8DmRz97NeLCMzlSrKmvHorOR72AIC+cj75JgRuSv+YxanoTFajqQPkeO9M/mAFF8HUPvjKElC/+XgA1TIaxY7y
X-Gm-Message-State: AOJu0YwUJlpe5sFMHgOhLlZHb5YUCpWVv9YWoSw6sEB2vzorOZtktgUG
	KH/URUYpjt617ps5fUT5A77U0ZPfNarp2Z+vKNBDNZ3WpWoXSBgFxIhcEYX+GjE=
X-Google-Smtp-Source: AGHT+IGFTvw1vxx85dKbJll5ZaDg39l0SDuhBFDjN3HTXmrCOzJmUUBmBQXdeARfZ/bdKcDF52kWww==
X-Received: by 2002:a05:6512:451:b0:51e:ff32:16a8 with SMTP id 2adb3069b0e04-52210273f01mr460200e87.62.1715294258223;
        Thu, 09 May 2024 15:37:38 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d32f1sm457974e87.181.2024.05.09.15.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 15:37:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 10 May 2024 01:37:36 +0300
Subject: [PATCH RFC 3/7] drm/panel: ilitek-ili9882t: use wrapped MIPI DCS
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-dsi-panels-upd-api-v1-3-317c78a0dcc8@linaro.org>
References: <20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org>
In-Reply-To: <20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org>
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
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2005;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=LbXKWqiDtaK+AQ1NXY6dRRGJIa5nbJ3JMjRjO+iNdK4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmPVAuGD8s+0CZnKan0NSsgk22yRkq0bYPJEx4s
 J4D6SGoo62JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj1QLgAKCRCLPIo+Aiko
 1U1QB/9jf6h6hbySFkd5s3YSe7Rk72+e2cx8A9V4vSgxt24eApZJ8tUZarJ3aHGtZ2fr2/pPdLz
 /Eq6giUUMEAURLyx956TTierWY5J7Ifq9AVSoQDdyxcmMMiXdclrpBzeR/fPA3br+R+xqBoXhHb
 DAKhaiXm776JWUDqglqM6VoEaH+ciW2ZQG1Wa1jKU92K3EHRzTaDFa3xruoems2yPxoQvy69N+k
 E7hAEAhb9IF5gVcFYPUWKKyUHsPRB6jIJ2xMeuNX2WkR7G15sr33GQvQLlaSVdAnEm4nMIyBn7h
 X4myAKi0Qf2VNKhrFKpGwzMDBu9PkLnkloCNcZZaRHBlc2xY
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Remove conditional code and always use mipi_dsi_dcs_*multi() wrappers to
simplify driver's init/exit code.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 30 +++++++++------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
index 58fc1d799371..e7a74d5443b0 100644
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
@@ -424,20 +420,14 @@ static inline struct ili9882t *to_ili9882t(struct drm_panel *panel)
 
 static int ili9882t_enter_sleep_mode(struct ili9882t *ili)
 {
-	struct mipi_dsi_device *dsi = ili->dsi;
-	int ret;
-
-	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+	struct mipi_dsi_multi_context ctx = { .dsi = ili->dsi };
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0)
-		return ret;
+	ili->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0)
-		return ret;
+	mipi_dsi_dcs_set_display_off_multi(&ctx);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
 
-	return 0;
+	return ctx.accum_err;
 }
 
 static int ili9882t_disable(struct drm_panel *panel)

-- 
2.39.2


