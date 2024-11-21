Return-Path: <linux-kernel+bounces-416638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E989D481A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10931F22B69
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 07:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C06E1CB30F;
	Thu, 21 Nov 2024 07:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RZAcPA2S"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CED1CACFC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732173283; cv=none; b=L3s6HnZSq9cc0/GLaUvNaPdEiRy1l1Sv/q6eFEm7YnclJqTPGcjlb++U8COLQNt0leekSdq9wyW+m8I6d3+hzoPRe1FwiK53wPshW8mREkxj38J/+C+cV8L+kzsQ84Oq1dgN+83lFLQkgIhFPduh2+oMmanZhoNBB5H46hN/eY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732173283; c=relaxed/simple;
	bh=A2FtbPtBgN4HAZMhc5C8majeKL2JPC2VrwbziCu3Djk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agHVpQNCdU40Q7NJJr8qMJmwj0ll/1j4O2l3YkMBBU5avEXGC3TtuX7qZYTRDqdHTYWy9/uLTyGTKTCTF64C+AuUzg0/3RMje/Z5+YcihHhgMLPFBRgn33tzGdmI+C86223Z/qS3iL/gIHUzEriy7jrFsSiPfxtZWzT5vbymq8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RZAcPA2S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKLAvTZ029738;
	Thu, 21 Nov 2024 07:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5vkRCAdghAGV/OZOlixTRMei5ZBVvBmCuVWIGEfSSu0=; b=RZAcPA2SVXaUaFkq
	/1rMx9njFLozm9kqShP8EwrwvTdZ3yyW1dPKFeWLm5t+yVu8bU9lCHNVpcLUCW3y
	E/nXNSozVm/yFkJJfaOFt7ku/939OiMlcu6kMXUgmHkbPwi/GvJsp8vtZZSyAazk
	zX/Sue40Fn80Mllo2DEo47ShsexCCHNihyfvtkhz9hGNwbiA9maGumwxeQ01A3u4
	MebPnOMckZz6GX5QbmZG990rwURMG+x67M9Su67dwmklzG72hS1/fIev7ZJdmxYS
	u4UIVCAz5e/eNmiu2ayr7RuS9Yg+vNSVAclb3ypVXINrWHDolo9JyEOkr8DM5DO4
	u+oQtg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431952bjcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 07:14:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AL7EQNh022335
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 07:14:26 GMT
Received: from ap-kernel-sh01-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 20 Nov 2024 23:14:22 -0800
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <ardb@kernel.org>,
        <ryan.roberts@arm.com>, <mark.rutland@arm.com>, <joey.gouly@arm.com>,
        <dave.hansen@linux.intel.com>, <akpm@linux-foundation.org>,
        <chenfeiyang@loongson.cn>, <chenhuacai@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: [PATCH 2/2] arm64: mm: implement vmemmap_check_pmd for arm64
Date: Thu, 21 Nov 2024 15:12:56 +0800
Message-ID: <20241121071256.487220-3-quic_zhenhuah@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241121071256.487220-1-quic_zhenhuah@quicinc.com>
References: <20241121071256.487220-1-quic_zhenhuah@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: r26VgHDOWkqgknP0jjAujSu1yuk8ENqN
X-Proofpoint-GUID: r26VgHDOWkqgknP0jjAujSu1yuk8ENqN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 spamscore=0 malwarescore=0
 mlxlogscore=520 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210055

vmemmap_check_pmd() is used to determine if needs to populate to base
pages. Implement it for arm64 arch.

Fixes: 2045a3b8911b ("mm/sparse-vmemmap: generalise vmemmap_populate_hugepages()")
Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
---
 arch/arm64/mm/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index bfecabac14a3..0e19dd1cfc0c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1143,7 +1143,8 @@ int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
 				unsigned long addr, unsigned long next)
 {
 	vmemmap_verify((pte_t *)pmdp, node, addr, next);
-	return 1;
+
+	return pmd_sect(*pmdp);
 }
 
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
-- 
2.25.1


