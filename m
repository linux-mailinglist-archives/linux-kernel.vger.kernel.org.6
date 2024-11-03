Return-Path: <linux-kernel+bounces-393651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5466F9BA3AA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 04:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C116D1F22680
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 03:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D84981ADA;
	Sun,  3 Nov 2024 03:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2DdAxRZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0E554673;
	Sun,  3 Nov 2024 03:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730604077; cv=none; b=ZdRKTPWqweNnRO8uwW15Tkd4kMDbpEHj0srHDTHqlbSEPalW+wxAfA2UHdQVrs8FPHaf2ML4eZ6yIXvZ8PHB44ZuE4QAoysjGBAuYJuOfnIj8fRpu8L0Cio068NUOEa1EtbS7ZMhmAgK2rURj1z9qkkx30IXMKAd/T29FIzTepE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730604077; c=relaxed/simple;
	bh=8jyV13JKHn0vIl+wBpuhM8EZ+NN4RHEftxJMCaIna00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sca3pQzqMKXMGjhXcxtfSlvcN/HmbCd2E/01VU5gRqjfE1Y0cC4ozREh4yZKVfRbIyNc0QrXskO+cTW+ZO9TwuvlnTgoB34CZic7ItvSf1pl1YgkPnfCv8gTs6j339cy5u24qloqkduudPoD7dUN3LA8wGPqOrNRCOsPLDPvLac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2DdAxRZ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730604075; x=1762140075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8jyV13JKHn0vIl+wBpuhM8EZ+NN4RHEftxJMCaIna00=;
  b=W2DdAxRZWCYB2LtrLAqHou9u3uhJgSVSzesKcDWLgUPG9kwpATda2ZJH
   YAgSlmvPNoMdi/IUVJU7Sd8JEFTlqivqVAOf90nnQRnvDkb2RDYErcOxV
   jpKNL3HpFqwxXJD39yuI2tAy9snNmUbkErvfCvu9l7fW/TrWZiQPid0Oj
   Fe8+zY9J+hVOu6mhOkuMQ/Eo4qXqaU+92iqrwFVJDT3RW/RXLnQ3pVGoX
   j0O0Ir7DogCISBNCrErK9X/xCrcfAlMJP9zEk82hV8yB2dpc3oCNX6Y7G
   fiEfWri7RqCakxGq2+nxsuUr2Ehx08OanV2ef+S8gfShlnbfITnQhzW6X
   Q==;
X-CSE-ConnectionGUID: oo4WYi/XRzapAVI7q03ajw==
X-CSE-MsgGUID: jvoGPCJCSwaKnkvrLPRpAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11244"; a="30548228"
X-IronPort-AV: E=Sophos;i="6.11,254,1725346800"; 
   d="scan'208";a="30548228"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 20:21:12 -0700
X-CSE-ConnectionGUID: 3SSZ6/PoSPeJNuzxqB1iwA==
X-CSE-MsgGUID: xv6vpDvIR3Ssdv3gkPqx7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,254,1725346800"; 
   d="scan'208";a="83451868"
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
Subject: [PATCH v2 01/13] crypto: acomp - Define two new interfaces for compress/decompress batching.
Date: Sat,  2 Nov 2024 20:20:59 -0700
Message-Id: <20241103032111.333282-2-kanchana.p.sridhar@intel.com>
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

This commit adds batch_compress() and batch_decompress() interfaces to:

  struct acomp_alg
  struct crypto_acomp

This allows the iaa_crypto Intel IAA driver to register implementation for
batch_compress() and batch_decompress() API, that can subsequently be
invoked from the kernel zswap/zram swap modules to compress/decompress
up to CRYPTO_BATCH_SIZE (i.e. 8) pages in parallel in the IAA hardware
accelerator to improve swapout/swapin performance.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 crypto/acompress.c                  |  2 +
 include/crypto/acompress.h          | 82 +++++++++++++++++++++++++++++
 include/crypto/internal/acompress.h | 16 ++++++
 3 files changed, 100 insertions(+)

diff --git a/crypto/acompress.c b/crypto/acompress.c
index 6fdf0ff9f3c0..a506db499a37 100644
--- a/crypto/acompress.c
+++ b/crypto/acompress.c
@@ -71,6 +71,8 @@ static int crypto_acomp_init_tfm(struct crypto_tfm *tfm)
 
 	acomp->compress = alg->compress;
 	acomp->decompress = alg->decompress;
+	acomp->batch_compress = alg->batch_compress;
+	acomp->batch_decompress = alg->batch_decompress;
 	acomp->dst_free = alg->dst_free;
 	acomp->reqsize = alg->reqsize;
 
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index 54937b615239..ab0d9987bde1 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -37,12 +37,20 @@ struct acomp_req {
 	void *__ctx[] CRYPTO_MINALIGN_ATTR;
 };
 
