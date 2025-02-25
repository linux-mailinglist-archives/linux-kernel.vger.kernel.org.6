Return-Path: <linux-kernel+bounces-531012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A5DA43B17
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A266017F994
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7C8266B61;
	Tue, 25 Feb 2025 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YYa5YrIh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202F524EF9D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478211; cv=none; b=mUuJrskjK8W06y8VIKLEo6H1pGzrHOZzOKjsa6v2szl/cUbhxbvD/F8PhxjnF6Ioc0l5rVO7tIWA6+97A9gq7wgMNCxFVQOAnTONazmLQYoKboJTaZ+EQWUgYNQ6wucs/ktW9Gx4tvApqEVCVTm962guV5vvyJolDJn2PfXvt/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478211; c=relaxed/simple;
	bh=73qkubxYAKv8s4JCwe6ccYSBzZa/m+3Q11RVn1IbDtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=uaztPsg2N43dtApV4o7hM+sauAKIxPg+sMct7Y5z/hEhmC3VQsiB0SCXo1e7fa9gUEmOVyKhselC9ZMDApHuQZviTqUkBmv7RURIOztRbTW0w0BqIQXTXZO8tsnV6BkIcXu5hXl73rennfNH6CYJERRtNyjpPR2SHf3MxuH6LdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YYa5YrIh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8GQC0029304;
	Tue, 25 Feb 2025 10:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=t4C3DL+tGYZMQDFK92O7UU
	xkgkHHfg0P1fCk8DxIELs=; b=YYa5YrIhLrbv0Lmas4Usp7tD0rrXwkOu6fxd0N
	B0AsOkgoffNE5v1nk1IqIy2RL9zjW0l6Mn+xlc07Agonfs9AW/l9Y8BhJmXYywv+
	C5UdO1kdLPqGDh0SHzuWsgq1mzx43hfrHxD54IHxaG2mNYmOuLInKu/cPchK7jrk
	KBCsbBDiegcHumf5wedgU/JaKLNpUMtbcA8MySiDo25hnPpbJej0775I2DBB4lRe
	fthv4xuviiOfwmdixhQIO0bLLc0vTnfcO7si8nAbTyCieeirI0c+vmX/fcvmHY/b
	Ncm1YXIDJWAyMbYyb+7i0zUbfVGRHW036G6ydYdGPtzE7kZQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y49egmqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 10:10:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51PAA0L0016820
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 10:10:00 GMT
Received: from hu-dikshita-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 25 Feb 2025 02:09:57 -0800
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
Date: Tue, 25 Feb 2025 15:39:40 +0530
Subject: [PATCH] arm64: defconfig: Enable iris video driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250225-enable-iris-defconfig-v1-1-1ed49c8396bb@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOOWvWcC/x2MWwqAIBAAryL7nWCLPegq0YeP1RbCQiGC8O5Jn
 zMw80KhzFRgES9kurnwmRr0nQC3mxRJsm8MqHBQiIOkZOzRbOYiPQV3psBR+tHODoPV46ShtVe
 mwM//XbdaPw/LgdZnAAAA
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Hans Verkuil
	<hverkuil@xs4all.nl>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740478197; l=809;
 i=quic_dikshita@quicinc.com; s=20240917; h=from:subject:message-id;
 bh=73qkubxYAKv8s4JCwe6ccYSBzZa/m+3Q11RVn1IbDtM=;
 b=MHys0LpHWsKNIBLb3lH0qKWgAjiuSc0LSS5QEvkWUdYYJELYAz7ZUY+SoSZTtohu5MhJoroUD
 RZJLO5+Rlu3B+QF0oO7Nu/Vi9veZX1gv/wxsy/oecI6qsc+pWp2yapH
X-Developer-Key: i=quic_dikshita@quicinc.com; a=ed25519;
 pk=EEvKY6Ar1OI5SWf44FJ1Ebo1KuQEVbbf5UNPO+UHVhM=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VANBj5h4EObH-bsSi-3qBEjP6fdnwKET
X-Proofpoint-GUID: VANBj5h4EObH-bsSi-3qBEjP6fdnwKET
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 mlxlogscore=496 lowpriorityscore=0 mlxscore=0
 adultscore=0 malwarescore=0 clxscore=1011 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502250070

Enable the building of the iris video driver by default.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index cb7da4415599..9cc06923c280 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -845,6 +845,7 @@ CONFIG_VIDEO_IMX8_ISI=m
 CONFIG_VIDEO_IMX8_ISI_M2M=y
 CONFIG_VIDEO_IMX8_JPEG=m
 CONFIG_VIDEO_QCOM_CAMSS=m
+CONFIG_VIDEO_QCOM_IRIS=m
 CONFIG_VIDEO_QCOM_VENUS=m
 CONFIG_VIDEO_RCAR_ISP=m
 CONFIG_VIDEO_RCAR_CSI2=m

---
base-commit: b2c4bf0c102084e77ed1b12090d77a76469a6814
change-id: 20250225-enable-iris-defconfig-d6b8c2fb4674

Best regards,
-- 
Dikshita Agarwal <quic_dikshita@quicinc.com>


