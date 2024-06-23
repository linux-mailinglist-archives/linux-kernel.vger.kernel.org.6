Return-Path: <linux-kernel+bounces-225942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CE49137F1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 07:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE28283B75
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 05:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A80B2BCFF;
	Sun, 23 Jun 2024 05:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ch+vl/ba"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B4B16419
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 05:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719121223; cv=none; b=eeQB0uSxajYfRW6gZ5CDdRxXBHI6dhcGKr9UcmyFo+GLGLPIWHAm5xsIAh/E0Mx8e3hIZbCguHdPwso9TdSJqTX5YGBG1KlPJ9SKWNWT9yt6MjR1YU9Walj2D7sJwn2Zlu1zf/DDjMteQuI/rFb5GeaADoqJXmMy5GukREkg3eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719121223; c=relaxed/simple;
	bh=Ogj1qgSBFy5LiaMGrph8HSRVcootU6FeEO747BTFj9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YjrgKO6BDwULS9+iDsN0N/ZzxFeKijayWTcNRbEJDud2PdZ+LVz6fmCFHo3rhQRNOR/9uoz/CPhfdZa4X9nIyO0uBfTfvobS1HQPi3KeSUPCk0goqJxCTUYB5b9SaFkBs0x0wWlHkXEJZXkHGSY7VF72mvvW0VKsJ9JAqYlgkr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ch+vl/ba; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ce0140416so641657e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 22:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719121220; x=1719726020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbJUOmvW24quAtGM4HEWCKTnos6XbtfhPM+nK5+e2Tw=;
        b=Ch+vl/baHE7qh8a1FrDSVMd7BPF6WvPa2cVJGz7Ei6loeoGLd76Z9nrkFrUxDOisuB
         K+pUEIp1WZiDYqXSUHeq5uRGut297Es9ylz9YEaeJ60SOLbCcv9uxs8ftaJq0rOPG6Kl
         D4pQJtMiyzqTnB6sV+VhNOD7Zxqu6efyc8SUXtsxvjnE3MK0NtmebjATBKwAYQHqAGUP
         Cas5Z9tyL7ohHZzehWqjQZ4xY3Oc+/TSuP47FHHTS/H8IzGQ8YL6EZR8K0Qz3h6TQgjv
         vUzNRHkBOUuBv+nhTCARq47FMvryhUDHIBe/aFGzOsL1qUhrEvwR1ltEcioG2J/dvlg1
         kBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719121220; x=1719726020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbJUOmvW24quAtGM4HEWCKTnos6XbtfhPM+nK5+e2Tw=;
        b=uYGu8F2VMs9kIKYHZ0+KAOKSgfbu/uDiJDdZDVLJzTVU/VsHbsYR1b4ybmAuPZw4iK
         oEuGtiIQ1IVhZXPdONjpT6U2VW2YNEUeXd3/p6itSvKi2FCKaKiCOA4D1kz1zP0fbW9T
         Go+fsFkaycxuZysQJJ0zE+7D+xNIDMfYdD0Hk9D6D1q/8POMY0YxENltEMA2IgDNBjvq
         mwdRsxGNeHMr7jO/KY1GE3wMDRpuvYvTYp88+U+r9psPFef60pL1JIyzewUobG2j1MyN
         jO+PAxMw4eheYzeuMZNcYjHTFKIsB0K9wGOdDmXWiP+cUEG5IBMI/0GNB3SoZ9fs30yv
         aWxw==
X-Forwarded-Encrypted: i=1; AJvYcCWINMGJkSEpdnud/NQSWRIV1GIee7c9GJpghKFGZph6Yt9dsfTyG+0G1+HkbLCYtirJ9l5/ckes/4imZU7mA5V2c/Sg6H/qTuoMWWuv
X-Gm-Message-State: AOJu0YySLMtNGP6OOsWB24FnCE9X17ZFFY7U2M25KVMwv2pNN6G96RMk
	dN9/nuWmEfZINxSDkPIF1UAAweop+TeGjg+nOPNhxyHey5Wg4iOBFJckzkyEsHI=
X-Google-Smtp-Source: AGHT+IFhjib/1suTVLnNKOG4CvpqSohWo8V1ebgg4ZYt51DXitjlM8EQ+GXNkC1wy0zWx1GrQbZ0kA==
X-Received: by 2002:a05:6512:348c:b0:52c:86d7:fa62 with SMTP id 2adb3069b0e04-52ce061b1femr1263685e87.23.1719121220118;
        Sat, 22 Jun 2024 22:40:20 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63bcd32sm659696e87.65.2024.06.22.22.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 22:40:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 23 Jun 2024 08:40:13 +0300
Subject: [PATCH v2 2/2] drm/connector: automatically set immutable flag for
 max_bpc property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-2-8590d44912ce@linaro.org>
References: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-0-8590d44912ce@linaro.org>
In-Reply-To: <20240623-drm-bridge-connector-fix-hdmi-reset-v2-0-8590d44912ce@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Ogj1qgSBFy5LiaMGrph8HSRVcootU6FeEO747BTFj9E=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmd7VC9k3OnQtTnxxxl8WBd8EP07ZwSvEfxe83x
 9mlVUBtvXWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZne1QgAKCRCLPIo+Aiko
 1ZulB/9VGOjTN5uHSczSZCl5LY1tDsEZ8ElrPoAzIIMyxJpYuHzDj1DEP2L3SeTXmv3wCOuwzTc
 6bNUkw9AdXzeLJ/IGR/Xk+V/XA9lDA5rBPuJkdSCdWaHur06DeHT8KOxFv7G0NLTl6T5MU7yptb
 wQGBL+gk8cC92DjyVWJdKinJm5xjogNa/2cR8nHAa2PjDuQVFDRfgLs9rWbq4srehFPnwVIxIUa
 oxspq1UPaQ+j1MCtZHSzIdBfaVt8ZCP+d7c8ygH59JccJ/3jw1oACd1hGJMXkpneuj7uqb5DblK
 9wKM9mnJISq4t243XjfYVTg4SbCN4fWKN4q+6IxUytONLpQj
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

With the introduction of the HDMI Connector framework the driver might
end up creating the max_bpc property with min = max = 8. IGT insists
that such properties carry the 'immutable' flag. Automatically set the
flag if the driver asks for the max_bpc property with min == max.

Fixes: aadb3e16b8f3 ("drm/connector: hdmi: Add output BPC to the connector state")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_connector.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index ab6ab7ff7ea8..33847fd63628 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2610,7 +2610,12 @@ int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
 
 	prop = connector->max_bpc_property;
 	if (!prop) {
-		prop = drm_property_create_range(dev, 0, "max bpc", min, max);
+		u32 flags = 0;
+
+		if (min == max)
+			flags |= DRM_MODE_PROP_IMMUTABLE;
+
+		prop = drm_property_create_range(dev, flags, "max bpc", min, max);
 		if (!prop)
 			return -ENOMEM;
 

-- 
2.39.2


