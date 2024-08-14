Return-Path: <linux-kernel+bounces-286858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF75951FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F3C6B2DE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BA71BA881;
	Wed, 14 Aug 2024 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UQ8J287A"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59291BB6B8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652417; cv=none; b=rmInvoF6GQ25IRFM6iUK7IDtKVW/OdIr4HlUVOTDh6CfSRd99zXRnACT8TtG7lvFqYBXKn8NxXZVYJXnhr69oqdmlfkQwiPxgNLCcz+dg8SaWNpxooR9Oh1rtJmDkQgmJX2WRNTRQHkW3Sjj+slI5IsZ4iBBYtc8mZuSgaqmluk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652417; c=relaxed/simple;
	bh=hgTl9lTsUAZQPOBhbpnRHATV+4ZngYvMLBpZVaFNA1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Udg2bHny1dpgZjOWeGk+lg1ZLE7sLAgvYgjBINLgEtud3t6Gj6xdHArnhAylCxtKS0s0Ju/0ZeRu5pOMiZGprkumXrrHn/UQ0pD7zb5epdqdJ0Nxm+4f/QsIrDWEZ+q1qK+7QhllhSNSvHKl+aIelNHY03xJRHaXpu+wjMaYHOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UQ8J287A; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtalC006074;
	Wed, 14 Aug 2024 16:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=N
	hGg+QKJ9Cb1suH4rctcJIF6xt0s6tIqw024945p4eA=; b=UQ8J287A/AK9Npdca
	Ov+rZCRM4dgCcSXUfpGm84RWxkYYxYYssKGns1NKr0ItzsbSHF9lmwirr5VKyniI
	/M9TmqrVfy0o2Ob6Dt5iJWyqJeNG4E2ZDP9llT7HdyCQW4PLQa6e98BGt9dGeNXd
	TwXAydt/g2mH8i83e3bAWTk6kJ9wdkly+O1de+NUhgO/HqLHDFDznLwgP6F2MnZU
	xDeq/iBA722OU93t7r0P4LL755kLaIzODQv6CXdPfZkn1AD3hywkAhC9gwqoP66n
	KjdnC2YpA5Z1eACJvqvyvaDpgBWSvFncIGOOTS4tb6mYbZXHErW98wNaOmgdPFfj
	r5OXg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy4bguaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EFoG8V021115;
	Wed, 14 Aug 2024 16:19:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxngn7k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:49 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47EGIvC0035951;
	Wed, 14 Aug 2024 16:19:49 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-174-212.vpn.oracle.com [10.65.174.212])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40wxngn7gt-3;
	Wed, 14 Aug 2024 16:19:49 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, surenb@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v4 02/17] maple_tree: introduce mas_wr_prealloc_setup()
Date: Wed, 14 Aug 2024 12:19:29 -0400
Message-ID: <20240814161944.55347-3-sidhartha.kumar@oracle.com>
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
X-Proofpoint-GUID: XJ_CCdNwqMeWJj7i_OdRelDsnSBxqvoX
X-Proofpoint-ORIG-GUID: XJ_CCdNwqMeWJj7i_OdRelDsnSBxqvoX

Introduce a helper function, mas_wr_prealoc_setup(), that will set up a
maple write state in order to start a walk of a maple tree.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 884e2d130876..407c0be6e42f 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5399,6 +5399,13 @@ static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
 	mas_reset(wr_mas->mas);
 }
 
+static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
+{
+	struct ma_state *mas = wr_mas->mas;
+
+	mas_wr_store_setup(wr_mas);
+	wr_mas->content = mas_start(mas);
+}
 /* Interface */
 
 /**
@@ -5509,8 +5516,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 	if (unlikely(!mas->index && mas->last == ULONG_MAX))
 		goto ask_now;
 
-	mas_wr_store_setup(&wr_mas);
-	wr_mas.content = mas_start(mas);
+	mas_wr_prealloc_setup(&wr_mas);
 	/* Root expand */
 	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
 		goto ask_now;
-- 
2.46.0


