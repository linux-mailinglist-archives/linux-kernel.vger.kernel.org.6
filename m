Return-Path: <linux-kernel+bounces-369010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 114109A17D9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F065B22A3C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2247017BB13;
	Thu, 17 Oct 2024 01:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bc9WGqF3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AE81BF37;
	Thu, 17 Oct 2024 01:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729128099; cv=none; b=Ter5b/Y4bKmCcao/rVa8QLJETCCDF3gZUg7//6+RfF6OfFXK3Txn8oGFgpbKAm1ogMQnEWUTNH9UXj+EcWBqzE23xILpRmwg29uuVYLqqFga+iCOLsBjRgywEuGIfXJNaqDsbz7zG1IHtOThsBOy3ZokbI/R0fdKA4e7yJRu4LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729128099; c=relaxed/simple;
	bh=MoU58M8T7rcx/IBlMaHdTEckSl87Udq9kFncTSWMw2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=U9xS06SXD/+6p31f9gkM3hLKVcgbxLatDo5MgwuH5F0JCDT2SX/JqGazx8UlCF0S/Wj7LJqVRuS4bmQyPPRxPISe21B1uCSf/1AqyiIA7FiHxvxT9Eu9nZak+Ry6XBkzlbtC7dk7kXKfDdDuyxYxoG65RN9ZmU3ZediA/rwtURw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Bc9WGqF3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GGQhVm007437;
	Thu, 17 Oct 2024 01:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PA83bsh5krzeagUpu6CFMIhKJkcYoIcWs2JsMr/7ooo=; b=Bc9WGqF3EOM8qxfh
	FZHlUAa9v+UVrGXcVm0aDhGgXAPrhaByErk8Kg9UKzevlOttDKWx3VK4vPi/6D7/
	GBVbnqd81DGZqq8DZ3DlALX0kTM9ur7NQP1K7naPhWWVfMS97pAP/FUM3KILZ7hR
	e2A0Ko9pOwSSXPlN+phbBIJtoekNgUwZORemcvZ0A/yK8UTzG41ZrID99lLUxiS3
	VuKsF/oZsYXx0o7xsGYqifRkogAitPP7GPeJqFoXKi8Q9iALRalhhTSf8QVKjCYE
	armQbQ2vvwYD3V/ERDID2l0pBrC67z/zckhNKW5FdiaZOHUe2VY6etdOzCmvXYKn
	PjBHFg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429mjy6fy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 01:21:20 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49H1LIIV006369
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 01:21:19 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 16 Oct 2024 18:21:18 -0700
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Date: Wed, 16 Oct 2024 18:21:16 -0700
Subject: [PATCH v3 10/23] drm/msm/dpu: Add dpu_hw_cwb abstraction for CWB
 block
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241016-concurrent-wb-v3-10-a33cf9b93835@quicinc.com>
References: <20241016-concurrent-wb-v3-0-a33cf9b93835@quicinc.com>
In-Reply-To: <20241016-concurrent-wb-v3-0-a33cf9b93835@quicinc.com>
To: Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        <quic_abhinavk@quicinc.com>, Sean Paul
	<sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        "David
 Airlie" <airlied@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Simona Vetter <simona@ffwll.ch>,
        Simona Vetter <simona.vetter@ffwll.ch>
CC: <quic_ebharadw@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, Rob Clark <robdclark@chromium.org>,
        =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
        "Jessica
 Zhang" <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729128075; l=6259;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=MoU58M8T7rcx/IBlMaHdTEckSl87Udq9kFncTSWMw2Y=;
 b=6odH4UTMWwhrNHC6FIKIOooQNAbtW8VFFQ2rKMCwkMSK23h1TNBj6weMijuL3WBgoWFoxZXGB
 8LTcyqV21/lAtdBbQ9jowN8Yht7wiZ+vzpE442AA+rmMiT+LRHwFbTq
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qn05j4N9Hxavl0Bv8NUC0TYvfDmJ5DMo
X-Proofpoint-ORIG-GUID: Qn05j4N9Hxavl0Bv8NUC0TYvfDmJ5DMo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170008

The CWB mux has its own registers and set of operations. Add dpu_hw_cwb
abstraction to allow driver to configure the CWB mux.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/Makefile                |  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cwb.c  | 73 +++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cwb.h  | 70 +++++++++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  5 +-
 4 files changed, 148 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index de7cf60d206241ac03d7e744e048cbfd845f6cc9..26bacd93a148288849d5076c73ef4f294ff2c188 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -78,6 +78,7 @@ msm-display-$(CONFIG_DRM_MSM_DPU) += \
 	disp/dpu1/dpu_hw_catalog.o \
 	disp/dpu1/dpu_hw_cdm.o \
 	disp/dpu1/dpu_hw_ctl.o \
