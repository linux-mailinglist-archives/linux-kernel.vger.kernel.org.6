Return-Path: <linux-kernel+bounces-426494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF2A9DF3FB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 00:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7709162C29
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 23:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B62F1AC885;
	Sat, 30 Nov 2024 23:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDVTHunB"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05C8170A3D
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 23:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733010935; cv=none; b=p/DPM8TA6m7EeM2bb/m51/lmNmDzE9QFnHA5lt2kus9DeaxJhEWBQ6yHqkpd5jO+PfpNYR1LDGKJ0yGRpudj3M+lG4p71KNlA5MsfqBrGcX8ZaSolGCTaUFF39Wu4Cxnu+RLFbrfhdmx35bDTFEbTyN7a6+eRVcjgyaxRyDu2Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733010935; c=relaxed/simple;
	bh=dRMlgzQ8g4adZeqAK73JToeVmDq3hWsW88+VTTxsaX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qjtJ0XgQTaYmxaoj1yhswkwpQ1NFyiHINVWxG5/DevfP6EZFkclxvzp96tE9ULkX9bgt7X3VLkfNlxIHs6AOVuy7c3mq2bNJPn7cOOZRxMmY2iJyz/2+PiHP3OsRWpONMTZMfJ7RXQ8z73INBwzbKK3JHCkD6FSYxH5Nv7mt8W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CDVTHunB; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffdbc0c103so42653681fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 15:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733010932; x=1733615732; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVandmEjl29fQ2g5/xmh15AXnmnKHqPEzmZef3xU4Eo=;
        b=CDVTHunBCPPrAxZ1PHckG2p7iP3W/FpG6WmRrUjMYf/vmuO1gacvWAB36uqlHwHZTT
         n8Qvi0AQeINk68Us41WGMOABI6ILNtwRdxkfJbdl5zOa8ZsxRynmZBMd6AjCl6nfgF8j
         ZJ6h01fewPCkrPYGjGPU6YrKOpn3Xjo9UGGcoYmVHgy7heIK6QgCtjvp7sMWczwNAWTp
         xWtd1vp3EsV1cPbt2zO/iKuCVU1+TygeJuxGSNrcgYJQfo2w9n7OQLMg8CLWTNPhH6rU
         Y8Z0w7U6/Ld4hy1WU0W0cNCepRpb30N/sRUQwrcdPj0DZMHpX8foqFtXKe1lYrsMlq4g
         vjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733010932; x=1733615732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVandmEjl29fQ2g5/xmh15AXnmnKHqPEzmZef3xU4Eo=;
        b=r7x1xgnxk4rZixMlUVlIIbAdTfRnvMMukzfX73V8o75W7nhqhVUytZyXl5HGJW6iZb
         vh1CPFIpkZ8n3I/xaUFhuGq8P+O4DLage9o90JMcmeCrALPuzniZTn6Bq8k9/RRSbgtv
         g/qNR4nJeZ+EOl6DrUNfHq53+agXeJKlXUyzBuBIvmgsC9rcq3QExIDbSN4LmyYDG3/t
         wVxh8yojmiffwIfECpi0OyIobJDde/a2kccRnmqjwhEQdprlAkhb4cYqyvr+NuBsEFbn
         94gcp2lsLwqy8T1AXfHQOLrShB8j5fDxM87OCN7oZsVud9xGu8Cx0jSdTNBsAFzUYMfz
         yptg==
X-Forwarded-Encrypted: i=1; AJvYcCUh1G896yfqLUuFP2rqHlU54KuYVzz6qqcAjsd6a5u3yeDrA/M9M0KVadd4bMrPvEo8qfqHCirVB8k8fqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh9F7/ziMpTDnR8twfZRGcjZSJVX+zR35cN5ImGCUccXTvLDMK
	7E/ItEKwnXSw76gqCk08M5lgA1nXcGr5VBnD7raUzf9VIrvrjC8DpzWRejuSdYs=
X-Gm-Gg: ASbGncuFA3EDKXq+cx14tdBvM8eHnPbS9YdJzZ3KiRqD177ufUpE9DqtF0cfuAjWevw
	n0F+i+jhemBQw/KVCOaQiwvd0jS6h4CIosmgFS+7Pmmu2zPi4icNkDNJlMP6uCyTz/dubq5xw6L
	96r2TtlVs98Db0lFmNknH7lWRjm6h9Y51gX3ytLPlSrtYBCIJo8PcAKX5NHysQe06hXX/XlLIqu
	OeoBCsQ+eFWZSJ8SoPhjuL4+jPqeAmqJH8cyKIoY5qyBiq7botJMRl/AQ==
