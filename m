Return-Path: <linux-kernel+bounces-442384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 482279EDC1A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2408C1618E9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD89200114;
	Wed, 11 Dec 2024 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y0fypTEO"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506901FCFF7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960536; cv=none; b=G+xLoPZiNx4DHwS1se5TFASenUh8o/pnzwT7U2m5t4HdFIojAJXtyvBt8GsaMQBBGajJO9y7U0vkHcywvB8E1ocQeOjHNpoTqzyPu5U93NY/r2aUbE0PKgG7C+9A3A2NVDlSvbleBkffmSVMWjXw6zfswjtHYPMtDhSJiKvfQGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960536; c=relaxed/simple;
	bh=07bzKTzskIVI/q9n2mCU9Sl5yWHixeA9E75gnkk3cpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ALgnZyXiYMAL0pm9B7Xki66j2v/f+VA4KvsiZZGu5CFjxBoRIPxZN9bauEWFk2Ft4fbo5w4x+HK5t1oC7RhwdXNz83jxwUx3A4qTumJslNcctH7DTCDS2r12Z1FJfoeAe3UJppQX1Fl5I+c+pD+JNlYRut6CGcc8TdyAriaEoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y0fypTEO; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30219437e63so12841321fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733960532; x=1734565332; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rqZk3Tq5fCD5CxCGxjQunAPcXw7TlzumxBBq+M+xg8w=;
        b=y0fypTEOMFEGZhTRLAQME3FAxJ6f5uuZCzxtEcCp1ohWC3VVqIJ46XiOCW5fS1mJC9
         whZ3TNSYKy5av6J1gAzMfeXW5yMV+qjPa/AmKwoRAcOkcjF6J7ssqWevm/uWPrOtZGE8
         whpHXDlT0DXFwGtyfixoVjfS8E7efcefc2LgZ+pzhXeUISPf2KDWujOVEZuQS2Nwsj5D
         oxsKeWkITrQBizYNgIhmTbAjOnS3BMAD8DeI4gm4r5AnxYob2Xi8In8WIjZY3QLXartU
         5/KzwLh7SsOQUiZpBvl9/cy64gOJJguxxCpN6WCGrULWrXC7R0lUlc6jphnxf8/wcrK2
         r2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733960532; x=1734565332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqZk3Tq5fCD5CxCGxjQunAPcXw7TlzumxBBq+M+xg8w=;
        b=P4rtOUtjhUMFzMNOglYsZJWxSur78GFiygpHxdpX5wY5f32ESKDeH7YPM0+L2EqIqL
         2eNVocDw6Q4Gnn1c27j1vhGMUbNYdOaq/tDONdG0FB8e/lXdoDikvYVkuyPyd6tbcpLx
         OvD+EZgTbRW7Bry9+sL9ic0tQnu1z2Ry9Nb54e6cEH6RfoNRKppmalqYxImxWFuH5kQt
         6tkcszZEFPALHMER2iDt/aZ1rAnmVV8mnHZzQ2nfQXUZ9e8C456tknLly9g4WrxyCCzC
         hvGkf9xTi/ZJmZVxKiFDwLKfvPxp/KoTTbWXxxQMgQ4Oe7rYzYKqPH6WBEq8crpfaHON
         LY2A==
X-Forwarded-Encrypted: i=1; AJvYcCWBzeTfpmacj5NSLxFrsRJtZSmYPXY7Ra/PtBcos9uHKe+PFsdpnWnaaZl4PCg+lOU0fIDQO3X7ctn31lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE4JTnORp0yNHreeZvWgoi9gxf9J3NoZga+BAE4zmbj1NV7Stz
	4Ozh5dj+4+XspeXlrfVVxM1wegnL/QkRxQNmbJoHmBL4nrq1EDnWFSV7iCS6ito=
X-Gm-Gg: ASbGnct3iPi9F+79mPsNdxOnHJW87/gIYk4EzZiMoQ2f335lkLLGBm4MXXpvqc1xjH9
	urXyItnU1HfoGgRqVPf8lR2wjnnbcLegaIiNx7SRejFo/l7PJ7WOmeG7f1KZa/pq3FNlFsHuOzc
	SblcOTzCVZn+Vy4g8DRLJSsaSydEi+fYnOcPbUTTmyRe3jzs3rNvuv9qZwUO1xSuczEeIWWQfIO
	L+8ZN9JEJ2hFOPjTWXyJLxCceJUysTmJgwelM7I5lSdPNvvquypIodJfie9Hg==
X-Google-Smtp-Source: AGHT+IHQJxXVg7oUqoCxrKBCYDWSNziSaeipgx0uMcv1PGhRvvElpMAwOp78E97VVfBYsHxBPRArdQ==
X-Received: by 2002:a05:6512:4010:b0:53d:f769:14cb with SMTP id 2adb3069b0e04-5402f96473emr325964e87.9.1733960532528;
        Wed, 11 Dec 2024 15:42:12 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401cc76909sm1222207e87.58.2024.12.11.15.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 15:42:11 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 12 Dec 2024 01:41:45 +0200
