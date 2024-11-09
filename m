Return-Path: <linux-kernel+bounces-402818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD42C9C2D1B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 13:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7A91F21C80
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 12:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C71319882B;
	Sat,  9 Nov 2024 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MbRpdYj1"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A971953BA
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731155725; cv=none; b=dngsJdD+DyqPj0YBGLgcYxLcRO+ndvKKNte5DCMfjdH3tKsjWbUUh/Zc2ROAIo8uZvQgX7VrHs9ShxKYn/kTQS2s5L+FQrgYhY+W4GfB3bLWJm3vzaBjEMh33F7+ja5irZJDtuByxHD4RUxcR3KgN+O+n/OWSdc+JHvo29Urrfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731155725; c=relaxed/simple;
	bh=HrGaJ3EnGO039JV3w0anWuEujv8ijZYE/SL4efGrI0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qf8pIpXEL4T7MxqnDUiCdkBk3isffC4NE6f7XbFiQ8uXUq1fTaioYUfPFC3zLKMfiinpN5IaFjLeX/2e3FKN+4T9+GwJyKfTn4TPt1cFHfG/uazC6kAyfgNefnlN3kHDlrrFdhG5ubjVkZbARhbImdHungEs3sXRsKpV0Aa4p+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MbRpdYj1; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f53973fdso2980789e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 04:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731155722; x=1731760522; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42exLch29KQ7aLIpxUbDK7QotO8PsN7YchUut2Ri5WY=;
        b=MbRpdYj1Jmn17hS4pMYss3jY7EXAlKMHejr/lMapsB9qiSSTS2Ucf9dUPollqNvBnh
         9KfqM0pw6QYwiZv3Z24NNRf/MMnJ8QR9LI4Fni271xFlv5eNhfgTXc5sEsggFkx7qUmu
         P3Ly6iWoiZbCM/UzV38DDtzoy9SOVHpC2qxd85pDZssadVJhb5Meee/YE19ihuhIVMvr
         gUvM1VxtQKQJjS9ytUhh2ivUvUq9/YQbQHuPlTwHii/FJbBO6ok8ff4wrEoUj/Ds1Uj+
         ccJ/lSlDs7eXe1SygEupvh/Q8mGDIkOv6jA/P52bOckNDRj8lJp0QNyRqqx06TOXIs57
         p7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731155722; x=1731760522;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42exLch29KQ7aLIpxUbDK7QotO8PsN7YchUut2Ri5WY=;
        b=k74ARQFGmz8OBC/muQuMn1YTQamKVtHnVAdljq07y54YKpQPHpJlgNov0C+YY7MrMt
         2/M7gXm0VfeqlpBzX9cuOlc07pNhrMcpc2PI1h3FyljXF+jwCrfDnplZStbSKzY53IKb
         8yZd8PBms93APRD41b1d8Y0pwdADeX5D/4fnL8VWseInb09Xk04LZGhl6Wzlo9Yi7LUH
         eD1Ssj9w8vIPOWL0XuXWy4P1QGBvRXtG2kq/JdTRD5u+RfY5HkBm9w9XdR+WCNe6w0FY
         rkwPzpeSZ0P2bQWY1Xqn+i6IBhHK7kDc2uV6hSrJJW8NegJiRLKhfftorZ5jXWzmzPX1
         9Flg==
X-Forwarded-Encrypted: i=1; AJvYcCUEeFgxG/j1Dx8uB0J0DOZU2Dx4BvaU4yV+IU4q7nzbVCMuyge9LpA74CWBo4Vta50KIOKHtWlh3X6ni4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGqPMFi7OLBPDoT+YeWBWrjCOWxIV7ohAqi6QdrONnyLIJpW9I
	cq4clpQDPwNVH/sJNPjH+1GT7O16EMPujs+zR8eFCZoKQM70dyejfGVU9iNB8JQ=
X-Google-Smtp-Source: AGHT+IF4/eBJh19k7QgFTqtYdnnffmTFfXf5+J78TQkqLjRVT/odItDWynAUIGAavfq6S1uNQ3S3Rg==
X-Received: by 2002:a05:6512:3b0f:b0:539:e2cc:d37c with SMTP id 2adb3069b0e04-53d866b20c5mr2162656e87.3.1731155722003;
        Sat, 09 Nov 2024 04:35:22 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826784dbsm922899e87.15.2024.11.09.04.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 04:35:20 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 09 Nov 2024 14:35:07 +0200
Subject: [PATCH v3 3/7] drm/vc4: use drm_hdmi_connector_mode_valid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241109-hdmi-mode-valid-v3-3-5348c2368076@linaro.org>
References: <20241109-hdmi-mode-valid-v3-0-5348c2368076@linaro.org>
In-Reply-To: <20241109-hdmi-mode-valid-v3-0-5348c2368076@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1406;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=HrGaJ3EnGO039JV3w0anWuEujv8ijZYE/SL4efGrI0s=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ7p+2D8f9f3f02SmxcyeF2ex7K28O/vzlAxeRaO7cXPNW
 zsuJYd3MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAi8XvZ/wepedeVGdUY/a45
 FTO/7Xv1pfz//KulXi+rvn++ruXV9J7NOxLtmRcxvg+wZrRovKntYX/l455LjPp/mY6/slNL/Pl
 IWeDX/SKHQ1IhgnO3qBnVF8wtvslfkSapYrigQPV1aors4rk70zwbriaaeRQcdeXdbrUik+9iTr
 3y4uDFNV95Qi329Ra9ez75iaVqFrfO4Q+ODGlq+7zjND5K1GcfK5y1cIpR3I81f1Sq0lZ9fjpv4
 h1f7px11wK7Fdc86Finv+NEnaX9fp3ZGteNPzDPa2jUMjdrizhkZfb2yw+FlWWPjxf++GQuHhh1
 QN72G+PP935pvX3m6Ws0Pt6+XhQ/dbleqv5FzZ6UOZXSAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use new drm_hdmi_connector_mode_valid() helper instead of a
module-specific copy.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 62b82b1eeb3694d1685969c49b2760cbbddc840e..486e513b898d7f761e8615f2afc193ca44b23200 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1752,7 +1752,6 @@ vc4_hdmi_encoder_mode_valid(struct drm_encoder *encoder,
 			    const struct drm_display_mode *mode)
 {
 	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
-	unsigned long long rate;
 
 	if (vc4_hdmi->variant->unsupported_odd_h_timings &&
 	    !(mode->flags & DRM_MODE_FLAG_DBLCLK) &&
@@ -1760,8 +1759,7 @@ vc4_hdmi_encoder_mode_valid(struct drm_encoder *encoder,
 	     (mode->hsync_end % 2) || (mode->htotal % 2)))
 		return MODE_H_ILLEGAL;
 
-	rate = drm_hdmi_compute_mode_clock(mode, 8, HDMI_COLORSPACE_RGB);
-	return vc4_hdmi_connector_clock_valid(&vc4_hdmi->connector, mode, rate);
+	return drm_hdmi_connector_mode_valid(&vc4_hdmi->connector, mode);
 }
 
 static const struct drm_encoder_helper_funcs vc4_hdmi_encoder_helper_funcs = {

-- 
2.39.5


