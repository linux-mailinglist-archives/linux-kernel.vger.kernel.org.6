Return-Path: <linux-kernel+bounces-522932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FF7A3D03C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73093B9A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933831DFD83;
	Thu, 20 Feb 2025 03:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3PX/RIs"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2EE1E2613
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740023980; cv=none; b=d/pXYZMm2aIb9ddLfOD9koBfJLi73Ne2P2ABREkiH4GUIRwUnDWdkEn5AZ19E692CrNhKQE7eL9dzJBefacm0eHvzMBiELd4SmKYfraVdlsb/36FxhLRoF+2GQQFRvk0tsfGEBFsLxKYatnCIYkHwauF0+/KKt3bBRUHit54NBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740023980; c=relaxed/simple;
	bh=akDkekVVLzHGn2gQgxyT6iyr6q7HQnLI7MIRAAwIajA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k3SPcSI5IRTdPyEfQaUPxJ9NH4y9EEzrimDyixNnvD22eLRm/q1GqMWbEUHAkNoi6OLFvV5ke2delkqyUrMYQe7FdxW9rCLZzejpcVuSCqBW+Q5i5e/sjn+3gMLAhZsLF8Sr6ldyl22AHw94xNHXPRnLnYZ+3EMQlOJmHGELDlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W3PX/RIs; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-543e47e93a3so605476e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740023975; x=1740628775; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+iQktoZgMXFUuH/VI1uCNDXJ1CPN0nauJB73520LxmY=;
        b=W3PX/RIsLmwC+q2Dq4QsVLJvNPJ6/NF0NFeIkv5SF6ulGtEFynZCoi/3AV9cSmfGq0
         xmOxRta/yx2L1Zz4UIQUXwxDbVdpHdAfTDHQDpEn1CCOZJ0Izl1SLd+znMwUPU5iE+cP
         Jt2RI0Gh7os+0BuwZpBi/ENtzgyZs4U2lR+g0kX4GlJMnxAJvjJ+Tih3caXRxxVQvXQs
         fupABjH/HizB/5lGprlqD76e4SRnDZpRleA36s1v2av3y/4y5CCvyINqOk6zBSdqvSAy
         kZnUUGSS3Sq7pgjZWdzxMzkWlJgRinyh3TGojyjYgIr7L3cAfgrp4qfah1gkmzLp2LPL
         4I0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740023975; x=1740628775;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iQktoZgMXFUuH/VI1uCNDXJ1CPN0nauJB73520LxmY=;
        b=dVhC6wnbJ7ryQi5jPwkyfnwL0TqK9k1b7t5QkkHfd8ZV3BKjNy4Pz2J6aVkz400QSK
         rCE5FYiac90T3SgtZHZm0MVe/76Ep3xtsoQdlJTRC+oQdz/1/pnTygazPC2eF/kyUUk1
         r+A/rlkREyHi9/TWTu2utab3YMvJrHlkJX2IMx4/GOP0J3bm6sgYL4H7QkiapGaLSYjz
         xF8Ifi6Ha7CJ0OOdgUDHFB5irmMaBiYmruvaqbJUM6HDKpstjCIHxF92iWGQNO4BRcm9
         0tmOJ20FOYzy95gwZQGvgX6KrFLFwB1/OnFXNe9m8FNyfIlDrLxqyeAzcCIVgFKSeGj1
         X2uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBs27XhytCFIOkBLmt+ix0oWRlKDThjSY76ZbsLdr8TuejY+Xz3vgor7Am4fEYzdZRL1mprayyHx/VAHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk1i606dhCPK+G1djf8UPOEFWlC2+7TISPbQRguQJfuVn8ChID
	/LDerwzPtcHNH296h4g09/B8OChcthEWYvgZPA6qapvv39ZCte4aAzukSZQN2B0=
X-Gm-Gg: ASbGncv4AmPddMZdYRMLnGPqbca8GMjtunG3lTVDSOGAtcIKseZnrPhhrlX31K+LiTA
	mP3UriPoloRGFsVOoAc0MDGrtW7ABtCrO68utwQibBHdaoy9ZhQSJqNr1chl/qTKHzwxfbc2bDA
	XFHubgFYgJzK5BIvdg+BD87nw57RbBZfm70egiERY0NVGWwQGwnHlRl48rmuM+M/gmDMHoGOIJ9
	FruGxVfRxw+CdX5fQk1F2A+SAxlgGpfgrfd42/8QPV9xVwrqNR4ybOKPccY5tN43h1KyXP8KTdv
	at4XyoNNe5hVtIYgaZN65Wc=
