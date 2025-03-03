Return-Path: <linux-kernel+bounces-542011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82216A4C49F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C997173C20
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349E32147F4;
	Mon,  3 Mar 2025 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w4z0SNNf"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B6D1DA61B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014905; cv=none; b=uWNA9q8P6BcY9AOts/O08cc9AFde26ju6StzYQd99A8XgOYHCiYo1r3/HHUK0baeUxxWy6xSXGPtpBZXtQjGNBmLExpsUmctrpit8hnh4Fgh16tEkggCXf80pXBB+/MW36FG+dBoTPzjs+S9w5qgt7JhDlkAtgdcbP7qkytNqg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014905; c=relaxed/simple;
	bh=WBM/p7IonF+GUTkphvNqY034IFJPvXxbXKnpEjol144=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XGm1/CzpL3rGsmDyDnnwbg6/AU1apjnRiGcSgCto43Gtzt6Ct0aL9dFHuZBQZNA92BbvBPd8hVkUM5OTjCO9ASpPRSmzHs7LZGLGWAjunRgP1FQCHpTXLgN8XZclYEph7DGWYU93CyIT1v2seIX9uleYGG4H1hxw3r2ZUanE+fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w4z0SNNf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22328dca22fso68739485ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741014903; x=1741619703; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rajdpuATf4cHrwTeJ8T+ZsyTPgo2DiGPUjAIn6iu1Wg=;
        b=w4z0SNNfm07Xta0oZmdh5DPfzvfGIqIYFIwNbv5gYv1SxCOt2H72eBpG8B5ZH8H3y4
         nN4whT9cuAESXSiibmVf3mnufu1gH+aNs5hep2UeKcLldwgcyzXSKJXscirMQEzHvN7R
         K6S58fWLGBNV6uvKVH39DdoUwjkzvQNsNHvgP0B6ZyqTJvQ7DdZUjTz6qEGRHfM3PlGE
         tOoyOYJOLfmf+iEuxsVp7th1cRbvVy3rpxrvoQ1TTHUESbXojrLx/cPTAc0Ryl9JJYAo
         CCPwmgTvIof4aZw6a/qaALP09AMOMTPtJnVSEXVgamhD4+ipsQvEtEMReIqm+iTivrO1
         lyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741014903; x=1741619703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rajdpuATf4cHrwTeJ8T+ZsyTPgo2DiGPUjAIn6iu1Wg=;
        b=VTxv60C5Ydem+G2IWu7ZgKaFvTPLnoc2Btc6eyhtjxodL+zJK/vaLP12yt8/DYbq1t
         DCNCBQ8mV7VPZUOoqmSsg2c/YSqxklgSfA/Pkv9OgVAaqt+eOpM44XughG9nODAVu7vj
         ea5TAK41PGV1K8wvlzVD/tAp6q4HLDxjqJ0d6ewmMczevGuqVIBwCsWTUeroK2hDWzqs
         IN3C8+CbQlGHZFc+cYEKSVBcAri3NOYGQiY30ItdGWCBydPc1n08cryiCGckRf4Xmmmz
         BoxVpjnWm4HJ3DNEQ08niFBGu4EqYFLFM6wUuSayOz27fCX1UOaBEBElfGX5RPWntQXW
         1F3w==
X-Forwarded-Encrypted: i=1; AJvYcCXkpVdE+jKGAE7uyzXK3nfJCQO3bmGeEeukQ0/0+kp5WRy71x7Ui57271GhMz5hoEsGiaJCZ3nVVLHXKgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1QzcfsIpE/f1nJHD0G1S9qNJRlOVx0/vWz1LrQVun1rk+l/SK
	T3ForCABibuWFIrcONejyslH25txIhjhL+XnYLi6oYInMJNDt+xIuLPHFJx5dmqZgpX8eacKm+H
	cRz3F8g==
