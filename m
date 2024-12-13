Return-Path: <linux-kernel+bounces-445631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAC59F18BA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9CF188C9EA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F7B1F2C40;
	Fri, 13 Dec 2024 22:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i0CeG6FV"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2BF1F2395
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 22:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128110; cv=none; b=BfpMeYki5MmGkHHreTrEyAUYOOweo7MMbb97dmf6SF7L/4a7mwr2r4XE1al5/8mLKGP3JuRnjArqSeHIB36EEaOUQty5KRKMTBm3helwk5vrrOaeIR04fHZMLYz0A2GMChEFrdAXD2YDKuYXjHZZDjKI2LzjY0dT9fP++4sVTrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128110; c=relaxed/simple;
	bh=pQCOp1S6V/JRH6JOV3082YMk98ZUP3XYs5wxxF1uZAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nK2E8EFt1fFUAkNNfsCmDkU9LUU/XAH0zGgo1jUuCETXMY1vAAs3nr+3dMdwSBKTHQtHKQLB78ETvOqX12HWwc+IktJPpSubyrXcn4Un/SpnfoaTpkxTalt7+gyErL1gvbpdWCCQJLm1vOHgUegWFpcPFFUX3ciMKvEnNy9HYsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i0CeG6FV; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30033e07ef3so23889701fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734128106; x=1734732906; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72LEVu4zv5GnCl7a/DOzppLgP9PEkC9JVzSKxkGRJcM=;
        b=i0CeG6FVp03CdilHe0yHBB/XEXnpXZ3svf/piql/ilIL11nAjGxVvQU8HKBHLYlqAB
         zSx7h1Y5Wv/6mtFYTXq4Cp0xUI20Id6M2i4L+8qpfYxEuUyHrnn+TVwEt0VH8GAyvRe8
         p/8ldTm7Rcuwx25EAmBQHW89iKb67pbVcuZrsIRFhskQuEe2LZWjB/GNt/IZW1M6YiMy
         Ho4aqo3dPDD9uoZEUQVoTQDbhDhrK1RyqwftpxgV2JAiD8QlmLHdr9zKyI6/rPv08jqa
         f8+o+f62WLqdQeAx5KWvBbTX1HSXxvg9H8PBN+niQDBjKbOyoMVmWtjrPDV6Kg1sbdge
         9w7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128106; x=1734732906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72LEVu4zv5GnCl7a/DOzppLgP9PEkC9JVzSKxkGRJcM=;
        b=OV54FAVO/OHSTojFmKREIVLIn7msZuzKq6fEZhQoMT1s9+fytmVWOh19ZsBDl+aKR4
         jfnBUIy/S9cVlmxpLmJqRnbRuOsaOcvqPP1a/9ggwSwQtwR7i2L4laM0bnhamJhQ2YbZ
         3sljTB/I0EZBT9GcAPjct82Ai6O3LY+8UBbwM44qJQKQgeXkkv+XHa3DgoCKqcD7GsA/
         nBq3IEgRugTeRc1QyaIM3FE5vnfgO20Mjoiz1fiNtSGrKgEwwzZeKfKiXi5y6y12dtTn
         cIT7g7Wj2vTMCciFwj8BL9zIelOveP25mq77hycCBvQ1F1HnhstfodnIo0zFMfqa+e1z
         i90g==
X-Forwarded-Encrypted: i=1; AJvYcCUU98PDlI6Y95i15+V3m8JORESs0kpMLkvcS9FrcWi8A4ifXDDNexVN33cQFU7eD18cqBo+srOmk4qRl5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz405EMkE8PGScKCqWlulFDDFKt6UmMq4i9osQdgxiu5I6geKUz
	04bgsNyAjEJ7p8shL6oLDMV2vBFYxDFyAZ7+zNeH7SqU6rNWGrHd9LTTMdhv9PzzPkhShuZS+27
	SMs7RRQ==
X-Gm-Gg: ASbGnctYo9EhCbA83/cRjyj41hTsydp0bfsYbnxfCpkjyKxVat37mMwluUg+NU7oasQ
	5PuLMtGnNliZPZyC7gvsu3o48ggruqmjBcbmm4mLYq4YpltrHBhC+4f758VEqFwMwRVbrNjZQ2d
	00WJnaN8nWVJwuO3G1YHe4URIT/jlZcg4WbXyN10vhNHJD8NzNhotbnbxaCKmfbQieoWbuFjNoI
	V4UfgvHxyFn8qMHAybkOa12AbNJVdG+018ABytPnMrH4AuN2fK7ZZvQNrkhGc1A
