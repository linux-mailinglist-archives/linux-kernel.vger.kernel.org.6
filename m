Return-Path: <linux-kernel+bounces-517266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DE2A37E74
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F85A1889D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAF8212FBF;
	Mon, 17 Feb 2025 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O6yFe/aE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98CF212FB8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739784594; cv=none; b=Af7prLv9DMgSb7YIJCY+CqSwXsVQ20DjyN5pnEhs5XOi8+hvQg6IMeoPXSDSNt4MbOWBXSjul+yRQdtChu7yZdMiyDmqFz5IT/4Qj1b2G79FPHTURn8YNLCNZvqzYkEGrqaLiO/eKkhK0hUw2KqLd/gPPgnMOMUT3MSxC7XSHJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739784594; c=relaxed/simple;
	bh=VzZYmy8HCIEE2iVfSEctYcgto2oodrX1SXR55rravXk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XuztDWlU7ioG/ycAIdh0U1lvXj4jmR/DlvpL9FavLNE8Uiq5OvQqCTmBRKxNe8zqTB3vC1SbNN1rc/D4zB9L1EH8aAGj6BKYz9SX/8x1kNSQGslwKcj8qkWBIbyGyjgHbxHxYo8nqTtsOzjVfKH3eMqT1C2WxQKrFCsCka+Hoqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O6yFe/aE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H034L8022247;
	Mon, 17 Feb 2025 09:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MMb+tLlYn6VHNWNF2n/4Z/
	lgRcF295GIGpb11Gobqag=; b=O6yFe/aEeENcOhSuFPpJ3DsB3ITW/m+5/wmpoo
	GmJ6MA0nX8NiDG7XCKFy/t1s1pJR/GoMKSDmEmf7bZq83ogmhwMuqNgTydhasFSw
	kTc1bLYe1H6yTdlwwMU8Op8K/5SmjaRhH9Ha7lcCWjYEk/8ZA18kHFByykIjxP41
	UV4dT5D4FS8r2B22TQGCaxtuVpps4iE4MlKQudMoYwvBp+dtJC08G8LGREGmo6nj
	NVrDt6/FJ1rj0BrWVF1MwCYzNlwLTeHlRZjtSOVGSlOVCgtBg/Uw/1O6cx0hB28h
	FMiQ/b1xMuekjRyzz3rc7K9Q0mZYkDmduCxxnHYE4ofBHFug==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7u955s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 09:29:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51H9TO53004284
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 09:29:24 GMT
Received: from ap-kernel-sh01-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 17 Feb 2025 01:29:20 -0800
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
To: <anshuman.khandual@arm.com>, <catalin.marinas@arm.com>, <david@redhat.com>
CC: <will@kernel.org>, <ardb@kernel.org>, <ryan.roberts@arm.com>,
        <mark.rutland@arm.com>, <joey.gouly@arm.com>,
        <dave.hansen@linux.intel.com>, <akpm@linux-foundation.org>,
        <chenfeiyang@loongson.cn>, <chenhuacai@kernel.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_tingweiz@quicinc.com>,
        Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: [PATCH v7] arm64: mm: Populate vmemmap at the page level if not section aligned
Date: Mon, 17 Feb 2025 17:29:07 +0800
Message-ID: <20250217092907.3474806-1-quic_zhenhuah@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZOKV0jmXvUiSquowFIyeXjllNSgPbq_O
X-Proofpoint-ORIG-GUID: ZOKV0jmXvUiSquowFIyeXjllNSgPbq_O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_04,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170083

On the arm64 platform with 4K base page config, SECTION_SIZE_BITS is set
to 27, making one section 128M. The related page struct which vmemmap
points to is 2M then.
Commit c1cc1552616d ("arm64: MMU initialisation") optimizes the
vmemmap to populate at the PMD section level which was suitable
initially since hot plug granule is always one section(128M). However,
commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
introduced a 2M(SUBSECTION_SIZE) hot plug granule, which disrupted the
existing arm64 assumptions.

The first problem is that if start or end is not aligned to a section
boundary, such as when a subsection is hot added, populating the entire
section is wasteful.

The Next problem is if we hotplug something that spans part of 128 MiB
section (subsections, let's call it memblock1), and then hotplug something
that spans another part of a 128 MiB section(subsections, let's call it
memblock2), and subsequently unplug memblock1, vmemmap_free() will clear
the entire PMD entry which also supports memblock2 even though memblock2
is still active.

Assuming hotplug/unplug sizes are guaranteed to be symmetric. Do the
fix similar to x86-64: populate to pages levels if start/end is not aligned
with section boundary.

Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
---
 arch/arm64/mm/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b4df5bc5b1b8..eec1666da368 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1178,7 +1178,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 {
 	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
 
-	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES))
+	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) ||
+		(end - start < PAGES_PER_SECTION * sizeof(struct page)))
 		return vmemmap_populate_basepages(start, end, node, altmap);
 	else
 		return vmemmap_populate_hugepages(start, end, node, altmap);
-- 
2.25.1


