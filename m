Return-Path: <linux-kernel+bounces-306641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C38B96419C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6AC1C20A57
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84F01922FB;
	Thu, 29 Aug 2024 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GBZ609hZ"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D018E36A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926818; cv=none; b=Rgdapt8DiPbCKz/vhky3mX+IKTp+//gboJQnSbVX11YtjzaIwkpXtVIarltsyJkIqj+BxY/CNb7E1AlJoIE8GzAFMntY+orqwMbc/4K0Vs70nTH08YK4qWF9C1JWxcnHBXU6dxG2hkwRAOQTd7X3PZ3StfGj/gOB7JIVOcnMimc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926818; c=relaxed/simple;
	bh=IWaQt7fOIuTYMO/sDj1ofTNDciH2u7nSLcam8JkLU5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oiLnZjBa62i5dEyQwo7DAKZfMpMJuRq4PuV60oS2j0uqUNsExuwjL/L1n+GlqpQLWuyJTqrlkgo7QaJu1lpYDG6wiXK94+9rooUnXKkABUgNUbI637TFYGu04WqP1ZSJb8IRxhA6yviT7udkWfaMjyTsUOYFoBSz0pWnCzxtyUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GBZ609hZ; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70930972e19so171888a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724926816; x=1725531616; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8bZPOFtZouu5Teru3SXjHUwrTGv8xZnRnBYE1IpFB0=;
        b=GBZ609hZrAhBaFU57vplkYxqfEv1DUMlDqAXlJ4dUe4PgP50yNtAlkU6nRx9P6msXa
         +LkIOysLYdYOlorOiQEIjwt3X107NDqM4109MvNTOuVnkWOYWaCJBCJhyKcvHHFE0AOy
         zFtLxzg51ypg1KUG9fw7dP9nI27Xyck6plXgfdwcew5jhG6Jcm/21fnNpPyahPSv753D
         ev4+2F8tffsGf+JFsxohnjf+kjrRVUISRuVoTLcIATP7HDzopBM8XAejuA3tP5sSfuhP
         uPjitQJecZNL096g3qnArmJTb5UJVFjZJg9rTbRNCKaidurNJ50OZz8dk4eNy2bSed7p
         iRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926816; x=1725531616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8bZPOFtZouu5Teru3SXjHUwrTGv8xZnRnBYE1IpFB0=;
        b=jLO32RX6jwZ8QgLaDYyguQqWSC8CipY8ABWIl7QqIKXes6slMXBqA08OiNFej9W0GA
         I3435HbNpoXclL6tMUGgG0ir7P/iTDMySjND0mkwIJOQSY5qsEnFgV9s5Ald9xzSnyOd
         ZrY2to3Vu3TMPsQY5VWRA6J9s5bpgaaNdv/fkfb091mZaBU+NaF6arCuMmX+aBbiCSu3
         IEa45nGNn+D8sleH4UmohRoJSZAKRPeH5J8JSVD3unSIDsCFjBBe9nX3rxpDFdr5Hkd7
         uzbt1sIfJrgiTGPxBzworUxXWg7FPm8z4fgcQzauCRYKvaCwbFr9uSEC86KFfGblxztR
         So4w==
X-Forwarded-Encrypted: i=1; AJvYcCW3h+RsxE4hDw3uKHkqkG4i4np87H2FnTQz0xnl+Pz5+WoNf4eg/kKGJDyfl5Wz02zqxLPzmBrOyZtqu5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsETJw/FWys6QRV3Oo3GO4OASk8iQ6ZnStqqEGPOseQROHY0b8
	nK8AL//spDogTLAALhgtFbel9hIuYQEfHhPiO0j8Va/jLWEjabcd4YZ38um4GoU=
X-Google-Smtp-Source: AGHT+IEym+LTunQTzfEmwfn9ioQibaynXV6VWyoQiFC3MErj3eUuTmWGKObCu8L9rZiNCDri6dHHhw==
X-Received: by 2002:a05:6358:29b:b0:1aa:b266:2a67 with SMTP id e5c5f4694b2df-1b603cce482mr233441555d.30.1724926815732;
        Thu, 29 Aug 2024 03:20:15 -0700 (PDT)
Received: from [127.0.1.1] ([112.65.12.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d4df4sm891684a12.82.2024.08.29.03.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:20:15 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 29 Aug 2024 18:17:37 +0800
Subject: [PATCH 08/21] drm/msm/dpu: decide right side per last bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-8-bdb05b4b5a2e@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724926736; l=1363;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=IWaQt7fOIuTYMO/sDj1ofTNDciH2u7nSLcam8JkLU5E=;
 b=ieBILLU/UCHYnkUeuzubKY3xpimkInETjb4hrSXsJVo68E0UyJbCNZUYZa/sf3Xf25pT23B2E
 G+zkaRPb8/1BUuBtPQa+vtVVb8HJTql3RoelmtRjCwo4R/VQBtzW6q+
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

in case of multiple mixer pairs

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index a27e39c525d1a..d9f26e189eebf 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -369,11 +369,10 @@ static void _dpu_crtc_setup_blend_cfg(struct dpu_crtc_mixer *mixer,
 static void _dpu_crtc_program_lm_output_roi(struct drm_crtc *crtc)
 {
 	struct dpu_crtc_state *crtc_state;
-	int lm_idx, lm_horiz_position;
+	int lm_idx;
 
 	crtc_state = to_dpu_crtc_state(crtc->state);
 
-	lm_horiz_position = 0;
 	for (lm_idx = 0; lm_idx < crtc_state->num_mixers; lm_idx++) {
 		const struct drm_rect *lm_roi = &crtc_state->lm_bounds[lm_idx];
 		struct dpu_hw_mixer *hw_lm = crtc_state->mixers[lm_idx].hw_lm;
@@ -384,7 +383,7 @@ static void _dpu_crtc_program_lm_output_roi(struct drm_crtc *crtc)
 
 		cfg.out_width = drm_rect_width(lm_roi);
 		cfg.out_height = drm_rect_height(lm_roi);
-		cfg.right_mixer = lm_horiz_position++;
+		cfg.right_mixer = lm_idx & 0x1;
 		cfg.flags = 0;
 		hw_lm->ops.setup_mixer_out(hw_lm, &cfg);
 	}

-- 
2.34.1


