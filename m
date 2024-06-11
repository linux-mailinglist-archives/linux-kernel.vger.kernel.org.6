Return-Path: <linux-kernel+bounces-209131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C20902DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE6D6B215B1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382DB6116;
	Tue, 11 Jun 2024 00:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XGOCwBsM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC2936D;
	Tue, 11 Jun 2024 00:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718066028; cv=none; b=CZoDcR9Y6ngQFiQJm1pnWuMHAPF2f0ubai8WDRU+1GeJwNIagdZo5rB3WxBYdhLu9lVjE9q3tGRVHxCN6uvkEYrLqfDpb/MLrFEcsCxCSuo8cbuH8MmBFtgzWnrQGve+9FhOG7y1Pk/zkFgqH9UofAcBuhjIRqJ49rdFFcDt6ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718066028; c=relaxed/simple;
	bh=wtdzQRxOMexWGjNC8skrlZnz3w3ta2PK/Jy6mSAiXnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=gU3sYXjNx8tz3fYd7pEhXl6cBHk0reD+0t3gYS1UzG1UsC9Aqddwuw3SrWSxFPq5QqzPQYNdX1+UZ23k+P4eKui5Ji7mIN0f+X4FEaN4xxg+UkuhY7BxyufK/ZVy8Cj3ZYDsPIoBWZk1R0rvzwxWj/S5YnxcuwDKgHjWJAs5aOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XGOCwBsM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45AEVpMr002947;
	Tue, 11 Jun 2024 00:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bZhndy4MI3ONNuNIKTshtD
	iak6BeQW4L/GKC3VmY628=; b=XGOCwBsMjITwMdQq+2Xk8x8LL4H5WkZtD67bME
	+Qu+ZMhBnmCqRoBx2yaXG6wicnXMyAHfEThhhnJq9Nsm2LQ7mUXEx0bcWS/xRV5x
	+vVaiaOZbd4C+q9NfTL46yN8ViMfeaTDUv9Ketudu/y7x9DjJOEGkcRKonnUL0bT
	+709Lr8cEEPpf5MYqOWcy1Mi4Cmm21dPI4RWTAeK+fQoGEUOzLGmtixLY07t0sP0
	CGFSGc+JYUF45C9kNukB5l/DXPdcorqFUDWtZTsHsU7njo+HKbG1Pib6A4G0JOlA
	wa22tqErTQVfmvTXAXak/YLr3oewf+rOcJnQmRlFFKO3GQHQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymgfk5gqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 00:33:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45B0Ximc021191
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 00:33:44 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 17:33:44 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 10 Jun 2024 17:33:41 -0700
Subject: [PATCH] staging: rtl8192e: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240610-md-drivers-staging-rtl8192e-v1-1-b5d11ee98297@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGSbZ2YC/x3MwQqDMAwA0F+RnBdo1ZW5Xxke2prVgHYj6UQQ/
 33dju/yDlASJoV7c4DQxsqvXGEvDcTZ50TIUzW0pu2NswbXCSfhjURRi0+cE0pZbnZoCc3QXYO
 Lfeg6B3V4Cz15/++PsTp4JQzic5x/58L5s+PqtZDAeX4BMlxz14wAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q_mmv1-qJ1CM5rptC5ufGbu261egW6-d
X-Proofpoint-ORIG-GUID: q_mmv1-qJ1CM5rptC5ufGbu261egW6-d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_07,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=982 suspectscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110002

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/rtl8192e/rtllib.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/rtl8192e/rtllib_crypt_ccmp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/rtl8192e/rtllib_crypt_tkip.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/rtl8192e/rtllib_crypt_wep.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 1 +
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c | 1 +
 drivers/staging/rtl8192e/rtllib_crypt_wep.c  | 1 +
 drivers/staging/rtl8192e/rtllib_module.c     | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
index cbb8c8dbe9b0..da9e630b594c 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
@@ -407,4 +407,5 @@ static void __exit rtllib_crypto_ccmp_exit(void)
 module_init(rtllib_crypto_ccmp_init);
 module_exit(rtllib_crypto_ccmp_exit);
 
+MODULE_DESCRIPTION("Support module for rtllib CCMP crypto");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
index 0244b524a7d4..3969b6b916ed 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
@@ -708,4 +708,5 @@ static void __exit rtllib_crypto_tkip_exit(void)
 module_init(rtllib_crypto_tkip_init);
 module_exit(rtllib_crypto_tkip_exit);
 
+MODULE_DESCRIPTION("Support module for rtllib TKIP crypto");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/rtl8192e/rtllib_crypt_wep.c b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
index 21c2b7666d6f..eae75d122553 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_wep.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
@@ -238,4 +238,5 @@ static void __exit rtllib_crypto_wep_exit(void)
 module_init(rtllib_crypto_wep_init);
 module_exit(rtllib_crypto_wep_exit);
 
+MODULE_DESCRIPTION("Support module for rtllib WEP crypto");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
index e7af4a25b0be..469a69726c16 100644
--- a/drivers/staging/rtl8192e/rtllib_module.c
+++ b/drivers/staging/rtl8192e/rtllib_module.c
@@ -175,4 +175,5 @@ static void __exit rtllib_exit(void)
 module_init(rtllib_init);
 module_exit(rtllib_exit);
 
+MODULE_DESCRIPTION("Support module for rtllib wireless devices");
 MODULE_LICENSE("GPL");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240610-md-drivers-staging-rtl8192e-0935b6c4b336


