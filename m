Return-Path: <linux-kernel+bounces-446616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862419F26E6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B5C77A13EB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 22:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4AF1D63DD;
	Sun, 15 Dec 2024 22:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="moSlZVsh"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF631D5CDE
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 22:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734302692; cv=none; b=kCFi6IHrNwM7dpo9NtvqNnWdPzMWaKuXQ/2laZlFM+6V0LnFecBB2tVu6oIRcphDCEXvVS9CGuAhyraWWKmkLOs9/PVD2qXPp3S0vba2HZKk8ihL/GUSUinz283y4eXvs7/ppGi/8OlmmLxqja4kijTwJA07JVhlrI+zlzZTA6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734302692; c=relaxed/simple;
	bh=hQBxsTOsUN7geLuBg/YMa+OCFGXDLFQzdaIrPM9DcOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MB/ds1xNx3HhnHu5RtptxrhrNljHcIkol1ErXZlP5rkoPQnnomxAfEb7t0cKskiqcgm7V83Jn/W3Ebe3Ohcy942/uepTgdmzmm5obNbN761kIsT7qy9JD9jFqmzFk9Pw8VQiWUwiDANxzARC6P+QMyGCs5EjJ+hIytMm4P048kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=moSlZVsh; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3003c0c43c0so38818201fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 14:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734302689; x=1734907489; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+296vAyMuQ8gRY6T48nP00jA3mm+oO9UHHBrJmnhzGQ=;
        b=moSlZVsh5i7+Mp8gqsVUShYFj1UXqRmKGw+6DwFXnuFg8cdVOEc7xLrAsGS6PVRNwP
         fvSAa810zFBdwF4cxOYCGq3OKDG4MluQHz1qiKORySxAhGZY6cOhmDUBGHIIKGa4eDDP
         em0YzpAwsZDIhCxcMuiIzpd90lyhfPH6uz5MUQR0KGPxAMGcD+YHyCWj0aM/MG/gPyD3
         QD0yDNH431ujtE9Ff7RbB5DhwJi+0dRZTXDhT3KiGakBqOcsNSyKA4pgjTe7Aq49A9P3
         h+sa7mWrbV0nmzJIdD3orUDfQgDT1VF1YrqJ/yGPuwIcO3F4R9QSqpyL+l6OGSdJIfLK
         loDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734302689; x=1734907489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+296vAyMuQ8gRY6T48nP00jA3mm+oO9UHHBrJmnhzGQ=;
        b=jI0uqEgrP2059Vu1Trh8AaqphP0D0oqPxvs191O+lBcfBVK5ER9wnletIjZ39RBaCN
         4ekIGXD5ScxHKoemmK1naxfZYKZWQ+7GMSVH+qt7APmuSAbAoWOQotiRRm6COGlT2i0T
         ZnAyuZGNj6RlUWXyBL5l/D46gjmZ2uUCza+IulNyZbifgIQVwSiS6MHSRa5A6EsjRNhX
         otI3iUOCjhJ/xAVvzsk5R12z4/RL4vNMcRUND4zQl1TtZ+1JWE4tEcHKcJtBpsmMaDvc
         eMaBZUMRgfO65KotgNpNU2ElHZa0gnkcHgpPdDElls7W5sizh7yLmYxD/IpYWIgZDMt8
         sOCA==
X-Forwarded-Encrypted: i=1; AJvYcCUnEWRCaaf9jqnWz6qeaR97xGTnX3Xh/YH2BuD+yidKoEuTcVdyzqBwYDawzowCHJpuBhBtSjkn12SpD/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPcZ+XBlI0LfizJRi+K7DN/e/dhPjWAK9RQCHA50wU2ByV9PgK
	2NLCWJ/lxOmbknMNnrTj1Sq+MOhWgxi5DwRrLK85OYfA7My074Xbs6dZkxayYE0=
