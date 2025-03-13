Return-Path: <linux-kernel+bounces-560169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ACAA5FEF0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E8027AAE4D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2261F37D3;
	Thu, 13 Mar 2025 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rV6V5l1Y"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7927C1F2BBB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889520; cv=none; b=IovoB5Ge4qAdu2fUX00fm1uHwOFrCjZzpgxSA4+9dTrWGkT3quYTT1sbdgJklweQEJNCtYrdGT+0EK52ml6dXIoeJZB79UX3OvQhbOzaEqxor4BhZPb2iZcXiisJiobGz0EVXhP3Xkhk564wYGYipqMIA5M1rYQIQGMdzvTHkk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889520; c=relaxed/simple;
	bh=I6idEbcATjINv9XdShmp78j79HzBX3Z2G8brrJmIrc8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cDXdXOHfbPROw+kto/aOSvdBXxBTzsJeT7bO8FqjeBYtvRyEnRKksumXQu2WD/NvBl1sZ99uFsd9qQEnbXtUDAZnVy9Tkgj+GnoctROdWU12fC5KTxBaj+MklDFVE/CpmfCD7Vm7gP+m5/6k9DqKWJBcXUElzfR5QxrF4ZguSFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rV6V5l1Y; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ceed237efso9521515e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741889517; x=1742494317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tRsJowh9EEZA56z2uUOhJ3rtTOtbuzhctlmDmyeE3Lo=;
        b=rV6V5l1YAyjRZSBpjbfpM1p4vN6TLo68K1WekOHm10y89m9u9KvEp3S4o397bnYQZh
         s67O0rfCzrKFILNpcIoohxPPPh4fgfJG13tq2J8FvCfjZI+qou+GCgkYnWVjhiJ0V5A6
         zZoSN9gZkW618zp6WS0zsaxobYaaIfuwZhCdQBEesLZfJ8tC6m/ipqNgpbG4co7l0f/D
         ZtcO3aLmSYS/8L1RUQyi4Eea5nO5BXiWoHX3vyj15HWBELS+KGqusWwSI/Dka05dTDUt
         WwZxGD32r1I7GnUgm4c0DJP1m8zBrYKUR6+LpHq15czX61rMLKoAGri1lcm8eTbNVG/M
         Hx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741889517; x=1742494317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRsJowh9EEZA56z2uUOhJ3rtTOtbuzhctlmDmyeE3Lo=;
        b=QfouvjDiNLKL8+mBJReKCzU0po0cMqnMAEYa6V3kC7UevjVzIR+IID2O+JUG6jKrVA
         MPsy9coG12mcbvoXfikdKdnO5TZL0FCMO1DxTGBPLe4FREjtLdC8js2RvlGeawql4JvV
         JlUo5Z6MfDPNsD5/Qgop/s66ELY9U+hN4THayYdrrVAGexl0/N3f5MZd73hvDr5OwY6j
         01tYBM6jM5OMcM9u8IUruayEDKcftSuZsMz8ni+ZH37XfbsaRt6iOEmMgiGPf+f9UC0r
         oOyOGxxG84LvAZ014XPyDKkhVC+IsORYeKZVN+otIGqFwid/KOBSYG1+SUXQOdhWCdnz
         LkBg==
X-Gm-Message-State: AOJu0Yws8cIj4UPC59EMFnmFlWI7nu0V6RZeLVpV6dNxxCALLAAJtiDn
	Q1DTWbbk0rJiPItl9f83126dK/N1m7OYtOcCymVoAZfX1S5wY+cfPjyun2nPxriKeT+ygs6SdLQ
	2fX9vmT1IiA==
X-Google-Smtp-Source: AGHT+IFfyCsrs7ccNNldH6c3NwbPOVylewQWVrKq/G7/S6WFMNKzAcRUB4lJBTdyYKD3llafwzpnB+NDVR+YSw==
X-Received: from wmbeq4.prod.google.com ([2002:a05:600c:8484:b0:43b:c967:2f53])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f14:b0:43d:7a:471f with SMTP id 5b1f17b1804b1-43d01be7e4bmr134665765e9.18.1741889516996;
 Thu, 13 Mar 2025 11:11:56 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:11:27 +0000
In-Reply-To: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250313-asi-page-alloc-v1-8-04972e046cea@google.com>
Subject: [PATCH RFC HACKS 08/11] mm/page_alloc: Simplify gfp_migratetype()
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

This currently uses optimised bit-hacks to avoid conditional branches
etc. For the purposes of the RFC, let's not get bogged down in those
details - temporarily just drop the bit hacking.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/gfp.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 6bb1a5a7a4ae3392c1cd39cb79271e05512adbeb..23289aa54b6c38a71a908e5a6e034828a75a3b66 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -14,25 +14,20 @@ struct mempolicy;
 
 /* Convert GFP flags to their corresponding migrate type */
 #define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
-#define GFP_MOVABLE_SHIFT 3
 
 static inline int gfp_migratetype(const gfp_t gfp_flags)
 {
 	VM_WARN_ON((gfp_flags & GFP_MOVABLE_MASK) == GFP_MOVABLE_MASK);
-	BUILD_BUG_ON((1UL << GFP_MOVABLE_SHIFT) != ___GFP_MOVABLE);
-	BUILD_BUG_ON((___GFP_MOVABLE >> GFP_MOVABLE_SHIFT) != MIGRATE_MOVABLE);
-	BUILD_BUG_ON((___GFP_RECLAIMABLE >> GFP_MOVABLE_SHIFT) != MIGRATE_RECLAIMABLE);
-	BUILD_BUG_ON(((___GFP_MOVABLE | ___GFP_RECLAIMABLE) >>
-		      GFP_MOVABLE_SHIFT) != MIGRATE_HIGHATOMIC);
 
 	if (unlikely(page_group_by_mobility_disabled))
 		return MIGRATE_UNMOVABLE;
 
-	/* Group based on mobility */
-	return (__force unsigned long)(gfp_flags & GFP_MOVABLE_MASK) >> GFP_MOVABLE_SHIFT;
+	switch (gfp_flags & GFP_MOVABLE_MASK) {
+	case __GFP_RECLAIMABLE: return MIGRATE_RECLAIMABLE;
+	case __GFP_MOVABLE: return MIGRATE_MOVABLE;
+	default: return MIGRATE_UNMOVABLE;
+	}
 }
-#undef GFP_MOVABLE_MASK
-#undef GFP_MOVABLE_SHIFT
 
 static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
 {

-- 
2.49.0.rc1.451.g8f38331e32-goog


