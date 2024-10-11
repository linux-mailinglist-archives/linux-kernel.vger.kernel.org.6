Return-Path: <linux-kernel+bounces-361878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00CF99AE3A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C8528778D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA4719D8B7;
	Fri, 11 Oct 2024 21:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="djD9E7VD"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56941D0F7D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728683112; cv=none; b=sZ3j/Gz1iJ2cmXevwcYsn1Ex7mEiLFcl2yUDkE1hci3oyTCk4shqoBwVuBwNvpBw92s1pFhRCBLB//aVU/2cvRNAuKi48Orzut78cCw841o7UDzfUoGfE5c9RHLAlFSibsEIdpg+FHwlSQ6HXTC96lu0/ycjZChHcvoos+gX1Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728683112; c=relaxed/simple;
	bh=KbxzAhwBMk4VMSsqasGfdTI336s0nXsCiP7ulIA3OZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQSvig9Y0yrLMQY/AqRiTYsXNs1QDwlB6k1B31VxIsy+AfBYxzrpO38ANZxhm20LwPSmdUCMRaSmrL3P5ofmIvWOVK2K5zzRAB+mNznBZWh6jwNU8kHhLpNUXzdKqs4wJ3oL5TfsKgrOesCUQwECqrquxN36M9ZLP7Wy0kOueqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=djD9E7VD; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BJU7Em007071;
	Fri, 11 Oct 2024 21:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=ZqnDF4NJzZ0S7p0y6Jm6lFyensH2W
	rRmhFzYfRLv1UI=; b=djD9E7VD6JF2c7WTLLYbLI70eIpssEjFQPzvmQvir9gOR
	/YtI6n/U1rqqi383p5hEPZZs9h673WkiTUfYULbXTlcUmw4SLMGjasS3rqZ41A5a
	PnzMZPeaIc40NeN6B5IEbE7UnFLZ3Pr3PhiLadLLAOBc/hxJ5850pAYrO9ru7fGU
	GZ7XJHhe+VOz2kX/yKfqUBX8sUoVIcNJ2uQQioQN7cYv90QhY97eNYTyVBLBMjtA
	MFbOYtDLe1lRpn0ofsqUVmkZWrwxCicB3grcat3Bc4pIRiez3IpmB9sVNrMi/E2x
	e9c2enqBefQoeSX0JNDzPwe2ahHDrxSCM/apbILew==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303ynv68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 21:44:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BJssPW027931;
	Fri, 11 Oct 2024 21:44:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwj395s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 21:44:55 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49BLisSm026877;
	Fri, 11 Oct 2024 21:44:54 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-170-196.vpn.oracle.com [10.65.170.196])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 422uwj395e-1;
	Fri, 11 Oct 2024 21:44:54 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, richard.weiyang@gmail.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 1/2] maple_tree: check for MA_STATE_BULK on setting wr_rebalance
Date: Fri, 11 Oct 2024 17:44:50 -0400
Message-ID: <20241011214451.7286-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_19,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410110153
X-Proofpoint-ORIG-GUID: NOZrxeg1V9xh0fXmiHV9jw6tFqSzWPAE
X-Proofpoint-GUID: NOZrxeg1V9xh0fXmiHV9jw6tFqSzWPAE

It is possible for a bulk operation (MA_STATE_BULK is set) to enter the
new_end < mt_min_slots[type] case and set wr_rebalance as a store type.
This is incorrect as bulk stores do not rebalance per write, but rather
after the all of the writes are done through the mas_bulk_rebalance()
path. Therefore, add a check to make sure MA_STATE_BULK is not set
before we return wr_rebalance as the store type.

Also add a test to make sure wr_rebalance is never the store type when
doing bulk operations via mas_expected_entries()

Fixes: 5d659bbb52a2 ("maple_tree: introduce mas_wr_store_type()")
Suggested-by: Liam Howlett <liam.howlett@oracle.com>
Signed-off-by: Sidhartha <sidhartha.kumar@oracle.com>
---

Hi Andrew, this commit is a hotfix for this rc however it has no userspace
effects as there are no users of the bulk instertion mode.

 lib/maple_tree.c                 |  2 +-
 tools/testing/radix-tree/maple.c | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 4b423330d83c..b3b1d4b8126b 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4228,7 +4228,7 @@ static inline void mas_wr_store_type(struct ma_wr_state *wr_mas)
 
 	/* Potential spanning rebalance collapsing a node */
 	if (new_end < mt_min_slots[wr_mas->type]) {
-		if (!mte_is_root(mas->node)) {
+		if (!mte_is_root(mas->node) && !(mas->mas_flags & MA_STATE_BULK)) {
 			mas->store_type = wr_rebalance;
 			return;
 		}
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 5fde09999be4..551ae6898c1d 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36317,6 +36317,28 @@ static inline int check_vma_modification(struct maple_tree *mt)
 	return 0;
 }
 
+/*
+ * test to check that bulk stores do not use wr_rebalance as the store
+ * type.
+ */
+static inline void check_bulk_rebalance(struct maple_tree *mt)
+{
+	MA_STATE(mas, mt, ULONG_MAX, ULONG_MAX);
+	int max = 10;
+
+	build_full_tree(mt, 0, 2);
+
+	/* erase every entry in the tree */
+	do {
+		/* set up bulk store mode */
+		mas_expected_entries(&mas, max);
+		mas_erase(&mas);
+		MT_BUG_ON(mt, mas.store_type == wr_rebalance);
+	} while (mas_prev(&mas, 0) != NULL);
+
+	mas_destroy(&mas);
+}
+
 void farmer_tests(void)
 {
 	struct maple_node *node;
@@ -36328,6 +36350,10 @@ void farmer_tests(void)
 	check_vma_modification(&tree);
 	mtree_destroy(&tree);
 
+	mt_init(&tree);
+	check_bulk_rebalance(&tree);
+	mtree_destroy(&tree);
+
 	tree.ma_root = xa_mk_value(0);
 	mt_dump(&tree, mt_dump_dec);
 
-- 
2.43.0