X-Google-Smtp-Source: AGHT+IFxIGZTCl2+FV0phQXK3nZn1ZVOLyIwEd2xBNXTWsJOfxd6ufDjErhJ/Bt/Wlo7yiHe3hXNJg==
X-Received: by 2002:a05:6512:2316:b0:53d:dc3c:2595 with SMTP id 2adb3069b0e04-53df010b113mr13994153e87.44.1733010931778;
        Sat, 30 Nov 2024 15:55:31 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df649647dsm900706e87.195.2024.11.30.15.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 15:55:30 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 01 Dec 2024 01:55:18 +0200
Subject: [PATCH 01/10] drm/connector: add mutex to protect ELD from
 concurrent access
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241201-drm-connector-eld-mutex-v1-1-ba56a6545c03@linaro.org>
References: <20241201-drm-connector-eld-mutex-v1-0-ba56a6545c03@linaro.org>
In-Reply-To: <20241201-drm-connector-eld-mutex-v1-0-ba56a6545c03@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Phong LE <ple@baylibre.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2918;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=dRMlgzQ8g4adZeqAK73JToeVmDq3hWsW88+VTTxsaX4=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ7r30refv/TKFDs8Y2WIFPVQT4z9p9Ztb63x/CrnBwOpu
 9X8J3Z0MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAiMjXs/4xDs4XudBZPNPqn
 kCpyM6RdQOWzeLBy8ZPpGxftDLy97qNmD6N3i6urZu4ODovJnRfad3DHVKg/ur1et6Vl+2EZu0e
 yxsFXpq526Q8JCdBwub7SsPv3+VQt9zlV4VNuM1ZNmV8c+7DodCpXyU7/vuWHrAQTr0qLTuNJfi
 7+yf7LHPf/M7MW/7y1/o8Gc8MR93DzonOcBczZHvd3Lw7grt9wxPWA+kK1QFnfw27Ndcwznj48a
 nBgd8lz5tieNl+W3a6z98Q22chfUj3lPm/rWpttiy+c9vhvfVDCs6/vap3TuncOXcc5NpTp6qxe
 uz/kevSCnWG2aS7lyg2/S68xCj6sOHHJgUnIzND4q0scAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The connector->eld is accessed by the .get_eld() callback. This access
can collide with the drm_edid_to_eld() updating the data at the same
time. Add drm_connector.eld_mutex to protect the data from concurrenct
access. Individual drivers are not updated (to reduce possible issues
while applying the patch), maintainers are to find a best suitable way
to lock that mutex while accessing the ELD data.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_connector.c | 1 +
 drivers/gpu/drm/drm_edid.c      | 4 ++++
 include/drm/drm_connector.h     | 5 ++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index fc35f47e2849ed6786d6223ac9c69e1c359fc648..bbdaaf7022b62d84594a29f1b60144920903a99a 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -277,6 +277,7 @@ static int __drm_connector_init(struct drm_device *dev,
 	INIT_LIST_HEAD(&connector->probed_modes);
 	INIT_LIST_HEAD(&connector->modes);
 	mutex_init(&connector->mutex);
+	mutex_init(&connector->eld_mutex);
 	mutex_init(&connector->edid_override_mutex);
 	mutex_init(&connector->hdmi.infoframes.lock);
 	connector->edid_blob_ptr = NULL;
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 855beafb76ffbecf5c08d58e2f54bfb76f30b930..f0ca77bd42fd518d505d0db78557e0c8d83efb29 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -5657,6 +5657,8 @@ static void drm_edid_to_eld(struct drm_connector *connector,
 	if (!drm_edid)
 		return;
 
+	mutex_lock(&connector->eld_mutex);
+
 	mnl = get_monitor_name(drm_edid, &eld[DRM_ELD_MONITOR_NAME_STRING]);
 	drm_dbg_kms(connector->dev, "[CONNECTOR:%d:%s] ELD monitor %s\n",
 		    connector->base.id, connector->name,
@@ -5717,6 +5719,8 @@ static void drm_edid_to_eld(struct drm_connector *connector,
 	drm_dbg_kms(connector->dev, "[CONNECTOR:%d:%s] ELD size %d, SAD count %d\n",
 		    connector->base.id, connector->name,
 		    drm_eld_size(eld), total_sad_count);
+
+	mutex_unlock(&connector->eld_mutex);
 }
 
 static int _drm_edid_to_sad(const struct drm_edid *drm_edid,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index e3fa43291f449d70f3b92a00985336c4f2237bc6..1e2b25e204cb523d61d30f5409faa059bf2b86eb 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2001,8 +2001,11 @@ struct drm_connector {
 	struct drm_encoder *encoder;
 
 #define MAX_ELD_BYTES	128
-	/** @eld: EDID-like data, if present */
+	/** @eld: EDID-like data, if present, protected by @eld_mutex */
 	uint8_t eld[MAX_ELD_BYTES];
+	/** @eld_mutex: protection for concurrenct access to @eld */
+	struct mutex eld_mutex;
+
 	/** @latency_present: AV delay info from ELD, if found */
 	bool latency_present[2];
 	/**

-- 
2.39.5


