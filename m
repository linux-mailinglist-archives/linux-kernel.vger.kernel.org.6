Return-Path: <linux-kernel+bounces-447002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE669F2BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABAAD1632B9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70842202C50;
	Mon, 16 Dec 2024 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehPs5aAv"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBD0202C31
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337668; cv=none; b=p7pF7zgIgL61ztwPfVi/rwpja+F/9zdBuyHo46/RFt2yh7KtUewWpgPAXH+Ukg06KTzhm56HEhUbjtr7f+g0PkG8wm//LFHSohdTzoytmVt1Ox37Z8mPWGxIdXxzOUEvacsTuJhKKiP3xr+U7Mvrah3oGHKeuCmBV31tjF3SiJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337668; c=relaxed/simple;
	bh=onC/sZOCceTmvl+85uTb+5rs4Fex+BwK8WACCKdIkwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SxBbRrEupW697g/j3fZFk+9yvj38mr52pN2v16sNqoRlXM3ZzVRu8bHmPxLzc6v0jPxxN7RfDOu+VrETcnsfPd6nVI8X+jJ7Y/JVhb7soja5FLaTN6oqCJAHSsSj+cCV01dTMrMzTix3o+4XVJ6Ha/aaYO4DAJxdXqaHW8wkWZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ehPs5aAv; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3002c324e7eso43834381fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734337665; x=1734942465; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFueXj50GklXs26URhroJEyDlIZhDwWcbd/CoZUqrUk=;
        b=ehPs5aAvH2aAUZHR8Yf4J2NnCiDtk2wAoik3pm8Iipe4j3feqJly1gx8Qu4c14khla
         w3xJZBG91lnNJBCiAuC666pXE7E0rREANt4KCI9zT7NJfzyiR65pFwliR3ZNb8XEuHxP
         +jbKXlMkzSJt/2M8tS2K9ee4EpF+3NBJ8zo5v0/SWEaRjvAIaUdiqidMp7ce9BJPKBbo
         dDRC5lcKATInFlo6J5z+0rMBh8DbXtfGfvJ6iMWZiDlhwOUm3uWTIU6m7IlCNtluin0V
         DDUt3nFURfA6et0VNDgNiBAn6pLpPZJuQS9ZZ1jg6OoWpdLIgRkgrI95sX9CV2WqV7Mp
         HyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734337665; x=1734942465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFueXj50GklXs26URhroJEyDlIZhDwWcbd/CoZUqrUk=;
        b=ENizh6bgKHsNF9ZpWsiQadPWj2VVEUpcKkPYd0C34pj48T03S6gTXvyLN4sneUUqo0
         nn5UXfYMcqgKZFAmu6UIAyFaQ0MlhUabgCn5w+GDdeMhahadPb2p/A7g7RDSQ0RnWHkW
         O/fvWpoLOHHQHjD/Ju+SAXdNncolcOsYIokiK8ZaoB73uSp1RQyapZzzTMTAHxGPmM31
         +KLn/WTqB+uPXby7hiB+EAoBpnV7Gt+0jiDxkLjjW0pjS/wtWhP4YcfQTAP/cTdutC2G
         FJ/s2QByia35Ysq71pZ7pJtfqZacDKGhYb7ZU0oQYjXrEuymG/+Ffq6XpbMykFApH5Cu
         92zA==
X-Forwarded-Encrypted: i=1; AJvYcCUGkv9BclQwa0OcUWF4Ep70WoZzuqywK9TT1pmNspX6V2TXWRu17m48SJb0xIMOHWZ+MCI0wlAt50gvtHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyByjPIiUNiLca/efY7kFfLhRI4OhCHABbTSu5lX5cX3Zp52ZbI
	yWSdrEn7X5TkopYx1pzquhOnNjZrVlo+3Aj8JJpHLFqNy7c5HibzoH768zglaYM=
X-Gm-Gg: ASbGncvew0pfTDdkpzL46btsC0VP0KyHXOR4sMWdFwAC/ZG2mRudL6Vk0g87MkTDj9N
	wgDYhlYB1WYVrAUcP8afruepMU0elQd/ZQJORrexNm6oZIC56cDiT3XrgSSvvrMBewb5QVN2Aoh
	mRBiTSMcmGR8cyt2iujRfIvHaZmKKiUZiRhijml0Ypoec/3K+LKoRsEzH4vBFHBIycS7Vlg41j/
	X3SC5LDgkWosbDIk6b++lMzH8waF/abkC3Dff5cHiy1447L46Xuw6q77vSpdKI5
X-Google-Smtp-Source: AGHT+IGsrhukEvweE+kATGZLKV7abTQp6BM2UyFHz+pdJV3ZnHx5w2xQCWTcZUPlJgEfT6lvq/IlrA==
X-Received: by 2002:a05:651c:2122:b0:300:1de5:59e3 with SMTP id 38308e7fff4ca-30254521ed0mr38410041fa.2.1734337665329;
        Mon, 16 Dec 2024 00:27:45 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30344045342sm8543371fa.33.2024.12.16.00.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:27:44 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 16 Dec 2024 10:27:29 +0200
