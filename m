Return-Path: <linux-kernel+bounces-286864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1529951FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455581F22FEC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446401BDAB9;
	Wed, 14 Aug 2024 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="loFM2EoE"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9897B1BC07D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652419; cv=none; b=lbXp8WoeakzTzr2HXt8MyQ6ZEyg22fV3PHD8k3YBlmQ49vGVx6UiIPKVtMoS1wTiKYu/Z933KFmK3Q+2fp56nUBsa2/ZaaQm2PZeFtW4KyGadUpUY/77B3afW3RLD0BhM5SsMfg+EksOOKm3sMcst8r0BUYAVKBU5IYLIQP6TQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652419; c=relaxed/simple;
	bh=VASC67UsmzFAV8P/Pc7gQjTBtms2a8JSvjDFzuHFsjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrQIyNKvKhAvKBipx7bviTLXZrTGRep4QiU7V1cTO1KKD1D+SVy1ASc1cmjTE5A1B110w54U00mFfYwxPitOEZrBje7PNoy+4tY3pFU6A2IPWekhXx5k8K/jFkfccUMTw9ueDOe0jI6rDDT5tDfQDYoYef2TqnO/eOVm+bZxOig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=loFM2EoE; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtcB3006144;
	Wed, 14 Aug 2024 16:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=o
	jgvkVfomFPmyla9upDrqtBp4pUg5X73oMV30GnXzGs=; b=loFM2EoEus7A6VxsC
	HhRGiBXieoRciWl2FxqxJ4XUp7WSIQycNsvNGmTK4bhzG6AdaBKnk/nI4v+n8L0f
	r7W/rvkzpHrzdT98NoK1n2mLH6BqkAExXFs/1GkoVTYLLAdjYLP3ISHPG7Q6bhR8
	uR+X2CUTjoH3Wj8JwAXdqNgbeMh3FY23COdEts49GVtrHJIgaDkkWbTmyHdWOMRD
	PtoC4h0zXzvQQy9IXxqvsolqBM640uka4DMP+GmZPBjd/kQ3iA4cLiqibR+4mxci
	YJmQ7N3zrNp5lk/0Lu7cfLFvWDkI7xc+yGSfevZIMNVGqVKzTLuTquzzn9CBQ9SW
	tu3zQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy4bguba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:20:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EG72um021274;
	Wed, 14 Aug 2024 16:19:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxngn7ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 16:19:59 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47EGIvCQ035951;
	Wed, 14 Aug 2024 16:19:59 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-65-174-212.vpn.oracle.com [10.65.174.212])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40wxngn7gt-16;
	Wed, 14 Aug 2024 16:19:59 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, surenb@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v4 15/17] maple_tree: remove repeated sanity checks from write helper functions
Date: Wed, 14 Aug 2024 12:19:42 -0400
Message-ID: <20240814161944.55347-16-sidhartha.kumar@oracle.com>
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
X-Proofpoint-GUID: ZCBd3Df6Kl7Nj28ZCgCzu7Yk76nJyfKX
X-Proofpoint-ORIG-GUID: ZCBd3Df6Kl7Nj28ZCgCzu7Yk76nJyfKX

These sanity checks are now redundant as they are already checked in
mas_wr_store_type(). We can remove them from mas_wr_append() and
mas_wr_node_store().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 5f79be184377..8c1a1a483395 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3816,11 +3816,6 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
 	unsigned char copy_size, node_pivots = mt_pivots[wr_mas->type];
 	bool in_rcu = mt_in_rcu(mas->tree);
 
-	/* Check if there is enough data. The room is enough. */
-	if (!mte_is_root(mas->node) && (new_end < mt_min_slots[wr_mas->type]) &&
-	    !(mas->mas_flags & MA_STATE_BULK))
-		return false;
-
 	if (mas->last == wr_mas->end_piv)
 		offset_end++; /* don't copy this offset */
 	else if (unlikely(wr_mas->r_max == ULONG_MAX))
@@ -4018,17 +4013,9 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
 static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
 		unsigned char new_end)
 {
-	struct ma_state *mas;
+	struct ma_state *mas = wr_mas->mas;
 	void __rcu **slots;
-	unsigned char end;
-
-	mas = wr_mas->mas;
-	if (mt_in_rcu(mas->tree))
-		return false;
-
-	end = mas->end;
-	if (mas->offset != end)
-		return false;
+	unsigned char end = mas->end;
 
 	if (new_end < mt_pivots[wr_mas->type]) {
 		wr_mas->pivots[new_end] = wr_mas->pivots[end];
-- 
2.46.0


