Return-Path: <linux-kernel+bounces-429765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C859E284B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 189DFB674E7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9283F1F76AE;
	Tue,  3 Dec 2024 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="U5y+hE8A"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E0F204F84
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239979; cv=none; b=K0Mp7AkqkjtgrZnafwse8Rq7gPgvQdBTgEKLmqkG4AEWK7OtPy/p6ZAnP9CrdpCQkBa3j4GLeFwG0vJA6i1Mm5lztdSSZhWmKuQRL08V+x7M6QfXAQwoVPVpYrT4sXSLsRadnLVCQ/CDaE0MrQsisjwW0Mud9qSYtk4+EMpCLc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239979; c=relaxed/simple;
	bh=LUYFIqzYiNC8iDjcYjzRM/NzCPA2BcvlCTGVyApeMyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o08FJmCBs/4IfILxipcOgenysBz9Gh0DhKTOMNHPKx7HEjYHgyuFNaPEkSSQtSYz5LlK5stX2J8fmRSgu0lV5GP+F1GUz0+896s/cD4PV5IyeNxFcxouFcpCq5PI/z9jTzDoPjF36DBVqhMVMqc1mNX+0aLs7gnqq2Mdh94df7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=U5y+hE8A; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3ea68fc1a7cso2700767b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 07:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733239977; x=1733844777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=854g8zvMX205jFWe5CwR3kRcBo1TfCPiGvzDJnv2dMk=;
        b=U5y+hE8AlQ5RNTn1wvZKs/tYic8sjv4/RNNQaa6i4OIGS/hkyTlJsqcHVHm8gQKasG
         uQc1yxKexzBJUXxKM6+qwa7sl2c2c/eqF2yvp1x0Nfuz9seX1h1j4qsTluEBwxqdisVl
         S7KI2OpHt0VItCdaP1cnGq0lhnG2DxcXu9P8ClotpHeJcN5O4o9JUN9vgG6/hI9BDfza
         2h+ylaZur13T8T8Jd+2SngaZkG0PWAYuAS7me3Xq4IomLG+cOlx1rM52I5pW/3AuauG0
         bMfvd2DtFVfmc9lJazpc2CV9UeS2n3WzBba1I7DCHT9wNrfT9XBCYQZAZkRu51JmZSHh
         h9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239977; x=1733844777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=854g8zvMX205jFWe5CwR3kRcBo1TfCPiGvzDJnv2dMk=;
        b=oYZ0L6xLoXBnVk2RiFZQOvq6rl+Vkmh4lWEhyGXgiF306xCQg5R4zWJARAJTLgDa/9
         Ef2/YA3sIKKbc35AO+Q0fe2ws7+ToDA4ry5785t2Zn4isxW3gXdHzTue3gW1ecZf0FA4
         M1WI0SfvMkgka2CzNgaZSgFdR9dg2mEbbfdVAN0Vkqns7mm4TE+xQk3/fxRqXLSdcFEG
         0Acw/B9aDQFwC5Hxnf6i4lErts5awKoJ7webwAMUKTsECa2mbvdVDGqT3Y2B7siTKkwO
         9T/bSbqx5bD9eoZP+YKvS6Kslbei4qUVvRzHX0MA20T0tp8TBn8GFr2LywBBTVjZOyhn
         D2oA==
X-Forwarded-Encrypted: i=1; AJvYcCUC4VrLMSyt92OMWpORtSpw5lpGA9LDTiiln2OtikwGzK/p5M1xUOhndApADJ9cTi6vtuLIpED/u01GUiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz87jeFozaEjTGXIbuC4LMTYWKXfdTdqdEVit5RB+5bIu8vh5fb
	TR5fvXF1oJaW/qb3aJj8eEDe8LuhucbWF6LS1R2/bR4cdi6cC0Qcrw/on2aVQvM=
X-Gm-Gg: ASbGnctqgibXzxoPdCI88luEkx0HYDxZPmr1RTnpbD+rsPHomoIS37MZlFqQBaJPuef
	xOzJJVa6ta2yUDfnhWuK/j1BohBNFsZLCaVWBwtsz4NJ5X0V6C6JsMZ7sOSTVol30y6UX2Aph07
	IaHhNegYdhCeAJma2Gc44c78yTmWncRQAmUfVcdDscPTwEY+eZ+2HYD3iXiyItDnGPVjLQPncoh
	Nq3MQFgSr5j08WYn4/L5jSutUffnDlT8XWZjUclfkcmUtUBbqI6sYovQKo=
