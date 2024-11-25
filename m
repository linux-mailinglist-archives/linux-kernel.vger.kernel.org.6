Return-Path: <linux-kernel+bounces-421402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E7B9D8AED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D112167BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E151B85CA;
	Mon, 25 Nov 2024 17:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RPy7pLFY"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7C21B6D0C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554274; cv=none; b=q6ifjaG7S8bs4TzuPxouaMBmPaedd6tbhdo5oS4sy+nfmymuRBmZ0wPMzHnZIXFKkAnQw1HsDOiKG2rjUhbi8JcsWi497V36lXuuPDBDbiiVbE5gVqFnqAFaH3FnLsZz2Zpg6egIp0QKca2BexL7j3MdrcrxFFngjnrEvGqpO1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554274; c=relaxed/simple;
	bh=7S/oLN/DEII9oL7EN3aZBI6qYSXJO9+f1T4AscFQ1gk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YeTZL1HS/YD5FzOq2yipN05Y3uDToud+yWrfKD7F4YPZ7nmAXl3PXJHGv0Mx2LA6vdTL2yQRLCnRU+ZyqUxaAFZWRnxRlWJez2Jl01KqlvuJKof3YQnkR4+d6UqdHkGJUeu+knCon0uYZaFHtU2Q8huqwbG9H/lndVP1E00qf3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RPy7pLFY; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-38242c5b4ffso2584638f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732554270; x=1733159070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4AEya7qP9gbIMfOd2WdxGj+0SNfsKysCWPPlG8qhpw=;
        b=RPy7pLFY1Wpkz8s8yyosKTGoDsf7DPbZnA8BYtm6yqrNVhls6c09UPCSi4DrCg+APA
         6rKllEyQPIlITGxKmswSGMIr4siNQkOJ3LGIp3S6lByZRZUercD/fEzwP1PCUkba2Js4
         3ZylSCideIj2RHN0ybYPq9fmAivQ6sipGUCINDHyELXgvFXqMAIIkHGNTkZfzVXUCHNf
         3Jy4ImpXvs96jRgAD/BCRwo3MdIFTFnK1/WxRxBMBxr1ZMLH37aLqy+n2fFmigOFZwpl
         9/TLUjkj/r/7UcCDaSB/IWoM2cILHzmZTVL4aCrn3pvqLZwOHsdOzKtjDSEJcjx9WTaO
         uQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732554270; x=1733159070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4AEya7qP9gbIMfOd2WdxGj+0SNfsKysCWPPlG8qhpw=;
        b=u3Eu2KDZF+gyxfquIDKhLdvbCtZr6tL/J32614escyJK8DCzpc6DTgAVpygx484Czq
         DLhOjy4xqj2I85ENasBpWM6QnwH016/UMf0GdLq47EPYizUtbSnVDKQUYHfReUw/X4oy
         +bDSIkB2SFkGRw7RzHW1H4v9ConYcQ0PoAyrzBtzMPnpVf7L20cVqc0zIO9ZgEHTTCGW
         w8ZAiHs6Dhl0R/sEBe8JRUNh/pqkGW4+rPXtlmhcKBNoGwS6mCzeQMj48adTSbllB5+L
         jiPmyYyvIhnVnAye4FWdZhKwBqpXfBAx0YzyaCybP+JA9mRp2cjHAAMAlA9SRvJ2SIgJ
         3gyw==
X-Gm-Message-State: AOJu0YxOLC86SO2a3OPGQ2K2LKCr4zoEOt6vXz5hn2c7fLYdMwYNAfPi
	8Em9D2HcAJJWVMdVkZ3Q64/2ev92yvoEEA6WTlnafy+kN8T78jo0ViNp7vvZ/aBziKLhCZvhxGO
	joXxwK99TDBguhrTghMoT8HqGbP4D2LtoghCejTl3MJKKjIVa0xX+bzAOep1TvyeOEl/mUHk62k
	02nFht1i+FJ4loTCVg24SfyuM7Up2qEQ==
X-Google-Smtp-Source: AGHT+IH+qO5ae1Hho1Lm/Fon9RV09yeJwfdIfXubNTP0EAwEzYAgMSd0otVbm0JAEWssA/T7qg2RLt5y
X-Received: from wmsm10.prod.google.com ([2002:a05:600c:3b0a:b0:432:d7fd:fd75])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:64ac:0:b0:382:51bf:b0c6
 with SMTP id ffacd0b85a97d-38260b863b3mr12016305f8f.28.1732554270160; Mon, 25
 Nov 2024 09:04:30 -0800 (PST)
