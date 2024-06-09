Return-Path: <linux-kernel+bounces-207435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CC0901717
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 19:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A571C2090F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 17:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C77481B8;
	Sun,  9 Jun 2024 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PnIvlTqf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2DA42ABB;
	Sun,  9 Jun 2024 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717952801; cv=none; b=mzS/+2dZqxSo2K222TGXP8YusyB75g6mixKkLugGejy7S4c6Va0MHV3unqMl9WFdX42mKiL5vuEoh9JBpHssAQOnNzBLB0UH4ZXHK05Zu9fzfKohYztRB5XrFXiLJnPehgNGk2Eu7cgYUO5dqFwiqGc5+gRO5wxwpibciJeI9CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717952801; c=relaxed/simple;
	bh=UONug+tHjGQtm0wMv5FIcjK3HlH0v7XTS+RD9si9Z9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=bx2UvaZqzxh16YRhfcaE5kAX/O/2uHEr8rRulhPfob2iUQb9Tn6Nm1DetQJJoHB6KoZB9bfiqY9GuMHkbQIq/j/4KNCwgYJVfk7gQM9iIuYaM7jtRIP+ehH5droM/4Xu5FQOQ23VqrYpyZWNz64Xivj/uyghFMzMAXm6q0WF6HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PnIvlTqf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 459Dj28H004165;
	Sun, 9 Jun 2024 17:06:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Nd4I7BwXo/JVhQ7ZFFgJ7D
	z9h9yOs/Q0G21x7GFkf+8=; b=PnIvlTqf4iDBxpDUe5gTO7JnOZlnB6n3PLXfQv
	8VBBm9aQmgIwqsmj4VGb2RlrVNtS8JVgODcDQHu/tZJJN+MbXPiWEAyvUeauI/Fl
	coL/VzwDlqJ8YYx/4Mu+rkX+rZLkssV2KR7ePEx+Ycz6raHzt8mea7eEcFDnVjbW
	bkjeLBuIQaM9T1otRbwFC4TDmpDEYKL06gYR7Iv4FHBRuKe8MbgqGzZRKZGeyU9d
	GZXZ2KdloY96FTLCCVBsRHakfplSwB8V29fXekq1ms3Wkf8auuw9KU/xP1pZXh3B
	GrYnVqOmiM4Jev4fDDqGbvMzrouPdHVttvKFRrcVamARsjig==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymfp79ty9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Jun 2024 17:06:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 459H6KqP021937
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 9 Jun 2024 17:06:20 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 9 Jun 2024
 10:06:20 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 9 Jun 2024 10:06:17 -0700
Subject: [PATCH] drm/bridge: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240609-md-drivers-gpu-drm-bridge-v1-1-b582c5c815d7@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAjhZWYC/x2M0QrCMAxFf2Xk2UCts6i/Ij60a7YFbB2JG4Oxf
 zfz7R4492ygJEwKj2YDoYWVP9XgfGqgG2MdCDkbg3e+dcHdsWTMwguJ4jDNtgsm4WxiiOniwzX
 k/hbA/pNQz+u//XwZp6hkbqzdeBTfXOcVS9QvCez7D5sjl6uKAAAA
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        "Jernej
 Skrabec" <jernej.skrabec@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 94vtPuE6jhCkHW1cF7GiZaiXDf1Jvg51
X-Proofpoint-ORIG-GUID: 94vtPuE6jhCkHW1cF7GiZaiXDf1Jvg51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-09_12,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406090134

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/lontium-lt9611.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/lontium-lt9611uxc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/sil-sii8620.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/sii9234.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c    | 1 +
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 1 +
 drivers/gpu/drm/bridge/sii9234.c           | 1 +
 drivers/gpu/drm/bridge/sil-sii8620.c       | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index b99fe87ec738..73983f9b50cb 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -1195,4 +1195,5 @@ static struct i2c_driver lt9611_driver = {
 };
 module_i2c_driver(lt9611_driver);
 
+MODULE_DESCRIPTION("Lontium LT9611 DSI/HDMI bridge driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index ab702471f3ab..724a08f526db 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -1021,6 +1021,7 @@ static struct i2c_driver lt9611uxc_driver = {
 module_i2c_driver(lt9611uxc_driver);
 
 MODULE_AUTHOR("Dmitry Baryshkov <dmitry.baryshkov@linaro.org>");
+MODULE_DESCRIPTION("Lontium LT9611UXC DSI/HDMI bridge driver");
 MODULE_LICENSE("GPL v2");
 
 MODULE_FIRMWARE(FW_FILE);
diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
index d8373d918324..0c74cdc07032 100644
--- a/drivers/gpu/drm/bridge/sii9234.c
+++ b/drivers/gpu/drm/bridge/sii9234.c
@@ -961,4 +961,5 @@ static struct i2c_driver sii9234_driver = {
 };
 
 module_i2c_driver(sii9234_driver);
+MODULE_DESCRIPTION("Silicon Image SII9234 HDMI/MHL bridge driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 599164e3877d..6bb755e9f0a5 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -2384,4 +2384,5 @@ static struct i2c_driver sii8620_driver = {
 };
 
 module_i2c_driver(sii8620_driver);
+MODULE_DESCRIPTION("Silicon Image SiI8620 HDMI/MHL bridge driver");
 MODULE_LICENSE("GPL v2");

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240609-md-drivers-gpu-drm-bridge-6ab32656df86


