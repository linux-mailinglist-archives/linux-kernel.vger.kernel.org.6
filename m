Return-Path: <linux-kernel+bounces-225927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A094F913799
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 06:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E393F2832D5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 04:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D6D16419;
	Sun, 23 Jun 2024 04:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qzc/0253"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8969473;
	Sun, 23 Jun 2024 04:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719116378; cv=none; b=jgDW0hNIdywbnzuncg536aL5xVCj9knu9u2+BaIwsdH1xn7OQRD3zAtWHb3AHqLpS2uYBG2EBnyRnKAVz5QAjCbU9t0nshONHBjNki2dtGwhbdi6U2he3nrTtGb+krduUm9mQtKoVbGHc3vYv0y7Syr5DNS1TYvq7JM9t2UkUhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719116378; c=relaxed/simple;
	bh=ZX6xRyUedSav6yevYaJTlPiWZyWdal2dD3pkCTH8nrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=VO2PkT4sfIFII+5F80B8s8+ctzYCCru7FJeza+jonmjqX9aB4KXX0FD1gD7/NlMm18p177h18X72FTXoJXYiMz6OkqE4knhfSq/5NPsXyBOeEWd1SxMKVzGu03bqtTH8gLpg/4E4k2ThXqJkILaqexBGdEi00U0FhVKA7MjWEec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qzc/0253; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45N3359x027614;
	Sun, 23 Jun 2024 04:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wEz3z+/mJ/0BVpG/LmQvMe
	EhE9kS3R/QfuAjEgIXPdc=; b=Qzc/0253j7EetjW1IC3BBGkGKfqd1raqmngk0v
	fuBqz6IG0mlbbbplwDWwPMglqazm8oJ6KgOOObP4++il3Pwre9XR4WInxVmKIU71
	CMThIOZ/dJGetAe/x6D6r0Gq3wXCGxBkplhe6zxS7GuoG2X+N4ha3oGa/ZxMCCpB
	K3SOGsm2BSgr4JTEfkUxWHBkmbHR11G79RrFlvV88aHEpI7o8F8l1o/H3XHO6gor
	5wGAyfSzspZC9YvK1FY3b2bDERK/pdk4mGxy055hrS22B6VJh7I2ynbRrsqzRIja
	GETfbgp3JljFNbeQieIeJfaOOsKJ30dvTZ0pSCJbo0vjvcJw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqw998rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Jun 2024 04:19:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45N4JRsl014458
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Jun 2024 04:19:27 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 22 Jun
 2024 21:19:26 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 22 Jun 2024 21:19:23 -0700
Subject: [PATCH] crypto: arm/xor - add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240622-md-arm-arch-arm-lib-v1-1-753a8885da24@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAEqid2YC/x2MQQqDMBBFryKz7oDGULBXKV1k4tgMmLRMqgji3
 Z26+PDf4r0dKqtwhUezg/IqVT7FoLs1EFMob0YZjcG1zrd35zCPGDTbYrrOLIQDdRP13g+uj2D
 mV3mS7ao+X8YUKiNpKDH9W7OUZcMc6o8VjuMEvnPBf4QAAAA=
To: Russell King <linux@armlinux.org.uk>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: soE3_H0FqfMlb1lpcaWiNILIWdLq86tl
X-Proofpoint-GUID: soE3_H0FqfMlb1lpcaWiNILIWdLq86tl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-22_19,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=594 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406230032

With ARCH=arm and CONFIG_KERNEL_MODE_NEON=y, make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm/lib/xor-neon.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 arch/arm/lib/xor-neon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
index 522510baed49..cf57fca97908 100644
--- a/arch/arm/lib/xor-neon.c
+++ b/arch/arm/lib/xor-neon.c
@@ -8,6 +8,7 @@
 #include <linux/raid/xor.h>
 #include <linux/module.h>
 
+MODULE_DESCRIPTION("NEON accelerated XOR implementation");
 MODULE_LICENSE("GPL");
 
 #ifndef __ARM_NEON__

---
base-commit: 563a50672d8a86ec4b114a4a2f44d6e7ff855f5b
change-id: 20240622-md-arm-arch-arm-lib-9b1fb344923c


