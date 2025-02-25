Return-Path: <linux-kernel+bounces-532528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2545A44EFA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 121597A531A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAE1212D83;
	Tue, 25 Feb 2025 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLaVXNdx"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6CE1A4E98
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740519126; cv=none; b=PFq+OIjY6fn4AAh2Y8sDqlOdN7JAa34HKPjjeihaCsW2FdBvbbsDyt8FVUJl+CLhvL4GO6CtKq4e9lCMOexSG5bVJeSr50WdrUV5F05kSF6nL/ZOJqCRXfQfgVRkjO/uE/8/ALpy6dw+3POvDUIfJ74bkkzb30QlieMQWOv+hN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740519126; c=relaxed/simple;
	bh=uRDLdkZS9/NtZAoaxTUipJyEmLKP+vgA1WGHOFs9aGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=npmMPSzz+FuxmWuRWggK+iJ4c/SBEUAsrOXLuiFOlfgUo2oONjRtFbVaz5jiCfW/TrELpqB/xbl6VJ3f1dRo04/Ceh4T1scdBXlVZqQGmaBOfh8Bhgokkh6Z/W3mK5MIkzYHKfTFsGEB8cKFLoObEEXfE17eV+QNMaPQXQaEYI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLaVXNdx; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f7031ea11cso55529787b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740519121; x=1741123921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I7Rrea/X07qPqBXuL0X3TBXgqYMlwfU0ITIeihIkB7o=;
        b=DLaVXNdxZRdMppEU5Wg2D4WRdgxNNp57s4S+uLP+DjoTm5FxSSYCY+nFlU4wfV1ppT
         8JcFsmWx7Bo6w79u6j+csn1a5gd6Sw/kfdzmhGHkZUG0alIzuWhqt0d7+MwLY9sW/9EG
         p6WGzkyxz7WXZDkz/oap4WXmv//PDhmnCXuNPvAfIzbLI6a5RlwZi8RwArq214RLZyHn
         /B8Ybc+yNYDxeCzbP07Hb7MOaZCNQG1JUhQ3lPeUcdDV1dKK+BclaMNe8YBKhcds/o09
         3cZU37tB6HiP5k0aZF8zHgYzhQm4uw3qBTxBUh7wYBwOb3gp+K5G0Pqr8UBtgZHqxXLo
         ykkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740519121; x=1741123921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7Rrea/X07qPqBXuL0X3TBXgqYMlwfU0ITIeihIkB7o=;
        b=XYRvXRiyP3N+4SlB9bzCm5S6SK7j8nRBPavchDXr0lTf+AtcBSeNHDdJMRtBy7LZdB
         5aVsmkyxk+IO/MmA5+wZHDG9QD7X7imVSDuhY/qhOhmCgzzswgJrX7xcRRKM8bK5eUGj
         uwku8cK3CxEq2ix/Z1tSCBj3Qqd55AT9iccXBihQsOkKjYS7jFU/Gw5BbhAwDRAiVV6N
         28Bfbvmdl91e4m6cnn82H0sjV48Vls+iXCDRz60ZXay0hGtRoxciYCOm3uL1CNRQ7cFk
         It+rGGPGm80cuHCUFT0jiqAA50BOhZIXp7sAbKQ6bnJ64ngtMALv3dJXYElUmtSiiz7p
         ZyYA==
X-Forwarded-Encrypted: i=1; AJvYcCWsFSNtm91VXP6gM1+V0IS1abh/8D7+uSf2a6aZ3k2MgfvOjbcKxnxO6yf2QeH7svFo0MqEESOOAMsP3IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFlH1RCYCmIxPz/PatC9LV2up4DVmDlX+7sYVq+q5ZGBw23Qdn
	xMBv/n0+bDCLkPkgSM1XB2HDWwF6q8TJdFp6m9rQw99s14bswV9K
X-Gm-Gg: ASbGnctXgaukNg28UMoWDZSfgzUCqS8INc4HW7Y6/nQowDfNTUB4ofdDl3/kYADqNM7
	C3MAaDZX5OfwP1b8Pj5+/PbeRhNpfVwcsID0EB/qgV2E0RDgcosGp54mycStyJ7dYtmN7CJM1Ce
	eNQOrJNuUyvBbZFDF8gjA1LjBiZknajlf0/p7qelmb25QG+bNdajUMQb8VTwH/dTYMHrem3q3Wn
	W0MpZWn8WEC3zLEN5zumuR+blCJGaaM38gDAvG0z3KjNb2RFCVktD/E43DSkKHNPDOrvJWaZzdb
	uo829S2Iscr4bz9jBg==
