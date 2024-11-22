Return-Path: <linux-kernel+bounces-417997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5CC9D5BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93C39B245D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D6F1DE4C5;
	Fri, 22 Nov 2024 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z1vEwtbm"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C2A1DE2BE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732266806; cv=none; b=LjzY3XHmiZ22lgThhXsv7sV78MFifL8NCOxMJE6Zd2mHxwhoNaEq3d2vRPPy7DnFIewXVEDI86Ij5h0ET+I0ZSe4DMEJWUwmeFj9T58OW1VhgIe/R6WyIm2l1VryXsScd6jgvB6IoXXWGUtJfBdV6vxGN32UruUkaNsWuOW5Pyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732266806; c=relaxed/simple;
	bh=7WdeDK9PVMnPHS0xN6wrfKPJv4ESCzGwmvZnGPcMZ/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pD16vQTueI7bhmRb5q3N6fRaSPime1nbOusPvE6/3ABDPgCCCumbsT3OmVJkmPrrbPKBJD5JFIQHpfiCT97JUzv4IQlVIdsxr0c2y7ISjCi8tUcYMdTeZ3xqmZ7+9NTE7wBZF+5vVTUDdwzUM94mAjKzEhg1nU4GYQHSEOTgVJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z1vEwtbm; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f6e1f756so2050846e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732266802; x=1732871602; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YdWiUnW6vTgN40+31xk3R74ZtFvE1HPhsssihDLePE8=;
        b=Z1vEwtbmmyO4/8F0W598beXFxaLScGHwPW15cV7iQTGOB2NZMxelL5d1dqbG6sdu1j
         0tmzzPNx7RfxMsAVkIynn10b8n9cKUVhs7/stYQcIrCiwRpX4hiteENO9qBdq+X9bbD2
         xyQLFzmy0dmkt7mWado5KKXaGUOYWAUn8J7PyR1fg97RwoWA422dIKNlNuiocos3KTQ3
         mStvOjXb1vM+zLOMp40wZyrTIo1NslCcNSoGn+0tim0dblCLy8S84Ya8AmzVqj0gIU2c
         2T+GkJh0gDud72cXtsiR9wLFg69N9m+FLLSlapI1VPsIVnHO+H5qJ/2CmGmVt8dKTk4u
         8FFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732266802; x=1732871602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdWiUnW6vTgN40+31xk3R74ZtFvE1HPhsssihDLePE8=;
        b=BiUcA/REU5dQDEP+zDep7ynjRtOqo5OyWMcwfYWw5cP1sNgejSFGW8gY9q45PoB/rF
         XH4EtvkQPeYVBAETKML66T5ncXi86GprDGvVHsjmrVq2bM7fnJNiVet7e2dhEQLMALw4
         UryPNHEpHzwEvNWY6oZgDsWCBKn1cB66S+gx0iG8EKStp4fV0OJu7xQ0eqJVaC+hKrQw
         mjorYPXv84kYw2KZLP4P5lTi7yn5BFI6GJoAQ9sZxRbXCd6XD+HUdxgr4YqseWKU8wtc
         9u+ESCcWeL6Kh0jgGs3PoYBjvI3VurfIlOXkjlrX6QQXaX6LO3M2BoQUU9xQu8U7lr2B
         8koA==
X-Forwarded-Encrypted: i=1; AJvYcCWQR0Kw4BFjlReqNQS435LMoyXoozlFqGwCF3rNI0ZkElW0jXodQ5GvtJb/ZDGPDpZlSGz8PIGO6Vh4I/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9hqgQqYvCN+g8Wa/w3XuKB1wnU7DHxZX7YxWT4OMsJcjwZ/ZF
	9YQf+1LKYamJ6O84dC4d+Wsp+cRLYm1gcg94bTR/mcVSuTR5Kx3fe/ODXUl8z+ibrZJ8KVW6Gf5
	y
