Return-Path: <linux-kernel+bounces-426870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6F19DF995
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA88281AF5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 03:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189C31E32A6;
	Mon,  2 Dec 2024 03:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXNWXk4r"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33AF1E2831
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 03:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733110115; cv=none; b=U6fANGXHOWYgy1T5573bNavE5P1GhE7gh+z03i4EdjIP+/EqRVL2puP7xvZ7EwcEEsSeSrbKYrHFNmBqQbkmFF7C1UG9zA9JUfWtZS2ssgmxNPT+QIHhKi+610mbJXecAL1HDweHQSfw7JCiKjQfobpKYtWF3eFNupmVGpec8Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733110115; c=relaxed/simple;
	bh=1hD1lletugdyH+qz+YPYmDUibRXlcEodpBsnm0JbD9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AfKz5iw7hqLuHTVso/K8lcn14U9jGfumLTirdk/p7hxzNxBHTrJVR05d/ywts5My9uDTp0/Zjk8Tkp5/mI2yYHYnxtvI4cLtjhRnWXaS9UB8ucW8m0VKS+bwuZWCWWLo0Mp3V4N/DSrlsk6XU+dXe5ePlaetZ/iwmfJoaAtM/uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XXNWXk4r; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7eaac1e95ffso2852010a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 19:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733110113; x=1733714913; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MW8P2vBtR0tiHVuNXF698UnUQTzNbjkVYUdDrWgvFuo=;
        b=XXNWXk4rJwIEewNnjHrVwNzvH9G2BT7bkEZsQjD8OvE8frMeIerCNgSImEBtcMB0QY
         e1vlyjIAIO8nWPwWQpe3C1ziDY3pD11mZbBROKrGKLD4vg4wEE0Ep34G5PGAuCW4JU+p
         PFSPo1GP3K4iIooRl2HGFZa/y+hOL+njBB474hKbWKvW7u68jnFw4GghhLB42KK0wDOZ
         q4yrtFPEak0S/YAiiQwuzhy+ukKF7WG1fh0V9aY99dOqC+s04e+foCP2YN1tvHnhpY/D
         hL5f11cMAwlh3lIYqrvkI70re1w+2CdMonbFpyOaOu/tcmH9N/GpCre2Djws8mOJmif9
         Udkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733110113; x=1733714913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MW8P2vBtR0tiHVuNXF698UnUQTzNbjkVYUdDrWgvFuo=;
        b=YQhpU6gvFjuwGoVejcRJHXLvnx7k0ZxjOYTkoWVPfp4bhm0emTsbQgiBVokPD9Jz5U
         Ppm+FyEofJEM3YWs1eUYWEMVz/gs5VUTrMAB+si7FdEbBrAVt23w/TsUT6x+umGse1Lv
         SSC2WYr613g2qtNVGSihFKjAU9Cfrt+EBW7/bbAPf6Af+mTMGWdPDjJ9Tr0GqohhpFe2
         35dIyhhwTgOVLO0OD/iLylhzV9kqJHmldmyNArQYyqBH3iw9t3iOKwfuxG53exicnEKl
         uhRhj3IRzwy6qBaGYMvp6xRlFJmOVJJNRFCDrSR+XBI1O+DY0OHLOdM1ccb38OYVsmoB
         jtDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5wjdqsFD/AfnHOl2aDbFE3sWhh4IFyIzUMShZO64cNBVZiKVi3VaXGDflalKyYA4XRjih8qSGQyd6AVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkg4EO75q2L85WYjeyJEHj5HaAckC0p3lnppOEgRb95EJY1wdv
	rcjcu7/mHNGhDdsT03YXmTR0rhxxOq6WFDFR4dWfT8xCfZ5XPyDv8xDL6iqdIrZGAlRufKgFGz7
	BPQ==
X-Google-Smtp-Source: AGHT+IFcUZRmwT3M3+dp5We5TbG1PhbrCpT/ilv6sNt1Wnzg29EAa63YEsnLXpC87arqRV9kgWQHWdyeDzU=
X-Received: from pgct22.prod.google.com ([2002:a05:6a02:5296:b0:7fb:e344:7ca0])
 (user=yuzhao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d9e:b0:1db:915b:ab11
 with SMTP id adf61e73a8af0-1e0e0b0f11cmr32948241637.24.1733110113337; Sun, 01
 Dec 2024 19:28:33 -0800 (PST)
Date: Sun,  1 Dec 2024 20:28:19 -0700
In-Reply-To: <20241202032823.2741019-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241202032823.2741019-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202032823.2741019-3-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 2/6] mm/mglru: optimize deactivation
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Bharata B Rao <bharata@amd.com>, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"

Do not shuffle a folio in the deactivation paths if it is already in
the oldest generation. This reduces the LRU lock contention.

