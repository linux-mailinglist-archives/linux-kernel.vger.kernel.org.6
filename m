Return-Path: <linux-kernel+bounces-560171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7F4A5FEF2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09EF44208AA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9051F3BBC;
	Thu, 13 Mar 2025 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WlZWKWYQ"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46761F3BA3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889524; cv=none; b=pvXIcqK8Z+ANly0EJSqttPhxwhD82SE7asMtV+8nrD1nRV9wbKor0iPpBpSwmiAfmcZkd1EwafiLBituHWNUg3FsxfKHxLZe95O4Fw0jWiwWCfo+VU7PpK1qZAAENKsLnmEyhZPLwY1y2cj3A7PX9HZ8DOR+wC4kUyLXRX3wCEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889524; c=relaxed/simple;
	bh=iGdPf0L9eAmfpxDO21sCB/pch8E5xey9ZueJIm70CcA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=otAF5k8qrHS8jxfCNAakkgvKHGKQ7m14DFiW8YXfQ2U8GD2lRGsRSNEsPscZ5aw+a4JEzD0KKgavNRqkL6uB5AITIQmZYFZ3W47fDvDCTyDfuINV6rRYnARoEVG+UohnQDCyjT2dIQUxgVUk0SF7f6Ro4ON3YnPx+PVt8IN8o1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WlZWKWYQ; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3912fe32a30so633975f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741889521; x=1742494321; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MT67Tc4nbE6RvTfwk389B1U2q+t+QBE9ZWlf/JDHQjo=;
        b=WlZWKWYQcV+vEs53+NXnnJ6eYf92gOZ8Jqa/cSLR8yRrESRBRIZEAxzIsj26AuGFIs
         C3CfDNBk7r9AwqJbsBOgt43smNmg3A3Cjo8UHFS2P/RLcGELKgjE29MnG8rUtAnEnFmC
         HACqKiU9/oCEJsnLdRdDk5tVLRXLk/+92H1LQz77Xn2TxQ4mw1HWv0zpgey3y8Lt0plQ
         jrMyQj/qy/tGjLwNEvpcsxwbNI4rmQgHGb+ONFixdApxY5C4Q5M64oRObqiokfd7n/PO
         NIYi2fzxy55ygdkzEMNYXQxLhoGcSYuY9rW0zYpu5V6O0jaYIhSyPDPZy1zTSFMhmvZi
         phQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741889521; x=1742494321;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MT67Tc4nbE6RvTfwk389B1U2q+t+QBE9ZWlf/JDHQjo=;
        b=B7WMJku0l5THkCngHpolmbsi1rL9Et01iug+Ma1djJXq+iaPe+b1AjwuUlCHuR/rUH
         mSOk8gE15+TsNrqjwrVPGb5E+fRspHEOuFuRfD+x2VJ0PkvW2C4FaZ9WxVQ3e1I8fzdT
         dL3fBS921IeLb1U7Nr1ePtTuy7tfABnp3sCNh96lEDbkSFT3b1wUDVeQw0Nhz8OH37jq
         mdhksyr1dP3JvuDViDQ1eVe4QrU1GD01b2t9K4Nhn2B1RgS278GIGUJipAhG/qsgRmxt
         fJaMRD7G3yA9eVl+GlfUAsm+xY3ECA+0muxI1W5xhpwC474DNJf733H1aG/E0hphzK3o
         wi1w==
X-Gm-Message-State: AOJu0Yyv8jp4oFXu9xVRBPAXbKDW2LG0nfT196xYOLpTyau3qO1jo/lW
	4Nu+EmjbjVlvTeTGpkZDiDsJ6tqxxxAqGlQhMT0z9dibPpYacB9cCxTOj7t3iXOMxiaKk+p8yuj
	3f2nELunNrw==
X-Google-Smtp-Source: AGHT+IGTDPbDngPkmEoWDX7m7yWVpzg47wDDczIbjQCcv6h8SnX4qWQyopmuiT4sdFB+hEFVGiIYdXMgmMnnIQ==
X-Received: from wro9.prod.google.com ([2002:a05:6000:41c9:b0:391:2f9a:9a8b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1f83:b0:390:f9d0:5e3 with SMTP id ffacd0b85a97d-39263affd7amr11502380f8f.1.1741889521421;
 Thu, 13 Mar 2025 11:12:01 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:11:29 +0000
In-Reply-To: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250313-asi-page-alloc-v1-10-04972e046cea@google.com>
Subject: [PATCH RFC 10/11] mm/page_alloc: Add support for nonsensitive allocations
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Mike Rapoport <rppt@kernel.org>, Junaid Shahid <junaids@google.com>, Reiji Watanabe <reijiw@google.com>, 
	Patrick Bellasi <derkling@google.com>, Brendan Jackman <jackmanb@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

Creating nonsensitive pages from sensitive ones is pretty easy: Just
call asi_map(). Since this doesn't require any allocation or
synchronization (at least, the synchronization is implied by the zone
lock) just do it immediately in the place where the pageblock's
migratetype is updated.

Implement a migratetype fallback mechanism to let this happen,
restricted to requiring a whole pageblock.

Now that it's possible to create nonsensitive pages, the allocator
supports non-__GFP_SENSITIVE allocations, so remove the temporary hack
setting this flag unconditionally in the entry point.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/include/asm/asi.h |  5 ++++
 mm/page_alloc.c            | 67 +++++++++++++++++++++++++++++++++++-----------
 2 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
index cf8be544de8b108190b765e3eb337089866207a2..4208b60852ace25fc9716c276bd86bf920ab3340 100644
--- a/arch/x86/include/asm/asi.h
+++ b/arch/x86/include/asm/asi.h
@@ -2,7 +2,12 @@
 #ifndef _ASM_X86_ASI_H
 #define _ASM_X86_ASI_H
 
+#include <linux/align.h>
+#include <linux/mm.h>
+#include <linux/mmdebug.h>
+
 #include <asm/pgtable_types.h>
+#include <asm/set_memory.h>
 
 #ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ae711025da15823e97cc8b63e0277fc41b5ca0f8..0d8bbad8675c99282f308c4a4122d5d9c4b14dae 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -15,6 +15,7 @@
  *          (lots of bits borrowed from Ingo Molnar & Andrew Morton)
  */
 
+#include <linux/asi.h>
 #include <linux/stddef.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
@@ -422,6 +423,18 @@ void set_pageblock_migratetype(struct page *page, int migratetype)
 		     migratetype != MIGRATE_UNMOVABLE_NONSENSITIVE))
 		migratetype = MIGRATE_UNMOVABLE_SENSITIVE;
 
