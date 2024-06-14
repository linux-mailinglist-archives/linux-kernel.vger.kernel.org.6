Return-Path: <linux-kernel+bounces-214134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BB9908008
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36CBB1F21E22
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC9D2032A;
	Fri, 14 Jun 2024 00:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yQYD743r"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF2D19D8A3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718323357; cv=none; b=HVk5e2SGiYn6DpGqvbo8KARlhL1zqt7Em2h1ZSYUFqS2k7pqAgj7pfkxyvyzA4+9PBc5eTUrabBgq0gJyVaLbmm/mPi4TpxljFWFhdJotm6U2J3siEe1+X1d/S6kP83WDbndylokfbJE5kwfMx5EY+F2DxhEGkw+oq7gsBJeR5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718323357; c=relaxed/simple;
	bh=hx52QihZ5EuJ5AiqKyFQ2KKiCjZKNAgTrsIHJEVKJeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fcWSm+lIWG//NaUxfwGH8i0aRnB0LjHfzR6rXKTCewNRZuBX67CNjHRJPnzf5qUlcbLVHjwThBa595BN9tDIxoTjdhBSwR4jh/weG1eJ/A0dj4UnPUHjPhUgszq3GQzmEn1ebW8ZOm7Y3pU0HUzgjF6vu9p9TOusiwnDUEWvZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yQYD743r; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52c815e8e9eso1767478e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718323352; x=1718928152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zfrPUlUPVILrHliAQdW9ExhLGgEKHG4S87IgBlFScQ=;
        b=yQYD743ro7JOdjshuAbqwMihiRODRqdZcGlmRR34KA1wE1bDWio+kdf2tQK3BBABHS
         +v/1iIuNSrRiKQPXcv1SkQSo8jGtSs0liYwGm0Xt31R1/XeY9SYJ0dRa3R91HUviCIiF
         YNLRihtCaD2FNz/Uy3Ylct135o4owREILmkezP5qMrbTe4vijlA3gOmkeCM5d9NhOvFF
         70WFM/EJFYDsr+yhmA/MZw002l9Au95J58HPyZ0zQrPJORjVAD/sFJJdL/zLD/ImhmG3
         yaNpEALtRk2WwWWclfJBMWq3Ih29gG91zxwQr7XhQO3Tcs7yU/dOXRb2NFX0DyIQJWsT
         g8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718323352; x=1718928152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zfrPUlUPVILrHliAQdW9ExhLGgEKHG4S87IgBlFScQ=;
        b=u2e/ScG5KCd+B3rE4ZFuIFy3AIdaFoEE5rN91qyzBH8y8cCTl/bas8NkAJvygt7uHJ
         q/birTCmYNpdr7cEx7aI1uZ8mqaTWxwckPfA/x6qMO4RrP5m4yyaD6ChBflsnhCba5XE
         o8iENZjTBBTFe/G513e/X4BdaqkFE3tFSWvmRuvmsxSJ4kYmdbAPP8MpbOZaOat0fFOt
         psMkFjOAPrNthvboOpxi0K1c58fd5rwLxLeHEymmVBRA7cUsJQh+RT/ZIAWhT5OMFyon
         699z8+xuWhIeSgmMMH7bez7B4SAtJimufsEgdNqBaIX67nw02zE+4fQXSNGfjXqbl8zt
         T+lg==
X-Forwarded-Encrypted: i=1; AJvYcCU/FSK+nSdI+bWa0AULBIK2TMFczoAqtUwFqmc7OpOd7A7jbhw6KUR9VkUfHM7pBgjRE45qmQgkzIhsDrTkHBdQN+kwyF6tfPyUUS/e
X-Gm-Message-State: AOJu0YzJLJsIx7yxD+CgJY34xTp9zjWu7Qm34QP9CiUZ25UMc0CST38D
	7r59wOTfWqeuButGiSGTVDNsrQUO3tl4T6JO1wlcFTh5uDdvGKgth9NqPi3frh8=
X-Google-Smtp-Source: AGHT+IF8OZ+6PpwFsBXyTwunpB/Bk1x8X+p90EOhm2amALpsFfnel6zQFwhZv7CB04URvvlELTWQCg==
X-Received: by 2002:a19:f707:0:b0:52c:84a2:6e0f with SMTP id 2adb3069b0e04-52ca6e6535dmr677515e87.15.1718323352001;
        Thu, 13 Jun 2024 17:02:32 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca288804dsm374797e87.262.2024.06.13.17.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 17:02:30 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 14 Jun 2024 03:02:22 +0300
