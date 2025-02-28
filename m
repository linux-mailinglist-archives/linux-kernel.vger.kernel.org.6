Return-Path: <linux-kernel+bounces-538221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722D8A495FA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25DEF16B499
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A2725CC83;
	Fri, 28 Feb 2025 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WAH1ZaSU"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5192425B67E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736348; cv=none; b=ExWwVaRXBdVk3CKieogJfBuVzBy2dYxKEO/laDP1CatXeioqVBAoibJKIRNhw45Mos9/ZtFIvvfPKorbitDBzmTZPu+0f84aOOx8s5Q+45muHcs/DZqcRkstmGT10upA9lM2xLmE0F0I4mKFwDVYQyUn1LDGEQNgTllNB5+Syko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736348; c=relaxed/simple;
	bh=Oy/AgJ+iKO+epYA8MI/4Dr7jfnlyxcVb/cWIeswoGYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R6dDo0PT6a1XoxaYJMT3jiu4+ycSMNa+/KDYshHJrAgSck0z9t8Pj1PPIiw6hXn6etLXkV/awRD16liNsg0tpKev/MJ5XzX+jUcoH0bXJVhRL/NICCEH8pPg3kNd3VJNITf4NslE0TQUNVv5gywCYruibu5No2ZWKKfPmbB19V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WAH1ZaSU; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so10062535e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740736344; x=1741341144; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HO3rm5+cQOMI85a/kqJJUn+V+LGjTUrNi05UBywCRJg=;
        b=WAH1ZaSUwb04MVgCb5VX1mUNokoOjYPJFYxVr6mVI0kgfPHEPSkpcy3YI2xSvUEvHt
         Ips3OXe74n6vWlFvd0SxVba5wCVQOvmRCugR24dU202EhxIFQGvuf3ZKbu8gjdQyMBU/
         dA9vm6j0SYRioY9vHm2iNs6XJfEu3L4j3q6Ov1TFp5rws60eVrQZiDdiHv9KP67/dzcN
         +8Uu6sN41D8dNZqqb9qHVnD+y7B9mR+0qfNcpkFoPUqEjfkja3cJd60VF5K3iYiISmaz
         q8QLtU03CPp1tTdngai+E63J+gI8sHUq8KBRVr8UsRj+q90Dc2ckXeyS0nhlHecJpDvw
         mnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740736344; x=1741341144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HO3rm5+cQOMI85a/kqJJUn+V+LGjTUrNi05UBywCRJg=;
        b=TEa4rGOZrT81zdiXDGoov+dU8eezfBp4c50V1uu5yGf/qv2P0xejKWVmAUm8aEmNlt
         qbqApq9B7CaYI50Bd+QMPfmmgU59xIjxTjAYpLZvdUV6f+Ci62kRgwmbYkIgFU6VRl9T
         S5A0tB5mc6VmG8iczmOZCjTI+vHVz9775y3wxKjUf8qIlsv4knU4OHdtQ670dKsk2y3d
         G2uMb2JjEggNT3SxqikyxshBdzeBS0GyKIDqetmBXHc0Qdv3NSs4OmUOWhr5XBLBMQgk
         Rj2aNyVYMzkcGK1iYFp5BrfFXxoreeYU7kbbXQEVXMfWzpPnI8LakDVPV+6Iio4bHRpZ
         bSTw==
X-Forwarded-Encrypted: i=1; AJvYcCXUk7IMpDC7usaNkaiOKs+vIhgD/EsRDndpyNRUJrrRgs5Fh+iQHKmA5HxmaX/hYeHlup+OLjLPgzXe5B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSMujvA/eAv7g7PRr9Fn6v61/VoTW4sXybpRBO3dEq+S+OQmaD
	8V0jz0rvztbKaNUdJhhvPO0TNDV6frsHnt8g6OHNEpB7LVPILW256B6L16qOLu+clw5qdMe6/vO
	oCMzRtc6PQg==
X-Google-Smtp-Source: AGHT+IE1A0Dj6yDwVQ5f1BronRrhiqIk/3BQtEj5r1ew6jfrtBzSUFcUVO/MsKCaxzJF66E3L65r+gpQTCtWGQ==
X-Received: from wmbbh18.prod.google.com ([2002:a05:600c:3d12:b0:439:8e3e:b51b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:190a:b0:439:9c0e:3709 with SMTP id 5b1f17b1804b1-43ba66e6b0emr22738525e9.8.1740736344709;
 Fri, 28 Feb 2025 01:52:24 -0800 (PST)
Date: Fri, 28 Feb 2025 09:52:18 +0000
In-Reply-To: <20250228-clarify-steal-v4-0-cb2ef1a4e610@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228-clarify-steal-v4-0-cb2ef1a4e610@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250228-clarify-steal-v4-2-cb2ef1a4e610@google.com>
Subject: [PATCH v4 2/2] mm/page_alloc: Clarify should_claim_block() commentary
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

Note the page_group_by_mobility_disabled logic is not explained in the
commentary, that is outside the scope of this patch...

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 441c9d9cc5f8edbae1f4169207f5de9f32586f34..17ba5d758aa539370947b6f894e5fce7de6c5c5e 100644
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
- * reclaimable and unmovable allocations, we try to claim the whole block
- * regardless of page size, as fragmentation caused by those allocations
- * polluting movable pageblocks is worse than movable allocations stealing from
- * unmovable and reclaimable pageblocks.
+ * When we are falling back to another migratetype during allocation, should we
+ * try to claim an entire block to satisfy further allocations, instead of
+ * polluting multiple pageblocks?
  */
 static bool should_try_claim_block(unsigned int order, int start_mt)
 {
@@ -1965,19 +1958,32 @@ static bool should_try_claim_block(unsigned int order, int start_mt)
 		return true;
 
 	/*
-	 * Movable pages won't cause permanent fragmentation, so when you alloc
-	 * small pages, you just need to temporarily steal unmovable or
-	 * reclaimable pages that are closest to the request size.  After a
-	 * while, memory compaction may occur to form large contiguous pages,
-	 * and the next movable allocation may not need to steal.  Unmovable and
-	 * reclaimable allocations need to actually claim the whole block.
+	 * Above a certain threshold, always try to claim, as it's likely there
+	 * will be more free pages in the pageblock.
 	 */
-	if (order >= pageblock_order / 2 ||
-		start_mt == MIGRATE_RECLAIMABLE ||
-		start_mt == MIGRATE_UNMOVABLE ||
-		page_group_by_mobility_disabled)
+	if (order >= pageblock_order / 2)
 		return true;
 
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
+	/*
+	 * Movable pages won't cause permanent fragmentation, so when you alloc
+	 * small pages, we just need to temporarily steal unmovable or
+	 * reclaimable pages that are closest to the request size. After a
+	 * while, memory compaction may occur to form large contiguous pages,
+	 * and the next movable allocation may not need to steal.
+	 */
 	return false;
 }
 

-- 
2.48.1.711.g2feabab25a-goog


