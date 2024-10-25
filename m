Return-Path: <linux-kernel+bounces-380789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC149AF61F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 106D4B22037
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A36413E898;
	Fri, 25 Oct 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tBHo4xaY"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613D410A1C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729815631; cv=none; b=gE5oS6U91k1XRyVvWKflBZZorYGVWC2pgjsa/OOmTEm5X0vfx7EVdRJXkczFwgywe9suYuOUSizeIP3uJ1dAPAiwT6mkNU2R2O8Jr65ImxricO2TK5+gZN6SOEqPt3maoEmBQpwPKHnBq1ZKwanQEMHwvUzdkoWTJ0mUUaON82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729815631; c=relaxed/simple;
	bh=fjswmDgSyE721HeZ7JINqy82YwCdlpAYkSS3IiYxgeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XHdFji0Xh7z6E3xuYFDDheqPLs2LLLDxW7cmvlY+xplLIykBm1/SG8wRTRLAIy8zVs3NY4TpcxiOCQiyd3s3Ygs8Q5OzUNgaIJzm71N1ZVfZe1PYfHvwXzUxrciJ53H0Uqs12o6BJ0EuqX3m/kGDfhJgGUOAgou5cy6W6XvQcwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tBHo4xaY; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539983beb19so1936025e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 17:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729815625; x=1730420425; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRTCQ/+1u3zeZXeRWKmW68djJj/Ad8VQXBpteQMSNwY=;
        b=tBHo4xaYImDGwijs5gugiiB+QVX0FdGFD2bJnLHl/80AB4AxOZJgz0oI2O2b+lgFW6
         ffl1T/ZRjpTzzHzE9m1TnQyX1bBbjgDxJBT8GtVNFmxVF+yZqqI9NW9gX6+r21VkhdxT
         CQsF2XgtzgeJ1HTluUQsfABiy/wG8R5o/ce2dS2Kl3dTjP79keu07Lmv8U1hXBClSpEy
         /xsVFidYrqYwYyY+s38lWXtpjfysvE3fJZwLhs0gKiLq7LjNL3nNGRJheuIWnQ2lmD0N
         9b1zvIFLXqug4YbjKOPgv1E0dPQxCHBzMVELPOGO8VDNgvvcXzQiBIyaB0ENvtrHXlEz
         sfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729815625; x=1730420425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRTCQ/+1u3zeZXeRWKmW68djJj/Ad8VQXBpteQMSNwY=;
        b=MGQLR2pZPiN/g34WyV833ZUOcLKzClMsJbvJcPF121T59YdLGMGs/R2Zg89Sx9SVJn
         6No35Vkx1rQkUmDpeW4RQuX5IWrSbIMrvIjtBC2h8BJMah4RZcFfTzgiwZCUt5nnsMPC
         BcDhejzo2cwzDroj8vEJPgNoCKSXAlQgI6EMcsZyErGKbAGtrFf1SiXE/PTRsf+Nbemp
         Ldd7dPEPq33GdoTwUCyXgtFqif0PpJE1nnNOl8JF/vsPN2/BKnVYh7MJFdc3MvHRRQWq
         UIb+tZFZ5kiaqXXByAs2lWOjvSZddTjMHWlNdVWdgS5D8lU5YCNo1phhYCySy4fH3rhc
         nT5g==
X-Forwarded-Encrypted: i=1; AJvYcCXtbH0euNUuYmtOGfkuAknP4f4RsF5kOBMRIGfPdtbLhiVcLMo1zHvjQFRLTyKg5nhfyjl7AJddA278Aag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV8hMOXznpv4E6i7I58o+/LTDlTaWqF/bwANYx3dO7TWeFgEUS
	GxdPL2hhqIk8FXMEcyPhFNwk3bMOVXLZ5naozimSMRuea2lWxjr+e7/hrMHHGNY=
X-Google-Smtp-Source: AGHT+IFXB3KrD9SfcXPQqARpEzGbr2ADVrbuzuWFPGjLEVWLX+LM3ekCR0Ie1gKBwqNArHTy9wsm1w==
X-Received: by 2002:a05:6512:3989:b0:53a:1337:5ff7 with SMTP id 2adb3069b0e04-53b1a36c6admr5102880e87.40.1729815625170;
        Thu, 24 Oct 2024 17:20:25 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1b05b3sm6227e87.161.2024.10.24.17.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 17:20:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 25 Oct 2024 03:20:13 +0300
Subject: [PATCH v6 6/9] drm/msm/dpu: move rot90 checking to
 dpu_plane_atomic_check_sspp()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-dpu-virtual-wide-v6-6-0310fd519765@linaro.org>
