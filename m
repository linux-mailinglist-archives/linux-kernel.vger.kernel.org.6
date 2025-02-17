Return-Path: <linux-kernel+bounces-518096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06554A389FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B971892B42
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A54D22A4E9;
	Mon, 17 Feb 2025 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XW4k/9UB"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA2522A1D2
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810539; cv=none; b=fmH5Vobzbw6QmL/pK7EZmGCOUSQYCuvKTpSYg0+ZhUmc4OUzePsZ14Bf0tQz0myCPLS5AJT3bJt4+CjROalyLSfooPIlRlEO+auHFebQUCcCbEB6mkCqZaV4Is3smz+ujwCnZMfGuPIctzJgIZ+XjS/af0g74SqQV6dE6sOoiPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810539; c=relaxed/simple;
	bh=PobwmYdzzRqN5CO/uFpBiNP5UMSqbCiwqI7SwEWPUwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KRV6wCSQcHA/Ps8wWuoU7QMA8W2WXVWboMSz4o7fJmeln4XmBGoBm0kcEQzQPHuF2v2HkU/u+1zfBccEQgJPIl2gCuffcttqlkDZQ+d3npxalBNd9KywgAKotBPf7PPqJamMaUGbyggn+u9U4BB9jJ4VM/Wd8z1OM+Jy9pvbbXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XW4k/9UB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5deb440675eso698957a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739810535; x=1740415335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZbUZM+KRDVAkDSEKXcjcElT785Yt0BkHHCIYIyK7Z8=;
        b=XW4k/9UBof4uMlPBdvU61WKs68XgLcd4Jx9z84B8qh9JmjbmSlWxmrEwvFTw6eSHwv
         WIufZbOe4WLIV9JH3W5vPY59KLV4HDnd1gvYAHN0l1MKFgpIFGgk7B0KPRH7eaeIa8LO
         7EWQdcIMqx3MyE86ruk8mCbi0BWBBGzSQOr4Bce5M42T72h7UtVecSpDh8BFnBsbHxeg
         Cap+ieMqiwwcyhx3mvMLMfezXZoor2mR/QBKYtUxqfQ9JPL8uGNzCxstHBP9jbbR5CzM
         Iee5BpHrSZSrULAbvtBD1ySriXaGHLO+wf/wmiu8yMc/bSvJfrnbEy9RHv96810KFz3s
         g/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810535; x=1740415335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZbUZM+KRDVAkDSEKXcjcElT785Yt0BkHHCIYIyK7Z8=;
        b=Q7GR9bd7g/tJS0f20fw+kTgYC9Gun11WaEWfN/K1nysnHXQJbG4Pi35f9wdj7dKi93
         8U/n+/sLhje5Qit+osQxZqx0JD8q3o/xpQobRfevtfS4JDzY1VKyBfhlQAefgLN9eSH5
         ioZsSLg4xYXGXGNl5LVi/aBaDqzLVl+odA/HVwyDRfjhkbe5Mbd5FxYBZIR80PQ16EKq
         Se9SbRdB2FWxV//bcvvmuaQdLrHA26aradg8HFi77ffKr46TBYEHae43JpDROLOzdw6L
         Lk5Wg9qeVgCzon7FJbms3+48yp61bjvJXTptNotrxc24p9UfSwkPfbuh8D0eFogVzy7h
         xWsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzdB3eu+EKXpOM9WifjeLaYIeMqzj+WKvAhX9AcT6Asi6If4DRkF//gEEX/4xtsgPacmqAkFJfLuIRxKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhZmzs/w11ULXz2vydK/mggsfDbeC0nKBpHD3IRDEP37M3yTom
	CuAB907JuLrunFLM15PnfvKdCH0e58nvssUcBcqtz16DFxbicrB4Ja/zfDJQrP4=
X-Gm-Gg: ASbGnctMgq1mm7EPwY/Tz1Z2WovHcLo5MMF+Hi63e8CifZpFAfT5ziGx49hD2vwIzc5
	snih0a9FCjWR9TFYJjxx1d+7p1OvRThCXUO6CWcN7/z7upTwhjbFfuUSb0MYYoFdnFd+vNizRAD
	nYLU2CpoZI0Us5QnK4F8PfHh44Xge4auo+vPMoeg79h+9RMOS04R54XNR0XWITgc3c/EanyCOkU
	1cUAqzUuh1lZX5goerPs4UzmauA9akpFxeldqA/+bdvWsjUz4pg7nPXLF2rmiwtAueWjAsWcck9
	7y+uJKL7N4X+kAk/BZC8Sp7Y+Hf5knw=
