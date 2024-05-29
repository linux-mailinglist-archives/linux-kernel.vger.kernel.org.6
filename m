Return-Path: <linux-kernel+bounces-194777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B9C8D41DB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 01:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486AD1C2184D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 23:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42388205E21;
	Wed, 29 May 2024 23:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JMN6kA3B"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A12201249
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 23:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717024357; cv=none; b=UhS9KgZWMHrA6j3p9AZFx+2zovfhvPuRVeIzUjksnCFgR6Q0EtXLwfDRb92eabfIbIxEUqIvkWy7udoxMaXKHlKnB/76NvP2qbgZiePZ0rpeW24Zho0gtRecIq2/9aEEZYZsLCkagCjE805As3gN7+VGFrdRETEleQX1zrGle8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717024357; c=relaxed/simple;
	bh=Z5HyGMj9APefRaxEDeEqqLA87VR+HciRAWGWfJZW4lA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PPbpYxIS3r1v6YccLtXckh4HclxGOi4MlSxN+2HVKGwJtuvzkibWU++3NnNdd8THhz1xAcTYPZVFahYhCSrnyxuW30GTcWBx7bcc+iuFW0Ipo/7xN39QOFUix+w5MJ1J+Yw+GuYSBKH4lKBOp3APkqJhLB83Pe9wqY4IwUcaM6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JMN6kA3B; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52b7db60003so187634e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 16:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717024353; x=1717629153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFqvSl6cE0JuDyfinWPR+ZylqDnid+FJwqA2hwQ4DFs=;
        b=JMN6kA3BkTDVs237aEzTlLVxVkQTbw0GEgHjmHJ+zc51nX9iYLPnpkdwBt0d+nr1Uh
         g+fXNDLR7tJIzRBs62Lak3Y5cHsuayqplihuiDthqGUT4tymibt6zjCW9JvHFkqBY9u6
         vSMkCoDcAaQ0O1ZVuvLnAqtDq/3fxSbgvmxHxOT4972b3YhWHYIlltMHyqEWoSorblpX
         k8DkloYoseKnAsKE6K5lS3Rzk3+xVUmkxWSXjO5MiqHO9UumAqnqGg0McgDLiFtEGqOY
         RO8kjuha4TNnXMYuSVhmtths3R81xPm7eblhF2c2bm4ENAoGhzDCN5lTFMT/PCWKsDil
         ZgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717024353; x=1717629153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFqvSl6cE0JuDyfinWPR+ZylqDnid+FJwqA2hwQ4DFs=;
        b=qfHGBF+UnWTdkH8ebFKJYi1hWWGgtICnnSypZA1Dk9AJpJRzm4RTBMotNUf4pBYsZQ
         Sc5eWpWQ2Lk2Ex9ivwMakQK2KvBTVXeUMo+ByRt6puAqKfon8MHgvUK8P57urdkWQ7Qq
         q6H5xVIprbc3zo3KEgyvOK+3UZhFYb3lIQVs7k7xenBaSwjFfit7gmpt4PhWAyHmob46
         ENEk7ciUveYdwFVLTrt3UH+Msno6LbflRIA1dy7p0KgbxTAUKPZqgXNKS8G03G6r/99E
         8QFmdssrF4yX5mCE3BV8mdTf0TiB9uoeA9OblIBlb653gNaKVECkr4prSD+yF/e1BwAN
         82sA==
X-Forwarded-Encrypted: i=1; AJvYcCVgbWZjbdlkDgqh+gO3nv8SB5T7PjokC+YpeKGxHn3LvguebZygrQMQrkDKspJJvwoNJg48F7OXb+F+0WNxClc+vJiq8dMQHZKkdEVi
X-Gm-Message-State: AOJu0YxA4n06wn1TjL3fsBEDu5QO+8/LSWzh16HePIupXIb6oc2S96fi
	Gq/HCH5tDScr/ONNP06PO29oyYUVWnG7Pd5wSydmJEUHF2tOQm+wOMiA/gEfFUs=
