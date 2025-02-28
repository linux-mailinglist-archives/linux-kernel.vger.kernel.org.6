Return-Path: <linux-kernel+bounces-537750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6FEA49029
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2661892C65
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0FE1B4F0C;
	Fri, 28 Feb 2025 04:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JPO7JSdl"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3903F1AA1DC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716059; cv=none; b=p8y1KRQrU8hkqGe/t8j4bWMyk35oSnx6WMoRLIY8Bwm0LKt/uEEjI4IiJvvSavwKryKh1hTMaRljIa4bVtq3KFgsFbFfscJXWsbrGQK7AT9GFtKcE/pmvf3P7EdyFkzsi5PO/wph0jr39tj2UghJuL7ts0dAw6LQj/3gVQZNwLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716059; c=relaxed/simple;
	bh=AoDhO2t+dIdRoZkxxXCA28rPq8VTkQxMjsmlolETDOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PcD36gyGkymoe7ULa9Y89jsXMee75JTz8pgLhmz673/DGS+bN27zR6ZvwhN3P74weSX+glV69eNxTdKLpWO1Ye/R9W6mCF3XZZyJNRvK9Vuw8IW5swlzVPAUu7qv6CWafj/SJL7sS9/o2oiOcaEti9c6FyW+ToSFOOFu9WtiXyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JPO7JSdl; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30a28bf1baaso16424981fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740716055; x=1741320855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=229LaQQs3AtVYpVY7CYXwuqYuFTusa/OnRSCiJVHHMQ=;
        b=JPO7JSdlglpxMeiGfDKfk+kHDTYiQ6sTFYELLEe625gQqXEEGaWVcCfUG8GbPM7805
         SnxiP38GEQeUHIsnR1bRu3KBC4NEWyVagFixxDsVJohczSu0lYA385ZHNbmz6T78g4m5
         prhR00uLd7B/n1E1pMENNdDyp+JzGCH5uoer45fI5l3wIOCLXd8VQezQ3lx3lnFIzgy/
         zTN1epPmlsQEL7xJ09MRRxii9aY4Hyv9LuD8z6xPXmbHmdN4cLF9AFcSUStx/VBkWxHK
         86NPkxSH45lVvTpWjTsAOlvSRu2+p1sB7ezSefF6FvSb/vwaZcXe226yFw7g3/4btNw7
         IOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740716055; x=1741320855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=229LaQQs3AtVYpVY7CYXwuqYuFTusa/OnRSCiJVHHMQ=;
        b=mMPzAnbXmUQx9JBefvIAtGphhZ35PFv9B9lQrZDVAa/20mXJqGmngyAZUoJlLnJlQ7
         8XwyVSzanNBj5IXVkohqWhNHZCGJdySYoDyN2X66qQBBKdcJgyc6iseVWM+lfOOpbqSE
         rzWBPqN3hb6mMst/UopQaaIVl/MdCyVRSURBxfGX43GRmP98yFBM690dWW5APP3CrjQ1
         B6kBv0Ifmpy48J+bZ9zIlT6Cd9UypqfvBeVhddUs7g1v8hxo7k87GS838TrulxYJXAvC
         42SMrq4sXu9NXCBnzWh6LZIPfn/56iAY7w/Mi03sMqjSBahpMAZ02+14eVXc62nPKq9c
         /Yqw==
X-Forwarded-Encrypted: i=1; AJvYcCXw+nLrVz2tpW87qjnEEnfJepndrq7Lr4h9aXC2iRqHXv02kT+pZ0m3iTN3l8f3fSjKU1jBBcGBEtAeiUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+Yt7ZuPxlmCmmBWdesngTTzDF4ZDIhC7JcVhIrIfn1bpO82z
	UEAHGvtveNwBco+bKL4JWfjzX8ktPOo1ctI1dxjPB558YFacAkm/m2PRSVGvsnY=
X-Gm-Gg: ASbGncvt5jXXZBExWZp5NhriNOWIoYwwCHHzLtzs1517xxZOzAToiFkmywEuT+NB5q0
	NVEdVQ3B+vWxrEQmn603fvuegAlwACGs2Jr/vC1mLHYXqG0mq34huOTDP5XBKTzHAXR+ZjW2v0y
	cxIoftKF00BqBhzkMrDEPDBniQ8cX1BLTmhvpKPa0i6jhgyIEP6bQG8/K6KMTn0qNRIhu7LnPzn
	ptlZwXNxEcIYLqNIUE4c9MjtV81IxO4SvWHANFK2mHxDTA2eZ+Lh7rL/dDeSI/kHgTp+k1G8zqB
	odV0AMcwy/WrMD+ZAFKcqXowykIvygPIyA==
