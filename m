Return-Path: <linux-kernel+bounces-546142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 793DBA4F6E2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9453A5EBA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9E31D7985;
	Wed,  5 Mar 2025 06:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tK8A0eF3"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDC01DE2C1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 06:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741155117; cv=none; b=ibjg0IXPWXIRF2KHkBW+tljXXx43OX2Vrq3W3UfGQNKtTgs8ly/qzR4OjUr42SYbF6qZ/Yst8+v5sqcvBQrV7TQrK9iJ4Me7GI7TWThCo8rX1Ct7EPEQPQ45bFePQEglfOGzIWDqIAEvMqnMtSoEkEBr0XS/zq2pk5FtsnyR3zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741155117; c=relaxed/simple;
	bh=4dy+m/XxTgeCzQ7zVcCdW+/Lm2thUR9Kdc8yM1twUBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIp6V17rBAnnayQpMbRuI6MF6E7Rrt4Mqb4HuGJGz7PRli0Qce4jzUTTneQyRQo13xxYSPSTsBOpT0gG5QQqWF75ZYUYm3Jd4QKFn7P1/ezpE9u3cTFK1TZyYs9JZyCuGshbqk43SU9POYkqh4/KtwbhHfW374unBzteexfV/TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tK8A0eF3; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741155112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WoO6FUy5jZ5BOBiD7+tifxnzM0sl78f3lOIy/v/d1Yo=;
	b=tK8A0eF3Xlefw6CMLjm18bHwmIKhLt12hIUd+n5xuMqL3BbtRIYg5Gaj8g5jd+DEaWgwwz
	/Bwog36MMW0mCFIHU/kOoYr9xP/Xz/kmzC90sgmkI3tV66KzlJIjgoPnnqSrOz/5v/3rAn
	Y1ADaz2vPlUZexNOEZegHZGBkvOqNkw=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH mm-unstable 1/5] mm: zpool: Add interfaces for object read/write APIs
Date: Wed,  5 Mar 2025 06:11:29 +0000
Message-ID: <20250305061134.4105762-2-yosry.ahmed@linux.dev>
In-Reply-To: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Zsmalloc introduce new APIs to read/write objects besides mapping them.
Add the necessary zpool interfaces.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 include/linux/zpool.h | 17 +++++++++++++++
 mm/zpool.c            | 48 +++++++++++++++++++++++++++++++++++++++++++
 mm/zsmalloc.c         | 21 +++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/include/linux/zpool.h b/include/linux/zpool.h
index 5e6dc46b8cc4c..1784e735ee049 100644
--- a/include/linux/zpool.h
+++ b/include/linux/zpool.h
@@ -52,6 +52,16 @@ void *zpool_map_handle(struct zpool *pool, unsigned long handle,
 
 void zpool_unmap_handle(struct zpool *pool, unsigned long handle);
 
+
+void *zpool_obj_read_begin(struct zpool *zpool, unsigned long handle,
+			   void *local_copy);
+
+void zpool_obj_read_end(struct zpool *zpool, unsigned long handle,
+			void *handle_mem);
+
+void zpool_obj_write(struct zpool *zpool, unsigned long handle,
+		     void *handle_mem, size_t mem_len);
+
 u64 zpool_get_total_pages(struct zpool *pool);
 
 
@@ -90,6 +100,13 @@ struct zpool_driver {
 				enum zpool_mapmode mm);
 	void (*unmap)(void *pool, unsigned long handle);
 
+	void *(*obj_read_begin)(void *pool, unsigned long handle,
+				void *local_copy);
+	void (*obj_read_end)(void *pool, unsigned long handle,
+			     void *handle_mem);
+	void (*obj_write)(void *pool, unsigned long handle,
+			  void *handle_mem, size_t mem_len);
+
 	u64 (*total_pages)(void *pool);
 };
 
diff --git a/mm/zpool.c b/mm/zpool.c
index 4bbd12d4b6599..378c2d1e5638f 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -320,6 +320,54 @@ void zpool_unmap_handle(struct zpool *zpool, unsigned long handle)
 	zpool->driver->unmap(zpool->pool, handle);
 }
 
+/**
+ * zpool_obj_read_begin() - Start reading from a previously allocated handle.
+ * @zpool:	The zpool that the handle was allocated from
+ * @handle:	The handle to read from
+ * @local_copy:	A local buffer to use if needed.
+ *
+ * This starts a read operation of a previously allocated handle. The passed
+ * @local_copy buffer may be used if needed by copying the memory into.
+ * zpool_obj_read_end() MUST be called after the read is completed to undo any
+ * actions taken (e.g. release locks).
+ *
+ * Returns: A pointer to the handle memory to be read, if @local_copy is used,
+ * the returned pointer is @local_copy.
+ */
+void *zpool_obj_read_begin(struct zpool *zpool, unsigned long handle,
+			   void *local_copy)
+{
+	return zpool->driver->obj_read_begin(zpool->pool, handle, local_copy);
+}
+
+/**
+ * zpool_obj_read_end() - Finish reading from a previously allocated handle.
+ * @zpool:	The zpool that the handle was allocated from
+ * @handle:	The handle to read from
+ * @handle_mem:	The pointer returned by zpool_obj_read_begin()
+ *
+ * Finishes a read operation previously started by zpool_obj_read_begin().
+ */
+void zpool_obj_read_end(struct zpool *zpool, unsigned long handle,
+			void *handle_mem)
+{
+	zpool->driver->obj_read_end(zpool->pool, handle, handle_mem);
+}
+
+/**
+ * zpool_obj_write() - Write to a previously allocated handle.
+ * @zpool:	The zpool that the handle was allocated from
+ * @handle:	The handle to read from
+ * @handle_mem:	The memory to copy from into the handle.
+ * @mem_len:	The length of memory to be written.
+ *
+ */
+void zpool_obj_write(struct zpool *zpool, unsigned long handle,
+		     void *handle_mem, size_t mem_len)
+{
+	zpool->driver->obj_write(zpool->pool, handle, handle_mem, mem_len);
+}
+
 /**
  * zpool_get_total_pages() - The total size of the pool
  * @zpool:	The zpool to check
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 63c99db71dc1f..d84b300db64e7 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -507,6 +507,24 @@ static void zs_zpool_unmap(void *pool, unsigned long handle)
 	zs_unmap_object(pool, handle);
 }
 
+static void *zs_zpool_obj_read_begin(void *pool, unsigned long handle,
+				     void *local_copy)
+{
+	return zs_obj_read_begin(pool, handle, local_copy);
+}
+
+static void zs_zpool_obj_read_end(void *pool, unsigned long handle,
+				  void *handle_mem)
+{
+	zs_obj_read_end(pool, handle, handle_mem);
+}
+
+static void zs_zpool_obj_write(void *pool, unsigned long handle,
+			       void *handle_mem, size_t mem_len)
+{
+	zs_obj_write(pool, handle, handle_mem, mem_len);
+}
+
 static u64 zs_zpool_total_pages(void *pool)
 {
 	return zs_get_total_pages(pool);
@@ -522,6 +540,9 @@ static struct zpool_driver zs_zpool_driver = {
 	.free =			  zs_zpool_free,
 	.map =			  zs_zpool_map,
 	.unmap =		  zs_zpool_unmap,
+	.obj_read_begin =	  zs_zpool_obj_read_begin,
+	.obj_read_end  =	  zs_zpool_obj_read_end,
+	.obj_write =		  zs_zpool_obj_write,
 	.total_pages =		  zs_zpool_total_pages,
 };
 
-- 
2.48.1.711.g2feabab25a-goog


