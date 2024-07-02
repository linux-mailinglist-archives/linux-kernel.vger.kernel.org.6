Return-Path: <linux-kernel+bounces-238540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B1F924BD7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B071C2216E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318A3155312;
	Tue,  2 Jul 2024 22:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fCUpaGKV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08F71DA30D;
	Tue,  2 Jul 2024 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719960484; cv=none; b=Ttoxe+qGc3n78HDvJUNXdv5zjAT4HaYIaFxFw6o3Q/oFbSFqkPUtNNFinmgy8LlewDclm/YIqQK+BhpU+9cEVK+fmCdR14e7STASsBpSltZRHmz6CnFfBwjWt9WqPuCTVNUbH2PoaCL+UFcLXlqBFjBYsqrVWmGE9MDe/tXVkRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719960484; c=relaxed/simple;
	bh=mw68T9jQcrgZ8rsXgev8J6DkS8eB19jG7vr7gTPXFRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=qcBETXq+vLU1TZC9HpFFkLTeAdzSZwMRwY4BtTJ5BG32IdxUgnDFhpUENjgTOExOqUetzOk3mxJFTngvurHs6X+8Nfcg4vLVX+nCoerviibInXcU4rJt3mTtcEkMC3D4f/MFfrypO/vdyFdqVRc9sxT8g6nvhrk/FPGJM/7CvDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fCUpaGKV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462IHokj022894;
	Tue, 2 Jul 2024 22:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jPNSw80T+KY8X2rAn8zymE
	4afhuab4qvsquOW2otnWI=; b=fCUpaGKV7BXm/aoJUHuAs2EPREecc1x2P9BUnU
	OePmoy8I3RX6RSSfiJezTwTmzyNlGsaM6zIiZVN0A7pzRSIsH33peBYMD0c0fJDp
	8VSfH+J7EZ6PateFvobYqB4VNFziV9vw4uzGOFDr2d+J7t7sAZLin5kqmNbb34e1
	266ueMLlziDx5bTtIFHrIuMb7tcYxhhSJNjFIee3941ohZdvguWNjvB/ti04Q1Qp
	zObaolSfZaddTjGs1TTzzmgHmqVxuwiAheCCIHRrRTOXIRyqi/auK4ZXlSGrfhBp
	99NdIK4yqnb8U+IelAKaE91QdT++Xd2urifZH9qhlEI/jm8w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40297rt0vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 22:48:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 462Mm0Rj021496
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 22:48:00 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 2 Jul 2024
 15:47:59 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 2 Jul 2024 15:47:59 -0700
Subject: [PATCH] math: rational: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240702-md-sh-lib-math-v1-1-93f4ac4fa8fd@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJ6DhGYC/x3MQQqDQAxA0atI1g2MseDQq5QuMho7AZ2WiRZBv
 HvTLt/i/wNMqorBrTmgykdNX8XRXhoYMpenoI5uoEDX0AfCZUTLOGvChdeMbUcUuetlihE8ele
 ZdP8P7w93YhNMlcuQf5tZy7Z7aatUOM8vvQoXjn8AAAA=
To: Andrew Morton <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cEEOViNaPPysuaBZGvU4I4ycBq0vBdP8
X-Proofpoint-GUID: cEEOViNaPPysuaBZGvU4I4ycBq0vBdP8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_16,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=921
 lowpriorityscore=0 clxscore=1015 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020166

With ARCH=sh, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/math/rational.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/math/rational.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/math/rational.c b/lib/math/rational.c
index ec59d426ea63..d2c34e629ee1 100644
--- a/lib/math/rational.c
+++ b/lib/math/rational.c
@@ -108,4 +108,5 @@ void rational_best_approximation(
 
 EXPORT_SYMBOL(rational_best_approximation);
 
+MODULE_DESCRIPTION("Rational fraction support library");
 MODULE_LICENSE("GPL v2");

---
base-commit: 1dfe225e9af5bd3399a1dbc6a4df6a6041ff9c23
change-id: 20240702-md-sh-lib-math-13228a37ef88


