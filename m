Return-Path: <linux-kernel+bounces-549833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5780EA557BF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 660337A894B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3CB1FDA97;
	Thu,  6 Mar 2025 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhdD9V2n"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D12907
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294215; cv=none; b=TDUkBPYhnhCu01gwXoxMCB1kRZ85w1MBHGErgetmKk8xFgm5fq5yPtvwvU/FYpWU+P7S/qDuFer8HASkf1KlCVcopII7MgCeYM/GBDaUeOuq24KQ3/GJXRVfCAujoSztqeUoF7D+M1GYCsAD28ng2KPzrEEuW6EadoR/yaqwUTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294215; c=relaxed/simple;
	bh=0p3VWC6g/rVoeVWh+yiyC5gOXJiJIJvuFtg5yLWwpjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ICZJsbqDA0Z0ssDT6PZiD2A4cKuuIewptqPyvTrRhNSdYc20ys66nI0XgDRopTAqkf9gcUr9PhHTqie1XbQtMTaKAEYytw59+rFsEsMA0sE6A3r2jDm54iwa5lloV+nLYGLDVidnUrZl92faEiXCIZNq3DuRJA3C7KKbHjj0Y5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhdD9V2n; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e60b75f8723so812877276.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 12:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741294212; x=1741899012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CW+w+PN/jx32kLzmAOgMqdjE70IN/TzfJPx39gL+5rc=;
        b=nhdD9V2nZ9c/t6fRzYIN1/fF6phXaIXpQNgGi8ESBEfcjJEvHiUSwzkPtitm8KotDT
         ENWBJiAHg8AMgCODVKuPc4d6cOl8Mm1Rkx061dgITxtPcHUQlWC3+cpvMWLSR6AadQky
         d3C1DKayBSvZH0rKS5HtseymaprAReqit+p6ootTHmdGdFNAPWWuAtRE+Jg9LzM7VfnS
         k3IwoaUs2DHEDqOvEegRMOhPmyrBbQQ+i9UEP1UhIijdMLc/AtmlKaPGq16pJf8RevId
         idruqubk2hEafg7DSXdnrtrB/krGkbeXFWfKQ0L/ZzIGUAdcKBPbbTcsdAGbenV8a/JO
         7vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741294212; x=1741899012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CW+w+PN/jx32kLzmAOgMqdjE70IN/TzfJPx39gL+5rc=;
        b=hEC2LDBl2kxN+Sk96kcLJGghERCAwEQFtCasGjxqmdN3h9swyqZF2rhDsUQdlzzek7
         R1ZCSJT5DnVox03KfXOeSo5zGufUL87974ZNmBH6fGDberzQd682ud5h3Kb5rLlD3SyV
         9ltERPieDHT6Ah31AuUIgxBQJNli9hVngNaAEbpDrQ+dFj6w+kBB6qTAyFOY2AbsqU1W
         GiDbPdZvBzF1t6txqLD7wU85X5QB5A0Lbg7Z7ucDfFXx7kIZMRcbSTJM+3XT6txxO/3A
         i8vQQud1EA5SGfl8YPXkDcxHFT50EN/8Jyz/Mvos1ZetT33rpaPJfdQfV49voksMbJfz
         BGSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjGHTque+LZe09m1rq5AqO2xkkZuUmKI5JinR5ogFdFzr09oCW2db3wCNM2fICCepGFUfVC9FPMm6yhBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjHpdyIya7EGAnKfbPzPTkNHpJGrAGkYoG+DFJZbGKWYJtbtZ2
	TtHnkvUi6s1AyD/WEuRG43VLtA8/Bozj4ByqahrjzvqxLY1VeQCz
X-Gm-Gg: ASbGncuvkc5GeuWbb+Lo6kZY8q6VayEyq6LTTPDGamkIgZj/xkQiVinF0xbtqDZc2y0
	5B6mcWnWUtB4T9a4tZtkfTnxjCg4J4y/8MbmE6Rz/S2CV+KASxRbOq/h0LBDNE6iMqJseG3UZg2
	FAQOaFph9ONnSPmS4NJ7sse0RbygNukU5Jr4CdwDkNlsgjhq4VRmir0JdWqpaBKPQjbbuPs+UjA
	qJugme5jAk5/HDuhEQDscjsYyJL9OB4S/WL7U4Veu0EbELB97dF0RCf2FWQ3G58/bwBKCdxznDO
	MlyD3+7/XXMEUoPIT26Rh7R8qXgBdCEUawjt
