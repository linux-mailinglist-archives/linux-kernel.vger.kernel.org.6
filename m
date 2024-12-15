Return-Path: <linux-kernel+bounces-446413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44D59F240E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE41A165202
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5C917B502;
	Sun, 15 Dec 2024 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvML1srk"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E04D1714CF
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734268230; cv=none; b=SuHekg2kB+GvO93ttslZcdFdePGhcnRSSvraTZXIhLf1cc1IRKyHHksCKQod/VFu8zDwf3aeXBS0EHU4PBCi3mDp+wQkszKfMxjHsCQIt3zWnhz7w6jM936wDD+8Za8vqXfSOyyoB43gwaKUPHeTjrUJDse0o1Rtf0/1YE+G56k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734268230; c=relaxed/simple;
	bh=43Y1vOVC8uxKpG9I2AzBkfgbAZrp6UPf+I1kZ/3et7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bF3rmaYh88k0kXdgaLGAC73RFxk81or9Ht75YjWyz8QE92sffOMCQA9qgsMz3LnnxZ5sgLkx9Gw9h05fyNbVH057VFD+gy2DFrOVVhnwzfYKUj4UcYCsWgaqAczZmAzjLeXQ/uPj4LpzGQGI5XxXRudQSvw22VxMT7Fo7+cqJ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UvML1srk; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5401ab97206so3388028e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 05:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734268226; x=1734873026; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2S/zehdszrYe/6HUukpuBZ2KgVEa4+0Sundmnl7SoM=;
        b=UvML1srkT+FJHgSura2mPiwM4E7RK1+dVH5yQ7GOZ3FGoXXHItuBXGiZDSgMJg+f5m
         PP0rkIVXfyrqNoSajUTF5ZEcsGBXP1lYtWvAaCMvUFpGZaZXn43n8Dnf1BjUktFp+ZiN
         FJ2RmagsGZklQa6xCaD/sjQotlS9Yh/zNrjnE5SjlnRsEj82NjOFFlccaqCw2wzzSjn5
         TM3H8NYwIsUYqLeWhqg0mpKhH8tONznHXYrEnAfiZ/NIxz1EkP3/H8Xag0JTlS439+4r
         +zLVGxD7CAoHhGHkNoPM78UzXLaoF4tWHBAaaSxWtUCLCZtBpFkATy4cLRp9VJGXTgtm
         o2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734268226; x=1734873026;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2S/zehdszrYe/6HUukpuBZ2KgVEa4+0Sundmnl7SoM=;
        b=QYEGqWNaB2nSLrklmYDmR3lmwtXCd/lQDHAOyLf4BAWGIOywJulnO9SDPJEFFxE/WS
         oPkBYeW4JeT4gP39asuuqO4CTJmuSN8m+4lUtc+3o0zuZAN5izbmfhBYUEoAw6b/s8Ey
         v05G+VhUa44VxALsmFzmlB9su6Wns2zxwjdXtAqDmZiarn40SOeud5rRz9ZeFVaouVz3
         rSp+svlIxLm8EHr22IsnUkXT6jyKCqxxn1ERE8U1NVX5a2vesoykdxQtvaSNr0E38aJm
         OKcp9M13eRXDX672yMJozX7SQhKqkXWpxpbQy3b8zr31Cpl0UoELemfu/mnzxd1maoVF
         mzpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhqUXr9FksHOs6zpp6KM4JYJ9cgqZki+PqDRw+MYk6k038YqaZQN1fkJGP/fk+nTdUiyfrvaxaxL+wGFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYw9UGYAXG5Mjfkc3oQY3Ahrx5NFEnnE1qo5bOSorkAS1EtakI
	SADEeP5UVw5OJzw6xY00g7GDlv/zlFgII0+MLJg8fpbPT/CP/u5FVrQQUw8OKf0=
X-Gm-Gg: ASbGncszrtKrOoy0Xdm3NsbYpjYIxoSF0wgsze0krg4iYqxXriRVDVDQisg4N4I018D
	rT3mCahW79v6cwtL8o3V84aGNbm6FQTbbv4+kYQS9CJM/M3KmUI7QmPOuiP91KStfzjg/tBnzv8
	x4T2iOre7qDSo+WSyLKg8TNEazFHO7gDz9Cd7avXx9Mp2kmkrOk1v0UFCOJBNujTZ0DQjObv71P
	apM4PL6LpCWyYwIPGyMHzCd3udmQBD/im34zjtml8EK0oXk2YinjtVjD5Bh8ZXS
