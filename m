Return-Path: <linux-kernel+bounces-243040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE2F9290EE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 06:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E744BB21284
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 04:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28A622EE4;
	Sat,  6 Jul 2024 04:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KcoxEo4Q"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BE51CD31
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 04:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241821; cv=none; b=G3RepbuyUEal/W2Ld1FuhXVttWlN0PjgSD/rH4stffWoUoFt7FIMrVeHde3nZzH3x8iRdJl2/9dV7K3DtxgXORgYqa7nc+pSXsp8yBD4jvBLgrsuyGBFkdFRAXxTbZXbGN1HjodzBlrKo7Pzk1gPpJVGVv/vL39BfbgLXvitWZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241821; c=relaxed/simple;
	bh=M9pc+U462otBmyCGF82RSB362L3Cc0jrA10xEuzqAC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TePlox0buCvFSaXwU1NgUUEQmCGOLqoIrCtwQRKWTe9lDF7dL/ckmbIJcGAOMvT6o+YlN6fbOZ2MnRJDuhg9OLjQ2WtQfERUxuySTv5p0qgzx9eABFtZgI7jiVoZ3MImF35j+zLsSq+THGWPhXJgcADYbXXfNQXZ7BQYB+TIi0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KcoxEo4Q; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70b0d0fefe3so981877b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 21:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720241819; x=1720846619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x441/jctiZDhLwO/5h6POdMEIGSeyDo7GTcWYKMYAC4=;
        b=KcoxEo4Qi7Fl+Btv615G4muK3UNc4melK8Y9JGlNRtolo/KoBv79h7LU1Fde9itbb4
         JuijTasdAp9Ko30hJZO3zeziXPHqeeS2aSPNbW6Z7NCdhXDv23KTuqYi+iGYw1J9+1G1
         zs7jFh25/KixZRW+XKek42PBWfe0khAgzSQN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720241819; x=1720846619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x441/jctiZDhLwO/5h6POdMEIGSeyDo7GTcWYKMYAC4=;
        b=CQPy4pHGz6JBePqUvRa+I5trbYnNfb4SMoTKXkmt0oO/iImPmi0mpBhxemHhudeKWe
         v0ysqXrIsYmZTOGgJgrpqDpUljjUmmHjMjQAOeolSt0RwHjm7k9M4CmPMMHzInB3lVFR
         vX2DNMsrna8gJn61SDNRul/IZQPA9ea9yLZOChIDcNCasNQpKfmCvmTBXcBZKJcUwczp
         MZzfKgcC2uK9DuIXhN/xUKktGV/PFThjbB4QmAp3rA+YFxEopdRRhULuCpxJUU2JA1uU
         WOOn/w1KsqBd6IDK5pGqRlHdhRBjl8cvv6RnpL175LSpgi4lvFcRg0ZT/VWKHYVh8JJ+
         GJvg==
X-Gm-Message-State: AOJu0YxvTC6SvbcPryUIT/LiqlqMXKtW5+IX5JypMH3CqZyL2rD0e25r
	lUiTkEx9BsOvmWdIbsUx0N30juYLrxjgZg9szWf8L43oQDznD0qRg94XRUJVEA==
X-Google-Smtp-Source: AGHT+IG+gJSEP9d052qSS4jde55lfIVo9Va1z2puU1oVgxaLDAZv+0BC2GnrLVnKpuq7DwchJcs57w==
X-Received: by 2002:a05:6a00:1791:b0:705:c0a1:61c9 with SMTP id d2e1a72fcca58-70b00947856mr6899185b3a.9.1720241819102;
        Fri, 05 Jul 2024 21:56:59 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:88a7:e7d7:713d:ff09])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7623cd854b2sm2784104a12.38.2024.07.05.21.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 21:56:58 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 04/23] zram: introduce custom comp backends API
Date: Sat,  6 Jul 2024 13:56:06 +0900
Message-ID: <20240706045641.631961-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240706045641.631961-1-senozhatsky@chromium.org>
References: <20240706045641.631961-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Moving to custom backends implementation gives us ability to
have our own minimalistic and extendable API, and algorithms
tunings becomes possible.

The list of compression backends is empty at this point,
we will add backends in the followup patches.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig    |  39 +--------
 drivers/block/zram/zcomp.c    | 151 +++++++++++-----------------------
 drivers/block/zram/zcomp.h    |  29 ++++---
 drivers/block/zram/zram_drv.c |   9 +-
 4 files changed, 76 insertions(+), 152 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index eacf1cba7bf4..ace5698db5f6 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -3,7 +3,6 @@ config ZRAM
 	tristate "Compressed RAM block device support"
 	depends on BLOCK && SYSFS && MMU
 	depends on HAVE_ZSMALLOC
-	depends on CRYPTO_LZO || CRYPTO_ZSTD || CRYPTO_LZ4 || CRYPTO_LZ4HC || CRYPTO_842
 	select ZSMALLOC
 	help
 	  Creates virtual block devices called /dev/zramX (X = 0, 1, ...).
@@ -16,45 +15,9 @@ config ZRAM
 
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
index 8237b08c49d8..5075934ce388 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (C) 2014 Sergey Senozhatsky.
- */
 
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -15,92 +12,68 @@
 
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
+static struct zcomp_ops *backends[] = {
+	NULL
 };
 
-static void zcomp_strm_free(struct zcomp_strm *zstrm)
+static void zcomp_strm_free(struct zcomp *comp, struct zcomp_strm *zstrm)
 {
-	if (!IS_ERR_OR_NULL(zstrm->tfm))
-		crypto_free_comp(zstrm->tfm);
+	if (zstrm->ctx)
+		comp->ops->destroy_ctx(zstrm->ctx);
 	vfree(zstrm->buffer);
-	zstrm->tfm = NULL;
+	zstrm->ctx = NULL;
 	zstrm->buffer = NULL;
 }
 
