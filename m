Return-Path: <linux-kernel+bounces-537287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 557EDA48A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C6016AFBE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3FA26FDBA;
	Thu, 27 Feb 2025 20:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ohjIdKOS"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A3F1DE4C8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689318; cv=none; b=Vfy6UC9hfvZzv/2z0bUATudZmVPnroZWC236fRdKt7Kh1TotLGXXn7uCfXy0Oa1J31d9uD7ixkDsDcuNwaruS7p6dtYPDz3ZFA3lISqU0vwgGZxeUeeOXgoyk8KJBqXLTD7KtYKkBVw3dvEunU8Sa+mj45mVJYSGsO0yv0SOzuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689318; c=relaxed/simple;
	bh=4etr/PLeKE0Ee99iWvZ5MxF0MwPPzF93qZ9ybRzqQuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfkCS69MT437g3F8An6OM0rVvKcv7ZGbWED8aPU6tuJFrEWS5Q7XiBWRvdZTUF2n2krbqIHykb3NngvFKFwFrD4irxXJQiwlem5wo3zzJ/Wgkd9qyKm+QtBPSxO4lDmC7Rp8luVAw0AAbw0iObPj3mJAYRDafJwP5ZPENuZVJlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ohjIdKOS; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RJiZYW016085;
	Thu, 27 Feb 2025 20:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=yx9M9
	UzqVwml5F8oWQIucj2N+1y3Ei0ljrqvD/e/T2I=; b=ohjIdKOSsQO1tLIu9nnUn
	xhgz+qtJjumTeG7E97FFyIDHSheCZCosT9pJDQBx9QT2e8pKJdseL6qr+iKcWz91
	BPe7G2kZHuixpGiy3WnAWOCU39AuSEtEqTNPP9ND+zlyFzFB6JvRsbbctA6ulJbQ
	SsWtyHBtdPUoIaQNLig6Ttulx5f7Y0/MF6pSuKFjasnfuV1M3v4x29U97FXcsaaT
	PICh7HFsKGHN5INARpHAADFydfV8PxQBtsujVGtT12IiuboViS2uqpNGew9qgyqY
	V7DvHb3I5CfO9s+4ONbApCrG2UeqoyUS/LPoiwOgH8Mj8rvm0cbFQS5aVOjVDJny
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf49kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 20:48:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RJHgQa012657;
	Thu, 27 Feb 2025 20:48:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51dws08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 20:48:29 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51RKhrve030883;
	Thu, 27 Feb 2025 20:48:28 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44y51dwrvc-2;
	Thu, 27 Feb 2025 20:48:28 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        richard.weiyang@gmail.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v3 1/6] maple_tree: convert mas_prealloc_calc() to take in a maple write state
Date: Thu, 27 Feb 2025 20:48:18 +0000
Message-ID: <20250227204823.758784-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227204823.758784-1-sidhartha.kumar@oracle.com>
References: <20250227204823.758784-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502270154
X-Proofpoint-ORIG-GUID: 3MQcGoUFxweh2jMn3Ee8qzJHIvxipMUo
X-Proofpoint-GUID: 3MQcGoUFxweh2jMn3Ee8qzJHIvxipMUo

In a subsequent patch, mas_prealloc_calc() will need to access fields only
in the ma_wr_state. Convert the function to take in a ma_wr_state and
modify all callers. There is no functional change.

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 42c65974a56c..0410e13a099e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4144,13 +4144,14 @@ static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
 /**
  * mas_prealloc_calc() - Calculate number of nodes needed for a
  * given store oepration
- * @mas: The maple state
+ * @wr_mas: The maple write state
  * @entry: The entry to store into the tree
  *
  * Return: Number of nodes required for preallocation.
  */
-static inline int mas_prealloc_calc(struct ma_state *mas, void *entry)
+static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
 {
+	struct ma_state *mas = wr_mas->mas;
 	int ret = mas_mt_height(mas) * 3 + 1;
 
 	switch (mas->store_type) {
@@ -4247,16 +4248,15 @@ static inline enum store_type mas_wr_store_type(struct ma_wr_state *wr_mas)
  */
 static inline void mas_wr_preallocate(struct ma_wr_state *wr_mas, void *entry)
 {
-	struct ma_state *mas = wr_mas->mas;
 	int request;
 
 	mas_wr_prealloc_setup(wr_mas);
-	mas->store_type = mas_wr_store_type(wr_mas);
-	request = mas_prealloc_calc(mas, entry);
+	wr_mas->mas->store_type = mas_wr_store_type(wr_mas);
+	request = mas_prealloc_calc(wr_mas, entry);
 	if (!request)
 		return;
 
-	mas_node_count(mas, request);
+	mas_node_count(wr_mas->mas, request);
 }
 
 /**
@@ -5401,7 +5401,7 @@ void *mas_store(struct ma_state *mas, void *entry)
 		return wr_mas.content;
 	}
 
-	request = mas_prealloc_calc(mas, entry);
+	request = mas_prealloc_calc(&wr_mas, entry);
 	if (!request)
 		goto store;
 
@@ -5498,7 +5498,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 
 	mas_wr_prealloc_setup(&wr_mas);
 	mas->store_type = mas_wr_store_type(&wr_mas);
-	request = mas_prealloc_calc(mas, entry);
+	request = mas_prealloc_calc(&wr_mas, entry);
 	if (!request)
 		return ret;
 
-- 
2.43.0


