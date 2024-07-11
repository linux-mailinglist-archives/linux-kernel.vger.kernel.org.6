Return-Path: <linux-kernel+bounces-248514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7057292DE45
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039741F22655
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C5BE572;
	Thu, 11 Jul 2024 02:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEcL1jGt"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271D3C133
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 02:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720664007; cv=none; b=FowVCXe6rbzatTNTzaU0l44wr4JUhXD9/VR0jSUeyl2zmQNe+2w5Hkw9aXuDnRgjR2TlAh5hDmDrzV2PDsK38SrPwyEmjYnbcmnfbv6jl7hlhEBW1vesFWJsnwMDdozpWe4jhO3UkD6ug3zjdocGvdjk8tsA+JbsVyJmj9Vn+9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720664007; c=relaxed/simple;
	bh=Ub6aJebnv3sNKRUMRdjFJPK9vCRxRBndWeWnvuCQDyU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QtVyf90040z0Fw0WMpME0to2vvx7zQzk+ROHWV1bs42eLKFlBneYMCH9XxRgEmNRJrCUhK0nlFGs1vvmZpDG/RmEz7rPKp6gP8MejpQ5X4hkODPbHRuPC6nCMPdC/p+zvxNjjR4f3/wxGWDPuo8bsYQ8SNiulcqLx51jEKS7QaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEcL1jGt; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e039fe0346eso724408276.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720664005; x=1721268805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2KA7HqAEDJDFjninnbueVy/cjuPGw3T2Kp1IRta9cE=;
        b=WEcL1jGt0B5lxrpVYyXtjL8Xz3hcyx6lFtwCIglP6L3VVLf2/gYCSpPi1NDawQzK1A
         uLR88RsL6KDyT/k31NoVV4U4cfJU5GfmKe4cEgBlbIkbRicK8teK3QHH0qKAlzfk6MFY
         oivkEI/QW8djgEsadrg34pyBcQjmXn5tXRm0PscCNBq2XwVTrVEKbLUP0+3ecihppUEl
         zK4qaltwswzqDN6vzc9jHTW88MfRxhn+xGK2Gl/yV4NqeKcalU5YlzepvP6ff4PunGEZ
         FMc2kcjS+ogPrd7OnOhin0Bp0tV7k5Wpc0o46Ai/MyX5b9DUbm1sGr1zWKN+akSFp2lr
         VEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720664005; x=1721268805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2KA7HqAEDJDFjninnbueVy/cjuPGw3T2Kp1IRta9cE=;
        b=l0dw2TTUaLXUTPwzEYv1Yh639WJe7BdPeTwvvxmd2i7UY/v2VTS9D3v9snG+71T6z/
         6cdj5TjHa1AcRQqvQXniOiLHDBcRaXUjvg4h0eGE0smn4wyAUojYSNyOn7Djq2up4VQh
         B0nAkRSVln7AXvyecrY1ndjm+m43XG6qf97nfNT2schxdJu7iAH9849IL8faeFlqiYlu
         DVZlW7yYEs5iSRipTH4qjJImkoQgNXsjOLTlTHkwL3Q8lIWuxwlj59paxTzJRfo6m2X8
         cXqwvEUcpLgsg5XkD3D8cb4gW2p8tXM/VRK/S8/t/bu1G0ChkyOsvKidGx36zXz0J2mB
         TlAg==
X-Forwarded-Encrypted: i=1; AJvYcCX1Uid9I/9ARSxDJSPFEWgXDV1NlyZ6z7yIEZFK8sJ7+NibTBJFNs3l+Em3mVcIdKBRmiE62KCPrBAI0VbxkkloyUj4NgaC12ZxI/dP
X-Gm-Message-State: AOJu0Yy/RaylEIc+UjJVZ7idHMRFPkmfm63Nr+mnMPKB/e6sY0lOVNPL
	OGs5wAxgA4VKTbi/8jS2fUsNJGvZvxGyECE5sVaISkVV4ynINeOMTlMrxLqvjNho64FQkhdDlTe
	eTg==
X-Google-Smtp-Source: AGHT+IH/Rp/IjlPFZgIAEzdNYzL8aBM88d5tP9iD3BV755kvnBakj7CsVrD7R8NFWV17wOfNsmdxA2dCn38=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:9b06:2f28:6675:a98b])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:1701:b0:e02:c478:c8b9 with SMTP id
 3f1490d57ef6-e041b1449e9mr15176276.12.1720664004897; Wed, 10 Jul 2024
 19:13:24 -0700 (PDT)
