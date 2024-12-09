Return-Path: <linux-kernel+bounces-437088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FB99E8EF5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31811639A8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CE1216385;
	Mon,  9 Dec 2024 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c1hrRAJJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDCA215F6B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737401; cv=none; b=gRhe52Ufz2ol+wmkxTssbuZwZ+56XPoGImcu/vsm26ZQMUle/0kPDmvPG8SPo+ZVLV/rhewhD6rB1RapmcSBUTSKHTrWlGYRlj/CsLunmUcNsZ6mD0OqFV7i7IxbFST4o113GckwbUZy7MpaTyHlVAg6ibDbJh7DRKP6OOWT0Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737401; c=relaxed/simple;
	bh=D+vcjVldC4eAxQxgzHYCLWc5NJVuxFO7b0LK3dgolQM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqZ2G0AWjuV9f478onONRz6v6f4NleHSLs+j//6IZuJWlVjEEEvGQVuNmRAk7bxLn4M1wvuEBDaxIGnEXaM7jo+XfU1ZrzeY55mBoSOsshjScHJR0PXJ8hGq6toNYe94hqbXVPSNlYI1QuJqO+TpgaMgc3xfC3i4MFvO/55dKeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c1hrRAJJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8MMWYR012704;
	Mon, 9 Dec 2024 09:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LtABRAQ0YEr/CI1X8BieMgHVTu9h5oCNjef5fZpS0XE=; b=c1hrRAJJUL8NJMcq
	bM+hWcCgUlXoeumzTI0rTfVNnCGanA1GHZUX0iaNAVx0gTD65t7S2hVMHqz/1228
	dxZWbR1IC0FpQGAERJJdktQWQDsyF0F5i6wFdOgAODynMMZvo+mtumH+Q2NXpomQ
	FXfo3RfJbC2L7C9TBvfRz+7QpoiZwP0jDDftWf0hXY0xkjTfwmRWnu1Ra+Z62SgJ
	7lS3wvzcfqJbggRwcMEsoh648vPKW9STcPvOHllQGBN14YKsCcA4uR468o5wsBG2
	dcxSyy195O1lQyHJPTVumAWygsFdC3PEVuGLXChRKtJ+fvedB93NbkGUWuHVKh0k
	4yPoKw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ceetm41g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 09:43:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B99h322017647
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 09:43:03 GMT
Received: from ap-kernel-sh01-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Dec 2024 01:42:59 -0800
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <ardb@kernel.org>,
        <ryan.roberts@arm.com>, <mark.rutland@arm.com>, <joey.gouly@arm.com>,
        <dave.hansen@linux.intel.com>, <akpm@linux-foundation.org>,
        <chenfeiyang@loongson.cn>, <chenhuacai@kernel.org>
CC: <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: [PATCH v2 2/2] arm64: mm: implement vmemmap_check_pmd for arm64
Date: Mon, 9 Dec 2024 17:42:27 +0800
Message-ID: <20241209094227.1529977-3-quic_zhenhuah@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241209094227.1529977-1-quic_zhenhuah@quicinc.com>
References: <20241209094227.1529977-1-quic_zhenhuah@quicinc.com>
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
X-Proofpoint-GUID: gs-sJae984RW_OSNds3kolLIBqleNwa7
X-Proofpoint-ORIG-GUID: gs-sJae984RW_OSNds3kolLIBqleNwa7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 mlxlogscore=497
 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090075

vmemmap_check_pmd() is used to determine if needs to populate to base
pages. Implement it for arm64 arch.

Fixes: 2045a3b8911b ("mm/sparse-vmemmap: generalise vmemmap_populate_hugepages()")
Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
---
 arch/arm64/mm/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index fd59ee44960e..41c7978a92be 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1169,7 +1169,8 @@ int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
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


