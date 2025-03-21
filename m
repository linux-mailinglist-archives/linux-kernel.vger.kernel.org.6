Return-Path: <linux-kernel+bounces-570805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E983A6B4AB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69578189E3CC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B57A1E7C27;
	Fri, 21 Mar 2025 07:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GJr3cUVl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD9633F6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742540465; cv=none; b=LgtBMQsUfeaew9KJvIqJbpRY/Blr3WcDs8h/UeAUA8biHYJrtrxi/ipxeS7w4US/ryvyJaA5D1cHH6h6ky90FxGfErJfCmP9uUBvZSTcxtH6nzeip9DrXqfMYDJtMkQR4b20AngkpL+NAVvpcL0FQhIOx0CgZvJ5+yWWwkh+sTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742540465; c=relaxed/simple;
	bh=WCtOPnjS5L6Ho4z2Wejs69s5stTNUC974q0wICzNqcE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QQwxO7YtOnEgax9P6zngmQUeDNDlndCBscmYC2wMbgNNiV4Ru47+fSyJB8kS7Bq6VZGaa5Ggs8j56mddomqEduax2uWotyOT8k5cMp/FK6zR2sDJcnwWwMw7SJ+jDSdfFfUJ0Y9fNq7a3pwnZOsY4UF0iZMcL/HRsMh11nbbYnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GJr3cUVl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L1WgjF030882;
	Fri, 21 Mar 2025 07:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PK0BeTHmcdd/qcMUUN81vS
	2AduMCdU/azMiQVglHyhE=; b=GJr3cUVlt7col3IiWsW0y4BBvH5RvRnMOuO6c8
	bYOK5zygh5lMqrFFFKdGkt6b/83EnIiX6tHRzpZ7K8hAuhZ6uqKqTRzm6XsGKYtQ
	lPexFlYYEqr9/Qf8p9OuoKf2Bb3nO+CT1k5Jzy7f7rzIHx8QJt4nFhdqTjASYVxr
	XrnIvqYBmch1ypzP5gV6mSIfQeGUBH4E+3eF1c2m/l2B4OVJAgzHMIRyXBd37lgm
	H3JGm5LtDz7er3GijXdKRYksIFzZ15t+6NtDrZYfpNr8fPvixdQDCoj0QoDN2Gie
	cCpukVTfS4hvfvVIXXG3ON7/TSr7Bn8LiiDPS46Oj/zrFb3g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45gcd1bw5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 07:00:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52L70g6H010467
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 07:00:42 GMT
Received: from ap-kernel-sh01-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 21 Mar 2025 00:00:37 -0700
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
To: <anshuman.khandual@arm.com>, <catalin.marinas@arm.com>, <david@redhat.com>,
        <will@kernel.org>, <ryan.roberts@arm.com>, <mark.rutland@arm.com>,
        <ardb@kernel.org>, <quic_zhenhuah@quicinc.com>,
        <yangyicong@hisilicon.com>, <joey.gouly@arm.com>,
        <quic_cgoldswo@quicinc.com>, <quic_sudaraja@quicinc.com>,
        <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_tingweiz@quicinc.com>
Subject: [PATCH] arm64: mm: Correct the update of max_pfn
Date: Fri, 21 Mar 2025 15:00:19 +0800
Message-ID: <20250321070019.1271859-1-quic_zhenhuah@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Authority-Analysis: v=2.4 cv=bfFrUPPB c=1 sm=1 tr=0 ts=67dd0e9b cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=ZcgGWeM3x-1IUL8PSGgA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: vhqnlhEx7zteyR5jia7Iia7zm_iS-JR7
X-Proofpoint-ORIG-GUID: vhqnlhEx7zteyR5jia7Iia7zm_iS-JR7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_02,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=576
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210049

Hotplugged memory can be smaller than the original memory. For example,
on my target:

root@genericarmv8:~# cat /sys/kernel/debug/memblock/memory
   0: 0x0000000064005000..0x0000000064023fff    0 NOMAP
   1: 0x0000000064400000..0x00000000647fffff    0 NOMAP
   2: 0x0000000068000000..0x000000006fffffff    0 DRV_MNG
   3: 0x0000000088800000..0x0000000094ffefff    0 NONE
   4: 0x0000000094fff000..0x0000000094ffffff    0 NOMAP
max_pfn will affect read_page_owner. Therefore, it should first compare and
then select the larger value for max_pfn.

Fixes: 8fac67ca236b ("arm64: mm: update max_pfn after memory hotplug")
Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
---
 arch/arm64/mm/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 1dfe1a8efdbe..310ff75891ef 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1361,7 +1361,8 @@ int arch_add_memory(int nid, u64 start, u64 size,
 		__remove_pgd_mapping(swapper_pg_dir,
 				     __phys_to_virt(start), size);
 	else {
-		max_pfn = PFN_UP(start + size);
+		/* Address of hotplugged memory can be smaller */
+		max_pfn = max(max_pfn, PFN_UP(start + size));
 		max_low_pfn = max_pfn;
 	}
 
-- 
2.25.1


