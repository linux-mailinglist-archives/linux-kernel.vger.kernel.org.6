Return-Path: <linux-kernel+bounces-385588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3449B3910
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45801F227DF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DA01DF757;
	Mon, 28 Oct 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ndg5c+EY"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7DB186616
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140022; cv=none; b=fBJX02zbK3Qv/p2Twa9JbafBRSr9oda+n74irW//l6lipk2pEtHUDg9Jnk4sB/wjpoyyvmHiz4CrIoFyvfuHZuh+BrfORdOpceabywOJjxZFoKrUIbVoMf/PunPIm1tDW7XsXGei+4D9veWAV8Ea91vlWyZ6iWFpGmAOh3BZTMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140022; c=relaxed/simple;
	bh=xCHg34d/z2Iyw41CqIOn82y5Z51ZewWBi9AvOb/PN2s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NUYPhOrMnzgT9c0LhnhS4zsqo28rdaYXWjC+qsQMkoIeWQCbBVtY7QF0phoWKfpc8tCMuTcI58/vF53qSRhV83t6GQ9rnlku7q25wETzSmGxEX/6Kx1JsbEsE48J9DS9/k82+rGQ9kMwpaaoNJpPeQojsTGneWQHpxdCoOak5zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ndg5c+EY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b5792baaso7816693276.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730140019; x=1730744819; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SAR6sfCl7q8CLvZahnZnQP4NAt397CoYQQGsmmQJtFQ=;
        b=Ndg5c+EYZ82Olxa7fJz11JwUUajDO2GNoNXJw7XhEU4ZSAnhAnxek5Lax9P3W8lyIb
         ysl8xZcWcvNAGUQfbIvXllve6JX20jbxOdXmNsMtkW13vE6qptxNcFZykrFGUc5SE0yi
         /LfFy4IRAZ4QHhaAWY3DWxCm+RB6PXaYAgUFOhDHJFjb2FAP8XS9nIZvN9IeK9fvcOPV
         /D5SAtl5kZgVmDDKNVZ4ufY5/yaWDLRxMRkGWHr4f/pB99zpREKx2qiQqtVGGrIY3v/D
         PbH7K3302n+vRTpaCwiooWKzTIbg2ayOk4ZKys7rbGVpwpVQMkNzYepP+szyiQxcVZYL
         fpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730140019; x=1730744819;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAR6sfCl7q8CLvZahnZnQP4NAt397CoYQQGsmmQJtFQ=;
        b=Ezva9wte8K5Blw4Tn8m9ZQfgRoRS+HKCU8Djp862Ip2To0d/ldPuls/hNXEkxtmNBT
         tNOL9ypwRkh+YpxHSvGe6pGdstLCVzZb3UnJ9mjPqYIW2EJ6EsWfvuFbX7wiyimxjfdw
         mtVmiGEDf3I2c3hZepPXYVdKGBZtaypmZWvutb7W4TAunFFLum0YSR4/ICMqptKV+RAJ
         2iiKutHyGe07aZ4NHsgR2/Ns4UN5fSLLGHu47O8nl5cWc17TiCiHoe/wiToPguIy9Vxk
         0gd0qH+cICQJBOVoZJxYa5x+omyku89eVzk7O+QTtDdyumvfUxK+odKTgFZh4Wyl6fnt
         CVDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz5PC09q4D2XwW/Bx9ms8xH40LbMNqRBCSUtX16OVekO5yWcIal59E63SXFhVLEnDAQwP0TDwhFZA8cfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZWT8vvNh9Voh4IppNPXtjm/79/hhXODy/pg0i0fVunJZGprzH
	wS6wk6teSgHpjgwqJ4Q6bevYUm4dUkzYDgnS3frefoYq+qqvkUNithFjds7WCG3DVGw/pVlhCTI
	Chg==
X-Google-Smtp-Source: AGHT+IF9DI9pp2VPfLEJ3zKqqGeHwod+kO2SFViH2kiVn5KE0GbX5j8j/rSkrE/wdW7Vn+59QAK4wt9Kcgs=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:28ef:e08b:2af:6fd])
 (user=yuzhao job=sendgmr) by 2002:a25:8512:0:b0:e2e:3401:ea0f with SMTP id
 3f1490d57ef6-e3087bd5448mr92425276.7.1730140019385; Mon, 28 Oct 2024 11:26:59
 -0700 (PDT)
