Return-Path: <linux-kernel+bounces-372411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 312429A4835
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606581C2213B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254FC20969F;
	Fri, 18 Oct 2024 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q9hazLp+"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAD1212D23
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283684; cv=none; b=k75uMlmwG+PgtAa2YQ0pi1Kjltzx/Gvgique9bA242SWysztaiJ+QpnZMSVcH2YT7JR/4PiwtSe0S2SNYF+Iq5WGRwJUZF7qSxoJ1OQcieAA8CvQ97aOZGV4D8jTOhemdOp+ET8ZaoUUwkAD0VF2J5RWmqpTSKR4m8iwa2EgJwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283684; c=relaxed/simple;
	bh=osIrL7yWr+4pmjn4TVjBTzhg7zx8VCnWZvSiQ2XJamw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mcRtZCkxODRVS9FN1j4PsAb47KwQUhD9ivy72+XyO3DgMrDvqrlJCJjcalH5z/lhnrcO4k8UtqfEmU1a8UPK943yaZLQEakAYslkgsKjITWG7UHJumBG3Nwwi5IEkDgfrfYw+8dp6SKt0b0Vq4hpv3p44t55/bywD22FPZbKPAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q9hazLp+; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so2468034e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729283680; x=1729888480; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQVWVw/idsCMZK/QpoLkRhrGm63gf8m8ez6XsTKeLHM=;
        b=q9hazLp+KEVI/SvGH3RCcOrL9Df7X1Du0eU+6xSzzdUTQGSoWQC+hQ5fFRaYLHOAUB
         gd4WQbUwU3jrim2DkYCD0IRGjEJRB+9GTamhb7WwuWIOJ04VpkFOTagOC4K+Ce9zQEwA
         mpNmjauw9+6BmKwX8H52Wg0Mn8PdOqyUwvN/XFc5xTLy6Xv22/C3xZeV2yjdufkcu20m
         UE6oZTTgXt/4GXAvDg5QnhK51CdlYKiyYKzck5BB6/svUyNk5l+KcGo5mLSPJsRdm2TN
         zv7DA0jfQ3ngri+acEtvRBK+CXaneaB/VRjBdP8zItDD/Y8XH2NXVEuJbCNvvTnA3ddb
         XHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729283680; x=1729888480;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQVWVw/idsCMZK/QpoLkRhrGm63gf8m8ez6XsTKeLHM=;
        b=TtGcA/v/zwn8KgD9nAALb4XZWFcWuJ06bOciHRFLfigEOYF5TIXZpwu7bdL7lP2+rr
         yl1r/sfsj3gEPAPaF0rbfqvONChYoTgb2ijvbL8n469RZrx/ZatJ+jyRytl016DcwyIt
         BsMKo+hPwzkbJhsqSyRwO0CQqYEYaC0cSXegJlj0QWI4DY+5wEGGGcMy6qsuY/p6ICHQ
         St1h1c2DaRqSA95ldBs5bUvsS4LXstvz2uluPDSokFwblgxKZLDRt+lfVyVc21SOPC6O
         9D7NUrhYh1Q7w950gcKVwyDs2ZrMlC6b6UFrGUu5/ATCHAC4OKg+0FVGMdzijkB6JLUU
         ZVRA==
X-Forwarded-Encrypted: i=1; AJvYcCU6eulOwktVmGSREHg7G5AxR7D4vWr2DuairmGRmBk1J9qj2Fs4YBlg3k9+k6fL19Qw07hbIqKSnc//Y84=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTM+4fFedB3ZKPHGpcm36Oh8mg76PjY/FshJXbY1xz+JhaLlzy
	LE+3ZAsnv5+ZULIPiR0hc/mbSzctOiltHhqfEeJQivj5luSn6K1hDo/jDZok8Us=
X-Google-Smtp-Source: AGHT+IGoSpeJeqVcn2bBpU1CDeVL7TbnH9BzbJ+fJdWG6AlVnAH1yvvW7YML8X25GofhaYelXl/hnA==
X-Received: by 2002:a05:6512:3ba6:b0:539:ea54:8d22 with SMTP id 2adb3069b0e04-53a15218aafmr2609863e87.18.1729283680110;
        Fri, 18 Oct 2024 13:34:40 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151f0e09sm314047e87.146.2024.10.18.13.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 13:34:39 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 18 Oct 2024 23:34:23 +0300
Subject: [PATCH 5/6] drm/bridge: lontium-lt9611: drop TMDS char rate check
 in mode_valid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-hdmi-mode-valid-v1-5-6e49ae4801f7@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=osIrL7yWr+4pmjn4TVjBTzhg7zx8VCnWZvSiQ2XJamw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnEsZX2CRSrVD6zRlV3sf79iOpwhz41ku4gX4qc
 tGYqxdPC/uJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZxLGVwAKCRCLPIo+Aiko
 1RyYB/9E+wiPd2wCJklbxNW0iDngze8b+l1vYstAn14YjudFSUOj7PzR+r+wuO8oBzGp30jLWxr
 2hv3hyWP7IHMsIgLkbUSkoabiCeCcw00YJ8pTNRNA03XEUYNPShaFGKncbTJjclO8N02NDuqbbG
 EVBl6Wn92lNxdYi1TseW2pacNmyCH3D+R8WRBF2OFFYKVx/lcV47U6CAT7vh4Oh9sdmiYQKg9+s
 nK5XOLg0lX2/m1gGOePKId5J4Sz18NrsoOXoEUXbeyUJynFaWCg8HwtmA1ZmeiqbEBu/DF1TVVo
 zuOH+2JIHO9gjlZ3jT4dd918nxB+waOmoaThOushOweRJPOs
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Drop manual check of the TMDS char rate in the mode_valid callback. This
check is now being performed by the core.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 1b31fdebe164..b8ccffdf515a 100644
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


