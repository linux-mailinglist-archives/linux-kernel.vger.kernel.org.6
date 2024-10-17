Return-Path: <linux-kernel+bounces-370404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D6E9A2BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB191C26334
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C37E1E04BA;
	Thu, 17 Oct 2024 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MImItx9E"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9AB1E0B82
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188941; cv=none; b=Eu+WCby9oJ7kLtVE8f48TLtbQI4wtDZPX8IDLH5Oz9cSYOSqLQT9w5YIHblsFRLoSN/RvNuecunzcSA50YZWVZPRcVqMLxiQPYl25lVkrtlThY9yvM2D+RuzCTBR7SZOtmYTK72AS4vceW+Ua1KlnwPAfMoTqQaOhqHsLQO8ing=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188941; c=relaxed/simple;
	bh=a250gqTybQoLWtogC//ZdkOdpAgR0TH2LFJaXWoUx0c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W3nNjPsQB/KNqEfUO5XyQiTd+LgyUJlXL+L0AoUO4TWOp2Mclo6nV029sY94tmxEKGDVXkUyzy6xd6LBEaS1loYZ9iIumyaASqpoqYadRH5PSMju71t35Gq/2BrxrSj23+8rdZM1kLl4zklf3+9XYo4KpzsbCzKJT0Pz2+TJTuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--weixugc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MImItx9E; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--weixugc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-20c94c1f692so20493085ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729188939; x=1729793739; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HxA9E1IHlt239nhDTqDd4dmPZVRZp9vSfPKedRWwzZg=;
        b=MImItx9E1ur4keMl35Dk4CssRgYF3mqglgM8o7RpGJICJHjjsVyKsNPkKcbuVsMMd5
         bjx9k+S4BHRFItdb4YRkIijYp2ZXDmKGjKucISd00wVoW+4p7dkfMjxinv9s4XpGZsX7
         jOGJVsm6M6ldpzWh9rsFJUSQiKXQYfqbmWtv2YLpPgFYFr/snLXrjwwbpSkoneRnD7NV
         ou6H9g3LOXAvwDkOnoGWnOkgp+Li1zPqdG1C9iTyVDrJegZK7wLmzgWWH1qrJFnHFUUs
         rFTRy1VGI8iOzk3ELtVpjh5Z1ZTelFiqIAqxozZPTu9z0B6SzmVYSJx5csrx5QjZOe0M
         U/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729188939; x=1729793739;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HxA9E1IHlt239nhDTqDd4dmPZVRZp9vSfPKedRWwzZg=;
        b=ryKq2ac0rx0N67ZnQKhFCXn2NujXWIQZNQR3OVu/tGsGOFRZjIdTu46vRszs2op5r3
         cpfPaI3olCnO2Z0x3JJpBilkAAXxvlkdSRju6MSR1jP22GYTsUZtsGKmuJSScdFdkFks
         V2NwghHu3GHuSdnVUjHxSrzN+5ZoVg1XvEjWE+nrvoeWcJ+G7jzp16yylNn4JGXQ5KRB
         zMl5clOONIL6EDLjmmpuiXEgQ3q1mlcQjQSPb9s3ELDbQgg9oL8M+66ivtZ9N1zoc6Wb
         5DOi90y4zht621caBnNrashoO8g8FQoppEPm1wEXL1I2s70uQqSv8YKAGo+Fpz3QZf/U
         uOpg==
X-Forwarded-Encrypted: i=1; AJvYcCVSnVT4GPsKUJvtm0n38B3PttiybOi6eK1EDkZ6flKbB8KrxJc6gayLMY9sPDVdKCi1uGNigg+c31MRskE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkUjVYfRk/oe27sx4kv9xIzqKasXsURw3V+HTiU2IN3GKikYOe
	3EU13apULTWBuIvZ0D4OMkTZjqtQdhbKA5+v9KwxpwK3qbO8o8x0TP1NxV328UbKut38cAjOV4q
	p3gWabA==
X-Google-Smtp-Source: AGHT+IEM5Vb8Wnjqgfj0YMkL/+m9MvF/5frBqIhXLjjHbwiFYCqRQAulc0R8W0vdNIg7J3UV6981NeDrJSjv
X-Received: from monterey.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:641d])
 (user=weixugc job=sendgmr) by 2002:a17:903:4287:b0:20c:6764:6681 with SMTP id
 d9443c01a7336-20d4720842bmr44275ad.2.1729188938643; Thu, 17 Oct 2024 11:15:38
 -0700 (PDT)
Date: Thu, 17 Oct 2024 18:15:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241017181528.3358821-1-weixugc@google.com>
Subject: [PATCH v2] mm/mglru: reset page lru tier bits when activating
From: Wei Xu <weixugc@google.com>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Brian Geffon <bgeffon@google.com>, Jan Alexander Steffens <heftig@archlinux.org>, 
	Suleiman Souhlal <suleiman@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Wei Xu <weixugc@google.com>
