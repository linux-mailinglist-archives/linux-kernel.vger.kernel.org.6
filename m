Return-Path: <linux-kernel+bounces-169444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9370D8BC8C3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A46C282061
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD9C1419B3;
	Mon,  6 May 2024 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BZBz+OwT"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9208140E40
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982330; cv=none; b=USVclEEt8pUF90DaGBjE2k+BKyK3SxBr0SfzUeNj4NsmCGhRbTT26gK1WKY0q0bhuBX2X/h5ZPN90OS7mRVTlPgicV6DJ8orj8v1rrVa65zf2Rlhh5eC9/g9VyAWPlBpVLtvQxwfGpq6Z81U/bvT80HFwuENfqGpydp2u3ySLwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982330; c=relaxed/simple;
	bh=8qI5x0BGUJs1JbjZreFI8Kvjdzxo5r4XEf1ADBnlo2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkOAAFJOBEUjjFe4s1vm5p0tHv5BvpG+mEOaTWpWTo4PvPQAWyhExHy7WDVmNWf9YU+/c7LlHZ4DzqqLW1Ldy5DyQlQ/bR9TVZ/SLHDJJPyA/aE6OqeyNDOLzPQgjNah8FicDcpKVopRFgF6rx29o+IEejHjZf09+BVySLuxep8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BZBz+OwT; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b3c1ea9a68so987518a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 00:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714982327; x=1715587127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJ4glZLOzUHMCYOraHYCv1mLDw/pz7BmHlcE0TlYg0c=;
        b=BZBz+OwThD6D/zU9/9nwv+BNNYgiwc9i9siruGCOZAlnSoddro/SVI0lZmyjZvHYXV
         RJD9WnHfuZe25jxa1uXuTY3frQJ7Aioz4blp2J1uawzZ6p54AY370ETMW/+DGzNoUytk
         WM50+ZKeQWotxmTJp5qHSovJzABMvqbPfe8mE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714982327; x=1715587127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJ4glZLOzUHMCYOraHYCv1mLDw/pz7BmHlcE0TlYg0c=;
        b=w9xnOFVd8hL+gFjycQ7R+hEDaO8rLDNxVqWMbFPBif2fTbfVUZKR14gxhfrjWRQL0x
         obmemzMJTNXz20DAO4tQkWeobe34cXgnFHbaSoTrj84qrPEEg9a8i3bs1ob5tkEPeY3I
         yrNs7eTf7KsFSxHnyacz5SCEOQt+5FAVTgz+FejGd4c1Leo5awIuZcsfiCbJ6VZC1QfM
         6dosgE9LuS59hI/+3aUnUEtGwwu9QgJi7pnPW7jIv0nJOnkOfqrs2ki679cT4BvRycfN
         zaNo8bnJoKzauIQ8aN448RNNyssfywatYJqL6tKpDW7Ppap6lcOA3vo+gbGpnVxPC+xj
         YxQQ==
X-Gm-Message-State: AOJu0YzSQ4GBWXXejWnz0AlOptWnEXlQ9zzsrwaKMoXSqFOcGpfCrYhM
	oTesgdQ12qn7uAaH76I/EcJVTupZJPlS+WZhProS4bMebd7FIdWejNzAHS+OTA==
X-Google-Smtp-Source: AGHT+IE5iyQHAjHukQ7ulnyFaOjBB9hRZUTXAdL9e3p3WYQegSS+1BGu18UeI33TeJ5YXYjBVRoEIQ==
X-Received: by 2002:a17:90a:880b:b0:2b1:be71:15d0 with SMTP id s11-20020a17090a880b00b002b1be7115d0mr17119940pjn.22.1714982326860;
        Mon, 06 May 2024 00:58:46 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4e24:10c3:4b65:e126])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001ec64b128dasm7633772plf.129.2024.05.06.00.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 00:58:46 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 01/17] zram: move from crypto API to custom comp backends API
Date: Mon,  6 May 2024 16:58:14 +0900
Message-ID: <20240506075834.302472-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240506075834.302472-1-senozhatsky@chromium.org>
References: <20240506075834.302472-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Crypto API is beautiful and powerful, however, being a
generic API, it lacks support for fine-grained per-algorithm
configuration. A number of compression algorithms provide
various knobs to tune characteristics for particular data
patterns. The simplest case is "compression level". A more
complicated and interesting case is user-space trained
dictionaries (e.g. lz4 and zstd).

Moving to custom backends implementation gives us ability to
have our own minimalistic and extendable API, and algorithms
tunings becomes possible.

