Return-Path: <linux-kernel+bounces-535448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F00A472F5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2CAF3A13F8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC8E1D90AE;
	Thu, 27 Feb 2025 02:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oio0O6K8"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1F270036
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740623130; cv=none; b=eB+6Ds3NC6eB0vjelF8F9V6fuJ4i42FDpm0r7wwGSjLOg3PbxNys99dCVrLjHhxdqeV+QrCSP/Bqq4HPytI4vWsgxgLFREpLlcfvFVtIJ4eqoBADCpzEz6hwCJ7zQypVdgQS6u2iqUq4bp9EcTt/P1q3HZ9NaXFhOPc8bTu0eSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740623130; c=relaxed/simple;
	bh=9z1p16IGdhhxiTm15wIHhYzKoRC0TrBbMnzmOx4bB8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W7vjkDqvsA4eCMXoxg/L0KX9Usj3bzLW2UqqxGdjGHEXOTfNv+snaNA5xNxeEOIDWEz3QNLrUQ+KptL+Bc+cDbgRCL8GEMo+12evvSOIzfu/4mNJl3trT93p3nrXOeo7Eq7x6pNEUQYbqXE347M8lLD3X6QpDgjkGnOBhQhgNu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oio0O6K8; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-547bcef2f96so444341e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740623126; x=1741227926; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E18tpw+zq+SBOUnMq7VeJ2wmflhlIp1Qicz+wQlS2Sw=;
        b=oio0O6K8cQOXpBEUS0ld8Ekg+nxugLAcKikUxgfWBrIJw0c8Y5rbW0r6pJ1Kv8aAE8
         xEBKFFGyfRVdLyLsZ36yjFMudTZTUMNnDlJUoZWEUMYy1VHe6RBsmAlXUNNh6g0UdpYW
         RnbBliIbi3Qg0AONKsKT1d71FLFcux0Hx92o1GGICtrWyP+9Bejkcxbq+rgwC/Mo+G+B
         ePazZsV1YUXz8fTvJ7BHF1A2y92fBVuSTF6WKjlkx8vax8FOVEANCXGS80XqWWfFo5P+
         4OB5yNTdsbpWNg6/I5sxQp2i1LDwh1tYFEbGUNTH/vEPjn4/tGAQmdXAzSRM6S0BRrfD
         N54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740623126; x=1741227926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E18tpw+zq+SBOUnMq7VeJ2wmflhlIp1Qicz+wQlS2Sw=;
        b=DXAVHVTiyQg3iRqArSSc59GzzsNwt1n0zSJRnXjd+J+H5+CjyFPdGMHksv7PDcxYfq
         cCZyb/NcBju4Y9JrqcVMg9w4BoCb8KyBlj1dYTjQClSbjnzz3d696i4jFapE/5SuuAYV
         p6Mh0sQiz8kovzwDHdZKOneZd5KYcwtiSs+HkhOKTjHqTcuoWEOgCrD7Pwz9sC5HpZJ6
         F37BxKw4XZnQkqNWwauyFHCpOlkLUm4xxtQgunlXbRulRKtca8XkFNohuhVOjCXr4DU3
         TBgm1KJZyPW9VqIULzUka6gGlPhcEDAu1p0spszmEWTKCr4CJuJpKJnCPIc4O7M57LAX
         zwXA==
X-Forwarded-Encrypted: i=1; AJvYcCXK72cxlnOQxISzp1hYQ3z0WQlabVaScnE0koeIvq+2sCZ5qWzYriyJJ9uPWyyA/r6ZYAcpLQaZb0U33fU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoam+a51Yp8ceJZtkMoTJcXKk9Z5ZFHk82ve7v6rlNLpp0/L2d
	XL7JiQltVyQpgWJlZRSkzF15gTaoZcrKwJBVHT9ghcDfUlA57yR8QbFC9myzy08=
X-Gm-Gg: ASbGncuH3NIZXapmwpBj+1bh7Y9uFwc+veXWtDoLsqwsgj27hHQ0MdI5ZlUA5OzVVen
	LP/zQTqwZd+R8cZcswjqGujp4J4MF3W2fLCGqpKhqwjBwA8fti8jAJ5kbv4NYBxrQXbiqU7RBfp
	n1JUCVXkGQF8ZwQibh5Iwl+w35KefQ2aoaiTbR9J0OxNHLBN2JEwmAdLf6wYULbDMcjKDJuKOZt
	FckEnKNCJ2YsjzRnixmMVeMGeDX5i1nFFC38yotLmEnVW6QFODTr6JenwpZLSXAXskcQF/rENGp
	moN8e/rdfMg4ZWFG4hY/ivaECC3XIqqeMA==
X-Google-Smtp-Source: AGHT+IH6JvW63owJyZ1PeivaBeeBGjJMDrOP0137MVcsa3BSvMkJ++/F3s9OT2J6ygpsST5S+eTgWg==
X-Received: by 2002:a05:6512:3b22:b0:545:60b:f38b with SMTP id 2adb3069b0e04-54838edd919mr10462109e87.8.1740623126477;
        Wed, 26 Feb 2025 18:25:26 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549441742a0sm48067e87.5.2025.02.26.18.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 18:25:25 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Feb 2025 04:25:13 +0200
Subject: [PATCH v3 5/7] drm/msm/mdp4: move move_valid callback to
 lcdc_encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-fd-mdp4-lvds-v3-5-c983788987ae@linaro.org>