X-Google-Smtp-Source: AGHT+IH5aSmqRPHTo0UG4pFiS1vT4kt8zwVM8HO6DfMchsgJu7PBKOyLEVj19RbkGTT+ov5bBXm3cw==
X-Received: by 2002:a19:385d:0:b0:521:5583:483c with SMTP id 2adb3069b0e04-52b7d47b180mr447915e87.54.1717024353584;
        Wed, 29 May 2024 16:12:33 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529acea1ea8sm1015998e87.276.2024.05.29.16.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 16:12:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 30 May 2024 02:12:30 +0300
Subject: [PATCH v3 7/7] drm/msm/hdmi: also send the SPD and HDMI Vendor
 Specific InfoFrames
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-bridge-hdmi-connector-v3-7-a1d184d68fe3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4619;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Z5HyGMj9APefRaxEDeEqqLA87VR+HciRAWGWfJZW4lA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmV7ZbguFTt1zdbaP9jCvDU93XbT8eFn6tgB+64
 z4kMhW8bLaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZle2WwAKCRCLPIo+Aiko
 1dliCACmfXMljuWZIQ03AWDZ1a4riEFfzm+g0Xjhm5z9o3MlwfKxyL2QeVqwBICP6qmAXm2wT5+
 ukY13FkUjQ02/v4vIaNSgu7JEKWeAiVTs+AXi13Q18Ljv/huxC9V7KEFih9KFx5nXDfXbCFmY/0
 3QvSBWLm9NPzhevt5V4C0GYEkdzqESeoDLDA3md0SimJaMYwIlQn8NDUyxG6IRJBwTaWv7N1ss7
 vr1q8PSDJrxx1JaB8lJEQoHbdveFXF0UvesUZMZ49pli7oguoqsXhIQJmstjBtEcA6N+IP3H7YS
 Q6nOyGKyQP1McDlZFU+5SWx/OJH9P6GRe7eMa5guwdgw2vKC
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Extend the driver to send SPD and HDMI Vendor Specific InfoFrames.

While the HDMI block has special block to send HVS InfoFrame, use
GENERIC0 block instead. VENSPEC_INFO registers pack frame data in a way
that requires manual repacking in the driver, while GENERIC0 doesn't
have such format requirements. The msm-4.4 kernel uses GENERIC0 to send
HDR InfoFrame which we do not at this point anyway.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 93 ++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 3ac63edbf5bb..79ce3b6d1222 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -68,6 +68,8 @@ static void power_off(struct drm_bridge *bridge)
 }
 
 #define AVI_IFRAME_LINE_NUMBER 1
+#define SPD_IFRAME_LINE_NUMBER 1
+#define VENSPEC_IFRAME_LINE_NUMBER 3
 
 static int msm_hdmi_config_avi_infoframe(struct hdmi *hdmi,
 					 const u8 *buffer, size_t len)
@@ -141,6 +143,74 @@ static int msm_hdmi_config_audio_infoframe(struct hdmi *hdmi,
 	return 0;
 }
 
