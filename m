Return-Path: <linux-kernel+bounces-316142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B0B96CBBD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FCD2B23454
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884291FAA;
	Thu,  5 Sep 2024 00:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkRJ0S9W"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9F579E1
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725496180; cv=none; b=O0btVRy0iKz5+HVm21NWPISvLxv71Icy1wbQGpp5czK8i91d8CHBG/ketjh0mvH9z7YZz7n10bOU7oY5jsDIZ7t8Mn4ilTtkLpSYSUwGy1ZrmUS62sLFFafcmuxzIpUgNYBDDQaMrKnIOC9tprC+0KXCIa/fmlSK2UE6ps56x10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725496180; c=relaxed/simple;
	bh=3CGL9/MsrEgkC8yIVHx0u+kjrlAchNlbnTwvYTonHRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/6hRQJv1F7Fs/WS3Gxv5tLH/1j/1xCrETkWAZ2BaCT7eUZgwkZH0HaB046Y8mdQEgVdGEbNxqchOCAej+kjRXIqL2Lk2/TOu5dsaMmPPbkNFLyY7c2g0ErckIPaoH9aVONLffrca29dbz821OcYkdRsBJtbtS4YLJarmr2/KA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkRJ0S9W; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-277c861d9f6so155356fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 17:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725496178; x=1726100978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEFd6qhlBAEcOUAlKTFgbmkZei5HvQ6w0Ywk2W8QABk=;
        b=OkRJ0S9WmrBUTmIKAdBKWmBaAb2kC3NwiMbI4kUDnPcxEFWCFh8gvHUlTQrdUIu7hc
         OiIlaS45tE3LFbYIJb/bUe6XUT5CUv9tj4nuMLLK2vEhiweBhRojJLAyiEhpmOzsv07s
         5BLyxCk6H/wyGoxr4bx8FjzeqLwWJAYq8yRLZKNw1NqKsNp8kQI6Pezn+bEuD7eMrf/W
         ttHkV83P1A1CLRW8LdyH9SW5oqXs0EfON1eKzUcDFAoH/8y65BTFye47tiN5BBpzC3l3
         ic1ZSK2dyJ0V/VMjSn9Q0g33ADV4kAn+83t5Kdt7BqReSGZTwhefju4Pk4tcioEunY+4
         X69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725496178; x=1726100978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEFd6qhlBAEcOUAlKTFgbmkZei5HvQ6w0Ywk2W8QABk=;
        b=nlc9US10KUAtADXb7z9G5wK34lyPHNL3rUGJip8eyYkTHi4jHviTxpJ1vaw0xSMKAn
         L993eM7e6N3ysvGHsmAAbVddL5zEHJZZZ9qGGYUXBbGmaSFTyC+g1zfHPsnJ/hr2VrcD
         kneLgRcBXUDp4NwmzTI0m/tnS3rIOzWlvRqnu8IzxHpUOBSGVBPAGm7ta5LFnQg5w9SN
         aFsOkSHNkFERfLeZKrMfHOuvkmdFB/keDNIhuGtZda65qpI5gYS4t8JjX+I86nhWlhB5
         9d05pWANPiEMjmJhvrOV2yWzX39n7dQqm9/CSnlkdwINSDEyQ8pDXT1MEvv+tEHbsW2D
         NckA==
X-Forwarded-Encrypted: i=1; AJvYcCUKR32yzaZg1MeuR2XQeWOIWstLlCJLViEb4l5p9Ddc48unciKhPQE+F5Ty2LM8dD7byeuqHZ8ISRy/BBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy93jzwJ82a34q5qaWWdQy5DPIOQbigKmeINZy1h2ogyWdE1fs
	27WmpbpyTv8uw5n0M3MRAaoxuA232HMsH+uw05Jo3FireoLPGzWq
X-Google-Smtp-Source: AGHT+IEp+9r8rGdfg/De7m0n3NCcboQiamR2fz1tciWoya/v/bNrW9VY5cdwhq+54PSHOLRYulVeVw==
X-Received: by 2002:a05:6870:eca7:b0:277:e94b:779c with SMTP id 586e51a60fabf-27810b95fe3mr11015166fac.19.1725496178163;
        Wed, 04 Sep 2024 17:29:38 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:fdcc:5b39:8249:b563])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd852c1sm2258446a12.7.2024.09.04.17.29.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Sep 2024 17:29:37 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: yosryahmed@google.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	chengming.zhou@linux.dev,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	nphamcs@gmail.com,
	shakeel.butt@linux.dev,
	usamaarif642@gmail.com,
	willy@infradead.org,
	ying.huang@intel.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
