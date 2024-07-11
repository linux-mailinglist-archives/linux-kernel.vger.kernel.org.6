Return-Path: <linux-kernel+bounces-248518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E2192DE49
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08AA1F227D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE39338DD9;
	Thu, 11 Jul 2024 02:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ua92oq3Y"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D436D2E6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 02:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720664017; cv=none; b=ndaWYKltVXzch0MvrAvFVdF8mm28fTM+QG8txOaxG8XcfAYM+613oAJ5uHNWpi3vDclt/os4ncMmDjeZfcanJiiYsErzpmgXYSueN2HHDY/8Hs6Ui5AaTOYaQDi7Dh2+bcJ8BA7i5tqHErqLi7HBWIN4FiCWUxuBSdlJVrKTMw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720664017; c=relaxed/simple;
	bh=swOwdDH1NV4Az5FcwJyGuyop9Sm6BF+VY5nxNejLdHE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rZ8iShtYPw4FMqD3T5LZITa8X3VIxn8QCobC6sHAcBbU/7hQVP5+W4jPaLArbvIA9vtGA9X/6cUJ3MmP19z9NU47kDmhKEDY8UAKM6JSv1owKFHYhLAq1Mnwek+twhJsipFBmHvT+xuWTwTXBbGNmAbUaqm5FVFarL4Opy/tq9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ua92oq3Y; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65bbd01d146so5835557b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720664015; x=1721268815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NwEn3rgyWV9MRh72z1BbFtM83NQgy5RTa5P2H131skI=;
        b=ua92oq3Y77AfCbPrwb5EqH9nNKbsISkAysHWn53oNsTgzG3SdrPRnM4Twgwe8gUtGM
         sot65fMC/sobEO66w7jYdoli1LhzRltythIgqiQyzZpK7NxxhQzir5t4ZSEy4ZvSfG7N
         h5p/n0f2txfWxjwl3uLOlUBtrBdnQWgs7Mzql7JAAaU3AE3HG6dAKsVUL7Pnu3a/JQhp
         QNFsEJ7i7oWu3u+1tpe/B3+KuV8FUb9+U9Q1pmD7NX03k3CIm8WpkQXEc//mBLc9gBKQ
         5lRCzVv2xj5gSkqNwnw4VC1NSlAz/qpkBSqH48CT/7imOPrVxQ5lagjvGAyPPdlQ6VRD
         LW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720664015; x=1721268815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwEn3rgyWV9MRh72z1BbFtM83NQgy5RTa5P2H131skI=;
        b=j/XVObqjmkGG+wBLOv8Z0+QqgiNZn83MYWzlm6WpzC8HZb83B/a+rZa0wB5LuF0H2q
         9WSBKH2D2wwQOnnP+su0y8htsKd+NxmHBnBGEiL+hAjbMTocHD6jUp+3rAPXSyGdQO26
         oBkGJI1FrfUW6y91xZ1cUK01e+sesV/FHwfH8KTrYd4DjQCjQTQFUNoivFR2jyyTCGpm
         1bNCKWsHNJ530Uw5gAfURwMzei905NPEz+sY6EWFm8oo41mgAt9eS5D5VywMb7jXykxG
         W2uY63X+H+8ZFgKk6NWm7XxHRdObsw7myzISRT5W9HKQnw/KTo/aUVp28uA84ctAIpg6
         P9oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt9mxX2sLWJlBf04SkhqTUiF09vIsNJknX4BNbL+xYENpXt7GHYLRit/l4JPqlBkCjD24GipSZAVQe8hDIiOenPm/hR3fr4MZBYZfe
X-Gm-Message-State: AOJu0Yy2z4qDrFvJc/hNGobQeucLi9mezGge91VaBS4vHgiVWZpMXCn6
	XZlFczdokTAGFYXZcbWI5ttPH3T49rodUaTse+KJz/TXvS6GAuZBC5OTI09USovqvV/D87JSVFb
	UEg==