X-Google-Smtp-Source: AGHT+IGVXS883nXIuZYBsjXJ3OOjbGyP2J9bpQihhqu0wXhqHhv9fTudoRolKvxSbMvzbaKlzoMdEg==
X-Received: by 2002:a05:6512:230d:b0:541:1c48:8c17 with SMTP id 2adb3069b0e04-5411c488e3emr2593586e87.46.1734268226033;
        Sun, 15 Dec 2024 05:10:26 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c25160sm483590e87.281.2024.12.15.05.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 05:10:24 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 15 Dec 2024 15:10:23 +0200
Subject: [PATCH v5] drm/msm/dpu: allow sharing SSPP between planes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241215-dpu-share-sspp-v5-1-665d266183f9@linaro.org>
X-B4-Tracking: v=1; b=H4sIAD7VXmcC/x3MMQqAMAxA0auUzAZsMSpeRRxKjTZLLQ2KIN7d4
 viG/x9QLsIKk3mg8CUqR6qgxkCIPu2MslaDa11nnSVc84kafWFUzRkH8tT3zMGOBDXKhTe5/+G
 8vO8HskNmkGAAAAA=
X-Change-ID: 20241215-dpu-share-sspp-75a566eec185
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9978;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=43Y1vOVC8uxKpG9I2AzBkfgbAZrp6UPf+I1kZ/3et7g=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnXtU/oBRhQAngE4atbmuLwF+T90jBSI7rJVr2N
 UHIzu3YawOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ17VPwAKCRCLPIo+Aiko
 1S3RCACO4lwh2qjAvmyM0cOg5o+Ls5w+bE7PNR4NEatp4ZD93a/35rO/s4mqMPvUnIWgtIxmYfF
 9BRXW7gPZ2qOlhBngyfwPQ1vkcPFqqIBSc1uiMVTKGbB7Bvey+Qt1ac7S18YLHGUnUu8A1pzIIG
 siTPJbJlRA+H+yzSIhIUAWuWSzVxjFqRqpf+us3kJlXJWt1i5geYyHo6UXWflTJA6F/J885MtkP
 wvg4ly3wUon4JjXQMA8B0TzPE9xj/b/P8hY4OHpKuP4+z91k/SKrQElEagtF0eVAPCIJuvIbMcf
 KhwXF/++wEU9pZAFuyIxY17u8ikHjJw23IHuPw0GqpUqjitD
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Since SmartDMA planes provide two rectangles, it is possible to use them
to drive two different DRM planes, first plane getting the rect_0,
another one using rect_1 of the same SSPP. The sharing algorithm is
pretty simple, it requires that each of the planes can be driven by the
single rectangle and only consequetive planes are considered.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
This patch has been deferred from v5 of virtual wide patchset to
simplify the merging path. Now as the wide planes have been merged, pick
up the patch that allows sharing of the SSPPs between two planes.
---
Changes since v4:
- Rebased on top of the current msm-next-lumag
- Renamed dpu_plane_try_multirect() to dpu_plane_try_multirect_shared()
  (Abhinav)
- Link to v4: https://lore.kernel.org/dri-devel/20240314000216.392549-11-dmitry.baryshkov@linaro.org/
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 153 +++++++++++++++++++++++++-----
 1 file changed, 128 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 098abc2c0003cde90ce6219c97ee18fa055a92a5..2fd21d27df4741a8d942f9c9bae989f319cfb8d8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -887,10 +887,9 @@ static int dpu_plane_atomic_check_nosspp(struct drm_plane *plane,
 	return 0;
 }
 
