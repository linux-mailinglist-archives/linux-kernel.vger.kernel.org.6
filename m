Return-Path: <linux-kernel+bounces-576041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8F5A70A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69693B7737
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697F71F3BB9;
	Tue, 25 Mar 2025 19:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ua5ImGnH"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC141EF0AD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742930509; cv=none; b=p4YmsA7HSkr7CMqRKOHaacQw+afCNruhvnm0jT+dSoxVQvTPzQk0W0OTIw+U3xllCKgWA6fbZmCFerRdkTD8L6yNnacfOMiCgMzWoda1e51xZz5/iiMFqstSNKd9+BzCgkP/mUFW5R1LW2tFCG6A6xLQXoy6C+yBzPKTN2QpurE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742930509; c=relaxed/simple;
	bh=mLHtZJFLMF48TiDY/Fyy9ntYtplBGAFzZq4lKzgNgsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SbVUiFzwPfIxnn1vsHSM3ejawPAKJySr+tUKjjq1q6STOwFDt/VA2n2+2RaW7VO/7uFnl7lBDhNGa+SX6m7z6nu+M6vO/KEMJMgZm+/QXPetu7JiEZvBHtVFOUHtj515e1nE5Br1fPvR5E3URhwmprQgia97Xq3az1A8+MhfiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ua5ImGnH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so58196215e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742930505; x=1743535305; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfMUnRKa6FZTnWMdT4iRvYn+H2j4PDg2i8e1Rmjpi6Q=;
        b=ua5ImGnHtXgTF53Tdm05uHakvXkVHRWhVYc6etB53Qy5UW8g0RKBxLaj+WN6rWSVxD
         cSp7UEc5nWrJbgh3DPrXGdI+QiJ/Glrk+Y0lVYqhKJ3xseV6d7xXZ1NlFO6HcGgJoML0
         7OyKLZsiHqc3O+bB9O6I/DRn0Cqo0qvE7UF2JxCg/lUDUKzPgmjVQW0y7tiBuihyqVC7
         9ZylPSgnBNHwcYoYPCesLjExYCfox3i/PPJ1+wCg3e2Q4oz+dT2mdiDynNH6dy6xyYSI
         mSS0i5XwxJpCcMNP6TKaaZTnrLdJ9yBzadtiqusq1CTi/jYp+eT1MIgmvhKd6EuZRV/+
         Y+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742930505; x=1743535305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfMUnRKa6FZTnWMdT4iRvYn+H2j4PDg2i8e1Rmjpi6Q=;
        b=XrPLmVdaYs1yal02ru4p6JUJ0zZvJEg5nZi3OKUZaKAwWpUdYCeM5HYW/CiQVf1QZn
         VBXhiJCnDGAsFvEDzUWcICSIx1C6hHorUoyRBNaq4r9fM2RDObYDCqwp7qDJpn7P5Ogt
         OE6iTp/2I9thGXJ7EMcq4MQ8ekDzld7z9YezLJjMjX9OJRqYKiNFRGBcsgD4SwI8ci0t
         HMYD+WoPYdiUtrVs3f1D5OkYXwFYuX9JY4hNpm2LqPKSO63E56vjLXiJ5UE2E9oOx3Zq
         YH9nvIcSlVdbMlp34w6YQUC0NnFr01Mj8pJMMuxuWRAqG0wk98Pa4kxjUwVJc1d8RGaz
         ktrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyPwYXne7Nnr5blN955lABMeMe3HHP768sBGcbqJldVTkQvPbwEGrdK2PnLcRjUfWLnY35ozQtd/PPbQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdt22j8IaJ9C0YHs9VrJtG09QYv/B3HuCZn1lSKByJ1irHsvgI
	LCPoHp0Brty6pRwTQgC0r3Di5VBowcq+dmSxeVhqg4fdL84gRCwcAvW8MFxuwOc=
