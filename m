Return-Path: <linux-kernel+bounces-306650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A535F9641B2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5491628B847
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A7E19580B;
	Thu, 29 Aug 2024 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5tdnCNT"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280041B29A6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926858; cv=none; b=nfKtxnu4Z9zwQzGSCIRPWdl7Ze2w7DvA8AYICHWAwD2jo52i/b1r/juBbBVpOctD+SxaSsg3ENP+i8XmudvrQ2y8MfHurZW56hUdgRB0ODU/fnjlJYetN+GXnIHsPaNrK7gfxgY+USaPYl235y2NDHQHp1WV4fcpMGUaqqM8lmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926858; c=relaxed/simple;
	bh=iBBFvuh42T8eyN/dYK/D5D18dlzaCweeyM10rWmhUYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AvsTVa9NBLyAM64t3Is5uQBV2FldRiBI3KyMB09swzYi8w9LowxSSGdB0mphnwApI+c8yLtIxkzlQZ4GinclYisGwWfhioapj1t5QgeIWFbqOpXQL1e2JHF0Ua3n4B7/6EpuKJjL7ITOzF1+yjxoA2XG5X7qI0uxMVuhH0PK/b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F5tdnCNT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7143165f23fso393485b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724926856; x=1725531656; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0uRNpfIp2lpV9SgGo9NPsUI/ImMZPWVqx5nn2wZId8=;
        b=F5tdnCNT9Ka4olhUMvASpHI7BAgLVtIu7SaRk62I5SUvaGbaVkzMClyTFhOJODC/GX
         2Fo28hxYeOXpmSd+JgYStgALoWNx3GteEdVw1mGa/Pd/EuDZcjh0hCHrJi9J5njr978I
         nhLcrLcaHo36akETW8xvkVqrYGFy94QFlEi7R993xEgNj5hEYDUjxmn4BBGMzQPLTI4k
         IRU56nS/0wZdZZ6YRdNu6cjBXVqg7zgMIhVn387wdx9oR1c9YdmFZINidf2w2PY8TSme
         b7/MlNbJ5n8P/WpgURFRcUWs+Iyg/pC0UajInFyaggHRitEXYuXJRQT6DYRctyUdqShC
         Vs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926856; x=1725531656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0uRNpfIp2lpV9SgGo9NPsUI/ImMZPWVqx5nn2wZId8=;
        b=h2P+9bHcChLSQT3D2VCS8K2FeolUyfZIfkzayYdkKIsGBDJ5uWOIfOT8QEiFB3qbQa
         wvVmw+ooR8ag+02rVeFSo/b+ayyVb93kTY5pMDTsUkgBo30TnlTlqUxEgVTCUANebBZ+
         Cba5hZhqFrtK02RmlNTkol5yv14effwPYp4HDnY1DzQgwjjSUebAiUYogX5DDxcf6GTj
         yaNzmNcS+9ziTcu7wUgzpv17qVh3MnM2wfZ1OK/dnyHlGqAtI24dGgxv3XUJ60PsA/Rb
         9g4avR1LvBP1TDb9nj/508+iKjygz8OfqyLpeGFIGI8RzjEGST1UzwsobegO5BJkyPdi
         Ryng==
X-Forwarded-Encrypted: i=1; AJvYcCU5uRL6K7+2SFYPo/IcoYhdNhJxVJkyumQcFuKhTg/ZYORmOhcDn2+3NustazB/KchMAYvx9ZboqyBrIjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw5MmaW/51yesi0yrwulFpvs/y8ZQNwDkzma14EMELMbmh26BI
	AoXGnpqgGFEi4TP297d8t6qGXoU/+S+wpVfpqOmKOVpoAg0GEdxoiAJkHnmnTNI=
X-Google-Smtp-Source: AGHT+IEQnZ7U6OXJ59JaU5lRHIu343sdAHqmwh5ITZdY+IPrw4gsbPdHxDGzOKFTJbJ7zQsi41Jqkg==
X-Received: by 2002:a05:6a00:10c1:b0:70d:244b:cad9 with SMTP id d2e1a72fcca58-715dfcc0ba3mr2510462b3a.28.1724926856440;
        Thu, 29 Aug 2024 03:20:56 -0700 (PDT)