X-Google-Smtp-Source: AGHT+IEn2a1k9EtjOpfVet1ysm6MWr9jkiUyE2X2SH8cUoAjtJnT3D5sVQSXdc6UVYtxwSGjKa8I4g==
X-Received: by 2002:a05:6808:2e4e:b0:3ea:aa8a:c115 with SMTP id 5614622812f47-3eae4f8c2c0mr3705224b6e.21.1733239977325;
        Tue, 03 Dec 2024 07:32:57 -0800 (PST)
Received: from localhost.localdomain ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea86036cbbsm2891878b6e.8.2024.12.03.07.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 07:32:56 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/12] mm/filemap: add read support for RWF_UNCACHED
Date: Tue,  3 Dec 2024 08:31:44 -0700
Message-ID: <20241203153232.92224-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203153232.92224-2-axboe@kernel.dk>
References: <20241203153232.92224-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RWF_UNCACHED as a read operation flag, which means that any data
read wil be removed from the page cache upon completion. Uses the page
cache to synchronize, and simply prunes folios that were instantiated
when the operation completes. While it would be possible to use private
pages for this, using the page cache as synchronization is handy for a
variety of reasons:

1) No special truncate magic is needed
2) Async buffered reads need some place to serialize, using the page
   cache is a lot easier than writing extra code for this
3) The pruning cost is pretty reasonable

and the code to support this is much simpler as a result.

You can think of uncached buffered IO as being the much more attractive
cousin of O_DIRECT - it has none of the restrictions of O_DIRECT. Yes,
it will copy the data, but unlike regular buffered IO, it doesn't run
into the unpredictability of the page cache in terms of reclaim. As an
example, on a test box with 32 drives, reading them with buffered IO
looks as follows:

Reading bs 65536, uncached 0
  1s: 145945MB/sec
  2s: 158067MB/sec
  3s: 157007MB/sec
  4s: 148622MB/sec
  5s: 118824MB/sec
  6s: 70494MB/sec
  7s: 41754MB/sec
  8s: 90811MB/sec
  9s: 92204MB/sec
 10s: 95178MB/sec
 11s: 95488MB/sec
 12s: 95552MB/sec
 13s: 96275MB/sec

where it's quite easy to see where the page cache filled up, and
performance went from good to erratic, and finally settles at a much
lower rate. Looking at top while this is ongoing, we see:

 PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
7535 root      20   0  267004      0      0 S  3199   0.0   8:40.65 uncached
3326 root      20   0       0      0      0 R 100.0   0.0   0:16.40 kswapd4
3327 root      20   0       0      0      0 R 100.0   0.0   0:17.22 kswapd5
3328 root      20   0       0      0      0 R 100.0   0.0   0:13.29 kswapd6
3332 root      20   0       0      0      0 R 100.0   0.0   0:11.11 kswapd10
3339 root      20   0       0      0      0 R 100.0   0.0   0:16.25 kswapd17
3348 root      20   0       0      0      0 R 100.0   0.0   0:16.40 kswapd26
3343 root      20   0       0      0      0 R 100.0   0.0   0:16.30 kswapd21
3344 root      20   0       0      0      0 R 100.0   0.0   0:11.92 kswapd22
3349 root      20   0       0      0      0 R 100.0   0.0   0:16.28 kswapd27
3352 root      20   0       0      0      0 R  99.7   0.0   0:11.89 kswapd30
3353 root      20   0       0      0      0 R  96.7   0.0   0:16.04 kswapd31
3329 root      20   0       0      0      0 R  96.4   0.0   0:11.41 kswapd7
3345 root      20   0       0      0      0 R  96.4   0.0   0:13.40 kswapd23
3330 root      20   0       0      0      0 S  91.1   0.0   0:08.28 kswapd8
3350 root      20   0       0      0      0 S  86.8   0.0   0:11.13 kswapd28
3325 root      20   0       0      0      0 S  76.3   0.0   0:07.43 kswapd3
3341 root      20   0       0      0      0 S  74.7   0.0   0:08.85 kswapd19
3334 root      20   0       0      0      0 S  71.7   0.0   0:10.04 kswapd12
3351 root      20   0       0      0      0 R  60.5   0.0   0:09.59 kswapd29
3323 root      20   0       0      0      0 R  57.6   0.0   0:11.50 kswapd1
[...]

