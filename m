Return-Path: <linux-kernel+bounces-560165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DEFA5FEE9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7838188DB65
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FF41F0E5C;
	Thu, 13 Mar 2025 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yh+Wev4o"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FCA1F0990
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889511; cv=none; b=u4n68U2TIc+TXusYlKf/BKeUSht4i+ZBcV6ptc2MgkVMdCUczIgOzE4qncpn/m/s5HIiR4FVoMSsYJJRIF7TRpbzC9eK15Ewfqdks1MCRc06qu+UtaA+XIO5UnoeDGSgbUWUbFwG8jKajFtim2bvQbAVNfZIkV1wZ6MqfiIX83g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889511; c=relaxed/simple;
	bh=fGEeQXrjwKQkQP57EyE86cUhUZbL2LxsT8EcaJSEXxg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T7x0EWr3KvvROl6uu0LWM2kAszctaOdJfx6ooTNvNnrcn+mB/QMnYUU5o0MTsp3iDw/uOqncwg+78US+dQSVsw4tXuWeVzx9vyU22g8ZRtNAz0h1u3v3soC3mTqmX2cn7f5Rsz0jxX1fRee2hIK8wmDnDNSHimETj+TTF4fZr3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yh+Wev4o; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3913aea90b4so554826f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741889508; x=1742494308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9PPqJkUj7Pibb+TYCrq8XdoSiIxYoCw22sHO21dNMJ4=;
        b=yh+Wev4orPFstZVXbA4aeH68SGxxOxexddQYOPGq6MpT1OwPaT9ABnOi6aOpNpXywp
         odLP5iJz26RddTE/vwcGVVHn+Cusme+rzF2VFi1nkwELRvJferVWacVpW5hugCSdTwmd
         Ai0Ci1gS9FSv0cCZAcgjHj190/EbOb3FO9dz3qO/mbFLPbkEv/uyJdGkKjCuDx7rUDyF
         dpMIvzsMZRhSXzuZnwNysI0kYGX1ykhrRisA6pFuArAwOzXkoN41dBeYecZlOKK60XKd
         sOQ1BHvmd0nw5E4k7jcXQqogPJxL9BlZYgUp4PXtAFdxcXgchlubDyEDwT+Ji5RNoszl
         efpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741889508; x=1742494308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9PPqJkUj7Pibb+TYCrq8XdoSiIxYoCw22sHO21dNMJ4=;
        b=Q9miIolT7vjrRAjlv9OAooYmIW5HcT8DC0HdXw4E+hQqMLdfFoQkHnBGwKdqeJKO1x
         jrY/QbNUt4AZN/WuBrnhA1QQXama4ELZex4y6+3DvFf/vRMpwxlIM1OKRZZ0nfhwOV1/
         bDbthuQX1CkLdM1BxkFlseTjhCA80Zz7l6T5lz7/WcwYTqe0ytNbyYODUD7ax7M2NfV5
         uJnJFBaZRWiUAsCz3/j9fzbc+7uc1qvrsoXhsximywI3sFn6XyB0gD4aXnqTxbppC9nr
         grrejZE0Q1QyzUlsfwjJATycoL/8RrEdfIzkVOjmN/2w4Sps+BHRyQL9VnrnwajPcpVp
         E4aA==
X-Gm-Message-State: AOJu0Yw+nHtBkMeseTXpD06+Myr3sRJJI9rotCQk8fBSsNmip4l68MDK
	K0zOovB2nX2tfLn14Kvl4UbX/jxp9P2LVlvjjJuhFzxaavhTMVOP6trFzrQesuXOZAICHRiZpHs
	0UXFTZM3MEg==
X-Google-Smtp-Source: AGHT+IF8ERnTvg3YNcVI2WgDobZeTnOtswaGwtLGXdYxevgaK+phqTml6l4yAXJ9Dw4d5FjayQ84d9+Hw+R0XA==
X-Received: from wmbfm8.prod.google.com ([2002:a05:600c:c08:b0:43b:c9cc:b9b3])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:598c:0:b0:391:3988:1c7c with SMTP id ffacd0b85a97d-396c2105ea6mr522202f8f.24.1741889508450;
 Thu, 13 Mar 2025 11:11:48 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:11:23 +0000
In-Reply-To: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250313-asi-page-alloc-v1-4-04972e046cea@google.com>
Subject: [PATCH RFC 04/11] x86/mm/asi: Sync physmap into ASI_GLOBAL_NONSENSITIVE
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

Mirror the physmap into the ASI pagetables, but with a maximum
granularity that's guaranteed to allow changing pageblock sensitivity
without having to allocate pagetables.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/mm/init_64.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 8f75274fddd96b8285aff48493ebad93e30daebe..4ca6bb419b9643b0e72cb5b6da6d905f2b2be84b 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -7,6 +7,7 @@
  *  Copyright (C) 2002,2003 Andi Kleen <ak@suse.de>
  */
 
+#include <linux/asi.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -736,7 +737,8 @@ phys_pgd_init(pgd_t *pgd_page, unsigned long paddr_start, unsigned long paddr_en
 {
 	unsigned long vaddr, vaddr_start, vaddr_end, vaddr_next, paddr_last;
 
-	*pgd_changed = false;
+	if (pgd_changed)
+		*pgd_changed = false;
 
 	paddr_last = paddr_end;
 	vaddr = (unsigned long)__va(paddr_start);
@@ -770,9 +772,13 @@ phys_pgd_init(pgd_t *pgd_page, unsigned long paddr_start, unsigned long paddr_en
 					  (pud_t *) p4d, init);
 
 		spin_unlock(&init_mm.page_table_lock);
-		*pgd_changed = true;
+		if (pgd_changed)
+			*pgd_changed = true;
 	}
 
+	if (pgd_changed)
+		sync_global_pgds(vaddr_start, vaddr_end - 1);
+
 	return paddr_last;
 }
 
@@ -784,9 +790,29 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
 {
 	bool pgd_changed;
 	unsigned long paddr_last;
+	pgd_t *pgd_asi = asi_pgd(ASI_GLOBAL_NONSENSITIVE);
 
 	paddr_last = phys_pgd_init(init_mm.pgd, paddr_start, paddr_end, page_size_mask,
 				   prot, init, &pgd_changed);
+
+	/*
+	 * Set up ASI's global-nonsensitive physmap. This needs to mapped at max
+	 * 2M size so that regions can be mapped and unmapped at pageblock
+	 * granularity without requiring allocations.
+	 */
+	if (pgd_asi) {
+		/*
+		 * Since most memory is expected to end up sensitive, start with
+		 * everything unmapped in this pagetable. The page allocator
+		 * assumes that's the case.
+		 */
+		pgprot_t prot_np = __pgprot(pgprot_val(prot) & ~_PAGE_PRESENT);
+
+		VM_BUG_ON((PAGE_SHIFT + pageblock_order) < page_level_shift(PG_LEVEL_2M));
+		phys_pgd_init(pgd_asi, paddr_start, paddr_end, 1 << PG_LEVEL_2M,
+			      prot_np, init, NULL);
+	}
+
 	if (pgd_changed)
 		sync_global_pgds((unsigned long)__va(paddr_start),
 				 (unsigned long)__va(paddr_end) - 1);

-- 
2.49.0.rc1.451.g8f38331e32-goog