X-Google-Smtp-Source: AGHT+IHJxTDFuBrHOHDZMH3AITUYqDUx//9Ghz6xXX1DL8AOZQFEu8CyC3LUNC8qJz6rZboiotGoew==
X-Received: by 2002:a05:6402:34d1:b0:5de:a6a8:5ec3 with SMTP id 4fb4d7f45d1cf-5e0361a9bc7mr4002036a12.7.1739810534941;
        Mon, 17 Feb 2025 08:42:14 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbac781b78sm82647966b.60.2025.02.17.08.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:42:14 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 17 Feb 2025 17:41:36 +0100
Subject: [PATCH v2 15/16] drm/msm/dpu: Implement new v12.0 DPU differences
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-b4-sm8750-display-v2-15-d201dcdda6a4@linaro.org>
References: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
In-Reply-To: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=21162;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=PobwmYdzzRqN5CO/uFpBiNP5UMSqbCiwqI7SwEWPUwY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBns2bEC2GSr+KrOt2OU/JhkQpmsyyNlIPslW5oW
 9puF2AKnxeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7NmxAAKCRDBN2bmhouD
 13x+D/0aZJQsnojU+1i/ogSUArC/H9JMrZwx73K4KOFCVSGAMp1CegGG1M1JF9oUTYK9JqGbbxl
 Vzd7kOMFokRvgFNlgy3V4a0Y61eGZjVpvGmq7n8wDiWdHJcJmojdmm5iR+QGJUMsEeCjNap5+W6
 GdYUx+x4JXI4AMMNfoiaKUzWN1K8UeNdVWLMTCXlNVG6OvgdGIPezPW6pLgHaoYX+wk6tZceb7b
 ckV0PCKltmgIQbpRyBei1Nw6tRQuXwQlKT8Gst/g7EO+5/WdZK3bwSY9uXHHNe/gpDB2JTSAvSH
 3YBLQsA8euX9zNO7LM5j/Fp7lRIv2n3R4lQgBuFMAi3lSg2AEfeEnJaF59iEQeprtYkffkL0q5D
 SdWkK30ZOndsGXqDHiL5QmFiL49aGqqw8QhgZ/4h1uU/TbNU+WaLBRNtP8Nwx+E7e2GWtFzFi6I
 X2x+FIwzl8aFD0YOF0HenWpZwHq9qKKk3Ep+kLsNj+K3npLf0JRdk878feaIarMFH5tRJvLINJS
 zKvHZb59LqIdsO3hsjmR+wM6mS5FMaITQFAH0wb2FqAN6QPjVsVXo+C+8djUb5814IO0oTE5eqQ
 oMFGKybQUb+uSm0ZFoDRG5euNHPAmM6g87pTkN09Fd0SNjqFfDlPwaNjcUtNqzowjKI8BhzMd0G
 lh/oaaM816EM7TQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Implement new features and differences coming in v12.0 of DPU present on
Qualcomm SM8750 SoC:
1. 10-bit color alpha.
2. New CTL_PIPE_ACTIVE and CTL_LAYER_ACTIVE registers for pipes and
   layer mixers.
2. Several differences in LM registers (also changed offsets) for LM
   crossbar hardware changes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. New patch
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  49 +++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  12 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c  |  59 +++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h  |  17 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c   | 210 +++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h   |  18 +++
 6 files changed, 350 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 7de79696a21e58a4c640f00265610ccce8b5d253..ecb52a0eec8d5a5e91ab6305046dd1adddd77cf0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -319,15 +319,21 @@ static bool dpu_crtc_get_scanout_position(struct drm_crtc *crtc,
 	return true;
 }
 