X-Google-Smtp-Source: AGHT+IESa8qolAMTFNqWbMDxjYResyR5kPLAkWzhjfwsqrBTG4hn9eOwmrwmXsP01jgv8LizRkO9Kw==
X-Received: by 2002:a05:6512:3ca8:b0:545:1dea:7b2f with SMTP id 2adb3069b0e04-5494c38bd76mr634215e87.45.1740716055177;
        Thu, 27 Feb 2025 20:14:15 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549441262b9sm361101e87.0.2025.02.27.20.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:14:13 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 28 Feb 2025 06:14:06 +0200
Subject: [PATCH v2 2/8] drm/msm/dpu: program master INTF value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-dpu-active-ctl-v2-2-9a9df2ee5193@linaro.org>
References: <20250228-dpu-active-ctl-v2-0-9a9df2ee5193@linaro.org>
In-Reply-To: <20250228-dpu-active-ctl-v2-0-9a9df2ee5193@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2935;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=AoDhO2t+dIdRoZkxxXCA28rPq8VTkQxMjsmlolETDOo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnwTgOI2a12c5nnpkFzuRBe/F8av9QAf5AGQdLt
 PAmBneIexiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ8E4DgAKCRCLPIo+Aiko
 1c/NB/4ld7gG0gXOmNt1fY0qrRWkykgxbJC059ytvMKjIFROSR3D9yGOy2W6VW5i3SVUU4RWYD5
 4HDjTvWuaP9iBjO/AqntSMDzuAS3xupXntxShitM4JcZDrRSXk2Gdy8C1B3TYfnArBSQOJOTyA7
 R3krlOq4v3n9me4V0BBsdQMbYzpTZIm11r6T2diA9NLtyXPoTPL3K8qj704t2d3ngq6hXjV7+et
 c6g/uznC+99Z8AbvtxmJ8ZciTFk5CaZofU4sqSOvoMUH5jVzkFiVesvv2oA4lT5zfv9L8uNxRca
 I1ELPXN4oFJVMUE30IPHTEP9+NYsOocTtEOF5QBMAOJKmTUa
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

If several interfaces are being handled through a single CTL, a main
('master') INTF needs to be programmed into a separate register. Write
corresponding value into that register.

Co-developed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 12 ++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 32ab33b314fc44e12ccb935c1695d2eea5c7d9b2..ffff60c4206c6f2833293fdcc56b653f7d3124a5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -583,6 +583,9 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
 	DPU_REG_WRITE(c, CTL_DSC_ACTIVE, dsc_active);
 	DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE, merge_3d_active);
 
+	if (cfg->intf_master)
+		DPU_REG_WRITE(c, CTL_INTF_MASTER, BIT(cfg->intf_master - INTF_0));
+
 	if (cfg->cdm)
 		DPU_REG_WRITE(c, CTL_CDM_ACTIVE, cfg->cdm);
 }
@@ -625,6 +628,7 @@ static void dpu_hw_ctl_reset_intf_cfg_v1(struct dpu_hw_ctl *ctx,
 {
 	struct dpu_hw_blk_reg_map *c = &ctx->hw;
 	u32 intf_active = 0;
+	u32 intf_master = 0;
 	u32 wb_active = 0;
 	u32 merge3d_active = 0;
 	u32 dsc_active;
@@ -651,6 +655,14 @@ static void dpu_hw_ctl_reset_intf_cfg_v1(struct dpu_hw_ctl *ctx,
 		intf_active = DPU_REG_READ(c, CTL_INTF_ACTIVE);
 		intf_active &= ~BIT(cfg->intf - INTF_0);
 		DPU_REG_WRITE(c, CTL_INTF_ACTIVE, intf_active);
+
+		intf_master = DPU_REG_READ(c, CTL_INTF_MASTER);
+
+		/* Unset this intf as master, if it is the current master */
+		if (intf_master == BIT(cfg->intf - INTF_0)) {
+			DPU_DEBUG_DRIVER("Unsetting INTF_%d master\n", cfg->intf - INTF_0);
+			DPU_REG_WRITE(c, CTL_INTF_MASTER, 0);
+		}
 	}
 
 	if (cfg->wb) {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
index 85c6c835cc8780e6cb66f3a262d9897c91962935..e95989a2fdda6344d0cb9d3036e6ed22a0458675 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
@@ -36,6 +36,7 @@ struct dpu_hw_stage_cfg {
 /**
  * struct dpu_hw_intf_cfg :Describes how the DPU writes data to output interface
  * @intf :                 Interface id
+ * @intf_master:           Master interface id in the dual pipe topology
  * @mode_3d:               3d mux configuration
  * @merge_3d:              3d merge block used
  * @intf_mode_sel:         Interface mode, cmd / vid
@@ -45,6 +46,7 @@ struct dpu_hw_stage_cfg {
  */
 struct dpu_hw_intf_cfg {
 	enum dpu_intf intf;
+	enum dpu_intf intf_master;
 	enum dpu_wb wb;
 	enum dpu_3d_blend_mode mode_3d;
 	enum dpu_merge_3d merge_3d;

-- 
2.39.5


