Return-Path: <linux-kernel+bounces-514360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E67FA355ED
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974223ADC19
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EDA19007F;
	Fri, 14 Feb 2025 04:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iapLYMpT"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D55B18FDA5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508821; cv=none; b=sftnM6kpi9uy3rx+pRp/mDV3PuR1+nb9RN1YZ5QfJMjOzqSXOEYrKq1w03kJAnRjB5rW3XVepmCsplV4JgSdrhn2dg07LABJ0/aGo0/mqu0JnaLh8qJwFxmHri1En55BQICCHx25Z2YODTSSwPDxFDA5J2Tz1mpp6Un9jF4npec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508821; c=relaxed/simple;
	bh=COsjrWCrhKbYAUy1yAf/i0nha4gWII3XHI6ohEWeZ4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/MyV527DacUNYLABQyPTZPDv+kplZ/9ORsKr9g7lha8pQkUUwsL41rdtZPpsGVXD9SnezEchgWl+8xFRABB9iyRJ/OFkKveXkMPDZQJUxVTbCt8/nttyvErlHD51j2Vks9WzrqkPFs81vuJXU8LCflh5tVl1yQnL9lRasXGDTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iapLYMpT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f2339dcfdso25110725ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739508819; x=1740113619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8MSYx1r6vOiRHwxjnCDNpKvIAk9Qp1UAjAoAUDj4z4=;
        b=iapLYMpTrM2FlHXqcT8qiHAFx20mP/GrXKuXcadlP31bx9hXGCZpWhrd1AabJsqlcR
         K8UA6zterGxnW3/pIL8vOWcLpgzWeV6nwz4kwdLavVx8KIUS5ZSUApqQi0YXzn49v5LH
         8WxZdxL94YtKXDwC/0Z69PlFATmif6fD2ls9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508819; x=1740113619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8MSYx1r6vOiRHwxjnCDNpKvIAk9Qp1UAjAoAUDj4z4=;
        b=Lp77TOlFargiWXXQCbDknlNpSPqSXy1oUJAyYc7lpVFCDlHTr5O3vQTYcj+VU4KpPq
         LYKE7e7Ro4fPFaFzBMDrteWB9gAxWKiZnMOs8JgNGiDCnW+IWISHFtotfeSYq08QtW1l
         Gx1nH0Bcb3vnO8xwUba+cEOZArK+4IPjTBcOkWiSrbThMo+sOgJbRp66DB/PCFe3sQR3
         vEqPd3b+JNPGvGvG3tfG54Vu2a3arqpjC8WwI3HhAvCj2hvDHZXUOJpqWysTzVXZLXK7
         VfdB5A6ut/YPcQ+0JsVfkRdGuHoArKGfi2iHVCTDhXq+hpOFkube+8PqUm5/4GtLMHGI
         Ue9A==
X-Forwarded-Encrypted: i=1; AJvYcCX12JwOudXQPKfVCS9MfAuyqhnlKK50yydg9MgteW3ZMV6IFvA5LCcCgzHoVD/07XUTti3/Vvi0N6MuBbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb0pf/jYDmRYeszsbcuWcxJftPeYcIhMagSuyamcnxh3id7OCZ
	Ddg2BQLLeH3F5roe5AMpwT9xPyhP7lhYCglHFHb4A3uckgSkPRFZhsynf0Ztmw==
X-Gm-Gg: ASbGncuVVHDHwN7NP4KsBPJ48/TGoH7xFiQy5Fs2L/2JKEp8kl+7kt5tckPs3HGtCkL
	eCWS1Db1GClpX0UYDVhKTpOB7+1aZ8lF2VFKqLpc2skMcA8d2IqABiQWNReFXe3MQC0Aow8O+bj
	qNQSWEZH0H7qsExPJ/ZxX8SdvXGAITVOHWmU1eWh7qzeRNtAVRM4+jnIIJWAAYU+Http9rq7T/F
	xZg7kF27ZkOlx4KwIGIghdYodOOmOLuB1GPe+86OL/dmsauXQdXHyIZn2D44p4NRW5cUgLShMQt
	23ZruWe8Om2q6JVp5w==
X-Google-Smtp-Source: AGHT+IFj0J84blWWRorX7QC5QTsPm4yxqb/UskRAxNtWaOKmY3i/R9l8RGftlk8+B1lrXJZdO59P7Q==
X-Received: by 2002:a17:903:18a:b0:220:e98e:4f1b with SMTP id d9443c01a7336-220e98e52b9mr44389295ad.0.1739508818756;
        Thu, 13 Feb 2025 20:53:38 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:942d:9291:22aa:8126])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d53492d0sm20895595ad.35.2025.02.13.20.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 20:53:38 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 13/17] zram: switch to new zsmalloc object mapping API
Date: Fri, 14 Feb 2025 13:50:25 +0900
Message-ID: <20250214045208.1388854-14-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250214045208.1388854-1-senozhatsky@chromium.org>
References: <20250214045208.1388854-1-senozhatsky@chromium.org>
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
index 2e46ea542ecd..87ce304a60aa 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1603,11 +1603,11 @@ static int read_incompressible_page(struct zram *zram, struct page *page,
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
@@ -1625,11 +1625,11 @@ static int read_compressed_page(struct zram *zram, struct page *page, u32 index)
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
@@ -1725,7 +1725,7 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 				     u32 index)
 {
 	unsigned long handle;
-	void *src, *dst;
+	void *src;
 
 	/*
 	 * This function is called from preemptible context so we don't need
@@ -1742,11 +1742,9 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
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
@@ -1767,7 +1765,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	int ret = 0;
 	unsigned long handle;
 	unsigned int comp_len;
-	void *dst, *mem;
+	void *mem;
 	struct zcomp_strm *zstrm;
 	unsigned long element;
 	bool same_filled;
@@ -1813,11 +1811,8 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
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
@@ -1929,7 +1924,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 	unsigned int comp_len_new;
 	unsigned int class_index_old;
 	unsigned int class_index_new;
-	void *src, *dst;
+	void *src;
 	int ret = 0;
 
 	handle_old = zram_get_handle(zram, index);
@@ -2039,12 +2034,9 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
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