References: <20241025-dpu-virtual-wide-v6-0-0310fd519765@linaro.org>
In-Reply-To: <20241025-dpu-virtual-wide-v6-0-0310fd519765@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7321;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=fjswmDgSyE721HeZ7JINqy82YwCdlpAYkSS3IiYxgeA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnGuQ6i3DSU9tGMxB0M2nsxWSCM1V2BDRVCeYTg
 LZCiSL6NqmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZxrkOgAKCRCLPIo+Aiko
 1RQOB/0bU06eApjWatBhQTStn3jZMMKq7lE0YoSbYrDoWpWCHvk/UpQm9/9rUXuBITauMHBXauw
 H116gHQD78WkO2HpjN9zgjSXO64nUWXO6xskXhLmub7QjAexZ5zVAAt5CFiouMKmdDJr5P/IdgM
 bjXlf/SaalGZVrtKhfQ7KRpK5OgFQU3M2+Ex+e+59zrubs1m45mEHPGOeErc0gqc89Usb1Sd6i0
 fHgwI4N9okAE1BFh86Fxi9OZ2bNewaHO5PE8fjJdSZOfnCl8idpC6CrrxSM/B28JmKWJHKPxtZo
 e45mi7EwM37ivKdJyD8lumr8VEHpjt5jY+oueAldKgMG66Yu
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Move a call to dpu_plane_check_inline_rotation() to the
dpu_plane_atomic_check_sspp() function, so that the rot90 constraints
are checked for both SSPP blocks. Also move rotation field from struct
dpu_plane_state to struct dpu_sw_pipe_cfg.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h |  2 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c   | 55 +++++++++++++++--------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h   |  2 --
 3 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
