Return-Path: <linux-kernel+bounces-510581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E6AA31F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F1A7A4408
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB9D202C42;
	Wed, 12 Feb 2025 06:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FjGFCQu5"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FCE202C5B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341994; cv=none; b=B4i/XKTtKIu74daiTv/n9GEtO+eIMQnCJjVf7J/6aHo7Ee1uxUROTe1dOd3IeVMLRWW4ieJzotJX8Fp+DdLOSQ2KDvehF6TGCXRRDY00vG8eGKmuQqwlSLtOr/uRibYT9NKwjqmqpXNO0wPVhEXLjMBOx3qcRhR9fQiqQ1wId6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341994; c=relaxed/simple;
	bh=mgqECS8dn1xjq1nP602YrqXmI98zspRzEWQlMNgS6hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ooX2RasKpp9Of0CpaWW2pLAehOHiJs+RQFamLst4bIk9k014cKFgTbdZ92u46rkNxha7tnGPgo54MxkPTH8FA6vkB5siBVYqOONyjkI83Lakau9vLusigrd/X4+ehpcSTh+3Wu7dHCscBXIEpWQC5mBjUb0wVQRcMP0w1mRpDr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FjGFCQu5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f61b01630so7545725ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739341992; x=1739946792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+0Z+4xYmRhftKTrRiF3jNVLaBZmv0cRLATopAZYYvQ=;
        b=FjGFCQu5vkf9eJ2ifR89MTduobd7oVmA+jY7RuXXdmFzfuFL63iv4C8Ghjn6hFMjod
         rUj4NN1ueITMRxY3u1XeN66uKhraRVsE1GzBZ7jb7Z4OEgw8Rv/IyJKJnTAuGw6Jw2H5
         U3YemutVkUpL2hT7BTOcUbVScgpfqxzkiGNw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341992; x=1739946792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+0Z+4xYmRhftKTrRiF3jNVLaBZmv0cRLATopAZYYvQ=;
        b=WI3v8II1HpGu1mCdAFb3vmabGBtjDAe4Sg0ZsaDhgrTno1M751Y26L89hc8KQtxd/5
         hczmLpSP/FDaiBEhC3rizfqHgZF5ywcUbAWvlNlpnufYqZxI52ji1g2Hxl5P597Wb8s+
         o/CHSq7z4CDM3Ff4xWSQ+Tppba2eKXveiDovowzPbB3AZpDPRGQWZduVtV2tv0egzuWk
         tS+bdYTEN1fEouMEE1ORf5Q0rxQBBcXM61Fj1nQ9jcAccbk3NUmKL2w6W8t4BHbx5/vG
         joRHS21gmFOio8MDRx8X2KKl5w3WNyGZK+bBWhfuSKNHq2/R09ToxfJqzIxSuiGzLb+S
         q6CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlyAvANFrv62T18kv/38l4/hsiXMV7mkaJX1PdclPnTF+FFGfKcxcmWm6x2luMvL29A3e66267yQxOHYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3BvKZ9maDJ0aVnNlsfmfJNAxBF8A8nNg098R0DJqvG8skAXBt
	39SvogcCtg8f0sTKet1wf8cbe69ouqNsqOML0dCI598I8Q8Bp2gOmBFffOG9dw==
X-Gm-Gg: ASbGncuvlZmm9ZDj8Isg4UfpLyiZpfOx/c8FGa+829jSEBofyYeu4mUM8g0ZXi+ZZF4
	0jgetfs43OX5naF79AQ8qWuyyiaiVg20jOXNKs2mbVhULrIIF31UNI4fFmE4Z9/qw2ZKswn1j7w
	0G46M1XgbmHrgn7tUEj9AQIIwszD3RVUToW+E8ZAYo6yzJXJOWy2/Gx62U2oluhS9nucAlTh63P
	HTaPHQknAzSc2FJKXrUdS26UhcSAu0Ud0/oBdsbsXt2ef5zDLKGa2iuv4f5US13cc+fnpGqGSFW
	KHnmUyF7LnZ756Hq1Q==
X-Google-Smtp-Source: AGHT+IEhnNCxLoE2CNoFgq8/HUot/UmlliKB3Yg2LwQwc2F/d9hoWw6hVmqWymhRbVtPXN7CHslIlw==
X-Received: by 2002:a05:6a21:9101:b0:1e0:d3e9:1f8 with SMTP id adf61e73a8af0-1ee5cedffe2mr2971435637.10.1739341992642;
        Tue, 11 Feb 2025 22:33:12 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73093ab315csm4424643b3a.143.2025.02.11.22.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:33:12 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 14/18] zram: switch to new zsmalloc object mapping API
Date: Wed, 12 Feb 2025 15:27:12 +0900
Message-ID: <20250212063153.179231-15-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212063153.179231-1-senozhatsky@chromium.org>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
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
index c393243eeb5c..61a9c3ed6f7a 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -46,6 +46,7 @@ static const struct zcomp_ops *backends[] = {
 static void zcomp_strm_free(struct zcomp *comp, struct zcomp_strm *zstrm)
 {
 	comp->ops->destroy_ctx(&zstrm->ctx);
+	vfree(zstrm->local_copy);
 	vfree(zstrm->buffer);
 	zstrm->buffer = NULL;
 }
@@ -59,12 +60,13 @@ static int zcomp_strm_init(struct zcomp *comp, struct zcomp_strm *zstrm)
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
index 7c4c296181a8..c6310077c221 100644
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
@@ -1700,11 +1700,9 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
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
@@ -1725,7 +1723,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	int ret = 0;
 	unsigned long handle;
 	unsigned int comp_len;
-	void *dst, *mem;
+	void *mem;
 	struct zcomp_strm *zstrm;
 	unsigned long element;
 	bool same_filled;
@@ -1771,11 +1769,8 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
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
@@ -1887,7 +1882,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	unsigned int comp_len_new;
 	unsigned int class_index_old;
 	unsigned int class_index_new;
-	void *src, *dst;
+	void *src;
 	int ret = 0;
 
 	handle_old = zram_get_handle(zram, index);
@@ -1997,12 +1992,9 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
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
2.48.1.502.g6dc24dfdaf-goog


