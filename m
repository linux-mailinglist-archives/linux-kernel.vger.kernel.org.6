Return-Path: <linux-kernel+bounces-218440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFF290BFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3091F2276B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF61199EB5;
	Mon, 17 Jun 2024 23:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IFHzQUEx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C21288BD;
	Mon, 17 Jun 2024 23:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718668033; cv=none; b=XeAXxEslkoV2d/MW1mvtzC9g/mYP8onB4bepJ1OznJHuNm2diEKIxdbD+1HjYsiobsoOX3uKB+JkEpThT2KgE1x9iQP4a81iQXoOHSrzviYivNIGdXSumLbsA9FO07YqLwwPr+GkUCy5iJm1DLLGg1wO0HmbZxsnqs26m7eI0BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718668033; c=relaxed/simple;
	bh=X69PeuIEgpqfq/kpUARttKZjeOQ4rtH1JUKDF4eHXO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=A3BsHPoDkhj6n3sva7JjCwxajRVe3s/EYGHsp1vZO4zrRGXRj7SnpTuayGlnGpFVaPxhFX7SnqN9kQNzFGSo+OoV99spuWyS81kTnjiViWbDIPsRRD8l4BgbU3RRgNwyNpcbdJ/kUn6cSMlk8/uqRkqif3PX/ZeDG2Oh0/1fcnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IFHzQUEx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HL5da1016008;
	Mon, 17 Jun 2024 23:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jDG0K+WOKw6f8MLeBYAaLB
	FQGctuL8ElU0BjDTIFv0s=; b=IFHzQUExqzXDe3HQIGnjVEgy58W3IOmr/YhIb8
	gc7T/BgXunVxv5pXSpGNgNKHxiN49GwPQhQ3mD6XhTPyWs/KQT4e/5S9s8zy8tdd
	n7dkUjZlaLAjDifVo/tPUK6wyg92oFTpEpCs+gdhJa6w9wOvTleknVsf47LMgSWR
	2fDxaiCEi41WU0ZMifX3aNrm2Lmqzot3hLabyy4enaCcG54fcHO2exEHTOQSTtRU
	cj4dk/KZzPDU//Pn5Y8PZZUdfy7UCjRFi6DL7ihI342N1hD3mCBLFkCo57YOzWCk
	V9CYyBmVaMdiTEghDXxEpePU/XiqiL9D0Tq1TBlHHCjvkz0Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys1wr50hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 23:47:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45HNl7Up014299
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 23:47:07 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 16:47:06 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 17 Jun 2024 16:47:04 -0700
Subject: [PATCH] m68k: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-md-m68k-arch-m68k-v1-1-57d38beaeb13@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPfKcGYC/yXMQQrCMBCF4auUWTuQxlLFq4iLyWRqBk2UiUqh9
 O6Nunvf4v0LVDGVCqduAZOPVn2Uhn7XAScqV0GNzeCdH9zYHzBHzOPxhmSc/stPnmnPPrgYoP2
 eJpPOv+b50hyoCgajwulbumt5z5ipvsRgXTd/Cl3ZggAAAA==
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: <linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K5e7IH_XCHppF4pzVv_S_5yyT5izCJ6q
X-Proofpoint-ORIG-GUID: K5e7IH_XCHppF4pzVv_S_5yyT5izCJ6q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=926 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406170183

With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/m68k/emu/nfblock.o
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/m68k/emu/nfcon.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 arch/m68k/emu/nfblock.c | 1 +
 arch/m68k/emu/nfcon.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/m68k/emu/nfblock.c b/arch/m68k/emu/nfblock.c
index 642fb80c5c4e..b35ac17e7ea9 100644
--- a/arch/m68k/emu/nfblock.c
+++ b/arch/m68k/emu/nfblock.c
@@ -193,4 +193,5 @@ static void __exit nfhd_exit(void)
 module_init(nfhd_init);
 module_exit(nfhd_exit);
 
+MODULE_DESCRIPTION("ARAnyM block device driver");
 MODULE_LICENSE("GPL");
diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
index 17b2987c2bf5..0ab2e4d08871 100644
--- a/arch/m68k/emu/nfcon.c
+++ b/arch/m68k/emu/nfcon.c
@@ -173,4 +173,5 @@ static void __exit nfcon_exit(void)
 module_init(nfcon_init);
 module_exit(nfcon_exit);
 
+MODULE_DESCRIPTION("ARAnyM console driver");
 MODULE_LICENSE("GPL");

---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240617-md-m68k-arch-m68k-2f2ca3c2b0db


