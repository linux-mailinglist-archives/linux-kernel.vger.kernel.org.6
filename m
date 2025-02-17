Return-Path: <linux-kernel+bounces-518095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F7EA389F5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9E818931D8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE8522A1D6;
	Mon, 17 Feb 2025 16:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZ1b69s7"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7BF229B27
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810536; cv=none; b=RTNmUi08IPiyyxc8nudxCl0MStM030r2tdnvbCCdCRezSyis1G0bW92LrtwoBDUz+1MUG/9Y8GD3HA1PMRYLMEh94Jxms2Fi5tXxjMh/QTSoUuTESBoRq2xUFEIjjOtRrKqCZJ1uf+YhTybTBWwo+I6QAWN3UKUuEt0cXa9a6ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810536; c=relaxed/simple;
	bh=MRN/ryi+pMGgkQFSG+NX2HFCuyWv6SXBLRgehaGG5PI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZVNW+F6H/ptclGKwDr3w1FdQMGh8I+Ev05b9FvGGiWzGrDCUNzykKe4ttAGOjuYU4r5plo13lnjvd4B4V4+2YOMOJK5s6/lbSfxm9jF2Hk6gYgEpwFLRNQJyPj0sGCGJARSw3WhviU0TJmNhAg6TB0sgcVn6PcUu65++TeBXdjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qZ1b69s7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abad214f9c9so53968566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739810533; x=1740415333; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8nOoi7/gmo0cWUkjWoW9KsdAcJb9kHFiSd6bM8xPlc=;
        b=qZ1b69s7oZ683K+sU6e0BqIBsDa5SUP++XElB7DvN/EyvAfzsZXCCKKr3Bjo998zvt
         4NgXgXWb9gGGRPUCDxSdXkL1qAyzoERBGTsts1P2GS1SLxwSOMe/iefpBY/r6DkGUSrT
         IfWhkOuRuVZAU98O7MkVe6dG/TtAKhvhIQ4eQynzSLxhQcZsDK/V2ZGkYDsDBSwYvFjp
         viRjzhyBCpdNALvENgTkUSjCPda7pZZouQ0brgn3XK5YuQIBvbsaUpEO4a6SY0tjCpQl
         x5v63plVlSFUF7Ae8uBrLrfeXBduFxIq08PCkJd5PsD5XujFhqUpfKi3ZWA+ax/HE1uT
         nrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810533; x=1740415333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8nOoi7/gmo0cWUkjWoW9KsdAcJb9kHFiSd6bM8xPlc=;
        b=hI2g9LyO4A56fc2vziSBqbSERr1nV3ObJmKFEx1UhA/k5UClSXbZsM3RRm499zehXx
         JVPW8JRvaIcLAiTeSd7cl4A7IXhlPjz72x5O6GRBwS6MxRdrieZubOGf37Pmt8jHfkwi
         WelN9bzobnxX3BvuzfdagRFHuy7z+xxn0u/VG0d1exBSRLFMavRUX66CB40XuVy9hLkG
         50P5XgZ+D3yqaIirPDp3RcwOw8Z3rawIiQx9JycYBtNSTwtUDNcRYraboDS1TBzFkjY1
         dY3oZ662nc20MNcJiNsOJXpPNxRePI+2Ix4qsIKeo5xyTmBp3Yhsaj8ZgAnG806bE5MP
         eF9w==
X-Forwarded-Encrypted: i=1; AJvYcCWgfQvrFBN5DgdI/OVuTW1l91JgBWN+X++GtuV5i4B0iuJAp0UgSV0eRra9rWwlmNYedh0pTn7QRT6uQ4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0BwDDnUp29YTXLwn+Qz10cpJrBLaleElyUklhhBpp76nlV0Mk
	nLu7qT4VMJ6W5XTZLo48W6uVdhj4EaUCC1oWKihAvdPVbH2jNOSsPbi5fpVQNgE=
