Return-Path: <linux-kernel+bounces-183348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA118C97D9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE75B1C214DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151BF1CD02;
	Mon, 20 May 2024 02:18:03 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E60417C98
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171482; cv=none; b=FbPZlNm4TGfwOlEWpJxLMpX5I2mg4Me6ymKXmZk+lnRTjKldn1zxUEMRNyasl/9OHtleDIJ+C+Ed9jQpn6yiSl+NWIDErxDp1r56oUPI70LsgWGpyL1thp2MJUSzynwK1XwrLFHf0LLIF+oDtS25DsspBU820v4Eil3gP2uq3EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171482; c=relaxed/simple;
	bh=ehIxxhU20E42H9fwoVfMOG31SVEM0pU29Q1g7U/iKtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uO8evkpyyyVyHyHbMFhElQdOO3cDaPfjtFipOnl1DI0kt9InvxfEpb8vTlO0H+8gDvPSFqA1vm1f+hWfpn0O+0Vilbx5ie1BYMldQh007WHHlhUmn+QsNqet+SKADK5ro4RYlTzB+8bTNQC+OElyrV2HYEENE308JCHZvEhEI4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-c7-664ab2c9c7c5
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
Subject: [RESEND PATCH v10 10/12] mm: separate move/undo parts from migrate_pages_batch()
Date: Mon, 20 May 2024 11:17:32 +0900
Message-Id: <20240520021734.21527-11-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520021734.21527-1-byungchul@sk.com>
References: <20240520021734.21527-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnke7JTV5pBvcWi1jMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	LZOWsxT81K64fW81awPjdOUuRk4OCQETiaNT9jPB2CsPTAOz2QTUJW7c+MkMYosImEkcbP3D
	DmIzC9xlkjjQzwZiCwtESqxvfMoIYrMIqEpse7MDrJ4XqP57+042iJnyEqs3HACLcwLFZ6za
	yQJiCwmYSvw4+hWohguo5j2bxJqv11ggGiQlDq64wTKBkXcBI8MqRqHMvLLcxMwcE72MyrzM
	Cr3k/NxNjMDQX1b7J3oH46cLwYcYBTgYlXh4dzzyTBNiTSwrrsw9xCjBwawkwrtpC1CINyWx
	siq1KD++qDQntfgQozQHi5I4r9G38hQhgfTEktTs1NSC1CKYLBMHp1QDo9i6TfPfGgUuZOud
	e7hv9vdJLslOl77VWnNNDk032Dln7v0ue3ZDt5p9occ+b2sIUjv+4MUBNzaZ6a+3PT25/m5M
	TQ2fJ4/kjB1yBg7tvMFCxx/WvWBhf3x2o8ebyssbPScZCNyKm/s4XeEsE0f42aN3FV/eicrY
	aaH05nD8LMmqjuv9PEt3P1ViKc5INNRiLipOBACLhzNzeQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrHtyk1eawfXlHBZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgytgyaTlLwU/titv3VrM2ME5X7mLk5JAQMJFYeWAaE4jNJqAucePGT2YQW0TA
	TOJg6x92EJtZ4C6TxIF+NhBbWCBSYn3jU0YQm0VAVWLbmx1g9bxA9d/bd7JBzJSXWL3hAFic
	Eyg+Y9VOFhBbSMBU4sfRr2wTGLkWMDKsYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECAzkZbV/
	Ju5g/HLZ/RCjAAejEg/vhtueaUKsiWXFlbmHGCU4mJVEeDdtAQrxpiRWVqUW5ccXleakFh9i
	lOZgURLn9QpPTRASSE8sSc1OTS1ILYLJMnFwSjUwXim/sPG8woXUZZpls36/s7ujpLNTXU5o
	2sNHG1XOZHDv1td7ocMQWGeYsTvx8vVVQSIT2VplZ3BM1H2fOFG2w+o9I/OznvPnjV9s2PTC
	4FZXUGp844F8nVIv+8anVvtsl7En3EoxaPLO271g7p4Lsu6i3YLaO9qWJM3ral3VrVA/8c9j
	iQg2JZbijERDLeai4kQAotwRFmACAAA=
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
index c7692f303fa7..f9ed7a2b8720 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1609,6 +1609,81 @@ static int migrate_hugetlbs(struct list_head *from, new_folio_t get_new_folio,
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
+		switch(rc) {
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
@@ -1631,7 +1706,7 @@ static int migrate_pages_batch(struct list_head *from,
 	int pass = 0;
 	bool is_thp = false;
 	bool is_large = false;
-	struct folio *folio, *folio2, *dst = NULL, *dst2;
+	struct folio *folio, *folio2, *dst = NULL;
 	int rc, rc_saved = 0, nr_pages;
 	LIST_HEAD(unmap_folios);
 	LIST_HEAD(dst_folios);
@@ -1790,42 +1865,11 @@ static int migrate_pages_batch(struct list_head *from,
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
@@ -1834,20 +1878,8 @@ static int migrate_pages_batch(struct list_head *from,
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


