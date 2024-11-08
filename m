Return-Path: <linux-kernel+bounces-401145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7189C1676
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C04F1F217DE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BCC1C3F00;
	Fri,  8 Nov 2024 06:26:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DDD1D52B;
	Fri,  8 Nov 2024 06:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731047176; cv=none; b=Ein9uC07LLMffYn3Y3eSGhzaojRRlm7itNavosfqNBo+7ekE0bPOhNIEEqsVsV51sg58C92qLlGYLRC5yC0bDu2sOMOhJdwM9u5QahRUSJR3rZllWofUqARMaTXyGhFhuYPB9D+LtjWbvZ1Bq5yHu4GHkvzEMeUU3KL0lPMFmUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731047176; c=relaxed/simple;
	bh=fQK8xTVejBDpIgskcOjO/rL9vdDxvIKWkhvWe05pTwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ocBdz+UCNQ/DoXgthNZKXyVfBp/4JHme7FO+1+SB7VBwiXva5sw+Vy9tfGUzT4lQoq+xp+F21l/rjhTn5ppm7DPDeNZOkJPDGw5fNNnrwOvumV38He+YBO43zOElPXksWA6mcKlXKEkswRG0HZlWQsu4TNVfJD9y8GPYQS4/fxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930B9C4CECE;
	Fri,  8 Nov 2024 06:26:13 +0000 (UTC)
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
Subject: [PATCH V2] LoongArch: Disable KASAN if PGDIR_SIZE is too large for cpu_vabits
Date: Fri,  8 Nov 2024 14:25:56 +0800
Message-ID: <20241108062556.4138380-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If PGDIR_SIZE is too large for cpu_vabits, KASAN_SHADOW_END will
overflow UINTPTR_MAX because KASAN_SHADOW_START/KASAN_SHADOW_END are
aligned up by PGDIR_SIZE. And then the overflowed KASAN_SHADOW_END looks
like a user space address.

For example, PGDIR_SIZE of CONFIG_4KB_4LEVEL is 2^39, which is too large
for Loongson-2K series whose cpu_vabits = 39.

Since CONFIG_4KB_4LEVEL is completely legal for CPUs with cpu_vabits <=
39, we just disable KASAN via early return in kasan_init(). Otherwise we
get a boot failure.

Moreover, we change KASAN_SHADOW_END from the first address after KASAN
shadow area to the last address in KASAN shadow area, in order to avoid
the end address exactly overflow to 0 (which is a legal case). We don't
need to worry about alignment because pgd_addr_end() can handle it.

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Change KASAN_SHADOW_END definition.

 arch/loongarch/include/asm/kasan.h |  2 +-
 arch/loongarch/mm/kasan_init.c     | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/include/asm/kasan.h b/arch/loongarch/include/asm/kasan.h
index c6bce5fbff57..cb74a47f620e 100644
--- a/arch/loongarch/include/asm/kasan.h
+++ b/arch/loongarch/include/asm/kasan.h
@@ -51,7 +51,7 @@
 /* KAsan shadow memory start right after vmalloc. */
 #define KASAN_SHADOW_START		round_up(KFENCE_AREA_END, PGDIR_SIZE)
 #define KASAN_SHADOW_SIZE		(XKVRANGE_VC_SHADOW_END - XKPRANGE_CC_KASAN_OFFSET)
-#define KASAN_SHADOW_END		round_up(KASAN_SHADOW_START + KASAN_SHADOW_SIZE, PGDIR_SIZE)
+#define KASAN_SHADOW_END		(round_up(KASAN_SHADOW_START + KASAN_SHADOW_SIZE, PGDIR_SIZE) - 1)
 
 #define XKPRANGE_CC_SHADOW_OFFSET	(KASAN_SHADOW_START + XKPRANGE_CC_KASAN_OFFSET)
 #define XKPRANGE_UC_SHADOW_OFFSET	(KASAN_SHADOW_START + XKPRANGE_UC_KASAN_OFFSET)
diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_init.c
index 4a0d1880dd71..7277b7583e1b 100644
--- a/arch/loongarch/mm/kasan_init.c
+++ b/arch/loongarch/mm/kasan_init.c
@@ -238,7 +238,7 @@ static void __init kasan_map_populate(unsigned long start, unsigned long end,
 asmlinkage void __init kasan_early_init(void)
 {
 	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_START, PGDIR_SIZE));
-	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_END, PGDIR_SIZE));
+	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_END + 1, PGDIR_SIZE));
 }
 
 static inline void kasan_set_pgd(pgd_t *pgdp, pgd_t pgdval)
@@ -253,7 +253,7 @@ static void __init clear_pgds(unsigned long start, unsigned long end)
 	 * swapper_pg_dir. pgd_clear() can't be used
 	 * here because it's nop on 2,3-level pagetable setups
 	 */
-	for (; start < end; start += PGDIR_SIZE)
+	for (; start < end; start = pgd_addr_end(start, end))
 		kasan_set_pgd((pgd_t *)pgd_offset_k(start), __pgd(0));
 }
 
@@ -262,6 +262,17 @@ void __init kasan_init(void)
 	u64 i;
 	phys_addr_t pa_start, pa_end;
 
+	/*
+	 * If PGDIR_SIZE is too large for cpu_vabits, KASAN_SHADOW_END will
+	 * overflow UINTPTR_MAX and then looks like a user space address.
+	 * For example, PGDIR_SIZE of CONFIG_4KB_4LEVEL is 2^39, which is too
+	 * large for Loongson-2K series whose cpu_vabits = 39.
+	 */
+	if (KASAN_SHADOW_END < vm_map_base) {
+		pr_warn("PGDIR_SIZE too large for cpu_vabits, KernelAddressSanitizer disabled.\n");
+		return;
+	}
+
 	/*
 	 * PGD was populated as invalid_pmd_table or invalid_pud_table
 	 * in pagetable_init() which depends on how many levels of page
-- 
2.43.5


