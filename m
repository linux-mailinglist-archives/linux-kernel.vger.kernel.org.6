Return-Path: <linux-kernel+bounces-517805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A3AA385FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665FA176175
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CC7221D87;
	Mon, 17 Feb 2025 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FW1G4Z7k"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E6221D587
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801819; cv=none; b=ZNjlxigNNg7a9EiTsnRaTVANaln26PNoEOy5xSxX7/nachqTyoNh7NYEEyQ1cyfxolKQJ8n+BaAKJmZbzBHKjHVK6aH5Mes94W2fgi10WRu9hIj0T/WAGW7uqi97PRDr0ZdpzwMx20QAtV3f7a4M2nrj2bDBCV+ptPrI4QIIeTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801819; c=relaxed/simple;
	bh=OxydkO597ugBLy/eoQLhIhZIi3C8VBz20HvkW34FMds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PLuPWDGbTwvqv81201mGL5+Bwq3YsszHpP21XMA9KuTrCVHM3prVF3ZOhK2aPCl+hDMoniPKy2P18aD4vRIrNpfhSZ6oKUm4qmHPmSoiNdbktcO2Gw+Wb1l6KXibO6bNUMyyQPZ7BTkCoF+hB78fz/v577wQzdutUErFuC29WaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FW1G4Z7k; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-221057b6ac4so30363845ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739801816; x=1740406616; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ieoJPWE+tVOeqiIoh5GOinrnACdNHE09O5GdzPDKAj8=;
        b=FW1G4Z7kk6FQsr89Sxj0uA03GaSfETFRdMUtDLGXH2UMyY1vPVS+iJaGK0kRdbNPJ7
         qxxtAZ8z7yXv2vNfrH2Ia1TmspFJK3rEcPY0MuRvO5ukXP/GDLw0+vHHVnxaIiHB+seh
         ImrHA/N1ybX8tHpYjNyIfkf3TKeLI3ZrD1q10ZCWIgsS5yNdZ3znbqtkTSfFTKeXLv6U
         A4JSVqTyK7G5pl8obMw3YhYKCY8cYYOm8GYs7RNl03rQfSszmhsrNwPy9Fna//LWUFUF
         KI9a0FHH73zg76iCg8qqW9/M5BXNeTTppcAFz/8wBEV+24kBfUzjXkLDFn4MUfxTqa73
         07Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801816; x=1740406616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieoJPWE+tVOeqiIoh5GOinrnACdNHE09O5GdzPDKAj8=;
        b=qDldWm5Xk2y8d+N4NsOGnT5W8fBFL73lB9lYQLTy+Pzoe+gRubVPOQl/aii2figF0k
         hcbzK9HUqrbqhnied8ybkuQhZ1EoaFpwLRpB+wqPniCocVXwv15Kma98NUIw/5od0SRT
         rHdFBdjHyZgMWsQxWZFwO1GBgLAuaGuqjouP0TctnvjUHIpDJ9qWBxH8qN3Fe4oMNdUh
         aDWenLgXSVEaR0l3B+hQGfCXPqHCfdjE3oo5zQRCi6vmPTCjPzKcARuQhR4FZx/OP0ZQ
         Ddps2BMdaY+D9HALmaHhwQ0XYmlTKlXppH8LGA9XMLlSoCi0N09rV1SGZTtH4QZmkT8V
         0WCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3Y3mpqpdiaweZORpfP+xQMAKe5QKJJ9xvabQ5DOcCkI58zG2wX/6aQyYzE5RPjYZ4Bs4I9vWZP2J4aVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0GlT9GDBlsvWxa0tlw1xGLdLBIMN5vaXOZqad8myHDjso6lm6
	D7UML9vKmQZ9zTditnJB4eYa1CbrASzwjBfScn0OP1wF2WwsVohzalITYK3WfwalLVHFLc3jbT4
	Bfd+nzg==
