Return-Path: <linux-kernel+bounces-540887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC668A4B617
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A0267A29FE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D3D1E7C05;
	Mon,  3 Mar 2025 02:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lRfVeWDz"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028AF1E5B7A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968750; cv=none; b=ONgOYrNIloy1oZ4c3DvER7BzyFGEZwv9Rs8GLlBqwaRoBax8xCnWjaD3XjLfojevJ2EliFNKRrxPMnpRcATzW0K53tXYwvcC2ZwOnjhj2tssZG5418S2ZQcsrc2gUwJj92PlLofm/EH5ieMRPwa0O8n7rArYEs0MywliX3+QQCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968750; c=relaxed/simple;
	bh=wcSr27N3MI4dvCoc9p6MifR/HaNjuWH8mKzrev84nnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2j8gPiT7IWPx7pNpQUFHVNA2jysndrN5/T/7uJrgqBJnBDbugoKBhkTZT++jRc1h6HT/jOGPuvKsPy1V/isHZ1TfTKzD+ti/HKQsD+oSPFbfso8Bgr/LllNHcI6pu5QD+NsWb2N2fRS3TiExs7Y4HN/jjBradU5ncdXzwxqcLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lRfVeWDz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fe96dd93b4so7159852a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740968748; x=1741573548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T67dKHYswiGrddgSZiZdCiBHKq1q/ZI+uUwWC6eNCTs=;
        b=lRfVeWDzWDD4EbRAf7thShz7Gr0KkoRIZ3+aiuFPzVGqi2pJ6y0cceU1LGxzDgJH5o
         Bgp5cvwA4lMK9+7K0YdybnfYSIMQlvv6DZIZBdh8ryZc69snpCw9g4oHGYhZMuxLarsS
         DY27LDSZBGHEycd6yWGyEseLXfNp9YegQtRoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740968748; x=1741573548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T67dKHYswiGrddgSZiZdCiBHKq1q/ZI+uUwWC6eNCTs=;
        b=Uccg71/o24H8FippjYbFus5Y8G6OxgQtvzTJbsJ3MxoeUJddjP3Kzp2duOEKHAz41x
         Ucu1qfcEm7Ig1/pY71SsrWrurIlUlhsMoHaFcV3pad3pO6E3YqdopIzYO3z3Iu68MTbl
         XC7H4H3JRTVmxd2fKaX3yAlBE6T8tkdx9gXla7NdvXx/1dMaABFedjFQWXL2MzhILh4y
         qLnwv6n8ClRgqCW3pR0CgXos+9H8oJaB1ujmyARJc0nIsxFxBJK0WQYN7fuJTVVUwZxu
         9hbBxPCHmMYXM4WYYN2kCgGgHi/drP9EfEQUYhtED7LZ3B8IWY5sgv5n8A3Xov1tyV5R
         HqbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBQqsRIME2UApEJ8l8JNpuY1Pmj33Xfyzu0y1HI9Eu6D4rT3ymDDhPILPbCfob8+MIY2omKXDPCfa3PaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWbFvhWcdbKgE+SROi6X9StVQ4KNDxC8M2YQ3OvH7eJ88b3xn1
	i455KKCu2u+gNIdkKNh3myGVzvMlN3d+vhs3hgd7zPQgVb5hXJsIJ0SC1SgN1w==
X-Gm-Gg: ASbGnctmY5m+Gf3xPxjpdgX3QWs7WTJNLlmbnU9VKUo7Dc9oqcXX5swBKj+1Snc13Q8
	8JhTy0TM4LpjQtwG8DCxLg49PgZfRV1GViZ8jAjSdDgg33jAyWrd4RmQrH/hOGZvs5iSjnW/KjX
	rl/0ACZcV//hiLIcXsRW8EZ+MGVYySrZvYlZm/3atiWGiffOWBBP1LZHI5SJ5TwjIUxQSre/RmM
	+tOT6+12z3urIDd1gGjaLRx8tFchVn82L59EJTqhkbpcpd7SBPPuaYLb0AWjRF6jARc/O1t/uPY
	f0eUGNyFkLoYWC/JNrIIm3pS24tbGMYTcpg0d80rA6Ka9G8=
X-Google-Smtp-Source: AGHT+IH55gKbbFLH/4p1SdtWLi5VFnXEFbXHma9n71ec/lgw7BNRJwBiDWwI7fYS8F4jPBgKdgrzew==
X-Received: by 2002:a05:6a21:6e03:b0:1f0:e2e6:f41e with SMTP id adf61e73a8af0-1f2f3cee5b8mr17138562637.8.1740968748420;
        Sun, 02 Mar 2025 18:25:48 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1513:4f61:a4d3:b418])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7364002f247sm2421551b3a.90.2025.03.02.18.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 18:25:48 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v10 15/19] zram: switch to new zsmalloc object mapping API