Received: from [127.0.1.1] ([112.65.12.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d4df4sm891684a12.82.2024.08.29.03.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:20:55 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 29 Aug 2024 18:17:42 +0800
Subject: [PATCH 13/21] drm/msm/dpu: Support quad pipe in header files
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-13-bdb05b4b5a2e@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724926736; l=4530;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=iBBFvuh42T8eyN/dYK/D5D18dlzaCweeyM10rWmhUYM=;
 b=ljxhEuqO0d+83B1jOB9X07XgeIfQ83dErzf8WVk3l5RtHzfq5go+VT1T9rPgHJOT3eTMcu4NQ
 Jtog/FbpINjCKsHZzsDiLWeqW1wQsnLRf7/8HNDlzHujPsKNJEnA+Ti
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Support 4 pipes and their configs at most. They are for 2 SSPP
and their multi-rect mode. Because one SSPP can co-work with
2 mixer at most, 2 pair of mixer are needed for 2 SSPP in quad-
pipe case. So 2 mixer configs are needed in quad-pipe case.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h | 11 ++++++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h   | 30 +++++++++++++++++++++--------
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index a2eff36a2224c..424725303ccad 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -32,7 +32,7 @@
 #define DPU_MAX_PLANES			4
 #endif
 
-#define PIPES_PER_STAGE			2
+#define PIPES_PER_STAGE			4
 #ifndef DPU_MAX_DE_CURVES
 #define DPU_MAX_DE_CURVES		3
 #endif
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
index fc54625ae5d4f..ae6beff2c294b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
@@ -143,11 +143,20 @@ struct dpu_hw_pixel_ext {
  *             such as decimation, flip etc to program this field
  * @dest_rect: destination ROI.
  * @rotation: simplified drm rotation hint
+ * @visible: mark this cfg is valid
+ * @mxcfg_id: mixer config ID for left or right half screen.
+ *             We have single SSPP, dual SSPP, single SSPP+multi_rect or dual
+ *             SSPP+multi_rect case. mxcfg_id mark current pipe will use
+ *             which mixer cfg. The first mxcfg is for the left half of screen,
+ *             the 2nd mxcfg is for the right half screen. The heading cfg may
+ *             be skipped by pipe with the first mxcfg_id = 1 if the plane is
+ *             only displayed in the right side, thus SSPP goes to later mixers.
  */
 struct dpu_sw_pipe_cfg {
 	struct drm_rect src_rect;
 	struct drm_rect dst_rect;
-	unsigned int rotation;
+	unsigned int rotation, mxcfg_id;
+	bool visible;
 };
 
 /**
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
index e225d5baceb09..9e79cf9eba264 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
@@ -14,14 +14,30 @@
 #include "dpu_hw_mdss.h"
 #include "dpu_hw_sspp.h"
 
+/**
+ * Max number of mixer configs. Because we support 4 pipes at most,
+ * the 4 pipes are with 2 SSPP and their multi-rect mode. While one
+ * SSPP can co-work with 2 mixer at most, then 2 pair of mixer are
+ * needed for 2 SSPP in quad-pipe case. Thus 2 mixer configs are
+ * needed in quad-pipe case.
+ */
+#define MIX_CFGS_IN_CRTC 2
+
 /**
  * struct dpu_plane_state: Define dpu extension of drm plane state object
  * @base:	base drm plane state object
  * @aspace:	pointer to address space for input/output buffers
- * @pipe:	software pipe description
- * @r_pipe:	software pipe description of the second pipe
- * @pipe_cfg:	software pipe configuration
- * @r_pipe_cfg:	software pipe configuration for the second pipe
+ * @pipe:	software pipe description. Some or all of fields in array can
+ *		be in use per topology. The heading fields are used first,
+ *		and the later fields is invalid if visible field of pipe_cfg
+ *		is not set. For example, the visible fields of pipe_cfg are set
+ *		in the first 2 pipe_cfg fields, and the mxcfg_id for them are
+ *		0 and 1. That means the first pipe is for left half screen and
+ *		the 2nd pipe is for right half. The visible field of the 3rd
+ *		pipe_cfg is not set, which means the 3rd and 4th pipe are not
+ *		in use.
+ * @pipe_cfg:	software pipe configuration. The 4 fields are for SSPP and their
+		parallel rect as above pipes.
  * @stage:	assigned by crtc blender
  * @needs_qos_remap: qos remap settings need to be updated
  * @multirect_index: index of the rectangle of SSPP
@@ -34,10 +50,8 @@
 struct dpu_plane_state {
 	struct drm_plane_state base;
 	struct msm_gem_address_space *aspace;
-	struct dpu_sw_pipe pipe;
-	struct dpu_sw_pipe r_pipe;
-	struct dpu_sw_pipe_cfg pipe_cfg;
-	struct dpu_sw_pipe_cfg r_pipe_cfg;
+	struct dpu_sw_pipe pipe[PIPES_PER_STAGE];
+	struct dpu_sw_pipe_cfg pipe_cfg[PIPES_PER_STAGE];
 	enum dpu_stage stage;
 	bool needs_qos_remap;
 	bool pending;

-- 
2.34.1


