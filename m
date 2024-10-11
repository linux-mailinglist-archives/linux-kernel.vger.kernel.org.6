Return-Path: <linux-kernel+bounces-361143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0CC99A432
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01F51C21602
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF53218581;
	Fri, 11 Oct 2024 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L216FNM2"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9EB20C473
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728650984; cv=none; b=E1QnDZ3edFTg1NQ8fythKW2Tz8t2udIB7K4HvWkB2VowTksrTH1AjprY0X3CmzAhog9XDBC8G70U5EfR/m2nCdMb4is2DifK/04jLKNUudI0UaIFb0GNyhoagTJF57H4UQU5GcnKnq7ULa+rZ5le2RADTRux7qY7/RWlUqJz7vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728650984; c=relaxed/simple;
	bh=XKzJNvuAeEgwDNk9dQbQsx7kY64FyT6iwHSXDIRVdJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=NcEDxOacEgncnJIPPbEPM4aZnwXdh7Rdq03aksOWtrb+BGn71rJXAToNX+eJpSngQkdp194l+yGvQzOkzk4CBscV87OktufH11wtmEVaGNtUu4V2i4jv/XeHSbbdqDM2gyfHkxLF5fD9Vl4KXzSoWRCDm5jB4ThMvaQt7n19bjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=L216FNM2; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241011124934epoutp013fb6307a939c3568158fd64976bc7793~9ZubuhiMx3035130351epoutp01J
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:49:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241011124934epoutp013fb6307a939c3568158fd64976bc7793~9ZubuhiMx3035130351epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728650974;
	bh=ZDDxYTyUSVZN/3oOMtfj8vkA3ZrBEhFDTR3n8K4qjAs=;
	h=From:To:Cc:Subject:Date:References:From;
	b=L216FNM2fp+KuQm4f+ThQFTEKXMwELZTZnmfimnGUVGLL1Ae/kU1v0YmbCeRIW17o
	 SO5qbGFixMttDse74mg5nCj9l1/7NaS12IC1tbRyzheqpBSQoBafQRpnluWDehzhLT
	 jHYAYALjhyTrHr/1T2Vbhju7KYeni9yGyhH+VbX4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20241011124933epcas1p35ebd9763fef301994d077b4ac48ed194~9Zua9QY5l1466914669epcas1p3o;
	Fri, 11 Oct 2024 12:49:33 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.249]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4XQ5zw5nSMz4x9Pv; Fri, 11 Oct
	2024 12:49:32 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	98.B5.09398.CDE19076; Fri, 11 Oct 2024 21:49:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241011124931epcas1p176b2ce6a566f7557468dff1e12677a11~9ZuZxr9tB0397703977epcas1p13;
	Fri, 11 Oct 2024 12:49:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241011124931epsmtrp1894f8a76a79fa4863e9a32084b58cdf6~9ZuZxAJID2084420844epsmtrp1Q;
	Fri, 11 Oct 2024 12:49:31 +0000 (GMT)
X-AuditID: b6c32a39-39fff700000024b6-c7-67091edcb57b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8C.F5.08229.BDE19076; Fri, 11 Oct 2024 21:49:31 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.104.99]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241011124931epsmtip1f1fdaf407b83077f147fe941f7992a64~9ZuZmIyyL3079430794epsmtip1s;
	Fri, 11 Oct 2024 12:49:31 +0000 (GMT)
From: Jaewon Kim <jaewon31.kim@samsung.com>
To: sj@kernel.org, minchan@kernel.org, vbabka@suse.cz,
	kaleshsingh@google.com, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v2] vmscan: add a vmscan event for reclaim_pages
