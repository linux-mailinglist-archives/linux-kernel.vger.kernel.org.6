Return-Path: <linux-kernel+bounces-237973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA69F924172
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EADDB247A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1751B581C;
	Tue,  2 Jul 2024 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g5mPUV4f"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C6F1BA883
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932013; cv=none; b=N9FEyX1QJDlCjsw/R2B8kIbsjjIGeBYGxuKWsftcOR2I4sFABcKE+FWZBRhu3FfifbZ99GV2mgLmqP1Q/BIgf6J2E+RsXq8H26tUjLAJ1CotiqZjd2DtPj2mWdN9bsZoroTpSuz4oUtevahOtIvwbHjin7MOZus6YYmc3jBqpxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932013; c=relaxed/simple;
	bh=tXlu/iyyiCZQKvXuXEUwC4OSe5RD3diweqj4T7gWl6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iS9A4aWS2Ksqk8Pmuk9p2Ye7wTLRBzQW7hRkKwvgOfgq38wWxrdAkr9Qs8nNCgdj989sF8SbkPDdxsp6g0Ba0A5laiAawFN5nGJie+CWkrc5rXNgW4iTLigfWR8kFePefwmvLd6uQ0lOoH2nivXothNdjfN6vMU8v1oUJ3p1ORc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g5mPUV4f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462CYO8J019938;
	Tue, 2 Jul 2024 14:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sCFEBHA7koj+ik2f1w9lXo1W
	2vxNTRhHDG7Av5cWQgU=; b=g5mPUV4fqb3TIrKz6WxQTpVq92TXXAPnNaZ5yy4q
	RuBMuUMvkNBgUmVsWtopkZ0eTfixqogYMh8VlSImCWBOijStGdUUmkqRKdIh31JF
	t7jtO2vr9GAfHbjHUtOtGJsQGj4MNM5Je7KWhGGk8wImM7a5/b8KVhAox6UH0Wf2
	z5qdnq8WL6Zeq7wW9K4uOpHq/5TFa1E7EDzS0xPlr1R0ohYvWWNZoX+oApZ4F7BI
	XUKbqzi/3d859mGKhyEnQNQi5JbonlpDaJ313Lg4fxyTtpnO9Jig/dQ8DuxzerM1
	NYcguJ6be260QTc84eTQd5+Xo/+otEWAjySpltZyKI4pkg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40297rrqk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 14:53:24 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 462ErOjK015041
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 14:53:24 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 2 Jul 2024 07:53:22 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <brgl@bgdev.pl>,
        <madalin.bucur@nxp.com>, <davem@davemloft.net>,
        <andriy.shevchenko@linux.intel.com>,
        Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v1 4/5] devres: Simplify devm_percpu_match() implementation
Date: Tue, 2 Jul 2024 22:51:53 +0800
Message-ID: <1719931914-19035-5-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1719931914-19035-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1719931914-19035-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KjNgpdRdBidkasdEeyDcc7OjyGbgs3pO
X-Proofpoint-GUID: KjNgpdRdBidkasdEeyDcc7OjyGbgs3pO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_10,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020110

Simplify devm_percpu_match() implementation by removing redundant
conversions.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Previous discussion link:
https://lore.kernel.org/lkml/1719496036-24642-1-git-send-email-quic_zijuhu@quicinc.com/

Changes since the original one:
 - Select the simplier solution

 drivers/base/devres.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index e9b0d94aeabd..2ad6dacb3472 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -1176,9 +1176,8 @@ static void devm_percpu_release(struct device *dev, void *pdata)
 
 static int devm_percpu_match(struct device *dev, void *data, void *p)
 {
-	struct devres *devr = container_of(data, struct devres, data);
-
-	return *(void **)devr->data == p;
+	/* @data is already and must be (void *)devr->data */
+	return *(void **)data == p;
 }
 
 /**
-- 
2.34.1