X-Gm-Gg: ASbGncs2Ozfm6NZjyacv4eTvEc1tJFNw/cJeZkezOpgFrN2k+RW1oRKEIsFY7cW4gi7
	/xSrFgC6FwQo846v1MXUdRRGkOeM5zA2Ww1vAMOPGdyMRipiiSw1jAISeH4QR2jM5ZkjSYf00Sv
	DmCfrwOMYJhJNi+dV3lAoPHzQqpG2/q03cTH9+9SVkLbotmHQLI6Wvc2BR6caCKQERu68S5cQD4
	2/P2gQX+ZFb8hNc63iAuXuhLCfLWGX6sNf8kq2DZ5Qo70WzqmGi0Fg/D8BWaoIG81Y/nVEZsEi1
	BJq/Upy0MObC1CF1/nWpwfbd1RrUezpwIZxnzB9zE1YSPuGMDgOm4cG9
X-Google-Smtp-Source: AGHT+IFSJk7sX8ah/jLfo3djxid/LJPIi8rrO/WV4KITHQ/DIuSczuOmd//GwyvtrJBHrFrWDtgXQw==
X-Received: by 2002:a05:600c:138a:b0:43c:f184:2e16 with SMTP id 5b1f17b1804b1-43d509e3fcdmr171193605e9.5.1742930505522;
        Tue, 25 Mar 2025 12:21:45 -0700 (PDT)
