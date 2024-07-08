Return-Path: <linux-kernel+bounces-244899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A9C92AB2A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126511F22578
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3622614EC65;
	Mon,  8 Jul 2024 21:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mrRKOaDv"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD21A14900C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 21:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474087; cv=none; b=kL8/wM0hQx8YzLrNn3XfGZWnQ3LzyuxJIw8aI4i59WdM58OH7f3cjm3aEp2Xsu1WFJNpEGwJxUoxTGWSepWQlvttpAmZqD5tKIOp/dnDyWBpd9blLkyDIEvjLZpjlEigIlSWm9QZUrFDPnmLEgt8QIwkuKYEuS38NwdWenkZOw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474087; c=relaxed/simple;
	bh=UfTEjRMJvJ/xQZLuLW5elQXN69itdp4CIsGCnxsu4HM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lnynhL59Ih0+89gRD12gAGzhcrEV6UKeWM/3NYI9HyaA+7Co3LSWxhG30GMH0EZRfTO04aZfsfVB8p5ZgF4Mtp0zFrzQN1cPtMPG+f/shdWHDQ4/FlVhLvHq5ZD2GSAptQlIkKcuB2JDkGKIkjtqPfIpHLfgIAXD8jLvCTFtjH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mrRKOaDv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02b7adfb95so8349416276.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 14:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720474085; x=1721078885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/TY24y9pPj6qKzi8Thkqn2Z0GLOC7Boxtia/ZunSEuA=;
        b=mrRKOaDvDZyM7lhqq/dkAAESldnygYGIv+LEWSUwzCd8b7unVD9YUyayb1TVJeLKxh
         J4UYEXtJkOwPpQlhMMbvmQk2MKipQfo9WgpjHVf6pFWcikW9xzO/fcasKQzJNTOp78x0
         BZROn+Wqbb78SOXtn/VPUAThTqO8NSa4X6H29tMI6s+PzfEo51gjdSVltoOCS80EIptF
         ysupjconB84eh4DaxW0eY3DR7S9GoZqhp0ejV1PEH38X5IgfCz6qJB7aHNTNQSYlOWqc
         lqqbuvKBIQFhpaYC67phxJ17bQ3jX2qXgTqy/auTnr3PlKg1SxpGgnem2gRnNSLoXn3L
         958A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720474085; x=1721078885;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/TY24y9pPj6qKzi8Thkqn2Z0GLOC7Boxtia/ZunSEuA=;
        b=aXda4O6mLuzggRCdAt2XIEFmwkad7h8OCFmvNc6FFpU155+xSQb0Qu8ioUcvGF9iAt
         Yi+EguzLoaAclYTTXBaUeJM0P9N2uN7w4aLc/NpNJo42dAUTh44+3YsB21PqaWSTRqCH
         QZDQFUNo2HiBzOP4UCYgqyexWFjI/6/FrPK+r5tPOf7GcxplE/zEr/C653kbKO3i/aDY
         dgbQznKbs8DZGgNFFXGhd2K3lxhvwEkJf1LoxAOQ3bQbYkST3N6loU+zNlQpndJZAXR1
         zzduT2GjRK4JGbJQyZYntY9vuGin5FMjqNew4gJeXog5nadCH3cEMXj+bypR1Shn/VQx
         jA3A==
X-Forwarded-Encrypted: i=1; AJvYcCVymxyFvJhef5dnuRMAHEPKV/RsM7kJHr2uaxhpJmdqK7MHH7PWGUboBhp8aG4hbPSo1/6VaJnus4DKv+OLqe6ZJpl13R6AvQLKRFSD
X-Gm-Message-State: AOJu0Yw1hL60+W9kvNw+jrEbMvNN0Utkhwgpeq2LVU+kXvD25JL9J/bN
	b+5X21HlRmXuOciO3UNoJZKMfI/yv9e4F5jDBaOndTLBB0gxBR5s+PeQogQKRJWnJu+Rij9lCMd
	vdg==
X-Google-Smtp-Source: AGHT+IFPaoT+0JeZqOGBuuBQ7SnQNqAFXgIKe35KGee83N0v93aXFTJlMQQDVA/DV+kJteIJoGtx5mPKvcs=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:386c:9fc4:1a37:2b64])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:1106:b0:e03:3c8c:e82c with SMTP id
 3f1490d57ef6-e041b17e019mr20463276.9.1720474084855; Mon, 08 Jul 2024 14:28:04
 -0700 (PDT)
