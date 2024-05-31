Return-Path: <linux-kernel+bounces-197049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9638D657C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB74128E06A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FB4155A5B;
	Fri, 31 May 2024 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GR7WZzvZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337CF763FC;
	Fri, 31 May 2024 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168505; cv=none; b=aMlwXUIZ3xJV7vJ5e0ociJT8oPDRwjeI8sUUaeQwEXFz0mHyVXvehZ+aN+GP0Fh40Qmsktj8MFAA7NtKtPUfdWAGwM4BxbsTf5IJV4aUAle8E0gnpPxBtxbNgaRfUNCkbBW2Ka2XOzmi1KOlzD+TGgk7nxk1EI68Pll8SO70GK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168505; c=relaxed/simple;
	bh=y8V55efr4uF6Om2FlcplDHrMx1QmNY292P1iyKh5MJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=W0rPa4kDhn09HdPBGjkud6g/OOJ9a3HceAw+6SZyZjpKkmZSOYBbsAJnC5I0hcwtDuXHcH0N6iHB32T16S42L8BltouJ5tvC9AfucYPgh5h+WvLVJLHndQIl3vgyrBgBY9kUZvPYJ4JTIj4Lw5kitTOR22Xrqk/7M8FsRYDQ6pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GR7WZzvZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V9pdp1020271;
	Fri, 31 May 2024 15:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=p2ZQfPuppUmERB3tBSY+ow
	cilKnecseJiK+pUrjWVOM=; b=GR7WZzvZctciUkmpf198uk9tSJig5+E9FSKR8f
	Hv65b53qlSMq8jul+2KMD9cLa8AP9wursZeNss4025YZmSF7zZF0aH80+MdOYySK
	/PmzwVDrkXrZ/tpXjvkUX1qOseJPQCWdr1KiH0c+S8yHXJkRY/CNHz/Imp2juira
	U1flmNh+w1trWDOwmRb18CctYfLwZgbLQ+7eBiH6PFSbu04kNW0n2vxzXA2sL6VB
	ItWx5FcJaY4G/liJW0zc4CZQY2nzeb37r7gR5IIxKGYkEU5r1AfUvkCzQaNMtJBG
	XRMw/SdcnQx43P4YqH8fBPuPurkLhEk50eCY9Q9jP6LpNHCw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2hf3r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 15:15:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44VFExbZ000564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 15:14:59 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 08:14:59 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 31 May 2024 08:14:56 -0700
Subject: [PATCH] lib/ts: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240531-lib-ts-v1-1-03d7f3546c49@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAG/pWWYC/x3MQQqDMBCF4avIrB0wUUvbq4iLJI51wKZlJoog3
 t3o8oP/vR2UhEnhXewgtLLyL2aYsoAwufgh5CEbbGWbqq0NzuwxKT7bZrRhqOnxMpDjv9DI233
 U9dneKaEXF8N0zWeOy4Zfp4kEjuMEc6S9GHcAAAA=
To: Andrew Morton <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: U44SVSMu2BhnpEii9Asl0Cyte-VP3P-_
X-Proofpoint-ORIG-GUID: U44SVSMu2BhnpEii9Asl0Cyte-VP3P-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_11,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=829 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310114

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/ts_kmp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/ts_bm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/ts_fsm.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/ts_bm.c  | 1 +
 lib/ts_fsm.c | 1 +
 lib/ts_kmp.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/lib/ts_bm.c b/lib/ts_bm.c
index e5f30f9177df..eed5967238c5 100644
--- a/lib/ts_bm.c
+++ b/lib/ts_bm.c
@@ -216,6 +216,7 @@ static void __exit exit_bm(void)
 	textsearch_unregister(&bm_ops);
 }
 
+MODULE_DESCRIPTION("Boyer-Moore text search implementation");
 MODULE_LICENSE("GPL");
 
 module_init(init_bm);
diff --git a/lib/ts_fsm.c b/lib/ts_fsm.c
index 64fd9015ad80..053615f4fcd7 100644
--- a/lib/ts_fsm.c
+++ b/lib/ts_fsm.c
@@ -331,6 +331,7 @@ static void __exit exit_fsm(void)
 	textsearch_unregister(&fsm_ops);
 }
 
+MODULE_DESCRIPTION("naive finite state machine text search");
 MODULE_LICENSE("GPL");
 
 module_init(init_fsm);
diff --git a/lib/ts_kmp.c b/lib/ts_kmp.c
index c77a3d537f24..5520dc28255a 100644
--- a/lib/ts_kmp.c
+++ b/lib/ts_kmp.c
@@ -147,6 +147,7 @@ static void __exit exit_kmp(void)
 	textsearch_unregister(&kmp_ops);
 }
 
+MODULE_DESCRIPTION("Knuth-Morris-Pratt text search implementation");
 MODULE_LICENSE("GPL");
 
 module_init(init_kmp);

---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240531-lib-ts-854f2cd3e691


