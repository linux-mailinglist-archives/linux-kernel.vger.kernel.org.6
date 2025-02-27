Return-Path: <linux-kernel+bounces-535198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB3FA4700A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE30318804CF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC323749C;
	Thu, 27 Feb 2025 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmi/kiBx"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EF2C133
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615289; cv=none; b=jG9i2Fv0fpUUdujCZzXtqjpJWFDD2udfrg7rd6ghr8KrTGqQ5AX1OkTBxrqqPhfJwCZBGuUvwXCznTr7FMsOC3+5x/Y3mYm++sbfc3GXQ/wKidojdQnatLoExj5htsKlbGt9pgc4ECOKfKXCPnCBJrbtchuQQ8HVHSJuhhPWI9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615289; c=relaxed/simple;
	bh=RailmPJAzhqmxJZv14Daex/APHu36shwM6xbxYvkooo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNvaHQTV1wr0yympzdR+Xrfcz4cX5XCQ0qQnCcmhLXriMvN0qi0/fztoZ1IHQ/zHUvNRNfGxqDLaxgkOh22kOOHeWp/Hntr4CjcaNYPSBDVTRAT20ZnxvLpss/+F+LvRkNS11zMFklRGWg8PgHt4mCRQ9IjMxQxmeDPp4Wyf0UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmi/kiBx; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6fd3b6a6a24so1501597b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740615286; x=1741220086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7FGmvfp8qBg8DjAtLK6Oe9oRO76pBZzftFVPLP7nIc=;
        b=hmi/kiBxHackBXBxOQ0yb6p1/IBvy/JhysUOPwytox548ghXlhzcXGFdmMzp7Ry9FK
         48p66pCezLXmqBvNmxVnTPlplRMuD0cqnfqx2dl+jiQPQ82VF8k36Rlhn+heKvlWpZiD
         Pm7CN/Kbsp9y6CYm36/of9CkQgjvUjR4n8CeWvosp2C2ZoQOVifrjoC+lkG6n5J5spNe
         M/jgTrjBH+Uje3m0/x80+BEeeYCYFa8p9Vk0LwPui6oB0lyO/T2vRtP5q7fGyeTU/kav
         LPmBCgKqhCYK+PkIS/otk0JkjmJv66PuYoML0WoW6d6MSAFNC/+Y8+3i4eMDRhU9u8B2
         8GKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740615286; x=1741220086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7FGmvfp8qBg8DjAtLK6Oe9oRO76pBZzftFVPLP7nIc=;
        b=SfaHU+5qqbqtZMnk/altQsnwvTmHhT0tW+beGaCuomeemVrhNloPq6T5tCGFRWZAXZ
         tPnxAdsCPNI6Im0dEFGgxCwO9FDIIalbKy9i+WyEEH5Z1SebYx4sOewcF35WCfGcd9QN
         HVBbP12AzqtXSUzpzC9g2US9hLANwFcbRcWv35gBfcwhzSqPH3dmtBUcdhYHbThNd4HM
         Ar+2ztXK0XZnJvyzaSSOnANKgXtxxIVgPtpBpFUI5YEXe6ufzajGayt0K5EaGwI2Lk2P
         TWWAtS8JQ0ylBdoUQxn+0hScijIR2gTtmeuFZS50xsnw9TvZQMp1EAZobTgxYhuEFHrC
         wlCA==
X-Forwarded-Encrypted: i=1; AJvYcCVn69vzkAZRvQC/5BZjGdrIzO3893l5YB0lUBTFcFeV0dQqoAf5V8TpyT4zBJ+ZmgibcG6YR4OZnTR2ZJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDv5jUZp0K9QJeUpopKR9TuYV9NJVvd4FbDokSWCKYk9eelO4m
	Ei3ntjaLvuQa4eXE9v8VNhgkT+qPWZQ0YstyxpwbKXiOvcgNWrargDw6rA==
