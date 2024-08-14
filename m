Return-Path: <linux-kernel+bounces-286850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C834951FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78911B2D4DC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F7B1B86FF;
	Wed, 14 Aug 2024 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SJ2szo5b"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F5E1B32A2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652410; cv=none; b=j0gRhDiHzcVyr4znP3xs9cS9a6Wv5udHAbE856Q/XjyWJ9WcVunr/d7Op82WlqSaEUGqdj3CZGu8asG7qSvFD2you98vxUqXWobrO/vipG6NKDT8i6Hnd3T00OXrj5B9SDdpaoPbL4WOQLkGbq9yMKJyhmKGDfy2idqIZ7+OPec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652410; c=relaxed/simple;
	bh=L/aDCUx5s8oiKiqT2llMT4H59d/5gNsuVRuzufsISss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2SFLAz8ZgExiqKtddIXy/qczTQHVLT+NeYFIDYcWfXaoBSmxwjLkGtwrrqvHIh+kAWSf/1zYa82Pz6R4lIWJxLDbUP38oyGdrbE1Pf/0I8YTmbw61jl4Io1SqetLqZVb2BYrTz8MsTdqbZQNrTvPNom8csxIRTqXDSpwyG8BjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SJ2szo5b; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtWSQ023329;
	Wed, 14 Aug 2024 16:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=5
	uQINWFWZQNV6tNI6ezaoBToRmo3e5PavdxTeJelrlY=; b=SJ2szo5bmYygJs7sr
	vwuNA8ci5Rm2wFJjsyhy1CfhVc+dCEdltUeDABnZL6P0PpUIgIn/hcOHhYTkTQfj
	5FVjatKDKcbp3ZtqI6UQgM++ajnqedvkE5YpaGo45DIkw47RkWzeTVoTL00IX2W/
	GBJ4vW7F9R04b6V33f5GHCP7S2GNgl5v8gwMyFMgOGXMkHbt3hcd0/VBcZ3OqMdR
	HfbRbVlla2cB6DrPtM7IxDeruzX9MM8/gLB7CSfCW+5ak4JjPiEw92Ce/u30kkqs
	dBde/7gaxm/EzGGnsDnsSzwH/HVSPzUD0tDRJFhkxKUQYeH+X8PqGQ/0T+VFcYTS
	aVMcg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4104gakdt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EFrm2f021836;
	Wed, 14 Aug 2024 16:19:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxngn7r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:56 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47EGIvCI035951;
	Wed, 14 Aug 2024 16:19:56 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-174-212.vpn.oracle.com [10.65.174.212])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40wxngn7gt-12;
	Wed, 14 Aug 2024 16:19:55 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, surenb@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v4 11/17] maple_tree: simplify mas_commit_b_node()
Date: Wed, 14 Aug 2024 12:19:38 -0400
Message-ID: <20240814161944.55347-12-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814161944.55347-1-sidhartha.kumar@oracle.com>
References: <20240814161944.55347-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_12,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408140111
X-Proofpoint-GUID: ilu7tFYRhKBnBl3wIDCZ1J5O7IMopA3I
X-Proofpoint-ORIG-GUID: ilu7tFYRhKBnBl3wIDCZ1J5O7IMopA3I

The only callers of mas_commit_b_node() are those with store type of
wr_rebalance and wr_split_store. Use mas->store_type to dispatch to the
correct helper function. This allows the removal of mas_reuse_node() as
it is no longer used.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 64 ++++++------------------------------------------
 1 file changed, 7 insertions(+), 57 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index bb940f61d713..0314e9b52621 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3395,72 +3395,22 @@ static int mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 	return 1;
 }
 
-/*
- * mas_reuse_node() - Reuse the node to store the data.
- * @wr_mas: The maple write state
- * @bn: The maple big node
- * @end: The end of the data.
- *
- * Will always return false in RCU mode.
- *
- * Return: True if node was reused, false otherwise.
- */
-static inline bool mas_reuse_node(struct ma_wr_state *wr_mas,
-			  struct maple_big_node *bn, unsigned char end)
-{
-	/* Need to be rcu safe. */
-	if (mt_in_rcu(wr_mas->mas->tree))
-		return false;
-
-	if (end > bn->b_end) {
-		int clear = mt_slots[wr_mas->type] - bn->b_end;
-
-		memset(wr_mas->slots + bn->b_end, 0, sizeof(void *) * clear--);
-		memset(wr_mas->pivots + bn->b_end, 0, sizeof(void *) * clear);
-	}
-	mab_mas_cp(bn, 0, bn->b_end, wr_mas->mas, false);
-	return true;
-}
-
 /*
  * mas_commit_b_node() - Commit the big node into the tree.
  * @wr_mas: The maple write state
  * @b_node: The maple big node
- * @end: The end of the data.
  */
 static noinline_for_kasan int mas_commit_b_node(struct ma_wr_state *wr_mas,
-			    struct maple_big_node *b_node, unsigned char end)
+			    struct maple_big_node *b_node)
 {
-	struct maple_node *node;
-	struct maple_enode *old_enode;
-	unsigned char b_end = b_node->b_end;
-	enum maple_type b_type = b_node->type;
-
-	old_enode = wr_mas->mas->node;
-	if ((b_end < mt_min_slots[b_type]) &&
-	    (!mte_is_root(old_enode)) &&
-	    (mas_mt_height(wr_mas->mas) > 1))
-		return mas_rebalance(wr_mas->mas, b_node);
-
-	if (b_end >= mt_slots[b_type])
-		return mas_split(wr_mas->mas, b_node);
+	enum store_type type = wr_mas->mas->store_type;
 
-	if (mas_reuse_node(wr_mas, b_node, end))
-		goto reuse_node;
+	WARN_ON_ONCE(type != wr_rebalance && type != wr_split_store);
 
-	mas_node_count(wr_mas->mas, 1);
-	if (mas_is_err(wr_mas->mas))
-		return 0;
+	if (type == wr_rebalance)
+		return mas_rebalance(wr_mas->mas, b_node);
 
-	node = mas_pop_node(wr_mas->mas);
-	node->parent = mas_mn(wr_mas->mas)->parent;
-	wr_mas->mas->node = mt_mk_node(node, b_type);
-	mab_mas_cp(b_node, 0, b_end, wr_mas->mas, false);
-	mas_replace_node(wr_mas->mas, old_enode);
-reuse_node:
-	mas_update_gap(wr_mas->mas);
-	wr_mas->mas->end = b_end;
-	return 1;
+	return mas_split(wr_mas->mas, b_node);
 }
 
 /*
@@ -4155,7 +4105,7 @@ static void mas_wr_bnode(struct ma_wr_state *wr_mas)
 	trace_ma_write(__func__, wr_mas->mas, 0, wr_mas->entry);
 	memset(&b_node, 0, sizeof(struct maple_big_node));
 	mas_store_b_node(wr_mas, &b_node, wr_mas->offset_end);
-	mas_commit_b_node(wr_mas, &b_node, wr_mas->mas->end);
+	mas_commit_b_node(wr_mas, &b_node);
 }
 
 static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
-- 
2.46.0


