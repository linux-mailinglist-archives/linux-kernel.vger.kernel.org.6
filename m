Return-Path: <linux-kernel+bounces-371074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8A79A3600
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95F62B23B74
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C928188A00;
	Fri, 18 Oct 2024 06:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvokcR2P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C18186E27
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234092; cv=none; b=I/zjGn0seJMXLd5drtvb0ZE9wiE0EDeQAVCA/L5LRKkI++dEyGM7hdQqjQqA9tWOq6wVNJIf4EpLziK+yc0kwtJjknhQaCA+BsP40YAB/l3jN1R4DkFkMPwvIKL8cVQYd19MuKb3zCFE3LVj8PgiQ1By05QgbQVplwDn1Qf1BP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234092; c=relaxed/simple;
	bh=UPuvHsF/khjGuvZn4W/MjDOW3ucu5XL70qjTmnPaytQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Srst0AtrCqu8yDjYm2+hCrVGi1rE+EZ77wUCkskbJ6XBuAOPp2qoOj02CCNXE0uEgoIS3FRzHB46NtBKMORqtM22dFkAWARRaVbs3uyZWzsQfjVgiUTltw8z2UGztyssx9qVY6GnLUSKGKZF79zH5qd/U/mg0oR1BgUx+XYM+P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvokcR2P; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729234090; x=1760770090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UPuvHsF/khjGuvZn4W/MjDOW3ucu5XL70qjTmnPaytQ=;
  b=PvokcR2PrC/fXzeiGW0/7O+5QmdFS8EHHDS9owCgRbug2QvDKApy94Ml
   6zGYcWCd3HsMxksdipTV2LUqWDzmvQsgk0Jlq9M80gvTQaSs7n7cjS+8m
   HurD0wuS8FOXAYnfDpntBhbE/Ex2J6FqNGgQUp07GNDlkKD6/qIRTgEFn
   XmjkZCrgpRUT1Utnyli8pvukno1ZH/g0wSde4DWBgbCMoz6vHdMsFBOZi
   fU5SX52bHljcvy/Hbk2ANHBSJN2WkTiejBQm+B99aooCSyEEZXZVG/TAf
   lQzPSxxA1nhbsFNQBzHCXKjO4JD1ikHIH6wnIhHzjgiOYc+IUf3xRurDG
   g==;
X-CSE-ConnectionGUID: /I0hDXPXQ7ChIrj59nh3Jw==
X-CSE-MsgGUID: YIpKIewHTVyhMSKyrpQMMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28963326"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28963326"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:48:07 -0700
X-CSE-ConnectionGUID: NWgiSYFkS0SuqFRm5HR5lA==
X-CSE-MsgGUID: UXdDj26UTrKRjCKhs7vctg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="82744504"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa003.fm.intel.com with ESMTP; 17 Oct 2024 23:48:06 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	hughd@google.com,
	willy@infradead.org,
	bfoster@redhat.com,
	dchinner@redhat.com,
	chrisl@kernel.org,
	david@redhat.com
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [RFC PATCH v1 2/7] mm: swap: Add IAA batch decompression API swap_crypto_acomp_decompress_batch().
Date: Thu, 17 Oct 2024 23:48:00 -0700
Message-Id: <20241018064805.336490-3-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241018064805.336490-1-kanchana.p.sridhar@intel.com>
References: <20241018064805.336490-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added a new API swap_crypto_acomp_decompress_batch() that does batch
decompression. A system that has Intel IAA can avail of this API to submit a
batch of decompress jobs for parallel decompression in the hardware, to improve
performance. On a system without IAA, this API will process each decompress
job sequentially.

The purpose of this API is to be invocable from any swap module that needs
to decompress multiple 4K folios, or a batch of pages in the general case.
For instance, zswap would decompress up to (1UL << SWAP_RA_ORDER_CEILING)
folios in batches of SWAP_CRYPTO_SUB_BATCH_SIZE (i.e. 8 if the system has
IAA) pages prefetched by swapin_readahead(), which would improve readahead
performance.

