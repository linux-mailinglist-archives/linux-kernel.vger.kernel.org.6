Return-Path: <linux-kernel+bounces-284528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47849501F0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C2D1F22906
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B5219ADA4;
	Tue, 13 Aug 2024 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gB7aL9K8"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9EE19AD6C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543401; cv=none; b=nfHb0z10xhfbLrvZcgivtbi5N1MiIaGco4ccgWBTLKW4EWvLK3HR5rGcQKQzIcPP+WAkt7F0YBKpTfbbhLXp3k/mLIXWdo67WiqpoGV2SoH+ZS1PLqU1TaNTyp1VMWYKMIeNy9cX4tcMZqdIt9hEESJDw3BaWSNFgbFje5BEcUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543401; c=relaxed/simple;
	bh=ZaRZPIKMb9tT1bgJXnZN+jAzi+AtsUj/jTsR+EdbRoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gv2oe8XuKp0IiSQyh3cmG0MH8Mq9AooWkL4AcsLRCnY4LWoMNLA8d9kgyr3fc7VrrVhxyeCfICyROVgjTMbJcKFoDK9BzkOGih49InR2orERsRzeXBH3lFQZO94QGMNOh/vMAtWHpZzB4hRU7X9l4D4dzKwFv/bnt0rgLNBGwzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gB7aL9K8; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7b594936e9bso3618033a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723543399; x=1724148199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NoxN63bBPaM/wCd8ZvlEoxvS8xfn7jCuCDDPzEXx9AA=;
        b=gB7aL9K8rxT92KTPA0kUHFxVnq8g92F1/0AKw6e+zNZQ1SNqtgs+5iCbJPK89PagJa
         YQF478bmuSxDbkLlx5Qq1QqS0aH740VuEc7k8iTU5Yrjj61C/lmA74GZIHLWGEM+7FuR
         AA1zaADBs8Ye7lXJUM/vy2HwYIvJ9E2jt4A3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723543399; x=1724148199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NoxN63bBPaM/wCd8ZvlEoxvS8xfn7jCuCDDPzEXx9AA=;
        b=qu0DwLxToDmfChSEtpUKzMSapotao7E3g1/6EPpml+UnhpB/5cHYA/gBn6ovw/GdKc
         G2EWRwhK89OBHN9Ru9ODzZLdOjegmir3P8qUkq0tlPvzQxAuC8qfp8rYQNFMznyCiDu7
         f1py4dXfuiCyllIig6/Hs0VKlc7Poyorws1ivJpnqFxeEaBqBq7ioc1vf0t/ri48Y2Ju
         Rr8Ohlk0P8fLC2sUOoAKZV5kAWs8bEQpyH/W+DVwG77spGX849b1G9UzmJgfwmj8LT5K
         4ONGhv8qZzVyV8/cU6pytlPWRoK5Xr7tpWwEkqhTtBdmH3OAHoHbycGt6xrZocf5qhm2
         usBw==
X-Forwarded-Encrypted: i=1; AJvYcCXifcconW6SJpQ9PoNlSWIB9qMYGn6gy8+2Y1Qz9YabYIxHARHpwcQE5291oXQ5XcyE/IB9MPJUxREBvB/9CslzROruccxQJBqefhdg
X-Gm-Message-State: AOJu0YyMlmGDyD7TVQmcDER97L3CidedC9uB32wWpNMgkGO5+P6JxBe2
	b/BGXagztnZkJRBVt3looM9pL7QEjt7wd75Y5N5xCspplwpJDBbePVf1TEWg
X-Google-Smtp-Source: AGHT+IFosWR7zkd7jgDT2HviKT6vEjybZ5RhsLylZWQSu4p1a07i1ADAXGsNcDrKZxIxqrj/LlkKPw==
X-Received: by 2002:a05:6a20:96c8:b0:1c8:d7b7:dcbd with SMTP id adf61e73a8af0-1c8d7b7dcf2mr2811688637.1.1723543399534;
        Tue, 13 Aug 2024 03:03:19 -0700 (PDT)