Before this patch, the contention is reproducible by FIO, e.g.,

  fio -filename=/dev/nvme1n1p2 -direct=0 -thread -size=1024G \
      -rwmixwrite=30  --norandommap --randrepeat=0 -ioengine=sync \
      -bs=4k -numjobs=400 -runtime=25000 --time_based \
      -group_reporting -name=mglru

  98.96%--_raw_spin_lock_irqsave
          folio_lruvec_lock_irqsave
          |
           --98.78%--folio_batch_move_lru
               |
                --98.63%--deactivate_file_folio
                          mapping_try_invalidate
                          invalidate_mapping_pages
                          invalidate_bdev
                          blkdev_common_ioctl
                          blkdev_ioctl

After this patch, deactivate_file_folio() bails out early without
taking the LRU lock.

A side effect is that a folio can be left at the head of the oldest
generation, rather than the tail. If reclaim happens at the same time,
it cannot reclaim this folio immediately. Since there is no known
correlation between truncation and reclaim, this side effect is
considered insignificant.

Reported-by: Bharata B Rao <bharata@amd.com>
Closes: https://lore.kernel.org/CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com/
Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Kalesh Singh <kaleshsingh@google.com>
---
 mm/swap.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 3a01acfd5a89..15a94be8b0af 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -379,7 +379,8 @@ static void __lru_cache_activate_folio(struct folio *folio)
 }
 
 #ifdef CONFIG_LRU_GEN
-static void folio_inc_refs(struct folio *folio)
+
+static void lru_gen_inc_refs(struct folio *folio)
 {
 	unsigned long new_flags, old_flags = READ_ONCE(folio->flags);
 
@@ -406,10 +407,30 @@ static void folio_inc_refs(struct folio *folio)
 		new_flags |= old_flags & ~LRU_REFS_MASK;
 	} while (!try_cmpxchg(&folio->flags, &old_flags, new_flags));
 }
-#else
-static void folio_inc_refs(struct folio *folio)
+
+static bool lru_gen_clear_refs(struct folio *folio)
 {
+	int gen = folio_lru_gen(folio);
+	int type = folio_is_file_lru(folio);
+	struct lru_gen_folio *lrugen = &folio_lruvec(folio)->lrugen;
+
+	set_mask_bits(&folio->flags, LRU_REFS_MASK | LRU_REFS_FLAGS, 0);
+
+	/* whether can do without shuffling under the LRU lock */
+	return gen == lru_gen_from_seq(READ_ONCE(lrugen->min_seq[type]));
 }
+
+#else /* !CONFIG_LRU_GEN */
+
+static void lru_gen_inc_refs(struct folio *folio)
+{
+}
+
+static bool lru_gen_clear_refs(struct folio *folio)
+{
+	return false;
+}
+
 #endif /* CONFIG_LRU_GEN */
 
 /**
@@ -428,7 +449,7 @@ static void folio_inc_refs(struct folio *folio)
 void folio_mark_accessed(struct folio *folio)
 {
 	if (lru_gen_enabled()) {
-		folio_inc_refs(folio);
+		lru_gen_inc_refs(folio);
 		return;
 	}
 
@@ -524,7 +545,7 @@ void folio_add_lru_vma(struct folio *folio, struct vm_area_struct *vma)
  */
 static void lru_deactivate_file(struct lruvec *lruvec, struct folio *folio)
 {
-	bool active = folio_test_active(folio);
+	bool active = folio_test_active(folio) || lru_gen_enabled();
 	long nr_pages = folio_nr_pages(folio);
 
 	if (folio_test_unevictable(folio))
@@ -589,7 +610,10 @@ static void lru_lazyfree(struct lruvec *lruvec, struct folio *folio)
 
 	lruvec_del_folio(lruvec, folio);
 	folio_clear_active(folio);
-	folio_clear_referenced(folio);
+	if (lru_gen_enabled())
+		lru_gen_clear_refs(folio);
+	else
+		folio_clear_referenced(folio);
 	/*
 	 * Lazyfree folios are clean anonymous folios.  They have
 	 * the swapbacked flag cleared, to distinguish them from normal
@@ -657,6 +681,9 @@ void deactivate_file_folio(struct folio *folio)
 	if (folio_test_unevictable(folio))
 		return;
 
+	if (lru_gen_enabled() && lru_gen_clear_refs(folio))
+		return;
+
 	folio_batch_add_and_move(folio, lru_deactivate_file, true);
 }
 
@@ -670,7 +697,10 @@ void deactivate_file_folio(struct folio *folio)
  */
 void folio_deactivate(struct folio *folio)
 {
-	if (folio_test_unevictable(folio) || !(folio_test_active(folio) || lru_gen_enabled()))
+	if (folio_test_unevictable(folio))
+		return;
+
+	if (lru_gen_enabled() ? lru_gen_clear_refs(folio) : !folio_test_active(folio))
 		return;
 
 	folio_batch_add_and_move(folio, lru_deactivate, true);
-- 
2.47.0.338.g60cca15819-goog


