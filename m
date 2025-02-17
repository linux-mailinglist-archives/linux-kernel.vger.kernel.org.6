Return-Path: <linux-kernel+bounces-515847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EEBA369DB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAEEF3B371E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE1714A4FF;
	Sat, 15 Feb 2025 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B53DhqaJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A943B192;
	Sat, 15 Feb 2025 00:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739578543; cv=none; b=NvNs0QahodTUcAVCMmrYucoltYdA4qVXYAla1EQmHitUjFq+owpbLAGrcolDv1XvA4oS4fmF3XRu6G++gXhITD1hsLVppPBrYp9Yepa6bGQ5zMmTq1OHmrpdmb0cbQIS3zUkvEnw1LAOXgEIjfVsxa1vsnELeWgFIy35TWVQoSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739578543; c=relaxed/simple;
	bh=EHhiT+0dWBVudJepaAMBdhiYZEq4yAFmUsUSqMmZ9kM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Sk8K2RtJKRLtfJUzrb2ZOh0NG54/x+sH2McnKPTEJhSxbj3gCS5KGEPkskP3BVXpdw882tMIPMAd0W2sgydHaT+dh2CScq67BTDkf8lyVEDLeDM/uhG51EHdifDr0M/0ZGYfuzbO6OgisSeHiSQi+Nmt3SpGgPVsKZ+PG/pb9ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B53DhqaJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51F00SII023270;
	Sat, 15 Feb 2025 00:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UBSXBxADo0RU8LD+9yNUygZ3xMbNnqDsIOHDixCNL1k=; b=B53DhqaJT6lGoG1J
	TmQXUBdZdg0oQDCE4qKS9rmBtveDP5TmbxaWR/eiq4kfALxxeJs1zOIoQP24RS/A
	8fkkGKhaYPiDImXMgmyJxN6L7Rti7DfSCQTud30DSnOB7je0O64OmdZy2cr7RNw4
	zxBXaakqhH55o2/ADXfliZjN3g5RP8sdSbBL6pf/1WTBsCo5CyLP2Z28g1rN4sbz
	S+3fSVt86dxP26Hnsh6dbphdLxMGKJcIE8DXuwSiWEn2BzeDfLMYPTx6J+Ig6VlM
	NCWyRrRY/0t5JQ2h7aJgCPksdHB6MRr459RmckeeJp+magFzDqMQ6bn3Dr7nEpvn
	8ylPXA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44sc5udj75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Feb 2025 00:15:28 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51F0FRT4028161
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Feb 2025 00:15:27 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 14 Feb 2025 16:15:26 -0800
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Date: Fri, 14 Feb 2025 16:14:31 -0800
Subject: [PATCH v6 08/14] drm/msm/dpu: Configure CWB in writeback encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250214-concurrent-wb-v6-8-a44c293cf422@quicinc.com>
References: <20250214-concurrent-wb-v6-0-a44c293cf422@quicinc.com>
In-Reply-To: <20250214-concurrent-wb-v6-0-a44c293cf422@quicinc.com>
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
X-Mailer: b4 0.15-dev-f0f05
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739578524; l=7389;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=EHhiT+0dWBVudJepaAMBdhiYZEq4yAFmUsUSqMmZ9kM=;
 b=EDKcBveoTwC+X2Rl9GknSfYZyYR9Y+M6JljfHSFBlHhEBgHMW294UXekBLoEpQB+yDsPZp+nI
 73rdrMd5PgCCLMiNRayuoabvmXX5QAYtd5z7dC8H467G3XrTCkmi/v8
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3xgDBdeK0mb5TiP-aleVG5VkOPk7_pE3
X-Proofpoint-ORIG-GUID: 3xgDBdeK0mb5TiP-aleVG5VkOPk7_pE3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_10,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502150000

Cache the CWB block mask in the DPU virtual encoder and configure CWB
according to the CWB block mask within the writeback phys encoder

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 75 +++++++++++++++++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h   |  7 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |  4 +-
 3 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index b7d10855e6bf..2cd1de88448d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -24,6 +24,7 @@
 #include "dpu_hw_catalog.h"
 #include "dpu_hw_intf.h"
 #include "dpu_hw_ctl.h"
+#include "dpu_hw_cwb.h"
 #include "dpu_hw_dspp.h"
 #include "dpu_hw_dsc.h"
 #include "dpu_hw_merge3d.h"
@@ -139,6 +140,7 @@ enum dpu_enc_rc_states {
  *			num_phys_encs.
  * @hw_dsc:		Handle to the DSC blocks used for the display.
  * @dsc_mask:		Bitmask of used DSC blocks.
+ * @cwb_mask		Bitmask of used CWB muxes
  * @intfs_swapped:	Whether or not the phys_enc interfaces have been swapped
  *			for partial update right-only cases, such as pingpong
  *			split where virtual pingpong does not generate IRQs
@@ -185,6 +187,7 @@ struct dpu_encoder_virt {
 	struct dpu_hw_dsc *hw_dsc[MAX_CHANNELS_PER_ENC];
 
 	unsigned int dsc_mask;
+	unsigned int cwb_mask;
 
 	bool intfs_swapped;
 
@@ -1151,6 +1154,7 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 	int num_cwb = 0;
 	bool is_cwb_encoder;
 	unsigned int dsc_mask = 0;
+	unsigned int cwb_mask = 0;
 	int i;
 
 	if (!drm_enc) {
@@ -1191,8 +1195,12 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 						       ARRAY_SIZE(hw_pp));
 	}
 
-	for (i = 0; i < num_cwb; i++)
+	for (i = 0; i < num_cwb; i++) {
 		dpu_enc->hw_cwb[i] = to_dpu_hw_cwb(hw_cwb[i]);
+		cwb_mask |= BIT(dpu_enc->hw_cwb[i]->idx - CWB_0);
+	}
+
+	dpu_enc->cwb_mask = cwb_mask;
 
 	num_ctl = dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
 		drm_enc->crtc, DPU_HW_BLK_CTL, hw_ctl, ARRAY_SIZE(hw_ctl));