Date: Mon,  3 Mar 2025 11:03:24 +0900
Message-ID: <20250303022425.285971-16-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303022425.285971-1-senozhatsky@chromium.org>
References: <20250303022425.285971-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use new read/write zsmalloc object API.  For cases when RO mapped
object spans two physical pages (requires temp buffer) compression
streams now carry around one extra physical page.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zcomp.c    |  4 +++-
 drivers/block/zram/zcomp.h    |  2 ++
 drivers/block/zram/zram_drv.c | 28 ++++++++++------------------
 3 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index cfdde2e0748a..a1d627054bb1 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -45,6 +45,7 @@ static const struct zcomp_ops *backends[] = {
 static void zcomp_strm_free(struct zcomp *comp, struct zcomp_strm *zstrm)
 {
 	comp->ops->destroy_ctx(&zstrm->ctx);
+	vfree(zstrm->local_copy);
 	vfree(zstrm->buffer);
 	zstrm->buffer = NULL;
 }
@@ -57,12 +58,13 @@ static int zcomp_strm_init(struct zcomp *comp, struct zcomp_strm *zstrm)
 	if (ret)
 		return ret;
 
+	zstrm->local_copy = vzalloc(PAGE_SIZE);
 	/*
 	 * allocate 2 pages. 1 for compressed data, plus 1 extra for the
 	 * case when compressed size is larger than the original one
 	 */
 	zstrm->buffer = vzalloc(2 * PAGE_SIZE);
-	if (!zstrm->buffer) {
+	if (!zstrm->buffer || !zstrm->local_copy) {
 		zcomp_strm_free(comp, zstrm);
 		return -ENOMEM;
 	}
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 23b8236b9090..25339ed1e07e 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -34,6 +34,8 @@ struct zcomp_strm {
 	struct mutex lock;
 	/* compression buffer */
 	void *buffer;
+	/* local copy of handle memory */
+	void *local_copy;
 	struct zcomp_ctx ctx;
 };
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f6e887f94b71..62aef12417a4 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1561,11 +1561,11 @@ static int read_incompressible_page(struct zram *zram, struct page *page,
 	void *src, *dst;
 
 	handle = zram_get_handle(zram, index);
-	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
+	src = zs_obj_read_begin(zram->mem_pool, handle, NULL);
 	dst = kmap_local_page(page);
 	copy_page(dst, src);
 	kunmap_local(dst);
-	zs_unmap_object(zram->mem_pool, handle);
+	zs_obj_read_end(zram->mem_pool, handle, src);
 
 	return 0;
 }
@@ -1583,11 +1583,11 @@ static int read_compressed_page(struct zram *zram, struct page *page, u32 index)
 	prio = zram_get_priority(zram, index);
 
 	zstrm = zcomp_stream_get(zram->comps[prio]);
-	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
+	src = zs_obj_read_begin(zram->mem_pool, handle, zstrm->local_copy);
 	dst = kmap_local_page(page);
 	ret = zcomp_decompress(zram->comps[prio], zstrm, src, size, dst);
 	kunmap_local(dst);
-	zs_unmap_object(zram->mem_pool, handle);
+	zs_obj_read_end(zram->mem_pool, handle, src);
 	zcomp_stream_put(zstrm);
 
 	return ret;
@@ -1683,7 +1683,7 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 				     u32 index)
 {
 	unsigned long handle;
-	void *src, *dst;
+	void *src;
 
 	/*
 	 * This function is called from preemptible context so we don't need
@@ -1701,11 +1701,9 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 		return -ENOMEM;
 	}
 
-	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
 	src = kmap_local_page(page);
-	memcpy(dst, src, PAGE_SIZE);
+	zs_obj_write(zram->mem_pool, handle, src, PAGE_SIZE);
 	kunmap_local(src);
-	zs_unmap_object(zram->mem_pool, handle);
 
 	zram_slot_lock(zram, index);
 	zram_set_flag(zram, index, ZRAM_HUGE);
@@ -1726,7 +1724,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	int ret = 0;
 	unsigned long handle;
 	unsigned int comp_len;
-	void *dst, *mem;
+	void *mem;
 	struct zcomp_strm *zstrm;
 	unsigned long element;
 	bool same_filled;
@@ -1773,11 +1771,8 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 		return -ENOMEM;
 	}
 
-	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
-
-	memcpy(dst, zstrm->buffer, comp_len);
+	zs_obj_write(zram->mem_pool, handle, zstrm->buffer, comp_len);
 	zcomp_stream_put(zstrm);
-	zs_unmap_object(zram->mem_pool, handle);
 
 	zram_slot_lock(zram, index);
 	zram_set_handle(zram, index, handle);
@@ -1882,7 +1877,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	unsigned int comp_len_new;
 	unsigned int class_index_old;
 	unsigned int class_index_new;
-	void *src, *dst;
+	void *src;
 	int ret = 0;
 
 	handle_old = zram_get_handle(zram, index);
@@ -1993,12 +1988,9 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		return PTR_ERR((void *)handle_new);
 	}
 
-	dst = zs_map_object(zram->mem_pool, handle_new, ZS_MM_WO);
-	memcpy(dst, zstrm->buffer, comp_len_new);
+	zs_obj_write(zram->mem_pool, handle_new, zstrm->buffer, comp_len_new);
 	zcomp_stream_put(zstrm);
 
-	zs_unmap_object(zram->mem_pool, handle_new);
-
 	zram_free_page(zram, index);
 	zram_set_handle(zram, index, handle_new);
 	zram_set_obj_size(zram, index, comp_len_new);
-- 
2.48.1.711.g2feabab25a-goog


