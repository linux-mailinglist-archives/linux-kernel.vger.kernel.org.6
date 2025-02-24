Return-Path: <linux-kernel+bounces-529056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EC7A41F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BDBE7A31A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C2123BCEF;
	Mon, 24 Feb 2025 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKgLDRaF"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE1623373F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400662; cv=none; b=mI8jIIx+FTGaPqASpEvahj0aAe3SKnqR+0JefDXx9g3xjf5dPnHpU5EPJg8IAj/ZliItPesNZJbHG+pZcrdaDhU/7Oo0X68Wv/cz/Wiy29rk8FUsawlbTqhPfa56sm27hMWCLhfrmd8H+zP7hImHUYCVy5/THlh45ro4la7HhZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400662; c=relaxed/simple;
	bh=z6lk/P4QasBTfrnQhTYhSQH1MJxcuLsTjlFtJQhgB8g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vCd31XYLan9sQGv2TiqUIP4T2GR0ISBjOhIrnUTSmEuPo+lwZvfmODIYKvmjdoYZjNhe68WvAgY1WDtEP1LoF3NsLayNbDoBkmRVuq6hvivJynMAKN+JThYzUWCT8fuxCmpTWwYXNRicz2qsh+X9zSCDU074Hn1GYcQ/K3x6Jm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uKgLDRaF; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43947a0919aso33920595e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740400659; x=1741005459; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9H3uAh8z39ZL705dy+lsEsP19JzvEAhzwdccc5XF6GE=;
        b=uKgLDRaFeTDJTuspkyrwYAILcc8YKQs2gpN7lM99VorP5qjfmWARgTgNxkXKQgZXBI
         HbKFXDtXwVTl/pDJMlIW12QOeEXZtoVLfIxH7Z6TmpPsEQgv9lkfQ4gFxacf5rsEdNS6
         eXvFoNyqRd0cgv+yWV8Vp2FzGwVjYG6AI+gDszzwpPsF+TW9MaWeHjgf54IBd2FhOG3V
         OOnjRje+OY2YvB2vQGfii7hq/18T7Thnn2ZvnEwWUczXEe5v6ZrfShbuN4FHlKiCyQxJ
         ViIZ74Vlw76xw2YgXACOpdR9F0WZwsczeEk7g2jLjGD6X0XIWSU4RqlWuerGfA2Y/SDt
         vsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740400659; x=1741005459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9H3uAh8z39ZL705dy+lsEsP19JzvEAhzwdccc5XF6GE=;
        b=Rusfj+BikqfHnrcwMXQMWvQJuLLi5TIL5FLOZUUkFavtGJVIGCT985ZBYhgeLi+Lvq
         stkYvtXk16MqjV1Pd1v11EZDL3yQVgTSzwK5g0Exff7X7/mGbpaR7rMB9JNaCVlPMJct
         xmJjZHjQXG/4zgognjmeFluWdcsUrc9M+bFkQHqSTT0oQuKpXChSW0UDGWpz6OSBV+Vb
         dIVMGP3ei6sXHYgWX9X7ikT7hTqZuWqmGEX6RyVw5Bn7dy2vSGY6cVAziAqGA4t/WhcJ
         4dAHMqSWyfXyrHZVrvN9kpNOkC2Bp9iFaI8KLUvsahLwv2+PV3K09W2IR5kxPjKXDrsf
         Z18Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQB8hEXygRSclB5qh/JLMNoI45ZcPQE2KH9/KbKkgHBqnDzxD5XmqWkhB66qbqy/WTE5kR2jGEp9ZKOaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKbq7qZ/ewzLPqS3T9p75OdGkgau+tbnjI03ALWulFsbOgqzzw
	suIGCqKyWJisCJRzF3CcagAERRKnMBb9+FEMw3xmtsn0rOicrT1w0+WbWlVURc1Ivi80jmiPvpN
	Mr2jn9Q4lIA==
X-Google-Smtp-Source: AGHT+IG06C12mCh6DOgP0VK1wSYmbo1aaL50c6VFj4ZklSRSFPy/ILkeB2EyUg8/wsegGye3DKVKomcDzBRQ8g==
X-Received: from wmsp10.prod.google.com ([2002:a05:600c:1d8a:b0:439:8664:577a])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4006:b0:38f:2856:7dc2 with SMTP id ffacd0b85a97d-38f6e95d596mr12371877f8f.18.1740400659184;
 Mon, 24 Feb 2025 04:37:39 -0800 (PST)
Date: Mon, 24 Feb 2025 12:37:29 +0000
In-Reply-To: <20250224-clarify-steal-v2-0-be24da656764@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224-clarify-steal-v2-0-be24da656764@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250224-clarify-steal-v2-2-be24da656764@google.com>
Subject: [PATCH v2 2/2] mm/page_alloc: Clarify should_claim_block() commentary
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
index 50d6c503474fa4c1d21b5bf5dbfd3eb0eef2c415..547cdba789d8f3f04c5aab04ba7e74cb54c1261b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1826,16 +1826,9 @@ static void change_pageblock_range(struct page *pageblock_page,
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
@@ -1849,6 +1842,26 @@ static bool should_claim_block(unsigned int order, int start_mt)
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
@@ -1857,12 +1870,6 @@ static bool should_claim_block(unsigned int order, int start_mt)
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
2.48.1.601.g30ceb7b040-goog


