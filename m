Return-Path: <linux-kernel+bounces-357320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F225996FB9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9174B1C21F12
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DC91E1A10;
	Wed,  9 Oct 2024 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="awaWthG+"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BCF1E133F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487236; cv=none; b=YlaIfOuzhedfZQJUeoIBqPj3j5mn78IajM2NqDmj4IDnh2oSUtJUaD02aJ1aajVOI6JEWmQBdH5bcpzo9KOkR6xz/XUynGxyjEA/65p504jeXT83TXwZuLqZgz8yBUva0CnqdjaKXT4eXt5m2KdioVE9AnSnaSnEM39LWLZLfa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487236; c=relaxed/simple;
	bh=j82239oWEOEbqR2Q0C352NPUpn5HJfDiSYxCTRU1L5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sn7NQrMDuxSCk9CBkpMSyiUMC4bDgJPYn07//XJyktETTWQ2+PhWD2i5A7zjO6OIP+pNaW4c9wVdM1Q5I5MBlejN5TXsprFslZl0Zs+/dYN8H7fC1yPvGf2KyKWdCcg0KPMBPThqbOzYCgOnXdZfID/RMX4GFVQXXS8yddSlZ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=awaWthG+; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499Eu9H6015997;
	Wed, 9 Oct 2024 15:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=HlHl6ChjHbnuvgtCTGs0ivDwGXG0c
	XdbfUONSFCyc5Q=; b=awaWthG+OdkEZPf7DFC/4l36q9PN+ufdPc7Onl4d9X0wh
	RZxXMW3LQC5cRnKVJ2gY0py60cEW/Mr//DQ7n8t+eAcUCNAAq/zna8Wu5lPOexP+
	hNQrkTgYtHP4LXq0PeTvMBPylgTeHvf1Pc7Csr8j/QcDK8CMZ9QsImqsTl9yUSgG
	BVI07eg2aE5kKbYVmA7gcoiRGqFxd+o3VMYdNTx9LJ1Ypj+SmEnpaV6/FQXO2PdS
	lVAsayf5t5atJ3XJPPyKx1Xc7kkZbhKVAxF1143XqjYKRvehcrH+jj1EydcdVOnQ
	2A3IpdNBPGTlwx4Jo/ddhC3NPPaedYti6p+/68vjw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300e0n2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 15:20:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499E1CA3015276;
	Wed, 9 Oct 2024 15:20:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw8rb4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 15:20:13 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 499FKCC1001460;
	Wed, 9 Oct 2024 15:20:12 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-39-198-16.vpn.oracle.com [10.39.198.16])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 422uw8rb23-1;
	Wed, 09 Oct 2024 15:20:11 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, richard.weiyang@gmail.com,
        Sidhartha <sidhartha.kumar@oracle.com>
Subject: [PATCH] maple_tree: remove conditionals to detect wr_node_store
Date: Wed,  9 Oct 2024 11:20:07 -0400
Message-ID: <20241009152007.2096-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_14,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090095
X-Proofpoint-GUID: NyHvPBSqz9i1BDNvvD4hoG0zoFxVMeUa
X-Proofpoint-ORIG-GUID: NyHvPBSqz9i1BDNvvD4hoG0zoFxVMeUa

From: Sidhartha <sidhartha.kumar@oracle.com>

In mas_wr_store_type(), we check if new_end < mt_slots[wr_mas->type]. If
this check fails, we know that ,after this, new_end is >= mt_min_slots.
Checking this again when we detect a wr_node_store later in the function
is reduntant. Because this check is part of an OR statement, the statement
will always evaluate to true, therefore we can just get rid of it.

Suggested-by; Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 4b423330d83c..f5a12d37b352 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4252,14 +4252,7 @@ static inline void mas_wr_store_type(struct ma_wr_state *wr_mas)
 		return;
 	}
 
-	if (mte_is_root(mas->node) || (new_end >= mt_min_slots[wr_mas->type]) ||
-		(mas->mas_flags & MA_STATE_BULK)) {
-		mas->store_type = wr_node_store;
-		return;
-	}
-
-	mas->store_type = wr_invalid;
-	MAS_WARN_ON(mas, 1);
+	mas->store_type = wr_node_store;
 }
 
 /**
-- 
2.43.0


