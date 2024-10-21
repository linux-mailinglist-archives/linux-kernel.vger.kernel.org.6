Return-Path: <linux-kernel+bounces-374723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB649A6EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124B0284138
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100D41D1F5D;
	Mon, 21 Oct 2024 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FSFlqe7f"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790EE1CBEAC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526557; cv=none; b=CEX3nrcKgcOB0PL7Q4jmOBwW5JiwzwIXW1wAjQUoInbhxLf6Y/AXLA8AA03mTPwge3EEUi+guSTWO2ulSNbb2XijIhJbj6+vL2V/Wg5iYOWDklmTT4eqFMZkokZ6LrI39e3iicDJ6fAEsHy5II/udnfRiKHCxp4EQdtHKn8WuSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526557; c=relaxed/simple;
	bh=AWbZedU+/iyeA5bLS4jAirLWZGBbH1WMGEm0Ke4wUDQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kXPkjhVDnZ60EetzP9zzNMPLj4ubF+JIzoKKB8czDBPvymAZyO6oGIu5ASlu3InjJcOLMAEkXLakwN6hXIkEV9XCBpVpsnR8dqigaKuGzzT8e82q6pEnJYCkRqrveTeVUpKBm485vr/9c0m2nr1QrgX6g5ULbqmF6D8od00oH2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FSFlqe7f; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1159159528so8011482276.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729526554; x=1730131354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xS8RR8lB059oPyR5mt7J0tawOIdChogU8TDyO7jPWP4=;
        b=FSFlqe7feptFxGdKLQKSjD5tB02Xma7WQi0iUwf1lnY7aiVdmMyECg95J2r5g9FWiA
         WVqg1wB7u6ZcUsbiLkIDz4vrAgGZq5jiAZlJtFlq+Fzhi33Vig/Sz9QpBOjy5f4ITknY
         CSr+lfSq9Q9ah3HcYXQ1J8QrxWobP5DsSBKt6wLsbcMHQ2u6xSYDCjJf5BLVHElchsTk
         zImvwsO+tEaO/3y3afn8k2aMWqfhDi+Ypn7ZMbALFVXvEMXk0wUU+ubDpfPEwguTXdN6
         bT27khofj5V1/7ArB1oP1W0An00m0KquHGCgRwIxWeXGdVi2neNW4yt14hiK+6YFrsTZ
         G9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729526554; x=1730131354;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xS8RR8lB059oPyR5mt7J0tawOIdChogU8TDyO7jPWP4=;
        b=HerNfm163uGA25Nf/MyVwJEEyfGterwi95BVgSVd2r8TS3oFeH9EBtQvQ/pa6EsiZ+
         nOULgl8AAyu9J0Yh1AhlPfbGlOIQdhSSGnlucoy4QlhTb3t0mTfBfYx+ocZU7k3i9iUm
         oDgMlqzpcjou3sVjtFWscFYN3xA12XQwv3jeH24sxYI/RxHMN2+2MAqlk2XAKdCjaAFC
         oSszh5m+l8kCVWVl6I4zRF8iTjXBxTCbRLaKcjPCQt9Kt0RWW5ZzF/0lpk3XMAjnIFiT
         5GrUw1zz52YgIWg52tu8BjzqQ05PZf5RZC6zwO0tTZfvIuZRAQRQ6JsZnKaQ6B9Q+Kox
         j/Qw==
X-Forwarded-Encrypted: i=1; AJvYcCV/InnzifYPuRfeqPr+vpw3ZvxKvw8+Rl/oNat21qnRYUTiODlwvk55QhqVnbzhdaVsRAGt5mAdKygXgf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZCH/vzyqHvRj2KjVuPgFbOLy9gPqO5nS8aq92zH2aIrFf6NKU
	5WFnh+63E5JtbU/w67uV7ijpqEdr3wh9e8ZczocxxWx53uIQEb7deHI1AHCS3eBjRTdvz7Q/Ofy
	fZtNfCBoWdS2Sezu2vg==
X-Google-Smtp-Source: AGHT+IGDNzg+raVpdy9asgo0adGMV8bfu1r5gOhX68FDbWgpgo+ybonbytlhVGcQ6fwb8NaxBtgJYObRec+ukV0u
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:13d:fb22:ac12:a84b])
 (user=jthoughton job=sendgmr) by 2002:a5b:503:0:b0:e29:7587:66d6 with SMTP id
 3f1490d57ef6-e2e245964c8mr62276.4.1729526554296; Mon, 21 Oct 2024 09:02:34
 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:02:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241021160212.9935-1-jthoughton@google.com>
Subject: [PATCH] mm: Add missing mmu_notifier_clear_young for !MMU_NOTIFIER
From: James Houghton <jthoughton@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: James Houghton <jthoughton@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Jason Gunthorpe <jgg@nvidia.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Remove the now unnecessary ifdef in mm/damon/vaddr.c as well.

Signed-off-by: James Houghton <jthoughton@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
---

Notes:
    This patch is originally from this series[1]. I've split up the MM and
    KVM bits of the series, and I have already sent the MGLRU changes
    here[2]. That leaves this small cleanup for DAMON.
    
    [1]: https://lore.kernel.org/kvm/20240926013506.860253-1-jthoughton@google.com/
    [2]: https://lore.kernel.org/kvm/20241019012940.3656292-1-jthoughton@google.com/

 include/linux/mmu_notifier.h | 7 +++++++
 mm/damon/vaddr.c             | 2 --
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index d39ebb10caeb..e2dd57ca368b 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -606,6 +606,13 @@ static inline int mmu_notifier_clear_flush_young(struct mm_struct *mm,
 	return 0;
 }
 
+static inline int mmu_notifier_clear_young(struct mm_struct *mm,
+					   unsigned long start,
+					   unsigned long end)
+{
+	return 0;
+}
+
 static inline int mmu_notifier_test_young(struct mm_struct *mm,
 					  unsigned long address)
 {
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 08cfd22b5249..821990d0141a 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -353,11 +353,9 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 		set_huge_pte_at(mm, addr, pte, entry, psize);
 	}
 
-#ifdef CONFIG_MMU_NOTIFIER
 	if (mmu_notifier_clear_young(mm, addr,
 				     addr + huge_page_size(hstate_vma(vma))))
 		referenced = true;
-#endif /* CONFIG_MMU_NOTIFIER */
 
 	if (referenced)
 		folio_set_young(folio);

base-commit: b5d43fad926a3f542cd06f3c9d286f6f489f7129
-- 
2.47.0.105.g07ac214952-goog