Date: Mon, 28 Oct 2024 12:26:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241028182653.3420139-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v3] mm/page_alloc: keep track of free highatomic
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Link Lin <linkl@google.com>, 
	David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"

OOM kills due to vastly overestimated free highatomic reserves were
observed:

  ... invoked oom-killer: gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE), order=0 ...
  Node 0 Normal free:1482936kB boost:0kB min:410416kB low:739404kB high:1068392kB reserved_highatomic:1073152KB ...
  Node 0 Normal: 1292*4kB (ME) 1920*8kB (E) 383*16kB (UE) 220*32kB (ME) 340*64kB (E) 2155*128kB (UE) 3243*256kB (UE) 615*512kB (U) 1*1024kB (M) 0*2048kB 0*4096kB = 1477408kB

The second line above shows that the OOM kill was due to the following
condition:

  free (1482936kB) - reserved_highatomic (1073152kB) = 409784KB < min (410416kB)

And the third line shows there were no free pages in any
MIGRATE_HIGHATOMIC pageblocks, which otherwise would show up as type
'H'. Therefore __zone_watermark_unusable_free() underestimated the
usable free memory by over 1GB, which resulted in the unnecessary OOM
kill above.

The comments in __zone_watermark_unusable_free() warns about the
potential risk, i.e.,

  If the caller does not have rights to reserves below the min
  watermark then subtract the high-atomic reserves. This will
  over-estimate the size of the atomic reserve but it avoids a search.

However, it is possible to keep track of free pages in reserved
highatomic pageblocks with a new per-zone counter nr_free_highatomic
protected by the zone lock, to avoid a search when calculating the
usable free memory. And the cost would be minimal, i.e., simple
arithmetics in the highatomic alloc/free/move paths.

Note that since nr_free_highatomic can be relatively small, using a
per-cpu counter might cause too much drift and defeat its purpose,
in addition to the extra memory overhead.

Reported-by: Link Lin <linkl@google.com>
Signed-off-by: Yu Zhao <yuzhao@google.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 include/linux/mmzone.h |  1 +
 mm/page_alloc.c        | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 2e8c4307c728..5e8f567753bd 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -825,6 +825,7 @@ struct zone {
 	unsigned long watermark_boost;
 
 	unsigned long nr_reserved_highatomic;
+	unsigned long nr_free_highatomic;
 
 	/*
 	 * We don't know if the memory that we're going to allocate will be
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a78acaae6d9c..372a386f34f5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -635,6 +635,8 @@ compaction_capture(struct capture_control *capc, struct page *page,
 static inline void account_freepages(struct zone *zone, int nr_pages,
 				     int migratetype)
 {
+	lockdep_assert_held(&zone->lock);
+
 	if (is_migrate_isolate(migratetype))
 		return;
 
@@ -642,6 +644,9 @@ static inline void account_freepages(struct zone *zone, int nr_pages,
 
 	if (is_migrate_cma(migratetype))
 		__mod_zone_page_state(zone, NR_FREE_CMA_PAGES, nr_pages);
+
+	if (is_migrate_highatomic(migratetype))
+		WRITE_ONCE(zone->nr_free_highatomic, zone->nr_free_highatomic + nr_pages);
 }
 
 /* Used for pages not on another list */
@@ -3117,11 +3122,10 @@ static inline long __zone_watermark_unusable_free(struct zone *z,
 
 	/*
 	 * If the caller does not have rights to reserves below the min
-	 * watermark then subtract the high-atomic reserves. This will
-	 * over-estimate the size of the atomic reserve but it avoids a search.
+	 * watermark then subtract the free pages reserved for highatomic.
 	 */
 	if (likely(!(alloc_flags & ALLOC_RESERVES)))
-		unusable_free += z->nr_reserved_highatomic;
+		unusable_free += READ_ONCE(z->nr_free_highatomic);
 
 #ifdef CONFIG_CMA
 	/* If allocation can't use CMA areas don't use free CMA pages */
-- 
2.47.0.163.g1226f6d8fa-goog