Subject: [PATCH v4 3/3] drm/panel-edp: drop several legacy panels
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-edp-panel-drop-v4-3-4e0a112eec46@linaro.org>
References: <20240614-edp-panel-drop-v4-0-4e0a112eec46@linaro.org>
In-Reply-To: <20240614-edp-panel-drop-v4-0-4e0a112eec46@linaro.org>
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Jeffrey Hugo <quic_jhugo@quicinc.com>, devicetree@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7171;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=hx52QihZ5EuJ5AiqKyFQ2KKiCjZKNAgTrsIHJEVKJeY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBma4iSOvT8Y3rVOEvJW6Aw/Idxzce019n+w4iht
 3YVrIas0fCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmuIkgAKCRCLPIo+Aiko
 1Rb9B/9nlEHpAdJ1BhZfisEfvgPJ6mnUA0K9AZ+3Ay6sL5EcWQX0WGMUfqFOw9iB7qA+NmwVZuF
 tiK2LsF9F6ynUvr7ds5TXCi8uf4Im4jKERarcx7iisMADgkI+B5/ZvRlTW8YWKbxqcwaVXt7tl7
 EB3VKoNtd1tn0p0fCmr0rKafb+ODKfxqUurxrkqlregPXC9J9qypGlTnIpl6IAeKI5BCbfpgzLe
 8Oinn3CNt7A6Xjq3W/JM/Br3DFr2Bp4OsSWRwFXh9V1JXvJzu7H09zKXaOpPSKoFpMrTJKFea2q
 VbrPVr6in5OKkglUuoofXI8olFVdC8+fr72PhR37NTfEEJxI
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The panel-edp driver supports legacy compatible strings for several eDP
panels which were never used in DT files present in Linux tree and most
likely have never been used with the upstream kernel. Drop compatibles
for these panels in favour of using a generic "edp-panel" device on the
AUX bus.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 173 ++------------------------------------
 1 file changed, 7 insertions(+), 166 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 85edfd3d59f3..3a574a9b46e7 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1045,33 +1045,6 @@ static const struct panel_desc auo_b116xak01 = {
 	},
 };
 
-static const struct drm_display_mode auo_b133han05_mode = {
-	.clock = 142600,
-	.hdisplay = 1920,
-	.hsync_start = 1920 + 58,
-	.hsync_end = 1920 + 58 + 42,
-	.htotal = 1920 + 58 + 42 + 60,
-	.vdisplay = 1080,
-	.vsync_start = 1080 + 3,
-	.vsync_end = 1080 + 3 + 5,
-	.vtotal = 1080 + 3 + 5 + 54,
-};
-
-static const struct panel_desc auo_b133han05 = {
-	.modes = &auo_b133han05_mode,
-	.num_modes = 1,
-	.bpc = 8,
-	.size = {
-		.width = 293,
-		.height = 165,
-	},
-	.delay = {
-		.hpd_reliable = 100,
-		.enable = 20,
-		.unprepare = 50,
-	},
-};
-
 static const struct drm_display_mode auo_b133htn01_mode = {
 	.clock = 150660,
 	.hdisplay = 1920,
@@ -1121,33 +1094,6 @@ static const struct panel_desc auo_b133xtn01 = {
 	},
 };
 