-static void _dpu_crtc_setup_blend_cfg(struct dpu_crtc_mixer *mixer,
-		struct dpu_plane_state *pstate, const struct msm_format *format)
+static void _dpu_crtc_setup_blend_cfg(const struct dpu_hw_ctl *ctl,
+				      struct dpu_crtc_mixer *mixer,
+				      struct dpu_plane_state *pstate,
+				      const struct msm_format *format)
 {
 	struct dpu_hw_mixer *lm = mixer->hw_lm;
 	uint32_t blend_op;
-	uint32_t fg_alpha, bg_alpha;
+	uint32_t fg_alpha, bg_alpha, max_alpha;
 
 	fg_alpha = pstate->base.alpha >> 8;
-	bg_alpha = 0xff - fg_alpha;
+	if (ctl->mdss_ver->core_major_ver < 12)
+		max_alpha = 0xff;
+	else
+		max_alpha = 0x3ff;
+	bg_alpha = max_alpha - fg_alpha;
 
 	/* default to opaque blending */
 	if (pstate->base.pixel_blend_mode == DRM_MODE_BLEND_PIXEL_NONE ||
@@ -337,7 +343,7 @@ static void _dpu_crtc_setup_blend_cfg(struct dpu_crtc_mixer *mixer,
 	} else if (pstate->base.pixel_blend_mode == DRM_MODE_BLEND_PREMULTI) {
 		blend_op = DPU_BLEND_FG_ALPHA_FG_CONST |
 			DPU_BLEND_BG_ALPHA_FG_PIXEL;
-		if (fg_alpha != 0xff) {
+		if (fg_alpha != max_alpha) {
 			bg_alpha = fg_alpha;
 			blend_op |= DPU_BLEND_BG_MOD_ALPHA |
 				    DPU_BLEND_BG_INV_MOD_ALPHA;
@@ -348,7 +354,7 @@ static void _dpu_crtc_setup_blend_cfg(struct dpu_crtc_mixer *mixer,
 		/* coverage blending */
 		blend_op = DPU_BLEND_FG_ALPHA_FG_PIXEL |
 			DPU_BLEND_BG_ALPHA_FG_PIXEL;
-		if (fg_alpha != 0xff) {
+		if (fg_alpha != max_alpha) {
 			bg_alpha = fg_alpha;
 			blend_op |= DPU_BLEND_FG_MOD_ALPHA |
 				    DPU_BLEND_FG_INV_MOD_ALPHA |
@@ -446,8 +452,10 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 	uint32_t lm_idx;
 	bool bg_alpha_enable = false;
 	DECLARE_BITMAP(active_fetch, SSPP_MAX);
+	DECLARE_BITMAP(active_pipes, SSPP_MAX);
 
 	memset(active_fetch, 0, sizeof(active_fetch));
+	memset(active_pipes, 0, sizeof(active_pipes));
 	drm_atomic_crtc_for_each_plane(plane, crtc) {
 		state = plane->state;
 		if (!state)
@@ -465,6 +473,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 			bg_alpha_enable = true;
 
 		set_bit(pstate->pipe.sspp->idx, active_fetch);
+		set_bit(pstate->pipe.sspp->idx, active_pipes);
 		_dpu_crtc_blend_setup_pipe(crtc, plane,
 					   mixer, cstate->num_mixers,
 					   pstate->stage,
@@ -473,6 +482,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 
 		if (pstate->r_pipe.sspp) {
 			set_bit(pstate->r_pipe.sspp->idx, active_fetch);
+			set_bit(pstate->r_pipe.sspp->idx, active_pipes);
 			_dpu_crtc_blend_setup_pipe(crtc, plane,
 						   mixer, cstate->num_mixers,
 						   pstate->stage,
@@ -482,7 +492,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 
 		/* blend config update */
 		for (lm_idx = 0; lm_idx < cstate->num_mixers; lm_idx++) {
-			_dpu_crtc_setup_blend_cfg(mixer + lm_idx, pstate, format);
+			_dpu_crtc_setup_blend_cfg(ctl, mixer + lm_idx, pstate, format);
 
 			if (bg_alpha_enable && !format->alpha_enable)
 				mixer[lm_idx].mixer_op_mode = 0;
@@ -495,6 +505,9 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 	if (ctl->ops.set_active_fetch_pipes)
 		ctl->ops.set_active_fetch_pipes(ctl, active_fetch);
 
+	if (ctl->ops.set_active_pipes)
+		ctl->ops.set_active_pipes(ctl, active_pipes);
+
 	_dpu_crtc_program_lm_output_roi(crtc);
 }
 
@@ -510,6 +523,7 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 	struct dpu_hw_ctl *ctl;
 	struct dpu_hw_mixer *lm;
 	struct dpu_hw_stage_cfg stage_cfg;
+	DECLARE_BITMAP(active_lms, LM_MAX);
 	int i;
 
 	DRM_DEBUG_ATOMIC("%s\n", dpu_crtc->name);
@@ -519,10 +533,18 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 		if (mixer[i].lm_ctl->ops.clear_all_blendstages)
 			mixer[i].lm_ctl->ops.clear_all_blendstages(
 					mixer[i].lm_ctl);
+		if (mixer[i].lm_ctl->ops.set_active_fetch_pipes)
+			mixer[i].lm_ctl->ops.set_active_fetch_pipes(mixer[i].lm_ctl, NULL);
+		if (mixer[i].lm_ctl->ops.set_active_pipes)
+			mixer[i].lm_ctl->ops.set_active_pipes(mixer[i].lm_ctl, NULL);
+
+		if (mixer[i].hw_lm->ops.clear_all_blendstages)
+			mixer[i].hw_lm->ops.clear_all_blendstages(mixer[i].hw_lm);
 	}
 
 	/* initialize stage cfg */
 	memset(&stage_cfg, 0, sizeof(struct dpu_hw_stage_cfg));
+	memset(active_lms, 0, sizeof(active_lms));
 
 	_dpu_crtc_blend_setup_mixer(crtc, dpu_crtc, mixer, &stage_cfg);
 
@@ -536,13 +558,22 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 		ctl->ops.update_pending_flush_mixer(ctl,
 			mixer[i].hw_lm->idx);
 
+		set_bit(lm->idx, active_lms);
+		if (ctl->ops.set_active_lms)
+			ctl->ops.set_active_lms(ctl, active_lms);
+
 		DRM_DEBUG_ATOMIC("lm %d, op_mode 0x%X, ctl %d\n",
 			mixer[i].hw_lm->idx - LM_0,
 			mixer[i].mixer_op_mode,
 			ctl->idx - CTL_0);
 
-		ctl->ops.setup_blendstage(ctl, mixer[i].hw_lm->idx,
-			&stage_cfg);
+		if (ctl->ops.setup_blendstage)
+			ctl->ops.setup_blendstage(ctl, mixer[i].hw_lm->idx,
+						  &stage_cfg);
+
+		if (lm->ops.setup_blendstage)
+			lm->ops.setup_blendstage(lm, mixer[i].hw_lm->idx,
+						 &stage_cfg);
 	}
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 5172ab4dea995a154cd88d05c3842d7425fc34ce..56b858011d02cb20c25053fa90932b1478286501 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2199,6 +2199,18 @@ static void dpu_encoder_helper_reset_mixers(struct dpu_encoder_phys *phys_enc)
 		/* clear all blendstages */
 		if (phys_enc->hw_ctl->ops.setup_blendstage)
 			phys_enc->hw_ctl->ops.setup_blendstage(ctl, hw_mixer[i]->idx, NULL);
+
+		if (hw_mixer[i]->ops.clear_all_blendstages)
+			hw_mixer[i]->ops.clear_all_blendstages(hw_mixer[i]);
+
+		if (ctl->ops.set_active_lms)
+			ctl->ops.set_active_lms(ctl, NULL);
+
+		if (ctl->ops.set_active_fetch_pipes)
+			ctl->ops.set_active_fetch_pipes(ctl, NULL);
+
+		if (ctl->ops.set_active_pipes)
+			ctl->ops.set_active_pipes(ctl, NULL);
 	}
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 2e1e22589f730d1a60c3cbf6ad6b6aeaea38c6fb..8b6b60f5e6206078f1df98b20f77ed91049e6ef0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -40,6 +40,8 @@
 #define   CTL_INTF_FLUSH                0x110
 #define   CTL_CDM_FLUSH                0x114
 #define   CTL_PERIPH_FLUSH              0x128
+#define   CTL_PIPE_ACTIVE               0x12C
+#define   CTL_LAYER_ACTIVE              0x130
 #define   CTL_INTF_MASTER               0x134
 #define   CTL_DSPP_n_FLUSH(n)           ((0x13C) + ((n) * 4))
 
@@ -61,6 +63,8 @@ static const u32 fetch_tbl[SSPP_MAX] = {CTL_INVALID_BIT, 16, 17, 18, 19,
 	CTL_INVALID_BIT, CTL_INVALID_BIT, CTL_INVALID_BIT, CTL_INVALID_BIT, 0,
 	1, 2, 3, 4, 5};
 
+static const u32 lm_tbl[LM_MAX] = {CTL_INVALID_BIT, 0, 1, 2, 3, 4, 5, 6, 7};
+
 static int _mixer_stages(const struct dpu_lm_cfg *mixer, int count,
 		enum dpu_lm lm)
 {
@@ -648,7 +652,17 @@ static void dpu_hw_ctl_reset_intf_cfg_v1(struct dpu_hw_ctl *ctx,
 				merge3d_active);
 	}
 
-	dpu_hw_ctl_clear_all_blendstages(ctx);
+	if (ctx->ops.clear_all_blendstages)
+		ctx->ops.clear_all_blendstages(ctx);
+
+	if (ctx->ops.set_active_lms)
+		ctx->ops.set_active_lms(ctx, NULL);
+
+	if (ctx->ops.set_active_fetch_pipes)
+		ctx->ops.set_active_fetch_pipes(ctx, NULL);
+
+	if (ctx->ops.set_active_pipes)
+		ctx->ops.set_active_pipes(ctx, NULL);
 
 	if (cfg->intf) {
 		intf_active = DPU_REG_READ(c, CTL_INTF_ACTIVE);
@@ -692,6 +706,40 @@ static void dpu_hw_ctl_set_active_fetch_pipes(struct dpu_hw_ctl *ctx,
 	DPU_REG_WRITE(&ctx->hw, CTL_FETCH_PIPE_ACTIVE, val);
 }
 
+static void dpu_hw_ctl_set_active_pipes(struct dpu_hw_ctl *ctx,
+					unsigned long *active_pipes)
+{
+	int i;
+	u32 val = 0;
+
+	if (active_pipes) {
+		for (i = 0; i < SSPP_MAX; i++) {
+			if (test_bit(i, active_pipes) &&
+			    fetch_tbl[i] != CTL_INVALID_BIT)
+				val |= BIT(fetch_tbl[i]);
+		}
+	}
+
+	DPU_REG_WRITE(&ctx->hw, CTL_PIPE_ACTIVE, val);
+}
+
+static void dpu_hw_ctl_set_active_lms(struct dpu_hw_ctl *ctx,
+				      unsigned long *active_lms)
+{
+	int i;
+	u32 val = 0;
+
+	if (active_lms) {
+		for (i = LM_0; i < LM_MAX; i++) {
+			if (test_bit(i, active_lms) &&
+			    lm_tbl[i] != CTL_INVALID_BIT)
+				val |= BIT(lm_tbl[i]);
+		}
+	}
+
+	DPU_REG_WRITE(&ctx->hw, CTL_LAYER_ACTIVE, val);
+}
+
 /**
  * dpu_hw_ctl_init() - Initializes the ctl_path hw driver object.
  * Should be called before accessing any ctl_path register.
@@ -754,8 +802,13 @@ struct dpu_hw_ctl *dpu_hw_ctl_init(struct drm_device *dev,
 	c->ops.trigger_pending = dpu_hw_ctl_trigger_pending;
 	c->ops.reset = dpu_hw_ctl_reset_control;
 	c->ops.wait_reset_status = dpu_hw_ctl_wait_reset_status;
-	c->ops.clear_all_blendstages = dpu_hw_ctl_clear_all_blendstages;
-	c->ops.setup_blendstage = dpu_hw_ctl_setup_blendstage;
+	if (mdss_ver->core_major_ver < 12) {
+		c->ops.clear_all_blendstages = dpu_hw_ctl_clear_all_blendstages;
+		c->ops.setup_blendstage = dpu_hw_ctl_setup_blendstage;
+	} else {
+		c->ops.set_active_pipes = dpu_hw_ctl_set_active_pipes;
+		c->ops.set_active_lms = dpu_hw_ctl_set_active_lms;
+	}
 	c->ops.update_pending_flush_sspp = dpu_hw_ctl_update_pending_flush_sspp;
 	c->ops.update_pending_flush_mixer = dpu_hw_ctl_update_pending_flush_mixer;
 	if (mdss_ver->core_major_ver >= 7)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
index b8bd5b22c5f8dadd01c16c352efef4063f2614a6..7175dfecea1057db3fa16fbfd4139182a53d1760 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
@@ -245,6 +245,23 @@ struct dpu_hw_ctl_ops {
 
 	void (*set_active_fetch_pipes)(struct dpu_hw_ctl *ctx,
 		unsigned long *fetch_active);
+
+	/**
+	 * Set active pipes attached to this CTL
+	 * @ctx: ctl path ctx pointer
+	 * @active_pipes: bitmap of enum dpu_sspp
+	 */
+	void (*set_active_pipes)(struct dpu_hw_ctl *ctx,
+				 unsigned long *active_pipes);
+
+	/**
+	 * Set active layer mixers attached to this CTL
+	 * @ctx: ctl path ctx pointer
+	 * @active_lms: bitmap of enum dpu_lm
+	 */
+	void (*set_active_lms)(struct dpu_hw_ctl *ctx,
+			       unsigned long *active_lms);
+
 };
 
 /**
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
index 3bfb61cb83672dca4236bdbbbfb1e442223576d2..c631b4ae8dc13b7b18fab4721a7b2f2d97da717a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
@@ -19,12 +19,28 @@
 
 /* These register are offset to mixer base + stage base */
 #define LM_BLEND0_OP                     0x00
+
+/* <v12 DPU with offset to mixer base + stage base */
 #define LM_BLEND0_CONST_ALPHA            0x04
 #define LM_FG_COLOR_FILL_COLOR_0         0x08
 #define LM_FG_COLOR_FILL_COLOR_1         0x0C
 #define LM_FG_COLOR_FILL_SIZE            0x10
 #define LM_FG_COLOR_FILL_XY              0x14
 
+/* >= v12 DPU */
+#define LM_BG_SRC_SEL_V12		0x14
+#define LM_BG_SRC_SEL_V12_RESET_VALUE	0x0000C0C0
+#define LM_BORDER_COLOR_0_V12		0x1C
+#define LM_BORDER_COLOR_1_V12		0x20
+
+/* >= v12 DPU with offset to mixer base + stage base */
+#define LM_BLEND0_FG_SRC_SEL_V12	0x04
+#define LM_BLEND0_CONST_ALPHA_V12	0x08
+#define LM_FG_COLOR_FILL_COLOR_0_V12	0x0C
+#define LM_FG_COLOR_FILL_COLOR_1_V12	0x10
+#define LM_FG_COLOR_FILL_SIZE_V12	0x14
+#define LM_FG_COLOR_FILL_XY_V12		0x18
+
 #define LM_BLEND0_FG_ALPHA               0x04
 #define LM_BLEND0_BG_ALPHA               0x08
 
@@ -83,6 +99,22 @@ static void dpu_hw_lm_setup_border_color(struct dpu_hw_mixer *ctx,
 	}
 }
 
+static void dpu_hw_lm_setup_border_color_v12(struct dpu_hw_mixer *ctx,
+					     struct dpu_mdss_color *color,
+					     u8 border_en)
+{
+	struct dpu_hw_blk_reg_map *c = &ctx->hw;
+
+	if (border_en) {
+		DPU_REG_WRITE(c, LM_BORDER_COLOR_0_V12,
+			      (color->color_0 & 0x3ff) |
+			      ((color->color_1 & 0x3ff) << 16));
+		DPU_REG_WRITE(c, LM_BORDER_COLOR_1_V12,
+			      (color->color_2 & 0x3ff) |
+			      ((color->color_3 & 0x3ff) << 16));
+	}
+}
+
 static void dpu_hw_lm_setup_misr(struct dpu_hw_mixer *ctx)
 {
 	dpu_hw_setup_misr(&ctx->hw, LM_MISR_CTRL, 0x0);
@@ -112,6 +144,27 @@ static void dpu_hw_lm_setup_blend_config_combined_alpha(struct dpu_hw_mixer *ctx
 	DPU_REG_WRITE(c, LM_BLEND0_OP + stage_off, blend_op);
 }
 
+static void
+dpu_hw_lm_setup_blend_config_combined_alpha_v12(struct dpu_hw_mixer *ctx,
+						u32 stage, u32 fg_alpha,
+						u32 bg_alpha, u32 blend_op)
+{
+	struct dpu_hw_blk_reg_map *c = &ctx->hw;
+	int stage_off;
+	u32 const_alpha;
+
+	if (stage == DPU_STAGE_BASE)
+		return;
+
+	stage_off = _stage_offset(ctx, stage);
+	if (WARN_ON(stage_off < 0))
+		return;
+
+	const_alpha = (bg_alpha & 0x3ff) | ((fg_alpha & 0x3ff) << 16);
+	DPU_REG_WRITE(c, LM_BLEND0_CONST_ALPHA_V12 + stage_off, const_alpha);
+	DPU_REG_WRITE(c, LM_BLEND0_OP + stage_off, blend_op);
+}
+
 static void dpu_hw_lm_setup_blend_config(struct dpu_hw_mixer *ctx,
 	u32 stage, u32 fg_alpha, u32 bg_alpha, u32 blend_op)
 {
@@ -144,6 +197,148 @@ static void dpu_hw_lm_setup_color3(struct dpu_hw_mixer *ctx,
 	DPU_REG_WRITE(c, LM_OP_MODE, op_mode);
 }
 
+static void dpu_hw_lm_setup_color3_v12(struct dpu_hw_mixer *ctx,
+				       uint32_t mixer_op_mode)
+{
+	struct dpu_hw_blk_reg_map *c = &ctx->hw;
+	int op_mode, stages, stage_off, i;
+
+	stages = ctx->cap->sblk->maxblendstages;
+	if (stages <= 0)
+		return;
+
+	for (i = DPU_STAGE_0; i <= stages; i++) {
+		stage_off = _stage_offset(ctx, i);
+		if (WARN_ON(stage_off < 0))
+			return;
+
+		/* set color_out3 bit in blend0_op when enabled in mixer_op_mode */
+		op_mode = DPU_REG_READ(c, LM_BLEND0_OP + stage_off);
+		if (mixer_op_mode & BIT(i))
+			op_mode |= BIT(30);
+		else
+			op_mode &= ~BIT(30);
+
+		DPU_REG_WRITE(c, LM_BLEND0_OP + stage_off, op_mode);
+	}
+}
+
+static int _set_staged_sspp(u32 stage, struct dpu_hw_stage_cfg *stage_cfg,
+			    int pipes_per_stage, u32 *value)
+{
+	int i;
+	u32 pipe_type = 0, pipe_id = 0, rec_id = 0;
+	u32 src_sel[PIPES_PER_STAGE];
+
+	*value = LM_BG_SRC_SEL_V12_RESET_VALUE;
+	if (!stage_cfg || !pipes_per_stage)
+		return 0;
+
+	for (i = 0; i < pipes_per_stage; i++) {
+		enum dpu_sspp pipe = stage_cfg->stage[stage][i];
+		enum dpu_sspp_multirect_index rect_index = stage_cfg->multirect_index[stage][i];
+
+		src_sel[i] = LM_BG_SRC_SEL_V12_RESET_VALUE;
+
+		if (!pipe)
+			continue;
+
+		/* translate pipe data to SWI pipe_type, pipe_id */
+		if (pipe >= SSPP_DMA0 && pipe <= SSPP_DMA5) {
+			pipe_type = 0;
+			pipe_id = pipe - SSPP_DMA0;
+		} else if (pipe >= SSPP_VIG0 && pipe <= SSPP_VIG3) {
+			pipe_type = 1;
+			pipe_id = pipe - SSPP_VIG0;
+		} else {
+			DPU_ERROR("invalid rec-%d pipe:%d\n", i, pipe);
+			return -EINVAL;
+		}
+
+		/* translate rec data to SWI rec_id */
+		if (rect_index == DPU_SSPP_RECT_SOLO || rect_index == DPU_SSPP_RECT_0) {
+			rec_id = 0;
+		} else if (rect_index == DPU_SSPP_RECT_1) {
+			rec_id = 1;
+		} else {
+			DPU_ERROR("invalid rec-%d rect_index:%d\n", i, rect_index);
+			rec_id = 0;
+		}
+
+		/* calculate SWI value for rec-0 and rec-1 and store it temporary buffer */
+		src_sel[i] = (((pipe_type & 0x3) << 6) | ((rec_id & 0x3) << 4) | (pipe_id & 0xf));
+	}
+
+	/* calculate final SWI register value for rec-0 and rec-1 */
+	*value = 0;
+	for (i = 0; i < pipes_per_stage; i++)
+		*value |= src_sel[i] << (i * 8);
+
+	return 0;
+}
+
+static int dpu_hw_lm_setup_blendstage(struct dpu_hw_mixer *ctx, enum dpu_lm lm,
+				      struct dpu_hw_stage_cfg *stage_cfg)
+{
+	struct dpu_hw_blk_reg_map *c = &ctx->hw;
+	int i, ret, stages, stage_off, pipes_per_stage;
+	u32 value;
+
+	stages = ctx->cap->sblk->maxblendstages;
+	if (stages <= 0)
+		return -EINVAL;
+
+	if (ctx->cap->sourcesplit)
+		pipes_per_stage = PIPES_PER_STAGE;
+	else
+		pipes_per_stage = 1;
+
+	/*
+	 * When stage configuration is empty, we can enable the
+	 * border color by setting the corresponding LAYER_ACTIVE bit
+	 * and un-staging all the pipes from the layer mixer.
+	 */
+	if (!stage_cfg)
+		DPU_REG_WRITE(c, LM_BG_SRC_SEL_V12, LM_BG_SRC_SEL_V12_RESET_VALUE);
+
+	for (i = DPU_STAGE_0; i <= stages; i++) {
+		stage_off = _stage_offset(ctx, i);
+		if (stage_off < 0)
+			return stage_off;
+
+		ret = _set_staged_sspp(i, stage_cfg, pipes_per_stage, &value);
+		if (ret)
+			return ret;
+
+		DPU_REG_WRITE(c, LM_BLEND0_FG_SRC_SEL_V12 + stage_off, value);
+	}
+
+	return 0;
+}
+
+static int dpu_hw_lm_clear_all_blendstages(struct dpu_hw_mixer *ctx)
+{
+	struct dpu_hw_blk_reg_map *c = &ctx->hw;
+	int i, stages, stage_off;
+
+	stages = ctx->cap->sblk->maxblendstages;
+	if (stages <= 0)
+		return -EINVAL;
+
+	DPU_REG_WRITE(c, LM_BG_SRC_SEL_V12, LM_BG_SRC_SEL_V12_RESET_VALUE);
+
+	for (i = DPU_STAGE_0; i <= stages; i++) {
+		stage_off = _stage_offset(ctx, i);
+		if (stage_off < 0)
+			return stage_off;
+
+		DPU_REG_WRITE(c, LM_BLEND0_FG_SRC_SEL_V12 + stage_off,
+			      LM_BG_SRC_SEL_V12_RESET_VALUE);
+	}
+
+	return 0;
+}
+
 /**
  * dpu_hw_lm_init() - Initializes the mixer hw driver object.
  * should be called once before accessing every mixer.
@@ -175,12 +370,21 @@ struct dpu_hw_mixer *dpu_hw_lm_init(struct drm_device *dev,
 	c->idx = cfg->id;
 	c->cap = cfg;
 	c->ops.setup_mixer_out = dpu_hw_lm_setup_out;
-	if (mdss_ver->core_major_ver >= 4)
+	if (mdss_ver->core_major_ver >= 12)
+		c->ops.setup_blend_config = dpu_hw_lm_setup_blend_config_combined_alpha_v12;
+	else if (mdss_ver->core_major_ver >= 4)
 		c->ops.setup_blend_config = dpu_hw_lm_setup_blend_config_combined_alpha;
 	else
 		c->ops.setup_blend_config = dpu_hw_lm_setup_blend_config;
-	c->ops.setup_alpha_out = dpu_hw_lm_setup_color3;
-	c->ops.setup_border_color = dpu_hw_lm_setup_border_color;
+	if (mdss_ver->core_major_ver < 12) {
+		c->ops.setup_alpha_out = dpu_hw_lm_setup_color3;
+		c->ops.setup_border_color = dpu_hw_lm_setup_border_color;
+	} else {
+		c->ops.setup_alpha_out = dpu_hw_lm_setup_color3_v12;
+		c->ops.setup_blendstage = dpu_hw_lm_setup_blendstage;
+		c->ops.clear_all_blendstages = dpu_hw_lm_clear_all_blendstages;
+		c->ops.setup_border_color = dpu_hw_lm_setup_border_color_v12;
+	}
 	c->ops.setup_misr = dpu_hw_lm_setup_misr;
 	c->ops.collect_misr = dpu_hw_lm_collect_misr;
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h
index fff1156add683fec8ce6785e7fe1d769d0de3fe0..1b9ecd082d7fd72b07008787e1caea968ed23376 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h
@@ -11,6 +11,7 @@
 #include "dpu_hw_util.h"
 
 struct dpu_hw_mixer;
+struct dpu_hw_stage_cfg;
 
 struct dpu_hw_mixer_cfg {
 	u32 out_width;
@@ -48,6 +49,23 @@ struct dpu_hw_lm_ops {
 	 */
 	void (*setup_alpha_out)(struct dpu_hw_mixer *ctx, uint32_t mixer_op);
 
+	/**
+	 * Clear layer mixer to pipe configuration
+	 * @ctx		: mixer ctx pointer
+	 * Returns: 0 on success or -error
+	 */
+	int (*clear_all_blendstages)(struct dpu_hw_mixer *ctx);
+
+	/**
+	 * Configure layer mixer to pipe configuration
+	 * @ctx		: mixer ctx pointer
+	 * @lm		: layer mixer enumeration
+	 * @stage_cfg	: blend stage configuration
+	 * Returns: 0 on success or -error
+	 */
+	int (*setup_blendstage)(struct dpu_hw_mixer *ctx, enum dpu_lm lm,
+				struct dpu_hw_stage_cfg *stage_cfg);
+
 	/**
 	 * setup_border_color : enable/disable border color
 	 */

-- 
2.43.0


