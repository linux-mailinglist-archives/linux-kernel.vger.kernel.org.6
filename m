Return-Path: <linux-kernel+bounces-446038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C519F1EF1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 14:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A225018897EE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 13:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D025189B8B;
	Sat, 14 Dec 2024 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iBIKVNX2"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69639D268
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734183438; cv=none; b=efGF0L2mAuZRb2RUrTwDFs709qzhgDX9Xlt1VA647uJbldf4hr+UzWU7PTUR1Xlez9ogMvRw5AdowdseixHlYl1z8E9djgqvIxrh36WvLZN45Qc8SsjLQJNAOzvxAohtyfX6H3Pp00fq+QGVnutQr9YJGVgCk7C/cmUUGB6GSwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734183438; c=relaxed/simple;
	bh=BA8YlLlkI8E3eOA2TnmDuTVb8Ici90Dw1AiMpOT58zA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HQ5ny/laWH+t5OCjuxwRhvyWJrGEFhmWszo4Eaok8gQSvSVj5CQuQtjiiH4pGom7azbGWWjtUrlyW6AOTbXhz+hLsnMgrOS+KMNOQZCFRrJryvL/pQZTaamdGo1wTmmM4oIE0r09i0YgQnQM0ZeeGU5FkIfuXHbPLlmVRXvxwgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iBIKVNX2; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53f22fd6887so2862204e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 05:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734183435; x=1734788235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=noTSGg19tqU9DdkDojtudCfDYwJCYSgCTwqn4/VzC74=;
        b=iBIKVNX2Z8/588++0yTqeDpYzzpgpGIve0gY/eqB/hRs9xwv9SMKdLVBZHE/T784tS
         nSno01zBTGQPZRWVDNYyzQPnp9zHTUPvqfd4ePe5PWD73AARqUxGg7wZ100ed8wVtrrZ
         PmMu2qIRnIPMPE1i3ZiY0bh7AWVVbZ4Mul1PJy1WSkHa8w8bP3aVY5Un2zYByXcX/RAY
         Gr3Vtm93jrY4PQL6OkjaZ84PjpcsVOwBGiuP8kPSShBAJW8ym5AiRdX5goIixpPi+6iJ
         IHKAAYLGSy/74fEcMfn8b98KudRf1bqyJALaT60lKr2BzjsyMauTN8pPzUQA/MrUtDNc
         YwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734183435; x=1734788235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noTSGg19tqU9DdkDojtudCfDYwJCYSgCTwqn4/VzC74=;
        b=JRpuaq9rQmK6KnKjywSIDxviEk7EEkeFnnQ7aVBTe0kLOhrEzQvlwnTXE4vk+X8MYW
         MNs5QdB8Bc0AGFwOjIhTfZGRzWIlCb9amD//HQ5b38HYh67cC7nmLF4cZY3zUSGDYftn
         5epIHlAfV2EPov5vG+CyPfOEySA5pMrt8mJZwd8fXVSCLlwH8AJzTYWJbl/cPEBIMfBf
         IOJeOOKbZoX22VE5/A70Ij8vwkwPBVHq5ahF8kX/TseS/i2RPdar9Km2TicWVwhQGfuw
         svxFQ0y+1W8EUA0pMC8vXngTTbNzVD4yTvjyp5BrMQPB6IOR6On4cG0n6Pey2PsKYeev
         bRHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNoV/k6TzDBBqAJ48kdEU/MnTqneWHe4+ZxFL9ga5/Ih1hfDoNlLmCg2mRqXNgma54ryKDB6BxWWHqo08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHBJ4kRCsVJtMrHm0KXdD+lffhethDZcXlgrX/qdVjRPiep39J
	o81P+aGOzREaf2xNzEOtOhVoAOjVQIRXCJ2mNwUaElnDVXSFtC+FKoi4us0IZGE=
X-Gm-Gg: ASbGnct+F3rHyEWIcX/lZm/iYiANQ4LKHNbfPSYdLQreiHK6bDnuuKUaz3u53lBwfwq
	chfohMPdNemBtHz70y15uAPE7JVbf3IuFlf4kucLePamXtvIsg0OYC6646qbb+SAKHgku8ICkrl
	VBoFW/+Boq99rsf09qrp2HqomaDQ7q1ZgKMCyFuMambCHHqTkWIf+aLxUtQcVIi0NhZlBSnPEgg
	X1NXmGcoQWtTqr4qBKjOIpirUDW/gg6tTz1C/yu21cpNGAAv+lKrutPqDkyV5Vf
X-Google-Smtp-Source: AGHT+IEi0xR7zoRxTqPxl0iLty4zwbr4Ao3SIaMjLOMpCbEphybEZM9KZwFp8q8/rnfiMhGmkXfFYg==
X-Received: by 2002:a05:6512:12d1:b0:53e:362e:ed3 with SMTP id 2adb3069b0e04-5408cd008f8mr1439574e87.1.1734183434499;
        Sat, 14 Dec 2024 05:37:14 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120baa474sm220131e87.90.2024.12.14.05.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 05:37:13 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 14 Dec 2024 15:37:05 +0200
Subject: [PATCH v2 1/5] drm/encoder_slave: make mode_valid accept const
 struct drm_display_mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241214-drm-connector-mode-valid-const-v2-1-4f9498a4c822@linaro.org>