X-Google-Smtp-Source: AGHT+IHw7aa5o4uaJn+nouzG3FdTcLYjCCQsNGddd5XryyAd4X9xtVduXFEX5mFe+RqzhgSoX2paAw==
X-Received: by 2002:a05:6512:238a:b0:545:2300:924d with SMTP id 2adb3069b0e04-5452fe3f69bmr8165563e87.22.1740023975060;
        Wed, 19 Feb 2025 19:59:35 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545225f22ebsm2143909e87.16.2025.02.19.19.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 19:59:33 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 20 Feb 2025 05:59:24 +0200
Subject: [PATCH v2 3/5] drm/msm/dpu: enable CDM_0 for DPUs 1.x - 4.x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-dpu-add-cdm-v2-3-77f5f0df3d9a@linaro.org>
References: <20250220-dpu-add-cdm-v2-0-77f5f0df3d9a@linaro.org>
In-Reply-To: <20250220-dpu-add-cdm-v2-0-77f5f0df3d9a@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7366;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=akDkekVVLzHGn2gQgxyT6iyr6q7HQnLI7MIRAAwIajA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBntqidHdzz2cllGriTVveL83n6zPQSayzkPKmLT
 Gzym3Re3QiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7aonQAKCRCLPIo+Aiko
 1Zt+CAClEde4yYR1pO+IHb7Op+k5ZVM/BBRba55q7cD5ZwxbefaTOABnp+rGAF1etvxhqaIogmN
 B24Evol5ClsCbzvhG6ixQEVf0QnxrGtsqCSC2ZrPFmjv8590VLiVF1l6SBvsPTInLuWA3GRGg9z
 ohhf/V/jtT1Q6/NpDaLj75PUcIdO7NpSMDio0OctOxK3hydtj16OB1sVIf1RzF3D8tzFuoeK5lJ
 hGdcRmwe7B/Q3tNWDn1ft5axI2i0htG6d2amPNtRXWhRR9E5pcy9GdEw+Fd/1qnrMbatOjrfULp
 6zzaLaIo2U9wMj6nMkHhHbAHKl1JOXtjs5qqGLtGepFzNqRV
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Enable the CDM_0 block on DPU versions 1.x - 4.x as
documented in the vendor dtsi file.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_7_msm8996.h  | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h  | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h   | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h   | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h   | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h   | 1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c           | 7 +++++++
 10 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h
