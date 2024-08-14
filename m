Return-Path: <linux-kernel+bounces-286860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D8B951FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D511C20D46
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED631BD036;
	Wed, 14 Aug 2024 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KkI9jY+E"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7353B1BBBD9
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652418; cv=none; b=UiLerf1TlysfJtyWdiD0NAl4GjPGp+koL+HSucCLAE5sVpHoCbcCXA6NjPSpvtvU6YJPQSjZNvIXT4BM63T0N68YkxESFd5ImW9FraNu14w/qdUU9BqR6VfmBSwEXt999Q+wPZ8CI1vosaEKzg3hsoVRXPs+XEOtnsbDATKQZm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652418; c=relaxed/simple;
	bh=gAflZBOa+Z5hY24AXrk1qYUj/cSAR+7Y16ohhlGDclI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaNXXyeD2xTXv8mZuzZjliD9F9TiEi22/E+SQ76Vr7q7NBkYTmjomyu7jwqNd2S80wUyiNYSrgjdtjFq4cCfz6OSsdu7k4k67+pNNLoaN9415sx2JLF1hWmvGfa2E/mOyn40Whf8SW6tOBaTMdXCFO2/j+Pbkv105ioGr2iZt/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KkI9jY+E; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtb8N007187;
	Wed, 14 Aug 2024 16:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=q
	TtBzc2HUrnD0EKBLPylJelpcf3wUNndt/MP7eAKeGk=; b=KkI9jY+E8SErnHR07
	OydZ1z+tbnA4ZEqn0PXpLYUNR2W81XwsZWJ+m/qY08nIjge57mxHxkVFeWR13AGC
	ICfexAy46KRyH2P+rKNNsDgDf78m2GvaffYQyMI8e0d7n2v8aXwuGEyF3hcbEsL2
	HhOMsVK5ZV6Cmkb+Jcy9sC68RDOipCsmh/5xBii/PeavWF+ngx8hn526DaBnGlQZ
	8+qVk8nDypTgGqfT/r0VVxLbU3a/u1EVur6N+F8LDYf1XhFvNcO+aAh9cf0j4wZq
	f/+P6zbSEhljLS/uBC0Ds2Iad2x1+yg0BMn0rVu+dOWxV+ByzPG6qCsd/qKS48My
	jISXQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0398m0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EFY5Y3020945;
	Wed, 14 Aug 2024 16:19:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxngn7kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:50 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47EGIvC2035951;
	Wed, 14 Aug 2024 16:19:50 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-174-212.vpn.oracle.com [10.65.174.212])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40wxngn7gt-4;
	Wed, 14 Aug 2024 16:19:50 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, surenb@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 03/17] maple_tree: move up mas_wr_store_setup() and mas_wr_prealloc_setup()
Date: Wed, 14 Aug 2024 12:19:30 -0400
Message-ID: <20240814161944.55347-4-sidhartha.kumar@oracle.com>
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
X-Proofpoint-ORIG-GUID: eY-2fWbxE3ooirXwYLmMSjR9_L3EgGHl
X-Proofpoint-GUID: eY-2fWbxE3ooirXwYLmMSjR9_L3EgGHl

Subsequent patches require these definitions to be higher, no functional
changes intended.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 96 ++++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 407c0be6e42f..de4a91ced8ca 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4227,6 +4227,54 @@ static inline void mas_wr_store_entry(struct ma_wr_state *wr_mas)
 		mas_wr_modify(wr_mas);
 }
 
+static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
+{
+	if (!mas_is_active(wr_mas->mas)) {
+		if (mas_is_start(wr_mas->mas))
+			return;
+
+		if (unlikely(mas_is_paused(wr_mas->mas)))
+			goto reset;
+
+		if (unlikely(mas_is_none(wr_mas->mas)))
+			goto reset;
+
+		if (unlikely(mas_is_overflow(wr_mas->mas)))
+			goto reset;
+
+		if (unlikely(mas_is_underflow(wr_mas->mas)))
+			goto reset;
+	}
+
+	/*
+	 * A less strict version of mas_is_span_wr() where we allow spanning
+	 * writes within this node.  This is to stop partial walks in
+	 * mas_prealloc() from being reset.
+	 */
+	if (wr_mas->mas->last > wr_mas->mas->max)
+		goto reset;
+
+	if (wr_mas->entry)
+		return;
+
+	if (mte_is_leaf(wr_mas->mas->node) &&
+	    wr_mas->mas->last == wr_mas->mas->max)
+		goto reset;
+
+	return;
+
+reset:
+	mas_reset(wr_mas->mas);
+}
+
+static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
+{
+	struct ma_state *mas = wr_mas->mas;
+
+	mas_wr_store_setup(wr_mas);
+	wr_mas->content = mas_start(mas);
+}
+
 /**
  * mas_insert() - Internal call to insert a value
  * @mas: The maple state
@@ -5358,54 +5406,6 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
 		mt_destroy_walk(enode, mt, true);
 	}
 }
-
-static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
-{
-	if (!mas_is_active(wr_mas->mas)) {
-		if (mas_is_start(wr_mas->mas))
-			return;
-
-		if (unlikely(mas_is_paused(wr_mas->mas)))
-			goto reset;
-
-		if (unlikely(mas_is_none(wr_mas->mas)))
-			goto reset;
-
-		if (unlikely(mas_is_overflow(wr_mas->mas)))
-			goto reset;
-
-		if (unlikely(mas_is_underflow(wr_mas->mas)))
-			goto reset;
-	}
-
-	/*
-	 * A less strict version of mas_is_span_wr() where we allow spanning
-	 * writes within this node.  This is to stop partial walks in
-	 * mas_prealloc() from being reset.
-	 */
-	if (wr_mas->mas->last > wr_mas->mas->max)
-		goto reset;
-
-	if (wr_mas->entry)
-		return;
-
-	if (mte_is_leaf(wr_mas->mas->node) &&
-	    wr_mas->mas->last == wr_mas->mas->max)
-		goto reset;
-
-	return;
-
-reset:
-	mas_reset(wr_mas->mas);
-}
-
-static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
-{
-	struct ma_state *mas = wr_mas->mas;
-
-	mas_wr_store_setup(wr_mas);
-	wr_mas->content = mas_start(mas);
-}
 /* Interface */
 
 /**
-- 
2.46.0


