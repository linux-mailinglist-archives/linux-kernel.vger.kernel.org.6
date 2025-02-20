Return-Path: <linux-kernel+bounces-523000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F25A3D0ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5877E3BD119
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070AD1EE7A9;
	Thu, 20 Feb 2025 05:36:14 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E60B1E3DC4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029772; cv=none; b=N9Ke2NSesSjMbjh02aJEwzVa9Yw23hGDHoniMCKheyNMuDiXHrDwXY5+HKYZlVrFG5IThBZzhENXXucW7IF+FlkyIGu/CNKqjtuVpuUDEK+xwRkrsb5ViMdNT6Im/BD9waIIr/oDVt+pvG78JYVLxRJkvkldmItvTTXYdr7AqZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029772; c=relaxed/simple;
	bh=o92M9Oubd12E0b566Pkq4Lbv5SuVQHUAFaiOY/7OkGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=W3iUQpZRKPwXMv8g6bxylTHeN7Sv+0W/zKIg0VZfn8uByvA4Q7touRqnSA/tSCAnoH+am4GpEHlWaWMco5U81YeLcnwd796yUiB5i2S6nqCJkE1TDg+xswwlJvtDOMMGLuToB/u/zEfPJTA6KODBuxDQW1Xy20X2op3xLOn/lI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-21-67b6bba759bc
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
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
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [RFC PATCH v12 23/26] mm: separate move/undo parts from migrate_pages_batch()
Date: Thu, 20 Feb 2025 14:20:24 +0900
Message-Id: <20250220052027.58847-24-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnke7y3dvSDfq+y1jMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	rz1eBX+0Kx49O8nawDhTuYuRk0NCwERi1depbDD2z89vWEFsNgF1iRs3fjKD2CICZhIHW/+w
	g9jMAneZJA70g9ULC4RJ3NyxG8xmEVCVmDBrN1gvL1B9+465zBAz5SVWbzgAZnMCxX/M6AWr
	FxIwlXi34BJTFyMXUM17NoljR+axQjRIShxccYNlAiPvAkaGVYxCmXlluYmZOSZ6GZV5mRV6
	yfm5mxiBgb+s9k/0DsZPF4IPMQpwMCrx8M5o3ZYuxJpYVlyZe4hRgoNZSYS3rX5LuhBvSmJl
	VWpRfnxRaU5q8SFGaQ4WJXFeo2/lKUIC6YklqdmpqQWpRTBZJg5OqQbGHpWW1MRliikTmYu/
	MP99xr33yLZCy+1FOgorwri2LrrsK23LHVTyaJN9+K0zTscu/rA6eGXfq4rNjY9Z17ov9Gs+
	lP3L+rNeaXhe3K2iB3LyDULfHj2cendGo7Rfg7vfA71rbS5VEu8zw9/obZ1x483b13wvgycX
	PRbYKvTJLGf5u57q9dH9SizFGYmGWsxFxYkAlW02a3gCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrLt897Z0g5+zhS3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfNY/OIDk8fWX3YejVOvsXl83iQXwB/FZZOS
	mpNZllqkb5fAlfG1x6vgj3bFo2cnWRsYZyp3MXJySAiYSPz8/IYVxGYTUJe4ceMnM4gtImAm
	cbD1DzuIzSxwl0niQD8biC0sECZxc8duMJtFQFViwqzdYL28QPXtO+YyQ8yUl1i94QCYzQkU
	/zGjF6xeSMBU4t2CS0wTGLkWMDKsYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECAzjZbV/Ju5g
	/HLZ/RCjAAejEg/vg8db04VYE8uKK3MPMUpwMCuJ8LbVb0kX4k1JrKxKLcqPLyrNSS0+xCjN
	waIkzusVnpogJJCeWJKanZpakFoEk2Xi4JRqYGTljrVtzTKauYx3slvNo0tzjbZqBwqUbp28
	aYbFHIv4T/PXH/A7mZ8S5xcxqeLfTqPPxtPFShmeimwuW7GmeVbUosmiF36vvqAZ99oofVfg
	4WdmqXnTD77452glwv3nz6q9LVsnnpL2fGL/ItCvPnBNo12pkFFVQOyy1DvtEs1TpSXm6r9T
	vaLEUpyRaKjFXFScCADMZTXRXwIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Functionally, no change.  This is a preparation for luf mechanism that
requires to use separated folio lists for its own handling during
migration.  Refactored migrate_pages_batch() so as to separate move/undo
parts from migrate_pages_batch().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/migrate.c | 134 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 83 insertions(+), 51 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index dfb5eba3c5223..5e12023dbc75a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1695,6 +1695,81 @@ static int migrate_hugetlbs(struct list_head *from, new_folio_t get_new_folio,
 	return nr_failed;
 }
 
