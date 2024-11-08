Return-Path: <linux-kernel+bounces-400844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 646BA9C1326
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84F8BB22856
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FEB1917D9;
	Fri,  8 Nov 2024 00:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PZPsL2ig"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931615B0F7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 00:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731025328; cv=none; b=DafAa3/QEAcgY0I3emuz4gLTiB9MSyZ9veBkCXBpVBVOggXYD9AU1RoxJ6PlNiaoH/vh4Ow3AUozj3yBLX6umX7IBkZgcBhuJsQZZQQ6M2ZCmSuju5NNO92WgFyTEGRUZ2TI30RSjNldJx4CYuzqBJ+SW6iqYaZ8YBGi//tIcxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731025328; c=relaxed/simple;
	bh=SceYz9X9ESeUh0RpHgvPBbmsjglzf1byNf8UClINDmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a10smxpXi/WpoqzXobWKDZYLNh4TkrVWH7+4NfcSWq7UGmHKUE+59zkHPdkgi9V3a2AQ1Psl1jK1/TObNd997pA10fCfKpOoRgA+sEkRId0q3xGakyXvX7DIPFAn9zC23uoSbCvod3JkTBSQwmkG3aygo2jOVFaf8QsnXpULPPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PZPsL2ig; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb5111747cso16048071fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 16:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731025325; x=1731630125; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+Tcdow0zD4/30pc+/ir8ZwvJBZ3vcNLxhfEFFEtWtc=;
        b=PZPsL2igeVNuzZq2fiv4Kvmd889Lkwg9jH624b47NeEEbjnSAVRqDJ+bbaJ3pv+8HT
         boWfQRfXS0PU5m1VrDWloBTfqwK4/C9z3PccuhQfGol85NKTfpVEzj9iNIVQ6Sjms8uw
         3pUJdiENCyJbLj6OC6vgXbca2B28Rcpi82UOMgKlj0/BP65hpqR8/GTku7klmKBW0Vss
         157Ibgzhv4f15BpSeVsJEHdSuWoQCMIIfCK3Mgcwadg1zegGRNXAoP8qnXPyXTpOlYKg
         HeN4rnZepNoc7NKi6jH4TmCMOOIeUtygFF7rM6E8S9VId+DN9m4I+wdRvqU0+pNJxUrN
         dqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731025325; x=1731630125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+Tcdow0zD4/30pc+/ir8ZwvJBZ3vcNLxhfEFFEtWtc=;
        b=IXOAVCO+ugAli/x28OQGkVYW0/jlG9d8PJ41/WDxKRRfZl2joaaXXEt5p2tOb0zZ4z
         Hy88o7m0p/SkyTNT8kaYwUjhcf8Od//Tlvuct/bKse/tnYMK1q4DtYOYVm2iKO6jkOz0
         z7FVGpgpEfQ4DhhU2wBm8m2hGMIMRbqd/wjO13DWvMRJ/mLf2K2MadUgHqRD3SnRP175
         dQUoCyZXD+jZOIrcuvu+HUMa7LGFOgsNZCJY2LuUYcqKCrTzCNgHlz7Cw1f5ZvXPXjK5
         eo6Z0sGIm+3dumvwnjnbMy1Yl/y/K5H7q8+jJAdTvft/mViCAUHDV6novInHeK348gU8
         WX8w==
X-Forwarded-Encrypted: i=1; AJvYcCVgZmUriQVmzMzdJKJl9h8poIdz96RBnEs4mhFfL4vhI7aa8sLjjXKy/fcCgaqN+DzhxzqfvMXpOCKYsaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf6LF99uV+JWPGuG6uboCkr4ddyAjdZU3FI9QeOlBk0dnlg0mN
	v6IQ/2K5kPzWaRzORzkupDVfZuJS3wP2dnzB7Cu2KzOLdHg2+OSA8wm7vujppj8=
X-Google-Smtp-Source: AGHT+IE5nVLgmECo0GflJVzUjKHDFmESQ9ctk54DBo6OpIxRts4k62fUKMbru4M/1fR8ZKF1aHGjdA==
X-Received: by 2002:a2e:a594:0:b0:2fb:6229:c597 with SMTP id 38308e7fff4ca-2ff201e6df5mr4313761fa.4.1731025325025;
        Thu, 07 Nov 2024 16:22:05 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff17900a63sm4195191fa.47.2024.11.07.16.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 16:22:03 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 08 Nov 2024 02:21:41 +0200
Subject: [PATCH 10/14] drm/msm/dp: drop obsolete audio headers access
 through catalog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-fd-dp-audio-fixup-v1-10-40c8eeb60cf5@linaro.org>
References: <20241108-fd-dp-audio-fixup-v1-0-40c8eeb60cf5@linaro.org>
In-Reply-To: <20241108-fd-dp-audio-fixup-v1-0-40c8eeb60cf5@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paloma Arellano <quic_parellan@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
 Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5661;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=SceYz9X9ESeUh0RpHgvPBbmsjglzf1byNf8UClINDmY=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ7pu5IQkNtPrHV6Lq9fOumDEUPQm/tiq5UcDd0+7/+OXy
 898zkLXTkZjFgZGLgZZMUUWn4KWqTGbksM+7JhaDzOIlQlkCgMXpwBMREOQg6FdwfzTgYVrLDuj
 r23/kObad5lhu1XzRZUMoe0Wvy1LLH6rXau9e6tpK+M0xeU9XZpTz+f1K3pe4Yy8v3EV53efE28
 TDeNFj0r7L12tzjORh7HKqP9TSboFyy2vJQabDI6EnOiuOiEly8Kom6mw67yeI5/2Eh3un3NE64
 y835p7r/mkPC1m4b81mb6ngyS2bgrmeWr4+HXrwk5ntfpkZZadnyTv66v571HkX1Jic/Sf82qfw
 C/OfSaGbQZMB7ayqAhtK7JIktkkLWSc58ckXe0j0BwvGvD3xuaSQ+lKR9597WdOXfBrbex7qS0/
 5EqDL+3OELF+ZnP2/wM/9oA69ovsGb++p/K1rOlMvaUGAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Drop obsolete functions to access audio packet headers. The dp_audio.c
now writes them using msm_dp_write_link() directly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_audio.c   |  2 -
 drivers/gpu/drm/msm/dp/dp_catalog.c | 76 -------------------------------------
 drivers/gpu/drm/msm/dp/dp_catalog.h | 24 ------------
 3 files changed, 102 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index 481fb266fffbec5dd96422f4fb7af8af36acb634..63bdd57948401451426364796e608643c1ebfebe 100644
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
index 9c12484589dc38951a3f1cb4bb33eb9aa5822d87..5071c86fd219cb1c933b32104a396982c5cc8ace 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -62,7 +62,6 @@
 struct msm_dp_catalog_private {
 	struct device *dev;
 	struct drm_device *drm_dev;
-	u32 (*audio_map)[DP_AUDIO_SDP_HEADER_MAX];
 	struct msm_dp_catalog msm_dp_catalog;
 };
 
@@ -300,40 +299,6 @@ struct msm_dp_catalog *msm_dp_catalog_get(struct device *dev)
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
@@ -417,47 +382,6 @@ void msm_dp_catalog_audio_config_sdp(struct msm_dp_catalog *msm_dp_catalog)
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
index 8b63f53e960092666f08b95f556aefe210f4a1e0..24f1cf4ed5150c4e0e80880588641a01bb6a1596 100644
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
 
@@ -151,17 +135,9 @@ u32 msm_dp_catalog_ctrl_read_psr_interrupt_status(struct msm_dp_catalog *msm_dp_
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