X-Google-Smtp-Source: AGHT+IHVonpcA3bjsHp1vhOPOp2NisrZS4zDBbh6hiesTlr8TBlBhIV+AlpbUxqOo2ZlblfcldolqA==
X-Received: by 2002:a05:690c:680a:b0:6ef:7f89:d906 with SMTP id 00721157ae682-6fd220a8769mr11124647b3.33.1740519121459;
        Tue, 25 Feb 2025 13:32:01 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd1185bc43sm6375287b3.106.2025.02.25.13.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 13:32:00 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] zswap: do not crash the kernel on decompression failure
Date: Tue, 25 Feb 2025 13:32:00 -0800
Message-ID: <20250225213200.729056-1-nphamcs@gmail.com>
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

[1]: https://lore.kernel.org/all/ZsiLElTykamcYZ6J@casper.infradead.org/

Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 85 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 27 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f6316b66fb23..31d4397eed61 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -62,6 +62,8 @@ static u64 zswap_reject_reclaim_fail;
 static u64 zswap_reject_compress_fail;
 /* Compressed page was too big for the allocator to (optimally) store */
 static u64 zswap_reject_compress_poor;
+/* Load and writeback failed due to decompression failure */
+static u64 zswap_reject_decompress_fail;
 /* Store failed because underlying allocator could not get memory */
 static u64 zswap_reject_alloc_fail;
 /* Store failed because the entry metadata could not be allocated (rare) */
@@ -953,11 +955,12 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	return comp_ret == 0 && alloc_ret == 0;
 }
 
-static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
+static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 {
 	struct zpool *zpool = entry->pool->zpool;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
+	bool ret = true;
 	u8 *src;
 
 	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
@@ -984,12 +987,19 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	sg_init_table(&output, 1);
 	sg_set_folio(&output, folio, PAGE_SIZE, 0);
 	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
-	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
-	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
+	if (crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait) ||
+			acomp_ctx->req->dlen != PAGE_SIZE) {
+		ret = false;
+		zswap_reject_decompress_fail++;
+		pr_alert_ratelimited(
+			"decompression failed on zswap entry with offset %08lx\n",
+			entry->swpentry.val);
+	}
 	mutex_unlock(&acomp_ctx->mutex);
 
 	if (src != acomp_ctx->buffer)
 		zpool_unmap_handle(zpool, entry->handle);
+	return ret;
 }
 
 /*********************************
@@ -1018,6 +1028,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_NONE,
 	};
+	int ret = 0;
 
 	/* try to allocate swap cache folio */
 	mpol = get_task_policy(current);
@@ -1034,8 +1045,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	 * and freed when invalidated by the concurrent shrinker anyway.
 	 */
 	if (!folio_was_allocated) {
-		folio_put(folio);
-		return -EEXIST;
+		ret = -EEXIST;
+		goto put_folio;
 	}
 
 	/*
@@ -1048,14 +1059,17 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
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
+		goto fail;
 	}
 
-	zswap_decompress(entry, folio);
+	if (!zswap_decompress(entry, folio)) {
+		ret = -EIO;
+		goto fail;
+	}
+
+	xa_erase(tree, offset);
 
 	count_vm_event(ZSWPWB);
 	if (entry->objcg)
@@ -1071,9 +1085,14 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 
 	/* start writeback */
 	__swap_writepage(folio, &wbc);
-	folio_put(folio);
+	goto put_folio;
 
-	return 0;
+fail:
+	delete_from_swap_cache(folio);
+	folio_unlock(folio);
+put_folio:
+	folio_put(folio);
+	return ret;
 }
 
 /*********************************
@@ -1600,6 +1619,29 @@ bool zswap_load(struct folio *folio)
 	if (WARN_ON_ONCE(folio_test_large(folio)))
 		return true;
 
+	/*
+	 * We cannot invalidate the zswap entry before decompressing it. If
+	 * decompression fails, we must keep the entry in the tree so that
+	 * a future read by another process on the same swap entry will also
+	 * have to go through zswap. Otherwise, we risk silently reading
+	 * corrupted data for the other process.
+	 */
+	entry = xa_load(tree, offset);
+	if (!entry)
+		return false;
+
+	/*
+	 * If decompression fails, we return true to notify the caller that the
+	 * folio's data were in zswap, but do not mark the folio as up-to-date.
+	 * This will effectively SIGBUS the calling process.
+	 */
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
@@ -1612,21 +1654,8 @@ bool zswap_load(struct folio *folio)
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
@@ -1727,6 +1756,8 @@ static int zswap_debugfs_init(void)
 			   zswap_debugfs_root, &zswap_reject_compress_fail);
 	debugfs_create_u64("reject_compress_poor", 0444,
 			   zswap_debugfs_root, &zswap_reject_compress_poor);
+	debugfs_create_u64("reject_decompress_fail", 0444,
+			   zswap_debugfs_root, &zswap_reject_decompress_fail);
 	debugfs_create_u64("written_back_pages", 0444,
 			   zswap_debugfs_root, &zswap_written_back_pages);
 	debugfs_create_file("pool_total_size", 0444,
-- 
2.43.5


