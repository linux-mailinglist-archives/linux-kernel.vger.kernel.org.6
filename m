Return-Path: <linux-kernel+bounces-537291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 561AEA48A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D22C7A617F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BE827128C;
	Thu, 27 Feb 2025 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PBhhTmil"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B46B270ED8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740689322; cv=none; b=TkepDPHQ9hMAbhrrDete+jjhNbDoi0BJGJAI7Ebyq5fpdFVP4Bx0flEWl8DUz3/CLZHpeW4F+Ry/mQBI1OH34NSUzhLvOaxfk9wDoJm254nUamrp6Ez0OpZW7qv74BJ4rs/Xsag8yA+Ph0bxuKROtbo8PZJT9GEH/IDdekM6Q5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740689322; c=relaxed/simple;
	bh=cnu25XFWA4Swo2UQVm1Cw7Zk8/bBwx94Ih7mkOo5ZXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6OS1ZKsXwNwkzKC3Ea625qn88X74UZalW1BIoOnDBAevv2fE+Y1T5Y2gFhw9abo1hK2j1oKnd2de1tp+JuP+UZffx+ycKjZlOjYxjDDjONTHV2blAW14cG5XHHvv9gpEV8kAwq9+48kwlOHIQvR1pOj7fnAy8AP2Bl4dlJv1Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PBhhTmil; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RJiZdN019264;
	Thu, 27 Feb 2025 20:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=axDkg
	HvhakXDWLjLRooU6nhITyeHLZk+oAMXqWkly/0=; b=PBhhTmilyd9IYSeYhZc6a
	iJyzgxRRaT/PeQgr/CCixYuGZZSTM3wW/Xh5sl93AC0FGP//ewS6utQZmgRMtFwl
	CVzMBdJfwArOQhwoppWVm9HOA8xiTDxfDWL8pjdW2sAGsAY9ZUoX6Q+eaqcH4Sm7
	JRBTqv3X+vf5tcsCn23I/7bKa8/4gcTFVnH0gKlkmXAT7rIbkdGoLA9XYWuqX4hu
	D+vU29VZRhA8PrXUiZAU3JSQUAyOYONYTS8sTYc6durXdZkx4B6yPoMR4Lkp6squ
	cH70G6CK4uL573eNanO3qb4QOicjA5NkeUG5YWj7K6+mDBGwwXMusoHre7u8F919
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf4cp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 20:48:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RKV9Pl012574;
	Thu, 27 Feb 2025 20:48:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51dws5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 20:48:33 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51RKhrvk030883;
	Thu, 27 Feb 2025 20:48:33 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44y51dwrvc-5;
	Thu, 27 Feb 2025 20:48:32 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        richard.weiyang@gmail.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v3 4/6] maple_tree: break on convergence in mas_spanning_rebalance()
Date: Thu, 27 Feb 2025 20:48:21 +0000
Message-ID: <20250227204823.758784-5-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227204823.758784-1-sidhartha.kumar@oracle.com>
References: <20250227204823.758784-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502270154
X-Proofpoint-ORIG-GUID: qbzTOSdHShzfMYbSFjzmfG_Qc6PIheuw
X-Proofpoint-GUID: qbzTOSdHShzfMYbSFjzmfG_Qc6PIheuw

This allows support for using the vacant height to calculate the worst
case number of nodes needed for wr_rebalance operation.
mas_spanning_rebalance() was seen to perform unnecessary node allocations.
We can reduce allocations by breaking early during the rebalancing loop
once we realize that we have ascended to a common ancestor.

Suggested-by: Liam Howlett <liam.howlett@oracle.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 878a7740628c..c859c7253d69 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2899,11 +2899,24 @@ static void mas_spanning_rebalance(struct ma_state *mas,
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
+				/* May be a new root stored in mast->bn */
+				if (mas_is_root_limits(mast->orig_l))
+					new_height++;
+				break;
+			}
 
-		if (mast_overflow(mast))
 			continue;
+		}
 
 		/* May be a new root stored in mast->bn */
 		if (mas_is_root_limits(mast->orig_l)) {
-- 
2.43.0


