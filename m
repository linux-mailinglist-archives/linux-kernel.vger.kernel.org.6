Return-Path: <linux-kernel+bounces-427225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E65B9DFE55
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D863280F28
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E52200B9B;
	Mon,  2 Dec 2024 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Er3MrYMN"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEC61FF5F9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134028; cv=none; b=axAgGQ+bebE96HKvDnquDiKogIFmC5xZhuoIYafPIdWH6xiBiBM9wzeDCghpUTqszOcOd/paESSXwPecQ0qGGCgTg0ADGeQG3KEQJo93lSzuD7cbmQkQ4F18uXZbXmc52cpI+rjJMKCjBPqituEGf2Dh0hQiJbtxUXgFJ3ppQY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134028; c=relaxed/simple;
	bh=Qf+U2MCFAOfe9NVZx8RRUA1o8N6bH6Ds8FzvUs6RCUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bfxlqp3suKKfydAEw+K2QmwHuWL1SSAVVnvb8kiVCmpVNJn0m8Qu0XdQullX3dHMVEx/F4kh/ivgjLk7qVzhaPOzJ7BHUkhzzj3LokbfxJiBorsD2nwrVGkBiFDWSGMBjyxUZPVaclKxUXmeVDPgUGUAm7esw8YwWQk3ouQjmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Er3MrYMN; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53dde5262fdso4464863e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 02:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733134024; x=1733738824; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKNyFL0LYH7UQJUWnI3jk3IChb96zF8xUShk22XqH8c=;
        b=Er3MrYMNjTSxEuhOHtwi67zwRC4ROe9gibtKVvxklUIYfX+vwFebbhLdF01D+ErurD
         r0eTwAZKciIkUlc7oyVjrDPTcWm2O/AI9O6B+1W3EZz9gBS5My1qNxwM7uIhO79Xx5RZ
         c7nSv1JRGNICQP05rAWc21Q9u6fLEIaA2TJGkZiVrTdNboM9A1ghPhbukU81IeKfw94Z
         hyR/PjTw2oSZAqrKNZFPMgNXcY2tZGSa9CpIV9buyfttzO8tEjllCjmSv800U//+EI+E
         oxSKlyeNyYnU4F/+mMgQwpY2U5E1I2aj7PW23RFMrXTQuIlAhd0v2/a48QJDpoQIUXWC
         suZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733134024; x=1733738824;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKNyFL0LYH7UQJUWnI3jk3IChb96zF8xUShk22XqH8c=;
        b=Rf06ht8JfwhRaC+4R3pvbxM27PVB6sfPW6H+8fj2QYsp1wrxbICRfNWNu6rkwU7lAY
         HrcFFRahie3iF+SkSUH5CtTZAaBEoqP+I810HZ+DsFVNmx1sRNM98oPz9BnvQrNVlvlg
         uo0r5xYarrv8v88FhoYf/SAfvromOBeBo2UMiwJvzKzBP+tbIH6Ug9D61FfJn+NFDbED
         /tnBKJBV8wRStICdo7jTcMz02yAQOQkBOrOjnhmbhGwm+MfFOfNI3bH9Faa8GvUqlrGj
         T6x+3Mb9vweG7r09jNScoEjXPiH0fmvTRkI4vCEzNNcv5goGVqewYrfijdE0qZVH5yiL
         jumQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ4k9WZyC4uth+wflLcTj9U7rGqICezrmDQ/fZXMfGoQK6CFWJ7gzqO6wxyY2jvRyFjEAqWNTFXBiiaWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRLNBEJvlU0OBKeSchLiQwWMbVIAw4QP/0qvLTw0VvAxwfTn2z
	TFs5haCmSLbVHAy3PhRB2wjD0GTEuur/fPJtdUhuWJr2VNFbppaTYZ2z2Hl9cGs=
X-Gm-Gg: ASbGncsOI7KVl3zO7J0iL+YHcUFBPPIXQORKtY0H0MvmWPK/hWlvQszw/updznUrgPm
	H5ThF+7JkGWgBnfJfKkNYn1P2rzYURQ4xSzOjGXFBc5A6Ly9ue3xAts1NUNv9UAaxbqbwhWXSWn
	ukrgZSflW6vXjs8tGuPQKHFOSGVPSd2rLBHnWZCPDx92TbwzKBG7zbKKUZtkm0huWKbFVLOz4hF
	6wk3VrMFkVhThgQQKhlEuglFVaKvglNdOqIz1PY5zrg2m+Dj9ngskzSSg==
