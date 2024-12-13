Return-Path: <linux-kernel+bounces-445626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA049F18B0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0634188ED20
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AC21F03DE;
	Fri, 13 Dec 2024 22:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RBd7Rzsl"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554171EE03D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 22:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128098; cv=none; b=UR+fZXba7ibiM7mmO/0PUMOqyVlUina8j99tN9+Em0OFSACP3BHnhzGZ52KNi9mpH54nUiHpONOhniUsuQfYkyBoVDcrT+hcnv7PC9/2CiNakQ9U9P/RsHctUkDvLB9JFG4348WGnGgJ+Ksmo7T5k5dLjcBY8YTEgmb7Yx+tnzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128098; c=relaxed/simple;
	bh=7p9Y0N9fe5J+FNtNErF+g9/bY2UcR9C9Ev4Hmj1Hodk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N4S0pOuZvxpphEJjBHCicNIRUg4wkZF2mJgH8GMyO/t6zrlRhkhoJPIvKx2iSLAgTTZle56sH4BXs3nvUBSmu5O9hqwyODwX9AkAFHaGRswp44guiczz2p12it37FO3VagOuph4TztAiymY/sUExXHaoHSRbrtzIeWI4lwfN/oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RBd7Rzsl; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30229d5b21cso19118341fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734128094; x=1734732894; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opYI+4K2DJJKwW+ZJQ9gJCluOKx+HHP7NZLtl3Vo64o=;
        b=RBd7RzslCoxNd01SuyTF6zlVrX0U/KOpxwMgEqRUz+d6lykP9Lk3EUoALe2w4NS0qM
         RbCdpL65pQh3YJIXYP9brFxis/vo+ehzgusiiPCZRHJPz6nMaAL3m9F5eknqOT9gwrez
         Kk/wqqzRN37Ae+5gn37AEi6u3J8I6vPq7felRxll7+tDUgWLoLWaIyzO0RA1/iMlCTIF
         wD0zQDUUhBaPpcMvTcizny/lvA98t5U42pV9rvzBU0pUHOwQBXiEpyQtUMH3rTi65x74
         DnLCHaoTkzkJVL6RbscpnOKiCIl3erdckseAryqdv2jdekqqPOlP+iNxb7oSmJtaI2XF
         0aVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128094; x=1734732894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opYI+4K2DJJKwW+ZJQ9gJCluOKx+HHP7NZLtl3Vo64o=;
        b=t+FKer1SNZC5nBmRYaRTQDALuyvxba8z1Mk35wQAUj7yBz+KV6njJr3wM2cfU4dfE4
         M2+X2TC7pWo5iGdQlvcwCAXgSEQ+l0K5jxo/Hpnz04NpvtkPiChcg1yNEI2rDPILcISd
         dK1uek667G+IT8/J41TvfptYnheGmCbDO+IZ8/9gHw4qra2XBygjDe03aqlVFnI7IfTN
         CVF2kMbjYnAgtWimz/WdaT0umgmSWqgFpG/+dZZyGJvWJyPNgkztBiozNli911ee3+F9
         R+aQdnUygir85CzPASW+HbgXU12TXBUPFX2zsvcXfHhvNCj18GMBYHF5BIJv/4uDFa6s
         O2bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWR/KnDj3Vb0J1fint62SR39xNteDF+RCoTldQD3LmrS/UZOvYqn81LtjtFGr0imQjnYoOD+L4NbKesuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZz4GxNvmpbMZfzxjwk1wJKsgU1VrwNjhg5ShTJcS5NNhMF09z
	CFFOy+EaLG4mDSGGDXsYE+7MKJa48d9K+czCqKO6Ptcy80eR8l5Qd9GQyvoa9ZU=
X-Gm-Gg: ASbGncvepQshWdAeVEV44+E9w87he8ACposZ1syhVARSyGQKZlXLyfNvOYp5YDu8oA2
	vuIdZy35anxaYBHYeUs0w3TQbY6InPwKB+AKNxTkJdAbP2405W4JWEqwbfYU8ApLcfuBr8vQDC1
	S33/yT593bdmMNZeCh8WvOQa7S76Un+wcVuSN0POyk7HK3z2QHFs4TbwiT+VEOSVWo3BWO2Sa+g
	9zqvkB9h701X5irKIpepectdvDj8WI0FH3Dw4fE/clQ+I0eYU1YOjgMFZq5elPQ
