Return-Path: <linux-kernel+bounces-561091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F86A60D75
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD9F19C60F4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A23A1F1927;
	Fri, 14 Mar 2025 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l6wt+O/6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2911F12FF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945025; cv=none; b=IdrPeqgxAwyB9xzJBfHwcNbsmy3CfXy3HM1gRzbuDycuM0AuBFMvBxCfneEfltsL65h7iPfQsD0fjknZymnfe8HK9nmz8u2jzXPwL1kWiID1V6Ej9s8xnVpQ7uvStDIUy2ZfIZ1Vx3JBwmKQj7HQfMe60BMIRDVFHRTMIPRHht4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945025; c=relaxed/simple;
	bh=sPGFPs8Z9BJzKH3T0QhgjGfhe3qB0nROPdLNLb450jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AL7MCtPwAf7vVFcrpABrEG457wSLCA0I8q221d+tYcPqMkYV5OAl+FcXLnu8qDjj4Xd8smji3uoFXcHNDm77TZelEiKDPpC5Q58a2dup96h6j2sfwFGA/p84Xl/mxJ7DynRyB+6KUiVN6NyTkqvvwiBFvOuD9nQeVG6mz/iOYoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l6wt+O/6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DKDAEq027573
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MfnAPAp+R1qao5Wl5xlx5FtRla2ujtMfiADZ2nfdBAQ=; b=l6wt+O/6JjKNXJv6
	qTfaNcP0eRbf10CjgKQAzzap1lDQ5nUqQBwNRIqKm0kVu/muT9H2+VhjcfXdCR3u
	Jh/IZtx91b5WbKwYAxvY9y7ctYXjsloC/wnqUd0+KtFyyI7uUp6YBKIhNE0BBIw3
	JytDXWbOshqZ+n5bxAzMJUo7Xh2G5x7cXwIJr58bv8lUPQXkRffKCoCUzuHjZMWQ
	p/EOtWmL3nN2XkQLKNWdZHofZlUz9Ly0XNh3yhyv/o/D77/jDyObxeOGV4ledJ9r
	uN1JNwdqTcTtrLoMg7bFYK4iWCBL6FzY/eJcZffc5UjQjEEcd7pDvA0WPEtsmVXi
	iGAaJg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45c6731py1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:37:03 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8f9450b19so42078706d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741945022; x=1742549822;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfnAPAp+R1qao5Wl5xlx5FtRla2ujtMfiADZ2nfdBAQ=;
        b=KBod7F15Waw+s/V8MSoYTmPOarnvM73v2b5z9pSf8wuZfhl/nhwrNfCpBr+bQ+twi3
         xr5cU34RXcvdq/Se65/tuXOrlIoloziFwv5W026CfPG5UHoKkvwbflCrmYmawHfpIrds
         tNw+zU1EKEAIsVjN0T03hdd9KnhF4OAuMwACegTojX0kRyGfn2b/Y+AjqIRDNXwNrCSt
         bQeaX4HfEO0aNKI58UBbCHQASmSON8d15hBPM4PQkWYUNPMJOHXAjCx5g50baEZjVygg
         cCw0rzBWX2HRqPCsGq42tk0lKC3q0e9r9f/lu8CIMrdIqiUW5i94cKfcRSr3XsLFVcsE
         WcjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNZ9azKmtDuuBJ80nrz9FN1yQmRvtB1jVuNb24CsQ5ZF3yNoBReglIo2NBHqajBlFGiACyQuW1XSKvrhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz66bXns0WlntSqduFle8erVF+lpn+nlm1R4qnEQdJUh2ifHH4E
	0ZoRDzv3a0qC7+3cMK2DP4AhweHzJnNPpIwZsgZj8mJpuz+3/AwsEPJcsIdMllDMPMYeVJ8Rn/e
	GuiMLZG8V5emvEa2xUOLIirSfR4WwQpi9YtWOrrcgOCDUJlLO1w8gSG6HbGAG11I=
X-Gm-Gg: ASbGncuzphJtdBUnlLGwUyKxc0Q9Vt6s6BeeQrtVPbIKQxPiCj4K2vhWQfSSfXCHvfP
	rny+rCIE9yaQ9GqcUnuKW3MQUPjyNVLxgx/M3z0TLshu3c3h8x7/PrJjo7L6AyPHUgLmBbdgwfY
	DzIWFpZRVkTl/IJCAZcqx3umWtnc9AmQisduX3zkwrZED2wJR+6BJkk3Kp3j0WqJJQ1/FooPNoh
	R3ugxbljbgSCy+ipntCtUe0J2fGfEFYVHOxoQVNtfV/QrzqJmOodlRZ+CixtmHlLG/MkKGikZhw
	ZMU2/CSFtzAvaJGFE+X32cMS+T7sdf/HteIey9SIMR/OiH1sgl/uG57Ny1NkAVMcwkQMYepr5+s
	8+gpUpYDczlmvzcvd3yw7USNsG3cJ
