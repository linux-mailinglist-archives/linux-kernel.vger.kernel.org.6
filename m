Return-Path: <linux-kernel+bounces-286852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2641F951FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD06C2824ED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2119E1B9B48;
	Wed, 14 Aug 2024 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KWWc+eVT"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15841B8E9A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652413; cv=none; b=fCEtUKOAS+eqbYo30m19WN4VywQGfMlO9JhE+4ET+7yijnnTfoo7QN8Vh+1G+kf+PwoOGWWpAeDCfiad347zd4YyJdWN1J9Q/zJT5zErgiIFvE2ALessE9jIGLt8A4cmuncK+MvymcuvJxNwPOcoJD2IDdBh2XFXosi3sAC9Ewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652413; c=relaxed/simple;
	bh=D8Ucs9Bh1lopemhqRc7BNj6MAS18JUVsIY1Cb29Lo84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQ5xqet3YRUzfh+hbxBRRaLauasJllBU4k38pEFv2rgTftjnWJHMg9juGMP7ucrUeJEKW+Wvk/Rj9uIaGnA1lJYsImdwgDKNEWEYplxqqAa8UHE7nxIytmLjBGMCD7wZjUVNOMad+xQxlcFDa0iTGrajx/waN+liU2hMHHcaiKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KWWc+eVT; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtcoM013696;
	Wed, 14 Aug 2024 16:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=D
	rUVd8Ocr4EBUKoIid60LZ74yaHvtLUZiDCAkpS+Tww=; b=KWWc+eVTxu1rIJZZ6
	rMAdO+mGNmNk95hmtiWDlW7kveyeWNruY/48N1MqXPGZN+LCrgVKJNKLTDBcoLQ/
	s84vE0/qtoH+DRCc05Q2GKEr1Ziza3BrRMgX8UGt1/Gtdrhkkj3L9TGfAAJVzSey
	hCzLsNujCb/OfYyKHJ3RZ4kJczgjNOfm9qsahwK98/uNGzEDxe5IDiryb8ihVfWi
	GbSYFcwoLe4tTDTb3mHfAS9xsE3BHxreCtRMhjYw9c2YjurDSzs/0AXbYY7pPHPH
	wDsOc9dilvekKHIdnqD3RevTq9d1y+JQWVP3EB+Rk8k8b5CoDMrAA/4P3PiqGfmz
	B1P/A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0rtrstq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EFqAgF021061;
	Wed, 14 Aug 2024 16:19:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxngn7jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:49 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47EGIvBw035951;
	Wed, 14 Aug 2024 16:19:48 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-174-212.vpn.oracle.com [10.65.174.212])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40wxngn7gt-2;
	Wed, 14 Aug 2024 16:19:48 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, surenb@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v4 01/17] maple_tree: introduce store_type enum
Date: Wed, 14 Aug 2024 12:19:28 -0400
Message-ID: <20240814161944.55347-2-sidhartha.kumar@oracle.com>
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
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=842
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408140111
X-Proofpoint-ORIG-GUID: _eke-QWlv1NOCLsekQJ5eHK2j9FpMEtH
X-Proofpoint-GUID: _eke-QWlv1NOCLsekQJ5eHK2j9FpMEtH

Add a store_type enum that is stored in ma_state. This will be used to
keep track of partial walks of the tree so that subsequent walks can
pick up where a previous walk left off.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/maple_tree.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index a53ad4dabd7e..8e1504a81cd2 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -148,6 +148,18 @@ enum maple_type {
 	maple_arange_64,
 };
 
+enum store_type {
+	wr_invalid,
+	wr_new_root,
+	wr_store_root,
+	wr_exact_fit,
+	wr_spanning_store,
+	wr_split_store,
+	wr_rebalance,
+	wr_append,
+	wr_node_store,
+	wr_slot_store,
+};
 
 /**
  * DOC: Maple tree flags
@@ -436,6 +448,7 @@ struct ma_state {
 	unsigned char offset;
 	unsigned char mas_flags;
 	unsigned char end;		/* The end of the node */
+	enum store_type store_type;	/* The type of store needed for this operation */
 };
 
 struct ma_wr_state {
@@ -477,6 +490,7 @@ struct ma_wr_state {
 		.max = ULONG_MAX,					\
 		.alloc = NULL,						\
 		.mas_flags = 0,						\
+		.store_type = wr_invalid,				\
 	}
 
 #define MA_WR_STATE(name, ma_state, wr_entry)				\
-- 
2.46.0


