Return-Path: <linux-kernel+bounces-517810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBA0A3860A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4134317297C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921DB2222B1;
	Mon, 17 Feb 2025 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ntz4JyjR"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4272222A9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801853; cv=none; b=q5CKoO0EIxH13JgfN/5lXpLJDI41kA85QCIgIOQJ2Zy9OApEmwJlSl8tkHoxqrSoK5xrFsyf5O3cxrOdnLhykjsyuuc3WdPetBGSHNW25cdMye+eBT/Y98y3QzaerRoxo8KWDQ3tQAH2w1G2tekHQC7pu/PgCjNFobZxH3gataA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801853; c=relaxed/simple;
	bh=abNbpRlXHuZ7m2O+VGB/4vwIlVmkocNUGdti7LPWNjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r8KpclgIU679eDHi3ID0n+uQl4meNGoGyss47gaPPMeSWy87LYerXqF5WDp7AQxU5C1okK8OhBtcTa1bgWorqgipHD/ibDXT9vGuxMLBS9hRmN7X89zydPDevm57oeTAO5WylQ0xXX6YW3RP7nIb2Rb7LEBfdfm3oQrlBu617Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ntz4JyjR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220c2a87378so60488335ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739801852; x=1740406652; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CnxZo728cU6Bds36JLYqHT6x28HxQHbVwrzkHphwtQ=;
        b=Ntz4JyjRlONBaWPRwD0gJszQA5Bh0Feh0D/pmO3ylvaGuGxxfvkrSvDkqdEvdw3PdS
         aq54vuGQGsIifj74qDGRvY9NBXP7AuXPnejzlk7nPkx6EbNwu5/WVD1T+v/KShWsocxs
         6A0GTkZ6tQieonJUoWRMMmGGv4YaquIEhQLTDSI27b4h+03IyeisBVeHsR2hVP8DDhoF
         wKIo4vh9xqTT9OSAAhxImymC+d3r40/7JPwxHDsmU2Ta8mlbrHd8ej6iLg9ldUl40uQZ
         LMBynxakszSR7rLgwMOsjiBvTr2+aWEXjbj/HVd1J5O0OeuAmnGFHQW5Y6oWvuTih/DN
         J2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801852; x=1740406652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CnxZo728cU6Bds36JLYqHT6x28HxQHbVwrzkHphwtQ=;
        b=kcI9BFa0RTkQ0IvQY+offoMoHUHcJXtGvNGtsdH9Rzdcas3nJwviJRVXUFArEDr1Qx
         FoULQg6gheqSS4yhkPnp8yjazH2LnUT7qAyT07mhfualP3Sfz8cG4hwAHoGORQWp9gH4
         B7cC/Vb9w7414Ey+pVxNsyvvlNd8LqnDXr98Wy4s+o5Vj2SS97mka1r/V6YfDKMNcCly
         WP/4lwbuQoPN1LN5no97cbN9KoS3VDF2xlJfei/fkTqv0wVnnHJjg7NXvCY2tDzY+Pqs
         fGBV0CwmcCAd5SkTm02qYTLxFN+mZJo3m3400VnmPlSzFnKmOg0Kxz36T9Iy0Hfp+WQu
         bl0A==
X-Forwarded-Encrypted: i=1; AJvYcCXeJEu819jfo8CjoFQaY7hU1Mdh1+UwEfAeXe1GbrkYHjUV/WeP3QC7QPDezJk2dkY3PU95BVxZ3ajd0Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlV7SxQgDhO3REbF1ng0NMfY6sH8n7XHhp6WXp5LHGa0bY4IP5
	Zc1uQo4bJY5nmjsNXqX9ZOEO51qstgwATOVZQ0ljITAV/QCaX19OBv6X4s+XnWlBHbq0H1fUaGf
	FyWJpEQ==
X-Gm-Gg: ASbGncvrSWkfFmp4xyDjfVznsbXx4NeExPMioMrLme+lKMH9fUfQ2zp+0MyHV7UPHVh
	mI3RIcfQB9p7vSLElWgvyKSbcDUmM9xM+jxHNXGKhPz58DsIGj8dEdin+kmG5yxtZ7j44k/b75f
	CrySLTtZTfwE65GyvYBJSbylOaAclYXv97FA0UpTpcptKlL/GXCagHE1URZgIVxU6Lm9mc3lbod
	+Ewbs0CYa6ALoBsr+0NMItu5sJiEWXIa0PY0I6Me5xj84UgAilNydAnjY+Tn07uuCCE5utekyKB
	v0m/Fip0zg0o
X-Google-Smtp-Source: AGHT+IHaD53v+SPng3uYJPEofw88FIK9ZP+O2KcaexT7MncLnnkv/HcyrqrLBH/PoDwf8Tt8V7NBOA==
X-Received: by 2002:a17:902:f70e:b0:21f:3e2d:7d35 with SMTP id d9443c01a7336-22104025607mr142318155ad.15.1739801851724;
        Mon, 17 Feb 2025 06:17:31 -0800 (PST)
Received: from [127.0.1.1] ([112.65.12.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5366984sm71900845ad.60.2025.02.17.06.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:17:31 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 17 Feb 2025 22:15:57 +0800
Subject: [PATCH v6 08/15] drm/msm/dpu: bind correct pingpong for quad pipe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-8-c11402574367@linaro.org>
References: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-0-c11402574367@linaro.org>
In-Reply-To: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-0-c11402574367@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739801787; l=1833;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=abNbpRlXHuZ7m2O+VGB/4vwIlVmkocNUGdti7LPWNjc=;
 b=eYSXAYvCkNz10FE2WbTG+bkySWvWHXeMrax77LxLcyhYt4QdlkAkkV+zY0DtldOxE3t6lxx8g
 9W8sUUL6/LUA+NmwVpaRy4xAkGnH9ITtveh8Gvpsxv3/SQaRfGy4BkD
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

There are 2 interfaces and 4 pingpong in quad pipe. Map the 2nd
interface to 3rd PP instead of the 2nd PP.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 018a1a49ca7d152fddcce7ffa1a0a5d54eb615af..c89a5da0fa8321e9082d5aee304fa16402bb4ad9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1220,7 +1220,7 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 	struct dpu_hw_blk *hw_pp[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_blk *hw_ctl[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_blk *hw_dsc[MAX_CHANNELS_PER_ENC];
-	int num_ctl, num_pp, num_dsc;
+	int num_ctl, num_pp, num_dsc, num_pp_per_intf;
 	unsigned int dsc_mask = 0;
 	int i;
 
@@ -1275,11 +1275,17 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 		dpu_enc->cur_master->hw_cdm = hw_cdm ? to_dpu_hw_cdm(hw_cdm) : NULL;
 	}
 
+	/*
+	 * There may be 4 PP and 2 INTF for quad pipe case, so INTF is not
+	 * mapped to PP 1:1. Let's calculate the stride with pipe/INTF
+	 */
+	num_pp_per_intf = num_pp / dpu_enc->num_phys_encs;
+
 	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
 		struct dpu_encoder_phys *phys = dpu_enc->phys_encs[i];
 		struct dpu_hw_ctl *ctl0 = to_dpu_hw_ctl(hw_ctl[0]);
 
-		phys->hw_pp = dpu_enc->hw_pp[i];
+		phys->hw_pp = dpu_enc->hw_pp[num_pp_per_intf * i];
 		if (!phys->hw_pp) {
 			DPU_ERROR_ENC(dpu_enc,
 				"no pp block assigned at idx: %d\n", i);

-- 
2.34.1


