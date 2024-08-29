Return-Path: <linux-kernel+bounces-306658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AF69641C6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7CE1C24A18
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA8B18E37B;
	Thu, 29 Aug 2024 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rZPz17Sb"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DA41B4C29
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926901; cv=none; b=UIQD6RKnki0uz1DKYSmWMtFr9Q4vBIjjAubrQdjM11rE3ivqoonmUgVsX2gdl69y5rV4yD4OJphFogL41k7geIcYH2ugbzSh6SjRJLboeAoGI6UTAJU2zXB8CxdyvkVRbhdnw8+XYhpU61yhbXUtjoO5l1Z0jqhd7ujOlVrqQ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926901; c=relaxed/simple;
	bh=ISvroWQkoq1F0Dc7B+ldRkqGyVCkm1R5SOT45VY+lqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=htwCffDiUKWgI3a+oDkd2FG8+/1XGfCwRr98FoIauPanzvqSvYYOF9RodCBhpz8nyXjVvtYnfGv3y3DYOepQre2BG2QkiN5FJKmpQOmDMbL3cpZrox7zvFzaoXCt2xMkyO6DgxvtBBc/F5IwX3w18aRgXVBS0BDbBGo/SXU2ChU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rZPz17Sb; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70930972e19so172326a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724926899; x=1725531699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EK1k+f2ysbGl8LU/rYDG3ay57h/xaV/fco9SLUBD9EM=;
        b=rZPz17SbHiVMvsMJGoJ2D1SDx4h4cMSNCCTqlAh8RYLthXGMnONGcyK5AiMLtiydlP
         49Aka5SVbyZeOC6leYs+lx06GIFBsXmSqXghGjc2H4B853HTFuh4B/w+kWhmqCwxHe70
         1P7ezwr/F0ke3T8Trn1H23k2wYrwOd0eaZ9VzrUeWlGoTxl+xkqGacKnqf8OIUKI4LVU
         3emmz3yeYbCsU5heayxQ4tQrzazmx3k4A1Uaj9kS+qBegxND+2BRhRF0AZGRUPWlHZnv
         npfPJ9tlG8tzJ42ERdxgDIJRM9YpyYF2jipDd7Qh/SPg16mDk+7BoYtlEIp+OfTqJC7M
         g9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926899; x=1725531699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EK1k+f2ysbGl8LU/rYDG3ay57h/xaV/fco9SLUBD9EM=;
        b=AVkP0eq2hSg7+EOQpj5mdoqMSDrAKq9xfWLKYuQ+CS2i2YHI5ql1176BNt7h4cBw+f
         HeD2kyVR7EWq+vz+jAFoSB6QSs44KuJQ8xykw5Dm4Kb+UUuCskH4CJrDAawmIjUERx5y
         o8vj4iyBO+JeGgsCQTR3Uh+ARewSt9Se4VotVw8DIsXg8fpwArz4FmxBoEVSpb46274k
         pmOJADbImQfOFuf+Fd5Jv8b1JhQqdx63RPWrAzTK4fgGd+ndn8Vts5I0xCAh1GUIMJIN
         lxxj/x2594e8VIA+D7zUlAey6bbEswVqNc2GWNX56t5MXqDdssJrdI/khYnKr7/n9pIL
         dpkg==
X-Forwarded-Encrypted: i=1; AJvYcCV9MbrYsUaCzhJgxsES6BH6q0eHEwvexVkHLBGhfdBMl9T3SgogD8UZtCGI/HJTb/aUaA/U+KVUFVidvMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YykD/vCDyCy26sCZyAnsYNEZ5HloPsmmNoo4hUWBULn9YEWubFx
	86zIYW4ItviSPX/dhpjVHrEO7bXlE/ppgGnDadufW5ni57SDRK4a5b/huuqu9hk=
X-Google-Smtp-Source: AGHT+IHtCmZmbk18Vi3Dak2OwPt7OgHLCogUdc/r503bV/QzKkLfHYxNgEZbCcAkIvUU8w4p49d8kQ==
X-Received: by 2002:a05:6358:7e03:b0:1b3:9b14:9c94 with SMTP id e5c5f4694b2df-1b603bebbc9mr299226155d.3.1724926898755;
        Thu, 29 Aug 2024 03:21:38 -0700 (PDT)