X-Google-Smtp-Source: AGHT+IFnTWBphArn+3nEEQZAb7l6bmtWQ8xRj98QypbmoOZGU0ruXSDAvaWrK58SXtuDlMbXHNeRCw==
X-Received: by 2002:a2e:8095:0:b0:2ff:5d45:883d with SMTP id 38308e7fff4ca-302a4d2182bmr10620311fa.13.1734128106486;
        Fri, 13 Dec 2024 14:15:06 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441e0f43sm413451fa.125.2024.12.13.14.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:15:05 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 14 Dec 2024 00:14:29 +0200
Subject: [PATCH 13/35] drm/msm/dpu: get rid of DPU_CTL_DSPP_SUB_BLOCK_FLUSH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241214-dpu-drop-features-v1-13-988f0662cb7e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2599;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=pQCOp1S6V/JRH6JOV3082YMk98ZUP3XYs5wxxF1uZAw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnXLHFa7D/ZOU6IWO40FuM1ZI07Ay9Uc/VNqqwo
 oX+EXBeavqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1yxxQAKCRCLPIo+Aiko
 1QFAB/4vfqU0CQkPt3pS20P8KsDEBmonJiPX1mt3JX0VCdEdcJrcC1udYFMOdgcnMq03qC+YfQI
 3Sr6VpcdPUX4MiqjZVctNlVdNzE5dEZ36InR79hGK4yey7xZ9D5QAWKDe18h5Vi7Uw614vgi5Oc
 ndUA26f9HBfBW9+O01C73SjpM4746nj8kLYvcV3zBuMJv84ymli6thWH5qzUYP6nZHQJkve6dos
 5h9RsGGSzHUVD3kIdQApOO38PUOj+akVpikaL1ltqzeWQQt2EN1dFA9Ko3ZVyzeE2ln5m7QLbu/
 66O8zNnAj1XJn+OTSidkY0+KixCF5/Q//ZPfD8q6BcGR16XQ
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Continue migration to the MDSS-revision based checks and replace
DPU_CTL_DSPP_SUB_BLOCK_FLUSH feature bit with the core_major_ver >= 7
check.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 3 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 2 --
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c     | 2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 4b44e4d8d13631b6b1a8824b12cd8d5bd4ae7e3f..188d73b56190c2719a012889d6b7993f38a28906 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -111,8 +111,7 @@
 	(BIT(DPU_PINGPONG_DITHER) | BIT(DPU_PINGPONG_DSC))
 
 #define CTL_SC7280_MASK \
-	(BIT(DPU_CTL_VM_CFG) | \
-	 BIT(DPU_CTL_DSPP_SUB_BLOCK_FLUSH))
+	(BIT(DPU_CTL_VM_CFG))
 
 #define INTF_SC7180_MASK \
 	(BIT(DPU_INTF_INPUT_CTRL) | \
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index 1acc1a7d0a365e511d5b6d7cc236e1c28062c76e..12b0faa9e9380034c20142e6c7077192ca097985 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -135,13 +135,11 @@ enum {
  * CTL sub-blocks
  * @DPU_CTL_SPLIT_DISPLAY:	CTL supports video mode split display
  * @DPU_CTL_VM_CFG:		CTL config to support multiple VMs
- * @DPU_CTL_DSPP_BLOCK_FLUSH:	CTL config to support dspp sub-block flush
  * @DPU_CTL_MAX
  */
 enum {
 	DPU_CTL_SPLIT_DISPLAY = 0x1,
 	DPU_CTL_VM_CFG,
-	DPU_CTL_DSPP_SUB_BLOCK_FLUSH,
 	DPU_CTL_MAX
 };
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index f0dbb00737df2b4ade540eb440cb3ae0baf7c153..4427a97ad52237b4ad64d63e4e02428c76f8616e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -753,7 +753,7 @@ struct dpu_hw_ctl *dpu_hw_ctl_init(struct drm_device *dev,
 	c->ops.setup_blendstage = dpu_hw_ctl_setup_blendstage;
 	c->ops.update_pending_flush_sspp = dpu_hw_ctl_update_pending_flush_sspp;
 	c->ops.update_pending_flush_mixer = dpu_hw_ctl_update_pending_flush_mixer;
-	if (c->caps->features & BIT(DPU_CTL_DSPP_SUB_BLOCK_FLUSH))
+	if (mdss_ver->core_major_ver >= 7)
 		c->ops.update_pending_flush_dspp = dpu_hw_ctl_update_pending_flush_dspp_sub_blocks;
 	else
 		c->ops.update_pending_flush_dspp = dpu_hw_ctl_update_pending_flush_dspp;

-- 
2.39.5