X-Google-Smtp-Source: AGHT+IEbVZmYW6DpRm49c6xD0RPJKOVNNtKwNJhKE+00HKB2nAyQq5npS5jud2Z6RbIqjV4/yQeeTz+gpoU=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:9b06:2f28:6675:a98b])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:158c:b0:e03:a0b2:f73 with SMTP id
 3f1490d57ef6-e041b05c952mr151870276.6.1720664015346; Wed, 10 Jul 2024
 19:13:35 -0700 (PDT)
Date: Wed, 10 Jul 2024 20:13:17 -0600
In-Reply-To: <20240711021317.596178-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711021317.596178-1-yuzhao@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240711021317.596178-6-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 5/5] mm/swap: remove boilerplate
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove boilerplate by using a macro to choose the corresponding lock
and handler for each folio_batch in cpu_fbatches.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/swap.c | 107 +++++++++++++++++++-----------------------------------
 1 file changed, 37 insertions(+), 70 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 4a66d2f87f26..342ff4e39ba4 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -220,16 +220,45 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 	folios_put(fbatch);
 }
 
-static void folio_batch_add_and_move(struct folio_batch *fbatch,
-		struct folio *folio, move_fn_t move_fn)
+static void __folio_batch_add_and_move(struct folio_batch *fbatch,
+		struct folio *folio, move_fn_t move_fn,
+		bool on_lru, bool disable_irq)
 {
+	unsigned long flags;
+
+	folio_get(folio);
+
+	if (on_lru && !folio_test_clear_lru(folio)) {
+		folio_put(folio);
+		return;
+	}
+
 	if (folio_batch_add(fbatch, folio) && !folio_test_large(folio) &&
 	    !lru_cache_disabled())
 		return;
 
+	if (disable_irq)
+		local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
+	else
+		local_lock(&cpu_fbatches.lock);
+
 	folio_batch_move_lru(fbatch, move_fn);
+
+	if (disable_irq)
+		local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
+	else
+		local_unlock(&cpu_fbatches.lock);
 }
 