The list of compression backends is empty at this point,
we will add backends in the followup patches.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig    |  39 +----------
 drivers/block/zram/zcomp.c    | 127 +++++++++++++---------------------
 drivers/block/zram/zcomp.h    |  26 +++++--
 drivers/block/zram/zram_drv.c |   9 ++-
 4 files changed, 73 insertions(+), 128 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 7b29cce60ab2..8ecb74f83a5e 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -2,7 +2,6 @@
 config ZRAM
 	tristate "Compressed RAM block device support"
 	depends on BLOCK && SYSFS && MMU
-	depends on CRYPTO_LZO || CRYPTO_ZSTD || CRYPTO_LZ4 || CRYPTO_LZ4HC || CRYPTO_842
 	select ZSMALLOC
 	help
 	  Creates virtual block devices called /dev/zramX (X = 0, 1, ...).
@@ -15,45 +14,9 @@ config ZRAM
 
 	  See Documentation/admin-guide/blockdev/zram.rst for more information.
 
-choice
-	prompt "Default zram compressor"
-	default ZRAM_DEF_COMP_LZORLE
-	depends on ZRAM
-
-config ZRAM_DEF_COMP_LZORLE
-	bool "lzo-rle"
-	depends on CRYPTO_LZO
-
-config ZRAM_DEF_COMP_ZSTD
-	bool "zstd"
-	depends on CRYPTO_ZSTD
-
-config ZRAM_DEF_COMP_LZ4
-	bool "lz4"
-	depends on CRYPTO_LZ4
-
-config ZRAM_DEF_COMP_LZO
-	bool "lzo"
-	depends on CRYPTO_LZO
-
-config ZRAM_DEF_COMP_LZ4HC
-	bool "lz4hc"
-	depends on CRYPTO_LZ4HC
-
-config ZRAM_DEF_COMP_842
-	bool "842"
-	depends on CRYPTO_842
-
-endchoice
-
 config ZRAM_DEF_COMP
 	string
-	default "lzo-rle" if ZRAM_DEF_COMP_LZORLE
-	default "zstd" if ZRAM_DEF_COMP_ZSTD
-	default "lz4" if ZRAM_DEF_COMP_LZ4
-	default "lzo" if ZRAM_DEF_COMP_LZO
-	default "lz4hc" if ZRAM_DEF_COMP_LZ4HC
-	default "842" if ZRAM_DEF_COMP_842
+	default "unset-value"
 
 config ZRAM_WRITEBACK
        bool "Write back incompressible or idle page to backing device"
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 8237b08c49d8..0d0d2e6dbaa9 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -15,31 +15,16 @@
 
 #include "zcomp.h"
 