index ab3dfb0b374ead36c7f07b0a77c703fb2c09ff8a..1f32807bb5e5d49b696832c4eab54c05106bfd4b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h
@@ -190,6 +190,7 @@ const struct dpu_mdss_cfg dpu_msm8937_cfg = {
 	.mdss_ver = &msm8937_mdss_ver,
 	.caps = &msm8937_dpu_caps,
 	.mdp = msm8937_mdp,
+	.cdm = &dpu_cdm_1_x_4_x,
 	.ctl_count = ARRAY_SIZE(msm8937_ctl),
 	.ctl = msm8937_ctl,
 	.sspp_count = ARRAY_SIZE(msm8937_sspp),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h
index 6bdaecca676144f9162ab1839d99f3e2e3386dc7..42131959ff22020a83c0ea65d79a56fd57c800f9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h
@@ -167,6 +167,7 @@ const struct dpu_mdss_cfg dpu_msm8917_cfg = {
 	.mdss_ver = &msm8917_mdss_ver,
 	.caps = &msm8917_dpu_caps,
 	.mdp = msm8917_mdp,
+	.cdm = &dpu_cdm_1_x_4_x,
 	.ctl_count = ARRAY_SIZE(msm8917_ctl),
 	.ctl = msm8917_ctl,
 	.sspp_count = ARRAY_SIZE(msm8917_sspp),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h
index 14f36ea6ad0eb61e87f043437a8cd78bb1bde49c..2b4723a5c67606d68dea905d947cd691bb28eda0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h
@@ -198,6 +198,7 @@ const struct dpu_mdss_cfg dpu_msm8953_cfg = {
 	.mdss_ver = &msm8953_mdss_ver,
 	.caps = &msm8953_dpu_caps,
 	.mdp = msm8953_mdp,
+	.cdm = &dpu_cdm_1_x_4_x,
 	.ctl_count = ARRAY_SIZE(msm8953_ctl),
 	.ctl = msm8953_ctl,
 	.sspp_count = ARRAY_SIZE(msm8953_sspp),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_7_msm8996.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_7_msm8996.h
index 491f6f5827d151011dd3f74bef2a4b8bf69591ab..5cf19de71f060818d257f95aa781b91ec201d4e4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_7_msm8996.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_7_msm8996.h
@@ -316,6 +316,7 @@ const struct dpu_mdss_cfg dpu_msm8996_cfg = {
 	.mdss_ver = &msm8996_mdss_ver,
 	.caps = &msm8996_dpu_caps,
 	.mdp = msm8996_mdp,
+	.cdm = &dpu_cdm_1_x_4_x,
 	.ctl_count = ARRAY_SIZE(msm8996_ctl),
 	.ctl = msm8996_ctl,
 	.sspp_count = ARRAY_SIZE(msm8996_sspp),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
index 64c94e919a69804599916404dff59fa4a6ac6cff..746474679ef5b9ce7ef351e2d5434706d6109d33 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
@@ -302,6 +302,7 @@ const struct dpu_mdss_cfg dpu_msm8998_cfg = {
 	.mdss_ver = &msm8998_mdss_ver,
 	.caps = &msm8998_dpu_caps,
 	.mdp = &msm8998_mdp,
+	.cdm = &dpu_cdm_1_x_4_x,
 	.ctl_count = ARRAY_SIZE(msm8998_ctl),
 	.ctl = msm8998_ctl,
 	.sspp_count = ARRAY_SIZE(msm8998_sspp),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h
index 424815e7fb7dd858448bd41b5368b729373035f8..4f2f68b07f203a11529f7a680fb87b448305d80a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h
@@ -269,6 +269,7 @@ const struct dpu_mdss_cfg dpu_sdm660_cfg = {
 	.mdss_ver = &sdm660_mdss_ver,
 	.caps = &sdm660_dpu_caps,
 	.mdp = &sdm660_mdp,
+	.cdm = &dpu_cdm_1_x_4_x,
 	.ctl_count = ARRAY_SIZE(sdm660_ctl),
 	.ctl = sdm660_ctl,
 	.sspp_count = ARRAY_SIZE(sdm660_sspp),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h
index df01227fc36468f4945c03e767e1409ea4fc0896..c70bef025ac4190347f81d75caf4777786fbeaf7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h
@@ -205,6 +205,7 @@ const struct dpu_mdss_cfg dpu_sdm630_cfg = {
 	.mdss_ver = &sdm630_mdss_ver,
 	.caps = &sdm630_dpu_caps,
 	.mdp = &sdm630_mdp,
+	.cdm = &dpu_cdm_1_x_4_x,
 	.ctl_count = ARRAY_SIZE(sdm630_ctl),
 	.ctl = sdm630_ctl,
 	.sspp_count = ARRAY_SIZE(sdm630_sspp),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
index 72bd4f7e9e504c771d999dcf6277fceb169cffca..ab7b4822ca630f8258bc9eb52c0b967e9bc34d18 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
@@ -319,6 +319,7 @@ const struct dpu_mdss_cfg dpu_sdm845_cfg = {
 	.mdss_ver = &sdm845_mdss_ver,
 	.caps = &sdm845_dpu_caps,
 	.mdp = &sdm845_mdp,
+	.cdm = &dpu_cdm_1_x_4_x,
 	.ctl_count = ARRAY_SIZE(sdm845_ctl),
 	.ctl = sdm845_ctl,
 	.sspp_count = ARRAY_SIZE(sdm845_sspp),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h
index daef07924886a529ee30349ae80375a324bbc245..c2fde980fb521d9259a9f1e3bf88cc81f46fdfe8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h
@@ -132,6 +132,7 @@ const struct dpu_mdss_cfg dpu_sdm670_cfg = {
 	.mdss_ver = &sdm670_mdss_ver,
 	.caps = &sdm845_dpu_caps,
 	.mdp = &sdm670_mdp,
+	.cdm = &dpu_cdm_1_x_4_x,
 	.ctl_count = ARRAY_SIZE(sdm845_ctl),
 	.ctl = sdm845_ctl,
 	.sspp_count = ARRAY_SIZE(sdm670_sspp),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index ec7f42a334fc688bec468df490c81a89dd3d396d..a6bb46b201e907566e88abce945507d1bab51b3b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -507,6 +507,13 @@ static const struct dpu_dsc_sub_blks dsc_sblk_1 = {
 /*************************************************************
  * CDM block config
  *************************************************************/
+static const struct dpu_cdm_cfg dpu_cdm_1_x_4_x = {
+	.name = "cdm_0",
+	.id = CDM_0,
+	.len = 0x224,
+	.base = 0x79200,
+};
+
 static const struct dpu_cdm_cfg dpu_cdm_5_x = {
 	.name = "cdm_0",
 	.id = CDM_0,

-- 
2.39.5


