Return-Path: <linux-kernel+bounces-247056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCF992CA66
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70A01F23833
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDF055C0A;
	Wed, 10 Jul 2024 06:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ys6Y8w8O"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CB61A28D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720591778; cv=none; b=muqhUR2ZhSHqeSUrRtEJBzcqi+kXaXJbsEhcWyAtol9oAfkdHlrW126Df20Dpi79spr96SdtnL5jTlJGH2AmMantgnUBYAbkkfQUxElr9bq/h9VorxffjKRTj8z8ZSZcTGOofdAwUVmZMoF/W0yLSFb+83JUy2MlVu5XFimmMEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720591778; c=relaxed/simple;
	bh=0+fZuP12qY21RTPxHU6v5ZKge2p5BesIMlD0z50Q5AU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Hw2OAosuETBWgJO7C+eu6FzwIuXGVy1dLVzD37GI7gcKkoa8zYWjnUe0HRvLA1El8zydIB1f0auE0EUNis9U7maI351Fi0sRpv7CLv7TyJMENQ512BUrrNA+4KPT30OQgbaNPOWzT6wkXiXf8caLMRwGMGeQ2W8CF2rOIz6Dwyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ys6Y8w8O; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03a3aafc6eso9520855276.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 23:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720591776; x=1721196576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h5uZ7CARkJp0bCCnNjPnh/UCvn8scxgN13mnhGZm9ws=;
        b=ys6Y8w8Orv7vwFSBL7eYPOlzTgNO5mIgG/sYfw5HLOCaZd4HqtFF9dQvb4dTjsVQ7k
         uTRSilc3oeLMiiXelEi878YABHotQ7PRF+sdNhtm5NnNPaPxYiEyb4La/IcmBhDAvzge
         CRs+8v9LLVy7Ljhv+h5tyGa0k00pofQJSz0nPUngt9d74CFah/1K5EaDYFenR9Dm9X17
         8zA1PLvfwSJjTdzZ33l3x2pd55lcHlncrfGdOHp1bIQekZc1Kidz0qh/BqC6I8zm6Lo3
         tKS36qn8xMh8pjw4K8akzyDWesUcunMhLl1M6dkIEs3CFTrmjlZHtpkIK3yw+E71dN1B
         dhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720591776; x=1721196576;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h5uZ7CARkJp0bCCnNjPnh/UCvn8scxgN13mnhGZm9ws=;
        b=OSoFKSZu78JtE8y2ZikkBQ2l94FZ4Fy2BSDfWgCYuvhJRgkeLX6bkwQFwVcik4R9Gt
         yKcJ8x1pM1f181KKUHXRt5KQLoX1BI9H9wgz2RbumrSYbe+X/nirmVlrEl3APexzovcT
         HxfqVB0MbL5o4XjSvlr2wTt7xLuS5345aTATM7atgy8aqIgiG8KeQUjozVEjKZh0jYoA
         BcOeaD57bOyUEa7jgFuIK4SJStN+AY/6UcC1Exq6Xun2ZDzy2Da1MGj9bHMPdniSD91k
         zjYoAYeqL+Xc2VRDbabP6DOR99XLF/dcRONc8CCmG+i7vI9CZarpWGz2Vgtq6l90paJc
         rYdg==
X-Forwarded-Encrypted: i=1; AJvYcCVjawdSpDQDlUUJAwiEqaKoYXlAW3q3CvwrSQVUaLZs4rzVN3CiwWBgib0KRuDmsHNppMNSS4ay+IJbcwPIRcnp7gkMh8SqM7hIdFD5
X-Gm-Message-State: AOJu0YxS4/Fz5hFawWQIvYBm404EchUfIxv/2UZmjwTWTC251jldT6yH
	60c1bDiPcNeRZYpIY45U8dfDNkM+qr02GNY0omPFgGs5LFJ7DAf426n82CQEhuPMzyNVVlooKxu
	O1Q==
X-Google-Smtp-Source: AGHT+IHC47f78BVmo+sdyjTSABTw0/Tqy6HN60awY2Lq4hntIiDkKOsp2uNyQ+wFfxFT0ijOssIk3hgSFsg=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:32c1:5ac8:f94b:a9a])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:124a:b0:e03:31ec:8a25 with SMTP id
 3f1490d57ef6-e041b10fd77mr10931276.10.1720591776148; Tue, 09 Jul 2024
 23:09:36 -0700 (PDT)
Date: Wed, 10 Jul 2024 00:09:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240710060933.3979380-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v2] mm/truncate: batch-clear shadow entries
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

Also, rename clear_shadow_entry() to clear_shadow_entries() accordingly.

Reported-by: Bharata B Rao <bharata@amd.com>
Closes: https://lore.kernel.org/d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com/
Tested-by: Bharata B Rao <bharata@amd.com>
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/truncate.c | 68 +++++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 37 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 5ce62a939e55..dfb3d1f4d456 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -39,12 +39,25 @@ static inline void __clear_shadow_entry(struct address_space *mapping,
 	xas_store(&xas, NULL);
 }
 
-static void clear_shadow_entry(struct address_space *mapping, pgoff_t index,
-			       void *entry)
+static void clear_shadow_entries(struct address_space *mapping,
+				 struct folio_batch *fbatch, pgoff_t *indices)
 {
+	int i;
+
+	/* Handled by shmem itself, or for DAX we do nothing. */
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
@@ -105,36 +118,6 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
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
@@ -494,6 +477,7 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 	unsigned long ret;
 	unsigned long count = 0;
 	int i;
+	bool xa_has_values = false;
 
 	folio_batch_init(&fbatch);
 	while (find_lock_entries(mapping, &index, end, &fbatch, indices)) {
@@ -503,8 +487,8 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 			/* We rely upon deletion not changing folio->index */
 
 			if (xa_is_value(folio)) {
-				count += invalidate_exceptional_entry(mapping,
-							     indices[i], folio);
+				xa_has_values = true;
+				count++;
 				continue;
 			}
 
@@ -522,6 +506,10 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 			}
 			count += ret;
 		}
+
+		if (xa_has_values)
+			clear_shadow_entries(mapping, &fbatch, indices);
+
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 		cond_resched();
@@ -616,6 +604,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	int ret = 0;
 	int ret2 = 0;
 	int did_range_unmap = 0;
+	bool xa_has_values = false;
 
 	if (mapping_empty(mapping))
 		return 0;
@@ -629,8 +618,9 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
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
@@ -666,6 +656,10 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 				ret = ret2;
 			folio_unlock(folio);
 		}
+
+		if (xa_has_values)
+			clear_shadow_entries(mapping, &fbatch, indices);
+
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 		cond_resched();
-- 
2.45.2.803.g4e1b14247a-goog


