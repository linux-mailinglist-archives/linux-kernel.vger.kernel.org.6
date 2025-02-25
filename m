Return-Path: <linux-kernel+bounces-531752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16249A4446F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B0B1884BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B28C268FC2;
	Tue, 25 Feb 2025 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yZFm787S"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFE426BDBF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497402; cv=none; b=hEtur+B/cCLRHrVnJy7GfOkdD1/Vdzt2e5rO3Bco2NLrwOOlvTyvdbKeEvbcqQiil5rJTce0w2hKuvR43li+CkPrcf+PaJHAvLltN1noVYGrCZR/mZZzSxI63VcONm+kvFYb4A/YRWI58nGIyB7hkdQ/6HULsMQ4UhjpimcZAhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497402; c=relaxed/simple;
	bh=2t7x2tjKNw2qIHCtZTtrUlEyUmTO9R0TRnhffv1XEwM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jfgVD9TdczDu7HbA+eKPPidAXYzrp/UZHjbcn7PaIyfbG9AZgy5JekLJm8orrWJUG0yFy9Odn/ACbP0OzJJpkW2eNbR/EINW71wsNzH7VdJD7asI+Z17B6IX5eV2gGmCEgatH+oCWytnasf5f4G12bSJFp1tLINIylTngdSAKFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yZFm787S; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-438e4e9a53fso46035075e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740497399; x=1741102199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NLwoRANke7kr877qFcAfj/lJYQPtzdEo7Afw90Odwbs=;
        b=yZFm787SImXmOE4/jgnBaC/RMffXZRgeq1wm3Eq1kXBio24R0gWa2UK24jjIGHV7nK
         3UsjDy3NUJI+vMY5Zoq5wNMS2SZ6SIUQuIkJFev+kKzRNaJec03j9mqaC6QSSNh/cGld
         jGoqDK/tMi3MkdlWIVoQDAxEE4Af5noK8fyBsUTcF2IlxlDtFsY/tTmcKIofz2RJ3pti
         X5y78NOCAMb/PnSObmv40aWxKS6/MC8FGGEga7J0mel5n2cAGxHTUhmofrFZ32KykzED
         SaWl/LVGA51ffemcusou2P2yxFWdH2jYrvImY6l6j/F8QVnZRiUXDRg+wGKd9t6bPnDB
         Bx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497399; x=1741102199;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLwoRANke7kr877qFcAfj/lJYQPtzdEo7Afw90Odwbs=;
        b=Km0QXNmNTUde/egQcY81+DUr3/8nAs7uPyVp+yn2+uRYXWef/pPDzrpQf7oSRez85S
         P8ztbPWMykGsg917Cl9C9bTvcBfNNw1hmsNnfN90DIU0bzXD1fL0Ud2YC9/yD2DoS4tm
         LEaAGqn/UkypnZJ8TkiGjWYV56AozIup4J9zUL56vKV9oSnrd/yCNV0k5/Lh4ANxlkGF
         XY2nQBXQc2rWnrLKPAR+r0+UpXRd4pzPQRfgAJz4ZrhKboLSs29J8KPDcxRtu5SWGTen
         w//8MXp8Bt3tBwdnRJ+wq1oFUY5ao38WR/dnrhyW7xwb8jy/XkEMEl8zZca8ybaevrMM
         rrVA==
X-Forwarded-Encrypted: i=1; AJvYcCVnQt3usjwSpD/b3/CGtZi11uJSLaYEIMSq0UwC1aiG+J1xt9GoJU+XmbFviTzqerO1knKFPfES72QI+yA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8o0t0NxerlcXtb4XlYUjV6IiyvrhcZdJYARVYWpzRV/MCXSVn
	DTgFqT9NE5Shi/4i/VAmSVAK8p3yJMz18TcFoAkYzYeeshZp2HeOW1zYPIr6OxP0IeycApIS/QW
	yo268vfsMeA==