Towards this eventual goal, the swap_crypto_acomp_decompress_batch()
interface is implemented in swap_state.c and exported via mm/swap.h. It
would be preferable for swap_crypto_acomp_decompress_batch() to be exported
via include/linux/swap.h so that modules outside mm (for e.g. zram) can
potentially use the API for batch decompressions with IAA, since the
swapin_readahead() batching interface is common to all swap modules.
I would appreciate RFC comments on this.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/swap.h       |  42 +++++++++++++++++--
 mm/swap_state.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+), 4 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index 08c04954304f..0bb386b5fdee 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -10,11 +10,12 @@ struct mempolicy;
 #include <linux/crypto.h>
 
 /*
- * For IAA compression batching:
- * Maximum number of IAA acomp compress requests that will be processed
- * in a sub-batch.
+ * For IAA compression/decompression batching:
+ * Maximum number of IAA acomp compress/decompress requests that will be
+ * processed in a sub-batch.
  */
-#if defined(CONFIG_ZSWAP_STORE_BATCHING_ENABLED)
+#if defined(CONFIG_ZSWAP_STORE_BATCHING_ENABLED) || \
+	defined(CONFIG_ZSWAP_LOAD_BATCHING_ENABLED)
 #define SWAP_CRYPTO_SUB_BATCH_SIZE 8UL
 #else
 #define SWAP_CRYPTO_SUB_BATCH_SIZE 1UL
@@ -60,6 +61,29 @@ void swap_crypto_acomp_compress_batch(
 	int nr_pages,
 	struct crypto_acomp_ctx *acomp_ctx);
 
