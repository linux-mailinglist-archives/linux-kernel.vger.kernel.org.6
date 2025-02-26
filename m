Return-Path: <linux-kernel+bounces-533852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB24A45F52
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FD1160565
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5640E21ADA0;
	Wed, 26 Feb 2025 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DJtwTl6G"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECEE21D3D8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573218; cv=none; b=VtGq9wmuw4rVwrZZu0Uaeu3GvgxGg2ETL3+ZFI/Mj7a+0+nHPWNAFrCKdF8fg9J5nCtBXzL+FdK6aWWBv7WLRAWcDOGU2w2JoK3bIPdnuyudXBMX5L/kiB87iB50G41MCBcJxxP9zyS/QLD/qxBJrP+QLCSh4Lpo7MC2D5Tvyzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573218; c=relaxed/simple;
	bh=kXnt8vjlhZJf0cBxy7dPZ9teD4pxdE5E8edh78McPmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WSRn2yx7Y6sTOTJaa842e3AunPtArMUf3IF461O3KRV/UsVyKda7jrAxhrNlVn+GIJ3iEx10ZowrXtDdEbacJ9UGIFycp0nv35k29M3JJ1/kkLIHJxrEfG0oi8xcGiyohGEYa3dn/PmVJ0euOyt4tAQnw3zgFVR7f/I61MCQrew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DJtwTl6G; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fc3027c7aeso13210064a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740573216; x=1741178016; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17xwTof96P1WeJRZDnaNGAPL65jkXDHzo93BzhWGU/w=;
        b=DJtwTl6GekPG3jnfWk3swJxg5F995Aba3f8XBtl8ZKjcWvRvaWA5iAqeTNqFVDsRGZ
         bVLs6o3MPFi+X8M9cJbVsNwIG4a2CbtdUJQYzxHZ9+8S0ddVwCHHNOW+PNf4HbyMK6ir
         am2yYWOKuqA7PhV2r1n+9EW4oQYqC++cLBWZwGs6EMfNGzsAk3Bz8tFSmzWtk0mFKVEh
         aDVV7iQLvoD1dtRpXt37IZKeawHE+cg9Vn7moTQVajLCI9okU2siOF2y2oWRy4/u+fE/
         xTxZhEdfo8Xi6iwYVS9u3S6bN6krBaqGoG+HnEDnnKF/z1mm2U83rBVdWjvZHiXV0SWv
         A4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740573216; x=1741178016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17xwTof96P1WeJRZDnaNGAPL65jkXDHzo93BzhWGU/w=;
        b=tIw5KLxi36elXwDRtZHKR8n4uWZ5v0e92piZIvAWvIYOrcIif82r8vvvZRZnUENgS+
         kK8hqlZFBQe99raAgfSW8+hVV8yX7KrP/Jn2A7pRlF038LYnHe4CYF7YiRNEBeGCAWgX
         DAz+ThX0STcfMc5GdXePjQJglF/RP1+bNL9nTVh4lEnFehtxhe2wteWXXjemig2RWVwD
         UGGQekNT5Rx5evcPSMhAhQuCHQPTe72zNJW5xVO4yGs5MSHE3J+iKgCewyuuMIeciHnL
         6JZvzw8DhN6evG05DGz7kBmXw/6VY/jqtDgzMaeDzbeab0I03i0qbB0e/2h4BVSNjDYS
         1Drg==
X-Forwarded-Encrypted: i=1; AJvYcCU41rB4xS+VYmVPUvEVy88x9LWaliU7NiYOhI4hIIvlrniLcZJtTEY+hVotQng0p+Nd09V7rqkhboKPMkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5VFcNgQBgaUllm8xe0cyZo1jgTaztT7KvXF+1dUvo/mW4PPrO
	Z1+Q6iz5hpP/pGGWGGwkWixYj4DyVSMlNhIqFILUSxrUCsa31Dw0234yGcpxVk8=
X-Gm-Gg: ASbGncts57eFNkRFF0857yEwnkhoyFlJ/Redn0ydllcw2grHFFMKWYDOKzbvklwIglE
	pYdq63ANxqsLYu4WKcHV1MznVxZWGLF2bQr2975qcAic78PCGAqpUvDSVYbwp12REgobE1edcme
	UKae7fGvrBko67vMcrzJa7NAHMpSydZl3mCrCs7/H3kYsXRopjUpSAG77+6Xm+K0BAEJ2NBDXWZ
	vzuDhXSN2XBoFR7DZzzy5y7D1X9yBYNr4TDFi3WqkJhiRaxJrq+fxCPVoeaTk/qBlzrdHdUlEwp
	jjK28zhEQH06rlQSYFIV3oU=
X-Google-Smtp-Source: AGHT+IGgBhUkOJXiyd6dIFdgOWGhE4BOLqrz/YwMdOstrCHIeFZubPsRVKQhK44uiKy2zVlvPodC2Q==
X-Received: by 2002:a17:90b:4d0d:b0:2ee:aef4:2c5d with SMTP id 98e67ed59e1d1-2fce8724453mr29496116a91.26.1740573216268;
        Wed, 26 Feb 2025 04:33:36 -0800 (PST)
Received: from [127.0.1.1] ([112.64.61.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825d2ed3sm1352479a91.29.2025.02.26.04.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 04:33:35 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 26 Feb 2025 20:31:00 +0800
Subject: [PATCH v7 11/15] drm/msm/dpu: split PIPES_PER_STAGE definition per
 plane and mixer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v7-11-8d5f5f426eb2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740573128; l=5119;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=kXnt8vjlhZJf0cBxy7dPZ9teD4pxdE5E8edh78McPmA=;
 b=JJ8UFjSdVAc8FtojNdHgH4PgT+xHtLS29uuC8AgQTazgaDlTgVIRngU4ys+Dgb4NiyVlxhTcY
 +5mu89tK5HdBfHp9uK54NuRidyhfdaGLFsbXfc67xrYU9vCppPTlOUg
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


