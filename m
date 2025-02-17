Return-Path: <linux-kernel+bounces-517814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC41A38638
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40CF3B6888
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF25D223300;
	Mon, 17 Feb 2025 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PIS9VkwY"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7161C223328
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801877; cv=none; b=c4OOpyyrrBLanufnT94xF14fJPdW2AmphQ5SY2xeG+CgdETzStLottSwYQUPPVxclq07aT/WM5EOGIeKPWJFGugSZ7Fw93BMXn/dFzphu0RFPhPGnu1w84Ah5O2FXjKHDokrlGPZgCdC+LPjXW4mxm+4n8BKBnvwVEyhogHE1uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801877; c=relaxed/simple;
	bh=kXnt8vjlhZJf0cBxy7dPZ9teD4pxdE5E8edh78McPmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=meIJYX9Wqujmq8lWobtQ5ilxn+6VaNuDF/l5gSFm7SR/GC3NAFKeJDCy4bT2C+MNCIJ1rLpF+Vq0ams3eG4NDaFceT9Vj8VHI+Tgr9ppGtvXWOceG+qgBAllQEwzZEbEK5ZDXvDVH8N3szsFgpRPI5747YtYg6zBpBRSBGztaMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PIS9VkwY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fc4418c0e1so2594192a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739801875; x=1740406675; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17xwTof96P1WeJRZDnaNGAPL65jkXDHzo93BzhWGU/w=;
        b=PIS9VkwYnha9L/PbjXYFIBvpQspYW7cp1zDOgz9h4vbPU6oHZku8sE8jEFrlEZ7kcN
         IZ2w/ThvDifBpQCoyqb3O7eoBLeYbvizdYgB9HrjqPJ2us/Jq5kwxMLYN5ogkuTEdcL4
         9ZEyYictN3DQkz4Cio5XFySmJq4RoztGlMqpCJAmei0ni0BzDpxPA+Dr06xKNpS8DI2w
         BbMQeV7CzMv2XH7FqNkSg8R/UJmMTwdpaT5wgPSnYM9qmyksJbnMrEhl/TLVerqAXkmv
         2hx64tA2CJgQzZ8lZbBXY3PblWf03ANYh5ct9Bb3455F2x+MfzuQtW+wGs2Qp7QifMjp
         JnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801875; x=1740406675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17xwTof96P1WeJRZDnaNGAPL65jkXDHzo93BzhWGU/w=;
        b=Nn0LyxcZlaOv0DyFrGNjhNmzNeqiPcanGQZUYaOOZLknFfIaFKLe7QIyGZXSfgQ3B2
         sXLO1CwmL0oBgJXMDO8n6vf69INnP5tMuPNnl6FAqIULis6YnaEAbN5piy1f7DuqplNz
         bTQG+Ij1WhDTXX9SJIgXQ0Q/IlHTj0hlXOCIHaLsvRzxNL2Rq8tlk5om/6kB1JTjSJ+o
         btMg80GGlel/0Z6NsB1GRl1XW7+C5q7q9idEUh+be3s37JEcW2UL/wEoyPlLxqG12d6X
         qSModoICZEUOAj59Hc+WNN1op+xKk+qMYjyNt+qIuyONcWD1/EEBZsLFpEDhEdwYEJZ4
         3MjA==
X-Forwarded-Encrypted: i=1; AJvYcCWd9y5X0Cemj1wsmi65atrjjPw5JuBI3s6M0V7+EzZO/GEUnJGvAYzrXwZsaJHYjLxDXdfDTne8qv3JcAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcsF4XzB1a8Ihbasi+0nP0NSKjUUMinrXWIkyJ/tzDuQT/KucK
	xf+B0X0P1cXZqydGL0juqprysCD0CAlK5ziHYk0nVDtyqGn/e1FMQStfXGFIrS58BPrxv9yI7E/
	x3uJTNw==
X-Gm-Gg: ASbGncvW2s0Z4oNdjLJgpl9nk3qFiG+mrN7EVkQ5BgZgu40wlqSjcnpqdenj0MSWz5m
	EeTc8HRaMjIFE08MUdPbt+GGABoMmrL+BLpw0btAsCzvEzVaauUgoNn9uq/CmNDh1/Ns0Qxdpz/
	C+mxS2hhY1U7vsxANkQF0kguNIHekE5vfBqoWTF1BfdN/A6ilvjRvJpu3wGPtOSnThXiDXf69Mw
	5+RGgH574y/t/32wnn+x3MiIr+P57CXvtg/MUMTkOlFDTaMXDjRyMWU60frLf2AKMd8POnHWJcS
	hjhiwztb/MTt
X-Google-Smtp-Source: AGHT+IEOglgFQdwEzqJu0j6vzqPrWQpA1Rv1b6MLfNgp1HxIbPtNbvk1zzZbKbDMxDw3sPQl8uJ3aQ==
X-Received: by 2002:a17:90b:33d2:b0:2fa:3b6b:3370 with SMTP id 98e67ed59e1d1-2fc0fa67323mr28176314a91.16.1739801874684;
        Mon, 17 Feb 2025 06:17:54 -0800 (PST)
