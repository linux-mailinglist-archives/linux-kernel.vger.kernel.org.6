Return-Path: <linux-kernel+bounces-286861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40AE951FB7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67FD1C216C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730FA1BD4E1;
	Wed, 14 Aug 2024 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F3mLM2xR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603D91BBBD5
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652418; cv=none; b=HrNWUbu09yWB21ehIwqk4dn/dGQCbUh1Ft1LrroXoeKGw/bl66NMOPgGSf8VfQMoC3O9ZFeTkZ3M9Of9fgl+t5FHoHxoowIAqz51ZewKhxk0wjZSzLi7id7jMIBwy6ql4/poiPabJqoXOSeVnEswITFNnF8/llAfKEXXuKgoPms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652418; c=relaxed/simple;
	bh=2s4IC5pYDSTMzQiB8qMbWtOgC/W2n0jWmWxSLixhBbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3Z6uzH5gwqUj7+rCSOZma2b5JWxT/fSY3AH8Kh7pXdAza35Hv23/WIptNFrySx0quMIlZ5//ahAxUF6RgE7sCIC9qrn9yrZY0KUP9Y9SlIsstRwnxJF5lYC5/6JEPP+3CnT2PS8i+I5APcmyY7W1gJuxWh4alOv1N4j/91yp+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F3mLM2xR; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtWAs015137;
	Wed, 14 Aug 2024 16:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=y
	QLRA/Ga16U7VMfZQaR29Wpf+8YrtU3+vrypmAwrPwY=; b=F3mLM2xR4tJ3Oq+yS
	Z6ZG4TQX6FgoktAaKwRIiQ2RwkyHITAtmNWhllAFHYq8TDsWJCV8nQGV0iMiw7Sy
	1A/eFAAXojAnoTXeiip2NCWbq5Mcp4WoFZ6x6GHdbUvH5CJkiMH269kO78MGveuO
	FShW7X+nLVVzrgD2rtesW/YSWmtwNH9vkui/mmoQbaRHY6BqWZeyFTFdm6vTbjZX
	HzPGiHln13VHhEPsLdBFvAYIHtNB2vsXe+S1zkhNmpRzhdZCwdLv7HMHDN6sX9Th
	bAKDvXXRfc6gorraHM5btgJn4L+uzx6yKt8sy6Z292px5dTuMpcSAeqz5HqPy7iN
	+5ShQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy030v8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EFCIm0021084;
	Wed, 14 Aug 2024 16:19:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxngn7nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:53 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47EGIvCA035951;
	Wed, 14 Aug 2024 16:19:53 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-174-212.vpn.oracle.com [10.65.174.212])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40wxngn7gt-8;
	Wed, 14 Aug 2024 16:19:53 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, surenb@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 07/17] maple_tree: use mas_store_gfp() in mtree_store_range()
Date: Wed, 14 Aug 2024 12:19:34 -0400
Message-ID: <20240814161944.55347-8-sidhartha.kumar@oracle.com>
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
X-Proofpoint-GUID: a4z5tUvF5q0S00dZBPlU9FsYu2pVjaT8
X-Proofpoint-ORIG-GUID: a4z5tUvF5q0S00dZBPlU9FsYu2pVjaT8

Refactor mtree_store_range() to use mas_store_gfp() which will abstract
the store, memory allocation, and error handling.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 8ba52ffa778e..e01e05be6301 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6476,7 +6476,6 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
 		unsigned long last, void *entry, gfp_t gfp)
 {
 	MA_STATE(mas, mt, index, last);
-	MA_WR_STATE(wr_mas, &mas, entry);
 	int ret = 0;
 
 	trace_ma_write(__func__, &mas, 0, entry);
@@ -6487,17 +6486,9 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
 		return -EINVAL;
 
 	mtree_lock(mt);
-retry:
-	mas_wr_store_entry(&wr_mas);
-	if (mas_nomem(&mas, gfp))
-		goto retry;
-
+	ret = mas_store_gfp(&mas, entry, gfp);
 	mtree_unlock(mt);
 
-	if (mas_is_err(&mas))
-		ret = xa_err(mas.node);
-
-	mas_destroy(&mas);
 	return ret;
 }
 EXPORT_SYMBOL(mtree_store_range);
-- 
2.46.0