Subject: [PATCH v3 10/14] drm/msm/dp: drop obsolete audio headers access
 through catalog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-fd-dp-audio-fixup-v3-10-0b1c65e7dba3@linaro.org>
References: <20241212-fd-dp-audio-fixup-v3-0-0b1c65e7dba3@linaro.org>
In-Reply-To: <20241212-fd-dp-audio-fixup-v3-0-0b1c65e7dba3@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paloma Arellano <quic_parellan@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
 Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5710;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=07bzKTzskIVI/q9n2mCU9Sl5yWHixeA9E75gnkk3cpk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnWiM55LP5AjgeqKTF4Cp1FK2osYOe0MoctlG7i
 C+LwG6UROKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1ojOQAKCRCLPIo+Aiko
 1ffwCACd3VFpro7OROy5FLGRbgVRuEnWjFc8Gd+7MWbyyhww4noXWXKpIxYiheUZ/hw4ZR1NvBF
 +WZAYlNocT+w2WaB9V42xPU3cIdig5stuMKNureZdruReM/hO8z252KB4TQcwrdkV/y8m4GLfqw
 39bvyTAIx1sZgg7r7/Gi0n9H6yflJZ02HjIvTkmizdiNDD1TgM43CkSBroVfsNGdf8Fvi9sY6BT
 PvMnOfgh7GPMky1FLRwES9Ys7/eE/WNN4U5167PZe6GkEvvfdcK799CmeTUpmi8wGP986SWNBlj
 /zdYiu8D8qhDX3dt5neMOcMP2QMH/fx1T8YwZVyqGddwGX+F
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Drop obsolete functions to access audio packet headers. The dp_audio.c
now writes them using msm_dp_write_link() directly.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_audio.c   |  2 -
 drivers/gpu/drm/msm/dp/dp_catalog.c | 76 -------------------------------------
 drivers/gpu/drm/msm/dp/dp_catalog.h | 24 ------------
 3 files changed, 102 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index 1aa52d5cc08684a49102e45ed6e40ac2b13497c7..24b62faa875437e184895c6d03df19884ebb1fd6 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -405,8 +405,6 @@ struct msm_dp_audio *msm_dp_audio_get(struct platform_device *pdev,
 
 	msm_dp_audio = &audio->msm_dp_audio;
 
-	msm_dp_catalog_audio_init(catalog);
-
 	return msm_dp_audio;
 error:
 	return ERR_PTR(rc);
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index 91c580b1ee312595f3cca886c61ec570069eff03..c1c30da001ed881e1524370be9082d959bdd8bc7 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -62,7 +62,6 @@
 struct msm_dp_catalog_private {
 	struct device *dev;
 	struct drm_device *drm_dev;
-	u32 (*audio_map)[DP_AUDIO_SDP_HEADER_MAX];
 	struct msm_dp_catalog msm_dp_catalog;
 };
 
@@ -304,40 +303,6 @@ struct msm_dp_catalog *msm_dp_catalog_get(struct device *dev)
 	return &catalog->msm_dp_catalog;
 }
 
-u32 msm_dp_catalog_audio_get_header(struct msm_dp_catalog *msm_dp_catalog,
-				enum msm_dp_catalog_audio_sdp_type sdp,
-				enum msm_dp_catalog_audio_header_type header)
-{
-	struct msm_dp_catalog_private *catalog;
-	u32 (*sdp_map)[DP_AUDIO_SDP_HEADER_MAX];
-
-	catalog = container_of(msm_dp_catalog,
-		struct msm_dp_catalog_private, msm_dp_catalog);
-
-	sdp_map = catalog->audio_map;
-
-	return msm_dp_read_link(msm_dp_catalog, sdp_map[sdp][header]);
-}
-
-void msm_dp_catalog_audio_set_header(struct msm_dp_catalog *msm_dp_catalog,
-				 enum msm_dp_catalog_audio_sdp_type sdp,
-				 enum msm_dp_catalog_audio_header_type header,
-				 u32 data)
-{
-	struct msm_dp_catalog_private *catalog;
-	u32 (*sdp_map)[DP_AUDIO_SDP_HEADER_MAX];
-
-	if (!msm_dp_catalog)
-		return;
-
-	catalog = container_of(msm_dp_catalog,
-		struct msm_dp_catalog_private, msm_dp_catalog);
-
-	sdp_map = catalog->audio_map;
-
-	msm_dp_write_link(msm_dp_catalog, sdp_map[sdp][header], data);
-}
-
 void msm_dp_catalog_audio_config_acr(struct msm_dp_catalog *msm_dp_catalog, u32 select)
 {
 	struct msm_dp_catalog_private *catalog;
@@ -421,47 +386,6 @@ void msm_dp_catalog_audio_config_sdp(struct msm_dp_catalog *msm_dp_catalog)
 	msm_dp_write_link(msm_dp_catalog, MMSS_DP_SDP_CFG2, sdp_cfg2);
 }
 
