Return-Path: <linux-kernel+bounces-372412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4786D9A4836
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6939F1C22308
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F59213EE2;
	Fri, 18 Oct 2024 20:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UB3tMiun"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45673212D33
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283685; cv=none; b=iPCTmdjiU/o3V5GXh4nexI387bXRC9eU9GaxJG9d8EJes0IqZnyZ0ylUToTv3Xs0Vo9W3sOVNORl+qeMcaZcSPC2dqJhEhcxu5eIfa7b4xGY7CUo6VDKdhBdfiDDgqRfJsIHx01Bv6jkqKpyWmG3bP0f1nr+xvlqMngORoDHyjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283685; c=relaxed/simple;
	bh=62YpkgWLFOCHVyXEfwzdT8WXezDQplIIX6XUhdEmdrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V9OkarSl6BD5NhCGRjN7lAHcbC7u+ycrflMNlv7b+bCk7mSQRKx8fMOexfTmviCfcKAdpnebk3KfMT6uaeS2sG2p4y0D6vSD16FnlvTmlndtm4GHkv2EJm04tZDanAAFoR2NOfAnSLevAGj/AqUAG/2trt4Y2fNccCmTl+w87II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UB3tMiun; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e1543ab8so4522411e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729283681; x=1729888481; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KNF3aZ80xlLK3q7tI6wiBMuQSM/G62kGRgo4sUnlVk=;
        b=UB3tMiunb7Iwb8bVyrNLVUoBC+qVTv0XU75c901Y4FflmiEDlX+kR5YfTeNFpzpIL+
         NZ5+ld5I6X8T0W4L7Wb2lCdUmPsQQKygM64dW3fEzfp5KqEqcaQ4KNBNwRCTP+6EnPX4
         r+/tTbSWH+Hbpwk2Apoo19GQosV+5bPEf9PJyq3Y3UgyWh9asngJZ2HlsCDtFwq6x7UU
         8b5ZbtWxxpu8a34crx9efPPBg211xtZ7YhMxWwb/PwTZN5eQv33b9coJdEA3X8pOZwLF
         3FVGjVwJPZZGybM51U1PmiYYy9JoWPVewOzMpFkN/9wofSFbTrsNCNFoBDwZVY6OzRDv
         OGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729283681; x=1729888481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KNF3aZ80xlLK3q7tI6wiBMuQSM/G62kGRgo4sUnlVk=;
        b=bH3CJSltesLPYDy2FDgwoAbQ0Es5lr/bBYriSU87blEHK9NagUuPNmk5+6i/POVmIh
         Zi6igy71+qQ6s7YxKqKo1JtDuw5z4DounzupptV0/22xX+oKjbMkMIB32xYruMkrc2Xc
         9kda4aud5F3aS1pryGsasyNQ0OxSDwCYp45T9D+bOQxuW8cLUM3BaQ9kqfQXGos/X3M1
         WtYqyOekXi6pFxdfJ3B1D+l81IZp/HMAjtd4xX4P0NwcMS79o/OH8iPHjkX/e/H7eF4Y
         htW0IcpFVZo8uPMHx0eEZDzwNI3AnKiUZH5H+KtptAsrAiviZBi4W0VfsaMLXDUcx+Gh
         Wj6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAemOvVkeNXGhSTcfWSZ0Ec8Qg4N5sX9JAS9cHLTYtiTGzyUHKKpqIAfTzLodw1JXpSN0wU+cE1elpEzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiWEAK4GWHZwaPu9D9Ed8oD41q9KmUhdZGJ8FlfHMruGJOdJtC
	Th1n/t0mPLiFm45kDqayq37giWk7a0Nob2I9YTKbRyUpS5nL3rnyMEJHHPO/BBs=
