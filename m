Return-Path: <linux-kernel+bounces-197644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B708D6D6C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 03:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2B61F23CC3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2023A943;
	Sat,  1 Jun 2024 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R4aI75Uk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C201AD31;
	Sat,  1 Jun 2024 01:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206601; cv=none; b=ZUL1iq3kO45DWp2ixZ5whsdtetxJaEs3YBTxRBtf7Er2FuaWbgrGTA+zBo88MLhYqZW6UOU/yoVm/oHtT6TzKnjX9O5g3nQFdj3OFlY0+uTWa2iIu3tko6LSH8c73F6/AeEzOzu3mDz4GGLxx/AhSWtRjSQ+W95UGcME5bcOTqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206601; c=relaxed/simple;
	bh=bfin1mb2lms87ecaRAMBZaip0AwJC2lMiq3E1SwXuzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=XtKL9ZZkvfIZapRK/mULImJay5C5x/n5MRFpL+WRzH62LU3TnDLOutQuaiqvGOetdXMxHN1JvqN+a8+bkMb09iQ230gPdab3emxbLOVGPSvjMEzRoFz9hTYOBU/Mv00o6qtz9vhoSW2TRV4xW+d2H0F+8dnoRhR8zAsrv/r+jrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R4aI75Uk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VN85f4015687;
	Sat, 1 Jun 2024 01:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4pKatfYly41zvnKCsAN2dr
	HHRXyfn7lM+D+5/Fjk/3Q=; b=R4aI75UkZ7qzBIl1s0dwWLxaJidqsVrtKGc9Hn
	lDEtxkdKvsk7z7OCigzzZHIymR/CU39slxgKDNB7CnFtWjHJvskAydgSDyh6qKyE
	CqjVVc16yB9LsT94hyaekx79LEw5bCkwJWku1+/8jYveyluY+VU99wVYddq9dz88
	AotnHblin7iPlzKl7qodVNbOuJncrjk7l2MyoGiKuVSAlah2w27r5P6unjRVEpeb
	ivbekMhld3Zedbt0kGODG3ybEJCavBgXDrPaBqY9z9FSpMfXfH9hha35JWlj4Xl2
	km/EMsYWtce6xrRsAPzgfAEvfw5uO6tfYkbAdH8I0nQsduAg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ydyws8ce1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jun 2024 01:49:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4511nuF5001520
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Jun 2024 01:49:56 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 18:49:56 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 31 May 2024 18:49:47 -0700
Subject: [PATCH] siphash: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240531-md-lib-siphash_kunit-v1-1-38688065b796@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADt+WmYC/x3M0Q6CMAxA0V8hfbbJNsGgv2KM6aC6RqhkBUNC+
 Henj+fh3g2Ms7DBpdog80dM3lrgDxV0ifTJKH0xBBdq1xw9jj0OEtFkSmTp/lpUZnSRmhDO/lS
 3LZR0yvyQ9b+93oojGWPMpF36zQbRZcWRbOYM+/4FQTcSAoUAAAA=
To: Andrew Morton <akpm@linux-foundation.org>,
        "Jason A. Donenfeld"
	<Jason@zx2c4.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _OzywqVpjxsdpH14tlUm7EFyoHm5pdZ4
X-Proofpoint-GUID: _OzywqVpjxsdpH14tlUm7EFyoHm5pdZ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_14,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406010012

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/siphash_kunit.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/siphash_kunit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/siphash_kunit.c b/lib/siphash_kunit.c
index a3c697e8be35..26bd4e8dc03e 100644
--- a/lib/siphash_kunit.c
+++ b/lib/siphash_kunit.c
@@ -194,4 +194,5 @@ static struct kunit_suite siphash_test_suite = {
 kunit_test_suite(siphash_test_suite);
 
 MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
+MODULE_DESCRIPTION("Test cases for siphash.c");
 MODULE_LICENSE("Dual BSD/GPL");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240531-md-lib-siphash_kunit-0ba522916488


