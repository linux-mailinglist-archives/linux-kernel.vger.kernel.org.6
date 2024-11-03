Return-Path: <linux-kernel+bounces-393654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 856B09BA3B1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 04:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD37B1C21388
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 03:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C3E13C908;
	Sun,  3 Nov 2024 03:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="huLGYf6v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A606C70833;
	Sun,  3 Nov 2024 03:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730604079; cv=none; b=bI92W1iuMkXb3LbBB3sgSUzViwyTrNINBv2boYY7dLV/oMpc/h/8UjGBxQS77265771wQkjEZrFyty9gGcbH8Iv9tP4o7zE8c/sx1VPGt2bZyTkbEaDXjIAxYUn5VsnPvJ/604+OOf0ANR1ofHFti5GU9eTnQUak0dUHB+WGTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730604079; c=relaxed/simple;
	bh=A/Xb7b4ZlfpZ9fjf2/i7i8CtYcuuNebRbHMn7yrPUpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BCXnQQo/JqBXBBJX/abUwElBq0xoWbGMwx2aOxNgDHmavNA7aYjf5E86sRhdH9ikHCUZd3Fim+9iWxCQIE064JK5Df6HGQ5KLlL9u7ooUBG9wW3n5YDiNJ6CE18JwNGluoIfmqo8Z9GhuscS0Lj1oUsW5RGGynBEWICvuIKH1k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=huLGYf6v; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730604077; x=1762140077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A/Xb7b4ZlfpZ9fjf2/i7i8CtYcuuNebRbHMn7yrPUpE=;
  b=huLGYf6v/YPDKRbrcPjO65wsecKPcUEs0D8+VL/dduqOYlfIEMhqtGgS
   HsXdHV7Yk32JI5dtcLW5+KKc9XTHwbGYxoRqrQY4liCxNiBeBDFOlzxOO
   tK5rt0sLd2mu+wp9hT4yio93r21AfRvaIavDD5MhGAELIjuwNz+TH4OmE
   jg534CNwIGzJWEmLvRQwY3VEdP+Z4x98qt1LEy8315Iw/BRcbFfLd0QfS
   1XXw7l0VUV4xFs2gUTcztiHVQHmqeHygSl8sgOrXkZrIuUz3OMDmSQhpV
   Dk1XYRX1t1KHqaLH2LhqnjWuEd4/YoTkrWqH91MxLAYSRW14bhBVFCZPz
   A==;
X-CSE-ConnectionGUID: KXHcrDcWSU6idFea31TMkA==
X-CSE-MsgGUID: dOpC6CvSQfWCfY1waAfeFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11244"; a="30548259"
X-IronPort-AV: E=Sophos;i="6.11,254,1725346800"; 
   d="scan'208";a="30548259"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 20:21:13 -0700
X-CSE-ConnectionGUID: LgPwuFS0TdG3yCMIj+pSwA==
X-CSE-MsgGUID: 7nNDVED+S1a6Z4X/Dbo88Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,254,1725346800"; 
   d="scan'208";a="83451875"
Received: from unknown (HELO JF5300-B11A338T.jf.intel.com) ([10.242.51.115])
  by orviesa006.jf.intel.com with ESMTP; 02 Nov 2024 20:21:13 -0700
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
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com,
	zanussi@kernel.org
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v2 03/13] crypto: iaa - Implement compress/decompress batching API in iaa_crypto.
Date: Sat,  2 Nov 2024 20:21:01 -0700
Message-Id: <20241103032111.333282-4-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241103032111.333282-1-kanchana.p.sridhar@intel.com>
References: <20241103032111.333282-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch provides iaa_crypto driver implementations for the newly added
crypto_acomp batch_compress() and batch_decompress() interfaces.

This allows swap modules such as zswap/zram to invoke batch parallel
compression/decompression of pages on systems with Intel IAA, by invoking
these API, respectively:

 crypto_acomp_batch_compress(...);
 crypto_acomp_batch_decompress(...);

