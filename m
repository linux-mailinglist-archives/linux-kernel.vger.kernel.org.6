Return-Path: <linux-kernel+bounces-359677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A83998EEA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5165F282151
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0551CF5D9;
	Thu, 10 Oct 2024 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jMBof341"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B731CF5EA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582751; cv=none; b=i/8FWf9gcvLEbI3LFiGCt4iNdEiwjzPyIe9ByyoXop1xUM7yd58ePVj0A+d29CG+D3qb7PfNjuUViuXWXFcHr4Pi/rQFo6b3WSvamVdUvIrwegEqzsMxnvQ/mjCkjm4DbzqCqh7yWius2w99SP1h4hEp6MpZzOrS7/vMe+xL7q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582751; c=relaxed/simple;
	bh=wIJkzro5qJWOdr2gzKdknWXZ5j3M5dSu0NXfBW2TRxM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aF4Lsvwhct5O8oSY2TXosheVgP8IJps/l70CaF5Z7kZIP7rR/WMyvhO5C//zNr5jZt8XhSfLWw4w76UYZggFzjd/0Rif9r89Gl9M8K9lodPkn4y3MNOJ1D/ykBL1Mq/UOounce/9qrP2fn3vX812feGxOHBhZy/RwyvIYchVsSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jMBof341; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AD8kOC027035;
	Thu, 10 Oct 2024 17:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=oNl8qbJwfIXDG/UAwjT6ZFo0a8CuYyPXXz44Avl05qc=; b=jM
	Bof341BFv4s5/sMJr0NfS9JQv/gHer+u90f8QNg4JVFo/cge/lvIvcgaWzTaNVxs
	uPrc2evx8QN8p2t1r05luUrt2Fu2ikLWqTW9oKKIIVYtv1WL4wLagsdzHyaiTpNM
	si5q1IxkDOxQE9SbfGh8hKaWsentIVfbsvRjf8xNsieK2WA6HiV1FCNXArQdaju1
	qrlqeor9Iu7cu5Bpji1sb3NwUl58fuKPSI9hCTpK5vTVcrmS2gArFLO8ieec7WYy
	Xgub/n6MGl6RwvktekzxHVHxHi9QZNVDagGhkOXnOyyPRH2rOglwO+l9l1TKBGvh
	j0xSRwC3yCCKJN8xqrEg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 426fj6rqyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 17:52:12 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49AHqBcx011580
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 17:52:11 GMT
Received: from hu-pintu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 10 Oct 2024 10:52:07 -0700
From: Pintu Kumar <quic_pintu@quicinc.com>
To: <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <joe@perches.com>, <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>,
        Pintu Kumar <quic_pintu@quicinc.com>
Subject: [PATCH] mm/zsmalloc: Use memcpy_from/to_page whereever possible
Date: Thu, 10 Oct 2024 23:21:43 +0530
Message-ID: <20241010175143.27262-1-quic_pintu@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fqU7cb6IRHNjToMAf-LH-u0MmQNgoe0x
X-Proofpoint-ORIG-GUID: fqU7cb6IRHNjToMAf-LH-u0MmQNgoe0x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=796
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410100118

As part of [1] we have replaced kmap/kunmap_atomic() with
kmap_local_page()/kunmap_local().

But later it was found that some of the code could be replaced
with already available apis in highmem.h, such as
memcpy_from_page()/memcpy_to_page().

Also, update the comments with correct api naming.

[1] https://lkml.kernel.org/r/20241001175358.12970-1-quic_pintu@quicinc.com

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index d3ff10160a5f..64b66a4d3e6e 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -263,7 +263,7 @@ struct zspage {
 struct mapping_area {
 	local_lock_t lock;
 	char *vm_buf; /* copy buffer for objects that span pages */
-	char *vm_addr; /* address of kmap_atomic()'ed pages */
+	char *vm_addr; /* address of kmap_local_page()'ed pages */
 	enum zs_mapmode vm_mm; /* mapping mode */
 };
 
@@ -1046,11 +1046,10 @@ static inline void __zs_cpu_down(struct mapping_area *area)
 static void *__zs_map_object(struct mapping_area *area,
 			struct page *pages[2], int off, int size)
 {
-	int sizes[2];
-	void *addr;
+	size_t sizes[2];
 	char *buf = area->vm_buf;
 
-	/* disable page faults to match kmap_atomic() return conditions */
+	/* disable page faults to match kmap_local_page() return conditions */
 	pagefault_disable();
 
 	/* no read fastpath */
@@ -1061,12 +1060,8 @@ static void *__zs_map_object(struct mapping_area *area,
 	sizes[1] = size - sizes[0];
 
 	/* copy object to per-cpu buffer */
-	addr = kmap_local_page(pages[0]);
-	memcpy(buf, addr + off, sizes[0]);
-	kunmap_local(addr);
-	addr = kmap_local_page(pages[1]);
-	memcpy(buf + sizes[0], addr, sizes[1]);
-	kunmap_local(addr);
+	memcpy_from_page(buf, pages[0], off, sizes[0]);
+	memcpy_from_page(buf + sizes[0], pages[1], 0, sizes[1]);
 out:
 	return area->vm_buf;
 }
@@ -1074,8 +1069,7 @@ static void *__zs_map_object(struct mapping_area *area,
 static void __zs_unmap_object(struct mapping_area *area,
 			struct page *pages[2], int off, int size)
 {
-	int sizes[2];
-	void *addr;
+	size_t sizes[2];
 	char *buf;
 
 	/* no write fastpath */
@@ -1091,15 +1085,11 @@ static void __zs_unmap_object(struct mapping_area *area,
 	sizes[1] = size - sizes[0];
 
 	/* copy per-cpu buffer to object */
-	addr = kmap_local_page(pages[0]);
-	memcpy(addr + off, buf, sizes[0]);
-	kunmap_local(addr);
-	addr = kmap_local_page(pages[1]);
-	memcpy(addr, buf + sizes[0], sizes[1]);
-	kunmap_local(addr);
+	memcpy_to_page(pages[0], off, buf, sizes[0]);
+	memcpy_to_page(pages[1], 0, buf + sizes[0], sizes[1]);
 
 out:
-	/* enable page faults to match kunmap_atomic() return conditions */
+	/* enable page faults to match kunmap_local() return conditions */
 	pagefault_enable();
 }
 
@@ -1511,10 +1501,10 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 		d_size -= size;
 
 		/*
-		 * Calling kunmap_atomic(d_addr) is necessary. kunmap_atomic()
-		 * calls must occurs in reverse order of calls to kmap_atomic().
-		 * So, to call kunmap_atomic(s_addr) we should first call
-		 * kunmap_atomic(d_addr). For more details see
+		 * Calling kunmap_local(d_addr) is necessary. kunmap_local()
+		 * calls must occurs in reverse order of calls to kmap_local_page().
+		 * So, to call kunmap_local(s_addr) we should first call
+		 * kunmap_local(d_addr). For more details see
 		 * Documentation/mm/highmem.rst.
 		 */
 		if (s_off >= PAGE_SIZE) {
-- 
2.17.1


