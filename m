Return-Path: <linux-kernel+bounces-403260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F282B9C3335
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 16:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834D91F214A1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 15:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EB7159209;
	Sun, 10 Nov 2024 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jDTXabpf"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC38158208
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731252570; cv=none; b=HqhdAidESNrq58qb2aWMF87aIPXxn/9baZrkPJjwMtbfKiLea4tgdBuiJ6+wgBLbHOqDl5uZKx81n4eeObwx6KKgq25UZLaxAaa1kkbqzeWK+ZKqFo6VJADuS7K14eUIoo8DJ1NOYjTovpe2ieI6eEEj/LUv5j9+oK0/m38ib9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731252570; c=relaxed/simple;
	bh=DvOUyhYLGoxN2Hc3acnkKQpks6bE7rAJDoBJQe3HSFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXJsJS5RS5TYJlg3YCaF4Srw2UGLFNr6MNo+L4FIJuZrSp2hTc7Y4ty+DvWM5fj95WqtddqzuIGmbsJr1vd08vnEPkINtV6rdlr8qUjXHskFvKX0zUA3DEAWrqMTlhVmJwFm4CTNtm1IepnzAX0oywgc3nwrLatOnyLeQXs+Ikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jDTXabpf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20e6981ca77so42845775ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 07:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731252568; x=1731857368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6ru6+H4oQlmjhy4ZS59TJ0rgrpyxDTaEbRj/Vr+gBQ=;
        b=jDTXabpfNmkfTfN2pKKft5LnVS8ofQE3fRSSULoPO1MAPz4TIQ+PKVaf7z0nIi0kSO
         KvragGR9eX+cguqb+WAeeso1/5o2cWWY6UyU6Hx6wZA3vNGcq5XOUR/iWOTYfYhABKvp
         KZRFEfWMokybmbHgkrKIRLqw4ChQvepExYoYND9RJ9OnCER2tIexck99O/ZvAZTa3Buc
         CPoGYkOnUEoEx4kbQ1ir7xeL0g3xVNL0S/AmGa9T8ktMxatRNVoDfc1jW0R2MtFnEErs
         rOxpD/plCD7khf76VgDabfo57/lzrl+xXlCt+c8ofJpdhN2AswS/fI/cAQJjgbAuqfv2
         gsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731252568; x=1731857368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6ru6+H4oQlmjhy4ZS59TJ0rgrpyxDTaEbRj/Vr+gBQ=;
        b=PosRisWisVHd7nav/MnCqyWyW/Zrn/fe5T5UmTf0vKZDGHxB11Wyv0r9N3sPQwKKlg
         2TmI2UafkReB3c/ExWtCxvD9msXWm4BQv9LJJ0hHGwdUptRNVvXawa+ym0agopcQ5SK0
         BiNTmFPA90hdirRim4JL/ZgOtz6gDwdMq79kWRguDiXPQQd8EY1EIvUcT+R2+JA5AHB0
         JshTx3J+xWfHZrPkMYdNM7tzGDcSzb/Jhh2MhJt0GSL4zumPtyZ14/hPJfNfTvawmZXw
         hRjIOSxUGigLO8TIrfEhKDhu92sRzE91y0gaT2zZR62kFlIWaLXi0Gv5Rl0xt19BizzR
         zmSw==
X-Forwarded-Encrypted: i=1; AJvYcCUXtptQ/U6c1UKaUslNoW9IUpNW1awHNAedQNeqMrhuTEOaVUqJ1NTcrA03HbmkA9gu4oCE9Qy6LK8IqTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOpYU8Tp9llqW8PzgPYO5p5oiog1Hs0qeOLpxYgR3zcGSZghqb
	7oJQDBVHMPYeG3iDn1KdS6f497hKow5oaOGlOjXBsCPiLlY6wDAOcLC7O4QRsLI=
