Return-Path: <linux-kernel+bounces-286866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D314951FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21E46B2A31F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217A11BE86D;
	Wed, 14 Aug 2024 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mPpvf9Vl"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA6E1BC093
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652420; cv=none; b=iOqDWQmPxL6zBR70CEe0ilaJXFfeJzbcuHf9i6hKn9lxIzeio1sVIz9JbAB8X8iPQcgcknmMlpAgJyONm3RIjBbLmuuNcXDVAtJHw3WUHOfiLmgZJUcV6HRj3jSulpsD41K0QGhCgLvP5KN5VmpLJcDm2uN2jyqXh63vaC0p9LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652420; c=relaxed/simple;
	bh=phnhCPFrbjSBE5H5D0hO0PThbedRa1p/qn3gMYiolg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4XCdrC1zBqdqdOPVErVX5EwcMaO4DrBH1O4nLt1PgGqARhHzNtvgiEYxlhooPr6hxJ6aR0D6madEaqBcAHWfaYJLs7pdX22G65h+fYFNuT4l5Kcz1n2+1hHJMmfp4l/K0nC/gBo64FLxQ6UvwrgXntI9HYWRdEowbeIVAMDTGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mPpvf9Vl; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtWAu015137;
	Wed, 14 Aug 2024 16:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=J
	U3MqvLejtF8so20hIcXMrVIJrbiyTBFwoucx2atG8c=; b=mPpvf9Vl7mi+SK9ak
	g8xRjjdemhfyKdIX9++Pje+cowzRNYPv69qLf+lhPmswetGAPmywA94Id71fp6Qy
	0iU8aO0zPpYkqZyyeqWGQpWTgfHo4IJNzChyUMQT7xqcGXxeNwRUGYWNDqK4ycp6
	ckS9nCQkSiQXU+mz7fkJmyARzi9oRLlUeADEFxDHWZ6aayG5XifxaF6SCCjbwOSc
	OFN+BdlaWQXnNuYfAOpVnNNe4hOPJ3eYCcF00TuzdTs8TjTOcnpWC1J48wAYSSSE
	TUeW3E9oh0v7o4v/dABXZg+SCtgIixW4D7Gn2DjlZJ1EtCbR0garOcAatdLbuQeU
	IVjPA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy030v8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EFoG8d021115;
	Wed, 14 Aug 2024 16:19:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxngn7s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:57 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47EGIvCM035951;
	Wed, 14 Aug 2024 16:19:57 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-174-212.vpn.oracle.com [10.65.174.212])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40wxngn7gt-14;
	Wed, 14 Aug 2024 16:19:57 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, surenb@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 13/17] maple_tree: have mas_store() allocate nodes if needed
Date: Wed, 14 Aug 2024 12:19:40 -0400
Message-ID: <20240814161944.55347-14-sidhartha.kumar@oracle.com>
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
X-Proofpoint-GUID: v3cAlC_zKdtNYKss_wgLLRbQp1Xvee2n
X-Proofpoint-ORIG-GUID: v3cAlC_zKdtNYKss_wgLLRbQp1Xvee2n

Not all users of mas_store() enter with nodes already preallocated.
Check for the MA_STATE_PREALLOC flag to decide whether to preallocate nodes
within mas_store() rather than relying on future write helper functions
to perform the allocations. This allows the write helper functions to be
simplified as they do not have to do checks to make sure there are
enough allocated nodes to perform the write.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 6640ca775808..d5e020dd93fa 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5477,13 +5477,12 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
  * @entry: The entry to store.
  *
  * The @mas->index and @mas->last is used to set the range for the @entry.
- * Note: The @mas should have pre-allocated entries to ensure there is memory to
- * store the entry.  Please see mas_expected_entries()/mas_destroy() for more details.
  *
  * Return: the first entry between mas->index and mas->last or %NULL.
  */
 void *mas_store(struct ma_state *mas, void *entry)
 {
+	int request;
 	MA_WR_STATE(wr_mas, mas, entry);
 
 	trace_ma_write(__func__, mas, 0, entry);
@@ -5506,7 +5505,23 @@ void *mas_store(struct ma_state *mas, void *entry)
 	 */
 	mas_wr_prealloc_setup(&wr_mas);
 	mas_wr_store_type(&wr_mas);
+	if (mas->mas_flags & MA_STATE_PREALLOC) {
+		mas_wr_store_entry(&wr_mas);
+		MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
+		return wr_mas.content;
+	}
+
+	request = mas_prealloc_calc(mas, entry);
+	if (!request)
+		goto store;
+
+	mas_node_count(mas, request);
+	if (mas_is_err(mas))
+		return NULL;
+
+store:
 	mas_wr_store_entry(&wr_mas);
+	mas_destroy(mas);
 	return wr_mas.content;
 }
 EXPORT_SYMBOL_GPL(mas_store);
-- 
2.46.0


