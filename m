Return-Path: <linux-kernel+bounces-542023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F5DA4C4C4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE4F188EB36
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1435215193;
	Mon,  3 Mar 2025 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="puRj5zdq"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB380215F48
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014975; cv=none; b=XYZR74O5JxOr0GmO7H6PaYKdka7OtkEe/lostA8S1RS92mGx4abjxA3wgQTf5IMAv8XOfXRMuxVrKLJntXTyPXwdXoNIW88IrENFFXpgvzT26HQodV5/KtORQrJmcC/sQfSa7w+efdoPSYHkMBE0/Zq7J1/XL7bLuzdlm/EwCUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014975; c=relaxed/simple;
	bh=JEWlAQKLoU0arL2fXui4XtAd0zqAMT6RO2YjjIM9g8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o53SNECIwddRu8u478lYCfJsyRS/QjxGKSviw6RFeP752BJNh96fHZyZLFQ3X2fpEkQ/t90oU9Et2GPVwGac/vWibBgcmhTiIMxHMsc/L+09iRF5PktZVejbAUaDD/uBBA04JMw9yl0TaumMOp4jikXkgudKYBuqbAVv3JQDBhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=puRj5zdq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2234e5347e2so91881055ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741014973; x=1741619773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jeiKOAhssO22mG+syoBELGAqYmpudt1t/PGbu5skEvc=;
        b=puRj5zdqxgChEkLofJaVyXMF/8pnNKmo8KUQGie2HlNh9XMmPy0Ik7zYE+Z0u2Di79
         pdQnh1aB3qpvExcyvQO0tkgrCXj844Jya+DRqWSOdGrw2xYPJBjoK+TlpELixGE8WKdK
         j8f5e5qgDyEvWVhTKLZmvpMxR67RwB6XDqxRtUWzC4Jz68aBfURBlpARTiCQ4yB97x5b
         3a3T3W8F6GiGEar9OeD+6GPAYUw1snDR7KRPo9GbivhQWeapg+A52DEGfQLiQwVk1cgY
         RCo8VvEkZN0EP8PsfNEvHTxv2IjudU5BTZIKxlm1tUVF9C2gq7crnKSFVjsJugF4+P4G
         yHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741014973; x=1741619773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeiKOAhssO22mG+syoBELGAqYmpudt1t/PGbu5skEvc=;
        b=WdwQeLaDVYrTfE/2wBTXErSppstS57Lit/tgOyVLXo/LZ+i5nUVIhh75M/upO1465e
         KiZcuIDRLnS1OaBtj8xz5yu1eNnYA4AmYuza0iowTBMssIrXV4QiDIF41Ro1N0uT9dN4
         7fKBwybPzHTdxKr76ZNOKMcijITr4EDLlDiDq2fwqq5MEFm3zglCp0JsXy5Nen7BYBgz
         +e4Y8sxWQabCO4E4IXA7du9ZRrOspl01B/cafmSHCLlTNhDNtFxsvWWv1pxyTal9b3LV
         uqwOCQQhDTK2GMEgKJmf+K2/SiXtwMRAhc+sVGZpKWzQYEMWGZ0l2qTJaekAd9vXbdeU
         lr7g==
X-Forwarded-Encrypted: i=1; AJvYcCWfitog/QhP6Zij1lxBvceGWnlPIAsWPvOaswr+bV/ZcnwHz3wdKFyb0KuLuaJImss9XpqrcIUDrhUSMpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/iF1t2bWZ1lsYp7MAeE+NsFhyEn8/55EukbjWaLeAPV4fCdcO
	Jy1/HJExHJddhruyclPO3r+KoFsWjyRRYDXspnMBPj9LhzHqrAFuabdWR5FuE1F0h8qAqnCgEmy
	CLjljzA==
X-Gm-Gg: ASbGncthlg5n/QMzIJKjBz3XuqC5AwO4/uSx7Pkau5P3F+fxtGzXmWKk5mM9j9VdaGM
	OBdumnsw68m30mSfFJDgh9ANrr4Gex1qxfCBv7m86QwGT7iLabEeM1MH0NzVY7R25OiIICgaWuM
	S4rmhw00RBuvJGyes2v0hqyug4l7Fza9Q81rZaT9QIgl60i+3EXUjqTQvDcQFvX9EKZMj1NzSsp
	Mgg8naRID3D44Lp2H6EhYqyuzLVc3KroXro3FcZLyT/0LM3+b+Ar9gDe13kTJHAeNO37D59w3ds
	ST5X5ALgFR7shGsOCV4sF8y+1wY+GyrmELyhZi56Og==
X-Google-Smtp-Source: AGHT+IH5vZiJbKOJSXP5L2myFgEt0PYILkd+ohhQaEBUZOw54AxUXPlrBE8hgjH2MJ/U71KQ//b5DQ==
X-Received: by 2002:a05:6a00:2348:b0:736:34ca:dee2 with SMTP id d2e1a72fcca58-73634cae088mr13842365b3a.4.1741014972660;
        Mon, 03 Mar 2025 07:16:12 -0800 (PST)
