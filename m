Return-Path: <linux-kernel+bounces-286865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A71952007
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E71FCB2541E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4294F1BDAB7;
	Wed, 14 Aug 2024 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ka68dGYh"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678CB1BC070
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652419; cv=none; b=b4awnCAzF5RTe0who8OV/4RQ0ZzVUK+qPrEITBRIHspXF79H2W/Ng7fsNJ0da8kaf2g5XKRZcSjuDzyhuqPwsBKIp8EfOceYS5uNFb5AwRARk0kYDtrJqyXNkVwiMNWkitv/WWYHKLMFaUo7sfJHDxvQPnwlmxaVtfZSxHRM/c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652419; c=relaxed/simple;
	bh=xkZGyQA2xP9i+UECZHBxL8HxlO7F9oTWU/J7xBBRW3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1PUACB7gWfjcEyMnV5obUTF6gTJ6HrJEVwBIjKO1PYDCc42HID002h+1hGDGdKmbo/DMYlOZpf/UeIj1G+lQOveyfGQxP5pMTsTSK8x3IaqyMsY1SCZzNInutk6rTfu57byVeLbcDb9nnwp/0BmDPCjy535LHfIDGXmzWNxDI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ka68dGYh; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtbNK006104;
	Wed, 14 Aug 2024 16:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=h
	In+8Yybfsr43/VXbr2dLboHCSAINfu362LGlbxAENo=; b=ka68dGYhm1Xqj6yu0
	K5fC28UFxeARsgcEQTd+TXLxOUBI63cP6S2h8jpQM95oaCjkZBwxc9anmwSsS2aD
	LHkcjoxks3v9UNNtC0auQvhtRIxietTzPzq6Op57O9PW/WjRXFli0sO5x/7Rj2Mn
	EEHvEIjTm7Qzdp7aKE3yoNVmflNb+HE8C/W2k7GJcU37ifynndlll6i7MtTd+rhT
	fCA+GfOCo/ndmk0+9l96Sm++c5BIXDCx6Ik86naRcJar6+V27AjqTnDH2LM+EY3N
	1o3FkNlmjB9Gc8GJY//1f2/1macb/Ye1bYV7rWSFciUhGogSZOkZSGOCaEgTFvsy
	SXcuQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy4bgub4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EFxhpc021064;
	Wed, 14 Aug 2024 16:19:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxngn7qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:55 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47EGIvCG035951;
	Wed, 14 Aug 2024 16:19:55 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-174-212.vpn.oracle.com [10.65.174.212])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40wxngn7gt-11;
	Wed, 14 Aug 2024 16:19:55 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, surenb@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 10/17] maple_tree: convert mas_insert() to preallocate nodes
Date: Wed, 14 Aug 2024 12:19:37 -0400
Message-ID: <20240814161944.55347-11-sidhartha.kumar@oracle.com>
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
X-Proofpoint-GUID: oVTmzFlSWob157LVeIvGqKVdGTcYWCQB
X-Proofpoint-ORIG-GUID: oVTmzFlSWob157LVeIvGqKVdGTcYWCQB

By setting the store type in mas_insert(), we no longer need to use
mas_wr_modify() to determine the correct store function to use. Instead,
set the store type and call mas_wr_store_entry(). Also, pass in the
requested gfp flags to mas_insert() so they can be passed to the call to
mas_wr_preallocate().

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 2242e07a46dc..bb940f61d713 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4457,26 +4457,24 @@ static inline void *mas_insert(struct ma_state *mas, void *entry)
 	if (wr_mas.content)
 		goto exists;
 
-	if (mas_is_none(mas) || mas_is_ptr(mas)) {
-		mas_store_root(mas, entry);
+	mas_wr_preallocate(&wr_mas, entry);
+	if (mas_is_err(mas))
 		return NULL;
-	}
 
 	/* spanning writes always overwrite something */
-	if (!mas_wr_walk(&wr_mas))
+	if (mas->store_type == wr_spanning_store)
 		goto exists;
 
 	/* At this point, we are at the leaf node that needs to be altered. */
-	wr_mas.offset_end = mas->offset;
-	wr_mas.end_piv = wr_mas.r_max;
-
-	if (wr_mas.content || (mas->last > wr_mas.r_max))
-		goto exists;
+	if (mas->store_type != wr_new_root && mas->store_type != wr_store_root) {
+		wr_mas.offset_end = mas->offset;
+		wr_mas.end_piv = wr_mas.r_max;
 
-	if (!entry)
-		return NULL;
+		if (wr_mas.content || (mas->last > wr_mas.r_max))
+			goto exists;
+	}
 
-	mas_wr_modify(&wr_mas);
+	mas_wr_store_entry(&wr_mas);
 	return wr_mas.content;
 
 exists:
-- 
2.46.0


