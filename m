Return-Path: <linux-kernel+bounces-356713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B073996589
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C27B280FB3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18FA18C35C;
	Wed,  9 Oct 2024 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fI8dnVq+"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA86A18BC0F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466299; cv=none; b=dKY3vdWhpdY2hWTlSx9orVJQ4ArZ8xy+YMoGLDCTJbjhTZIj9kDi+2xuJPTlL9wy5te0vqge6KQylgPTz9IE1bcSKZMt3QXyWrvwGaldeR3jnjDL2bapSZDFeHd9ayOfOIEJLKVgmCVHhceDLF+s+kOarpO1x7w0JDQTPXdbPfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466299; c=relaxed/simple;
	bh=zA7QvVvUDfLW5xwEFaku8RV4IBbqZflwD3WDG66Y7Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=EVciq9OQFQH7JRbX0LcHfO1cQyYPoSUFSBX8NYfqHEcuhE/PH93d6rsIJ/5EWVgyijjYmqM/SflqGZZIEHBpA+bwc2p+awf4IXn0/jNoYLf9/YwxWWkgiqZwBnAnNh7K2jt3qWjE/L7tEitVLatW6Z3apt8mdSOxN/ek6VnGvHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fI8dnVq+; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241009093134epoutp018b43a02fa4022b956939b6ca9366f2ca~8vu-wwTf12461824618epoutp01m
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 09:31:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241009093134epoutp018b43a02fa4022b956939b6ca9366f2ca~8vu-wwTf12461824618epoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728466294;
	bh=oX/xDr/GpkwH1kksizyq2v7s48YFwPwJfaCX7lWkAtQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=fI8dnVq+9++AZxNXhZ1rqUSwVmcdVRLXgq7GZiBal2IPl2+pnl1z1UGDowKeYoC8e
	 7tKaax/DVm7jUJkjbiddvIGFY7X9lkUnrsl7n8HT9rFTTma5sq2q9bQ+SZH9j/WvRw
	 cv4QJ90P6oraUlQJZaGg8+9PzwQOdcCOO2IPS8kA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241009093134epcas1p278d42a80cd82ad75cc1f01e5ed8c9b8d~8vu-Hmn4a2663326633epcas1p2z;
	Wed,  9 Oct 2024 09:31:34 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.243]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4XNnhP4pp6z4x9Pw; Wed,  9 Oct
	2024 09:31:33 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	AA.B6.09435.57D46076; Wed,  9 Oct 2024 18:31:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20241009093133epcas1p39b770ebcc6d2d78cad2f9a522bc6f179~8vu_dYqFf2390323903epcas1p3g;
	Wed,  9 Oct 2024 09:31:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241009093133epsmtrp1a4cb4253506fe0074259bd07e4b661a9~8vu_cllo63181131811epsmtrp1I;
	Wed,  9 Oct 2024 09:31:33 +0000 (GMT)
X-AuditID: b6c32a36-ac7ff700000024db-a7-67064d75728d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EF.0F.08229.57D46076; Wed,  9 Oct 2024 18:31:33 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.104.99]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241009093133epsmtip16f38b25a25350c4203e39640aeaa3068~8vu_T_3Pp1931019310epsmtip1M;
	Wed,  9 Oct 2024 09:31:33 +0000 (GMT)
From: Jaewon Kim <jaewon31.kim@samsung.com>
To: sj@kernel.org, minchan@kernel.org, vbabka@suse.cz,
	kaleshsingh@google.com, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH] vmscan: add a vmscan event for reclaim_pages