X-Gm-Gg: ASbGncv84UypRrfFEXaCb4A4RrLhu2FxPhLQoQawXMy+QP/BOaPVIqBijbuTiiqV9vy
	zvrkRbsIZ3runoUH5K1+HkpAH9MT3dNx1cVDtfMW5H3yOfMV2BXWEG5fNhwe5hbJ35Cx+aKpapj
	oHBOa9EfobDKYNmkQ75cCFjaFWM+De8IFoT2+YOSSXAxo0wHE2gS9kie5q9LkYxa2Zqet83GNXK
	uFOLeLd/gaXc2xGwJY1G3ghNlu/gs0Vn2mjGtGaacuMhT+2FaGK1ofv3Q==
X-Google-Smtp-Source: AGHT+IGGtUj/UQVAqhj71L/+WsqH4TByvBEbJYS9Kr4E80g55FT15j0av7rsnKtHopezihZc5TlJsg==
X-Received: by 2002:a05:6512:114f:b0:53d:d5be:4bda with SMTP id 2adb3069b0e04-53dd5be4be0mr678315e87.17.1732266802045;
        Fri, 22 Nov 2024 01:13:22 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2451386sm299530e87.77.2024.11.22.01.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:13:20 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 22 Nov 2024 11:13:01 +0200
Subject: [PATCH v4 05/10] drm/sun4i: use drm_hdmi_connector_mode_valid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-hdmi-mode-valid-v4-5-2fee4a83ab79@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=7WdeDK9PVMnPHS0xN6wrfKPJv4ESCzGwmvZnGPcMZ/4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnQEshvg15KlERBUKq4lR2p/TSqtj5mXXjddQL8
 zndDKhDnu6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0BLIQAKCRCLPIo+Aiko
 1UswB/oDlMjmP0dYXrp0SYxKvIUkgl6MY851PyW708IlMOZOJbH5lo0GCNkGsMmCV16kq0l1ais
 KIus1wfQ1xA0lwo8KtUJJeX6gPpLRN0nWs5AbJm2S53M1m+XwFjW11vOEZYe5BEyvuq6cTNrqOf
 SP5rwIdTIFJYNqC/T/oVX3emjSYFRHp0mS6piDuxv9io3UFM5M9xGCDSP9ZsYwVCe0uwtI7lOx4
 VwYEaqqRz+m3DbfRHe6M2eQAtAMGgLCsyo+Rom/69e0SKJkKkWncfEMwKQez9slaQ8GeIXaA4E9
 KsJ/lbh1VelTpjfb+9nV77MboAKh3hm26Msd2x+zXcDXq7U0
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use new drm_hdmi_connector_mode_valid() helper instead of a
module-specific copy.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index b3649449de3026784ae2f3466906403a0b6e3b47..54b72fe220afacc208b3fd48d5160031127ea14a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -205,16 +205,6 @@ static int sun4i_hdmi_connector_atomic_check(struct drm_connector *connector,
 	return 0;
 }
 
-static enum drm_mode_status
-sun4i_hdmi_connector_mode_valid(struct drm_connector *connector,
-				struct drm_display_mode *mode)
-{
-	unsigned long long rate = drm_hdmi_compute_mode_clock(mode, 8,
-							      HDMI_COLORSPACE_RGB);
-
-	return sun4i_hdmi_connector_clock_valid(connector, mode, rate);
-}
-
 static int sun4i_hdmi_get_modes(struct drm_connector *connector)
 {
 	struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
@@ -269,7 +259,7 @@ static const struct drm_connector_hdmi_funcs sun4i_hdmi_hdmi_connector_funcs = {
 
 static const struct drm_connector_helper_funcs sun4i_hdmi_connector_helper_funcs = {
 	.atomic_check	= sun4i_hdmi_connector_atomic_check,
-	.mode_valid	= sun4i_hdmi_connector_mode_valid,
+	.mode_valid	= drm_hdmi_connector_mode_valid,
 	.get_modes	= sun4i_hdmi_get_modes,
 };
 

-- 
2.39.5


