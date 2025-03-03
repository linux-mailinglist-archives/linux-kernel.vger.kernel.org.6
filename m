Return-Path: <linux-kernel+bounces-540886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F386A4B615
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6FC16C12D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014651D517E;
	Mon,  3 Mar 2025 02:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q9hyLQMB"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E01D1E51F5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968745; cv=none; b=mRTk6hTCnL5OsOcGmrOozuUhAR32DWdELiiZKdWpbPrBlst49nz4Z7ZznoLDKoGlI0M4bReswrO6wKDArXkndJemtMa80YMnXiYSeyv0EbF3aCyBKkrIZBlTmRVzLJnGP7FogOW5D2l+9BSbFyoa1OEUkKYske2IYu8aEH5jhiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968745; c=relaxed/simple;
	bh=3iFieOUYn4iqBiRwGHIpWNqgK/MF7aWW1jnWLFdMd18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0yKbqTetdU/TtibGzyI2QDTMFfuhZAF8QOF0wKu5G+/alHUYNneTfR0TEQ/0m+UKKBfzuxATfR8mUg55L3h0oVtKNgOmyP1aU+lmxi8ecvuvhBCCxfhwLDi32i0ZZxE553cf3xqiysEVqRua+wNDXvi5aXZngs/fryMoMla6ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q9hyLQMB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223a3c035c9so9000995ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740968743; x=1741573543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmmGIMp09Xa9+ajjYrlkAeQFbd0l0inskGKz/hBM/Wo=;
        b=Q9hyLQMBz2vaE4DoH0SR7wV8R1Gvuqc9ctvxkhjuQ7vT1v5TI23ZFUcpOky7dKmO1y
         RBWeBBBG9vNAUmmyiCcFc3G4F2liQbeuH0rkXI3+EqPU69/E6vSmHv/zwD7ioc5xhO4j
         GS7AnxPr4dEdqtF94y6wZzf0Wm9U2IfLsplUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740968743; x=1741573543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmmGIMp09Xa9+ajjYrlkAeQFbd0l0inskGKz/hBM/Wo=;
        b=RKzg3X5OlMa6RfPp/I4jbKN01jT/Fhn83YznkhlixIDKD21PMgTW+WCOUtE73NMm2L
         LBNvzNCZmR0S20V6QL3aJdm79VdS9MAsc3C3sTZRIlejRYnFMvGT7qYSCF+eVJKN10MT
         PI71oB8amirVEZE0738IH8Qz4oebVmFhlMGembct07lLg03aK118w4/WJydkU5bT32+x
         qi6MNcEVNBPHHj9Dyf2seiQvRp589I0QpBQ68Vf1rr3oh5NMUoEp/M6UAYbs3UOSrysY
         35oQrHpugie4ebfPOq5JZxSVNVFb3+cGKqEDqZzk5twJuWHTbbTWFffmYWb+alwcDvCT
         eG6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVxnRe+BOl1PnMBoCr8pl2y7bQmoegxQ03hYJ9Dv1Ak7MipulZbt3fWB8mF1VKxHOZq57XDLaB4BUa1eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQkiYh0UzSeY9z6h7WXBtKFSIwu80PrRNSvHaqgC5iHEMNGe70
	HKoa0hu4P+LHT1JbG17SFzA9We8pGolKSDTgEEjJZqT9pjNtqKwF6wwPM2KwHQ==
X-Gm-Gg: ASbGnctZnwzyoBoYE8DujTXsHnxSJgIWzj7Erbr2DAYbNEJvhkMvs8mYP+ghvBFXhlU
	ZNHS6TBEoDtP9jGnuG7sI1n4VvZcFQTPzyc9sr2uR3G5wpJSrBVnRWtW39a+kc50ejyfq+k9y1r
	GWrpla/qBx23SJcYw3+yGKSmz7UsexuFHfD58oy3UrdK+rPkLCDlhY3y2zraPi7E94tNrTa4Pyg
	Rchgv+Uzyj6Y2Vpk/ZdAciA7uZniRSQlAuMC0w6K3PAr/4ZsfaA7jFQsup5cW82L273quOxk7SD
	LdznxTvuTgJjxPHowukYvj0k0bMN1IFc0Aics31RheoVvdY=
