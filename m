Return-Path: <linux-kernel+bounces-526222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0458BA3FBAF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB9A19E1E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DD621504E;
	Fri, 21 Feb 2025 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ei8HKgFY"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F53720FA99
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155791; cv=none; b=jvMVcACwb9OcB/6qjoutBB27HGhOOvunDNeGWbqfcSoYwkYhW7ubrlc3ICSzI3BcW77H48fBD+cEQTi7XuNeFmz686HyF3X+eVnAcNYIWRabQi8xpXODUg7OkAjIKPhwk0cuw46zekbFjaxY57kxrHdnoC++7JxNKZ7ziC3un64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155791; c=relaxed/simple;
	bh=yrBvXCOotBlZ3fFlQZY/g9HG07/jYBHna8hiQ0CGhp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnhIZT+KKfgB4Ikjl8pLiEr0D43n1dHiiafamn2oW8qD6fIwoFW0EdBHavWR4CV2xWcEOjG2VDqBU8XEVwulrJGlL+dvo1D00edp6WCkSDm4oXWb3hWoEN7lTJizRQ4SwwDc0KVpfsyZxLx+3MeD37QJUX4hmGmbQaVza1wvHAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ei8HKgFY; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8fcjB027789;
	Fri, 21 Feb 2025 16:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=OSOza
	BP2cohPw2EjUEbuKxDUw/Doi0XEbeFRJ2RbVEY=; b=Ei8HKgFYYeNWmmDPvjg9B
	uxS5b9LyQpXJBrZOjtYjq2p67cIBhQPktSsvONrPvgNiZxtA/chdsRIzd14HGAd+
	LYazWaMTqguu2wbMtCCe4IXYCMn1bC4/sUfuYxTKjUlAYO1deIGQJv/SKrHOeBh2
	3hqmw5Vkbn8T/yw2hwrWZYv2WsEDR2cu0Kwab6KoIjUJTaWTd9kvN22mY/2RB/pY
	oiYPyMhmTctbQKrTYPkLF/GzyqSJ5tC6SHL/4j0FOaNdV9WqLnq7cThPSo18pbnu
	9lD/hN4+8w+cjHzMUGnEfiiCoXEjjr41ofSq3cOig0Ebe5fpPr9kwocRLcYB7qRK
	Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00pxkrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 16:36:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LG8tCv010613;
	Fri, 21 Feb 2025 16:36:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w07gxm75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 16:36:13 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51LGUIXD005786;
	Fri, 21 Feb 2025 16:36:13 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44w07gxm69-2;
	Fri, 21 Feb 2025 16:36:13 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        richard.weiyang@gmail.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 1/6] maple_tree: convert mas_prealloc_calc() to take in a maple write state
Date: Fri, 21 Feb 2025 16:36:05 +0000
Message-ID: <20250221163610.578409-2-sidhartha.kumar@oracle.com>
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
X-Proofpoint-ORIG-GUID: QQWwevtEjJ6ySVkZGd0LJ4o6jKJpWsOs
X-Proofpoint-GUID: QQWwevtEjJ6ySVkZGd0LJ4o6jKJpWsOs

In a subsequent patch, mas_prealloc_calc() will need to access fields only
in the ma_wr_state. Convert the function to take in a ma_wr_state and
modify all callers. There is no functional change.

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


