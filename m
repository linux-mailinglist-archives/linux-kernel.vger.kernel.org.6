Return-Path: <linux-kernel+bounces-436205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7325F9E8273
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 23:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288F128113D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F751547E3;
	Sat,  7 Dec 2024 22:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mEK6QgPD"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA7A1922C0
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733609733; cv=none; b=GeUiQPHdEEOnnYkmkZEp7rUwhmCVHKCwpVrsHXmEV2mvQvrXaEih1O2lb/kJXoqPrd0Rr0H9RdLSBsy4moonO3Xi34lD74UJJrGeBfFeNPfyT2laBS/aBIvDi65tVFgzNqbifWj7wROQQP6lb6uVc4e/PFdj50Z8aBReQkDyCsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733609733; c=relaxed/simple;
	bh=vXP0qU9PAGACWPwiNw1lO5Aef0HXGX3T4TbaUosNZ7w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fjdhUc8TccPOs7+td6GoQThwkao06CpQeuRKLvQ7qD3enuG7P4L0ICTMwcTbyGBol7Vel/SEGNdVm2jN6rnPQiFX6YyKKFLcYl/bin5A84a8RRJCHPsXUK0adJ10fzrmA9EO+5HlyPXPnDxIXD5UrhuYJUce3yF+kVH5PivgcAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mEK6QgPD; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-725c36cdc5cso1444383b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 14:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733609731; x=1734214531; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CCT5euYl/qJQPeGGazPVJuZRHShIdP4mKhuDso53GD0=;
        b=mEK6QgPDv7VfHh2Fd83PBlfig5t6fJQrG6VxF2KvCum1Q09CmN5FBcC1VbsqEx/Z3n
         MneGykg1Tzk8t3Amj7R3HIUF3u5u0hEjpMX0v8Wec6LelSzrWzeZURfReqIDdqGHndFg
         5TkbinCvgQOu8unC4sPj9vS4D3eaxyEXTTon6lUnIAzTzuFKN5KvRHcZpzt1bIYoD0Qg
         wJjKo92NYBHU+nW5WHvNAfw4LxclhP57K8KnTAW8HtVNSvu3Trtu0+BZvVvcVlnbmWnk
         Uplk9ec2h7APyB6gIuUiKMoqs6lDj5nwa7DULVLYKUh8X9k6AV4TxImtvn4Jt66p5Uf3
         ZGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733609731; x=1734214531;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCT5euYl/qJQPeGGazPVJuZRHShIdP4mKhuDso53GD0=;
        b=k+UKJFZj+cbiy1DA7Y+4kf2iv7putKv2NOEW5kleRVfvfJn+3IkoHh+u0PFSNvODkV
         vSEAHswGYrZvVYY6P1duYlapAPyRRg69IxUoKl3MKnCg8vSGDoyfJWINNpre+wPX+mWB
         L84rLuTpsHQSKGRx+fQKHPQj78j+4KtbRkC4C/hemzC16Wn3y8bG1nzU6ydlj5UVlGKX
         xpcG8e25KsICTASDsPkcDvwewfxDsRSGZy9fyXepdoovkqVWJwkME+5uuldzwLXtwOle
         351N+HeesoX+dAE1kOoe3DXLJJuP6U9NQt5l3qcjSbI8XH7v5iwkvl2D3IvXyU3v+6aK
         l1fA==
X-Forwarded-Encrypted: i=1; AJvYcCVrH7SeodctE7AjZFGCUuDMoAFfJLjoszMgSaEMV3WR/MuIbgYsRM6FuoQH28UnbetWrFZcIvOrfaaxrNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWNjaFNQnA0mvZgh+zhPnxWFZBlpd/e7o3HPmHq/WO+O1/hEQJ
	O/bkI9dYF0CeJizjiDeBZbslaoYfeoHlg0OShEDTsTPLMgSOVzCzjrapCNNdOX72GLZq1fBIvgJ
	k2A==
