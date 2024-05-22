Return-Path: <linux-kernel+bounces-186075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DE38CBFA3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4976228394E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF0682D93;
	Wed, 22 May 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjupJRt9"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEEC824AC
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716375065; cv=none; b=U1d/vwyRAjlwpGXEeb/dvIv2ME4YeTJxvapu/00Y0AIa6ixSJu1R3qC+60TNdk1gY560vIuhWQOL4EoOa5NG1mGxiteTD5Ktw3OQCzz7Z4R+lpDQRySCXKSo8tbqouLoWP0o34VVXho5HzqcftGWFQ9Jr6BKDFQJWji9X4I4cfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716375065; c=relaxed/simple;
	bh=K1KI+nZVasxZlSMfFS8U9hLPw6QPc6PsVGWsUOlWg9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aUPSEsSAf88+bHUKztlIHYMHeHz7ZmdFUxXWT3Sxq8uAyUR5XMfrNIZqxHQTqWhZTJLK1RGXGnrtNlIVCeJ8rtsLZCsu7SDQ0VQcn/jFVgn9aJzRWn0UZfGoz5oBMZG9RpMT1C3WQO2N1N0a/MeYg4up68twWIUKAtYqwPpDV9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CjupJRt9; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51fcb7dc722so643787e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716375062; x=1716979862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsC/gRsvFclAEANavYSBlEUjjyUnanQ9kBr3o4SWpJA=;
        b=CjupJRt9CqbVSlMtBqOvGzoSBwc3+xhxQgFfLGk26h7IonFMuQ3T5F18qOaj8qAT2D
         PaTA6ovZA8w3eJMMl8oRdQGBsFzT+C94K7PRw+OEvtzNjt7k0rq5SWejP5Gp3ZLC4+nl
         Bcymip1C44ZSgr8xzqgHkbM2JGwnu8cvznlQsT5wLDuS5zn5ihHb1ohiPGOwaWFpTi1f
         crPey6N1rRR9QLoHdWsfUuzef0V35qco9NNhPAs5Y6nStg55XqQxWNi6Bio6nLC70dSQ
         sSEDvEC47PywWjDVUtCOra4u2QIqQXrpBR4YV/cEYhMIuZ+uqb3Qfgvg57L1PQ5wx7h9
         dNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716375062; x=1716979862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsC/gRsvFclAEANavYSBlEUjjyUnanQ9kBr3o4SWpJA=;
        b=qpBcIyHQk5K5XLi4SFLbTmJG72PuHISgJUacA3Ftk6NEqeLqQknc3S3eiWIzWqir73
         XJL0VeORUd66kUiyM1Crfsch86tRlFxOOThWoAWkOlFDWK8VwA6r4CRlrqqZWCTutsF0
         O0OSU7DlesCYnkihI3L1LreIfiF0PFUyoJ37gpws70A9STv3oVEf88AbQLYU/A7PZ1Xs
         tk5l/MrEM/Xc/bsWB/mH+rn+XsYywdKKfttEq15SDEWKXlYQ1LuFXzE3AlKPePDnOnEI
         ixrh7E98SgHi0XjzF24fHrfTD/D5fjPOvm6TzC1Hfu9xw46w+NJGK/E2FyYG2p9PbBfo
         kIiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkVsLzJ2JZGeEeshpgRrsCwjJ4GjfJxqXe3RBTpgu/vwLwnjBjNOImqjJxy3vsdKPnwZLRpINrwKnW3Rfcd0X/BsRVSDBchomz+r3I
X-Gm-Message-State: AOJu0YwYOuWYLmXt2DUB1i+hGP4LRq9nszvcHRW39SR4N8OWHDvgTG5V
	EVyqhp4RdusiZCcsg3eIHmjLlsD5RTO1aDdXtAHhIwyBsQ5/5Lqg/z5Wrs1wf5w=
X-Google-Smtp-Source: AGHT+IFKBWmoLwb0ELld20WRYh6MP860S9/NAr7J2q43NCXsCE00e4g0SyRTBt1FvFJipTvpKF/64A==
X-Received: by 2002:ac2:46ca:0:b0:51c:590f:4305 with SMTP id 2adb3069b0e04-5269b2e6679mr529373e87.8.1716375062015;
        Wed, 22 May 2024 03:51:02 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52431778ec8sm1279126e87.194.2024.05.22.03.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 03:51:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 22 May 2024 13:50:57 +0300
