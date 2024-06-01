Return-Path: <linux-kernel+bounces-197619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1587B8D6D2B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 02:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4FA5284EBA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 00:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230333FD4;
	Sat,  1 Jun 2024 00:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AsI5Dri+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E68B1852;
	Sat,  1 Jun 2024 00:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717201924; cv=none; b=M9fWEKsfjl4OLnjDSgn/TlUqFLI4jUDNbQ1FCCcto/0833gv5yFOKrFc319mn7fr/yjPLZH39xWMO5YgkIWsL0+ZEa+PcQC92hLjy9VTy0CdPlfFl66+4p/GP5d/n+UL0IUFTjy/c8KQXvQQI8PB0dYnCQE8fCiYVzRoaPKxlBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717201924; c=relaxed/simple;
	bh=/JUvva5d6xnh5YGojWFizPY8QX9Bret9wnE8Y20VAlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=feqvtpTl+AA0nG+C4+JoDyL5Le2z/RCdFPFIEuiNxuMuA7JQB9vDGP7sQPQbDcL/CbFd2eCkiJHzTCXZDtNOINT/ORjg2S5ailsXKvl3SVx6JKo7Fz2gAMCn6V2gn5LmVda9RDmH8DyrJfXwtxxc8fp//xrmLPiwnyJyMMQdNzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AsI5Dri+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VF1b6V015761;
	Sat, 1 Jun 2024 00:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=r1SBgs9XB2baeFN6Nj9QxP
	fbNSA4lDfjaPqPkB877Sg=; b=AsI5Dri+XKI4FFOuel/Foull4aGAR4a/0OvoCH
	AakhrNpExL7wRxWNwSr+FhypoiYCxvdUUQUbcRiVJfOk7tuh4F9Is8qhmoNldRjk
	7aCMngYtqH7kKYvDHA54/CuDI9GB8MFTB0GclrRfR9vE4GjmMq+JKcDZHDN6otA4
	kcjt3o2q57mucpkDAa6tGbnRJ2HEExXAHegVfqSDP6mTSvYQ5ZPbVJ3SWQaw6zn7
	TsDX2NjFxHaiNWt1I+coTjp9/ShRxHxkQGEsr8/xsTfvjrBPRmj0c43vEwhXkklx
	hlhQivbY3ytslPl0dUU1ekvsNj1jqlHEpDCOyE+Wpgbocqpw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ydyws89s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jun 2024 00:31:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4510VsvQ002347
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Jun 2024 00:31:54 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 17:31:54 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 31 May 2024 17:31:54 -0700
Subject: [PATCH] lib: test_objpool: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240531-md-lib-test_objpool-v1-1-516efee92a05@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPlrWmYC/x3MQQ6CMBBA0auQWTsJUKzoVYwxLR1kTGlJpxISw
 t2tLt/i/x2EEpPArdoh0crCMRQ0pwqGyYQXIbtiaOu2q8+qwdmhZ4uZJD+jfS8xelSqd1d1GXu
 tNZRySTTy9r/eH8XWCKFNJgzT7+U5fDacjWRKcBxfJB2fuoQAAAA=
To: Andrew Morton <akpm@linux-foundation.org>,
        Matt Wu
	<wuqiang.matt@bytedance.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 75To4B6y4M4qkaRm6DuFTpvTCxqXs1Vl
X-Proofpoint-GUID: 75To4B6y4M4qkaRm6DuFTpvTCxqXs1Vl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_14,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406010001

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_objpool.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/test_objpool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/test_objpool.c b/lib/test_objpool.c
index bfdb81599832..5a3f6961a70f 100644
--- a/lib/test_objpool.c
+++ b/lib/test_objpool.c
@@ -687,4 +687,5 @@ static void __exit ot_mod_exit(void)
 module_init(ot_mod_init);
 module_exit(ot_mod_exit);
 
-MODULE_LICENSE("GPL");
\ No newline at end of file
+MODULE_DESCRIPTION("Test module for lockless object pool");
+MODULE_LICENSE("GPL");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240531-md-lib-test_objpool-338d937f8666