X-Gm-Gg: ASbGnctousSf/5He5m7g+RUAVoaeP9MoOZz4t6Mhdk/1pJ9h3q7NaeIRwneRpsuGbX9
	jeeV7GVhXnc8ODeEmi41Wbw5SkvaRvNK1vwprSki4oTK7JZ48rbKXVyWwKiwf/jaOcWESpsCFi3
	ldEoR4akJw3xuliBvoTyYnpcRPfRcg21HOMZFbWzwGLdLnKvgRMQfGsey6RZ1NWT4gr9WgaVLon
	rw3zvSJCpg8sImEudw8ife6qY17nHtCc2iKucyZG2etNlZ6Fw+zHieS3+xZQ6tE
X-Google-Smtp-Source: AGHT+IH2GCXfzbVvWNOK9XBTJKSJBxpiSiM6H3OPGKPuzaqEk3p2cRZmqDTdIQF591kChEB/AWaj5A==
X-Received: by 2002:a05:651c:50f:b0:302:17e7:e18a with SMTP id 38308e7fff4ca-3025459b038mr35569091fa.26.1734302689250;
        Sun, 15 Dec 2024 14:44:49 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441a41d1sm7201701fa.100.2024.12.15.14.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 14:44:48 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 16 Dec 2024 00:44:20 +0200
Subject: [PATCH v4 15/16] drm/msm/dp: read hw revision only once
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fd-dp-audio-fixup-v4-15-f8d1961cf22f@linaro.org>
References: <20241216-fd-dp-audio-fixup-v4-0-f8d1961cf22f@linaro.org>
In-Reply-To: <20241216-fd-dp-audio-fixup-v4-0-f8d1961cf22f@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paloma Arellano <quic_parellan@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
 Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4887;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=hQBxsTOsUN7geLuBg/YMa+OCFGXDLFQzdaIrPM9DcOQ=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ3p89O71XdGyjxqU/orazo4tUFb6+1k5faNh76UVloduN
 /Qfm3i7k9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQATKWdl/yu0QiGK65mu5FG5
 Fp2oh9n5E9ui82WrMjxufX9vONPixpzALX9Of1/Ned3/kw+ruygjS/1b7tdPHMRjDh5sX/R6fsS
 lYtnJJTttU2/eNZ282WCqyCJXq223On8aBfAye6wU2MtyRenrBvYTukJls3lOJW2e80r4wsnFT3
 IULNqim02Xrc4Obv0+Q2aZYoxcsrKHZUBcrWVAzAfBvzn8+5v5ImYnboq8GFyxPMW56luEsn0N4
 /7/5cmbtzPXGDlnKv05E/dOVeB7aZJrerW81qxnLJlbmb0u3zPJ0Pn34snMg4bPyrZJzqpI4bTd
 s89ZQHJm3faPl7Vrre2rKqIncESfj32yMCMlgTf901V2AA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

There is little point in rereading DP controller revision over and over
again. Read it once, after the first software reset and propagate it to
the dp_panel module.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_catalog.c | 13 -------------
 drivers/gpu/drm/msm/dp/dp_catalog.h |  3 ---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 12 +++++++++---
 drivers/gpu/drm/msm/dp/dp_panel.c   |  3 +--
 drivers/gpu/drm/msm/dp/dp_panel.h   |  1 +
 5 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index 2992a0df262e9ab167a21a270d1aa8fd1383033d..84adf3a38e4cf0619b15850c31416f1e67049a42 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -42,19 +42,6 @@ void msm_dp_catalog_snapshot(struct msm_dp_catalog *msm_dp_catalog, struct msm_d
 				    msm_dp_catalog->p0_len, msm_dp_catalog->p0_base, "dp_p0");
 }
 
