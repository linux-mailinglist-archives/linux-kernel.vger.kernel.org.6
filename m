Return-Path: <linux-kernel+bounces-249643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DC292EE2F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DCB1C2140B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2112216EB59;
	Thu, 11 Jul 2024 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n8ySceTx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76F416E870;
	Thu, 11 Jul 2024 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720823; cv=none; b=nI3jmTBHX8mAm9UyNGGglKwdIPTAB7yYYMwDWeOR6ylBtolj8PJSY+dS3ImkgpmzJT2oTrMzQ1Id1X5obruzaf/6SpCYelRRE0MuUsGcSkC9v/t2Cq6oT2lm8USX/9DETqyzIa+U540CB1BhZg5Bgw/z8tacPT2GanwcSsROAKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720823; c=relaxed/simple;
	bh=TiMKibYFLIqpKOzZI/Qxq1649SejuxuD1Q0Zim3d2ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=MzR0u6FOl4tTNYDrGh5pTeuG+BmAAzw6NUU3nS0PlkyIKfIdAYg/fuNKD5Qy3TGd8+VJbQXvIP9jNdo1nvaZDdHvBPuBaHDVRrIbu6El43l+LY7p8iBPm1G/1sWUaWCLkZLIY9Ygvdrj7802CwJI/H24htQkEZacEyQAxjghOiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n8ySceTx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BFmSig032636;
	Thu, 11 Jul 2024 18:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=N7nvtSWo9WWnfpuIwR7eOP
	es2K3UZsesR0FAqN+XzPY=; b=n8ySceTxPEhllQxusBNWI4Pifn6nyBWGrRjvQr
	mO5EBgkDYpgCEyK6C5yJkAKKW/sm6T0CH/qnjC3nAgS6LGcg0paqzAE5OHhNyCJ3
	3GjSa2mSBrpoMF1JUuslDKVjkBFZgBoKJNg7b82caZQu4p9+Chk24Ipo2/6PilKW
	g+rUVZgCOsJX1/4OWY2cXlJFEG18DM4Z9V/IVoaYTMFJOvcO0RPhjUCbmxFDGuVb
	HTnh3Sus/mxr+AU5TuGMTvEt1TyPXB0Ct9FYGHkyWB+7SrMNUSLtvFHjPZn0ryfP
	v6y7/CKb1qy7CVmUFS9ye7li70fkfMt0FFq/IG5Gki38l2rQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40ajbqr9yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 18:00:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46BI0Bo1015915
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 18:00:11 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Jul
 2024 11:00:11 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 11 Jul 2024 10:52:13 -0700
Subject: [PATCH v2] crypto: arm/xor - add missing MODULE_DESCRIPTION()
 macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240711-md-arm-arch-arm-lib-v2-1-ab08653dc106@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMwbkGYC/32OTQ6DIBCFr2JYdxpBbLWr3qNxATiWSQQtqLEx3
 r3oAbqY5H3J+5mNRQyEkT2yjQVcKNLgE4hLxoxV/o1AbWImciHzmxDgWlDBpTP2FD1pqDXvdCF
 lLQrDUnIM2NF6tr6axFpFBB2UN/bo6snPKzgVJwyH3VKchvA9f1j4Efo/t3DgcC8LVVVV2Sohn
 5+ZDHlzNYNjzb7vP3e/ZG3XAAAA
To: Russell King <linux@armlinux.org.uk>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bO-38yDT1daemt-Es2Lnkm9b3ZDwEg6G
X-Proofpoint-ORIG-GUID: bO-38yDT1daemt-Es2Lnkm9b3ZDwEg6G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=622 bulkscore=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407110125

With ARCH=arm and CONFIG_KERNEL_MODE_NEON=y, make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm/lib/xor-neon.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v2:
- No changes to the actual patch, just rebased to current linus/master
- Hope to have these warnings fixed tree-wide in 6.11
- Link to v1: https://lore.kernel.org/r/20240622-md-arm-arch-arm-lib-v1-1-753a8885da24@quicinc.com
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
base-commit: 9d9a2f29aefdadc86e450308ff056017a209c755
change-id: 20240622-md-arm-arch-arm-lib-9b1fb344923c