Received: from [127.0.1.1] ([112.65.12.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d4df4sm891684a12.82.2024.08.29.03.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:21:38 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 29 Aug 2024 18:17:47 +0800
Subject: [PATCH 18/21] drm/msm/dpu: blend pipes by left and right
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-18-bdb05b4b5a2e@linaro.org>
References: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
In-Reply-To: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724926736; l=4932;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=ISvroWQkoq1F0Dc7B+ldRkqGyVCkm1R5SOT45VY+lqU=;
 b=+7LVoLcsKj5xmIck33DQjTT9nriKG4O0nLNgjDwuzuo9YnLw3DJ69ueeDe9MrwsQ3HlFqVasm
 qj+HtjZ5pOcCRK987BnH6B3l7ZB4CopzAzT+H+5jvcBDz7sXAj0z1R+
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Blend pipes by left and right. The first 2 pipes are for
left half screen and the later 2 pipes are for right in quad
pipe case.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 13 +++++++++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 10 +++++++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c  | 19 +++++++++++++++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h  |  4 +++-
 4 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 3b3cd17976082..8fd56f8f2851f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -574,8 +574,17 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 			mixer[i].mixer_op_mode,
 			ctl->idx - CTL_0);
 
-		ctl->ops.setup_blendstage(ctl, mixer[i].hw_lm->idx,
-			&stage_cfg);
+		/*
+		 * call dpu_hw_ctl_setup_blendstage() to blend layers per stage cfg.
+		 * There is 4 mixers at most. The first 2 are for the left half, and
+		 * the later 2 are for the right half.
+		 */
+		if (cstate->num_mixers == 4 && i >= 2)
+			ctl->ops.setup_blendstage(ctl, mixer[i].hw_lm->idx,
+				&stage_cfg, true);
+		else
+			ctl->ops.setup_blendstage(ctl, mixer[i].hw_lm->idx,
+				&stage_cfg, false);
 	}
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 76793201b984e..5d927f23e35b2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2049,9 +2049,13 @@ static void dpu_encoder_helper_reset_mixers(struct dpu_encoder_phys *phys_enc)
 		if (phys_enc->hw_ctl->ops.update_pending_flush_mixer)
 			phys_enc->hw_ctl->ops.update_pending_flush_mixer(ctl, hw_mixer[i]->idx);
 
-		/* clear all blendstages */
-		if (phys_enc->hw_ctl->ops.setup_blendstage)
-			phys_enc->hw_ctl->ops.setup_blendstage(ctl, hw_mixer[i]->idx, NULL);
+		/* clear all blendstages in both left and right */
+		if (phys_enc->hw_ctl->ops.setup_blendstage) {
+			phys_enc->hw_ctl->ops.setup_blendstage(ctl,
+				hw_mixer[i]->idx, NULL, false);
+			phys_enc->hw_ctl->ops.setup_blendstage(ctl,
+				hw_mixer[i]->idx, NULL, true);
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 602dfad127c2a..2072d18520326 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -478,12 +478,13 @@ static const struct ctl_blend_config ctl_blend_config[][2] = {
 };
 
 static void dpu_hw_ctl_setup_blendstage(struct dpu_hw_ctl *ctx,
-	enum dpu_lm lm, struct dpu_hw_stage_cfg *stage_cfg)
+	enum dpu_lm lm, struct dpu_hw_stage_cfg *stage_cfg, bool right)
 {
 	struct dpu_hw_blk_reg_map *c = &ctx->hw;
 	u32 mix, ext, mix_ext;
 	u32 mixercfg[5] = { 0 };
 	int i, j;
+	int pipe_start, pipe_end;
 	int stages;
 	int pipes_per_stage;
 
@@ -502,13 +503,27 @@ static void dpu_hw_ctl_setup_blendstage(struct dpu_hw_ctl *ctx,
 	if (!stage_cfg)
 		goto exit;
 
+	/*
+	 * For quad pipe case, blend pipes in right side separately. Otherwise,
+	 * all content is on the left half by defaut (no splitting case).
+	 */
+	if (!right) {
+		pipe_start = 0;
+		pipe_end = pipes_per_stage == PIPES_PER_STAGE ? 2 : 1;
+	} else {
+		pipe_start = 2;
+		pipe_end = PIPES_PER_STAGE;
+	}
+
+	DRM_DEBUG_ATOMIC("blend lm %d on the %s side\n", lm - LM_0,
+			 right ? "right" : "left");
 	for (i = 0; i <= stages; i++) {
 		/* overflow to ext register if 'i + 1 > 7' */
 		mix = (i + 1) & 0x7;
 		ext = i >= 7;
 		mix_ext = (i + 1) & 0xf;
 
-		for (j = 0 ; j < pipes_per_stage; j++) {
+		for (j = pipe_start; j < pipe_end; j++) {
 			enum dpu_sspp_multirect_index rect_index =
 				stage_cfg->multirect_index[i][j];
 			enum dpu_sspp pipe = stage_cfg->stage[i][j];
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
index 557ec9a924f81..2dac7885fc5e7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
@@ -25,6 +25,8 @@ struct dpu_hw_ctl;
 /**
  * struct dpu_hw_stage_cfg - blending stage cfg
  * @stage : SSPP_ID at each stage
+ *          The first 2 in PIPES_PER_STAGE(4) are for the first SSPP.
+ *          The 3rd/4th in PIPES_PER_STAGE(4) are for the 2nd SSPP.
  * @multirect_index: index of the rectangle of SSPP.
  */
 struct dpu_hw_stage_cfg {
@@ -243,7 +245,7 @@ struct dpu_hw_ctl_ops {
 	 * @cfg       : blend stage configuration
 	 */
 	void (*setup_blendstage)(struct dpu_hw_ctl *ctx,
-		enum dpu_lm lm, struct dpu_hw_stage_cfg *cfg);
+		enum dpu_lm lm, struct dpu_hw_stage_cfg *cfg, bool right);
 
 	void (*set_active_pipes)(struct dpu_hw_ctl *ctx,
 		unsigned long *fetch_active);

-- 
2.34.1


