Return-Path: <linux-kernel+bounces-202069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F318FC776
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D634B2466A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452D218C324;
	Wed,  5 Jun 2024 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ki+9sMSz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4D1946CE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579040; cv=none; b=q66cwQQl+KZpbK2YQAknuYpN1sJxEHRJd+v/Z0mMid5Cj9zSyDtxeCeIHv4ZWuh5UZgS291kvYWMllJujy/yfpRCpznMuvboKqHC4WFovCENk2Z/+Gwje6E8bzQj/9BhBd4tr1Tte5c9hkfUzwD1sjWkwKWrx9PN6mGoqTjrhmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579040; c=relaxed/simple;
	bh=RiSQgPYiMhrmRQtKPPt1uZSioZUPCR9mfCfxvJ5T9nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dGhzfPRSn12rppro5jGZLkGg+beryxCrHhsUQVzb70+Br86tCKVLbWgQKMNPXkN+FXMXn9F99w/HZoHuBYiyI8X0JDaSbPWGo4B1OpxUHNM8/LyTxvAT74mdcajbnxe+HeVtLbwN4lq4LJ0tbpJFcF1NdJY941QwoaM9WYwXs9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ki+9sMSz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717579037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rYWKKIbN+7uLwqmZYu4Gu6iwgKUOkP1ippA/hZaEuBI=;
	b=Ki+9sMSzN54VIVcEMEWsQgHsKlf/gxzwzzXUjHHDxdg3PoM5KoRLzmSwQydKwYji5bqjqV
	TRGoLzVM9yLCH1WdkAhSZf5e3AKgG6YsJTm4Tf6jmEtQ0ZUqHN2gmXIDwQVumFEZRg2QN9
	E88v1ENw9z/UzIH5fFFk5IGFMR3xJRg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-2ulr3NoHNjGfnrVgFBOrdQ-1; Wed, 05 Jun 2024 05:17:14 -0400
X-MC-Unique: 2ulr3NoHNjGfnrVgFBOrdQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6A19101A531;
	Wed,  5 Jun 2024 09:17:13 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 63C59492BF6;
	Wed,  5 Jun 2024 09:17:11 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	David Wang <00107082@163.com>,
	Lance Yang <ioworker0@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	York Jasper Niebuhr <yjnworkstation@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH v1] Revert "mm: init_mlocked_on_free_v3"
Date: Wed,  5 Jun 2024 11:17:10 +0200
Message-ID: <20240605091710.38961-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

There was insufficient review and no agreement that this is the right
approach.

There are serious flaws with the implementation that make processes using
mlock() not even work with simple fork() [1] and we get reliable crashes
when rebooting.

Further, simply because we might be unmapping a single PTE of a large
mlocked folio, we shouldn't zero out the whole folio.

... especially because the code can also *corrupt* urelated memory because
	kernel_init_pages(page, folio_nr_pages(folio));

Could end up writing outside of the actual folio if we work with a
tail page.

Let's revert it. Once there is agreement that this is the right approach,
the issues were fixed and there was reasonable review and proper
testing, we can consider it again.

[1] https://lkml.kernel.org/r/4da9da2f-73e4-45fd-b62f-a8a513314057@redhat.com

Fixes: ba42b524a040 ("mm: init_mlocked_on_free_v3")
Reported-by: David Wang <00107082@163.com>
Closes: https://lore.kernel.org/lkml/20240528151340.4282-1-00107082@163.com/
Reported-by: Lance Yang <ioworker0@gmail.com>
Closes: https://lkml.kernel.org/r/20240601140917.43562-1-ioworker0@gmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: York Jasper Niebuhr <yjnworkstation@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 ---
 include/linux/mm.h                            |  9 +---
 mm/internal.h                                 |  1 -
 mm/memory.c                                   |  6 ---
 mm/mm_init.c                                  | 43 +++----------------
 mm/page_alloc.c                               |  2 +-
 security/Kconfig.hardening                    | 15 -------
 7 files changed, 9 insertions(+), 73 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b600df82669db..11e57ba2985cc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2192,12 +2192,6 @@
 			Format: 0 | 1
 			Default set by CONFIG_INIT_ON_FREE_DEFAULT_ON.
 
