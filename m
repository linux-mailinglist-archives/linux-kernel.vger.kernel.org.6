Return-Path: <linux-kernel+bounces-198044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BECB8D72BF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 01:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B554D1F217FD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 23:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7CD481B4;
	Sat,  1 Jun 2024 23:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f/PiKzoI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DA72594;
	Sat,  1 Jun 2024 23:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717284814; cv=none; b=VmmHuMRPTsmR8ICAUpGo6J1QY6jBa0/saMbV91tQepi8ZMRuvq8vwrIIwPk9Mhy7ZTDnEkRw0mkGl0TT8JymCqYY1G4hBOIgfKvYbw1jEwEWEDmNtV7+J7N+oXzGJdhRV2lewkjQcoX5B7S9pxLU14LmCwgp96QC9Xw3MIBNA5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717284814; c=relaxed/simple;
	bh=2OKmri72qr+7yq99nowflqbuosPbtC9/ewnS0kyGPyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=D+bVCKqALMIMEXLCadoaTN87btI1PIgfAGpJhg7jDLN5RX1X00le4bGAKIbySIS4T9yMoUgdNjXZwhsvV/3oqY4I6ncKL39PZkV90QZ/3v3LQA7bua9UucTbsfKxL34mtmgo/56gpF7/0MxEow8CeqgzY6z1xXSuCrvpPdtMv2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f/PiKzoI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 451Mumme023690;
	Sat, 1 Jun 2024 23:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/rG/putmMKLThcmXs6qzOM
	hUYpFUikRDTLLrqpv2ySg=; b=f/PiKzoIoc1EcIpLcj4hzyQPorEvII5fMQAeQJ
	z4Ga4Laej7DiK7Lpab8VRjhCeETYaJxweyOForRdm1zIqljuzWEarBaTwQFpvC8C
	0z9cT4OWnOOvrWmrLuGkp80a/ZUjushp0YUJpIs+hTyfaaRNyer88Zak/KOfIoZG
	195x+mI++Gy0pxuNaj3rYotitUa/eONNBl/phKkWrmIF9FXBhlGbNevhO3/avBMP
	7KegEgOpVbr9+axGNNDDBY6a7T+RiJ7+nVG2Yi0BpI9cM/EbPe7gI0AvB5f1Vu6/
	+HllhPMtnUKYtde22L0kNf3nKaXGeWcsJlWDQxkAmnFjbxlg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw59hcpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jun 2024 23:33:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 451NXOXR013457
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Jun 2024 23:33:24 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 1 Jun 2024
 16:33:23 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 1 Jun 2024 16:33:23 -0700
Subject: [PATCH] KUnit: add missing MODULE_DESCRIPTION() macros for
 lib/*_test.ko
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240601-md-lib-test2-v1-1-be764b785f17@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMKvW2YC/x3MTQ6CQAxA4auQrm3SGcGFVzEu5qdIExhNOxoSw
 t0dWH6L9zYwVmGDe7eB8k9M3qXBXTpIUygvRsnN4Mn3dCOHS8ZZIla26jH3TPE60DC6BC35KI+
 ynrvHszkGY4waSpqOySzlu+ISrLLCvv8Bfa33wn0AAAA=
To: Andrew Morton <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y0ixhSHHK9JwLgyN_6LmkYxqEz5i3KuH
X-Proofpoint-ORIG-GUID: Y0ixhSHHK9JwLgyN_6LmkYxqEz5i3KuH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_11,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 clxscore=1015 mlxlogscore=989 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406010188

make allmodconfig && make W=1 C=1 reports for lib/*_test.ko:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/atomic64_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/hashtable_test.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
The last of the lib/*.ko cleanups :)
---
 lib/atomic64_test.c  | 1 +
 lib/hashtable_test.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
index d9d170238165..759ea1783cc5 100644
--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -273,4 +273,5 @@ static __exit void test_atomics_exit(void) {}
 module_init(test_atomics_init);
 module_exit(test_atomics_exit);
 
+MODULE_DESCRIPTION("Testsuite for atomic64_t functions");
 MODULE_LICENSE("GPL");
diff --git a/lib/hashtable_test.c b/lib/hashtable_test.c
index 1d1b3288dee2..3521de6bad15 100644
--- a/lib/hashtable_test.c
+++ b/lib/hashtable_test.c
@@ -314,4 +314,5 @@ static struct kunit_suite hashtable_test_module = {
 
 kunit_test_suites(&hashtable_test_module);
 
+MODULE_DESCRIPTION("KUnit test for the Kernel Hashtable structures");
 MODULE_LICENSE("GPL");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240601-md-lib-test2-d4e0b3505f1c


