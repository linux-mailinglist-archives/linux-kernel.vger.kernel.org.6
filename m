Return-Path: <linux-kernel+bounces-200333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B425C8FAE7F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E9A1F24C7C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2232142651;
	Tue,  4 Jun 2024 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ddFR8wsg"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D731428F5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492534; cv=none; b=QiY3Lwr8Yct4E6/+mOJLRhUQQBezcWeaFA8H13NUvZu842S1gCT1im1PBq8Ip8GGbEla5qYxZNwBTkiecWpDrb5ZLvpzMyBmF+AFHnAF2hTvqvYz6HwhE1mabPh/8GeHVVR3C+ICesS/mlWf7KjNeKODutyMl3RmnTm/iQj71Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492534; c=relaxed/simple;
	bh=Nta7iN+WFvRet05k6qlyoPpxSdKuLhWbm5NL+lqsFH4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=twFEIz08mxdXyUMtWybwZCNKHZs/4VFbPak4gE2lZhvQdJ/ZANarcL+Qdrrm2reAlNfUVAWeKnSdMxD+C5jFh0SMlipiOSpJRgaMnUGoPwLxUD5584nI50mYUL4e1rr9jwROMNDIY3Jg1oifXhb9f9Zg+EH1Wpdp1LN8GeGZdV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ddFR8wsg; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=OttNBT7tDdR+8AIHQK
	EdCnsXbEagpDW5BlvkbCVKymI=; b=ddFR8wsgl8hZrgVsG8OTgCSXkrFUJhIVwf
	v2H66v3QqIt65zB3rSIOvAhmve4LvEWC4aaldZKPoTqKc1DxuoB69mulzhyjTf0b
	ano9jtjGSmJBeM0gt1pPqvoNayaB5ghn7hz1u40wOOT0NNfN1FDr3aAHKfhWKuqW
	U86hDftYk=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [118.242.3.34])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wAnFS7u2l5mNA2KAQ--.319S2;
	Tue, 04 Jun 2024 17:14:23 +0800 (CST)
From: yangge1116@126.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	baolin.wang@linux.alibaba.com,
	liuzixing@hygon.cn,
	yangge <yangge1116@126.com>
Subject: [PATCH] mm/page_alloc: skip THP-sized PCP list when allocating non-CMA THP-sized page
Date: Tue,  4 Jun 2024 17:14:20 +0800
Message-Id: <1717492460-19457-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wAnFS7u2l5mNA2KAQ--.319S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFykXw18Ww1DXFy8GF1UAwb_yoW8XryxpF
	Wxua4jyayfXw13Ca97J3Wqkrsxuw4vgFWUCF4fXw1UZw13ta1293s7GF90vF1fAr98AF18
	tr4ktr95ZF4qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jxJ5rUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiGBPzG2VLblbknQABsN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: yangge <yangge1116@126.com>

Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
THP-sized allocations") no longer differentiates the migration type
of pages in THP-sized PCP list, it's possible to get a CMA page from
the list, in some cases, it's not acceptable, for example, allocating
a non-CMA page with PF_MEMALLOC_PIN flag returns a CMA page.

The patch forbids allocating non-CMA THP-sized page from THP-sized
PCP list to avoid the issue above.

Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for THP-sized allocations")
Signed-off-by: yangge <yangge1116@126.com>
---
 mm/page_alloc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2e22ce5..0bdf471 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2987,10 +2987,20 @@ struct page *rmqueue(struct zone *preferred_zone,
 	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
 
 	if (likely(pcp_allowed_order(order))) {
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+		if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
+						order != HPAGE_PMD_ORDER) {
+			page = rmqueue_pcplist(preferred_zone, zone, order,
+						migratetype, alloc_flags);
+			if (likely(page))
+				goto out;
+		}
+#else
 		page = rmqueue_pcplist(preferred_zone, zone, order,
 				       migratetype, alloc_flags);
 		if (likely(page))
 			goto out;
+#endif
 	}
 
 	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
-- 
2.7.4


