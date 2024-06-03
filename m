Return-Path: <linux-kernel+bounces-198553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D048D7A2C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 04:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032C61F21318
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 02:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045F3BE48;
	Mon,  3 Jun 2024 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iVLyEF3u"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ED45250;
	Mon,  3 Jun 2024 02:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717383031; cv=none; b=cJt6K51iXK+k2HZy0G/TX84zeNCSmx1Pi9COn9hxlOxfJ7kt5AAMs8vel57BgFlpHrizz31JTFuGTu8PjJwDLg9xeByicyfPSVfTCViRkYqdg6Y/WgIOsJwsl79DncQEHJIiCNPBFYlpFgHE7MTNbycRf58zohiJ9qiIkWBdqZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717383031; c=relaxed/simple;
	bh=6uvSY3SwAc38IQogftaZ7RpTV6ON0Jubfb3GR7ZfSHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=oL+deSSoPsyqs5KPqp1phBBMVLatgpeWyFF7MEt+etqzuMHfEBMPIV0uOlJ3iCvy761DmScEG37ikbTLsmahYlR9uxDitX1rhW/SibqYipoW+v0hdUs3a36cMKZQKdY4ChK6B3v8LgpzXIa1ifOHumPL8aJNs1s+OzoLsiRJiY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iVLyEF3u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452NdYBw007549;
	Mon, 3 Jun 2024 02:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AyV4HEOEcvfq3ISoGaKKge
	6HVEEr9S/6kBh7HMdcDRk=; b=iVLyEF3u53bcfn8LfQVj6HONsXMVbjR/M1lRfo
	flSwTeiLpd1PLXdTKjkqvCSDTHx9GsyF9pnCJU7Nv5TO3ydt+XrelC7WZY7ivcIy
	A9Dk4Bv4T7SpTSdZWt6Fg/Iwd0xrAJ5d09hT5svY22OYhl6zrEoY9bYyQcxE+mht
	nvriAJ3LsliaayjhfSVMgHajlfWdJ0y27iR6Kbso/0uYIUUykiQFDD/eLzl/NVkv
	2N3fUm8KvVFqRUo0hizD81p/hgLDrx/n7ZDoNrbeug0l8tjSPfneivD1BSOclsUo
	HOaED+PFqOcd58O4XtdwMEVXziGhx1HQgU6p5d1JjNPzMCQA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw6qjsyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 02:50:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4532oHnn030908
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 02:50:17 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 2 Jun 2024
 19:50:16 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 2 Jun 2024 19:50:15 -0700
Subject: [PATCH] auxdisplay: hd44780: add missing MODULE_DESCRIPTION()
 macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240602-md-drivers-auxdisplay-hd44780-v1-1-0f15bd19f949@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGYvXWYC/x3MwQqDMAwA0F+RnBeopVjZr4wdUpvNgHaSTHGI/
 75ux3d5BxirsMG1OUB5E5NXqWgvDQwjlSej5GrwzgfXOY9zxqyysRrSumexZaIPjjmE2DuM3KV
 +6PrWxwj1WJQfsv//2706kTEmpTKMv3WSsu44k71Z4Ty/mWVU3o4AAAA=
To: Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _V14EhOMqn0F1e0fHOkE3NY3OUZp2kmF
X-Proofpoint-ORIG-GUID: _V14EhOMqn0F1e0fHOkE3NY3OUZp2kmF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_15,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=934 clxscore=1011 impostorscore=0 malwarescore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030024

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/hd44780_common.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/auxdisplay/hd44780_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index 7cbf375b0fa5..4ef87c3118c0 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -366,4 +366,5 @@ struct hd44780_common *hd44780_common_alloc(void)
 }
 EXPORT_SYMBOL_GPL(hd44780_common_alloc);
 
+MODULE_DESCRIPTION("Common functions for HD44780 (and compatibles) LCD displays");
 MODULE_LICENSE("GPL");

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240602-md-drivers-auxdisplay-hd44780-7e6b8c681277


