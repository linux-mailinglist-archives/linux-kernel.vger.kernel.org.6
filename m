Return-Path: <linux-kernel+bounces-522931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA41A3D040
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5DB417AE60
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3101E3DEC;
	Thu, 20 Feb 2025 03:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oLqw7DWa"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B351E32CD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740023980; cv=none; b=MNjbgMRh2XW6fJfD6zoYIddkAcxiXDCpe5iPq9vBWvJRHxdwx3Pyj+dMNaiWk+QeP6Vc5h3uT6ySXOLquHkrZwpy65l0s2EWASbC7N01zxvhbNnu5wAIuecq+BlpEgJ1MZRduLNN56HE4elSbWnKZc/qjQ/NFY3jszftHYLcSdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740023980; c=relaxed/simple;
	bh=ksuGoNCpiLiyemIz0C1goT90Bi/HXDBK3gu4zkBcFe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qMESgVc6DtoOBnQk/kkCywnCNU/hmTbyTKgM8MCX5pCDSO1DqbWMtZowrCJoguInmC7YZcUastKyN8fzxSreDUjCgKRIUmJa8E2gNuN4+1cxkUOUdiYfC9V5mLHqzX+azrlPG9CI+GtnwDRkuaNqa0hXabqECyU15GntLWdnnLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oLqw7DWa; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54622829175so520317e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740023977; x=1740628777; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqbHNmz099kigX0TqynbTHurbS64qX/w1xCegrKBwT4=;
        b=oLqw7DWaSa683TPRLrmJpyENM2uQ/VBBhpBhACltg+gSOBw47kFNR56zttxX/6ab9j
         gZnxwkUC0rZ2o2CdZdUbas5w2YPu5J81xP4c9x8YoWhG77JLuVsQgeYh2gYVNP/oSwF4
         BipGe1Orh01joqUMBoVTx3RMMEGBzhJviRe/WH2oWjbDlLmNYdg8POvlb6HzAt3JhOes
         UCbPDk9opEVfGOQXV7Bx4DanyVQsRCLDD2GHOizL0u1rlTW8ijVpwFVMTVQioH2hVJfp
         DDNsgTwJRPnnjheBNuEvQnjgw0ei89vlMEU2RuFq3j7IKC/yndYQMoHP+HqmPif8mQ10
         USJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740023977; x=1740628777;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqbHNmz099kigX0TqynbTHurbS64qX/w1xCegrKBwT4=;
        b=D6xBYWeR2y/WeAFdM9uXR/ozImh08k+niv4j3ex/tFdxXcs0MI0LX3b+MrM6OH/5ir
         3Ge4/3D4jFsSy0/NUwv1auTGWhIcDFKYcjqp8XzBvdembVjkNi01Oe+6eTT4jpqzIP9+
         RDhf9utavFniAImywmTuiUIlgWLKyQo7gYdksEiSSdI6p2OhrLW87dXKuWHRbZr+Eaqy
         6AfBMlcV6LrnbHJ7Hhee4exkFNUp7j52dRHYEVz0Xe/IFxOj8XckuTVnav0PCtP9FZq6
         AJ/hd0XjJg1OiMhQkGjVopJyIpA+vUlqH1jr0zVI7/u7aNTkY5Hdhc9abTvVaDOO8N7/
         rw4A==
X-Forwarded-Encrypted: i=1; AJvYcCUZfRPTy5/Tu5dZC4CqhrD/hiQeeLfKnmiQXY2SzcIuMTiwS4iWfefaR90WewY40dM0dxfw3iXAxkEAQgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEMgYk53aSXG71EWLuWq06squgVf1G//2ekJqQQU6whn9H3xBw
	LJXRyhqyQDQdVIXkzd2L3mvlXF0xJVWsZnfJjs2ZLQJjG2sUnD9bl8tbrNO0B+Y=
X-Gm-Gg: ASbGncvoyyGr4G+1rks9d0L7IUAZ76pqWWpa58Rsd9693VyBWnhp9SZbnn72apgdU28
	cBTjpMfeSjGNbqb83qgeohpe910nUnb3eCA6ZrlOn3/RhwXfEYNU8njD71uBRRtZ7+F6FjsMoz8
	JYUwA/qcbGiLlC76e+wRp3G9qUUbf5DFqnWDGgK8A+lUJ0woo858yaB9LKwpHTmRVtPVky2vZUo
	R3rjcMuUDm020bkxOhUylglTYcA5UpUgCkenfYrAT2pJZtxuA+RCeW13Kirb6BUDV7oDWFHLHFp
	FvN840h0HJy8YaOO8QAdmzc=
X-Google-Smtp-Source: AGHT+IHNLX1q/p1F1rq4DyZnm4yuozfzfNUpta652kVpbxvogd3CMY4f1V3qt5Csx5Qszd0Ja2VUvw==
X-Received: by 2002:a05:6512:110b:b0:545:aaf:13fd with SMTP id 2adb3069b0e04-5452fe76fccmr6884137e87.51.1740023976695;
        Wed, 19 Feb 2025 19:59:36 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545225f22ebsm2143909e87.16.2025.02.19.19.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 19:59:36 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 20 Feb 2025 05:59:25 +0200
Subject: [PATCH v2 4/5] drm/msm/dpu: enable CDM_0 for SC8280XP platform
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-dpu-add-cdm-v2-4-77f5f0df3d9a@linaro.org>
References: <20250220-dpu-add-cdm-v2-0-77f5f0df3d9a@linaro.org>
In-Reply-To: <20250220-dpu-add-cdm-v2-0-77f5f0df3d9a@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=975;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ksuGoNCpiLiyemIz0C1goT90Bi/HXDBK3gu4zkBcFe4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBntqidVLBOqKTIOpBvG4db7VXVScNmMMC80vm5o
 Ax1Q2LayhuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7aonQAKCRCLPIo+Aiko
 1Wt6B/4l0tedtz00rD6xE5Nk2oCfAEA9rif90maR94yeStThnNmOlaypC8JzqTsQwzyfYIDLppP
 8Ad965InPWg8vKtWToJBb50m5vxxaubDgD/FQgmQqnFfuFsIzC06Uo2Qy9oTcoyXXPuZbw8YKvi
 K3VE8dPcvKt/74eD8HOTPHK/u4N5szfXBzG6SvzmYwok1e8rvwd+YVfgta0o9RZGN/sjj8SiXku
 X8/0zk0CE4KwOPA2Y+s0dzLlE5RBhDGuxMZU3ulsUMoOc/eGdn205hFslC6jxR/QIbBfiY34qJo
 9K55rA2S3tsK3K2xjDvxlegOvFKTXSdkAnGCv/toxdPo0Ipm
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Enable CDM on the SC8280XP platform, allowing RGB to YUV conversion for
the output.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
index 0d143e390eca964b1c81f835d0904a2079b0b941..fcee1c3665f88a9defca4fec38dd76d56c97297e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
@@ -435,6 +435,7 @@ const struct dpu_mdss_cfg dpu_sc8280xp_cfg = {
 	.mdss_ver = &sc8280xp_mdss_ver,
 	.caps = &sc8280xp_dpu_caps,
 	.mdp = &sc8280xp_mdp,
+	.cdm = &dpu_cdm_5_x,
 	.ctl_count = ARRAY_SIZE(sc8280xp_ctl),
 	.ctl = sc8280xp_ctl,
 	.sspp_count = ARRAY_SIZE(sc8280xp_sspp),

-- 
2.39.5


