Return-Path: <linux-kernel+bounces-533376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C97DA45946
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813033AB36D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24902459EC;
	Wed, 26 Feb 2025 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bF6KmQEm"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F79238172
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560386; cv=none; b=PB/Uv1cnDMMC1M649lRMo+1lb/Ng7cmoT4vu/H0k2sOVxrz5+rIucxl0/01r+zTj4FJj84BqX8rjf6VmcdVvnRwV4q/Tx0IgsyzAVXUPoJhYHgzc0kLCvbowkIR+asyuDKBGkYKtbTpoUq/FKp8u9+uT/rOh2jpp7oRrVg2Pc7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560386; c=relaxed/simple;
	bh=spKKvIsUEXwYtFbU2ADRWxlKua9ZC3kOdX8BM/6IO2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gxZBQbcF09SPkhPuLOwHbVqJwWBiN8MjXtKP63Bme4E1WlOqTEPRoc+xn1zgA6jLhj+a1LW9pAft8OiSa+uScA3nkclfOyz6/94GNJIZUk6VcqnhWkNwNseP1NDSoGAR2ProbFm5L/J/RddJUNwIgdvHCw66g2ykFnTlHkpRXlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bF6KmQEm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5461cb12e39so6377348e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740560383; x=1741165183; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxAcg2Edh0LLCX/q03x2dqp484sdB8Gfc9kAJ/WMpN4=;
        b=bF6KmQEm6fC8ufMAkCad4UNvibDbEiQgHqcLsIo57g+EV97jpMn+yzyMngi4mao1Tn
         bFo4yioA5IuU8E5e5MR2tNYN7jy62lp4euZurHV5iv/yzB6ItM4JjvWr8oDjwIH0tQ/t
         RwVheWAQphyNPdHSy2usxT50Fo3pr+rH+pLkx2/LERAwsxuZdnPgkPN72qIq3aueQz3t
         ljtSm/wRk9EHPv6tQL7LULaSXKBlLr4o5Wijq0wSixHiX0HoHHMmxppuH4Q7iJjc6gr2
         Eo39L+nwgxk6tE0WfOxIj+Cl7A74CwNs4oraSzc8exg5T9Ndmr/GEZb0YtZh3mihChou
         G9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740560383; x=1741165183;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxAcg2Edh0LLCX/q03x2dqp484sdB8Gfc9kAJ/WMpN4=;
        b=F1pYYKG1mBOCWnsoZZA/xl0ywDkVNuW2Q81Z7soDCAA0/rr1SCvbjChCSwsM2ov1xf
         N+MFBE8s2cOhfXf86dn9mf4p6KfP/+e9Cv9CgHQOLDDkd4XNXd1jngi3r+dHmyZTmElK
         EJiN94IrgXx1Jr253uIayPppJSA/ov7JMMKFOeap7I8CYUzvpynRsc3Jvh2a1RTl7biy
         U3uSzfF2FxHevPlMKrvXb7Rud2s8wIS5fUmKscMgkqiw2UG4Fck8szO3kedqY1EzPlRf
         C820rCYqm/CqRP/J+I4t0cBY3KxscpWMcindaillP7+x8m/5u1XBE4DvLLvEfE5TSbh9
         XCEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwg193Z9GkIRlatEwGJVMt9cwsABQBJL3H1wB2dtXRC+LCdNLvxP1+DcvbhwFCewKI7GBhRRrO5NlqF+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy402/fB06yuo2cKPciv+zkMMANhBaktDKNBCnMGT4EPw7Vb9Bt
	hmpk5pvYDSs/q2T7dw4s9W8cLqIrwtwhqVPgl/OTmbJMMV5P0wtTdgtrhoKN7b4ToSRbMc24Ozi
	ySBo=