X-Google-Smtp-Source: AGHT+IFvpVx9Ots+rSZAhtOqWblxPULMnkskDtDJKAJlLVE17r/FOJnwPAYUt7eNkmwSGm7X7M38mg==
X-Received: by 2002:a05:6902:2481:b0:e60:a6a0:f5bf with SMTP id 3f1490d57ef6-e635c1002dcmr1200540276.5.1741294211940;
        Thu, 06 Mar 2025 12:50:11 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e634b84312asm485270276.23.2025.03.06.12.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 12:50:11 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] page_io: zswap: do not crash the kernel on decompression failure
Date: Thu,  6 Mar 2025 12:50:10 -0800
Message-ID: <20250306205011.784787-1-nphamcs@gmail.com>
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
entry in zswap writeback.

See [1] for a recent upstream discussion about this.

The zswap writeback case is relatively straightforward to fix. For the
zswap_load() case, we change the return behavior:

* Return 0 on success.
* Return -ENOENT (with the folio locked) if zswap does not own the
  swapped out content.
* Return -EIO if zswap owns the swapped out content, but encounters a
  decompression failure for some reasons. The folio will be unlocked,
  but not be marked up-to-date, which will eventually cause the process
  requesting the page to SIGBUS (see the handling of not-up-to-date
  folio in do_swap_page() in mm/memory.c), without crashing the kernel.
* Return -EINVAL if we encounter a large folio, as large folio should
  not be swapped in while zswap is being used. Similar to the -EIO case,
  we also unlock the folio but do not mark it as up-to-date to SIGBUS
  the faulting process.

As a side effect, we require one extra zswap tree traversal in the load
and writeback paths. Quick benchmarking on a kernel build test shows no
performance difference:

With the new scheme:
real: mean: 125.1s, stdev: 0.12s
user: mean: 3265.23s, stdev: 9.62s
sys: mean: 2156.41s, stdev: 13.98s

The old scheme:
real: mean: 125.78s, stdev: 0.45s
user: mean: 3287.18s, stdev: 5.95s
sys: mean: 2177.08s, stdev: 26.52s

[1]: https://lore.kernel.org/all/ZsiLElTykamcYZ6J@casper.infradead.org/

Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/zswap.h |   6 +--
 mm/page_io.c          |   6 +--
 mm/zswap.c            | 118 +++++++++++++++++++++++++++++-------------
 3 files changed, 87 insertions(+), 43 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index d961ead91bf1..30c193a1207e 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -26,7 +26,7 @@ struct zswap_lruvec_state {
 
 unsigned long zswap_total_pages(void);
 bool zswap_store(struct folio *folio);
-bool zswap_load(struct folio *folio);
+int zswap_load(struct folio *folio);
 void zswap_invalidate(swp_entry_t swp);
 int zswap_swapon(int type, unsigned long nr_pages);
 void zswap_swapoff(int type);
@@ -44,9 +44,9 @@ static inline bool zswap_store(struct folio *folio)
 	return false;
 }
 
-static inline bool zswap_load(struct folio *folio)
+static inline int zswap_load(struct folio *folio)
 {
-	return false;
+	return -ENOENT;
 }
 
 static inline void zswap_invalidate(swp_entry_t swp) {}
diff --git a/mm/page_io.c b/mm/page_io.c
index 9b983de351f9..4bce19df557b 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -638,11 +638,11 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 	if (swap_read_folio_zeromap(folio)) {
 		folio_unlock(folio);
 		goto finish;
-	} else if (zswap_load(folio)) {
-		folio_unlock(folio);
-		goto finish;
 	}
 
+	if (zswap_load(folio) != -ENOENT)
+		goto finish;
+
 	/* We have to read from slower devices. Increase zswap protection. */
 	zswap_folio_swapin(folio);
 
diff --git a/mm/zswap.c b/mm/zswap.c
index 138b50ba832b..799b22c19b5e 100644
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
@@ -985,11 +987,12 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	return comp_ret == 0 && alloc_ret == 0;
 }
 
-static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
+static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 {
 	struct zpool *zpool = entry->pool->zpool;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
+	int decomp_ret, dlen;
 	u8 *src, *obj;
 
 	acomp_ctx = acomp_ctx_get_cpu_lock(entry->pool);
@@ -1012,11 +1015,21 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	sg_init_table(&output, 1);
 	sg_set_folio(&output, folio, PAGE_SIZE, 0);
 	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
-	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
-	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
+	decomp_ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
+	dlen = acomp_ctx->req->dlen;
 
 	zpool_obj_read_end(zpool, entry->handle, obj);
 	acomp_ctx_put_unlock(acomp_ctx);
+
+	if (!decomp_ret && dlen == PAGE_SIZE)
+		return true;
+
+	zswap_decompress_fail++;
+	pr_alert_ratelimited("Decompression error from zswap (%d:%lu %s %u->%d)\n",
+						swp_type(entry->swpentry),
+						swp_offset(entry->swpentry),
+						entry->pool->tfm_name, entry->length, dlen);
+	return false;
 }
 
 /*********************************
@@ -1046,6 +1059,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_NONE,
 	};
+	int ret = 0;
 
 	/* try to allocate swap cache folio */
 	si = get_swap_device(swpentry);
