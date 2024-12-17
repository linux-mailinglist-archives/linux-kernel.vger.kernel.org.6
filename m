Return-Path: <linux-kernel+bounces-448365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C089F3F4B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F3B77A5162
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068CC142E77;
	Tue, 17 Dec 2024 00:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o+NasEhR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8988973451;
	Tue, 17 Dec 2024 00:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734396222; cv=none; b=I7NGa/2Y+Sz5ssOVY5zToRKvOas1g2Glc/z4BNSLYzJUOmWZjzAo6a/t7LAFYgOAGMz/5MYky+QwwL7i7yoqHXyFsZDYIpDeD4r0sVXIbLJTsoXl42O9mCDdXGu7UlJfZq87khoSTU290bk2YYnk2LiGy2l6PCeAEMP4CCre8zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734396222; c=relaxed/simple;
	bh=AeBq4h/GHY8tFhhkFXpKhdg8Aq9jZPVE9sWoFfNT+JM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZZdRJbtW+vHlZ39ae63toB0PPpxPi4fv2HmPNnTh0Y38AYy3SgCstlPV1ieFDSv63hvNkOzmp+R4HPyTlOS+MakbX6iuyTYc1Eh+HcOJmKJDJ/ikHKHIs/PNJcuvXtOoRL8l2bhddqKWitu7ywY202sXaRxQZsnqdlZ44TuBm9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o+NasEhR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGMsBS1008448;
	Tue, 17 Dec 2024 00:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nYSIOetJs6YdmhLewOLmculnnd8ueBB4wuveIJ5mNSA=; b=o+NasEhRhRYhK15x
	7LvNZesT3UPUvr2wf5yrm+JB94520HY5gOUAuYZ/FWxgDl2kXR5b6J1BOBIjR8WL
	ZDTo9vgmvDuVS9aKdYcMHKxOAQItxGtycMiERNy0DXkpKKDIOXg7Nftt+iearrWY
	mGjEIcJ1J2jPhZOUBnP0arprBIg7zQFw01hotCOaCrMEZ4uk1Fzvyj04LuX8v2qh
	o/XjgiohctzY2spJpMdapsFPhVTI87bYAXfgRNQ9zF74pCcNbplK/v55cXZuKEj3
	A5sRWJoGJU3/z7NF7qkBGsMibJQ3ILn6/oTZ2Mq5Tx+FQ/I2mg3qGL6scY+4i9O8
	ok8pFA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jwda062b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 00:43:26 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BH0hPYl018351
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 00:43:25 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 16 Dec 2024 16:43:25 -0800
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Date: Mon, 16 Dec 2024 16:43:12 -0800
Subject: [PATCH v4 01/25] drm: add clone mode check for CRTC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241216-concurrent-wb-v4-1-fe220297a7f0@quicinc.com>
References: <20241216-concurrent-wb-v4-0-fe220297a7f0@quicinc.com>
In-Reply-To: <20241216-concurrent-wb-v4-0-fe220297a7f0@quicinc.com>
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
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734396205; l=1838;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=AeBq4h/GHY8tFhhkFXpKhdg8Aq9jZPVE9sWoFfNT+JM=;
 b=WaS2LQgk9w/JdX4PZF1o+TFLrXvpMtH0f4FoGCH7XS4fYFRcJ4J29wq2u/nZfMaG4DpZVRIe2
 1RBXjMlPFwTDnFgK/WoosbCbYSXdwPSjD+hc2PuaSa2TlwIWi/TFcQa
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TXHcPwy7VNXDORtMsZtU83PAd7HaYZys
X-Proofpoint-ORIG-GUID: TXHcPwy7VNXDORtMsZtU83PAd7HaYZys
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=968 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170004

Add a common helper to check if the given CRTC state is in clone mode.
This can be used by drivers to help detect if a CRTC is being shared by
multiple encoders

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/drm_crtc.c | 20 ++++++++++++++++++++
 include/drm/drm_crtc.h     |  2 +-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 3488ff067c69bb820b36177c97bc9fe5d5cbfea1..46655339003db2a1b43441434839e26f61d79b4e 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -939,3 +939,23 @@ int drm_crtc_create_scaling_filter_property(struct drm_crtc *crtc,
 	return 0;
 }
 EXPORT_SYMBOL(drm_crtc_create_scaling_filter_property);
+
+/**
+ * drm_crtc_in_clone_mode - check if the given CRTC state is in clone mode
+ *
+ * @crtc_state: CRTC state to check
+ *
+ * This function determines if the given CRTC state is being cloned by multiple
+ * encoders.
+ *
+ * RETURNS:
+ * True if the CRTC state is in clone mode. False otherwise
+ */
+bool drm_crtc_in_clone_mode(struct drm_crtc_state *crtc_state)
+{
+	if (!crtc_state)
+		return false;
+
+	return hweight32(crtc_state->encoder_mask) > 1;
+}
+EXPORT_SYMBOL(drm_crtc_in_clone_mode);
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 8b48a1974da3143c7de176e6fe3e01da9c8fc9d8..caa56e039da2a748cf40ebf45b37158acda439d9 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -1323,5 +1323,5 @@ static inline struct drm_crtc *drm_crtc_find(struct drm_device *dev,
 
 int drm_crtc_create_scaling_filter_property(struct drm_crtc *crtc,
 					    unsigned int supported_filters);
-
+bool drm_crtc_in_clone_mode(struct drm_crtc_state *crtc_state);
 #endif /* __DRM_CRTC_H__ */

-- 
2.34.1


