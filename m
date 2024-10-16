Return-Path: <linux-kernel+bounces-368214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF7A9A0CBB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44AAAB21AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF69920ADDA;
	Wed, 16 Oct 2024 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AR3rHJk6"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C90208D97
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089160; cv=none; b=qkpaksu/bszwHhf7rvs3bYllyiMeLxpfAOz/7ee1ZecaCXdR+MXhNZ14ir5UYFhe6rlHc6lz3YZVFxxlMYRdzh0Nx7rSmDjiSJAo9anWd0ymmt5YAmpLf3KEvKLORmvsz17j42YS1yQ8ie51gj+f2lbaPg+5JoM28RgpwhEB7ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089160; c=relaxed/simple;
	bh=9tFyi9k7IgUfhj2xvBxUcAVTZ4B70J6eCdlm6rc23nA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=PiWoTKkvkR54UL+o6diIBxyt1MQtUGWU6UEd+0ieLU2N1O7kNnM9ZRYGMhXdo0rM91kBDew0lnmAGHMWNnpBlFRJ39QliJ7hgEcKBU2YpZ3DI/IywxQ7x6Bgg/JEi3RI8iu7gEeElgMtL0tLwTtEbnO8XvIFEfJi5YgiNe4Q/7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AR3rHJk6; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241016143236epoutp0338e2d385bb1f053400bc9d0da49c9cad~_9W0zjrtD0808008080epoutp03R
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:32:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241016143236epoutp0338e2d385bb1f053400bc9d0da49c9cad~_9W0zjrtD0808008080epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729089156;
	bh=q4/UYrkheKG89qi1j/kjpU2o34wk2+byWmCp6+7zaJQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=AR3rHJk6OpTmsFtUNagVshjIjTcd4XxjTfCP/g9ON8bVQV7k5uE1DO80rTv3NHfG2
	 XAxrqP4P0VDm6Yb8tup3O39aRcOR0JlRQ50zl2miJTXB5d5/o+WSArZDCnScKL4jYD
	 bxMNdDugtF5TD0P2CCzRBv+c2AdpfEJjQ1XldLCg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20241016143235epcas1p38cfcef0e1b048d0896d81ad7e634c48f~_9W0Z4SBA0916409164epcas1p3i;
	Wed, 16 Oct 2024 14:32:35 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.249]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4XTD2W3ZLfz4x9Pv; Wed, 16 Oct
	2024 14:32:35 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	78.EB.09951.38ECF076; Wed, 16 Oct 2024 23:32:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241016143235epcas1p216905027589e0a9c4ac44726510fbbd6~_9Wzoiw__1993219932epcas1p2K;
	Wed, 16 Oct 2024 14:32:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241016143235epsmtrp239de00befb9b684e0f3f6ba5d90636e2~_9Wzn4ef92089520895epsmtrp20;
	Wed, 16 Oct 2024 14:32:35 +0000 (GMT)
X-AuditID: b6c32a38-b93b8700000026df-9e-670fce8374fd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	98.04.08229.28ECF076; Wed, 16 Oct 2024 23:32:34 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.104.99]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241016143234epsmtip26ce5bc70af4e2af01fc6b47ae2bc5c00~_9WzcZzh03007630076epsmtip27;
	Wed, 16 Oct 2024 14:32:34 +0000 (GMT)
From: Jaewon Kim <jaewon31.kim@samsung.com>
To: sj@kernel.org, minchan@kernel.org, vbabka@suse.cz,
	kaleshsingh@google.com, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v3] vmscan: add a vmscan event for reclaim_pages