-static const char * const backends[] = {
-#if IS_ENABLED(CONFIG_CRYPTO_LZO)
-	"lzo",
-	"lzo-rle",
-#endif
-#if IS_ENABLED(CONFIG_CRYPTO_LZ4)
-	"lz4",
-#endif
-#if IS_ENABLED(CONFIG_CRYPTO_LZ4HC)
-	"lz4hc",
-#endif
-#if IS_ENABLED(CONFIG_CRYPTO_842)
-	"842",
-#endif
-#if IS_ENABLED(CONFIG_CRYPTO_ZSTD)
-	"zstd",
-#endif
+static struct zcomp_backend *backends[] = {
+	NULL
 };
 
-static void zcomp_strm_free(struct zcomp_strm *zstrm)
+static void zcomp_strm_free(struct zcomp *comp, struct zcomp_strm *zstrm)
 {
-	if (!IS_ERR_OR_NULL(zstrm->tfm))
-		crypto_free_comp(zstrm->tfm);
+	if (zstrm->ctx)
+		comp->backend->destroy_ctx(zstrm->ctx);
 	vfree(zstrm->buffer);
-	zstrm->tfm = NULL;
+	zstrm->ctx = NULL;
 	zstrm->buffer = NULL;
 }
 
@@ -47,60 +32,55 @@ static void zcomp_strm_free(struct zcomp_strm *zstrm)
  * Initialize zcomp_strm structure with ->tfm initialized by backend, and
  * ->buffer. Return a negative value on error.
  */
-static int zcomp_strm_init(struct zcomp_strm *zstrm, struct zcomp *comp)
+static int zcomp_strm_init(struct zcomp *comp, struct zcomp_strm *zstrm)
 {
-	zstrm->tfm = crypto_alloc_comp(comp->name, 0, 0);
+	zstrm->ctx = comp->backend->create_ctx();
+
 	/*
 	 * allocate 2 pages. 1 for compressed data, plus 1 extra for the
 	 * case when compressed size is larger than the original one
 	 */
 	zstrm->buffer = vzalloc(2 * PAGE_SIZE);
-	if (IS_ERR_OR_NULL(zstrm->tfm) || !zstrm->buffer) {
-		zcomp_strm_free(zstrm);
+	if (!zstrm->ctx || !zstrm->buffer) {
+		zcomp_strm_free(comp, zstrm);
 		return -ENOMEM;
 	}
 	return 0;
 }
 
+static struct zcomp_backend *lookup_backend(const char *comp)
+{
+	int i = 0;
+
+	while (backends[i]) {
+		if (sysfs_streq(comp, backends[i]->name))
+			break;
+		i++;
+	}
+	return backends[i];
+}
+
 bool zcomp_available_algorithm(const char *comp)
 {
-	/*
-	 * Crypto does not ignore a trailing new line symbol,
-	 * so make sure you don't supply a string containing
-	 * one.
-	 * This also means that we permit zcomp initialisation
-	 * with any compressing algorithm known to crypto api.
-	 */
-	return crypto_has_comp(comp, 0, 0) == 1;
+	return lookup_backend(comp) != NULL;
 }
 
 /* show available compressors */
 ssize_t zcomp_available_show(const char *comp, char *buf)
 {
-	bool known_algorithm = false;
 	ssize_t sz = 0;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(backends); i++) {
-		if (!strcmp(comp, backends[i])) {
-			known_algorithm = true;
+	for (i = 0; i < ARRAY_SIZE(backends) - 1; i++) {
+		if (!strcmp(comp, backends[i]->name)) {
 			sz += scnprintf(buf + sz, PAGE_SIZE - sz - 2,
-					"[%s] ", backends[i]);
+					"[%s] ", backends[i]->name);
 		} else {
 			sz += scnprintf(buf + sz, PAGE_SIZE - sz - 2,
-					"%s ", backends[i]);
+					"%s ", backends[i]->name);
 		}
 	}
 
-	/*
-	 * Out-of-tree module known to crypto api or a missing
-	 * entry in `backends'.
-	 */
-	if (!known_algorithm && crypto_has_comp(comp, 0, 0) == 1)
-		sz += scnprintf(buf + sz, PAGE_SIZE - sz - 2,
-				"[%s] ", comp);
-
-	sz += scnprintf(buf + sz, PAGE_SIZE - sz, "\n");
 	return sz;
 }
 
@@ -115,8 +95,8 @@ void zcomp_stream_put(struct zcomp *comp)
 	local_unlock(&comp->stream->lock);
 }
 
-int zcomp_compress(struct zcomp_strm *zstrm,
-		const void *src, unsigned int *dst_len)
+int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
+		   const void *src, unsigned int *dst_len)
 {
 	/*
 	 * Our dst memory (zstrm->buffer) is always `2 * PAGE_SIZE' sized
@@ -132,21 +112,19 @@ int zcomp_compress(struct zcomp_strm *zstrm,
 	 * the dst buffer, zram_drv will take care of the fact that
 	 * compressed buffer is too big.
 	 */
-	*dst_len = PAGE_SIZE * 2;
+	size_t dlen = PAGE_SIZE * 2;
+	int ret;
 
-	return crypto_comp_compress(zstrm->tfm,
-			src, PAGE_SIZE,
-			zstrm->buffer, dst_len);
+	ret = comp->backend->compress(zstrm->ctx, src, zstrm->buffer, &dlen);
+	if (!ret)
+		*dst_len = dlen;
+	return ret;
 }
 
-int zcomp_decompress(struct zcomp_strm *zstrm,
-		const void *src, unsigned int src_len, void *dst)
+int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
+		     const void *src, unsigned int src_len, void *dst)
 {
-	unsigned int dst_len = PAGE_SIZE;
-
-	return crypto_comp_decompress(zstrm->tfm,
-			src, src_len,
-			dst, &dst_len);
+	return comp->backend->decompress(zstrm->ctx, src, src_len, dst);
 }
 
 int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
@@ -158,7 +136,7 @@ int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
 	zstrm = per_cpu_ptr(comp->stream, cpu);
 	local_lock_init(&zstrm->lock);
 
-	ret = zcomp_strm_init(zstrm, comp);
+	ret = zcomp_strm_init(comp, zstrm);
 	if (ret)
 		pr_err("Can't allocate a compression stream\n");
 	return ret;