Received: from localhost ([2a00:23c8:b70a:ae01:9cf7:b69:fc50:980f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f995a05sm14372870f8f.8.2025.03.25.12.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 12:21:45 -0700 (PDT)
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Tue, 25 Mar 2025 19:21:29 +0000
Subject: [PATCH v2 4/4] drm/dp: fallback to maximum when PWM bit count is
 zero
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-wip-obbardc-qcom-t14s-oled-panel-v2-4-e9bc7c9d30cc@linaro.org>
References: <20250325-wip-obbardc-qcom-t14s-oled-panel-v2-0-e9bc7c9d30cc@linaro.org>
In-Reply-To: <20250325-wip-obbardc-qcom-t14s-oled-panel-v2-0-e9bc7c9d30cc@linaro.org>
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
 devicetree@vger.kernel.org, 
 Christopher Obbard <christopher.obbard@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3611;
 i=christopher.obbard@linaro.org; h=from:subject:message-id;
 bh=mLHtZJFLMF48TiDY/Fyy9ntYtplBGAFzZq4lKzgNgsc=;
 b=owEBbQKS/ZANAwAKAWNNxPBocEb4AcsmYgBn4wJFBoQIZRwm4MEfRBT/amOrrbqvY6meAJUGs
 Zzs1ajSUdGJAjMEAAEKAB0WIQTxi9yLbCX5CqI9UXRjTcTwaHBG+AUCZ+MCRQAKCRBjTcTwaHBG
 +NBjEACj/fERHN6R6wNa/Q6CY47brEh3D2ieKKqZBxc1NEsvAR37Zc3L7OdNhHDhO0qX76l2bVz
 0grE7BB4wuc7NzXZ5+fxfu5eq25/rHeM2FyHFx3XDB5Vs6s+FXp4BVh017F7kJEzfZ/lucDeVa6
 +1odcCZkLKkGoV6bNBU1L3xCweb0uF2N4y5P07QWF8fJMPXz6kVXHHTi4STVlWOkua2P3GjQAPz
 CUshB4Vl56YUudtq8tSN694HVj78hy9vtjI9NEPsbVQcYUmETh+lBRT1wotQuj677Snt4faSTye
 10veysIYlYdAe2YbXTsvNQkU7rh5HR9QSP9WCDTKuXBa1dPSVnvr3Q/csL8WrWld3tYod+XTm8W
 ZQINeb2U1/CnzLnpIJmaJBQuUrk5t/avx0W2AfF+HQi3YHjHz0qFfu+DCtOldywK8gQNC4aq3sP
 kSZ9jDk9s4CG4w92Ch6C0YSgXFBbzueiIcz/AgRDFUB4u5H9ov5vK5/Ip4CgY7AYz6VfKwflZs0
 3pS3ZJH32J0AWxp3q3AHo+YM5WWrNgwz2omWAVVhNqEtOHzPACWCLtS42J+JwQF4ipqnLJVooKL
 T2vclFbbcxl0MU+8q8N9KaohCHZm7s6cxFPtBlWrAFirGE77N7HLFAs/1KUgOqxFtq+PXR0wsO0
 vWpEvDkVpx9PB6Q==
X-Developer-Key: i=christopher.obbard@linaro.org; a=openpgp;
 fpr=F18BDC8B6C25F90AA23D5174634DC4F0687046F8

Some eDP devices report DP_EDP_PWMGEN_BIT_COUNT as 0, but still provide
valid non-zero MIN and MAX values. This patch reworks the logic to
fallback to the max value in such cases, ensuring correct backlight PWM
configuration even when the bit count value is not explicitly set.

This improves compatibility with eDP panels (e.g. Samsung ATNA40YK20
used on the Lenovo T14s Gen6 Snapdragon with OLED panel) which reports
DP_EDP_PWMGEN_BIT_COUNT as 0 but still provides valid non-zero MIN/MAX
values.

Co-developed-by: Rui Miguel Silva <rui.silva@linaro.org>
Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 51 ++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index da3c8521a7fa7d3c9761377363cdd4b44ab1106e..734b7b8e46394de21837cda6ca1b189413b25cd8 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -3964,7 +3964,7 @@ drm_edp_backlight_probe_max(struct drm_dp_aux *aux, struct drm_edp_backlight_inf
 {
 	int fxp, fxp_min, fxp_max, fxp_actual, f = 1;
 	int ret;
-	u8 pn, pn_min, pn_max;
+	u8 pn, pn_min, pn_max, bl_caps;
 
 	if (!bl->aux_set)
 		return 0;
@@ -3975,8 +3975,40 @@ drm_edp_backlight_probe_max(struct drm_dp_aux *aux, struct drm_edp_backlight_inf
 			    aux->name, ret);
 		return -ENODEV;
 	}
-
 	pn &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
+
+	ret = drm_dp_dpcd_readb(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min);
+	if (ret != 1) {
+		drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap min: %d\n",
+			    aux->name, ret);
+		return 0;
+	}
+	pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
+
+	ret = drm_dp_dpcd_readb(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max);
+	if (ret != 1) {
+		drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap max: %d\n",
+			    aux->name, ret);
+		return 0;
+	}
+	pn_max &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
+
+	ret = drm_dp_dpcd_readb(aux, DP_EDP_BACKLIGHT_ADJUSTMENT_CAP, &bl_caps);
+	if (ret != 1) {
+		bl_caps = 0;
+		drm_dbg_kms(aux->drm_dev, "%s: Failed to read backlight adjustment cap: %d\n",
+			aux->name, ret);
+	}
+
+	/*
+	 * Some eDP panels report brightness byte count support, but the byte count
+	 * reading is 0 (e.g. Samsung ATNA40YK20) so in these cases use pn_max
+	 * for pn.
+	 */
+	if (!pn && (bl_caps & DP_EDP_BACKLIGHT_BRIGHTNESS_BYTE_COUNT)
+	    && pn_max)
+		pn = pn_max;
+
 	bl->max = (1 << pn) - 1;
 	if (!driver_pwm_freq_hz)
 		return 0;
@@ -4003,21 +4035,6 @@ drm_edp_backlight_probe_max(struct drm_dp_aux *aux, struct drm_edp_backlight_inf
 	 * - FxP is within 25% of desired value.
 	 *   Note: 25% is arbitrary value and may need some tweak.
 	 */
-	ret = drm_dp_dpcd_readb(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min);
-	if (ret != 1) {
-		drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap min: %d\n",
-			    aux->name, ret);
-		return 0;
-	}
-	ret = drm_dp_dpcd_readb(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max);
-	if (ret != 1) {
-		drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap max: %d\n",
-			    aux->name, ret);
-		return 0;
-	}
-	pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
-	pn_max &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
-
 	/* Ensure frequency is within 25% of desired value */
 	fxp_min = DIV_ROUND_CLOSEST(fxp * 3, 4);
 	fxp_max = DIV_ROUND_CLOSEST(fxp * 5, 4);

-- 
2.49.0