X-Gm-Gg: ASbGnct0HcoA98t8/51Ld2SEgaCKEXk4ohvXsdGLv/cYd+QQeVwR1e6tol+isFUkd/M
	yvoblw25R9YJkLATxoHBAgABMStD66L+Mi0xjwHTFT1cep35CBl7t2wJJ1CughzV72anxYlu+Au
	CaKCtqzUD7UI2fesJ05ISnswKMXSPIjHalus09gwy3RkeMI08NEvxF9y0x098M6/TD9uOKayLz6
	DWOxD+BB0fLmk0+5GPVntYc5SRVBLO68jhdqY06+50BLF9oikZBhb45JTCxdX5hGSw5iayql2Nf
	deNqtB5TH7+36taweg==
X-Google-Smtp-Source: AGHT+IGsI05nc3u4INuI63hgrvfexWbQ5GBKkI0kAUb2SP+FeeiPTtbBg8Udhf/lFmH68g03WAw38Q==
X-Received: by 2002:a05:690c:6888:b0:6f4:8207:c68d with SMTP id 00721157ae682-6fd21dd7d5emr54601917b3.3.1740615286061;
        Wed, 26 Feb 2025 16:14:46 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd3cbc5ac9sm423007b3.121.2025.02.26.16.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 16:14:45 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] zswap: do not crash the kernel on decompression failure
Date: Wed, 26 Feb 2025 16:14:45 -0800
Message-ID: <20250227001445.1099203-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we crash the kernel when a decompression failure occurs in
zswap (either because of memory corruption, or a bug in the compression
algorithm). This is overkill. We should only SIGBUS the unfortunate
process asking for the zswap entry on zswap load, and skip the corrupted
entry in zswap writeback. The former is accomplished by returning true
from zswap_load(), indicating that zswap owns the swapped out content,
but without flagging the folio as up-to-date. The process trying to swap
in the page will check for the uptodate folio flag and SIGBUS (see
do_swap_page() in mm/memory.c for more details).

See [1] for a recent upstream discussion about this.

[1]: https://lore.kernel.org/all/ZsiLElTykamcYZ6J@casper.infradead.org/

Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 94 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 67 insertions(+), 27 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 6dbf31bd2218..e4a2157bbc64 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -62,6 +62,8 @@ static u64 zswap_reject_reclaim_fail;
 static u64 zswap_reject_compress_fail;
 /* Compressed page was too big for the allocator to (optimally) store */
 static u64 zswap_reject_compress_poor;
+/* Load or writeback failed due to decompression failure */
+static u64 zswap_decompress_fail;
 /* Store failed because underlying allocator could not get memory */
 static u64 zswap_reject_alloc_fail;
 /* Store failed because the entry metadata could not be allocated (rare) */
@@ -996,11 +998,13 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	return comp_ret == 0 && alloc_ret == 0;
 }
 
-static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
+static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 {
 	struct zpool *zpool = entry->pool->zpool;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
+	int decomp_ret;
+	bool ret = true;
 	u8 *src;
 
 	acomp_ctx = acomp_ctx_get_cpu_lock(entry->pool);
@@ -1025,12 +1029,25 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	sg_init_table(&output, 1);
 	sg_set_folio(&output, folio, PAGE_SIZE, 0);
 	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
-	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
-	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
+	decomp_ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
+	if (decomp_ret || acomp_ctx->req->dlen != PAGE_SIZE) {
+		ret = false;
+		zswap_decompress_fail++;
+		pr_alert_ratelimited(
+			"decompression failed with returned value %d on zswap entry with swap entry value %08lx, swap type %d, and swap offset %lu. compression algorithm is %s. compressed size is %u bytes, and decompressed size is %u bytes.\n",
+			decomp_ret,
+			entry->swpentry.val,
+			swp_type(entry->swpentry),
+			swp_offset(entry->swpentry),
+			entry->pool->tfm_name,
+			entry->length,
+			acomp_ctx->req->dlen);
+	}
 
 	if (src != acomp_ctx->buffer)
 		zpool_unmap_handle(zpool, entry->handle);
 	acomp_ctx_put_unlock(acomp_ctx);
+	return ret;
 }
 
 /*********************************
@@ -1060,6 +1077,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_NONE,
 	};
+	int ret = 0;
 
 	/* try to allocate swap cache folio */
 	si = get_swap_device(swpentry);
