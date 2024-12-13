Return-Path: <linux-kernel+bounces-445118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9010F9F1199
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746AC18856F7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AB41EC01D;
	Fri, 13 Dec 2024 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="weU06r9Y"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA001E7668
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105374; cv=none; b=jW7jhoPJPg5ZzsJQthDP9EFWQ3VJ5H0L0geLILHQM7CxV/Tqy4c4/YfDox8oETx4H8UMYzyn3cjbx9V0ADAYtHk7O7OXDU5Qkxucw1gzHrSyxnS3C4AvSHXj8GdOdpiH/V9ghVWNORbwv/S/9AgbxqMXUbwDpWIbYITFP1d9k2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105374; c=relaxed/simple;
	bh=EZq/FArZwXgCBs4pZJDUXjfhlPafSJVT3vDdAzxjcuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nk/OWhURQCZJncaQZiZy5n8XwQoNWGBOZNdzorLiq5YCmtHInOcKpW/JpwhBe+EAORiFWHxrN9lxW25nZVaWeufF89Y1ExnpDFtXvEIzhNJYzQenrn76Ib7lMbRFzaAR0ef/SYP78N6xl62WjU8IpY3qI0S8R1ZMbAF+BVuUvdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=weU06r9Y; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a8160382d4so6010695ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734105372; x=1734710172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6x6BO6+6Zb8b9h/4S7enLTX5qkkGgQROhVyQCWWxzU=;
        b=weU06r9YxvdS1WDcTqD0yw/mJvNIBBFPFHoPtJ/ANqgU/1+YICPLCz/p5ZaoKtruH/
         wcQYTGUmqBhkZM0QqifHRu75JqEB8tRvlMYkS5D5yBzooFTvJSPUF27t4MaPau+QkGg4
         /qyTert9WI/G7MGDy+CYNgtFiGFtopXWxGhOXvuohTQPNjrdIF+Nhw5pCmxo/tnf8ggT
         i4TNbQRfY1laF49TLG486wRYWdhfAHccLPai/Nql99tzfax0WISR2/70Kx29+FRQwHbr
         jS8ALKfGQ8HEsTvfuSIryOM2yYQhCpdLJYDGYNTv0NlG0ONSwxfkg3wYewuVRQpwFVis
         C37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105372; x=1734710172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6x6BO6+6Zb8b9h/4S7enLTX5qkkGgQROhVyQCWWxzU=;
        b=iql26/olM3U3xavRsg5LKbwtHvRxG1zOc6Y/2UZYTcBTo8Tq8/iHCkAUNH5wl1N2fL
         f8l9wq8XBFN+M7iTLYbLUeAv9m5w3e9uur/ODTEXky0k0p7EGNLwDQif7oZwz30jmVUm
         UZd5XigB/fN5vazMuIc4pZeJMXSaXrGAPUmNlISoDH+Rrnnz0pjfmMckbs0rhHd0ERQs
         o1MDR35LwI8apW+JxRC0FKGKLRUWPuixsL6uPpjSw2vfJ60PXZU+da0PiPJAzlH4tyek
         yl0/54r6SillZM0fg3FNIrQ8EtsQT/uXAYeWW20z5jTyAB7MFYhHs0gbyuWidEuSxRGG
         VRIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDkZuhfLxKMBhoJleBxbFfD+DHqCBstM/OQXjOGJANJuvhe3qLaDmwoCK4yE0E8Ckmlf3L+4yRpnDuEmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyINFpJNZLRgxSRc/jiqMn3YzC2KifAsUiDVkMZA4AM9dCr2kv+
	p491YOK7dZGyYuOzz9zPzH8TzUH1C1nqU9PCIkXDlSbnJvmzlIx+/gEruQxCVGk=
X-Gm-Gg: ASbGncuwRrYzEyJIAJe9vozARwpeMMVBQiuJiszmV9EOPo3wqTqUWsTsx6rEkwr8Mj7
	ScAI+VSeH/g3sR4kM4b/ARhD1XUTYcoPOCjB4C4tFyUsiefcnAWDTQt9lA0nwvY8pvKBhQNLA7u
	hkLAAi36/+bAtvMxeo1+JPlpmkPBexFU6/mIDKuoZJmCi5UbXHLYakgqFPXk4rBqAh1h0c7HXmC
	y3UpD0c8w9tgwUClBbcimJuuOGLQ/BEj2z4KwRT8PXWalreoRoci/Rj82AS
