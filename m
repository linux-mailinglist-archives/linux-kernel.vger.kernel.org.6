Return-Path: <linux-kernel+bounces-568507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789DDA69681
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417353BF0EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382AD202979;
	Wed, 19 Mar 2025 17:30:32 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CF21EF371
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405431; cv=none; b=XA7HaCs1cdFsPpBEKkEW/wr2U8kKkUYGZlRRyOvrGTygHgu/1sQh+elSa9BJ3o5T7hGd7XrAW96xymUH6YHrCsJKkvcery0NQx2uSvFnh36hy+3kUek01/7PxrcPVvmjq7uBHlcciFQ1jysUFSDxHhMHNO/5AuyU1eEXEsLnd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405431; c=relaxed/simple;
	bh=2a3vWbOQZxa43UEjag3UcZLs+eNu7cThdqh3tzX9VJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dZv5H3SNM0xqKdsfyS/7ZYo7hmrvrSMg8jETKeJOC/QG0m+18rvJ8XZXfp+psiEAvSYV6jOe6VeD44m/izrwBHCpeYqOj8Jbs6Es8O8KbSfJwK/MK6ie/Vk4s5MHXEw396vMyz55Di9d557U9DFzZm2x9q+BRoYRJg2cr3cOe1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:8180:83cc:5a47:caff:fe78:8708] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tuxDG-0000000081m-1RhR;
	Wed, 19 Mar 2025 13:28:18 -0400
Date: Wed, 19 Mar 2025 13:28:18 -0400
From: Rik van Riel <riel@surriel.com>
To: Vinay Banakar <vny@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, Bharata B Rao
 <bharata@amd.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter
 Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, SeongJae
 Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>, Byungchul Park
 <byungchul@sk.com>, Brendan Jackman <jackmanb@google.com>
Subject: [PATCH] mm/vmscan: batch TLB flush during memory reclaim
Message-ID: <20250319132818.1003878b@fangorn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com

From: Vinay Banakar <vny@google.com>

The current implementation in shrink_folio_list() performs a full TLB
flush for every individual folio reclaimed. This causes unnecessary
overhead during memory reclaim.

The current code:
1. Clears PTEs and unmaps each page individually
2. Performs a full TLB flush on every CPU the mm is running on

The new code:
1. Clears PTEs and unmaps each page individually
2. Adds each unmapped page to pageout_folios
3. Flushes the TLB once before procesing pageout_folios

This reduces the number of TLB flushes issued by the memory reclaim
code by 1/N, where N is the number of mapped folios encountered in
the batch processed by shrink_folio_list.

[riel: forward port to 6.14, adjust code and naming to match surrounding code]

Signed-off-by: Vinay Banakar <vny@google.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 mm/vmscan.c | 113 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 69 insertions(+), 44 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c767d71c43d7..ed2761610620 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1086,6 +1086,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	struct folio_batch free_folios;
 	LIST_HEAD(ret_folios);
 	LIST_HEAD(demote_folios);
+	LIST_HEAD(pageout_folios);
 	unsigned int nr_reclaimed = 0, nr_demoted = 0;
 	unsigned int pgactivate = 0;
 	bool do_demote_pass;
@@ -1394,51 +1395,10 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 				goto keep_locked;
 
 			/*
-			 * Folio is dirty. Flush the TLB if a writable entry
-			 * potentially exists to avoid CPU writes after I/O
-			 * starts and then write it out here.
+			 * Add to pageout list for batched TLB flushing and IO submission.
 			 */
-			try_to_unmap_flush_dirty();
-			switch (pageout(folio, mapping, &plug, folio_list)) {
-			case PAGE_KEEP:
-				goto keep_locked;
-			case PAGE_ACTIVATE:
-				/*
-				 * If shmem folio is split when writeback to swap,
-				 * the tail pages will make their own pass through
-				 * this function and be accounted then.
-				 */
-				if (nr_pages > 1 && !folio_test_large(folio)) {
-					sc->nr_scanned -= (nr_pages - 1);
-					nr_pages = 1;
-				}
-				goto activate_locked;
-			case PAGE_SUCCESS:
-				if (nr_pages > 1 && !folio_test_large(folio)) {
-					sc->nr_scanned -= (nr_pages - 1);
-					nr_pages = 1;
-				}
-				stat->nr_pageout += nr_pages;
-
-				if (folio_test_writeback(folio))
-					goto keep;
-				if (folio_test_dirty(folio))
-					goto keep;
-
-				/*
-				 * A synchronous write - probably a ramdisk.  Go
-				 * ahead and try to reclaim the folio.
-				 */
-				if (!folio_trylock(folio))
-					goto keep;
-				if (folio_test_dirty(folio) ||
-				    folio_test_writeback(folio))
-					goto keep_locked;
-				mapping = folio_mapping(folio);
-				fallthrough;
-			case PAGE_CLEAN:
-				; /* try to free the folio below */
-			}
+			list_add(&folio->lru, &pageout_folios);
+			continue;
 		}
 
 		/*
@@ -1549,6 +1509,71 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	}
 	/* 'folio_list' is always empty here */
 
+	if (!list_empty(&pageout_folios)) {
+		/*
+		 * The loop above unmapped the folios from the page tables.
+		 * One TLB flush takes care of the whole batch.
+		 */
+		try_to_unmap_flush_dirty();
+
+		while (!list_empty(&pageout_folios)) {
+			struct folio *folio = lru_to_folio(&pageout_folios);
+			struct address_space *mapping;
+			list_del(&folio->lru);
+
+			/* Recheck if the page got reactivated */
+			if (folio_test_active(folio) ||
+			    (folio_mapped(folio) && folio_test_young(folio)))
+				goto skip_pageout_locked;
+
+			mapping = folio_mapping(folio);
+			switch (pageout(folio, mapping, &plug, &pageout_folios)) {
+			case PAGE_KEEP:
+			case PAGE_ACTIVATE:
+				goto skip_pageout_locked;
+			case PAGE_SUCCESS:
+				/*
+				 * If shmem folio is split when writeback to swap,
+				 * the tail pages will make their own pass through
+				 * this loop and be accounted then.
+				 */
+				stat->nr_pageout += folio_nr_pages(folio);
+
+				if (folio_test_writeback(folio))
+					goto skip_pageout;
+				if (folio_test_dirty(folio))
+					goto skip_pageout;
+
+				/*
+				 * A synchronous write - probably a ramdisk.  Go
+				 * ahead and try to reclaim the folio.
+				 */
+				if (!folio_trylock(folio))
+					goto skip_pageout;
+				if (folio_test_dirty(folio) ||
+				    folio_test_writeback(folio))
+					goto skip_pageout_locked;
+				mapping = folio_mapping(folio);
+				/* try to free the folio below */
+				fallthrough;
+			case PAGE_CLEAN:
+				/* try to free the folio */
+				if (!mapping ||
+				    !remove_mapping(mapping, folio))
+					goto skip_pageout_locked;
+
+				nr_reclaimed += folio_nr_pages(folio);
+				folio_unlock(folio);
+				continue;
+			}
+
+skip_pageout_locked:
+			folio_unlock(folio);
+skip_pageout:
+			list_add(&folio->lru, &ret_folios);
+		}
+	}
+
 	/* Migrate folios selected for demotion */
 	nr_demoted = demote_folio_list(&demote_folios, pgdat);
 	nr_reclaimed += nr_demoted;
-- 
2.47.1


