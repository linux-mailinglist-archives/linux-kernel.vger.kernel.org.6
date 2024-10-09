Return-Path: <linux-kernel+bounces-356358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B76995FF7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8CD1C220F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C2F22EEF;
	Wed,  9 Oct 2024 06:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ia28nrey"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550C417BB06
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728455977; cv=none; b=ZpLmvddNdJq5ETDHTFhYVvg66jc6NKYqlEzdgBnJ+o5Fiz15zK+gAAgiUkLwdn2t5RcxMbgND6YTDvv5wvcrzB/JZA9BC71V0JrMj/46YqyYoAHNaojtDVLSORVoM+3E+rfudl0vSzrym8K91V53NT8F7KRpREn94C+0cGAX+c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728455977; c=relaxed/simple;
	bh=2C0WI9dOI0xa55HS53fJ/ajH3JKM6N1WB9VIImPfKIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dZ9VsxbAVlsEpIUsOyejID6xnVTnU95vzOJRk1SpAzK65Q+QhfKe285q050OSbznIg8QEFJgifuRP5041Q2IMqXqktKCWVJBYFkRxd/Sa8YdnmFIVzYU2O/TiMmo5pLhz/nwBbAwoVdPmdoC5sbOFBYjxPCjNQj+YVy20Pql8c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ia28nrey; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso4760940a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 23:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728455976; x=1729060776; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEHWg2NUfrC5myskQ2P1TzlN1mLHcnkoynuCkkPVEVY=;
        b=ia28nreyTmoXvAtVREYI1+l1to+1NTpGzkt0XAFCUZFE5MooThBYBjVo1OLswvaZw2
         F5grdTQYL1X+5Tbw9fdefALHO7xIUpdjaeh04DvCts/F2uehoP0PCxMeRTULP3UmRaAO
         mcRLcKrnZaYFo99EqDl+3VRviy3S9VflL/AWxb6Y1OMvBajyet8Ze7nHN8oaPLin3AN/
         8/00s9XaxtxlCHyYUlNpo8RVH98a2J1KLLZmr4HhqkONH+m2uHcq4+vmtTQTKZ/na1qt
         3Kcla9ayqL3gxc2VUOze3L7aniXWkVLnSMmWB/X/mmOY7XpAcig/hQaqpxTkU/oyy3Ba
         L9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728455976; x=1729060776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEHWg2NUfrC5myskQ2P1TzlN1mLHcnkoynuCkkPVEVY=;
        b=XPEYT8fnW5kZK3MYNci2tMguBAmohyxgcgc/yRXeXHdxPgs+Rz53sAsUDZGsDERTKS
         W+sh04U4T6q+LxDguQGRsCXbMdPrbGu2uYlIxaALW5uUGQEcDS4mL4gudiueFKP1VCOd
         aFPwi5jz/uatjqE7VUBh43BfV7R0Se+0ea2FqulZH7MA6vc/kMJ80TyoP0+aXXvWdXp7
         vc7+Vu03mOM+RPiQoyxp+RN0YM3+2SYjkjyhUzc6YB6tv3mZ7jCgjEAu8zgR9Hu5idyB
         yHO2jD9vDWu1nnjOb+IsrzZbsnCapn2FIr7ioJRwEwvzN2La67pShdHR7Etmn2OgQDAU
         gBXA==
X-Forwarded-Encrypted: i=1; AJvYcCUxYuaPlsmpt7cTHwwmqnNLLy4vv9R7qE0a6Z9FkOH+T3ID1eFZJ0JYzUc+jvc6MH9zmdYZYNsHD+ve/Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6P8oV82rquOhzyrNtUHKmhVlnKyA2hsM0wTlCuhw/feLJ/bMi
	9L22pz9zIbfZ4HrYh2KnHoLhIw5ySge22LVKNw9kWI7+D/JzerPhuFFg3Ml1Jbo=
