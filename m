Return-Path: <linux-kernel+bounces-560164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F0FA5FEE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C56C7A5D7B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AFF1F09B4;
	Thu, 13 Mar 2025 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dnjWuWnk"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59FC1EF0B5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889509; cv=none; b=Hi20YWlGnQ2XlHNICpIyrhFUeXUsK4SVJGzwD+vwTkuCb14dgc6R+njKoEF1g6x706K1NmotY0c+qD1LJ5HmlxqZR72paQIoFD+VcU0cSUF61xM9AdICutDNNU3sd+pUpyyJHwLmiX1PXIEHU87Tn2zkma5sYL8r1vzWlVx0VFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889509; c=relaxed/simple;
	bh=W4sw0yWx5RkXrhCwq5NJ/AictZZr0NkR62X+pTU0PNo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BR5Y0e2a960vdIVS/nw30Otv6JTpFY6s5LiND1ZgWPDP9G6A7WmDbyyThRmCbnkxrxJ1WEoZ96uQXgVpJH1f9r7zs+5iH57a24qPyUZciXpQfFSqRNI4hKYQX05t30KlOyYyg1d6VLOPSv5sZl//h9kjclWHAG8W1GizfGBKYkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dnjWuWnk; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-438e4e9a53fso9452735e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741889506; x=1742494306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SFFEGXNq9QK4O4fqhmQmuGwjZkzkfGXtfnqX8VsiIbA=;
        b=dnjWuWnkEFu89uIVNUPc8MmayWJxvZFpqJrfh4aQVOhnvRQ5hmrYrEWSip21TPUc2G
         mqbY6Dhztp75ljnRHtIS8XIvBpcqKzmK8pxOcpZ+sPFi7E4pTJC8ah5BwQn5V0s+u4bR
         HW3hMFHkNWwzBvpJ7gxsjSW8oEpscFktsnBexcQoXnGc/mpywFzfQItW3qRr9dRKMveP
         0ygdAOvbia+kHuv3tNTHHZ1zsG0XvVfMwd5QfWkzDCGBPxCmmRgOmMpMVI54u/phEZFc
         6hPkq1gcZbrHH4clPdL4iCX/CFqc5jSMIAtWFElhY3l/x/345lveGHqykcHX//WHyd2F
         BA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741889506; x=1742494306;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFFEGXNq9QK4O4fqhmQmuGwjZkzkfGXtfnqX8VsiIbA=;
        b=T7oyi1ftrhgEId00cvoXe4K3D9l2nIm235wkZoAc6jfoYyW1aUEadgllwzhuBzs9+g
         GRqiaplqwVdTnEkhdhFbHg5A+onXro9FNN/pImxRdksolB4Pfi0+rtPcTWKhwvNoejX7
         DXJWHkL17U69VuT6At7t+McEJr10og8ZMZnCVRWfSfd+qP/bqesQ6oq8liRFipNGgUHj
         XEiF2YSlBInLygJvpeBwtPrbTHl8p5XT/4V+XFdCNdfYDSljMgKF4mrJFYpPLTB8VySY
         qrmOVYggiqANGwW+1FNmkfVqHUJqrYx1rq6fjsRajeCbrtjap5K4+kG+g4DmpSu2deCj
         /SIQ==
X-Gm-Message-State: AOJu0Yzyk9DI7oDPVeAt4ap9ZF66esE3L5JLuak+yQ9MaD5NyQQQ6ZDO
	ugeZDWIK/nbKN9/8Wvt9P0ACraWn8l8Sh1ucM2qLB/jbljbZyeRiy1P0lMREexxa2NddwVq56BN
	Rf0S+001lvg==
X-Google-Smtp-Source: AGHT+IH1VGtpk3xtUCPvw+qm8+MH2zctSvi1XXF/gGWDnzmEetB35farCcixJ7scWW3mkfOJxNfCCFjLdwFb9g==
X-Received: from wmbg20.prod.google.com ([2002:a05:600c:a414:b0:43b:b74b:9350])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46cb:b0:43c:f470:7605 with SMTP id 5b1f17b1804b1-43d01bdd4a4mr133112715e9.12.1741889506406;
 Thu, 13 Mar 2025 11:11:46 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:11:22 +0000
In-Reply-To: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250313-asi-page-alloc-v1-3-04972e046cea@google.com>
Subject: [PATCH RFC 03/11] x86/mm: Add lookup_pgtable_in_pgd()
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

This is the same thing as lookup_address_in_pgd(), but it returns the
pagetable unconditionally instead of returning NULL when the pagetable
is none. This will be used for looking up and modifying pages that are
*_none() in order to map memory into the ASI restricted address space.

For a [PATCH], if this logic is needed, the surrounding code should
probably first be somewhat refactored. It now looks pretty repetitive,
and it's confusing that lookup_address_in_pgd() returns NULL when
pmd_none() but note when pte_none(). For now here's something that
works.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/include/asm/pgtable_types.h |  2 ++
 arch/x86/mm/pat/set_memory.c         | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 4b804531b03c3ce5cc48f0a75cb75d58b985777a..e09b509e525534f31c986d705e07b25dd9c04cb7 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -572,6 +572,8 @@ extern pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 				    unsigned int *level);
 pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
 				  unsigned int *level, bool *nx, bool *rw);
+extern pte_t *lookup_pgtable_in_pgd(pgd_t *pgd, unsigned long address,
+				    unsigned int *level);
 extern pmd_t *lookup_pmd_address(unsigned long address);
 extern phys_addr_t slow_virt_to_phys(void *__address);
 extern int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn,
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index ef4514d64c0524e5854fa106e3f37ff1e1ba10a2..d066bf2c9e93e126757bd32a7a666db89b2488b6 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -658,6 +658,40 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 	return new;
 }
 
+/*
+ * Lookup the page table entry for a virtual address in a specific pgd. Return
+ * the pointer to the entry, without implying that any mapping actually exists
+ * (the returned value may be zero).
+ */
+pte_t *lookup_pgtable_in_pgd(pgd_t *pgd, unsigned long address, unsigned int *level)
+{
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	*level = PG_LEVEL_256T;
+	if (pgd_none(*pgd))
+		return (pte_t *)pgd;
+
+	*level = PG_LEVEL_512G;
+	p4d = p4d_offset(pgd, address);
+	if (p4d_none(*p4d) || p4d_leaf(*p4d) || !p4d_present(*p4d))
+		return (pte_t *)p4d;
+
+	*level = PG_LEVEL_1G;
+	pud = pud_offset(p4d, address);
+	if (pud_none(*pud) || pud_leaf(*pud) || !pud_present(*pud))
+		return (pte_t *)pud;
+
+	*level = PG_LEVEL_2M;
+	pmd = pmd_offset(pud, address);
+	if (pmd_none(*pmd) || pmd_leaf(*pmd) || !pmd_present(*pmd))
+		return (pte_t *)pmd;
+
+	*level = PG_LEVEL_4K;
+	return pte_offset_kernel(pmd, address);
+}
+
 /*
  * Lookup the page table entry for a virtual address in a specific pgd.
  * Return a pointer to the entry (or NULL if the entry does not exist),

-- 
2.49.0.rc1.451.g8f38331e32-goog


