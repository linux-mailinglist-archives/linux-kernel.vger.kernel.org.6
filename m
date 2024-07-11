Return-Path: <linux-kernel+bounces-248517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B8892DE48
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A530CB2291D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0482DD28D;
	Thu, 11 Jul 2024 02:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PnWirced"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04901C686
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 02:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720664015; cv=none; b=kVSPKLRY1cUGdLsQmNNsZDkYuf6fW6nz5lFqwFhQw0qCL+c10uNSdPYbM5/WFSIbttjAwIhL8heU7S24V83t93LMdwLNvvH+qubKXzeMHh2BWXBvUFTkTjdgzoP6veCbQDcmS3H/OAzPNTiYo5dazoqhjD9Xwu8PgIrzJdOyHfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720664015; c=relaxed/simple;
	bh=DW9P12l/Vxqw6YA4KHi8AXt6xBkY2xccCQhFjXmnCoY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HwcjmGp+QXZRr4jH2VkJPkBCeh15C6bWF4/VPJS5rgftugVM3pRfcNDjaNLApbubyrjO84XciGx9QeA8kLqeJEL7PZWJu1LJuw4pXZtHrTUczer9XLl4AwI+MWqhGe5AczIfxMMqx387Gq3HWkhRmwUQ1DN4uWnNpzO/VMHN95Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PnWirced; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64a5503e253so6866607b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720664012; x=1721268812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6RCNHIc0/84Yq5SbDOD6xZQS6zwZu2n7K7QhObKOUEk=;
        b=PnWircedP1xM/JbRBTbBGQcKK3CIMVl9ehb2282jutMLdqS339LgcTshxysRD3W980
         sLW59G2PreqEFeosJjIz4wbtXo3K5M2HcTZSo1ddhpJ7C1xiv9xNDuPnvLQmP6XCakIE
         BdQIbbHaoUqdJweBJn+tg6GDLv7BvvTDnAk15Y569HJHkAonxfmTwqHu2ydv7c1+2LNR
         SPcCE8iRVcFWazAvBux4hpOC0PJMEmQQIxav/uWXFNv6hA/5m0TbvqnbTP3KvYW2eocx
         44CY2afudo/VJ1WlRmJ9UcWVxwGbIQ5db/16GY3tnaDrUF3RNGToWiVgFey9A3uN+RoP
         NLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720664012; x=1721268812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RCNHIc0/84Yq5SbDOD6xZQS6zwZu2n7K7QhObKOUEk=;
        b=U+hRGeinE8dGQx/DP+NIlSBe+HF6Zfov3YIgNONX9bOudRcWr7G7VrHYr2GiYpLcSb
         W5uMJtvqP13Qgsxqx3SxmGfPW865vg868AhzJvm1G6OM/AoJP8IYKvKwmLWxgqKUxh8U
         Jzs7tzMhUGBBtH1//T17BHnNKnjb6Nugqqmlf0m+w5hGGf2Ll6ThnSn0edWp5iGSst9o
         /BKOOOJFcEk7SPYtEn2ZO9Qh4aCdFEP+70OMI/4JnaDhKtv3sfknabd6gVLsqAb7Fx5u
         vMqwoeOIhpBigYrhRingA/9cA4OG3ssZL1c8wtTbaMtJywtMzpVhlUyILjdFqw/aJxYj
         ZjrA==
X-Forwarded-Encrypted: i=1; AJvYcCX4gJe8EAy3faa/MRzZPXeN31iiZJTjYVAzsTt4ZuEhYbZMQ53o3L+nH8+NRUZDhrpleXg4Q7a4gF01hI6JZOZom66SIXK0+8o2lif/
X-Gm-Message-State: AOJu0YwQSydRHVWXbhbeTgmu0NQuVnEbpl2LZ/YFdtwJRnFNyQ36A8XU
	8wgBW1U0sPVzveJ+MsdzzNrZTedmOmb8Xeg6ENLdAMmgm5yes+0QD+PqG2YDbHFtzOYaHdHwSF2
	qWQ==
X-Google-Smtp-Source: AGHT+IGs4gFVi/kxatEGxz/B1lm3LDZuehH0XgpGsn3CIFnEqcrCXAfD8VgVg/nDjjGVQUAHTzXmxtBJ/OQ=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:9b06:2f28:6675:a98b])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:2101:b0:e03:31ec:8a24 with SMTP id
 3f1490d57ef6-e041b17dfb5mr397954276.8.1720664012653; Wed, 10 Jul 2024
 19:13:32 -0700 (PDT)
Date: Wed, 10 Jul 2024 20:13:16 -0600
In-Reply-To: <20240711021317.596178-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711021317.596178-1-yuzhao@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240711021317.596178-5-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 4/5] mm/swap: remove remaining _fn suffix
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove remaining _fn suffix from cpu_fbatches handlers, which are
already self-explanatory.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/swap.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 774ae9eab1e6..4a66d2f87f26 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -160,7 +160,7 @@ EXPORT_SYMBOL(put_pages_list);
 
 typedef void (*move_fn_t)(struct lruvec *lruvec, struct folio *folio);
 