-static int dpu_plane_is_multirect_parallel_capable(struct dpu_hw_sspp *sspp,
-						   struct dpu_sw_pipe_cfg *pipe_cfg,
-						   const struct msm_format *fmt,
-						   uint32_t max_linewidth)
+static int dpu_plane_is_multirect_capable(struct dpu_hw_sspp *sspp,
+					  struct dpu_sw_pipe_cfg *pipe_cfg,
+					  const struct msm_format *fmt)
 {
 	if (drm_rect_width(&pipe_cfg->src_rect) != drm_rect_width(&pipe_cfg->dst_rect) ||
 	    drm_rect_height(&pipe_cfg->src_rect) != drm_rect_height(&pipe_cfg->dst_rect))
@@ -902,10 +901,6 @@ static int dpu_plane_is_multirect_parallel_capable(struct dpu_hw_sspp *sspp,
 	if (MSM_FORMAT_IS_YUV(fmt))
 		return false;
 
-	if (MSM_FORMAT_IS_UBWC(fmt) &&
-	    drm_rect_width(&pipe_cfg->src_rect) > max_linewidth / 2)
-		return false;
-
 	if (!test_bit(DPU_SSPP_SMART_DMA_V1, &sspp->cap->features) &&
 	    !test_bit(DPU_SSPP_SMART_DMA_V2, &sspp->cap->features))
 		return false;
@@ -913,6 +908,27 @@ static int dpu_plane_is_multirect_parallel_capable(struct dpu_hw_sspp *sspp,
 	return true;
 }
 
+static int dpu_plane_is_parallel_capable(struct dpu_sw_pipe_cfg *pipe_cfg,
+					 const struct msm_format *fmt,
+					 uint32_t max_linewidth)
+{
+	if (MSM_FORMAT_IS_UBWC(fmt) &&
+	    drm_rect_width(&pipe_cfg->src_rect) > max_linewidth / 2)
+		return false;
+
+	return true;
+}
+
+static int dpu_plane_is_multirect_parallel_capable(struct dpu_hw_sspp *sspp,
+						   struct dpu_sw_pipe_cfg *pipe_cfg,
+						   const struct msm_format *fmt,
+						   uint32_t max_linewidth)
+{
+	return dpu_plane_is_multirect_capable(sspp, pipe_cfg, fmt) &&
+		dpu_plane_is_parallel_capable(pipe_cfg, fmt, max_linewidth);
+}
+
+
 static int dpu_plane_atomic_check_sspp(struct drm_plane *plane,
 				       struct drm_atomic_state *state,
 				       const struct drm_crtc_state *crtc_state)
@@ -1001,6 +1017,69 @@ static bool dpu_plane_try_multirect_parallel(struct dpu_sw_pipe *pipe, struct dp
 	return true;
 }
 
+static int dpu_plane_try_multirect_shared(struct dpu_plane_state *pstate,
+					  struct dpu_plane_state *prev_pstate,
+					  const struct msm_format *fmt,
+					  uint32_t max_linewidth)
+{
+	struct dpu_sw_pipe *pipe = &pstate->pipe;
+	struct dpu_sw_pipe *r_pipe = &pstate->r_pipe;
+	struct dpu_sw_pipe_cfg *pipe_cfg = &pstate->pipe_cfg;
+	struct dpu_sw_pipe *prev_pipe = &prev_pstate->pipe;
+	struct dpu_sw_pipe_cfg *prev_pipe_cfg = &prev_pstate->pipe_cfg;
+	const struct msm_format *prev_fmt = msm_framebuffer_format(prev_pstate->base.fb);
+	u16 max_tile_height = 1;
+
+	if (prev_pstate->r_pipe.sspp != NULL ||
+	    prev_pipe->multirect_mode != DPU_SSPP_MULTIRECT_NONE)
+		return false;
+
+	if (!dpu_plane_is_multirect_capable(pipe->sspp, pipe_cfg, fmt) ||
+	    !dpu_plane_is_multirect_capable(prev_pipe->sspp, prev_pipe_cfg, prev_fmt))
+		return false;
+
+	if (MSM_FORMAT_IS_UBWC(fmt))
+		max_tile_height = max(max_tile_height, fmt->tile_height);
+
+	if (MSM_FORMAT_IS_UBWC(prev_fmt))
+		max_tile_height = max(max_tile_height, prev_fmt->tile_height);
+
+	r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
+	r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
+
+	r_pipe->sspp = NULL;
+
+	if (dpu_plane_is_parallel_capable(pipe_cfg, fmt, max_linewidth) &&
+	    dpu_plane_is_parallel_capable(prev_pipe_cfg, prev_fmt, max_linewidth) &&
+	    (pipe_cfg->dst_rect.x1 >= prev_pipe_cfg->dst_rect.x2 ||
+	     prev_pipe_cfg->dst_rect.x1 >= pipe_cfg->dst_rect.x2)) {
+		pipe->sspp = prev_pipe->sspp;
+
+		pipe->multirect_index = DPU_SSPP_RECT_1;
+		pipe->multirect_mode = DPU_SSPP_MULTIRECT_PARALLEL;
+
+		prev_pipe->multirect_index = DPU_SSPP_RECT_0;
+		prev_pipe->multirect_mode = DPU_SSPP_MULTIRECT_PARALLEL;
+
+		return true;
+	}
+
+	if (pipe_cfg->dst_rect.y1 >= prev_pipe_cfg->dst_rect.y2 + 2 * max_tile_height ||
+	    prev_pipe_cfg->dst_rect.y1 >= pipe_cfg->dst_rect.y2 + 2 * max_tile_height) {
+		pipe->sspp = prev_pipe->sspp;
+
+		pipe->multirect_index = DPU_SSPP_RECT_1;
+		pipe->multirect_mode = DPU_SSPP_MULTIRECT_TIME_MX;
+
+		prev_pipe->multirect_index = DPU_SSPP_RECT_0;
+		prev_pipe->multirect_mode = DPU_SSPP_MULTIRECT_TIME_MX;
+
+		return true;
+	}
+
+	return false;
+}
+
 static int dpu_plane_atomic_check(struct drm_plane *plane,
 				  struct drm_atomic_state *state)
 {
@@ -1098,13 +1177,14 @@ static int dpu_plane_virtual_atomic_check(struct drm_plane *plane,
 static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
 					      struct dpu_global_state *global_state,
 					      struct drm_atomic_state *state,
-					      struct drm_plane_state *plane_state)
+					      struct drm_plane_state *plane_state,
+					      struct drm_plane_state *prev_plane_state)
 {
 	const struct drm_crtc_state *crtc_state = NULL;
 	struct drm_plane *plane = plane_state->plane;
 	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
 	struct dpu_rm_sspp_requirements reqs;
-	struct dpu_plane_state *pstate;
+	struct dpu_plane_state *pstate, *prev_pstate;
 	struct dpu_sw_pipe *pipe;
 	struct dpu_sw_pipe *r_pipe;
 	struct dpu_sw_pipe_cfg *pipe_cfg;
@@ -1116,6 +1196,7 @@ static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
 							   plane_state->crtc);
 
 	pstate = to_dpu_plane_state(plane_state);
+	prev_pstate = prev_plane_state ? to_dpu_plane_state(prev_plane_state) : NULL;
 	pipe = &pstate->pipe;
 	r_pipe = &pstate->r_pipe;
 	pipe_cfg = &pstate->pipe_cfg;
@@ -1134,24 +1215,42 @@ static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
 
 	reqs.rot90 = drm_rotation_90_or_270(plane_state->rotation);
 
-	pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
-	if (!pipe->sspp)
-		return -ENODEV;
+	if (drm_rect_width(&r_pipe_cfg->src_rect) == 0) {
+		if (!prev_pstate ||
+		    !dpu_plane_try_multirect_shared(pstate, prev_pstate, fmt,
+						    dpu_kms->catalog->caps->max_linewidth)) {
+			pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
+			if (!pipe->sspp)
+				return -ENODEV;
 
-	if (!dpu_plane_try_multirect_parallel(pipe, pipe_cfg, r_pipe, r_pipe_cfg,
-					      pipe->sspp,
-					      msm_framebuffer_format(plane_state->fb),
-					      dpu_kms->catalog->caps->max_linewidth)) {
-		/* multirect is not possible, use two SSPP blocks */
-		r_pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
-		if (!r_pipe->sspp)
+			r_pipe->sspp = NULL;
+
+			pipe->multirect_index = DPU_SSPP_RECT_SOLO;
+			pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
+
+			r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
+			r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
+		}
+	} else {
+		pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
+		if (!pipe->sspp)
 			return -ENODEV;
 
-		pipe->multirect_index = DPU_SSPP_RECT_SOLO;
-		pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
+		if (!dpu_plane_try_multirect_parallel(pipe, pipe_cfg, r_pipe, r_pipe_cfg,
+						      pipe->sspp,
+						      msm_framebuffer_format(plane_state->fb),
+						      dpu_kms->catalog->caps->max_linewidth)) {
+			/* multirect is not possible, use two SSPP blocks */
+			r_pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
+			if (!r_pipe->sspp)
+				return -ENODEV;
 
-		r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
-		r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
+			pipe->multirect_index = DPU_SSPP_RECT_SOLO;
+			pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
+
+			r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
+			r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
+		}
 	}
 
 	return dpu_plane_atomic_check_sspp(plane, state, crtc_state);
@@ -1165,6 +1264,7 @@ int dpu_assign_plane_resources(struct dpu_global_state *global_state,
 {
 	unsigned int i;
 	int ret;
+	struct drm_plane_state *prev_plane_state = NULL;
 
 	for (i = 0; i < num_planes; i++) {
 		struct drm_plane_state *plane_state = states[i];
@@ -1174,9 +1274,12 @@ int dpu_assign_plane_resources(struct dpu_global_state *global_state,
 			continue;
 
 		ret = dpu_plane_virtual_assign_resources(crtc, global_state,
-							 state, plane_state);
+							 state, plane_state,
+							 prev_plane_state);
 		if (ret)
 			break;
+
+		prev_plane_state = plane_state;
 	}
 
 	return ret;

---
base-commit: d82c9281189d2b27642ede2760db495379503b86
change-id: 20241215-dpu-share-sspp-75a566eec185

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