X-Google-Smtp-Source: AGHT+IEOVFhFei02kQq1ltQWyF+j1C3XIjJZGZV1LAM2AT1TQ/js4+EAJqEYuNTXGh31ae8isAOkHA==
X-Received: by 2002:a17:903:2391:b0:20c:b274:34d0 with SMTP id d9443c01a7336-211835d19e6mr136506735ad.46.1731252568109;
        Sun, 10 Nov 2024 07:29:28 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f935dsm9940973a91.35.2024.11.10.07.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:29:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/15] mm/filemap: make buffered writes work with RWF_UNCACHED
Date: Sun, 10 Nov 2024 08:28:02 -0700
Message-ID: <20241110152906.1747545-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110152906.1747545-1-axboe@kernel.dk>
References: <20241110152906.1747545-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If RWF_UNCACHED is set for a write, mark new folios being written with
uncached. This is done by passing in the fact that it's an uncached write
through the folio pointer. We can only get there when IOCB_UNCACHED was
allowed, which can only happen if the file system opts in. Opting in means
they need to check for the LSB in the folio pointer to know if it's an
uncached write or not. If it is, then FGP_UNCACHED should be used if
creating new folios is necessary.

Uncached writes will drop any folios they create upon writeback
completion, but leave folios that may exist in that range alone. Since
->write_begin() doesn't currently take any flags, and to avoid needing
to change the callback kernel wide, use the foliop being passed in to
->write_begin() to signal if this is an uncached write or not. File
systems can then use that to mark newly created folios as uncached.

Add a helper, generic_uncached_write(), that generic_file_write_iter()
calls upon successful completion of an uncached write.

This provides similar benefits to using RWF_UNCACHED with reads. Testing
buffered writes on 32 files:

writing bs 65536, uncached 0
  1s: 196035MB/sec, MB=196035
  2s: 132308MB/sec, MB=328147
  3s: 132438MB/sec, MB=460586
  4s: 116528MB/sec, MB=577115
  5s: 103898MB/sec, MB=681014
  6s: 108893MB/sec, MB=789907
  7s: 99678MB/sec, MB=889586
  8s: 106545MB/sec, MB=996132
  9s: 106826MB/sec, MB=1102958
 10s: 101544MB/sec, MB=1204503
 11s: 111044MB/sec, MB=1315548
 12s: 124257MB/sec, MB=1441121
 13s: 116031MB/sec, MB=1557153
 14s: 114540MB/sec, MB=1671694
 15s: 115011MB/sec, MB=1786705
 16s: 115260MB/sec, MB=1901966
 17s: 116068MB/sec, MB=2018034
 18s: 116096MB/sec, MB=2134131

where it's quite obvious where the page cache filled, and performance
dropped from to about half of where it started, settling in at around
115GB/sec. Meanwhile, 32 kswapds were running full steam trying to
reclaim pages.

Running the same test with uncached buffered writes:

writing bs 65536, uncached 1
  1s: 198974MB/sec
  2s: 189618MB/sec
  3s: 193601MB/sec
  4s: 188582MB/sec
  5s: 193487MB/sec
  6s: 188341MB/sec
  7s: 194325MB/sec
  8s: 188114MB/sec
  9s: 192740MB/sec
 10s: 189206MB/sec
 11s: 193442MB/sec
 12s: 189659MB/sec
 13s: 191732MB/sec
 14s: 190701MB/sec
 15s: 191789MB/sec
 16s: 191259MB/sec
 17s: 190613MB/sec
 18s: 191951MB/sec

and the behavior is fully predictable, performing the same throughout
even after the page cache would otherwise have fully filled with dirty
data. It's also about 65% faster, and using half the CPU of the system
compared to the normal buffered write.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 29 +++++++++++++++++++++++++++++
 mm/filemap.c            | 26 +++++++++++++++++++++++---
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0122b3fbe2ac..5469664f66c3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -14,6 +14,7 @@
 #include <linux/gfp.h>
 #include <linux/bitops.h>
 #include <linux/hardirq.h> /* for in_interrupt() */
+#include <linux/writeback.h>
 #include <linux/hugetlb_inline.h>
 
 struct folio_batch;
