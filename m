Return-Path: <linux-kernel+bounces-525508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31747A3F0B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BE0422C63
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF42820469B;
	Fri, 21 Feb 2025 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HLQXdT4b"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861BC20ADF4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130797; cv=none; b=KhL/D8THH5kKED1TT0tiUarNfWSJz1ICqhY8S/+RUjj8MYPJeXTmW67yRAj5uyuKtH8kgZ8yDkrjrbO2GrLLFSmd3+NptCgrz+v//lMysmE62nHrkO5rWWT6y74RZQYhipQJ+lv6dYznPlrgEFIoLjMhTaH/y33KTomMmFVQHXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130797; c=relaxed/simple;
	bh=AYg9ttBwU3Iy/VBQie+4ekcZ79IcjostZ8tRZp0eDfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oojio4MOkQ4FwCzvpFrlhu+nKF2jt3Ypw3OufTBqZ7+J0QSOUDGqxatRI4mVArzRnSebZ9bG9g8yMLAkvRKSV9+bzgnflzwWJzlRHuQnDM6KfOeBluj5/j4xciusP070SHYJi8Y2Yuu87ycamxdKwTUC5eaA6bWwbgtTtmUxV/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HLQXdT4b; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220e989edb6so51504325ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740130795; x=1740735595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7nX2BQHP+jBaMIBfki0Sibf1caPlu6CBS1i9yoAT5c=;
        b=HLQXdT4bvOG0xCG9iGEKW88c8FO1ww+4dAGB1En2+G9FkGI+Y4UEQsyv0y2+bwHRxl
         vWbLYRPdg9zyLNAJ9FUs/KsKchbNuMXV2l5BRs5+b9fnTeZBfQKJ27Lb0f5XI0lOqGMA
         bfLcuo7Eb5sSKJgl8qJrGyfAnJ6iE43bVMmUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130795; x=1740735595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7nX2BQHP+jBaMIBfki0Sibf1caPlu6CBS1i9yoAT5c=;
        b=WkZ2RqS40drQiyW47cFz8g9tVtDOrTaSnOtiXecoHYGOObLmQmw6Uu/KcOiMTysLFD
         yMET4UzCQUKAwYbw9d+2W/qBsnPpsDMO0jwSr8leHaMN3/WKa+yqRiFnLw6CmOoK3mBI
         zBxQNXMKhApIuOTUYI8vUm/NCp4CeFxGOn5lpqxxHFtQzW66srILVjcFKesVgYWL4Z1y
         lYCLGZTu7xYaelQhzYWtJNBWmtJsuyjuMe+4qQ97oPBcMRopGvOEqRGy9anQKU4Zz+2N
         3SuOPra2kDEqIhfstzJoSzEov7nVssXl87wU8PXicscWsHC0JLiON71NEuUQKvTbC90B
         DHPg==
X-Forwarded-Encrypted: i=1; AJvYcCVnnNt46b6mTDX9Y8o19uTBtokaWzHDlJw7H/pNNjuuB2VEpdb3g+wQgVWJjwVkQJIL0+eZXx/KErVx7/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeajR/w6HHiqR/QQFnZjXTPAtG4IKV6oQ0ljSF/UtMTH7ZkQ5m
	chfXyR7/Fp7OwVfjvLZ5j2VhVMa8uxJYXRbi8FiqQg24vBMZ5I2ZTOC5qn/xCA==
X-Gm-Gg: ASbGnctvQnkBG5MHTfiG1d6HVGDRXIcZWq1f1sUf4UPKUnLLtk2k1tNvI988f7EQAe0
	p01LKQZN0mTNfphMDVV75I4mQy4TXtL/Fe/vn9TsJYV+CFXz5tXizC0rdNb9v0pFe7hi0zsg62T
	oXDJWGOUXaOdwNAKwvGmUfm1XaFbguFrKH0bu9kAGNgsccEASwE0sphJnPpXbkub4pJjwKlE17a
	Jyf9zJfpi9MDJ8Rf/5EfbGnVj0bHH6dFvY8gmAwwQZTCwL2AWqOfjpfb/m60Kx/+lluBucSfdRU
	VupYf3829KXV3HZTx3vzfJM/MhM=
X-Google-Smtp-Source: AGHT+IHnX9TtZ5+pJhaRuJdP+fitjuJuk97DulMxTJbwpxnruxJEAlVkN6hwAldQgSdlVmFyU1l8KA==
X-Received: by 2002:a05:6a20:9184:b0:1ee:c093:e24c with SMTP id adf61e73a8af0-1eef3dc4dfemr5404148637.30.1740130794756;
        Fri, 21 Feb 2025 01:39:54 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-adbf21517eesm12895632a12.13.2025.02.21.01.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 01:39:54 -0800 (PST)
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
Subject: [PATCH v7 13/17] zram: switch to new zsmalloc object mapping API
Date: Fri, 21 Feb 2025 18:38:06 +0900
Message-ID: <20250221093832.1949691-14-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250221093832.1949691-1-senozhatsky@chromium.org>
References: <20250221093832.1949691-1-senozhatsky@chromium.org>
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
index 814e64f4ee38..47ccda207bf3 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1566,11 +1566,11 @@ static int read_incompressible_page(struct zram *zram, struct page *page,
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
@@ -1588,11 +1588,11 @@ static int read_compressed_page(struct zram *zram, struct page *page, u32 index)
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
@@ -1688,7 +1688,7 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 				     u32 index)
 {
 	unsigned long handle;
-	void *src, *dst;
+	void *src;
 
 	/*
 	 * This function is called from preemptible context so we don't need
@@ -1705,11 +1705,9 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
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
@@ -1730,7 +1728,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	int ret = 0;
 	unsigned long handle;
 	unsigned int comp_len;
-	void *dst, *mem;
+	void *mem;
 	struct zcomp_strm *zstrm;
 	unsigned long element;
 	bool same_filled;
@@ -1776,11 +1774,8 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
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
@@ -1892,7 +1887,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	unsigned int comp_len_new;
 	unsigned int class_index_old;
 	unsigned int class_index_new;
-	void *src, *dst;
+	void *src;
 	int ret = 0;
 
 	handle_old = zram_get_handle(zram, index);
@@ -2002,12 +1997,9 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
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
2.48.1.601.g30ceb7b040-goog


