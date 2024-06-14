Return-Path: <linux-kernel+bounces-214347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E920908324
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC0A1F22CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447A01474B5;
	Fri, 14 Jun 2024 05:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Nw35y4dI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE6412D760;
	Fri, 14 Jun 2024 05:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718341277; cv=none; b=Qx6Mc4cOj2xYDLwkQWRdZK0m4k72h2cWXYuKcMtxprUMhf2E/1VrkS+twHUEReDTJvtzn3RyXar+UVr8KkodLqc67MWQXUZji8eC0a3HP5cW5/sh5qkwcRdZuyknDLhmGdaBKYH6nTIeo1uDARtEaqXF2JEuUIaNnGE32MirUmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718341277; c=relaxed/simple;
	bh=ZlzRwORiIRa7LXIyIWrp20CjAwTwiOrlERvYRnJNsNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=VIQ9xgY6JAjLIdLSrKroKUBuboKiWyYS+V+AA4S1VIuBSF4sPXi0ikgVs+z0UGrXWqwb1QQWnzIw0mJi+5ySEydphfegwMKuBYkkP/ap447whD30Bf3+uO87DSXjaZXxNVaUdIYed76FejT9VfjlQLfA0r26KnphOHIoNV7N3Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Nw35y4dI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DJGWg7031852;
	Fri, 14 Jun 2024 05:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZlzRwORiIRa7LXIyIWrp20
	CjAwTwiOrlERvYRnJNsNQ=; b=Nw35y4dIebxB4jp6zHMtt2M5Db303Eth74qQmX
	aigtLIjRk/DxWvNM4XK5VnMRyOdiuCmF4eCBUtdEpBDVioK8BRd3Wdwaq+rKoghc
	YnPRtG49A/lXW0Yu3j1mRNATcf3LyCmEYHnkgZKY8Jv0CwrQzZ/7J/XYOfPTkPz8
	pI0+o4ILP3uSiJXVy68rai7+W0IpFG5mCgbaXzR68XfqbJrV4r8DSq9E8jct5O80
	5fmrypZRZzDshC15Tvqc9zKi/5bSthOEQdBlpm7GzqTG19yG2umR9TLLawNCkP0Z
	XEnuFgE6Pm3n2hO6igQuwB/uiijA+3XDGMTLd7NjJj1C5Zaw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yr6q4123e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 05:01:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45E51BWB013740
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 05:01:11 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 22:01:11 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 13 Jun 2024 22:01:09 -0700
Subject: [PATCH] lib/zlib: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240613-md-csky-lib-zlib_deflate-v1-1-83504d9a27d6@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJTOa2YC/x3Myw6CMBCF4Vchs3YSLvX6KsaQaTvIxFJMBwlKe
 Herm5N8i/OvoJyEFS7FColnURljRrUrwPUU74zis6Eua1MeqgYHj04fbwxi8ZOn9dwFmhj3hsg
 0R+dOZw/5/kzcyfJPX2/ZlpTRJoqu/wWDxNeCA+nECbbtC6PUNVCJAAAA
To: Guo Ren <guoren@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-csky@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lOH4G12Yy4EzYuEHmPxF4lAiQLdm6CwH
X-Proofpoint-ORIG-GUID: lOH4G12Yy4EzYuEHmPxF4lAiQLdm6CwH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=743 suspectscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406140031

With ARCH=csky, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/zlib_deflate/zlib_deflate.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/zlib_deflate/deflate_syms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/zlib_deflate/deflate_syms.c b/lib/zlib_deflate/deflate_syms.c
index 24b740b99678..68941a2350ea 100644
--- a/lib/zlib_deflate/deflate_syms.c
+++ b/lib/zlib_deflate/deflate_syms.c
@@ -17,4 +17,5 @@ EXPORT_SYMBOL(zlib_deflate);
 EXPORT_SYMBOL(zlib_deflateInit2);
 EXPORT_SYMBOL(zlib_deflateEnd);
 EXPORT_SYMBOL(zlib_deflateReset);
+MODULE_DESCRIPTION("Data compression using the deflation algorithm");
 MODULE_LICENSE("GPL");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240613-md-csky-lib-zlib_deflate-54aa437cc89d


