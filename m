Return-Path: <linux-kernel+bounces-409714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1329C9077
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51EA5282850
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD09B18B499;
	Thu, 14 Nov 2024 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cLGVRprn"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC53433C4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603941; cv=none; b=pwV3r20fQik3MhHpYeeN88qRxdz672NGEqsTCizNxWzmRpAmUU26Tbela/+c+dKVrcb82oedeeWnm+KQERrmhfXiXcl3YZW/J0RIhMEEjL5IgufO7HQbZKQAp/xufnLBGp8s09jerdY4NUBRMXIMmISQ0ClzCF89opvqgOdURsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603941; c=relaxed/simple;
	bh=abI3WQbZEvzWAbPSPOuqh8UqU2IA51aJ50UHAArz0Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naevxx5vd4lfrp61nXJ7qlcNUzSpX7k4TzAEYu7PtYEKFdqGTSZ4hQ75cjTOFCeA2Q75KDw1wivEtruIwuMx5B0lc4w9yXcbytzZcERUo2ttRXxF1mydXSHCA+imVMUMoKeFkx9xjHHPo7ZaKAH8qGAHydfJczm8ud8XPIlmjO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cLGVRprn; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEChijk015748;
	Thu, 14 Nov 2024 17:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=iPoSj
	a3pKgizYaVyOF/YvV4XNpYb6HkD1dOoOPDQ6d4=; b=cLGVRprnu/d6Wv7+rrIQs
	MGhWgFO8PnbqxVbdyQ7DxF2ScfBfznRxwZWRG8IIN1B+cvn3QAeRlJVxJeFC0Mm4
	gR7/EQP1RrgwRWm4jdOHUPxAkGAy9CbPAEg0CdczprY+chvnG0UQ54M2qVHQDBFx
	DzNTM5UqjRHf2VBHcrjS17rGgGfDecDJ8kWW5AgR7WuSnByKV7LBQYPX2Wg6M419
	n9OtMufXJ4wcRhH+mYeg+z8iO6LNYrPOAgDu40QO95/EE+wrIiAA/6EsZVAW+LHT
	e3qSCjxk30JZLVUKtKl4RzpNpV+n+VxFpzpLtWb/3vb/wROp22++Q4PZ4kYhZo2h
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k29phn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:05:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEFZCp1022682;
	Thu, 14 Nov 2024 17:05:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw1jy7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:05:28 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AEH5QmJ032739;
	Thu, 14 Nov 2024 17:05:27 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-39-201-66.vpn.oracle.com [10.39.201.66])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42vuw1jy5w-2;
	Thu, 14 Nov 2024 17:05:27 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 1/5] maple_tree: convert mas_prealloc_calc() to take in a maple write state
Date: Thu, 14 Nov 2024 12:05:20 -0500
Message-ID: <20241114170524.64391-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241114170524.64391-1-sidhartha.kumar@oracle.com>
References: <20241114170524.64391-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140134
X-Proofpoint-ORIG-GUID: Pi8ej0-RcmxcKFwAiABK4IAlpu_VRTgd
X-Proofpoint-GUID: Pi8ej0-RcmxcKFwAiABK4IAlpu_VRTgd

In a subsequent patch, mas_prealloc_calc() will need to access fields only
in the ma_wr_state. Convert the function to take in a ma_wr_state and
modify all callers.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d0ae808f3a14..318d496debd7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4155,13 +4155,14 @@ static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
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
@@ -4258,16 +4259,15 @@ static inline enum store_type mas_wr_store_type(struct ma_wr_state *wr_mas)
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
@@ -5441,7 +5441,7 @@ void *mas_store(struct ma_state *mas, void *entry)
 		return wr_mas.content;
 	}
 
-	request = mas_prealloc_calc(mas, entry);
+	request = mas_prealloc_calc(&wr_mas, entry);
 	if (!request)
 		goto store;
 
@@ -5538,7 +5538,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 
 	mas_wr_prealloc_setup(&wr_mas);
 	mas->store_type = mas_wr_store_type(&wr_mas);
-	request = mas_prealloc_calc(mas, entry);
+	request = mas_prealloc_calc(&wr_mas, entry);
 	if (!request)
 		return ret;
 
-- 
2.43.0


