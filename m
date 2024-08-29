Return-Path: <linux-kernel+bounces-307668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD2E965135
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E181F2496B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385BE1BCA0E;
	Thu, 29 Aug 2024 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ve9U8gZY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140EB1BAEEC;
	Thu, 29 Aug 2024 20:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724964561; cv=none; b=MjzTjrKe0bUSldaZBAp0IFG8JbwCHksOUI4mITkaMcOHMw+5l8WFB4Zv2eRv4qZmPTEAlI/u1j2cxSNuZPswgPaBZUSiuhxaEPQAMP0jOAzyt9VZQxF+BZYUODFIACOV7Gk4+cjAZX5l705bmSMwvdRmWMMvCyyfp53MxcDhQr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724964561; c=relaxed/simple;
	bh=rV38pUjQATMZW2bX0YqB44oTApf4ol9ff7trbEnkmx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nVAwwEVd3+zQPxAyjUySC21JZJjtNwV0hwctwMH0V6eT4LvNuBhWD5Z1NcnOHSVq+mKdh29TYPb72NiYvkyjgUewzgjoZakuBjYskJnwbffkaBJ955ZosTOXuVgO6Gdz2bGF9ZJIpJfQCJGrgQoQXRB/qL3OGPU9LaJ9ovZ4fiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ve9U8gZY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TI3mkN019847;
	Thu, 29 Aug 2024 20:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r5mMPkv37s5CmsvZPmT50lWHA90Q444v18qNmMzX81Q=; b=Ve9U8gZYD54/WPQ7
	87aJLjhtDwEYLhM4lkv1SZu32vq1mskPx/jh8eHfi9Fx6EJTDAA55ffWvC7EyW9s
	yIK+sBkLMCFpE9Cz6G6JI3DEGg16Xz3sDZYIJIfFPUYTr0NM8I1P/eNP0kwn0Mgf
	URvvApINDa0Hb7jhGxKuI0QksLUehd8Um40G69LSBrRukaUFFqf6kJIgFN2WSlo6
	H9VP2j6QgLkqMVSBZohHi8AUzfSEfEk25K5sgi12EKq0BVGDkYXLG+DDq6LUQ9Jb
	nt7KOVlWSJUBPuUvnHufxT7gDCqeBwgHhvwB7mjiQET19T4fUkE/6I2/g2podLEe
	PXPFRA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419q2xxk9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 20:49:02 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47TKn1Rh016033
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 20:49:01 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 Aug 2024 13:49:01 -0700
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Date: Thu, 29 Aug 2024 13:48:30 -0700
Subject: [PATCH 09/21] drm/msm/dpu: add devcoredumps for cwb registers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240829-concurrent-wb-v1-9-502b16ae2ebb@quicinc.com>
References: <20240829-concurrent-wb-v1-0-502b16ae2ebb@quicinc.com>
In-Reply-To: <20240829-concurrent-wb-v1-0-502b16ae2ebb@quicinc.com>
To: Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        <quic_abhinavk@quicinc.com>, Sean Paul
	<sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        "David
 Airlie" <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
CC: <quic_ebharadw@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, Rob Clark <robdclark@chromium.org>,
        "Jessica
 Zhang" <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724964539; l=1033;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=Lsi5u5MKQM9ftfBPtBVwmlyW3xI2JXKRPLVXT4zgDug=;
 b=QojlAhkJcCC3rY8YgpLUSeGPwWOlTAA/tCJnD9DooOIjG/Q5wRm2cgFTGKCCW+ENR1faazoW7
 RSd0uIxNQ4KBJ3sAQaTROTe6dOF2W7f+7lZN9ccX1h4e0KaPATT8pPH
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Rj9g2N99kDFM6aPpq0-cwpzlu65rDZvc
X-Proofpoint-GUID: Rj9g2N99kDFM6aPpq0-cwpzlu65rDZvc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290145

From: Esha Bharadwaj <quic_ebharadw@quicinc.com>

Implement instance of snapshot function to dump new registers used
for cwb

Signed-off-by: Esha Bharadwaj <quic_ebharadw@quicinc.com>
Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index d1e2143110f2..87526d3c224a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -989,6 +989,11 @@ static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_k
 				dpu_kms->mmio + cat->mdp[0].base, "top");
 	}
 
+	/* dump CWB sub-blocks HW regs info */
+	for (i = 0; i < cat->cwb_count; i++)
+		msm_disp_snapshot_add_block(disp_state, cat->cwb[i].len,
+					    dpu_kms->mmio + cat->cwb[i].base, cat->cwb[i].name);
+
 	/* dump DSC sub-blocks HW regs info */
 	for (i = 0; i < cat->dsc_count; i++) {
 		base = dpu_kms->mmio + cat->dsc[i].base;

-- 
2.34.1


