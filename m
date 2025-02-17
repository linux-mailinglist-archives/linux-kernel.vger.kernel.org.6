Return-Path: <linux-kernel+bounces-517815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F04DA38618
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5032A175516
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A08022331F;
	Mon, 17 Feb 2025 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tj8TLfXB"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55A021D58E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801885; cv=none; b=tanJ7flixN3kGfajW5IB3WCyOmpj8TZ2MR+BRfzImML3EkxlK0TrFvHK8iZ7WBLU5uVndx+Z458kJ6MB8dbX3nmqdO8HxJkr5tdhX93eUqgD7vEHW/hhJVsLVGVnFpHkr4qN+KMd0QG4alhih1+cxn6kGsPR7E3OuDxZJh4XyBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801885; c=relaxed/simple;
	bh=za/TOFi8Ltkq/gvZgJJVaOFS39iYDTLgxFY68FFY8wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ScIubwHm7/38dbNs3iwusuwEjELFV55UFh3LC6wG+Z6mcq6+fGbS82FweFX8/vKbhmgAa6KETiExUASEbDf+U+Q6/Eo8fXQiL0gStrMq0EW3AxMnenwV+ypVza5KtOFETMovnqehLjtFDPDfCAFouHPtBngnkPKn6T8Eu8gqYdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tj8TLfXB; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fc1c80cdc8so5906259a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739801883; x=1740406683; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bsnor74CQhC3dm1vS3cAkcfQD0HtQ2hwGtKG/dYKq8=;
        b=Tj8TLfXBQ8ar3GWosl95KHeX+To7VYj9ugwAk1/AYko3A5n1azsI640FNXyz0tLUDg
         2HRqLdWt87HSjegG5eOm6zMFemu757RXXIbxSmQcLEj+53q1mT4V/sZnLAV+ObLiI5+S
         0/oWCWwlR3FxbhTzSLoR2HYkqM8bKECpkpD72PVkDMHnlvelzk5thmBYjPysATVx9If0
         HWissOHLjEwl7rmMnL/zdO3I14i6nw4RiStex6xpsStkOPMYneyf9xTJ2jjYNCIy5iPt
         mOL92atrY/7+NMXVrdiaAOo67jYtDAn7H0S1nLBmDYD1fNRPryuI7Lm67DTsPVJOgxP+
         BzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801883; x=1740406683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bsnor74CQhC3dm1vS3cAkcfQD0HtQ2hwGtKG/dYKq8=;
        b=F8oPOlZpaX6AqW1bsNAJIXdqoTHKNQQ1yv0w7wHMMe7bJjr19jWg/E1RnsBXo51H9p
         ECiJLda8JeNj1vSgFD5BWFSgmo39urDC5057EJVZNsV5cjaWACmJWlbKcr66eEZpvnhB
         /W2FpfiwhbgAO953FgtHCr78sDDu67m7OJ0kEaVSl/Yfvt1fGFLbSf8bYx3Yi5GPJe7k
         XHaV8hyAR8odBFVvjRNZuv2wQDnvJJZv5wcNTRZKChrDeepZwrS/EVaKCXZ0Ok3rHvup
         lrdjdR6oQ2y4FG5Ec8fLYutjPO3iGfULn1rpaKo9IdqRUrhEVNWsH6MzAps1Q815KcXm
         /7VA==
X-Forwarded-Encrypted: i=1; AJvYcCVVaJY8ORt9dO+txPl4RYPgLGIlAnQBX4rfvKio3O258SEqAgeZdn5R2BbW1hELHO06jMio/lOkc4LPtrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn9KpNDFWtnW7266kW1q1qSsk2m+B0ycA6IQ5QhctuXlOeNKPq
	J01zQPXS0kqSaXsz0A6hH+ibEuzt/BmmM27h8dJR0iP+HpSdtP0h9gz+Db8Q5qXGlfS6lOAOVtV
	GvDdnbw==
X-Gm-Gg: ASbGnctFGyPFghX+VBWql3mlz+52RGDx97eBU7cCjPHC/Cbn21fdc9WzNj89ww1c5xH
	6IhSf0xOCK8RP+pnDPypXxBQVKeH3kNjJ0XOv3hZkTL6p///dybxbFwlH0DHhgz2dU99wHPXepN
	tmygBl3aInxmYYczHwHDkbglTAa/ASu4S+k0DFpqXG0nJPOpXZ4x1y0t4XE45fL/VyF/6Shg/dh
	7BOPs581f8Gp/F3q09HAmoQ18K6gNni4L3SaPEXdRQKMe2bhEJWF1K5rZ5AxTlx/UPSLK1WRZhW
	4RyHIGfUs6lX
X-Google-Smtp-Source: AGHT+IFJ/9Ln4TwrSqudr9CAmOr3hLNQnzqL5uAlkzh70visApKWFl7N8wdmJkJczYPFDyU6ThqvZw==
X-Received: by 2002:a17:90b:2d8d:b0:2ee:cded:9ac7 with SMTP id 98e67ed59e1d1-2fc40f23484mr15503162a91.20.1739801882505;
        Mon, 17 Feb 2025 06:18:02 -0800 (PST)
