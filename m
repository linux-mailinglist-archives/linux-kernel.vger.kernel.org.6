Return-Path: <linux-kernel+bounces-535580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84218A474BF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DF916FD2A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADD722B8B6;
	Thu, 27 Feb 2025 04:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MZ97e1SA"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEF5227B8E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631071; cv=none; b=a+uTDJ40hAjHDMlcr2ihziGiNTQtrKMPJ4o8qH8QvtUxwicABnaFQrzH88z5H3wJJdf4MgEG64AnDwAs9ixOPWbp/5C2Hqf0DKqL8Ed9UsN99Jf1dubSG3fJ40S6xTvw1qOBsw8G68tIFGP3eAMm3zovOmFO4dEvOaAEH81jgdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631071; c=relaxed/simple;
	bh=YTxRDdOLOlPOoj4suLEt0fXJmIh58t2xvi+gw+BLvig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWKKuOLcFtJrkDNbIpFExTAOzqenJqsE5jN7I//TGq5pvMYe3Y3Nj8HDkJJwLCbKDylq+U3ZQOBmhrP69HGYI1ksALPqbPqr6u1v9SrdirOadN/VuRyQtRdyyvXnzNgqFc2yAPgP0BTo0OAOaYQWNnLMber7qOPF3BNOZyaAXSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MZ97e1SA; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fe98d173daso903499a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740631069; x=1741235869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBpeAJmv3dkwKu8bLvx37fcH2/07qN2DhOmgxltefRs=;
        b=MZ97e1SAxpLiSQkS/vcF2yXhoa2QfioFbyimJaJe4rwMBBjaTEGYzt86xhvH23X/ce
         lcF4tJIlLJFed7yVyo3X4JzBuQt3ykMm8RVGnbqD42yFzVqScv4YD2E14f3ih/W30ZsC
         dzEDiq/Ni7A1LW+OqenkHV8WcQHxko1eMIDck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631069; x=1741235869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBpeAJmv3dkwKu8bLvx37fcH2/07qN2DhOmgxltefRs=;
        b=RtZseg6F5Lo+iBw9uaIcNJGCA1IVaBYDc0bDTE9S9/zcqIgXY6fu33fyeta3rmKFhp
         AGP3QxzExmoS/8yRhNGXAEeqpLSAYZifANeXundtUeCN9Nx/inyojYKaIRCCVNEfwL0W
         TCnDG/yK0067mYyKqwFKmDIGhtiPZP4AXKSkR1MTVr+bioaf4GJ4AtPVS2VdRuBUF80w
         357bRxvC252/qy/jx9sDNa/LxrfojAxR4NnJunM3dK0uMQSaUmzsgpUCtjM6MifX8bm0
         mcnvJCOozJPVZddNrYGmP9gjiM0ipEAkc8479afpuIc/xDklbZ7Lqn3lSVzzhbED/EWb
         qSeg==
X-Forwarded-Encrypted: i=1; AJvYcCV4+AlJpL/DbSvaPaG+lPr8pvfMAVFwJZQ68Ew2Mt04pIcomDAZulSmoYcUB056fjbuUvJQIm0OuIJsuYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVp0B36hUcce8mlwoYNrXe3h7Vs7zPP/BrhsG1dos7mWgrNWl2
	A7QgWAWjpanf1jJHsF3sJx+vfMA1htFKFPIyZ1uXUAc8NEvgoakbHA5pTneReA==
X-Gm-Gg: ASbGncuaXWTJnyCoj5vF+lcSKM0FFmBiMCMfDCcuQE0+TfnYGu4/IJ/x0Bei/WZDQ9A
	XnO7tGhv6cT8eeoVI4UiR/90j9Qu0yX96mJBcIjaGiY6vOwp1ILdfeK8JxnZ5hhRTbQOZrSlzPE
	CrXM+6CUFzK7Qc7/5s/zsU0N1HnGaS8Ffq03kV+yEkzvGIMjxE49NoeUjGRmKAI2Ahx8SOM0bY1
	2gOCPUFyyBnBz/n15jWquEF/5Hvgq1j5tSRAhtv43hi4K/8EdLiy6rg+JqQLmHrRcUvjAFNrQ2a
	Oq+TP6Ja7IVT8SSzArc5v0lpmmBB
X-Google-Smtp-Source: AGHT+IGT9IFUdagZ07dcKsUPA3Ga8h0xkyUlcDu4WDHvdo9Rq1PU1sFyBt6xUxtOAdS37OHnC4HqBA==
X-Received: by 2002:a17:90a:f28e:b0:2fe:7fae:59f7 with SMTP id 98e67ed59e1d1-2fe7fae5c01mr9272618a91.33.1740631069336;
        Wed, 26 Feb 2025 20:37:49 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fe6ded6ebfsm4534899a91.1.2025.02.26.20.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 20:37:49 -0800 (PST)
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
Subject: [PATCH v9 14/19] zsmalloc: introduce new object mapping API
Date: Thu, 27 Feb 2025 13:35:32 +0900
Message-ID: <20250227043618.88380-15-senozhatsky@chromium.org>
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
index 74a7aaebf7a0..147915ba04f9 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1364,6 +1364,131 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
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
2.48.1.658.g4767266eb4-goog