X-Google-Smtp-Source: AGHT+IFUzXwupEjKjU3G5yBaWyfHTGKtmXT7ev29CB7NgYeiwwZcsa9Kn2KHTgjALswyWqYfSVF0Gw==
X-Received: by 2002:a05:6512:2210:b0:53d:ed6c:26ea with SMTP id 2adb3069b0e04-53df00c79a2mr10484287e87.8.1733134024465;
        Mon, 02 Dec 2024 02:07:04 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f191sm1418314e87.136.2024.12.02.02.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 02:07:03 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 02 Dec 2024 12:06:41 +0200
Subject: [PATCH v2 11/14] drm/msm/dp: move/inline audio related functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-fd-dp-audio-fixup-v2-11-d9187ea96dad@linaro.org>
References: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org>
In-Reply-To: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8606;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Qf+U2MCFAOfe9NVZx8RRUA1o8N6bH6Ds8FzvUs6RCUg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnTYau74U7FMwosjZf4iS1PGhEMm8FzF+3MlHrK
 CRW2InSjRiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ02GrgAKCRCLPIo+Aiko
 1V0VB/0RlCk+Jzo5mU+A87yLmCJakYeWiPoKRfLdCu1eBrR0li7c9kZqGRAMnYSDqXJx44/MDTa
 FlF9sD+cEG3OEOc8/nxtRdSDpwjuVJJapO0zet1TRc25U6LDPQPzBmd1ArUBUAqh+EsrELfzuZG
 QcUzGrYOExgLnYAh0OspY6/gbz29X5yNpNTD/D+eywlULwmCNXAYHpPo46LP1cAfWp+G9goknqh
 11l7I6fKBPeBPChXx4jGcHjm5P1zbZwdUd6TXF/OwW5SuKEBWnAIkCh+/p+9udV+OUNz8NvtvF9
 j1DNO/MJM0EtTd36yQ2xzvBbun4iC7PjgwMqFLkJgIhcjmga
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Move audio-related functions to dp_audio.c, following up the cleanup
done by the rest of the submodules. Inline functions with simple
register access patterns.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_audio.c   |  72 +++++++++++++++++++++----
 drivers/gpu/drm/msm/dp/dp_catalog.c | 105 ------------------------------------
 drivers/gpu/drm/msm/dp/dp_catalog.h |   6 ---
 3 files changed, 63 insertions(+), 120 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index 24b62faa875437e184895c6d03df19884ebb1fd6..4eec0af178cbb190b4e9262dbe9a6e788a57c054 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -119,9 +119,41 @@ static void msm_dp_audio_isrc_sdp(struct msm_dp_audio_private *audio)
 	msm_dp_write_link(catalog, MMSS_DP_AUDIO_ISRC_1, header[1]);
 }
 
