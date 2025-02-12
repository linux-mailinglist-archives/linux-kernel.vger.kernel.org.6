Return-Path: <linux-kernel+bounces-510580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAAEA31F0C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E851885FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7841FF5F9;
	Wed, 12 Feb 2025 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZTA+2Lrh"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120AC202C38
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341989; cv=none; b=aYwRrXXB4P0u7GEYzckJD2HnfplpCv4QrWNU1mYN27Q+Lq9DGdeNaRb2sHAGq4kpsMIT5ZDj0E5jpppdD59plODGs+5QmV2I3QCr2wjloZw55z0m2FGepKlkxxELNo7i1d6h7Yp4ncpOZ+ziQs7JR0eIG74c+LnfKKqh3ByZCA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341989; c=relaxed/simple;
	bh=MECIf4qWOwJd7TIEwrJXpz6WlwoNwT2TreIcypaxWhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIDZUruxg+wrfTi0KH6dv4scP+Pj7EwTgFYp6tdGKWrxSVlZOnAqFC9BBCjSgSprJkaHLYyZqf+C79c6N9FROZfecsxy3xoxZyNSU4Nsx8PIXSRyr5huNQmJaLMMifFheJUqT0bX7I2DjjumVcKG9lN8HUnJ4L4ptANyDZOxKgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZTA+2Lrh; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f9b91dff71so9788183a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739341987; x=1739946787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCEIYmpOSL5kMgSv8CIDbNXJeiLt2Oo14JvQ8JkkWQI=;
        b=ZTA+2LrhDixHxSDj7AMNJsRZ6De2gr00YKV1anoCApv5AFkxXDQqLkbKyclSg8n4/G
         KOKIVLqN54EKm63rTnqCjB96f2GTOkoHFft51FR7W86rmxl51ynSa2nrTT2toyBrpvTv
         Uh0HYyrEjsst155jNx0/mMwLMQapywnlh2798=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341987; x=1739946787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCEIYmpOSL5kMgSv8CIDbNXJeiLt2Oo14JvQ8JkkWQI=;
        b=qg1smVDaxAGy52eWaFYm5BhJvt7Hb2twaqnP4Sg0o/gr6/LGq1xOWJF3kYt38tPme+
         Y4R5NnUP5aLoPlSdIcWyeFE18X+Ha5l0cG2ZARKFhOgrckg3bapw61A+uHDilm7QCoUH
         HFGX4J2ppAARPCDz3JnGFH5yZo4KfNvD4YguRqh5ow+Ers7yl7+AIT2ILczj/KzILzzc
         s4fOAYdtHvZwheMQ9Z2Tv49zO4tz3S76AlrNCW9fD6MTczVr0FsEUAaElfWIBvsC+k5w
         I1AQWlbQLxQC9gb2WCMkkZZMF1DPUgzQ4yWBt1ik02Aqj89EfYB2r76dB/Fi1kUZ+TY1
         b0JA==
X-Forwarded-Encrypted: i=1; AJvYcCVTVbbBTR8oO6FYo1RGhKH+ie8wiaT5NVgXKID31CoPpzbsA/PmCE7k5296w7ljGKwLwpeni1KsJlzVxVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuPXBd1dGWL1O+fr9q6MmdSwSX61tYMag8thMFEStI0W5GFnrw
	Lkw59kTsRewSO2mOkX60DBkbSUl20EnlbtRfsdlK4vTvm1OGk5tjg6SwJyN4rw==
X-Gm-Gg: ASbGncv810djD0OCeOHQblqvW0rNMAM8LXGbIkToujIHf6YvX4RnWVBeyHgzpN4Cc3x
	wRoN18PMzW9fuo7Ks1XbaNM2LCtcOzYscUJMlq7JW+YVfEaN/hhxCR7x7dZM8k1lLHf9zR6PnZQ
	7yR79ZD7qjDHScuJmy3066xXDxPVpD/N+cwFYBhVrVrZsaiXSEXGgRDSVxAyWGKO2yqhywfFqjb
	b2sx/gUlucgX8dN+rOhdtRwXT3KEhcv46Y3B77tiv1l9CVDpJLma8zQoVYSBm4yOYUSZhR45D+Z
	C1SFmPzvK3cguYaDdQ==
X-Google-Smtp-Source: AGHT+IEcBz98pD8dO8lfqL3ofXePIyCx5p8Uf93CWTvB4grPFDM00/5pX1hnLpil/qbdFRArW8IpbA==
X-Received: by 2002:a17:90b:568d:b0:2ea:3f34:f18f with SMTP id 98e67ed59e1d1-2fbf5c0f4b5mr2776207a91.19.1739341987103;
        Tue, 11 Feb 2025 22:33:07 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fbf973c42esm672421a91.0.2025.02.11.22.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:33:06 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 13/18] zsmalloc: introduce new object mapping API
Date: Wed, 12 Feb 2025 15:27:11 +0900
Message-ID: <20250212063153.179231-14-senozhatsky@chromium.org>
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

10 runs

  369,205,778      instructions        #    0.80  insn per cycle
   40,467,926      branches            #  113.732 M/sec

  369,002,122      instructions        #    0.62  insn per cycle
   40,426,145      branches            #  189.361 M/sec

  369,036,706      instructions        #    0.63  insn per cycle
   40,430,860      branches            #  204.105 M/sec

[..]

NEW API
=======

10 runs

  265,799,293      instructions        #    0.51  insn per cycle
   29,834,567      branches            #  170.281 M/sec

  265,765,970      instructions        #    0.55  insn per cycle
   29,829,019      branches            #  161.602 M/sec

  265,764,702      instructions        #    0.51  insn per cycle
   29,828,015      branches            #  189.677 M/sec

[..]

Difference at 95.0% confidence
   -1.03219e+08 +/- 55308.7
   -27.9705% +/- 0.0149878%
   (Student's t, pooled s = 58864.4)

The old API will stay around until the remaining users switch
to the new one.  After that we'll also remove zsmalloc per-CPU
buffer and CPU hotplug handling.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 include/linux/zsmalloc.h |   8 +++
 mm/zsmalloc.c            | 129 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+)

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
index 80261bb78cf8..e40268f3b655 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1401,6 +1401,135 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
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
+	WARN_ON(in_interrupt());
+
+	/* Guarantee we can get zspage from handle safely */
+	pool_read_lock(pool);
+	obj = handle_to_obj(handle);
+	obj_to_location(obj, &zpdesc, &obj_idx);
+	zspage = get_zspage(zpdesc);
+
+	/* Make sure migration doesn't move any pages in this zspage */
+	zspage_read_lock(zspage);
+	pool_read_unlock(pool);
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
+	WARN_ON(in_interrupt());
+
+	/* Guarantee we can get zspage from handle safely */
+	pool_read_lock(pool);
+	obj = handle_to_obj(handle);
+	obj_to_location(obj, &zpdesc, &obj_idx);
+	zspage = get_zspage(zpdesc);
+
+	/* Make sure migration doesn't move any pages in this zspage */
+	zspage_read_lock(zspage);
+	pool_read_unlock(pool);
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
2.48.1.502.g6dc24dfdaf-goog