Subject: [PATCH v2 05/14] drm/msm/hdmi: drop clock frequency assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-fd-hdmi-hpd-v2-5-c30bdb7c5c7e@linaro.org>
References: <20240522-fd-hdmi-hpd-v2-0-c30bdb7c5c7e@linaro.org>
In-Reply-To: <20240522-fd-hdmi-hpd-v2-0-c30bdb7c5c7e@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2294;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=K1KI+nZVasxZlSMfFS8U9hLPw6QPc6PsVGWsUOlWg9o=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmTc4PVwLPggWZS7nDhhkL19OkYk1UVB6HyzzLX
 mh6kxylRy2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZk3ODwAKCRCLPIo+Aiko
 1T3zB/9Tc0eNy+q8LiRXQPBs5tBj5FD0fCU6cAnP2CgFPzBGWPNFSlTgvY0wUYAIhkX8udzpSbe
 mhSARwL1p/kUkAYWEVinpmOOjzyfowqVQqiXtzGJgeCpzcLxg9YgdAefRuO5X4FMjOQIydeexxK
 4rFnK1ZBFuYeflTip1RBDLYsJfVb+Mt1XfJbbu7SRpyLkI8jEcESSPvtimktULPTKI2EYn3yrFE
 2u3lrsW6FWkc2GGo3v+uhClA+Q9YScQllpF2B+Z5ASitZziAnHHhXXXGZEN49f/AwmKHdT31gRc
 qJdqXDzQTGkSf7y4B0qFRGA5bslOc2ncIzYVceNhmOuRAAG7
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The only clock which has frequency being set through hpd_freqs is the
"core" aka MDSS_HDMI_CLK clock. It always has the specified frequency,
so we can drop corresponding clk_set_rate() call together with the
hpd_freq infrastructure.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c     | 2 --
 drivers/gpu/drm/msm/hdmi/hdmi.h     | 1 -
 drivers/gpu/drm/msm/hdmi/hdmi_hpd.c | 9 ---------
 3 files changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 681265e29aa0..c14e009f38b1 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -236,12 +236,10 @@ static const struct hdmi_platform_config hdmi_tx_8960_config = {
 
 static const char *pwr_reg_names_8x74[] = {"core-vdda", "core-vcc"};
 static const char *hpd_clk_names_8x74[] = {"iface", "core", "mdp_core", "alt_iface"};
-static unsigned long hpd_clk_freq_8x74[] = {0, 19200000, 0, 0};
 
 static const struct hdmi_platform_config hdmi_tx_8974_config = {
 		HDMI_CFG(pwr_reg, 8x74),
 		HDMI_CFG(hpd_clk, 8x74),
-		.hpd_freq      = hpd_clk_freq_8x74,
 };
 
 /*
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
index abdbe4779cf9..c0d60ed23b75 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.h
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
@@ -96,7 +96,6 @@ struct hdmi_platform_config {
 
 	/* clks that need to be on for hpd: */
 	const char **hpd_clk_names;
-	const long unsigned *hpd_freq;
 	int hpd_clk_cnt;
 };
 
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c b/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
index 9ce0ffa35417..7ae69b14e953 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
@@ -68,15 +68,6 @@ static void enable_hpd_clocks(struct hdmi *hdmi, bool enable)
 
 	if (enable) {
 		for (i = 0; i < config->hpd_clk_cnt; i++) {
-			if (config->hpd_freq && config->hpd_freq[i]) {
-				ret = clk_set_rate(hdmi->hpd_clks[i],
-						   config->hpd_freq[i]);
-				if (ret)
-					dev_warn(dev,
-						 "failed to set clk %s (%d)\n",
-						 config->hpd_clk_names[i], ret);
-			}
-
 			ret = clk_prepare_enable(hdmi->hpd_clks[i]);
 			if (ret) {
 				DRM_DEV_ERROR(dev,

-- 
2.39.2