Date: Wed,  9 Oct 2024 18:31:24 +0900
Message-Id: <20241009093124.3647359-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTV7fUly3doOucosWc9WvYLLo3z2S0
	6H3/ismiad9MdovLu+awWdxb85/VYtnX9+wWh7++YbKY3djH6MDpsXPWXXaPBZtKPTat6mTz
	2PRpErvHiRm/WTz6tqxi9Diz4Ai7x+dNcgEcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZm
	Boa6hpYW5koKeYm5qbZKLj4Bum6ZOUDnKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVIL
	UnIKzAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM9aea2YrOK9X8XT2Y+YGxn3qXYycHBICJhI/
	b51k7mLk4hAS2MEocf3NVhYI5xOjxMdTp5kgnG+MEucaPjLDtMz8/YAdIrEXqKV9AiOE85lR
	4tuWBywgVWwC2hLvF0xiBbFFBLIkVh+9BBZnFiiVePvmBNgkYQFbiQc3X4DFWQRUJWZevcsE
	YvMK2EtsP/CfBWKbvMTMS9/ZIeKCEidnPoGaIy/RvHU22OESAl/ZJT4eecQI0eAi8WbpAqhT
	hSVeHd/CDmFLSbzsb4Oy8yUuXHwFtIwDyK6RWDjRECJsL7Hr6wxWkDCzgKbE+l36EKv4JN59
	7WGFqOaV6GgTgqhWk2h59pUVwpaR+PvvGVSJh8TrlckgYSGBWInlLz8yT2CUm4Xk/llI7p+F
	sGsBI/MqRrHUguLc9NRiwwIjeDwm5+duYgQnSi2zHYyT3n7QO8TIxMF4iFGCg1lJhFd3IWu6
	EG9KYmVValF+fFFpTmrxIUZTYIhOZJYSTc4Hpuq8knhDE0sDEzMjEwtjS2MzJXHeM1fKUoUE
	0hNLUrNTUwtSi2D6mDg4pRqY1iSxRYVzrDu+Srv3S+U7ia/rF4RXLoiYqnlAlqWrQrg0pfhG
	3IT6nMAV0RaSi3b92P5xTnLQ7+0W9TNVXbZ/MF4UGHj9St+1CasPaZtNS/mzl2W70K0Gnvka
	1Uu3nE8LeOgom/PnQlzh6ac7tikn1F99edF8V6Lp1Obpiw5WLNNpSHIMsdm18HLsar7j31Y2
	1k0TX1YnlMXz4rZI40GlS84hjxdLRJRvyQ75lsDHE7uP5e9n1dY/zxvEzL2iZELUDz29tmLx
	H0btPZYVrE2v2RkZniiVxlyRYXZe7st72X0TX7jH/r2P5d4fqZQX4U2M/jZ5Zd6DiX/Sl+Yv
	UZVepPhQZN6Ty/mJf7Meyb7XVWIpzkg01GIuKk4EANJkD0gdBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSnG6pL1u6wYaLghZz1q9hs+jePJPR
	ovf9KyaLpn0z2S0u75rDZnFvzX9Wi2Vf37NbHP76hslidmMfowOnx85Zd9k9Fmwq9di0qpPN
	Y9OnSeweJ2b8ZvHo27KK0ePMgiPsHp83yQVwRHHZpKTmZJalFunbJXBlrD3XzFZwXq/i6ezH
	zA2M+9S7GDk5JARMJGb+fsAOYgsJ7GaUuLgqHCIuI/Hm/FOWLkYOIFtY4vDh4i5GLqCSj4wS
	3Sf+MoPUsAloS7xfMIkVxBYRKJBY/eoaE4jNLFAp8e/2LbC4sICtxIObL1hAbBYBVYmZV++C
	1fAK2EtsP/CfBWKXvMTMS9/ZIeKCEidnPmGBmCMv0bx1NvMERr5ZSFKzkKQWMDKtYpRMLSjO
	Tc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDmktzR2M21d90DvEyMTBeIhRgoNZSYRXdyFruhBv
	SmJlVWpRfnxRaU5q8SFGaQ4WJXFe8Re9KUIC6YklqdmpqQWpRTBZJg5OqQYmz0PKL/VL/8kV
	FRl4WG594exQeI+pa94Fex+1JN+Ge9xVMfnnioMvX3n7bv3NrT8OXBHYz7nD/qzpN4HAVQp6
	B25nO9+d+DuR8YeYjOaVmR8/tDHG3TyzZOXRf1Yzt3a1ZGzKMHlUvS1AgcXk2ZpgqS9Hd1of
	N3mU+MTfcNb0z4L8jztVI7hqdbUWeEx6soVvgRbTGcmGlz1CpjpfnLbWVUzvu/r66N/IgjuT
	z3F45H6tPcdeEHv8ruQMRdNGthajrz+4Kt3Z9809FpTw6wTrtthauzOPLlm+9LmbV3cqWmju
	ybOiuUVt/2/sEmV9XdN/68w/C86klVervjOJ2VT2hv//wbq9zmxfi66H2Z8CJZbijERDLeai
	4kQAEUXMNdgCAAA=
X-CMS-MailID: 20241009093133epcas1p39b770ebcc6d2d78cad2f9a522bc6f179
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241009093133epcas1p39b770ebcc6d2d78cad2f9a522bc6f179
References: <CGME20241009093133epcas1p39b770ebcc6d2d78cad2f9a522bc6f179@epcas1p3.samsung.com>

The reclaim_folio_list uses a dummy reclaim_stat and is not being
used. To know the memory stat, add a new trace event. This is useful how
how many pages are not reclaimed or why.

This is an example.
mm_vmscan_reclaim_pages: nr_scanned=17 nr_reclaimed=17 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0

Currenlty reclaim_folio_list is only called by reclaim_pages, and
reclaim_pages is used by damon and madvise. In the latest Android,
reclaim_pages is also used by shmem to reclaim all pages in a
address_space.

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 include/trace/events/vmscan.h | 41 +++++++++++++++++++++++++++++++++++
 mm/vmscan.c                   | 40 +++++++++++++++++++++++++++++-----
 2 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 1a488c30afa5..509110a12fa5 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -346,6 +346,47 @@ TRACE_EVENT(mm_vmscan_write_folio,
 		show_reclaim_flags(__entry->reclaim_flags))
 );
 
