Return-Path: <linux-kernel+bounces-283638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 217BC94F734
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB171F224F7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B38619047C;
	Mon, 12 Aug 2024 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ybjwyw+R"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A7018EFE0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489570; cv=none; b=HZu9GNldIQ87vW9pBV8sMReijX1GohFgf4DNkWSN9BfsOGbEbeWJ2/u+s/HDlq5Gn9hkKLKBjIQ7FTED2Gc7nxJHnpaebA/l/RVuTYZ05yrX9nQlScUdj0YP+pobCL4EXEFsiR2stZCv1YuodS3quEJrdNjh5RnHtDyp4XZIWeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489570; c=relaxed/simple;
	bh=VCJaC4baszSI+pWDZXSkcjGNzE7fmxa8zgCFN9kUHYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aXjT3rfv+7Xt0FSzYe15bKqb+bniinklBa6gMdP2i0vLIbMLEztT4YgNxiW0mLky6AgaTeqs+SmjSlKQRGcRzGajSJTPJk/HdJDnWvlekTlNK6p8HsKQxFegKrTOrgZLtrgcp6Ll5bSUqhNuESoM56cD8NKPqnQwL7Pzgl3Uw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ybjwyw+R; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CHXVMA007029;
	Mon, 12 Aug 2024 19:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=hzJpDomWqI4XAK
	H5M6JOzCbongljBXfxlpCrhMR2RbI=; b=Ybjwyw+RMoaTJfi0g6NaelslofkTpP
	yt7GSIAJN4TuOVEhY2INVgr8SSWDE+ypgAUZbca18RG1gPY3f+RmZN4KcimsX90i
	fnE75pYtKIvWTKoF3WVvgFKrX4Cz3M9P8PI2j5sgdLt2P0pQ54BswD+DLmGVL+ZX
	+UfQnLbsA7EvtMKEvHy2psvMZlXXICzMTru15xdOeMGzvRJkWOBz4NHhaikOThj6
	SzFut2jr+ZVDkuN72s5/6IQ7fyA11dot/aplvfLel2Ik+wCaa70eMXlPY9PYzl0M
	Tc5cVvjzqIBtZPRi40X8PCwnXKbdaf4SlKI6DwsjR7IvtOEXNiNpo2MA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxmcud7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 19:05:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47CIhSbd017606;
	Mon, 12 Aug 2024 19:05:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn8dfcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 19:05:48 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47CJ22Kf022973;
	Mon, 12 Aug 2024 19:05:48 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-176-210.vpn.oracle.com [10.65.176.210])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40wxn8dfa3-1;
	Mon, 12 Aug 2024 19:05:48 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 1/2] maple_tree: reset mas->index and mas->last on write retries
Date: Mon, 12 Aug 2024 15:05:42 -0400
Message-ID: <20240812190543.71967-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408120141
X-Proofpoint-ORIG-GUID: 6I9s2c9p3OEU8v8FvF9ViXXLFMoqIjAi
X-Proofpoint-GUID: 6I9s2c9p3OEU8v8FvF9ViXXLFMoqIjAi

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
v1 -> v2:
        - re-initialize index and last in the mas_nomem() if statement so
          fast path is not effected in mas_erase().

        - use __mas_set_range() rather than set mas->index and mas->last
          directly.

 lib/maple_tree.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index aa3a5df15b8e..b547ff211ac7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5451,14 +5451,19 @@ EXPORT_SYMBOL_GPL(mas_store);
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
+		if (!entry)
+			__mas_set_range(mas, index, last);
 		goto retry;
+	}
 
 	if (unlikely(mas_is_err(mas)))
 		return xa_err(mas->node);
@@ -6245,23 +6250,26 @@ EXPORT_SYMBOL_GPL(mas_find_range_rev);
 void *mas_erase(struct ma_state *mas)
 {
 	void *entry;
+	unsigned long index = mas->index;
 	MA_WR_STATE(wr_mas, mas, NULL);
 
 	if (!mas_is_active(mas) || !mas_is_start(mas))
 		mas->status = ma_start;
 
-	/* Retry unnecessary when holding the write lock. */
+write_retry:
 	entry = mas_state_walk(mas);
 	if (!entry)
 		return NULL;
 
-write_retry:
 	/* Must reset to ensure spanning writes of last slot are detected */
 	mas_reset(mas);
 	mas_wr_store_setup(&wr_mas);
 	mas_wr_store_entry(&wr_mas);
-	if (mas_nomem(mas, GFP_KERNEL))
+	if (mas_nomem(mas, GFP_KERNEL)) {
+		/* in case the range of entry changed when unlocked */
+		mas->index = mas->last = index;
 		goto write_retry;
+	}
 
 	return entry;
 }
-- 
2.46.0


