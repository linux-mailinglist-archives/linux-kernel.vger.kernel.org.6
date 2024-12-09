Return-Path: <linux-kernel+bounces-437090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDF79E8EF9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44FC188128E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7065216601;
	Mon,  9 Dec 2024 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="immPB09I"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FCC215F5C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737403; cv=none; b=KAC/xSYq9O6Ofv4spmoaF1oYhCoRRH0TgafRmsFkH4j7VlCZNZiy2wg9H54oieSJqdjYxt5UR41PDhsfhVFTvYfJ0KZ3j5/GDmUPY/9Q2KlFfAvT/JeGhFImg9wfSfqYXqlQnJayUl2yoHLqPB2aFYQWK2rVdX2sjxWREeB24js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737403; c=relaxed/simple;
	bh=ceP32PL92pkdUQjp3TpgjzwxacwAFCR4Kl52CphuMMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LSUkvNg+26q+WIgsimF+JCX5rF7b/E7oy9LjutRXOBsXcdT/D6AskpXDLJK7SmCughXdpaTou2gBXgB13YD+RketqMSQ3XLN7tLz7rzRrVOAP6rgbJNMMe6DuVOQPWlWZJuKC3RHSBbvSeu4oICjG7Nbeuil3dfeelkcNC6JVXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=immPB09I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8NkrgO019407;
	Mon, 9 Dec 2024 09:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tqbr13cTVpmFqpleZm78ZDOWuVR4wFo0Qdc8LscuVcA=; b=immPB09IHqdJ86ly
	Wt5sEZWvGhCy3KNGq40HOAuAcKo+CFcCg5agk6CeGJBseyHXs18IpTs2Yw96+HRJ
	/qNIyAry9Vj00yiPO+78nct5dI40owyBOnwYmERKtSEk9M0IHjMnqyNbQfViiIpk
	frhftXVoSs44Gw8MA+NWdBeOQoFiodZuZPq1ifoMkbbeXoj6Z+InNfDb7ETI8xj1
	qvsCfPwaiTQWcEi+qVfoqnS1mPUkJ11/OYkLtWTUvG9EacsEmRZrQVC7K0SuyUn9
	Ia6tGuR/LErbV3YG1Y4zALTxh1XG/7vjliIThRRpthLWbZLmRXSomB7lq5RUg4Q9
	wosV2g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cc2ecb4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 09:42:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B99guef019069
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 09:42:56 GMT
Received: from ap-kernel-sh01-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Dec 2024 01:42:53 -0800
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <ardb@kernel.org>,
        <ryan.roberts@arm.com>, <mark.rutland@arm.com>, <joey.gouly@arm.com>,
        <dave.hansen@linux.intel.com>, <akpm@linux-foundation.org>,
        <chenfeiyang@loongson.cn>, <chenhuacai@kernel.org>
CC: <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: [PATCH v2 1/2] arm64: mm: vmemmap populate to page level if not section aligned
Date: Mon, 9 Dec 2024 17:42:26 +0800
Message-ID: <20241209094227.1529977-2-quic_zhenhuah@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 4-q_SRzBcq3Y4hdw5tH8DRWs14OCq0fu
X-Proofpoint-GUID: 4-q_SRzBcq3Y4hdw5tH8DRWs14OCq0fu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=822 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1011 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090075

Commit c1cc1552616d ("arm64: MMU initialisation")
optimizes the vmemmap to populate at the PMD section level. However, if
start or end is not aligned to a section boundary, such as when a
subsection is hot added, populating the entire section is wasteful. For
instance, if only one subsection hot-added, the entire section's struct
page metadata will still be populated.In such cases, it is more effective
to populate at page granularity.

This change also addresses mismatch issues during vmemmap_free(): When
pmd_sect() is true, the entire PMD section is cleared, even if there is
other effective subsection. For example, pagemap1 and pagemap2 are part
of a single PMD entry and they are hot-added sequentially. Then pagemap1
is removed, vmemmap_free() will clear the entire PMD entry, freeing the
struct page metadata for the whole section, even though pagemap2 is still
active.

Fixes: c1cc1552616d ("arm64: MMU initialisation")
Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
---
 arch/arm64/mm/mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e2739b69e11b..fd59ee44960e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1177,7 +1177,9 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
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


