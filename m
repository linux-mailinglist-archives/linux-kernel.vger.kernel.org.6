Return-Path: <linux-kernel+bounces-194771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3648D41C8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 01:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA5D7B22DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 23:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4E520010F;
	Wed, 29 May 2024 23:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTLttC16"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA8C1CB328
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717024352; cv=none; b=mektOCiJzNgFjQi+we66BOBjxkAs5j1w7EaA1mpIsop09Yg7GWaaouDKgmSq1KBf9hEzd1RcBSSLJOhNtMRqu4vGHSUtK4MknlCUCIzgznUiqdDaytthz8QYAFrN8vz1y9uk9juVfU10DmsZ5JE/PpPHTN6sxyqyeohbvxbOVNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717024352; c=relaxed/simple;
	bh=AXQkgT8bLCi+J4VLmDhYURPEkLAsLkNbwsYyTx65pa0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mvhZX3jl46NECLQ1VdpEIGEhqvc0vmFiIqlYtJLSdW6AL2CjDUCBiwDusCPElMe6Cqb5UOGfkL5UQbfDeNTb85CHQWT4kNeZw96nSv6JjlPk2Hmw0eCnXvn6HaMY2o1R+g15Ft6osr9oLe4H6WC+9o9OS6sFmsyO7AfsI2WAtG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eTLttC16; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b7b4812f3so238486e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 16:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717024349; x=1717629149; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xsWyvZJ7smsYEwcJt3QXuB4RboSifhUzN4Y/+3fVgYs=;
        b=eTLttC16EBJNdIPG8cKd8aFAxJ9jmVxdKclGbafYQDAaSoMg0NVCqX2mfh44boeNZF
         QUG14PaoC4iiqZh/2IzzdqXvAeQAgHHH8HtZFcuDIhbPwGsUCbQkSXSuvdC66CrL+iiA
         kREjxD8MFngJtK7YLjWmbirZOc0R7XUtwfxoh8utRE1yfFBDnnlWsdN7RsabXg+uN5Xt
         ywjjTj4PG04UQOkUEtgJQ2l90beZRr4L6fK6qIvg22BLK2KmV8rLJ3mOZXDuBS/TxVxx
         80JvYGn5kZIUlIY1jApa4Zj5ee6vJJ9sGKqvcTLfriIphaUmfecIVt+tlKT8kcdsS121
         ABrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717024349; x=1717629149;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsWyvZJ7smsYEwcJt3QXuB4RboSifhUzN4Y/+3fVgYs=;
        b=nZipzdjMNsD8e3nG7mDtJdQ5XMh8Vl/MNwe0wI4tIV4OYWrvZEq0bFqrXv6RzOYleU
         f0Va9e9FVEUH2ZDpj/jG9yWJGSH10PW2FT40C1MCui/e/SPEVsFG2wWpravIP4iEa59d
         C1D/Fbb6BIpMJTKsYE9Xvt9Jk6vs5cjSntuGuYog/Et21x/dA8GGAr2jYTuvMAvB54Qr
         u5DkpDZi6CEQHysIE5EnJrz/cg0f6gGjwgYNrh+9/brtt2db5QEHJVYSSmIoIEhQUW66
         9ZfiVHIQpmshI7Xjky+XdOwvJ0C7YJwYKwiXkn8yCRDwrfDNKhTCYdsFU1/91rjLpZ+S
         ftSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAynsy5Uejn29FXhGLgQUw6rkMXiB/Er1ftg6QbrhKSUwehi1xl+WPOtSZrzQRr81/vvJ8nM86Au1QxrkNjE9QMgV5pvP9tOGX0WHr
X-Gm-Message-State: AOJu0YzCRn8cOcC+SJkvqUQwGeNhPy2XqF/vcic3bGOEqtUaY0d06A7Y
	NdiEXplvm9nrGuOh5AECv9q8vLMx1W/k8lZZM/f0OQ6LN+rEJtPNfBNsLGl/z4g=
X-Google-Smtp-Source: AGHT+IGR2g9tEjUHRz3sWSg0237KZd0prRiZw5CS2OF0JFp0DTVGONPL8fJFqcllAiRPCR5tE1g7iQ==
X-Received: by 2002:ac2:41cb:0:b0:51e:e5cf:9940 with SMTP id 2adb3069b0e04-52b7e0ee8b0mr63089e87.4.1717024348995;
        Wed, 29 May 2024 16:12:28 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529acea1ea8sm1015998e87.276.2024.05.29.16.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 16:12:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 30 May 2024 02:12:24 +0300
Subject: [PATCH v3 1/7] drm/connector: hdmi: accept NULL for Audio
 Infoframe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-bridge-hdmi-connector-v3-1-a1d184d68fe3@linaro.org>
References: <20240530-bridge-hdmi-connector-v3-0-a1d184d68fe3@linaro.org>
In-Reply-To: <20240530-bridge-hdmi-connector-v3-0-a1d184d68fe3@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1693;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=AXQkgT8bLCi+J4VLmDhYURPEkLAsLkNbwsYyTx65pa0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmV7ZadQQ/u477cay7r64S0rsMMdpYg2c8F9bsk
 HP74y9RpWGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZle2WgAKCRCLPIo+Aiko
 1Xz/CACBG8J88iFv44gK5ywM44/nLwAiT0D+h+PopLWugWuGXC0yuvOQ7sSZ/TiE8fpiOzXNghn
 LqQShLj2piBG17rpD08ku2ULumRjKSuGcbAMUkWy7Vr2hEKxIrHv48HEWd4jkWGWw2JtHE1QZR0
 q9ai2atyG3KlWWGVlIEgBSayjXD83ULC38kztI/L6E3YaG7aIITrdW9NfyoSKb0mRuJzLOIwdcj
 K2Q5n8BtQ0jKRJYqInW7Kx4EXVbYwOy160ewSLGEwZBTd0ka7ZcG4UBpIKZt51O2Aq6cpxhN4R7
 U8bkuwdlyNpvpdu4AunLtBCfChGuVdAAJb0UFFgN6lErZjPS
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Allow passing NULL as audio infoframe as a way to disable Audio
Infoframe generation.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index ce96837eea65..5356723d21f5 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -681,7 +681,7 @@ EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_update_infoframes);
 /**
  * drm_atomic_helper_connector_hdmi_update_audio_infoframe - Update the Audio Infoframe
  * @connector: A pointer to the HDMI connector
- * @frame: A pointer to the audio infoframe to write
+ * @frame: A pointer to the audio infoframe to write or NULL to disable sending the frame
  *
  * This function is meant for HDMI connector drivers to update their
  * audio infoframe. It will typically be used in one of the ALSA hooks
@@ -704,10 +704,16 @@ drm_atomic_helper_connector_hdmi_update_audio_infoframe(struct drm_connector *co
 
 	mutex_lock(&connector->hdmi.infoframes.lock);
 
-	memcpy(&infoframe->data, frame, sizeof(infoframe->data));
-	infoframe->set = true;
+	if (frame) {
+		memcpy(&infoframe->data, frame, sizeof(infoframe->data));
+		infoframe->set = true;
+
+		ret = write_infoframe(connector, infoframe);
+	} else {
+		infoframe->set = false;
 
-	ret = write_infoframe(connector, infoframe);
+		ret = clear_infoframe(connector, infoframe);
+	}
 
 	mutex_unlock(&connector->hdmi.infoframes.lock);
 

-- 
2.39.2