Received: from [127.0.1.1] ([112.64.60.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736584b3cffsm1851984b3a.4.2025.03.03.07.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:16:12 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 03 Mar 2025 23:14:41 +0800
Subject: [PATCH v8 12/15] drm/msm/dpu: blend pipes per mixer pairs config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v8-12-eb5df105c807@linaro.org>
References: <20250303-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v8-0-eb5df105c807@linaro.org>
In-Reply-To: <20250303-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v8-0-eb5df105c807@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741014878; l=4567;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=JEWlAQKLoU0arL2fXui4XtAd0zqAMT6RO2YjjIM9g8k=;
 b=AxvNzZOHRxRqfSUYcGuJVLNcnZkltBBp9yJw59rQsvtUUvXlXZJbkA75caXwJFHPVQGmPeykn
 kO8hGewUF+ACdwFfmNV0Co0DyjUalCblP9T8hcaRRKJO0cHTsg2nfKG
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Currently, only 2 pipes are used at most for a plane. A stage structure
describes the configuration for a mixer pair. So only one stage is needed
for current usage cases. The quad-pipe case will be added in future and 2
stages are used in the case. So extend the stage to an array with array
size STAGES_PER_PLANE and blend pipes per mixer pair with configuration
in the stage structure.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 46 +++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 81474823e6799132db71c9712046d359e3535d90..6fbe42e8988edac7e7917ae8de180aefdaf443e9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -392,7 +392,7 @@ static void _dpu_crtc_program_lm_output_roi(struct drm_crtc *crtc)
 static void _dpu_crtc_blend_setup_pipe(struct drm_crtc *crtc,
 				       struct drm_plane *plane,
 				       struct dpu_crtc_mixer *mixer,
-				       u32 num_mixers,
+				       u32 lms_in_stage,
 				       enum dpu_stage stage,
 				       const struct msm_format *format,
 				       uint64_t modifier,
@@ -426,7 +426,7 @@ static void _dpu_crtc_blend_setup_pipe(struct drm_crtc *crtc,
 	stage_cfg->multirect_index[stage][stage_idx] = pipe->multirect_index;
 
 	/* blend config update */
-	for (lm_idx = 0; lm_idx < num_mixers; lm_idx++)
+	for (lm_idx = 0; lm_idx < lms_in_stage; lm_idx++)
 		mixer[lm_idx].lm_ctl->ops.update_pending_flush_sspp(mixer[lm_idx].lm_ctl, sspp_idx);
 }
 
@@ -442,7 +442,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 	const struct msm_format *format;
 	struct dpu_hw_ctl *ctl = mixer->lm_ctl;
 
-	uint32_t lm_idx, i;
+	uint32_t lm_idx, stage, i, pipe_idx, head_pipe_in_stage, lms_in_stage;
 	bool bg_alpha_enable = false;
 	DECLARE_BITMAP(fetch_active, SSPP_MAX);
 
@@ -463,15 +463,25 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 		if (pstate->stage == DPU_STAGE_BASE && format->alpha_enable)
 			bg_alpha_enable = true;
 
-		for (i = 0; i < PIPES_PER_PLANE; i++) {
-			if (!pstate->pipe[i].sspp)
-				continue;
-			set_bit(pstate->pipe[i].sspp->idx, fetch_active);
-			_dpu_crtc_blend_setup_pipe(crtc, plane,
-						   mixer, cstate->num_mixers,
-						   pstate->stage,
-						   format, fb ? fb->modifier : 0,
-						   &pstate->pipe[i], i, stage_cfg);
+		/* loop pipe per mixer pair with config in stage structure */
+		for (stage = 0; stage < STAGES_PER_PLANE; stage++) {
+			head_pipe_in_stage = stage * PIPES_PER_STAGE;
+			for (i = 0; i < PIPES_PER_STAGE; i++) {
+				pipe_idx = i + head_pipe_in_stage;
+				if (!pstate->pipe[pipe_idx].sspp)
+					continue;
+
+				lms_in_stage = min(cstate->num_mixers - (stage * PIPES_PER_STAGE),
+						  PIPES_PER_STAGE);
+				set_bit(pstate->pipe[pipe_idx].sspp->idx, fetch_active);
+				_dpu_crtc_blend_setup_pipe(crtc, plane,
+							   &mixer[head_pipe_in_stage],
+							   lms_in_stage,
+							   pstate->stage,
+							   format, fb ? fb->modifier : 0,
+							   &pstate->pipe[pipe_idx], i,
+							   &stage_cfg[stage]);
+			}
 		}
 
 		/* blend config update */
@@ -503,7 +513,7 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 	struct dpu_crtc_mixer *mixer = cstate->mixers;
 	struct dpu_hw_ctl *ctl;
 	struct dpu_hw_mixer *lm;
-	struct dpu_hw_stage_cfg stage_cfg;
+	struct dpu_hw_stage_cfg stage_cfg[STAGES_PER_PLANE];
 	int i;
 
 	DRM_DEBUG_ATOMIC("%s\n", dpu_crtc->name);
@@ -516,9 +526,9 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 	}
 
 	/* initialize stage cfg */
-	memset(&stage_cfg, 0, sizeof(struct dpu_hw_stage_cfg));
+	memset(&stage_cfg, 0, sizeof(stage_cfg));
 
-	_dpu_crtc_blend_setup_mixer(crtc, dpu_crtc, mixer, &stage_cfg);
+	_dpu_crtc_blend_setup_mixer(crtc, dpu_crtc, mixer, stage_cfg);
 
 	for (i = 0; i < cstate->num_mixers; i++) {
 		ctl = mixer[i].lm_ctl;
@@ -535,8 +545,12 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 			mixer[i].mixer_op_mode,
 			ctl->idx - CTL_0);
 
+		/*
+		 * call dpu_hw_ctl_setup_blendstage() to blend layers per stage cfg.
+		 * stage data is shared between PIPES_PER_STAGE pipes.
+		 */
 		ctl->ops.setup_blendstage(ctl, mixer[i].hw_lm->idx,
-			&stage_cfg);
+			&stage_cfg[i / PIPES_PER_STAGE]);
 	}
 }
 

-- 
2.34.1


