Return-Path: <linux-kernel+bounces-176773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925E08C34AD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 01:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A832281F56
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 23:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB875731E;
	Sat, 11 May 2024 23:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4XfyudR"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B78C4F1F2
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715468435; cv=none; b=E6ccnqrFrBO2ed3GQikxM4Y4Ahh/FdUBtXAHiyq1mdRASjOkcG+8M3+AAgbr0jQ8Wcwte9xmN0MTSwcd0iy5PBMiSs6XOHcZBn6Tw6feYeh+9Eqs7mylWPqfN7zIJZHFqZW+/ifegXRwkxr+IscpD9JwZ8odMjbcKOsTeHxlqKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715468435; c=relaxed/simple;
	bh=OgCl745YGNA8tkD2Ib/h4hAsQgMXN7Ouw6Gh4P8Oqr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hepnlv/rfZVfqiqQemp33bJfdpKn5froEAb3Nf15WD8thGvdSD171ynaHGCnyQCYCd5A6PJlsASxJEXT+XEkVaZwhvWORfTwRqKEfzxtWIkLm6NImGBkMJGWauRBm1NdEkBP343QiJVqMuuvxRwj9yE9DbPS8sfU0wOi06whd14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A4XfyudR; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52192578b95so3576207e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 16:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715468432; x=1716073232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4uNGOso+NPooLyBvhY0LTdeJRmp7LUENjYu60WmKgo=;
        b=A4XfyudRJNWTdSJ6Rwbu4aJ0mS4MNXsaF8+f9Xu5knGKEAlQ2xdyZLRUDcMORB+rtS
         jBj4uMxbWI/puN3oBg1P6XVI6OSWnA+pZrND5SoTRNPD8D8Uad4w5ctwY96aosfwNXQe
         rV0pMoInXZwyvjjF8XrmLMnTpJ2IrAYi3AZWT4g40Fgpdb7pFUOOT6G+rY36QcW2V+0P
         ykpGDfkrJJyMVBoDOULr4s359t0C7IBcrSxQtRD5L+AMFp5ktxihWqnhnHRyt+fl1ANz
         S8/mQlWb50JpAIwwyFaPrGCBwPXjSjICsgchJbk4Rawk/v2jY2/fUnyrZF4/StLawU9w
         p2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715468432; x=1716073232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4uNGOso+NPooLyBvhY0LTdeJRmp7LUENjYu60WmKgo=;
        b=MdC86atMDiGBh4SCK9LTx1aWEIkwA9+EBmQ2JUhzl/gJyv5aHqoK1o7bNw3oO1gVoh
         lHcHJMft6ZojgIWU2IPF3q1N97fZbjWR+GrZQvFW8CLfCzcFbhWy/KJG5NYQPlCAyU4u
         pvhS6sb5WY2Gjg5yvmgzTG6SjaLSAtKGjPgXRO87n/IPaWbWtIr2Hntpq401k0plEwFB
         ZxnuWaAOvzw2JX+oS19pG0erni3IfAchrPUQtH74cwlyO1yxkIgkD1aiBg5k2G6SDOTi
         qTps5ns6ngvRxZ0Sav7+VghxCW39Uadf2+y3ndPZcZ+2DLYRPtuEYBzmUaeZyPbRqucK
         kQeA==
X-Forwarded-Encrypted: i=1; AJvYcCVGxe2e5a8zHDIO6TKTl7u/7e6NiSV+D1wok7WB2kX/cz2U7SSdV1JDooiIoY/SiLQs+6rxzHXa9lv6hsAbLfEpcNnU8Le0JirN11Aq
X-Gm-Message-State: AOJu0YwJYtbFD068rWAfqbhgV3Ld10Mv9jTdkpqE7fjF09pdFLjogglK
	MDZWBr91kLu0fsnlWhAnnZT1GaNnMdyYJwMMbJkutlvbnO/FtScUb0FsBn/rzco=
X-Google-Smtp-Source: AGHT+IEb7pyVhy/kijEx2pcpLZpwZVbb1O1ml8VR743ch3WEd0/dsCMJWxyegjkwaoXS0wdRD4FqZg==
X-Received: by 2002:ac2:41d3:0:b0:51c:fd0a:7e34 with SMTP id 2adb3069b0e04-5220fb72d61mr3603209e87.22.1715468431830;
        Sat, 11 May 2024 16:00:31 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d3717sm1134222e87.173.2024.05.11.16.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 16:00:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 12 May 2024 02:00:24 +0300
