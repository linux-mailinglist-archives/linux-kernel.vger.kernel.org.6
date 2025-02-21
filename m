Return-Path: <linux-kernel+bounces-526754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115EBA402B2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9FA0422869
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AC82566F6;
	Fri, 21 Feb 2025 22:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KX67ZnmT"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61F8253F06
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177078; cv=none; b=rGakscaidg4vIhJf+EfIE3UiidCtTZ1+dTfRBV82NO7U41qjTMKafLyhKBn2Rqgdw9nmAW2CiCEbNXy+yXnfETRqyLKoNcGL+Lafp5qvDMLrLm5SVQwqMgFZrxaiT2+foC4/g603pndy33db04/MykdoJ5pufFbjUGsc04vjP5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177078; c=relaxed/simple;
	bh=B3EuZId1pLxQ+KiaufEF+Lgw9NOgh39bt1XSz1og9Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKHTVLyQWd6GhcQuODo1u2BFkqCReEg5gJ+0r3WV5G2N7af+S7M6/0PK2u6ym5DWtXld5mA0eFs0sHauLIZzUkIAqhOdGkH/GwTwXaPV+Cv2xEpTzEU3pBlShJAYiDc29S3L3ioSvQcfC0ZtT853dBnnWCXsqXH/BTAssPlNuWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KX67ZnmT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2211cd4463cso54070065ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740177075; x=1740781875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bYokSfTdUfiI0Hj0uXPo6i1n2cRTGAJHVL2SxOfWWQ=;
        b=KX67ZnmTQe0NGh+7FnnMWpqf2Gav5jay3KPzkUdPCbt/2Jut+NKjwn0KTF7I82lonF
         08S69cVrUltuWvSLlpKqqbsoXrk1r0YIe6oZRRuUdQRDm+cFb8uKUti58ki59w8OE08b
         f35lP/HOI90uCuypLBRQxmO116UGY/Fu8lu80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740177075; x=1740781875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bYokSfTdUfiI0Hj0uXPo6i1n2cRTGAJHVL2SxOfWWQ=;
        b=jjo519ta4mzSnZcWNkDG6s1rBAgwbBeh1svcj3vgCZrbRW9G2uhV3yoO/1mlH/GaCz
         yqV6AE1lGB5mQcoeEM8HePCvRDEF5gIsdTMh0uDcx+Ddrl5kLRgXJgsoCXPCZynIFUZr
         IwlHlXWyttgPQOWTwBl4F5KEO75GlbmbED+Y0XPazEKEUaZxtvkOnrH9sP8lCS7392+K
         yRX9r3Ryan/rHKVEEdLv2A5NIsTP0r8PKY5J3p2G2b4hLj1xex0mocGnpW/p4Xg5GbVw
         PMw5EhkOIwzNYkRuYuHXeKbtInLtp3c/tWjLoOmlPiyec2w+Kn7blnVthH3oksTqeEb0
         0GVw==
X-Forwarded-Encrypted: i=1; AJvYcCWxBq91hIs/rTEyQqASOHZfFzFbmLocGrk6d/7yWXVIv/+W0zrxrLPKmjKhv7RjexW49/APHRvCWF2tiMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrIsC2eA9Y+oK38DeqtbLerWxiLWW+xalNvhaMkyHT3r4L0yHW
	gkECgax8urWRirzch17973aQXXvPBY6hC7EWTRJwpPrZpSTfvWzvbUU7DFMs42lk0Zk9cDctSCk
	=
X-Gm-Gg: ASbGnctfviyiUZXDI7U3UpNrTDTmr7h6fnpfUAaMLWfKuuF3eeB2A5AkLLoihjHXtOl
	QgIQzYnX2KIryAQd/rmJ4NC7rKXQvLkkWc59o1yZ2XiFWsac7Fr/+7GGoDUxobPRowZxiG5wFYn
	MZAfq7rm+dHwscMK9S0gxaEiw/lonbBfpwBNPSAF+PKHRdC0cMlnhP/hg9t/xf/1zJ71SM/cNfy
	rBPgaG+TUcLwEcEiQj2EWESdLZg1eLcWlk1Wzy+bTMplJocFzDzz6qFsrrmBNe31+G9M7J1pP47
	XgqxVN1EMNsWVcPZSij0grRjIP4=
X-Google-Smtp-Source: AGHT+IHgZKuXmy0HUVJX3N4A8fmolG1cpyf+MQMTUT8UUMyAXq6Z3SZOJ2I2KS9bokpF5ag/pOAYiA==
X-Received: by 2002:a17:903:8c5:b0:21f:4c8b:c514 with SMTP id d9443c01a7336-2219fffa9f3mr71842835ad.45.1740177075271;
        Fri, 21 Feb 2025 14:31:15 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22120093e41sm95374735ad.93.2025.02.21.14.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 14:31:14 -0800 (PST)
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
Subject: [PATCH v8 12/17] zsmalloc: introduce new object mapping API
Date: Sat, 22 Feb 2025 07:25:43 +0900
Message-ID: <20250221222958.2225035-13-senozhatsky@chromium.org>
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
index 03710d71d022..1288a4120855 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1377,6 +1377,135 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
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
+	WARN_ON(in_interrupt());
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
2.48.1.601.g30ceb7b040-goog


