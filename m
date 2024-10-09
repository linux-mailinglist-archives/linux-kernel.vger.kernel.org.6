Return-Path: <linux-kernel+bounces-356600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B30219963F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D9B1F22D87
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA9D19148A;
	Wed,  9 Oct 2024 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H48P8Zx7"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5CB191493
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463863; cv=none; b=U7/SA0H7hG0/T5bP70aI1MSVTEwGmvR/Fgaf9YzKiX3cfhh1qaFvYhEuRrT9Umya8bPI2/Z0MG4I3X4yf759FLUrPnAmKlyrMiacAdAt8JXXoo5PPqyMnWQNpshWYHQ+i8ge1yqkUHPJTFRa+ppUalTwv8jOxcdPYoSL79WL3ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463863; c=relaxed/simple;
	bh=9RRYODS3A2d0Z0V8KOVcb66YQ53zyJFTZeiR1EUXh1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iFQrqdRP8X9wUicEof0nTxNu8WxcMLR7IDbkOYpnhOFSfq6Hg/zJXDwy8JoXTbw9h+Sc9JFJxmSzWrX2uj/K7T+fX7GtRR9BBShd/NVc+1WpCYvR3fY2GoiTd3qNy1x4t/AErTx54oDeENq2eCz+Nyx/pNxULIxckkAk853RA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H48P8Zx7; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db238d07b3so5577767a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 01:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728463861; x=1729068661; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LPn0pitWd582eaxpygCPJ3KnkuQTc8TgGjrVLwJiU4=;
        b=H48P8Zx74UAMRXrhQWz07AO1Y0eNDJ3+Lzx/VHVMBfLrrxMjj6bZnBe/eAipQM81X1
         4F67FVWU60/oO4WsJ2zG/VmC9GfF8pEyD6KrLOrZS+VZqZ+RdKGJ1FfDT3G8bT1EHhQ+
         +Iyr09dZZD+jrW70/J+kbND8dZKm+648nVlVqmd4N3rhQl0oqpL0dNTnKzvYHueXffyG
         qgAj7lRS+h77V4MX7AGdk7HSSBo8sLwrpynq5jgMF7j3SWJDgoys/4IY3vrSbRQf6dgi
         EP3RstnK+3kSsWatRcoM2a2PxiTSNFkccz1gmS5y/t/Vey3vHasquWe48sdn1gp5sUBE
         3bvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728463861; x=1729068661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LPn0pitWd582eaxpygCPJ3KnkuQTc8TgGjrVLwJiU4=;
        b=Z4O8Ro++Z9mwODAVRf0HO8U29oh7w97u2kBOBoMotYYMWW70QbasVKUupLvq6AcNdi
         rJ1Hk5PL6CTQYPntdKOKOCsBuJEdwoqE2A4PCdpQkP6r+tK7E8piOquIlk0+suuyp93B
         ZHBCJ9Bjwcu2wXTFTyxX9Rom7Bgtfnl+jPhV8GmomHOKoVUnfxRyafi6lRhrjvL0ANQZ
         J1oA7Foco/2uI8SZswk9NejVZ3agGvIF9ChiLXo8p5/SCMXfcbIWb349Bv0xAaK7Eq9J
         tCiegGrFjuah0Q2bB3QnC4TJTxomifNDuFz80BLPCS2OKPDeyT4CMCznRxDA1PVhrd7M
         8rQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoGsed9pxZMrl0ZEN4cp96wN5k2ildwLuEYuQE1IyTjzTj6NtUhX4oWuynhNx0nXglDwwknxiIJLcIIV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl5R6o5v0CWGoSmOJtwcxjTSkqSNTso/oFbKnBN8fUjoiqrkFM
	uUHqOvEfZ8ak7c00R5vDIFcT2LVYpiHY3vdwnXWlJSRx/Vih5r3kORjEYoyrcgc=
X-Google-Smtp-Source: AGHT+IEuBbVEOzp/44KTvogO+2Pwv6ey+PCRNhpJDBXR48nTEps9zZhOE/C5TsBcWU49Kk9eDonz1w==
X-Received: by 2002:a05:6a21:4006:b0:1d4:fd63:95bc with SMTP id adf61e73a8af0-1d8a3be149bmr3557677637.9.1728463861596;
        Wed, 09 Oct 2024 01:51:01 -0700 (PDT)
Received: from [127.0.1.1] ([112.65.12.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2abad236esm898157a91.10.2024.10.09.01.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:51:01 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 09 Oct 2024 16:50:20 +0800
Subject: [PATCH v2 07/14] drm/msm/dpu: bind correct pingpong for quad pipe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-7-76d4f5d413bf@linaro.org>
References: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org>
In-Reply-To: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728463820; l=1834;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=9RRYODS3A2d0Z0V8KOVcb66YQ53zyJFTZeiR1EUXh1U=;
 b=zI/fFfLWAz2Rx1/Bo0e+EbbQoShERiEAOqxWMBxb+PzQbh3DuBOpjimccwD4p8gsYHq+UnPTf
 qnLp6+iodCIDPeqPBs96CqtOwscwnDXQLGLGX3o192BuKvN1lM195gy
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

There are 2 interfaces and 4 pingpong in quad pipe. Map the 2nd
interface to 3rd PP instead of the 2nd PP.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index bd2509985c4d0..dfe282c607933 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1100,7 +1100,7 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 	struct dpu_hw_blk *hw_lm[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_blk *hw_dspp[MAX_CHANNELS_PER_ENC] = { NULL };
 	struct dpu_hw_blk *hw_dsc[MAX_CHANNELS_PER_ENC];
-	int num_lm, num_ctl, num_pp, num_dsc;
+	int num_lm, num_ctl, num_pp, num_dsc, num_pp_per_intf;
 	unsigned int dsc_mask = 0;
 	int i;
 
@@ -1171,9 +1171,14 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 
 	cstate->num_dscs = num_dsc;
 	cstate->num_mixers = num_lm;
-
 	dpu_enc->connector = conn_state->connector;
 
+	/*
+	 * There may be 4 PP and 2 INTF for quad pipe case, so INTF is not
+	 * mapped to PP 1:1. Let's calculate the stride with pipe/INTF
+	 */
+	num_pp_per_intf = num_lm / dpu_enc->num_phys_encs;
+
 	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
 		struct dpu_encoder_phys *phys = dpu_enc->phys_encs[i];
 		struct dpu_hw_ctl *ctl0 = to_dpu_hw_ctl(hw_ctl[0]);
@@ -1195,7 +1200,7 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 			return;
 		}
 
-		phys->hw_pp = dpu_enc->hw_pp[i];
+		phys->hw_pp = dpu_enc->hw_pp[num_pp_per_intf * i];
 
 		phys->cached_mode = crtc_state->adjusted_mode;
 		if (phys->ops.atomic_mode_set)

-- 
2.34.1


