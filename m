Return-Path: <linux-kernel+bounces-369021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C11D9A17E3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0FD11C214FE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C32E1C1AAC;
	Thu, 17 Oct 2024 01:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="en4zAF7Z"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084C72D057;
	Thu, 17 Oct 2024 01:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729128103; cv=none; b=bmpbjGd1Kq2tGY/Ir9Untd7DlKtunKqgd3vkA+85qbW6F3VTIggkzyGjeg532hBW7aAOkJZShXm7DJiBd+DSyaO/JqIIfVoDRAPbNbSo7JC16B2Qvhh0ZgJpUffoERXZ3/AnlaIWMbKbDFTgqTBMYf37P8KFXQTlO1Qy3f7++iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729128103; c=relaxed/simple;
	bh=zAT/1RZLakARtRskNvuwDKkLFwptSbuWfYGGQwQuqyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UerDT9ORW80sGOr1vHDcwm1y3ToMteSZRau9MBQU9tEO79FhDbow7gRUOJo6WFDEm/L8BRwR2bNUhec5DVeD2GymeJIAu5qDmThghL5bpjyo9MTrpePnc3JqbrG36ud2NIYIDyQ2EETKG99ygWW/8V8WNOb0XJKeyDrmtAf8HTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=en4zAF7Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GF46si031206;
	Thu, 17 Oct 2024 01:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1l4YKxihYjcgP2zuhNHbdWANBSrv9bRzVOhCeLdNKU8=; b=en4zAF7Z2yiThizx
	Yy7gEg1A9bFIGdKwpzNOYsad44HpilWyYWzekBlkYeniUmma65O9YH6Mr3/z3BEu
	5HbcF3JE5u/X9nqmiuO44Rjg3vBVV/+3AJDeT0O8iry7+3tU3PRnvetottcrqQFl
	QhX2pX0OG4Ebl1K45FODhw666Ji93iReLC6cbmZxL8U7IE2GvaUny3xjgDNuVte7
	n8u34URj1QhC1/0x9FyeJIC+sBTGk0BINoH9l8//Hduk+GUNEZmcRq28S4KW30qu
	cjjPl5DGR/Gg/G6MOKoBWmzTZJ4rJKLNUMu9KgTVcyfaftIKBlJ20bAwAvV1vbi0
	BRssxg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42a8nq2x89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 01:21:21 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49H1LLKJ030738
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 01:21:21 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 16 Oct 2024 18:21:21 -0700
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Date: Wed, 16 Oct 2024 18:21:25 -0700
Subject: [PATCH v3 19/23] drm/msm/dpu: Adjust writeback phys encoder setup
 for CWB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241016-concurrent-wb-v3-19-a33cf9b93835@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729128076; l=2614;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=zAT/1RZLakARtRskNvuwDKkLFwptSbuWfYGGQwQuqyA=;
 b=cT4gqkiTaWeh+qDk0zWGklnQ8H/GczRUrQU/nhw5BkXpdB9l7I07bBa1hco37bK0S7qYh0RnJ
 V+mdXZH3t05AsQfbLiLKtKgNPNHfRC5SEDV3/2iOVIUdqQLvkuCzb5R
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kEJjTFyFvw7Knxn73Gm2SBEBu8XU66E3
X-Proofpoint-GUID: kEJjTFyFvw7Knxn73Gm2SBEBu8XU66E3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170008

Adjust QoS remapper, OT limit, and CDP parameters to account for
concurrent writeback

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
index f8eca47432962d5916737fa1f0f4ea39970a9c4a..ec69005195f97359fe56678c59adbe25a5c6b787 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
@@ -68,7 +68,7 @@ static void dpu_encoder_phys_wb_set_ot_limit(
 	ot_params.num = hw_wb->idx - WB_0;
 	ot_params.width = phys_enc->cached_mode.hdisplay;
 	ot_params.height = phys_enc->cached_mode.vdisplay;
-	ot_params.is_wfd = true;
+	ot_params.is_wfd = !dpu_encoder_helper_get_cwb_mask(phys_enc);
 	ot_params.frame_rate = drm_mode_vrefresh(&phys_enc->cached_mode);
 	ot_params.vbif_idx = hw_wb->caps->vbif_idx;
 	ot_params.rd = false;
@@ -111,7 +111,7 @@ static void dpu_encoder_phys_wb_set_qos_remap(
 	qos_params.vbif_idx = hw_wb->caps->vbif_idx;
 	qos_params.xin_id = hw_wb->caps->xin_id;
 	qos_params.num = hw_wb->idx - WB_0;
-	qos_params.is_rt = false;
+	qos_params.is_rt = dpu_encoder_helper_get_cwb_mask(phys_enc);
 
 	DPU_DEBUG("[qos_remap] wb:%d vbif:%d xin:%d is_rt:%d\n",
 			qos_params.num,
@@ -174,6 +174,7 @@ static void dpu_encoder_phys_wb_setup_fb(struct dpu_encoder_phys *phys_enc,
 	struct dpu_encoder_phys_wb *wb_enc = to_dpu_encoder_phys_wb(phys_enc);
 	struct dpu_hw_wb *hw_wb;
 	struct dpu_hw_wb_cfg *wb_cfg;
+	u32 cdp_usage;
 
 	if (!phys_enc || !phys_enc->dpu_kms || !phys_enc->dpu_kms->catalog) {
 		DPU_ERROR("invalid encoder\n");
@@ -182,6 +183,10 @@ static void dpu_encoder_phys_wb_setup_fb(struct dpu_encoder_phys *phys_enc,
 
 	hw_wb = phys_enc->hw_wb;
 	wb_cfg = &wb_enc->wb_cfg;
+	if (dpu_encoder_helper_get_cwb_mask(phys_enc))
+		cdp_usage = DPU_PERF_CDP_USAGE_RT;
+	else
+		cdp_usage = DPU_PERF_CDP_USAGE_NRT;
 
 	wb_cfg->intf_mode = phys_enc->intf_mode;
 	wb_cfg->roi.x1 = 0;
@@ -199,7 +204,7 @@ static void dpu_encoder_phys_wb_setup_fb(struct dpu_encoder_phys *phys_enc,
 		const struct dpu_perf_cfg *perf = phys_enc->dpu_kms->catalog->perf;
 
 		hw_wb->ops.setup_cdp(hw_wb, wb_cfg->dest.format,
-				     perf->cdp_cfg[DPU_PERF_CDP_USAGE_NRT].wr_enable);
+				     perf->cdp_cfg[cdp_usage].wr_enable);
 	}
 
 	if (hw_wb->ops.setup_outaddress)

-- 
2.34.1