Date: Thu,  5 Sep 2024 12:29:26 +1200
Message-Id: <20240905002926.1055-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CAJD7tkYK3ecG7cuJcxSF-cw-0K=JPnoE3L4Y=7xUp_R8apqueg@mail.gmail.com>
References: <CAJD7tkYK3ecG7cuJcxSF-cw-0K=JPnoE3L4Y=7xUp_R8apqueg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Sep 5, 2024 at 11:57 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> [..]
> > well. i feel i have a much cheaper way to implement this, which
> > can entirely iteration even in your original code:
> >
> > +/*
> > + * Return the number of entries which are zero-filled according to
> > + * swap_info_struct->zeromap. It isn't precise if the return value
> > + * is 1 for nr > 1. In this case, it means entries have inconsistent
> > + * zeromap.
> > + */
> > +static inline unsigned int swap_zeromap_entries_count(swp_entry_t
> > entry, int nr)
>
> FWIW I am not really a fan of the count() function not returning an
> actual count. I think an enum with three states is more appropriate
> here, and renaming the function to swap_zeromap_entries_check() or
> similar.
>

Make sense to me, what about the below?

From 24228a1e8426b8b05711a5efcfaae70abeb012c4 Mon Sep 17 00:00:00 2001
From: Barry Song <v-songbaohua@oppo.com>
Date: Thu, 5 Sep 2024 11:56:03 +1200
Subject: [PATCH] mm: fix handling zero for large folios with partial zeromap

There could be a corner case where the first entry is non-zeromap,
but a subsequent entry is zeromap. In this case, we should not
return false.

Additionally, the iteration of test_bit() is unnecessary and
can be replaced with bitmap operations, which are more efficient.

Since swap_read_folio() can't handle reading a large folio that's
partially zeromap and partially non-zeromap, we've moved the code
to mm/swap.h so that others, like those working on swap-in, can
access it.

Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap")
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/page_io.c | 27 ++++-----------------------
 mm/swap.h    | 29 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 4bc77d1c6bfa..46907c9dd20b 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -226,26 +226,6 @@ static void swap_zeromap_folio_clear(struct folio *folio)
 	}
 }
 
-/*
- * Return the index of the first subpage which is not zero-filled
- * according to swap_info_struct->zeromap.
- * If all pages are zero-filled according to zeromap, it will return
- * folio_nr_pages(folio).
- */
-static unsigned int swap_zeromap_folio_test(struct folio *folio)
-{
-	struct swap_info_struct *sis = swp_swap_info(folio->swap);
-	swp_entry_t entry;
-	unsigned int i;
-
-	for (i = 0; i < folio_nr_pages(folio); i++) {
-		entry = page_swap_entry(folio_page(folio, i));
-		if (!test_bit(swp_offset(entry), sis->zeromap))
-			return i;
-	}
-	return i;
-}
-
 /*
  * We may have stale swap cache pages in memory: notice
  * them here and get rid of the unnecessary final write.
@@ -524,9 +504,10 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
 
 static bool swap_read_folio_zeromap(struct folio *folio)
 {
-	unsigned int idx = swap_zeromap_folio_test(folio);
+	unsigned int nr_pages = folio_nr_pages(folio);
+	zeromap_stat_t stat = swap_zeromap_entries_check(folio->swap, nr_pages);
 
-	if (idx == 0)
+	if (stat == SWAP_ZEROMAP_NON)
 		return false;
 
 	/*
@@ -534,7 +515,7 @@ static bool swap_read_folio_zeromap(struct folio *folio)
 	 * currently handled. Return true without marking the folio uptodate so
 	 * that an IO error is emitted (e.g. do_swap_page() will sigbus).
 	 */
-	if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
+	if (WARN_ON_ONCE(stat == SWAP_ZEROMAP_PARTIAL))
 		return true;
 
 	folio_zero_range(folio, 0, folio_size(folio));
diff --git a/mm/swap.h b/mm/swap.h
index f8711ff82f84..f8e3fa061c1d 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -4,6 +4,12 @@
 
 struct mempolicy;
 
+typedef enum {
+	SWAP_ZEROMAP_NON,
+	SWAP_ZEROMAP_FULL,
+	SWAP_ZEROMAP_PARTIAL
+} zeromap_stat_t;
+
 #ifdef CONFIG_SWAP
 #include <linux/swapops.h> /* for swp_offset */
 #include <linux/blk_types.h> /* for bio_end_io_t */
@@ -80,6 +86,24 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 {
 	return swp_swap_info(folio->swap)->flags;
 }
+
+/*
+ * Check if nr entries are all zeromap, non-zeromap or partially zeromap
+ */
+static inline zeromap_stat_t swap_zeromap_entries_check(swp_entry_t entry, int nr)
+{
+	struct swap_info_struct *sis = swp_swap_info(entry);
+	unsigned long start = swp_offset(entry);
+	unsigned long end = start + nr;
+
+	if (find_next_bit(sis->zeromap, end, start) == end)
+		return SWAP_ZEROMAP_NON;
+	if (find_next_zero_bit(sis->zeromap, end, start) == end)
+		return SWAP_ZEROMAP_FULL;
+
+	return SWAP_ZEROMAP_PARTIAL;
+}
+
 #else /* CONFIG_SWAP */
 struct swap_iocb;
 static inline void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
@@ -171,6 +195,11 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 {
 	return 0;
 }
+
+static inline zeromap_stat_t swap_zeromap_entries_check(swp_entry_t entry, int nr)
+{
+	return SWAP_ZEROMAP_NONE;
+}
 #endif /* CONFIG_SWAP */
 
 #endif /* _MM_SWAP_H */
-- 
2.34.1