This enables zswap_store() compress batching code to be developed in a
manner similar to the current single-page synchronous calls to:

 crypto_acomp_compress(...);
 crypto_acomp_decompress(...);

thereby, facilitating encapsulated and modular hand-off between the kernel
zswap/zram code and the crypto_acomp layer.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 313 +++++++++++++++++++++
 1 file changed, 313 insertions(+)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 2edaecd42cc6..3ac3a37fd2e6 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1797,6 +1797,317 @@ static void compression_ctx_init(struct iaa_compression_ctx *ctx)
 	ctx->use_irq = use_irq;
 }
 
+static int iaa_comp_poll(struct acomp_req *req)
+{
+	struct idxd_desc *idxd_desc;
+	struct idxd_device *idxd;
+	struct iaa_wq *iaa_wq;
+	struct pci_dev *pdev;
+	struct device *dev;
+	struct idxd_wq *wq;
+	bool compress_op;
+	int ret;
+
+	idxd_desc = req->base.data;
+	if (!idxd_desc)
+		return -EAGAIN;
+
+	compress_op = (idxd_desc->iax_hw->opcode == IAX_OPCODE_COMPRESS);
+	wq = idxd_desc->wq;
+	iaa_wq = idxd_wq_get_private(wq);
+	idxd = iaa_wq->iaa_device->idxd;
+	pdev = idxd->pdev;
+	dev = &pdev->dev;
+
+	ret = check_completion(dev, idxd_desc->iax_completion, true, true);
+	if (ret == -EAGAIN)
+		return ret;
+	if (ret)
+		goto out;
+
+	req->dlen = idxd_desc->iax_completion->output_size;
+
+	/* Update stats */
+	if (compress_op) {
+		update_total_comp_bytes_out(req->dlen);
+		update_wq_comp_bytes(wq, req->dlen);
+	} else {
+		update_total_decomp_bytes_in(req->slen);
+		update_wq_decomp_bytes(wq, req->slen);
+	}
+
+	if (iaa_verify_compress && (idxd_desc->iax_hw->opcode == IAX_OPCODE_COMPRESS)) {
+		struct crypto_tfm *tfm = req->base.tfm;
+		dma_addr_t src_addr, dst_addr;
+		u32 compression_crc;
+
+		compression_crc = idxd_desc->iax_completion->crc;
+
+		dma_sync_sg_for_device(dev, req->dst, 1, DMA_FROM_DEVICE);
+		dma_sync_sg_for_device(dev, req->src, 1, DMA_TO_DEVICE);
+
+		src_addr = sg_dma_address(req->src);
+		dst_addr = sg_dma_address(req->dst);
+
+		ret = iaa_compress_verify(tfm, req, wq, src_addr, req->slen,
+					  dst_addr, &req->dlen, compression_crc);
+	}
+out:
+	/* caller doesn't call crypto_wait_req, so no acomp_request_complete() */
+
+	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+
+	idxd_free_desc(idxd_desc->wq, idxd_desc);
+
+	dev_dbg(dev, "%s: returning ret=%d\n", __func__, ret);
+
+	return ret;
+}
+
+static void iaa_set_req_poll(
+	struct acomp_req *reqs[],
+	int nr_reqs,
+	bool set_flag)
+{
+	int i;
+
+	for (i = 0; i < nr_reqs; ++i) {
+		set_flag ? (reqs[i]->flags |= CRYPTO_ACOMP_REQ_POLL) :
+			   (reqs[i]->flags &= ~CRYPTO_ACOMP_REQ_POLL);
+	}
+}
+
+/**
+ * This API provides IAA compress batching functionality for use by swap
+ * modules.
+ *
+ * @reqs: @nr_pages asynchronous compress requests.
+ * @wait: crypto_wait for synchronous acomp batch compress. If NULL, the
+ *        completions will be processed asynchronously.
+ * @pages: Pages to be compressed by IAA in parallel.
+ * @dsts: Pre-allocated destination buffers to store results of IAA
+ *        compression. Each element of @dsts must be of size "PAGE_SIZE * 2".
+ * @dlens: Will contain the compressed lengths.
+ * @errors: zero on successful compression of the corresponding
+ *          req, or error code in case of error.
+ * @nr_pages: The number of pages, up to CRYPTO_BATCH_SIZE,
+ *            to be compressed.
+ */
+static void iaa_comp_acompress_batch(
+	struct acomp_req *reqs[],
+	struct crypto_wait *wait,
+	struct page *pages[],
+	u8 *dsts[],
+	unsigned int dlens[],
+	int errors[],
+	int nr_pages)
+{
+	struct scatterlist inputs[CRYPTO_BATCH_SIZE];
+	struct scatterlist outputs[CRYPTO_BATCH_SIZE];
+	bool compressions_done = false;
+	bool poll = (async_mode && !use_irq);
+	int i;
+
+	BUG_ON(nr_pages > CRYPTO_BATCH_SIZE);
+	BUG_ON(!poll && !wait);
+
+	if (poll)
+		iaa_set_req_poll(reqs, nr_pages, true);
+	else
+		iaa_set_req_poll(reqs, nr_pages, false);
+
+	/*
+	 * Prepare and submit acomp_reqs to IAA. IAA will process these
+	 * compress jobs in parallel if async-poll mode is enabled.
+	 * If IAA is used in sync mode, the jobs will be processed sequentially
+	 * using "wait".
+	 */
+	for (i = 0; i < nr_pages; ++i) {
+		sg_init_table(&inputs[i], 1);
+		sg_set_page(&inputs[i], pages[i], PAGE_SIZE, 0);
+
+		/*
+		 * Each dst buffer should be of size (PAGE_SIZE * 2).
+		 * Reflect same in sg_list.
+		 */
+		sg_init_one(&outputs[i], dsts[i], PAGE_SIZE * 2);
+		acomp_request_set_params(reqs[i], &inputs[i],
+					 &outputs[i], PAGE_SIZE, dlens[i]);
+
+		/*
+		 * If poll is in effect, submit the request now, and poll for
+		 * a completion status later, after all descriptors have been
+		 * submitted. If polling is not enabled, submit the request
+		 * and wait for it to complete, i.e., synchronously, before
+		 * moving on to the next request.
+		 */
+		if (poll) {
+			errors[i] = iaa_comp_acompress(reqs[i]);
+
+			if (errors[i] != -EINPROGRESS)
+				errors[i] = -EINVAL;
+			else
+				errors[i] = -EAGAIN;
+		} else {
+			acomp_request_set_callback(reqs[i],
+						   CRYPTO_TFM_REQ_MAY_BACKLOG,
+						   crypto_req_done, wait);
+			errors[i] = crypto_wait_req(iaa_comp_acompress(reqs[i]),
+						    wait);
+			if (!errors[i])
+				dlens[i] = reqs[i]->dlen;
+		}
+	}
+
+	/*
+	 * If not doing async compressions, the batch has been processed at
+	 * this point and we can return.
+	 */
+	if (!poll)
+		return;
+
+	/*
+	 * Poll for and process IAA compress job completions
+	 * in out-of-order manner.
+	 */
+	while (!compressions_done) {
+		compressions_done = true;
+
+		for (i = 0; i < nr_pages; ++i) {
+			/*
+			 * Skip, if the compression has already completed
+			 * successfully or with an error.
+			 */
+			if (errors[i] != -EAGAIN)
+				continue;
+
+			errors[i] = iaa_comp_poll(reqs[i]);
+
+			if (errors[i]) {
+				if (errors[i] == -EAGAIN)
+					compressions_done = false;
+			} else {
+				dlens[i] = reqs[i]->dlen;
+			}
+		}
+	}
+}
+
+/**
+ * This API provides IAA decompress batching functionality for use by swap
+ * modules.
+ *
+ * @reqs: @nr_pages asynchronous decompress requests.
+ * @wait: crypto_wait for synchronous acomp batch decompress. If NULL, the
+ *        driver must provide a way to process completions asynchronously.
+ * @srcs: The src buffers to be decompressed by IAA in parallel.
+ * @pages: The pages to store the decompressed buffers.
+ * @slens: Compressed lengths of @srcs.
+ * @errors: zero on successful compression of the corresponding
+ *          req, or error code in case of error.
+ * @nr_pages: The number of pages, up to CRYPTO_BATCH_SIZE,
+ *            to be decompressed.
+ */
+static void iaa_comp_adecompress_batch(
+	struct acomp_req *reqs[],
+	struct crypto_wait *wait,
+	u8 *srcs[],
+	struct page *pages[],
+	unsigned int slens[],
+	int errors[],
+	int nr_pages)
+{
+	struct scatterlist inputs[CRYPTO_BATCH_SIZE];
+	struct scatterlist outputs[CRYPTO_BATCH_SIZE];
+	unsigned int dlens[CRYPTO_BATCH_SIZE];
+	bool decompressions_done = false;
+	bool poll = (async_mode && !use_irq);
+	int i;
+
+	BUG_ON(nr_pages > CRYPTO_BATCH_SIZE);
+	BUG_ON(!poll && !wait);
+
+	if (poll)
+		iaa_set_req_poll(reqs, nr_pages, true);
+	else
+		iaa_set_req_poll(reqs, nr_pages, false);
+
+	/*
+	 * Prepare and submit acomp_reqs to IAA. IAA will process these
+	 * decompress jobs in parallel if async-poll mode is enabled.
+	 * If IAA is used in sync mode, the jobs will be processed sequentially
+	 * using "wait".
+	 */
+	for (i = 0; i < nr_pages; ++i) {
+		dlens[i] = PAGE_SIZE;
+		sg_init_one(&inputs[i], srcs[i], slens[i]);
+		sg_init_table(&outputs[i], 1);
+		sg_set_page(&outputs[i], pages[i], PAGE_SIZE, 0);
+		acomp_request_set_params(reqs[i], &inputs[i],
+					&outputs[i], slens[i], dlens[i]);
+		/*
+		 * If poll is in effect, submit the request now, and poll for
+		 * a completion status later, after all descriptors have been
+		 * submitted. If polling is not enabled, submit the request
+		 * and wait for it to complete, i.e., synchronously, before
+		 * moving on to the next request.
+		 */
+		if (poll) {
+			errors[i] = iaa_comp_adecompress(reqs[i]);
+
+			if (errors[i] != -EINPROGRESS)
+				errors[i] = -EINVAL;
+			else
+				errors[i] = -EAGAIN;
+		} else {
+			acomp_request_set_callback(reqs[i],
+						   CRYPTO_TFM_REQ_MAY_BACKLOG,
+						   crypto_req_done, wait);
+			errors[i] = crypto_wait_req(iaa_comp_adecompress(reqs[i]),
+						    wait);
+			if (!errors[i]) {
+				dlens[i] = reqs[i]->dlen;
+				BUG_ON(dlens[i] != PAGE_SIZE);
+			}
+		}
+	}
+
+	/*
+	 * If not doing async decompressions, the batch has been processed at
+	 * this point and we can return.
+	 */
+	if (!poll)
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
+			errors[i] = iaa_comp_poll(reqs[i]);
+
+			if (errors[i]) {
+				if (errors[i] == -EAGAIN)
+					decompressions_done = false;
+			} else {
+				dlens[i] = reqs[i]->dlen;
+				BUG_ON(dlens[i] != PAGE_SIZE);
+			}
+		}
+	}
+}
+
 static int iaa_comp_init_fixed(struct crypto_acomp *acomp_tfm)
 {
 	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
@@ -1822,6 +2133,8 @@ static struct acomp_alg iaa_acomp_fixed_deflate = {
 	.compress		= iaa_comp_acompress,
 	.decompress		= iaa_comp_adecompress,
 	.dst_free               = dst_free,
+	.batch_compress		= iaa_comp_acompress_batch,
+	.batch_decompress	= iaa_comp_adecompress_batch,
 	.base			= {
 		.cra_name		= "deflate",
 		.cra_driver_name	= "deflate-iaa",
-- 
2.27.0


