Return-Path: <linux-kernel+bounces-215580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C41C090949A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 01:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471951F23C95
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 23:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1F11AB537;
	Fri, 14 Jun 2024 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2g5MBss+"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3618519049A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718406328; cv=none; b=EOQmkphqzeNIHT+ptHzJOrQVGaVMjtk2Vb+DBDse6+Covk3npNPvSej9cV5xKP8gPXuU9tT6/QWU0MBq8bpjK+nryd6/zTGHu6kBlp4VRgfo7ce7MebSae5XDNsD4dbp8pWf3LUdV+cWcygqTOvolZpzkLsuWhbVgDyKxOXkqkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718406328; c=relaxed/simple;
	bh=JON1NdPgYPoWrnE0rBETijaw+SbmqmxVotV1RuOXvoc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mquHc5cPak5ZAg3Txyp0HDiMoFD2+gjK7i9+dNpr19gSIrxifwjuBwhjChEjIjBvLUNPq5CPkQLw7rpnc3BDA7eZeujnXDZvgsG1sNm8YAyK9AAHZH0RhQCJ4T+guyQvtvS4OetLcuOoQY6wano4MJG3daFjf8rm4Er2cuEXWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2g5MBss+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfe25446483so3888586276.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718406308; x=1719011108; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yn2hFXhX79WK1EuGevpcsoabHDFdbQfZxb2v8U67kDg=;
        b=2g5MBss+jYosVE+e4oF7hJvrL97VmnkItlxRQJ45oN24nTZ+v3HPEKyJOfFFYr4eoZ
         QvFxsZOGfpPauTswkh+KM/ryd2wYNW87P0fQZNCBT9unPqhSA4WvDWMNBHOJIz6S7k4V
         QmV6uFMjIEjcBxeSySj4E46SJHFa2TF30F9HLm9pdZ55SeDcivbNDhuJhMwJw01Mm3IH
         52ZRJ4GzC+OHGDXRYvYCGfNByZcUiYpLpJyWgtbMfQgKcMEQ4QJpvpyvVeXsl1bU839I
         d6jcuhyGz9zUWf5vrcNS+0/FKfnukFtgary7QxNyQqlBrxT64r0pjnxFuHkQkDLjMoxh
         91WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718406308; x=1719011108;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yn2hFXhX79WK1EuGevpcsoabHDFdbQfZxb2v8U67kDg=;
        b=LW50nH9dmYs68abHrltWmhcckMRBLl6/r77Z4G+j01tIuXquYXOiQ2x67fjA8pQ9CG
         EDKV10aT3m8ampp12XMQD3ZlCqcvFC3yEP5hnPxdbQ0iXv3vO1TvWaZh+2zauYjB8pCO
         3R0ll3GnB887oZc8vDfVsI0yPPsWn4dd/o5oaLxpJK/QCvyIyGrDFEvJP4LfJIcHwngQ
         l5humFnx1heUfQWXT7egoi4/iYnmd4NBDVtyJVfBlCBaUl7t6V1/IAQoju1P9sIkn/vs
         S8nyUwwuzXvLqwTv0LZycH6Rl8eQXjz8vKIq2P3gFBO/BJhKdYXepZGFOB6CA4tNSziq
         2vJA==
X-Forwarded-Encrypted: i=1; AJvYcCWTqRc+1pV46U1GiDVVsu72SrEq0woMcMEQ8Ib0QDzlrN1jN/1doB5By63FQl+WQT8AVivul1FpRduRfyP6vRu9a44ntTnb8HEw8qy3
X-Gm-Message-State: AOJu0YyWYJE0/Il0QfJErH2Q4aXthHD36rATF3TsUNubuqKWGRZlgZIi
	FQ68yTuLilrrAjaq7SqnYGmfMZYCzHYyBTR4xoDtFS3QqhZX/uemm326bNJ5oAx5mSFCtcE93I+
	Qvw==
X-Google-Smtp-Source: AGHT+IG+ZloUhmtk/dvF1n0BAyilcNB3L2cfA9Zfr3ld5hq7p6cOMW9TVxQTjZ6Wg9M3YIfspZKx34kVKi8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:92f9:5432:a95e:d0e8])
 (user=surenb job=sendgmr) by 2002:a25:938b:0:b0:dda:d7cf:5c2c with SMTP id
 3f1490d57ef6-dff154676camr253369276.13.1718406307948; Fri, 14 Jun 2024
 16:05:07 -0700 (PDT)
Date: Fri, 14 Jun 2024 16:05:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240614230504.3849136-1-surenb@google.com>
Subject: [PATCH 1/1] mm: handle profiling for fake memory allocations during compaction
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

During compaction isolated free pages are marked allocated so that they
can be split and/or freed. For that, post_alloc_hook() is used inside
split_map_pages() and release_free_list(). split_map_pages() marks free
pages allocated, splits the pages and then lets alloc_contig_range_noprof()
free those pages. release_free_list() marks free pages and immediately
frees them. This usage of post_alloc_hook() affect memory allocation
profiling because these functions might not be called from an instrumented
allocator, therefore current->alloc_tag is NULL and when debugging is
enabled (CONFIG_MEM_ALLOC_PROFILING_DEBUG=y) that causes warnings.
To avoid that, wrap such post_alloc_hook() calls into an instrumented
function which acts as an allocator which will be charged for these
fake allocations. Note that these allocations are very short lived until
they are freed, therefore the associated counters should usually read 0.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/compaction.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index e731d45befc7..739b1bf3d637 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -79,6 +79,13 @@ static inline bool is_via_compact_memory(int order) { return false; }
 #define COMPACTION_HPAGE_ORDER	(PMD_SHIFT - PAGE_SHIFT)
 #endif
 
+static struct page *mark_allocated_noprof(struct page *page, unsigned int order, gfp_t gfp_flags)
+{
+	post_alloc_hook(page, order, __GFP_MOVABLE);
+	return page;
+}
+#define mark_allocated(...)	alloc_hooks(mark_allocated_noprof(__VA_ARGS__))
+
 static void split_map_pages(struct list_head *freepages)
 {
 	unsigned int i, order;
@@ -93,7 +100,7 @@ static void split_map_pages(struct list_head *freepages)
 
 			nr_pages = 1 << order;
 
-			post_alloc_hook(page, order, __GFP_MOVABLE);
+			mark_allocated(page, order, __GFP_MOVABLE);
 			if (order)
 				split_page(page, order);
 
@@ -122,7 +129,7 @@ static unsigned long release_free_list(struct list_head *freepages)
 			 * Convert free pages into post allocation pages, so
 			 * that we can free them via __free_page.
 			 */
-			post_alloc_hook(page, order, __GFP_MOVABLE);
+			mark_allocated(page, order, __GFP_MOVABLE);
 			__free_pages(page, order);
 			if (pfn > high_pfn)
 				high_pfn = pfn;

base-commit: c286c21ff94252f778515b21b6bebe749454a852
-- 
2.45.2.627.g7a2c4fd464-goog


