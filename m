Return-Path: <linux-kernel+bounces-526224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06542A3FBB2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A061118828D9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852DB215175;
	Fri, 21 Feb 2025 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UDUou/wa"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A91A20FAAC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155791; cv=none; b=R9FPutgfxTIaXj/t53E276aFhr6Dpcd29gFS3lU5Jgm+W9WWH23D6EIXTQYjSK+OVH+8vX+ZAHULwRoo8PDU8mFETdgyGpZmsOLVsgLm1fcY5KWHLWvqRlhrhRTydTT2GidLzG/9PL01Rje1OfzvlRydhodBJcMIB0xQliXmkGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155791; c=relaxed/simple;
	bh=3AxKcyx6fp3bWph5PGB7opkTZKZSy1715tSCTe1fTxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcQTOSZ0tkv5J0PfAqCICJJ+gfUWquVH4izSHlITAwpCdiBBh+8WE6d5bZg5lEbkSng7aBqlGZIRJ9v4/LRfrirrJF3Qm/BeaIcHJ0ztlivIDUzJn3g42RWlqTRntJKTWU8Y/7JfW3c4XbXEUtGgNSiBV8Vn65BmBZhU90ynzCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UDUou/wa; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8ffb9016642;
	Fri, 21 Feb 2025 16:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=Qas13
	8Lb390XmRj9bcmiwXwau4wNel66xSmLqMbrZnQ=; b=UDUou/wao6D0tTHRZf2ud
	oy9fa4P3FIJEoE8a/7gu30ltSLHv4RDE1afSZm2FDB2ZwfsL0VJmFQMP+0OpsTK5
	YRucFDuch8EebCYq/fB1c0tY0WrHc3+9EMzHVOEIbX55o/D8CJ8t5xoEn8ZWbn4R
	m/X4BK60rMrcFMmhFRSjhXXm3ASqyU0oqq3oJkwDn4tKaX+4Oj6whCY7llfH36qP
	Ai4kTntWW15NdB0oPKQUS7b0P3pSNMaPeJ6iLsT9SfBdsB8O5K9WFNTMWkvhgIrn
	NonI0NQP3JTlxru2TTada43mrFQheWKFs4kC4KmSoJccOKj0Fakuymcm6vJUB+Z4
	Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00npkv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 16:36:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LFnZkJ010522;
	Fri, 21 Feb 2025 16:36:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w07gxm99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 16:36:15 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51LGUIXN005786;
	Fri, 21 Feb 2025 16:36:15 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44w07gxm69-7;
	Fri, 21 Feb 2025 16:36:15 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        richard.weiyang@gmail.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 6/6] maple_tree: reorder mas->store_type case statements
Date: Fri, 21 Feb 2025 16:36:10 +0000
Message-ID: <20250221163610.578409-7-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221163610.578409-1-sidhartha.kumar@oracle.com>
References: <20250221163610.578409-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210118
X-Proofpoint-ORIG-GUID: XIKLV5z05go6Yij8Q-abTzXMl6Qq-NEQ
X-Proofpoint-GUID: XIKLV5z05go6Yij8Q-abTzXMl6Qq-NEQ

Move the unlikely case that mas->store_type is invalid to be the last
evaluated case and put liklier cases higher up.

Suggested-by: Liam Howlett <liam.howlett@oracle.com>
Signed-off-by: Sidhartha <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 51 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 8fdd3f477198..36d7d7a27e32 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4091,15 +4091,6 @@ static inline void mas_wr_store_entry(struct ma_wr_state *wr_mas)
 	unsigned char new_end = mas_wr_new_end(wr_mas);
 
 	switch (mas->store_type) {
-	case wr_invalid:
-		MT_BUG_ON(mas->tree, 1);
-		return;
-	case wr_new_root:
-		mas_new_root(mas, wr_mas->entry);
-		break;
-	case wr_store_root:
-		mas_store_root(mas, wr_mas->entry);
-		break;
 	case wr_exact_fit:
 		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
 		if (!!wr_mas->entry ^ !!wr_mas->content)
@@ -4121,6 +4112,14 @@ static inline void mas_wr_store_entry(struct ma_wr_state *wr_mas)
 	case wr_rebalance:
 		mas_wr_bnode(wr_mas);
 		break;
+	case wr_new_root:
+		mas_new_root(mas, wr_mas->entry);
+		break;
+	case wr_store_root:
+		mas_store_root(mas, wr_mas->entry);
+		break;
+	case wr_invalid:
+		MT_BUG_ON(mas->tree, 1);
 	}
 
 	return;
@@ -4185,19 +4184,10 @@ static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
 	unsigned char delta = height - wr_mas->vacant_height;
 
 	switch (mas->store_type) {
-	case wr_invalid:
-		WARN_ON_ONCE(1);
-		break;
-	case wr_new_root:
-		ret = 1;
-		break;
-	case wr_store_root:
-		if (likely((mas->last != 0) || (mas->index != 0)))
-			ret = 1;
-		else if (((unsigned long) (entry) & 3) == 2)
-			ret = 1;
-		else
-			ret = 0;
+	case wr_exact_fit:
+	case wr_append:
+	case wr_slot_store:
+		ret = 0;
 		break;
 	case wr_spanning_store:
 		if (wr_mas->sufficient_height < wr_mas->vacant_height)
@@ -4217,10 +4207,19 @@ static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
 	case wr_node_store:
 		ret = mt_in_rcu(mas->tree) ? 1 : 0;
 		break;
-	case wr_append:
-	case wr_exact_fit:
-	case wr_slot_store:
-		ret = 0;
+	case wr_new_root:
+		ret = 1;
+		break;
+	case wr_store_root:
+		if (likely((mas->last != 0) || (mas->index != 0)))
+			ret = 1;
+		else if (((unsigned long) (entry) & 3) == 2)
+			ret = 1;
+		else
+			ret = 0;
+		break;
+	case wr_invalid:
+		WARN_ON_ONCE(1);
 	}
 
 	return ret;
-- 
2.43.0


