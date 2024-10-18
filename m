Return-Path: <linux-kernel+bounces-372490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FC89A4937
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3CE284A40
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE27190058;
	Fri, 18 Oct 2024 21:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DeUtON0E"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C7718CC05
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729288165; cv=none; b=XWAjZSPfV66Icr9Dfo4yXxS+GYGZO7EyHAwaN7eQfoPaPUM4ceq5O1Y+QZWtn5PQXXgIr9fnSlEuH7ryZdMw8pbgDcRlhBjcXc7KkuyNHxxtsEwI9TCP9HkQw2bPAoUPiYzAz7gZzUsHFJhj5sXCy7HEBCszG+r3FE8iOqz/rlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729288165; c=relaxed/simple;
	bh=XEeB8zSmc5l7zbT8EsjhmWQeibYM5q3N2PhNmNxtKME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QpqWtGWx8MJrWfjUkOt9GT62EsfCsbjhzWPo7Tn4UborVFpQI+lJlmP3mF1yT9x3UizKUIVx3a3MBZe4Hr0lw9RoSntLC5EwU3Yuk/aKbRUkCVzxH9HGEaLnB3P1pGzWhPR0s8zNGhvssLtAUlD+cH24q52TtBk6c5CW8I4cEuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DeUtON0E; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f7606199so3077771e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729288161; x=1729892961; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9z8gZhR6xKvHdHJfRz4craU+dxQh5f6YMki2hXyc4YM=;
        b=DeUtON0EgdAFECGxvmiXBwaURSfnd4pqCy52M9CUwZbK7UKlC5G8XQwtWJYhqh28J1
         N8v600XIjW2ELh2Kd7zfGxGikvPpwLyg9v5efDc/JG8KNFSVR/FEuXB11Ny30VuejE5g
         4KcJy00afbJvJjaVSaQOFuztydWJ29o76V3giH/EZMmd/0oUcelWw9OWvMS6VMho7eWS
         9+UliBzy12sckF+AHyYTXVy4xxraSgzeJqlIkqAdAcw0ThUiWuZ8bM1vqlLYzWTJeqJ7
         HAU+CRRgJLUHxBp3TfjG+7y6UF5X4VOYh69A0vYvifx6R312zP/0Nn6y/mqs6zFpBCdN
         zEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729288161; x=1729892961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9z8gZhR6xKvHdHJfRz4craU+dxQh5f6YMki2hXyc4YM=;
        b=jz1ZDBuECcpHhWf59yMR03o4YeOslXVgHxWdocwxCKYF1lAmdK5boamo9WMJWIwbu3
         vAdZbMEoYyKv2JVBp+1fnVs7QlIwrvH+78Yza+Z8AUC8sKCh0zt0C8AvJMwy+Guq7SN2
         QorIsFvRHI90thgxmsxvvC1JpJrZNjifKT2KVVj2FxKEtCDQocdPLCbYLmQzYez9aM3Q
         nZy+fYbgqo+GtgtUaP4pp9wH+81VoMh284Prvlpu8BiQUIQKshD3LKyhmeiyjW9wBSs/
         GnXTcr+8bueQ6uSaBUAZuPv73LpCY7ztkpEVgy93yF8stsB95YIy48360+UWD6qqnvM1
         yPow==
X-Forwarded-Encrypted: i=1; AJvYcCUi1+lvpucJzpZTP16rwdpWmfULO8q8o2gYsOWBJtQ+c45bu38W6KomExe8ZeGetLxhGfXXXl+Jdt6dLSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRJbusrIlcopGTlp42xDiiu5tXOC779HrY44GdyuPU8AGjWqpD
	6MVa6O2G00yRmq5wiVv1jlacB4nrIWwtXt32qwOgP7mWDq0Gok+gOt/fPjOcmG+RLP6pLRoqtBy
	lL5Y=