Subject: [PATCH v2 7/7] drm/panel: lg-sw43408: use new streamlined MIPI DSI
 API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240512-dsi-panels-upd-api-v2-7-e31ca14d102e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5815;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=OgCl745YGNA8tkD2Ib/h4hAsQgMXN7Ouw6Gh4P8Oqr4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmP/iJ9AtO2NUiQ/shLEjW1FgXeYS1lB99HJoMX
 gT0ERuhktKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj/4iQAKCRCLPIo+Aiko
 1bAYB/0em0c6mMAcvfItGDeSx6pM4OR2pgT65OKPxu1eIMWRA/SqpP/q596FmVGhhe1gBFRDdXw
 IDlpEQpE3qucx1ZM0pQXEULCVLaN52/h60g5xS8WOZASORELPpe+l3tuClkTofsOpnQ0LvnBz51
 UrCttNK9iuJMpj97rSHsufpaQHDQsgaFr34fMdBAq2kIAEEVPJPE4uo7vq57RJORyWEZLRNgcxf
 2B+MB7OvFIHzfzelPJhTGAKK4KmLnT9/PXiDphOeR4vRVAhQaSeFnZXSC6RsDpMUdM7rFbKAXga
 EZALKYcIlSJ6iUYXgVLU72da7nQi81w9CjUy0SmFcnlWB/cr
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use newer mipi_dsi_*_multi() functions in order to simplify and cleanup
panel's prepare() and unprepare() functions.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 95 +++++++++++++-------------------
 1 file changed, 37 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 67a98ac508f8..f3dcc39670ea 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -40,104 +40,83 @@ static inline struct sw43408_panel *to_panel_info(struct drm_panel *panel)
 
 static int sw43408_unprepare(struct drm_panel *panel)
 {
-	struct sw43408_panel *ctx = to_panel_info(panel);
+	struct sw43408_panel *sw43408 = to_panel_info(panel);
+	struct mipi_dsi_multi_context ctx = { .dsi = sw43408->link };
 	int ret;
 
-	ret = mipi_dsi_dcs_set_display_off(ctx->link);
-	if (ret < 0)
-		dev_err(panel->dev, "set_display_off cmd failed ret = %d\n", ret);
+	mipi_dsi_dcs_set_display_off_multi(&ctx);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(ctx->link);
-	if (ret < 0)
-		dev_err(panel->dev, "enter_sleep cmd failed ret = %d\n", ret);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
 
-	msleep(100);
+	mipi_dsi_msleep(&ctx, 100);
 
-	gpiod_set_value(ctx->reset_gpio, 1);
+	gpiod_set_value(sw43408->reset_gpio, 1);
+
+	ret = regulator_bulk_disable(ARRAY_SIZE(sw43408->supplies), sw43408->supplies);
 
-	return regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	return ret ? : ctx.accum_err;
 }
 
 static int sw43408_program(struct drm_panel *panel)
 {
-	struct sw43408_panel *ctx = to_panel_info(panel);
+	struct sw43408_panel *sw43408 = to_panel_info(panel);
+	struct mipi_dsi_multi_context ctx = { .dsi = sw43408->link };
 	struct drm_dsc_picture_parameter_set pps;
-	int ret;
 
-	mipi_dsi_dcs_write_seq(ctx->link, MIPI_DCS_SET_GAMMA_CURVE, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, MIPI_DCS_SET_GAMMA_CURVE, 0x02);
 
-	ret = mipi_dsi_dcs_set_tear_on(ctx->link, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	if (ret < 0) {
-		dev_err(panel->dev, "Failed to set tearing: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_tear_on_multi(&ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
 
-	mipi_dsi_dcs_write_seq(ctx->link, 0x53, 0x0c, 0x30);
-	mipi_dsi_dcs_write_seq(ctx->link, 0x55, 0x00, 0x70, 0xdf, 0x00, 0x70, 0xdf);
-	mipi_dsi_dcs_write_seq(ctx->link, 0xf7, 0x01, 0x49, 0x0c);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x53, 0x0c, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x55, 0x00, 0x70, 0xdf, 0x00, 0x70, 0xdf);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf7, 0x01, 0x49, 0x0c);
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(ctx->link);
-	if (ret < 0) {
-		dev_err(panel->dev, "Failed to exit sleep mode: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_exit_sleep_mode_multi(&ctx);
 
-	msleep(135);
+	mipi_dsi_msleep(&ctx, 135);
 
 	/* COMPRESSION_MODE moved after setting the PPS */
 
-	mipi_dsi_dcs_write_seq(ctx->link, 0xb0, 0xac);
-	mipi_dsi_dcs_write_seq(ctx->link, 0xe5,
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0xac);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe5,
 			       0x00, 0x3a, 0x00, 0x3a, 0x00, 0x0e, 0x10);
-	mipi_dsi_dcs_write_seq(ctx->link, 0xb5,
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb5,
 			       0x75, 0x60, 0x2d, 0x5d, 0x80, 0x00, 0x0a, 0x0b,
 			       0x00, 0x05, 0x0b, 0x00, 0x80, 0x0d, 0x0e, 0x40,
 			       0x00, 0x0c, 0x00, 0x16, 0x00, 0xb8, 0x00, 0x80,
 			       0x0d, 0x0e, 0x40, 0x00, 0x0c, 0x00, 0x16, 0x00,
 			       0xb8, 0x00, 0x81, 0x00, 0x03, 0x03, 0x03, 0x01,
 			       0x01);
-	msleep(85);
-	mipi_dsi_dcs_write_seq(ctx->link, 0xcd,
+	mipi_dsi_msleep(&ctx, 85);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xcd,
 			       0x00, 0x00, 0x00, 0x19, 0x19, 0x19, 0x19, 0x19,
 			       0x19, 0x19, 0x19, 0x19, 0x19, 0x19, 0x19, 0x19,
 			       0x16, 0x16);
-	mipi_dsi_dcs_write_seq(ctx->link, 0xcb, 0x80, 0x5c, 0x07, 0x03, 0x28);
-	mipi_dsi_dcs_write_seq(ctx->link, 0xc0, 0x02, 0x02, 0x0f);
-	mipi_dsi_dcs_write_seq(ctx->link, 0x55, 0x04, 0x61, 0xdb, 0x04, 0x70, 0xdb);
-	mipi_dsi_dcs_write_seq(ctx->link, 0xb0, 0xca);
-
-	ret = mipi_dsi_dcs_set_display_on(ctx->link);
-	if (ret < 0) {
-		dev_err(panel->dev, "Failed to set display on: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xcb, 0x80, 0x5c, 0x07, 0x03, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc0, 0x02, 0x02, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x55, 0x04, 0x61, 0xdb, 0x04, 0x70, 0xdb);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0xca);
 
-	msleep(50);
+	mipi_dsi_dcs_set_display_on_multi(&ctx);
 
-	ctx->link->mode_flags &= ~MIPI_DSI_MODE_LPM;
+	mipi_dsi_msleep(&ctx, 50);
 
-	drm_dsc_pps_payload_pack(&pps, ctx->link->dsc);
-	ret = mipi_dsi_picture_parameter_set(ctx->link, &pps);
-	if (ret < 0) {
-		dev_err(panel->dev, "Failed to set PPS: %d\n", ret);
-		return ret;
-	}
+	sw43408->link->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	drm_dsc_pps_payload_pack(&pps, sw43408->link->dsc);
 
-	ctx->link->mode_flags |= MIPI_DSI_MODE_LPM;
+	mipi_dsi_picture_parameter_set_multi(&ctx, &pps);
+
+	sw43408->link->mode_flags |= MIPI_DSI_MODE_LPM;
 
 	/*
 	 * This panel uses PPS selectors with offset:
 	 * PPS 1 if pps_identifier is 0
 	 * PPS 2 if pps_identifier is 1
 	 */
-	ret = mipi_dsi_compression_mode_ext(ctx->link, true,
+	mipi_dsi_compression_mode_ext_multi(&ctx, true,
 					    MIPI_DSI_COMPRESSION_DSC, 1);
-	if (ret < 0) {
-		dev_err(panel->dev, "Failed to set compression mode: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
+	return ctx.accum_err;
 }
 
 static int sw43408_prepare(struct drm_panel *panel)

-- 
2.39.2


