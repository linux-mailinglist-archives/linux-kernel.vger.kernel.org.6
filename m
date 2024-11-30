Return-Path: <linux-kernel+bounces-426073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F03019DEE7B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF31628206E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBEB155CBF;
	Sat, 30 Nov 2024 01:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wdTfdkmv"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97782154C04
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931581; cv=none; b=oY6U1Fo6yXO6fAk+FHTYbtZCQh1u9ohS4cZMf21xoBWDpmAI76nUrRnjbchSy2+GdT6034VT5WKvqrx4Bpf6ikxlWVrubzHIaPRhc6HRfAdOLLRsJcDJ9iQKXrMWZTYgs0sQdyFUTQFOVDrwVxQWuEtDFSQDSF2+mzmg14pbCo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931581; c=relaxed/simple;
	bh=UjNMLqX51SwfyB+kbUbjnJt95fAbmRoKvLYOPQ8ek9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lX7eSRcKuHfejcMGKAVxxX3d/xV0uzOiJNxmHQB/NvEzLqnLyt0IsSdwB8hOTepsLdf2q3+O21YE+FiKT9TyAMcAFPDhonsHXW3SS/1lNbYZh1RwHjUHtFJCieVRy1+So6v1EC0Ml4i19AY4ZkrI5FEHPrfe/Ni+R9idGf+zvwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wdTfdkmv; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53df1d1b726so2909647e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931578; x=1733536378; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9wxCYXwjuFpbEm8J6hnlc7LqgHEUz/bPD6SI90IVR0=;
        b=wdTfdkmvmw4L0GQNEFTySHzCI2OGyhSvxv2GXWp9DwRQI+L8T2lujnIYEG3OoqJ0/g
         39xS1NjKNUnev0Ay9YqYQO5ILkksqVRB055bJ8dI7Z5rCcRBX8e5Xs5cw/TRgWNfuDpg
         GVjrqd+/8Vxs1mR2RMw+92WwKayfZNGV0i9VwogZehbACdsfNLvRvcrErD6mQWJzf23H
         8K66HqFOQJYXiAydpCAI8KgEdahg0yM1jxmlfDx8DXh7BvV3K3QiPQtkVWV4Mzg8NjGR
         Kmltk0g4UlPbmoTh3SFuCOtYmabEgNF9mJ5Xxnr/w5+9cJRsU7kjWUGlDLMFEIC0PfUv
         7VVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931578; x=1733536378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9wxCYXwjuFpbEm8J6hnlc7LqgHEUz/bPD6SI90IVR0=;
        b=C1NXtQn4vnIx9Sjg7J9aQBOW3oDJmGalur/rJsEZYpPgf3To1/wEiyWnmagvWIC957
         04DOZLVW0+PrqMrZkQMm06oWNMdNFnDB8gsoj5xzVZ1ztuHLTTB3RAtgN14vZK8w4r2w
         iQdOhDDRqPML+2qhqSfq+2Yn71INNKektpCo1KAnx6ABHze4VOFg+uUpnP2aelpuEgZT
         HoQpntCF8ZkutssaahhFiQ5Sh3fzWRYLGcc8JikRZyHrM4QPytmnQxCSOGQqkMFHycXS
         dxqK5iVp8S2qmDsAcfdkfcRc5rfqg1mhvEeTqLEsFd7zAmcn7AkVbASwznlu2FafwZEO
         PmMg==
X-Forwarded-Encrypted: i=1; AJvYcCXWmLXDns1h5rTGJXcLxDoOpKF8GEg/Pei2Gj+7LtlCY75fATK77SmT+YXuQGd5283Ewz2gjUaLcF6Qey0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxb092YEQrjeMA4oV1QzFB96mZcqq7W6TMyf5j0M3PvmnYRKNU
	wJWuxkLthdMHa2uPpheItQSSS7qxdehPxoS2i99Ddmi4So7CA9vuFzC0Qb5S4fa+aVQCGyNOeu2
	w
X-Gm-Gg: ASbGnctaI3zOwI0zdLX6PBI7fzEbGQ4k7XVlPemhsYiSRuj+9Zdto9R1OitR7lSQjnw
	vpcb/s1ApteIn9bu02UlaIokV3avN75YDlyRm+6NWLZhTnP4jlW69CURjVQaI6XfZCMpOZtj8cY
	BFE5dL4TSuIdfDNtNjIGmLTVgORd9ulo/rkC4fQ1MQ9GigG3rxDVeoU6eVFv+7CnSV9kDUz37Wr
	4CfLgmG3y2Bt2sQ1aJVGFTQMbKerM3NKN9weamPqJMY3QG3FJTkwsRiLg==
X-Google-Smtp-Source: AGHT+IEPMkwzovF1BGtYWQPhSNDkhj65yoNCvxf3xV+YxR9n/u9tv7nbpK4B1sxwKYxaX0pKkPUYkw==
X-Received: by 2002:a05:6512:3c81:b0:53d:ea1d:50fc with SMTP id 2adb3069b0e04-53df0111f03mr8755501e87.48.1732931577781;
        Fri, 29 Nov 2024 17:52:57 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6443172sm636408e87.84.2024.11.29.17.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:52:56 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:52:34 +0200
Subject: [PATCH v5 09/10] drm/bridge: dw-hdmi-qp: replace mode_valid with
 tmds_char_rate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-hdmi-mode-valid-v5-9-742644ec3b1f@linaro.org>
References: <20241130-hdmi-mode-valid-v5-0-742644ec3b1f@linaro.org>
In-Reply-To: <20241130-hdmi-mode-valid-v5-0-742644ec3b1f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2092;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=UjNMLqX51SwfyB+kbUbjnJt95fAbmRoKvLYOPQ8ek9c=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm/hP4NTjv4z5OlKc/siHNPmPX53A9tMpMizW
 QagCkkZEseJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pv4QAKCRCLPIo+Aiko
 1YEYCACSjhD/Ij07xD1HSZ7Kb4z+Son1xvlSmJAJ4SpssXNb9iPUFIVI8goXplbGswSwyMT7gN/
 TJA4uoW5pm1VZfjXG6tfbVQkLp1egYiDvrum1DeygQ92wEt56uRPyVIx4IdIfPtB4T4NeaaxRHz
 LQnkHZDgA5FLhdyenT4uGiwtnYN42jAeIQOKN9kR+a3UWYD+yYdlR7SqZ/7LE57ljVXynJbKs6g
 U1MS/hQbvYoXlzbGG88vk9XYuwEsCee0SN0HMVpBvPgf+iAWlBzry2fAO18n4a3PcxUb5yoO8pZ
 BJV4wpwjoTw7LieiIOIG62SIWjAAknBD03dVAhxa/2O9Jx3N
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Replace .mode_valid() callback with .hdmi_tmds_char_rate_valid(). It is
more generic and is used in other mode validation paths. The rate
validation for .mode_valid() will be performed by the
drm_bridge_connector code.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 181c5164b23192f0b557624d73c6223032b90ec6..c686671e4850a1af75b82995185ffc3cbb22a447 100644
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


