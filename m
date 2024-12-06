Return-Path: <linux-kernel+bounces-434754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF3D9E6ACE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD221882B34
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E64C1F6676;
	Fri,  6 Dec 2024 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rJnGXru4"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B3A1EF0B5
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478198; cv=none; b=ZJPJbtVl8UDn5LZGWO2lqJGUaJuNlJ+DNRLy+JfBrNBZyj0L27fDBO8t7SgZ9KJ17D/04OWSw5go0siBCHlwZFLjj4R8SDsx4Om2oUwkwpwXtdRkLLxvBer9GH+wmihkMFlgVk3mtkIivefsHsJt/ATp7FP3b0uqEPpO+RopH+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478198; c=relaxed/simple;
	bh=3Q5pbMu5lborNDPG00HVqHDspCjjhjGT9968qr3bz9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XQdkp4lSFV1TQRzmgtnmo0I/CxmmjtN7xOUjSMTBH2z9SSYG5Hr4+AJUgbAzLmoPKbhpobFxvbUePgljWpDteVSr08NTkUA/a6GFBFkZUb2ygSaq/ojP/1vAXHmkbQSq9nnNMixKGJqcQ80861n4++zTPJvE3n4YMW8q4B9m2g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rJnGXru4; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30034ad2ca3so1923271fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733478195; x=1734082995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VnGo6ZNwboubgG4PK3zPxjFnyRb2ICdQLCcJ6lGvxCQ=;
        b=rJnGXru4Xt6zVYnMSteFC3ArKlwnoFlT2IQXXToym4nLhZw5lKKq1nbp/zAJhM7Ll0
         CbpPcRQrdP7fzdUQtdZITBW0NcsLkOFUdMcG/RdOjkU1lzmkm8yb0Sr6//KDsFPwhi9U
         SYfXClWUTMjc6+bHPbKEtTbVRJsBuAo5UkXY02zampKStFBf5XasV0hRGS8s3ZjuLgfv
         etVzTW1tpytyLsPH9iklXPcD5IrlJiDqJc+8OKSszEtJchJQERtLmXykAd6wOuw+D2hC
         b47Jjo9l+ee8C/4rDyto5i2QwYtMdfmiZfXOW3EHs2zQsplxBV6zebByVMiNuzI9BTOp
         1c9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478195; x=1734082995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnGo6ZNwboubgG4PK3zPxjFnyRb2ICdQLCcJ6lGvxCQ=;
        b=de/qbhcyafO2eVhywPptcwYCIlA4O9ayfXmV8txYe7j7ZHwgm3soDc6aCokMMDVa3t
         wxzYOejpHg++c2a0QJG5g5KL+KRUzIOPMoGDgfOjQ07LO3SAPI/z4Yua7+IzaesGVZ5K
         C9RJqsC5KghgNyoXZyHdEhLYw+CUeM1+aQYcIxnuWHpf5hKSZ2XYoiVceUYUrqB294E8
         JWTLt9uyizAoxbnjRrQlQrZTf1WXHSFBpXOJtaOzVX9Qo48jnL9U0b6JFxS8DilH96vA
         e8BumGZGYD0QeHwzcQeaW7nQ2/SBkseAic71IX3K3xiM6JsvEZFLa5nckSXM12prpOeR
         /IrA==
X-Forwarded-Encrypted: i=1; AJvYcCV7HX3HAW03bceguIl14fAGZ09xurZkrxrVNaAiwRL/RREeT7qHn6JN7/0AM3jIRgngcJxNv5IOKE/eWjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOac3qVep0/omICERBgwQUC4lkdGNgK6dfwnPKwpb0AXeiZinh
	0iqsDKKsmfApl5q3RQEBtE5prdPYpAYyymWlqZ0Cq+T3EImoUqzHOZERn5RDtFE=
X-Gm-Gg: ASbGnctGuj1/l/lmFBQ+WkalWN/IgqHBnRW0oLH+7NlPccvxcxpOsh+7dib31vlCkrm
	OJuMurig7HCTQFo1ndrMNpDumk3SBUJEoMJM+UlArGXyqFqOOL64bwMhI6RzzIjeMmnsgoF4TMv
	0vU5cxsEHRfycRkt/4U83RDGGIHTKCP4Ut0bpekNpl9gDFmatSKBqoGkIO7IHBexfhzO0pIVxW0
	cGUoANgWW9quiKjb6lKf5KcWrjJUTHtPgYA7A+fajuuu76O13wrOTfS4A==