X-Received: by 2002:a05:6214:4606:b0:6e6:9b86:85d0 with SMTP id 6a1803df08f44-6eaddf047edmr86518846d6.8.1741945021762;
        Fri, 14 Mar 2025 02:37:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9R6JN0FXci6PacWxLW3IijDjh+4/mh8D4VFIDD4anPJXV7iyWYisApZ+3rhQVxcDkVem3Xg==
X-Received: by 2002:a05:6214:4606:b0:6e6:9b86:85d0 with SMTP id 6a1803df08f44-6eaddf047edmr86518726d6.8.1741945021360;
        Fri, 14 Mar 2025 02:37:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a8368sm478585e87.32.2025.03.14.02.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 02:36:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 14 Mar 2025 11:36:49 +0200
Subject: [PATCH v6 2/4] drm/bridge: add function interface for DisplayPort
 audio implementation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-dp-hdmi-audio-v6-2-dbd228fa73d7@oss.qualcomm.com>
References: <20250314-dp-hdmi-audio-v6-0-dbd228fa73d7@oss.qualcomm.com>
In-Reply-To: <20250314-dp-hdmi-audio-v6-0-dbd228fa73d7@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Hermes Wu <Hermes.wu@ite.com.tw>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4882;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=sPGFPs8Z9BJzKH3T0QhgjGfhe3qB0nROPdLNLb450jk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn0/ixcF0KVuK5O3qMfR6zk8CJZvUE1rfBf7MgP
 pa+lkcaIDiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9P4sQAKCRCLPIo+Aiko
 1VicCACT3fkLWM99BgjcdDqMoVZ2qL5iU7A4kGDlUS1EZSsdCxqcqblOHmzmqUNwzLd9RdUp/3h
 lo59QNm+mnNht9pNC4D67dPwm/pcRPGYQhoaiT4BuXb3LYm6GcJ+hF2Zu/IopztZUn0PIVq6bDL
 wwBV4yjwOsyWjXW2eeQYBuZSckBS9VxsI8WWvo4IVE987p+00C1Rzrb5mPG/WeuXtRd+axXAt7e
 0itOGCNXFS96Q+xXEE+7KGP+zt1swUhg9f+oj8xDv+W9MoBrtjY1vXU4ecwMxWj+ln3mUrfwwNM
 50DU1B51imC85WLt7ZfFfpHR/Wg01cv58amOmkvZGODGisPp
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=a5Iw9VSF c=1 sm=1 tr=0 ts=67d3f8bf cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=4Yht-t6EeviOxvws5vEA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 25a3OulJQxtgDCVr5G6609T_do5NrdeT
X-Proofpoint-ORIG-GUID: 25a3OulJQxtgDCVr5G6609T_do5NrdeT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_04,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140075

It is common for the DisplayPort bridges to implement audio support. In
preparation to providing a generic framework for DP audio, add
corresponding interface to struct drm_bridge. As suggested by Maxime
for now this is mostly c&p of the corresponding HDMI audio API.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/drm/drm_bridge.h | 88 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 6 deletions(-)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index c6b66f733fffa77afc875e52f9d1500fcb66400f..e8d0e56bcc91c1f4c689e4e6fbd2aceaf4fc5cf1 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -737,6 +737,65 @@ struct drm_bridge_funcs {
 				      struct drm_bridge *bridge,
 				      bool enable, int direction);
 
