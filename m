Return-Path: <linux-kernel+bounces-249966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B70592F246
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD012835B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA9C1A073B;
	Thu, 11 Jul 2024 22:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kpuoKTSg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1ED19FA96;
	Thu, 11 Jul 2024 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720738154; cv=none; b=M8hN7AzFI3+qpGnWzBEqS5K2FF2miKeVSngiNnjDFl1X7k7ejXwz6CzKBUymnv4YhvwGZR+/8F9WOFWMlwA7tuFAuCQnfsPzfTXqRSzY/PMX6ZzF1pmX27FnBmziNf4CKJk7UTnkPGHlPZybchzloJCcBl08bZFv/ay4q18pHHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720738154; c=relaxed/simple;
	bh=olM2mbaQpFRDawu3ZuxhvtjY5RvgK/2qLifh2Btcsjo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=frYLN3gWaMFvRXO4hCLMWvxJMpSt6YtkT+Wb9MF2E5F/WzuX0ADoo4l/W4oNlYOiTLcN/gaXSmG+MhgqQ8L8h7ysqQuilkUGrIcUTcfJp3f2ml/HWvpWIYAeVYLjUK7b4w4bTLMLHt05f3pny/AMVoMUzrWF1JFyXm6qq+vODjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kpuoKTSg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BD5Ux4016488;
	Thu, 11 Jul 2024 22:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7R+FP3GMLetxfcfS2kCF2M
	bPrUJVtVu9hdgSH1cE+KY=; b=kpuoKTSgOKhzf+vg4/5p5L3VfeBZJC1n5RotV/
	rm0Z0pW0rawrkHsOVFdrRB7g30LW0TE81+xvMKTudq48PGkncDTK2E/fGw4SUEfb
	4WPNi2UaGrigeaBu88m4XlKBoC/bfBqE6xB8TyAaYoNJEJNyUUe6kCFeKlZlOLOf
	EJh6dw7cqaOsQFsQb/jNtfNlK09cpisV1R6pf5rFLMaxagxbIaJeXAPkBepe8zrG
	4CYWPpYsluHiXy06hkBxBpIotn3/bAgOsxgRYo+1RgLd/FI6UKbjbHywTuyRs+mU
	EQpjKQ+rEjcqfY9bQntj7jcEtYKnSMeypK8IKxVcfbdMyYMQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 409kdtnev2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 22:49:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46BMn0Pb030968
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 22:49:00 GMT
Received: from abhinavk-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 11 Jul 2024 15:48:59 -0700
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
        <swboyd@chromium.org>, <dianders@chromium.org>,
        <neil.armstrong@linaro.org>, <andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/msm/dp: enable widebus on all relevant chipsets
Date: Thu, 11 Jul 2024 15:48:50 -0700
Message-ID: <20240711224850.1672662-1-quic_abhinavk@quicinc.com>
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
X-Proofpoint-ORIG-GUID: jgZH0tXYJ3JIeUHNZGO_Eyohse8GymMw
X-Proofpoint-GUID: jgZH0tXYJ3JIeUHNZGO_Eyohse8GymMw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_17,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110161

Hardware document indicates that widebus is recommended on DP on all
MDSS chipsets starting version 5.x.x and above.

Follow the guideline and mark widebus support on all relevant
chipsets for DP.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 9622e58dce3e..e1228fb093ee 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -119,7 +119,7 @@ struct msm_dp_desc {
 };
 
 static const struct msm_dp_desc sc7180_dp_descs[] = {
-	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0 },
+	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
 	{}
 };
 
@@ -130,9 +130,9 @@ static const struct msm_dp_desc sc7280_dp_descs[] = {
 };
 
 static const struct msm_dp_desc sc8180x_dp_descs[] = {
-	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0 },
-	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1 },
-	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2 },
+	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
+	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
+	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
 	{}
 };
 
@@ -149,7 +149,7 @@ static const struct msm_dp_desc sc8280xp_dp_descs[] = {
 };
 
 static const struct msm_dp_desc sm8650_dp_descs[] = {
-	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0 },
+	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
 	{}
 };
 
-- 
2.44.0