+static void migrate_folios_move(struct list_head *src_folios,
+		struct list_head *dst_folios,
+		free_folio_t put_new_folio, unsigned long private,
+		enum migrate_mode mode, int reason,
+		struct list_head *ret_folios,
+		struct migrate_pages_stats *stats,
+		int *retry, int *thp_retry, int *nr_failed,
+		int *nr_retry_pages)
+{
+	struct folio *folio, *folio2, *dst, *dst2;
+	bool is_thp;
+	int nr_pages;
+	int rc;
+
+	dst = list_first_entry(dst_folios, struct folio, lru);
+	dst2 = list_next_entry(dst, lru);
+	list_for_each_entry_safe(folio, folio2, src_folios, lru) {
+		is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
+		nr_pages = folio_nr_pages(folio);
+
+		cond_resched();
+
+		rc = migrate_folio_move(put_new_folio, private,
+				folio, dst, mode,
+				reason, ret_folios);
+		/*
+		 * The rules are:
+		 *	Success: folio will be freed
+		 *	-EAGAIN: stay on the unmap_folios list
+		 *	Other errno: put on ret_folios list
+		 */
+		switch (rc) {
+		case -EAGAIN:
+			*retry += 1;
+			*thp_retry += is_thp;
+			*nr_retry_pages += nr_pages;
+			break;
+		case MIGRATEPAGE_SUCCESS:
+			stats->nr_succeeded += nr_pages;
+			stats->nr_thp_succeeded += is_thp;
+			break;
+		default:
+			*nr_failed += 1;
+			stats->nr_thp_failed += is_thp;
+			stats->nr_failed_pages += nr_pages;
+			break;
+		}
+		dst = dst2;
+		dst2 = list_next_entry(dst, lru);
+	}
+}
+
+static void migrate_folios_undo(struct list_head *src_folios,
+		struct list_head *dst_folios,
+		free_folio_t put_new_folio, unsigned long private,
+		struct list_head *ret_folios)
+{
+	struct folio *folio, *folio2, *dst, *dst2;
+
+	dst = list_first_entry(dst_folios, struct folio, lru);
+	dst2 = list_next_entry(dst, lru);
+	list_for_each_entry_safe(folio, folio2, src_folios, lru) {
+		int old_page_state = 0;
+		struct anon_vma *anon_vma = NULL;
+
+		__migrate_folio_extract(dst, &old_page_state, &anon_vma);
+		migrate_folio_undo_src(folio, old_page_state & PAGE_WAS_MAPPED,
+				anon_vma, true, ret_folios);
+		list_del(&dst->lru);
+		migrate_folio_undo_dst(dst, true, put_new_folio, private);
+		dst = dst2;
+		dst2 = list_next_entry(dst, lru);
+	}
+}
+
 /*
  * migrate_pages_batch() first unmaps folios in the from list as many as
  * possible, then move the unmapped folios.
@@ -1717,7 +1792,7 @@ static int migrate_pages_batch(struct list_head *from,
 	int pass = 0;
 	bool is_thp = false;
 	bool is_large = false;
-	struct folio *folio, *folio2, *dst = NULL, *dst2;
+	struct folio *folio, *folio2, *dst = NULL;
 	int rc, rc_saved = 0, nr_pages;
 	LIST_HEAD(unmap_folios);
 	LIST_HEAD(dst_folios);
@@ -1888,42 +1963,11 @@ static int migrate_pages_batch(struct list_head *from,
 		thp_retry = 0;
 		nr_retry_pages = 0;
 
-		dst = list_first_entry(&dst_folios, struct folio, lru);
-		dst2 = list_next_entry(dst, lru);
-		list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
-			is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
-			nr_pages = folio_nr_pages(folio);
-
-			cond_resched();
-
-			rc = migrate_folio_move(put_new_folio, private,
-						folio, dst, mode,
-						reason, ret_folios);
-			/*
-			 * The rules are:
-			 *	Success: folio will be freed
-			 *	-EAGAIN: stay on the unmap_folios list
-			 *	Other errno: put on ret_folios list
-			 */
-			switch(rc) {
-			case -EAGAIN:
-				retry++;
-				thp_retry += is_thp;
-				nr_retry_pages += nr_pages;
-				break;
-			case MIGRATEPAGE_SUCCESS:
-				stats->nr_succeeded += nr_pages;
-				stats->nr_thp_succeeded += is_thp;
-				break;
-			default:
-				nr_failed++;
-				stats->nr_thp_failed += is_thp;
-				stats->nr_failed_pages += nr_pages;
-				break;
-			}
-			dst = dst2;
-			dst2 = list_next_entry(dst, lru);
-		}
+		/* Move the unmapped folios */
+		migrate_folios_move(&unmap_folios, &dst_folios,
+				put_new_folio, private, mode, reason,
+				ret_folios, stats, &retry, &thp_retry,
+				&nr_failed, &nr_retry_pages);
 	}
 	nr_failed += retry;
 	stats->nr_thp_failed += thp_retry;
@@ -1932,20 +1976,8 @@ static int migrate_pages_batch(struct list_head *from,
 	rc = rc_saved ? : nr_failed;
 out:
 	/* Cleanup remaining folios */
-	dst = list_first_entry(&dst_folios, struct folio, lru);
-	dst2 = list_next_entry(dst, lru);
-	list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
-		int old_page_state = 0;
-		struct anon_vma *anon_vma = NULL;
-
-		__migrate_folio_extract(dst, &old_page_state, &anon_vma);
-		migrate_folio_undo_src(folio, old_page_state & PAGE_WAS_MAPPED,
-				       anon_vma, true, ret_folios);
-		list_del(&dst->lru);
-		migrate_folio_undo_dst(dst, true, put_new_folio, private);
-		dst = dst2;
-		dst2 = list_next_entry(dst, lru);
-	}
+	migrate_folios_undo(&unmap_folios, &dst_folios,
+			put_new_folio, private, ret_folios);
 
 	return rc;
 }
-- 
2.17.1


