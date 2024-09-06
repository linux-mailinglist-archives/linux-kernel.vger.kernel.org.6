Return-Path: <linux-kernel+bounces-317979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0999A96E6A4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2536A1C21417
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D6D819;
	Fri,  6 Sep 2024 00:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVQdz4yE"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740E48C0B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725581477; cv=none; b=AEfM7d/mbFzXxknXjdWfCRg6NiRDhZ1j6R30jqnOmRirs1vL2tajkBSS8OIUruPTsqQtJvPXphnmztTk1ybKcl/vLksvG66L0t4OyMTSJJNvnHmL50hWWbLGn+Kbp7gSmk/N1wP1wofy2v75jnwrPTulkC7nQOgK/V/BZXpEVgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725581477; c=relaxed/simple;
	bh=VuyU0xxoXycCoqy3vudJlY21agqDOkdf1ASkP+i+C9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LZq8nFApz8v02FYq1TqL+aIz+DpRMKq/p1AzBrAT0rsJ/80RUXY30uf8iT4tAqhlmANvdr/Cyl8QKuJApCcgs8MtJ/z1BtKF5jtotRT1ESuIc1yAj2ua8wFVzxv9z+YuMB90VylFL3bWYvYZseiGOO4G+vT8Qx1v3i9QV4ZE+Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVQdz4yE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-206bd1c6ccdso14091335ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 17:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725581475; x=1726186275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QXDrXH1Ww24AqoLO4gcy/YnLraR5k8WZQjyiNk/5Pk=;
        b=YVQdz4yEbY6z59nK9uzWtNLclGYMvJIRQaaWHHl8N+zHAYFk+3s/PSanRA1MakixOU
         zuTzdZfcogmeXpMy01eyNHI+rRoUzCG8g+S6AFy12Ne5WCr4StkV98JFzA92buvRXmeF
         s1MK1yGM1/XipZjr9OA8KkGBz223v3qGnMU7a4a4Ax1mvw6BM8svzAWdy17RWlIPbjqH
         NJg0MWwgf3+AF16ubKwTgoR0d9ua0FodOiKzXxNDeD3Pzsptq4XcTZGsEIrl5GrxjwRx
         ekv8KpTpth7V9EN2rWZ4TEzWQojkmwOMX3g1G6/QlPHNlVBFqufPr4K1eu8PL0TE0RvS
         NNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725581475; x=1726186275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QXDrXH1Ww24AqoLO4gcy/YnLraR5k8WZQjyiNk/5Pk=;
        b=CJxwqFvtXZJuK89YRspNi+41cySdV36+eqOn6p8uqesp+GF5+NYFX5jOFLiSYtAzRx
         TUcV9OUSkRR5KaDhrbnL7w+Rxhuebf1eYWgOt6BBRMEc8h+eJwXI81GFPGNNCfs66NWQ
         QbvzBHUsz0KUmzALQIq5WbQaNicI4FCaFOj7L2n+0CqrpGo7Z6lLMUo+f+3xPUT6Z77z
         MJCY7UsnmusSbm9BNcbzZM2mNe9tJZl1eYXaE6kwk7whdzbNFrEBW3lS3otLo+6UFkEw
         jJ+WgsANrTRWHWm34cuT9koN8ezKjSUz2uXmCVY03b96yAUaJQi3/16Pgx36Yp+aFYeS
         4fKg==
X-Forwarded-Encrypted: i=1; AJvYcCX8adkR79uNsjDKZrzoZp9Gdst43Q0+O2A4TeLm+2cLWl037EBMjQMBnBFn2KtjBdmJYxmtxY1crNTV+ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT1/3AwDzmduPZRoXvDReNbuPtk2g/9D+4uBPWhyPzGqC+1E4s
	9KU6U5jJ7wWEF5f3lbF3FcEEHChLg6LyPzL6Ag6w90xQCwz7pDZo
X-Google-Smtp-Source: AGHT+IFvLappnY16i84maiK/47bZsBM5+lg21Pra1SjZeJopowh0cGVj6dcf6eL6EAv/dFBjX036Cw==
X-Received: by 2002:a17:902:ce81:b0:1fb:1afb:b864 with SMTP id d9443c01a7336-206f049d07amr8865735ad.5.1725581474696;
        Thu, 05 Sep 2024 17:11:14 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:cd42:f8ae:5222:5ab7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea3548dsm33447445ad.140.2024.09.05.17.11.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Sep 2024 17:11:14 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hanchuanhua@oppo.com,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	hch@infradead.org,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	minchan@kernel.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	ryncsn@gmail.com,
	senozhatsky@chromium.org,
	shakeel.butt@linux.dev,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v8 1/3] mm: Fix swap_read_folio_zeromap() for large folios with partial zeromap
