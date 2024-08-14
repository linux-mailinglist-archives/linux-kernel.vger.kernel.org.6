Return-Path: <linux-kernel+bounces-286863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7540951FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA2C2823E1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1FD1BDAAC;
	Wed, 14 Aug 2024 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IFROYWw4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6786F1B8E9A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652419; cv=none; b=ZLkqQgDG3EXZ4l8Vv5LMVCc79d6bMX336W06dIQTKkz7Ok/E6w/O8Pe4gXh0kObOLuy6OVlSd5AIz3uo9kcxM9xlV8SPEG/rkDk/XM4oCo4YbB6WBNTPw2jnGgUfU3rg+yLGEcnlUKJwqPPwTDOUVqsJC6irDYERYB7zeLO22NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652419; c=relaxed/simple;
	bh=y95hEubGR0pbOqCq9U4CRc7XxhgxliXhemfFZXidLOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSb1E0JnWS3lpj2GhSLXfdDzqpqpU3Q2ChWRAQ2UCmtY/moOhfSGI8/kXLnKbIqT73t4KhkR/A7NlKSUyLtfkragkef9NjpiCF6gHCnYbs/w131JD31d9aPBFm7j3s/GeFM2TWKKyUkV1UbZ9ZyDagmDL+ZMBBEa0a8jLFFxQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IFROYWw4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtcGU013664;
	Wed, 14 Aug 2024 16:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=+
	5J3K/HmIJpRQS4W/uJ6jgAlZokAeNKvisghgsHFKU0=; b=IFROYWw4SAoarkD55
	MsNWVCctGE1pd0Ew5UTbymaONaxdBjtebyEa1n9/wmDF7dL9VA+78p/CiBLM1QLy
	RN0SlPWgVdVlsXyvvH7x5IDFT2F6w9l88oy31lr2Rmw4fEnxQnzaJC4OZKtw1YND
	USS7MFTPH9KhRI95sA7zwQBX53ZjqTxd0lrJyw8MmsyGI7M8+R5/q2G3kv7TooVY
	5LJCZI+Eaj33ff7mA4OPi2niFDwJe+ccna+AMx+kqquYM1CIqQmRZCCM7htljCML
	/vsjMAM06danwcyZc7rT3n5gic5IN9HnKUJA7PlXTWvvL28YVW1hutQk+ius1Spl
	Nfw8w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0rtrsty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EExw9p020871;
	Wed, 14 Aug 2024 16:19:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxngn7p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:54 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47EGIvCC035951;
	Wed, 14 Aug 2024 16:19:53 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-174-212.vpn.oracle.com [10.65.174.212])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40wxngn7gt-9;
	Wed, 14 Aug 2024 16:19:53 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, surenb@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 08/17] maple_tree: print store type in mas_dump()
Date: Wed, 14 Aug 2024 12:19:35 -0400
Message-ID: <20240814161944.55347-9-sidhartha.kumar@oracle.com>
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
X-Proofpoint-ORIG-GUID: KemaFXtiYByeyAQpqzfRLHYt45KvpHLk
X-Proofpoint-GUID: KemaFXtiYByeyAQpqzfRLHYt45KvpHLk

Knowing the store type of the maple state could be helpful for debugging.
Have mas_dump() print mas->store_type.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e01e05be6301..a1689fc6227b 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -7760,6 +7760,40 @@ void mas_dump(const struct ma_state *mas)
 		break;
 	}
 
+	pr_err("Store Type: ");
+	switch (mas->store_type) {
+	case wr_invalid:
+		pr_err("invalid store type\n");
+		break;
+	case wr_new_root:
+		pr_err("new_root\n");
+		break;
+	case wr_store_root:
+		pr_err("store_root\n");
+		break;
+	case wr_exact_fit:
+		pr_err("exact_fit\n");
+		break;
+	case wr_split_store:
+		pr_err("split_store\n");
+		break;
+	case wr_slot_store:
+		pr_err("slot_store\n");
+		break;
+	case wr_append:
+		pr_err("append\n");
+		break;
+	case wr_node_store:
+		pr_err("node_store\n");
+		break;
+	case wr_spanning_store:
+		pr_err("spanning_store\n");
+		break;
+	case wr_rebalance:
+		pr_err("rebalance\n");
+		break;
+	}
+
 	pr_err("[%u/%u] index=%lx last=%lx\n", mas->offset, mas->end,
 	       mas->index, mas->last);
 	pr_err("     min=%lx max=%lx alloc=%p, depth=%u, flags=%x\n",
-- 
2.46.0