X-Gm-Gg: ASbGncsJSVDwZM8DwUn5dA9GTHbOKTpl4qLbVldHNs5XC2e9fSgwQ0QO01A5sHhBKgh
	Dw+OHrql1YjVhCw/3dE+zKz3jGXcocq1YHHerXV3n79XX0ryPvlzrh1WevQJURS4Cb7bb1ot+3w
	vFgCC3ThRA5Bx0+08zR+/rRDeAaNDFMPCo9YpJ3C8QTK1YrnA8nZbebxOl574HCf2Se+dzmH5Cr
	aBaCl9UFrLh736xW2rWfR1Hv94YvwqL8OUf0QxnvjLuKF7kx/mE8p0VrofylUMkum0thSZCeoxq
	6JDjvrpiFgupT7p+uDJ33tul3emO+g5INQuAXVGEIg==
X-Google-Smtp-Source: AGHT+IFfKobZR/YNthU8FSN4d6D3QQs8d0hcDUIFWNCkJQnXRThDPSI3iD8UnplSa5AFqtM/nye7ow==
X-Received: by 2002:a05:6a00:244d:b0:736:5b46:489b with SMTP id d2e1a72fcca58-7365b46531emr4180973b3a.1.1741014902949;
        Mon, 03 Mar 2025 07:15:02 -0800 (PST)
Received: from [127.0.1.1] ([112.64.60.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736584b3cffsm1851984b3a.4.2025.03.03.07.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:15:02 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 03 Mar 2025 23:14:31 +0800
Subject: [PATCH v8 02/15] drm/msm/dpu: Do not fix number of DSC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v8-2-eb5df105c807@linaro.org>
References: <20250303-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v8-0-eb5df105c807@linaro.org>
In-Reply-To: <20250303-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v8-0-eb5df105c807@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741014878; l=1985;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=WBM/p7IonF+GUTkphvNqY034IFJPvXxbXKnpEjol144=;
 b=Eo4AVl6PNa4Zuh1hIo1r0Z2SysdoISXYk+vp0YJpZ7OGVtradN62MDjOdok4y1ut0fVsHeHrf
 MoiLB40oGZeBnFVeoDof6wy9ApzZxL92NfBW9r0UNStUJzs1O5ddDmZ
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Currently, if DSC is enabled, only 2 DSC engines are supported so far.
More usage cases will be added, such as 4 DSC in 4:4:2 topology. So
get the real number of DSCs to decide whether DSC merging is needed.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index eaac172141ede7bb4002ce1d0268b2f436fffc6c..c734d2c5790d2a8f5f20c4b5aa1e316062d9b34d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -164,6 +164,7 @@ enum dpu_enc_rc_states {
  *				clks and resources after IDLE_TIMEOUT time.
  * @topology:                   topology of the display
  * @idle_timeout:		idle timeout duration in milliseconds
+ * @num_dscs:			Number of DSCs in use
  * @wide_bus_en:		wide bus is enabled on this interface
  * @dsc:			drm_dsc_config pointer, for DSC-enabled encoders
  */
@@ -204,6 +205,7 @@ struct dpu_encoder_virt {
 	struct msm_display_topology topology;
 
 	u32 idle_timeout;
+	u32 num_dscs;
 
 	bool wide_bus_en;
 
@@ -622,9 +624,8 @@ bool dpu_encoder_use_dsc_merge(struct drm_encoder *drm_enc)
 		if (dpu_enc->phys_encs[i])
 			intf_count++;
 
-	/* See dpu_encoder_get_topology, we only support 2:2:1 topology */
 	if (dpu_enc->dsc)
-		num_dsc = 2;
+		num_dsc = dpu_enc->num_dscs;
 
 	return (num_dsc > 0) && (num_dsc > intf_count);
 }
@@ -1261,6 +1262,7 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 		dsc_mask |= BIT(dpu_enc->hw_dsc[i]->idx - DSC_0);
 	}
 
+	dpu_enc->num_dscs = num_dsc;
 	dpu_enc->dsc_mask = dsc_mask;
 
 	if ((dpu_enc->disp_info.intf_type == INTF_WB && conn_state->writeback_job) ||

-- 
2.34.1


