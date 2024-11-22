Return-Path: <linux-kernel+bounces-417998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E0F9D5BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70523B22978
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267721DE4EE;
	Fri, 22 Nov 2024 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JMwehT3u"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9112C1DE3D4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732266808; cv=none; b=QwxdiIdMdD8CxV6EZCwvHGpTZXsetnOE9Y+Jg7Rma1G2PEzdpw2Gfct8DXemjEd3jU0Ffc0x66T6puHOV1XctSyXLY9vQhooYdOl2siD5XWJQrausrZ31gZXmwyWd2NsTI5RcuOMDYkpNhHimVyFIYgOW6oOAKmYmYBXNNWpPds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732266808; c=relaxed/simple;
	bh=V4oVcdTHVT3mKFPFYYqaTi+sHqWjzKg7CIWwA7qtBbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qfrs0pt8MmC9IMG6rAbbFhwTkZ0k1XO/AZ58Agpuue8asQyz4FjD0+madJpVrkt29Y/xNAYeLk2RuVXNzTI2kSHrkkgL2nMGPg4Z2HkwO3vBpQtP8dbhY96VhtlqmTQg6FOuI1DdqHiJ1ptFwb/WNIqHgP2yx43JFTnk1mB2zrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JMwehT3u; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53dd668c5easo215985e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732266804; x=1732871604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yuGfl/EBV1L9yZwllQ4z7rC0GCiUIVGF8V+6a/LgMU=;
        b=JMwehT3ubG6cBGrMchGLgszvSoDljUCg8Qzn3aQVXpjY+TF80uSs4g+D5vllkg9JTX
         99h2kJO12tw3UPDq/ECQg51Ks6fRkrl2AmoiX2YBeDQ79ZI6ETnXGBTWEaL1ABHCNQt7
         q9t2svHFHZ1l9Rp5JevjArkjIzO1GsMOaiNmPWZS3ELhc3eUKfLam/1tXupq4DNM1GJr
         RMc3/K5+vkhy7pCfnVbPuLesqGt6lrU7ZjFQGVqzRFLbLQN/p9k4sV6nc/IlJ+1awM5r
         JXD9AZcbir8Gt76bdovjtCvrZeR0p2SrmKpMdwOfQZCBqX/kJoMrcMwDIDlcMF7GpOY5
         GSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732266804; x=1732871604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yuGfl/EBV1L9yZwllQ4z7rC0GCiUIVGF8V+6a/LgMU=;
        b=cevMPT8T2t50sVltdEq6FjhpiM6vxP7OHfE1ZIEGYnzh5iNsK60nwBexV1CgcbZcvT
         YTKDz9ogpUJkkG/O4vie2181Ng1dSAjy/P+YmEEDsOWuBuaAhHBp7JabcNDoDxChgT8r
         8n+EpXx6WJbx7xRo0sH3TdTmAKEut45olPsKKB23Vesm/Bzr6pcURZZE83uUKz+Q0aQy
         0KXfY6DlwSmF/FAIpJRB0v7316pP7t2mPJKSeMIL28N1AcsrYEOM3UDoiGxug07YqF75
         5jdbeTinhQirfw/v2vp34Uk4wGlTiReFR5s/p5OxA9qECdxO8PmuQVk0w7GDnw/xpPwF
         7oUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAyva76NGmZ8T6qhVhn2tuXrM0lHK07JUPpJJc1LAHopUHzgAGVdgDYF6nraQntvFKDETG/WjPFoTiMZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB4XfCeiKYtoMo0oXWR9a/D0foqYLF21Kd1jzPsgu25+PGLahs
	9DTT1jDE00GsNLZU66VOVYRmK5coDfYoXCvPy20RWbdAZmRtT/LtDDE5E7YAXkZwzqPfvo4bwpg
	C
