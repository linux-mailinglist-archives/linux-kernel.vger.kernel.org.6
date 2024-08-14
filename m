Return-Path: <linux-kernel+bounces-286853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942CE951FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EEF9B2D69A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70971BA870;
	Wed, 14 Aug 2024 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hEGTWlE3"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384521B8E9F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652413; cv=none; b=MJzgGMm5oEwPbEfp9Ss4+6L33SBVP0BxAKtwPzAJfzSSjiMApKGuW3HN/3M8rEb/nGzZPLDjruVTM9NioQVASTqW6Gy5j+r8pVFiAtYpe7lN3cgbyfj0CKbLSltJ6+xwHxqZZMnzbvc+QzsCJ291AMdvpm9FDWh9YO0Wj5SqRn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652413; c=relaxed/simple;
	bh=946cGtmmQ8VwWtT3hmqH9wtwEtVz5VVgo9tdwP8w4vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjGMEJNAXBZsvo5h646YRTEEKmd+NDcIHGHfo4Q6gtQcgcRzITKUlszeTB54D531kuMDV62qNtq8IowU//m8ZsNravs6UZnhZtJjpzein1yREaxL90R4XeijYzZ4vq77Ics5zsUBvecW1I5ppK+PK/DvJZgkBQ6/mKliZRnvGyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hEGTWlE3; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtWdj023335;
	Wed, 14 Aug 2024 16:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=l
	OqX+rCceq/tSGDWm6o1Tnunt1j5x96KRSeMshi7zdM=; b=hEGTWlE3FUBaaykV9
	QBO2pUGH+qBaZaALNI2hRgT7fQMOaUfagEjT36aP2SvGeHjkwjvrLMEDnJydpjeA
	QTIPUwja6X88b/j+HTKz+hTAmKdGjla8HmsPb/vybHSK7ESgkrGVsX5QHyR2MYjI
	AXW/6ViUeo0lT98+c+KFaD65EEvPiWUDpgSQjZx30+dPj77h9pUPK9Ninav6gbZS
	QlMklMSK55xfqoxXgaHAtEIuTj8AEDWjpWwPJv3f5041NSualldCjhefmmOvZnXS
	n1nBJ628mLnwAZybWFSfmAOT8BCyudU7YGuYqr13C1Y7dQUM/oB3WnYkgD0mLofK
	QnOkQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4104gakdt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EF5PPm021193;
	Wed, 14 Aug 2024 16:19:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxngn7rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:57 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47EGIvCK035951;
	Wed, 14 Aug 2024 16:19:56 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-174-212.vpn.oracle.com [10.65.174.212])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40wxngn7gt-13;
	Wed, 14 Aug 2024 16:19:56 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, surenb@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 12/17] maple_tree: remove mas_wr_modify()
Date: Wed, 14 Aug 2024 12:19:39 -0400
Message-ID: <20240814161944.55347-13-sidhartha.kumar@oracle.com>
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
X-Proofpoint-GUID: 7bCT3OyQlrF79LGUa3r-rM7oUGHDZ4BB
X-Proofpoint-ORIG-GUID: 7bCT3OyQlrF79LGUa3r-rM7oUGHDZ4BB

There are no more users of the function, safely remove it.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 0314e9b52621..6640ca775808 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4108,44 +4108,6 @@ static void mas_wr_bnode(struct ma_wr_state *wr_mas)
 	mas_commit_b_node(wr_mas, &b_node);
 }
 
-static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
-{
-	struct ma_state *mas = wr_mas->mas;
-	unsigned char new_end;
-
-	/* Direct replacement */
-	if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last) {
-		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
-		if (!!wr_mas->entry ^ !!wr_mas->content)
-			mas_update_gap(mas);
-		return;
-	}
-
-	/*
-	 * new_end exceeds the size of the maple node and cannot enter the fast
-	 * path.
-	 */
-	new_end = mas_wr_new_end(wr_mas);
-	if (new_end >= mt_slots[wr_mas->type])
-		goto slow_path;
-
-	/* Attempt to append */
-	if (mas_wr_append(wr_mas, new_end))
-		return;
-
-	if (new_end == mas->end && mas_wr_slot_store(wr_mas))
-		return;
-
-	if (mas_wr_node_store(wr_mas, new_end))
-		return;
-
-	if (mas_is_err(mas))
-		return;
-
-slow_path:
-	mas_wr_bnode(wr_mas);
-}
-
 /*
  * mas_wr_store_entry() - Internal call to store a value
  * @mas: The maple state
-- 
2.46.0