X-Google-Smtp-Source: AGHT+IEKYmfLZkuO7EgUY1v4G1Iwhi9AGdgh/bx/sqa3CDhkR/s7AfQq3cx/0emmaMmMhC0mjhOvrg==
X-Received: by 2002:a2e:be23:0:b0:302:40ec:a1b4 with SMTP id 38308e7fff4ca-302544b112cmr14661261fa.30.1734128094482;
        Fri, 13 Dec 2024 14:14:54 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441e0f43sm413451fa.125.2024.12.13.14.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:14:54 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 14 Dec 2024 00:14:24 +0200
Subject: [PATCH 08/35] drm/msm/dpu: inline _setup_mixer_ops()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241214-dpu-drop-features-v1-8-988f0662cb7e@linaro.org>
References: <20241214-dpu-drop-features-v1-0-988f0662cb7e@linaro.org>
In-Reply-To: <20241214-dpu-drop-features-v1-0-988f0662cb7e@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2099;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=7p9Y0N9fe5J+FNtNErF+g9/bY2UcR9C9Ev4Hmj1Hodk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnXLHFvYSehS5Tz24MK4MtF4NatfCHlTOnx1c2v
 TJMYwsSZs6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1yxxQAKCRCLPIo+Aiko
 1eL5B/9xEi4eRYyvweYAaE0ngSBTRPHVKpylfLocewX8Bn1P/5aWDfg4AT3MKwwLfbnt7tCJ24G
 k3pdQLmKQWVf7148LwG9yHljs51Zj6OzpoJf5aKMDfNQaAO0j/vUZRlOTIo7hn77UBXfnHl/drB
 Kk1q59YZ4Gt5k5Iz1o04iKUhu677KtDpt7K2mTtGLtzmypzkFUXfiEP21Rl74PWiRngvNsT1ktr
 Bxo11MKAqbaqvodCncIGSa+KRSTSuLvz6u/VcFY3FNxJ9AFjj5Jigg7249SIXoMM0AQtNDllZHx
 kLft3WQw/Z9i5v2VJe6Pq9SNNQUTE6buGe49Y8Cno/04aOTQ
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Inline the _setup_mixer_ops() function, it makes it easier to handle
different conditions involving LM configuration.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
index 81b56f066519a68c9e72f0b42df12652139ab83a..4f57cfca89bd3962e7e512952809db0300cb9baf 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
@@ -144,20 +144,6 @@ static void dpu_hw_lm_setup_color3(struct dpu_hw_mixer *ctx,
 	DPU_REG_WRITE(c, LM_OP_MODE, op_mode);
 }
 
-static void _setup_mixer_ops(struct dpu_hw_lm_ops *ops,
-		unsigned long features)
-{
-	ops->setup_mixer_out = dpu_hw_lm_setup_out;
-	if (test_bit(DPU_MIXER_COMBINED_ALPHA, &features))
-		ops->setup_blend_config = dpu_hw_lm_setup_blend_config_combined_alpha;
-	else
-		ops->setup_blend_config = dpu_hw_lm_setup_blend_config;
-	ops->setup_alpha_out = dpu_hw_lm_setup_color3;
-	ops->setup_border_color = dpu_hw_lm_setup_border_color;
-	ops->setup_misr = dpu_hw_lm_setup_misr;
-	ops->collect_misr = dpu_hw_lm_collect_misr;
-}
-
 /**
  * dpu_hw_lm_init() - Initializes the mixer hw driver object.
  * should be called once before accessing every mixer.
@@ -186,7 +172,15 @@ struct dpu_hw_mixer *dpu_hw_lm_init(struct drm_device *dev,
 	/* Assign ops */
 	c->idx = cfg->id;
 	c->cap = cfg;
-	_setup_mixer_ops(&c->ops, c->cap->features);
+	c->ops.setup_mixer_out = dpu_hw_lm_setup_out;
+	if (test_bit(DPU_MIXER_COMBINED_ALPHA, &c->cap->features))
+		c->ops.setup_blend_config = dpu_hw_lm_setup_blend_config_combined_alpha;
+	else
+		c->ops.setup_blend_config = dpu_hw_lm_setup_blend_config;
+	c->ops.setup_alpha_out = dpu_hw_lm_setup_color3;
+	c->ops.setup_border_color = dpu_hw_lm_setup_border_color;
+	c->ops.setup_misr = dpu_hw_lm_setup_misr;
+	c->ops.collect_misr = dpu_hw_lm_collect_misr;
 
 	return c;
 }

-- 
2.39.5