Date: Mon, 25 Nov 2024 18:04:12 +0100
In-Reply-To: <20241125170411.1898410-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241125170411.1898410-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3819; i=ardb@kernel.org;
 h=from:subject; bh=mM9vuf5kkZl20az/QVO84EIMF/oOjchevyUP+y7pdwE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JId1lHa+T7seidz6sd8qyOlwc3/VdLmfdtmdzplzr58Un3
 nw9f2NGRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjI3RMM/zT8WbOtvmVtXsQl
 6rXh02vl9BrdhmazhNaPt49FSE9+MZGRoSuD5YHcn89Cob89XvPFd2UmvIhaNUvmvebrLYceF70 /wgEA
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241125170411.1898410-9-ardb+git@google.com>
Subject: [PATCH v3 1/6] x86/sev: Avoid WARN()s and panic()s in early boot code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Using WARN() or panic() while executing from the early 1:1 mapping is
unlikely to do anything useful: the string literals are passed using
their kernel virtual addresses which are not even mapped yet. But even
if they were, calling into the printk() machinery from the early 1:1
mapped code is not going to get very far.

So drop the WARN()s entirely, and replace panic() with a deadloop.

Link: https://lore.kernel.org/all/6904c198-9047-14bb-858e-38b531589379@amd.com/T/#u
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/coco/sev/core.c   | 15 +++++----------
 arch/x86/coco/sev/shared.c |  9 +++++----
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index c5b0148b8c0a..499b41953e3c 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -777,15 +777,10 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 
 		val = sev_es_rd_ghcb_msr();
 
-		if (WARN(GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP,
-			 "Wrong PSC response code: 0x%x\n",
-			 (unsigned int)GHCB_RESP_CODE(val)))
+		if (GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP)
 			goto e_term;
 
-		if (WARN(GHCB_MSR_PSC_RESP_VAL(val),
-			 "Failed to change page state to '%s' paddr 0x%lx error 0x%llx\n",
-			 op == SNP_PAGE_STATE_PRIVATE ? "private" : "shared",
-			 paddr, GHCB_MSR_PSC_RESP_VAL(val)))
+		if (GHCB_MSR_PSC_RESP_VAL(val))
 			goto e_term;
 
 		/* Page validation must be performed after changing to private */
@@ -821,7 +816,7 @@ void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
-void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
 					unsigned long npages)
 {
 	/*
@@ -2361,8 +2356,8 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
 	call.rcx = pa;
 	ret = svsm_perform_call_protocol(&call);
-	if (ret)
-		panic("Can't remap the SVSM CA, ret=%d, rax_out=0x%llx\n", ret, call.rax_out);
+	while (ret)
+		cpu_relax(); /* too early to panic */
 
 	RIP_REL_REF(boot_svsm_caa) = (struct svsm_ca *)pa;
 	RIP_REL_REF(boot_svsm_caa_pa) = pa;
diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
index 71de53194089..afb7ffc355fe 100644
--- a/arch/x86/coco/sev/shared.c
+++ b/arch/x86/coco/sev/shared.c
@@ -1243,7 +1243,7 @@ static void svsm_pval_terminate(struct svsm_pvalidate_call *pc, int ret, u64 svs
 	__pval_terminate(pfn, action, page_size, ret, svsm_ret);
 }
 
-static void svsm_pval_4k_page(unsigned long paddr, bool validate)
+static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 {
 	struct svsm_pvalidate_call *pc;
 	struct svsm_call call = {};
@@ -1275,12 +1275,13 @@ static void svsm_pval_4k_page(unsigned long paddr, bool validate)
 
 	ret = svsm_perform_call_protocol(&call);
 	if (ret)
-		svsm_pval_terminate(pc, ret, call.rax_out);
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
 
 	native_local_irq_restore(flags);
 }
 
-static void pvalidate_4k_page(unsigned long vaddr, unsigned long paddr, bool validate)
+static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
+				     bool validate)
 {
 	int ret;
 
@@ -1293,7 +1294,7 @@ static void pvalidate_4k_page(unsigned long vaddr, unsigned long paddr, bool val
 	} else {
 		ret = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
 		if (ret)
-			__pval_terminate(PHYS_PFN(paddr), validate, RMP_PG_SIZE_4K, ret, 0);
+			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
 	}
 }
 
-- 
2.47.0.371.ga323438b13-goog