+/*
+ * The max compress/decompress batch size, for crypto algorithms
+ * that support batch_compress and batch_decompress API.
+ */
+#define CRYPTO_BATCH_SIZE 8UL
+
 /**
  * struct crypto_acomp - user-instantiated objects which encapsulate
  * algorithms and core processing logic
  *
  * @compress:		Function performs a compress operation
  * @decompress:		Function performs a de-compress operation
+ * @batch_compress:	Function performs a batch compress operation
+ * @batch_decompress:	Function performs a batch decompress operation
  * @dst_free:		Frees destination buffer if allocated inside the
  *			algorithm
  * @reqsize:		Context size for (de)compression requests
@@ -51,6 +59,20 @@ struct acomp_req {
 struct crypto_acomp {
 	int (*compress)(struct acomp_req *req);
 	int (*decompress)(struct acomp_req *req);
+	void (*batch_compress)(struct acomp_req *reqs[],
+			       struct crypto_wait *wait,
+			       struct page *pages[],
+			       u8 *dsts[],
+			       unsigned int dlens[],
+			       int errors[],
+			       int nr_pages);
+	void (*batch_decompress)(struct acomp_req *reqs[],
+				 struct crypto_wait *wait,
+				 u8 *srcs[],
+				 struct page *pages[],
+				 unsigned int slens[],
+				 int errors[],
+				 int nr_pages);
 	void (*dst_free)(struct scatterlist *dst);
 	unsigned int reqsize;
 	struct crypto_tfm base;
@@ -265,4 +287,64 @@ static inline int crypto_acomp_decompress(struct acomp_req *req)
 	return crypto_acomp_reqtfm(req)->decompress(req);
 }
 
+/**
+ * crypto_acomp_batch_compress() -- compress a batch of requests
+ *
+ * Function invokes the batch compress operation
+ *
+ * @reqs: @nr_pages asynchronous compress requests.
+ * @wait: crypto_wait for synchronous acomp batch compress. If NULL, the
+ *        driver must provide a way to process completions asynchronously.
+ * @pages: Pages to be compressed.
+ * @dsts: Pre-allocated destination buffers to store results of compression.
+ * @dlens: Will contain the compressed lengths.
+ * @errors: zero on successful compression of the corresponding
+ *          req, or error code in case of error.
+ * @nr_pages: The number of pages, up to CRYPTO_BATCH_SIZE,
+ *            to be compressed.
+ */
+static inline void crypto_acomp_batch_compress(struct acomp_req *reqs[],
+					       struct crypto_wait *wait,
+					       struct page *pages[],
+					       u8 *dsts[],
+					       unsigned int dlens[],
+					       int errors[],
+					       int nr_pages)
+{
+	struct crypto_acomp *tfm = crypto_acomp_reqtfm(reqs[0]);
+
+	return tfm->batch_compress(reqs, wait, pages, dsts,
+				   dlens, errors, nr_pages);
+}
+
+/**
+ * crypto_acomp_batch_decompress() -- decompress a batch of requests
+ *
+ * Function invokes the batch decompress operation
+ *
+ * @reqs: @nr_pages asynchronous decompress requests.
+ * @wait: crypto_wait for synchronous acomp batch decompress. If NULL, the
+ *        driver must provide a way to process completions asynchronously.
+ * @srcs: The src buffers to be decompressed.
+ * @pages: The pages to store the decompressed buffers.
+ * @slens: Compressed lengths of @srcs.
+ * @errors: zero on successful compression of the corresponding
+ *          req, or error code in case of error.
+ * @nr_pages: The number of pages, up to CRYPTO_BATCH_SIZE,
+ *            to be decompressed.
+ */
+static inline void crypto_acomp_batch_decompress(struct acomp_req *reqs[],
+						 struct crypto_wait *wait,
+						 u8 *srcs[],
+						 struct page *pages[],
+						 unsigned int slens[],
+						 int errors[],
+						 int nr_pages)
+{
+	struct crypto_acomp *tfm = crypto_acomp_reqtfm(reqs[0]);
+
+	return tfm->batch_decompress(reqs, wait, srcs, pages,
+				     slens, errors, nr_pages);
+}
+
 #endif
diff --git a/include/crypto/internal/acompress.h b/include/crypto/internal/acompress.h
index 8831edaafc05..acfe2d9d5a83 100644
--- a/include/crypto/internal/acompress.h
+++ b/include/crypto/internal/acompress.h
@@ -17,6 +17,8 @@
  *
  * @compress:	Function performs a compress operation
  * @decompress:	Function performs a de-compress operation
+ * @batch_compress:	Function performs a batch compress operation
+ * @batch_decompress:	Function performs a batch decompress operation
  * @dst_free:	Frees destination buffer if allocated inside the algorithm
  * @init:	Initialize the cryptographic transformation object.
  *		This function is used to initialize the cryptographic
@@ -37,6 +39,20 @@
 struct acomp_alg {
 	int (*compress)(struct acomp_req *req);
 	int (*decompress)(struct acomp_req *req);
+	void (*batch_compress)(struct acomp_req *reqs[],
+			       struct crypto_wait *wait,
+			       struct page *pages[],
+			       u8 *dsts[],
+			       unsigned int dlens[],
+			       int errors[],
+			       int nr_pages);
+	void (*batch_decompress)(struct acomp_req *reqs[],
+				 struct crypto_wait *wait,
+				 u8 *srcs[],
+				 struct page *pages[],
+				 unsigned int slens[],
+				 int errors[],
+				 int nr_pages);
 	void (*dst_free)(struct scatterlist *dst);
 	int (*init)(struct crypto_acomp *tfm);
 	void (*exit)(struct crypto_acomp *tfm);
-- 
2.27.0


