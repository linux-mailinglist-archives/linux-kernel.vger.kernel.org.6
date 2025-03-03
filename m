Return-Path: <linux-kernel+bounces-542691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE87A4CC79
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C345E174AA3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DB1232386;
	Mon,  3 Mar 2025 20:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V19+J/Ec"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524C5214A93
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741032392; cv=none; b=kxI/iWO80jlpJQx67f9VBEccub6WB+I5QOSXhLVmB9NP3+zv4wfFhiKvW9Rb9rXB6JaGY+hy4dNJqYm76f4Td8p6bCDyf2mWDMU8zVkx7n8lmhQB9dTZAOv1L1m59gn0MDq4qTXajqHXj/6VS+F8OTllwdTugfMcCbMUUBvMn6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741032392; c=relaxed/simple;
	bh=fsMuzxRivyzZyeg1j4JXmtloL/8F8+BDPkceOc8NEdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nR2CUbw5e1jYh87omnJRPjlmbXz0Po6fgj8z2/lrb8NXOue1UFA3C42ZnsZqeycpUXMIcAZpEnnV2vfmhxIwR1XGqWDSjxaj7S2JTf6Lohwnpf4YOMLo/BY9TQCP2ABjYudCkC8UB2nwP0+Ac+wHwL6c27Sfcw27zBpEXgwFpWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V19+J/Ec; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6fd719f9e0dso13320287b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 12:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741032389; x=1741637189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HdkfveeBHMcFthAzLeLlVIDBPC/Zmo/nuIz4RPFMAfw=;
        b=V19+J/EcV36P2YL+NnFnPudmSuzWyUssEuffSikZl/o6+kmaJGEQ10pkml5NTJse76
         /u/5jas/QSz9ruzs5XR6CUXj3IK5ZNWQtP1PKFN3UynxviKTi4VHYjEyH1jVA8VS6nBY
         Th8geTG7aXBkJRpe066RJGkL6z+iT3TnvIn3C3JNr7kDcm3pjuWLNVVSRruJyJaUg99N
         nc43Lk+s2CmOxEb/jBsPqHUKG4ygPo8pXRHiYb3lkGNA/OUCmwJeoBDRMRqB3cpaz+s4
         Tcxe8S4aMll5o4NIFrzL2P+9Z+pbvtb9VfdxFExM32aVq5KDhWIL9VbtfAB7ByOaEELy
         JQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741032389; x=1741637189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdkfveeBHMcFthAzLeLlVIDBPC/Zmo/nuIz4RPFMAfw=;
        b=UsKHrtBuz21lCslirVJIh3bMpHrUejyHQKiqIxYtubHvDvirVZ4ELnGebV6Cqiy5h2
         +c6mokXfCxtAzpkCgQ6GxLNvhqlrrfOihKUeAD62blY7QuMc18F4iBghhDnynmlPoiBA
         /4dfwvSpbUhFc/cqpXrYxQZWnwqhAz2+gUdQpFPh/L7IBqiRCqYN2iJ+o5sqnbRi/X20
         zFC33gQsRHkSqiaJEd3ZhtHA/mX0IjfhSJl0YIlIPAs/XoIOwXhA2esCc42ewOSTFxGM
         hhlHTLXB7TCokaFWdBZHVfN0IJyBCEni+N6tzkTlYFXISaCYY6NIzkyryNgvbkDFhy1O
         OE4A==
X-Forwarded-Encrypted: i=1; AJvYcCUhCl/CkgZKgi82EjA4bLiH/8+rRmKITRUCIRepyFlV8i0JPjTQPaLljUPOo7EIJ/PH9Ox5uBKZH3wgaHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdFqoI37s64uhzJf7EoPLOnwuHFDgLt/Q+NtHQrat5Q1CmJu8r
	aXpaesc5xzBq17Rst54ja0WVdZMt7ASkH+teHbnkBTmFRX6LrnIa9cb/Sw==