-/**
- * msm_dp_catalog_hw_revision() - retrieve DP hw revision
- *
- * @msm_dp_catalog: DP catalog structure
- *
- * Return: DP controller hw revision
- *
- */
-u32 msm_dp_catalog_hw_revision(const struct msm_dp_catalog *msm_dp_catalog)
-{
-	return msm_dp_read_ahb(msm_dp_catalog, REG_DP_HW_VERSION);
-}
-
 static void __iomem *msm_dp_ioremap(struct platform_device *pdev, int idx, size_t *len)
 {
 	struct resource *res;
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
index 310319619242df5fa0d91c89fbcc477f16c130ea..ddbae0fcf5fc428b2d37cd1eab1d5860a2f11a50 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.h
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
@@ -95,9 +95,6 @@ static inline void msm_dp_write_link(struct msm_dp_catalog *msm_dp_catalog,
 /* Debug module */
 void msm_dp_catalog_snapshot(struct msm_dp_catalog *msm_dp_catalog, struct msm_disp_state *disp_state);
 
-/* DP Controller APIs */
-u32 msm_dp_catalog_hw_revision(const struct msm_dp_catalog *msm_dp_catalog);
-
 struct msm_dp_catalog *msm_dp_catalog_get(struct device *dev);
 
 #endif /* _DP_CATALOG_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index b15b7ba599e29c4edd746e9c2a8bf2f4a8eedf15..60dbf7eab3fd184bc12035d267abb3758cce9f89 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -131,6 +131,8 @@ struct msm_dp_ctrl_private {
 	struct completion psr_op_comp;
 	struct completion video_comp;
 
+	u32 hw_revision;
+
 	bool core_clks_on;
 	bool link_clks_on;
 	bool stream_clks_on;
@@ -173,6 +175,11 @@ void msm_dp_ctrl_reset(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	sw_reset &= ~DP_SW_RESET;
 	msm_dp_write_ahb(msm_dp_catalog, REG_DP_SW_RESET, sw_reset);
+
+	if (!ctrl->hw_revision) {
+		ctrl->hw_revision = msm_dp_read_ahb(msm_dp_catalog, REG_DP_HW_VERSION);
+		ctrl->panel->hw_revision = ctrl->hw_revision;
+	}
 }
 
 static u32 msm_dp_ctrl_get_aux_interrupt(struct msm_dp_ctrl_private *ctrl)
@@ -307,12 +314,11 @@ static void msm_dp_ctrl_mainlink_disable(struct msm_dp_ctrl_private *ctrl)
 static void msm_dp_setup_peripheral_flush(struct msm_dp_ctrl_private *ctrl)
 {
 	struct msm_dp_catalog *msm_dp_catalog = ctrl->catalog;
-	u32 mainlink_ctrl, hw_revision;
+	u32 mainlink_ctrl;
 
 	mainlink_ctrl = msm_dp_read_link(msm_dp_catalog, REG_DP_MAINLINK_CTRL);
 
-	hw_revision = msm_dp_catalog_hw_revision(msm_dp_catalog);
-	if (hw_revision >= DP_HW_VERSION_1_2)
+	if (ctrl->hw_revision >= DP_HW_VERSION_1_2)
 		mainlink_ctrl |= DP_MAINLINK_FLUSH_MODE_SDE_PERIPH_UPDATE;
 	else
 		mainlink_ctrl |= DP_MAINLINK_FLUSH_MODE_UPDATE_SDP;
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 3441c28e3ce332bfe932d7adee7f0ecbaa486c2e..969d618c909876fd7a13aeb6e6c9e117071bc682 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -380,9 +380,8 @@ static void msm_dp_panel_send_vsc_sdp(struct msm_dp_panel_private *panel, struct
 
 static void msm_dp_panel_update_sdp(struct msm_dp_panel_private *panel)
 {
-	u32 hw_revision;
+	u32 hw_revision = panel->msm_dp_panel.hw_revision;
 
-	hw_revision = msm_dp_catalog_hw_revision(panel->catalog);
 	if (hw_revision >= DP_HW_VERSION_1_0 &&
 	    hw_revision < DP_HW_VERSION_1_2) {
 		msm_dp_write_link(panel->catalog, MMSS_DP_SDP_CFG3, UPDATE_SDP);
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 8dde55b3a5ab64c0c12d69cb2dd5b5c733c83432..c348417bb07f33efdf1402a73c27ff99e394e5a3 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -38,6 +38,7 @@ struct msm_dp_panel {
 	struct msm_dp_panel_psr psr_cap;
 	bool video_test;
 	bool vsc_sdp_supported;
+	u32 hw_revision;
 
 	u32 max_dp_lanes;
 	u32 max_dp_link_rate;

-- 
2.39.5


