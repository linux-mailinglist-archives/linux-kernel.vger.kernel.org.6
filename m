Return-Path: <linux-kernel+bounces-197604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F27848D6CFC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77EE1F26875
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BDD13210A;
	Fri, 31 May 2024 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WdPOP4Oq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7427C6D5;
	Fri, 31 May 2024 23:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717199125; cv=none; b=f7GZXsm27bY2AvKfXJakNKB/gdO9ujyTp2YR7CsSNidItTM76DJfVGmPuZ+jCzEQ+bWjFmWUUgkREzUyBgZOlb50mh7RuGh+9CZVFchjwFs6EMzAGFJCZZjFbJh5AJUjgPVXp11m5db9yaGGBr6Mc14y5UDIEe7yLtbn6bbBqms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717199125; c=relaxed/simple;
	bh=lKmrAoOUcOEbDxUzLRk3+YZK3TElbngdTHw7NxETvUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=itGzEjGFlYnpcg71HIL61qbI1lxujmFu5trWDMRa94BHlojXtltOricApqTnw6OkHy8qIG/xHeJ21C8QJ9Rcs/qhB+UA2r7GzpydvMlaoDInf5HudabonPVsYCfQTSoVcTzLnmynbK6g1GdW5PKmO/4grPH2xalXHvN3BDe6X30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WdPOP4Oq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VGea94022880;
	Fri, 31 May 2024 23:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mubpV1GE2DfPJE/CDMmUIn
	vdAS7wgTo0Z3KjCV6Kryc=; b=WdPOP4Oqd/qs38LP8ZhM87UNK/+Auan+u0vs6j
	iRxxkYgCmvZE4mSrIyorZrUl3RyIzzq3bs0HhTTfGxXAKMcA7d8ZRoHBx9s/6z0V
	zg4SbIikHodM1KuNw71hIRKibWACaEA6FxLN4bj8FB1HTIP7IXwpfB7Kvlv+cT9i
	9+2EUY7xYqbq4TZ71LRFXR7QnbHxyidrJ9gtwmEZ/DeITHVJwuyqyMVqtc0eN6Az
	sY2WKXDXch5QUZG9UvzMmeOJfFS9si5mol0NsAeLnklEUy3BTp/xjy+E3E7Vw8Mq
	SIz7qpgKOJtbVOPTKSPSwFZG6imS0JrFOLtYUIR7ecwd2u1w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfj9d920c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 23:45:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44VNjHct025500
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 23:45:17 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 16:45:17 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 31 May 2024 16:45:16 -0700
Subject: [PATCH] lib/test_linear_ranges: add missing MODULE_DESCRIPTION()
 macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240531-md-lib-test_linear_ranges-v1-1-053a1aad37c6@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAthWmYC/x2MWwrCQAwAr1LybWC3Plq8ikjZR7SBdpVklULp3
 U39HJiZFZSESeHarCD0ZeVXMfCHBtIYypOQszG0rj2589HjnHHiiJW0DhMXCjLI7ileetflFH1
 PHYH1b6EHL//37W4cgxJGk9O4Hy3+LDgHrSSwbT8KYFjSigAAAA==
To: Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown
	<broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MKjnPy_UwisyynTfDeU34RmJOqR0kZet
X-Proofpoint-ORIG-GUID: MKjnPy_UwisyynTfDeU34RmJOqR0kZet
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_14,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1011
 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2405310182

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_linear_ranges.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/test_linear_ranges.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_linear_ranges.c b/lib/test_linear_ranges.c
index c18f9c0f1f25..f482be00f1bc 100644
--- a/lib/test_linear_ranges.c
+++ b/lib/test_linear_ranges.c
@@ -216,4 +216,5 @@ static struct kunit_suite range_test_module = {
 
 kunit_test_suites(&range_test_module);
 
+MODULE_DESCRIPTION("KUnit test for the linear_ranges helper");
 MODULE_LICENSE("GPL");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240531-md-lib-test_linear_ranges-6807dcb18e7e