X-Google-Smtp-Source: AGHT+IEynku8b05ugapn+xW5MO4tP+/urn6SKqialSRpaetMXPe/mw9YxvkBEr2Hl0/nNihyBVcVWg==
X-Received: by 2002:a05:6e02:164e:b0:3a7:7ded:521b with SMTP id e9e14a558f8ab-3aff800f100mr28298385ab.17.1734105371849;
        Fri, 13 Dec 2024 07:56:11 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a9ca03ae11sm35258405ab.41.2024.12.13.07.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:56:11 -0800 (PST)
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
Subject: [PATCH 06/11] mm/truncate: add folio_unmap_invalidate() helper
Date: Fri, 13 Dec 2024 08:55:20 -0700
Message-ID: <20241213155557.105419-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155557.105419-1-axboe@kernel.dk>
References: <20241213155557.105419-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a folio_unmap_invalidate() helper, which unmaps and invalidates a
given folio. The caller must already have locked the folio. Embed the
old invalidate_complete_folio2() helper in there as well, as nobody else
calls it.

Use this new helper in invalidate_inode_pages2_range(), rather than
duplicate the code there.

In preparation for using this elsewhere as well, have it take a gfp_t
mask rather than assume GFP_KERNEL is the right choice. This bubbles
back to invalidate_complete_folio2() as well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/internal.h |  2 ++
 mm/truncate.c | 54 ++++++++++++++++++++++++++-------------------------
 2 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index cb8d8e8e3ffa..ed3c3690eb03 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -392,6 +392,8 @@ void unmap_page_range(struct mmu_gather *tlb,
 			     struct vm_area_struct *vma,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details);
+int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
+			   gfp_t gfp);
 
 void page_cache_ra_order(struct readahead_control *, struct file_ra_state *,
 		unsigned int order);
diff --git a/mm/truncate.c b/mm/truncate.c
index 7c304d2f0052..7b6f4399319f 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -525,6 +525,15 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
 }
 EXPORT_SYMBOL(invalidate_mapping_pages);
 
+static int folio_launder(struct address_space *mapping, struct folio *folio)
+{
+	if (!folio_test_dirty(folio))
+		return 0;
+	if (folio->mapping != mapping || mapping->a_ops->launder_folio == NULL)
+		return 0;
+	return mapping->a_ops->launder_folio(folio);
+}
+
 /*
  * This is like mapping_evict_folio(), except it ignores the folio's
  * refcount.  We do this because invalidate_inode_pages2() needs stronger
@@ -532,14 +541,26 @@ EXPORT_SYMBOL(invalidate_mapping_pages);
  * shrink_folio_list() has a temp ref on them, or because they're transiently
  * sitting in the folio_add_lru() caches.
  */
-static int invalidate_complete_folio2(struct address_space *mapping,
-					struct folio *folio)
+int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
+			   gfp_t gfp)
 {
-	if (folio->mapping != mapping)
-		return 0;
+	int ret;
+
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
-	if (!filemap_release_folio(folio, GFP_KERNEL))
+	if (folio_test_dirty(folio))
 		return 0;
+	if (folio_mapped(folio))
+		unmap_mapping_folio(folio);
+	BUG_ON(folio_mapped(folio));
+
+	ret = folio_launder(mapping, folio);
+	if (ret)
+		return ret;
+	if (folio->mapping != mapping)
+		return -EBUSY;
+	if (!filemap_release_folio(folio, gfp))
+		return -EBUSY;
 
 	spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
@@ -558,16 +579,7 @@ static int invalidate_complete_folio2(struct address_space *mapping,
 failed:
 	xa_unlock_irq(&mapping->i_pages);
 	spin_unlock(&mapping->host->i_lock);
-	return 0;
-}
-
-static int folio_launder(struct address_space *mapping, struct folio *folio)
-{
-	if (!folio_test_dirty(folio))
-		return 0;
-	if (folio->mapping != mapping || mapping->a_ops->launder_folio == NULL)
-		return 0;
-	return mapping->a_ops->launder_folio(folio);
+	return -EBUSY;
 }
 
 /**
@@ -629,18 +641,8 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 				folio_unlock(folio);
 				continue;
 			}
-			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
 			folio_wait_writeback(folio);
-
-			if (folio_mapped(folio))
-				unmap_mapping_folio(folio);
-			BUG_ON(folio_mapped(folio));
-
-			ret2 = folio_launder(mapping, folio);
-			if (ret2 == 0) {
-				if (!invalidate_complete_folio2(mapping, folio))
-					ret2 = -EBUSY;
-			}
+			ret2 = folio_unmap_invalidate(mapping, folio, GFP_KERNEL);
 			if (ret2 < 0)
 				ret = ret2;
 			folio_unlock(folio);
-- 
2.45.2