-static const struct drm_display_mode auo_b140han06_mode = {
-	.clock = 141000,
-	.hdisplay = 1920,
-	.hsync_start = 1920 + 16,
-	.hsync_end = 1920 + 16 + 16,
-	.htotal = 1920 + 16 + 16 + 152,
-	.vdisplay = 1080,
-	.vsync_start = 1080 + 3,
-	.vsync_end = 1080 + 3 + 14,
-	.vtotal = 1080 + 3 + 14 + 19,
-};
-
-static const struct panel_desc auo_b140han06 = {
-	.modes = &auo_b140han06_mode,
-	.num_modes = 1,
-	.bpc = 8,
-	.size = {
-		.width = 309,
-		.height = 174,
-	},
-	.delay = {
-		.hpd_reliable = 100,
-		.enable = 20,
-		.unprepare = 50,
-	},
-};
-
 static const struct drm_display_mode boe_nv101wxmn51_modes[] = {
 	{
 		.clock = 71900,
@@ -1414,33 +1360,6 @@ static const struct panel_desc innolux_p120zdg_bf1 = {
 	},
 };
 
-static const struct drm_display_mode ivo_m133nwf4_r0_mode = {
-	.clock = 138778,
-	.hdisplay = 1920,
-	.hsync_start = 1920 + 24,
-	.hsync_end = 1920 + 24 + 48,
-	.htotal = 1920 + 24 + 48 + 88,
-	.vdisplay = 1080,
-	.vsync_start = 1080 + 3,
-	.vsync_end = 1080 + 3 + 12,
-	.vtotal = 1080 + 3 + 12 + 17,
-	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
-};
-
-static const struct panel_desc ivo_m133nwf4_r0 = {
-	.modes = &ivo_m133nwf4_r0_mode,
-	.num_modes = 1,
-	.bpc = 8,
-	.size = {
-		.width = 294,
-		.height = 165,
-	},
-	.delay = {
-		.hpd_absent = 200,
-		.unprepare = 500,
-	},
-};
-
 static const struct drm_display_mode kingdisplay_kd116n21_30nv_a010_mode = {
 	.clock = 81000,
 	.hdisplay = 1366,
@@ -1689,75 +1608,6 @@ static const struct panel_desc sharp_lq123p1jx31 = {
 	},
 };
 
-static const struct drm_display_mode sharp_lq140m1jw46_mode[] = {
-	{
-		.clock = 346500,
-		.hdisplay = 1920,
-		.hsync_start = 1920 + 48,
-		.hsync_end = 1920 + 48 + 32,
-		.htotal = 1920 + 48 + 32 + 80,
-		.vdisplay = 1080,
-		.vsync_start = 1080 + 3,
-		.vsync_end = 1080 + 3 + 5,
-		.vtotal = 1080 + 3 + 5 + 69,
-		.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
-	}, {
-		.clock = 144370,
-		.hdisplay = 1920,
-		.hsync_start = 1920 + 48,
-		.hsync_end = 1920 + 48 + 32,
-		.htotal = 1920 + 48 + 32 + 80,
-		.vdisplay = 1080,
-		.vsync_start = 1080 + 3,
-		.vsync_end = 1080 + 3 + 5,
-		.vtotal = 1080 + 3 + 5 + 69,
-		.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
-	},
-};
-
-static const struct panel_desc sharp_lq140m1jw46 = {
-	.modes = sharp_lq140m1jw46_mode,
-	.num_modes = ARRAY_SIZE(sharp_lq140m1jw46_mode),
-	.bpc = 8,
-	.size = {
-		.width = 309,
-		.height = 174,
-	},
-	.delay = {
-		.hpd_absent = 80,
-		.enable = 50,
-		.unprepare = 500,
-	},
-};
-
-static const struct drm_display_mode starry_kr122ea0sra_mode = {
-	.clock = 147000,
-	.hdisplay = 1920,
-	.hsync_start = 1920 + 16,
-	.hsync_end = 1920 + 16 + 16,
-	.htotal = 1920 + 16 + 16 + 32,
-	.vdisplay = 1200,
-	.vsync_start = 1200 + 15,
-	.vsync_end = 1200 + 15 + 2,
-	.vtotal = 1200 + 15 + 2 + 18,
-	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
-};
-
-static const struct panel_desc starry_kr122ea0sra = {
-	.modes = &starry_kr122ea0sra_mode,
-	.num_modes = 1,
-	.size = {
-		.width = 263,
-		.height = 164,
-	},
-	.delay = {
-		/* TODO: should be hpd-absent and no-hpd should be set? */
-		.hpd_reliable = 10 + 200,
-		.enable = 50,
-		.unprepare = 10 + 500,
-	},
-};
-
 static const struct of_device_id platform_of_match[] = {
 	{
 		/* Must be first */
@@ -1785,18 +1635,12 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "auo,b116xa01",
 		.data = &auo_b116xak01,
-	}, {
-		.compatible = "auo,b133han05",
-		.data = &auo_b133han05,
 	}, {
 		.compatible = "auo,b133htn01",
 		.data = &auo_b133htn01,
 	}, {
 		.compatible = "auo,b133xtn01",
 		.data = &auo_b133xtn01,
-	}, {
-		.compatible = "auo,b140han06",
-		.data = &auo_b140han06,
 	}, {
 		.compatible = "boe,nv101wxmn51",
 		.data = &boe_nv101wxmn51,
@@ -1824,9 +1668,6 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "innolux,p120zdg-bf1",
 		.data = &innolux_p120zdg_bf1,
-	}, {
-		.compatible = "ivo,m133nwf4-r0",
-		.data = &ivo_m133nwf4_r0,
 	}, {
 		.compatible = "kingdisplay,kd116n21-30nv-a010",
 		.data = &kingdisplay_kd116n21_30nv_a010,
@@ -1857,12 +1698,6 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "sharp,lq123p1jx31",
 		.data = &sharp_lq123p1jx31,
-	}, {
-		.compatible = "sharp,lq140m1jw46",
-		.data = &sharp_lq140m1jw46,
-	}, {
-		.compatible = "starry,kr122ea0sra",
-		.data = &starry_kr122ea0sra,
 	}, {
 		/* sentinel */
 	}
@@ -1914,6 +1749,12 @@ static const struct panel_delay delay_200_500_e80_d50 = {
 	.disable = 50,
 };
 
+static const struct panel_delay delay_80_500_e50 = {
+	.hpd_absent = 80,
+	.unprepare = 500,
+	.enable = 50,
+};
+
 static const struct panel_delay delay_100_500_e200 = {
 	.hpd_absent = 100,
 	.unprepare = 500,
@@ -2122,7 +1963,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('S', 'D', 'C', 0x416d, &delay_100_500_e200, "ATNA45AF01"),
 
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "LQ140M1JW48"),
-	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &sharp_lq140m1jw46.delay, "LQ140M1JW46"),
+	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &delay_80_500_e50, "LQ140M1JW46"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x153a, &delay_200_500_e50, "LQ140T1JH01"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x154c, &delay_200_500_p2e100, "LQ116M1JW10"),
 

-- 
2.39.2


