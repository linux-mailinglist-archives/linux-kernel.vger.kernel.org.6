Return-Path: <linux-kernel+bounces-526755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65972A402B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE5E4228D8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B992566F8;
	Fri, 21 Feb 2025 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hohAeS4t"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C0E212B1B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177083; cv=none; b=skricS2NfFbotiVxixq2mONJFfHCSXyYznq4DRsYLRVh1uhLAWAz8Y8KrddBPfWTn4w0UPJmckOJ+Jq4GgCOVadjIZTwkYA+0D0IH5ET4vE91Ut0ydzux9TncNwBMtg82zbVgHsmByiAZwRpdUs/cSIyLg5Kv3sT/H+xIdkMcxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177083; c=relaxed/simple;
	bh=NiSQ7q+EvfNAk7dcsOoIV/oXNZDcNvjLhYsDxqbB8LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTbv+oh7nZ0G5LxUUgSrNOF/F6Orh9aYBWcmzP26n9SRK99VZncT4+p/24RsKheck1EP6UAnyzyM6mW4ZfhiXOdLc/uzC1IF+sF3STWMlQmtLI1ska460Fr3eCSe2OSjHdR/vjZS3vkMAk0MgeqoweQ3v27M6J65rSMLQiGRMpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hohAeS4t; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220e83d65e5so52009195ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740177081; x=1740781881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ywFL0qx8JBQIO9VI8pgvX03IYGXOc8sRHANyYI8RpE=;
        b=hohAeS4tMSguEjuld3dZO9FUATDBvWcwmoFbFs4LSytAmq1GzFeh/+qg/c6po930xG
         cdMpO0MhhSUu9ixf/210L1AjPENtOwJ/0WzGaNEE3kCTv21eDnYcVZzU8yq5rSOTsoxC
         zmF9X5mvpe5MmWlQPfy/t+cC0RId96lLLO1xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740177081; x=1740781881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ywFL0qx8JBQIO9VI8pgvX03IYGXOc8sRHANyYI8RpE=;
        b=j7p4DGnbGzE4mBDFxtiQfrIZP8KJTiN/6739yJEH62Ma0DLaGzppKOHks3oOKNZSwK
         ZIMaXQLCK0yfsa4ZSxD63R9zUzafSSeknBe8sQ69vq+91s5L83ZFkYLDkeTTx5rfzvXY
         jks5nUaXLUpxAVfMVYN5pAvtxOi7ZFNLnyO7rDl9xAL+rx62l0uRl/Ks/UNTHReo3wGX
         oPArM08UV1mn8KWW89V50l1uq9IAqQ4zP03IP4ynhlza9xFfGnqZ2rEoOL/ndfVNVxd+
         /QuUTWg92VPXwjN/iJt0e4UBto0u2mlM8F8JUOVOafxImA1lH6u3Yf/Y46q74QocpAML
         DCWg==
X-Forwarded-Encrypted: i=1; AJvYcCW5mtbz1fFXtTKmbsu7AJQxpq4HyUtW0PRZq4ivlCER2RMLRYfZu0DmqdwYAIsUkEzFJvz8cYFTe0k/0tE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrSK4vzQBjHL16K1Y2fCcy/NCJsjG6EcdoupeR8b58F6Ifmlnb
	E76ojIslmC8J4fE7IoHY+cfV3hsN5D5kK4rCTtqT8YE7jDzi0Vhlvby1GEJOTwjK/5SpWbqStpo
	=
X-Gm-Gg: ASbGncuGjc/O/T7LEm2c2+h250amS+ikNwdVp5KZZmso4BD3Kei1CAyyxNwmpDvZoHn
	OlvcuJORkMmCe4bVNXqZjkc/8yokOcHk319QrQs9ZLaeSJDb0l4czRtm7sk0wASx98PwyxOttD9
	A5Foa1NUfs6lXNbeL9Xqs2IbwScQLoXLLZBC/b0DH65+etFw9xwVHGGP8dUonvvM7Q0E9ZL3WnQ
	C4xDzzsJFy22jMquh9Qaaq3R4HBYo60GpSEe1o7X4OPCMyQ/nLDCUCAM62qacM//gqb7BXJpuFI
	X/jMvkuS0+55NmYzGpxKYcSykg0=
X-Google-Smtp-Source: AGHT+IHKsKKftwTwJ0CiusP95+2mkUFfAjHaiXoSZhqOL+gmM2fD2wdcoOjiL2xiqFP6/U7Mmpfp4g==
X-Received: by 2002:a17:902:cf10:b0:21a:8300:b9d5 with SMTP id d9443c01a7336-2219ff5f65emr84680315ad.23.1740177080968;
        Fri, 21 Feb 2025 14:31:20 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d55963d7sm143272675ad.257.2025.02.21.14.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 14:31:20 -0800 (PST)
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
Subject: [PATCH v8 13/17] zram: switch to new zsmalloc object mapping API
Date: Sat, 22 Feb 2025 07:25:44 +0900
Message-ID: <20250221222958.2225035-14-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250221222958.2225035-1-senozhatsky@chromium.org>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
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
index b96be8576cbc..1ce981ce6f48 100644
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


