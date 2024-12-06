Return-Path: <linux-kernel+bounces-434368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 063E19E65FD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6731882F69
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AAD5FEE4;
	Fri,  6 Dec 2024 04:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="haGkTjMx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD6819413C;
	Fri,  6 Dec 2024 04:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733459589; cv=none; b=YC0kqFDlUA1nrasvEVpOWgRk4KPxfuXcXsKrzuMm4lqLpucmS0O4rs7IaQCxOezQfrrpm0qNVtvIdFnCIOBMyQbD36EyLzJiuipiW5GQ1/I44vf5HJmAnJbR0vvRIZvCqLyLWK/LBz+hUzH40PjMNGLJFcNFaWq/83oTM9BVYWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733459589; c=relaxed/simple;
	bh=/IN28iSxmhcvEHxa4BVoRCOgYG9Z1KXwzU9cJ9F+p94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cGoxkGei52D9mognfS9Io4TdansNFv91y0GdDccXxjV1CERobwP8CXZ9GdTfuguO66LMSYoJ5Kh3VPkRRtVoJg3kAZ8aw+3XAJ6v5PSSqcpztA6SbHgocrWeA+dUnp+37UOUBeIYvFHr9/Wcr8qJOBNYbeZwmJ8UeZjjqT7eveY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=haGkTjMx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5HabPr018596;
	Fri, 6 Dec 2024 04:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8oMtiPprvNxIhDeFTA0cQjpwZHwRrQy7Y7CAFVRIAq8=; b=haGkTjMxPk4ai+rD
	xV98hXcic+sDvGmaaS7QR2NUHtnZuB+OkEKjOcwVftP94/ponakaZQwEf+5Mw3zP
	WtAEion9JeUnyQKSFxJGN51GtqICZUTjuAKT0mgU+FOcI+fyYzlzwfq5F/Wkyuok
	hTpwPzofqSQMa3Q1cQwp6mfK6HYT1xjUF3AJI6yjZaMJ8hrQwe9eas3VD/KGuc35
	KmFKzeucCObKQjfjPngymJY1Fu83iJ/8zVnzGBdx9+5URoLbCb0W1TEPVTg/9Zrl
	I6eKazMd4esfxQuP3/BZAdrgOy/Bo6kug+ALYxGT8OJr4OrdhwfFk8KzX/lfY8Sy
	/5SJFg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43bbnj2a2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 04:32:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B64WQKg022073
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Dec 2024 04:32:26 GMT
Received: from abhinavk-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Dec 2024 20:32:25 -0800
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
Date: Thu, 5 Dec 2024 20:31:34 -0800
Subject: [PATCH 03/45] drm/msm/dp: fix the intf_type of MST interfaces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241205-dp_mst-v1-3-f8618d42a99a@quicinc.com>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
In-Reply-To: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
To: Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        "Chandan
 Uddaraju" <chandanu@codeaurora.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Vara Reddy <quic_varar@quicinc.com>, Rob Clark <robdclark@chromium.org>,
        Tanmay Shah <tanmay@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jessica Zhang
	<quic_jesszhan@quicinc.com>,
        Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733459543; l=2214;
 i=quic_abhinavk@quicinc.com; s=20240509; h=from:subject:message-id;
 bh=/IN28iSxmhcvEHxa4BVoRCOgYG9Z1KXwzU9cJ9F+p94=;
 b=7g6IVhPcnaqQ8NTOUjRVFRZUBZIWDAWqTn6DLossjhr+v1pLpVG+YXaRofHWr0AlgQUduHpKx
 V3HYagTe4n4A0HokVhL9+9DvkYHpGAJLEFixjahf2vctqXDIA4H/8Qj
X-Developer-Key: i=quic_abhinavk@quicinc.com; a=ed25519;
 pk=SD3D8dOKDDh6BoX3jEYjsHrTFwuIK8+o0cLPgQok9ys=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sV15U_JVGuWSDaKH9DvzifJHLBHiRztP
X-Proofpoint-ORIG-GUID: sV15U_JVGuWSDaKH9DvzifJHLBHiRztP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=940 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412060029

Interface type of MST interfaces is currently INTF_NONE.
Fix this to INTF_DP.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
index 907b4d7ceb470b0391d2bbbab3ce520efa2b3263..2509e28e3d6b582cd837c6aea167b3f4ad877383 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
@@ -375,7 +375,7 @@ static const struct dpu_intf_cfg sa8775p_intf[] = {
 		.name = "intf_3", .id = INTF_3,
 		.base = 0x37000, .len = 0x280,
 		.features = INTF_SC7280_MASK,
-		.type = INTF_NONE,
+		.type = INTF_DP,
 		.controller_id = MSM_DP_CONTROLLER_0,	/* pair with intf_0 for DP MST */
 		.prog_fetch_lines_worst_case = 24,
 		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 30),
@@ -393,7 +393,7 @@ static const struct dpu_intf_cfg sa8775p_intf[] = {
 		.name = "intf_6", .id = INTF_6,
 		.base = 0x3A000, .len = 0x280,
 		.features = INTF_SC7280_MASK,
-		.type = INTF_NONE,
+		.type = INTF_DP,
 		.controller_id = MSM_DP_CONTROLLER_0,	/* pair with intf_0 for DP MST */
 		.prog_fetch_lines_worst_case = 24,
 		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17),
@@ -402,7 +402,7 @@ static const struct dpu_intf_cfg sa8775p_intf[] = {
 		.name = "intf_7", .id = INTF_7,
 		.base = 0x3b000, .len = 0x280,
 		.features = INTF_SC7280_MASK,
-		.type = INTF_NONE,
+		.type = INTF_DP,
 		.controller_id = MSM_DP_CONTROLLER_0,	/* pair with intf_0 for DP MST */
 		.prog_fetch_lines_worst_case = 24,
 		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 18),
@@ -411,7 +411,7 @@ static const struct dpu_intf_cfg sa8775p_intf[] = {
 		.name = "intf_8", .id = INTF_8,
 		.base = 0x3c000, .len = 0x280,
 		.features = INTF_SC7280_MASK,
-		.type = INTF_NONE,
+		.type = INTF_DP,
 		.controller_id = MSM_DP_CONTROLLER_1,	/* pair with intf_4 for DP MST */
 		.prog_fetch_lines_worst_case = 24,
 		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12),

-- 
2.34.1