@@ -1067,8 +1081,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	 * and freed when invalidated by the concurrent shrinker anyway.
 	 */
 	if (!folio_was_allocated) {
-		folio_put(folio);
-		return -EEXIST;
+		ret = -EEXIST;
+		goto out;
 	}
 
 	/*
@@ -1081,14 +1095,17 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
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
+		goto out;
 	}
 
-	zswap_decompress(entry, folio);
+	if (!zswap_decompress(entry, folio)) {
+		ret = -EIO;
+		goto out;
+	}
+
+	xa_erase(tree, offset);
 
 	count_vm_event(ZSWPWB);
 	if (entry->objcg)
@@ -1104,9 +1121,14 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 
 	/* start writeback */
 	__swap_writepage(folio, &wbc);
-	folio_put(folio);
 
-	return 0;
+out:
+	if (ret && ret != -EEXIST) {
+		delete_from_swap_cache(folio);
+		folio_unlock(folio);
+	}
+	folio_put(folio);
+	return ret;
 }
 
 /*********************************
@@ -1606,7 +1628,26 @@ bool zswap_store(struct folio *folio)
 	return ret;
 }
 
-bool zswap_load(struct folio *folio)
+/**
+ * zswap_load() - load a page from zswap
+ * @folio: folio to load
+ *
+ * Return: 0 on success, or one of the following error codes:
+ *
+ *  -EIO: if the swapped out content was in zswap, but could not be loaded
+ *  into the page due to a decompression failure. The folio is unlocked, but
+ *  NOT marked up-to-date, so that an IO error is emitted (e.g. do_swap_page()
+ *  will SIGBUS).
+ *
+ *  -EINVAL: if the swapped out content was in zswap, but the page belongs
+ *  to a large folio, which is not supported by zswap. The folio is unlocked,
+ *  but NOT marked up-to-date, so that an IO error is emitted (e.g.
+ *  do_swap_page() will SIGBUS).
+ *
+ *  -ENOENT: if the swapped out content was not in zswap. The folio remains
+ *  locked on return.
+ */
+int zswap_load(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
 	pgoff_t offset = swp_offset(swp);
@@ -1617,18 +1658,32 @@ bool zswap_load(struct folio *folio)
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 
 	if (zswap_never_enabled())
-		return false;
+		return -ENOENT;
 
 	/*
 	 * Large folios should not be swapped in while zswap is being used, as
 	 * they are not properly handled. Zswap does not properly load large
 	 * folios, and a large folio may only be partially in zswap.
-	 *
-	 * Return true without marking the folio uptodate so that an IO error is
-	 * emitted (e.g. do_swap_page() will sigbus).
 	 */
-	if (WARN_ON_ONCE(folio_test_large(folio)))
-		return true;
+	if (WARN_ON_ONCE(folio_test_large(folio))) {
+		folio_unlock(folio);
+		return -EINVAL;
+	}
+
+	entry = xa_load(tree, offset);
+	if (!entry)
+		return -ENOENT;
+
+	if (!zswap_decompress(entry, folio)) {
+		folio_unlock(folio);
+		return -EIO;
+	}
+
+	folio_mark_uptodate(folio);
+
+	count_vm_event(ZSWPIN);
+	if (entry->objcg)
+		count_objcg_events(entry->objcg, ZSWPIN, 1);
 
 	/*
 	 * When reading into the swapcache, invalidate our entry. The
@@ -1642,27 +1697,14 @@ bool zswap_load(struct folio *folio)
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
-		zswap_entry_free(entry);
 		folio_mark_dirty(folio);
+		xa_erase(tree, offset);
+		zswap_entry_free(entry);
 	}
 
-	folio_mark_uptodate(folio);
-	return true;
+	folio_unlock(folio);
+	return 0;
 }
 
 void zswap_invalidate(swp_entry_t swp)
@@ -1757,6 +1799,8 @@ static int zswap_debugfs_init(void)
 			   zswap_debugfs_root, &zswap_reject_compress_fail);
 	debugfs_create_u64("reject_compress_poor", 0444,
 			   zswap_debugfs_root, &zswap_reject_compress_poor);
+	debugfs_create_u64("decompress_fail", 0444,
+			   zswap_debugfs_root, &zswap_decompress_fail);
 	debugfs_create_u64("written_back_pages", 0444,
 			   zswap_debugfs_root, &zswap_written_back_pages);
 	debugfs_create_file("pool_total_size", 0444,

base-commit: 36768063c930199d5e01cde4d7a14fae3ccad51c
-- 
2.43.5