Date: Wed, 10 Jul 2024 20:13:13 -0600
In-Reply-To: <20240711021317.596178-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711021317.596178-1-yuzhao@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240711021317.596178-2-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 1/5] mm/swap: reduce indentation level
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Reduce indentation level by returning directly when there is no
cleanup needed, i.e.,

  if (condition) {    |    if (condition) {
    do_this();        |      do_this();
    return;           |      return;
  } else {            |    }
    do_that();        |
  }                   |    do_that();

and

  if (condition) {    |    if (!condition)
    do_this();        |      return;
    do_that();        |
  }                   |    do_this();
  return;             |    do_that();

Presumably the old style became repetitive as the result of copy and
paste.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/swap.c | 209 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 109 insertions(+), 100 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 9caf6b017cf0..952e4aac6eb1 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -117,7 +117,9 @@ void __folio_put(struct folio *folio)
 	if (unlikely(folio_is_zone_device(folio))) {
 		free_zone_device_folio(folio);
 		return;
-	} else if (folio_test_hugetlb(folio)) {
+	}
+
+	if (folio_test_hugetlb(folio)) {
 		free_huge_folio(folio);
 		return;
 	}
@@ -228,17 +230,19 @@ static void folio_batch_add_and_move(struct folio_batch *fbatch,
 	if (folio_batch_add(fbatch, folio) && !folio_test_large(folio) &&
 	    !lru_cache_disabled())
 		return;
+
 	folio_batch_move_lru(fbatch, move_fn);
 }
 
 static void lru_move_tail_fn(struct lruvec *lruvec, struct folio *folio)
 {
-	if (!folio_test_unevictable(folio)) {
-		lruvec_del_folio(lruvec, folio);
-		folio_clear_active(folio);
-		lruvec_add_folio_tail(lruvec, folio);
-		__count_vm_events(PGROTATED, folio_nr_pages(folio));
-	}
+	if (folio_test_unevictable(folio))
+		return;
+
+	lruvec_del_folio(lruvec, folio);
+	folio_clear_active(folio);
+	lruvec_add_folio_tail(lruvec, folio);
+	__count_vm_events(PGROTATED, folio_nr_pages(folio));
 }
 
 /*
@@ -250,22 +254,23 @@ static void lru_move_tail_fn(struct lruvec *lruvec, struct folio *folio)
  */
 void folio_rotate_reclaimable(struct folio *folio)
 {
-	if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
-	    !folio_test_unevictable(folio)) {
-		struct folio_batch *fbatch;
-		unsigned long flags;
+	struct folio_batch *fbatch;
+	unsigned long flags;
 
-		folio_get(folio);
-		if (!folio_test_clear_lru(folio)) {
-			folio_put(folio);
-			return;
-		}
+	if (folio_test_locked(folio) || folio_test_dirty(folio) ||
+	    folio_test_unevictable(folio))
+		return;
 
-		local_lock_irqsave(&lru_rotate.lock, flags);
-		fbatch = this_cpu_ptr(&lru_rotate.fbatch);
-		folio_batch_add_and_move(fbatch, folio, lru_move_tail_fn);
-		local_unlock_irqrestore(&lru_rotate.lock, flags);
+	folio_get(folio);
+	if (!folio_test_clear_lru(folio)) {
+		folio_put(folio);
+		return;
 	}
+
+	local_lock_irqsave(&lru_rotate.lock, flags);
+	fbatch = this_cpu_ptr(&lru_rotate.fbatch);
+	folio_batch_add_and_move(fbatch, folio, lru_move_tail_fn);
+	local_unlock_irqrestore(&lru_rotate.lock, flags);
 }
 
 void lru_note_cost(struct lruvec *lruvec, bool file,
@@ -328,18 +333,19 @@ void lru_note_cost_refault(struct folio *folio)
 
 static void folio_activate_fn(struct lruvec *lruvec, struct folio *folio)
 {
-	if (!folio_test_active(folio) && !folio_test_unevictable(folio)) {
-		long nr_pages = folio_nr_pages(folio);
-
-		lruvec_del_folio(lruvec, folio);
-		folio_set_active(folio);
-		lruvec_add_folio(lruvec, folio);
-		trace_mm_lru_activate(folio);
-
-		__count_vm_events(PGACTIVATE, nr_pages);
-		__count_memcg_events(lruvec_memcg(lruvec), PGACTIVATE,
-				     nr_pages);
-	}
+	long nr_pages = folio_nr_pages(folio);
+
+	if (folio_test_active(folio) || folio_test_unevictable(folio))
+		return;
+
+
+	lruvec_del_folio(lruvec, folio);
+	folio_set_active(folio);
+	lruvec_add_folio(lruvec, folio);
+	trace_mm_lru_activate(folio);
+
+	__count_vm_events(PGACTIVATE, nr_pages);
+	__count_memcg_events(lruvec_memcg(lruvec), PGACTIVATE, nr_pages);
 }
 
 #ifdef CONFIG_SMP
@@ -353,20 +359,21 @@ static void folio_activate_drain(int cpu)
 
 void folio_activate(struct folio *folio)
 {
-	if (!folio_test_active(folio) && !folio_test_unevictable(folio)) {
-		struct folio_batch *fbatch;
+	struct folio_batch *fbatch;
 
-		folio_get(folio);
-		if (!folio_test_clear_lru(folio)) {
-			folio_put(folio);
-			return;
-		}
+	if (folio_test_active(folio) || folio_test_unevictable(folio))
+		return;
 
-		local_lock(&cpu_fbatches.lock);
-		fbatch = this_cpu_ptr(&cpu_fbatches.activate);
-		folio_batch_add_and_move(fbatch, folio, folio_activate_fn);
-		local_unlock(&cpu_fbatches.lock);
+	folio_get(folio);
+	if (!folio_test_clear_lru(folio)) {
+		folio_put(folio);
+		return;
 	}
+
+	local_lock(&cpu_fbatches.lock);
+	fbatch = this_cpu_ptr(&cpu_fbatches.activate);
+	folio_batch_add_and_move(fbatch, folio, folio_activate_fn);
+	local_unlock(&cpu_fbatches.lock);
 }
 
 #else
@@ -378,12 +385,13 @@ void folio_activate(struct folio *folio)
 {
 	struct lruvec *lruvec;
 
-	if (folio_test_clear_lru(folio)) {
-		lruvec = folio_lruvec_lock_irq(folio);
-		folio_activate_fn(lruvec, folio);
-		unlock_page_lruvec_irq(lruvec);
-		folio_set_lru(folio);
-	}
+	if (!folio_test_clear_lru(folio))
+		return;
+
+	lruvec = folio_lruvec_lock_irq(folio);
+	folio_activate_fn(lruvec, folio);
+	unlock_page_lruvec_irq(lruvec);
+	folio_set_lru(folio);
 }
 #endif
 
@@ -610,41 +618,41 @@ static void lru_deactivate_file_fn(struct lruvec *lruvec, struct folio *folio)
 
 static void lru_deactivate_fn(struct lruvec *lruvec, struct folio *folio)
 {
-	if (!folio_test_unevictable(folio) && (folio_test_active(folio) || lru_gen_enabled())) {
-		long nr_pages = folio_nr_pages(folio);
+	long nr_pages = folio_nr_pages(folio);
 
-		lruvec_del_folio(lruvec, folio);
-		folio_clear_active(folio);
-		folio_clear_referenced(folio);
-		lruvec_add_folio(lruvec, folio);
+	if (folio_test_unevictable(folio) || !(folio_test_active(folio) || lru_gen_enabled()))
+		return;
 
-		__count_vm_events(PGDEACTIVATE, nr_pages);
-		__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE,
-				     nr_pages);
-	}
+	lruvec_del_folio(lruvec, folio);
+	folio_clear_active(folio);
+	folio_clear_referenced(folio);
+	lruvec_add_folio(lruvec, folio);
+
+	__count_vm_events(PGDEACTIVATE, nr_pages);
+	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_pages);
 }
 
 static void lru_lazyfree_fn(struct lruvec *lruvec, struct folio *folio)
 {
-	if (folio_test_anon(folio) && folio_test_swapbacked(folio) &&
-	    !folio_test_swapcache(folio) && !folio_test_unevictable(folio)) {
-		long nr_pages = folio_nr_pages(folio);
+	long nr_pages = folio_nr_pages(folio);
 
-		lruvec_del_folio(lruvec, folio);
-		folio_clear_active(folio);
-		folio_clear_referenced(folio);
-		/*
-		 * Lazyfree folios are clean anonymous folios.  They have
-		 * the swapbacked flag cleared, to distinguish them from normal
-		 * anonymous folios
-		 */
-		folio_clear_swapbacked(folio);
-		lruvec_add_folio(lruvec, folio);
+	if (!folio_test_anon(folio) || !folio_test_swapbacked(folio) ||
+	    folio_test_swapcache(folio) || folio_test_unevictable(folio))
+		return;
 
-		__count_vm_events(PGLAZYFREE, nr_pages);
-		__count_memcg_events(lruvec_memcg(lruvec), PGLAZYFREE,
-				     nr_pages);
-	}
+	lruvec_del_folio(lruvec, folio);
+	folio_clear_active(folio);
+	folio_clear_referenced(folio);
+	/*
+	 * Lazyfree folios are clean anonymous folios.  They have
+	 * the swapbacked flag cleared, to distinguish them from normal
+	 * anonymous folios
+	 */
+	folio_clear_swapbacked(folio);
+	lruvec_add_folio(lruvec, folio);
+
+	__count_vm_events(PGLAZYFREE, nr_pages);
+	__count_memcg_events(lruvec_memcg(lruvec), PGLAZYFREE, nr_pages);
 }
 
 /*
@@ -726,21 +734,21 @@ void deactivate_file_folio(struct folio *folio)
  */
 void folio_deactivate(struct folio *folio)
 {
-	if (!folio_test_unevictable(folio) && (folio_test_active(folio) ||
-	    lru_gen_enabled())) {
-		struct folio_batch *fbatch;
+	struct folio_batch *fbatch;
 
-		folio_get(folio);
-		if (!folio_test_clear_lru(folio)) {
-			folio_put(folio);
-			return;
-		}
+	if (folio_test_unevictable(folio) || !(folio_test_active(folio) || lru_gen_enabled()))
+		return;
 
-		local_lock(&cpu_fbatches.lock);
-		fbatch = this_cpu_ptr(&cpu_fbatches.lru_deactivate);
-		folio_batch_add_and_move(fbatch, folio, lru_deactivate_fn);
-		local_unlock(&cpu_fbatches.lock);
+	folio_get(folio);
+	if (!folio_test_clear_lru(folio)) {
+		folio_put(folio);
+		return;
 	}
+
+	local_lock(&cpu_fbatches.lock);
+	fbatch = this_cpu_ptr(&cpu_fbatches.lru_deactivate);
+	folio_batch_add_and_move(fbatch, folio, lru_deactivate_fn);
+	local_unlock(&cpu_fbatches.lock);
 }
 
 /**
@@ -752,21 +760,22 @@ void folio_deactivate(struct folio *folio)
  */
 void folio_mark_lazyfree(struct folio *folio)
 {
-	if (folio_test_anon(folio) && folio_test_swapbacked(folio) &&
-	    !folio_test_swapcache(folio) && !folio_test_unevictable(folio)) {
-		struct folio_batch *fbatch;
+	struct folio_batch *fbatch;
 
-		folio_get(folio);
-		if (!folio_test_clear_lru(folio)) {
-			folio_put(folio);
-			return;
-		}
+	if (!folio_test_anon(folio) || !folio_test_swapbacked(folio) ||
+	    folio_test_swapcache(folio) || folio_test_unevictable(folio))
+		return;
 
-		local_lock(&cpu_fbatches.lock);
-		fbatch = this_cpu_ptr(&cpu_fbatches.lru_lazyfree);
-		folio_batch_add_and_move(fbatch, folio, lru_lazyfree_fn);
-		local_unlock(&cpu_fbatches.lock);
+	folio_get(folio);
+	if (!folio_test_clear_lru(folio)) {
+		folio_put(folio);
+		return;
 	}
+
+	local_lock(&cpu_fbatches.lock);
+	fbatch = this_cpu_ptr(&cpu_fbatches.lru_lazyfree);
+	folio_batch_add_and_move(fbatch, folio, lru_lazyfree_fn);
+	local_unlock(&cpu_fbatches.lock);
 }
 
 void lru_add_drain(void)
-- 
2.45.2.803.g4e1b14247a-goog