index 8998d1862e16..9ae475420c05 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
@@ -144,10 +144,12 @@ struct dpu_hw_pixel_ext {
  * @src_rect:  src ROI, caller takes into account the different operations
  *             such as decimation, flip etc to program this field
  * @dest_rect: destination ROI.
+ * @rotation: simplified drm rotation hint
  */
 struct dpu_sw_pipe_cfg {
 	struct drm_rect src_rect;
 	struct drm_rect dst_rect;
+	unsigned int rotation;
 };
 
 /**
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index a5f29851361f..5e230391fabc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -528,8 +528,7 @@ static const struct dpu_csc_cfg *_dpu_plane_get_csc(struct dpu_sw_pipe *pipe,
 
 static void _dpu_plane_setup_scaler(struct dpu_sw_pipe *pipe,
 		const struct msm_format *fmt, bool color_fill,
-		struct dpu_sw_pipe_cfg *pipe_cfg,
-		unsigned int rotation)
+		struct dpu_sw_pipe_cfg *pipe_cfg)
 {
 	struct dpu_hw_sspp *pipe_hw = pipe->sspp;
 	const struct drm_format_info *info = drm_format_info(fmt->pixel_format);
@@ -552,7 +551,7 @@ static void _dpu_plane_setup_scaler(struct dpu_sw_pipe *pipe,
 			dst_height,
 			&scaler3_cfg, fmt,
 			info->hsub, info->vsub,
-			rotation);
+			pipe_cfg->rotation);
 
 	/* configure pixel extension based on scalar config */
 	_dpu_plane_setup_pixel_ext(&scaler3_cfg, &pixel_ext,
@@ -604,7 +603,7 @@ static void _dpu_plane_color_fill_pipe(struct dpu_plane_state *pstate,
 	if (pipe->sspp->ops.setup_rects)
 		pipe->sspp->ops.setup_rects(pipe, &pipe_cfg);
 
-	_dpu_plane_setup_scaler(pipe, fmt, true, &pipe_cfg, pstate->rotation);
+	_dpu_plane_setup_scaler(pipe, fmt, true, &pipe_cfg);
 }
 
 /**
@@ -696,12 +695,17 @@ static void dpu_plane_cleanup_fb(struct drm_plane *plane,
 }
 
 static int dpu_plane_check_inline_rotation(struct dpu_plane *pdpu,
-						const struct dpu_sspp_sub_blks *sblk,
-						struct drm_rect src, const struct msm_format *fmt)
+					   struct dpu_sw_pipe *pipe,
+					   struct drm_rect src,
+					   const struct msm_format *fmt)
 {
+	const struct dpu_sspp_sub_blks *sblk = pipe->sspp->cap->sblk;
 	size_t num_formats;
 	const u32 *supported_formats;
 
+	if (!test_bit(DPU_SSPP_INLINE_ROTATION, &pipe->sspp->cap->features))
+		return -EINVAL;
+
 	if (!sblk->rotation_cfg) {
 		DPU_ERROR("invalid rotation cfg\n");
 		return -EINVAL;
@@ -731,6 +735,7 @@ static int dpu_plane_atomic_check_pipe(struct dpu_plane *pdpu,
 {
 	uint32_t min_src_size;
 	struct dpu_kms *kms = _dpu_plane_get_kms(&pdpu->base);
+	int ret;
 
 	min_src_size = MSM_FORMAT_IS_YUV(fmt) ? 2 : 1;
 
@@ -768,6 +773,12 @@ static int dpu_plane_atomic_check_pipe(struct dpu_plane *pdpu,
 		return -EINVAL;
 	}
 
+	if (pipe_cfg->rotation & DRM_MODE_ROTATE_90) {
+		ret = dpu_plane_check_inline_rotation(pdpu, pipe, pipe_cfg->src_rect, fmt);
+		if (ret)
+			return ret;
+	}
+
 	/* max clk check */
 	if (_dpu_plane_calc_clk(mode, pipe_cfg) > kms->perf.max_core_clk_rate) {
 		DPU_DEBUG_PLANE(pdpu, "plane exceeds max mdp core clk limits\n");
@@ -891,7 +902,6 @@ static int dpu_plane_atomic_check_sspp(struct drm_plane *plane,
 	struct dpu_sw_pipe_cfg *pipe_cfg = &pstate->pipe_cfg;
 	struct dpu_sw_pipe_cfg *r_pipe_cfg = &pstate->r_pipe_cfg;
 	uint32_t max_linewidth;
-	unsigned int rotation;
 	uint32_t supported_rotations;
 	const struct dpu_sspp_cfg *pipe_hw_caps;
 	const struct dpu_sspp_sub_blks *sblk;
@@ -915,6 +925,15 @@ static int dpu_plane_atomic_check_sspp(struct drm_plane *plane,
 
 	max_linewidth = pdpu->catalog->caps->max_linewidth;
 
+	supported_rotations = DRM_MODE_REFLECT_MASK | DRM_MODE_ROTATE_0;
+
+	if (pipe_hw_caps->features & BIT(DPU_SSPP_INLINE_ROTATION))
+		supported_rotations |= DRM_MODE_ROTATE_90;
+
+	pipe_cfg->rotation = drm_rotation_simplify(new_plane_state->rotation,
+						   supported_rotations);
+	r_pipe_cfg->rotation = pipe_cfg->rotation;
+
 	ret = dpu_plane_atomic_check_pipe(pdpu, pipe, pipe_cfg, fmt,
 					  &crtc_state->adjusted_mode);
 	if (ret)
@@ -938,6 +957,7 @@ static int dpu_plane_atomic_check_sspp(struct drm_plane *plane,
 		    drm_rect_height(&pipe_cfg->src_rect) != drm_rect_height(&pipe_cfg->dst_rect) ||
 		    (!test_bit(DPU_SSPP_SMART_DMA_V1, &pipe->sspp->cap->features) &&
 		     !test_bit(DPU_SSPP_SMART_DMA_V2, &pipe->sspp->cap->features)) ||
+		    pipe_cfg->rotation & DRM_MODE_ROTATE_90 ||
 		    MSM_FORMAT_IS_YUV(fmt)) {
 			DPU_DEBUG_PLANE(pdpu, "invalid src " DRM_RECT_FMT " line:%u, can't use split source\n",
 					DRM_RECT_ARG(&pipe_cfg->src_rect), max_linewidth);
@@ -961,23 +981,6 @@ static int dpu_plane_atomic_check_sspp(struct drm_plane *plane,
 			return ret;
 	}
 
-	supported_rotations = DRM_MODE_REFLECT_MASK | DRM_MODE_ROTATE_0;
-
-	if (pipe_hw_caps->features & BIT(DPU_SSPP_INLINE_ROTATION))
-		supported_rotations |= DRM_MODE_ROTATE_90;
-
-	rotation = drm_rotation_simplify(new_plane_state->rotation,
-					supported_rotations);
-
-	if ((pipe_hw_caps->features & BIT(DPU_SSPP_INLINE_ROTATION)) &&
-		(rotation & DRM_MODE_ROTATE_90)) {
-		ret = dpu_plane_check_inline_rotation(pdpu, sblk, pipe_cfg->src_rect, fmt);
-		if (ret)
-			return ret;
-	}
-
-	pstate->rotation = rotation;
-
 	return 0;
 }
 
@@ -1117,14 +1120,14 @@ static void dpu_plane_sspp_update_pipe(struct drm_plane *plane,
 				pipe_cfg);
 	}
 
-	_dpu_plane_setup_scaler(pipe, fmt, false, pipe_cfg, pstate->rotation);
+	_dpu_plane_setup_scaler(pipe, fmt, false, pipe_cfg);
 
 	if (pipe->sspp->ops.setup_multirect)
 		pipe->sspp->ops.setup_multirect(
 				pipe);
 
 	if (pipe->sspp->ops.setup_format) {
-		unsigned int rotation = pstate->rotation;
+		unsigned int rotation = pipe_cfg->rotation;
 
 		src_flags = 0x0;
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
index 348b0075d1ce..31ee8b55c4dd 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
@@ -30,7 +30,6 @@
  * @plane_fetch_bw: calculated BW per plane
  * @plane_clk: calculated clk per plane
  * @needs_dirtyfb: whether attached CRTC needs pixel data explicitly flushed
- * @rotation: simplified drm rotation hint
  * @layout:     framebuffer memory layout
  */
 struct dpu_plane_state {
@@ -48,7 +47,6 @@ struct dpu_plane_state {
 	u64 plane_clk;
 
 	bool needs_dirtyfb;
-	unsigned int rotation;
 
 	struct dpu_hw_fmt_layout layout;
 };

-- 
2.39.5