+static int msm_hdmi_config_spd_infoframe(struct hdmi *hdmi,
+					 const u8 *buffer, size_t len)
+{
+	u32 buf[7] = {};
+	u32 val;
+	int i;
+
+	if (len != HDMI_INFOFRAME_SIZE(SPD) || len - 3 > sizeof(buf)) {
+		DRM_DEV_ERROR(&hdmi->pdev->dev,
+			"failed to configure SPD infoframe\n");
+		return -EINVAL;
+	}
+
+	/* checksum gets written together with the body of the frame */
+	hdmi_write(hdmi, REG_HDMI_GENERIC1_HDR,
+		   buffer[0] |
+		   buffer[1] << 8 |
+		   buffer[2] << 16);
+
+	memcpy(buf, &buffer[3], len - 3);
+
+	for (i = 0; i < ARRAY_SIZE(buf); i++)
+		hdmi_write(hdmi, REG_HDMI_GENERIC1(i), buf[i]);
+
+	val = hdmi_read(hdmi, REG_HDMI_GEN_PKT_CTRL);
+	val |= HDMI_GEN_PKT_CTRL_GENERIC1_SEND |
+		 HDMI_GEN_PKT_CTRL_GENERIC1_CONT |
+		 HDMI_GEN_PKT_CTRL_GENERIC1_LINE(SPD_IFRAME_LINE_NUMBER);
+	hdmi_write(hdmi, REG_HDMI_GEN_PKT_CTRL, val);
+
+	return 0;
+}
+
+static int msm_hdmi_config_hdmi_infoframe(struct hdmi *hdmi,
+					  const u8 *buffer, size_t len)
+{
+	u32 buf[7] = {};
+	u32 val;
+	int i;
+
+	if (len < HDMI_INFOFRAME_HEADER_SIZE + HDMI_VENDOR_INFOFRAME_SIZE ||
+	    len - 3 > sizeof(buf)) {
+		DRM_DEV_ERROR(&hdmi->pdev->dev,
+			"failed to configure HDMI infoframe\n");
+		return -EINVAL;
+	}
+
+	/* checksum gets written together with the body of the frame */
+	hdmi_write(hdmi, REG_HDMI_GENERIC0_HDR,
+		   buffer[0] |
+		   buffer[1] << 8 |
+		   buffer[2] << 16);
+
+	memcpy(buf, &buffer[3], len - 3);
+
+	for (i = 0; i < ARRAY_SIZE(buf); i++)
+		hdmi_write(hdmi, REG_HDMI_GENERIC0(i), buf[i]);
+
+	val = hdmi_read(hdmi, REG_HDMI_GEN_PKT_CTRL);
+	val |= HDMI_GEN_PKT_CTRL_GENERIC0_SEND |
+		 HDMI_GEN_PKT_CTRL_GENERIC0_CONT |
+		 HDMI_GEN_PKT_CTRL_GENERIC0_UPDATE |
+		 HDMI_GEN_PKT_CTRL_GENERIC0_LINE(VENSPEC_IFRAME_LINE_NUMBER);
+	hdmi_write(hdmi, REG_HDMI_GEN_PKT_CTRL, val);
+
+	return 0;
+}
+
 static int msm_hdmi_bridge_clear_infoframe(struct drm_bridge *bridge,
 					   enum hdmi_infoframe_type type)
 {
@@ -175,6 +245,25 @@ static int msm_hdmi_bridge_clear_infoframe(struct drm_bridge *bridge,
 
 		break;
 
+	case HDMI_INFOFRAME_TYPE_SPD:
+		val = hdmi_read(hdmi, REG_HDMI_GEN_PKT_CTRL);
+		val &= ~(HDMI_GEN_PKT_CTRL_GENERIC1_SEND |
+			 HDMI_GEN_PKT_CTRL_GENERIC1_CONT |
+			 HDMI_GEN_PKT_CTRL_GENERIC1_LINE__MASK);
+		hdmi_write(hdmi, REG_HDMI_GEN_PKT_CTRL, val);
+
+		break;
+
+	case HDMI_INFOFRAME_TYPE_VENDOR:
+		val = hdmi_read(hdmi, REG_HDMI_GEN_PKT_CTRL);
+		val &= ~(HDMI_GEN_PKT_CTRL_GENERIC0_SEND |
+			 HDMI_GEN_PKT_CTRL_GENERIC0_CONT |
+			 HDMI_GEN_PKT_CTRL_GENERIC0_UPDATE |
+			 HDMI_GEN_PKT_CTRL_GENERIC0_LINE__MASK);
+		hdmi_write(hdmi, REG_HDMI_GEN_PKT_CTRL, val);
+
+		break;
+
 	default:
 		drm_dbg_driver(hdmi_bridge->base.dev, "Unsupported infoframe type %x\n", type);
 	}
@@ -196,6 +285,10 @@ static int msm_hdmi_bridge_write_infoframe(struct drm_bridge *bridge,
 		return msm_hdmi_config_avi_infoframe(hdmi, buffer, len);
 	case HDMI_INFOFRAME_TYPE_AUDIO:
 		return msm_hdmi_config_audio_infoframe(hdmi, buffer, len);
+	case HDMI_INFOFRAME_TYPE_SPD:
+		return msm_hdmi_config_spd_infoframe(hdmi, buffer, len);
+	case HDMI_INFOFRAME_TYPE_VENDOR:
+		return msm_hdmi_config_hdmi_infoframe(hdmi, buffer, len);
 	default:
 		drm_dbg_driver(hdmi_bridge->base.dev, "Unsupported infoframe type %x\n", type);
 		return 0;

-- 
2.39.2


