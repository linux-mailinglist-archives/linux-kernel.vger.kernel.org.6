Return-Path: <linux-kernel+bounces-517804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD7AA38611
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828603B08E3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CF622068E;
	Mon, 17 Feb 2025 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Onux4puq"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4221121D58D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801812; cv=none; b=MBgQ2lbC768KTbdGYLX2dav+XCvOAdqElSLmCAfUliOu77UWjhS8Hj0O3iFZdxA+eZ3E5S+bkmnzntT9l1oAiX6L3uecQg9RukD3ui6Vmwj6+irYjlxR1Ixb+fYSf+f6bWchL+GxhpIu6ZnZSzOTNuG0Awx+sIZkBjkOfS32MBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801812; c=relaxed/simple;
	bh=WBM/p7IonF+GUTkphvNqY034IFJPvXxbXKnpEjol144=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f4emlts3BxzV0CufwoMSMXXdh+4rDnMCj9QvZR9ICQk18f9OU68Ag19+gxfIn/+fTTkNTC0fB1KQPt4vfGcIi/ncwmfJBf3xcxEY3BegqmqR+TRATTAfzokbqHNIkjZgXnqHoSkW9nrzjZfTzUSIE6lWQdDfZMo3yGu23/FTm6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Onux4puq; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fbfe16cc39so8262967a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739801810; x=1740406610; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rajdpuATf4cHrwTeJ8T+ZsyTPgo2DiGPUjAIn6iu1Wg=;
        b=Onux4puqw8f/4y3SkXQXq2EFJKWEKQRhEqXAJdrd6xiawgoMZqqVkv7cLqXskup/JF
         U/tqgVTMWaWtFHDQ5WJ/+RllT7D6FKlNiXyeWsIbLsRk+RgoKRg+vneOzwOe9zLK2Uog
         /egq5iAW5qYr5svaixPGpvzZniBS6/MTKqeWTZgB75rdQEXW+HdgGvQTZEegUXAIMHxi
         bfjgRGxpvrWm1v6V7G52eJoEv4W0t24FDq6V35TXVvptYXqnZTmfBJC1F6FicL1nHFqH
         RfanSmeaairDPlkcC8VlcocY2I8v+teJb7uTm5paGa1lO4Fa+GICbjYf7FL4bIvXiJOy
         Ri7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801810; x=1740406610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rajdpuATf4cHrwTeJ8T+ZsyTPgo2DiGPUjAIn6iu1Wg=;
        b=KkgFdUnlXuI9iCCEKxB6jfPR0JGpv5m68Z7ZCRxYfN0tqDSSj2sIm8E8aI/wN/q84J
         XivAcPBd0/feVKFGyynCuh8aeiF6pzTS/OY1JkyEEWAVbs/tFxR98zltfOGL7729U4cY
         5SVaPhyn1JmfOc3fElkaF+hABm0dFlr7GYbg03s6IghN+XwCW5EqYGS7aYZL3pIslks5
         lqYzjWnk2UQ16K27uwJu/VibEkybvjx1tbtb2A1kOByvjRyGOgeetG8xF8LxSdCwkaT8
         q7bnOeSqkViT6ygR9wA/bQJKUScJS/saqFmPjX5coExMuVK+XUeUOLcMYp/6YcdkH9pe
         ZweA==
X-Forwarded-Encrypted: i=1; AJvYcCVE14/laOar68KqcqYcQYuUmIqWqI0p6z7d0cOpzhOHoOlB3gygQwefC5XntZVQho220AAx8fzjfObWpPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3aK/AAV/TrUOuVP1puMonlYsnhGBPYYmYGohP5WBERlmYhm+l
	NGlP75j9KO8//2Q3CUR9IGcE3GjjT6CCMcysrQAA++K6JbObS+drC56F3EKmUkt5ThBqdRnhj3y
	YGjueSQ==
X-Gm-Gg: ASbGncsfVf/UPHzJ198YOqimgCVdNqzQsLGkDrOtso76+obG0Wbz+3HbihKD3EMbFhT
	W/tjWmuxoRgePUK+A1dcdfDSgrtbklL7dRKEebnXzYZ+ZQgXtyufHA6ufAjZ20r6xFpfTXStW4e
	acKRmH3L3ejxDeKjNBvRTULp/gD8PpA5mE/FWJCgzgXoC3SM8ZdKTYeMbAzH/zBBPKHhyNbnQNc
	FgKrqFzeZYrU5M/anHkVh0FvHUEuvFEwBiTiA73iWYVvdepyTy/LrXObjjjGmXyh0s5l6pYzmNn
	3JJ2Cbh8ycUi
X-Google-Smtp-Source: AGHT+IGU0FyPjwmxRoPaGDsf+N+koULFGoADf0/rSjEWbWDRJqGiRCi3XPxpi3patdoZmzDMZvgdqw==
X-Received: by 2002:a17:90b:380f:b0:2fa:ba3:5451 with SMTP id 98e67ed59e1d1-2fc4115089fmr14918129a91.35.1739801810264;
        Mon, 17 Feb 2025 06:16:50 -0800 (PST)
Received: from [127.0.1.1] ([112.65.12.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5366984sm71900845ad.60.2025.02.17.06.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:16:49 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 17 Feb 2025 22:15:51 +0800
Subject: [PATCH v6 02/15] drm/msm/dpu: Do not fix number of DSC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v6-2-c11402574367@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739801787; l=1985;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=WBM/p7IonF+GUTkphvNqY034IFJPvXxbXKnpEjol144=;
 b=mcXuCakUN4KMWaFmxuYcUpbFO6rXbt/WIvqiY/25a8klCfKl7bIvE0DvHvDTCKwU+id3pVIq6
 kD9VT2lfBCkDMeibmtyY2fQ1YAGkFlOEZhqnwXA6HzuKx21ogcHiIyF
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


