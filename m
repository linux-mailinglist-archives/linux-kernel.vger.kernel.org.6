Return-Path: <linux-kernel+bounces-182997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BF98C9305
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 01:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C7F0B20CC7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 23:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F1B6D1B4;
	Sat, 18 May 2024 23:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="enzkwb3H"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA056199B8;
	Sat, 18 May 2024 23:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716073932; cv=none; b=RaL6kufKwsXhSzhTNOuCfL42+hnAKzlC8dJBmQ91wgtCT+lYFmDYUEgHQybp20thOrLSDr+ZqkQDRctdWqSxzTmISqe4RAwp3K1XHVYwVvmTGIz12O0KWxkA3cFHB3kPOuVdLr2guvVUsKRmLV0Z+2UMErF0/TfqG+j+R4gV7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716073932; c=relaxed/simple;
	bh=ZeSIowTQnr75QHtRD1Ng6pH+Ka2rBOSqW8vKeGA7vU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=cE4dEGuOxB71wjS6MSJvNG92HwNP5Mvsr1CXArLwAzZtDep9qndlqKFMtfJ0LecycDzsNpBm2XD4SCDIEg9jFkNXO4+Jg11VlWHkmR+CZX9x0Lt9vuduo0e88pWZIppn/yq7RGmPHKnSKhKDeDiYJrm8KNT4JI2r6acDvGKzL9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=enzkwb3H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44IMjeXm004256;
	Sat, 18 May 2024 23:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=OUQ
	Rd2GdRsf9lno54cKcnioHKkv4lAeUNhw2neBZqrc=; b=enzkwb3HD1wQqTS8Y2G
	i8XY4WwnEzkmeQw5TskQ1Trda2z/U7KVUMHanNAd1p2rsQDZ3v/lUOvQFyhYybDP
	M4z5o7KqfyPtuCZ/+gHiOcCnP2uQM9vsRjZgEj0sSwvHZ5SQAAc/GIZa29behsSR
	H7fH41G9u7Idft2bvG4sOf96DCIUhOpKq/9IC9DQztdGYE8ncUf0PIqlcnjiftXR
	rqUM3CPP7n1G33t652lguZtzApHBEALXtrZa1he3ibHrbanBymuZ1KZgzFhojBvc
	HYiMdHLV0XR0pbEWdq2IgZP22jtXhwrg/qyGmWCeTtkg1QZbd6y1KKRlwbBs3ID3
	5kQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pq58t2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 May 2024 23:12:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44INC6Bc002988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 May 2024 23:12:06 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 18 May
 2024 16:12:06 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 18 May 2024 16:12:05 -0700
Subject: [PATCH] backtracetest: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240518-md-backtracetest-v1-1-fab9f942c139@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMQ1SWYC/x3M0Q6CMAyF4VchvbbJBhjUVzFcdKNIo0zSToMhv
 LvTyy8559/AWIUNLtUGym8xeaYCf6ggTpRujDIUQ+3q1h39CecBA8V7Voqc2TJG7hrXnP3QdiO
 U26I8yvpPXvviQMYYlFKcfqGHpNeKM1lmxeVTprDvXwDSUyiHAAAA
To: Andrew Morton <akpm@linux-foundation.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ag_TIsourjFYivzlDU9J3cCs1DQQRdC5
X-Proofpoint-ORIG-GUID: Ag_TIsourjFYivzlDU9J3cCs1DQQRdC5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-18_14,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1015 mlxlogscore=907 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405180191

Fix the 'make W=1' warning:

WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/backtracetest.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Andrew, 'b4 -c' doesn't show any maintainers for this file, so
adding you for guidance.
---
 kernel/backtracetest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/backtracetest.c b/kernel/backtracetest.c
index a4181234232b..2dfe66b9ed76 100644
--- a/kernel/backtracetest.c
+++ b/kernel/backtracetest.c
@@ -74,5 +74,6 @@ static void exitf(void)
 
 module_init(backtrace_regression_test);
 module_exit(exitf);
+MODULE_DESCRIPTION("Simple stack backtrace regression test module");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Arjan van de Ven <arjan@linux.intel.com>");

---
base-commit: 674143feb6a8c02d899e64e2ba0f992896afd532
change-id: 20240518-md-backtracetest-ce730391d47f


