Return-Path: <linux-kernel+bounces-416637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF5C9D4819
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57ABAB228E1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 07:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D585E1C9EB9;
	Thu, 21 Nov 2024 07:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="euIIBenF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C593C1AC8A2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732173279; cv=none; b=P7Z+aknrmyIDRifMy6BiyMCNCzLnv6qaF5hDXwDerJcoqQaSwQIu2EJP7OAI2t3zot7cpMoRnhV6XG3B+cs5d/MUNGrs3NloNjgz8bwbxMidId63SESQwyifJKmBdCFZ3+Pl6UH7F8Yw49GkruKwAY/tfEWK5TBOwBNDozvxDVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732173279; c=relaxed/simple;
	bh=+JWqziP4e5rNaZkzgnHdCfi36oftOsrB4dELXey8NDs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjY2L7vJWxIreOlZaqkIvn2RMXDCRtoDVQdXoRnnQlRHfjbPGxGVJ6VNwDVu5HlrajUMOxLrBVaFj9RbcnBkRGzkIN9DaV8hlEX/WRkKY4xitL0LZnzjvEIdIWCjkyceUfSQj4l9jjGGhDTm0IcYETsuDWtiup9RQ8QsiLV6dmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=euIIBenF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKKUwIp005740;
	Thu, 21 Nov 2024 07:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FOt8Tph16p04Omz7b7mGpae+/rWzmu36AlaD6/cvlhw=; b=euIIBenFgTz72M9w
	B/LK2/MbUXcO+H/UQRnhJV+WOxEa7SgGEMShfEOA6EBJknyPxnxFA/p0hfNbf2Cl
	8Gua8hFjq1u5chtCXs3+Df/5nG2GVIFNOIs7CKwx6kM395m/NzRkdCND95GEPbKW
	pV8bb7ovAG6ikIEOF48EJTIr2FRUIFSSAcg3ZU+xr8TyuvRTc4Hulu8OPrj3gLMY
	1aQnzS7u9qZv0Iy+zHBKjRmVbUdZqTDJewpVsc/vbo8aXSyC4GIwADCMQjq0PeoL
	cYnMTU4rj5EHwsoezyZmk58C3YpLOTQWmTM6jizHrpbAFgmeDqwqsmsHvWPWXbhC
	EvLbkQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y80bh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 07:14:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AL7ELXk026361
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 07:14:21 GMT
Received: from ap-kernel-sh01-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 20 Nov 2024 23:14:17 -0800
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <ardb@kernel.org>,
        <ryan.roberts@arm.com>, <mark.rutland@arm.com>, <joey.gouly@arm.com>,
        <dave.hansen@linux.intel.com>, <akpm@linux-foundation.org>,
        <chenfeiyang@loongson.cn>, <chenhuacai@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: [PATCH 1/2] arm64: mm: vmemmap populate to page level if not section aligned
Date: Thu, 21 Nov 2024 15:12:55 +0800
Message-ID: <20241121071256.487220-2-quic_zhenhuah@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 05MIabgfrqLIVwvVciH3LHE5dZLJeXE-
X-Proofpoint-GUID: 05MIabgfrqLIVwvVciH3LHE5dZLJeXE-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 mlxlogscore=895 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411210055

Commit 2045a3b8911b ("mm/sparse-vmemmap: generalise vmemmap_populate_hugepages()")
optimizes the vmemmap to populate at the PMD section level. However, if start
or end is not aligned to a section boundary, such as when a subsection is hot
added, populating the entire section is inefficient and wasteful. In such
cases, it is more effective to populate at page granularity.

This change also addresses misalignment issues during vmemmap_free(). When
pmd_sect() is true, the entire PMD section is cleared, even if only a
subsection is mapped. For example, if subsections pagemap1 and pagemap2 are
added sequentially and then pagemap1 is removed, vmemmap_free() will clear the
entire PMD section, even though pagemap2 is still active.

Fixes: 2045a3b8911b ("mm/sparse-vmemmap: generalise vmemmap_populate_hugepages()")
Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
---
 arch/arm64/mm/mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index fe833de501f7..bfecabac14a3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1151,7 +1151,9 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 {
 	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
 
-	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES))
+	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) ||
+	!IS_ALIGNED(page_to_pfn((struct page *)start), PAGES_PER_SECTION) ||
+	!IS_ALIGNED(page_to_pfn((struct page *)end), PAGES_PER_SECTION))
 		return vmemmap_populate_basepages(start, end, node, altmap);
 	else
 		return vmemmap_populate_hugepages(start, end, node, altmap);
-- 
2.25.1


