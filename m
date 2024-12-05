Return-Path: <linux-kernel+bounces-433102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB619E53E6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9F62869CD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C0F202F84;
	Thu,  5 Dec 2024 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/jKdSlR"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA5A202C32
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398110; cv=none; b=k8LtSlioJqSFRiwGMU5A2/3QTmYHNys2qRF+BLiynW9+7ZDo17midF7pFMMdrxh8wpExxTHu4EyWmhHTBOAciMwsDo7S9E8ico3Qmr7/RFnGCOfgTbYxUhoBrRsbz+vOM7s19yI72/DT6MF0R4Q0z5Zk1QeUE3OqPawwJoMbQ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398110; c=relaxed/simple;
	bh=cNPqBV2asGRYk4KDnmS95o6rHXLgSF4/nk+rZajYBqc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sVkaIjnvX8vkAHiZoMy1M2t/OSdk5raycBngW6SNRsH5uQGiT+o/aOL9aSGxs6JI5cox0Sk1uIcq64oEblCFePl4eCrl2hhLiyx/5geCexyNYenElC4kGjdIybJEb+Km0aqua45U8U9tESUOShh4YBnXH9Ft1A3YvDNnaUr+zo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i/jKdSlR; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-434a195814fso6813985e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733398107; x=1734002907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bm1Ka5uwmly0Cgi1lxCtqIUhWjpra8ZMMQLn8XAgLmo=;
        b=i/jKdSlRDDht6Pvi/+kLJ85i0pJmUap2Dh5WVNcbXIZffXUnjzVP4+WHj+p751wJhw
         wbLJO/anFUPMe56OiiATp1DOPLYlmhu2tDp/TFjSGWinZIKh0AmywTXiHPaBT73A9Rbt
         O4vM5vJvQo9rtcD1Q922Dl36kJ7hD3fHP4snXvScXerjDEc8L7xUuRq57deYkg8aA6Rz
         Bapt+IlvBLKmI9o61uuZtk/7/+9ryia1OE2v99k8ixkgwp5wxNJE7rgHVHc1nK3/ARWr
         47+9/DdPo28gSDmNA5q1B4aUO3EO6E0ivq7yDvY3RWo1Zuykn6oVqKOuTAZVoo3z67Xb
         U9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733398107; x=1734002907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bm1Ka5uwmly0Cgi1lxCtqIUhWjpra8ZMMQLn8XAgLmo=;
        b=OYi/S76PW00XnrcznYXkVmfN8M0QnBLBFFS6ZrWWlx0TOvAM6tlCpmf90te1cedzFp
         5CJl7EDg1Ol661RpLvtxp7lR7A0A4qoC+by/n1wyGM0rdC+YNZilh4NeiezmC0gJABC2
         LW9IapmFkGhwccEuL2t0r0vbrBOOHI9ZfNUi/aHxMkIAtRiNqBZpxdD5iCM3GbyHCTS4
         D6Bpgs7kX4czEP+RZUKLZJFVQjTl9TloZ9uLlkdv0F5tIos8VWixG3sI2jtNln60IfSG
         x10z5uQMTxmrkgvLxG2z5cljVmjqH14U4zSU4MfCagfsC5vtx3OLMwuIAWSxUqexVOM+
         Z3xw==
X-Gm-Message-State: AOJu0YxRlLI4RAOrGybCKIUfpx2GsvPbmbrMUecAj4oHHIEnpENTbmoR
	jETLf1sR77oC5fyD56t7td0LfFLqHiyeo9RgZqmBzbby3KEbbU3OJlzOFWclS/+jAAt8w6o0hbH
	xva/Wp1BUJXIhXBL0LAzNn/s8FfzZBiPLpObBy0Wei/ZASTskjtQLl+8ViNsXDyFBDGWUVk036i
	2Ja6vCJLS7HVW1uAIm88AGuvUbIwng5w==
X-Google-Smtp-Source: AGHT+IF75/PWd3mXHQmNiaS0NEimlrVSBtgJsHVS29Ev0elQ1BTrdrn9zQho3C88wFbKtBC7dTxhozEo
X-Received: from wmbbg19.prod.google.com ([2002:a05:600c:3c93:b0:431:59ab:a545])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4511:b0:434:a94f:f8a9
 with SMTP id 5b1f17b1804b1-434d0a239d0mr68937275e9.28.1733398107327; Thu, 05
 Dec 2024 03:28:27 -0800 (PST)
Date: Thu,  5 Dec 2024 12:28:08 +0100
In-Reply-To: <20241205112804.3416920-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241205112804.3416920-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4681; i=ardb@kernel.org;
 h=from:subject; bh=aishywIuVWUZ5XOlPXdxpKgKAjksbg1NQRdKDYm6qRk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT2wz/POmp5HvH1tRY4rfVb88ZyUmtu0adVt+alBt7/2M
 /h+2GnYUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACby7gXDPxNLj6q3q92uZKbG
 PLG+2J31p6VceWKVr7ttB1vCbk8OIUaG+W7bpsz48vxPMsvN8iKV3T9My/PfljfMN5SaLbRl/bx zPAA=
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205112804.3416920-12-ardb+git@google.com>
Subject: [PATCH v4 3/7] x86/boot/64: Avoid intentional absolute symbol
 references in .head.text
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The code in .head.text executes from a 1:1 mapping and cannot generally
refer to global variables using their kernel virtual addresses. However,
there are some occurrences of such references that are valid: the kernel
virtual addresses of _text and _end are needed to populate the page
tables correctly, and some other section markers are used in a similar
way.

