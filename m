Return-Path: <linux-kernel+bounces-522361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79016A3C927
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B21B3B28C2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1E422F3BD;
	Wed, 19 Feb 2025 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PV89HwoP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBEB1ADC86;
	Wed, 19 Feb 2025 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739994608; cv=none; b=RnKznxfzDu3zGir3+NRHdW6Kr/OI4GiNgEQsof27Xm22fA+oRVNykT7Uiq3BjQUwH8ZCiMkPdHmdaiYi1CD93Y4oqqiO33dTqVlserFYjSTbo4FTuwLf2vdt0Q9lwFTE5GkC7MtOq9J6mHJKWv2Lo5dRlI0OsCh9qeGhKliHiXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739994608; c=relaxed/simple;
	bh=JI9GrFlF/nAWv81oPejK4/xpvgUQO1mgJgREQLuTbbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UliqUnw2TwUyTv0FFzhF2Fflpif89kiQtSBoLyeHnBAlg/5QHfNkd8JP8b9wWuYqlTGoZA4BkCpN+GqZhQkVaD9Nz32h6d+OwHnE1QUmhywPeIT6YFxRY8jCs/yplt8Hk+zRjRBDyuzH/NdqPXRD1oCE5gUQErannSia4O8BCxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PV89HwoP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JGD7YU015154;
	Wed, 19 Feb 2025 19:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vB2leBjenYkd7IN9pVcSfjG6dUvdlda7ioUVzLUhZz0=; b=PV89HwoP3BN2MtFW
	csagT5MqBQdPBp11MeJyc5TkEEOf5Y5yYEFFaqCHIF2h0DdpUAoJI3WHO3rg0JD0
	HsxKUgBVuThUS8vyMsOeuEjQwPKJJlWw1/f/TTVuWS/sleLtPpFIc47hMpoVN0SS
	pFInGujYQ3YfBxPirtr+xvokBmbIQhEdNtOUD9a+Kv6wvYb8TD+T3jBPrdrZf32d
	vXZ/VOw+cj6yp8EJ2IEVBtzr11IIR+WBbtvhQUBHueqGWNUUqtrM16upcR53axAn
	KkIPlc79JPddaAyPjyGfzOqgfTUol/eYpdpwwJY6p8+BWWPQ1s/Cj1HZ65WB9ZJU
	HwPjow==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy4btx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 19:49:58 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51JJnvwB017781
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 19:49:57 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Feb 2025 11:49:57 -0800
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Date: Wed, 19 Feb 2025 11:49:18 -0800
Subject: [PATCH v3 2/5] drm/msm/iommu: rename msm_fault_handler to
 msm_gpu_fault_handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250219-abhinavk-smmu-fault-handler-v3-2-aa3f0bf4434a@quicinc.com>
References: <20250219-abhinavk-smmu-fault-handler-v3-0-aa3f0bf4434a@quicinc.com>
In-Reply-To: <20250219-abhinavk-smmu-fault-handler-v3-0-aa3f0bf4434a@quicinc.com>
To: Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>
CC: Abhinav Kumar <quic_abhinavk@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        "Jessica
 Zhang" <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.15-dev-f0f05
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739994597; l=1774;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=vgPDXDqUxj8n/dCQlEEd8aA5R+3YKMV0KJToIhdliOM=;
 b=V/I0ku8UIXSIpL1MJQpXQtdSzFfVGXZjklgPzgaXvPrWHOKFCBrSpM1vD/xoturrOpb0Xgzob
 nLfXXb05A3hA44rsvroRwVIDh43M+4H6cZN7bz3w2qJb/M2JqbMqnhQ
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PqccdSaxqhwEYLY2R1JMzN3YA8CTPpOT
X-Proofpoint-ORIG-GUID: PqccdSaxqhwEYLY2R1JMzN3YA8CTPpOT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_08,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=785 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190153

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

In preparation of registering a separate fault handler for
display, lets rename the existing msm_fault_handler to
msm_gpu_fault_handler.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/msm_iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 2a94e82316f9..20518bf9898a 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -243,7 +243,7 @@ static const struct iommu_flush_ops tlb_ops = {
 	.tlb_add_page = msm_iommu_tlb_add_page,
 };
 
-static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
+static int msm_gpu_fault_handler(struct iommu_domain *domain, struct device *dev,
 		unsigned long iova, int flags, void *arg);
 
 struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
@@ -319,7 +319,7 @@ struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
 	return &pagetable->base;
 }
 
-static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
+static int msm_gpu_fault_handler(struct iommu_domain *domain, struct device *dev,
 		unsigned long iova, int flags, void *arg)
 {
 	struct msm_iommu *iommu = arg;
@@ -448,7 +448,7 @@ struct msm_mmu *msm_iommu_gpu_new(struct device *dev, struct msm_gpu *gpu, unsig
 		return mmu;
 
 	iommu = to_msm_iommu(mmu);
-	iommu_set_fault_handler(iommu->domain, msm_fault_handler, iommu);
+	iommu_set_fault_handler(iommu->domain, msm_gpu_fault_handler, iommu);
 
 	/* Enable stall on iommu fault: */
 	if (adreno_smmu->set_stall)

-- 
2.48.1