X-Gm-Gg: ASbGnctlynfDycRDiTXZ3moPsUUS3i2ZcDhwjmbQ6KUsgiZHtsaE9Vu8MCJ9rxlJITg
	DtEv+h2mCZiR2J1Ik4LcR2d85dpiOOrtykQP6alNPqOPvWcThMDfkt1ejCcfBbcbHCz3M9LlP9e
	GRYQ4Sxfh/ma7p+3iVpYwCP0mSnosih3BPVenp9On/yYdlCfz6mDstLR7X5HkTH+b6pvWkGWN5N
	w8dEp1Dv3pSFcnI1JnmAlwl1vgXZ7GospcGq35PSYruNEbkhrEeXnG/Hd0NzkBg5rWEv8dVIGxu
	vYix8np43GWur85o6z6tYyOE8weilbFosLI=
X-Google-Smtp-Source: AGHT+IFwi79QlbVMiM2gb/qIQACVkI5eUGxJILuAwvKnC6e45vwXI/U6kbVe8aV+EygTVz1UjXpIeQ==
X-Received: by 2002:a05:690c:6912:b0:6f8:cedc:570d with SMTP id 00721157ae682-6fd4a030070mr209744017b3.6.1741032389023;
        Mon, 03 Mar 2025 12:06:29 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd3ca0f3desm21421927b3.1.2025.03.03.12.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:06:28 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] page_io: zswap: do not crash the kernel on decompression failure
Date: Mon,  3 Mar 2025 12:06:27 -0800
Message-ID: <20250303200627.2102890-1-nphamcs@gmail.com>
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
zswap_load() case, we reorganize the swap read paths, having
swap_read_folio_zeromap() and zswap_load() return specific error codes:

* 0 indicates the backend owns the swapped out content, which was
  successfully loaded into the page.
* -ENOENT indicates the backend does not own the swapped out content.
* -EINVAL and -EIO indicate the backend own the swapped out content, but
  the content was not successfully loaded into the page for some
  reasons. The folio will not be marked up-to-date, which will
  eventually cause the process requesting the page to SIGBUS (see the
  handling of not-up-to-date folio in do_swap_page() in mm/memory.c).

zswap decompression failures on the zswap load path are treated as an
-EIO error, as described above, and will no longer crash the kernel.

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
 include/linux/zswap.h |   4 +-
 mm/page_io.c          |  35 ++++++++----
 mm/zswap.c            | 130 ++++++++++++++++++++++++++++++------------
 3 files changed, 120 insertions(+), 49 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index d961ead91bf1..9468cb3e0878 100644
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
@@ -46,7 +46,7 @@ static inline bool zswap_store(struct folio *folio)
 
 static inline bool zswap_load(struct folio *folio)
 {
-	return false;
+	return -ENOENT;
 }
 
 static inline void zswap_invalidate(swp_entry_t swp) {}
diff --git a/mm/page_io.c b/mm/page_io.c
index 9b983de351f9..8a44faec3f92 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -511,7 +511,21 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
 	mempool_free(sio, sio_pool);
 }
 
-static bool swap_read_folio_zeromap(struct folio *folio)
+/*
+ * Return: one of the following error codes:
+ *
+ *  0: the folio is zero-filled (and was populated as such and marked
+ *  up-to-date and unlocked).
+ *
+ *  -ENOENT: the folio was not zero-filled.
+ *
+ *  -EINVAL: some of the subpages in the folio are zero-filled, but not all of
+ *  them. This is an error because we don't currently support a large folio
+ *  that is partially in the zeromap. The folio is unlocked, but NOT marked
+ *  up-to-date, so that an IO error is emitted (e.g. do_swap_page() will
+ *  sigbus).
+ */
+static int swap_read_folio_zeromap(struct folio *folio)
 {
 	int nr_pages = folio_nr_pages(folio);
 	struct obj_cgroup *objcg;
@@ -523,11 +537,13 @@ static bool swap_read_folio_zeromap(struct folio *folio)
 	 * that an IO error is emitted (e.g. do_swap_page() will sigbus).
 	 */
 	if (WARN_ON_ONCE(swap_zeromap_batch(folio->swap, nr_pages,
-			&is_zeromap) != nr_pages))
-		return true;
+			&is_zeromap) != nr_pages)) {
+		folio_unlock(folio);
+		return -EINVAL;
+	}
 
 	if (!is_zeromap)