X-Google-Smtp-Source: AGHT+IEvBA85x80m9/B/gJoVTav3nM1QjDIWITUKAkImXSQZnUaTDoetNxkyXbVIvGvOnxTTs+hpZQ==
X-Received: by 2002:a05:6512:3a8d:b0:536:7362:5923 with SMTP id 2adb3069b0e04-53a1520b285mr2619592e87.1.1729288161371;
        Fri, 18 Oct 2024 14:49:21 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151f0ce5sm332088e87.181.2024.10.18.14.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:49:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 19 Oct 2024 00:49:12 +0300
Subject: [PATCH 1/6] drm/display: bridge_connector: handle
 ycbcr_420_allowed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-bridge-yuv420-v1-1-d74efac9e4e6@linaro.org>
References: <20241019-bridge-yuv420-v1-0-d74efac9e4e6@linaro.org>
In-Reply-To: <20241019-bridge-yuv420-v1-0-d74efac9e4e6@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2190;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=XEeB8zSmc5l7zbT8EsjhmWQeibYM5q3N2PhNmNxtKME=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnEtfdkI2xvvDyeAfQVDQUi0tdefgLR6vV7buRI
 tI484ScB1+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZxLX3QAKCRCLPIo+Aiko
 1WeWCAClFBFBl2ZmrqDc2fZN2aSCu3RdrzJkvaupwJdyhURATXsaWpT9bGsmOd2MjKTxT0Loq9p
 C8WpoBOLd6UjVr13L7T8l6Sq3H77uEMREgloAxbbLVaW05xKTeFdS/KSTJr5oABdtTDqZzsxg0a
 slmypGrkSSKs3m2pJ/DXM/2yZYvIrGD8OmlpV1P5VSrCKXjNvMsek2LHuHrBDKxtfqjjTxMjDIl
 /ZBvupf/oBQ5XheDg1XSudap4ydX+m2c6+pZUkxgA/53WVDoyKOv5rDrinCM9gnbKDAFnC8Cm6z
 PiycyIZiFvnah4d49hQ0ije+kgj0w9K8xM9FIx6zlu5k5KN6
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Follow the interlace_allowed example and calculate drm_connector's
ycbcr_420_allowed flag as AND of all drm_bridge's ycbcr_420_allowed
flags in a chain. This is one of the gaps between several
bridge-specific connector implementations and drm_bridge_connector.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 6 ++++--
 include/drm/drm_bridge.h                       | 5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 3da5b8bf8259..320c297008aa 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -397,11 +397,11 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	bridge_connector->encoder = encoder;
 
 	/*
-	 * TODO: Handle doublescan_allowed, stereo_allowed and
-	 * ycbcr_420_allowed.
+	 * TODO: Handle doublescan_allowed and stereo_allowed.
 	 */
 	connector = &bridge_connector->base;
 	connector->interlace_allowed = true;
+	connector->ycbcr_420_allowed = true;
 
 	/*
 	 * Initialise connector status handling. First locate the furthest
@@ -414,6 +414,8 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	drm_for_each_bridge_in_chain(encoder, bridge) {
 		if (!bridge->interlace_allowed)
 			connector->interlace_allowed = false;
+		if (!bridge->ycbcr_420_allowed)
+			connector->ycbcr_420_allowed = false;
 
 		if (bridge->ops & DRM_BRIDGE_OP_EDID)
 			bridge_connector->bridge_edid = bridge;
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 75019d16be64..e8d735b7f6a4 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -802,6 +802,11 @@ struct drm_bridge {
 	 * modes.
 	 */
 	bool interlace_allowed;
+	/**
+	 * @ycbcr_420_allowed: Indicate that the bridge can handle YCbCr 420
+	 * output.
+	 */
+	bool ycbcr_420_allowed;
 	/**
 	 * @pre_enable_prev_first: The bridge requires that the prev
 	 * bridge @pre_enable function is called before its @pre_enable,

-- 
2.39.5