X-Google-Smtp-Source: AGHT+IE+JByFLuBtDUrc5bcjQDL8kXzJ75Xakggo0iV8YwzjqWoQMMXMd+ywhB7PLbJgopN3ZGVCPQ==
X-Received: by 2002:a17:902:e84e:b0:21f:6f33:f96 with SMTP id d9443c01a7336-2234a188d50mr267570275ad.6.1740968742708;
        Sun, 02 Mar 2025 18:25:42 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1513:4f61:a4d3:b418])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22350533a10sm67008045ad.247.2025.03.02.18.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 18:25:42 -0800 (PST)
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
Subject: [PATCH v10 14/19] zsmalloc: introduce new object mapping API
Date: Mon,  3 Mar 2025 11:03:23 +0900
Message-ID: <20250303022425.285971-15-senozhatsky@chromium.org>
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

Current object mapping API is a little cumbersome.  First, it's
inconsistent, sometimes it returns with page-faults disabled and
sometimes with page-faults enabled.  Second, and most importantly,
it enforces atomicity restrictions on its users.  zs_map_object()
has to return a liner object address which is not always possible
because some objects span multiple physical (non-contiguous)
pages.  For such objects zsmalloc uses a per-CPU buffer to which
object's data is copied before a pointer to that per-CPU buffer
is returned back to the caller.  This leads to another, final,
issue - extra memcpy().  Since the caller gets a pointer to
per-CPU buffer it can memcpy() data only to that buffer, and
during zs_unmap_object() zsmalloc will memcpy() from that per-CPU
buffer to physical pages that object in question spans across.

New API splits functions by access mode:
- zs_obj_read_begin(handle, local_copy)
  Returns a pointer to handle memory.  For objects that span two
  physical pages a local_copy buffer is used to store object's
  data before the address is returned to the caller.  Otherwise
  the object's page is kmap_local mapped directly.

- zs_obj_read_end(handle, buf)
  Unmaps the page if it was kmap_local mapped by zs_obj_read_begin().

- zs_obj_write(handle, buf, len)
  Copies len-bytes from compression buffer to handle memory
  (takes care of objects that span two pages).  This does not
  need any additional (e.g. per-CPU) buffers and writes the data
  directly to zsmalloc pool pages.

In terms of performance, on a synthetic and completely reproducible
test that allocates fixed number of objects of fixed sizes and
iterates over those objects, first mapping in RO then in RW mode:

OLD API
=======

3 first results out of 10

  369,205,778      instructions        #    0.80  insn per cycle
   40,467,926      branches            #  113.732 M/sec

  369,002,122      instructions        #    0.62  insn per cycle
   40,426,145      branches            #  189.361 M/sec

  369,036,706      instructions        #    0.63  insn per cycle
   40,430,860      branches            #  204.105 M/sec

[..]

NEW API
=======

3 first results out of 10

  265,799,293      instructions        #    0.51  insn per cycle
   29,834,567      branches            #  170.281 M/sec

  265,765,970      instructions        #    0.55  insn per cycle
   29,829,019      branches            #  161.602 M/sec

  265,764,702      instructions        #    0.51  insn per cycle
   29,828,015      branches            #  189.677 M/sec

[..]

T-test on all 10 runs
=====================

Difference at 95.0% confidence
   -1.03219e+08 +/- 55308.7
   -27.9705% +/- 0.0149878%
   (Student's t, pooled s = 58864.4)

The old API will stay around until the remaining users switch
to the new one.  After that we'll also remove zsmalloc per-CPU
buffer and CPU hotplug handling.

The split of map(RO) and map(WO) into read_{begin/end}/write is
suggested by Yosry Ahmed.

Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 include/linux/zsmalloc.h |   8 +++
 mm/zsmalloc.c            | 125 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index a48cd0ffe57d..7d70983cf398 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -58,4 +58,12 @@ unsigned long zs_compact(struct zs_pool *pool);
 unsigned int zs_lookup_class_index(struct zs_pool *pool, unsigned int size);
 
 void zs_pool_stats(struct zs_pool *pool, struct zs_pool_stats *stats);
+
+void *zs_obj_read_begin(struct zs_pool *pool, unsigned long handle,
+			void *local_copy);
+void zs_obj_read_end(struct zs_pool *pool, unsigned long handle,
+		     void *handle_mem);
+void zs_obj_write(struct zs_pool *pool, unsigned long handle,
+		  void *handle_mem, size_t mem_len);
+
 #endif
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index afbd72363731..7566070729ee 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1362,6 +1362,131 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 }
 EXPORT_SYMBOL_GPL(zs_unmap_object);
 