Subject: [PATCH 8/8] drm/msm/dpu: provide DSPP and correct LM config for
 SDM670
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-dpu-fix-catalog-v1-8-15bf0807dba1@linaro.org>
References: <20241216-dpu-fix-catalog-v1-0-15bf0807dba1@linaro.org>
In-Reply-To: <20241216-dpu-fix-catalog-v1-0-15bf0807dba1@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Robert Foss <rfoss@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Richard Acayan <mailingradian@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2663;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=onC/sZOCceTmvl+85uTb+5rs4Fex+BwK8WACCKdIkwI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnX+RstmAKkhUgDFSMOhulvZdpJWZcJyZTinijT
 6Z1u7es4gqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1/kbAAKCRCLPIo+Aiko
 1aAOB/91xjMOv0FVK7azVd6PO2iTLH9oMN0HMJWRapBLHclS/S2HRw4THhS0ZTXl3SQWdRSKTzi
 wIF0W3NfZ7im9NKZR6BNny0YHjrC4g8ctYty0aFeoGiCyAKdHSzf3n0ws09fsYYKkpKTxpvF+pf
 +u1+U1KJN/2e8b3eUkzrdnVy1naigTtie8j7011s4SkhnbTbkF9QIn0ky4UqNxEaBzuCNuuLUVP
 xb+A22DDN96Y1ASkC+ta8ZI6TQR+qyUccvPAL4VKZOVLA8kHl1kNPqUNGLVncSzKoEvDeWa6mVG
 sOV3h9QmLI9X8KpCwJYjMA9uHtbm2rAZXondZBSxwraOMne/
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On SDM670 the DPU has two DSPP blocks compared to 4 DSPP blocks on
SDM845. Currently SDM670 just reuses LMs and DSPPs from SDM845. Define
platform-specific configuration for those blocks.

Fixes: e140b7e496b7 ("drm/msm/dpu: Add hw revision 4.1 (SDM670)")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h | 54 +++++++++++++++++++++-
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h
index cbbdaebe357ec4a82a3c3d950aa13792a1fb2d6e..daef07924886a529ee30349ae80375a324bbc245 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h
@@ -65,6 +65,54 @@ static const struct dpu_sspp_cfg sdm670_sspp[] = {
 	},
 };
 
+static const struct dpu_lm_cfg sdm670_lm[] = {
+	{
+		.name = "lm_0", .id = LM_0,
+		.base = 0x44000, .len = 0x320,
+		.features = MIXER_SDM845_MASK,
+		.sblk = &sdm845_lm_sblk,
+		.lm_pair = LM_1,
+		.pingpong = PINGPONG_0,
+		.dspp = DSPP_0,
+	}, {
+		.name = "lm_1", .id = LM_1,
+		.base = 0x45000, .len = 0x320,
+		.features = MIXER_SDM845_MASK,
+		.sblk = &sdm845_lm_sblk,
+		.lm_pair = LM_0,
+		.pingpong = PINGPONG_1,
+		.dspp = DSPP_1,
+	}, {
+		.name = "lm_2", .id = LM_2,
+		.base = 0x46000, .len = 0x320,
+		.features = MIXER_SDM845_MASK,
+		.sblk = &sdm845_lm_sblk,
+		.lm_pair = LM_5,
+		.pingpong = PINGPONG_2,
+	}, {
+		.name = "lm_5", .id = LM_5,
+		.base = 0x49000, .len = 0x320,
+		.features = MIXER_SDM845_MASK,
+		.sblk = &sdm845_lm_sblk,
+		.lm_pair = LM_2,
+		.pingpong = PINGPONG_3,
+	},
+};
+
+static const struct dpu_dspp_cfg sdm670_dspp[] = {
+	{
+		.name = "dspp_0", .id = DSPP_0,
+		.base = 0x54000, .len = 0x1800,
+		.features = DSPP_SC7180_MASK,
+		.sblk = &sdm845_dspp_sblk,
+	}, {
+		.name = "dspp_1", .id = DSPP_1,
+		.base = 0x56000, .len = 0x1800,
+		.features = DSPP_SC7180_MASK,
+		.sblk = &sdm845_dspp_sblk,
+	},
+};
+
 static const struct dpu_dsc_cfg sdm670_dsc[] = {
 	{
 		.name = "dsc_0", .id = DSC_0,
@@ -88,8 +136,10 @@ const struct dpu_mdss_cfg dpu_sdm670_cfg = {
 	.ctl = sdm845_ctl,
 	.sspp_count = ARRAY_SIZE(sdm670_sspp),
 	.sspp = sdm670_sspp,
-	.mixer_count = ARRAY_SIZE(sdm845_lm),
-	.mixer = sdm845_lm,
+	.mixer_count = ARRAY_SIZE(sdm670_lm),
+	.mixer = sdm670_lm,
+	.dspp_count = ARRAY_SIZE(sdm670_dspp),
+	.dspp = sdm670_dspp,
 	.pingpong_count = ARRAY_SIZE(sdm845_pp),
 	.pingpong = sdm845_pp,
 	.dsc_count = ARRAY_SIZE(sdm670_dsc),

-- 
2.39.5