-	init_mlocked_on_free=	[MM] Fill freed userspace memory with zeroes if
-				it was mlock'ed and not explicitly munlock'ed
-				afterwards.
-				Format: 0 | 1
-				Default set by CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON
-
 	init_pkru=	[X86] Specify the default memory protection keys rights
 			register contents for all processes.  0x55555554 by
 			default (disallow access to all but pkey 0).  Can
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9849dfda44d43..9a5652c5fadd5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3776,14 +3776,7 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 static inline bool want_init_on_free(void)
 {
 	return static_branch_maybe(CONFIG_INIT_ON_FREE_DEFAULT_ON,
-				&init_on_free);
-}
-
-DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON, init_mlocked_on_free);
-static inline bool want_init_mlocked_on_free(void)
-{
-	return static_branch_maybe(CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON,
-				&init_mlocked_on_free);
+				   &init_on_free);
 }
 
 extern bool _debug_pagealloc_enabled_early;
diff --git a/mm/internal.h b/mm/internal.h
index b2c75b12014e7..c72c306761a48 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -588,7 +588,6 @@ extern void __putback_isolated_page(struct page *page, unsigned int order,
 extern void memblock_free_pages(struct page *page, unsigned long pfn,
 					unsigned int order);
 extern void __free_pages_core(struct page *page, unsigned int order);
-extern void kernel_init_pages(struct page *page, int numpages);
 
 /*
  * This will have no effect, other than possibly generating a warning, if the
diff --git a/mm/memory.c b/mm/memory.c
index 0f47a533014e4..2bc8032a30a2f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1507,12 +1507,6 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
 		if (unlikely(folio_mapcount(folio) < 0))
 			print_bad_pte(vma, addr, ptent, page);
 	}
-
-	if (want_init_mlocked_on_free() && folio_test_mlocked(folio) &&
-	    !delay_rmap && folio_test_anon(folio)) {
-		kernel_init_pages(page, folio_nr_pages(folio));
-	}
-
 	if (unlikely(__tlb_remove_folio_pages(tlb, page, nr, delay_rmap))) {
 		*force_flush = true;
 		*force_break = true;
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f72b852bd5b8e..3ec04933f7fd8 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2523,9 +2523,6 @@ EXPORT_SYMBOL(init_on_alloc);
 DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 EXPORT_SYMBOL(init_on_free);
 
-DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON, init_mlocked_on_free);
-EXPORT_SYMBOL(init_mlocked_on_free);
-
 static bool _init_on_alloc_enabled_early __read_mostly
 				= IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON);
 static int __init early_init_on_alloc(char *buf)
@@ -2543,14 +2540,6 @@ static int __init early_init_on_free(char *buf)
 }
 early_param("init_on_free", early_init_on_free);
 
-static bool _init_mlocked_on_free_enabled_early __read_mostly
-				= IS_ENABLED(CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON);
-static int __init early_init_mlocked_on_free(char *buf)
-{
-	return kstrtobool(buf, &_init_mlocked_on_free_enabled_early);
-}
-early_param("init_mlocked_on_free", early_init_mlocked_on_free);
-
 DEFINE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
 
 /*
@@ -2578,21 +2567,12 @@ static void __init mem_debugging_and_hardening_init(void)
 	}
 #endif
 
-	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early ||
-	    _init_mlocked_on_free_enabled_early) &&
+	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early) &&
 	    page_poisoning_requested) {
 		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
-			"will take precedence over init_on_alloc, init_on_free "
-			"and init_mlocked_on_free\n");
+			"will take precedence over init_on_alloc and init_on_free\n");
 		_init_on_alloc_enabled_early = false;
 		_init_on_free_enabled_early = false;
-		_init_mlocked_on_free_enabled_early = false;
-	}
-
-	if (_init_mlocked_on_free_enabled_early && _init_on_free_enabled_early) {
-		pr_info("mem auto-init: init_on_free is on, "
-			"will take precedence over init_mlocked_on_free\n");
-		_init_mlocked_on_free_enabled_early = false;
 	}
 
 	if (_init_on_alloc_enabled_early) {
@@ -2609,17 +2589,9 @@ static void __init mem_debugging_and_hardening_init(void)
 		static_branch_disable(&init_on_free);
 	}
 
-	if (_init_mlocked_on_free_enabled_early) {
-		want_check_pages = true;
-		static_branch_enable(&init_mlocked_on_free);
-	} else {
-		static_branch_disable(&init_mlocked_on_free);
-	}
-
-	if (IS_ENABLED(CONFIG_KMSAN) && (_init_on_alloc_enabled_early ||
-	    _init_on_free_enabled_early || _init_mlocked_on_free_enabled_early))
-		pr_info("mem auto-init: please make sure init_on_alloc, init_on_free and "
-			"init_mlocked_on_free are disabled when running KMSAN\n");
+	if (IS_ENABLED(CONFIG_KMSAN) &&
+	    (_init_on_alloc_enabled_early || _init_on_free_enabled_early))
+		pr_info("mem auto-init: please make sure init_on_alloc and init_on_free are disabled when running KMSAN\n");
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	if (debug_pagealloc_enabled()) {
@@ -2658,10 +2630,9 @@ static void __init report_meminit(void)
 	else
 		stack = "off";
 
-	pr_info("mem auto-init: stack:%s, heap alloc:%s, heap free:%s, mlocked free:%s\n",
+	pr_info("mem auto-init: stack:%s, heap alloc:%s, heap free:%s\n",
 		stack, want_init_on_alloc(GFP_KERNEL) ? "on" : "off",
-		want_init_on_free() ? "on" : "off",
-		want_init_mlocked_on_free() ? "on" : "off");
+		want_init_on_free() ? "on" : "off");
 	if (want_init_on_free())
 		pr_info("mem auto-init: clearing system memory may take some time...\n");
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2e22ce5675ca1..a264eac20d1de 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1016,7 +1016,7 @@ static inline bool should_skip_kasan_poison(struct page *page)
 	return page_kasan_tag(page) == KASAN_TAG_KERNEL;
 }
 
-void kernel_init_pages(struct page *page, int numpages)
+static void kernel_init_pages(struct page *page, int numpages)
 {
 	int i;
 
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index effbf5982be10..2cff851ebfd7e 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -255,21 +255,6 @@ config INIT_ON_FREE_DEFAULT_ON
 	  touching "cold" memory areas. Most cases see 3-5% impact. Some
 	  synthetic workloads have measured as high as 8%.
 
-config INIT_MLOCKED_ON_FREE_DEFAULT_ON
-	bool "Enable mlocked memory zeroing on free"
-	depends on !KMSAN
-	help
-	  This config has the effect of setting "init_mlocked_on_free=1"
-	  on the kernel command line. If it is enabled, all mlocked process
-	  memory is zeroed when freed. This restriction to mlocked memory
-	  improves performance over "init_on_free" but can still be used to
-	  protect confidential data like key material from content exposures
-	  to other processes, as well as live forensics and cold boot attacks.
-	  Any non-mlocked memory is not cleared before it is reassigned. This
-	  configuration can be overwritten by setting "init_mlocked_on_free=0"
-	  on the command line. The "init_on_free" boot option takes
-	  precedence over "init_mlocked_on_free".
-
 config CC_HAS_ZERO_CALL_USED_REGS
 	def_bool $(cc-option,-fzero-call-used-regs=used-gpr)
 	# https://github.com/ClangBuiltLinux/linux/issues/1766

base-commit: 32f88d65f01bf6f45476d7edbe675e44fb9e1d58
-- 
2.45.1