+	disp/dpu1/dpu_hw_cwb.o \
 	disp/dpu1/dpu_hw_dsc.o \
 	disp/dpu1/dpu_hw_dsc_1_2.o \
 	disp/dpu1/dpu_hw_interrupts.o \
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cwb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cwb.c
new file mode 100644
index 0000000000000000000000000000000000000000..5fbf52906ea94847a8eb3fcaa372e582dce2357c
--- /dev/null
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cwb.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved
+ */
+
+#include <drm/drm_managed.h>
+#include "dpu_hw_cwb.h"
+
+#define CWB_MUX              0x000
+#define CWB_MODE             0x004
+
+/* CWB mux block bit definitions */
+#define CWB_MUX_MASK         GENMASK(3, 0)
+#define CWB_MODE_MASK        GENMASK(2, 0)
+
+static void dpu_hw_cwb_config(struct dpu_hw_cwb *ctx,
+			      struct dpu_hw_cwb_setup_cfg *cwb_cfg)
+{
+	struct dpu_hw_blk_reg_map *c = &ctx->hw;
+	int cwb_mux_cfg = 0xF;
+	enum dpu_pingpong pp;
+	enum cwb_mode_input input;
+
+	if (!cwb_cfg)
+		return;
+
+	input = cwb_cfg->input;
+	pp = cwb_cfg->pp_idx;
+
+	if (input >= INPUT_MODE_MAX)
+		return;
+
+	/*
+	 * The CWB_MUX register takes the pingpong index for the real-time
+	 * display
+	 */
+	if ((pp != PINGPONG_NONE) && (pp < PINGPONG_MAX))
+		cwb_mux_cfg = FIELD_PREP(CWB_MUX_MASK, pp - PINGPONG_0);
+
+	input = FIELD_PREP(CWB_MODE_MASK, input);
+
+	DPU_REG_WRITE(c, CWB_MUX, cwb_mux_cfg);
+	DPU_REG_WRITE(c, CWB_MODE, input);
+}
+
+/**
+ * dpu_hw_cwb_init() - Initializes the writeback hw driver object with cwb.
+ * @dev:  Corresponding device for devres management
+ * @cfg:  wb_path catalog entry for which driver object is required
+ * @addr: mapped register io address of MDP
+ * Return: Error code or allocated dpu_hw_wb context
+ */
+struct dpu_hw_cwb *dpu_hw_cwb_init(struct drm_device *dev,
+				   const struct dpu_cwb_cfg *cfg,
+				   void __iomem *addr)
+{
+	struct dpu_hw_cwb *c;
+
+	if (!addr)
+		return ERR_PTR(-EINVAL);
+
+	c = drmm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
+	if (!c)
+		return ERR_PTR(-ENOMEM);
+
+	c->hw.blk_addr = addr + cfg->base;
+	c->hw.log_mask = DPU_DBG_MASK_CWB;
+
+	c->idx = cfg->id;
+	c->ops.config_cwb = dpu_hw_cwb_config;
+
+	return c;
+}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cwb.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cwb.h
new file mode 100644
index 0000000000000000000000000000000000000000..96b6edf6b2bbf7d270ac08f76af06fcd3c431527
--- /dev/null
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cwb.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved
+ */
+
+#ifndef _DPU_HW_CWB_H
+#define _DPU_HW_CWB_H
+
+#include "dpu_hw_util.h"
+
+struct dpu_hw_cwb;
+
+enum cwb_mode_input {
+	INPUT_MODE_LM_OUT,
+	INPUT_MODE_DSPP_OUT,
+	INPUT_MODE_MAX
+};
+
+/**
+ * struct dpu_hw_cwb_setup_cfg : Describes configuration for CWB mux
+ * @pp_idx:        Index of the real-time pinpong that the CWB mux will
+ *                 feed the CWB mux
+ * @input:         Input tap point
+ */
+struct dpu_hw_cwb_setup_cfg {
+	enum dpu_pingpong pp_idx;
+	enum cwb_mode_input input;
+};
+
+/**
+ *
+ * struct dpu_hw_cwb_ops : Interface to the cwb hw driver functions
+ * @config_cwb: configure CWB mux
+ */
+struct dpu_hw_cwb_ops {
+	void (*config_cwb)(struct dpu_hw_cwb *ctx,
+			   struct dpu_hw_cwb_setup_cfg *cwb_cfg);
+};
+
+/**
+ * struct dpu_hw_cwb : CWB mux driver object
+ * @base: Hardware block base structure
+ * @hw: Block hardware details
+ * @idx: CWB index
+ * @ops: handle to operations possible for this CWB
+ */
+struct dpu_hw_cwb {
+	struct dpu_hw_blk base;
+	struct dpu_hw_blk_reg_map hw;
+
+	enum dpu_cwb idx;
+
+	struct dpu_hw_cwb_ops ops;
+};
+
+/**
+ * dpu_hw_cwb - convert base object dpu_hw_base to container
+ * @hw: Pointer to base hardware block
+ * return: Pointer to hardware block container
+ */
+static inline struct dpu_hw_cwb *to_dpu_hw_cwb(struct dpu_hw_blk *hw)
+{
+	return container_of(hw, struct dpu_hw_cwb, base);
+}
+
+struct dpu_hw_cwb *dpu_hw_cwb_init(struct drm_device *dev,
+				   const struct dpu_cwb_cfg *cfg,
+				   void __iomem *addr);
+
+#endif /*_DPU_HW_CWB_H */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index c17d2d356f7a01d5ae63d3ebe4838bd55f60e4eb..c43cb55fe1d22123abc49b68d91689c637921527 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
  */
 
 #ifndef _DPU_HW_MDSS_H
@@ -352,6 +354,7 @@ struct dpu_mdss_color {
 #define DPU_DBG_MASK_DSPP     (1 << 10)
 #define DPU_DBG_MASK_DSC      (1 << 11)
 #define DPU_DBG_MASK_CDM      (1 << 12)
+#define DPU_DBG_MASK_CWB      (1 << 13)
 
 /**
  * struct dpu_hw_tear_check - Struct contains parameters to configure

-- 
2.34.1