Date: Fri, 11 Oct 2024 21:49:28 +0900
Message-Id: <20241011124928.1224813-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTX/eOHGe6wZceHYs569ewWXRvnslo
	0fv+FZNF076Z7BaXd81hs7i35j+rxbKv79ktDn99w2Qxu7GP0YHTY+esu+weCzaVemxa1cnm
	senTJHaPEzN+s3j0bVnF6HFmwRF2j8+b5AI4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403N
	DAx1DS0tzJUU8hJzU22VXHwCdN0yc4DOU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUW
	pOQUmBXoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ/w+MpW94J16xbWDqxgbGPcpdjFyckgImEhc
	u3mauYuRi0NIYAejxNInq5ggnE+MEr9fdLBDON8YJTa9ecsE09LS/QQqsZdRYuarDjYI5zNQ
	/4TbbCBVbALaEu8XTGIFsUUEsiRWH73EAmIzC5RKvH1zAmghB4ewgIPE78PeIGEWAVWJht6V
	YCW8AvYSW99BlEsIyEvMvPSdHSIuKHFy5hOoMfISzVtng90tIfCVXaL540N2iAYXiaffJzFD
	2MISr45vgYpLSbzsb4Oy8yUuXHzFBHKDhECNxMKJhhBhe4ldX2ewgoSZBTQl1u/Sh1jFJ/Hu
	aw8rRDWvREebEES1mkTLs6+sELaMxN9/z6BsD4l7Z6eDXSkkECuxes8rtgmMcrOQPDALyQOz
	EJYtYGRexSiWWlCcm55abFhgCo/H5PzcTYzgRKlluYNx+tsPeocYmTgYDzFKcDArifDqLmRN
	F+JNSaysSi3Kjy8qzUktPsRoCgzSicxSosn5wFSdVxJvaGJpYGJmZGJhbGlspiTOe+ZKWaqQ
	QHpiSWp2ampBahFMHxMHp1QDk65ZW4PQxy0GJ9OKtNes9LGVsHsh4drnfutYtFTpxsB45p02
	PXrTVu7OnhmSGpbOdmEFb5Oc2fKVXi+l4vK1uKXOJB9lurb2V+CdTZLKe6zs1s3STkntvqf8
	XVI+M7X63p3Xv7+579qguTPJPlCbe7oE1xv78ukuxzdKdx8wtq98tn+i3bypS1pPXTl7Pjlu
	6vHXx5bue9pZ5Z+gNnNX6rLdM9dxzlxTuK74fLjuRQen2F3xvLcXrD8eo712Uuh5OyMBn837
	/otNX7Vtw5QdYXqhGXmemQccf2tJlc/f7Pcx+U4q19ff23qttzF56XpdWtJxema7TWaSXOM3
	vceMkZd8TnStsousSmVdJPT9lRJLcUaioRZzUXEiABL2Hf4dBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSnO5tOc50gyP7jCzmrF/DZtG9eSaj
	Re/7V0wWTftmsltc3jWHzeLemv+sFsu+vme3OPz1DZPF7MY+RgdOj52z7rJ7LNhU6rFpVSeb
	x6ZPk9g9Tsz4zeLRt2UVo8eZBUfYPT5vkgvgiOKySUnNySxLLdK3S+DK+H1kKnvBO/WKawdX
	MTYw7lPsYuTkkBAwkWjpfsLexcjFISSwm1Hi1esLjBAJGYk355+ydDFyANnCEocPF0PUfGSU
	WDz3CDNIDZuAtsT7BZNYQWwRgQKJ1a+uMYHYzAKVEv9u32IF6RUWcJD4fdgbJMwioCrR0LuS
	BcTmFbCX2PruEgvEKnmJmZe+s0PEBSVOznzCAjFGXqJ562zmCYx8s5CkZiFJLWBkWsUomVpQ
	nJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERzSWpo7GLev+qB3iJGJg/EQowQHs5IIr+5C1nQh
	3pTEyqrUovz4otKc1OJDjNIcLErivOIvelOEBNITS1KzU1MLUotgskwcnFINTIUPNBeKS6dO
	UDv64vi5MH8dOy9zL16DKOONVyq/Z98XdNz8lrk+PFOIbbNd0n8D9uVv7eYKfJn9UerB+hVV
	zG7xcrOsfwdFbpiwdo+zXPzJF8qKzM88ImecWel6zo1plgD/KqHp2v6bbx2XnWvDO3f/JIMQ
	3+e7f/HcicruYmPw+9IiIGd4Xaf2wLflBraqzdK/nJe+iN3c9zGnwHCp2R0Rhvq7CxOXJoi/
	vKKS6snzl/U7Y/2jtpJPvRuju9dEsK28pxjS2zg1wVen/liYyt4/M85srs77HzO56e38Q3+f
	nb9eru1TeHrZFbmm8p2MHQat938d+PZx6bWramk7vvmrnt1TGGOqHXYk9FLcTSWW4oxEQy3m
	ouJEANPn9OnYAgAA