Received: from [127.0.1.1] ([112.65.12.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5366984sm71900845ad.60.2025.02.17.06.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:18:02 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 17 Feb 2025 22:16:01 +0800
Subject: [PATCH v6 12/15] drm/msm/dpu: blend pipes per mixer pairs config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-12-c11402574367@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739801787; l=4912;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=za/TOFi8Ltkq/gvZgJJVaOFS39iYDTLgxFY68FFY8wE=;
 b=C7E1sah3ieMMpeE1ANh60+/IurCFbYXHxwXfnJio68TiqyBOEpkITeLJFFx3ibfd5qr2sGquR
 UPyVMlAY0NOAoNWEAg9Ts/VZNhW0IImF1gtu5l8rZnjKy6zclvOlabG
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Currently, only 2 pipes are used at most for a plane. A stage structure
describes the configuration for a mixer pair. So only one stage is needed
for current usage cases. The quad-pipe case will be added in future and 2
stages are used in the case. So extend the stage to an array with array size
STAGES_PER_PLANE and blend pipes per mixer pair with configuration in the
stage structure.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 45 +++++++++++++++++++----------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  1 +
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 81474823e6799132db71c9712046d359e3535d90..50acaf25a3ffcc94354faaa816fe74566784844c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -401,7 +401,7 @@ static void _dpu_crtc_blend_setup_pipe(struct drm_crtc *crtc,
 				       struct dpu_hw_stage_cfg *stage_cfg
 				      )
 {
-	uint32_t lm_idx;
+	uint32_t lm_idx, lm_in_pair;
 	enum dpu_sspp sspp_idx;
 	struct drm_plane_state *state;
 
@@ -426,7 +426,8 @@ static void _dpu_crtc_blend_setup_pipe(struct drm_crtc *crtc,
 	stage_cfg->multirect_index[stage][stage_idx] = pipe->multirect_index;
 
 	/* blend config update */
-	for (lm_idx = 0; lm_idx < num_mixers; lm_idx++)
+	lm_in_pair = num_mixers > 1 ? 2 : 1;
+	for (lm_idx = 0; lm_idx < lm_in_pair; lm_idx++)
 		mixer[lm_idx].lm_ctl->ops.update_pending_flush_sspp(mixer[lm_idx].lm_ctl, sspp_idx);
 }
 
@@ -442,7 +443,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 	const struct msm_format *format;
 	struct dpu_hw_ctl *ctl = mixer->lm_ctl;
 
-	uint32_t lm_idx, i;
+	uint32_t lm_idx, stage, i, pipe_idx, head_pipe_in_stage;
 	bool bg_alpha_enable = false;
 	DECLARE_BITMAP(fetch_active, SSPP_MAX);
 
@@ -463,15 +464,22 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
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
+				set_bit(pstate->pipe[pipe_idx].sspp->idx, fetch_active);
+				_dpu_crtc_blend_setup_pipe(crtc, plane,
+							   &mixer[head_pipe_in_stage],
+							   cstate->num_mixers - (stage * PIPES_PER_STAGE),
+							   pstate->stage,
+							   format, fb ? fb->modifier : 0,
+							   &pstate->pipe[pipe_idx], i,
+							   &stage_cfg[stage]);
+			}
 		}
 
 		/* blend config update */
@@ -503,7 +511,7 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 	struct dpu_crtc_mixer *mixer = cstate->mixers;
 	struct dpu_hw_ctl *ctl;
 	struct dpu_hw_mixer *lm;
-	struct dpu_hw_stage_cfg stage_cfg;
+	struct dpu_hw_stage_cfg stage_cfg[STAGES_PER_PLANE];
 	int i;
 
 	DRM_DEBUG_ATOMIC("%s\n", dpu_crtc->name);
@@ -516,9 +524,9 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 	}
 
 	/* initialize stage cfg */
-	memset(&stage_cfg, 0, sizeof(struct dpu_hw_stage_cfg));
+	memset(&stage_cfg, 0, sizeof(stage_cfg));
 
-	_dpu_crtc_blend_setup_mixer(crtc, dpu_crtc, mixer, &stage_cfg);
+	_dpu_crtc_blend_setup_mixer(crtc, dpu_crtc, mixer, stage_cfg);
 
 	for (i = 0; i < cstate->num_mixers; i++) {
 		ctl = mixer[i].lm_ctl;
@@ -535,8 +543,13 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 			mixer[i].mixer_op_mode,
 			ctl->idx - CTL_0);
 
+		/*
+		 * call dpu_hw_ctl_setup_blendstage() to blend layers per stage cfg.
+		 * There are 4 mixers at most. The first 2 are for the left half, and
+		 * the later 2 are for the right half.
+		 */
 		ctl->ops.setup_blendstage(ctl, mixer[i].hw_lm->idx,
-			&stage_cfg);
+			&stage_cfg[i / PIPES_PER_STAGE]);
 	}
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index 5f010d36672cc6440c69779908b315aab285eaf0..64e220987be5682f26d02074505c5474a547a814 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -34,6 +34,7 @@
 #define DPU_MAX_PLANES			4
 #endif
 
+#define STAGES_PER_PLANE		2
 #define PIPES_PER_PLANE			2
 #define PIPES_PER_STAGE			2
 #ifndef DPU_MAX_DE_CURVES

-- 
2.34.1