+static void msm_dp_audio_config_sdp(struct msm_dp_audio_private *audio)
+{
+	struct msm_dp_catalog *msm_dp_catalog = audio->catalog;
+	u32 sdp_cfg, sdp_cfg2;
+
+	sdp_cfg = msm_dp_read_link(msm_dp_catalog, MMSS_DP_SDP_CFG);
+	/* AUDIO_TIMESTAMP_SDP_EN */
+	sdp_cfg |= BIT(1);
+	/* AUDIO_STREAM_SDP_EN */
+	sdp_cfg |= BIT(2);
+	/* AUDIO_COPY_MANAGEMENT_SDP_EN */
+	sdp_cfg |= BIT(5);
+	/* AUDIO_ISRC_SDP_EN  */
+	sdp_cfg |= BIT(6);
+	/* AUDIO_INFOFRAME_SDP_EN  */
+	sdp_cfg |= BIT(20);
+
+	drm_dbg_dp(audio->drm_dev, "sdp_cfg = 0x%x\n", sdp_cfg);
+
+	msm_dp_write_link(msm_dp_catalog, MMSS_DP_SDP_CFG, sdp_cfg);
+
+	sdp_cfg2 = msm_dp_read_link(msm_dp_catalog, MMSS_DP_SDP_CFG2);
+	/* IFRM_REGSRC -> Do not use reg values */
+	sdp_cfg2 &= ~BIT(0);
+	/* AUDIO_STREAM_HB3_REGSRC-> Do not use reg values */
+	sdp_cfg2 &= ~BIT(1);
+
+	drm_dbg_dp(audio->drm_dev, "sdp_cfg2 = 0x%x\n", sdp_cfg2);
+
+	msm_dp_write_link(msm_dp_catalog, MMSS_DP_SDP_CFG2, sdp_cfg2);
+}
+
 static void msm_dp_audio_setup_sdp(struct msm_dp_audio_private *audio)
 {
-	msm_dp_catalog_audio_config_sdp(audio->catalog);
+	msm_dp_audio_config_sdp(audio);
 
 	msm_dp_audio_stream_sdp(audio);
 	msm_dp_audio_timestamp_sdp(audio);
@@ -132,8 +164,7 @@ static void msm_dp_audio_setup_sdp(struct msm_dp_audio_private *audio)
 
 static void msm_dp_audio_setup_acr(struct msm_dp_audio_private *audio)
 {
-	u32 select = 0;
-	struct msm_dp_catalog *catalog = audio->catalog;
+	u32 select, acr_ctrl;
 
 	switch (audio->msm_dp_audio.bw_code) {
 	case DP_LINK_BW_1_62:
@@ -154,13 +185,17 @@ static void msm_dp_audio_setup_acr(struct msm_dp_audio_private *audio)
 		break;
 	}
 
-	msm_dp_catalog_audio_config_acr(catalog, select);
+	acr_ctrl = select << 4 | BIT(31) | BIT(8) | BIT(14);
+
+	drm_dbg_dp(audio->drm_dev, "select: %#x, acr_ctrl: %#x\n",
+		   select, acr_ctrl);
+
+	msm_dp_write_link(audio->catalog, MMSS_DP_AUDIO_ACR_CTRL, acr_ctrl);
 }
 
 static void msm_dp_audio_safe_to_exit_level(struct msm_dp_audio_private *audio)
 {
-	struct msm_dp_catalog *catalog = audio->catalog;
-	u32 safe_to_exit_level = 0;
+	u32 safe_to_exit_level, mainlink_levels;
 
 	switch (audio->msm_dp_audio.lane_count) {
 	case 1:
@@ -180,14 +215,33 @@ static void msm_dp_audio_safe_to_exit_level(struct msm_dp_audio_private *audio)
 		break;
 	}
 
-	msm_dp_catalog_audio_sfe_level(catalog, safe_to_exit_level);
+	mainlink_levels = msm_dp_read_link(audio->catalog, REG_DP_MAINLINK_LEVELS);
+	mainlink_levels &= 0xFE0;
+	mainlink_levels |= safe_to_exit_level;
+
+	drm_dbg_dp(audio->drm_dev,
+		   "mainlink_level = 0x%x, safe_to_exit_level = 0x%x\n",
+		   mainlink_levels, safe_to_exit_level);
+
+	msm_dp_write_link(audio->catalog, REG_DP_MAINLINK_LEVELS, mainlink_levels);
 }
 
 static void msm_dp_audio_enable(struct msm_dp_audio_private *audio, bool enable)
 {
-	struct msm_dp_catalog *catalog = audio->catalog;
+	u32 audio_ctrl;
+
+	audio_ctrl = msm_dp_read_link(audio->catalog, MMSS_DP_AUDIO_CFG);
+
+	if (enable)
+		audio_ctrl |= BIT(0);
+	else
+		audio_ctrl &= ~BIT(0);
+
+	drm_dbg_dp(audio->drm_dev, "dp_audio_cfg = 0x%x\n", audio_ctrl);
 
-	msm_dp_catalog_audio_enable(catalog, enable);
+	msm_dp_write_link(audio->catalog, MMSS_DP_AUDIO_CFG, audio_ctrl);
+	/* make sure audio engine is disabled */
+	wmb();
 }
 
 static struct msm_dp_audio_private *msm_dp_audio_get_data(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index 5071c86fd219cb1c933b32104a396982c5cc8ace..60ba6e0a204f536fd050591e891add17d286fb2d 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -298,108 +298,3 @@ struct msm_dp_catalog *msm_dp_catalog_get(struct device *dev)
 
 	return &catalog->msm_dp_catalog;
 }
-
-void msm_dp_catalog_audio_config_acr(struct msm_dp_catalog *msm_dp_catalog, u32 select)
-{
-	struct msm_dp_catalog_private *catalog;
-	u32 acr_ctrl;
-
-	if (!msm_dp_catalog)
-		return;
-
-	catalog = container_of(msm_dp_catalog,
-		struct msm_dp_catalog_private, msm_dp_catalog);
-
-	acr_ctrl = select << 4 | BIT(31) | BIT(8) | BIT(14);
-
-	drm_dbg_dp(catalog->drm_dev, "select: %#x, acr_ctrl: %#x\n",
-					select, acr_ctrl);
-
-	msm_dp_write_link(msm_dp_catalog, MMSS_DP_AUDIO_ACR_CTRL, acr_ctrl);
-}
-
-void msm_dp_catalog_audio_enable(struct msm_dp_catalog *msm_dp_catalog, bool enable)
-{
-	struct msm_dp_catalog_private *catalog;
-	u32 audio_ctrl;
-
-	if (!msm_dp_catalog)
-		return;
-
-	catalog = container_of(msm_dp_catalog,
-		struct msm_dp_catalog_private, msm_dp_catalog);
-
-	audio_ctrl = msm_dp_read_link(msm_dp_catalog, MMSS_DP_AUDIO_CFG);
-
-	if (enable)
-		audio_ctrl |= BIT(0);
-	else
-		audio_ctrl &= ~BIT(0);
-
-	drm_dbg_dp(catalog->drm_dev, "dp_audio_cfg = 0x%x\n", audio_ctrl);
-
-	msm_dp_write_link(msm_dp_catalog, MMSS_DP_AUDIO_CFG, audio_ctrl);
-	/* make sure audio engine is disabled */
-	wmb();
-}
-
-void msm_dp_catalog_audio_config_sdp(struct msm_dp_catalog *msm_dp_catalog)
-{
-	struct msm_dp_catalog_private *catalog;
-	u32 sdp_cfg = 0;
-	u32 sdp_cfg2 = 0;
-
-	if (!msm_dp_catalog)
-		return;
-
-	catalog = container_of(msm_dp_catalog,
-		struct msm_dp_catalog_private, msm_dp_catalog);
-
-	sdp_cfg = msm_dp_read_link(msm_dp_catalog, MMSS_DP_SDP_CFG);
-	/* AUDIO_TIMESTAMP_SDP_EN */
-	sdp_cfg |= BIT(1);
-	/* AUDIO_STREAM_SDP_EN */
-	sdp_cfg |= BIT(2);
-	/* AUDIO_COPY_MANAGEMENT_SDP_EN */
-	sdp_cfg |= BIT(5);
-	/* AUDIO_ISRC_SDP_EN  */
-	sdp_cfg |= BIT(6);
-	/* AUDIO_INFOFRAME_SDP_EN  */
-	sdp_cfg |= BIT(20);
-
-	drm_dbg_dp(catalog->drm_dev, "sdp_cfg = 0x%x\n", sdp_cfg);
-
-	msm_dp_write_link(msm_dp_catalog, MMSS_DP_SDP_CFG, sdp_cfg);
-
-	sdp_cfg2 = msm_dp_read_link(msm_dp_catalog, MMSS_DP_SDP_CFG2);
-	/* IFRM_REGSRC -> Do not use reg values */
-	sdp_cfg2 &= ~BIT(0);
-	/* AUDIO_STREAM_HB3_REGSRC-> Do not use reg values */
-	sdp_cfg2 &= ~BIT(1);
-
-	drm_dbg_dp(catalog->drm_dev, "sdp_cfg2 = 0x%x\n", sdp_cfg2);
-
-	msm_dp_write_link(msm_dp_catalog, MMSS_DP_SDP_CFG2, sdp_cfg2);
-}
-
-void msm_dp_catalog_audio_sfe_level(struct msm_dp_catalog *msm_dp_catalog, u32 safe_to_exit_level)
-{
-	struct msm_dp_catalog_private *catalog;
-	u32 mainlink_levels;
-
-	if (!msm_dp_catalog)
-		return;
-
-	catalog = container_of(msm_dp_catalog,
-		struct msm_dp_catalog_private, msm_dp_catalog);
-
-	mainlink_levels = msm_dp_read_link(msm_dp_catalog, REG_DP_MAINLINK_LEVELS);
-	mainlink_levels &= 0xFE0;
-	mainlink_levels |= safe_to_exit_level;
-
-	drm_dbg_dp(catalog->drm_dev,
-			"mainlink_level = 0x%x, safe_to_exit_level = 0x%x\n",
-			 mainlink_levels, safe_to_exit_level);
-
-	msm_dp_write_link(msm_dp_catalog, REG_DP_MAINLINK_LEVELS, mainlink_levels);
-}
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
index 24f1cf4ed5150c4e0e80880588641a01bb6a1596..e2fdccc332f874458709593c68a1d1a46b6cc406 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.h
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
@@ -134,10 +134,4 @@ u32 msm_dp_catalog_ctrl_read_psr_interrupt_status(struct msm_dp_catalog *msm_dp_
 
 struct msm_dp_catalog *msm_dp_catalog_get(struct device *dev);
 
-/* DP Audio APIs */
-void msm_dp_catalog_audio_config_acr(struct msm_dp_catalog *catalog, u32 select);
-void msm_dp_catalog_audio_enable(struct msm_dp_catalog *catalog, bool enable);
-void msm_dp_catalog_audio_config_sdp(struct msm_dp_catalog *catalog);
-void msm_dp_catalog_audio_sfe_level(struct msm_dp_catalog *catalog, u32 safe_to_exit_level);
-
 #endif /* _DP_CATALOG_H_ */

-- 
2.39.5