X-Google-Smtp-Source: AGHT+IGO83dLwzMAW2+OSLdDNKSAMPRJx7wbGvVzqnB7FL9rEUp8ltEN+IEPBCHAKKIyLKaCJmNhINOp203v6A==
X-Received: from wmbed10.prod.google.com ([2002:a05:600c:614a:b0:439:985c:9199])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1910:b0:439:98f6:8bc8 with SMTP id 5b1f17b1804b1-439aebcf61dmr138093215e9.26.1740497399462;
 Tue, 25 Feb 2025 07:29:59 -0800 (PST)
Date: Tue, 25 Feb 2025 15:29:49 +0000
In-Reply-To: <20250225-clarify-steal-v3-0-f2550ead0139@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250225-clarify-steal-v3-0-f2550ead0139@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250225-clarify-steal-v3-2-f2550ead0139@google.com>
Subject: [PATCH v3 2/2] mm/page_alloc: Clarify should_claim_block() commentary
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>, 
	Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

There's lots of text here but it's a little hard to follow, this is an
attempt to break it up and align its structure more closely with the
code.

Reword the top-level function comment to just explain what question the
function answers from the point of view of the caller.

Break up the internal logic into different sections that can have their
own commentary describing why that part of the rationale is present.

Note the page_groupy_by_mobility_disabled logic is not explained in the
commentary, that is outside the scope of this patch...

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5e694046ef92965b34d4831e96d92f02681a8b45..475ec1284033acec69da4a39dd4e7d7fbaee6d0f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1941,16 +1941,9 @@ static inline bool boost_watermark(struct zone *zone)
 }
 
 /*
- * When we are falling back to another migratetype during allocation, try to
- * claim entire blocks to satisfy further allocations, instead of polluting
- * multiple pageblocks.
- *
- * If we are stealing a relatively large buddy page, it is likely there will be
- * more free pages in the pageblock, so try to claim the whole block. For
- * reclaimable and unmovable allocations, we claim the whole block regardless of
- * page size, as fragmentation caused by those allocations polluting movable
- * pageblocks is worse than movable allocations stealing from unmovable and
- * reclaimable pageblocks.
+ * When we are falling back to another migratetype during allocation, should we
+ * try to claim an entire block to satisfy further allocations, instead of
+ * polluting multiple pageblocks?
  */
 static bool should_claim_block(unsigned int order, int start_mt)
 {
@@ -1964,6 +1957,26 @@ static bool should_claim_block(unsigned int order, int start_mt)
 	if (order >= pageblock_order)
 		return true;
 
+	/*
+	 * Above a certain threshold, always try to claim, as it's likely there
+	 * will be more free pages in the pageblock.
+	 */
+	if (order >= pageblock_order / 2)
+		return true;
+
+	/*
+	 * Unmovable/reclaimable allocations would cause permanent
+	 * fragmentations if they fell back to allocating from a movable block
+	 * (polluting it), so we try to claim the whole block regardless of the
+	 * allocation size. Later movable allocations can always steal from this
+	 * block, which is less problematic.
+	 */
+	if (start_mt == MIGRATE_RECLAIMABLE || start_mt == MIGRATE_UNMOVABLE)
+		return true;
+
+	if (page_group_by_mobility_disabled)
+		return true;
+
 	/*
 	 * Movable pages won't cause permanent fragmentation, so when you alloc
 	 * small pages, you just need to temporarily steal unmovable or
@@ -1972,12 +1985,6 @@ static bool should_claim_block(unsigned int order, int start_mt)
 	 * and the next movable allocation may not need to steal.  Unmovable and
 	 * reclaimable allocations need to actually claim the whole block.
 	 */
-	if (order >= pageblock_order / 2 ||
-		start_mt == MIGRATE_RECLAIMABLE ||
-		start_mt == MIGRATE_UNMOVABLE ||
-		page_group_by_mobility_disabled)
-		return true;
-
 	return false;
 }
 

-- 
2.48.1.658.g4767266eb4-goog


