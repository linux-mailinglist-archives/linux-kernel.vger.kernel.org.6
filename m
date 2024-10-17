Return-Path: <linux-kernel+bounces-369000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4318C9A17B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349B51C21742
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1933BBD8;
	Thu, 17 Oct 2024 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LXVhSwOf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F39018AEA;
	Thu, 17 Oct 2024 01:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729128097; cv=none; b=QRESpd+W2gtFOwihrK2c9xGcvarG6FyxVcukqvyIMuO6gPYU5v/seWx6I/GNGqED2PZaXINkkiB8hwKEN5ekru0WbHBXrW8QJbOSIwAhACaK2FS9Ymw8/ogX0M/FCs/ob9IxnQRxRviP+xCcGown3/i4SCNpvcjMgch3a2PTSNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729128097; c=relaxed/simple;
	bh=9Rk7xw2N2sg3bvy2VqJKcXUhopzuAX8I09Kv9Ru6L14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WpPBmFhiGx95elf2ERqgRRiaFzftMjtVaJ/ufdpGzwjzQKlj10yXk6DT6U2g3lh3+lFlOvqOm0sbWkUbC2c8JqWelRvyvsGRoipB7G3LeWXS+j36H+QVsT3VUeYA9fi1AuoBLAiMB0zC2+YBdpJFiNZEhrEDbkz98Qr/ZIER32M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LXVhSwOf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GGA7Is016942;
	Thu, 17 Oct 2024 01:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dSLYOKeK2D050jVbWBjBAU12s5cTt5Q7YUsl0NzD0CY=; b=LXVhSwOf+HLASbzS
	Xuig02dEWCINyo/Sjz4oTVkefqMMDSuQxoNDR6AfW1SdJFXihBMCWGMlR+B4sEC9
	qPc+QL6G5veQhshhIeRovff7Mc5XrjubajjbA/lnzHYCamwojXSgBCCJEu1RiWoR
	hJ9c+egj4Z9LC9XfyryKHcuatjAC6UqvSJtOT+T2XSRBN9zftg9o2urN1zcn0xmt
	AbOgEsrFL9/yuKcaqYKEJTUcP6KFKA/r8EP6P37d6ZmYAlc4g5Yyany+lQpeyzrN
	c/zlJr7A487DG4ve7gJloJnuHzdU0ktSlizMkaa67xMxJhycVkmmNt52iRJ23bCH
	02Miug==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429mh56f2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 01:21:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49H1LIBW006362
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 01:21:18 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 16 Oct 2024 18:21:17 -0700
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Date: Wed, 16 Oct 2024 18:21:13 -0700
Subject: [PATCH v3 07/23] drm/msm/dpu: Add CWB entry to catalog for SM8650
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241016-concurrent-wb-v3-7-a33cf9b93835@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729128075; l=2728;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=9TggonaZnQBVGjsAorWrdM06bU69eZqz6oXH/eaygJI=;
 b=OmOU0C6d3JK/EWcTVBUa+CBO/uEAFe8v19icB/Xs/MUeHTu+kIK/j14XMFMuDw7iiwnhrclcY
 oIfC7hSfXIPCVKxrr3fEZMYEue8spzvDNcGtr+99fwiWypIYyNYYLip
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Xb6WFRWpHQJCvI0x3bb7I3ZUhnnkZYbf
X-Proofpoint-ORIG-GUID: Xb6WFRWpHQJCvI0x3bb7I3ZUhnnkZYbf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170008

From: Esha Bharadwaj <quic_ebharadw@quicinc.com>

Add a new block for concurrent writeback mux to the SM8650 HW catalog

Signed-off-by: Esha Bharadwaj <quic_ebharadw@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h | 21 +++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h      | 13 +++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
index eb5dfff2ec4f48d793f9d83aafed592d0947f04b..33f5faf4833f7534a1403ccec560fffe8ea0bb1f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
@@ -350,6 +350,25 @@ static const struct dpu_wb_cfg sm8650_wb[] = {
 	},
 };
 
+static const struct dpu_cwb_cfg sm8650_cwb[] = {
+	{
+		.name = "cwb_0", .id = CWB_0,
+		.base = 0x66200, .len = 0x8,
+	},
+	{
+		.name = "cwb_1", .id = CWB_1,
+		.base = 0x66600, .len = 0x8,
+	},
+	{
+		.name = "cwb_2", .id = CWB_2,
+		.base = 0x7E200, .len = 0x8,
+	},
+	{
+		.name = "cwb_3", .id = CWB_3,
+		.base = 0x7E600, .len = 0x8,
+	},
+};
+
 static const struct dpu_intf_cfg sm8650_intf[] = {
 	{
 		.name = "intf_0", .id = INTF_0,
@@ -447,6 +466,8 @@ const struct dpu_mdss_cfg dpu_sm8650_cfg = {
 	.merge_3d = sm8650_merge_3d,
 	.wb_count = ARRAY_SIZE(sm8650_wb),
 	.wb = sm8650_wb,
+	.cwb_count = ARRAY_SIZE(sm8650_cwb),
+	.cwb = sm8650_cwb,
 	.intf_count = ARRAY_SIZE(sm8650_intf),
 	.intf = sm8650_intf,
 	.vbif_count = ARRAY_SIZE(sm8650_vbif),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index 37e18e820a20a4c4ab9a97da78df19a2ff7cfa00..b42d8b3640e2bfcf9d64cd8de416f87dcf82009b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -621,6 +621,16 @@ struct dpu_wb_cfg {
 	enum dpu_clk_ctrl_type clk_ctrl;
 };
 
+/*
+ * struct dpu_cwb_cfg : MDP CWB mux instance info
+ * @id:                enum identifying this block
+ * @base:              register base offset to mdss
+ * @features           bit mask identifying sub-blocks/features
+ */
+struct dpu_cwb_cfg {
+	DPU_HW_BLK_INFO;
+};
+
 /**
  * struct dpu_vbif_dynamic_ot_cfg - dynamic OT setting
  * @pps                pixel per seconds
@@ -823,6 +833,9 @@ struct dpu_mdss_cfg {
 	u32 dspp_count;
 	const struct dpu_dspp_cfg *dspp;
 
+	u32 cwb_count;
+	const struct dpu_cwb_cfg *cwb;
+
 	/* Add additional block data structures here */
 
 	const struct dpu_perf_cfg *perf;

-- 
2.34.1