X-Google-Smtp-Source: AGHT+IEt2QNCddQYWVKfB6+oA4wi1uwU6EE4Epbp02LT9vvWkL/dw9e49n8cYO5z2fCivqAKNp9p3w==
X-Received: by 2002:a05:6a21:4006:b0:1d6:e635:5c5e with SMTP id adf61e73a8af0-1d8a3be3800mr2761351637.9.1728455975717;
        Tue, 08 Oct 2024 23:39:35 -0700 (PDT)
Received: from [127.0.1.1] ([112.65.12.217])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7d209sm7077396b3a.208.2024.10.08.23.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 23:39:35 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 09 Oct 2024 14:38:43 +0800
Subject: [PATCH 2/2] drm/msm/dpu: configure DSC per number in use
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-20-v1-2-139511076a9f@linaro.org>
References: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-20-v1-0-139511076a9f@linaro.org>
In-Reply-To: <20241009-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-20-v1-0-139511076a9f@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728455958; l=2326;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=2C0WI9dOI0xa55HS53fJ/ajH3JKM6N1WB9VIImPfKIE=;
 b=HP+c/P4RyRLtj5qmtNP5ZJC9hnjQGAIDviKyYH9UDoC7jibslP/JuWcqa/HanjQtWNGuZ1SQu
 cRL+hjUOnJVCOllDwonK4ucg3fw6355uee/7408cTrqeln2DjhnbP0Y
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Only 2 DSC engines are allowed, or no DSC is involved currently.
We need 4 DSC in quad-pipe topology in future. So let's only configure
DSC engines in use, instread of maximum number of DSC engines.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 39700b13e92f3..e8400b494687c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1871,10 +1871,13 @@ static void dpu_encoder_dsc_pipe_cfg(struct dpu_hw_ctl *ctl,
 		ctl->ops.update_pending_flush_dsc(ctl, hw_dsc->idx);
 }
 
-static void dpu_encoder_prep_dsc(struct dpu_encoder_virt *dpu_enc,
-				 struct drm_dsc_config *dsc)
+static void dpu_encoder_prep_dsc(struct drm_encoder *drm_enc)
 {
 	/* coding only for 2LM, 2enc, 1 dsc config */
+	struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
+	struct dpu_crtc_state *cstate = to_dpu_crtc_state(drm_enc->crtc->state);
+	struct drm_dsc_config *dsc = dpu_enc->dsc;
+	int num_dsc = cstate->num_dscs;
 	struct dpu_encoder_phys *enc_master = dpu_enc->cur_master;
 	struct dpu_hw_ctl *ctl = enc_master->hw_ctl;
 	struct dpu_hw_dsc *hw_dsc[MAX_CHANNELS_PER_ENC];
@@ -1886,7 +1889,7 @@ static void dpu_encoder_prep_dsc(struct dpu_encoder_virt *dpu_enc,
 	u32 initial_lines;
 	int i;
 
-	for (i = 0; i < MAX_CHANNELS_PER_ENC; i++) {
+	for (i = 0; i < num_dsc; i++) {
 		hw_pp[i] = dpu_enc->hw_pp[i];
 		hw_dsc[i] = dpu_enc->hw_dsc[i];
 
@@ -1915,7 +1918,7 @@ static void dpu_encoder_prep_dsc(struct dpu_encoder_virt *dpu_enc,
 	enc_ip_w = intf_ip_w / 2;
 	initial_lines = dpu_encoder_dsc_initial_line_calc(dsc, enc_ip_w);
 
-	for (i = 0; i < MAX_CHANNELS_PER_ENC; i++)
+	for (i = 0; i < num_dsc; i++)
 		dpu_encoder_dsc_pipe_cfg(ctl, hw_dsc[i], hw_pp[i],
 					 dsc, dsc_common_mode, initial_lines);
 }
@@ -1953,7 +1956,7 @@ void dpu_encoder_prepare_for_kickoff(struct drm_encoder *drm_enc)
 	}
 
 	if (dpu_enc->dsc)
-		dpu_encoder_prep_dsc(dpu_enc, dpu_enc->dsc);
+		dpu_encoder_prep_dsc(drm_enc);
 }
 
 bool dpu_encoder_is_valid_for_commit(struct drm_encoder *drm_enc)

-- 
2.34.1