Received: from localhost (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7c697a549d8sm944650a12.67.2024.08.13.03.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 03:03:18 -0700 (PDT)
From: Takaya Saeki <takayas@chromium.org>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Junichi Uekawa <uekawa@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Takaya Saeki <takayas@chromium.org>
Subject: [PATCH v3] filemap: add trace events for get_pages, map_pages, and fault
Date: Tue, 13 Aug 2024 10:03:12 +0000
Message-ID: <20240813100312.3930505-1-takayas@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow precise tracking of page caches accessed, add new tracepoints
that trigger when a process actually accesses them.

The ureadahead program used by ChromeOS traces the disk access of
programs as they start up at boot up. It uses mincore(2) or the
'mm_filemap_add_to_page_cache' trace event to accomplish this. It stores
this information in a "pack" file and on subsequent boots, it will read
the pack file and call readahead(2) on the information so that disk
storage can be loaded into RAM before the applications actually need it.

A problem we see is that due to the kernel's readahead algorithm that
can aggressively pull in more data than needed (to try and accomplish
the same goal) and this data is also recorded. The end result is that
the pack file contains a lot of pages on disk that are never actually
used. Calling readahead(2) on these unused pages can slow down the
system boot up times.

To solve this, add 3 new trace events, get_pages, map_pages, and fault.
These will be used to trace the pages are not only pulled in from disk,
but are actually used by the application. Only those pages will be
stored in the pack file, and this helps out the performance of boot up.

With the combination of these 3 new trace events and
mm_filemap_add_to_page_cache, we observed a reduction in the pack file
by 7.3% - 20% on ChromeOS varying by device.

Signed-off-by: Takaya Saeki <takayas@chromium.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changelog between v3 and v2
- Use a range notation in the printf format 

Changelog between v2 and v1
- Fix a file offset type usage by casting pgoff_t to loff_t
- Fix format string of dev and inode

 include/trace/events/filemap.h | 84 ++++++++++++++++++++++++++++++++++
 mm/filemap.c                   |  4 ++
 2 files changed, 88 insertions(+)

V2:https://lore.kernel.org/all/20240620161903.3176859-1-takayas@chromium.org/
V1:https://lore.kernel.org/all/20240618093656.1944210-1-takayas@chromium.org/

diff --git a/include/trace/events/filemap.h b/include/trace/events/filemap.h
index 46c89c1e460c..f48fe637bfd2 100644
--- a/include/trace/events/filemap.h
+++ b/include/trace/events/filemap.h
@@ -56,6 +56,90 @@ DEFINE_EVENT(mm_filemap_op_page_cache, mm_filemap_add_to_page_cache,
 	TP_ARGS(folio)
 	);
 
+DECLARE_EVENT_CLASS(mm_filemap_op_page_cache_range,
+
+	TP_PROTO(
+		struct address_space *mapping,
+		pgoff_t index,
+		pgoff_t last_index
+	),
+
+	TP_ARGS(mapping, index, last_index),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, i_ino)
+		__field(dev_t, s_dev)
+		__field(unsigned long, index)
+		__field(unsigned long, last_index)
+	),
+
+	TP_fast_assign(
+		__entry->i_ino = mapping->host->i_ino;
+		if (mapping->host->i_sb)
+			__entry->s_dev =
+				mapping->host->i_sb->s_dev;
+		else
+			__entry->s_dev = mapping->host->i_rdev;
+		__entry->index = index;
+		__entry->last_index = last_index;
+	),
+
+	TP_printk(
+		"dev=%d:%d ino=%lx ofs=%lld-%lld",
+		MAJOR(__entry->s_dev),
+		MINOR(__entry->s_dev), __entry->i_ino,
+		((loff_t)__entry->index) << PAGE_SHIFT,
+		((((loff_t)__entry->last_index + 1) << PAGE_SHIFT) - 1)
+	)
+);
+
+DEFINE_EVENT(mm_filemap_op_page_cache_range, mm_filemap_get_pages,
+	TP_PROTO(
+		struct address_space *mapping,
+		pgoff_t index,
+		pgoff_t last_index
+	),
+	TP_ARGS(mapping, index, last_index)
+);
+
+DEFINE_EVENT(mm_filemap_op_page_cache_range, mm_filemap_map_pages,
+	TP_PROTO(
+		struct address_space *mapping,
+		pgoff_t index,
+		pgoff_t last_index
+	),
+	TP_ARGS(mapping, index, last_index)
+);
+
+TRACE_EVENT(mm_filemap_fault,
+	TP_PROTO(struct address_space *mapping, pgoff_t index),
+
+	TP_ARGS(mapping, index),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, i_ino)
+		__field(dev_t, s_dev)
+		__field(unsigned long, index)
+	),
+
+	TP_fast_assign(
+		__entry->i_ino = mapping->host->i_ino;
+		if (mapping->host->i_sb)
+			__entry->s_dev =
+				mapping->host->i_sb->s_dev;
+		else
+			__entry->s_dev = mapping->host->i_rdev;
+		__entry->index = index;
+	),
+
+	TP_printk(
+		"dev=%d:%d ino=%lx ofs=%lld",
+		MAJOR(__entry->s_dev),
+		MINOR(__entry->s_dev), __entry->i_ino,
+		((loff_t)__entry->index) << PAGE_SHIFT
+	)
+);
+
 TRACE_EVENT(filemap_set_wb_err,
 		TP_PROTO(struct address_space *mapping, errseq_t eseq),
 
diff --git a/mm/filemap.c b/mm/filemap.c
index d62150418b91..925eef5e16f0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2556,6 +2556,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 			goto err;
 	}
 
+	trace_mm_filemap_get_pages(mapping, index, last_index);
 	return 0;
 err:
 	if (err < 0)
@@ -3287,6 +3288,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	if (unlikely(index >= max_idx))
 		return VM_FAULT_SIGBUS;
 
+	trace_mm_filemap_fault(mapping, index);
+
 	/*
 	 * Do we have something in the page cache already?
 	 */
@@ -3653,6 +3656,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);
 	add_mm_counter(vma->vm_mm, folio_type, rss);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	trace_mm_filemap_map_pages(mapping, start_pgoff, end_pgoff);
 out:
 	rcu_read_unlock();
 
-- 
2.46.0.76.ge559c4bf1a-goog


