Return-Path: <linux-kernel+bounces-248516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7C592DE47
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B26BB22A45
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CCF18EAF;
	Thu, 11 Jul 2024 02:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bwACksfq"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F009C12E7C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720664012; cv=none; b=C0ILRFW1A19IGPkjB1KJXDHRTdirwZxIYvOqloBVbP4ODJF+Z4ZPiusHzQFu6HRoJl/bsSYjM7WPFsJNJPxcX+TsEF+kHD6SeZAyx1gHZQjNxIg7bLfednPgolLfYPyMBsAK6GYgO3ejFev5uM0BDzBdxlAl//VBmX/5/wXgRNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720664012; c=relaxed/simple;
	bh=iP/ws+ycbMf6bFYw1o6xwD5xNp9ysgzyHcMAdbVxrCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LqtBobZRIA+IGK1J4H1NJh6z19pxriFdtCPialnG2byTywj9+3Y5Y3z4G9SUarYgchgWugg1OuQU3xkOsRc1gV36ZFtu9+UuBOupUI5PbqYkAMCXUij7kAkhRfyw9W+2iWMj2ooxABcuCxqICU9IrS2Knof+KvFiupJvurMI9iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bwACksfq; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035f7b5976so889978276.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720664010; x=1721268810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WhNUH7SAP/MNFXjYcDX49dOz4gKNgHUZEXTQwt2QQyA=;
        b=bwACksfqADURhXe3ZpGx5vk82DATvkoud8XnfKC5vdB9ugqFu1arCVUSgwd3VPInl8
         lCScRksq7iyedqNZtnQyXxbxlzpvfP1IJJiKKOWGM0ov0JyqEmNxgOVqxzGOSOd74iRm
         Ni+edC9oGCCO8qmGjBLXaDCW4nZIARKc6sohgduAk53N3mUKDeBlRTB00JLt0i2UQdit
         XsJpqjqvtb66NRSUv6VCJ1YHJgazXPy5vncRK4SfeA2gb70RtGD6GjwAOiAf4D3jReoR
         oOhnJ32C4m5AzqMYvi6cQlVr9adxgOoTGD3kZsyNz2TkchCyCZVV8opva0G6OwPDQa/n
         +rpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720664010; x=1721268810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WhNUH7SAP/MNFXjYcDX49dOz4gKNgHUZEXTQwt2QQyA=;
        b=BaabCgXleJ6zRYKIlnUe4w27VjyLCR6D2gq8l1dIREc5RNXmWn8S5voVQzQWRYYi6P
         hFKh0JPtRVwrD9a6CAThh/L2UdgkvWI73GKqjBBxMcRjvAXkUqb748F0Q0Thhyeu0AB2
         XaG81qh53mTtqGrVvrv3n2CldPMMTgIxWCebXdX3D69lZGNag2m9Jr53wO1gBs0auOKB
         sfrxogVrG1p68FppfFHgaALG/mvgbbqQ+dKwdEuw1JL2xa5cXIkSIkNujVHQU3n9jOLW
         JDfTwVDLg6dOQTJHLkeTQsytv1FpDDn+afarNH8D4qP1xwnTvQ6yThWQpGbDCYkQkF3a
         3YhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmDDmI3T4TlztEcuIrp5RnXodiV8gHgvjvvl1TNCUfroDsUI/hWdfW5iDrPue6qkabwtm0r/bLSDqGprZkfQX1MMt9aIoDXUNA7NtN
X-Gm-Message-State: AOJu0Yx50vgMDRAsGeXl0qzVvBz6VP4yKXKDkX+xuj+2NFjDqJPy9I9K
	JD3QTA+/y8exUGrwvuUds01LR7JWPYFiZVXmp/yeJt19OvVrIUUOEEdW8QbrNXY9OxjLnUL2oln
	pQg==
X-Google-Smtp-Source: AGHT+IGkIwS4bVyfM5ByoYpmZQq2iqjOHx1IN9uZ+1eS+2/SoQ8AfYNeitOzBddCLqNu0G2MAu021nNjM8U=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:9b06:2f28:6675:a98b])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:32a6:b0:e03:61bb:6032 with SMTP id
 3f1490d57ef6-e0577fa164amr20670276.1.1720664010014; Wed, 10 Jul 2024 19:13:30
 -0700 (PDT)
