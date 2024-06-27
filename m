Return-Path: <linux-kernel+bounces-233010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A2291B108
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870831F273C2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D1619EECF;
	Thu, 27 Jun 2024 20:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IOjdR3x3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D36514D6EB;
	Thu, 27 Jun 2024 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521632; cv=none; b=LWqUpgDSrT+zkt4SVmeVL1iXEW+KZe3irCUKaN2L6TonKfn7G0BqS8l0jJfywMZ4SBztt0cCXkNyBRV59X8iwCK31pUNzHzpCIj3fz2baUE9Rm26Z0ftejP2z2EoRyt2oxM0KPNxfMuqZBQoW2W1hAo6wxtyNy9wlscFGg79Q8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521632; c=relaxed/simple;
	bh=C6WsT7FSf4AiYebaH534b2vAsLxYS+5bbmQlk9UXwKc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=alLAbDTnwrHOzLxp7UncMTCiGtEFP+ovZhZXDw04iYHXJ3jVIWD4BS2hHj1evX+G6UhVmwq28oQAqR5mFlp1tqUSl8DZZBOXEy+Z+sbFtzti5Cytc+XSBWoJtP/y7hOuf7X2HudYHdjP+yjoqFu75lHn79jgm4LpHqgs797Udno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IOjdR3x3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RAkNWK003678;
	Thu, 27 Jun 2024 20:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+VgCuJQkBNSGIB2qP3xpqf
	n4wdZ4tV/ZUoWC19xX0DQ=; b=IOjdR3x3ffnD8VzBV6ykqadQwVTvpUXDk1J+W9
	R2JZtyFmhaCBdbEWtFOZ8VdU0sO50Y+4vPNhm+9lqe5JXMIbjPSgNOiA77qDgT2g
	q5Y44TkXOgcAQqZL6S1e9XbUuTLPTKo6gzdWF2vm0uqnXP2RgXFgbvAxyxgPbANO
	YKyaSB/EcoXs+tn4lG26zZW1SPQCKwBTClNUKPU+6jmJAF/aacPu5x1yG2FPrEN8
	5g+XTBPviIHcrbnbsQwBFwNqoBdHMLueRzSCP3pzmUw1zKV4sKDtjLCVCeg7UdK/
	AXn1+Zhbyv2ypUMgcYz+UbmFUxmiwFLAyNnCnxs72SM8DjoA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywmaf63ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 20:53:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45RKrekW017431
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 20:53:40 GMT
Received: from abhinavk-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 27 Jun 2024 13:53:40 -0700
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
To: <freedreno@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Daniel
 Vetter" <daniel@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <quic_jesszhan@quicinc.com>,
        <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] drm/msm/dpu: check ubwc support before adding compressed formats
Date: Thu, 27 Jun 2024 13:53:27 -0700
Message-ID: <20240627205328.2912859-1-quic_abhinavk@quicinc.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CK130NLPbFawpboBquJSvSoZ9kATw-UH
X-Proofpoint-GUID: CK130NLPbFawpboBquJSvSoZ9kATw-UH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_14,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=832 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406270155

On QCM2290 chipset DPU does not support UBWC.

Add a dpu cap to indicate this and do not expose compressed formats
in this case.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h | 1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h          | 2 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c               | 5 ++++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
index 3cbb2fe8aba2..6671f798bacc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
@@ -12,6 +12,7 @@ static const struct dpu_caps qcm2290_dpu_caps = {
 	.max_mixer_blendstages = 0x4,
 	.has_dim_layer = true,
 	.has_idle_pc = true,
+	.has_no_ubwc = true,
 	.max_linewidth = 2160,
 	.pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
 };
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index af2ead1c4886..676d0a283922 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -342,6 +342,7 @@ struct dpu_rotation_cfg {
  * @has_dim_layer      dim layer feature status
  * @has_idle_pc        indicate if idle power collapse feature is supported
  * @has_3d_merge       indicate if 3D merge is supported
+ * @has_no_ubwc        indicate if UBWC is supported
  * @max_linewidth      max linewidth for sspp
  * @pixel_ram_size     size of latency hiding and de-tiling buffer in bytes
  * @max_hdeci_exp      max horizontal decimation supported (max is 2^value)
@@ -354,6 +355,7 @@ struct dpu_caps {
 	bool has_dim_layer;
 	bool has_idle_pc;
 	bool has_3d_merge;
+	bool has_no_ubwc;
 	/* SSPP limits */
 	u32 max_linewidth;
 	u32 pixel_ram_size;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 6000e84598c2..31fe0fc4c02e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -1341,10 +1341,13 @@ void dpu_plane_danger_signal_ctrl(struct drm_plane *plane, bool enable)
 static bool dpu_plane_format_mod_supported(struct drm_plane *plane,
 		uint32_t format, uint64_t modifier)
 {
+	struct dpu_plane *pdpu = to_dpu_plane(plane);
+	const struct dpu_caps *caps = pdpu->catalog->caps;
+
 	if (modifier == DRM_FORMAT_MOD_LINEAR)
 		return true;
 
-	if (modifier == DRM_FORMAT_MOD_QCOM_COMPRESSED)
+	if (modifier == DRM_FORMAT_MOD_QCOM_COMPRESSED && !caps->has_no_ubwc)
 		return dpu_find_format(format, qcom_compressed_supported_formats,
 				ARRAY_SIZE(qcom_compressed_supported_formats));
 
-- 
2.44.0


