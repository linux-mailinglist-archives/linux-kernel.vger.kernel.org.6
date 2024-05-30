Return-Path: <linux-kernel+bounces-195831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DA78D526C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EEBD1F24A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2DB158A0A;
	Thu, 30 May 2024 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kGAodZpT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12651581E6;
	Thu, 30 May 2024 19:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717097979; cv=none; b=Pd7U2zrpJhFW/gskCKrfwx1+w1MMdv86EuAMZJiIHcW/0gmtzxVEXzPmx1fzMhmXb/bzB2NylwBJqsaMplpTl2FpmRNpHK1dCUDfFAwKOk2s30uRe3TJCLLOEiyM6zUU7pnYFGMUaB5QlyfqM+4WbkscuXnp1kz0LgrTAfPDKd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717097979; c=relaxed/simple;
	bh=wUld6fDYM1OOaXYHHFwLLRyYEIOykO8t+EULeUJsVwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=lqHcbIhkehxzqdEYmMDKxnaNfbL/9iHcPgMJ2Ub4EW2qDFdUJvES6zjZ24N6KPFrijGhytcb8JFc1TYW6WX2SX9cQ22/ZRG49oj5DgpQ8BnT8P3jusKzTnYr6usyi6lmCEbGS9izZhl2gpM/HTumrhcFmUqowmTkIFh0Pq6clKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kGAodZpT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UGpGxU024728;
	Thu, 30 May 2024 19:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=G3LhfMYXLod+WXyf4kdGO/
	jHODsxn9J3pVc37hfWDsY=; b=kGAodZpTwWYkwEBVdPEUJz2E1FDOJNwQxzvj6T
	IFhFCRegim8E8nAlrQ7L7V+Wf6u58oLJEzp2o2xnzaN0xm3eqKBBYpyDrCgCOKSa
	F8Um25XZwq7hDLwJAWck9qBBt1ZfPpklHN5FhfnUa4F3SUy9i3SnMIvIPXz6BQD+
	Qh7NIgKDmmho3VKj4GCuzLosKDlerVbk0II1YK5TP/0WR9DwHKMagoDn+DU6peIR
	XGpaXYXf7KMgn5lNve4iJveErH9sHvMYmxd9mg+lzqo/9qHtOJVwKlioKpb43/Ba
	8fPddLiDCD5D+hcFZVUtVEwzVAYN4Q+RmRbNxWdXwfvAgG4Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0qmyvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 19:39:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44UJdVmU011554
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 19:39:31 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 12:39:30 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 30 May 2024 12:39:26 -0700
Subject: [PATCH] kcsan: test: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240530-md-kernel-kcsan-v1-1-a6f69570fdf6@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAO7VWGYC/x3MywrCQAxA0V8pWRuYPgYZf0VczCPa0DZKolIo/
 XenLs/i3g2MlMng0myg9GXjp1S0pwbyGOVByKUaOtcNzvcOl4ITqdCMU7YoGM7B5+B9W/oEtXo
 p3Xn9H6+36hSNMGmUPB6fmeWz4hLtTQr7/gMZhQwLgAAAAA==
To: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>
CC: <kasan-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p3zlZjerhl5YzVcwUELOeuVp3a5BI-Jf
X-Proofpoint-ORIG-GUID: p3zlZjerhl5YzVcwUELOeuVp3a5BI-Jf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_13,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405300145

Fix the warning reported by 'make C=1 W=1':
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/kcsan/kcsan_test.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 kernel/kcsan/kcsan_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 0c17b4c83e1c..117d9d4d3c3b 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -1620,5 +1620,6 @@ static struct kunit_suite kcsan_test_suite = {
 
 kunit_test_suites(&kcsan_test_suite);
 
+MODULE_DESCRIPTION("KCSAN test suite");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Marco Elver <elver@google.com>");

---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240530-md-kernel-kcsan-9795c9551d3b


