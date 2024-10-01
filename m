Return-Path: <linux-kernel+bounces-346455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB3C98C4E9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2351F21855
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B221CC8B9;
	Tue,  1 Oct 2024 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LT8PGcyN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A151CC884
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805280; cv=none; b=dMqHcDZ0YuiepOqZQDUIYLgRy0q2+wX3dBB/licWWtHdzP1Uzo+Xo/AoTzptE6B6BR5zG2S7JGLPQIOjtRQ5IvLS53Y1U5W1mPgEvyuA8kLN3umk8bvWYyh6ijVg/wE3k5K6S5+NTxNXmnreqspWnJhkP5YOMOYcXGva1sOfq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805280; c=relaxed/simple;
	bh=HCAI1qgwT7IF1vgi4ECcoAZxrSQts1+MMKSnjvYXTjw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kHV933gbiUwO5x328LgNypTgAV34KIIdtbkxDn1i7cbQnvyFXe3Rpkbs71y1tUqMVwCJnfnjeguYvQ3vpNsLiTtahZBGxWcUSs7gn812T1TlJvTuu0XeyTNmf7CMSoSgg7QcdydezhQOjQcokTTcj+EFyk2fniQgBTpwf9LRwyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LT8PGcyN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491AUsor001779;
	Tue, 1 Oct 2024 17:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=FD3EhqA3CYSccYK1CMSE9VY0pQmd+OHP+KzHPvAuot4=; b=LT
	8PGcyN6j1tE7dYEqf73kaKyXBf89tMrCIkC1Y2pjtBeug8pcMEjJFfsGH5OWMl+c
	g4e7dZar1XmWWQitAWVmwJPO9rPWWaaVNVYxgAuU2SbY0dTUzmkI6ewTKvr/MfaN
	Va7/MYaTA5pTjnJlsWUEfsAjtgZmey8amyPruyKKuYqNkCXmIrTNsis5rwZuTyLe
	rcHmws5qdZRYIPudDrhvYvziDEANUqCZhTiHLGT+AEViF4gIk89yJft9cvFSx8+D
	K3gc3cwVhEp5DqVWAI3mXbFUyNDjdZ1lmiQ0vOaKFCRufUk1J4XuvVkWXouK3dT/
	IWu+N6y6vUDdKu0zBGWg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xa12satj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 17:54:26 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 491HsPqf017680
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Oct 2024 17:54:25 GMT
Received: from hu-pintu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 1 Oct 2024 10:54:22 -0700
From: Pintu Kumar <quic_pintu@quicinc.com>
To: <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC: <joe@perches.com>, <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>,
        Pintu Kumar <quic_pintu@quicinc.com>
Subject: [PATCH 3/3] zsmalloc: replace kmap_atomic with kmap_local_page
Date: Tue, 1 Oct 2024 23:23:58 +0530
Message-ID: <20241001175358.12970-1-quic_pintu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 8Tx1oWPSCC50INi9GFs6M_rXXI_i8tJ5
X-Proofpoint-GUID: 8Tx1oWPSCC50INi9GFs6M_rXXI_i8tJ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=693
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010115

The use of kmap_atomic/kunmap_atomic is deprecated.
Replace it will kmap_local_page/kunmap_local all over the place.
Also fix SPDX missing license header.

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1

WARNING: Deprecated use of 'kmap_atomic', prefer 'kmap_local_page' instead
+               vaddr = kmap_atomic(page);

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
---
 mm/zsmalloc.c | 66 ++++++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 16a07def09c9..d3ff10160a5f 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
 /*
  * zsmalloc memory allocator
  *
@@ -898,7 +900,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 
 		set_first_obj_offset(page, off);
 
-		vaddr = kmap_atomic(page);
+		vaddr = kmap_local_page(page);
 		link = (struct link_free *)vaddr + off / sizeof(*link);
 
 		while ((off += class->size) < PAGE_SIZE) {
@@ -921,7 +923,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 			 */
 			link->next = -1UL << OBJ_TAG_BITS;
 		}
-		kunmap_atomic(vaddr);
+		kunmap_local(vaddr);
 		page = next_page;
 		off %= PAGE_SIZE;
 	}
@@ -1059,12 +1061,12 @@ static void *__zs_map_object(struct mapping_area *area,
 	sizes[1] = size - sizes[0];
 
 	/* copy object to per-cpu buffer */
-	addr = kmap_atomic(pages[0]);
+	addr = kmap_local_page(pages[0]);
 	memcpy(buf, addr + off, sizes[0]);
-	kunmap_atomic(addr);
-	addr = kmap_atomic(pages[1]);
+	kunmap_local(addr);
+	addr = kmap_local_page(pages[1]);
 	memcpy(buf + sizes[0], addr, sizes[1]);
-	kunmap_atomic(addr);
+	kunmap_local(addr);
 out:
 	return area->vm_buf;
 }