References: <20250227-fd-mdp4-lvds-v3-0-c983788987ae@linaro.org>
In-Reply-To: <20250227-fd-mdp4-lvds-v3-0-c983788987ae@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4330;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=9z1p16IGdhhxiTm15wIHhYzKoRC0TrBbMnzmOx4bB8I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnv80H9mWNP5xm0U518aEA7MFJlLbfnScNOLNek
 6ngfP55A2CJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7/NBwAKCRCLPIo+Aiko
 1TS4B/4jhTAUlM4rgtB8XhTYa1IaFlN4nD5YNisfDQe3RWIPeYXqasBrLgy3wsErfrpwSgbwk9Z
 dqw1eQFoMXtsQY5rCvEBgyDOyUwen61/QK9vPLoCKjkWlZi/9v5zHT3YMX7V2UaqjZb29UTSuNN
 9KdTVUxqtgOYBzGLe7W3IMI5YtBGFuVe+21N2/q3WZ1ddbaFYbYuSCMcbym4iC42bZctMjHTmm7
 wxgXY/Ny8i5fCoeiew39A6P4vYGvzigO2bJDaPFEAFI4yfVw8lpC25+5w1Yi03d2WZv/mmnJMeO
 9y53Z/5Yh/8tu/PRj6tzTwc+b9VtXnp11bYtMffN9wgXQ4eD
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

We can check the LCDC clock directly from the LCDC encoder driver, so
remove it from the LVDS connector.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h           |  1 -
 drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c  | 27 ++++++++++++++++------
 .../gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c    | 21 -----------------
 3 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
index b8bdc3712c73b14f3547dce3439a895e3d10f193..e0380d3b7e0cee99c4c376bf6369887106f44ede 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
@@ -191,7 +191,6 @@ struct drm_crtc *mdp4_crtc_init(struct drm_device *dev,
 long mdp4_dtv_round_pixclk(struct drm_encoder *encoder, unsigned long rate);
 struct drm_encoder *mdp4_dtv_encoder_init(struct drm_device *dev);
 
-long mdp4_lcdc_round_pixclk(struct drm_encoder *encoder, unsigned long rate);
 struct drm_encoder *mdp4_lcdc_encoder_init(struct drm_device *dev,
 		struct device_node *panel_node);
 
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
index db93795916cdaa87ac8e61d3b44c2dadac10fd9e..cfcedd8a635cf0297365e845ef415a8f0d553183 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
@@ -348,19 +348,32 @@ static void mdp4_lcdc_encoder_enable(struct drm_encoder *encoder)
 	mdp4_lcdc_encoder->enabled = true;
 }
 
+static enum drm_mode_status
+mdp4_lcdc_encoder_mode_valid(struct drm_encoder *encoder,
+		const struct drm_display_mode *mode)
+{
+	struct mdp4_lcdc_encoder *mdp4_lcdc_encoder =
+			to_mdp4_lcdc_encoder(encoder);
+	long actual, requested;
+
+	requested = 1000 * mode->clock;
+	actual = clk_round_rate(mdp4_lcdc_encoder->lcdc_clk, requested);
+
+	DBG("requested=%ld, actual=%ld", requested, actual);
+
+	if (actual != requested)
+		return MODE_CLOCK_RANGE;
+
+	return MODE_OK;
+}
+
 static const struct drm_encoder_helper_funcs mdp4_lcdc_encoder_helper_funcs = {
 	.mode_set = mdp4_lcdc_encoder_mode_set,
 	.disable = mdp4_lcdc_encoder_disable,
 	.enable = mdp4_lcdc_encoder_enable,
+	.mode_valid = mdp4_lcdc_encoder_mode_valid,
 };
 
-long mdp4_lcdc_round_pixclk(struct drm_encoder *encoder, unsigned long rate)
-{
-	struct mdp4_lcdc_encoder *mdp4_lcdc_encoder =
-			to_mdp4_lcdc_encoder(encoder);
-	return clk_round_rate(mdp4_lcdc_encoder->lcdc_clk, rate);
-}
-
 /* initialize encoder */
 struct drm_encoder *mdp4_lcdc_encoder_init(struct drm_device *dev,
 		struct device_node *panel_node)
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
index 52e728181b523cc3380d7718b5956e7e2dbd4cad..4755eb13ef79f313d2be088145c8cd2e615226fe 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
@@ -56,26 +56,6 @@ static int mdp4_lvds_connector_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
-static enum drm_mode_status
-mdp4_lvds_connector_mode_valid(struct drm_connector *connector,
-			       const struct drm_display_mode *mode)
-{
-	struct mdp4_lvds_connector *mdp4_lvds_connector =
-			to_mdp4_lvds_connector(connector);
-	struct drm_encoder *encoder = mdp4_lvds_connector->encoder;
-	long actual, requested;
-
-	requested = 1000 * mode->clock;
-	actual = mdp4_lcdc_round_pixclk(encoder, requested);
-
-	DBG("requested=%ld, actual=%ld", requested, actual);
-
-	if (actual != requested)
-		return MODE_CLOCK_RANGE;
-
-	return MODE_OK;
-}
-
 static const struct drm_connector_funcs mdp4_lvds_connector_funcs = {
 	.detect = mdp4_lvds_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
@@ -87,7 +67,6 @@ static const struct drm_connector_funcs mdp4_lvds_connector_funcs = {
 
 static const struct drm_connector_helper_funcs mdp4_lvds_connector_helper_funcs = {
 	.get_modes = mdp4_lvds_connector_get_modes,
-	.mode_valid = mdp4_lvds_connector_mode_valid,
 };
 
 /* initialize connector */

-- 
2.39.5


