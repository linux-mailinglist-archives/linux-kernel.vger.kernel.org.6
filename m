Return-Path: <linux-kernel+bounces-433100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 431BF9E53E3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3CB161CA2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075ED1F7086;
	Thu,  5 Dec 2024 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkuSa8sj"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CB71F427E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398106; cv=none; b=qJDxOz5Mq8+Q+GrPKL32on7niOCyVTkT9kIa5RHUs9osodK0gI4UySUPbDvDuVb9L+jOS2H833NWrjj36Oq1M7m0Vg2e9A99Cb7XuKHZ2MP4YHgv8GgbCD3rZ0Z7nvJP4ykMLo6JwvBUUxGmpfkTrwFgGY3WsyRmI9W2DrUzSFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398106; c=relaxed/simple;
	bh=DBRMrtU3BneuI23gD6GcBvYRIwBuzovHn3/5N1XHOhY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sp0VjiISZ7R2aluisZqe+wKOIavwsO4vnO6W3cH0aC4KZkkrTIsjUNZ15ROE6xv9ZzhFqxO8W8kDgoneC2JVEx2pfRWxp2JVK2by4C/XrXr301he97fnuhB+APnEpEbYdyM5nZhrl5aJsfCC1KMLzanvBulQbJnITWzfNzWC2KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qkuSa8sj; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4349d895ef8so7857845e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733398103; x=1734002903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TK52PsD7eqvOZMcbHq0MK/FDCTFUEiVfbJZbNIORGp4=;
        b=qkuSa8sjPG+6UA9cVnN2lkrni3JtXFlMdUerfdx5+5n84EPME2Y+sfjsY7wHo/0PHd
         8PI2QKfHyLYWuYzQ3y8Et+/6exOFwHjxQU8f5HlQGjiuaRlGcvNq7M8walzlNPwtDh5V
         SuULAqSY5bhfYgiPnj1DD1zaiL2PQhKkg256NukOYGXKJoyGRyzExARAJNGSX1LVwJiz
         eQ+OIZYaqA7qwxbLUrsVvI6gGo5cd2wEOpb0I2cl+BWjkH4IGJLjRLE+DsKnnAKUIXaz
         h441CEQefQ+DNXkT2RARfuMuK5nibSMz3HErT5idFn0WNoVGiN6ia/y3aQhEe5DuHwda
         SdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733398103; x=1734002903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TK52PsD7eqvOZMcbHq0MK/FDCTFUEiVfbJZbNIORGp4=;
        b=gfb7VFt0eMdBe8J8mvFGWk4olkCKEbBwmXQnMrBxpn1kqNDlTf8ADNkhZS+ocJCex3
         mKNw2MXFUB5oG3f3H4mzsrxrjJT+njbiKNLz3tZZs6BomgyB2+M+ogcjZ5fScj5rwthn
         J+aHWezqWeASSGYk2nvcDHU+RCUQxxflAmkWLWPtxiTDF/2scQoaN0ZQTRJtR0FCT9un
         E47qNtOCitAFtZ6U2fPtCxCvCYgnGLt0XPlcN/Y0r0E+oafSDGLyFCZOnsTz6gZ2hx0j
         zoPB94kGQR+oEG57ZNlJjuSQxpbnltSYgJGG8KwUXEBB3u4q6BgqeJhmQW5ksoB7mNiF
         QUew==
X-Gm-Message-State: AOJu0YxEq8HNaxG7lhhzp8EWyNxdfu+6hB66huDf/UpYXn3bkLOnLWXe
	XHdHemo+XsRUTNeQ/W0T7UkDJ3iz+82YDuhX+XgSZpFuaj2vtPYQBQwgLToZa1rtiHnBKmnLPCP
	4pBcDY4EguuA/kwyEjqE4LmIabjr3Qhg71JMzfT50jwouZA/HX/XeA2higzE41sLoPe/KJIpngW
	tSJ54j+CEOhUjf2woqJrka+hMABjI7pg==
X-Google-Smtp-Source: AGHT+IEKSgqh/kMIdd32T8gun8oyfBtYL6y1yZ1S5lF6wxY4kA6FukPkNjh3i5pKn2adq9S5Knxv40IA
X-Received: from wmj5.prod.google.com ([2002:a05:600c:245:b0:434:a4a6:487a])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5888:0:b0:385:ded5:86ee
 with SMTP id ffacd0b85a97d-385fd43c326mr9068987f8f.57.1733398103030; Thu, 05
 Dec 2024 03:28:23 -0800 (PST)
Date: Thu,  5 Dec 2024 12:28:06 +0100
In-Reply-To: <20241205112804.3416920-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241205112804.3416920-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3819; i=ardb@kernel.org;
 h=from:subject; bh=3JZPOEZBXLByXMtcdnLrpry4D8Y9LpxCLkWAlkGdFG4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT2wzz39QXqQauKO+6pR1o2TJpZl2B9cOJnZ5/vhFU4z7
 nXtOCPfUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACayLYfhf01jefBBQdfGxC37
 6pTe87swWpWvCNmo5vixXeSE3K+5zgz/465FHX20iPG/k+1SfSlvfbNs44sLVs22tDufnDzlGoM VOwA=
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205112804.3416920-10-ardb+git@google.com>
Subject: [PATCH v4 1/7] x86/sev: Avoid WARN()s and panic()s in early boot code
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
2.47.0.338.g60cca15819-goog


