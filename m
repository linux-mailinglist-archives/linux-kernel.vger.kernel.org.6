Return-Path: <linux-kernel+bounces-225939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0342A9137D8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 07:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3460C1C20F82
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 05:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC19C2E62B;
	Sun, 23 Jun 2024 05:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eVrAk7yJ"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC401DFFC
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 05:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719120463; cv=none; b=O488iDoPc8BPxEWS9UcyYLaSJRlCNSeZGEKb44UA42sKmmnOyxjSlu3u8thXd+Im9w71jyAmCxFLyYl10tvXGEHleHi6wxcmY9A02g+EArXoA2hHhzhs1E8yIHj/BNwT31UrpfsTGf2MNiSarz3dZ7U81+iqCND1UL4NDGD5BOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719120463; c=relaxed/simple;
	bh=jAaTSmJr2uiPJgpayy5rEW5crModRwCP351g8zoCUvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HurIf675egd4N+FOfM89m3O9oOM+S6pOR1XPbSsyZoJ2YsCNZzgRSQMOBIYIZyFtYoR/laSjHGHMx1opkEPpQwiLa8pP8g7jb9SpWF6PgouP8TNafhtWPjTCeTRGEFWVDOKWAy+8Ym+c5rJ6slc6HNEvPNDcDF3jtKHlmasEvIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eVrAk7yJ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52cdcd26d61so1344088e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 22:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719120459; x=1719725259; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2saQ5GQqawAS020WhizaGqzYJuR5npRpI77BdgX5gZ4=;
        b=eVrAk7yJOiLkt4J4KJr+l13yWTQVz5alFLbzhibiLFWdWZaehiw2Komn4PIwOc6hly
         8awfdB2P/4fSYd5nkN06jjJGjjIVuqTZEU4SYc12fQ4JTh0xXWNd0FRHPkZkwTudZJud
         5AuLims7Q3HzKvG+9nKiZ8YJFD89UDFyp2PsSoIttYvrT77qT0YHsFfPwmaLdFDNkxiv
         T0kPn6jpR46RYYz1aKvh6Q/Q54+hz8a6/Gw+n5o+vVshbYQzujwIrMSnC7hBl3spgQM0
         g1pd/w4LMnpB7NkWMdrTcg+isxXGeBQJjG0uXH/sv5DeRAZ1Beu7OU0PVpp+Yg7Rphjl
         1IXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719120459; x=1719725259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2saQ5GQqawAS020WhizaGqzYJuR5npRpI77BdgX5gZ4=;
        b=UzZjqM92pb++y1VUqlVnRwu0IArqYL4UPo68bitZtdn2NMYxzz3gnsplwDpQII3Xd6
         oipcW09wx9rW3WILF8c5yRLJyr09ptvUbZUuvX9w6/9QluojA0D5QHld6D1EXJDa8VK7
         AiOrhHComa6jwc3SQQ2IXJGp/ZX7WVr7nRpQILEcZ8fWfZ+HxsL8sSJdlRvCA4TLVKkD
         B2fNarHo46zwiVBcqVrePhfDzGRZ9sKrCMTwIss9OckLUC4hE4JHSEb2HJIfaAzM/8Ca
         ht6i7P/CXdhs2EzYNUCvZ7fuBqWFwTL+E//qCatT9AwLiZqQFwRWU+H/6iwvtAIuFZDu
         2nvg==
X-Forwarded-Encrypted: i=1; AJvYcCW+bu15bxEixBKMZWeEc1R16+GEWe28I/7NEL7AVIGUIR7O2mDEA4yI3GEw/09oKCMVqUnSSaJ5H9Ir82Yhul5lG0Dx9YTMUXnyh8S3
X-Gm-Message-State: AOJu0YweS0Fdwx3MMUsUcrwrxFihQEqKtqJXICl1e2fCh/uuW1bWTD7Z
	VLKfqHwwN6//tSxnmNYpVbkajae7r/CALOr8eyOKyPuckDLNBjhBSx2DYc+bz5E=
X-Google-Smtp-Source: AGHT+IEvS2WjHnwWGl92qbL6wla2qBKHSorPxz8gak6ZS8m1ZorPAlVx9duVX5y/FvHE6ocjI98IJQ==
X-Received: by 2002:ac2:58fa:0:b0:52c:d7d1:7398 with SMTP id 2adb3069b0e04-52ce1834ef3mr598682e87.28.1719120459472;
        Sat, 22 Jun 2024 22:27:39 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd6432006sm657651e87.194.2024.06.22.22.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 22:27:39 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 23 Jun 2024 08:27:36 +0300
Subject: [PATCH 2/2] drm/connector: automatically set immutable flag for
 max_bpc property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-drm-bridge-connector-fix-hdmi-reset-v1-2-41e9894dcdec@linaro.org>
References: <20240623-drm-bridge-connector-fix-hdmi-reset-v1-0-41e9894dcdec@linaro.org>
In-Reply-To: <20240623-drm-bridge-connector-fix-hdmi-reset-v1-0-41e9894dcdec@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=jAaTSmJr2uiPJgpayy5rEW5crModRwCP351g8zoCUvg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmd7JJSqaP9hqJROLabxEuECkMvF5EbVH8tieWJ
 +gvAN4NyfmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZneySQAKCRCLPIo+Aiko
 1eyaB/9cejxrfkEBvLqrLSL5QM8CBqHaFoTUlqQi6hrhvlhVa97iyQTVZTERvScncDTQYcftfyQ
 fKRz4XD8BSrCBWnmNzOrY4/7EJ8mY7mLBf62mlwWtMOybRqWYauFmuWarB09dIzyFaBFl+J1gn6
 CskDp8bTURZEO4DaTp0oQ2cGW+GR5g97CnvsMl+brvps1zhlge9SMoxIIpLVqukMp5xFX1sjTy4
 8zvvLkqy5FKWN8nDNDkmKJhY50v2fKQiKslKHJfAJ/hxXhxCPhlX5oDiuvRKyAOrXeZ75R65bh4
 X7pT14X2i+RurM+o/28x90weuzaTjeKKdvA3UD5PQFrr69W8
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

With the introduction of the HDMI Connector framework the driver might
end up creating the max_bpc property with min = max = 8. IGT insists
that such properties carry the 'immutable' flag. Automatically set the
flag if the driver asks for the max_bpc property with min == max.

Fixes: aadb3e16b8f3 ("drm/connector: hdmi: Add output BPC to the connector state")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_connector.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index ab6ab7ff7ea8..0725ca74dc37 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2610,6 +2610,11 @@ int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
 
 	prop = connector->max_bpc_property;
 	if (!prop) {
+		u32 flags = 0;
+
+		if (min == max)
+			flags |= DRM_MODE_PROP_IMMUTABLE;
+
 		prop = drm_property_create_range(dev, 0, "max bpc", min, max);
 		if (!prop)
 			return -ENOMEM;

-- 
2.39.2