@@ -70,6 +71,34 @@ static inline int filemap_write_and_wait(struct address_space *mapping)
 	return filemap_write_and_wait_range(mapping, 0, LLONG_MAX);
 }
 
+/*
+ * generic_uncached_write - start uncached writeback
+ * @iocb: the iocb that was written
+ * @written: the amount of bytes written
+ *
+ * When writeback has been handled by write_iter, this helper should be called
+ * if the file system supports uncached writes. If %IOCB_UNCACHED is set, it
+ * will kick off writeback for the specified range.
+ */
+static inline void generic_uncached_write(struct kiocb *iocb, ssize_t written)
+{
+	if (iocb->ki_flags & IOCB_UNCACHED) {
+		struct address_space *mapping = iocb->ki_filp->f_mapping;
+
+		/* kick off uncached writeback */
+		__filemap_fdatawrite_range(mapping, iocb->ki_pos,
+					   iocb->ki_pos + written, WB_SYNC_NONE);
+	}
+}
+
+/*
+ * Value passed in to ->write_begin() if IOCB_UNCACHED is set for the write,
+ * and the ->write_begin() handler on a file system supporting FOP_UNCACHED
+ * must check for this and pass FGP_UNCACHED for folio creation.
+ */
+#define foliop_uncached			((struct folio *) 0xfee1c001)
+#define foliop_is_uncached(foliop)	(*(foliop) == foliop_uncached)
+
 /**
  * filemap_set_wb_err - set a writeback error on an address_space
  * @mapping: mapping in which to set writeback error
diff --git a/mm/filemap.c b/mm/filemap.c
index efd02b047541..cfbfc8b14b1f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -430,6 +430,7 @@ int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
 
 	return filemap_fdatawrite_wbc(mapping, &wbc);
 }
+EXPORT_SYMBOL_GPL(__filemap_fdatawrite_range);
 
 static inline int __filemap_fdatawrite(struct address_space *mapping,
 	int sync_mode)
@@ -1609,7 +1610,14 @@ static void folio_end_uncached(struct folio *folio)
 {
 	bool reset = true;
 
-	if (folio_trylock(folio)) {
+	/*
+	 * Hitting !in_task() should not happen off RWF_UNCACHED writeback, but
+	 * can happen if normal writeback just happens to find dirty folios
+	 * that were created as part of uncached writeback, and that writeback
+	 * would otherwise not need non-IRQ handling. Just skip the
+	 * invalidation in that case.
+	 */
+	if (in_task() && folio_trylock(folio)) {
 		reset = !invalidate_complete_folio2(folio->mapping, folio, 0);
 		folio_unlock(folio);
 	}
@@ -4061,7 +4069,7 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 	ssize_t written = 0;
 
 	do {
-		struct folio *folio;
+		struct folio *folio = NULL;
 		size_t offset;		/* Offset into folio */
 		size_t bytes;		/* Bytes to write to folio */
 		size_t copied;		/* Bytes copied from user */
@@ -4089,6 +4097,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
+		/*
+		 * If IOCB_UNCACHED is set here, we now the file system
+		 * supports it. And hence it'll know to check folip for being
+		 * set to this magic value. If so, it's an uncached write.
+		 * Whenever ->write_begin() changes prototypes again, this
+		 * can go away and just pass iocb or iocb flags.
+		 */
+		if (iocb->ki_flags & IOCB_UNCACHED)
+			folio = foliop_uncached;
+
 		status = a_ops->write_begin(file, mapping, pos, bytes,
 						&folio, &fsdata);
 		if (unlikely(status < 0))
@@ -4219,8 +4237,10 @@ ssize_t generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ret = __generic_file_write_iter(iocb, from);
 	inode_unlock(inode);
 
-	if (ret > 0)
+	if (ret > 0) {
+		generic_uncached_write(iocb, ret);
 		ret = generic_write_sync(iocb, ret);
+	}
 	return ret;
 }
 EXPORT_SYMBOL(generic_file_write_iter);
-- 
2.45.2