@@ -2232,6 +2240,9 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc)
 	if (phys_enc->hw_pp && phys_enc->hw_pp->ops.setup_dither)
 		phys_enc->hw_pp->ops.setup_dither(phys_enc->hw_pp, NULL);
 
+	if (dpu_enc->cwb_mask)
+		dpu_encoder_helper_phys_setup_cwb(phys_enc, false);
+
 	/* reset the merge 3D HW block */
 	if (phys_enc->hw_pp && phys_enc->hw_pp->merge_3d) {
 		phys_enc->hw_pp->merge_3d->ops.setup_3d_mode(phys_enc->hw_pp->merge_3d,
@@ -2275,6 +2286,56 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc)
 	ctl->ops.clear_pending_flush(ctl);
 }
 
+void dpu_encoder_helper_phys_setup_cwb(struct dpu_encoder_phys *phys_enc,
+				       bool enable)
+{
+	struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(phys_enc->parent);
+	struct dpu_hw_cwb *hw_cwb;
+	struct dpu_hw_cwb_setup_cfg cwb_cfg;
+
+	struct dpu_kms *dpu_kms;
+	struct dpu_global_state *global_state;
+	struct dpu_hw_blk *rt_pp_list[MAX_CHANNELS_PER_ENC];
+	int num_pp;
+
+	if (!phys_enc->hw_wb)
+		return;
+
+	dpu_kms = phys_enc->dpu_kms;
+	global_state = dpu_kms_get_existing_global_state(dpu_kms);
+	num_pp = dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
+					       phys_enc->parent->crtc,
+					       DPU_HW_BLK_PINGPONG, rt_pp_list,
+					       ARRAY_SIZE(rt_pp_list));
+
+	if (num_pp == 0 || num_pp > MAX_CHANNELS_PER_ENC) {
+		DPU_DEBUG_ENC(dpu_enc, "invalid num_pp %d\n", num_pp);
+		return;
+	}
+
+	/*
+	 * The CWB mux supports using LM or DSPP as tap points. For now,
+	 * always use LM tap point
+	 */
+	cwb_cfg.input = INPUT_MODE_LM_OUT;
+
+	for (int i = 0; i < MAX_CHANNELS_PER_ENC; i++) {
+		hw_cwb = dpu_enc->hw_cwb[i];
+		if (!hw_cwb)
+			continue;
+
+		if (enable) {
+			struct dpu_hw_pingpong *hw_pp =
+					to_dpu_hw_pingpong(rt_pp_list[i]);
+			cwb_cfg.pp_idx = hw_pp->idx;
+		} else {
+			cwb_cfg.pp_idx = PINGPONG_NONE;
+		}
+
+		hw_cwb->ops.config_cwb(hw_cwb, &cwb_cfg);
+	}
+}
+
 /**
  * dpu_encoder_helper_phys_setup_cdm - setup chroma down sampling block
  * @phys_enc: Pointer to physical encoder
@@ -2735,6 +2796,18 @@ enum dpu_intf_mode dpu_encoder_get_intf_mode(struct drm_encoder *encoder)
 	return INTF_MODE_NONE;
 }
 
+/**
+ * dpu_encoder_helper_get_cwb_mask - get CWB blocks mask for the DPU encoder
+ * @phys_enc: Pointer to physical encoder structure
+ */
+unsigned int dpu_encoder_helper_get_cwb_mask(struct dpu_encoder_phys *phys_enc)
+{
+	struct drm_encoder *encoder = phys_enc->parent;
+	struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(encoder);
+
+	return dpu_enc->cwb_mask;
+}
+
 /**
  * dpu_encoder_helper_get_dsc - get DSC blocks mask for the DPU encoder
  *   This helper function is used by physical encoder to get DSC blocks mask
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
index 63f09857025c..61b22d949454 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) 2015-2018 The Linux Foundation. All rights reserved.
  */
 
@@ -309,6 +309,8 @@ static inline enum dpu_3d_blend_mode dpu_encoder_helper_get_3d_blend_mode(
 	return BLEND_3D_NONE;
 }
 
+unsigned int dpu_encoder_helper_get_cwb_mask(struct dpu_encoder_phys *phys_enc);
+
 unsigned int dpu_encoder_helper_get_dsc(struct dpu_encoder_phys *phys_enc);
 
 struct drm_dsc_config *dpu_encoder_get_dsc_config(struct drm_encoder *drm_enc);
@@ -331,6 +333,9 @@ int dpu_encoder_helper_wait_for_irq(struct dpu_encoder_phys *phys_enc,
 
 void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc);
 
+void dpu_encoder_helper_phys_setup_cwb(struct dpu_encoder_phys *phys_enc,
+				       bool enable);
+
 void dpu_encoder_helper_phys_setup_cdm(struct dpu_encoder_phys *phys_enc,
 				       const struct msm_format *dpu_fmt,
 				       u32 output_type);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
index 4c006ec74575..f2cbc9335e54 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #define pr_fmt(fmt)	"[drm:%s:%d] " fmt, __func__, __LINE__
@@ -340,6 +340,8 @@ static void dpu_encoder_phys_wb_setup(
 
 	dpu_encoder_helper_phys_setup_cdm(phys_enc, format, CDM_CDWN_OUTPUT_WB);
 
+	dpu_encoder_helper_phys_setup_cwb(phys_enc, true);
+
 	dpu_encoder_phys_wb_setup_ctl(phys_enc);
 }
 

-- 
2.48.1