Date: Mon,  8 Jul 2024 15:27:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240708212753.3120511-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v1] mm/truncate: batch-clear shadow entries
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bharata B Rao <bharata@amd.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Make clear_shadow_entry() clear shadow entries in `struct folio_batch`
so that it can reduce contention on i_lock and i_pages locks, e.g.,

  watchdog: BUG: soft lockup - CPU#29 stuck for 11s! [fio:2701649]
    clear_shadow_entry+0x3d/0x100
    mapping_try_invalidate+0x117/0x1d0
    invalidate_mapping_pages+0x10/0x20
    invalidate_bdev+0x3c/0x50
    blkdev_common_ioctl+0x5f7/0xa90
    blkdev_ioctl+0x109/0x270

Reported-by: Bharata B Rao <bharata@amd.com>
Closes: https://lore.kernel.org/d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com/
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/truncate.c | 67 +++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 37 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 5ce62a939e55..bc12e7ff7d6a 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -39,12 +39,24 @@ static inline void __clear_shadow_entry(struct address_space *mapping,
 	xas_store(&xas, NULL);
 }
 
-static void clear_shadow_entry(struct address_space *mapping, pgoff_t index,
-			       void *entry)
+static void clear_shadow_entry(struct address_space *mapping,
+			       struct folio_batch *fbatch, pgoff_t *indices)
 {
+	int i;
+
+	if (shmem_mapping(mapping) || dax_mapping(mapping))
+		return;
+
 	spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
-	__clear_shadow_entry(mapping, index, entry);
+
+	for (i = 0; i < folio_batch_count(fbatch); i++) {
+		struct folio *folio = fbatch->folios[i];
+
+		if (xa_is_value(folio))
+			__clear_shadow_entry(mapping, indices[i], folio);
+	}
+
 	xa_unlock_irq(&mapping->i_pages);
 	if (mapping_shrinkable(mapping))
 		inode_add_lru(mapping->host);
@@ -105,36 +117,6 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
 	fbatch->nr = j;
 }
 
-/*
- * Invalidate exceptional entry if easily possible. This handles exceptional
- * entries for invalidate_inode_pages().
- */
-static int invalidate_exceptional_entry(struct address_space *mapping,
-					pgoff_t index, void *entry)
-{
-	/* Handled by shmem itself, or for DAX we do nothing. */
-	if (shmem_mapping(mapping) || dax_mapping(mapping))
-		return 1;
-	clear_shadow_entry(mapping, index, entry);
-	return 1;
-}
-
-/*
- * Invalidate exceptional entry if clean. This handles exceptional entries for
- * invalidate_inode_pages2() so for DAX it evicts only clean entries.
- */
-static int invalidate_exceptional_entry2(struct address_space *mapping,
-					 pgoff_t index, void *entry)
-{
-	/* Handled by shmem itself */
-	if (shmem_mapping(mapping))
-		return 1;
-	if (dax_mapping(mapping))
-		return dax_invalidate_mapping_entry_sync(mapping, index);
-	clear_shadow_entry(mapping, index, entry);
-	return 1;
-}
-
 /**
  * folio_invalidate - Invalidate part or all of a folio.
  * @folio: The folio which is affected.
@@ -494,6 +476,7 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 	unsigned long ret;
 	unsigned long count = 0;
 	int i;
+	bool xa_has_values = false;
 
 	folio_batch_init(&fbatch);
 	while (find_lock_entries(mapping, &index, end, &fbatch, indices)) {
@@ -503,8 +486,8 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 			/* We rely upon deletion not changing folio->index */
 
 			if (xa_is_value(folio)) {
-				count += invalidate_exceptional_entry(mapping,
-							     indices[i], folio);
+				xa_has_values = true;
+				count++;
 				continue;
 			}
 
@@ -522,6 +505,10 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 			}
 			count += ret;
 		}
+
+		if (xa_has_values)
+			clear_shadow_entry(mapping, &fbatch, indices);
+
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 		cond_resched();
@@ -616,6 +603,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	int ret = 0;
 	int ret2 = 0;
 	int did_range_unmap = 0;
+	bool xa_has_values = false;
 
 	if (mapping_empty(mapping))
 		return 0;
@@ -629,8 +617,9 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 			/* We rely upon deletion not changing folio->index */
 
 			if (xa_is_value(folio)) {
-				if (!invalidate_exceptional_entry2(mapping,
-						indices[i], folio))
+				xa_has_values = true;
+				if (dax_mapping(mapping) &&
+				    !dax_invalidate_mapping_entry_sync(mapping, indices[i]))
 					ret = -EBUSY;
 				continue;
 			}
@@ -666,6 +655,10 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 				ret = ret2;
 			folio_unlock(folio);
 		}
+
+		if (xa_has_values)
+			clear_shadow_entry(mapping, &fbatch, indices);
+
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 		cond_resched();
-- 
2.45.2.803.g4e1b14247a-goog


