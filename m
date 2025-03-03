Return-Path: <linux-kernel+bounces-542018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B04C1A4C4B5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3943188F069
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CB021B9E7;
	Mon,  3 Mar 2025 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="en+mhdq1"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D2C21858D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014949; cv=none; b=cL2l9/w2lcxv7QKGQuGM5/Nv7i2sRvCFqpL10FHZ93F6NISp541rP1lA4IvZUf5l1AncU+BXOZ44X1kdw9sb9N7bevABEK8W/WQjfxGIQ7AjlAqxbkUXofaxm3z2s+eKxCl0yHGlfhmYW0o2pRp5RJFqTlGkrBwBO0TR4mhWel8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014949; c=relaxed/simple;
	bh=abNbpRlXHuZ7m2O+VGB/4vwIlVmkocNUGdti7LPWNjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WQzlUO1CulcAONs+3pwfC1zZdwtuwKznZjAFJJxKhD9UtxJ6pni6fDLhvVH/gJFUdMtVfYDgnSUPwOnfCNaVU7485otyAHFwfMPe/V+Boo7WTZShGKPLUwL9D3w95yvQAu9s9oPviG5IInX5M/rp5JXej2R/l2Dzc5wzngBwKyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=en+mhdq1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223378e2b0dso65533605ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741014944; x=1741619744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CnxZo728cU6Bds36JLYqHT6x28HxQHbVwrzkHphwtQ=;
        b=en+mhdq1jdR92GNl4ZAWXwv39ju4wR7nSWv/KUvbVdsVaizFj4YYgNOg6yzEcbXpBX
         T4HAOOXNaboM1SQMdc0DJlF7zlcA0gTdG3X3Smes+M0MlWXWNXC/bMVJ/s+yG6yJB8X/
         wc9k4680wfjZW8r+LeD1mqHH3hiccY6ULym8kEG0qQ0+9d3JnXvd083iyykYsErXzLBD
         EzfSV8DzUclkWu4oeimhseGrNmgohuW9uuN/cZ8rEjLaVV4Iln6Zp8xGlOgddsdHH/66
         DWlgXN8C40Fldq2Wgvx6R+jg1I+spF2Di4KyhoteHQazVuMw/eaGbnDRwxp/6Pnf08So
         OBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741014944; x=1741619744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CnxZo728cU6Bds36JLYqHT6x28HxQHbVwrzkHphwtQ=;
        b=ujpSRXuRuCf0nqoenrgQHV3oJV2TXt+yGxmGg6CmfW6r+/5+lpUSgrngAXjK/7S3Q2
         n9laxO+236hStxBd/nfIcELjcBpbaEm/jjjjdUm4Z1rBBOlZ1/NzKaxoU1UfplmYjSx/
         yXwDeBf20ad8BF8yzcldp0Cmwf6xuaQKBGlGkA3F299vtHw+swiP1seCRQpYLdyLjIIw
         h9u++M+YPEcTG4jlZYBzKtKJh0bOMoBpu1n7tHYC59d2leufQ0RFMDPZko2x9i7CpqQ3
         oNVM/FiDwFUkRF4ybf3pEOpn9m6gGGogg5iCBJ5EI8l07lTf0y0bq3YjjJ6fMDhKETjs
         x+CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUHrQ9e0AGql7UzPBMqtycNSsY9mT6TkGVz8nWl9hwm5ZBRHOWW476bcszgTRPIulGVtYFy8cQzBOVjmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk5YhS9JbGmlTh4X4/hD+oUOD1DVDf3Ke/59ivhxSkajaFdr4r
	D3sRP8lvwxB/VKuroYJTnzjwA0LBrD57QEcfzmDAC9ZLhbP+wBls6DgL/yDRJzxHntZeFkXUZZo
	Qoa4U7Q==
X-Gm-Gg: ASbGnctMyHLUAtskZ3S3E6aghffs/xBSq7nNoNqcOIC1L+fTvMdr6givMoj2M+/hO3e
	Ww6F3Xaau4bJeVdkNBYddy2jsUPd//CJ5vanfE66GEhJRmdQzznzH6s2moWGZuqTvW8zqVvvcBS
	qag7jye2JPSayxrbEVIpZfuCFiDXW33SHjAZcbDPyLvZYuXMzqWud6I8RJDdV5JK0CEAol3SHUt
	/1KwXG8rpB3pJ3KAEUhC1a0qkMivZFrX0eLkl8Z7vM8tTEgo8XTGofOxYLF5Fy+gMy7XOUqYdf0
	b2FTLbsIlLnscO1E/MAJVBu/L7/1ufAxqIKhD5SflQ==
X-Google-Smtp-Source: AGHT+IEg2m/fKRl8NuF/bQLQAXhw1TZ3bcnJihpWao2bd3w+quxqO/hplTobUUaPhbEXNNJOs4bH+g==
X-Received: by 2002:a05:6a00:2346:b0:736:5486:7820 with SMTP id d2e1a72fcca58-73654867d3dmr5458326b3a.13.1741014944577;
        Mon, 03 Mar 2025 07:15:44 -0800 (PST)
Received: from [127.0.1.1] ([112.64.60.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736584b3cffsm1851984b3a.4.2025.03.03.07.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:15:44 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 03 Mar 2025 23:14:37 +0800
Subject: [PATCH v8 08/15] drm/msm/dpu: bind correct pingpong for quad pipe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v8-8-eb5df105c807@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741014878; l=1833;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=abNbpRlXHuZ7m2O+VGB/4vwIlVmkocNUGdti7LPWNjc=;
 b=jmcI05kD0Lk55iTgw8b3SeomPl6ldCeoX+Rk6l2P1K3v+BKRthZHHQ2JcIv06DE/dVpNXjvLF
 OVaG1qKQ/OwC09PlvpYg7YF4oR0vFjOaDInuHZJPj9sRa+Uu280nXTY
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

There are 2 interfaces and 4 pingpong in quad pipe. Map the 2nd
interface to 3rd PP instead of the 2nd PP.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 018a1a49ca7d152fddcce7ffa1a0a5d54eb615af..c89a5da0fa8321e9082d5aee304fa16402bb4ad9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1220,7 +1220,7 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 	struct dpu_hw_blk *hw_pp[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_blk *hw_ctl[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_blk *hw_dsc[MAX_CHANNELS_PER_ENC];
-	int num_ctl, num_pp, num_dsc;
+	int num_ctl, num_pp, num_dsc, num_pp_per_intf;
 	unsigned int dsc_mask = 0;
 	int i;
 
@@ -1275,11 +1275,17 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 		dpu_enc->cur_master->hw_cdm = hw_cdm ? to_dpu_hw_cdm(hw_cdm) : NULL;
 	}
 
+	/*
+	 * There may be 4 PP and 2 INTF for quad pipe case, so INTF is not
+	 * mapped to PP 1:1. Let's calculate the stride with pipe/INTF
+	 */
+	num_pp_per_intf = num_pp / dpu_enc->num_phys_encs;
+
 	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
 		struct dpu_encoder_phys *phys = dpu_enc->phys_encs[i];
 		struct dpu_hw_ctl *ctl0 = to_dpu_hw_ctl(hw_ctl[0]);
 
-		phys->hw_pp = dpu_enc->hw_pp[i];
+		phys->hw_pp = dpu_enc->hw_pp[num_pp_per_intf * i];
 		if (!phys->hw_pp) {
 			DPU_ERROR_ENC(dpu_enc,
 				"no pp block assigned at idx: %d\n", i);

-- 
2.34.1


