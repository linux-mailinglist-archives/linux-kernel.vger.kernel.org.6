Return-Path: <linux-kernel+bounces-533849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBE3A45F75
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCB83B6B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C3A220682;
	Wed, 26 Feb 2025 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ohkcNgTm"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CF521CA15
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573198; cv=none; b=SloVMz/n9TDYiCAs0An7+GXaknnLOsqsCYafmUoQ6tK7YaqELgrxwC5MmgTgqBYH/uwKRbFWRlCyVMzWZ5hSUlEc9vM1i2AJL6mjmz1ytjn1mngNJ6JKs0DzabrX+ArCX14hIdYnHdhgAOgUHo+QcgbZT94EMPBV9lxUVOeS+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573198; c=relaxed/simple;
	bh=abNbpRlXHuZ7m2O+VGB/4vwIlVmkocNUGdti7LPWNjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oOu3eyoZo/0Q5T55ZGTg1LYHGC99ubZrIDenKTbh7YzGhdaKAAfREIAJo15ciYofuDyQpCSBNIU7dsQHqJp6eedvYiEIf8uundmfd6LyM5G2zAO0wNnD9jW40PiWl2Yfiojgt7LbVS2RhxCiF7z32dti1KfzXF0XWpaN8b3NTcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ohkcNgTm; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fc1843495eso9943187a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740573196; x=1741177996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CnxZo728cU6Bds36JLYqHT6x28HxQHbVwrzkHphwtQ=;
        b=ohkcNgTm+NUGMg1WFSAnD6YTTH5YMK1FvgHyXP0pThfPiHMOwkYQJqeskzuU93sLgC
         dn8M75btf9VrAShqNctWd/nCRBU9aEOPtrkA70A2eAvMq39ZkKxMTQCOYlxqdHxemm+U
         omjYQ8xkPtFx0s4Zzbf/Wlx+eVoQsGN/BdUgrUWOtENq0EfpNpvcGtZst7HugO1d96AH
         ju+vphL23+BHNvoKwLZOg3GmVL9PgyJFkOqUepMaHBnl43D83tXJ6syrCvEK2D4TJgcs
         MLUF8Y61KRjApaSd63467BV0U8wOz7LUuA+aVFEENZ0tQJ0ONNgyW1Z+MbNZqRNYlkQt
         rCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740573196; x=1741177996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CnxZo728cU6Bds36JLYqHT6x28HxQHbVwrzkHphwtQ=;
        b=oemGEo/BsDOWa7aOTY0ly9hhGjjBqdugAxUaGEChwEx69YLHFf+Qcx32IbwC4SIK5i
         /oh9y+AAXWib4S/swL4nBjmu0CHl/BISn8dOKtmj7Eb5kamyzkg36Ob+wYgz5KG0ncyX
         g+/J9cujPdMkIKVRlZIbZ/Wd/xPJ5W/be6hVsPPqMu0kPHJpEO9PUMRdkYZoQYQ6In+b
         XA7Qs4dTer2BVR75s0C20fzkR14138Fl4OZCVDPVgVQmTI+NY7v4FiF5+uLvG9mFHYf1
         /bjm6FYqom5NTPSanu6706dYhMJOZoXasZrNCNN0u9N5p3SU1lL7FvTJp1sSFz8hkUIG
         AASw==
X-Forwarded-Encrypted: i=1; AJvYcCVGxfu80BW92w4j1XiA4e6+6tHSK+XTmXSCifaUN9yP6PjpvMn1EOYuaq1UWTT+ooq9m+CF4RvtV+Ytk3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRKUo8gMCCptWStrAZxGtaRZR0jKxbGXuwm+GYmgOBaG062GAh
	WrOO9AlcIUVeVMBn26hIM+LPorbMvlgNJkHyw1pnAulgHyaw+V0sQsKMs+CubFU=
X-Gm-Gg: ASbGncsJy0ZajXwnJ9e/mmJ2kVn43iizWsP3h1kbyF0ruDKqvq2vm6ecBattboMSpMl
	hp9wuZTxhfYx86o4e8WtfQ1Uipb9dUEyBxO2mr2oNcAHVAHNc2fzyJNEQDFhgbuXAWfij7j5NPd
	0raf0pf/03kGGd41E0nhqCjgUcwktwC6HyGXAsTOifCimTwbu+vI1ltekAVh1jbVjr9ChyJxGno
	OTKugjOoWsz5krLYIXbKSwt02i4veIxv7BhHDrKJGrClyy4GOaC85Me//A7X63OnqHsgsrN6HJx
	bHN4EP1xsZvC/XIf56KYeT8=
X-Google-Smtp-Source: AGHT+IHVv0yrikMvgAdx6REBH3QlKkyvnv9uRabQC7gUyZETLFWKVH2v2BHNQD7OyE2I/nvYWl70Fw==
X-Received: by 2002:a17:90b:524f:b0:2f4:49d8:e6f6 with SMTP id 98e67ed59e1d1-2fce76a2737mr30710402a91.3.1740573195748;
        Wed, 26 Feb 2025 04:33:15 -0800 (PST)
Received: from [127.0.1.1] ([112.64.61.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825d2ed3sm1352479a91.29.2025.02.26.04.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 04:33:15 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 26 Feb 2025 20:30:57 +0800
Subject: [PATCH v7 08/15] drm/msm/dpu: bind correct pingpong for quad pipe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v7-8-8d5f5f426eb2@linaro.org>
References: <20250226-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v7-0-8d5f5f426eb2@linaro.org>
In-Reply-To: <20250226-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v7-0-8d5f5f426eb2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740573128; l=1833;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=abNbpRlXHuZ7m2O+VGB/4vwIlVmkocNUGdti7LPWNjc=;
 b=hA+IxnJICm08UCSRxQOh06pxVkrGrtaSNApnAb3JQQyQvCd3NOS6U73IhMSqgG+XEVNrBI7+8
 t+uMzOcT7mMAf60gBGpFYydkYgt9vwpSV9fsZbbQVhF9jqnpmz/aKjT
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