+/**
+ * This API provides IAA decompress batching functionality for use by swap
+ * modules.
+ * The acomp_ctx mutex should be locked/unlocked before/after calling this
+ * procedure.
+ *
+ * @srcs: The src buffers to be decompressed.
+ * @pages: The pages to store the buffers decompressed by IAA.
+ * @slens: src buffers' compressed lengths.
+ * @errors: Will contain a 0 if the page was successfully decompressed, or a
+ *          non-0 error value to be processed by the calling function.
+ * @nr_pages: The number of pages, up to SWAP_CRYPTO_SUB_BATCH_SIZE,
+ *            to be decompressed.
+ * @acomp_ctx: The acomp context for iaa_crypto/other compressor.
+ */
+void swap_crypto_acomp_decompress_batch(
+	u8 *srcs[],
+	struct page *pages[],
+	unsigned int slens[],
+	int errors[],
+	int nr_pages,
+	struct crypto_acomp_ctx *acomp_ctx);
+
 /* linux/mm/vmscan.c, linux/mm/page_io.c, linux/mm/zswap.c */
 /* For batching of compressions in reclaim path. */
 struct swap_in_memory_cache_cb {
@@ -204,6 +228,16 @@ static inline void swap_write_in_memory_cache_unplug(
 {
 }
 
+static inline void swap_crypto_acomp_decompress_batch(
+	u8 *srcs[],
+	struct page *pages[],
+	unsigned int slens[],
+	int errors[],
+	int nr_pages,
+	struct crypto_acomp_ctx *acomp_ctx)
+{
+}
+
 static inline void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 {
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 117c3caa5679..3cebbff40804 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -855,6 +855,115 @@ void swap_crypto_acomp_compress_batch(
 }
 EXPORT_SYMBOL_GPL(swap_crypto_acomp_compress_batch);
 
+/**
+ * This API provides IAA decompress batching functionality for use by swap
+ * modules.
+ * The acomp_ctx mutex should be locked/unlocked before/after calling this
+ * procedure.
+ *
+ * @srcs: The src buffers to be decompressed.
+ * @pages: The pages to store the buffers decompressed by IAA.
+ * @slens: src buffers' compressed lengths.
+ * @errors: Will contain a 0 if the page was successfully decompressed, or a
+ *          non-0 error value to be processed by the calling function.
+ * @nr_pages: The number of pages, up to SWAP_CRYPTO_SUB_BATCH_SIZE,
+ *            to be decompressed.
+ * @acomp_ctx: The acomp context for iaa_crypto/other compressor.
+ */
+void swap_crypto_acomp_decompress_batch(
+	u8 *srcs[],
+	struct page *pages[],
+	unsigned int slens[],
+	int errors[],
+	int nr_pages,
+	struct crypto_acomp_ctx *acomp_ctx)
+{
+	struct scatterlist inputs[SWAP_CRYPTO_SUB_BATCH_SIZE];
+	struct scatterlist outputs[SWAP_CRYPTO_SUB_BATCH_SIZE];
+	unsigned int dlens[SWAP_CRYPTO_SUB_BATCH_SIZE];
+	bool decompressions_done = false;
+	int i, j;
+
+	BUG_ON(nr_pages > SWAP_CRYPTO_SUB_BATCH_SIZE);
+
+	/*
+	 * Prepare and submit acomp_reqs to IAA.
+	 * IAA will process these decompress jobs in parallel in async mode.
+	 * If the compressor does not support a poll() method, or if IAA is
+	 * used in sync mode, the jobs will be processed sequentially using
+	 * acomp_ctx->req[0] and acomp_ctx->wait.
+	 */
+	for (i = 0; i < nr_pages; ++i) {
+		j = acomp_ctx->acomp->poll ? i : 0;
+
+		dlens[i] = PAGE_SIZE;
+		sg_init_one(&inputs[i], srcs[i], slens[i]);
+		sg_init_table(&outputs[i], 1);
+		sg_set_page(&outputs[i], pages[i], PAGE_SIZE, 0);
+		acomp_request_set_params(acomp_ctx->req[j], &inputs[i],
+					&outputs[i], slens[i], dlens[i]);
+		/*
+		 * If the crypto_acomp provides an asynchronous poll()
+		 * interface, submit the request to the driver now, and poll for
+		 * a completion status later, after all descriptors have been
+		 * submitted. If the crypto_acomp does not provide a poll()
+		 * interface, submit the request and wait for it to complete,
+		 * i.e., synchronously, before moving on to the next request.
+		 */
+		if (acomp_ctx->acomp->poll) {
+			errors[i] = crypto_acomp_decompress(acomp_ctx->req[j]);
+
+			if (errors[i] != -EINPROGRESS)
+				errors[i] = -EINVAL;
+			else
+				errors[i] = -EAGAIN;
+		} else {
+			errors[i] = crypto_wait_req(
+					crypto_acomp_decompress(acomp_ctx->req[j]),
+					&acomp_ctx->wait);
+			if (!errors[i]) {
+				dlens[i] = acomp_ctx->req[j]->dlen;
+				BUG_ON(dlens[i] != PAGE_SIZE);
+			}
+		}
+	}
+
+	/*
+	 * If not doing async decompressions, the batch has been processed at
+	 * this point and we can return.
+	 */
+	if (!acomp_ctx->acomp->poll)
+		return;
+
+	/*
+	 * Poll for and process IAA decompress job completions
+	 * in out-of-order manner.
+	 */
+	while (!decompressions_done) {
+		decompressions_done = true;
+
+		for (i = 0; i < nr_pages; ++i) {
+			/*
+			 * Skip, if the decompression has already completed
+			 * successfully or with an error.
+			 */
+			if (errors[i] != -EAGAIN)
+				continue;
+
+			errors[i] = crypto_acomp_poll(acomp_ctx->req[i]);
+
+			if (errors[i]) {
+				if (errors[i] == -EAGAIN)
+					decompressions_done = false;
+			} else {
+				dlens[i] = acomp_ctx->req[i]->dlen;
+				BUG_ON(dlens[i] != PAGE_SIZE);
+			}
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(swap_crypto_acomp_decompress_batch);
+
 #endif /* CONFIG_SWAP */
 
 static int swap_vma_ra_win(struct vm_fault *vmf, unsigned long *start,
-- 
2.27.0


