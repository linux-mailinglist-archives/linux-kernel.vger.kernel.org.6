Return-Path: <linux-kernel+bounces-279862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015D294C2C0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75AB21F2377C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D269918FC8F;
	Thu,  8 Aug 2024 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R9Cj3YEA"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55594143723
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134619; cv=none; b=IOBS8hyQpuqKNEKmtG5dnJVP4j+/UQ1zEb4SpP0i7SU4i+gBu5Hb3Zs95+t0wxAxnOpOUKa+hO6cTind10szxVYpuKyUdDwEZ7SyGBcah6oDDWbL5ong/XRi+LRpoVtq7gmQ9zKPdDTrVRK4yQVg/twTGQNVpip3fz8XEsrR5r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134619; c=relaxed/simple;
	bh=Qc6nYfbCa+8/s8t1iE7BpeImUzEnm7nd9elDwc2nkAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaBgUD8YXkm9Z+Cz65FufgDNW8kX38qgPZTfDx/pTCYWYWug7P2HUK44vDtLjWa8kavtHoM+zNSdiKzSnPTl3E8b/kkavdqHdyMQpr4healOwYECo+5Ph9aZrp5TCi1FUOqAmH+FEmFQR5y+73JQDmA2Gq/Ib/piWDsfDLA74IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R9Cj3YEA; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478AMYqo024560;
	Thu, 8 Aug 2024 16:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=I
	2cunVBKYInUBWGR+biooL7s+jlkeRxlVBahI3pFvBw=; b=R9Cj3YEAMetjVgQs6
	tWw51Yuh5aTZUgnweOHGJW++VrIIaJPBjEVDLAieMlD8StiqZxFYhSB1MNOciYUj
	Q377WaN6BaZTXRJapniCM7cdmwQWRXkXPnjMvpXJ6vPg6cnCLh+OhO9uEdMpOvcO
	ltNnks5FhK9arjbDW7yb3yFypBHpsPPueKS/eST/CxMuQ3kCx63eG8wggnhNtBjq
	iphHq29PUJ+vXxyM4XE6K08YOoOgDOAHMBhsfdcZF/2E1P0KwpY556egh5Zdau6R
	51+ijE0jfk5gwrV6QjWOv6WU4IL1y0tBkCC8iSgQZTc7Y2g90TuA4JcLLSB9wgsf
	g0fNg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sayea4u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 16:30:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 478G4LYm039532;
	Thu, 8 Aug 2024 16:30:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0cvkr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 16:30:06 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 478GU5Op039245;
	Thu, 8 Aug 2024 16:30:05 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-170-228.vpn.oracle.com [10.65.170.228])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40sb0cvkpn-2;
	Thu, 08 Aug 2024 16:30:05 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 2/2] maple_tree: reset mas->index and mas->last on write retries
Date: Thu,  8 Aug 2024 12:30:00 -0400
Message-ID: <20240808163000.25053-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240808163000.25053-1-sidhartha.kumar@oracle.com>
References: <20240808163000.25053-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_16,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408080116
X-Proofpoint-ORIG-GUID: gJa0QCKoVr-mSRtHz71HGb5V55626mTL
X-Proofpoint-GUID: gJa0QCKoVr-mSRtHz71HGb5V55626mTL

The following scenario can result in a race condition:

Consider a node with the following indices and values

	a<------->b<----------->c<--------->d
	    0xA        NULL          0xB

	CPU 1			  CPU 2
      ---------        		---------
	mas_set_range(a,b)
	mas_erase()
		-> range is expanded (a,c) because of null expansion

	mas_nomem()
	mas_unlock()
				mas_store_range(b,c,0xC)

The node now looks like:

	a<------->b<----------->c<--------->d
	    0xA        0xC          0xB

	mas_lock()
	mas_erase() <------ range of erase is still (a,c)

The node is now NULL from (a,c) but the write from CPU 2 should have been
retained and range (b,c) should still have 0xC as its value. We can fix
this by re-intializing to the original index and last. This does not need
a cc: Stable as there are no users of the maple tree which use internal
locking and this condition is only possible with internal locking.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 65fba37ef999..6ba95a278326 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5451,14 +5451,21 @@ EXPORT_SYMBOL_GPL(mas_store);
  */
 int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp)
 {
+	unsigned long index = mas->index;
+	unsigned long last = mas->last;
 	MA_WR_STATE(wr_mas, mas, entry);
 
 	mas_wr_store_setup(&wr_mas);
 	trace_ma_write(__func__, mas, 0, entry);
 retry:
 	mas_wr_store_entry(&wr_mas);
-	if (unlikely(mas_nomem(mas, gfp)))
+	if (unlikely(mas_nomem(mas, gfp))) {
+		if (!entry) {
+			mas->index = index;
+			mas->last = last;
+		}
 		goto retry;
+	}
 
 	if (unlikely(mas_is_err(mas)))
 		return xa_err(mas->node);
@@ -6245,17 +6252,19 @@ EXPORT_SYMBOL_GPL(mas_find_range_rev);
 void *mas_erase(struct ma_state *mas)
 {
 	void *entry;
+	unsigned long index = mas->index;
 	MA_WR_STATE(wr_mas, mas, NULL);
 
 	if (!mas_is_active(mas) || !mas_is_start(mas))
 		mas->status = ma_start;
 
-	/* Retry unnecessary when holding the write lock. */
+write_retry:
+	/* reset mas->index and mas->last in case range of entry changed */
+	mas->index = mas->last = index;
 	entry = mas_state_walk(mas);
 	if (!entry)
 		return NULL;
 
-write_retry:
 	/* Must reset to ensure spanning writes of last slot are detected */
 	mas_reset(mas);
 	mas_wr_store_setup(&wr_mas);
-- 
2.46.0