-static void lru_add_fn(struct lruvec *lruvec, struct folio *folio)
+static void lru_add(struct lruvec *lruvec, struct folio *folio)
 {
 	int was_unevictable = folio_test_clear_unevictable(folio);
 	long nr_pages = folio_nr_pages(folio);
@@ -230,7 +230,7 @@ static void folio_batch_add_and_move(struct folio_batch *fbatch,
 	folio_batch_move_lru(fbatch, move_fn);
 }
 
-static void lru_move_tail_fn(struct lruvec *lruvec, struct folio *folio)
+static void lru_move_tail(struct lruvec *lruvec, struct folio *folio)
 {
 	if (folio_test_unevictable(folio))
 		return;
@@ -265,7 +265,7 @@ void folio_rotate_reclaimable(struct folio *folio)
 
 	local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
 	fbatch = this_cpu_ptr(&cpu_fbatches.lru_move_tail);
-	folio_batch_add_and_move(fbatch, folio, lru_move_tail_fn);
+	folio_batch_add_and_move(fbatch, folio, lru_move_tail);
 	local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
 }
 
@@ -527,7 +527,7 @@ void folio_add_lru(struct folio *folio)
 	folio_get(folio);
 	local_lock(&cpu_fbatches.lock);
 	fbatch = this_cpu_ptr(&cpu_fbatches.lru_add);
-	folio_batch_add_and_move(fbatch, folio, lru_add_fn);
+	folio_batch_add_and_move(fbatch, folio, lru_add);
 	local_unlock(&cpu_fbatches.lock);
 }
 EXPORT_SYMBOL(folio_add_lru);
@@ -571,7 +571,7 @@ void folio_add_lru_vma(struct folio *folio, struct vm_area_struct *vma)
  * written out by flusher threads as this is much more efficient
  * than the single-page writeout from reclaim.
  */
-static void lru_deactivate_file_fn(struct lruvec *lruvec, struct folio *folio)
+static void lru_deactivate_file(struct lruvec *lruvec, struct folio *folio)
 {
 	bool active = folio_test_active(folio);
 	long nr_pages = folio_nr_pages(folio);
@@ -612,7 +612,7 @@ static void lru_deactivate_file_fn(struct lruvec *lruvec, struct folio *folio)
 	}
 }
 
-static void lru_deactivate_fn(struct lruvec *lruvec, struct folio *folio)
+static void lru_deactivate(struct lruvec *lruvec, struct folio *folio)
 {
 	long nr_pages = folio_nr_pages(folio);
 
@@ -628,7 +628,7 @@ static void lru_deactivate_fn(struct lruvec *lruvec, struct folio *folio)
 	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_pages);
 }
 
-static void lru_lazyfree_fn(struct lruvec *lruvec, struct folio *folio)
+static void lru_lazyfree(struct lruvec *lruvec, struct folio *folio)
 {
 	long nr_pages = folio_nr_pages(folio);
 
@@ -662,7 +662,7 @@ void lru_add_drain_cpu(int cpu)
 	struct folio_batch *fbatch = &fbatches->lru_add;
 
 	if (folio_batch_count(fbatch))
-		folio_batch_move_lru(fbatch, lru_add_fn);
+		folio_batch_move_lru(fbatch, lru_add);
 
 	fbatch = &fbatches->lru_move_tail;
 	/* Disabling interrupts below acts as a compiler barrier. */
@@ -671,21 +671,21 @@ void lru_add_drain_cpu(int cpu)
 
 		/* No harm done if a racing interrupt already did this */
 		local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
-		folio_batch_move_lru(fbatch, lru_move_tail_fn);
+		folio_batch_move_lru(fbatch, lru_move_tail);
 		local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
 	}
 
 	fbatch = &fbatches->lru_deactivate_file;
 	if (folio_batch_count(fbatch))
-		folio_batch_move_lru(fbatch, lru_deactivate_file_fn);
+		folio_batch_move_lru(fbatch, lru_deactivate_file);
 
 	fbatch = &fbatches->lru_deactivate;
 	if (folio_batch_count(fbatch))
-		folio_batch_move_lru(fbatch, lru_deactivate_fn);
+		folio_batch_move_lru(fbatch, lru_deactivate);
 
 	fbatch = &fbatches->lru_lazyfree;
 	if (folio_batch_count(fbatch))
-		folio_batch_move_lru(fbatch, lru_lazyfree_fn);
+		folio_batch_move_lru(fbatch, lru_lazyfree);
 
 	folio_activate_drain(cpu);
 }
@@ -716,7 +716,7 @@ void deactivate_file_folio(struct folio *folio)
 
 	local_lock(&cpu_fbatches.lock);
 	fbatch = this_cpu_ptr(&cpu_fbatches.lru_deactivate_file);
-	folio_batch_add_and_move(fbatch, folio, lru_deactivate_file_fn);
+	folio_batch_add_and_move(fbatch, folio, lru_deactivate_file);
 	local_unlock(&cpu_fbatches.lock);
 }
 
@@ -743,7 +743,7 @@ void folio_deactivate(struct folio *folio)
 
 	local_lock(&cpu_fbatches.lock);
 	fbatch = this_cpu_ptr(&cpu_fbatches.lru_deactivate);
-	folio_batch_add_and_move(fbatch, folio, lru_deactivate_fn);
+	folio_batch_add_and_move(fbatch, folio, lru_deactivate);
 	local_unlock(&cpu_fbatches.lock);
 }
 
@@ -770,7 +770,7 @@ void folio_mark_lazyfree(struct folio *folio)
 
 	local_lock(&cpu_fbatches.lock);
 	fbatch = this_cpu_ptr(&cpu_fbatches.lru_lazyfree);
-	folio_batch_add_and_move(fbatch, folio, lru_lazyfree_fn);
+	folio_batch_add_and_move(fbatch, folio, lru_lazyfree);
 	local_unlock(&cpu_fbatches.lock);
 }
 
-- 
2.45.2.803.g4e1b14247a-goog