+	/*
+	 * TODO: doing this here makes this code pretty confusing, since in the
+	 * asi_unmap() case it's up to the caller. Need to find a way to express
+	 * this with more symmetry.
+	 *
+	 * TODO: Also need to ensure the pages have been zeroed since they were
+	 * last in userspace. Need to figure out how to do that without too much
+	 * cost.
+	 */
+	if (migratetype == MIGRATE_UNMOVABLE_NONSENSITIVE)
+		asi_map(page, pageblock_nr_pages);
+
 	set_pfnblock_flags_mask(page, (unsigned long)migratetype,
 				page_to_pfn(page), MIGRATETYPE_MASK);
 }
@@ -1606,19 +1619,35 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
 
 
 /*
- * This array describes the order lists are fallen back to when
- * the free lists for the desirable migrate type are depleted
+ * This array describes the order lists are fallen back to when the free lists
+ * for the desirable migrate type are depleted. When ASI is enabled, different
+ * migratetypes have different numbers of fallbacks available, in that case the
+ * arrays are terminated early by -1.
  *
  * The other migratetypes do not have fallbacks.
+ *
+ * Note there are no fallbacks from sensitive to nonsensitive migratetypes.
  */
-static const int fallbacks[MIGRATE_PCPTYPES][MIGRATE_PCPTYPES - 1] = {
-	[MIGRATE_UNMOVABLE_SENSITIVE]    = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE   },
 #ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
-	/* TODO: Cannot fallback from nonsensitive */
-	[MIGRATE_UNMOVABLE_NONSENSITIVE] = { -1 },
+#define TERMINATE_FALLBACK -1
+#else
+#define TERMINATE_FALLBACK
 #endif
-	[MIGRATE_MOVABLE]                = { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE_SENSITIVE },
-	[MIGRATE_RECLAIMABLE]            = { MIGRATE_UNMOVABLE_SENSITIVE,   MIGRATE_MOVABLE   },
+static const int fallbacks[MIGRATE_PCPTYPES][MIGRATE_PCPTYPES - 1] = {
+	[MIGRATE_UNMOVABLE_SENSITIVE]    = {
+		MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE, TERMINATE_FALLBACK
+	},
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+	[MIGRATE_UNMOVABLE_NONSENSITIVE] = {
+		MIGRATE_UNMOVABLE_SENSITIVE, MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE
+	},
+#endif
+	[MIGRATE_MOVABLE] = {
+		MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE_SENSITIVE, TERMINATE_FALLBACK
+	},
+	[MIGRATE_RECLAIMABLE] = {
+		MIGRATE_UNMOVABLE_SENSITIVE, MIGRATE_MOVABLE, TERMINATE_FALLBACK
+	},
 };
 
 #ifdef CONFIG_CMA
@@ -1931,6 +1960,21 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
 	if (area->nr_free == 0)
 		return -1;
 
+	/*
+	 * It's not possible to  change the sensitivity of individual pages,
+	 * only an entire pageblock. Thus, we can only fallback to a migratetype
+	 * of a different sensitivity when the entire block is free.
+	 *
+	 * This cross-sensitivity fallback occurs exactly when the start
+	 * migratetype is MIGRATE_UNMOVABLE_NONSENSITIVE. This is because it's
+	 * the only nonsensitive migratetype (so if it's the start type, a
+	 * fallback will always differ in sensitivity) and it doesn't appear in
+	 * the 'fallbacks' arrays (i.e. we never fall back to it, so if it isn't
+	 * the start type, the fallback will never differ in sensitivity).
+	 */
+	if (migratetype == MIGRATE_UNMOVABLE_NONSENSITIVE && order < pageblock_order)
+		return -1;
+
 	*claim_block = false;
 	for (i = 0; i < MIGRATE_PCPTYPES - 1 ; i++) {
 		fallback_mt = fallbacks[migratetype][i];
@@ -4694,13 +4738,6 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
 	struct alloc_context ac = { };
 
-	/*
-	 * Temporary hack: Allocation of nonsensitive pages is not possible yet,
-	 * allocate everything sensitive. The restricted address space is never
-	 * actually entered yet so this is fine.
-	 */
-	gfp |= __GFP_SENSITIVE;
-
 	/*
 	 * There are several places where we assume that the order value is sane
 	 * so bail out early if the request is out of bound.

-- 
2.49.0.rc1.451.g8f38331e32-goog


