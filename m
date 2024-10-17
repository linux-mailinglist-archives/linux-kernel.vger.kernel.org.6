Return-Path: <linux-kernel+bounces-369018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE8B9A17E1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE661F22E63
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A481319923D;
	Thu, 17 Oct 2024 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aJvGdZcF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A986F06D;
	Thu, 17 Oct 2024 01:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729128102; cv=none; b=AxE3kFASMHk1n9RjjmLVK7HoTL8RzPSuQUztcUz8elLMrYoAkpaB3uGfhU3XW4akCV1ksdFiaeKAfcGmWEUzM5d2cvflOHM8DHeyA1WbAkMyCpXIHBKRW2mvtUjYgg85hlANzWgqF5zeU9HuUIfFLPPTf8NDkytu7g9k2XFGwnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729128102; c=relaxed/simple;
	bh=mjd1ZJN3pAxmViJZWNn8jh6IZXhJEheZjIsftdsTfHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=anFgiq6KZiJkm7uoV5qpi/jM7546VNQDMzNhxz6exiVQBupWB+Hn7C2/LLxzmHI2fSIDA4GghwM+XCXuQ/P9VGIdf9+vIRIgFi94fjaqE1Vbiq5tCB3ngJlFnxeXhJjHH+NnM3BUuM7BFooVScGTHwZB+udIq+P2yH1NLkBQgG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aJvGdZcF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H0NBh1010242;
	Thu, 17 Oct 2024 01:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XGzmkao55eu98t1lLIdWtEsqsLuojURK4Fh8BwXWO/w=; b=aJvGdZcFbMKvxpf/
	PQJ0spfWtCpETDVHBF8x2nKedhMkGx+r8vjUdNRdBYQaZuqaYYH3Spa7KYPmXsBb
	+iqWHsICUcx6p2HV7kzwEBglL5ntLrCGEX3ucns79t5lvfU31gmdRXnJ8GYEjEVw
	3GWjO6kXqGy6TXjtqIAopOHGcxE08/vIwD5kUOFGGvRDOPxo3jwCIIawnWc0IVKf
	Kx5VE+pMXTrQa1z5WocQHLtP8WOfc+nx5KsffpJyOlLQXiFiVe7z7oZmVgM2KYGX
	2w/VK/6oqoZqi+bzMHH6jB1YELOzwmVgAmkQSgVnM0uUvzFhHdyqVsmrfLI5m+Au
	1JBdXQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ar0503eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 01:21:20 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49H1LJd5030710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 01:21:19 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 16 Oct 2024 18:21:19 -0700
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Date: Wed, 16 Oct 2024 18:21:18 -0700
Subject: [PATCH v3 12/23] drm/msm/dpu: Add RM support for allocating CWB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241016-concurrent-wb-v3-12-a33cf9b93835@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729128075; l=2880;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=mjd1ZJN3pAxmViJZWNn8jh6IZXhJEheZjIsftdsTfHI=;
 b=7JcHnQvQIhlL9TECKCwpfMwQNHaTRRdhDyp23xEMkakWQlfBn7XqokSO1v4Kt0rNQbTGD+RTc
 6E7oJ1jERdBDnfOWqASY2Vld1xy+KHZ9b/O4oYH29+tDN2ON7xrfSha
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BCqUiEGFnF0b6b4oqc89bzkCBlryA0pc
X-Proofpoint-ORIG-GUID: BCqUiEGFnF0b6b4oqc89bzkCBlryA0pc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170008

Add support for allocating the concurrent writeback mux as part of the
WB allocation

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 17 +++++++++++++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h |  2 ++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index bc99b04eae3a5dd3182e1e49ecbe0e31e80c60fe..96c80cf9f6ad60cef9fb5fda38179b8ef4f5de4a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -1,15 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
- * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
-#include "msm_drv.h"
 #define pr_fmt(fmt)	"[drm:%s] " fmt, __func__
 #include "dpu_kms.h"
 #include "dpu_hw_lm.h"
 #include "dpu_hw_ctl.h"
 #include "dpu_hw_cdm.h"
+#include "dpu_hw_cwb.h"
 #include "dpu_hw_pingpong.h"
 #include "dpu_hw_sspp.h"
 #include "dpu_hw_intf.h"
@@ -113,6 +113,19 @@ int dpu_rm_init(struct drm_device *dev,
 		rm->hw_wb[wb->id - WB_0] = hw;
 	}
 
+	for (i = 0; i < cat->cwb_count; i++) {
+		struct dpu_hw_cwb *hw;
+		const struct dpu_cwb_cfg *cwb = &cat->cwb[i];
+
+		hw = dpu_hw_cwb_init(dev, cwb, mmio);
+		if (IS_ERR(hw)) {
+			rc = PTR_ERR(hw);
+			DPU_ERROR("failed cwb object creation: err %d\n", rc);
+			goto fail;
+		}
+		rm->cwb_blks[cwb->id - CWB_0] = &hw->base;
+	}
+
 	for (i = 0; i < cat->ctl_count; i++) {
 		struct dpu_hw_ctl *hw;
 		const struct dpu_ctl_cfg *ctl = &cat->ctl[i];
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
index 36a0b6ed628d72c892e5cc9116e1907499cc15e2..8b968655d05b03e39d27901750681fc987258610 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
@@ -20,6 +20,7 @@ struct dpu_global_state;
  * @ctl_blks: array of ctl hardware resources
  * @hw_intf: array of intf hardware resources
  * @hw_wb: array of wb hardware resources
+ * @hw_cwb: array of cwb hardware resources
  * @dspp_blks: array of dspp hardware resources
  * @hw_sspp: array of sspp hardware resources
  * @cdm_blk: cdm hardware resource
@@ -30,6 +31,7 @@ struct dpu_rm {
 	struct dpu_hw_blk *ctl_blks[CTL_MAX - CTL_0];
 	struct dpu_hw_intf *hw_intf[INTF_MAX - INTF_0];
 	struct dpu_hw_wb *hw_wb[WB_MAX - WB_0];
+	struct dpu_hw_blk *cwb_blks[CWB_MAX - CWB_0];
 	struct dpu_hw_blk *dspp_blks[DSPP_MAX - DSPP_0];
 	struct dpu_hw_blk *merge_3d_blks[MERGE_3D_MAX - MERGE_3D_0];
 	struct dpu_hw_blk *dsc_blks[DSC_MAX - DSC_0];

-- 
2.34.1