-/*
- * Initialize zcomp_strm structure with ->tfm initialized by backend, and
- * ->buffer. Return a negative value on error.
- */
-static int zcomp_strm_init(struct zcomp_strm *zstrm, struct zcomp *comp)
+static int zcomp_strm_init(struct zcomp *comp, struct zcomp_strm *zstrm)
 {
-	zstrm->tfm = crypto_alloc_comp(comp->name, 0, 0);
+	zstrm->ctx = comp->ops->create_ctx();
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
 
+static struct zcomp_ops *lookup_backend_ops(const char *comp)
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
+	return lookup_backend_ops(comp) != NULL;
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
 
@@ -115,38 +88,25 @@ void zcomp_stream_put(struct zcomp *comp)
 	local_unlock(&comp->stream->lock);
 }
 
-int zcomp_compress(struct zcomp_strm *zstrm,
-		const void *src, unsigned int *dst_len)
+int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
+		   const void *src, unsigned int *dst_len)
 {
-	/*
-	 * Our dst memory (zstrm->buffer) is always `2 * PAGE_SIZE' sized
-	 * because sometimes we can endup having a bigger compressed data
-	 * due to various reasons: for example compression algorithms tend
-	 * to add some padding to the compressed buffer. Speaking of padding,
-	 * comp algorithm `842' pads the compressed length to multiple of 8
-	 * and returns -ENOSP when the dst memory is not big enough, which
-	 * is not something that ZRAM wants to see. We can handle the
-	 * `compressed_size > PAGE_SIZE' case easily in ZRAM, but when we
-	 * receive -ERRNO from the compressing backend we can't help it
-	 * anymore. To make `842' happy we need to tell the exact size of
-	 * the dst buffer, zram_drv will take care of the fact that
-	 * compressed buffer is too big.
-	 */
-	*dst_len = PAGE_SIZE * 2;
+	/* The dst buffer should always be 2 * PAGE_SIZE */
+	size_t dlen = 2 * PAGE_SIZE;
+	int ret;
 
-	return crypto_comp_compress(zstrm->tfm,
-			src, PAGE_SIZE,
-			zstrm->buffer, dst_len);
+	ret = comp->ops->compress(zstrm->ctx, src, PAGE_SIZE,
+				  zstrm->buffer, &dlen);
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
+	return comp->ops->decompress(zstrm->ctx, src, src_len,
+				     dst, PAGE_SIZE);
 }
 
 int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
@@ -158,7 +118,7 @@ int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
 	zstrm = per_cpu_ptr(comp->stream, cpu);
 	local_lock_init(&zstrm->lock);
 
-	ret = zcomp_strm_init(zstrm, comp);
+	ret = zcomp_strm_init(comp, zstrm);
 	if (ret)
 		pr_err("Can't allocate a compression stream\n");
 	return ret;
@@ -170,7 +130,7 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node)
 	struct zcomp_strm *zstrm;
 
 	zstrm = per_cpu_ptr(comp->stream, cpu);
-	zcomp_strm_free(zstrm);
+	zcomp_strm_free(comp, zstrm);
 	return 0;
 }
 
@@ -199,32 +159,21 @@ void zcomp_destroy(struct zcomp *comp)
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
+	comp->ops = lookup_backend_ops(alg);
+	if (!comp->ops) {
+		kfree(comp);
+		return ERR_PTR(-EINVAL);
+	}
+
 	error = zcomp_init(comp);
 	if (error) {
 		kfree(comp);
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index e9fe63da0e9b..dde28a8d32d4 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -1,7 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2014 Sergey Senozhatsky.
- */
 
 #ifndef _ZCOMP_H_
 #define _ZCOMP_H_
@@ -12,13 +9,26 @@ struct zcomp_strm {
 	local_lock_t lock;
 	/* compression/decompression buffer */
 	void *buffer;
-	struct crypto_comp *tfm;
+	void *ctx;
+};
+
+struct zcomp_ops {
+	int (*compress)(void *ctx, const unsigned char *src, size_t src_len,
+			unsigned char *dst, size_t *dst_len);
+
+	int (*decompress)(void *ctx, const unsigned char *src, size_t src_len,
+			  unsigned char *dst, size_t dst_len);
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
+	struct zcomp_ops *ops;
 	struct hlist_node node;
 };
 
@@ -33,10 +43,9 @@ void zcomp_destroy(struct zcomp *comp);
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
index efcb8d9d274c..93042da8ccdf 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1327,7 +1327,8 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 		ret = 0;
 	} else {
 		dst = kmap_local_page(page);
-		ret = zcomp_decompress(zstrm, src, size, dst);
+		ret = zcomp_decompress(zram->comps[prio], zstrm,
+				       src, size, dst);
 		kunmap_local(dst);
 		zcomp_stream_put(zram->comps[prio]);
 	}
@@ -1414,7 +1415,8 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 compress_again:
 	zstrm = zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
 	src = kmap_local_page(page);
-	ret = zcomp_compress(zstrm, src, &comp_len);
+	ret = zcomp_compress(zram->comps[ZRAM_PRIMARY_COMP], zstrm,
+			     src, &comp_len);
 	kunmap_local(src);
 
 	if (unlikely(ret)) {
@@ -1601,7 +1603,8 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 		num_recomps++;
 		zstrm = zcomp_stream_get(zram->comps[prio]);
 		src = kmap_local_page(page);
-		ret = zcomp_compress(zstrm, src, &comp_len_new);
+		ret = zcomp_compress(zram->comps[prio], zstrm,
+				     src, &comp_len_new);
 		kunmap_local(src);
 
 		if (ret) {
-- 
2.45.2.803.g4e1b14247a-goog


