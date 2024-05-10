Return-Path: <linux-kernel+bounces-175359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBDF8C1E79
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726B01C21F31
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8125D165FB6;
	Fri, 10 May 2024 06:52:37 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3C81635A1
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323956; cv=none; b=nHYlkGMe/MPbamFkV0BMGxC25J8ka/IeNEJyFscafw0IP3kqMM79F2YSYJ0TKJ+f98Q+jprM1DqIkbnoudPo3yyXGkSEpkRpcJLvG0EHDkBkcUuzfWbuOXIhv2gpIOvge9HmJZDqiDieWy74xd8SLibupUT3wtj4zePpbOaUE+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323956; c=relaxed/simple;
	bh=ehIxxhU20E42H9fwoVfMOG31SVEM0pU29Q1g7U/iKtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=s0fSQrh22qBV2BZ2hpq4bS9zePzrqklRRWUoAYqT+3msOUfnx9Vc2H6oV/oBoSAYx/cntDAyCSjDf+HY8FdGoNCIHQr2HRgQghWuzRdIgXMlxioIL+5qTuC8HQ33lNfbJ12gl0mVD6QmsM3eLYYnjJ2F9KPdXll9CSRy0laqocs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-f1-663dc4215f8d
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
Subject: [PATCH v10 10/12] mm: separate move/undo parts from migrate_pages_batch()
Date: Fri, 10 May 2024 15:52:04 +0900
Message-Id: <20240510065206.76078-11-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240510065206.76078-1-byungchul@sk.com>
References: <20240510065206.76078-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXC9ZZnka7iEds0gz83jS3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	lknLWQp+alfcvreatYFxunIXIweHhICJxINT5V2MnGBmx/nZLCA2m4C6xI0bP5lBbBEBM4mD
	rX/YQWxmgbtMEgf62UBsYYEgicPLjzOBjGERUJVo+l8EEuYFKv97ejMTxEh5idUbDoCN4QSK
	f1g2AywuJGAq0fFgImMXIxdQzWc2iQMP90I1SEocXHGDZQIj7wJGhlWMQpl5ZbmJmTkmehmV
	eZkVesn5uZsYgWG/rPZP9A7GTxeCDzEKcDAq8fDu2GyTJsSaWFZcmXuIUYKDWUmEt6rGOk2I
	NyWxsiq1KD++qDQntfgQozQHi5I4r9G38hQhgfTEktTs1NSC1CKYLBMHp1QDo4bVwppI6RW+
	37pd7CZPm5D7fE+9e4FG7r4tp/ae4jsY71Vz7/GaOStLOOqvTWBmXP5c8ILxrbspouYKHXrB
	2k/n9tmddFecJx/69+aMub7zxIOOba25ZPcqumZHzMldl8JtCx46t5r2mfq8OLDhVmubar2k
	/qxy9tkWzOuvrPJnCymf1eWnr8RSnJFoqMVcVJwIADV40Ud3AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrKt4xDbN4MYuTYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZWyZtJyl4Kd2xe17q1kbGKcrdzFyckgImEh0nJ/NAmKzCahL3LjxkxnEFhEw
	kzjY+ocdxGYWuMskcaCfDcQWFgiSOLz8OFMXIwcHi4CqRNP/IpAwL1D539ObmSBGykus3nAA
	bAwnUPzDshlgcSEBU4mOBxMZJzByLWBkWMUokplXlpuYmWOqV5ydUZmXWaGXnJ+7iREYxstq
	/0zcwfjlsvshRgEORiUe3h2bbdKEWBPLiitzDzFKcDArifBW1VinCfGmJFZWpRblxxeV5qQW
	H2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTBKOWfcnmPxb/6zrp0OdqXrHZ9vUmg2
	6GbZuoLdt/PNh2DHnDsFPj1Kp6bX3cu9e71uj/e60JeLUm6EWV8Ui3nvoqg4w2P9NIfjSTUp
	2d3WXzaWejw/fFb5fFTZ35v6t59IxfKz/r7X4jSjUprB4d31iRW8q39YXT8Y4eajnTU3xOm/
	oZX1HQUlluKMREMt5qLiRACpUG94XwIAAA==
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