References: <20241214-drm-connector-mode-valid-const-v2-0-4f9498a4c822@linaro.org>
In-Reply-To: <20241214-drm-connector-mode-valid-const-v2-0-4f9498a4c822@linaro.org>
To: Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@redhat.com>, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Peter Senna Tschudin <peter.senna@gmail.com>, Ian Ray <ian.ray@ge.com>, 
 Martyn Welch <martyn.welch@collabora.co.uk>, 
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Stefan Agner <stefan@agner.ch>, 
 Alison Wang <alison.wang@nxp.com>, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@csie.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, Zack Rusin <zack.rusin@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, virtualization@lists.linux.dev, 
 spice-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2993;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=BA8YlLlkI8E3eOA2TnmDuTVb8Ici90Dw1AiMpOT58zA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnXYoDwzezrZ7RAm6EtxUMTtxskFsgC2A3+5mf5
 PDqwy2TYryJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ12KAwAKCRCLPIo+Aiko
 1ehtB/4/gv0Y1mrqzFU9+qOJXPi6qnxv3Xebl1NN4vXW6xGWPscYkS7un6aXBPzphwSiybT5Era
 LbRNX+KCaHxxZqHH1wD1S0U/hTBThZIWnM42zFf0kC4OIX6smT3zfpoHAFsHl5BO4LxW7zCkhce
 NKxrDnOXXRjcU5FTGiE1s4jztJxDiSHwdzI4l+Ly8uoKKijhwSSQ6f0gNCw/m/EIMyuu8solCjv
 LmvAJJS2wJUUe6lcm6eObgRuQYPXBAp+PBAkdiNosFiK6BZ/3CvdBkYcm4uwgYxJd/RfeLePmcd
 dT2X/n21cOejt0WUUOG99WJQGqO/wTvviqkz0NfQmIJA5D88
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The mode_valid() callbacks of drm_encoder, drm_crtc and drm_bridge
accept const struct drm_display_mode argument. Change the mode_valid
callback of drm_encoder_slave to also accept const argument.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/i2c/ch7006_drv.c          | 2 +-
 drivers/gpu/drm/i2c/sil164_drv.c          | 2 +-
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c | 2 +-
 include/drm/drm_encoder_slave.h           | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i2c/ch7006_drv.c b/drivers/gpu/drm/i2c/ch7006_drv.c
index 131512a5f3bd996ad1e2eb869ffa09837daba0c7..a57f0a41c1a9e2006142fe0bad2914b0c344c82a 100644
--- a/drivers/gpu/drm/i2c/ch7006_drv.c
+++ b/drivers/gpu/drm/i2c/ch7006_drv.c
@@ -104,7 +104,7 @@ static bool ch7006_encoder_mode_fixup(struct drm_encoder *encoder,
 }
 
 static int ch7006_encoder_mode_valid(struct drm_encoder *encoder,
-				     struct drm_display_mode *mode)
+				     const struct drm_display_mode *mode)
 {
 	if (ch7006_lookup_mode(encoder, mode))
 		return MODE_OK;
diff --git a/drivers/gpu/drm/i2c/sil164_drv.c b/drivers/gpu/drm/i2c/sil164_drv.c
index ff23422727fce290a188e495d343e32bc2c373ec..708e119072fcb50c31b5596b75dc341429b93697 100644
--- a/drivers/gpu/drm/i2c/sil164_drv.c
+++ b/drivers/gpu/drm/i2c/sil164_drv.c
@@ -255,7 +255,7 @@ sil164_encoder_restore(struct drm_encoder *encoder)
 
 static int
 sil164_encoder_mode_valid(struct drm_encoder *encoder,
-			  struct drm_display_mode *mode)
+			  const struct drm_display_mode *mode)
 {
 	struct sil164_priv *priv = to_sil164_priv(encoder);
 
diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
index 3ecb101d23e949b753b873d24eec01ad6fe7f5d6..35ad4e10d27323c87704a3ff35b7dc26462c82bd 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
@@ -308,7 +308,7 @@ static int nv17_tv_get_modes(struct drm_encoder *encoder,
 }
 
 static int nv17_tv_mode_valid(struct drm_encoder *encoder,
-			      struct drm_display_mode *mode)
+			      const struct drm_display_mode *mode)
 {
 	struct nv17_tv_norm_params *tv_norm = get_tv_norm(encoder);
 
diff --git a/include/drm/drm_encoder_slave.h b/include/drm/drm_encoder_slave.h
index 49172166a164474f43e4afb2eeeb3cde8ae7c61a..b526643833dcf78bae29f9fbbe27de3f730b55d8 100644
--- a/include/drm/drm_encoder_slave.h
+++ b/include/drm/drm_encoder_slave.h
@@ -85,7 +85,7 @@ struct drm_encoder_slave_funcs {
 	 * @mode_valid: Analogous to &drm_encoder_helper_funcs @mode_valid.
 	 */
 	int (*mode_valid)(struct drm_encoder *encoder,
-			  struct drm_display_mode *mode);
+			  const struct drm_display_mode *mode);
 	/**
 	 * @mode_set: Analogous to &drm_encoder_helper_funcs @mode_set
 	 * callback. Wrapped by drm_i2c_encoder_mode_set().

-- 
2.39.5


