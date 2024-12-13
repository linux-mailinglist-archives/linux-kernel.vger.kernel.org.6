Return-Path: <linux-kernel+bounces-445630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF5B9F18B8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E62067A084C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7673F1F2C4B;
	Fri, 13 Dec 2024 22:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iWttlYmw"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7251F1319
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 22:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128107; cv=none; b=m0V2DV3JVgvYrH2B48apotgrj7ww8mSCe3t0TQIYuZt6pU6D2iJDvQ9qo+wuV9b0sCxTRnxXokEC61udGlPruW7iGUK9A0G76xcgW0jKNnpTdP0Bk0RsukN7wCsjvN/UT83ha8G41EQr20eF9rXtCIgXhJMHc2BGOjVsR2S9Pns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128107; c=relaxed/simple;
	bh=MZhjCNwgWizVywyMX/aJ+JSvvPCWwwXZCcDJjCNcyas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jl3A0BSxxgWomY0n/QrfaxpHeAyu2XTicIuwtp6N1XeNJPJb6kVSJ3GoBd/diLvFu/KtPYyIjMiF7mdWJU4KoqCCZBIbKkYUgg3sdAB6gt2w6LOqkPeGvHQaErEvszD6eeypbynPNXWyt06jZo3K0biG+Uzq7HHSTdCfoKSegvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iWttlYmw; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30039432861so23564911fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734128104; x=1734732904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMDHENqu7kX5P1n4SJgKmKj9EqxeCNLadyOWWcHQ94Y=;
        b=iWttlYmwlCVYi+ndbfp3oij1P/pjKKp34A+gVe9x9SJcRWrd71jAw+6A8z3DZ/90Ax
         bg9yfC/o3gqnp73kRfsk1e+LkpjFIfo9jOvRRZJqQQVh2Npz0C7d+VxZd4XeemQR4tcq
         uN74B88yPQYO9Zzd1JZmENkNHQk4J8yJhY9MRnXKLWS4DH27Lha4SGyFHzBFRTe816KC
         eQT4AfPUyFpp7QzCH/zv1yhhfcKG4MBnwTi7ZGd0R3fnaL8tUNnszly0x6T0gRiVZFt2
         pNXkBv8W+JAkwV3mjvzBDDR8guewbEfspbxDrHoipKCtHT1tdc1uJM2u1rOczJotyYEf
         BUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128104; x=1734732904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMDHENqu7kX5P1n4SJgKmKj9EqxeCNLadyOWWcHQ94Y=;
        b=JW0EVFWGSKHxz5G0R3/2IxSS17PJAtlzqMoo6udoG3UODu/++uFART+5nAcQwszvlI
         zLPt+pC14MIyuTDsF9SAaMb7FovRC3OdvADoQ+1hbR01A6+pvnSXNR2AvzLCLocsRq0x
         gUgWfuKoew2ScJ6e9Ut2y9W+GQF47JFZezbq4CEXVhFaREoniMjA1UbY0udB4UVa1cDa
         zV8ClgEdAzLN0wNpvPoOSRFTltREsls8whE/uT7TMp8h5Pz5zz+H7Ft07sbzJQpGVp1A
         oTskPy/5b/ADwAInNy7Rf55kS3OYxztWvEcbIbh5RT5oSHS6U0sTZFJt+0QBGcypjQ6Y
         Duiw==
X-Forwarded-Encrypted: i=1; AJvYcCWVa4jOEZCUf/su6crX8WvpGZE+PuRaBKEd93MrVBAxqbK+QtWcJpCqcdn2T6CK3s4vEvW9PQI2rFGysEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGymSFVBWbwvwhUQgexfQ1TYs+b8d+HqoEDDvnckcbzeh+T03Z
	47XtyX/dcd0PSRXwNgEsJuLbpRaWnD4FsPgIeu4qx0b3oWXbzh7QALb/66+9Nqg=
X-Gm-Gg: ASbGncsEqV0n0Gwb9nlrbN+s7gArzMTQshW+nRS1ssg5TWutVmGzQr55U298tSyLhWj
	ssK3oxP6JCsQ6GtSgWsEPggBCH80bLWO4AuTQepY1ofC9Ba9opZNvYnJBhrPGXGUAm6m1+qmmvS
	Xg6bJMdHilJvEBEhbXB3EcwoElQDWYbPqh1Jc6Vqtv+lb9EeAEnZi3V/3iR1vmt290WsNB5Dzrr
	C35/MdiwD87VH8JzZoFJLUP5G9vYawAy9mC0MPRDWH4TUeOA6xIJia6k5I5l/77