X-Gm-Gg: ASbGncto346BSOEKi71ET0xcCKFZT1pqe/IIuhpqTLMlaX2YSRdsKeJJGXpi8SQ14G0
	QI/xhJuoGqvteN9NjpEIotk0jXaujb3SoNe1QWA8W7wZlxUzFOtq/MqNohbcyLKc2CphZn3AzM+
	A3WQF2+g05MTOZcBXaL+XjKCmnm8bjxwqKXHk6rU7j2EuOXMWYBtrr75WEo+Yax2DS4CapuVU8c
	+k6zsLHg9Cd79nYmbptmPnkbnYnm755W8+fD+FyPOJMhhh47rsqMrIRZGLHyowAPdpndp/amCVz
	MzhNwwZ9edLc
X-Google-Smtp-Source: AGHT+IEzS4KfqXP8Xt5GHMhRafBYz+RgwbGhXZbMd3m4c1JZ4WuTSy64hH8ktZu0531hH/zPEWjhCA==
X-Received: by 2002:a17:902:f802:b0:221:1c2:2012 with SMTP id d9443c01a7336-221040d8543mr122081405ad.49.1739801816584;
        Mon, 17 Feb 2025 06:16:56 -0800 (PST)
Received: from [127.0.1.1] ([112.65.12.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5366984sm71900845ad.60.2025.02.17.06.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:16:56 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 17 Feb 2025 22:15:52 +0800
Subject: [PATCH v6 03/15] drm/msm/dpu: configure DSC per number in use
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-3-c11402574367@linaro.org>
References: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-0-c11402574367@linaro.org>
In-Reply-To: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-0-c11402574367@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739801787; l=2046;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=OxydkO597ugBLy/eoQLhIhZIi3C8VBz20HvkW34FMds=;
 b=lhqZ5hF5B/LxqlpWvqkkYt16wWBab7XyL2JKhANDd8P3fXIeDeCBYNDuOWhE5D35Gixz8qzDh
 NTv0ao21qDWBwzxlK6RGvis1Oqq9uwC7CB3quezik71QV5Xd72QHSdn
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Currently if DSC support is requested, the driver only supports using
2 DSC blocks. We need 4 DSC in quad-pipe topology in future. So Only
configure DSC engines in use, instead of the maximum number of DSC
engines.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index c734d2c5790d2a8f5f20c4b5aa1e316062d9b34d..5b98ae96bf5d46872a7af801d4157820d72af01f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2027,11 +2027,11 @@ static void dpu_encoder_dsc_pipe_cfg(struct dpu_hw_ctl *ctl,
 static void dpu_encoder_prep_dsc(struct dpu_encoder_virt *dpu_enc,
 				 struct drm_dsc_config *dsc)
 {
-	/* coding only for 2LM, 2enc, 1 dsc config */
 	struct dpu_encoder_phys *enc_master = dpu_enc->cur_master;
 	struct dpu_hw_ctl *ctl = enc_master->hw_ctl;
 	struct dpu_hw_dsc *hw_dsc[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_pingpong *hw_pp[MAX_CHANNELS_PER_ENC];
+	int num_dsc = dpu_enc->num_dscs;
 	int this_frame_slices;
 	int intf_ip_w, enc_ip_w;
 	int dsc_common_mode;
@@ -2039,7 +2039,7 @@ static void dpu_encoder_prep_dsc(struct dpu_encoder_virt *dpu_enc,
 	u32 initial_lines;
 	int i;
 
-	for (i = 0; i < MAX_CHANNELS_PER_ENC; i++) {
+	for (i = 0; i < num_dsc; i++) {
 		hw_pp[i] = dpu_enc->hw_pp[i];
 		hw_dsc[i] = dpu_enc->hw_dsc[i];
 
@@ -2068,7 +2068,7 @@ static void dpu_encoder_prep_dsc(struct dpu_encoder_virt *dpu_enc,
 	enc_ip_w = intf_ip_w / 2;
 	initial_lines = dpu_encoder_dsc_initial_line_calc(dsc, enc_ip_w);
 
-	for (i = 0; i < MAX_CHANNELS_PER_ENC; i++)
+	for (i = 0; i < num_dsc; i++)
 		dpu_encoder_dsc_pipe_cfg(ctl, hw_dsc[i], hw_pp[i],
 					 dsc, dsc_common_mode, initial_lines);
 }

-- 
2.34.1