+TRACE_EVENT(mm_vmscan_reclaim_pages,
+
+	TP_PROTO(unsigned long nr_scanned, unsigned long nr_reclaimed,
+		struct reclaim_stat *stat),
+
+	TP_ARGS(nr_scanned, nr_reclaimed, stat),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, nr_scanned)
+		__field(unsigned long, nr_reclaimed)
+		__field(unsigned long, nr_dirty)
+		__field(unsigned long, nr_writeback)
+		__field(unsigned long, nr_congested)
+		__field(unsigned long, nr_immediate)
+		__field(unsigned int, nr_activate0)
+		__field(unsigned int, nr_activate1)
+		__field(unsigned long, nr_ref_keep)
+		__field(unsigned long, nr_unmap_fail)
+	),
+
+	TP_fast_assign(
+		__entry->nr_scanned = nr_scanned;
+		__entry->nr_reclaimed = nr_reclaimed;
+		__entry->nr_dirty = stat->nr_dirty;
+		__entry->nr_writeback = stat->nr_writeback;
+		__entry->nr_congested = stat->nr_congested;
+		__entry->nr_immediate = stat->nr_immediate;
+		__entry->nr_activate0 = stat->nr_activate[0];
+		__entry->nr_activate1 = stat->nr_activate[1];
+		__entry->nr_ref_keep = stat->nr_ref_keep;
+		__entry->nr_unmap_fail = stat->nr_unmap_fail;
+	),
+
+	TP_printk("nr_scanned=%ld nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld",
+		__entry->nr_scanned, __entry->nr_reclaimed,
+		__entry->nr_dirty, __entry->nr_writeback,
+		__entry->nr_congested, __entry->nr_immediate,
+		__entry->nr_activate0, __entry->nr_activate1,
+		__entry->nr_ref_keep, __entry->nr_unmap_fail)
+);
+
 TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 
 	TP_PROTO(int nid,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 749cdc110c74..4776c42dfd2a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2126,9 +2126,9 @@ static void shrink_active_list(unsigned long nr_to_scan,
 }
 
 static unsigned int reclaim_folio_list(struct list_head *folio_list,
-				      struct pglist_data *pgdat)
+				      struct pglist_data *pgdat,
+				      struct reclaim_stat *stat)
 {
-	struct reclaim_stat dummy_stat;
 	unsigned int nr_reclaimed;
 	struct folio *folio;
 	struct scan_control sc = {
@@ -2139,7 +2139,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 		.no_demotion = 1,
 	};
 
-	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, true);
+	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, stat, true);
 	while (!list_empty(folio_list)) {
 		folio = lru_to_folio(folio_list);
 		list_del(&folio->lru);
@@ -2149,16 +2149,40 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 	return nr_reclaimed;
 }
 
+static void reclaim_stat_add(struct reclaim_stat *stat_from,
+			     struct reclaim_stat *stat_to)
+{
+	int type;
+
+	if (!trace_mm_vmscan_reclaim_pages_enabled())
+		return;
+
+	stat_to->nr_dirty += stat_from->nr_dirty;
+	stat_to->nr_unqueued_dirty += stat_from->nr_unqueued_dirty;
+	stat_to->nr_congested += stat_from->nr_congested;
+	stat_to->nr_writeback += stat_from->nr_writeback;
+	stat_to->nr_immediate += stat_from->nr_immediate;
+	stat_to->nr_pageout += stat_from->nr_pageout;
+	for (type = 0; type < ANON_AND_FILE; type++)
+		stat_to->nr_activate[type] += stat_from->nr_activate[type];
+	stat_to->nr_ref_keep += stat_from->nr_ref_keep;
+	stat_to->nr_unmap_fail += stat_from->nr_unmap_fail;
+	stat_to->nr_lazyfree_fail += stat_from->nr_lazyfree_fail;
+}
+
 unsigned long reclaim_pages(struct list_head *folio_list)
 {
 	int nid;
+	unsigned int nr_scanned = 0;
 	unsigned int nr_reclaimed = 0;
 	LIST_HEAD(node_folio_list);
 	unsigned int noreclaim_flag;
+	struct reclaim_stat stat_total, stat_one;
 
 	if (list_empty(folio_list))
 		return nr_reclaimed;
 
+	memset(&stat_total, 0, sizeof(stat_total));
 	noreclaim_flag = memalloc_noreclaim_save();
 
 	nid = folio_nid(lru_to_folio(folio_list));
@@ -2168,14 +2192,20 @@ unsigned long reclaim_pages(struct list_head *folio_list)
 		if (nid == folio_nid(folio)) {
 			folio_clear_active(folio);
 			list_move(&folio->lru, &node_folio_list);
+			nr_scanned += folio_nr_pages(folio);
 			continue;
 		}
 
-		nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
+		nr_reclaimed += reclaim_folio_list(&node_folio_list,
+						   NODE_DATA(nid), &stat_one);
+		reclaim_stat_add(&stat_one, &stat_total);
 		nid = folio_nid(lru_to_folio(folio_list));
 	} while (!list_empty(folio_list));
 
-	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
+	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid),
+					   &stat_one);
+	reclaim_stat_add(&stat_one, &stat_total);
+	trace_mm_vmscan_reclaim_pages(nr_scanned, nr_reclaimed, &stat_total);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 
-- 
2.25.1