X-Google-Smtp-Source: AGHT+IHOfIBmoyEolZXZdyLfUjfRu7LK9x/y6e2NRNb0G1IfVvxWYDXdxw9kGPS8sm9OVNX+a5FRXQ==
X-Received: by 2002:a2e:bea8:0:b0:2ff:df01:2b43 with SMTP id 38308e7fff4ca-3002f8aaef2mr6873121fa.18.1733478194869;
        Fri, 06 Dec 2024 01:43:14 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020db3805sm4128441fa.50.2024.12.06.01.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 01:43:13 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 06 Dec 2024 11:43:04 +0200
Subject: [PATCH v2 01/10] drm/connector: add mutex to protect ELD from
 concurrent access
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-drm-connector-eld-mutex-v2-1-c9bce1ee8bea@linaro.org>
References: <20241206-drm-connector-eld-mutex-v2-0-c9bce1ee8bea@linaro.org>
In-Reply-To: <20241206-drm-connector-eld-mutex-v2-0-c9bce1ee8bea@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3318;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=3Q5pbMu5lborNDPG00HVqHDspCjjhjGT9968qr3bz9k=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnUsctUfPifOTQ8tgTrVr4NDA9HQHo4lV6wGZ/x
 802YkRE+OKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1LHLQAKCRCLPIo+Aiko
 1YTBB/4+LnnhEaD+gppGgLjgyd7DzGULNQMgJ2hoRulbF1tCZiqhH2JwwQgaiFxKaCK13GN72v/
 +MlHzrTYbtF24x6wcNLxIFk87u2wdjCt5dO8xqKiiFF4My86VJebVFFgPQmUXcFvMWkWUS3PByj
 f9McLONHSWPtO0XRW3DbeQ8zzl5cChJhSN8/mkvwrNqq0BkWWOEDxxROis0bi2KSFK0/SBEJ2rN
 X+RhP/l08plhS1bGyEvzzOyAMvtpjSEsEYXf5mCZGGnypfY+YKJQ1VDkpPcX3/Si3R6D3pZ0Vpw
 Wfr3vj5voa6Xeg3e/NqY4k/PPQjahgFQwpQeJMdgalo1w5Zq
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The connector->eld is accessed by the .get_eld() callback. This access
can collide with the drm_edid_to_eld() updating the data at the same
time. Add drm_connector.eld_mutex to protect the data from concurrenct
access. Individual drivers are not updated (to reduce possible issues
while applying the patch), maintainers are to find a best suitable way
to lock that mutex while accessing the ELD data.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_connector.c | 1 +
 drivers/gpu/drm/drm_edid.c      | 6 ++++++
 include/drm/drm_connector.h     | 5 ++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

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
index 855beafb76ffbecf5c08d58e2f54bfb76f30b930..13bc4c290b17d556d654b7cdd8c48c24a32aba9c 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -5605,7 +5605,9 @@ EXPORT_SYMBOL(drm_edid_get_monitor_name);
 
 static void clear_eld(struct drm_connector *connector)
 {
+	mutex_lock(&connector->eld_mutex);
 	memset(connector->eld, 0, sizeof(connector->eld));
+	mutex_unlock(&connector->eld_mutex);
 
 	connector->latency_present[0] = false;
 	connector->latency_present[1] = false;
@@ -5657,6 +5659,8 @@ static void drm_edid_to_eld(struct drm_connector *connector,
 	if (!drm_edid)
 		return;
 
+	mutex_lock(&connector->eld_mutex);
+
 	mnl = get_monitor_name(drm_edid, &eld[DRM_ELD_MONITOR_NAME_STRING]);
 	drm_dbg_kms(connector->dev, "[CONNECTOR:%d:%s] ELD monitor %s\n",
 		    connector->base.id, connector->name,
@@ -5717,6 +5721,8 @@ static void drm_edid_to_eld(struct drm_connector *connector,
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