+	/**
+	 * @dp_audio_startup:
+	 *
+	 * Called when ASoC starts a DisplayPort audio stream setup.
+	 *
+	 * This callback is optional, it can be implemented by bridges that
+	 * set the @DRM_BRIDGE_OP_DP_AUDIO flag in their &drm_bridge->ops.
+	 *
+	 * Returns:
+	 * 0 on success, a negative error code otherwise
+	 */
+	int (*dp_audio_startup)(struct drm_connector *connector,
+				  struct drm_bridge *bridge);
+
+	/**
+	 * @dp_audio_prepare:
+	 * Configures DisplayPort audio stream. Can be called multiple
+	 * times for each setup.
+	 *
+	 * This callback is optional but it must be implemented by bridges that
+	 * set the @DRM_BRIDGE_OP_DP_AUDIO flag in their &drm_bridge->ops.
+	 *
+	 * Returns:
+	 * 0 on success, a negative error code otherwise
+	 */
+	int (*dp_audio_prepare)(struct drm_connector *connector,
+				  struct drm_bridge *bridge,
+				  struct hdmi_codec_daifmt *fmt,
+				  struct hdmi_codec_params *hparms);
+
+	/**
+	 * @dp_audio_shutdown:
+	 *
+	 * Shut down the DisplayPort audio stream.
+	 *
+	 * This callback is optional but it must be implemented by bridges that
+	 * set the @DRM_BRIDGE_OP_DP_AUDIO flag in their &drm_bridge->ops.
+	 *
+	 * Returns:
+	 * 0 on success, a negative error code otherwise
+	 */
+	void (*dp_audio_shutdown)(struct drm_connector *connector,
+				    struct drm_bridge *bridge);
+
+	/**
+	 * @dp_audio_mute_stream:
+	 *
+	 * Mute/unmute DisplayPort audio stream.
+	 *
+	 * This callback is optional, it can be implemented by bridges that
+	 * set the @DRM_BRIDGE_OP_DP_AUDIO flag in their &drm_bridge->ops.
+	 *
+	 * Returns:
+	 * 0 on success, a negative error code otherwise
+	 */
+	int (*dp_audio_mute_stream)(struct drm_connector *connector,
+				      struct drm_bridge *bridge,
+				      bool enable, int direction);
+
 	/**
 	 * @debugfs_init:
 	 *
@@ -830,9 +889,24 @@ enum drm_bridge_ops {
 	 *
 	 * Note: currently there can be at most one bridge in a chain that sets
 	 * this bit. This is to simplify corresponding glue code in connector
-	 * drivers.
+	 * drivers. Also it is not possible to have a bridge in the chain that
+	 * sets @DRM_BRIDGE_OP_DP_AUDIO if there is a bridge that sets this
+	 * flag.
 	 */
 	DRM_BRIDGE_OP_HDMI_AUDIO = BIT(5),
+	/**
+	 * @DRM_BRIDGE_OP_DP_AUDIO: The bridge provides DisplayPort audio operations.
+	 * Bridges that set this flag must implement the
+	 * &drm_bridge_funcs->dp_audio_prepare and
+	 * &drm_bridge_funcs->dp_audio_shutdown callbacks.
+	 *
+	 * Note: currently there can be at most one bridge in a chain that sets
+	 * this bit. This is to simplify corresponding glue code in connector
+	 * drivers. Also it is not possible to have a bridge in the chain that
+	 * sets @DRM_BRIDGE_OP_HDMI_AUDIO if there is a bridge that sets this
+	 * flag.
+	 */
+	DRM_BRIDGE_OP_DP_AUDIO = BIT(6),
 };
 
 /**
@@ -934,25 +1008,27 @@ struct drm_bridge {
 
 	/**
 	 * @hdmi_audio_dev: device to be used as a parent for the HDMI Codec if
-	 * @DRM_BRIDGE_OP_HDMI_AUDIO is set.
+	 * either of @DRM_BRIDGE_OP_HDMI_AUDIO or @DRM_BRIDGE_OP_DP_AUDIO is set.
 	 */
 	struct device *hdmi_audio_dev;
 
 	/**
 	 * @hdmi_audio_max_i2s_playback_channels: maximum number of playback
-	 * I2S channels for the bridge that sets @DRM_BRIDGE_OP_HDMI_AUDIO.
+	 * I2S channels for the @DRM_BRIDGE_OP_HDMI_AUDIO or
+	 * @DRM_BRIDGE_OP_DP_AUDIO.
 	 */
 	int hdmi_audio_max_i2s_playback_channels;
 
 	/**
 	 * @hdmi_audio_spdif_playback: set if this bridge has S/PDIF playback
-	 * port for @DRM_BRIDGE_OP_HDMI_AUDIO
+	 * port for @DRM_BRIDGE_OP_HDMI_AUDIO or @DRM_BRIDGE_OP_DP_AUDIO.
 	 */
 	unsigned int hdmi_audio_spdif_playback : 1;
 
 	/**
-	 * @hdmi_audio_dai_port: sound DAI port for @DRM_BRIDGE_OP_HDMI_AUDIO,
-	 * -1 if it is not used.
+	 * @hdmi_audio_dai_port: sound DAI port for either of
+	 * @DRM_BRIDGE_OP_HDMI_AUDIO and @DRM_BRIDGE_OP_DP_AUDIO, -1 if it is
+	 * not used.
 	 */
 	int hdmi_audio_dai_port;
 };

-- 
2.39.5


