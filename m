Return-Path: <linux-kernel+bounces-196227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F8C8D591F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 05:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5578B1F23D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4938277F08;
	Fri, 31 May 2024 03:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LJvY+hNU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2D2187562;
	Fri, 31 May 2024 03:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717127292; cv=none; b=A6pvdj3aPCxy2nnxdIedZFznpyOl7iXtIV39DMaRmp8TKcbxigdm8kDUek+sYr7d4eM3x91R/bJvqdLRexOLRCxQZthvLcCe+xBr6Yb0LWpyPZSSdgREtd40N3dTfOlRpsET7Kt/vKFBnszXEZkF56BLX4F+TX7VEAYiarHhUDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717127292; c=relaxed/simple;
	bh=0qCJgFLf9cXN6pdBFJDfR8v6g2HBsgnEiPYfjYNZNY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=oNMN9dlBcyqzB+HhHRiZ2Ih6BJB0/vvlOsMqr1AFJBDXpC4yq6Tl3rApIdvrqQQ8QaNyRmM+4jPO5+tB1fOtQeK1BvyH2ONLgOtusULSZcUZHWdiYXhJBZfzLiGqa2kkXWcf1s6O0d5APNG1aYzkTR1/LgszFNzBWnOBeaal7dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LJvY+hNU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UJPcHi015856;
	Fri, 31 May 2024 03:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Br+FZ6MhvKaX5QBk82W+eV
	7qxeYU5nM4tEeHEpAgG2s=; b=LJvY+hNU9u/3LCqpd0At2U2Z4nF99G5mfPpgQr
	NIrdtRPsirH8J/I5ZpjigWDx0fitE3Zc5l42Xl8LCmgk6mERcURP/8cbGd8yhLQc
	P5vOcRJBBSVGR7sRR2izUzdW5ONLWvLUsjXimEropir2MekakqF1RZeEDzshzisr
	L6r2FwXiHOcqjQPSPvDlmYr/veMZGAIj/dWhsatR7PR1xfyhSOtNA824atvxh//2
	EcUwdWtvPGp+otr11W8cbaFYeH51wYQarkrX8ByNrUI50ADBjksG0pWRoJh+RhPY
	lv81MZPUOxrjZAsf7fFfNlzn0DbEtzu83W8aXbGeS8CJzjYA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2pwuu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 03:48:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44V3m89n004112
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 03:48:08 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 20:48:01 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 30 May 2024 20:48:01 -0700
Subject: [PATCH] parport: add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240530-parport-v1-1-09bee2ca3123@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAHBIWWYC/x3M0QqDMAyF4VeRXC9Qu6ljrzK8SLs4A66WREUQ3
 33dLj/4zznAWIUNHtUBypuYzKmgvlQQR0pvRnkVg3f+5pqrw0yaZ12w7og7H5v7EFoodVYeZP8
 /PfviQMYYlFIcf/tJ0rrjh2xhhfP8AqjUUZ94AAAA
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FIaQ4w7fS3vAdceo2HPcuHKHYgN5ai8s
X-Proofpoint-ORIG-GUID: FIaQ4w7fS3vAdceo2HPcuHKHYgN5ai8s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1011 bulkscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 mlxlogscore=919
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310028

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/parport/parport.o

Add the missing MODULE_DESCRIPTION() macro invocation.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/parport/share.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 49c74ded8a53..b7148517e076 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -1219,4 +1219,5 @@ irqreturn_t parport_irq_handler(int irq, void *dev_id)
 }
 EXPORT_SYMBOL(parport_irq_handler);
 
+MODULE_DESCRIPTION("Parallel-port resource manager");
 MODULE_LICENSE("GPL");

---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240530-parport-17ae72c58fb6


