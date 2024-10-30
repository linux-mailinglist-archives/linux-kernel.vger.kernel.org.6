Return-Path: <linux-kernel+bounces-388301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC2E9B5D64
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341EC28421E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479391E04BC;
	Wed, 30 Oct 2024 08:11:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBADD1990B3;
	Wed, 30 Oct 2024 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730275866; cv=none; b=C5xoe5n2YIU3q0rItmXV/GdYBrZ4Bg0TSv8JgqC4NjdonxYeeyX02VDpwnGa461z1vPfNBRwfA/+CcwdkKZ3nnnVguABHNPC9f/qJ/VpqxRN/xF6EmffVj/G81sgdVoMV5PPoiHomciDfwjRYCONmPIPiZ6aOdeurtyk+vnZq68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730275866; c=relaxed/simple;
	bh=k2/xQ67GrtCbvQxI0S1wkSv7WoJXBjZi9MlpNv07Ex8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MJtm8j0lPmeQbw8ItG5wmUWj8R8aCfGXy5OkKzcJZYYcdU8If4vGFQ7l4OzcpV8kSvFMh2otyUj6kIs6DdZe0nQ7WHJ36107OlwBNtjm/pLomPqTwFku+lCGdVYeXCnsgTJOOJGPVoRMgjjf4mJUS7MFW9S7GrugiXfqhIqamRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAE1C4CEE4;
	Wed, 30 Oct 2024 08:11:03 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Make KASAN work with 5-level page-tables
Date: Wed, 30 Oct 2024 16:10:43 +0800
Message-ID: <20241030081043.3430381-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make KASAN work with 5-level page-tables, including:
1. Implement and use __pgd_none() and kasan_p4d_offset().
2. As done in kasan_pmd_populate() and kasan_pte_populate(), restrict
   the loop conditions of kasan_p4d_populate() and kasan_pud_populate()
   to avoid unnecessary population.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/mm/kasan_init.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_init.c
index 427d6b1aec09..4a0d1880dd71 100644
--- a/arch/loongarch/mm/kasan_init.c
+++ b/arch/loongarch/mm/kasan_init.c
@@ -13,6 +13,13 @@
 
 static pgd_t kasan_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 
+#ifdef __PAGETABLE_P4D_FOLDED
+#define __pgd_none(early, pgd) (0)
+#else
+#define __pgd_none(early, pgd) (early ? (pgd_val(pgd) == 0) : \
+(__pa(pgd_val(pgd)) == (unsigned long)__pa(kasan_early_shadow_p4d)))
+#endif
+
 #ifdef __PAGETABLE_PUD_FOLDED
 #define __p4d_none(early, p4d) (0)
 #else
@@ -142,6 +149,19 @@ static pud_t *__init kasan_pud_offset(p4d_t *p4dp, unsigned long addr, int node,
 	return pud_offset(p4dp, addr);
 }
 
+static p4d_t *__init kasan_p4d_offset(pgd_t *pgdp, unsigned long addr, int node, bool early)
+{
+	if (__pgd_none(early, pgdp_get(pgdp))) {
+		phys_addr_t p4d_phys = early ?
+			__pa_symbol(kasan_early_shadow_p4d) : kasan_alloc_zeroed_page(node);
+		if (!early)
+			memcpy(__va(p4d_phys), kasan_early_shadow_p4d, sizeof(kasan_early_shadow_p4d));
+		pgd_populate(&init_mm, pgdp, (p4d_t *)__va(p4d_phys));
+	}
+
+	return p4d_offset(pgdp, addr);
+}
+
 static void __init kasan_pte_populate(pmd_t *pmdp, unsigned long addr,
 				      unsigned long end, int node, bool early)
 {
@@ -178,19 +198,19 @@ static void __init kasan_pud_populate(p4d_t *p4dp, unsigned long addr,
 	do {
 		next = pud_addr_end(addr, end);
 		kasan_pmd_populate(pudp, addr, next, node, early);
-	} while (pudp++, addr = next, addr != end);
+	} while (pudp++, addr = next, addr != end && __pud_none(early, READ_ONCE(*pudp)));
 }
 
 static void __init kasan_p4d_populate(pgd_t *pgdp, unsigned long addr,
 					    unsigned long end, int node, bool early)
 {
 	unsigned long next;
-	p4d_t *p4dp = p4d_offset(pgdp, addr);
+	p4d_t *p4dp = kasan_p4d_offset(pgdp, addr, node, early);
 
 	do {
 		next = p4d_addr_end(addr, end);
 		kasan_pud_populate(p4dp, addr, next, node, early);
-	} while (p4dp++, addr = next, addr != end);
+	} while (p4dp++, addr = next, addr != end && __p4d_none(early, READ_ONCE(*p4dp)));
 }
 
 static void __init kasan_pgd_populate(unsigned long addr, unsigned long end,
-- 
2.43.5