X-Google-Smtp-Source: AGHT+IEl8R1cmj28OPLFqtiDWg2fB94ckYMMQdIX4ec28uNnZF6M5HtHbm5Uz48+fA+MPXvUSkLa8w==
X-Received: by 2002:a2e:9dce:0:b0:302:4115:d56 with SMTP id 38308e7fff4ca-30254492809mr12696231fa.13.1734128104098;
        Fri, 13 Dec 2024 14:15:04 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441e0f43sm413451fa.125.2024.12.13.14.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:15:02 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 14 Dec 2024 00:14:28 +0200
Subject: [PATCH 12/35] drm/msm/dpu: get rid of DPU_CTL_FETCH_ACTIVE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241214-dpu-drop-features-v1-12-988f0662cb7e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2460;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=MZhjCNwgWizVywyMX/aJ+JSvvPCWwwXZCcDJjCNcyas=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnXLHFk7XNLSsikl3gO+dbol3RCYCaIpN3fyqbB
 n+0ouH2DuSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1yxxQAKCRCLPIo+Aiko
 1fu1B/0e1SGh9FmaT21JoImSgvZZFpx5HOY0KOYre847raa5UJHvL9CM44S7t7gZTh3AAdB4YS8
 vqNz7sgaBDuaOmt6nzTTP/BikF7X3LByvHuI0EiDxjgORmYsYQ9ViM1zzvAAfZZ77WjyAVMrutL
 UzAxz1/lPlvNurYDSIvXXssjZVz2rGAuw3C16x9GJztdRaqLT3MQ9xxpuSh2DRp9AtRBVblGOIF
 3rdG0f/gN5OVIacz8O27JiLfk6ZsgwEs5S0IeBtZMwmQvj1qSyuHNduxFbEgdaqw5FhWhWAg/xI
 df08TCmAM9P+xySxSA31KURqIV2+edcOUKyZLPk7N4mq2yL6
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Continue migration to the MDSS-revision based checks and replace
DPU_CTL_FETCH_ACTIVE feature bit with the core_major_ver >= 7 check.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 3 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 2 --
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c     | 2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 0b6b4313f8acd76e8ae1a0849127466491e8f108..4b44e4d8d13631b6b1a8824b12cd8d5bd4ae7e3f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -111,8 +111,7 @@
 	(BIT(DPU_PINGPONG_DITHER) | BIT(DPU_PINGPONG_DSC))
 
 #define CTL_SC7280_MASK \
-	(BIT(DPU_CTL_FETCH_ACTIVE) | \
-	 BIT(DPU_CTL_VM_CFG) | \
+	(BIT(DPU_CTL_VM_CFG) | \
 	 BIT(DPU_CTL_DSPP_SUB_BLOCK_FLUSH))
 
 #define INTF_SC7180_MASK \
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index 83e0a0905d7ee59a2be0478865bc515c3c7e193f..1acc1a7d0a365e511d5b6d7cc236e1c28062c76e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -134,14 +134,12 @@ enum {
 /**
  * CTL sub-blocks
  * @DPU_CTL_SPLIT_DISPLAY:	CTL supports video mode split display
- * @DPU_CTL_FETCH_ACTIVE:	Active CTL for fetch HW (SSPPs)
  * @DPU_CTL_VM_CFG:		CTL config to support multiple VMs
  * @DPU_CTL_DSPP_BLOCK_FLUSH:	CTL config to support dspp sub-block flush
  * @DPU_CTL_MAX
  */
 enum {
 	DPU_CTL_SPLIT_DISPLAY = 0x1,
-	DPU_CTL_FETCH_ACTIVE,
 	DPU_CTL_VM_CFG,
 	DPU_CTL_DSPP_SUB_BLOCK_FLUSH,
 	DPU_CTL_MAX
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 59d25916d2d412113768d71a76a6aed4c879299a..f0dbb00737df2b4ade540eb440cb3ae0baf7c153 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -758,7 +758,7 @@ struct dpu_hw_ctl *dpu_hw_ctl_init(struct drm_device *dev,
 	else
 		c->ops.update_pending_flush_dspp = dpu_hw_ctl_update_pending_flush_dspp;
 
-	if (c->caps->features & BIT(DPU_CTL_FETCH_ACTIVE))
+	if (mdss_ver->core_major_ver >= 7)
 		c->ops.set_active_pipes = dpu_hw_ctl_set_fetch_pipe_active;
 
 	c->idx = cfg->id;

-- 
2.39.5