X-Gm-Gg: ASbGnct0pNqOrMQYNLR92wSE0PjM5EG4hBKTWQB7qntqLWFjohkV8YlIuBZsVlUO/iI
	de+2kcdt2KSXUwL9SWBdUw08XCwd11f3PMoibQeGCAHphd2zZoAEKsJ2ktsgjl+0VjMkJT5R791
	a8i1X/MhUdCPK4yJ3ZjV+HdTLhw8SAfhaZ6daJqG9mNS6TruHsTQzJszTTbj3+S2LL4fppeBUMG
	u/JlquTpXKuOCk6bz4GHIAaCt6dpvbxrzIZ+7apDgLvwFc/ZzXn3oRDvfcspgqCEQNB4wkTw1Rf
	yvPyR6e04uNEUlcGEdcs8aFcJNKBS0Q=
X-Google-Smtp-Source: AGHT+IHvbDRkkAMa1vWNiKvSm78EVhBveMF8emVyRCP5+UYCqs2dQdsJcDTDXtVjnaDKUT4ZXiDzcQ==
X-Received: by 2002:a17:907:2da0:b0:aae:e684:cc75 with SMTP id a640c23a62f3a-abb70dac916mr386633166b.13.1739810532844;
        Mon, 17 Feb 2025 08:42:12 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbac781b78sm82647966b.60.2025.02.17.08.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:42:12 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 17 Feb 2025 17:41:35 +0100
Subject: [PATCH v2 14/16] drm/msm/dpu: Add missing "fetch" name to
 set_active_pipes()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-b4-sm8750-display-v2-14-d201dcdda6a4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3984;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=MRN/ryi+pMGgkQFSG+NX2HFCuyWv6SXBLRgehaGG5PI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBns2bDHVydNVYpXSL+Ug0+oBX/FfYHsQrUWyOPQ
 Ako0B13CUWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7NmwwAKCRDBN2bmhouD
 1+ooD/97+K/YLW3t+RwvAHJQk/mC1Yi7hSFimM+NNoceCV3YhSkyt2Cl9W/PEkn0NOZO/ZgibiQ
 66pYtOLCVNmK3izL1Gj775sFdhyKX2MT/omTGIEx7/WaqGzBj6R+xqobVDBxkfBsGYsLaLi8PLd
 0ROu6u+6CbbiyUPVvieFlQF0N4W4WbQ7BdweI7UdZd3XJ6WrE3EsedVHUweCfMdVhrSka4A8XAw
 SsQN1mrnAuU0fY/CLaFg1OcSND0uIrQCxO/T3fe2Tetajv6k08LunoYwODO5M9yW4rOzQULOtv4
 2HKgOK6tUZSbYobV76tKMz9410G/w/Ap6CvLreebbEi7dvct+SQh9ciZIsBNqr1uqsp7moyfNB2
 CEbmhhl0wq0Gph6khzPIz3RcGuQhN6/iwn/mT/n+jsyf1A40LONg2k8bacZKNwu38jh+F0ZvW3p
 tX7Gb3ovjkQTfrFeDuOVqnOLunKKsaO6+/lJykiuxoHnvQsvkkls3O1fAVx0qI7Kj4kWqC6KMzk
 KdXaFkitss7d8/pp/PFfcLyVjTiKNmrAFh+I0vwdACzIqAAWO+XZDbUM7HGKvr8CFYd3wHlmM5a
 sqIjywaAXll96UGyYCdfjzRJfy3wGFdIvEt1r1ojelM9XtJWPbS9ku6jbilMzecWNccpDWswpm7
 OciF5ZrjZbDV7UQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The set_active_pipes() callback configures CTL_FETCH_PIPE_ACTIVE and
