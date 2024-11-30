Return-Path: <linux-kernel+bounces-426072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBDD9DEE7A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484B116269A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7EA1552EB;
	Sat, 30 Nov 2024 01:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uGtzDa3g"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BD873446
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931579; cv=none; b=Boqhuwg+9X7Onil12wzHN+wGcNnkHHIuVsRdhOf20JQ6mFJTKck7mKw2XWAWTbszg6hzEAgcPmqxsOPfbcV0Si2iqjE27OeQEMr8ioaurBXt92vxfsBNeYkRZtOPiFo7WbEGFIemv1Tkntv/1+aVofdNQPU+IPOoI+g9JgwRrmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931579; c=relaxed/simple;
	bh=CHPPIcbOk/4oF+oFDkgVgA19LBW1SDNLoLgjIjG3wi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pin3QUbKAPSbe5/UGLPcmwHkMWxS03z7Ra21AV6gLexJjY9SWHXsP7UjSAmoGiYljMmNu3dEKW/Tcp3nVppTPn7PzMS9hWX2/St9ynXMDvL++ZGjFTRHGigeMTCkil0sZgOiyadVHw4coRdd6tO2UILGnrxr1gevDtxgGi64d6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uGtzDa3g; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53de035ea13so2446677e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931575; x=1733536375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hHECBYEofE1LVFfISufmiOFENr43Xg+pptUAkUKUyA=;
        b=uGtzDa3gQUI5/7JmPAAIGhqW47ZSnUsNq92UfJNm4+gOm7M08+CcqertiQZqX0lVCU
         rh7NDQnEnqINmNODudekZtvaFOg2h9STZNvgptE+3ltGEI4t/A3lDhDbB96NtEwypeuV
         mqmjpWgazWMalEng5y8E7m8xHoc2cYUEoOPArpgO55WRZR4ORTdUkfD/T0aoDVDfpHxD
         PAZmO1Ko+XLTUvke/g31GSVuIX5ZrSh2VvKX0zRcZege4G9HCMFTCJuZ0ebp9QAHUwam
         px4Y6qyQ4iJgpxlOZ2TcVQyVTgtUmDBBPZECJ+td7p+ey8a6sCibXKMRxDh379lBy70z
         2oCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931575; x=1733536375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hHECBYEofE1LVFfISufmiOFENr43Xg+pptUAkUKUyA=;
        b=IJbdy4M5cFwn15D13o/HbE0GJTaroNu+lJDo10KomM2S6u16qRsuPHo93qWMyksXtb
         dDTPN08YCnEXoBbR3sNTLIQvfqunhlFcpYbVU08RxuU7HPQGgQdKODQNDdWbA2Ll3sLZ
         bbC6o71nj4xz5xSoRwcFMpurQ8OreL0pauunRHjsC5F6l1+M6x/02Jzdy8TStHgQuml2
         sEPGiZiUTuiBGs3++CusY8svtpeQlmzs9KFGD4mNHDXCmpFaflxqNxTcRPs0CL6/Rf8A
         sUjiawq/ApdhtB8NwQzaW6SCOXVwbm9y+OEmmqWvH21TsBhaHag7O/uFmRV7Dc2mVpxI
         M7ng==
X-Forwarded-Encrypted: i=1; AJvYcCVsI1YpgtlbEjsmU6rO60dZcGeY65sm7rgC3Ik0vy2O1t9/5jmzH9jgouMRtJEylfLUnk20FbTDfCQE5M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmmPO3xsVblgPiDkix0Hf1YjIPR1melLJqHGxxRaAx9DbdYyuv
	9p16/rSrkV2M64UBEW43NKYc1Cc2f2+Wy6JfpgqZaZ6h3HiIgc74Nhfh7S7qfbU=
X-Gm-Gg: ASbGncuUwAJVJ6VzM+j5zta/Ssjt9QnCFCtP50jWocUmec8QOlDg2/xapnuCcAWRkeV
	8KSeUgZUKGUOcIzfG/Ne5ME8yXlwzoenJHy5DMn5GpoARLBYkZDxAdz44t7+2djLRiBfUDdMtFy
	SuaXrBBQpqQAWzdebHrS2PsHinCMXLA3kZJgAyPfUlb+EaSaOJ/Xm7vHbYkwQT7dHYAauDx7tGC
	wcO516hafBKJVXAiGvKz7DAPUaVRBIClDao3cPM6p5V8j5TXyO4beZrbg==
X-Google-Smtp-Source: AGHT+IGpbKPr0jDpuxGiDeE7FvrQMAmAyXEng/ZnD9YgSk62wmodTKnHm1As1pVrSEzDd0Rvi+mmbQ==
X-Received: by 2002:a05:6512:3b25:b0:53d:ed08:5712 with SMTP id 2adb3069b0e04-53df00d3c8bmr8073919e87.23.1732931575393;
        Fri, 29 Nov 2024 17:52:55 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6443172sm636408e87.84.2024.11.29.17.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:52:54 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:52:33 +0200
Subject: [PATCH v5 08/10] drm/bridge: lontium-lt9611: drop TMDS char rate
 check in mode_valid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-hdmi-mode-valid-v5-8-742644ec3b1f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=CHPPIcbOk/4oF+oFDkgVgA19LBW1SDNLoLgjIjG3wi4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm/gZYVRxsPvBuVk2hROVkIaUSrjCIe8xd0oY
 EGWuQDCOl2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pv4AAKCRCLPIo+Aiko
 1TwnB/95gm5vag8iFN5M1sSaLORbtyefXMqgXK+UYyOyMGH3WsrGBMV3zrqFa3hOpYrpMOPCJ0p
 2qpzknExme8zQHyG/cCZzlAZZ0eO6hM0CQ4/s+rxguRsevb95fQ5hLPrn9R2wyESwkIQNRYRb3a
 2aXx6WQ49NUOzerBIcauDv7aYjXAkWdIRA7hLYiNDTUg5XaxsEmn/6wFvWpYIa8jK6QejHWd7y4
 sTqgUxNX89KPdleAyprS2KSf4PwrAVlhpqMiALo1t+TdddoHZRFuKOltrZOe72vM5ukHKooMl5i
 xPpLai8cV0tXWnmKjXAfd+Ca/6CUJ/aMT3RViERTh2qn2xln
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Drop manual check of the TMDS char rate in the mode_valid callback. This
check is now being performed by the core.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 8f25b338a8d8f95dc0691735ac6343675098f7f7..1ffbe473e4103dfc315a8cd3571e9407bf518797 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -757,7 +757,6 @@ static enum drm_mode_status lt9611_bridge_mode_valid(struct drm_bridge *bridge,
 						     const struct drm_display_mode *mode)
 {
 	struct lt9611 *lt9611 = bridge_to_lt9611(bridge);
-	unsigned long long rate;
 
 	if (mode->hdisplay > 3840)
 		return MODE_BAD_HVALUE;
@@ -765,8 +764,7 @@ static enum drm_mode_status lt9611_bridge_mode_valid(struct drm_bridge *bridge,
 	if (mode->hdisplay > 2000 && !lt9611->dsi1_node)
 		return MODE_PANEL;
 
-	rate = drm_hdmi_compute_mode_clock(mode, 8, HDMI_COLORSPACE_RGB);
-	return bridge->funcs->hdmi_tmds_char_rate_valid(bridge, mode, rate);
+	return MODE_OK;
 }
 
 static int lt9611_bridge_atomic_check(struct drm_bridge *bridge,

-- 
2.39.5


