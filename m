Return-Path: <linux-kernel+bounces-202209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AE58FC932
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2EC1C237C7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28BC192B74;
	Wed,  5 Jun 2024 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x7VaglDL"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F4C192B66
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583792; cv=none; b=oe5nkkizigyuaOECrJV/VBpJLWxYW+aE6Hwn9NzoceHzMolv5Y+kfMOtMZfDVAHi8mO3STiO1JbMwy7Y6bwcO12JQrAPEvHYmkA1FWgRSXT+VyG40dNkxoF14RqOHzzzPGd4APZqGkrYHNlV/4y17yKoOEEPta+IGo/LOYxF2QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583792; c=relaxed/simple;
	bh=t+JYog3mSPZZIoU84rJI+s2xcKpJusbWDToFBxl4H20=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H1aBvRAPZKSuI/zvz0xkhxPVN7/FLF6gg6Q+Qi58RGDZukdGLut9CGJm6BDr4lWo0r3OozYgwDqiinXsbvfisvwS0BWKC2kRijw6Cwr1Aa6V0YlJQUJr6Bzu3VB3f+KeT9u5JwwFy3fDcx//2GzCwvIvt8+Y4nCLaOtA0MTYwJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x7VaglDL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62ca03fc1ceso49086257b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 03:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717583789; x=1718188589; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XEmtNDC5pui6ZIXiXr09dhxXS6IpsEqJxTtW36Erzok=;
        b=x7VaglDLNyihcOs9q2IxsSW+KEEeafmXvM3xcHg5rr/RX19EIXmXyjj5fVK4SmqsPt
         KjrqaWecCXn/O8Xa/Lth/GkWZo2NAHO2LGoMut6ihvDMHrUN3xirbkaliyisoqnMcBU0
         D7JX5kNkIu/zPyxhFTBhKMatiTJRQyWbg/UV9JxtXCiRSJZASCknUeD+DGx4dF/C2Pss
         /EKX8nFas4YOxw5u66yzyDTlYHLDzL77RHAYWUkLAJrN9RTxxVLEN1VjY4j5GGLey4h0
         nVvXdvKYms1F0oseNhhG9tYNjhmROGgV7BSEDwEPW9hcASNLpKHWzUh93YhSNM2MW63V
         /i8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717583789; x=1718188589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEmtNDC5pui6ZIXiXr09dhxXS6IpsEqJxTtW36Erzok=;
        b=DQQd/BFRJp3FaGex27NvKgc7GfZ7EebHHoUOoffS9lrledjOgpnGzNxrOPIPgCaXdH
         gMHr6GC3QhftjdQ6ZlFrffOibXna1obZntKzOzCgGfIC/8YNY3GVKrLFfqfMBozS45Hp
         1lyjs6vrqDLd00jIk1DwS+MAORsUlqRWlkDyq3QYy7Aq0DBByzoOGAtLVcm6+kG4N1J6
         qzBcdLnPndnjGuuCKJpNMbLJrzoRE0iIlRis5nkzrL2rgQwj5pnIKLdfIaOs/wX1AIv+
         n+LWBtDZH40R+HPGmx++P3r8Y/RamHWel0Uj3hHC0PE+Q7wvwAULcLKwmsnWRknSIfxo
         kcOw==
X-Gm-Message-State: AOJu0Yxu7G9yj9stY7HtcUTK7yXDtiJ0fDduPpkjMtjIiMIWlFxDHS/T
	vaPHjxjMlicsQJZ/ZfkfervtIz4KHBmXCTrWH6vTRnxP0ybnoAyRH/I+mH+1p5EhfM1dR41aSfY
	bR1Fupjki2I7sbVz0Tkpx5vWVGC/Jr2qcdi4mPMB9C3wllWAraHrveZ+WylRLdxUHHD0d1mMg4H
	mpoZ3nL+ixsU3hllcp/N3G0oX7FAYjdg==
X-Google-Smtp-Source: AGHT+IErUQKTO2ZcLdxataNAEG3RQJL00sJsirZyJaf+bAntAY3hTC9uSlGTLmYfzNdhPplKlB8hmwbs
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:690c:5:b0:622:cd98:3b89 with SMTP id
 00721157ae682-62cbb5e58admr3992217b3.9.1717583789516; Wed, 05 Jun 2024
 03:36:29 -0700 (PDT)
Date: Wed,  5 Jun 2024 12:16:15 +0200
In-Reply-To: <20240605101610.2824747-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605101610.2824747-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4681; i=ardb@kernel.org;
 h=from:subject; bh=HUfqDZ5e/aoYcRzKVO71ALLOyHdGEo9FPF3h43qwzBo=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIS3B6n2zy7bFP4ODt1gXLtKQ6DjJsPrWxNe155bnWm67q
 xcxtdW+o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExEbDIjQ+8u9fWKCodvG78o
 t1grPi0sJPcli/38f1Xej6o4Xy7I9GH4n8L185zfhRah447yxXeEjk3Xm26qN+Vs0ZfN9/N5bQ8 t4QMA
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240605101610.2824747-10-ardb+git@google.com>
Subject: [PATCH v3 4/4] x86/boot/64: Avoid intentional absolute symbol
 references in .head.text
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>
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
index 81696a4967e6..c0f20962f9b1 100644
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
2.45.1.288.g0e0cd299f1-goog


