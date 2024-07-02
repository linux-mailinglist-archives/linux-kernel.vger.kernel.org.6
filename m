Return-Path: <linux-kernel+bounces-237538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2E4923A98
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB9D1F2244A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A1115746D;
	Tue,  2 Jul 2024 09:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hv2nYLxc"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517D4153BFA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913739; cv=none; b=M2UnmnfCNey3vqY0U3F1Ewjq5X+CaChpvJ/KgTQTvwB7rqRdhoeo/ehMXXdtfmHKtmfQJjZCERccZuYRql62qbI678C4tDHCYLC+oieyzjLZdErqUZEqtwZgU+ttM+++zL3n4mgWf41uEe2yLdFVVueiW/2oGhA4PkG3q55QgfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913739; c=relaxed/simple;
	bh=Ogj1qgSBFy5LiaMGrph8HSRVcootU6FeEO747BTFj9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=swIs57pgR/yNNsX2XT01UN/jMrIseKpCia/ERZe5UYQo0h1GldJiUUzKUDHI7xlNhgG7aleyQwD97sPwU2LoxVTG0ASQJUJxNoEPyXLGeoaE/AQHCd4URPSDxYFDu6BWqZCedhOAA2YW/1Q6dF9OVcs0gYpDZoRgZ/vxHtclFls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hv2nYLxc; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebe785b234so40264611fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 02:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719913735; x=1720518535; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbJUOmvW24quAtGM4HEWCKTnos6XbtfhPM+nK5+e2Tw=;
        b=hv2nYLxc4etcqSz4FN9ElxiAIDM91aZLvhLqCsNfvA5RlFBfJh5Na/62NdueDpe8pE
         6iA1rzA/ByeHrjgIl++xyFttit+fop7JDVC3L294CRZu03ayAULwdlflOMcsPn9yT3/s
         04NMm0cf3b4gOnl9iozX56KdCxdHqcnomTbmNLUIAV18Y15eQ+aQ+lgk+MiOBzvNgrdz
         hj5+pinDskDa5G1lG500SfrKF9CmZAIgN13yCmlndh58OgbnK8oYNNDIHO3VJekr7RpF
         kMZYQd9Org89UmazfVjAeYcsCu9tHCJzN1qHHlXyYfIxYwyxcPZzXp+E4BaqnCGmuif1
         LuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719913735; x=1720518535;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbJUOmvW24quAtGM4HEWCKTnos6XbtfhPM+nK5+e2Tw=;
        b=nGHXa3w+e8V8S7JuBOuifjuoJoY2VF6RQ7HsaniaMoeQ3LlOqVRUG/QAin8SkrQYGW
         6cqvXxrN8PpGUvBYtWosDsmSW/gS8mPU8y8TtQhER4bPUukfHRiqtHIip2/hSON7aJVU
         Pgjl6GztzQGg/BBBGcHPECvDvWEK3cnFtZO9dceNpzYvg/7AHEwLPDpX4KyP8fBVvwJM
         HKLM4jXm3gvvRUtAKsv06WYhX/GWMlUUGhjFvvEtVxkRgQ54TMAjHAMRiB8tAHxobXOA
         wV0o3rxp1AI+/+aHsrpizkE1CO549cpBTqj+bA1Qnn7kw97U9GCHvc76hCmIPPyDgDvP
         /qZw==
X-Forwarded-Encrypted: i=1; AJvYcCXInEUmTjmR7Lru/iI5CT+W9lXCa46eJZZd4EWm1XyNSU5eSDSt2yZfwz2VSW3oeQM4cRQO3ltYhvndu1/3ezsUeenpVZ0eNK6TLBYd
X-Gm-Message-State: AOJu0Yw3wsQ84ecUZL8WCqMcGeKVryeJuGloMAL2sD5e+bS1sFbCDKaZ
	NjQpgMfQDGOfd31ykam07as3tMaYAMLgogqpKJQFrnukzSrwSqjxqrRPEO0I2a4=
X-Google-Smtp-Source: AGHT+IGfmdHB+8edC65CU37es9H6R49dvRUzRUlXwIzKM7NUfhJMiOkS6U7fLphVNhqcxMt5+DlouQ==
X-Received: by 2002:a2e:b53a:0:b0:2ec:6cbe:5e4c with SMTP id 38308e7fff4ca-2ee5e4c38c3mr48178251fa.26.1719913735592;
        Tue, 02 Jul 2024 02:48:55 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee5160e333sm16231161fa.5.2024.07.02.02.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:48:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 02 Jul 2024 12:48:53 +0300
Subject: [PATCH v3 2/4] drm/connector: automatically set immutable flag for
 max_bpc property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-drm-bridge-connector-fix-hdmi-reset-v3-2-12b0e3124ca4@linaro.org>
References: <20240702-drm-bridge-connector-fix-hdmi-reset-v3-0-12b0e3124ca4@linaro.org>
In-Reply-To: <20240702-drm-bridge-connector-fix-hdmi-reset-v3-0-12b0e3124ca4@linaro.org>
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
 dri-devel@lists.freedesktop.org, igt-dev@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Ogj1qgSBFy5LiaMGrph8HSRVcootU6FeEO747BTFj9E=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmg80FIFlpwZSuAMcVaex64ulawWVazh4lwSquc
 qTrBGjVLnSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZoPNBQAKCRCLPIo+Aiko
 1ZPXB/9JSHXBoeLLdgKIA/GlpIadryusEgR3jFySCJuDELdNN4OuXdoem3dSd9kjIC+JcMsHNNF
 I0fK75E2EybrRE6uduTV2Z7e3+27bJvncgqo+vguR701/L5k7SQ10eqZ4FDg702uh9jSg635tsB
 0sYf7ed+6tCdPoy7PrfIWzke9XSTRvyh6pcqDgJIX3f4cXnKnBJzk5QIrQPnghLIwS38Pw9PXW5
 /F4+fMCjdCYjVO2i4L6ZfF5b9km3s/i6agBdI2/h6nOuaW+mh24ZOOPhQWhPu3olMMXl2W+3RSL
 t/HhQjnpdsmUS7Tbx2PKaDZWepo+M9RjijPg5dCK8NdkCJqE
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