X-Gm-Gg: ASbGncsu7h3P0CbmO1JDFev4eSU6pAVNt5sVEI4dE6PLJfWtat1xXshgpfSWcIdfnMP
	Et9HT0AGfoRSs0lq3X3zFpD9FYih/jLcBT05ukYnWlCFFifuj2RX+wrkreTNOomXD2tjzoidhLy
	SSYzaXhL98mXhgSxAoPAZ6/gNmUZGzMnDfUYG++6Jhx5OGsBrCPvTWvJri1JlThfrWFjLcVpj3S
	HL/STCE0mHT2gqDUF5zRYlKrJ2/PwCROZAL7qWGBTE9oSEvf7kUG9N36wyAdG9FkKaoGQ+Ktbbh
	ikQmGHPvr6THWrjrI9+1Tm8KPCD5At4fTg==
X-Google-Smtp-Source: AGHT+IFo+WGQZv/2HHPDxvc16/ldl7ZK79qJBQmkGWyMeSV3pDc9yvGidvBoz4ORQ7EVM5XREMFT6g==
X-Received: by 2002:a05:6512:3b06:b0:545:2e85:c152 with SMTP id 2adb3069b0e04-54838f4c9d8mr11853120e87.34.1740560382489;
        Wed, 26 Feb 2025 00:59:42 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819e0c49sm4556641fa.10.2025.02.26.00.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 00:59:41 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 26 Feb 2025 10:59:29 +0200
Subject: [PATCH v8 6/7] drm/msm/hdmi: also send the SPD and HDMI Vendor
 Specific InfoFrames
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-bridge-hdmi-connector-v8-6-340af24b35cc@linaro.org>
References: <20250226-bridge-hdmi-connector-v8-0-340af24b35cc@linaro.org>
In-Reply-To: <20250226-bridge-hdmi-connector-v8-0-340af24b35cc@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4777;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=spKKvIsUEXwYtFbU2ADRWxlKua9ZC3kOdX8BM/6IO2g=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnvtftXifKCqVrCyjGdTISkAmAEKpl+UusHqw7J
 liRrBG3F8KJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ77X7QAKCRCLPIo+Aiko
 1YE5CACuM/zNqvGkIJ71dxbuQhP4b4ogbNqVS6jh+xo6Is38O6E90kX3zS3FVweT5SqnmJXy//0
 H0vvA5pf5YVLDM+M4m6bRTLA7XJs1eNrN9/Qw3kPoxKeR80jn8nPvECyVME3UvD47OgUjSI/3zQ
 O3RbWP6zs8/nLA6PoYyc9UvXBaDEl7qkO9Oxvmo/7paHsP2HBcdYaTUF22+x6UqC6njkPEk4oxB
 ngmCOCf16/J92GxV1qxo80XsECIruO037m+iIl6LdeL6vhKygL1AO+68VH4pgsD2hAvNqYQALTY
 uFPXleqUNTS28xjOs7Iu6tvODgjah7n6ZA5i7XX8F+ZNcqm5
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Extend the driver to send SPD and HDMI Vendor Specific InfoFrames.

While the HDMI block has special block to send HVS InfoFrame, use
GENERIC0 block instead. VENSPEC_INFO registers pack frame data in a way
that requires manual repacking in the driver, while GENERIC0 doesn't
have such format requirements. The msm-4.4 kernel uses GENERIC0 to send
HDR InfoFrame which we do not at this point anyway.

Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 93 ++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 15ab0858105328c2f774ec1f79423614bbbaeb41..aee75eee3d4244cd95e44df46d65b8e3e53de735 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -69,6 +69,8 @@ static void power_off(struct drm_bridge *bridge)
 }
 
 #define AVI_IFRAME_LINE_NUMBER 1
+#define SPD_IFRAME_LINE_NUMBER 1
+#define VENSPEC_IFRAME_LINE_NUMBER 3
 
 static int msm_hdmi_config_avi_infoframe(struct hdmi *hdmi,
 					 const u8 *buffer, size_t len)
@@ -142,6 +144,74 @@ static int msm_hdmi_config_audio_infoframe(struct hdmi *hdmi,
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
@@ -176,6 +246,25 @@ static int msm_hdmi_bridge_clear_infoframe(struct drm_bridge *bridge,
 
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
@@ -197,6 +286,10 @@ static int msm_hdmi_bridge_write_infoframe(struct drm_bridge *bridge,
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
2.39.5


