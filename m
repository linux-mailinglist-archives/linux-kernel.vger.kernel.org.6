Return-Path: <linux-kernel+bounces-306646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D7F9641AA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C81BDB25C16
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6881B14E6;
	Thu, 29 Aug 2024 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWXXaCOY"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39A19413D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926841; cv=none; b=dmoHE8oVfTS3nmoZnQhNpGVmrT4DGJs9ht7WSHrugDFZ2m3b8i6OOP5cvNeqdCWgZeOHs3DSLX89LvmtQmxoE9UiY5XEUE8b4tNVu2AwaHlPGRqBRP2n74s5wuJPWjRP48ptZL3wGBcXyiKu67RF1wg6lYEpNqKZ50BmbOjAUwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926841; c=relaxed/simple;
	bh=kZcvFgM7BrpSSre+N3AhgJe8dih69TpaDCUeGk49yQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oYtW+iiMrJb5Yjapih6G5hLUr2dYhb2j9lF/m5+vCmWamj+3O94uho8+z1j4mTDI9kBaLCZrwanadecwu4ZYNZyd4vHdIeaBv2GN0egGISmmJW8BSqS+DdKdZ0saIV6ZqObXXmOh3LtN18wATWbnFrwo2wDbb7u01/3rzClXi8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WWXXaCOY; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70f60d73436so220613a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724926839; x=1725531639; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Q+hoiaQgUkbwBnUwr/XhQnF7bzaey6Ce3LFLI7Ja2A=;
        b=WWXXaCOYnoveWteeqxFh2uaq/Bo9emEvH3vkwUuDDHrzuhRu64byxw0cjadgswZ2QS
         9Ju4rG5nezAKUltu3QontAaG/7MqBl4dreBcwprQEfByCXm4pYPvwIGXdwwKUmmrTyym
         EZjACJw8TfmgQF/i5fCUUBg9XDyRhV1eTUT7LFV8uA69qafvmDRiND+B54pTKYaXJQ6G
         SvYZD2/iAu0RP2JLmFZp5imtF51zMcmT1PhOU+Ip6hZToq7oRFjQhf4fYXa65FdOQQIJ
         jtVMO7gAGRlkhMnlLSg/fEgxi+mpf6aOcwAIU7rYmCDcOJhzhpSjV5/n78dVjTfqEz9j
         FQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926839; x=1725531639;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Q+hoiaQgUkbwBnUwr/XhQnF7bzaey6Ce3LFLI7Ja2A=;
        b=jhjRIEylgwwAyKzBUqBXHNw6DGB8zK/92A7nVR5h4e92upifBgQ15fcF1F/lu239HR
         Fb6Kjb07Pw1DAo3K64IE4A4yG+jFZEFITw1JZb24gsLih2IAYifaqJ91YC/F7JWrxe7u
         5s7/y0pWRGJfq+fTfY4kAkqT9P1fCmraWESvrBEfn6HxreafwQ3hf91hrbWyF9R+jTyP
         d8yXMybMSX29KuL5qxroMknXcumHrh2fHisl3M9W7oq53JH/ZAyRJIEnvpLV9R1qCld8
         w5xFsYaFNiLx3f8DBQCC3L/J5j2pSI65fL3Xox6Mpss6zn2vgPMx7hkxOepVjXpzryWG
         BhZA==
X-Forwarded-Encrypted: i=1; AJvYcCXziiPmnnCAk6NlSaFXMt4jMdP1Z0DXahfQLdnofsoBUuCuTegvlSu6fEdFlkfQxO/lYwsCcYQHtp+aDzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo84yM6A3GhxHWCy2CPp61bNftqE/0zgdtG4y7cnJc8q5y6ncL
	YEQ6NO522Y2ilIU9WZA8J4uIC2IlSZHo2wWynHkrGcqLvic+x2HWBScMZJ9JDs0=