X-Gm-Gg: ASbGncvJfnRc8nXyTwR5cjzPHIBWirYTDZyeOf4jujTjE2rbABx497F3j6bOMHis+As
	Bb8fTuj8BX+eUFUA/qzfAwgAzCYEWVc93cOjrfGs49s5k6+ZPJkb9w1UvNau+YGApHHWHuhkaA3
	S8aUGCNRr9tNJSbExypQ91ebGdqRxMFye90sOLxUafefsKidLgRA/5wON6PwQUn/pjvKHXbWMUp
	zPDOCHiFHLOOKjgQ5/bgf7ymmmuf+4hvhWQEvVnAGBZTE2l+AvPyPMpQg==
X-Google-Smtp-Source: AGHT+IFLvHEAOMFsbgXw0Dwjm3ehikp3aJtpuOLNAA/Ny7NGqmxqJedFV/QSTgM4ejrUuhK9ANir2A==
X-Received: by 2002:a05:6512:3c8a:b0:539:fd75:2b6c with SMTP id 2adb3069b0e04-53dc618307bmr1957531e87.21.1732266804495;
        Fri, 22 Nov 2024 01:13:24 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2451386sm299530e87.77.2024.11.22.01.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:13:23 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 22 Nov 2024 11:13:02 +0200
Subject: [PATCH v4 06/10] drm/vc4: use drm_hdmi_connector_mode_valid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-hdmi-mode-valid-v4-6-2fee4a83ab79@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1740;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=V4oVcdTHVT3mKFPFYYqaTi+sHqWjzKg7CIWwA7qtBbc=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ7qDt5JRalysFtfhpV3XJx9r4HUI7Mk6MKsr+cPD+3Hfb
 Jbz8vN1MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAiGk84GPqERKMOmjLumLjD
 MnKKz41Pm3N+pJ9/n8z0rvuN6cMZVyc75WV+fMW/4fbSA2vvrrVpMe45G3ww+9aP3vVvnz98rSu
 4O/isbPYRnyflj5ydRXks1ul3emxm9fvxfFpOelVarJm2RHEYa/6RS44puVXrtA+wmssZ5c0uzJ
 ygVmJ9LPPTud7Y0PcL77Sd/xHW+ob7VvMR38uiHV0XZA79iVnTJeCicc++kzU/JSzJ6oPkpn6nn
 mvqh9ltP5Y1VQhNcD2W0HDzreEji7nuNWpRnX37Lrr1bVsfapB0u+3tivnhToYGkh6Ov7Pn7ivy
 U2d2yzm0/xyn4Lp0CR2pL0vk/PYt+hT85/Dzhto1cnINAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use new drm_hdmi_connector_mode_valid() helper instead of a
module-specific copy.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 62b82b1eeb3694d1685969c49b2760cbbddc840e..2fecaac0df0acd865186ee928cf26449799fc7ba 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -580,6 +580,7 @@ static const struct drm_connector_helper_funcs vc4_hdmi_connector_helper_funcs =
 	.detect_ctx = vc4_hdmi_connector_detect_ctx,
 	.get_modes = vc4_hdmi_connector_get_modes,
 	.atomic_check = vc4_hdmi_connector_atomic_check,
+	.mode_valid = drm_hdmi_connector_mode_valid,
 };
 
 static const struct drm_connector_hdmi_funcs vc4_hdmi_hdmi_connector_funcs;
@@ -1752,7 +1753,6 @@ vc4_hdmi_encoder_mode_valid(struct drm_encoder *encoder,
 			    const struct drm_display_mode *mode)
 {
 	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
-	unsigned long long rate;
 
 	if (vc4_hdmi->variant->unsupported_odd_h_timings &&
 	    !(mode->flags & DRM_MODE_FLAG_DBLCLK) &&
@@ -1760,8 +1760,7 @@ vc4_hdmi_encoder_mode_valid(struct drm_encoder *encoder,
 	     (mode->hsync_end % 2) || (mode->htotal % 2)))
 		return MODE_H_ILLEGAL;
 
-	rate = drm_hdmi_compute_mode_clock(mode, 8, HDMI_COLORSPACE_RGB);
-	return vc4_hdmi_connector_clock_valid(&vc4_hdmi->connector, mode, rate);
+	return MODE_OK;
 }
 
 static const struct drm_encoder_helper_funcs vc4_hdmi_encoder_helper_funcs = {

-- 
2.39.5


