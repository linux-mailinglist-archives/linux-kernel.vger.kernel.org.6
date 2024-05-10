Return-Path: <linux-kernel+bounces-175201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 390E98C1C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25A81F2355C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 01:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F0A13C8E6;
	Fri, 10 May 2024 01:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ob/HyBld"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D7E13B7A9;
	Fri, 10 May 2024 01:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715305490; cv=none; b=A5anhp5c9di4r+AR0EBiVLqpzAZUOkUjrzK4dQ/VFHqQFOHtBRc5D4OZlsLBjJsPSvTWsb62WgC/yteGOADLuAV3/t5b88zMErNmseRZSFywpnDbvG6v4tkdgc8a5kKggtnrKvFHG/9gphrW3Hd9WCli7O05P8wZY68zG+NAM/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715305490; c=relaxed/simple;
	bh=Z5zOkeaCJzSf4qW8zcrMf+qzgg5FfZa15nOgZLkWxwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=iBHhprqVnK1lrM+mZuEN+ycHTreX9t16Y78gFdPmspMKEN4XuZmybAyqGUOUBA/vKks38qtCnljZqSAtMheOuva7AdBnWB7YM0yAuwKzgBAqZRq20Wc3Lw1jlQYXQoBbgYjoHSZtRSsM1MvRPKzUfpbujsck853ecfpRHxH+vAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ob/HyBld; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A1B9U5023950;
	Fri, 10 May 2024 01:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=WEr
	kBehGRZvL1gta8obGebWnnhjP+Z4r5zimA1rTDBE=; b=ob/HyBldpq82e4aLxrQ
	g972I+8tmz3V+3cCJAR0qQBI6FtF+eTTurmGB2RhA1/rE4/nqQYdssRr+zb8fgnm
	D1iBeYxEYtsXzbUWtnFxZv87epDe/DH5g0XdrNScajLdVano9DDscr5KCdJYXQEc
	q/w8jN0hc92dmclY4iJN3YfmhXhBs6FjAgUNNrtyOO4zcljOvjr6CmvmnjCs7sGZ
	23W0Oo/BfLvBHWWRipqf7THcgCrQZeWFaSvssIRrl0J/0g5m1Sn4IImr/HHo1be6
	GrFF43myBwxiGVaaTHXIxY3P0tYpHElblpuvk+Y79NTX0uC14wDIU5c7VGeX9P1X
	2Kw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w0raf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 01:44:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44A1igge024784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 01:44:42 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 May 2024
 18:44:41 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 9 May 2024 18:44:41 -0700
Subject: [PATCH] platform/goldfish: goldfish_pipe: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240509-goldfish_pipe-md-v1-1-acb513276263@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAh8PWYC/x3MTQrCQAxA4auUrA2koy7qVURkftJOoJ0OiUqh9
 O6OLr/FezsYq7DBrdtB+SMma2noTx3E7MvEKKkZHLkLXWnAaZ3TKJafVSrjkrBPHB2FdPYDQcu
 q8ijbf3l/NAdvjEF9ifk3mqW8N1y8vVjhOL5vIsFJgQAAAA==
To: <kernel-janitors@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cBNx5G4JhF4Y5uckTK5biZKp5u8HlQnO
X-Proofpoint-ORIG-GUID: cBNx5G4JhF4Y5uckTK5biZKp5u8HlQnO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_12,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 clxscore=1011 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100011

Fix the make W=1 warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/goldfish/goldfish_pipe.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
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
base-commit: dd5a440a31fae6e459c0d6271dddd62825505361
change-id: 20240509-goldfish_pipe-md-1dec20bd3a90