-		return false;
+		return -ENOENT;
 
 	objcg = get_obj_cgroup_from_folio(folio);
 	count_vm_events(SWPIN_ZERO, nr_pages);
@@ -538,7 +554,8 @@ static bool swap_read_folio_zeromap(struct folio *folio)
 
 	folio_zero_range(folio, 0, folio_size(folio));
 	folio_mark_uptodate(folio);
-	return true;
+	folio_unlock(folio);
+	return 0;
 }
 
 static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
@@ -635,13 +652,11 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 	}
 	delayacct_swapin_start();
 
-	if (swap_read_folio_zeromap(folio)) {
-		folio_unlock(folio);
+	if (swap_read_folio_zeromap(folio) != -ENOENT)
 		goto finish;
-	} else if (zswap_load(folio)) {
-		folio_unlock(folio);
+
+	if (zswap_load(folio) != -ENOENT)
 		goto finish;
-	}
 
 	/* We have to read from slower devices. Increase zswap protection. */
 	zswap_folio_swapin(folio);
diff --git a/mm/zswap.c b/mm/zswap.c
index 6dbf31bd2218..b67481defc6c 100644
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
@@ -996,11 +998,12 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	return comp_ret == 0 && alloc_ret == 0;
 }
 
-static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
+static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 {
 	struct zpool *zpool = entry->pool->zpool;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
+	int decomp_ret, dlen;
 	u8 *src;
 
 	acomp_ctx = acomp_ctx_get_cpu_lock(entry->pool);
@@ -1025,12 +1028,31 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	sg_init_table(&output, 1);
 	sg_set_folio(&output, folio, PAGE_SIZE, 0);
 	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
-	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
-	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
+	decomp_ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
+	dlen = acomp_ctx->req->dlen;
 
 	if (src != acomp_ctx->buffer)
 		zpool_unmap_handle(zpool, entry->handle);
 	acomp_ctx_put_unlock(acomp_ctx);
+
+	if (decomp_ret || dlen != PAGE_SIZE) {
+		zswap_decompress_fail++;
+		pr_alert_ratelimited(
+			"decompression failed with returned value %d on zswap entry with "
+			"swap entry value %08lx, swap type %d, and swap offset %lu. "
+			"compression algorithm is %s. compressed size is %u bytes, and "
+			"decompressed size is %u bytes.\n",
+			decomp_ret,
+			entry->swpentry.val,
+			swp_type(entry->swpentry),
+			swp_offset(entry->swpentry),
+			entry->pool->tfm_name,
+			entry->length,
+			acomp_ctx->req->dlen);
+
+		return false;
+	}
+	return true;
 }
 
 /*********************************
@@ -1060,6 +1082,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_NONE,
 	};
+	int ret = 0;
 
 	/* try to allocate swap cache folio */
 	si = get_swap_device(swpentry);
@@ -1081,8 +1104,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	 * and freed when invalidated by the concurrent shrinker anyway.
 	 */
 	if (!folio_was_allocated) {
-		folio_put(folio);
-		return -EEXIST;
+		ret = -EEXIST;
+		goto out;
 	}
 
 	/*
@@ -1095,14 +1118,17 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
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
@@ -1118,9 +1144,14 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 
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
@@ -1620,7 +1651,29 @@ bool zswap_store(struct folio *folio)
 	return ret;
 }
 
-bool zswap_load(struct folio *folio)
+/**
+ * zswap_load() - load a page from zswap
+ * @folio: folio to load
+ *
+ * Return: one of the following error codes:
+ *
+ *  0: if the swapped out content was in zswap and was successfully loaded.
+ *  The folio is unlocked and marked up-to-date.
+ *
+ *  -EIO: if the swapped out content was in zswap, but could not be loaded
+ *  into the page (for e.g, because there was a memory corruption, or a
+ *  decompression bug). The folio is unlocked, but NOT marked up-to-date,
+ *  so that an IO error is emitted (e.g. do_swap_page() will SIGBUS).
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
@@ -1631,18 +1684,32 @@ bool zswap_load(struct folio *folio)
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
@@ -1656,27 +1723,14 @@ bool zswap_load(struct folio *folio)
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
@@ -1771,6 +1825,8 @@ static int zswap_debugfs_init(void)
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

