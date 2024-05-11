Return-Path: <linux-kernel+bounces-176768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D235A8C34A3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 01:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8844C281EB8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 23:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D9845008;
	Sat, 11 May 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a/J+m04T"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E421DDEA
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715468431; cv=none; b=F0zR/SWGpXRXrWWMH8zlMm6HptHxrUVXUD81F3bbcJunoCIh3mIL4Z0/aAyuNuRy4jzHBt/OuC3yAlZB2MCS8MyPoUsIu4GsY4ggR6bQGumw43JxmaiFXLLiD4ZEPbsqa2m5Gl21UnxbXLvz0Ft9y+OJJknRuvJaqv+825sctbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715468431; c=relaxed/simple;
	bh=sjNwNWt1lktWQrmL6beKWmXl2L8FICi4sYx1xY8LX/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Byov1hTxDcTeiusBjjHUNfuWnAt/DbUtQnOajXOuh8MfThCGm4DFdLpKOdCPo1kORBJdJgG2OmMXy3VKjzR1bC3baowO+x5R7Jnd8zsMKgmdyOpq5m+8AZgIwyEZ5POZKonWCqgZcTarVRsUVX4du2lgSGqR6j6GiojGbMXvY1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a/J+m04T; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-522297f91bcso1886468e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 16:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715468427; x=1716073227; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ItR8Il0wZKComYTOQXyrvGGchY2JbpvV93y+cdGZEE=;
        b=a/J+m04TXFA5XouTQXUXbz5zSz6RwapsgTu4cDtae7GzjZpfJzQIl6EDiyBU0DQiAe
         LWueIRx6IcqAoN3k0PyJSN8nXj0Jz2mlAMA9RQsPOsRPZ75qDfLtTelqFSWjcxSo6Stm
         9A+sU+P46zkrno2IU0se6ihPDFQKDtrloetsrkz6CED09EWLKM6J4zVtAteJ4Io9Vsa8
         cWq0nkMAmAfUyrbrc0tlnSMdVymoocDBSSClcx8vVqLNJcfHIr4OlTW5k9dxo/WYhjKI
         eQXtdo4bNHM1oHZcrWM47LClzdm9ot6kn55haOOvw3UzaUWW8QD52CVDickBisPIfO+0
         NNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715468427; x=1716073227;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ItR8Il0wZKComYTOQXyrvGGchY2JbpvV93y+cdGZEE=;
        b=m6XdLXdBnEwhpkKwujccpy3VZ0Svrx9K+djwmJtl8jw3vj2BsWgdnU5mEbUI1snxTY
         YE5YT8ML/FXYO5GCZf0hCrcLLV0DCMndrnArzJ54jgL18SGZIDpQ1J4akenXtmuLl/Vu
         zfI2QyN7Uieotfuhqq+9K07azjYPm1KgN1aRN1Z9RImmhVgA3gz/Yo0/WujXAsZcU22m
         ipsZEWEf9JHYrhis+SvxkQlnc+lTZazwjIqIdb6r8XH7Gd5Kd8MpQO+KIviRwmhuvWVh
         rxn0n/q/Ck7Np85taIlamhrrhpAsHl5UQo03eqblF1DR9smcbaDn8DTAGjKsA9mGJdZJ
         Fnxg==
X-Forwarded-Encrypted: i=1; AJvYcCUslRwHzjMRcqkk307Nd9yYfL6rX7vNaPgSL+J0JR2NFIgWjvRoZ5Ug6zO3oo6DJK0JLnS6597DGsS9dqyb/ebXicnu9KFg74setVRH
X-Gm-Message-State: AOJu0YzbM1aQrt0upJSEz9rG1SNgPhhBfKZaSzInU9jq9Ja2M3ZvLN2R
	Dflalb58UMZkff9eFxM4aGEEATrQZnUHQnuf5/Rvzh9ff44NauLk4HWjGpNo+Fc=
X-Google-Smtp-Source: AGHT+IGupD6xSF5z3LDxw5fpnNiXEVPwrXMtCUrN+VFBtOrmIH4ipNMQ9NazLPourMk+7YDo207urw==
X-Received: by 2002:a05:6512:ba3:b0:518:8d15:8810 with SMTP id 2adb3069b0e04-5220fc7354cmr5061661e87.14.1715468427451;
        Sat, 11 May 2024 16:00:27 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d3717sm1134222e87.173.2024.05.11.16.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 16:00:26 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 12 May 2024 02:00:18 +0300