Content-Type: text/plain; charset="UTF-8"

When a folio is activated, lru_gen_add_folio() moves the folio to the
youngest generation.  But unlike folio_update_gen()/folio_inc_gen(),
lru_gen_add_folio() doesn't reset the folio lru tier bits
(LRU_REFS_MASK | LRU_REFS_FLAGS).  This inconsistency can affect how
pages are aged via folio_mark_accessed() (e.g. fd accesses), though
no user visible impact related to this has been detected yet.

Note that lru_gen_add_folio() cannot clear PG_workingset if the
activation is due to workingset refault, otherwise PSI accounting
will be skipped.  So fix lru_gen_add_folio() to clear the lru tier
bits other than PG_workingset when activating a folio, and also
clear all the lru tier bits when a folio is activated via
folio_activate() in lru_gen_look_around().

Fixes: 018ee47f1489 ("mm: multi-gen LRU: exploit locality in rmap")
Signed-off-by: Wei Xu <weixugc@google.com>
---
 include/linux/mm_inline.h | 15 ++++++++++++++-
 include/linux/mmzone.h    |  2 ++
 mm/vmscan.c               |  8 ++++----
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 6f801c7b36e2..355cf46a01a6 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -155,6 +155,11 @@ static inline int folio_lru_refs(struct folio *folio)
 	return ((flags & LRU_REFS_MASK) >> LRU_REFS_PGOFF) + workingset;
 }
 
+static inline void folio_clear_lru_refs(struct folio *folio)
+{
+	set_mask_bits(&folio->flags, LRU_REFS_MASK | LRU_REFS_FLAGS, 0);
+}
+
 static inline int folio_lru_gen(struct folio *folio)
 {
 	unsigned long flags = READ_ONCE(folio->flags);
@@ -222,6 +227,7 @@ static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio,
 {
 	unsigned long seq;
 	unsigned long flags;
+	unsigned long mask;
 	int gen = folio_lru_gen(folio);
 	int type = folio_is_file_lru(folio);
 	int zone = folio_zonenum(folio);
@@ -257,7 +263,14 @@ static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio,
 	gen = lru_gen_from_seq(seq);
 	flags = (gen + 1UL) << LRU_GEN_PGOFF;
 	/* see the comment on MIN_NR_GENS about PG_active */
-	set_mask_bits(&folio->flags, LRU_GEN_MASK | BIT(PG_active), flags);
+	mask = LRU_GEN_MASK;
+	/*
+	 * Don't clear PG_workingset here because it can affect PSI accounting
+	 * if the activation is due to workingset refault.
+	 */
+	if (folio_test_active(folio))
+		mask |= LRU_REFS_MASK | BIT(PG_referenced) | BIT(PG_active);
+	set_mask_bits(&folio->flags, mask, flags);
 
 	lru_gen_update_size(lruvec, folio, -1, gen);
 	/* for folio_rotate_reclaimable() */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 17506e4a2835..96dea31fb211 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -403,6 +403,8 @@ enum {
 	NR_LRU_GEN_CAPS
 };
 
+#define LRU_REFS_FLAGS		(BIT(PG_referenced) | BIT(PG_workingset))
+
 #define MIN_LRU_BATCH		BITS_PER_LONG
 #define MAX_LRU_BATCH		(MIN_LRU_BATCH * 64)
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c12f78b042f3..2d0486189804 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2602,8 +2602,6 @@ static bool should_clear_pmd_young(void)
  *                          shorthand helpers
  ******************************************************************************/
 
-#define LRU_REFS_FLAGS	(BIT(PG_referenced) | BIT(PG_workingset))
-
 #define DEFINE_MAX_SEQ(lruvec)						\
 	unsigned long max_seq = READ_ONCE((lruvec)->lrugen.max_seq)
 
@@ -4138,8 +4136,10 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 		old_gen = folio_lru_gen(folio);
 		if (old_gen < 0)
 			folio_set_referenced(folio);
-		else if (old_gen != new_gen)
+		else if (old_gen != new_gen) {
+			folio_clear_lru_refs(folio);
 			folio_activate(folio);
+		}
 	}
 
 	arch_leave_lazy_mmu_mode();
@@ -4370,7 +4370,7 @@ static bool isolate_folio(struct lruvec *lruvec, struct folio *folio, struct sca
 
 	/* see the comment on MAX_NR_TIERS */
 	if (!folio_test_referenced(folio))
-		set_mask_bits(&folio->flags, LRU_REFS_MASK | LRU_REFS_FLAGS, 0);
+		folio_clear_lru_refs(folio);
 
 	/* for shrink_folio_list() */
 	folio_clear_reclaim(folio);
-- 
2.47.0.rc1.288.g06298d1525-goog


