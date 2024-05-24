Return-Path: <linux-kernel+bounces-189201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E21188CED16
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 01:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D524B21CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 23:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB66C158A05;
	Fri, 24 May 2024 23:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RXcHG6r8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C578B127E34;
	Fri, 24 May 2024 23:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716595114; cv=none; b=Q2n97Sxr4YQ9cYkoqL2n23nyjrvmVkwk4vmn7UEMHPIqwgwXIU4DedtOlkQCUg/VygjNgktwBQw5f8I0fM0L3EDYeElwbJGQ2NFbtpGCzZQKQO2wvnkdIoZVbs1NUwmHWobhATyGFxgQ+JZ0WXeeuU7+7c4YNHIlbZq4cjuYrOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716595114; c=relaxed/simple;
	bh=A9S99suvDW0R8aU5hwzhr13BhdpMOBd28EOUGOBruDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=T3DE+siS+QkBT5m9TrLaqWaP9kkSQtq2HQuBx/1UzBygChkCd28vSbyECo5pfaeg//FvoeILHAHk9PzvDnSCxpIPDv2OXiF/KkSFAa61K1ThQ2PGleYV8B8bMCpN/GeRCNNS9qeVo2H6bp8I8W0NF4wLhiK2akU34nYg6pHVCv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RXcHG6r8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44ONkshW020356;
	Fri, 24 May 2024 23:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LBjmT3Coiwjm3+7PqgzsAT
	POUy8Vih/jxyPy1KSkQ/g=; b=RXcHG6r88m4vsTLx6u0B6EjiIY8UVz5I2jjd1m
	QFo/xhmjdcItoRU6Wd+0oXHZtX239rbTAreREcOVWwhR1HVuCc1m5aHHZr4jmM6n
	PvEMT0k1B7BXippHhajlgWmYHp14CGaPCHFVQ9BSpnRYssoItMYB3CCHf7OW5aJb
	eyo08owag/fiCCOrdlWOHct+RMWRdDjXn7h6+eU0TJRhbWwPW5AqIYWWTzktlcA/
	9lFDqTwrZ/WaDWXlEOT6OoUBG0zZPwSmff4J8ybDdlJIfgRxif+kvSfDs0BQkiPM
	eDmayIm2DU5y4TpXcjSdKyOHy8PLpKilrTpdzNCioxu8y5Kg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaa97bqrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 23:58:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44ONwQS4002080
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 23:58:27 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 24 May
 2024 16:58:26 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 24 May 2024 16:58:26 -0700
Subject: [PATCH] of: of_test: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240524-md-of-of_test-v1-1-6ebd078d620f@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKEpUWYC/x2MUQqDMBAFryL73QWTpq30KkVKYta6UKNk06KId
 3dbeD8Db2YDocwkcK82yPRl4SkpmFMF3eDTi5CjMtjauvpiHY4Rp173LCQF6RpdczaNCzcD6sy
 Zel7+vUerHLwQhuxTN/wqb06fBUcvhTLOq15h3w/YJadmhAAAAA==
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ruv2Ko0zEDrRL_eoJY74MkB15Lhb0hjI
X-Proofpoint-GUID: ruv2Ko0zEDrRL_eoJY74MkB15Lhb0hjI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_08,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=997 lowpriorityscore=0
 mlxscore=0 clxscore=1011 spamscore=0 phishscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240174

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/of/of_test.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/of/of_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/of_test.c b/drivers/of/of_test.c
index a9301d293f01..c85a258bc6ae 100644
--- a/drivers/of/of_test.c
+++ b/drivers/of/of_test.c
@@ -54,4 +54,5 @@ static struct kunit_suite of_dtb_suite = {
 kunit_test_suites(
 	&of_dtb_suite,
 );
+MODULE_DESCRIPTION("KUnit tests for OF APIs");
 MODULE_LICENSE("GPL");

---
base-commit: 07506d1011521a4a0deec1c69721c7405c40049b
change-id: 20240524-md-of-of_test-e6d483184b71