+void *zs_obj_read_begin(struct zs_pool *pool, unsigned long handle,
+			void *local_copy)
+{
+	struct zspage *zspage;
+	struct zpdesc *zpdesc;
+	unsigned long obj, off;
+	unsigned int obj_idx;
+	struct size_class *class;
+	void *addr;
+
+	/* Guarantee we can get zspage from handle safely */
+	read_lock(&pool->lock);
+	obj = handle_to_obj(handle);
+	obj_to_location(obj, &zpdesc, &obj_idx);
+	zspage = get_zspage(zpdesc);
+
+	/* Make sure migration doesn't move any pages in this zspage */
+	zspage_read_lock(zspage);
+	read_unlock(&pool->lock);
+
+	class = zspage_class(pool, zspage);
+	off = offset_in_page(class->size * obj_idx);
+
+	if (off + class->size <= PAGE_SIZE) {
+		/* this object is contained entirely within a page */
+		addr = kmap_local_zpdesc(zpdesc);
+		addr += off;
+	} else {
+		size_t sizes[2];
+
+		/* this object spans two pages */
+		sizes[0] = PAGE_SIZE - off;
+		sizes[1] = class->size - sizes[0];
+		addr = local_copy;
+
+		memcpy_from_page(addr, zpdesc_page(zpdesc),
+				 off, sizes[0]);
+		zpdesc = get_next_zpdesc(zpdesc);
+		memcpy_from_page(addr + sizes[0],
+				 zpdesc_page(zpdesc),
+				 0, sizes[1]);
+	}
+
+	if (!ZsHugePage(zspage))
+		addr += ZS_HANDLE_SIZE;
+
+	return addr;
+}
+EXPORT_SYMBOL_GPL(zs_obj_read_begin);
+
+void zs_obj_read_end(struct zs_pool *pool, unsigned long handle,
+		     void *handle_mem)
+{
+	struct zspage *zspage;
+	struct zpdesc *zpdesc;
+	unsigned long obj, off;
+	unsigned int obj_idx;
+	struct size_class *class;
+
+	obj = handle_to_obj(handle);
+	obj_to_location(obj, &zpdesc, &obj_idx);
+	zspage = get_zspage(zpdesc);
+	class = zspage_class(pool, zspage);
+	off = offset_in_page(class->size * obj_idx);
+
+	if (off + class->size <= PAGE_SIZE) {
+		if (!ZsHugePage(zspage))
+			off += ZS_HANDLE_SIZE;
+		handle_mem -= off;
+		kunmap_local(handle_mem);
+	}
+
+	zspage_read_unlock(zspage);
+}
+EXPORT_SYMBOL_GPL(zs_obj_read_end);
+
+void zs_obj_write(struct zs_pool *pool, unsigned long handle,
+		  void *handle_mem, size_t mem_len)
+{
+	struct zspage *zspage;
+	struct zpdesc *zpdesc;
+	unsigned long obj, off;
+	unsigned int obj_idx;
+	struct size_class *class;
+
+	/* Guarantee we can get zspage from handle safely */
+	read_lock(&pool->lock);
+	obj = handle_to_obj(handle);
+	obj_to_location(obj, &zpdesc, &obj_idx);
+	zspage = get_zspage(zpdesc);
+
+	/* Make sure migration doesn't move any pages in this zspage */
+	zspage_read_lock(zspage);
+	read_unlock(&pool->lock);
+
+	class = zspage_class(pool, zspage);
+	off = offset_in_page(class->size * obj_idx);
+
+	if (off + class->size <= PAGE_SIZE) {
+		/* this object is contained entirely within a page */
+		void *dst = kmap_local_zpdesc(zpdesc);
+
+		if (!ZsHugePage(zspage))
+			off += ZS_HANDLE_SIZE;
+		memcpy(dst + off, handle_mem, mem_len);
+		kunmap_local(dst);
+	} else {
+		/* this object spans two pages */
+		size_t sizes[2];
+
+		off += ZS_HANDLE_SIZE;
+		sizes[0] = PAGE_SIZE - off;
+		sizes[1] = mem_len - sizes[0];
+
+		memcpy_to_page(zpdesc_page(zpdesc), off,
+			       handle_mem, sizes[0]);
+		zpdesc = get_next_zpdesc(zpdesc);
+		memcpy_to_page(zpdesc_page(zpdesc), 0,
+			       handle_mem + sizes[0], sizes[1]);
+	}
+
+	zspage_read_unlock(zspage);
+}
+EXPORT_SYMBOL_GPL(zs_obj_write);
+
 /**
  * zs_huge_class_size() - Returns the size (in bytes) of the first huge
  *                        zsmalloc &size_class.
-- 
2.48.1.711.g2feabab25a-goog


