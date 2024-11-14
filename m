Return-Path: <linux-kernel+bounces-409715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A52F9C9078
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECD628584B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996E818C028;
	Thu, 14 Nov 2024 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I15HK8i7"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589E5188708
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603942; cv=none; b=G2XAWa9376bEaQPXMaYGXQqhc+BkzxoJfHBIK2tCBCa+63JLS+CHaSi4OMUFH6Gzuzh8yAWbnRogquVJgU9ihpyQ50k9vWXhCrdMBFi+IlRgra5II+ihC8pk1uA4oumBD4PsV2ui/vrN5y4WyWSC9bwhlS/zs5nz697RYxWA0ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603942; c=relaxed/simple;
	bh=XcRT0zbjVfzNnZATSr6fZ9vc5Z1zY4bCUm7s0FzRid0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKFZS0E0WQsXMDp3QQGRhQcLdKJ4Bc3rqf80NGnsesm8Dkce3zrL8gIoNY0R/b4t3CCQFQRJZV1Yh9FOACSWZyErjX6jpfGxFbZiAPqeW8nnmn7SCdBoIQVEu5+3kJEyKe3iCJR0RVGxrL5p7fB13t61/LZvvbON+52pWQ62vrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I15HK8i7; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECwwRQ015665;
	Thu, 14 Nov 2024 17:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=7n8i7
	NEm1gSxP0N4uiNn0lAGElW5oeiIKP+aNCEbcoY=; b=I15HK8i7hsG0PDKMeAozq
	TJ2kPd9fpgiRXiYPzyKxxlpgyDqPVrKSFKp8h2zOrWIPVwyphFppHW5Qu1Pur2NJ
	ix4Jn8CmrY2exq7D7H9XKqXAmkLhd5Ki9AVzxTbKrKQXcVfFzNH46z3VjDz8ZmlO
	FqhwjuFfGWVX4OL/D3JuhGVrTeF/Dx+7vL4wa/1nEQ8QmNmct+xzFPodRbiH2Zdr
	scueIvKDFPbHHHUuvEW3MdYdMI8zisB6FoF3Ag2+aaOKIj571qdJA4AsQ81G6HdZ
	r5WXszi0fXuIxB6SCIIh5uO9Y7niRG0Q5vDBpUPMxipu2KxjsXuu28mCcdFfGsYz
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k29phr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:05:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEFZCp4022682;
	Thu, 14 Nov 2024 17:05:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw1jy98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 17:05:30 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AEH5QmP032739;
	Thu, 14 Nov 2024 17:05:30 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-39-201-66.vpn.oracle.com [10.39.201.66])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42vuw1jy5w-5;
	Thu, 14 Nov 2024 17:05:30 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 4/5] maple_tree: break on convergence in mas_spanning_rebalance()
Date: Thu, 14 Nov 2024 12:05:23 -0500
Message-ID: <20241114170524.64391-5-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241114170524.64391-1-sidhartha.kumar@oracle.com>
References: <20241114170524.64391-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=871 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140134
X-Proofpoint-ORIG-GUID: hAce8W2brrC5ZjcaybhLTlN17kwCsQrq
X-Proofpoint-GUID: hAce8W2brrC5ZjcaybhLTlN17kwCsQrq

This allows support for using the vacant height to calculate the worst
case number of nodes needed for wr_rebalance operation.
mas_spanning_rebalance() was seen to perform unnecessary node allocations.
We can reduce allocations by breaking early during the rebalancing loop
once we realize that we have ascended to a common ancestor.

Suggested-by: Liam Howlett <liam.howlett@oracle.com>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index f14d70c171c2..59c5c3f8db30 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2904,11 +2904,21 @@ static void mas_spanning_rebalance(struct ma_state *mas,
 		mast_combine_cp_right(mast);
 		mast->orig_l->last = mast->orig_l->max;
 
-		if (mast_sufficient(mast))
-			continue;
+		if (mast_sufficient(mast)) {
+			if (mast_overflow(mast))
+				continue;
+
+			if (mast->orig_l->node == mast->orig_r->node) {
+			       /*
+				* The data in b_node should be stored in one
+				* node and in the tree
+				*/
+				slot = mast->l->offset;
+				break;
+			}
 
-		if (mast_overflow(mast))
 			continue;
+		}
 
 		/* May be a new root stored in mast->bn */
 		if (mas_is_root_limits(mast->orig_l))
-- 
2.43.0


