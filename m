Return-Path: <linux-kernel+bounces-356594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 557919963EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1674F28826F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6BB18E34A;
	Wed,  9 Oct 2024 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JpH1P2PG"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D768818E34C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463837; cv=none; b=Zf3VwMZRwgxXzBDh1XbyYoNHD07mJzMpQV/s8DRjyVZ9ioB7Fbtk6aPxfoZ+ahlcKhlNlzTro4NYyxCySRzRXyAsC6ItFFjkSo0lrTapWnvK5GKFKum0vBkcr7pWr1Dwmx3cl6eD2F78ea/ZgreDQ9LnHia7VPF0E/vftYZCir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463837; c=relaxed/simple;
	bh=VkIAGwnZaBvIGk9O/Pd26yOaUH9F6U5Y+Vxq/wNMgsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sDDt3kzHWbmVGStxpwbXo7jDHdPuS8cb6J6VrGfubvCMN6w9y/6uiA3pc7rMfMBkYLlgCOw9Q2r2qQ3pmZMkcYTjXM7lGisEFHD9q57+HviVgUmlnDiLNpZvZwdMf6DzJv0T4Ysk2YS7xFH1xM5YDk45250AN5VaiV7Xy5kd0uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JpH1P2PG; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e09f67bc39so5465278a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 01:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728463834; x=1729068634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQUSJNvwZ/PY6GUH9AC1To+F9Rww7eBYxG8hGTmYBHA=;
        b=JpH1P2PGdhrv7UrLZEdbm2BgzHw+CU/c0HDvdb1VNCMWvjJONhFgGc81CWy1V3yWCH
         eqMhvL2+4VIjSaK4KgybfEJoApyDl57KGxHuMw1AirVORJOOp4XALhsD0fy77npElBxj
         LZvi0GF4HsSxkct8gIdKv3xJXBGb8pFGrC9sWhJtNCGP7pSj6uZ+u/04KeuqBAxQEG85
         l9O0ZUNnbwRroR3s3SU2ZGB8EzDvTYD0rKVlIMBOOBF1XjDT71rPu5YzJcaPZ9MOKRdv
         5GTZAdcdQidEDuseDvK5f6I9dIcuLrl0U6372+E0hw+JNA7IV90qsnXr0GkIL9/GwJho
         vXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728463834; x=1729068634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQUSJNvwZ/PY6GUH9AC1To+F9Rww7eBYxG8hGTmYBHA=;
        b=ouVfmsFefyc3uBW0MMr6WYeE61qlnTvrkTl5joHQ47BXKlPUnuT9/ceD/10BohLe3J
         FJchZEQZyTMrb5hdkANg6JbU2UUWNdjYQLyOCP2Q6i7jXDGauyLoiKigEgxdZjKlLOCm
         jihu8UbCSP9IsmioUxel3LU9rTJzZHav7V5WJCWxObx1G4p9sfETs55FhsBQFFTibHaD
         UD0aQxZBZQjuGduRjdltYFKMPcQHt5hEpFF6EveEai4i63rXnB38dtZUrAIoK7CNomcF
         dRnAGODP0sPwubN15aR0M2K1i3xzmDaWVIh7v+03eULjAuyHzuncZWDgmXtexAU5moP2
         1D8A==
X-Forwarded-Encrypted: i=1; AJvYcCU04AlV/coL6KkvSNpC2Xkt9RUZ2CjRbM0mFHaDP5GDxITdT6foVvqvNIkTw66erpwJpTDIi9siEiZhS1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Af1vadaI0x72WpIwXI9x2PDmzWJq2570W4I3hU6Uqb7AMWE9
	9Zh3QPqQkyETaCCJucvI/y7R+mLKg8smGzMQR6X87G4qV1fJP9+zoEwCTIZ9ZLc=
X-Google-Smtp-Source: AGHT+IELZNGpZl+o9brSMTMV2R5qjLAQnLo4r4MZsTmntvKCuRTaaBljTAzcdiFMnYwOHsV1z7J9Aw==
X-Received: by 2002:a17:90b:1104:b0:2e2:9522:279e with SMTP id 98e67ed59e1d1-2e2a25247e0mr2199871a91.31.1728463834283;
        Wed, 09 Oct 2024 01:50:34 -0700 (PDT)
Received: from [127.0.1.1] ([112.65.12.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2abad236esm898157a91.10.2024.10.09.01.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:50:34 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 09 Oct 2024 16:50:15 +0800
Subject: [PATCH v2 02/14] drm/msm/dpu: decide right side per last bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-2-76d4f5d413bf@linaro.org>
References: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org>
In-Reply-To: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-21-v2-0-76d4f5d413bf@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728463820; l=1407;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=VkIAGwnZaBvIGk9O/Pd26yOaUH9F6U5Y+Vxq/wNMgsM=;
 b=aojPxprQ0psdASS4m8/E0MCuQj6okV8Fejiw7zVz4jm03ih52aCBaafWdJ/sa3xxRnZyuiX6W
 CVGfU1DgFG7D5QOSOi+332+U+ccsaaKBjtPHPV9UyH4D/pH/Nk9Dih0
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

decide right side of a pair per last bit, in case of multiple
mixer pairs.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 7d0fff9472441..3e0e6e9757da5 100644
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


