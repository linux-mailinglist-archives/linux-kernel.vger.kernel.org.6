Return-Path: <linux-kernel+bounces-533846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD8FA45F71
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C353B6D02
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FF1218591;
	Wed, 26 Feb 2025 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QNfHIp91"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6783A217F48
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573176; cv=none; b=FZd6RQJ6NndPeS4CW26Kevrj2pexyF/3EGouhldWli1h2Kc5XSNjGeEg6tuEX3nJfYTUdf0DR3LJTgiEuboyjYpqKYv3ukJlQ5ICis7ACercapf0EZtoZGjVuB4hhF/uyldc30gC4UEzyFnN8tZqwGfsyF0nMI72hzuiqSVsmOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573176; c=relaxed/simple;
	bh=BbqtIHW7JPzSyRGmtZOcXUwUkV9c75Bm5PqICVDkcB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W1a+4l11OoJdE6W82jXfATmwCzq9wD+m5Cj4OchzZAuawamw8F/LZ/hYCas+zfRmXh71rAUcqI2SmbNn6V74qwOIyuprMkpJToQ6iJ3j92RI8umaeH4+03Pog1hsLOoqShNELuc1b6tnYWrHY1mUYD2f/7JPF+mMKSBIUhri36c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QNfHIp91; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so10771495a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740573174; x=1741177974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qq+zAHNdvdZOSJ//3Q5rS+vuxV2fvoAwakzSqW6Ri/w=;
        b=QNfHIp91HlAq1Tkxxm0epcaMq9PF+hUkFS8h95OrM4H5KmbKowUCvdN4o6VdfLsq3j
         2ginK+zaCHJ4T2x/eU6TlzT/dgWgq4FLXca9RhE2Em4ZfuMC28DV3LDZ4+ca2BOyrnXs
         AZA4wfzyFJ+tEtRv72eKnjXYz5xoXaNFLZcEBiGrCB/1UrF1Y4OVgl6VtiWqWoj0+rRg
         IN0TfywVfrxGcJeZPsIIDadGG9Ady6Nu1P33akoE+o1FTkXJE3ah/s1LQkhw860OHTbY
         WhRkLAI5o2s+LoESiql3jXynUCa2k7qFm/JOp8qSsjbil8OIy2vT831aheSIbZ2/EEsO
         ilMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740573174; x=1741177974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qq+zAHNdvdZOSJ//3Q5rS+vuxV2fvoAwakzSqW6Ri/w=;
        b=lwHQnD6qyH41UDs2Qntxkg5+cTHwbbgRkpYduPFlrrPkslgNgEkVHxxfHy6VeRgT2N
         /Bj1M01bVElnIbBP5hNmoXIsuXQdZG5qsjvTtJzLTtvYftYLigQCQfvO33NqdTZjIOG2
         D9C9F8Dwvg3Uzv+KH1lH7Bb1m0f37c9+rHyj0u5+7IgbabrG+aEegUnu72zMMzFstzUR
         mnHQqyKPRBuwkFEbMR+NfvnlhCWcMEGA1kco9dyVZq+XLgmL/4XCwNdI+etpsNzF518p
         tB9MVEyHhU/YgTkEqGnNLD67moUfBzJW6pYJN7DGRDvA1Je/K9vhVp+ONiD2PUzgMYiI
         2QFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmZvyPpv4nV7qNXGwMTYjjWBPEjxJwdYQ1KtW8THcR6XXooGX9MsufARWlLK4GkWXcjOEr+pWlCK6P7qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YySGM/9cCDo5n9ujrMHVBsX9OyjhA/J76zmTaqKh213rf7GJbF8
	F47gjRBS6pV+bq4XWGFtaq5nAGbJcHZ0wy3UU/ds9SbEYElI/ICObYOEC/6c2RM=
X-Gm-Gg: ASbGncsG5NMTELE7bfWlaWgfmkCEPPOHTYhpJkvruYrlsx5BHHRQwz/lc3dv9RZ1c7b
	g5FmSQ4zZ6oPtOaZZhANmu4Cp3uL6Uk/q4lqI4d/JM/ippnJrAc7D5tiC1fCo+uW316K0KQ+V8R
	vwdEjMjESy37gMUEDjdGC4igpboF44bW4xd8PA3xX5qN/1sb6yNEDB8Dk5/jKf+BH1ZeX5OMI7m
	VlV9b/FsIlK4oJbV5LzBDxkWv8Pi5BOLovOPJeRv9KSQn4t+oRFkNqGY3zin82Cr75UKAHipsd2
	p9EMB/EVBcCkdPnDvINZYkw=
X-Google-Smtp-Source: AGHT+IF5L7rzBSpk5qpsdgsAUFke51js1iZjo1fChsxijAq1kVHbMpTBDgh9GnhBUEpzjWW9aGsJOw==
X-Received: by 2002:a17:90a:c88d:b0:2f4:f7f8:fc8b with SMTP id 98e67ed59e1d1-2fe68bff7b9mr10849509a91.27.1740573174703;
        Wed, 26 Feb 2025 04:32:54 -0800 (PST)
Received: from [127.0.1.1] ([112.64.61.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825d2ed3sm1352479a91.29.2025.02.26.04.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 04:32:54 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 26 Feb 2025 20:30:54 +0800
Subject: [PATCH v7 05/15] drm/msm/dpu: decide right side per last bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v7-5-8d5f5f426eb2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740573128; l=1985;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=BbqtIHW7JPzSyRGmtZOcXUwUkV9c75Bm5PqICVDkcB0=;
 b=V/CkV7RfmMO2LWW73eg6oN53kkGMHGfvRe6idE6dRf7RLfIow3wlkAPeJrWmi8SDPXs0fCLVL
 pq6gm8FfMxWA+SjXyE5WFzO3MKcNwQq6WTfuXo1z9HFbqCHHOSYohl4
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Currently, only one pair of mixers is supported, so a non-zero counter
value is sufficient to identify the correct mixer within that pair.
However, future implementations may involve multiple mixer pairs. With
the current implementation, all mixers within the second pair would be
incorrectly selected as right mixer. To correctly select the mixer
within a pair, test the least significant bit of the counter. If the
least significant bit is not set, select the mixer as left one;
otherwise, select the mixer as right one for all pairs.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 7191b1a6d41b3a96f956d199398f12b2923e8c82..41c9d3e3e3c7c0c74ac9007a1ea6dcdde0b05f97 100644
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