X-CMS-MailID: 20241011124931epcas1p176b2ce6a566f7557468dff1e12677a11
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241011124931epcas1p176b2ce6a566f7557468dff1e12677a11
References: <CGME20241011124931epcas1p176b2ce6a566f7557468dff1e12677a11@epcas1p1.samsung.com>

The reclaim_folio_list uses a dummy reclaim_stat and is not being
used. To know the memory stat, add a new trace event. This is useful how
how many pages are not reclaimed or why.

This is an example.
mm_vmscan_reclaim_pages: nid=0 nr_scanned=112 nr_reclaimed=112 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0

Currenlty reclaim_folio_list is only called by reclaim_pages, and
reclaim_pages is used by damon and madvise. In the latest Android,
reclaim_pages is also used by shmem to reclaim all pages in a
address_space.

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
v2: remove reclaim_stat_add function and call the trace on each node
v1: introduce a new trace event
---
 include/trace/events/vmscan.h | 45 +++++++++++++++++++++++++++++++++++
 mm/vmscan.c                   | 16 +++++++++----
 2 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 1a488c30afa5..490958fa10de 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -346,6 +346,51 @@ TRACE_EVENT(mm_vmscan_write_folio,
 		show_reclaim_flags(__entry->reclaim_flags))
 );
 
+TRACE_EVENT(mm_vmscan_reclaim_pages,
+
+	TP_PROTO(int nid,
+		unsigned long nr_scanned, unsigned long nr_reclaimed,
+		struct reclaim_stat *stat),
+
+	TP_ARGS(nid, nr_scanned, nr_reclaimed, stat),
+
+	TP_STRUCT__entry(
+		__field(int, nid)
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
+		__entry->nid = nid;
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
+	TP_printk("nid=%d nr_scanned=%ld nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld",
+		__entry->nid,
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
index 749cdc110c74..0c2c36bf4c5a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2126,9 +2126,10 @@ static void shrink_active_list(unsigned long nr_to_scan,
 }
 
 static unsigned int reclaim_folio_list(struct list_head *folio_list,
+				      unsigned int nr_scanned,
 				      struct pglist_data *pgdat)
 {
-	struct reclaim_stat dummy_stat;
+	struct reclaim_stat stat;
 	unsigned int nr_reclaimed;
 	struct folio *folio;
 	struct scan_control sc = {
@@ -2139,12 +2140,13 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 		.no_demotion = 1,
 	};
 
-	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, true);
+	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &stat, true);
 	while (!list_empty(folio_list)) {
 		folio = lru_to_folio(folio_list);
 		list_del(&folio->lru);
 		folio_putback_lru(folio);
 	}
+	trace_mm_vmscan_reclaim_pages(pgdat->node_id, nr_scanned, nr_reclaimed, &stat);
 
 	return nr_reclaimed;
 }
@@ -2152,6 +2154,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 unsigned long reclaim_pages(struct list_head *folio_list)
 {
 	int nid;
+	unsigned int nr_scanned = 0;
 	unsigned int nr_reclaimed = 0;
 	LIST_HEAD(node_folio_list);
 	unsigned int noreclaim_flag;
@@ -2168,15 +2171,18 @@ unsigned long reclaim_pages(struct list_head *folio_list)
 		if (nid == folio_nid(folio)) {
 			folio_clear_active(folio);
 			list_move(&folio->lru, &node_folio_list);
+			nr_scanned += folio_nr_pages(folio);
 			continue;
 		}
 
-		nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
+		nr_reclaimed += reclaim_folio_list(&node_folio_list, nr_scanned,
+						   NODE_DATA(nid));
+		nr_scanned = 0;
 		nid = folio_nid(lru_to_folio(folio_list));
 	} while (!list_empty(folio_list));
 
-	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
-
+	nr_reclaimed += reclaim_folio_list(&node_folio_list, nr_scanned,
+					   NODE_DATA(nid));
 	memalloc_noreclaim_restore(noreclaim_flag);
 
 	return nr_reclaimed;
-- 
2.25.1


