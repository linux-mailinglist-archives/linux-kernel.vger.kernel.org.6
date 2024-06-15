Return-Path: <linux-kernel+bounces-216021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D5C909A05
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 23:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E579D1C21391
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 21:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B1C61FF3;
	Sat, 15 Jun 2024 21:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aNBk28wX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A388F48;
	Sat, 15 Jun 2024 21:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718487254; cv=none; b=Xnj3NaD5rRcLCpb1rkvYOLJ26dyJAocqqIdVj9I3NTtL5UbKySl/0qMAEuhci7sUAqU8IyiouFtHdISvcBO28x7lQSWhkf2sZulWskbGVTtsYaxCZZnW4rSVgCuhF/HG8RN/STeIC00amwTMfPD65aXtRnNj6tK8lBy4X2q1+7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718487254; c=relaxed/simple;
	bh=eRJU09bP0cQH5HaBLi8EHIzusLgsK7lxMJg3wz5/nOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=kIv0pchgTQ0g+asg4P/yP0+a2OtGi4AfRbSoIFyNGsTS6PICfy2ThaGfqRrF5O5Vbo2FzO9FvbpgqNS3OUosJrzEWDZTHqIDcv7BQOGYMlSBnnrTCaEVZShB3RYJZIK0hXPtQlfTviDRlFwTdtxweXVEskOAjxqnHj4dJpDQvDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aNBk28wX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45FKt1ac010736;
	Sat, 15 Jun 2024 21:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XL5dreQrlr1cLZe7QnKJxL
	QFzdVrWYm7b2ULMUIwaTE=; b=aNBk28wXuXW9N3LoOrQ1kls/OoKDIbRdu46RSa
	rodoQM1SDBVxpwqkU2hk5OOE1UAozlc7sklMv/8dYrzL4a7vHCmpiwTNH/Gm93ga
	ws9HGC+FkdGwfYDouyLTrUyIcc6OZDvNT5L4LWrnKo7/k0dUWHUVXI5q8BAPJ3ZM
	lAjiJq8tSwFxl1uX13yoP9zuyBARVRyx6ck9p3mkhXWaq+Dr2j0XZHV5u2Pv3MNk
	jolh38A3fgVMpqstm1wcyKSyu3zR0mOO7bK2Wj8eImhnMtPSxQRSecjqLcXF9JIl
	F0dma/ZKFzI1ZsU6XooPsygvm2g2WnTkhCnNdGtR/eJHVd2Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys3639331-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 21:34:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45FLY9hU002074
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 21:34:09 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 15 Jun
 2024 14:34:08 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 15 Jun 2024 14:34:06 -0700
Subject: [PATCH v2] platform/goldfish: goldfish_pipe: add missing
 MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240615-goldfish_pipe-md-v2-1-b4323a969594@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAM0IbmYC/32OQQqDMBREryJZ95ckVotd9R5FSky+5oMmNlGxi
 Hdv9ABdPph5MxuLGAgje2QbC7hQJO8SyEvGtFWuQyCTmEkub7zgFXS+Ny1F+x5pRBgMCINa8sb
 kquIs1caALa2n8lUnblREaIJy2h6inty8wqDihOGIW4qTD9/zwCKO0p+tRYAApZtC5PJeyjJ/f
 mbS5PRV+4HV+77/APxvoaLRAAAA
To: Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1PftA1sDtwFZ7BMFAeTWA9gKft3__ude
X-Proofpoint-ORIG-GUID: 1PftA1sDtwFZ7BMFAeTWA9gKft3__ude
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-15_15,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406150164

With arch=x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/goldfish/goldfish_pipe.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v2:
- Rebased to v6.10-rc3
- Updated commit text to use a more recent boilerplate
- Since there are no matching entries in MAINTAINERS, added Andrew & Greg
  to see if this can go through one of their misc trees
- Link to v1: https://lore.kernel.org/r/20240509-goldfish_pipe-md-v1-1-acb513276263@quicinc.com
---
 drivers/platform/goldfish/goldfish_pipe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 061aa9647c19..c2aab0cfab33 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -946,4 +946,5 @@ static struct platform_driver goldfish_pipe_driver = {
 
 module_platform_driver(goldfish_pipe_driver);
 MODULE_AUTHOR("David Turner <digit@google.com>");
+MODULE_DESCRIPTION("Goldfish virtual device for QEMU pipes");
 MODULE_LICENSE("GPL v2");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240509-goldfish_pipe-md-1dec20bd3a90