newer DPU v12.0 comes with CTL_PIPE_ACTIVE, thus rename it to
set_active_fetch_pipes() to better match the purpose.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. New patch
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c   | 12 ++++++------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c |  6 +++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 7191b1a6d41b3a96f956d199398f12b2923e8c82..7de79696a21e58a4c640f00265610ccce8b5d253 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -445,9 +445,9 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 
 	uint32_t lm_idx;
 	bool bg_alpha_enable = false;
-	DECLARE_BITMAP(fetch_active, SSPP_MAX);
+	DECLARE_BITMAP(active_fetch, SSPP_MAX);
 
-	memset(fetch_active, 0, sizeof(fetch_active));
+	memset(active_fetch, 0, sizeof(active_fetch));
 	drm_atomic_crtc_for_each_plane(plane, crtc) {
 		state = plane->state;
 		if (!state)
@@ -464,7 +464,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 		if (pstate->stage == DPU_STAGE_BASE && format->alpha_enable)
 			bg_alpha_enable = true;
 
-		set_bit(pstate->pipe.sspp->idx, fetch_active);
+		set_bit(pstate->pipe.sspp->idx, active_fetch);
 		_dpu_crtc_blend_setup_pipe(crtc, plane,
 					   mixer, cstate->num_mixers,
 					   pstate->stage,
@@ -472,7 +472,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 					   &pstate->pipe, 0, stage_cfg);
 
 		if (pstate->r_pipe.sspp) {
-			set_bit(pstate->r_pipe.sspp->idx, fetch_active);
+			set_bit(pstate->r_pipe.sspp->idx, active_fetch);
 			_dpu_crtc_blend_setup_pipe(crtc, plane,
 						   mixer, cstate->num_mixers,
 						   pstate->stage,
@@ -492,8 +492,8 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 		}
 	}
 
-	if (ctl->ops.set_active_pipes)
-		ctl->ops.set_active_pipes(ctl, fetch_active);
+	if (ctl->ops.set_active_fetch_pipes)
+		ctl->ops.set_active_fetch_pipes(ctl, active_fetch);
 
 	_dpu_crtc_program_lm_output_roi(crtc);
 }
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 9d4866509e97c262006e15cf3e02a2f1ca851784..2e1e22589f730d1a60c3cbf6ad6b6aeaea38c6fb 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -675,8 +675,8 @@ static void dpu_hw_ctl_reset_intf_cfg_v1(struct dpu_hw_ctl *ctx,
 	}
 }
 
-static void dpu_hw_ctl_set_fetch_pipe_active(struct dpu_hw_ctl *ctx,
-	unsigned long *fetch_active)
+static void dpu_hw_ctl_set_active_fetch_pipes(struct dpu_hw_ctl *ctx,
+					      unsigned long *fetch_active)
 {
 	int i;
 	u32 val = 0;
@@ -764,7 +764,7 @@ struct dpu_hw_ctl *dpu_hw_ctl_init(struct drm_device *dev,
 		c->ops.update_pending_flush_dspp = dpu_hw_ctl_update_pending_flush_dspp;
 
 	if (mdss_ver->core_major_ver >= 7)
-		c->ops.set_active_pipes = dpu_hw_ctl_set_fetch_pipe_active;
+		c->ops.set_active_fetch_pipes = dpu_hw_ctl_set_active_fetch_pipes;
 
 	c->idx = cfg->id;
 	c->mixer_count = mixer_count;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
index f04ae0b1d986fa8f73e5bf96babfca3b4f3a0bf5..b8bd5b22c5f8dadd01c16c352efef4063f2614a6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
@@ -243,7 +243,7 @@ struct dpu_hw_ctl_ops {
 	void (*setup_blendstage)(struct dpu_hw_ctl *ctx,
 		enum dpu_lm lm, struct dpu_hw_stage_cfg *cfg);
 
-	void (*set_active_pipes)(struct dpu_hw_ctl *ctx,
+	void (*set_active_fetch_pipes)(struct dpu_hw_ctl *ctx,
 		unsigned long *fetch_active);
 };
 

-- 
2.43.0


