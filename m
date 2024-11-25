Return-Path: <linux-kernel+bounces-421404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B10789D8AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7318B28465C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFC31B87DC;
	Mon, 25 Nov 2024 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oi6YuHZK"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3A61B85DB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554277; cv=none; b=uDbY4kc6FghX+3b62Pb+poEVNI/LyIuocd7vmNoegpbu2HpcaX05tKN83m0VNc+pKhPzA1DCGY4wkWWMcQ85s8b9X1eKQNmBRWvo82erHdjN7maAMGFjr1I/j5CcplL6YoMq3uHqdlhp4MbncgSBUQ9FY2uBs58+4AWk4lKoF6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554277; c=relaxed/simple;
	bh=Q9nhFnvX5po7qMTBQm2qkwxUv6qGFxXNiDtnJ95wJa8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B5akMA28oYK4iWdKYu+IIIWDDqRdYnLkQ10tSGKBMD34Aopi/rVfdAyvH5zF4wlLP4OmKsmL8kW4dngshWZHZ6QT1BY4eofahFSRowOtPI7QrP2ilGmM9Bihw6txpYjoRusNvnS+zq9yiMaiZUmcVZhp4E5nflL+njSyL8JR5s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oi6YuHZK; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4316655b2f1so33984845e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732554274; x=1733159074; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BM7VXYp5ri3IbFK6Ch5atB9YeFiiuDxY+E4jisoxWjc=;
        b=Oi6YuHZKA2xON//byY/JgDhHiMAwxKlP2AgvOaAI1UlQIo74fB2ebMX4SyRZlAZDHJ
         HfHBE6bcoNSVAUMuS5JdIN/RXQnQeqtHOshUgTcef0TgxfYwyD2cESYTMwbj/KMA1Yic
         PkWlM3RO655jz+jF+le03/0LmVshngX7B9A97sWB9v2PexdUbTijcEh6b4Iwrz/yJFV9
         b8w1sXYJDiG16ZJUVO0vYHwW6avRCfk/g7sfHeSKqZ9bhF2WmY4riOa2bJGfIqOZOSaM
         NJfoHDe5n3CyLvG25PP6WjqghUwxpktDeD+NdA1TlTuhBBc9n8egkLr9gH6o2izQ85EJ
         2YmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732554274; x=1733159074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BM7VXYp5ri3IbFK6Ch5atB9YeFiiuDxY+E4jisoxWjc=;
        b=YRx44nAI4uWA5YzIe+nRxRtUhFdSmZcaQvjb12XnFL8DU2VbtuC8pKU9iNO1G3w/vE
         Q0n5c2+foQsguMUO1El81tUHczDLSrw2goOv8DelceoKNvP/vVlBdNoF+22qS3qKZiGK
         k8IkEY0x9rh2Wh7jPRCJ0sAGECgq0ZJ+ZfxZqDh2qn7XGMnB9oOOK0Sd8qPADc/blrJf
         VNb0lzr+gKEznUIRS/aSACRfOfH6zqYpd3W0siM45EpQx4Q0QesMDtQ390h1QTMR/GdY
         ZhTU54P5bbsQ52o+KRzt3ZlBoNVv64XjXYL3qw1Ix0RaUgRCR+8vpxx6JcX3iLiA6yqG
         ysoQ==
X-Gm-Message-State: AOJu0Yw+o+xqPooyOcVrt3eept03OCshGv+anmmy508p6rkGz2tmMj3n
	1Hh/IEy+7cC15m0+raeF+RVxXuhvQ2g3692Y9vBFBJ980QrSPrVNAC8IWJp3bxXS2KcO1uDJ2zq
	dMP/Kr8juabuVUCkiIUsiL5A+IszdL1k6rhUVyX28EMhVrI9IyP/cwKbVMzLyJx4AofRWenj9hF
	1dVRJGExtQJWbWjhLnyaens4cni0uCuA==
X-Google-Smtp-Source: AGHT+IGrpQhxDrRtZw7ZKsTRm7aLmXBM7kh5WVYDf/sM62+dDhPXpKmIMG2BcnHQ7D8g+9vRFJWzK+Y6
X-Received: from wmsn38.prod.google.com ([2002:a05:600c:3ba6:b0:431:5cb1:96bf])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b19:b0:42c:bae0:f05b
 with SMTP id 5b1f17b1804b1-433ce413c8emr103504305e9.1.1732554274240; Mon, 25
 Nov 2024 09:04:34 -0800 (PST)
Date: Mon, 25 Nov 2024 18:04:14 +0100
In-Reply-To: <20241125170411.1898410-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241125170411.1898410-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4681; i=ardb@kernel.org;
 h=from:subject; bh=h3YMNGTShKWsXTWvJuEzKY1ErpCIlE1Hv0v55I/Djgw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JId1lncCnO49Su7uqLFSL6mYtVvwacmYlx/y5H/d/au4PZ
 rz/J7y/o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExE/B7DP7vL7NP2xWtnRptY
 PK7N6mR0a1R+u1d6vlqqwO9UTk/jIkaGEzfKfp8/7bT/+gWJcmPJQIsjDM8tJ7RnC05LWOsu6fW LCwA=
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241125170411.1898410-11-ardb+git@google.com>
Subject: [PATCH v3 3/6] x86/boot/64: Avoid intentional absolute symbol
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
2.47.0.371.ga323438b13-goog