-void msm_dp_catalog_audio_init(struct msm_dp_catalog *msm_dp_catalog)
-{
-	struct msm_dp_catalog_private *catalog;
-
-	static u32 sdp_map[][DP_AUDIO_SDP_HEADER_MAX] = {
-		{
-			MMSS_DP_AUDIO_STREAM_0,
-			MMSS_DP_AUDIO_STREAM_1,
-			MMSS_DP_AUDIO_STREAM_1,
-		},
-		{
-			MMSS_DP_AUDIO_TIMESTAMP_0,
-			MMSS_DP_AUDIO_TIMESTAMP_1,
-			MMSS_DP_AUDIO_TIMESTAMP_1,
-		},
-		{
-			MMSS_DP_AUDIO_INFOFRAME_0,
-			MMSS_DP_AUDIO_INFOFRAME_1,
-			MMSS_DP_AUDIO_INFOFRAME_1,
-		},
-		{
-			MMSS_DP_AUDIO_COPYMANAGEMENT_0,
-			MMSS_DP_AUDIO_COPYMANAGEMENT_1,
-			MMSS_DP_AUDIO_COPYMANAGEMENT_1,
-		},
-		{
-			MMSS_DP_AUDIO_ISRC_0,
-			MMSS_DP_AUDIO_ISRC_1,
-			MMSS_DP_AUDIO_ISRC_1,
-		},
-	};
-
-	if (!msm_dp_catalog)
-		return;
-
-	catalog = container_of(msm_dp_catalog,
-		struct msm_dp_catalog_private, msm_dp_catalog);
-
-	catalog->audio_map = sdp_map;
-}
-
 void msm_dp_catalog_audio_sfe_level(struct msm_dp_catalog *msm_dp_catalog, u32 safe_to_exit_level)
 {
 	struct msm_dp_catalog_private *catalog;
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
index 8dcc029d87315d5777c9c48c0df403be8dd447ce..5ac89a11a503e2abae9f4cc4740b18f2f3b6da5e 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.h
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
@@ -31,22 +31,6 @@
 #define DP_HW_VERSION_1_0	0x10000000
 #define DP_HW_VERSION_1_2	0x10020000
 
-enum msm_dp_catalog_audio_sdp_type {
-	DP_AUDIO_SDP_STREAM,
-	DP_AUDIO_SDP_TIMESTAMP,
-	DP_AUDIO_SDP_INFOFRAME,
-	DP_AUDIO_SDP_COPYMANAGEMENT,
-	DP_AUDIO_SDP_ISRC,
-	DP_AUDIO_SDP_MAX,
-};
-
-enum msm_dp_catalog_audio_header_type {
-	DP_AUDIO_SDP_HEADER_1,
-	DP_AUDIO_SDP_HEADER_2,
-	DP_AUDIO_SDP_HEADER_3,
-	DP_AUDIO_SDP_HEADER_MAX,
-};
-
 struct msm_dp_catalog {
 	bool wide_bus_en;
 
@@ -147,17 +131,9 @@ u32 msm_dp_catalog_ctrl_read_psr_interrupt_status(struct msm_dp_catalog *msm_dp_
 struct msm_dp_catalog *msm_dp_catalog_get(struct device *dev);
 
 /* DP Audio APIs */
-u32 msm_dp_catalog_audio_get_header(struct msm_dp_catalog *msm_dp_catalog,
-				enum msm_dp_catalog_audio_sdp_type sdp,
-				enum msm_dp_catalog_audio_header_type header);
-void msm_dp_catalog_audio_set_header(struct msm_dp_catalog *msm_dp_catalog,
-				 enum msm_dp_catalog_audio_sdp_type sdp,
-				 enum msm_dp_catalog_audio_header_type header,
-				 u32 data);
 void msm_dp_catalog_audio_config_acr(struct msm_dp_catalog *catalog, u32 select);
 void msm_dp_catalog_audio_enable(struct msm_dp_catalog *catalog, bool enable);
 void msm_dp_catalog_audio_config_sdp(struct msm_dp_catalog *catalog);
-void msm_dp_catalog_audio_init(struct msm_dp_catalog *catalog);
 void msm_dp_catalog_audio_sfe_level(struct msm_dp_catalog *catalog, u32 safe_to_exit_level);
 
 #endif /* _DP_CATALOG_H_ */

-- 
2.39.5