which is just showing a partial list of the 32 kswapd threads that are
running mostly full tilt, burning ~28 full CPU cores.

If the same test case is run with RWF_UNCACHED set for the buffered read,
the output looks as follows:

Reading bs 65536, uncached 0
  1s: 153144MB/sec
  2s: 156760MB/sec
  3s: 158110MB/sec
  4s: 158009MB/sec
  5s: 158043MB/sec
  6s: 157638MB/sec
  7s: 157999MB/sec
  8s: 158024MB/sec
  9s: 157764MB/sec
 10s: 157477MB/sec
 11s: 157417MB/sec
 12s: 157455MB/sec
 13s: 157233MB/sec
 14s: 156692MB/sec

which is just chugging along at ~155GB/sec of read performance. Looking
at top, we see:

 PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
7961 root      20   0  267004      0      0 S  3180   0.0   5:37.95 uncached
8024 axboe     20   0   14292   4096      0 R   1.0   0.0   0:00.13 top

where just the test app is using CPU, no reclaim is taking place outside
of the main thread. Not only is performance 65% better, it's also using
half the CPU to do it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 28 ++++++++++++++++++++++++++--
 mm/swap.c    |  2 ++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index dd3042de8038..139d1db79ff8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2473,6 +2473,8 @@ static int filemap_create_folio(struct kiocb *iocb,
 	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), min_order);
 	if (!folio)
 		return -ENOMEM;
+	if (iocb->ki_flags & IOCB_UNCACHED)
+		__folio_set_uncached(folio);
 
 	/*
 	 * Protect against truncate / hole punch. Grabbing invalidate_lock
@@ -2518,6 +2520,8 @@ static int filemap_readahead(struct kiocb *iocb, struct file *file,
 
 	if (iocb->ki_flags & IOCB_NOIO)
 		return -EAGAIN;
+	if (iocb->ki_flags & IOCB_UNCACHED)
+		ractl.uncached = 1;
 	page_cache_async_ra(&ractl, folio, last_index - folio->index);
 	return 0;
 }
@@ -2547,6 +2551,8 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 			return -EAGAIN;
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			flags = memalloc_noio_save();
+		if (iocb->ki_flags & IOCB_UNCACHED)
+			ractl.uncached = 1;
 		page_cache_sync_ra(&ractl, last_index - index);
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			memalloc_noio_restore(flags);
@@ -2594,6 +2600,20 @@ static inline bool pos_same_folio(loff_t pos1, loff_t pos2, struct folio *folio)
 	return (pos1 >> shift == pos2 >> shift);
 }
 
+static void filemap_uncached_read(struct address_space *mapping,
+				  struct folio *folio)
+{
+	if (!folio_test_uncached(folio))
+		return;
+	if (folio_test_writeback(folio) || folio_test_dirty(folio))
+		return;
+	if (folio_trylock(folio)) {
+		if (folio_test_clear_uncached(folio))
+			folio_unmap_invalidate(mapping, folio, 0);
+		folio_unlock(folio);
+	}
+}
+
 /**
  * filemap_read - Read data from the page cache.
  * @iocb: The iocb to read.
@@ -2707,8 +2727,12 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 			}
 		}
 put_folios:
-		for (i = 0; i < folio_batch_count(&fbatch); i++)
-			folio_put(fbatch.folios[i]);
+		for (i = 0; i < folio_batch_count(&fbatch); i++) {
+			struct folio *folio = fbatch.folios[i];
+
+			filemap_uncached_read(mapping, folio);
+			folio_put(folio);
+		}
 		folio_batch_init(&fbatch);
 	} while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
 
diff --git a/mm/swap.c b/mm/swap.c
index 10decd9dffa1..4019ab371759 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -427,6 +427,8 @@ static void folio_inc_refs(struct folio *folio)
  */
 void folio_mark_accessed(struct folio *folio)
 {
+	if (folio_test_uncached(folio))
+		return;
 	if (lru_gen_enabled()) {
 		folio_inc_refs(folio);
 		return;
-- 
2.45.2