Subject: [PATCH v2 1/7] drm/panel: lg-sw43408: add missing error handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240512-dsi-panels-upd-api-v2-1-e31ca14d102e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2884;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=sjNwNWt1lktWQrmL6beKWmXl2L8FICi4sYx1xY8LX/4=;
 b=owEBbAGT/pANAwAKAYs8ij4CKSjVAcsmYgBmP/iIq2PSj7Y1vez6Rc2QseG7HDNb8trfZ6GFD
 fbOLvZ4cmeJATIEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj/4iAAKCRCLPIo+Aiko
 1RPRB/iPkeSgZV6o0AQqVNOnA/LGZ26CD5knxYfdT6mUpksmIdzNgz51P7eJqFplreJORm+ki18
 Ak5BJgGG1G/Le90JBUp2AAfXsWY8Qyc4blaMEuaiR7idSxNgE3dIMdrdKAxvV+Y8Km3qAquwJXw
 XX1uW/CIGcFwAkWYummz3BUUcQvximQ8c1502Q2MWhPeH/LD/Eb3qLSn9gzcXWL90IZXsQqaMrd
 TADER+4+U8OhlF9N29/espaXx4aqOR7cgeJ812G0t+TXDhqUA/nD2ptzrzxANloKyaGOrI1Qnfm
 fPGdECpiiVL/ErgtxppPVEIEBME0FKNDHgTZbbRHeR1R0T4=
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add missing error handling for the mipi_dsi_ functions that actually
return error code instead of silently ignoring it.

Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 33 ++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 2b3a73696dce..67a98ac508f8 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -62,16 +62,25 @@ static int sw43408_program(struct drm_panel *panel)
 {
 	struct sw43408_panel *ctx = to_panel_info(panel);
 	struct drm_dsc_picture_parameter_set pps;
+	int ret;
 
 	mipi_dsi_dcs_write_seq(ctx->link, MIPI_DCS_SET_GAMMA_CURVE, 0x02);
 
-	mipi_dsi_dcs_set_tear_on(ctx->link, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
+	ret = mipi_dsi_dcs_set_tear_on(ctx->link, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
+	if (ret < 0) {
+		dev_err(panel->dev, "Failed to set tearing: %d\n", ret);
+		return ret;
+	}
 
 	mipi_dsi_dcs_write_seq(ctx->link, 0x53, 0x0c, 0x30);
 	mipi_dsi_dcs_write_seq(ctx->link, 0x55, 0x00, 0x70, 0xdf, 0x00, 0x70, 0xdf);
 	mipi_dsi_dcs_write_seq(ctx->link, 0xf7, 0x01, 0x49, 0x0c);
 
-	mipi_dsi_dcs_exit_sleep_mode(ctx->link);
+	ret = mipi_dsi_dcs_exit_sleep_mode(ctx->link);
+	if (ret < 0) {
+		dev_err(panel->dev, "Failed to exit sleep mode: %d\n", ret);
+		return ret;
+	}
 
 	msleep(135);
 
@@ -97,14 +106,22 @@ static int sw43408_program(struct drm_panel *panel)
 	mipi_dsi_dcs_write_seq(ctx->link, 0x55, 0x04, 0x61, 0xdb, 0x04, 0x70, 0xdb);
 	mipi_dsi_dcs_write_seq(ctx->link, 0xb0, 0xca);
 
-	mipi_dsi_dcs_set_display_on(ctx->link);
+	ret = mipi_dsi_dcs_set_display_on(ctx->link);
+	if (ret < 0) {
+		dev_err(panel->dev, "Failed to set display on: %d\n", ret);
+		return ret;
+	}
 
 	msleep(50);
 
 	ctx->link->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
 	drm_dsc_pps_payload_pack(&pps, ctx->link->dsc);
-	mipi_dsi_picture_parameter_set(ctx->link, &pps);
+	ret = mipi_dsi_picture_parameter_set(ctx->link, &pps);
+	if (ret < 0) {
+		dev_err(panel->dev, "Failed to set PPS: %d\n", ret);
+		return ret;
+	}
 
 	ctx->link->mode_flags |= MIPI_DSI_MODE_LPM;
 
@@ -113,8 +130,12 @@ static int sw43408_program(struct drm_panel *panel)
 	 * PPS 1 if pps_identifier is 0
 	 * PPS 2 if pps_identifier is 1
 	 */
-	mipi_dsi_compression_mode_ext(ctx->link, true,
-				      MIPI_DSI_COMPRESSION_DSC, 1);
+	ret = mipi_dsi_compression_mode_ext(ctx->link, true,
+					    MIPI_DSI_COMPRESSION_DSC, 1);
+	if (ret < 0) {
+		dev_err(panel->dev, "Failed to set compression mode: %d\n", ret);
+		return ret;
+	}
 
 	return 0;
 }

-- 
2.39.2