Date: Fri,  6 Sep 2024 12:10:45 +1200
Message-Id: <20240906001047.1245-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240906001047.1245-1-21cnbao@gmail.com>
References: <20240906001047.1245-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

There could be a corner case where the first entry is non-zeromap,
but a subsequent entry is zeromap. In this case, we should not
let swap_read_folio_zeromap() return false since we will still
read corrupted data.

Additionally, the iteration of test_bit() is unnecessary and
can be replaced with bitmap operations, which are more efficient.

We can adopt the style of swap_pte_batch() and folio_pte_batch() to
introduce swap_zeromap_batch() which seems to provide the greatest
flexibility for the caller. This approach allows the caller to either
check if the zeromap status of all entries is consistent or determine
the number of contiguous entries with the same status.

Since swap_read_folio() can't handle reading a large folio that's
partially zeromap and partially non-zeromap, we've moved the code
to mm/swap.h so that others, like those working on swap-in, can
access it.

Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap")
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/page_io.c | 32 +++++++-------------------------
 mm/swap.h    | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 4bc77d1c6bfa..2dfe2273a1f1 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -226,26 +226,6 @@ static void swap_zeromap_folio_clear(struct folio *folio)
 	}
 }
 
-/*
- * Return the index of the first subpage which is not zero-filled
- * according to swap_info_struct->zeromap.
- * If all pages are zero-filled according to zeromap, it will return
- * folio_nr_pages(folio).
- */
-static unsigned int swap_zeromap_folio_test(struct folio *folio)
-{
-	struct swap_info_struct *sis = swp_swap_info(folio->swap);
-	swp_entry_t entry;
-	unsigned int i;
-
-	for (i = 0; i < folio_nr_pages(folio); i++) {
-		entry = page_swap_entry(folio_page(folio, i));
-		if (!test_bit(swp_offset(entry), sis->zeromap))
-			return i;
-	}
-	return i;
-}
-
 /*
  * We may have stale swap cache pages in memory: notice
  * them here and get rid of the unnecessary final write.
@@ -524,19 +504,21 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
 
 static bool swap_read_folio_zeromap(struct folio *folio)
 {
-	unsigned int idx = swap_zeromap_folio_test(folio);
-
-	if (idx == 0)
-		return false;
+	int nr_pages = folio_nr_pages(folio);
+	bool is_zeromap;
+	int nr_zeromap = swap_zeromap_batch(folio->swap, nr_pages, &is_zeromap);
 
 	/*
 	 * Swapping in a large folio that is partially in the zeromap is not
 	 * currently handled. Return true without marking the folio uptodate so
 	 * that an IO error is emitted (e.g. do_swap_page() will sigbus).
 	 */
-	if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
+	if (WARN_ON_ONCE(nr_zeromap != nr_pages))
 		return true;
 
+	if (!is_zeromap)
+		return false;
+
 	folio_zero_range(folio, 0, folio_size(folio));
 	folio_mark_uptodate(folio);
 	return true;
diff --git a/mm/swap.h b/mm/swap.h
index f8711ff82f84..1cc56a02fb5f 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -80,6 +80,32 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 {
 	return swp_swap_info(folio->swap)->flags;
 }
+
+/*
+ * Return the count of contiguous swap entries that share the same
+ * zeromap status as the starting entry. If is_zeromap is not NULL,
+ * it will return the zeromap status of the starting entry.
+ */
+static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
+		bool *is_zeromap)
+{
+	struct swap_info_struct *sis = swp_swap_info(entry);
+	unsigned long start = swp_offset(entry);
+	unsigned long end = start + max_nr;
+	bool start_entry_zeromap;
+
+	start_entry_zeromap = test_bit(start, sis->zeromap);
+	if (is_zeromap)
+		*is_zeromap = start_entry_zeromap;
+
+	if (max_nr <= 1)
+		return max_nr;
+	if (start_entry_zeromap)
+		return find_next_zero_bit(sis->zeromap, end, start) - start;
+	else
+		return find_next_bit(sis->zeromap, end, start) - start;
+}
+
 #else /* CONFIG_SWAP */
 struct swap_iocb;
 static inline void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
@@ -171,6 +197,13 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 {
 	return 0;
 }
+
+static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
+		bool *has_zeromap)
+{
+	return 0;
+}
+
 #endif /* CONFIG_SWAP */
 
 #endif /* _MM_SWAP_H */
-- 
2.34.1