Date: Wed, 10 Jul 2024 20:13:15 -0600
In-Reply-To: <20240711021317.596178-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711021317.596178-1-yuzhao@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240711021317.596178-4-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 3/5] mm/swap: fold lru_rotate into cpu_fbatches
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Fold lru_rotate into cpu_fbatches, and rename the folio_batch and the
lock protecting it to lru_move_tail and lock_irq respectively so that
all the boilerplate can be removed at the end of this series.

Also remove data_race() around folio_batch_count(), which is out of
place: all folio_batch_count() calls on remote cpu_fbatches are
subject to data_race(), and therefore data_race() should be inside
folio_batch_count().

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/swap.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index e4745b88a964..774ae9eab1e6 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -47,20 +47,11 @@
 int page_cluster;
 const int page_cluster_max = 31;
 
-/* Protecting only lru_rotate.fbatch which requires disabling interrupts */
-struct lru_rotate {
-	local_lock_t lock;
-	struct folio_batch fbatch;
-};
-static DEFINE_PER_CPU(struct lru_rotate, lru_rotate) = {
-	.lock = INIT_LOCAL_LOCK(lock),
-};
-
-/*
- * The following folio batches are grouped together because they are protected
- * by disabling preemption (and interrupts remain enabled).
- */
 struct cpu_fbatches {
+	/*
+	 * The following folio batches are grouped together because they are protected
+	 * by disabling preemption (and interrupts remain enabled).
+	 */
 	local_lock_t lock;
 	struct folio_batch lru_add;
 	struct folio_batch lru_deactivate_file;
@@ -69,9 +60,14 @@ struct cpu_fbatches {
 #ifdef CONFIG_SMP
 	struct folio_batch lru_activate;
 #endif
+	/* Protecting the following batches which require disabling interrupts */
+	local_lock_t lock_irq;
+	struct folio_batch lru_move_tail;
 };
+
 static DEFINE_PER_CPU(struct cpu_fbatches, cpu_fbatches) = {
 	.lock = INIT_LOCAL_LOCK(lock),
+	.lock_irq = INIT_LOCAL_LOCK(lock_irq),
 };
 
 static void __page_cache_release(struct folio *folio, struct lruvec **lruvecp,
@@ -267,10 +263,10 @@ void folio_rotate_reclaimable(struct folio *folio)
 		return;
 	}
 
-	local_lock_irqsave(&lru_rotate.lock, flags);
-	fbatch = this_cpu_ptr(&lru_rotate.fbatch);
+	local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
+	fbatch = this_cpu_ptr(&cpu_fbatches.lru_move_tail);
 	folio_batch_add_and_move(fbatch, folio, lru_move_tail_fn);
-	local_unlock_irqrestore(&lru_rotate.lock, flags);
+	local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
 }
 
 void lru_note_cost(struct lruvec *lruvec, bool file,
@@ -668,15 +664,15 @@ void lru_add_drain_cpu(int cpu)
 	if (folio_batch_count(fbatch))
 		folio_batch_move_lru(fbatch, lru_add_fn);
 
-	fbatch = &per_cpu(lru_rotate.fbatch, cpu);
+	fbatch = &fbatches->lru_move_tail;
 	/* Disabling interrupts below acts as a compiler barrier. */
 	if (data_race(folio_batch_count(fbatch))) {
 		unsigned long flags;
 
 		/* No harm done if a racing interrupt already did this */
-		local_lock_irqsave(&lru_rotate.lock, flags);
+		local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
 		folio_batch_move_lru(fbatch, lru_move_tail_fn);
-		local_unlock_irqrestore(&lru_rotate.lock, flags);
+		local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
 	}
 
 	fbatch = &fbatches->lru_deactivate_file;
@@ -825,7 +821,7 @@ static bool cpu_needs_drain(unsigned int cpu)
 
 	/* Check these in order of likelihood that they're not zero */
 	return folio_batch_count(&fbatches->lru_add) ||
-		data_race(folio_batch_count(&per_cpu(lru_rotate.fbatch, cpu))) ||
+		folio_batch_count(&fbatches->lru_move_tail) ||
 		folio_batch_count(&fbatches->lru_deactivate_file) ||
 		folio_batch_count(&fbatches->lru_deactivate) ||
 		folio_batch_count(&fbatches->lru_lazyfree) ||
-- 
2.45.2.803.g4e1b14247a-goog