@@ -1089,12 +1091,12 @@ static void __zs_unmap_object(struct mapping_area *area,
 	sizes[1] = size - sizes[0];
 
 	/* copy per-cpu buffer to object */
-	addr = kmap_atomic(pages[0]);
+	addr = kmap_local_page(pages[0]);
 	memcpy(addr + off, buf, sizes[0]);
-	kunmap_atomic(addr);
-	addr = kmap_atomic(pages[1]);
+	kunmap_local(addr);
+	addr = kmap_local_page(pages[1]);
 	memcpy(addr, buf + sizes[0], sizes[1]);
-	kunmap_atomic(addr);
+	kunmap_local(addr);
 
 out:
 	/* enable page faults to match kunmap_atomic() return conditions */
@@ -1223,7 +1225,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	area->vm_mm = mm;
 	if (off + class->size <= PAGE_SIZE) {
 		/* this object is contained entirely within a page */
-		area->vm_addr = kmap_atomic(page);
+		area->vm_addr = kmap_local_page(page);
 		ret = area->vm_addr + off;
 		goto out;
 	}
@@ -1260,7 +1262,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 
 	area = this_cpu_ptr(&zs_map_area);
 	if (off + class->size <= PAGE_SIZE)
-		kunmap_atomic(area->vm_addr);
+		kunmap_local(area->vm_addr);
 	else {
 		struct page *pages[2];
 
@@ -1318,7 +1320,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 	for (i = 0; i < nr_page; i++)
 		m_page = get_next_page(m_page);
 
-	vaddr = kmap_atomic(m_page);
+	vaddr = kmap_local_page(m_page);
 	link = (struct link_free *)vaddr + m_offset / sizeof(*link);
 	set_freeobj(zspage, link->next >> OBJ_TAG_BITS);
 	if (likely(!ZsHugePage(zspage)))
@@ -1328,7 +1330,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 		/* record handle to page->index */
 		zspage->first_page->index = handle | OBJ_ALLOCATED_TAG;
 
-	kunmap_atomic(vaddr);
+	kunmap_local(vaddr);
 	mod_zspage_inuse(zspage, 1);
 
 	obj = location_to_obj(m_page, obj);
@@ -1419,7 +1421,7 @@ static void obj_free(int class_size, unsigned long obj)
 	f_offset = offset_in_page(class_size * f_objidx);
 	zspage = get_zspage(f_page);
 
-	vaddr = kmap_atomic(f_page);
+	vaddr = kmap_local_page(f_page);
 	link = (struct link_free *)(vaddr + f_offset);
 
 	/* Insert this object in containing zspage's freelist */
@@ -1429,7 +1431,7 @@ static void obj_free(int class_size, unsigned long obj)
 		f_page->index = 0;
 	set_freeobj(zspage, f_objidx);
 
-	kunmap_atomic(vaddr);
+	kunmap_local(vaddr);
 	mod_zspage_inuse(zspage, -1);
 }
 
@@ -1492,8 +1494,8 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 	if (d_off + class->size > PAGE_SIZE)
 		d_size = PAGE_SIZE - d_off;
 
-	s_addr = kmap_atomic(s_page);
-	d_addr = kmap_atomic(d_page);
+	s_addr = kmap_local_page(s_page);
+	d_addr = kmap_local_page(d_page);
 
 	while (1) {
 		size = min(s_size, d_size);
@@ -1516,26 +1518,26 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 		 * Documentation/mm/highmem.rst.
 		 */
 		if (s_off >= PAGE_SIZE) {
-			kunmap_atomic(d_addr);
-			kunmap_atomic(s_addr);
+			kunmap_local(d_addr);
+			kunmap_local(s_addr);
 			s_page = get_next_page(s_page);
-			s_addr = kmap_atomic(s_page);
-			d_addr = kmap_atomic(d_page);
+			s_addr = kmap_local_page(s_page);
+			d_addr = kmap_local_page(d_page);
 			s_size = class->size - written;
 			s_off = 0;
 		}
 
 		if (d_off >= PAGE_SIZE) {
-			kunmap_atomic(d_addr);
+			kunmap_local(d_addr);
 			d_page = get_next_page(d_page);
-			d_addr = kmap_atomic(d_page);
+			d_addr = kmap_local_page(d_page);
 			d_size = class->size - written;
 			d_off = 0;
 		}
 	}
 
-	kunmap_atomic(d_addr);
-	kunmap_atomic(s_addr);
+	kunmap_local(d_addr);
+	kunmap_local(s_addr);
 }
 
 /*
@@ -1548,7 +1550,7 @@ static unsigned long find_alloced_obj(struct size_class *class,
 	unsigned int offset;
 	int index = *obj_idx;
 	unsigned long handle = 0;
-	void *addr = kmap_atomic(page);
+	void *addr = kmap_local_page(page);
 
 	offset = get_first_obj_offset(page);
 	offset += class->size * index;
@@ -1561,7 +1563,7 @@ static unsigned long find_alloced_obj(struct size_class *class,
 		index++;
 	}
 
-	kunmap_atomic(addr);
+	kunmap_local(addr);
 
 	*obj_idx = index;
 
@@ -1798,14 +1800,14 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	migrate_write_lock(zspage);
 
 	offset = get_first_obj_offset(page);
-	s_addr = kmap_atomic(page);
+	s_addr = kmap_local_page(page);
 
 	/*
 	 * Here, any user cannot access all objects in the zspage so let's move.
 	 */
-	d_addr = kmap_atomic(newpage);
+	d_addr = kmap_local_page(newpage);
 	copy_page(d_addr, s_addr);
-	kunmap_atomic(d_addr);
+	kunmap_local(d_addr);
 
 	for (addr = s_addr + offset; addr < s_addr + PAGE_SIZE;
 					addr += class->size) {
@@ -1818,7 +1820,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 			record_obj(handle, new_obj);
 		}
 	}
-	kunmap_atomic(s_addr);
+	kunmap_local(s_addr);
 
 	replace_sub_page(class, zspage, newpage, page);
 	/*
-- 
2.17.1