@@ -170,7 +148,7 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node)
 	struct zcomp_strm *zstrm;
 
 	zstrm = per_cpu_ptr(comp->stream, cpu);
-	zcomp_strm_free(zstrm);
+	zcomp_strm_free(comp, zstrm);
 	return 0;
 }
 
@@ -199,32 +177,21 @@ void zcomp_destroy(struct zcomp *comp)
 	kfree(comp);
 }
 
-/*
- * search available compressors for requested algorithm.
- * allocate new zcomp and initialize it. return compressing
- * backend pointer or ERR_PTR if things went bad. ERR_PTR(-EINVAL)
- * if requested algorithm is not supported, ERR_PTR(-ENOMEM) in
- * case of allocation error, or any other error potentially
- * returned by zcomp_init().
- */
 struct zcomp *zcomp_create(const char *alg)
 {
 	struct zcomp *comp;
 	int error;
 
-	/*
-	 * Crypto API will execute /sbin/modprobe if the compression module
-	 * is not loaded yet. We must do it here, otherwise we are about to
-	 * call /sbin/modprobe under CPU hot-plug lock.
-	 */
-	if (!zcomp_available_algorithm(alg))
-		return ERR_PTR(-EINVAL);
-
 	comp = kzalloc(sizeof(struct zcomp), GFP_KERNEL);
 	if (!comp)
 		return ERR_PTR(-ENOMEM);
 
-	comp->name = alg;
+	comp->backend = lookup_backend(alg);
+	if (!comp->backend) {
+		kfree(comp);
+		return ERR_PTR(-EINVAL);
+	}
+
 	error = zcomp_init(comp);
 	if (error) {
 		kfree(comp);
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index e9fe63da0e9b..757b85017e23 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -12,13 +12,26 @@ struct zcomp_strm {
 	local_lock_t lock;
 	/* compression/decompression buffer */
 	void *buffer;
-	struct crypto_comp *tfm;
+	void *ctx;
+};
+
+struct zcomp_backend {
+	int (*compress)(void *ctx, const unsigned char *src,
+			unsigned char *dst, size_t *dst_len);
+
+	int (*decompress)(void *ctx, const unsigned char *src, size_t src_len,
+			  unsigned char *dst);
+
+	void *(*create_ctx)(void);
+	void (*destroy_ctx)(void *ctx);
+
+	const char *name;
 };
 
 /* dynamic per-device compression frontend */
 struct zcomp {
 	struct zcomp_strm __percpu *stream;
-	const char *name;
+	struct zcomp_backend *backend;
 	struct hlist_node node;
 };
 
@@ -33,10 +46,9 @@ void zcomp_destroy(struct zcomp *comp);
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp);
 void zcomp_stream_put(struct zcomp *comp);
 
-int zcomp_compress(struct zcomp_strm *zstrm,
-		const void *src, unsigned int *dst_len);
-
-int zcomp_decompress(struct zcomp_strm *zstrm,
-		const void *src, unsigned int src_len, void *dst);
+int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
+		   const void *src, unsigned int *dst_len);
+int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
+		     const void *src, unsigned int src_len, void *dst);
 
 #endif /* _ZCOMP_H_ */
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4cf38f7d3e0a..298ef0e97e03 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1342,7 +1342,8 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 		ret = 0;
 	} else {
 		dst = kmap_local_page(page);
-		ret = zcomp_decompress(zstrm, src, size, dst);
+		ret = zcomp_decompress(zram->comps[prio], zstrm,
+				       src, size, dst);
 		kunmap_local(dst);
 		zcomp_stream_put(zram->comps[prio]);
 	}
@@ -1429,7 +1430,8 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 compress_again:
 	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
 	src = kmap_local_page(page);
-	ret = zcomp_compress(zstrm, src, &comp_len);
+	ret = zcomp_compress(zram->comps[ZRAM_PRIMARY_COMP], zstrm,
+			     src, &comp_len);
 	kunmap_local(src);
 
 	if (unlikely(ret)) {
@@ -1616,7 +1618,8 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 		num_recomps++;
 		zstrm = zcomp_stream_get(zram->comps[prio]);
 		src = kmap_local_page(page);
-		ret = zcomp_compress(zstrm, src, &comp_len_new);
+		ret = zcomp_compress(zram->comps[prio], zstrm,
+				     src, &comp_len_new);
 		kunmap_local(src);
 
 		if (ret) {
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


