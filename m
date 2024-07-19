Return-Path: <linux-kernel+bounces-257184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EEA937663
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2EE7B25445
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFA182877;
	Fri, 19 Jul 2024 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GHy4nE5O"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E4729A1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721383431; cv=none; b=nLmU7Y0nLLOeeORDOZ9SEgYPvmuNzj82Vo6J+8eUzCffw/Xum0mQhEGVURvU9PKNflmtp8owzfnsOzLV0U6rAnUZF7COqFMLd4eCXxT2QV6qP6llL98aOk3ocTSzJXXxeGN4qUKX5d78bIOqNb9tkXFH9uZexQn9u2o3o/0PYqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721383431; c=relaxed/simple;
	bh=izI20aXStgBYgn8HFsWluR+V7mVSO1GycmUKfkzqj9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ug4Mk06tFPX3xz1E5OwbnQInMl90wONyqB7UqRI0e/QghPTnOSi0fVBVUfVyDGC7UugexPYkkBpwRIGs6VxLpRKhJyAeookyqKB9lZ6wvhcdBI0VUlLoYp5EbOXPROy6muKxoNiSHfbWezJznOyWOgEbPIcYrzzfPPS1zIyfu4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GHy4nE5O; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58e76294858so1336335a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 03:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721383427; x=1721988227; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dojm5EDomrVj4JUg8oRrMk9Vwo9o7S9xTIkhL5loo68=;
        b=GHy4nE5OhEWAPohbPR2w9rd5+p4xQpBCAC6BH6eGuikYwu8dggXSLj89v3e2YIUk1g
         gVpJx2aBHk8O0OWCyVdYJDyCAz0K24qKkS6wg21IO965xM6GvPxjz4gpGExGiPnKNXAQ
         /IIum1GSoTkijtICrXbNtMy4f3/nJmNHAXCiCjP7KHzVZm8DUbBx4aBoX4cp40zakKzv
         w15hQzUHiWqiPY3O976SCISbNp2XNV/QmLbV8Wr/LpFhDUAwEm405Kn4KULQAIkRGP64
         RYNNgPZ1Fcug9BYuPPW/4kiHx8frLGiC3HmWcbgpa6ed+LVQ60NzouXMu8C/uNVui3aX
         7W8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721383427; x=1721988227;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dojm5EDomrVj4JUg8oRrMk9Vwo9o7S9xTIkhL5loo68=;
        b=jkibs2hLGrT8cDi1+mfw+hoTuf8XDsVkYzqyi4kQ6sYxs2//a/HBsSmtJWFyRYD9Sd
         9oY4AeMGfgqe1J/whAioyUMtOAhLXPX3E2ysObOgvDeJxCTCHqZvr2DucfptrtOTfpJu
         G/SFPMFb1sMB7T1Jlc0h5+A7DS37f34LKd9qS0RSu39ByC2bwi9hYTG48UrcfwhELAKB
         caJD1eKJ6g2S2TvoZ9wriJbgCjOux6uOWywLfNogi1WZRe6vduOsQjgrTZb1xxREVGe+
         fthO/Y/FR7OJb/8JsrTeKxY+f0Mv5yuRWLQ0y7AUQOIMmPPa09U6h7NC+nbEj7PK4XMz
         6bQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkNivwuzk1Yp0oTAR2b3xv2QA58NthU+nq7kNlQGQotLXIOcUX6GIK/ITbrmfrdiNNpfceN1ePojvOInnEg7KxDMPZyUFm2exvVHgV
X-Gm-Message-State: AOJu0YyTmNOqziOfvm1KF1RCXpYzgHklMdLROgD2cErokfdELY5d/9Vw
	m6J7eIrk13aKJMr1j+0/ghxlw6aEyoZP8DbOf/KqW4cMLMtrP2R2dAfHciNsm0c=
X-Google-Smtp-Source: AGHT+IHnaB5YdD3StKR6m9it2+rtNPUKChRJh+O3ecDwUr1Ack0r/lnJpwK4dkqjy3s6ITmXYoebTw==
X-Received: by 2002:a50:9e48:0:b0:595:7779:1f7 with SMTP id 4fb4d7f45d1cf-5a2ccb8bdf3mr1754758a12.16.1721383416050;
        Fri, 19 Jul 2024 03:03:36 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30aaa31e0sm919984a12.27.2024.07.19.03.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 03:03:35 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 19 Jul 2024 12:03:26 +0200
Subject: [PATCH 1/5] drm/msm/a6xx: Evaluate adreno_is_a650_family in
 pdc_in_aop check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-topic-a621-v1-1-850ae5307cf4@linaro.org>
References: <20240719-topic-a621-v1-0-850ae5307cf4@linaro.org>
In-Reply-To: <20240719-topic-a621-v1-0-850ae5307cf4@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721383413; l=964;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=izI20aXStgBYgn8HFsWluR+V7mVSO1GycmUKfkzqj9I=;
 b=4Q/jMz+9CswuFRv6acP1RY9tHUiRpIOJBCeen/F6KQA41/eIu08K7TMuJQrwSwDqO5uw7BRm9
 i12P5Z1JgGGC2fg2e+RX3bB30UnoccG/A3D+PWnO/kTtwJ6ReTHc+vG
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

A650 family includes A660 family (they've got a big family), A650
itself, and some more A6XX_GEN3 SKUs, all of which should fall into
the same branch of the if-condition. Simplify that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index cb538a262d1c..6f168f1f32d8 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -525,8 +525,7 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
 	if (IS_ERR(pdcptr))
 		goto err;
 
-	if (adreno_is_a650(adreno_gpu) ||
-	    adreno_is_a660_family(adreno_gpu) ||
+	if (adreno_is_a650_family(adreno_gpu) ||
 	    adreno_is_a7xx(adreno_gpu))
 		pdc_in_aop = true;
 	else if (adreno_is_a618(adreno_gpu) || adreno_is_a640_family(adreno_gpu))

-- 
2.45.2