To avoid the need for making exceptions to the rule that .head.text must
not contain any absolute symbol references, derive these addresses from
the RIP-relative 1:1 mapped physical addresses, which can be safely
determined using RIP_REL_REF().

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head64.c | 30 ++++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index a7cd4053eeb3..54f9a8faf212 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -91,9 +91,11 @@ static inline bool check_la57_support(void)
 	return true;
 }
 
-static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
+static unsigned long __head sme_postprocess_startup(struct boot_params *bp,
+						    pmdval_t *pmd,
+						    unsigned long p2v_offset)
 {
-	unsigned long vaddr, vaddr_end;
+	unsigned long paddr, paddr_end;
 	int i;
 
 	/* Encrypt the kernel and related (if SME is active) */
@@ -106,10 +108,10 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 	 * attribute.
 	 */
 	if (sme_get_me_mask()) {
-		vaddr = (unsigned long)__start_bss_decrypted;
-		vaddr_end = (unsigned long)__end_bss_decrypted;
+		paddr = (unsigned long)&RIP_REL_REF(__start_bss_decrypted);
+		paddr_end = (unsigned long)&RIP_REL_REF(__end_bss_decrypted);
 
-		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+		for (; paddr < paddr_end; paddr += PMD_SIZE) {
 			/*
 			 * On SNP, transition the page to shared in the RMP table so that
 			 * it is consistent with the page table attribute change.
@@ -118,11 +120,11 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 			 * mapping (kernel .text). PVALIDATE, by way of
 			 * early_snp_set_memory_shared(), requires a valid virtual
 			 * address but the kernel is currently running off of the identity
-			 * mapping so use __pa() to get a *currently* valid virtual address.
+			 * mapping so use the PA to get a *currently* valid virtual address.
 			 */
-			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
+			early_snp_set_memory_shared(paddr, paddr, PTRS_PER_PMD);
 
-			i = pmd_index(vaddr);
+			i = pmd_index(paddr - p2v_offset);
 			pmd[i] -= sme_get_me_mask();
 		}
 	}
@@ -146,6 +148,7 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 {
 	pmd_t (*early_pgts)[PTRS_PER_PMD] = RIP_REL_REF(early_dynamic_pgts);
 	unsigned long physaddr = (unsigned long)&RIP_REL_REF(_text);
+	unsigned long va_text, va_end;
 	unsigned long pgtable_flags;
 	unsigned long load_delta;
 	pgdval_t *pgd;
@@ -172,6 +175,9 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 	if (load_delta & ~PMD_MASK)
 		for (;;);
 
+	va_text = physaddr - p2v_offset;
+	va_end  = (unsigned long)&RIP_REL_REF(_end) - p2v_offset;
+
 	/* Include the SME encryption mask in the fixup value */
 	load_delta += sme_get_me_mask();
 
@@ -232,7 +238,7 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 	pmd_entry += sme_get_me_mask();
 	pmd_entry +=  physaddr;
 
-	for (i = 0; i < DIV_ROUND_UP(_end - _text, PMD_SIZE); i++) {
+	for (i = 0; i < DIV_ROUND_UP(va_end - va_text, PMD_SIZE); i++) {
 		int idx = i + (physaddr >> PMD_SHIFT);
 
 		pmd[idx % PTRS_PER_PMD] = pmd_entry + i * PMD_SIZE;
@@ -257,11 +263,11 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 	pmd = &RIP_REL_REF(level2_kernel_pgt)->pmd;
 
 	/* invalidate pages before the kernel image */
-	for (i = 0; i < pmd_index((unsigned long)_text); i++)
+	for (i = 0; i < pmd_index(va_text); i++)
 		pmd[i] &= ~_PAGE_PRESENT;
 
 	/* fixup pages that are part of the kernel image */
-	for (; i <= pmd_index((unsigned long)_end); i++)
+	for (; i <= pmd_index(va_end); i++)
 		if (pmd[i] & _PAGE_PRESENT)
 			pmd[i] += load_delta;
 
@@ -269,7 +275,7 @@ unsigned long __head __startup_64(unsigned long p2v_offset,
 	for (; i < PTRS_PER_PMD; i++)
 		pmd[i] &= ~_PAGE_PRESENT;
 
-	return sme_postprocess_startup(bp, pmd);
+	return sme_postprocess_startup(bp, pmd, p2v_offset);
 }
 
 /* Wipe all early page tables except for the kernel symbol map */
-- 
2.47.0.338.g60cca15819-goog


