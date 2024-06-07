Return-Path: <linux-kernel+bounces-206532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC544900B15
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5778FB24988
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BA619B3F7;
	Fri,  7 Jun 2024 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OaGqpKPH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0450214EC7B;
	Fri,  7 Jun 2024 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717780538; cv=none; b=iohWZp3GQTV9VBuae2I7cE7ZOcanzIghr1eXnhnaz4OiACCI3fdx1Mepl3ul6n1NArU8yWhUyA8dHlZSm8ZuqiASZwT1WS7iCk9t5txKfDb/uqbRUdCo7cJ8Uw+0wYqXpYo2Yj6s5nTahXyU2PnPdE7Cpx08KnJom/KRbanhXgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717780538; c=relaxed/simple;
	bh=Za2v3qaXxkuxnIYIIPWWduuavRVmLda6ovLO9m6cpo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=aBF6fWm2aqgWeIlMwJjfF863Svdta1U2JTPs1HjllvqrXoUyyVviQoGu2CQgmxRvIRZRD9tXDgJqZ1XqNS+avlDiL2afh81UlvDlWDmmc4QoeUgTBmm/qY/AI4UQOPW3bJYmq60MSygKkF8xsokwxIwmOYIlSP1koUaRSpaRers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OaGqpKPH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457ErQTV022867;
	Fri, 7 Jun 2024 17:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=IyRM4BkjktzL1b48KHFjkx
	6g+n1E5mh1upwggLSVvq8=; b=OaGqpKPHm7u4Dfry/x5v5uJmvNq2EgLlzWoC72
	evuvL3vwvWvaxHqm6IaRnlw7PH7s/qEmgdBFE1GZR6sYpe3f4F02on4lG/Zr8f4A
	3f4WMpZYf+bo+kxpy8INkauVkxQzyOAtxu/6yXPtz1weyAHKpq90Ap7fyDdArdbI
	Zwu1B4SHb3t4eaf2YTp6ywupZFsGlH22XOKPIspfyqYG0MvOxo/9MKE1E2GVe9AX
	/AeOuFj4UGNcH8pV4wgEY924JDBHxy0lA03///qfrrDY5D3UWE1ryYT8fRNSIttk
	zstq5GXLS9eWvGwVVBHvoVmYh2NxjWAP4ecGjuCE6O/I64zA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ykttx1wuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 17:15:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457HFTB0007719
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 17:15:29 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 7 Jun 2024
 10:15:28 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 7 Jun 2024 10:15:27 -0700
Subject: [PATCH] reset: hisilicon: hi6220: add missing MODULE_DESCRIPTION()
 macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240607-md-drivers-reset-v1-1-5d317ff8e3bd@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAC5AY2YC/x3MQQ6CQAxG4auQrm0yThCMVzEuCvMjTWQ0LRISw
 t0dWX6L9zZymMLpVm1kWNT1nQvOp4r6UfITrKmYYoh1aELLU+JkusCcDY6ZEa8NJLQSLzWV7GM
 YdD2W90dxJw7uTHI//kcvzd+VJ/EZRvv+Aw5klhiBAAAA
To: Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oAnYxsLEdQSA3XwIzJNEDNhT3V1zC5lo
X-Proofpoint-ORIG-GUID: oAnYxsLEdQSA3XwIzJNEDNhT3V1zC5lo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_10,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 clxscore=1011 adultscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070128

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/reset/hisilicon/hi6220_reset.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/reset/hisilicon/hi6220_reset.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
index 5c3267acd2b1..65aa5ff5ed82 100644
--- a/drivers/reset/hisilicon/hi6220_reset.c
+++ b/drivers/reset/hisilicon/hi6220_reset.c
@@ -219,4 +219,5 @@ static int __init hi6220_reset_init(void)
 
 postcore_initcall(hi6220_reset_init);
 
+MODULE_DESCRIPTION("Hisilicon Hi6220 reset controller driver");
 MODULE_LICENSE("GPL v2");

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240607-md-drivers-reset-e286ea07a254