+#define folio_batch_add_and_move(folio, op, on_lru)						\
+	__folio_batch_add_and_move(								\
+		this_cpu_ptr(&cpu_fbatches.op),							\
+		folio,										\
+		op,										\
+		on_lru,										\
+		offsetof(struct cpu_fbatches, op) > offsetof(struct cpu_fbatches, lock_irq)	\
+	)
+
 static void lru_move_tail(struct lruvec *lruvec, struct folio *folio)
 {
 	if (folio_test_unevictable(folio))
@@ -250,23 +279,11 @@ static void lru_move_tail(struct lruvec *lruvec, struct folio *folio)
  */
 void folio_rotate_reclaimable(struct folio *folio)
 {
-	struct folio_batch *fbatch;
-	unsigned long flags;
-
 	if (folio_test_locked(folio) || folio_test_dirty(folio) ||
 	    folio_test_unevictable(folio))
 		return;
 
-	folio_get(folio);
-	if (!folio_test_clear_lru(folio)) {
-		folio_put(folio);
-		return;
-	}
-
-	local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
-	fbatch = this_cpu_ptr(&cpu_fbatches.lru_move_tail);
-	folio_batch_add_and_move(fbatch, folio, lru_move_tail);
-	local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
+	folio_batch_add_and_move(folio, lru_move_tail, true);
 }
 
 void lru_note_cost(struct lruvec *lruvec, bool file,
@@ -355,21 +372,10 @@ static void folio_activate_drain(int cpu)
 
 void folio_activate(struct folio *folio)
 {
-	struct folio_batch *fbatch;
-
 	if (folio_test_active(folio) || folio_test_unevictable(folio))
 		return;
 
-	folio_get(folio);
-	if (!folio_test_clear_lru(folio)) {
-		folio_put(folio);
-		return;
-	}
-
-	local_lock(&cpu_fbatches.lock);
-	fbatch = this_cpu_ptr(&cpu_fbatches.lru_activate);
-	folio_batch_add_and_move(fbatch, folio, lru_activate);
-	local_unlock(&cpu_fbatches.lock);
+	folio_batch_add_and_move(folio, lru_activate, true);
 }
 
 #else
@@ -513,8 +519,6 @@ EXPORT_SYMBOL(folio_mark_accessed);
  */
 void folio_add_lru(struct folio *folio)
 {
-	struct folio_batch *fbatch;
-
 	VM_BUG_ON_FOLIO(folio_test_active(folio) &&
 			folio_test_unevictable(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
@@ -524,11 +528,7 @@ void folio_add_lru(struct folio *folio)
 	    lru_gen_in_fault() && !(current->flags & PF_MEMALLOC))
 		folio_set_active(folio);
 
-	folio_get(folio);
-	local_lock(&cpu_fbatches.lock);
-	fbatch = this_cpu_ptr(&cpu_fbatches.lru_add);
-	folio_batch_add_and_move(fbatch, folio, lru_add);
-	local_unlock(&cpu_fbatches.lock);
+	folio_batch_add_and_move(folio, lru_add, false);
 }
 EXPORT_SYMBOL(folio_add_lru);
 
@@ -702,22 +702,11 @@ void lru_add_drain_cpu(int cpu)
  */
 void deactivate_file_folio(struct folio *folio)
 {
-	struct folio_batch *fbatch;
-
 	/* Deactivating an unevictable folio will not accelerate reclaim */
 	if (folio_test_unevictable(folio))
 		return;
 
-	folio_get(folio);
-	if (!folio_test_clear_lru(folio)) {
-		folio_put(folio);
-		return;
-	}
-
-	local_lock(&cpu_fbatches.lock);
-	fbatch = this_cpu_ptr(&cpu_fbatches.lru_deactivate_file);
-	folio_batch_add_and_move(fbatch, folio, lru_deactivate_file);
-	local_unlock(&cpu_fbatches.lock);
+	folio_batch_add_and_move(folio, lru_deactivate_file, true);
 }
 
 /*
@@ -730,21 +719,10 @@ void deactivate_file_folio(struct folio *folio)
  */
 void folio_deactivate(struct folio *folio)
 {
-	struct folio_batch *fbatch;
-
 	if (folio_test_unevictable(folio) || !(folio_test_active(folio) || lru_gen_enabled()))
 		return;
 
-	folio_get(folio);
-	if (!folio_test_clear_lru(folio)) {
-		folio_put(folio);
-		return;
-	}
-
-	local_lock(&cpu_fbatches.lock);
-	fbatch = this_cpu_ptr(&cpu_fbatches.lru_deactivate);
-	folio_batch_add_and_move(fbatch, folio, lru_deactivate);
-	local_unlock(&cpu_fbatches.lock);
+	folio_batch_add_and_move(folio, lru_deactivate, true);
 }
 
 /**
@@ -756,22 +734,11 @@ void folio_deactivate(struct folio *folio)
  */
 void folio_mark_lazyfree(struct folio *folio)
 {
-	struct folio_batch *fbatch;
-
 	if (!folio_test_anon(folio) || !folio_test_swapbacked(folio) ||
 	    folio_test_swapcache(folio) || folio_test_unevictable(folio))
 		return;
 
-	folio_get(folio);
-	if (!folio_test_clear_lru(folio)) {
-		folio_put(folio);
-		return;
-	}
-
-	local_lock(&cpu_fbatches.lock);
-	fbatch = this_cpu_ptr(&cpu_fbatches.lru_lazyfree);
-	folio_batch_add_and_move(fbatch, folio, lru_lazyfree);
-	local_unlock(&cpu_fbatches.lock);
+	folio_batch_add_and_move(folio, lru_lazyfree, true);
 }
 
 void lru_add_drain(void)
-- 
2.45.2.803.g4e1b14247a-goog


