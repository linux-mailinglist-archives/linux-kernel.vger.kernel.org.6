Return-Path: <linux-kernel+bounces-533754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 347C6A45E34
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5124F7A5CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D0722A4E3;
	Wed, 26 Feb 2025 12:03:58 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD7F227EA1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571438; cv=none; b=EOokrAUbHSlvQ4OQQr2d5/9TcXTPMZmtRzvWAaX2wFIi13APeI2BaTsvHWat8FoMT7pmicdd+gm++pJmZg+NEiDsjN2ZfmLUTDkjfaJIe8vTrVo7/7hqHkM35qNcf529w7sGPV6l3Wmrl0IHoXIShDn6Esei03qzOXxPfUVPWm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571438; c=relaxed/simple;
	bh=tp43lXOci++0YebPZTGqm8t1AX0JsjH2WkIPwKbJc8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=S17mWaFd+aUG7hV9FXs01nMD2CbC6n/NTWG5VekK7nigOPQ1fO39rPyaBF1/Spqz3V9GzJHdoEHQWhu9IySFXVFRhCW65jQoGvucr0I08pkviep3afAcIESDOWYR4aZCCpajWFpJV18728w24ycQ6s0LvGJUATdG9z0jpowSEAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-4d-67bf0323287c
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	rjgolo@gmail.com
Subject: [RFC PATCH v12 based on v6.14-rc4 18/25] mm/page_alloc: retry 3 times to take pcp pages on luf check failure
Date: Wed, 26 Feb 2025 21:03:29 +0900
Message-Id: <20250226120336.29565-18-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120336.29565-1-byungchul@sk.com>
References: <20250226113024.GA1935@system.software.com>
 <20250226120336.29565-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC9ZZnka4y8/50g0cr+S3mrF/DZvF5wz82
	i6/rfzFbPP3Ux2JxedccNot7a/6zWpzftZbVYsfSfUwWlw4sYLI43nuAyWL+vc9sFps3TWW2
	OD5lKqPF7x9z2Bz4PL639rF47Jx1l91jwaZSj80rtDw2repk89j0aRK7x7tz59g9Tsz4zeLx
	ft9VNo+tv+w8GqdeY/P4vEkugCeKyyYlNSezLLVI3y6BK2PS7/dMBU+4KhZ+/svcwLiFo4uR
	k0NCwETi5aknLDD27lm7wGw2AXWJGzd+MoPYIgJmEgdb/7B3MXJxMAssY5LYe6KBDSQhLFAq
	saflC1ARBweLgKrEl+0VIGFeoPqvS3uZIGbKS6zecABsDidQ/NO0Y2CtQgLJEjt//2ECmSkh
	cJtNYsHbVYwQDZISB1fcYJnAyLuAkWEVo1BmXlluYmaOiV5GZV5mhV5yfu4mRmBQL6v9E72D
	8dOF4EOMAhyMSjy8D87sTRdiTSwrrsw9xCjBwawkwsuZuSddiDclsbIqtSg/vqg0J7X4EKM0
	B4uSOK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUA2NVoPP3GyuTFNPd5xRkPkyo/S03bWvu0gLz
	j+6TVyQrXJw/2ZVz30XV9pjaMLZd984nzExfZ/jL8uxa90OLqzr+Or+xPdXImzg1b8GTwq5r
	Pz4umOFu81dqx+rl3Pt/WB+2VPde8Mp61Q3lSyp24c6pr1+1xj7M2SgTMGNqz4QLsx4XGzNf
	vmakxFKckWioxVxUnAgAi+QV7GYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsXC5WfdrKvMvD/d4HIni8Wc9WvYLD5v+Mdm
	8XX9L2aLp5/6WCwOzz3JanF51xw2i3tr/rNanN+1ltVix9J9TBaXDixgsjjee4DJYv69z2wW
	mzdNZbY4PmUqo8XvH3PYHPg9vrf2sXjsnHWX3WPBplKPzSu0PDat6mTz2PRpErvHu3Pn2D1O
	zPjN4vF+31U2j8UvPjB5bP1l59E49Rqbx+dNcgG8UVw2Kak5mWWpRfp2CVwZk36/Zyp4wlWx
	8PNf5gbGLRxdjJwcEgImErtn7WIBsdkE1CVu3PjJDGKLCJhJHGz9w97FyMXBLLCMSWLviQY2
	kISwQKnEnpYvQEUcHCwCqhJftleAhHmB6r8u7WWCmCkvsXrDAbA5nEDxT9OOgbUKCSRL7Pz9
	h2kCI9cCRoZVjCKZeWW5iZk5pnrF2RmVeZkVesn5uZsYgSG6rPbPxB2MXy67H2IU4GBU4uF9
	cGZvuhBrYllxZe4hRgkOZiURXs7MPelCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb3CUxOEBNIT
	S1KzU1MLUotgskwcnFINjCnnH+xg14kzjJJp9ufZ5yXLH9WheOLKG4XzPL7zblyRCkxI9bGP
	uM/p/yE1xJWfR9WvYaFG+cPDKzkCdy2959DF9It5Anv1FzXXjw3G21QeRqabVjNUljis+RW2
	svH+lVvz2VcV/AsSLGz4eiJ8D9MpG10tTS5WYaHur/ODK8yV2PYJqDQrsRRnJBpqMRcVJwIA
	vtKw7k0CAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/page_alloc.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8e1ed80f304cd..811e7c4bd2d19 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3306,6 +3306,12 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 {
 	struct page *page;
 
+	/*
+	 * give up taking page from pcp if it fails to take pcp page
+	 * 3 times due to the tlb shootdownable issue.
+	 */
+	int try_luf_pages = 3;
+
 	do {
 		if (list_empty(list)) {
 			int batch = nr_pcp_alloc(pcp, zone, order);
@@ -3320,11 +3326,21 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 				return NULL;
 		}
 
-		page = list_first_entry(list, struct page, pcp_list);
-		if (!luf_takeoff_check_and_fold(page))
+		list_for_each_entry(page, list, pcp_list) {
+			if (luf_takeoff_check_and_fold(page)) {
+				list_del(&page->pcp_list);
+				pcp->count -= 1 << order;
+				break;
+			}
+			if (!--try_luf_pages)
+				return NULL;
+		}
+
+		/*
+		 * If all the pages in the list fails...
+		 */
+		if (list_entry_is_head(page, list, pcp_list))
 			return NULL;
-		list_del(&page->pcp_list);
-		pcp->count -= 1 << order;
 	} while (check_new_pages(page, order));
 
 	return page;
-- 
2.17.1