X-Google-Smtp-Source: AGHT+IGB98MZ4b+WRaD4A9VvwnCwxRN8d8/Fl30hE0Oq/p3vkPf3ZXCtCy1fbIicLKx9CCVIxFGzog==
X-Received: by 2002:a05:6512:e98:b0:539:93b2:1380 with SMTP id 2adb3069b0e04-53a154d80a7mr3793237e87.48.1729283681263;
        Fri, 18 Oct 2024 13:34:41 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151f0e09sm314047e87.146.2024.10.18.13.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 13:34:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 18 Oct 2024 23:34:24 +0300
Subject: [PATCH 6/6] drm/bridge: dw-hdmi-qp: replace mode_valid with
 tmds_char_rate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-hdmi-mode-valid-v1-6-6e49ae4801f7@linaro.org>
References: <20241018-hdmi-mode-valid-v1-0-6e49ae4801f7@linaro.org>
In-Reply-To: <20241018-hdmi-mode-valid-v1-0-6e49ae4801f7@linaro.org>
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
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1944;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=62YpkgWLFOCHVyXEfwzdT8WXezDQplIIX6XUhdEmdrA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnEsZX9lakH8ExWkyFJBh3Vc/U3dgf2jd+BXIqJ
 6Bk7kv5Vj+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZxLGVwAKCRCLPIo+Aiko
 1S68B/0X7Ry1mckj6d7MJuKYGTrRuZOVLxsRWDxeWeqwBQoQpAxzeojZvPJev6Oxh31fNJfDHlv
 viIPEJeCikJpCIWZRjx18K0IkZgFjHF+4lPgja+L45P7s9www21/P9l8yxpZxaeY8tfp9Feeva1
 w8zMRXKb2SIsoV5auELsD4HbL/zMAREVeDlAM+MAs/gM5SsfNbu0xS82tMU2PvLaWr23nj+XDiN
 M4NgU0NZh7rhHdbrRlo9A18C9fmxpbOkQCz/+cPA/upYzQy4eY6ZKOT9ZTAWLc6fVO78/I18bp1
 5I4arn059C+4n+6SO3O3HL370p623RGL7qCqpFj6x7vdg7A9
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Replace .mode_valid() callback with .hdmi_tmds_char_rate_valid(). It is
more generic and is used in other mode validation paths. The rate
validation for .mode_valid() will be performed by the
drm_bridge_connector code.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 181c5164b231..c686671e4850 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -442,16 +442,14 @@ dw_hdmi_qp_bridge_edid_read(struct drm_bridge *bridge,
 }
 
 static enum drm_mode_status
-dw_hdmi_qp_bridge_mode_valid(struct drm_bridge *bridge,
-			     const struct drm_display_info *info,
-			     const struct drm_display_mode *mode)
+dw_hdmi_qp_bridge_tmds_char_rate_valid(const struct drm_bridge *bridge,
+				       const struct drm_display_mode *mode,
+				       unsigned long long rate)
 {
 	struct dw_hdmi_qp *hdmi = bridge->driver_private;
-	unsigned long long rate;
 
-	rate = drm_hdmi_compute_mode_clock(mode, 8, HDMI_COLORSPACE_RGB);
 	if (rate > HDMI14_MAX_TMDSCLK) {
-		dev_dbg(hdmi->dev, "Unsupported mode clock: %d\n", mode->clock);
+		dev_dbg(hdmi->dev, "Unsupported TMDS char rate: %lld\n", rate);
 		return MODE_CLOCK_HIGH;
 	}
 
@@ -510,7 +508,7 @@ static const struct drm_bridge_funcs dw_hdmi_qp_bridge_funcs = {
 	.atomic_disable = dw_hdmi_qp_bridge_atomic_disable,
 	.detect = dw_hdmi_qp_bridge_detect,
 	.edid_read = dw_hdmi_qp_bridge_edid_read,
-	.mode_valid = dw_hdmi_qp_bridge_mode_valid,
+	.hdmi_tmds_char_rate_valid = dw_hdmi_qp_bridge_tmds_char_rate_valid,
 	.hdmi_clear_infoframe = dw_hdmi_qp_bridge_clear_infoframe,
 	.hdmi_write_infoframe = dw_hdmi_qp_bridge_write_infoframe,
 };

-- 
2.39.5