Date: Wed, 16 Oct 2024 23:32:27 +0900
Message-Id: <20241016143227.961162-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdlhTT7f5HH+6wdPdUhZz1q9hs+jePJPR
	ovf9KyaLpn0z2S0u75rDZnFvzX9Wi2Vf37NbHP76hslidmMfowOnx85Zd9k9Fmwq9di0qpPN
	Y9OnSeweJ2b8ZvHo27KK0ePMgiPsHp83yQVwRGXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5ua
	GRjqGlpamCsp5CXmptoqufgE6Lpl5gCdp6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUot
	SMkpMCvQK07MLS7NS9fLSy2xMjQwMDIFKkzIzui9/5qlYL18RXvrWqYGxqNSXYycHBICJhJv
	e28ydjFycQgJ7GCUuPN9PzOE84lRYsrNCUwQzjdGifMrDjLBtFxY9RWqZS+jxIlrO1ggnM+M
	Eg0L57KAVLEJaEu8XzCJFcQWEciSWH30ElicWaBU4u2bE8wgtrCAg8SdnttANgcHi4CqRNui
	MpAwr4CdxLv/E1gglslLzLz0nR0iLihxcuYTqDHyEs1bZzND1Hxll7hwSwBkjISAi8SiRRoQ
	YWGJV8e3sEPYUhKf3+1lg7DzJS5cfMUEUV4jsXCiIUTYXmLX1xmsIGFmAU2J9bv0IRbxSbz7
	2sMKUc0r0dEmBFGtJtHy7CsrhC0j8fffMyjbQ+Lug29gdwkJxEr83raWcQKj3Cwk589Ccv4s
	hGULGJlXMYqlFhTnpqcWGxaYwGMxOT93EyM4SWpZ7GCc+/aD3iFGJg7GQ4wSHMxKIryTunjT
	hXhTEiurUovy44tKc1KLDzGaAsNzIrOUaHI+ME3nlcQbmlgamJgZmVgYWxqbKYnznrlSliok
	kJ5YkpqdmlqQWgTTx8TBKdXAZHrJh1Ph2D0Jt0flAfPd9jNJ/N4QUzuLR17neGT0yh13FnX6
	CfDV2R448DxwRU7ypDudEnPiTik3z2DxMReKf5CsdNtfKPCZu1U9fzoPu2FmaSqvkvGuHcIP
	jlh37HiyyjeJa7/e23cce/tyjpQ5+KjKBz3s0HXuXGSVYe1U+6hBW+z7hpkvYz5e4T/z9W3c
	4hrXGXueTXeM31st8lvq9ru3DeIPdLfUtcYtETVcvlMnMDRiUfbVhj++nYxJ66+u/ePPNOXS
	MRn3jrmuCgZ7jCQO6Sx58+x5s6z5BeX1LTfPfpyjO4lrOoOv790PIXOaTp/yLuqXuXuhUGlZ
	gcAD82OHJ3JM3RU8U9ou+I6HEktxRqKhFnNRcSIAxa/1ORsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSvG7TOf50gzVbrC3mrF/DZtG9eSaj
	Re/7V0wWTftmsltc3jWHzeLemv+sFsu+vme3OPz1DZPF7MY+RgdOj52z7rJ7LNhU6rFpVSeb
	x6ZPk9g9Tsz4zeLRt2UVo8eZBUfYPT5vkgvgiOKySUnNySxLLdK3S+DK6L3/mqVgvXxFe+ta
	pgbGo1JdjJwcEgImEhdWfWXsYuTiEBLYzSixee8/NoiEjMSb809Zuhg5gGxhicOHiyFqPjJK
	rF3dzQRSwyagLfF+wSRWEFtEoEBi9atrYHFmgUqJf7dvgcWFBRwk7vTcZgaZwyKgKtG2qAwk
	zCtgJ/Hu/wQWiFXyEjMvfWeHiAtKnJz5hAVijLxE89bZzBMY+WYhSc1CklrAyLSKUTK1oDg3
	PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4pLU0dzBuX/VB7xAjEwfjIUYJDmYlEd5JXbzpQrwp
	iZVVqUX58UWlOanFhxilOViUxHnFX/SmCAmkJ5akZqemFqQWwWSZODilGpgyFwv+bw3vSM6f
	s3LRBnMPiwdux/8fd7dOSygy0dg+51BL0NuIjVIy8r1TJ+hKHLqiUOR69ubeF3nvWuYFH3ny
	9v+6myFn/ZuuJC5nfJZcdsV6hovS5wUrbHMuLGtdzfib+eKWD64zz4n9M/se6r5YpSXtr1eM
	RkQ923L3y9M4lILZ0vXjv72/snvunjLmBsXAyevmVlf3XjqzdUMeb3+paOgPVgOXY7d0RLp/
	XciTmLtOxO2PQOVsEem99V+2Jyx+57Dfif96X2y+3cWN0954xk0Q33aby+W429pIs+6+efVZ
	zEVcPIxMYZeC3+6fdeLVL+t/Cf2sgltKxdxKdlr4i5uf/b3hvJJJuQSnY6oSS3FGoqEWc1Fx
	IgAh91RY2AIAAA==
X-CMS-MailID: 20241016143235epcas1p216905027589e0a9c4ac44726510fbbd6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241016143235epcas1p216905027589e0a9c4ac44726510fbbd6
References: <CGME20241016143235epcas1p216905027589e0a9c4ac44726510fbbd6@epcas1p2.samsung.com>

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
v3: use sc.nr_scanned rather than new counting
v2: remove reclaim_stat_add function and call the trace on each node
v1: introduce a new trace event
---
 include/trace/events/vmscan.h | 45 +++++++++++++++++++++++++++++++++++
 mm/vmscan.c                   |  5 ++--
 2 files changed, 48 insertions(+), 2 deletions(-)

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
index 749cdc110c74..8e16f99cdd3d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2128,7 +2128,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 static unsigned int reclaim_folio_list(struct list_head *folio_list,
 				      struct pglist_data *pgdat)
 {
-	struct reclaim_stat dummy_stat;
+	struct reclaim_stat stat;
 	unsigned int nr_reclaimed;
 	struct folio *folio;
 	struct scan_control sc = {
@@ -2139,12 +2139,13 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 		.no_demotion = 1,
 	};
 
-	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, true);
+	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &stat, true);
 	while (!list_empty(folio_list)) {
 		folio = lru_to_folio(folio_list);
 		list_del(&folio->lru);
 		folio_putback_lru(folio);
 	}
+	trace_mm_vmscan_reclaim_pages(pgdat->node_id, sc.nr_scanned, nr_reclaimed, &stat);
 
 	return nr_reclaimed;
 }
-- 
2.25.1


