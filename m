Return-Path: <linux-kernel+bounces-364593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD7099D69E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4121C246DB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6821C3054;
	Mon, 14 Oct 2024 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bJrZgMiU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE55E231C95
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930985; cv=none; b=YnfxJam+qLxqW5MOzbrQcl6elDtMm13AyV7wduSmCF1QE4Et2GNUADBSI403BBAMIksI61IioAtK/yB3WgEHYG9NUw/r9YRNQ+P/YuoQ/f1cPNbUnuR2Z8OQm9q7F5AIrPiOYzJXNsV+eFDbeapmWkHIm03MLoHVeuDMGxo3qzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930985; c=relaxed/simple;
	bh=VTePUnpHqYgVpl5Jqcfp5eDbODabxqh0fsjgO/XXBTo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X5ufu663IoH4LQzURMC+CPxsRbwE9bSjxg9fRAsA5KEjTo69QPknp1GTxNU68F9m8UpwwfHB6rhsojEx1bFRVvT8+80wQoKkd3bVwaW2QRi9yJRgyHKE1uYvYLDBJ9RG1CGARiHR42WrcT9pMHdhWywivZ72+ZBq5FCBG86XQ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bJrZgMiU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EAr1ke017717;
	Mon, 14 Oct 2024 18:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=rTQyTnwMYXVKv1XLuvOWrlzjFXJGsy0xy60jx4xy4vc=; b=bJ
	rZgMiUFNKuvBmgxhzysyIPuzeGGqdn627UjMMP97OEprwQEDt0gt5fCcw+AwdNQM
	MiW6hjzeH2p82Qni2hUiWAPysAQHEUK8sPO8GzDLpRBiB+qDQUp1UEry6b2rmA4d
	s9lEDgVuI4RT1LEJaTO8E56D7AkOPu+xpb17wunngP0lUghIVv/rFxGJ/1Axf1xa
	qrzWy5q+4yjJc5jAxglrxPOVKm1HJEdJrtqHBQSqHMmVRsJV/sIvJ16EJ+oxQtiq
	cVoSJFVhJVsyVEC0vvMBL1eBz+f27mybA5wh5P5hiI0lwMzf7ksM67aoZwTO7wVC
	1by3bFc8mYF7UQl5uvzw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427hvfw6ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 18:36:14 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49EIaE5v030762
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 18:36:14 GMT
Received: from hu-pintu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 14 Oct 2024 11:36:11 -0700
From: Pintu Kumar <quic_pintu@quicinc.com>
To: <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC: <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>,
        Pintu Kumar
	<quic_pintu@quicinc.com>
Subject: [PATCH] mm/dmapool_test: replace printk with pr_info/err
Date: Tue, 15 Oct 2024 00:05:49 +0530
Message-ID: <20241014183549.8898-1-quic_pintu@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ATUTi6_cuKWZcTfrKJyDwfoZKBZN51ps
X-Proofpoint-ORIG-GUID: ATUTi6_cuKWZcTfrKJyDwfoZKBZN51ps
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140133

Add SPDX license header and use correct pr_info/err.
These warnings are reported by checkpatch.
This makes the style clean.

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
+#include <linux/device.h>

WARNING: printk() should include KERN_<LEVEL> facility level
+       printk("dmapool test: size:%-4zu align:%-4zu blocks:%-4d time:%llu\n",

[...]

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
---
 mm/dmapool_test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/dmapool_test.c b/mm/dmapool_test.c
index 54b1fd1ccfbb..99269e37ca59 100644
--- a/mm/dmapool_test.c
+++ b/mm/dmapool_test.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
 #include <linux/device.h>
 #include <linux/dma-map-ops.h>
 #include <linux/dma-mapping.h>
@@ -87,7 +89,7 @@ static int dmapool_test_block(const struct dmapool_parms *parms)
 	}
 	end_time = ktime_get();
 
-	printk("dmapool test: size:%-4zu align:%-4zu blocks:%-4d time:%llu\n",
+	pr_info("dmapool test: size:%-4zu align:%-4zu blocks:%-4d time:%llu\n",
 		parms->size, parms->align, blocks,
 		ktime_us_delta(end_time, start_time));
 
@@ -112,7 +114,7 @@ static int dmapool_checks(void)
 
 	ret = device_register(&test_dev);
 	if (ret) {
-		printk("%s: register failed:%d\n", __func__, ret);
+		pr_err("%s: register failed:%d\n", __func__, ret);
 		goto put_device;
 	}
 
@@ -121,7 +123,7 @@ static int dmapool_checks(void)
 	test_dev.dma_mask = &dma_mask;
 	ret = dma_set_mask_and_coherent(&test_dev, DMA_BIT_MASK(64));
 	if (ret) {
-		printk("%s: mask failed:%d\n", __func__, ret);
+		pr_err("%s: mask failed:%d\n", __func__, ret);
 		goto del_device;
 	}
 
-- 
2.17.1