X-Google-Smtp-Source: AGHT+IEX0/0XlihpBl2av7TPcnGj//5IebmVqNnUYSl/vdQwzILN65v6v1O4wV+Mrra4vxLhPsMYzWB6m58=
X-Received: from pfbbe12.prod.google.com ([2002:a05:6a00:1f0c:b0:724:ec9d:6e1a])
 (user=yuzhao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2381:b0:71e:573f:5673
 with SMTP id d2e1a72fcca58-725b8144a42mr8420603b3a.15.1733609731167; Sat, 07
 Dec 2024 14:15:31 -0800 (PST)
Date: Sat,  7 Dec 2024 15:15:18 -0700
In-Reply-To: <20241207221522.2250311-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241207221522.2250311-1-yuzhao@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241207221522.2250311-3-yuzhao@google.com>
Subject: [PATCH mm-unstable v3 2/6] mm/mglru: optimize deactivation
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
 mm/swap.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 3a01acfd5a89..756b6c5b9af7 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -379,11 +379,12 @@ static void __lru_cache_activate_folio(struct folio *folio)
 }
 
 #ifdef CONFIG_LRU_GEN
-static void folio_inc_refs(struct folio *folio)
+
+static void lru_gen_inc_refs(struct folio *folio)
 {
 	unsigned long new_flags, old_flags = READ_ONCE(folio->flags);
 
-	if (folio_test_unevictable(folio))
+	if (!folio_test_lru(folio) || folio_test_unevictable(folio))
 		return;
 
 	if (!folio_test_referenced(folio)) {
@@ -406,10 +407,33 @@ static void folio_inc_refs(struct folio *folio)
 		new_flags |= old_flags & ~LRU_REFS_MASK;
 	} while (!try_cmpxchg(&folio->flags, &old_flags, new_flags));
 }
-#else
-static void folio_inc_refs(struct folio *folio)
+
+static bool lru_gen_clear_refs(struct folio *folio)
 {
+	struct lru_gen_folio *lrugen;
+	int type = folio_is_file_lru(folio);
+
+	if (!folio_test_lru(folio) || folio_test_unevictable(folio))
+		return true;
+
+	set_mask_bits(&folio->flags, LRU_REFS_MASK | LRU_REFS_FLAGS, 0);
+
+	lrugen = &folio_lruvec(folio)->lrugen;
+	/* whether can do without shuffling under the LRU lock */
+	return folio_lru_gen(folio) == lru_gen_from_seq(READ_ONCE(lrugen->min_seq[type]));
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
@@ -428,7 +452,7 @@ static void folio_inc_refs(struct folio *folio)
 void folio_mark_accessed(struct folio *folio)
 {
 	if (lru_gen_enabled()) {
-		folio_inc_refs(folio);
+		lru_gen_inc_refs(folio);
 		return;
 	}
 
@@ -524,7 +548,7 @@ void folio_add_lru_vma(struct folio *folio, struct vm_area_struct *vma)
  */
 static void lru_deactivate_file(struct lruvec *lruvec, struct folio *folio)
 {
-	bool active = folio_test_active(folio);
+	bool active = folio_test_active(folio) || lru_gen_enabled();
 	long nr_pages = folio_nr_pages(folio);
 
 	if (folio_test_unevictable(folio))
@@ -589,7 +613,10 @@ static void lru_lazyfree(struct lruvec *lruvec, struct folio *folio)
 
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
@@ -657,6 +684,9 @@ void deactivate_file_folio(struct folio *folio)
 	if (folio_test_unevictable(folio))
 		return;
 
+	if (lru_gen_enabled() && lru_gen_clear_refs(folio))
+		return;
+
 	folio_batch_add_and_move(folio, lru_deactivate_file, true);
 }
 
@@ -670,7 +700,10 @@ void deactivate_file_folio(struct folio *folio)
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


