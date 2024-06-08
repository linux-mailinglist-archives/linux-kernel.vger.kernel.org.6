Return-Path: <linux-kernel+bounces-207133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69FD9012C1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 18:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1C8282405
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 16:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5539117B4F1;
	Sat,  8 Jun 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HNaoG582"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374DF1E888;
	Sat,  8 Jun 2024 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717864309; cv=none; b=C8Q5U/te3fD77pq+UtVuoYJpEoOnp7wQBM8ApJRJmRQMTmqV3/fHg5zNJ95fZ6YZ/MwV79W72b0hUtJxRXxYHbzsH4EkRi4acFLUPgQss+fqQRDz/f/6wa0oPqCBNo0viy7c18cqpqbQKBnOLYaE+iEuvDX75VT/qRoqLlE/o4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717864309; c=relaxed/simple;
	bh=dzIhkuinC2M3kjTBzjU1/eeINliwXE3DjZLHluC8O58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=RMSNRpBazs77QngiybsFNpHD5iYW8GNku1jN09jGczmOjXJJLjU1blGI8hapnaTuBGiFI8sV66+0AHdrqIgvhgJ5P62kTDxKUukpRg3XuCHUW440naWqaov6/vp/6Z1YZmTDB4wV34A3LOmBcdMzvarH+bKh6PZDZ6DP8d4jKz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HNaoG582; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 458FkEHQ020933;
	Sat, 8 Jun 2024 16:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=536ZuBV5Xko30Q9QMlfsPn
	5bbVS/iTQ4a8HbJhBdSFI=; b=HNaoG582wKFtHPPjR/c2amJbmbFW02g5F18ybt
	4JZKO4mSYkPEXG0zX5U5NyCJF27w7dGkpZj5lcOqvXg6Ja+QRu3ZAen/+lkryHuZ
	0t+2NURJx7LVWDwLJIy01mj1Lds+AzzJfjfvFlbNS3l6JYJ67DW9biFCeX1EeKZc
	k4W+F+pw33pTfuOxuwyxg3R/aLNkjDUNkhGsJUQThxBO3JzJZVqMH9ctC8soMOP6
	SdQ0g5oKO+okI/zT0RoxsCMtwbGloDBECxsIhu1OG2e2CNmd4mh9IU0wWPfeTzVA
	hzxHBbPqg9FfOScyrbwCJc9jlOjU1FNqJKIY8yi05b/e23RA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymgk8rn07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Jun 2024 16:31:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 458GVeI8018130
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 8 Jun 2024 16:31:40 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 8 Jun 2024
 09:31:40 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 8 Jun 2024 09:31:35 -0700
Subject: [PATCH] mailbox: mtk-cmdq: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240608-md-drivers-mailbox-v1-1-6ce5d6f924ad@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGaHZGYC/x3MTQqDMBBA4avIrDsQf5DSq5QuksykDmgsM60Ex
 Ls3uvwW7+1grMIGj2YH5U1M1lzR3hqIk89vRqFq6Fw3uNHdcSEklY3VcPEyh7VgH6lvE6U4hBF
 q+FFOUq7p81UdvDEG9TlO52qW/Cs1ti8rHMcffDtjaYMAAAA=
To: Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger
	<matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>,
        "Jeff Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sgnuojmQtyHcFGj8RcGnPU-sjzXGdcTN
X-Proofpoint-ORIG-GUID: sgnuojmQtyHcFGj8RcGnPU-sjzXGdcTN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-08_10,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406080125

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mailbox/mtk-cmdq-mailbox.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 4aa394e91109..8247584bcbeb 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -790,4 +790,5 @@ static void __exit cmdq_drv_exit(void)
 subsys_initcall(cmdq_drv_init);
 module_exit(cmdq_drv_exit);
 
+MODULE_DESCRIPTION("Mediatek Command Queue(CMDQ) driver");
 MODULE_LICENSE("GPL v2");

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240608-md-drivers-mailbox-3cd31fdfc4b6


