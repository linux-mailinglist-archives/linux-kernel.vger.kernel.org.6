Return-Path: <linux-kernel+bounces-208948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE17902AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310A61F22C44
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BAA143886;
	Mon, 10 Jun 2024 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IABCUkKq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024C06BB33;
	Mon, 10 Jun 2024 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056245; cv=none; b=QZr32CZdgTLg50YVhLVTgBrhv6dDD0Jx6O+zJIgXXwkzX30demfoN8MYrr105t9uOZnTd+e+2PYwYMlH2uqwag7bnAKRb1mnosJJvJhYSHKqUK5vfZAKnSrC7KqleuZwKtFfXMvZgOYmy3nn5uBqHaqJmQ4kwx9ulC3eyLRTbu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056245; c=relaxed/simple;
	bh=TFxV9viCsgGzXh/HDil6hu+fKqnzPH+C9fRoDE52ffg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=uarjn9chKaydyCClIji8lFKWIXmRDdyFsl1MeP2AHFrMaRytvELRgS9xv10GLBUvCYGvqZUOtGj34oMlPd9JzETifppiNrScbnjaFDYakInzYJte5PBQP1scuuJrGmha+bIC5fyknrOwP6kyUX0/JPHgKAFwkGmtuyH97TGDT8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IABCUkKq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45AEm5f5006815;
	Mon, 10 Jun 2024 21:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Xmr+t7hg7hJrqIQO0ea69r
	tcJI6nRDI2vfR2R9N+DhQ=; b=IABCUkKqdHHmusndhev+/NzR8jSIa1/Wji0KUI
	IbeNVJPm2ouMjnED3uyHr5Nb2O8cmyQ6gDJ2jMpUmJMEbyuOCwUhFYWrChmzPuxP
	eUPHqwqbdLhkin3ixibdjXDeD/KerGa8Sq93dFkya3vO+H++Jb9O89EmOX7uIm3e
	8AXWfKozY/MHlCXP4d66c15GVdMwN00T3ATSGjIsICh+eEXD+xrQXPmhjYLvC1Im
	pxC3m07M/UJXYifbHM4ONZvIB31r+qq3MQ4/1Pau0DR/fn89rsKtpN2cdxmzsALn
	S9D/Rp0zLl0hEEa8I/lUofuB9GeiGDPoAKHA+m/a4m3CkaWA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymgk8vtdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 21:50:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45ALodue027898
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 21:50:39 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 14:50:38 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 10 Jun 2024 14:50:37 -0700
Subject: [PATCH] platform/chrome: cros_ec_proto: add missing
 MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240610-md-drivers-platform-chrome-v1-1-f9c75adcc1ca@quicinc.com>
X-B4-Tracking: v=1; b=H4sIACx1Z2YC/x3MSwqDMBAA0KvIrDuQhCDSq5Qu8hmbAZPIxIog3
 t20y7d5JzQSpgbP4QShnRvX0qEfA4TkyoeQYzcYZawatcIcMQrvJA3XxW1zlYwhSc2EOkzWj3a
 yJnjowSo08/HPX+9u7xqhF1dC+pULl++B2bWNBK7rBkT8reuLAAAA
To: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>
CC: <chrome-platform@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rV2IW1dhTdhSKeDRxO1BybYEnDh8Pyyd
X-Proofpoint-ORIG-GUID: rV2IW1dhTdhSKeDRxO1BybYEnDh8Pyyd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_06,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100162

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/chrome/cros_kunit_proto_test.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/platform/chrome/cros_ec_proto_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index 41378c2ee6a0..3960f7c16eb0 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -2740,4 +2740,5 @@ static struct kunit_suite cros_ec_proto_test_suite = {
 
 kunit_test_suite(cros_ec_proto_test_suite);
 
+MODULE_DESCRIPTION("Kunit tests for ChromeOS Embedded Controller protocol");
 MODULE_LICENSE("GPL");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240610-md-drivers-platform-chrome-1c84b64842cb


