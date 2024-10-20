Return-Path: <linux-kernel+bounces-373124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1599A5286
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 07:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555721F22024
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 05:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF998BE8;
	Sun, 20 Oct 2024 05:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xHxPvk64"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE65322E
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 05:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729401203; cv=none; b=nP9ILM9ByTubZOek1zTEv56dwDgxXziFsgGk1Wvx0vPX50w9fm3oyH+3SYh08/1D2oFsUaSBHuZgtCBWx+SbowuDrmd0f/WULs9C+Uql/DGtE7b8hcPuTew8hz2unhJjwnW0KNeACLPm9lBhf1zSCXSuY1om/adBPRvHISYYLsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729401203; c=relaxed/simple;
	bh=DckghUVe9dPFRjS3yVxAAhDA93nISONcaHEQCJedePY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XtAYF+N0DJp+elz7bn1ClLQYrkgxYo5z6ZOSR00IUwTmwzEGt7KGG8xHTm8Dw3YuBcfMo9MB5B2y3BtJvzx9p1oufYsk9FmA6WuOiqFqC86Nhuri8SSpZ/uvACtTuq/YgjB/6esM3PhquHImhCGnNd3l3D99ttwf+j+vRkmmYDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xHxPvk64; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2bd09d2505so1354760276.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 22:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729401200; x=1730006000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OveFO/By7bLywJSu2dRYr+UbPIt48027oO27RCFliS0=;
        b=xHxPvk64S7mI7YRgpSJ9vS7krVNzXl2p22/8knJ4NgwkG+zRELFYn58BPJe+5n2+Ea
         I6/mJyXp9vNu0Q5Q2Ilpnlp34lNmKLT/nIsKjEjJwfsaPms+HW+FIth6E7UWkTPb9Xcc
         y9lh8w7w7iriOCi3D1LK1CNYUR/kkLtb1cIx10+0emfd8T9d2+CrSWk0gpdLMLdkcguM
         Lz7kV6naV6mLAuNyGdQ6CSW+vAEwaJaBIhUOrsirTZraUMoLH+JI4NkwBYOMhzq3Liny
         b33gRsYSdjIfE/BuCfJhGwcgLOt6h7Xrp2iqf889CIL58hfkk5wcUGNhbkjo3y3Nyjwu
         cnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729401200; x=1730006000;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OveFO/By7bLywJSu2dRYr+UbPIt48027oO27RCFliS0=;
        b=Rsf961XhAtP7T91o/SQCMLhSO3a3zEOAPwAWX5qTtKdjDnyFTIXPrByVysGaHS9Wmp
         JgNtEam1wXnsXtWPn8UbpRePcQ4alR+wCWUqCusWW4tT1Z4ud9EZFsU96eRhkGBC4/JU
         TPieWmN+FMtDFhdWcRI7+Zz+G1rWdAnxO6xqaqweK4OyW74ryZ/k8ie1UZahNhY6gWxa
         XveRz1eCLlv4rmLzJKoMQshMHXgW5Lb/xM8VpgkfJUpIIaFp92nP+5SV0U1BclfHyrrd
         MEdQLlTqS0i4f8c1FgV53xZd/TpKKmcYofod1I2m8vdSBJvokVjfT7sS6QMQHD+uGTuF
         eRzw==
X-Forwarded-Encrypted: i=1; AJvYcCU6/Qbd/b+V5ESLge3e78UKhzvHhs0qBYusB0XUG3z4w6BoB7wJUKgii+cH4b2KfqFZEkU1ZEhVJrOGaHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXQ8RclmeuuxlskZX2hQMrnu+oAsIGzBeoOTzx0RzsljQmZlRS
	0oH72HKxwrE1bozrAFJ7ypg0Fo3xD923TI/47cTggwpPB69tZSUvQ3vib0Kjdt8T71HKi2E/J1E
	eHA==
X-Google-Smtp-Source: AGHT+IE69tejyhZpf7BDrRSgZu1vdQhiSSEi/LMvUxrihOyJqQ+hsmkwcoQjakRfsDDkZfTV8line2Mhv3I=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:882f:cbc3:2127:9e93])
 (user=yuzhao job=sendgmr) by 2002:a25:1e87:0:b0:e28:ef2c:e0f4 with SMTP id
 3f1490d57ef6-e2bb158a04fmr4210276.7.1729401200141; Sat, 19 Oct 2024 22:13:20
 -0700 (PDT)
Date: Sat, 19 Oct 2024 23:13:15 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241020051315.356103-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v1] mm/page_alloc: try not to overestimate free highatomic
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Link Lin <linkl@google.com>
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
'H'. Therefore __zone_watermark_unusable_free() overestimated free
highatomic reserves. IOW, it underestimated the usable free memory by
over 1GB, which resulted in the unnecessary OOM kill.

The estimation can be made less crude, by quickly checking whether
there are free highatomic reserves at all. If not, then do not deduct
the entire highatomic reserves when calculating usable free memory.

Reported-by: Link Lin <linkl@google.com>
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/page_alloc.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bc55d39eb372..ee1ce19925ad 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3110,6 +3110,25 @@ struct page *rmqueue(struct zone *preferred_zone,
 	return page;
 }
 
+static unsigned long get_max_free_highatomic(struct zone *zone)
+{
+	int order;
+	unsigned long free = 0;
+	unsigned long reserved = zone->nr_reserved_highatomic;
+
+	if (reserved <= pageblock_nr_pages)
+		return reserved;
+
+	for (order = 0; order <= MAX_PAGE_ORDER; order++) {
+		struct free_area *area = &zone->free_area[order];
+
+		if (!list_empty(&area->free_list[MIGRATE_HIGHATOMIC]))
+			free += READ_ONCE(area->nr_free) << order;
+	}
+
+	return min(reserved, free);
+}
+
 static inline long __zone_watermark_unusable_free(struct zone *z,
 				unsigned int order, unsigned int alloc_flags)
 {
@@ -3117,11 +3136,11 @@ static inline long __zone_watermark_unusable_free(struct zone *z,
 
 	/*
 	 * If the caller does not have rights to reserves below the min
-	 * watermark then subtract the high-atomic reserves. This will
-	 * over-estimate the size of the atomic reserve but it avoids a search.
+	 * watermark then subtract the high-atomic reserves. This can
+	 * overestimate the size of free high-atomic reserves.
 	 */
 	if (likely(!(alloc_flags & ALLOC_RESERVES)))
-		unusable_free += z->nr_reserved_highatomic;
+		unusable_free += get_max_free_highatomic(z);
 
 #ifdef CONFIG_CMA
 	/* If allocation can't use CMA areas don't use free CMA pages */
-- 
2.47.0.rc1.288.g06298d1525-goog