Received: from [127.0.1.1] ([112.65.12.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5366984sm71900845ad.60.2025.02.17.06.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:17:54 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 17 Feb 2025 22:16:00 +0800
Subject: [PATCH v6 11/15] drm/msm/dpu: split PIPES_PER_STAGE definition per
 plane and mixer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-11-c11402574367@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739801787; l=5119;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=kXnt8vjlhZJf0cBxy7dPZ9teD4pxdE5E8edh78McPmA=;
 b=7lROwJxUvGXLmgdTkBQXKTPkWeEJOP0YGX4u1+9yEBFcHRn/ToR34B7wTglXOmAn4UDHZc/Nb
 ztLvpT8P1aAAqVGQ/J/DMWS+FykETP3P15NusF/e1SgPRCIN+Xwqsxo
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

The stage contains configuration for a mixer pair. Currently the plane
supports just one stage and 2 pipes. Quad-pipe support will require
handling 2 stages and 4 pipes at the same time. In preparation for that
add a separate define, PIPES_PER_PLANE, to denote number of pipes that
can be used by the plane.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c   | 14 +++++++-------
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h   |  4 ++--
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 193818b02197d0737c86de7765d98732fa914e8e..81474823e6799132db71c9712046d359e3535d90 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -463,7 +463,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 		if (pstate->stage == DPU_STAGE_BASE && format->alpha_enable)
 			bg_alpha_enable = true;
 
-		for (i = 0; i < PIPES_PER_STAGE; i++) {
+		for (i = 0; i < PIPES_PER_PLANE; i++) {
 			if (!pstate->pipe[i].sspp)
 				continue;
 			set_bit(pstate->pipe[i].sspp->idx, fetch_active);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index ba7bb05efe9b8cac01a908e53121117e130f91ec..5f010d36672cc6440c69779908b315aab285eaf0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -34,6 +34,7 @@
 #define DPU_MAX_PLANES			4
 #endif
 
+#define PIPES_PER_PLANE			2
 #define PIPES_PER_STAGE			2
 #ifndef DPU_MAX_DE_CURVES
 #define DPU_MAX_DE_CURVES		3
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index ef44af5ab681c8f526333fa92531a2225983aa09..d67f2ad20b4754ca4bcb759a65a39628b7236b0f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -1078,7 +1078,7 @@ static int dpu_plane_virtual_atomic_check(struct drm_plane *plane,
 		 * resources are freed by dpu_crtc_assign_plane_resources(),
 		 * but clean them here.
 		 */
-		for (i = 0; i < PIPES_PER_STAGE; i++)
+		for (i = 0; i < PIPES_PER_PLANE; i++)
 			pstate->pipe[i].sspp = NULL;
 
 		return 0;
@@ -1129,7 +1129,7 @@ static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
 	pipe_cfg = &pstate->pipe_cfg[0];
 	r_pipe_cfg = &pstate->pipe_cfg[1];
 
-	for (i = 0; i < PIPES_PER_STAGE; i++)
+	for (i = 0; i < PIPES_PER_PLANE; i++)
 		pstate->pipe[i].sspp = NULL;
 
 	if (!plane_state->fb)
@@ -1241,7 +1241,7 @@ void dpu_plane_flush(struct drm_plane *plane)
 		/* force 100% alpha */
 		_dpu_plane_color_fill(pdpu, pdpu->color_fill, 0xFF);
 	else {
-		for (i = 0; i < PIPES_PER_STAGE; i++)
+		for (i = 0; i < PIPES_PER_PLANE; i++)
 			dpu_plane_flush_csc(pdpu, &pstate->pipe[i]);
 	}
 
@@ -1364,7 +1364,7 @@ static void dpu_plane_sspp_atomic_update(struct drm_plane *plane,
 			&fmt->pixel_format, MSM_FORMAT_IS_UBWC(fmt));
 
 	/* move the assignment here, to ease handling to another pairs later */
-	for (i = 0; i < PIPES_PER_STAGE; i++) {
+	for (i = 0; i < PIPES_PER_PLANE; i++) {
 		if (!pstate->pipe[i].sspp)
 			continue;
 		dpu_plane_sspp_update_pipe(plane, &pstate->pipe[i],
@@ -1378,7 +1378,7 @@ static void dpu_plane_sspp_atomic_update(struct drm_plane *plane,
 
 	pstate->plane_fetch_bw = 0;
 	pstate->plane_clk = 0;
-	for (i = 0; i < PIPES_PER_STAGE; i++) {
+	for (i = 0; i < PIPES_PER_PLANE; i++) {
 		if (!pstate->pipe[i].sspp)
 			continue;
 		pstate->plane_fetch_bw += _dpu_plane_calc_bw(pdpu->catalog, fmt,
@@ -1397,7 +1397,7 @@ static void _dpu_plane_atomic_disable(struct drm_plane *plane)
 	struct dpu_sw_pipe *pipe;
 	int i;
 
-	for (i = 0; i < PIPES_PER_STAGE; i += 1) {
+	for (i = 0; i < PIPES_PER_PLANE; i += 1) {
 		pipe = &pstate->pipe[i];
 		if (!pipe->sspp)
 			continue;
@@ -1519,7 +1519,7 @@ static void dpu_plane_atomic_print_state(struct drm_printer *p,
 
 	drm_printf(p, "\tstage=%d\n", pstate->stage);
 
-	for (i = 0; i < PIPES_PER_STAGE; i++) {
+	for (i = 0; i < PIPES_PER_PLANE; i++) {
 		pipe = &pstate->pipe[i];
 		if (!pipe->sspp)
 			continue;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
index 052fd046e8463855b16b30389c2efc67c0c15281..18ff5ec2603ed63ce45f530ced3407d3b70c737b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
@@ -33,8 +33,8 @@
 struct dpu_plane_state {
 	struct drm_plane_state base;
 	struct msm_gem_address_space *aspace;
-	struct dpu_sw_pipe pipe[PIPES_PER_STAGE];
-	struct dpu_sw_pipe_cfg pipe_cfg[PIPES_PER_STAGE];
+	struct dpu_sw_pipe pipe[PIPES_PER_PLANE];
+	struct dpu_sw_pipe_cfg pipe_cfg[PIPES_PER_PLANE];
 	enum dpu_stage stage;
 	bool needs_qos_remap;
 	bool pending;

-- 
2.34.1


