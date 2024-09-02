Return-Path: <linux-kernel+bounces-311148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0648296857B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA3B1F23333
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AA9186E3F;
	Mon,  2 Sep 2024 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ESQGvYZS"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7931865F6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274634; cv=none; b=eO6RrdOL+YSyqSdgMPPP3zP92ncQ9yup5wAXD8qul4wn+e/mC5a2pvK9JlgeIBan3Rwxlfc3mCEIn77UFo4e+KChjrUeD2MQYZadOKOeZhIN+4qxuvNgT//BmaDtkodMeHgvpEEtIgifbNYi+q5M+/K6xoXF4YQz7Cas7HEt1t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274634; c=relaxed/simple;
	bh=i5SGbb27ixq93Cin1OF1ul13vrKZTiDPTZGvt9XhNtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5cyhTOPtLBj+QrThnogLxDE+zTEPZP2YgCrJGVkqJQHfPKShJoywwCDDTsNTq1hSBcJ2VfXUTrEl++IrUiOrUaXJeDt56Y61q30iRr6Sy3eQi9bnEeAiYZMuSYkMX2wJox6B1YtR435tdpJviNv32vraWxr+2CoWOYKAiHjCAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ESQGvYZS; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-70f6e65d605so1436780a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725274632; x=1725879432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMLjKl00jE0A+L1e9EaxbGdOiKqbW3HdpeGcS+qXhAE=;
        b=ESQGvYZSwFKEn3jn5VfshDD+O/3YXuLa45W8iqD4q7GIBi/QOaugRL7G4AP9C7o1EB
         exi/4MxVKWZ0y+qKBaihlVn7U+OxzTorDNakdFFAQuCZ9gffKbyefKDsZJM9VOxAsIrB
         olgwFd2ii+XJ7OybJNLSycNJMv4yWmC5oRAqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274632; x=1725879432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMLjKl00jE0A+L1e9EaxbGdOiKqbW3HdpeGcS+qXhAE=;
        b=kuLncDviZgyUgieDKH1nrqAxBgny0Ar+8jwVCCvBr4OFrcHoK5BuZXb0Z/xho3pKM1
         M57wzyj0qx5wb+qgFd+0AurxmFox879XK0FBk9P93QpG4jD7oMfkqjz4VR1jihWNa5z/
         qHpuHIRisJIvJ26NV0wQjpC0nUrU2Ih/FjdHsg5zhMof0ohxlL0SmYRjIR7VVY4330wz
         Iv8VjGUYovSBdm2lQS0pqSDOQIFJOubThzjDK8yaOnYgoAb+TstXpEhLWSK1nwHGg6UU
         IU70LMV/kSmfN80q9BNW3eD9oDKL1e3uAlG9JbshoPE9cnrJc5EfFivXto1Rp61JYZsL
         EKUA==
X-Forwarded-Encrypted: i=1; AJvYcCUYpqbDgDrOZy9pnT2VN65lcrtk3+2NxwEYzPr2zKSzmLR7RZgVxu7iqYWG6cOx/DtREYcyk2GT813zkqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe7DQ2RcFCkomGoMLCH4ZlwjWiSwJ6B/JXTsqItsK9hBkJi9dV
	gWmg71DBRV43vAeQMB47WZDlwwvw1m424Q+rLnIwHEQvBkeI2/uVGVG/WClWPw==
X-Google-Smtp-Source: AGHT+IEz2XqtIZvZotAF28uo/rjEi+n/LaR/diai5VuLyTP+flgjRSGtoWylJZbz61MpQOSlRNSLBg==
X-Received: by 2002:a05:6358:998a:b0:1ac:671c:d424 with SMTP id e5c5f4694b2df-1b603c1f2bbmr1770058555d.8.1725274631681;
        Mon, 02 Sep 2024 03:57:11 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a51e9sm6633769b3a.78.2024.09.02.03.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:57:11 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv7 04/24] zram: introduce custom comp backends API
Date: Mon,  2 Sep 2024 19:55:52 +0900
Message-ID: <20240902105656.1383858-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240902105656.1383858-1-senozhatsky@chromium.org>
References: <20240902105656.1383858-1-senozhatsky@chromium.org>
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
 Documentation/admin-guide/blockdev/zram.rst |  11 +-
 drivers/block/zram/Kconfig                  |  39 +----
 drivers/block/zram/zcomp.c                  | 150 +++++++-------------
 drivers/block/zram/zcomp.h                  |  29 ++--
 drivers/block/zram/zram_drv.c               |   9 +-
 5 files changed, 78 insertions(+), 160 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 091e8bb38887..181d55d64326 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -102,15 +102,8 @@ Examples::
 	#select lzo compression algorithm
 	echo lzo > /sys/block/zram0/comp_algorithm
 
-For the time being, the `comp_algorithm` content does not necessarily
-show every compression algorithm supported by the kernel. We keep this
-list primarily to simplify device configuration and one can configure
-a new device with a compression algorithm that is not listed in
-`comp_algorithm`. The thing is that, internally, ZRAM uses Crypto API
-and, if some of the algorithms were built as modules, it's impossible
-to list all of them using, for instance, /proc/crypto or any other
-method. This, however, has an advantage of permitting the usage of
-custom crypto compression modules (implementing S/W or H/W compression).
+For the time being, the `comp_algorithm` content shows only compression
+algorithms that are supported by zram.
 
 4) Set Disksize
 ===============
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
index 8237b08c49d8..fa31f1b91e0f 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (C) 2014 Sergey Senozhatsky.
- */
 
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -15,91 +12,68 @@
 
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
+static const struct zcomp_ops *backends[] = {
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
 
+static const struct zcomp_ops *lookup_backend_ops(const char *comp)
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
 	sz += scnprintf(buf + sz, PAGE_SIZE - sz, "\n");
 	return sz;
 }
@@ -115,38 +89,25 @@ void zcomp_stream_put(struct zcomp *comp)
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
@@ -158,7 +119,7 @@ int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
 	zstrm = per_cpu_ptr(comp->stream, cpu);
 	local_lock_init(&zstrm->lock);
 
-	ret = zcomp_strm_init(zstrm, comp);
+	ret = zcomp_strm_init(comp, zstrm);
 	if (ret)
 		pr_err("Can't allocate a compression stream\n");
 	return ret;
@@ -170,7 +131,7 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node)
 	struct zcomp_strm *zstrm;
 
 	zstrm = per_cpu_ptr(comp->stream, cpu);
-	zcomp_strm_free(zstrm);
+	zcomp_strm_free(comp, zstrm);
 	return 0;
 }
 
@@ -199,32 +160,21 @@ void zcomp_destroy(struct zcomp *comp)
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
index e9fe63da0e9b..e5eb5ec4c645 100644
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
+	const struct zcomp_ops *ops;
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
2.46.0.469.g59c65b2a67-goog