X-Google-Smtp-Source: AGHT+IHURAx1tsooOQ3BpeNpvN7C+aX7izExrX/ejBiTLN/buCsOS1Ed3EVamPLK9mdcOKp9oyzFHg==
X-Received: by 2002:a05:6358:720d:b0:1b5:a060:678b with SMTP id e5c5f4694b2df-1b603bedfacmr293928955d.3.1724926838743;
        Thu, 29 Aug 2024 03:20:38 -0700 (PDT)
Received: from [127.0.1.1] ([112.65.12.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d4df4sm891684a12.82.2024.08.29.03.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:20:38 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 29 Aug 2024 18:17:40 +0800
Subject: [PATCH 11/21] drm/msm/dpu: Support 4 mixers at most
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-11-bdb05b4b5a2e@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724926736; l=2904;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=kZcvFgM7BrpSSre+N3AhgJe8dih69TpaDCUeGk49yQg=;
 b=mFqZD0eT2dw9oeR2ZHc0FiJ57u/AjSO6ItzK6quKx8cKBjBQSZcjkn0eto2YSWy861soD7tvs
 4mW+Vaq5lU8A//Ocif+sSqA4ajsQ0iqXDMNcWh8CU+Q4fsNjOfNLRbn
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Support 4 mixers case with increasing array size and checking
the usage case.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c         | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h         | 6 +++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h | 3 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h   | 1 +
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index d9f26e189eebf..2c21a1e13d32f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -200,7 +200,7 @@ static int dpu_crtc_get_lm_crc(struct drm_crtc *crtc,
 		struct dpu_crtc_state *crtc_state)
 {
 	struct dpu_crtc_mixer *m;
-	u32 crcs[CRTC_DUAL_MIXERS];
+	u32 crcs[CRTC_QUAD_MIXERS];
 
 	int rc = 0;
 	int i;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
index 701c35803633d..08fc88d03bf6c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
@@ -210,7 +210,7 @@ struct dpu_crtc_state {
 
 	bool bw_control;
 	bool bw_split_vote;
-	struct drm_rect lm_bounds[CRTC_DUAL_MIXERS];
+	struct drm_rect lm_bounds[CRTC_QUAD_MIXERS];
 
 	uint64_t input_fence_timeout_ns;
 
@@ -218,10 +218,10 @@ struct dpu_crtc_state {
 
 	/* HW Resources reserved for the crtc */
 	u32 num_mixers;
-	struct dpu_crtc_mixer mixers[CRTC_DUAL_MIXERS];
+	struct dpu_crtc_mixer mixers[CRTC_QUAD_MIXERS];
 
 	u32 num_ctls;
-	struct dpu_hw_ctl *hw_ctls[CRTC_DUAL_MIXERS];
+	struct dpu_hw_ctl *hw_ctls[CRTC_QUAD_MIXERS];
 
 	enum dpu_crtc_crc_source crc_source;
 	int crc_frame_skip_count;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
index e77ebe3a68da9..c877ee45535ac 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
@@ -324,7 +324,8 @@ static inline enum dpu_3d_blend_mode dpu_encoder_helper_get_3d_blend_mode(
 
 	/* Use merge_3d unless DSC MERGE topology is used */
 	if (phys_enc->split_role == ENC_ROLE_SOLO &&
-	    dpu_cstate->num_mixers == CRTC_DUAL_MIXERS &&
+	    (dpu_cstate->num_mixers == CRTC_DUAL_MIXERS ||
+		dpu_cstate->num_mixers == CRTC_QUAD_MIXERS) &&
 	    !dpu_encoder_use_dsc_merge(phys_enc->parent))
 		return BLEND_3D_H_ROW_INT;
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index bf86d643887dd..f79ecd409a830 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -25,6 +25,7 @@
 #define MAX_IMG_HEIGHT 0x3fff
 
 #define CRTC_DUAL_MIXERS	2
+#define CRTC_QUAD_MIXERS	4
 
 #define MAX_XIN_COUNT 16
 

-- 
2.34.1


