Return-Path: <linux-kernel+bounces-535584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4683A474D2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE5627A5263
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0C222D4F9;
	Thu, 27 Feb 2025 04:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XFjKFv+y"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6665822CBF4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631076; cv=none; b=VHUXnmBNycDWDuy9shjVUobTLhNJLYSQ0EKnN7oiWbWtjX3DFLN2OmkvcHGHrVI+NWsJTJd9kpWgMd/pLlvnEqcrFAspQyeWMJ5QJ/cl+6xPLmdJJ4p/fYbKG8XxKNnKU/V25m84UfsLQhmGOvlz6I1KqgOS0XqYV1P5c5FPz64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631076; c=relaxed/simple;
	bh=Y1DGMDdF306tqns15ytiyh6756PpxvWDjG7kHbCED6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaTw24lMFNkT32Gz0NIHV9OZim6ke5eWXSOLJn8gFIdqzZiHdQvV9jn1YzlP/5AbS7ACPvW69tNDJbV7AHoHdE4a80/Vhnkkv90LtEkM2Jf728eK1X1A8Lzes0iPZ2tV5n1r1i7vuuHUNWCmR+8GtaGdYe7o1UL7n+Wesu3Nj3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XFjKFv+y; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2235908a30aso378275ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740631074; x=1741235874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzxKzH19wN3flX6Re4AXRoS/RZlbQkKv5ZSRzF7j4DA=;
        b=XFjKFv+y16pqG1xx+SL1AktW2sF/cbUf5bqfR9rTBNhKt9x7CSllaHKB42Z7KHINMR
         vHENGfuEF05VrDqlDj+sC+CarfxOhjoT7Q3TFqyF3SSXduGV8XXPBmpS6mVW2uIysq0z
         E5yX/i7KZpcQdK8F1Q3XGMg96cpWD5kycYNrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631074; x=1741235874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzxKzH19wN3flX6Re4AXRoS/RZlbQkKv5ZSRzF7j4DA=;
        b=AwIgPP1mISkdIgHfuyu5VgOM/Vu4QLt3fous1HxPY+y9IsyyTxSrZWNWRP92Io1qCX
         ryELy+lbw/q1J/GErI1bFAuC9DFpG0YvcIre0jIsJPU6n/GUHnZ3XcxFTAf6p9e/YaCE
         qC1NpiETbfrbtqRh/O+40RTy8+BxipaNxu6YjlHCRiRPrxbGZttRSwjAT4X5UKuRnIvn
         pWbIC0zkvxY7LmF6WmaUbDWXhIS/R/8xXyHKb/Ye7l/grAfA/fy1WIR3zozXD9OMz7yh
         RDjC6CPJ49dAw9LFxOYxR+dqLjpQlPn00rFJ+7oRnDeStjL+yZbvctC0QI9SJ5HVUPTE
         54SQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+XckPiv26lJZI9Z2EUnpWuU3kSBsn6uoQ6jnmk/wyfhovw57cFfchqKxo+4CmEFQrf8BeOX/MS/Fd74w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjQuMuJao6ef+FtFJp7F/eHY17Rdcd8gOir5ZYugtrDtYSezbg
	MiF9f2EUXm2Anud0BFVMpZ5EYYnzJDvnxvg+Dg3rJ5k640UgGewUB/UPmY9otg==
X-Gm-Gg: ASbGncvSh1uLmaT2V9UiMFOj2P70EXMyOyW9V384Vj4tM6ZF2JElWE6MOq8UcUa4iSG
	+wV0K3BYLwBRPvt2/J7q+KwLX57LvDJ/YfFieam7r4a68FcrDiGrbJ9Ct+yhnjZk5LOS5mF2u0k
	+Pb1CamCRj5qYDGVDXkN0eLOb3BdfhfZgkQQy/q35vMbJn2NvKFyBULY2Ph7IooPAV/tenpUpJW
	3DYyMIQvtDBTCIvwHD4Rn5L+QfxYpYkrFzlVS20+d0JAgInlTiY90iLgXR2l1TDqNv6HdBR6TMd
	AJl61g5i5UZvpxyH+frCSkUEf3nJ
X-Google-Smtp-Source: AGHT+IFihPm3YLRz0ki1R3h8+MO8xOX0re37Dk+wIL69kSAnv/pKGoOrc8itNvxpjLwlfq4K2/CuWw==
X-Received: by 2002:a17:902:f541:b0:223:26da:4b6f with SMTP id d9443c01a7336-22326da4d3emr76424375ad.14.1740631074685;
        Wed, 26 Feb 2025 20:37:54 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501d5247sm4996945ad.26.2025.02.26.20.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 20:37:54 -0800 (PST)
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
Subject: [PATCH v9 15/19] zram: switch to new zsmalloc object mapping API
Date: Thu, 27 Feb 2025 13:35:33 +0900
Message-ID: <20250227043618.88380-16-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250227043618.88380-1-senozhatsky@chromium.org>
References: <20250227043618.88380-1-senozhatsky@chromium.org>
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
index 7ad89df9a304..1e2ba3590a39 100644
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
2.48.1.658.g4767266eb4-goog


