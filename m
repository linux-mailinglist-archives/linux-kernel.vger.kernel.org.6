Return-Path: <linux-kernel+bounces-391480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E116A9B87AE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104931C21293
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F5D77111;
	Fri,  1 Nov 2024 00:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Leii2UNw"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC43A8D0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 00:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730420729; cv=none; b=GeXRPD/9pUdTycMZf2Mf56EdLeoFQ97bNKvFfRQUgfCwwWAtgec6ufFf4JAoM9mfVe4tEesjzHCSPWuhrTGk3f1WvBAK6x4OZ+PaXIC3IEIzu5p3uM8XlJBsE29ueSffUhwjxbfWPQu7R7Pe/+u5W3U6FsLzTNLpxGAQC7YQKT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730420729; c=relaxed/simple;
	bh=2cAY9yTx7ywPgJgHfm9Yb5s7i+clqrcNRhwPtafGQxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RcuORYfR3uWhhGOMejzSjDgwVOor1uM9nZGARyfNWKTIWN4Qf/atuBPdbXcH48FvaYrLxBIEJJEjRry4afv7J/LeVEBnGC5YjRGP04tn73JV072YGeGIOR3qBKEncN6HXosmLpDffiZeq0O8nvnur4FKIT8zsH6dTop8j/NfiGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Leii2UNw; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e690479cso1640665e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730420721; x=1731025521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5YSV0GHN6tODKa+I9kvPXfXQWz+eBBIeCxWrWSu71k=;
        b=Leii2UNwXq8KHiC1E4S/+FVZMPwsS3Tayt6rkufD8J/wMkDzAPISva3Ezut7CouWYx
         Nb8dPOSMTaEo8zAJF8qXHyyTi8/4vFhoxtfv1NM6bWKo6ExGbUO7x/RhFRlU9eIBO0Aj
         0pSRbZi0y5gU6NNVIHhsUVq4vo6YuKO+ZVKXmtemvpxEewqlz+LYNsC5tKewTCKjl896
         4TqZ7HTFHCtY/jN8DoKm6MLiASB8upAxeBvwumZbBJhDczu+lnYy1bLiFzTNfL8R76vc
         mzaegvegDFaOpE+Ibr/G9k9HNbDWzxaSpbzbW5VCELWvjLj0ZVlYqZRIFmGcWA4IelaS
         w4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730420721; x=1731025521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5YSV0GHN6tODKa+I9kvPXfXQWz+eBBIeCxWrWSu71k=;
        b=CtT9jo1XXIXWtxwxCuZ5U63fHLZ3QdqnFle/ATbRXrNfxGly6fiqnusrCvDoFOUrQ2
         Yh0AfWRwzAFbmIo1ok5thsz6VI2cvWfQPd8YnvrklBb7lnSMLXolQn0woIQO8Py1MSWB
         nKuuuZOkIegSqZQvCtCk5cxJjc/IyoV2013b+HFnHTr97xtwEyOPia9jWecVI5L42QuO
         K+3Cr+5/E+1ZkoX4fEMqgW+2qH5pXrxY2L5SSP/5t3QqQY3SZIeyFLuQ1Lx4FV0YBitE
         w2a/xfZN3XE3BBRwcrrByLlNKuaJh9VHvZBBbP+eysgaXk8A7kAXQWO9wX+hRyLG6a+c
         l2nw==
X-Forwarded-Encrypted: i=1; AJvYcCX6gILVg6mA7DLpFZ00lAAbck4LqgN1MUhwrljyLxV9+li/hXFk9f6d1vgvft6Y4pV0lnVfFMbeLiQMRZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylt+YeNfErPuqMj4b0FqVeueq8Nu9aPlBKlb9QD+yFF4/jt0QF
	Gp+jDqX6Gvs36SzOptHa0dVCeO2nTG2+C7u+eWQD/tBBUdz/Y1Fdf0peByK830M=
X-Google-Smtp-Source: AGHT+IH+Z352s483KbHjtU5VVJ6ZByUM9w51iqApUCzupb2q+5C0iuOE0kUGC7cK9WZXbJJqsjEwvg==
X-Received: by 2002:a05:6512:31cb:b0:539:e436:f1cd with SMTP id 2adb3069b0e04-53d65de60eamr1039132e87.16.1730420721328;
        Thu, 31 Oct 2024 17:25:21 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bcce489sm371153e87.127.2024.10.31.17.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 17:25:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 01 Nov 2024 02:25:08 +0200
Subject: [PATCH v2 5/6] drm/bridge: lontium-lt9611: drop TMDS char rate
 check in mode_valid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-hdmi-mode-valid-v2-5-a6478fd20fa6@linaro.org>
References: <20241101-hdmi-mode-valid-v2-0-a6478fd20fa6@linaro.org>
In-Reply-To: <20241101-hdmi-mode-valid-v2-0-a6478fd20fa6@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=2cAY9yTx7ywPgJgHfm9Yb5s7i+clqrcNRhwPtafGQxY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnJB/igzsmQyIppH1aHxewnBY4Uhlduz4k+yAau
 9lDSDvbvv6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZyQf4gAKCRCLPIo+Aiko
 1RyvB/9WSZ4mNeqd6GCGzKzlegONFJkuLiNKth6QBGTxQ//vKPOg3+AtwZwoekG8i/XcF3v32K4
 65STYUOFY1I/FgP221HjXjV3D9ECFQLDGGeKhm7aLPml3ejppcxSFCoSMIczoSfyYm5k1G2xoKr
 fCCE4IU+aSG01lp6cHyXCQG6y9YHZs864O0vGh0SgHH1N6SeLGRb4NG2Fe3MKhnXwjYwEcYpOyU
 J2lEr7q8KPfcvWjBZZzLDqwPmQ9c8C5h1xKOssI4DO3MY56kui4eN8trJfFkVfWm0Fg46xuPxrQ
 6aBgbPv0pAwW/CBUvWVI6roTVlburpPQoWsR3WuP+sPFeVDU
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Drop manual check of the TMDS char rate in the mode_valid callback. This
check is now being performed by the core.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 1b31fdebe164063e6f3972fdf8a5801ef4c35c4e..b8ccffdf515ade6e3bf863edbedc41e6f2030f29 100644
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