@@ -1081,8 +1099,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	 * and freed when invalidated by the concurrent shrinker anyway.
 	 */
 	if (!folio_was_allocated) {
-		folio_put(folio);
-		return -EEXIST;
+		ret = -EEXIST;
+		goto put_folio;
 	}
 
 	/*
@@ -1095,14 +1113,17 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	 * be dereferenced.
 	 */
 	tree = swap_zswap_tree(swpentry);
-	if (entry != xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL)) {
-		delete_from_swap_cache(folio);
-		folio_unlock(folio);
-		folio_put(folio);
-		return -ENOMEM;
+	if (entry != xa_load(tree, offset)) {
+		ret = -ENOMEM;
+		goto delete_unlock;
+	}
+
+	if (!zswap_decompress(entry, folio)) {
+		ret = -EIO;
+		goto delete_unlock;
 	}
 
-	zswap_decompress(entry, folio);
+	xa_erase(tree, offset);
 
 	count_vm_event(ZSWPWB);
 	if (entry->objcg)
@@ -1118,9 +1139,14 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 
 	/* start writeback */
 	__swap_writepage(folio, &wbc);
-	folio_put(folio);
 
-	return 0;
+put_folio:
+	folio_put(folio);
+	return ret;
+delete_unlock:
+	delete_from_swap_cache(folio);
+	folio_unlock(folio);
+	goto put_folio;
 }
 
 /*********************************
@@ -1620,6 +1646,20 @@ bool zswap_store(struct folio *folio)
 	return ret;
 }
 
+/**
+ * zswap_load() - load a page from zswap
+ * @folio: folio to load
+ *
+ * Returns: true if zswap owns the swapped out contents, false otherwise.
+ *
+ * Note that the zswap_load() return value doesn't indicate success or failure,
+ * but whether zswap owns the swapped out contents. This MUST return true if
+ * zswap does own the swapped out contents, even if it fails to write the
+ * contents to the folio. Otherwise, the caller will try to read garbage from
+ * the backend.
+ *
+ * Success is signaled by marking the folio uptodate.
+ */
 bool zswap_load(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
@@ -1644,6 +1684,17 @@ bool zswap_load(struct folio *folio)
 	if (WARN_ON_ONCE(folio_test_large(folio)))
 		return true;
 
+	entry = xa_load(tree, offset);
+	if (!entry)
+		return false;
+
+	if (!zswap_decompress(entry, folio))
+		return true;
+
+	count_vm_event(ZSWPIN);
+	if (entry->objcg)
+		count_objcg_events(entry->objcg, ZSWPIN, 1);
+
 	/*
 	 * When reading into the swapcache, invalidate our entry. The
 	 * swapcache can be the authoritative owner of the page and
@@ -1656,21 +1707,8 @@ bool zswap_load(struct folio *folio)
 	 * files, which reads into a private page and may free it if
 	 * the fault fails. We remain the primary owner of the entry.)
 	 */
-	if (swapcache)
-		entry = xa_erase(tree, offset);
-	else
-		entry = xa_load(tree, offset);
-
-	if (!entry)
-		return false;
-
-	zswap_decompress(entry, folio);
-
-	count_vm_event(ZSWPIN);
-	if (entry->objcg)
-		count_objcg_events(entry->objcg, ZSWPIN, 1);
-
 	if (swapcache) {
+		xa_erase(tree, offset);
 		zswap_entry_free(entry);
 		folio_mark_dirty(folio);
 	}
@@ -1771,6 +1809,8 @@ static int zswap_debugfs_init(void)
 			   zswap_debugfs_root, &zswap_reject_compress_fail);
 	debugfs_create_u64("reject_compress_poor", 0444,
 			   zswap_debugfs_root, &zswap_reject_compress_poor);
+	debugfs_create_u64("decompress_fail", 0444,
+			   zswap_debugfs_root, &zswap_decompress_fail);
 	debugfs_create_u64("written_back_pages", 0444,
 			   zswap_debugfs_root, &zswap_written_back_pages);
 	debugfs_create_file("pool_total_size", 0444,

base-commit: 598d34afeca6bb10554846cf157a3ded8729516c
-- 
2.43.5

