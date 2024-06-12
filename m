Return-Path: <linux-kernel+bounces-212228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5C9905CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E4D6B2444F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0570C84E0A;
	Wed, 12 Jun 2024 20:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SKtVbsJZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443AE84D29;
	Wed, 12 Jun 2024 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718224510; cv=none; b=Exrm+dIwQwMWveq5+4pGFwmUDbUGYqXMthOz0vOEOCpl+bP+GJPkeKwt/Sa/ZknNYaV2toWC8x6jJ7oSNPcnMIZpnUal1q+1GC18NYFRhqsMQAffIlwtLAdig8l8/s+y+88fUBbrnxiA1wqwugyk5qfthQfu61FmFJ0V9sSEovk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718224510; c=relaxed/simple;
	bh=L/2EIoZ/+vwHw6uSyi6cUEoLIqe5+OV0+uzzq/20Tfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Fy7Q54c/RMhfjlXxlpE21u2Mkq4LmreYSL7bAi7PDYR+sdJbz0i8e6l/uxA5TYvtBILQK58IkDQpaPPNRPO5Kgp/sOgoPcK7qczkdPLhdjcOr4cE+llsuxmozgT7j6q+U3E5S4UNMMYUkDz63AOS5fLQLgh+tyD6y5zGjK3SvMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SKtVbsJZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CGOQpn008296;
	Wed, 12 Jun 2024 20:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OmxBAyyWG3YkdYQ7UWbmkd
	Z3ASpIZSZ23s/j9DiPjSA=; b=SKtVbsJZxNhbL7J6K/pNFrNFgw2rmMO20xPvo4
	y7V28CAwb17SPTRqiW679HyPfY+VX9oU9OGeHuRCFJkZ+Zy449vUQslsPzzxyONn
	QH617swy+EgdUGaH0QoZbfrLbxxMythD2mv67AKfxeg4mto2bqHKryhMttnvgyAc
	vmOPEf6AtRQ08+sm0IOswMmWLrTM8zEQk3aeG13DUMV/CJeiGxQYkUWAvLxtIFqA
	kopIxsvC5EjNli/MiTrjwSTWGVJh8DKS24nxyZ73BAYoYX5arnQ21ItqKzBwWU8R
	nbkE4GeLV+ljcUr/Rrn7QOk58eZhD7v/XdnK2ffJoYWNgSmg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yps5xbbpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 20:34:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45CKYwkp009622
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 20:34:58 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Jun
 2024 13:34:57 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 12 Jun 2024 13:34:56 -0700
Subject: [PATCH] ARM64: reloc_test: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240612-md-arch-arm64-kernel-v1-1-1fafe8d11df3@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAG8GamYC/x3MQQrCMBCF4auUWTuQhjYWryIu0mRiBpsoMyqF0
 rubunnwLd6/gZIwKVy6DYS+rPysDf2pg5B9vRNybAZr7GBcb7FE9BJym+IGfJBUWnCa3BgdnUN
 KBtr1JZR4/Wevt+bZK+EsvoZ8xBaunxWL1zcJ7PsPDShCRYUAAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LLWG6yMqIGgXcxmm4lrbe7R3YyvbR2VF
X-Proofpoint-ORIG-GUID: LLWG6yMqIGgXcxmm4lrbe7R3YyvbR2VF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_10,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406120145

With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm64/kernel/arm64-reloc-test.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 arch/arm64/kernel/reloc_test_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/reloc_test_core.c b/arch/arm64/kernel/reloc_test_core.c
index 99f2ffe9fc05..5b0891146054 100644
--- a/arch/arm64/kernel/reloc_test_core.c
+++ b/arch/arm64/kernel/reloc_test_core.c
@@ -74,4 +74,5 @@ static void __exit reloc_test_exit(void)
 module_init(reloc_test_init);
 module_exit(reloc_test_exit);
 
+MODULE_DESCRIPTION("Relocation testing module");
 MODULE_LICENSE("GPL v2");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240612-md-arch-arm64-kernel-8865d6e7cff0


